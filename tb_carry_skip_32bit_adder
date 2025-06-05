`timescale 1ns/1ps

module tb_carry_skip_32bit_adder;

  reg  [31:0] a, b;
  reg         cin;
  wire [31:0] sum;
  wire        cout;
  
  carry_skip_32bit_adder DUT (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );
  
  initial begin
    $dumpfile("carry_skip_32bit_adder_tb.vcd");
    $dumpvars(0, tb_carry_skip_32bit_adder);
  end
  
  initial begin
    a   = 32'h00000000;
    b   = 32'h00000000;
    cin = 1'b0;
    #10;
    

    a   = 32'h12345678;
    b   = 32'h11111111;
    cin = 1'b0;
    #10;
    
    a   = 32'hFFFFFFFF;
    b   = 32'h00000001;
    cin = 1'b0;
    #10;
    
    a   = 32'hAAAAAAAA;
    b   = 32'h55555555;
    cin = 1'b1;
    #10;
    
    a   = 32'h0F0F0F0F;
    b   = 32'hF0F0F0F0;
    cin = 1'b1;
    #10;
    
    $finish;
  end
  
  // Monitor signals for each test.
  initial begin
    $monitor("Time=%0t | a=0x%h, b=0x%h, cin=%b --> sum=0x%h, cout=%b",
             $time, a, b, cin, sum, cout);
  end
  
endmodule
