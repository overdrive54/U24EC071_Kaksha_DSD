`timescale 1ns / 1ps

module tb_det_110;

    reg clk = 0;
    reg rstn = 0;
    reg in   = 0;
    wire out;

    det_110 dut ( .clk(clk), .rstn(rstn), .in(in), .out(out) );

    always #5 clk = ~clk;

    reg [31:0] bit_stream;
    integer i;

    initial begin
        $dumpfile("det_110.vcd");
        $dumpvars(0, tb_det_110);

        bit_stream = 32'b11011001011011001101100110110100;

        repeat(2) @(posedge clk);
        rstn = 1;

        for (i = 31; i >= 0; i = i - 1) begin
            in = bit_stream[i];
            @(posedge clk);
        end

        in = 0;
        repeat(4) @(posedge clk);

        $finish;
    end

endmodule
