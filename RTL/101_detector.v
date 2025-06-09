// 101 Sequence detector - Covering Non-overlapping and Overlapping cases
// This module detects the sequence "101" in a stream of bits.

//D-flip-flop module
module D_flip_flop(
    input clk, rstn, d
    output reg q
);
    always @(posedge clk) begin
        if(!rstn)
            q<=0;
        else
            q<=d;
    end
endmodule

//
module det_101(
    input clk, rst, in, overlap_en, // overlap_en: 1 for overlapping detection, 0 for non-overlapping
    output reg out
);

//Use parameter to define constants for states, because parameter cannot be changed.
//Like #Define in C
parameter IDLE = 2'b00,
            S1 = 2'b01,
            S2 = 2'b10;

reg [1:0] state, next_state;

//State register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end

//State transition logic
always @(*) begin
    case (state)
        IDLE: next_state = (in) ? S1 : IDLE;
        S1: next_state = (in) ? S1 : S2;
        S10: next_state = (in) ? (overlap_en ? S1 : IDLE) : IDLE;
        default: next_state = IDLE;
    endcase
end

//output logic
always @(*) begin
    if (state == S10 && in)
        out = 1; // Output high when "101" is detected
    else
        out = 0; // Output low otherwise
end
endmodule

