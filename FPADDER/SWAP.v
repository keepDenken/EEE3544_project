module SWAP (
    input  wire EXP_EFF,
    input  wire [26:0] M1,
    input  wire [26:0] M2,
    output wire [26:0] M_SMALL
);

assign M_SMALL = (EXP_EFF) ? (M2) : (M1);