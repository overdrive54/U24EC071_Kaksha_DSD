`timescale 1ns / 1ps

module siso_8_bit_tb;

    reg clk;
    reg rst_n;
    reg serial_in;
    wire serial_out;

    siso_8_bit dut (
        .serial_in(serial_in),
        .clk(clk),
        .rst_n(rst_n),
        .serial_out(serial_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("siso_8_bit_tb.vcd");
        $dumpvars(0, siso_8_bit_tb);

        rst_n = 1;
        serial_in = 0;
        #12;

        rst_n = 0;

        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;

        #100;

        $finish;
    end
endmodule
