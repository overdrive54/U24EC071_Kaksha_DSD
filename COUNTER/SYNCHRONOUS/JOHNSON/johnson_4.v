`timescale 1ns / 1ps

module D_ff(
    input clk, D, r,
    output reg q,
    output qbar
);

always @(posedge clk) begin
    if (r)
        q <= 0;
    else 
        q <= D;
end

assign qbar = ~q;

endmodule

module johnson_4(
input clk,
output [3 : 0] q,
output [3 : 0] qbar
    );
    D_ff d0 (.clk(clk), .D(q[2]), .r(0), .q(q[3]), .qbar(qbar[3]));
    D_ff d1 (.clk(clk), .D(q[1]), .r(0), .q(q[2]), .qbar(qbar[2]));
    D_ff d2 (.clk(clk), .D(q[0]), .r(0), .q(q[1]), .qbar(qbar[1]));
    D_ff d3 (.clk(clk), .D(qbar[3]), .r(0), .q(q[0]), .qbar(qbar[0]));
    
endmodule
