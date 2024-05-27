module ROUND(
    input  wire S,
    input  wire [23:0] M_NORM,
    input  wire [1:0]  round_mode,
    output reg [22:0] M_ROUND,
    output reg RENORM
);

parameter RUP   = 2'b00;
parameter RDOWN = 2'b01;
parameter RTE   = 2'b10;
parameter RTAZ  = 2'b11;

always @(*) begin
    case(round_mode)
        RUP: begin
            if(S==1'b1) begin
                RENORM  = 1'b0;
                M_ROUND = M_NORM[23:1];
            end
            else begin
                {RENORM, M_ROUND} = M_NORM[0] ? (M_NORM[23:1] + 1'b1) : ({1'b0, M_NORM[23:1]}); 
            end
        end
        RDOWN: begin
            if(S==1'b0) begin
                RENORM  = 1'b0;
                M_ROUND = M_NORM[23:1];
            end
            else begin
                {RENORM, M_ROUND} = M_NORM[0] ? (M_NORM[23:1] + 1'b1) : ({1'b0, M_NORM[23:1]});  
            end
        end
        RTE: begin
            {RENORM, M_ROUND} = M_NORM[0] ? ((M_NORM[1]) ? (M_NORM[23:1] + 1'b1) : ({1b'0, M_NORM[23:1]})) : ({1b'0, M_NORM[23:1]});
        end
        RTAZ: begin
            {RENORM, M_ROUND} = M_NORM[0] ? (M_NORM[23:1] + 1'b1) : ({1'b0, M_NORM[23:1]});
        end
    endcase
end

endmodule