module Decoder3x8 (
    input [2:0] sel,
    output reg [7:0] out
);
    function [7:0] decode;
        input [2:0] sel;
        begin
            decode = 8'b00000001 << sel;
        end
    endfunction
    
    always @(*) begin
        out = decode(sel);
    end
endmodule
