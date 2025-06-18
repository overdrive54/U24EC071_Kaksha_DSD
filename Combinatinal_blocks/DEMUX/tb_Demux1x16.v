`timescale 1ns / 1ps
module tb_Demux1x16;

    reg in;
    reg [3:0] sel;
    wire [15:0] out;

    Demux1x16 uut (.in(in), .sel(sel), .out(out));

    initial begin
        $monitor("Time=%0t | Selector=%b | Output=%b", $time, sel, out);

        in = 1'b1;
        
        sel = 4'b0000; #10;
        sel = 4'b0001; #10;
        sel = 4'b0010; #10;
        sel = 4'b0011; #10;
        sel = 4'b0100; #10;
        sel = 4'b0101; #10;
        sel = 4'b0110; #10;
        sel = 4'b0111; #10;
        
        $finish;
    end
endmodule
