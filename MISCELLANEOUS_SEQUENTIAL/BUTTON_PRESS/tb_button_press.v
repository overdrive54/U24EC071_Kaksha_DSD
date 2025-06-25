`timescale 1ns/1ps
module tb_button_press;

  reg  clk   = 1'b0;
  reg  button;
  wire blink;
  wire [1:0] q;
  wire [1:0] qbar;

  button_press uut (
      .button (button),
      .clk    (clk),
      .blink  (blink),
      .q      (q),
      .qbar   (qbar)
  );

  always #5 clk = ~clk;
  
  initial begin
  button = 0;
end

  initial begin
    $display(" time(ns) | clk btn | blink | q");
    $monitor("%8t |   %b   %b |   %b   | %b",
             $time, clk, button, blink, q);
  end
  
  initial begin
    $dumpfile("button_press.vcd");
    $dumpvars(0, uut);

    clk = 0;
    uut.ff0.q = 0;
    uut.ff1.q = 0;
    #10 button <= 1;
    #10 button <= 0;
    #10 button <= 1;
    #10 button <= 1;
    #10 button <= 1;
    #10 button <= 0;
    #10 button <= 0;
    #10 button <= 1;
    #10 button <= 0;
    #10 button <= 0;
    #10 button <= 0;
    #10 button <= 1;
    #10 button <= 0;

    $finish;
  end

endmodule
//---------------------------------------------------------------------
