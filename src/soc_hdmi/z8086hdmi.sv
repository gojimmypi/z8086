// Text mode video buffer to HDMI converter

module z8086hdmi (
	input clk,         // 50mhz clock
    input clk_pixel,   // 720p pixel clock
    input clk_5x_pixel,

    // video memory access, 80x30 text mode, 16-bit per character
    // lower byte: character code, upper byte: attributes, like VGA
    // so 2400 words (4800 bytes) in total
    input [11:0] addr,      // word address (2400 positions)
    input [15:0] din,       // 16-bit word input
    input        rd,
    input        wr,
    output [15:0] dout,     // 16-bit word output
    output       ready,

    // Settings register interface (clk domain)
    input  [2:0] io_addr,   // Address: 0=cursor_col, 1=cursor_row, 2=cursor_start, 3=cursor_end, 4=blink_enable
    input        io_rd,
    input        io_wr,
    input [15:0] io_din,
    output [15:0] io_dout,

	// hdmi output signals
	output       tmds_clk_n,
	output       tmds_clk_p,
	output [2:0] tmds_d_n,
	output [2:0] tmds_d_p
);

// Text mode: 80x30 characters, 12x24 pixels per character (6x12 font scaled 2x)
// Visible area: 960x720 pixels, fills entire 720p height (1280x720)
parameter CHAR_WIDTH = 12;
parameter CHAR_HEIGHT = 24;
parameter TEXT_COLS = 80;
parameter TEXT_ROWS = 30;
parameter OFFSET_X = (1280 - TEXT_COLS * CHAR_WIDTH) / 2;  // 160
parameter OFFSET_Y = (720 - TEXT_ROWS * CHAR_HEIGHT) / 2;   // 0

wire clk_audio = 0;     // no audio needed

// HDMI output
wire [2:0] tmds;
wire [10:0] cx, cy;  // Current pixel coordinates from HDMI module

// ========== Dual-port Video RAM ==========
// Port A: CPU access (50MHz domain)
// Port B: Video rendering (pixel clock domain)
// 80x30 text mode = 2400 chars × 16 bits = 4800 bytes (12-bit word addressing)
wire [15:0] vram_q_a;
wire [15:0] vram_q_b;
reg [11:0] vram_addr_b;

//dpram_difclk #(.ADRW(12), .DATW(16), .FILE("screen.hex")) u_vram (
//    .clk_a(clk),
//    .address_a(addr),
//    .data_a(din),
//    .q_a(vram_q_a),
//    .wren_a(wr),

//    .clk_b(clk_pixel),
//    .address_b(vram_addr_b),
//    .q_b(vram_q_b),
//    .wren_b(1'b0)
//);

