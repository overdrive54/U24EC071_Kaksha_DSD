`timescale 1ns/1ps

module tb_8b_carry_look_ahead_adder();

  reg  [7:0] a;
  reg  [7:0] b;
  reg        cin;
  wire [7:0] s;
  wire       cout;
  
  carry_select_8b_adder uut (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .s(s)
  );
  
  initial begin
    $dumpfile("carry_select_adder_tb.vcd");
    $dumpvars(0, tb_8b_carry_select_adder);
    
    a   = 8'd0;
    b   = 8'd0;
    cin = 1'b0;
    #10;
    
    a   = 8'h05;
    b   = 8'h03;
    cin = 1'b0;
    #10;
    
    a   = 8'h0F;
    b   = 8'h01;
    cin = 1'b0;
    #10;
    
    a   = 8'hA5;
    b   = 8'h5A;
    cin = 1'b1;
    #10;
    
    a   = 8'hFF;
    b   = 8'hFF;
    cin = 1'b1;
    #10;
    
    a   = 8'b10101010;
    b   = 8'b01010101;
    cin = 1'b0;
    #10;
    
    $finish;
  end
  
endmodule
