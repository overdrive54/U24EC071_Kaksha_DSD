`timescale 1ns / 1ps

module Barrel_shift_R(
input [4:0] shift_amnt,
input [31:0] shift_str,
output [31:0] shifted_str
    );
    wire [31:0] state,state0,state1,state2,state3,state4;
    assign state  = shift_str;
    assign state0  = shift_amnt[0]?{state[0],state[31:1]}:state;
    assign state1  = shift_amnt[1]?{state0[1:0],state0[31:2]}:state0;
    assign state2  = shift_amnt[2]?{state1[3:0],state1[31:4]}:state1;
    assign state3  = shift_amnt[3]?{state2[7:0],state2[31:8]}:state2;
    assign state4  = shift_amnt[4]?{state3[15:0],state3[31:16]}:state3;
    assign shifted_str = state4;
endmodule
