// Code your testbench here
`timescale 1ns / 1ps

module tb_decoder;
  reg in;
  reg [1:0] sel;
  wire [3:0] out;
  decoder uut (
    .in(in),
    .sel(sel),
    .out(out)
    );
  initial begin
    $dumpfile("tb_decoder.vcd");
    $dumpvars(0, tb_decoder);
    $monitor("Time=%0t | sel=%b | in=%b | out=%b", $time, sel, in, out);
    end

  initial begin
    in = 1; sel = 2'b00; #10
    in = 1; sel = 2'b01; #10
    in = 1; sel = 2'b10; #10
    in = 0; sel = 2'b11; #10
    in = 0; sel = 2'b00; #10
    in = 0; sel = 2'b01; #10
    in = 0; sel = 2'b10; #10
    in = 1; sel = 2'b11; #10
    $finish;
  end 
endmodule
