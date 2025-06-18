module Demux1x16 (
    input in,
    input [3:0] sel,
    output reg [15:0] out
);
    task demux;
        input in;
        input [3:0] sel;
        output reg [15:0] out;
        begin
            out = 16'b0000000000000001 << sel;
        end
    endtask
    
    always @(*) begin
        demux(in, sel, out);
    end
endmodule
