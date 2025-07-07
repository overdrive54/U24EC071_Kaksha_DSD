`timescale 1ns / 1ps
module mux4to1 (
    input  [1:0] sel,
    input        in0, in1, in2, in3,
    output reg   out
);
    always @* begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 1'b0;
        endcase
    end
endmodule

module D_ff (
    input  clk,
    input  D,
    input  r,
    output reg q,
    output      qbar
);
    always @(posedge clk or negedge r) begin
        if (!r)
            q <= 1'b0;
        else
            q <= D;
    end
    assign qbar = ~q;
endmodule

module uni_shift_8_bit (
    input  serial_in_L,
    input  serial_in_R,
    input  [7:0] parallel_in,
    input  [1:0] sel,
    input  clk,
    input  rst_n,
    output serial_out_L,
    output serial_out_R,
    output [7:0] q
);
    wire [7:0] d_in;

    assign serial_out_L = q[7];
    assign serial_out_R = q[0];

    genvar j;
    generate
        for (j = 0; j < 8; j = j + 1) begin : gen_dff
            D_ff u_ff (
                .clk (clk),
                .D   (d_in[j]),
                .r   (rst_n),
                .q   (q[j])
            );
        end
    endgenerate

    generate
        for (j = 0; j < 8; j = j + 1) begin : gen_mux
            mux4to1 u_mux (
                .sel (sel),
                .in0 (q[j]),
                .in1 ( (j == 7) ? serial_in_R : q[j+1] ),
                .in2 ( (j == 0) ? serial_in_L : q[j-1] ),
                .in3 (parallel_in[j]),
                .out (d_in[j])
            );
        end
    endgenerate
endmodule
