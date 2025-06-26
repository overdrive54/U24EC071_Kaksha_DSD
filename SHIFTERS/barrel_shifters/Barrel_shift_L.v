`timescale 1ns / 1ps

module Barrel_shift(
input [4:0] shift_amnt,
input [31:0] shift_str,
output [31:0] shifted_str
    );
    wire [31:0] state,state0,state1,state2,state3,state4;
    assign state  = shift_str;
    assign state0  = shift_amnt[0]?{state[30:0],state[31]}:state;
    assign state1  = shift_amnt[1]?{state0[29:0],state0[31:30]}:state0;
    assign state2  = shift_amnt[2]?{state1[27:0],state1[31:28]}:state1;
    assign state3  = shift_amnt[3]?{state2[23:0],state2[31:24]}:state2;
    assign state4  = shift_amnt[4]?{state3[15:0],state3[31:16]}:state3;
    assign shifted_str = state4;
endmodule
