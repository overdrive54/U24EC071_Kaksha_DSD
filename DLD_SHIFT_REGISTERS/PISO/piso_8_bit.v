`timescale 1ns / 1ps

module mux2to1 (
    input  sel,
    input  in0,
    input  in1,
    output reg out
);
    always @(*) begin
        if (sel)
            out = in1;
        else
            out = in0;
    end
endmodule

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

module piso_8_bit(
input [7:0] parallel_in,
input clk,
input rst_n,
input sel_p_s, // 0:parallel in , 1:serial out 
output serial_out
    );
    wire [7:0] q;
    wire [7:0] D;
    assign serial_out=q[0];
    
    genvar j;
    generate
    for (j=0; j<8; j= j+1) begin: gen_D_ff
    D_ff d_ff (
    .clk(clk),
    .D(D[j]),
    .r(rst_n),
    .q(q[j]),
    .qbar()
    );
    end
    endgenerate
    
    generate
    for (j = 0; j < 8; j = j + 1) begin : gen_mux
    mux2to1 mux_i (
    .sel (sel_p_s),
    .in0 (parallel_in[j]),
    .in1 (j == 7 ? 1'b0 : q[j+1]),
    .out (D[j])
            );
    end
    endgenerate
endmodule
