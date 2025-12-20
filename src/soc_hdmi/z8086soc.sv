// z8086 soc top module
module z8086soc (
    input clk50,
    input s0,
    input s1,
    output reg [7:0] led,

    // HDMI output
    output       tmds_clk_n,
    output       tmds_clk_p,
    output [2:0] tmds_d_n,
    output [2:0] tmds_d_p,

    // UART (via USB-C)
    output       uart_tx,
    input        uart_rx
);

// Video memory mapping: 0xB8000-0xB9FFF (8KB, covers 4800 bytes needed for 80x30)
wire vram_access = (addr >= 20'hB8000) && (addr < 20'hBA000);

// I/O port definitions
localparam PORT_LED = 8'h05;              // Port 5: LED output
localparam PORT_BUTTON = 8'h06;           // Port 6: Button input
localparam PORT_UART_DATA = 8'h07;        // Port 7: UART data (RX/TX)
localparam PORT_UART_STATUS = 8'h08;      // Port 8: UART status

// Video controller I/O range (VGA-style, 0x10-0x1f)
localparam PORT_VIDEO_BASE = 8'h10;       // Video controller base address
localparam PORT_VIDEO_CURSOR_COL = 8'h10; // Port 0x10: Cursor column (video addr 0)
localparam PORT_VIDEO_CURSOR_ROW = 8'h11; // Port 0x11: Cursor row (video addr 1)
localparam PORT_VIDEO_CURSOR_START = 8'h12; // Port 0x12: Cursor start scanline (video addr 2)
localparam PORT_VIDEO_CURSOR_END = 8'h13; // Port 0x13: Cursor end scanline (video addr 3)
localparam PORT_VIDEO_BLINK_ENABLE = 8'h14; // Port 0x14: Blink enable (video addr 4)

// Clock signals
wire clk27;
wire clk_pixel;      // ~74.25 MHz for 720p
wire clk_5x_pixel;   // ~371.25 MHz for TMDS

`ifndef VERILATOR

pll27 u_pll27 (
    .clkin(clk50),
    .clkout0(clk27),
    .mdclk(clk50)
);

pll74 u_pll74 (
    .clkin(clk27), 
    .clkout0(clk_pixel),
    .clkout1(clk_5x_pixel),
    .mdclk(clk50)
);

`endif

reg cpu_reset_n = 1'b0;
reg [19:0] reset_cnt = 20'hFFFFF;
reg uart_rx_sync1_top = 1'b1;
reg uart_rx_sync2_top = 1'b1;
reg uart_rx_low_seen = 1'b0;
reg uart_rx_valid_seen = 1'b0;

always @(posedge clk50) begin
`ifdef VERILATOR
    cpu_reset_n <= 1'b1;
`else
    reset_cnt <= reset_cnt == 20'h0 ? 20'h0 : reset_cnt - 20'h1;
    if (reset_cnt == 0 /*&& ~s0*/) begin
        cpu_reset_n <= 1'b1;
    end
