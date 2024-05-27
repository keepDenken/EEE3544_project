module LZC (
    input  wire [23:0] M,
    output wire [4:0] LZ
);

wire [31:0] M_PAD = {M, 8{1'b1}};

wire [15:0] STAGE1;
wire [7:0]  STAGE2;
wire [3:0]  STAGE3;
wire [1:0]  STAGE4;
wire        STAGE5;

wire RESULT1, RESULT2, RESULT3, RESULT4, RESULT5, RESULT6;

assign RESULT1  =   (M_PAD[31:16]   ==  16'b0);
assign RESULT2  =   (STAGE1[15:8]   ==  8'b0);
assign RESULT3  =   (STAGE2[7:4]    ==  4'b0);
assign RESULT4  =   (STAGE3[3:2]    ==  2'b0);
assign RESULT5  =   (STAGE4[1]      ==  1'b0);

assign STAGE1   =   (RESULT1)       ?   (M_PAD[15:0])   :   (M_PAD[31:16]);
assign STAGE2   =   (RESULT2)       ?   (STAGE1[7:0])   :   (STAGE1[15:8]);
assign STAGE3   =   (RESULT3)       ?   (STAGE2[3:0])   :   (STAGE2[7:4]);
assign STAGE4   =   (RESULT4)       ?   (STAGE3[1:0])   :   (STAGE3[3:2]);

assign LZ = (M==24'b0) ? (4'b0) : ((RESULT1<<4) + (RESULT2<<3) + (RESULT3<<2) + (RESULT4<<1) + RESULT5);

endmodule