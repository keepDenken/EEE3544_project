module EXP_ING_DEC (
    input  wire EXP_EFF,
    input  wire [4:0] NUM_0S
    input  wire [7:0] E1,
    input  wire [7:0] E2,
    output wire [7:0] E
);

assign E = (EXP_EFF) ? (E1 - NUM_0S + 2);