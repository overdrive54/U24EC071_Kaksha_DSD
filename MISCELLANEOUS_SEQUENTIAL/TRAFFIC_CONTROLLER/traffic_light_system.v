`timescale 1s / 100ms

module countdown (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire [6:0] preset_value,
    output reg  [6:0] count_out,
    output wire done
);
    
    reg start_prev;
    wire start_edge;
    
    assign start_edge = start & ~start_prev;
    assign done = (count_out == 0);  // done = 0 when finished (as per spec)
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_out <= 7'd0;
            start_prev <= 1'b0;
        end
        else begin
            start_prev <= start;
            
            if (start_edge)
                count_out <= preset_value;
            else if (count_out != 0)
                count_out <= count_out - 1'b1;
        end
    end
    
endmodule


module road_register (
    input  wire       clk,
    input  wire       rst_n,
    
    input  wire       pedestrian_request,
    input  wire       clear_pedestrian,
    
    input  wire       set_count_state,
    input  wire       clear_count_state,
    
    input  wire [6:0] count_value_in,
    input  wire       update_count,
    
    output reg        pedestrian_flag,     // Bit 8
    output reg        count_state,         // Bit 7  
    output reg [6:0]  count_value,         // Bits 6-0
    output wire [8:0] road_reg             // Complete 9-bit register
);

    assign road_reg = {pedestrian_flag, count_state, count_value};
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pedestrian_flag <= 1'b0;
        else if (clear_pedestrian)
            pedestrian_flag <= 1'b0;
        else if (pedestrian_request)
            pedestrian_flag <= 1'b1;
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count_state <= 1'b0;
        else if (clear_count_state)
            count_state <= 1'b0;
        else if (set_count_state)
            count_state <= 1'b1;
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count_value <= 7'd0;
        else if (update_count)
            count_value <= count_value_in;
    end

endmodule


module traffic_light_controller (
    input  wire clk,
    input  wire rst_n,
    
    input  wire ped_request_A,
    input  wire ped_request_B,
    
    output reg  green_A,
    output reg  yellow_A,
    output reg  red_A,
    
    output reg  green_B,
    output reg  yellow_B,
    output reg  red_B,
    
    output wire [2:0] current_state,
    output wire [6:0] time_remaining
);

    localparam [2:0] 
        ROAD_A_GREEN  = 3'b000,
        ROAD_A_YELLOW = 3'b001,
        ROAD_B_GREEN  = 3'b010,
        ROAD_B_YELLOW = 3'b011,
        IDLE          = 3'b100;
    
    reg [2:0] state, next_state;
    reg countdown_start;
    reg [6:0] countdown_preset;
    wire countdown_done;
    wire [6:0] countdown_value;
    
    wire [8:0] road_A_reg, road_B_reg;
    wire ped_flag_A, ped_flag_B;
    wire count_state_A, count_state_B;
    reg clear_ped_A, clear_ped_B;
    reg set_count_A, clear_count_A;
    reg set_count_B, clear_count_B;
    reg update_count_A, update_count_B;
    
    assign current_state = state;
    assign time_remaining = countdown_value;
    
    countdown timer (
        .clk(clk),
        .rst_n(rst_n),
        .start(countdown_start),
        .preset_value(countdown_preset),
        .count_out(countdown_value),
        .done(countdown_done)
    );
    
    // Instantiate road registers
    road_register road_A (
        .clk(clk),
        .rst_n(rst_n),
        .pedestrian_request(ped_request_A),
        .clear_pedestrian(clear_ped_A),
        .set_count_state(set_count_A),
        .clear_count_state(clear_count_A),
        .count_value_in(countdown_value),
        .update_count(update_count_A),
        .pedestrian_flag(ped_flag_A),
        .count_state(count_state_A),
        .count_value(),
        .road_reg(road_A_reg)
    );
    
    road_register road_B (
        .clk(clk),
        .rst_n(rst_n),
        .pedestrian_request(ped_request_B),
        .clear_pedestrian(clear_ped_B),
        .set_count_state(set_count_B),
        .clear_count_state(clear_count_B),
        .count_value_in(countdown_value),
        .update_count(update_count_B),
        .pedestrian_flag(ped_flag_B),
        .count_state(count_state_B),
        .count_value(),
        .road_reg(road_B_reg)
    );
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= ROAD_A_GREEN;
        else
            state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        countdown_start = 1'b0;
        countdown_preset = 7'd0;
        
        clear_ped_A = 1'b0;
        clear_ped_B = 1'b0;
        set_count_A = 1'b0;
        clear_count_A = 1'b0;
        set_count_B = 1'b0;
        clear_count_B = 1'b0;
        update_count_A = 1'b0;
        update_count_B = 1'b0;
        
        case (state)
            ROAD_A_GREEN: begin
                if (ped_flag_A | countdown_done) begin
                    next_state = ROAD_A_YELLOW;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd30; // 30 seconds yellow
                    clear_count_A = 1'b1;
                    set_count_A = 1'b1;
                end
                else if (!countdown_done && countdown_value == 7'd1) begin
                    next_state = ROAD_A_YELLOW;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd30; // 30 seconds yellow
                end
                else if (countdown_done) begin
                    countdown_start = 1'b1;
                    countdown_preset = 7'd120; // 120 seconds green
                    set_count_A = 1'b1;
                end
            end
            
            ROAD_A_YELLOW: begin
                if (!countdown_done && countdown_value == 7'd1) begin
                    next_state = ROAD_B_GREEN;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd120; // 120 seconds green
                    clear_count_A = 1'b1;
                    set_count_B = 1'b1;
                    clear_ped_B = 1'b1; // Clear pedestrian request as it's being served
                end
            end
            
            ROAD_B_GREEN: begin
                if (ped_flag_B | countdown_done) begin
                    next_state = ROAD_B_YELLOW;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd30; // 30 seconds yellow
                    clear_count_B = 1'b1;
                    set_count_B = 1'b1;
                end
                else if (!countdown_done && countdown_value == 7'd1) begin
                    next_state = ROAD_B_YELLOW;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd30; // 30 seconds yellow
                end
                else if (countdown_done) begin
                    countdown_start = 1'b1;
                    countdown_preset = 7'd120; // 120 seconds green
                    set_count_B = 1'b1;
                end
            end
            
            ROAD_B_YELLOW: begin
                if (!countdown_done && countdown_value == 7'd1) begin
                    next_state = ROAD_A_GREEN;
                    countdown_start = 1'b1;
                    countdown_preset = 7'd120; // 120 seconds green
                    clear_count_B = 1'b1;
                    set_count_A = 1'b1;
                    clear_ped_A = 1'b1; // Clear pedestrian request as it's being served
                end
            end
            
            default: begin
                next_state = ROAD_A_GREEN;
            end
        endcase
    end
    
    always @(*) begin
        green_A = 1'b0;
        yellow_A = 1'b0;
        red_A = 1'b0;
        green_B = 1'b0;
        yellow_B = 1'b0;
        red_B = 1'b0;
        
        case (state)
            ROAD_A_GREEN: begin
                green_A = 1'b1;
                red_B = 1'b1;
            end
            
            ROAD_A_YELLOW: begin
                yellow_A = 1'b1;
                red_B = 1'b1;
            end
            
            ROAD_B_GREEN: begin
                green_B = 1'b1;
                red_A = 1'b1;
            end
            
            ROAD_B_YELLOW: begin
                yellow_B = 1'b1;
                red_A = 1'b1;
            end
            
            default: begin
                red_A = 1'b1;
                red_B = 1'b1;
            end
        endcase
    end

endmodule


module traffic_light_system (
    input  wire clk,           // 1 Hz system clock
    input  wire rst_n,         // Active low reset
    
    input  wire ped_button_A,  // Pedestrian crossing request for Road A
    input  wire ped_button_B,  // Pedestrian crossing request for Road B
    
    output wire red_A,         // Road A red light
    output wire yellow_A,      // Road A yellow light  
    output wire green_A,       // Road A green light
    
    output wire red_B,         // Road B red light
    output wire yellow_B,      // Road B yellow light
    output wire green_B,       // Road B green light
    
    output wire [2:0] system_state,    // Current state of traffic controller
    output wire [6:0] countdown,       // Current countdown value
    output wire [8:0] road_A_status,   // Road A register status
    output wire [8:0] road_B_status    // Road B register status
);

    wire [2:0] current_state;
    wire [6:0] time_remaining;
    
    assign system_state = current_state;
    assign countdown = time_remaining;
    
    traffic_light_controller main_controller (
        .clk(clk),
        .rst_n(rst_n),
        
        .ped_request_A(ped_button_A),
        .ped_request_B(ped_button_B),
        
        .green_A(green_A),
        .yellow_A(yellow_A),
        .red_A(red_A),
        .green_B(green_B),
        .yellow_B(yellow_B),
        .red_B(red_B),
        
        .current_state(current_state),
        .time_remaining(time_remaining)
    );
    
    assign road_A_status = 9'b0; // Placeholder - connect to actual road register if needed
    assign road_B_status = 9'b0; // Placeholder - connect to actual road register if needed

endmodule
