`timescale 1ns / 1ps

module register (
    input clk,
    input rst_n,
    input [2:0] count_out,
    input start,
    input [2:0] req_floor,
    output reg [2:0] floor_state,
    output reg [1:0] direction
);
    
    reg [2:0] prev_floor;
    
    always @(*) begin
        if (!rst_n) begin
            floor_state <= 3'b001;
            direction <= 2'b00;
            prev_floor <= 3'b001;
        end else begin
            floor_state <= count_out;
            
            if (start && (count_out != prev_floor)) begin
                case ({prev_floor, count_out})
                    {3'b001, 3'b010}: direction <= 2'b01;
                    {3'b010, 3'b100}: direction <= 2'b01;
                    {3'b100, 3'b010}: direction <= 2'b10;
                    {3'b010, 3'b001}: direction <= 2'b10;
                    default: direction <= 2'b00;
                endcase
                end
            else if (!start) begin
                direction <= 2'b00;
            end
            
            prev_floor <= count_out;
        end
    end
endmodule
