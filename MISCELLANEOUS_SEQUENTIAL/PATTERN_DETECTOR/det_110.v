`timescale 1ns / 1ps

module det_110 (
    input  wire clk,
    input  wire rstn,
    input  wire in,
    output wire out
);
    localparam IDLE = 2'd0,
               S1   = 2'd1,
               S11  = 2'd2;

    reg [1:0] cur_state, next_state;

    always @(*) begin
        case (cur_state)
            IDLE: next_state =  in ? S1  : IDLE;
            S1:   next_state =  in ? S11 : IDLE;
            S11:  next_state =  in ? S11 : IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (!rstn)
            cur_state <= IDLE;
        else
            cur_state <= next_state;
    end

    assign out = (cur_state == S11) && (in == 1'b0);

endmodule
