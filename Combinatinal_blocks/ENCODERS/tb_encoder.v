// Code your testbench here
`timescale 1ns / 1ps

module tb_encoder;
  reg [3:0] in;
  wire [1:0] out;
  encoder uut (
    .in(in),
    .out(out)
    );
  initial begin
    $dumpfile("tb_encoder.vcd");
    $dumpvars(0, tb_encoder);
    $monitor("Time=%0t | in=%b | out=%b", $time, in, out);
    end

  initial begin
    in = 4'b0001; #10
    in = 4'b0010; #10
    in = 4'b0100; #10
    in = 4'b1000;
    $finish;
  end 
endmodule
