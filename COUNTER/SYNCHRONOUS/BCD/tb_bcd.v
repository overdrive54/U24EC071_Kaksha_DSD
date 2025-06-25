`timescale 1ns/1ps
module tb_bcd;
    reg clk   = 0;
    wire [4:0] q;

    always #10 clk = ~clk;

    bsdk_count DUT ( .clk(clk), .q(q));
    
    initial begin
    clk = 0;
    DUT.ff0.q = 0;
    DUT.ff1.q = 0;
    DUT.ff2.q = 0;
    DUT.ff3.q = 0;
    DUT.ff4.q = 0;
    end
    initial begin

        $dumpfile("bcd_19.vcd");
        $dumpvars(0, tb_bcd);

        #800 $finish;
    end
endmodule
