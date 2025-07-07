`timescale 1ns / 1ps

module elevator_top (
    input clk,
    input rst_n,
    input [2:0] external_calls,
    input [2:0] internal_requests,
    output [6:0] seg_a_to_g,
    output [1:0] arrow,
    output [2:0] current_floor,
    output [1:0] direction,
    output elevator_moving
);

    wire [2:0] count_out;
    wire [2:0] req_floor;
    wire start;
    wire [2:0] floor_state;
    wire [1:0] dir_internal;
    
    floor_request_manager req_manager (
        .clk(clk),
        .rst_n(rst_n),
        .external_calls(external_calls),
        .internal_requests(internal_requests),
        .current_floor(floor_state),
        .req_floor(req_floor),
        .start(start)
    );
    
    lift_count counter (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .req_floor(req_floor),
        .count_out(count_out)
    );
    
    register reg_module (
        .clk(clk),
        .rst_n(rst_n),
        .count_out(count_out),
        .start(start),
        .floor_state(floor_state),
        .direction(dir_internal)
    );
    
    seven_segment_display display (
        .clk(clk),
        .rst_n(rst_n),
        .floor_state(floor_state),
        .direction(dir_internal),
        .seg_a_to_g(seg_a_to_g),
        .arrow(arrow)
    );
    
    assign current_floor = floor_state;
    assign direction = dir_internal;
    assign elevator_moving = start;
    
endmodule
