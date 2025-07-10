`timescale 1ns / 1ps

module synch_fifo_32x8#(
parameter fifo_w = 32,
parameter fifo_d = 8
)(
input clk,rst,
input push_en,pop_en,
input [fifo_w-1 : 0] fifo_din,
output reg [fifo_w-1 : 0] fifo_dout,
output full, empty
    );
    reg [fifo_w-1:0] fifo [fifo_d-1 : 0];
    reg [$clog2(fifo_d)-1 : 0] fifo_r_ptr, fifo_w_ptr;
    
    //pop
    always@(posedge clk) begin
        if(rst)begin
            fifo_r_ptr <= 1'b0;
            fifo_dout <= 32'h00000000;
        end
        else if (pop_en && !empty) begin
             fifo_dout <= fifo[fifo_r_ptr];
             fifo_r_ptr = fifo_r_ptr +1;
        end
    end
    
    
    //push
    always@(posedge clk) begin
        if (rst)begin
            fifo_w_ptr <= 1'b0;
        end
        else if( push_en && !full ) begin
             fifo[fifo_w_ptr] <= fifo_din;
             fifo_w_ptr = fifo_w_ptr + 1;
        end
    end
    
    assign full = ((fifo_w_ptr + 1'b1) == fifo_r_ptr);
    assign empty = (fifo_w_ptr == fifo_r_ptr);

endmodule
