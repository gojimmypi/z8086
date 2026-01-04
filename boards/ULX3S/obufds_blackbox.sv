// file: boards/ULX3S/obufds_blackbox.sv
// ULX3S/ECP5 replacement for Xilinx OBUFDS.
// nextpnr-ecp5 does not support OBUFDS; model as simple complementary outputs.

module OBUFDS (
    input  wire I,
    output wire O,
    output wire OB
);
    assign O = I;
    assign OB = ~I;
endmodule
