`timescale 1ns / 1ps

module tb_4b_full_adder;
    reg [3:0] a, b;
    reg cin;
    wire cout;
    wire [3:0] s;

    4b_full_adder_behavioral uut (
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .s(s)
    );

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, tb_full_adder_behavioral); 

        $monitor("Time = %0t | a = %b | b = %b | cin = %b | sum = %b | cout = %b", 
                 $time, a, b, cin, s, cout);

        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        a = 4'b0011; b = 4'b0101; cin = 0; #10;
        a = 4'b0111; b = 4'b1001; cin = 1; #10;
        a = 4'b1010; b = 4'b1111; cin = 1; #10;
        a = 4'b1111; b = 4'b1111; cin = 1; #10;

        $finish;
    end
endmodule
