// Code your testbench here
`timescale 1ns / 1ps

module tb_p_encoder;
  reg [3:0] in;
  wire [1:0] out;
  p_encoder uut (
    .in(in),
    .out(out)
    );
  initial begin
    $dumpfile("tb_encoder.vcd");
    $dumpvars(0, uut);
    $monitor("Time=%0t | in=%b | out=%b", $time, in, out);
    end

  initial begin
    in = 4'b0101; #10
    in = 4'b1011; #10
    in = 4'b0110; #10
    in = 4'b0010; #10
    in = 4'b0001; #10
    in = 4'b1010; #10
    $finish;
  end 
endmodule
