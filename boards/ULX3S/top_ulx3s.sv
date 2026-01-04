// File: boards/ULX3S/top_ulx3s.sv
`default_nettype none

module top_ulx3s(
    input  wire        clk_25mhz,

    input  wire [6:0]  btn,
    output wire [7:0]  led,

    output wire        wifi_gpio0,

    input  wire        ftdi_txd,
    output wire        ftdi_rxd,

    output wire [3:0]  gpdi_dp,
    output wire [3:0]  gpdi_dn
);

    assign wifi_gpio0 = 1'b1;

    // --------------------------------------------------------------------
    // LED blinky (independent)
    // --------------------------------------------------------------------
    localparam integer CTR_WIDTH = 32;
    reg [CTR_WIDTH-1:0] ctr;
    reg [7:0] o_led;

    wire reset;
    assign reset = btn[2];

    always @(posedge clk_25mhz) begin
        if (reset) begin
            ctr <= {CTR_WIDTH{1'b0}};
            o_led <= 8'b00000000;
        end else begin
            ctr <= ctr + {{(CTR_WIDTH-1){1'b0}}, 1'b1};
            o_led[7] <= 1'b1;
            o_led[6] <= btn[1];
            o_led[5:0] <= ctr[23:18];
        end
    end

    assign led = o_led;

    // --------------------------------------------------------------------
    // z8086 SoC
    // --------------------------------------------------------------------
    // ULX3S provides 25 MHz here; z8086soc port is named clk50.
    // This is a straight-through alias so it will synthesize.
    wire clk50;
    assign clk50 = clk_25mhz;

    // Map ULX3S buttons to SoC inputs (adjust if you want different behavior)
    wire s0;
    wire s1;
    assign s0 = btn[1];
    assign s1 = btn[2];

    // TMDS from SoC
    wire        tmds_clk_n;
    wire        tmds_clk_p;
    wire [2:0]  tmds_d_n;
    wire [2:0]  tmds_d_p;

    z8086soc u_soc (
        .clk50      (clk50),
        .s0         (s0),
        .s1         (s1),
        .led        (),          // LED is handled by blinky above

        .tmds_clk_n (tmds_clk_n),
        .tmds_clk_p (tmds_clk_p),
        .tmds_d_n   (tmds_d_n),
        .tmds_d_p   (tmds_d_p),

        .uart_tx    (ftdi_rxd),
        .uart_rx    (ftdi_txd)
    );

    // --------------------------------------------------------------------
    // ULX3S GPDI pin mapping (LPF expects gpdi_[d][3]=clock, [2:0]=data)
    // --------------------------------------------------------------------
    assign gpdi_dp[3] = tmds_clk_p;
    assign gpdi_dn[3] = tmds_clk_n;

    assign gpdi_dp[2:0] = tmds_d_p;
    assign gpdi_dn[2:0] = tmds_d_n;

endmodule

`default_nettype wire
