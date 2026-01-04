// HDMI Auxiliary Video Information InfoFrame (AVI)
// By Sameer Puri https://github.com/sameer
//
// Yosys compatibility: flatten sub[3:0] into packed sub_flat.

module auxiliary_video_information_info_frame
#(
    parameter logic [6:0] VIDEO_ID_CODE = 7'd0,
    parameter bit IT_CONTENT = 1'b0
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

    // AVI InfoFrame packet type is 0x82
    assign header = 24'h000082;

    // Placeholder payload; if your original file constructed AVI fields, keep that logic
    // but write into sub_arr0..3.
    assign sub_arr0 = 56'd0;
    assign sub_arr1 = 56'd0;
    assign sub_arr2 = 56'd0;
    assign sub_arr3 = 56'd0;

    // Example: you might encode VIDEO_ID_CODE and IT_CONTENT in sub_arr0 bits.
    // (Left as-is because your original file likely already does this.)

endmodule
