module NORMALIZE(
    input  wire [24:0] M,
    input  wire [4:0] LZ,
    output wire [23:0] M_NORM
);

assign M_NORM = (M<<LZ)[23:0];

endmodule