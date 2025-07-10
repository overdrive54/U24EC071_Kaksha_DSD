`timescale 1ns / 1ps

module tb_synch_fifo_32x8;

    parameter fifo_w = 32;
    parameter fifo_d = 8;

    reg clk;
    reg rst;
    reg push_en;
    reg pop_en;
    reg [fifo_w-1:0] fifo_din;
    wire [fifo_w-1:0] fifo_dout;
    wire full;
    wire empty;

    synch_fifo_32x8 #(
        .fifo_w(fifo_w),
        .fifo_d(fifo_d)
    ) uut (
        .clk(clk),
        .rst(rst),
        .push_en(push_en),
        .pop_en(pop_en),
        .fifo_din(fifo_din),
        .fifo_dout(fifo_dout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fifo_tb.vcd");
        $dumpvars(0, tb_synch_fifo_32x8);

        clk = 0;
        rst = 1;
        push_en = 0;
        pop_en = 0;
        fifo_din = 0;

        #10 rst = 0;

        #10 push_en = 1; fifo_din = 32'hA1A1A1A1;
        #10 fifo_din = 32'hB2B2B2B2;
        #10 fifo_din = 32'hC3C3C3C3;
        #10 push_en = 0;

        #10 pop_en = 1;
        #30 pop_en = 0;

        #10 push_en = 1; fifo_din = 32'hD4D4D4D4;
        #10 fifo_din = 32'hE5E5E5E5;
        #10 push_en = 0;

        // End simulation
        #50 $finish;
    end

endmodule
