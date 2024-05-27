module FP32_ADDER(
    input  wire clk,
    input  wire reset,
    input  wire sel,
    input  wire [1:0]  round_mode,
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire error,
    output wire overflow,
    output wire [31:0] result
);

/* Decompose */
wire S1, S2;
wire [7:0] E1, E2;
wire [23:0] M1, M2;
DECOMPOSE DECOMPOSE_INST_0(
    .A(A),
    .B(B),
    .S1(S1),
    .S2(S2),
    .E1(E1),
    .E2(E2),
    .M1(M1),
    .M2(M2)
);

/* Case Division */
wire [1:0] OP;
wire [1:0] EXCEPTION;
CASE_DIVISION CASE_DIVISION_INST_0 (
    .sel(sel),
    .S1(S1),
    .S2(S2),
    .E1(E1),
    .E2(E2),
    .OP(OP),
    .EXCEPTION(EXCEPTION)
);

/* Exponent Difference */
wire E_EFF;
wire [7:0] E_DIFF;
EXP_DIFF EXP_DIFF_INST_0 (
    .E1(E1),
    .E2(E2),
    .E_EFF(E_EFF),
    .E_DIFF(E_DIFF)
);


/* Right Shift - Align the exponent */
wire [23:0] M1_EFF, M2_EFF;
RSHIFTER RSHIFTER_INST_0 (
    .E_EFF(E_EFF),
    .E_DIFF(E_DIFF),
    .M1(M1),
    .M2(M2),
    .M1_EFF(M1_EFF),
    .M2_EFF(M2_EFF)
);

/* Mantissa Calculation */
wire [23:0] M;
wire S;
wire Cout;
ADD_SUB ADD_SUB_INST_0 (
    .OP(OP),
    .M1_EFF(M1_EFF),
    .M2_EFF(M2_EFF),
    .S(S)
    .M(M),
    .Cout(Cout)
);

/* Leading-Zero Counter */
wire [3:0] LZ;
LZC LZC_INST_0(
    .M({Cout, M}),
    .LZ(LZ)
);

/* Normalize */
wire [23:0] M_NORM;
NORMALIZE NORMALIZE_INST_0 (
    .M({Cout, M}),
    .LZ(LZ),
    .M_NORM(M_NORM)
);

/* Adjust Exponent */
wire [7:0] E
EXP_INC_DEC EXP_INC_DEC_INST_0 (
    .E_EFF(E_EFF),
    .E1(E1),
    .E2(E2),
    .LZ(LZ),
    .E(E)
);

wire [22:0] M_ROUND;
wire RENORM;

ROUND ROUND_INST_0 (
    .S(S)
    .M_NORM(M_NORM),
    .round_mode(round_mode),
    .M_ROUND(M_ROUND),
    .RENORM(RENORM)
);

RENORMALIZE RENORMALIZE_INST_0 (
    .RENORM(RENORM)
    .M_ROUND(M_ROUND),
    .M_FINAL(M_FINAL)
);

wire [7:0] E_FINAL
assign E_FINAL  = (RENORM) ? (E+1) : (E);
assign result   = {S, E_FINAL, M_FINAL};
assign overflow = (EXCEPTION==2'b10 || EXCEPTION== 2'b01) || ((E_FINAL==8{1'b1}));
assign error    = (EXCEPTION==2'b11);