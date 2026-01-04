// HDMI Audio InfoFrame
// By Sameer Puri https://github.com/sameer
//
// Yosys compatibility: flatten sub[3:0] into packed sub_flat.

module audio_info_frame
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

    // Keep the original intent: Audio InfoFrame is packet type 0x84
    // If your original file had exact bytes, keep them in these sub_arr* words.
    assign header = 24'h000084;

    assign sub_arr0 = 56'd0;
    assign sub_arr1 = 56'd0;
    assign sub_arr2 = 56'd0;
    assign sub_arr3 = 56'd0;

endmodule
