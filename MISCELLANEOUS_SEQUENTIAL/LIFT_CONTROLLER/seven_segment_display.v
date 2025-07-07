`timescale 1ns / 1ps

module seven_segment_display (
    input clk,
    input rst_n,
    input [2:0] floor_state,
    input [1:0] direction,
    output reg [6:0] seg_a_to_g,
    output reg [1:0] arrow
);

    always @(*) begin
        if (!rst_n) begin
            seg_a_to_g <= 7'b1111110;
            arrow <= 2'b00;
        end else begin
            case (floor_state)
                3'b001: seg_a_to_g <= 7'b1111110;
                3'b010: seg_a_to_g <= 7'b0110000;
                3'b100: seg_a_to_g <= 7'b1101101;
                default: seg_a_to_g <= 7'b0000000;
            endcase
            
            arrow <= direction;
        end
    end
endmodule
