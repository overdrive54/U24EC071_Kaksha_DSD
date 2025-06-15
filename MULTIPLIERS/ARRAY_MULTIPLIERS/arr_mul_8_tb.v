`timescale 1ns / 1ps

module arr_mul_8_tb;
  
  reg [7:0] A, B;
  wire [15:0] out;
  
  arr_mul_8 uut (
    .out(out),
    .A(A),
    .B(B)
  );
  
  initial begin
    $monitor("Time = %d | A = %b | B = %b | Product = %b", $time, A, B, out);

    A = 8'b00000010; B = 8'b00000011; #10;
    A = 8'b00000101; B = 8'b00000110; #10;
    A = 8'b11111111; B = 8'b00000001; #10;
    A = 8'b10101010; B = 8'b01010101; #10;
    A = 8'b00000000; B = 8'b11111111; #10;
    A = 8'b11111111; B = 8'b11111111; #10;

    $finish;
  end
endmodule
