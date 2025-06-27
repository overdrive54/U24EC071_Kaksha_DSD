`timescale 1ns / 1ps

module Barrel_shift_sel(
input [4:0] shift_amnt,
input L_R,// L:1  R:0
input [31:0] shift_str,
output reg [31:0] shifted_str
    );

    reg [31:0] state,state0,state1,state2,state3,state4;
    always @* begin
    if( L_R )begin
    
    state  = shift_str;
    state0  = shift_amnt[0]?{state[30:0],state[31]}:state;
    state1  = shift_amnt[1]?{state0[29:0],state0[31:30]}:state0;
    state2  = shift_amnt[2]?{state1[27:0],state1[31:28]}:state1;
    state3  = shift_amnt[3]?{state2[23:0],state2[31:24]}:state2;
    state4  = shift_amnt[4]?{state3[15:0],state3[31:16]}:state3;
    end 
    
    else begin
    state  = shift_str;
    state0  = shift_amnt[0]?{state[0],state[31:1]}:state;
    state1  = shift_amnt[1]?{state0[1:0],state0[31:2]}:state0;
    state2  = shift_amnt[2]?{state1[3:0],state1[31:4]}:state1;
    state3  = shift_amnt[3]?{state2[7:0],state2[31:8]}:state2;
    state4  = shift_amnt[4]?{state3[15:0],state3[31:16]}:state3;
    end 
    shifted_str = state4;
    end
endmodule
