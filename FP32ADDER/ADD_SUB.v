module ADD_SUB (
    input  wire [1:0] OP,
    input  wire [23:0] M1_EFF,
    input  wire [23:0] M2_EFF,
    output wire S,
    output wire [23:0] M,
    output wire Cout
);

wire order;
assign order     = M1_EFF >= M2_EFF;
assign S         = (^OP) ? (order^OP[0]) : (&OP);
assign {Cout, M} = (^OP) ? ((order) ? (M1-M2) : (M2-M1)) : (M1+M2);

endmodule