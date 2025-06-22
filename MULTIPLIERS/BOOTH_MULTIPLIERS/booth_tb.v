`timescale 1ns/1ps

module booth_tb;

    reg signed [7:0] X, Y;

    wire signed [15:0] Z;

    BoothMul uut (
        .X(X),
        .Y(Y),
        .Z(Z)
    );

    initial begin
        $dumpfile("booth_comb.vcd");
        $dumpvars(0, uut);

        $display("Time\tX\tY\tZ");
        $monitor("%0dns\t%d\t%d\t%d", $time, X, Y, Z);

        X = 8'd5;   Y = 8'd3;   #10;
        X = -8'd7;  Y = 8'd4;   #10;
        X = 8'd12;  Y = -8'd6;  #10;
        X = -8'd10; Y = -8'd10; #10;
        X = 8'd0;   Y = 8'd25;  #10;
        X = 8'd127; Y = 8'd2;   #10;
        X = 8'd1;   Y = -8'd128;#10;
        X = -8'd1;  Y = -8'd128;#10;

        #20;
        $finish;
    end

endmodule
