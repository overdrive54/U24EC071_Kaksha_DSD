`timescale 1ns / 1ps

module tb_uni_shift_8_bit;

    reg clk;
    reg rst_n;
    reg serial_in_L, serial_in_R;
    reg [7:0] parallel_in;
    reg [1:0] sel;
    wire serial_out_L, serial_out_R;
    wire [7:0] q;

    uni_shift_8_bit uut (
        .serial_in_L(serial_in_L),
        .serial_in_R(serial_in_R),
        .parallel_in(parallel_in),
        .sel(sel),
        .clk(clk),
        .rst_n(rst_n),
        .serial_out_L(serial_out_L),
        .serial_out_R(serial_out_R),
        .q(q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("uni_shift.vcd");
        $dumpvars(0, tb_uni_shift_8_bit);

        rst_n = 0; serial_in_L = 0; serial_in_R = 0; parallel_in = 8'b10101010; sel = 2'b11;
        #12 rst_n = 1;
        
        #10 sel = 2'b11;

        #10 sel = 2'b00;

        #10 serial_in_L = 1; sel = 2'b10;

        #10 serial_in_R = 1; sel = 2'b01;

        #50 $finish;
    end

endmodule
