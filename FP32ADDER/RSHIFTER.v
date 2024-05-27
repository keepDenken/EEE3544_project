module RSHIFTER(
    input  wire E_EFF,
    input  wire [7:0] E_DIFF,
    input  wire [23:0] M1,
    input  wire [23:0] M2,
    output wire [23:0] M1_EFF,
    output wire [23:0] M2_EFF
);

assign M1_EFF = (E_EFF) ? (M1) : (M1 >> E_DIFF);
assign M2_EFF = (E_EFF) ? (M2 >> E_DIFF) ? (M2);

endmodule