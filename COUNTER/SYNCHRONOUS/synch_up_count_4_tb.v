`timescale 1ns / 1ps

module synch_up_count_4_tb;

    reg clk;
    wire [3:0] q;
    wire [3:0] qbar;

    synch_up_count_4 uut (
        .clk(clk),
        .q(q),
        .qbar(qbar)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
    clk = 0;
    uut.t0.q = 0;
    uut.t1.q = 0;
    uut.t2.q = 0;
    uut.t3.q = 0;
end
    initial begin
        $dumpfile("up_count_4_t_ff.vcd");
        $dumpvars(0, uut);
        $monitor("Time = %0t | Counter = %b", $time, q);

        #200 $finish;
    end

endmodule
