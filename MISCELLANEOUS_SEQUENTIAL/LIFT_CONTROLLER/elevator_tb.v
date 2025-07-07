`timescale 1ns / 1ps

module elevator_tb;
    reg clk, rst_n;
    reg [2:0] external_calls, internal_requests;
    wire [6:0] seg_a_to_g;
    wire [1:0] arrow;
    wire [2:0] current_floor;
    wire [1:0] direction;
    wire elevator_moving;
    
    elevator_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .external_calls(external_calls),
        .internal_requests(internal_requests),
        .seg_a_to_g(seg_a_to_g),
        .arrow(arrow),
        .current_floor(current_floor),
        .direction(direction),
        .elevator_moving(elevator_moving)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0;
        external_calls = 0;
        internal_requests = 0;
        
        #10 rst_n = 1;
        
        #20 external_calls[2] = 1;
        #20 external_calls[2] = 0;
        
        #20 internal_requests[0] = 1;
        #20 internal_requests[0] = 0;
        
        #20 external_calls[1] = 1;
        #20 internal_requests[2] = 1;
        #20 external_calls = 0;
        #20 internal_requests = 0;
        
        #200 $finish;
    end
    
endmodule
