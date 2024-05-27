module DECOMPOSE(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire S1,
    output wire S2,
    output wire [7:0] E1,
    output wire [7:0] E2,
    output wire [23:0] M1,
    output wire [23:0] M2
);

assign S1 = A[31];
assign S2 = B[31];
assign E1 = A[30:23];
assign E2 = B[30:23];
assign M1 = {1'b1, A[22:0]};
assign M2 = {1'b1, B[22:0]};

endmodule