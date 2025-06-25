`timescale 1ns / 1ps

module D_ff (
    input  wire clk,
    input  wire rst_n,
    input  wire d,
    output reg  q,
    output wire qbar
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

    assign qbar = ~q;
endmodule

module button_press (
    input  wire clk,
    input  wire button,
    output wire blink,
    output wire [1:0] q,
    output wire [1:0] qbar
);
    wire cur,  prev;
    wire cur_n, prev_n;

    D_ff ff0 (
        .clk   (clk),
        .rst_n (1'b1),
        .d     (button),
        .q     (cur),
        .qbar  (cur_n)
    );

    D_ff ff1 (
        .clk   (clk),
        .rst_n (1'b1),
        .d     (cur),
        .q     (prev),
        .qbar  (prev_n)
    );

    assign q     = {prev, cur};
    assign qbar  = {prev_n, cur_n};

    assign blink = cur & ~prev;

endmodule
