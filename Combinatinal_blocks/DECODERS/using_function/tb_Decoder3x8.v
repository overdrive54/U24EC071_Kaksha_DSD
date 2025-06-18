`timescale 1ns / 1ps
module tb_Decoder3x8;

    reg [2:0] sel;
    wire [7:0] out;

    Decoder3x8 uut (.sel(sel), .out(out));

    initial begin
        $monitor("Time=%0t | Selector=%b | Output=%b", $time, sel, out);

        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;
        
        $finish;
    end
endmodule
