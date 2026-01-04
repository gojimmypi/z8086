// file: boards/ULX3S/pll27.sv
// ULX3S/ECP5 replacement for Tang "pll27".
// nextpnr-ecp5 does not support the Tang-specific pll27 cell, so map to ECP5 EHXPLLL.
//
// Ports preserved for minimal integration.
// mdclk is unused on ULX3S/ECP5; kept only for compatibility.

module pll27 (
    input  wire clkin,
    output wire clkout0,
    input  wire mdclk
);

    // Silence unused warning; mdclk is only used on Tang dynamic PLL programming.
    wire mdclk_unused;
    assign mdclk_unused = mdclk;

    // ECP5 PLL primitive.
    // Replace these divider values to match the required frequencies.
    EHXPLLL #(
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED"),
        .STDBY_ENABLE("DISABLED"),
        .DPHASE_SOURCE("DISABLED"),

        .CLKOP_ENABLE("ENABLED"),
        .CLKOS_ENABLE("DISABLED"),
        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),

        .OUTDIVIDER_MUXA("DIVD"),
        .OUTDIVIDER_MUXB("DIVD"),
        .OUTDIVIDER_MUXC("DIVD"),
        .OUTDIVIDER_MUXD("DIVD"),

        // --------------------------------------------------------------------
        // TODO: Set these to generate the correct clkout0.
        // In your design, pll27 takes clk50 and outputs clk27.
        // These placeholders are NOT guaranteed correct.
        // --------------------------------------------------------------------
        .CLKI_DIV(1),
        .CLKFB_DIV(1),
        .CLKOP_DIV(1),

        .CLKOP_CPHASE(0),
        .CLKOP_FPHASE(0),

        .FEEDBK_PATH("CLKOP")
    ) pll_i (
        .CLKI(clkin),

        // Feedback from CLKOP (clkout0)
        .CLKFB(clkout0),

        .RST(1'b0),
        .STDBY(1'b0),

        .PHASESEL0(1'b0),
        .PHASESEL1(1'b0),
        .PHASEDIR(1'b0),
        .PHASESTEP(1'b0),
        .PHASELOADREG(1'b0),
        .PLLWAKESYNC(1'b0),

        .ENCLKOP(1'b1),
        .ENCLKOS(1'b0),
        .ENCLKOS2(1'b0),
        .ENCLKOS3(1'b0),

        .CLKOP(clkout0),
        .CLKOS(),
        .CLKOS2(),
        .CLKOS3(),

        .LOCK(),
        .INTLOCK(),
        .REFCLK(),
        .CLKINTFB()
    );

endmodule
