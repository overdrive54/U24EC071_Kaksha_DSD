`timescale 1ns / 1ps

module tb_up_count_4_t_ff;

    reg clk;
    wire [3:0] q;

    // Instantiate the counter
    up_count_4_t_ff uut (
        .clk(clk),
        .q(q)
    );

    // Clock generation: toggle every 5ns → 10ns period (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
    clk = 0;
    // Simulate an initial reset pulse
    uut.t0.q = 0;
    uut.t1.q = 0;
    uut.t2.q = 0;
    uut.t3.q = 0;
end
    // Monitor and waveform dump
    initial begin
        $dumpfile("up_count_4_t_ff.vcd");
        $dumpvars(0, tb_up_count_4_t_ff);
        $monitor("Time = %0t | Counter = %b", $time, q);

        #200 $finish; // Run simulation for 200ns
    end

endmodule
