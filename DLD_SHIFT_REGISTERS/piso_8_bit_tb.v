`timescale 1ns / 1ps
module piso_8_bit_tb;

    reg         clk;
    reg         rst_n;
    reg         sel_p_s;
    reg  [7:0]  parallel_in;
    wire        serial_out;

    piso_8_bit dut (
        .parallel_in (parallel_in),
        .clk         (clk),
        .rst_n       (rst_n),
        .sel_p_s     (sel_p_s),
        .serial_out  (serial_out)
    );

    initial clk = 1'b0;
    always  #5 clk = ~clk;

    initial begin
        $dumpfile("piso_8_bit_tb.vcd");
        $dumpvars(0, piso_8_bit_tb);

        rst_n       = 1'b1;
        sel_p_s     = 1'b0;
        parallel_in = 8'h00;
        #12;
        rst_n       = 1'b0;

        parallel_in = 8'hBD;
        sel_p_s     = 1'b0;
        #10;

        sel_p_s     = 1'b1;
        #80;
        sel_p_s     = 1'b0;
        parallel_in = 8'h53;
        #10;

        sel_p_s     = 1'b1;
        #80;

        #20;
        $finish;
    end
endmodule
