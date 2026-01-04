// vram_ecp5.sv
// Dual-clock, true dual-port VRAM for ECP5 (ULX3S)
// Tailored for 80x30 text mode: 2400 words x 16 bits
//
// Port A (CPU, clka): read/write, synchronous read (registered output)
// Port B (video, clkb): read-only, synchronous read (registered output)
//
// Notes:
// - Inference-friendly for Yosys + nextpnr-ecp5 (ECP5 DP16KD BRAM)
// - Optional INIT_FILE uses $readmemh (hex words, 16-bit wide)

module vram_ecp5 #(
    parameter DATA_W = 16,
    parameter ADDR_W = 12,
    parameter DEPTH  = 2400,
    parameter INIT_FILE = ""
) (
    input  wire                 clka,
    input  wire [ADDR_W-1:0]    addra,
    input  wire [DATA_W-1:0]    dina,
    output reg  [DATA_W-1:0]    douta,
    input  wire                 wea,

    input  wire                 clkb,
    input  wire [ADDR_W-1:0]    addrb,
    output reg  [DATA_W-1:0]    doutb
);

    (* ram_style = "block" *)
    reg [DATA_W-1:0] mem [0:DEPTH-1];

    integer idx;

    initial begin
        if (INIT_FILE != "") begin
            $readmemh(INIT_FILE, mem);
        end else begin
            for (idx = 0; idx < DEPTH; idx = idx + 1) begin
                mem[idx] = {DATA_W{1'b0}};
            end
        end
    end

    // Port A: sync read, optional write
    always @(posedge clka) begin
        if (wea) begin
            if (addra < DEPTH) begin
                mem[addra] <= dina;
            end
        end

        if (addra < DEPTH) begin
            douta <= mem[addra];
        end else begin
            douta <= {DATA_W{1'b0}};
        end
    end

    // Port B: sync read-only
    always @(posedge clkb) begin
        if (addrb < DEPTH) begin
            doutb <= mem[addrb];
        end else begin
            doutb <= {DATA_W{1'b0}};
        end
    end

endmodule
