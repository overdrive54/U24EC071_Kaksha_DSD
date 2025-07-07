`timescale 1ns / 1ps

module lift_count(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [2:0] req_floor,
    output wire [2:0] count_out
);

    localparam [2:0]
        GROUND = 3'b001,
        ONE    = 3'b010,
        TWO    = 3'b100;
    
    reg [2:0] present_state;
    reg [2:0] next_state;
    reg dir;
    
    assign count_out = present_state;
    
    always @* begin
        next_state = present_state;
        
        case (present_state)
            GROUND: begin
                if (req_floor[1] || req_floor[2]) begin
                    next_state = ONE;
                    dir = 1;
                end
            end
            
            ONE: begin
                if (req_floor[0]) begin
                    next_state = GROUND;
                    dir = 0;
                end
                else if (req_floor[2]) begin
                    next_state = TWO;
                    dir = 1;
                end
            end
            
            TWO: begin
                if (req_floor[1] || req_floor[0]) begin
                    next_state = ONE;
                    dir = 0;
                end
            end
            
            default: begin
                next_state = GROUND;
                dir = 0;
            end
        endcase
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            present_state <= GROUND;
            dir <= 0;
        end
        else if (start) begin
            present_state <= next_state;
        end
    end
    
endmodule
