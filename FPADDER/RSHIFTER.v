module RSHIFTER(
    input  wire [26:0] M_SMALL,
    input  wire [7:0]  EXP_DIFF,
    output wire [26:0] M_EFF
);

assign M_EFF = M_SMALL >> EXP_DIFF;

endmodule