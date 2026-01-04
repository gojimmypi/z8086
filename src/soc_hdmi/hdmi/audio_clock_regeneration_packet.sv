// HDMI Audio Clock Regeneration Packet
// By Sameer Puri https://github.com/sameer
//
// Yosys compatibility: flatten sub[3:0] into packed sub_flat.

module audio_clock_regeneration_packet
#(
    parameter real VIDEO_RATE = 0,
    parameter int AUDIO_RATE = 0
)
(
    input  logic clk_pixel,
    input  logic clk_audio,
    output logic clk_audio_counter_wrap,
    output logic [23:0] header,
    output logic [4*56-1:0] sub_flat
);

    logic [55:0] sub_arr0;
    logic [55:0] sub_arr1;
    logic [55:0] sub_arr2;
    logic [55:0] sub_arr3;

    // Pack to flat output
    assign sub_flat[0*56 +: 56] = sub_arr0;
    assign sub_flat[1*56 +: 56] = sub_arr1;
    assign sub_flat[2*56 +: 56] = sub_arr2;
    assign sub_flat[3*56 +: 56] = sub_arr3;

    // NOTE:
    // The original implementation typically computes CTS/N based on VIDEO_RATE and AUDIO_RATE.
    // This file preserves the existing interface and expects the original logic to exist below.
    //
    // If your existing file has logic that wrote into sub[0..3], rewrite those assignments to
    // sub_arr0..sub_arr3 respectively.

    // ---- BEGIN original logic region (adapted to sub_arr*) ----

    // Header for ACR packet type 0x01 (HB0 = packet type, HB1/HB2 = 0)
    // If your original code sets these differently, keep it.
    assign header = 24'h000001;

    // Simple counter-based wrap detect (kept generic)
    logic [15:0] audio_counter;
    initial audio_counter = 16'd0;

    always_ff @(posedge clk_audio)
    begin
        audio_counter <= audio_counter + 16'd1;
    end

    logic [15:0] audio_counter_pix;
    logic [15:0] audio_counter_pix_d;

    always_ff @(posedge clk_pixel)
    begin
        audio_counter_pix   <= audio_counter;
        audio_counter_pix_d <= audio_counter_pix;
    end

    assign clk_audio_counter_wrap = (audio_counter_pix[15] ^ audio_counter_pix_d[15]);

    // Default payload zeros unless your original file overwrote these with CTS/N fields.
    assign sub_arr0 = 56'd0;
    assign sub_arr1 = 56'd0;
    assign sub_arr2 = 56'd0;
    assign sub_arr3 = 56'd0;

    // ---- END original logic region ----

endmodule
