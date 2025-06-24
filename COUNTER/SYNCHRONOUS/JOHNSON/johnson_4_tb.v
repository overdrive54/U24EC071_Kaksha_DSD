`timescale 1ns / 1ps

module johnson_4_tb;

    reg clk;
    wire [3:0] q;
    wire [3:0] qbar;

    johnson_4 uut (
        .clk(clk),
        .q(q),
        .qbar(qbar)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
    clk = 0;
    uut.d0.q = 0;
    uut.d1.q = 0;
    uut.d2.q = 0;
    uut.d3.q = 0;
end
    initial begin
        $dumpfile("up_count_4_t_ff.vcd");
        $dumpvars(0, uut);
        $monitor("Time = %0t | Counter = %b", $time, q);

        #200 $finish;
    end

endmodule
