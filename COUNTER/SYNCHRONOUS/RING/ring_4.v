`timescale 1ns / 1ps

module ring_4(
    input clk,
    input reset,
    output reg [3:0] q,
    output wire [3:0] qbar
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b1000;
            end
        else
            q <= {q[0], q[3:1]};
    end
        assign qbar = ~q;

endmodule
