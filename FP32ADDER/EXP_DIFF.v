module EXP_DIFF(
    input  wire [7:0] E1,
    input  wire [7:0] E2,
    output wire E_EFF,
    output wire [7:0] E_DIFF
);

assign E_EFF  = (E1>=E2);
assign E_DIFF = (E_EFF) ? (E1-E2) : (E2-E1);

endmodule