`ifdef ULX3S
    vram_ecp5 #(
        .DATA_W(16),
        .ADDR_W(12),
        .DEPTH(2400),
        .INIT_FILE("boards/ULX3S/screen.hex")   // or "" if you do not want init
    ) u_vram (
        .clka(clk),
        .addra(addr),
        .dina(din),
        .douta(vram_q_a),
        .wea(wr),

        .clkb(clk_pixel),
        .addrb(vram_addr_b),
        .doutb(vram_q_b)
    );
`else
 vram u_vram (
     .clka(clk),
     .ada(addr),
     .dina(din),
     .douta(vram_q_a),
     .ocea(1'b0),   // CE for registered output
     .cea(1'b1),
     .reseta(1'b0),
     .wrea(wr),

     .clkb(clk_pixel),
     .adb(vram_addr_b),
     .dinb(16'h0000),
     .doutb(vram_q_b),
     .oceb(1'b0),
     .ceb(1'b1),
     .resetb(1'b0),
     .wreb(1'b0)
 );
 `endif

assign dout = vram_q_a;
assign ready = 1'b1;  // Single-cycle access for dual-port RAM

// ========== Dual-port Settings Memory ==========
// Port A: CPU register access (50MHz domain)
// Port B: Sequential read at frame end (pixel clock domain)
// 5 words: 0=cursor_col, 1=cursor_row, 2=cursor_start, 3=cursor_end, 4=blink_enable
reg [15:0] settings_mem [0:4];
reg [15:0] settings_q_a;
reg [15:0] settings_q_b;
reg [2:0] settings_addr_b;

// Port A: CPU access (clk domain)
always @(posedge clk) begin
    if (io_wr) begin
        settings_mem[io_addr] <= io_din;
    end else begin
        settings_q_a <= settings_mem[io_addr];
    end
end

// Port B: Sequential read (clk_pixel domain)
always @(posedge clk_pixel) begin
    settings_q_b <= settings_mem[settings_addr_b];
end

assign io_dout = settings_q_a;

// ========== Font ROM ==========
// 256 characters × 12 rows × 8 bits (6 bits used per row)
// Font is 6x12, will be scaled 2x to 12x24
// Address: {char_code[7:0], row[3:0]}
reg [11:0] font_addr;
wire [7:0] font_data;

sprom #(
    .width(8),
    .widthad(12),
    .init_file("font6x12.hex")
) font_rom (
    .clk(clk_pixel),
    .address(font_addr),
    .q(font_data)
);

// ========== Color Palette (16 colors) ==========
reg [23:0] palette [0:15];
initial begin
    palette[0]  = 24'h000000;  // Black
    palette[1]  = 24'h0000AA;  // Blue
    palette[2]  = 24'h00AA00;  // Green
    palette[3]  = 24'h00AAAA;  // Cyan
    palette[4]  = 24'hAA0000;  // Red
    palette[5]  = 24'hAA00AA;  // Magenta
    palette[6]  = 24'hAA5500;  // Brown
    palette[7]  = 24'hAAAAAA;  // Light Gray
    palette[8]  = 24'h555555;  // Dark Gray
    palette[9]  = 24'h5555FF;  // Light Blue
    palette[10] = 24'h55FF55;  // Light Green
    palette[11] = 24'h55FFFF;  // Light Cyan
    palette[12] = 24'hFF5555;  // Light Red
    palette[13] = 24'hFF55FF;  // Light Magenta
    palette[14] = 24'hFFFF55;  // Yellow
    palette[15] = 24'hFFFFFF;  // White
end

// ========== Rendering Pipeline ==========
// Timing analysis (each character is 12 pixels wide):
// - HDMI outputs cx/cy at cycle N, expects rgb at cycle N+1
// - BRAM read latency: 1 cycle (address set at N, data valid at N+1)
// - Total pipeline: VRAM read (1 cycle) + Font ROM read (1 cycle) = 2 cycles minimum
//
// Strategy: Prefetch next character while displaying current one
// For character at pixel_x = 0..11:
//   pixel_x = 9:  Set VRAM address for NEXT character (3 cycles before pixel_x=0 of next char)
//   pixel_x = 10: VRAM data valid, set Font ROM address (2 cycles before pixel_x=0)
//   pixel_x = 11: Font data valid, load shift register (1 cycle before pixel_x=0)
//   pixel_x = 0:  Start outputting from shift register

reg [23:0] rgb;
reg [5:0] blink_div = 0;
reg blink_state = 1'b1;

// Settings registers (loaded from settings memory at frame end)
reg [6:0] cursor_col = 0;
reg [4:0] cursor_row = 0;
reg [4:0] cursor_start = 0;
reg [4:0] cursor_end = 0;
reg blink_enable = 1'b0;

// Sequential read state machine for settings
reg [2:0] settings_read_state = 0;

// Current pixel position (combinatorial from cx, cy)
// wire [6:0] char_x      = (cx - (OFFSET_X - CHAR_WIDTH)) / CHAR_WIDTH;   // 0-79
// wire [4:0] char_y      = (cy - OFFSET_Y) / CHAR_HEIGHT;  // 0-29
// wire [3:0] pixel_x     = (cx - (OFFSET_X - CHAR_WIDTH)) % CHAR_WIDTH;   // 0-11
// wire [4:0] pixel_y     = (cy - OFFSET_Y) % CHAR_HEIGHT;  // 0-23
// wire visible = (cx >= OFFSET_X) && (cx < OFFSET_X + TEXT_COLS * CHAR_WIDTH) &&
//                (cy >= OFFSET_Y) && (cy < OFFSET_Y + TEXT_ROWS * CHAR_HEIGHT);

localparam END_X = OFFSET_X + TEXT_COLS * CHAR_WIDTH;
localparam END_Y = OFFSET_Y + TEXT_ROWS * CHAR_HEIGHT;

// Timing signals
reg [6:0] char_x;     // x of NEXT character
reg [4:0] char_y;     // y of current character
reg [3:0] pixel_x;    // x within character 0-11
reg [4:0] pixel_y;    // y within character 0-23
reg       active;     // [OFFSET_X - CHAR_WIDTH, END_X - CHAR_WIDTH)
reg       visible;    // [OFFSET_X, END_X) & [OFFSET_Y, END_Y]
always @(posedge clk_pixel) begin
    case (cx)
    0: begin
        visible <= 0;
        char_x <= 0;
        char_y <= (cy - OFFSET_Y) / CHAR_HEIGHT;
        pixel_x <= 0;
        pixel_y <= (cy - OFFSET_Y) % CHAR_HEIGHT;
    end
    OFFSET_X - CHAR_WIDTH - 1: active <= 1;
    OFFSET_X - 1:              visible <= 1;
    END_X - 1: begin           visible <= 0; active <= 0; end
    default: begin
        if (active) begin
            pixel_x <= pixel_x == 11 ? 0 : (pixel_x + 1);
            char_x <= pixel_x == 11 ? char_x + 1 : char_x;
        end
    end
    endcase
end

// Rendering state
reg [5:0] font_shift;   // Shift register holding current character's font row (6 bits)
reg [7:0] curr_attr;    // Current character's attributes

// Registered cursor and blink signals (calculated at pixel_x=10, used during pixel output)
reg cursor_hit_r = 1'b0;
reg blink_suppress_r = 1'b0;

// Pixel output logic uses registered values
wire [3:0] fg_index = curr_attr[3:0];
wire [3:0] bg_index = blink_enable ? {1'b0, curr_attr[6:4]} : curr_attr[7:4];
wire pixel_on = cursor_hit_r ? 1'b1 : (font_shift[0] && !blink_suppress_r);

wire tmdsClk;

always @(posedge clk_pixel) begin
    // Sequential read of settings at frame end (cx == 1279, cy == 719)
    if (cx == 11'd1279 && cy == 11'd719) begin
        settings_read_state <= 3'd0;
        settings_addr_b <= 3'd0;
    end else if (settings_read_state < 3'd6) begin
        settings_read_state <= settings_read_state + 1'b1;

        case (settings_read_state)
        3'd0: settings_addr_b <= 3'd1;  // Read cursor_col (data will be valid next cycle)
        3'd1: begin
            cursor_col <= settings_q_b[6:0];
            settings_addr_b <= 3'd2;  // Read cursor_row
        end
        3'd2: begin
            cursor_row <= settings_q_b[4:0];
            settings_addr_b <= 3'd3;  // Read cursor_start
        end
        3'd3: begin
            cursor_start <= settings_q_b[4:0];
            settings_addr_b <= 3'd4;  // Read cursor_end
        end
        3'd4: begin
            cursor_end <= settings_q_b[4:0];
            settings_addr_b <= 3'd0;  // Read blink_enable
        end
        3'd5: begin
            blink_enable <= settings_q_b[0];
        end
        endcase
    end

    // Blink counter at frame start
    if (cx == 0 && cy == 0) begin
        if (blink_div == 6'd29) begin
            blink_div <= 0;
            blink_state <= ~blink_state;
        end else begin
            blink_div <= blink_div + 1'b1;
        end
    end

    // ===== Prefetch Pipeline =====
    // Start calc NEXT character address at pixel_x = 7
    if (pixel_x == 7) begin
        // Calculate next character position (wraparound at end of line)
        vram_addr_b <= char_y * TEXT_COLS + char_x;
    end

    // At pixel_x = 8: VRAM address is valid
    // At pixel_x = 9: VRAM data is valid
    // Set font ROM address and latch attributes
    if (pixel_x == 9) begin
        font_addr <= vram_q_b[7:0] * 12 + pixel_y[4:1];
        curr_attr <= vram_q_b[15:8];  // Latch attributes for upcoming character
    end

    // At pixel_x = 10: Font address is valid, calculate cursor_hit and blink_suppress
    // Register these signals to reduce combinational path during pixel output
    if (pixel_x == 10) begin
        cursor_hit_r <= (char_x == cursor_col) &&
                        (char_y == cursor_row) &&
                        (pixel_y >= cursor_start) &&
                        (pixel_y <= cursor_end) &&
                        blink_state;
        blink_suppress_r <= blink_enable && curr_attr[7] && !blink_state;
    end

    // At pixel_x = 11: Font data is valid
    // Load font row into shift register
    if (pixel_x == 11) begin
        font_shift <= font_data[5:0];  // Load 6-bit font row
    end else if (pixel_x[0]) begin
        // ===== Shift Operation =====
        font_shift <= font_shift[5:1];  // Shift right, fill with 0
    end

    // ===== RGB Output =====
    if (visible) begin
        // Extract pixel from MSB of font shift register
        if (pixel_on) begin
            rgb <= palette[fg_index];  // Foreground color
        end else begin
            rgb <= palette[bg_index];  // Background color
        end
    end else begin
        // Test pattern in border areas for HDMI debugging
        if (cx < OFFSET_X) begin
            rgb <= {2'b0, cy[7:2], 8'h00, 8'h00};  // Red gradient (left)
        end else if (cx >= OFFSET_X + TEXT_COLS * CHAR_WIDTH) begin
            rgb <= {8'h00, 8'h00, 2'b0, cy[7:2]};  // Blue gradient (right)
        end else if (cy < OFFSET_Y) begin
            rgb <= {8'h00, cx[7:0], 8'h00};  // Green gradient (top)
        end else begin
            rgb <= {8'h00, cx[7:0], cx[7:0]};  // Cyan gradient (bottom)
        end
    end
end

hdmi #( .VIDEO_ID_CODE(4),
        .DVI_OUTPUT(0),
        .VIDEO_REFRESH_RATE(60.0),
        .IT_CONTENT(1),
        .AUDIO_RATE(48000),
        .AUDIO_BIT_WIDTH(16),
        .START_X(0),
        .START_Y(0) )

hdmi(   .clk_pixel_x5(clk_5x_pixel),
        .clk_pixel(clk_pixel),
        .clk_audio(clk_audio),
        .rgb(rgb),
        .reset(0),
        .audio_sample_word(),
        .tmds(tmds),
        .tmds_clock(tmdsClk),
        .cx(cx),
        .cy(cy),
        .frame_width(),
        .frame_height() );

`ifdef ULX3S
    // ECP5: differential outputs
    OBUFDS u_clk (.I(clk_pixel), .O(tmds_clk_p), .OB(tmds_clk_n));
    OBUFDS u_d0  (.I(tmds[0]),   .O(tmds_d_p[0]), .OB(tmds_d_n[0]));
    OBUFDS u_d1  (.I(tmds[1]),   .O(tmds_d_p[1]), .OB(tmds_d_n[1]));
    OBUFDS u_d2  (.I(tmds[2]),   .O(tmds_d_p[2]), .OB(tmds_d_n[2]));
`else
    // Gowin LVDS output buffer
    ELVDS_OBUF tmds_bufds [3:0] (
        .I({clk_pixel, tmds}),
        .O({tmds_clk_p, tmds_d_p}),
        .OB({tmds_clk_n, tmds_d_n})
    );
`endif


endmodule
