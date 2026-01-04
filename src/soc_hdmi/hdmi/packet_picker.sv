// Implementation of HDMI packet choice logic.
// By Sameer Puri https://github.com/sameer
//
// Yosys compatibility: no unpacked-array ports anywhere in this module.

module packet_picker
#(
    parameter int VIDEO_ID_CODE = 4,
    parameter real VIDEO_RATE = 0,
    parameter bit IT_CONTENT = 1'b0,
    parameter int AUDIO_BIT_WIDTH = 0,
    parameter int AUDIO_RATE = 0,
    parameter bit [8*8-1:0] VENDOR_NAME = 0,
    parameter bit [8*16-1:0] PRODUCT_DESCRIPTION = 0,
    parameter bit [7:0] SOURCE_DEVICE_INFORMATION = 0
)
(
    input  logic clk_pixel,
    input  logic clk_audio,
    input  logic reset,
    input  logic video_field_end,
    input  logic packet_enable,
    input  logic [4:0] packet_pixel_counter,

    input  logic [2*AUDIO_BIT_WIDTH-1:0] audio_sample_word,

    output logic [23:0] header,
    output logic [4*56-1:0] sub
);

    // Unpack audio input words
    logic [AUDIO_BIT_WIDTH-1:0] audio_in0;
    logic [AUDIO_BIT_WIDTH-1:0] audio_in1;
    assign audio_in0 = audio_sample_word[AUDIO_BIT_WIDTH-1:0];
    assign audio_in1 = audio_sample_word[2*AUDIO_BIT_WIDTH-1:AUDIO_BIT_WIDTH];

    // Packet type state
    logic [7:0] packet_type;
    initial packet_type = 8'd0;

    // NULL packet payload (zeros)
    logic [23:0] header_null;
    logic [4*56-1:0] sub_null;
    assign header_null = 24'd0;
    assign sub_null = {4{56'd0}};

    // ACR packet
    logic clk_audio_counter_wrap;
    logic [23:0] header_acr;
    logic [4*56-1:0] sub_acr;

    audio_clock_regeneration_packet #(
        .VIDEO_RATE(VIDEO_RATE),
        .AUDIO_RATE(AUDIO_RATE)
    ) u_acr (
        .clk_pixel(clk_pixel),
        .clk_audio(clk_audio),
        .clk_audio_counter_wrap(clk_audio_counter_wrap),
        .header(header_acr),
        .sub_flat(sub_acr)
    );

    // Audio Sample packet config (no casts)
    localparam bit [3:0] SAMPLING_FREQUENCY =
        (AUDIO_RATE == 32000)  ? 4'b0011 :
        (AUDIO_RATE == 44100)  ? 4'b0000 :
        (AUDIO_RATE == 88200)  ? 4'b1000 :
        (AUDIO_RATE == 176400) ? 4'b1100 :
        (AUDIO_RATE == 48000)  ? 4'b0010 :
        (AUDIO_RATE == 96000)  ? 4'b1010 :
        (AUDIO_RATE == 192000) ? 4'b1110 :
                                 4'b0000;

    localparam int AUDIO_BIT_WIDTH_COMPARATOR =
        (AUDIO_BIT_WIDTH < 20)  ? 20 :
        (AUDIO_BIT_WIDTH == 20) ? 25 :
        (AUDIO_BIT_WIDTH < 24)  ? 24 :
        (AUDIO_BIT_WIDTH == 24) ? 29 :
                                  20;

    localparam logic [2:0] WORD_LENGTH_3 = (AUDIO_BIT_WIDTH_COMPARATOR - AUDIO_BIT_WIDTH);
    localparam bit WORD_LENGTH_LIMIT = (AUDIO_BIT_WIDTH <= 20) ? 1'b0 : 1'b1;
    localparam logic [3:0] WORD_LENGTH_4 = {WORD_LENGTH_3, WORD_LENGTH_LIMIT};

    // CDC / buffering (same intent as original)
    logic clk_audio_old;
    initial clk_audio_old = 1'b0;

    logic [AUDIO_BIT_WIDTH-1:0] audio_transfer0;
    logic [AUDIO_BIT_WIDTH-1:0] audio_transfer1;
    logic audio_transfer_toggle;
    initial audio_transfer_toggle = 1'b0;

    always_ff @(posedge clk_pixel)
    begin
        clk_audio_old <= clk_audio;
        if (clk_audio & ~clk_audio_old)
        begin
            audio_transfer0 <= audio_in0;
            audio_transfer1 <= audio_in1;
            audio_transfer_toggle <= ~audio_transfer_toggle;
        end
    end

    logic [1:0] audio_transfer_sync;
    initial audio_transfer_sync = 2'd0;

    always_ff @(posedge clk_pixel)
        audio_transfer_sync <= {audio_transfer_toggle, audio_transfer_sync[1]};

    logic sample_buffer_current;
    initial sample_buffer_current = 1'b0;

    logic [1:0] samples_remaining;
    initial samples_remaining = 2'd0;

    logic [23:0] audio_sample_word_buffer [1:0] [3:0] [1:0];

    logic sample_buffer_used;
    logic sample_buffer_ready;
    initial sample_buffer_used = 1'b0;
    initial sample_buffer_ready = 1'b0;

    logic [AUDIO_BIT_WIDTH-1:0] audio_mux0;
    logic [AUDIO_BIT_WIDTH-1:0] audio_mux1;

    always_comb
    begin
        if (audio_transfer_sync[0] ^ audio_transfer_sync[1])
        begin
            audio_mux0 = audio_transfer0;
            audio_mux1 = audio_transfer1;
        end
        else
        begin
            audio_mux0 = audio_sample_word_buffer[sample_buffer_current][samples_remaining][0][23:(24-AUDIO_BIT_WIDTH)];
            audio_mux1 = audio_sample_word_buffer[sample_buffer_current][samples_remaining][1][23:(24-AUDIO_BIT_WIDTH)];
        end
    end

    always_ff @(posedge clk_pixel)
    begin
        if (sample_buffer_used)
            sample_buffer_ready <= 1'b0;

        if (audio_transfer_sync[0] ^ audio_transfer_sync[1])
        begin
            audio_sample_word_buffer[sample_buffer_current][samples_remaining][0] <= {audio_mux0, {(24-AUDIO_BIT_WIDTH){1'b0}}};
            audio_sample_word_buffer[sample_buffer_current][samples_remaining][1] <= {audio_mux1, {(24-AUDIO_BIT_WIDTH){1'b0}}};

            if (samples_remaining == 2'd3)
            begin
                samples_remaining <= 2'd0;
                sample_buffer_ready <= 1'b1;
                sample_buffer_current <= ~sample_buffer_current;
            end
            else
                samples_remaining <= samples_remaining + 2'd1;
        end
    end

    // Frame counter
    logic [7:0] frame_counter;
    initial frame_counter = 8'd0;

    always_ff @(posedge clk_pixel)
    begin
        if (reset)
            frame_counter <= 8'd0;
        else if ((packet_pixel_counter == 5'd31) && (packet_type == 8'h02))
        begin
            frame_counter <= frame_counter + 8'd4;
            if (frame_counter >= 8'd192)
                frame_counter <= frame_counter - 8'd192;
        end
    end

    // Packed inputs to audio_sample_packet
    logic [7:0] valid_bit_flat;
    logic [7:0] user_data_bit_flat;
    logic [192-1:0] audio_sample_word_flat;
    logic [3:0] audio_sample_word_present_packet;

    initial valid_bit_flat = 8'd0;
    initial user_data_bit_flat = 8'd0;
    initial audio_sample_word_flat = {192{1'b0}};
    initial audio_sample_word_present_packet = 4'd0;

    task automatic load_audio_words_from_buffer;
        input logic which_buf;
        begin
            audio_sample_word_flat[24*0 +: 24] <= audio_sample_word_buffer[which_buf][0][0];
            audio_sample_word_flat[24*1 +: 24] <= audio_sample_word_buffer[which_buf][0][1];
            audio_sample_word_flat[24*2 +: 24] <= audio_sample_word_buffer[which_buf][1][0];
            audio_sample_word_flat[24*3 +: 24] <= audio_sample_word_buffer[which_buf][1][1];
            audio_sample_word_flat[24*4 +: 24] <= audio_sample_word_buffer[which_buf][2][0];
            audio_sample_word_flat[24*5 +: 24] <= audio_sample_word_buffer[which_buf][2][1];
            audio_sample_word_flat[24*6 +: 24] <= audio_sample_word_buffer[which_buf][3][0];
            audio_sample_word_flat[24*7 +: 24] <= audio_sample_word_buffer[which_buf][3][1];
        end
    endtask

    logic [23:0] header_audio_sample;
    logic [4*56-1:0] sub_audio_sample;

    audio_sample_packet #(
        .SAMPLING_FREQUENCY(SAMPLING_FREQUENCY),
        .WORD_LENGTH(WORD_LENGTH_4)
    ) u_asp (
        .frame_counter(frame_counter),
        .valid_bit_flat(valid_bit_flat),
        .user_data_bit_flat(user_data_bit_flat),
        .audio_sample_word_flat(audio_sample_word_flat),
        .audio_sample_word_present(audio_sample_word_present_packet),
        .header(header_audio_sample),
        .sub_flat(sub_audio_sample)
    );

    // AVI / SPD / Audio Info
    logic [23:0] header_avi;
    logic [4*56-1:0] sub_avi;

    auxiliary_video_information_info_frame #(
        .VIDEO_ID_CODE(VIDEO_ID_CODE[6:0]),
        .IT_CONTENT(IT_CONTENT)
    ) u_avi (
        .header(header_avi),
        .sub_flat(sub_avi)
    );

    logic [23:0] header_spd;
    logic [4*56-1:0] sub_spd;

    source_product_description_info_frame #(
        .VENDOR_NAME(VENDOR_NAME),
        .PRODUCT_DESCRIPTION(PRODUCT_DESCRIPTION),
        .SOURCE_DEVICE_INFORMATION(SOURCE_DEVICE_INFORMATION)
    ) u_spd (
        .header(header_spd),
        .sub_flat(sub_spd)
    );

    logic [23:0] header_audio_info;
    logic [4*56-1:0] sub_audio_info;

    audio_info_frame u_aif (
        .header(header_audio_info),
        .sub_flat(sub_audio_info)
    );

    // Packet scheduling flags
    logic audio_info_frame_sent;
    logic auxiliary_video_information_info_frame_sent;
    logic source_product_description_info_frame_sent;
    logic last_clk_audio_counter_wrap;

    initial audio_info_frame_sent = 1'b0;
    initial auxiliary_video_information_info_frame_sent = 1'b0;
    initial source_product_description_info_frame_sent = 1'b0;
    initial last_clk_audio_counter_wrap = 1'b0;

    always_ff @(posedge clk_pixel)
    begin
        if (sample_buffer_used)
            sample_buffer_used <= 1'b0;

        if (reset || video_field_end)
        begin
            audio_info_frame_sent <= 1'b0;
            auxiliary_video_information_info_frame_sent <= 1'b0;
            source_product_description_info_frame_sent <= 1'b0;
            packet_type <= 8'd0;
            last_clk_audio_counter_wrap <= 1'b0;
        end
        else if (packet_enable)
        begin
            if (last_clk_audio_counter_wrap ^ clk_audio_counter_wrap)
            begin
                packet_type <= 8'd1;
                last_clk_audio_counter_wrap <= clk_audio_counter_wrap;
            end
            else if (sample_buffer_ready)
            begin
                packet_type <= 8'd2;
                load_audio_words_from_buffer(~sample_buffer_current);
                audio_sample_word_present_packet <= 4'b1111;
                sample_buffer_used <= 1'b1;
            end
            else if (!audio_info_frame_sent)
            begin
                packet_type <= 8'h84;
                audio_info_frame_sent <= 1'b1;
            end
            else if (!auxiliary_video_information_info_frame_sent)
            begin
                packet_type <= 8'h82;
                auxiliary_video_information_info_frame_sent <= 1'b1;
            end
            else if (!source_product_description_info_frame_sent)
            begin
                packet_type <= 8'h83;
                source_product_description_info_frame_sent <= 1'b1;
            end
            else
                packet_type <= 8'd0;
        end
    end

    // Output mux
    always_comb
    begin
        header = header_null;
        sub = sub_null;

        if (packet_type == 8'd1)
        begin
            header = header_acr;
            sub = sub_acr;
        end
        else if (packet_type == 8'd2)
        begin
            header = header_audio_sample;
            sub = sub_audio_sample;
        end
        else if (packet_type == 8'h82)
        begin
            header = header_avi;
            sub = sub_avi;
        end
        else if (packet_type == 8'h83)
        begin
            header = header_spd;
            sub = sub_spd;
        end
        else if (packet_type == 8'h84)
        begin
            header = header_audio_info;
            sub = sub_audio_info;
        end
    end

endmodule
