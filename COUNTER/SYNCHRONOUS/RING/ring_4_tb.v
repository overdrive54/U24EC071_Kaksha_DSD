`timescale 1ns / 1ps

module ring_4_tb;

    reg clk;
    reg reset;
    wire [3:0] q;
    wire [3:0] qbar;

    ring_4 uut (
        .clk(clk),
        .reset(reset),
        .q(q),
        .qbar(qbar)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("ring_counter_4.vcd");
        $dumpvars(0, uut);
        $monitor("Time = %0t | q = %b | qbar = %b", $time, q, qbar);
    
    reset = 1; #10;
    reset = 0;
    
        #200;

        $finish;
    end

endmodule
