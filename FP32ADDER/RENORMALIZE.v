module RENORMALIZE (
    input  wire RENORM,
    input  wire [22:0] M_ROUND,
    output wire [22:0] M_FINAL
);

assign M_FINAL = (RENORM) ? (M_ROUND>>1) : (M_ROUND);

endmodule