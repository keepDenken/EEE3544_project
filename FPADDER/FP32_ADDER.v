module FP32_ADDER (
    input   wire  [31:0] A,
    input   wire  [31:0] B,
    input   wire  [1:0]  rmode,
    output  wire  [31:0] Y,
    output  wire         error,
    output  wire         overflow
);

/* Pre-Process Stage */
wire S1, S2;
wire[7:0] E1, E2;
wire[25:0] M1, M2;

DECOMP DECOMP_INST_0 ( // M with hidden bit, also GRS bit, thus M is 24 bit wide.
    .A(A),
    .B(B),
    .S1(S1),
    .S2(S2),
    .E1(E1),
    .E2(E2),
    .M1(M1),
    .M2(M2)
);

wire [7:0]  EXP_DIFF;
wire        EXP_EFF;
EXP_DIFF EXP_DIFF_INST_0 ( // Calculate Exponent difference
    .E1(E1),
    .E2(E2),
    .EXP_DIFF(EXP_DIFF),
    .EXP_EFF(EXP_EFF)
);

wire [23:0] M_SMALL;
SWAP SWAP_INST_0 ( // Output Mantissa of small operand
    .EXP_EFF(EXP_EFF),
    .M1(M1),
    .M2(M2),
    .M_SMALL(M_SMALL)
);

wire [25:0] M_EFF;
RSHIFTER RSHIFTER_INST_0 ( //Shift Small Mantissa by exponent difference
    .M_SMALL(M_SMALL),
    .EXP_DIFF(EXP_DIFF),
    .M_EFF(M_EFF)
);

/* ADD-SUBTRACT M */
wire S;
wire C;
wire [26:0] M;
ADD_SUB_M ADD_SUB_M_INST_0 ( //Add/Subtract Mantissa 
    .S1(S1),
    .S2(S2),
    .M1(M1),
    .M2(M2),
    .S(S),
    .C(C),
    .M(M)
);

/* Leading Zero Detection */
wire [4:0] NUM_0S;
LZD LZD_INST_0 ( //Count the number of leading 0's
    .M({C, M}),
    .NUM(NUM_0S)
);

/* NORMALIZE */
wire [26:0] M_NORM;
LSHIFTER LSHIFTER_INST_0 ( //Normalize Mantissa
    .M(M),
    .NUM_0S(NUM_0S),
    .M_NORM(M_NORM)
);

/* Exponent Adjustment */
wire [7:0] E;
EXP_INC_DEC EXP_INC_DEC_INST_0 (
    .EXP_EFF(EXP_EFF),
    .NUM_0S(NUM_0S)
    .E1(E1),
    .E2(E2),
    .E(E)
);

/* ROUNDINGS */
wire [22:0] M_FINAL;
wire RENORM;
ROUND ROUND_INST_0(
    .rmode(rmode),
    .S(S),
    .M_NORM(M_NORM),
    .M_FINAL(M_FINAL),
    .RENORM(RENORM)
);