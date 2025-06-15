// Code your design here
`timescale 1ns / 1ps

module full_adder_behavioral(a,b,cin,cout,s);
  input a, b, cin;
  output reg cout, s;
  always @ ( * ) begin
    {cout, s}= a + b + cin;
  end
endmodule
