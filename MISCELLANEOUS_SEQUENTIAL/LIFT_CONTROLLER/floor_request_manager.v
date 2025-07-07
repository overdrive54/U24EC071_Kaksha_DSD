`timescale 1ns / 1ps

module floor_request_manager (
    input clk,
    input rst_n,
    input [2:0] external_calls,
    input [2:0] internal_requests,
    input [2:0] current_floor,
    output reg [2:0] req_floor,
    output reg start
);

    reg [2:0] pending_requests;
    reg elevator_busy;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            req_floor <= 3'b000;
            start <= 1'b0;
            pending_requests <= 3'b000;
            elevator_busy <= 1'b0;
        end else begin
            pending_requests <= external_calls | internal_requests;
            
            if (|pending_requests && !elevator_busy) begin
                req_floor <= pending_requests;
                start <= 1'b1;
                elevator_busy <= 1'b1;
            end
            
            if (elevator_busy) begin
                if (|(current_floor & req_floor)) begin
                    pending_requests <= pending_requests & ~current_floor;
                    
                    if (!(|(pending_requests & ~current_floor))) begin
                        start <= 1'b0;
                        elevator_busy <= 1'b0;
                        req_floor <= 3'b000;
                    end else begin
                        req_floor <= pending_requests & ~current_floor;
                    end
                end
            end
        end
    end
endmodule
