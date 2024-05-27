module DECOMP(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire S_1, S_2,
    output wire [7:0] E1, E2,
    output wire [26:0] M1, M2
);

assign S_1 = A[31];
assign S_2 = B[31];

assign E1  = A[30:23];
assign E2  = B[30:23];

assign M1 = {1'b1, A[22:0], 3'b0};
assign M2 = {1'b1, B[22:0], 3'b0};

endmodule