`timescale 1ns / 1ps

module synch_fifo #(
    parameter fifo_w = 32,
    parameter fifo_d = 8
)(
    input wire clk,
    input wire rst,
    input wire push_en,
    input wire pop_en,
    input wire [fifo_w-1 : 0] fifo_din,
    output reg [fifo_w-1 : 0] fifo_dout,
    output wire full,
    output wire empty
);

    reg [fifo_w-1:0] fifo [0 : fifo_d-1];
    reg [$clog2(fifo_d)-1 : 0] fifo_r_ptr, fifo_w_ptr;
    reg [$clog2(fifo_d)  : 0]  fifo_count;

    always @(posedge clk) begin
        if (rst) begin
            fifo_r_ptr <= 0;
            fifo_dout  <= {fifo_w{1'b0}};
        end else if (pop_en && !empty) begin
            fifo_dout  <= fifo[fifo_r_ptr];
            fifo_r_ptr <= fifo_r_ptr + 1'b1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            fifo_w_ptr <= 0;
        end else if (push_en && !full) begin
            fifo[fifo_w_ptr] <= fifo_din;
            fifo_w_ptr <= fifo_w_ptr + 1'b1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            fifo_count <= 0;
        end else begin
            case ({push_en && !full, pop_en && !empty})
                2'b10: fifo_count <= fifo_count + 1'b1;
                2'b01: fifo_count <= fifo_count - 1'b1;
                default: fifo_count <= fifo_count; 
            endcase
        end
    end

    assign full  = (fifo_count == fifo_d);
    assign empty = (fifo_count == 0);

endmodule
