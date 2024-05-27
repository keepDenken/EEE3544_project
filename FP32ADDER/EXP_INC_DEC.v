module EXP_INC_DEC(
    input  wire E_EFF,
    input  wire [7:0] E1,
    input  wire [7:0] E2,
    input  wire [4:0] LZ,
    output wire [7:0] E
);

wire [7:0] _E = (E_EFF) ? (E1) : (E2);
wire [4:0] operand = LZ - 1;

assign E = (_E > operand) ? (_E-operand) : (5'b0);

endmodule