`endif
end

// Sync UART RX for debug probes
always @(posedge clk50) begin
    uart_rx_sync1_top <= uart_rx;
    uart_rx_sync2_top <= uart_rx_sync1_top;
end

wire [19:0] addr;
wire [15:0] din;
wire [15:0] dout;
wire wr;
wire rd;
wire io;
wire word;
reg ready;
reg [2:0] state;
reg vram_rd_word;
reg vram_rd_addr0;

z8086 cpu (
    .clk(clk50),
    .reset_n(cpu_reset_n),
    .addr(addr),
    .din(din),
    .dout(dout),
    .wr(wr),
    .rd(rd),
    .io(io),
    .word(word),
    .ready(ready),
    .intr(1'b0),
    .nmi(1'b0),
    .inta()
);

// Video memory interface
wire [15:0] hdmi_dout;
wire hdmi_ready;

reg [15:0] din_r;
wire [7:0] q;
reg q_out_lo, q_out_hi;
reg wr_2nd;

// VRAM byte write handling
reg [15:0] vram_write_data;
reg vram_write_en;

// ========== UART Signals ==========
reg [7:0] uart_tx_data;
reg uart_tx_wr;
wire uart_tx_busy;
wire [7:0] uart_rx_data;
wire uart_rx_valid;
reg uart_rx_ack;

// ========== Video Control Settings Interface ==========
wire video_io_access = io && (addr[7:4] == 4'h1); // I/O access to 0x10-0x1f range
reg [2:0] hdmi_io_addr;
reg hdmi_io_rd;
reg hdmi_io_wr;
reg [15:0] hdmi_io_din;
wire [15:0] hdmi_io_dout;

// Main RAM
spram #(
    .width(8),
    .widthad(17),
    .init_file("soc_hdmi.hex")
) ram (
    .clk(clk50),
    .wraddress(state == 2'd2 ? addr[16:0]+17'd1 : addr[16:0]),
    .wren(wr & ~io & ~vram_access | wr_2nd),
    .data(state == 2'd2 ? dout[15:8] : dout[7:0]),
    .rdaddress(state == 2'd1 ? addr[16:0]+17'd1 : addr[16:0]),
    .q(q)
);

// Data input multiplexer
assign din = q_out_hi ? {q, din_r[7:0]} :
             q_out_lo ? {din_r[15:8], q} : din_r;

reg rx_r;

// memory and io access
always @(posedge clk50) begin
    // led[7] <= ~cpu_reset_n;
    // rx_r <= uart_rx;
    // if (uart_rx & ~rx_r)
    //     led[7] <= ~led[7];   // flip on rising edge
    led[7] <= 1'b1;

    ready <= 1'b0;
    q_out_lo <= 1'b0;
    q_out_hi <= 1'b0;
    wr_2nd <= 1'b0;
    vram_write_en <= 1'b0;

    // Clear UART strobes
    uart_tx_wr <= 1'b0;
    uart_rx_ack <= 1'b0;

    // Clear HDMI settings interface strobes
    hdmi_io_rd <= 1'b0;
    hdmi_io_wr <= 1'b0;

    case (state)
    3'd0: begin
        // Video memory access
        if ((rd | wr) & vram_access) begin
            if (rd) begin
                // Read: wait one cycle for VRAM output
                vram_rd_word <= word;
                vram_rd_addr0 <= addr[0];
                state <= 3'd4;
            end else if (wr) begin
                // Write: Handle byte vs word writes
                if (word) begin
                    // Word write: write directly
                    vram_write_data <= dout;
                    vram_write_en <= 1'b1;
                    ready <= hdmi_ready;
                end else begin
                    // Byte write: need read-modify-write
                    // State 0: Start read to get current word
                    state <= 3'd3;
                end
            end
        end
        // Regular memory access
        else if (rd & ~io) begin
            q_out_lo <= 1'b1;
            state <= word ? 3'd1 : 3'd0;
            if (~word) ready <= 1'b1;
        end else if (wr & ~io) begin
            state <= word ? 3'd2 : 3'd0;
            if (~word) ready <= 1'b1;
            if (word) wr_2nd <= 1'b1;
        end
        // I/O port access
        if ((rd | wr) & io) begin
            case (addr[7:0])
            PORT_LED: begin     // port 5: LED
                if (rd) din_r <= {9'b0, ~led[6:0]};
                if (wr) led[6:0] <= ~dout[6:0];
            end
            PORT_BUTTON: begin  // port 6: Buttons
                if (rd) din_r <= {14'h0000, ~s1, ~s0};
            end
            PORT_UART_DATA: begin    // port 7: UART data
                if (rd) begin
                    din_r <= {8'h00, uart_rx_data};
                    uart_rx_ack <= 1'b1;
                end
                if (wr) begin
`ifdef VERILATOR
                    $display("[PORT 7 WR] PC=0x%05X dout=0x%02X '%c'",
                             {cpu.CS, 4'h0} + cpu.IP, dout[7:0],
                             (dout[7:0] >= 32 && dout[7:0] < 127) ? dout[7:0] : 8'h2E);
`endif
                    uart_tx_data <= dout[7:0];
                    uart_tx_wr <= 1'b1;
                end
            end
            PORT_UART_STATUS: begin  // port 8: UART status
                if (rd) begin
                    // Bit 0: Data Ready (RX has data)
                    // Bit 5: THR Empty (TX ready)
                    din_r <= {8'h00, 2'b00, ~uart_tx_busy, 4'b0000, uart_rx_valid};
                end
            end
            default: begin
                // Video controller I/O forwarding (0x10-0x1f)
                if (video_io_access) begin
                    // Direct forwarding to video controller
                    hdmi_io_addr <= addr[2:0];  // Lower 3 bits as settings address
                    if (rd) begin
                        hdmi_io_rd <= 1'b1;
                        din_r <= hdmi_io_dout;
                    end
                    if (wr) begin
                        hdmi_io_din <= dout;
                        hdmi_io_wr <= 1'b1;
                    end
                end
            end
            endcase
            ready <= 1'b1;
        end
    end
    3'd1: begin  // read 2nd byte (regular RAM)
        q_out_hi <= 1'b1;
        state <= 3'd0;
        ready <= 1'b1;
    end
    3'd2: begin  // write 2nd byte (regular RAM)
        state <= 3'd0;
        ready <= 1'b1;
    end
    3'd3: begin  // VRAM byte write: read complete, now write modified word
        // Merge the byte with the word we read
        if (addr[0]) begin
            // Writing to upper byte
            vram_write_data <= {dout[7:0], hdmi_dout[7:0]};
        end else begin
            // Writing to lower byte
            vram_write_data <= {hdmi_dout[15:8], dout[7:0]};
        end
        vram_write_en <= 1'b1;
        ready <= hdmi_ready;
        state <= 3'd0;
    end
    3'd4: begin  // VRAM read: data ready
        din_r <= vram_rd_word ? hdmi_dout :
                 (vram_rd_addr0 ? {8'h00, hdmi_dout[15:8]} : {8'h00, hdmi_dout[7:0]});
        ready <= hdmi_ready;
        state <= 3'd0;
    end
    endcase

    if (q_out_lo) din_r[7:0] <= q;
    if (q_out_hi) din_r[15:8] <= q;

    if (!cpu_reset_n) begin
        uart_rx_low_seen <= 1'b0;
        uart_rx_valid_seen <= 1'b0;
    end else begin
        if (!uart_rx_sync2_top) uart_rx_low_seen <= 1'b1;
        if (uart_rx_valid) uart_rx_valid_seen <= 1'b1;
    end

end

// ========== HDMI Video Output ==========
z8086hdmi hdmi_module (
    .clk(clk50),
    .clk_pixel(clk_pixel),
    .clk_5x_pixel(clk_5x_pixel),

    // Video memory access (16-bit word, mapped at 0xB8000, 4800 bytes = 2400 words for 80x30)
    .addr(addr[12:1]),          // Word address (divide byte address by 2)
    .din(vram_write_data),      // 16-bit word data (prepared by state machine)
    .rd(rd & vram_access),
    .wr(vram_write_en),         // Write enable (controlled by state machine)
    .dout(hdmi_dout),
    .ready(hdmi_ready),

    // Settings register interface
    .io_addr(hdmi_io_addr),
    .io_rd(hdmi_io_rd),
    .io_wr(hdmi_io_wr),
    .io_din(hdmi_io_din),
    .io_dout(hdmi_io_dout),

    // HDMI output
    .tmds_clk_n(tmds_clk_n),
    .tmds_clk_p(tmds_clk_p),
    .tmds_d_n(tmds_d_n),
    .tmds_d_p(tmds_d_p)
);

// ========== UART ==========
uart_simple uart (
    .clk(clk50),
    .reset_n(cpu_reset_n),

    // CPU interface
    .tx_data(uart_tx_data),
    .tx_wr(uart_tx_wr),
    .tx_busy(uart_tx_busy),

    .rx_data(uart_rx_data),
    .rx_valid(uart_rx_valid),
    .rx_ack(uart_rx_ack),

    // Physical pins
    .uart_tx(uart_tx),
    .uart_rx(uart_rx)
);

endmodule
