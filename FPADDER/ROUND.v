module ROUND (
    input  wire [1:0] rmode,
    input  wire S,
    input  wire [26:0] M_NORM,
    output  wire [22:0] M_FINAL,
    output  wire RENORM
);

reg [27:0] M_ROUND;
reg [22:0] _M_FINAL;

parameter RUP   = 2'b00;
parameter RDOWN = 2'b01;
parameter RTE   = 2'b10;
parameter RTAZ  = 2'b11;

assign RENORM   = M_ROUND[27];
assign M_FINAL  = (RENORM) ? (M_ROUND[26:4]) : (M_ROUND[25:3]);

always @(*) begin
    case(rmode)
        RUP: begin
            M_ROUND = (S) ? (M_NORM - 3'b111) : (M_NORM + 3'b111);
        end
        RDOWN: begin
            M_ROUND = (S) ? (M_NORM + 3'b111) : (M_NORM - 3'b111);
        end
        RTE: begin
            if(M_NORM[2:0]==3'b100) : M_ROUND = (M_NORM[3]=1'b0) ? (M_NORM + 3'b100) : ({1'b0, M_NORM});
            else : M
        end
        RTAZ: begin
        
        end
    endcase
end