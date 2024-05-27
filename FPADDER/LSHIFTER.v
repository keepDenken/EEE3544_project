module LSHIFTER (
    input  wire [27:0] M,
    input  wire [4:0] NUM_0S,
    output wire [26:0] M_NORM,
)

assign M_NORM = (M>>NUM_0S)[27:1];