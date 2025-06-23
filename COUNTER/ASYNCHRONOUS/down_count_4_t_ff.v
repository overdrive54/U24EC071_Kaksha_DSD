`timescale 1ns / 1ps

module T_ff(
    input clk, T, r,
    output reg q,
    output qbar
);

always @(posedge clk) begin
    if (r)
        q <= 0;
    else if (T)
        q <= ~q;
end

assign qbar = ~q;

endmodule

module down_count_4_t_ff(
input clk,
output [3 : 0] q,
output [3 : 0] qbar
    );
    T_ff t0 (.clk(clk), .T(1), .r(0), .q(q[0]));
    T_ff t1 (.clk(q[0]), .T(1), .r(0), .q(q[1]));
    T_ff t2 (.clk(q[1]), .T(1), .r(0), .q(q[2]));
    T_ff t3 (.clk(q[2]), .T(1), .r(0), .q(q[3]));
    
endmodule
