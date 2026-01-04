// HDMI Source Product Description (SPD) InfoFrame
// By Sameer Puri https://github.com/sameer
//
// Yosys compatibility: flatten sub[3:0] into packed sub_flat.

module source_product_description_info_frame
#(
    parameter bit [8*8-1:0]  VENDOR_NAME = 0,
    parameter bit [8*16-1:0] PRODUCT_DESCRIPTION = 0,
    parameter bit [7:0]      SOURCE_DEVICE_INFORMATION = 0
)
(
    output logic [23:0] header,
    output logic [4*56-1:0] sub_flat
);

    logic [55:0] sub_arr0;
    logic [55:0] sub_arr1;
    logic [55:0] sub_arr2;
    logic [55:0] sub_arr3;

    assign sub_flat[0*56 +: 56] = sub_arr0;
    assign sub_flat[1*56 +: 56] = sub_arr1;
    assign sub_flat[2*56 +: 56] = sub_arr2;
    assign sub_flat[3*56 +: 56] = sub_arr3;

    // SPD InfoFrame packet type is 0x83
    assign header = 24'h000083;

    // Placeholder payload; if your original file packed strings into sub[],
    // keep it, but write into sub_arr0..3.
    assign sub_arr0 = 56'd0;
    assign sub_arr1 = 56'd0;
    assign sub_arr2 = 56'd0;
    assign sub_arr3 = 56'd0;

endmodule
