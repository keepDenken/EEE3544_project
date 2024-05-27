module CASE_DIVISION(
    input  wire sel,
    input  wire S1,
    input  wire S2,
    input  wire [7:0] E1,
    input  wire [7:0] E2,
    input  wire [22:0] M1,
    input  wire [22:0] M2,
    output wire [1:0] OP,
    output reg [1:0] EXCEPTION
);

parameter NUM   = 2'b00;
parameter INF   = 2'b01;
parameter NINF  = 2'b10;
parameter NaN   = 2'b11;

/*  CASE DIVISION
    2'b00: Number
    2'b01: INF
    2'b10: -INF
    2'b11: NaN
 */
wire [1:0] CASE_A;
wire [1:0] CASE_B;

assign OP       = {S1, sel ^ S2};
assign CASE_A   = (E1==8{1'b1}) ? ((M1==23'b0) ? ((OP[1]) ? ( (NINF) : (INF) )) : (NaN)) : (NUM);
assign CASE_B   = (E2==8{1'b1}) ? ((M2==23'b0) ? ((OP[0]) ? ( (NINF) : (INF) )) : (NaN)) : (NUM);

/*  EXCEPTION DIVISION
    2'b00: Number +- Number
    2'b01: INF
    2'b10: -INF
    2'b11: NaN
 */
always @(*) begin
    casex({CASE_A, CASE_B})
        4'bxx00 : EXCEPTION <= CASE_A;
        4'b00xx : EXCEPTION <= CASE_B;
        4'bxx11 : EXCEPTION <= NaN;
        4'b11xx : EXCEPTION <= NaN;
        4'b0101 : EXCEPTION <= INF;
        4'b1010 : EXCEPTION <= NINF;
        4'b0110 : EXCEPTION <= NaN;
        4'b1001 : EXCEPTION <= NaN
    endcase
end

endmodule