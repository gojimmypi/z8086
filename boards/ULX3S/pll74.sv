// file: boards/ULX3S/pll74.sv
// ULX3S/ECP5 PLL: 25 MHz input -> 25 MHz pixel + 125 MHz (5x) output.
// Uses a legal VCO (625 MHz).

module pll74 (
    input  wire clkin,
    output wire clkout0,
    output wire clkout1,
    input  wire mdclk
);
    // mdclk intentionally unused
    wire _unused_mdclk = mdclk;

    wire lock;
    wire clkfb;

    // EHXPLLL primitive (ECP5)
    EHXPLLL #(
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED"),
        .STDBY_ENABLE("DISABLED"),
        .DPHASE_SOURCE("DISABLED"),
        .OUTDIVIDER_MUXA("DIVA"),
        .OUTDIVIDER_MUXB("DIVB"),
        .OUTDIVIDER_MUXC("DIVC"),
        .OUTDIVIDER_MUXD("DIVD"),

        .CLKI_DIV(1),
        .CLKFB_DIV(25),

        .CLKOP_ENABLE("ENABLED"),
        .CLKOP_DIV(25),
        .CLKOP_CPHASE(0),
        .CLKOP_FPHASE(0),

        .CLKOS_ENABLE("ENABLED"),
        .CLKOS_DIV(5),
        .CLKOS_CPHASE(0),
        .CLKOS_FPHASE(0),

        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),

        .FEEDBK_PATH("CLKOP")
    ) pll_i (
        .CLKI(clkin),
        .CLKFB(clkfb),
        .CLKOP(clkout0),
        .CLKOS(clkout1),
        .CLKOS2(),
        .CLKOS3(),
        .RST(1'b0),
        .STDBY(1'b0),
        .LOCK(lock),
        .INTLOCK(),
        .PHASESEL0(1'b0),
        .PHASESEL1(1'b0),
        .PHASEDIR(1'b0),
        .PHASESTEP(1'b0),
        .PHASELOADREG(1'b0),
        .PLLWAKESYNC(1'b0),

        .ENCLKOP(1'b0),
        .ENCLKOS(1'b0),
        .ENCLKOS2(1'b0),
        .ENCLKOS3(1'b0)
    );

    assign clkfb = clkout0;

endmodule
