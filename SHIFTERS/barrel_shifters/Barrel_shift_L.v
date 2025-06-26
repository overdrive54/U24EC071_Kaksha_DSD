`timescale 1ns / 1ps

module Barrel_shift_L(
input [4:0] shift_amnt,
input [31:0] shift_str,
output [31:0] shifted_str
    );
    wire state  = shifted_str;
    wire state0  = shift_amt[0]?{state[31],state[0:30]};

endmodule
