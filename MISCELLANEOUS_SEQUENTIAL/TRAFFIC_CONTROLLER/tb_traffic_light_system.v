`timescale 1s / 100ms

module tb_traffic_light_system;

    reg clk;
    reg rst_n;
    reg ped_button_A;
    reg ped_button_B;
    
    wire red_A, yellow_A, green_A;
    wire red_B, yellow_B, green_B;
    wire [2:0] system_state;
    wire [6:0] countdown;
    wire [8:0] road_A_status;
    wire [8:0] road_B_status;
    
    reg [8*20:1] state_name;
    always @(*) begin
        case (system_state)
            3'b000: state_name = "ROAD_A_GREEN       ";
            3'b001: state_name = "ROAD_A_YELLOW      ";
            3'b010: state_name = "ROAD_B_GREEN       ";
            3'b011: state_name = "ROAD_B_YELLOW      ";
            default: state_name = "UNKNOWN           ";
        endcase
    end
    
    traffic_light_system dut (
        .clk(clk),
        .rst_n(rst_n),
        .ped_button_A(ped_button_A),
        .ped_button_B(ped_button_B),
        .red_A(red_A),
        .yellow_A(yellow_A), 
        .green_A(green_A),
        .red_B(red_B),
        .yellow_B(yellow_B),
        .green_B(green_B),
        .system_state(system_state),
        .countdown(countdown),
        .road_A_status(road_A_status),
        .road_B_status(road_B_status)
    );
    
    initial begin
        clk = 0;
        forever #0.5 clk = ~clk;
    end
        
    initial begin
       
        rst_n = 0;
        ped_button_A = 0;
        ped_button_B = 0;
        
        #2 rst_n = 1;

        #300;
        
        wait (green_B && countdown > 60);  // Wait until Road A is green with time remaining
        #30
        ped_button_B = 1;
        #4 ped_button_B = 0;  // Button press pulse
        
        #200;
               
        wait (yellow_A);
        #20
        ped_button_A = 1;
        #4 ped_button_A = 0;
        
        #200;
                
        wait (green_B && countdown > 90);  // Wait until Road B is green
        repeat (5) begin
            ped_button_B = 1;
            #4 ped_button_B = 0;
            #4;
        end
        
        wait (green_A && countdown > 60);
        #30
        ped_button_A = 1;
        #4 ped_button_A = 0;  // Button press pulse

        #150;

        #10;
        $finish;
    end  
    
    initial begin
        $dumpfile("traffic_light_system.vcd");
        $dumpvars(0, tb_traffic_light_system);
    end

endmodule
