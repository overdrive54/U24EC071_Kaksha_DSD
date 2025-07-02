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

module siso_8_bit(
input serial_in,
input clk,
input rst_n,
output serial_out
    );
    wire [7:0] q;
    wire [7:0] d;

    assign serial_out = q[0];

    genvar j;
    generate
        for (j = 0; j < 8; j = j + 1) begin : gen_DFF
            if (j == 7) begin
                assign d[j] = serial_in;
            end else begin
                assign d[j] = q[j+1];
            end

            D_ff dff_inst (
                .clk(clk),
                .D(d[j]),
                .r(rst_n),
                .q(q[j]),
                .qbar()
            );
        end
    endgenerate
endmodule
