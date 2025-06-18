module Mux16x1 (
    input [15:0] in,
    input [3:0] sel,
    output reg out
);
    task mux;
        input [15:0] in;
        input [3:0] sel;
        output reg out;
        begin
            out = in[sel];
        end
    endtask
    
    always @(*) begin
        mux(in, sel, out);
    end
endmodule
