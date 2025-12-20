// Single-port ROM (read-only memory)
module sprom #(
    parameter width = 8,
    parameter widthad = 12,
    parameter init_file = ""
)(
    input                clk,
    input  [widthad-1:0] address,
    output   [width-1:0] q
);

    reg [width-1:0] mem [0:(2**widthad)-1];
    reg [widthad-1:0] addr_reg;

    // Initialize ROM from hex file (one word per line)
    initial begin
        if (init_file != "") begin
            $readmemh(init_file, mem);
        end else begin
            $display("Warning: sprom instantiated without init_file");
        end
    end

    // Register address for read
    always @(posedge clk) begin
        addr_reg <= address;
    end

    assign q = mem[addr_reg];

endmodule
