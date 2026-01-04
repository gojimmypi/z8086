// file: boards/ULX3S/pll27.sv
// Minimal ULX3S/ECP5 implementation.
// Pass-through to avoid invalid PLL config bits during ecppack.

module pll27 (
    input  wire clkin,
    output wire clkout0,
    input  wire mdclk
);
    // mdclk intentionally unused
    wire _unused_mdclk = mdclk;

    assign clkout0 = clkin;
endmodule
