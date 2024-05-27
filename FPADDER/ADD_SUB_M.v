module ADD_SUB_M (
    input  wire S1, S2,
    input  wire [26:0] M1,
    input  wire [26:0] M2,
    output wire S
    output wire C,
    output wire [26:0] M,
);

/* Addition for 1, Subtraction for 0 */
wire OP = (S1==S2);
/* M1 - M2 for 1 M2 - M1 for 0 */
wire ORDER = M1 > M2;
wire _M[27:0] = (OP) ? (M1 + M2) : (ORDER ? (M1 - M2) : (M2-M1));

assign S = (OP) ? (S1) : (ORDER ? (S1) : (S2));
assign C = _M[27];
assign M = _M[26:0];

endmodule