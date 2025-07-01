`timescale 1ns / 1ps

module tb_register_16x16();

    reg clk;
    reg reset;
    reg write_read_enable;
    reg [3:0] write_add;
    reg [15:0] write_val;
    reg [3:0] read_1_add;
    reg [3:0] read_2_add;
    wire [15:0] read_1_val;
    wire [15:0] read_2_val;

    register_16x16 uut (
        .clk(clk),
        .reset(reset),
        .write_read_enable(write_read_enable),
        .write_add(write_add),
        .write_val(write_val),
        .read_1_add(read_1_add),
        .read_2_add(read_2_add),
        .read_1_val(read_1_val),
        .read_2_val(read_2_val)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        reset = 1;
        write_read_enable = 0;
        write_add = 0;
        write_val = 0;
        read_1_add = 0;
        read_2_add = 0;
        
        @(posedge clk);
        @(posedge clk);
        reset = 0;
        
        write_read_enable = 0;
        
        @(posedge clk);
        write_add = 4'h0; write_val = 16'hAAAA;
        @(posedge clk);
        write_add = 4'h1; write_val = 16'h5555;
        @(posedge clk);
        write_add = 4'h2; write_val = 16'h1234;
        @(posedge clk);
        write_add = 4'hF; write_val = 16'hDEAD;
        @(posedge clk);
        write_add = 4'h8; write_val = 16'hBEEF;


        write_read_enable = 1;
        @(posedge clk);
        read_1_add = 4'h0; read_2_add = 4'h1;
        @(posedge clk);
        read_1_add = 4'h2; read_2_add = 4'hF;
        @(posedge clk);
        read_1_add = 4'h8; read_2_add = 4'h0;
        @(posedge clk);
        read_1_add = 4'h1; read_2_add = 4'h1;
        @(posedge clk);
        read_1_add = 4'hF; read_2_add = 4'hF;
        @(posedge clk);
        read_1_add = 4'h3; read_2_add = 4'h7;
        @(posedge clk);
        read_1_add = 4'hA; read_2_add = 4'hC;
        
        write_read_enable = 0;
        @(posedge clk);
        write_add = 4'h5; write_val = 16'h9999;
        
        write_read_enable = 1;
        @(posedge clk);
        read_1_add = 4'h5; read_2_add = 4'h5;
        
        @(posedge clk);
        reset = 1;
        @(posedge clk);
        @(posedge clk);
        reset = 0;

        @(posedge clk);
        read_1_add = 4'h0; read_2_add = 4'h1;
        @(posedge clk);
        read_1_add = 4'hF; read_2_add = 4'h8;
        
        write_read_enable = 0;
        repeat(16) begin
            @(posedge clk);
            write_val = write_add + 16'h1000;
            write_add = write_add + 1;
        end

        write_read_enable = 1;
        read_1_add = 0;
        read_2_add = 8;
        
        repeat(8) begin
            @(posedge clk);
            read_1_add = read_1_add + 1;
            read_2_add = read_2_add + 1;
        end
        #50;
        $finish;
    end
endmodule
