`timescale 1ns / 1ps

module tb_LUT_RAM_64_Kb;

    parameter WIDTH = 32;
    parameter DEPTH = 2048;
    
    reg clk;
    reg reset;
    reg write_read_en;
    reg [$clog2(DEPTH)-1:0] address;
    reg [WIDTH-1:0] din;
    wire [WIDTH-1:0] dout;
    
    LUT_RAM_64_Kb uut (
        .clk(clk),
        .reset(reset),
        .write_read_en(write_read_en),
        .address(address),
        .din(din),
        .dout(dout)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
    
    reset = 1;
    write_read_en = 0;
    address = 0;
    din = 0;

    @(posedge clk);
    reset = 0;
    
    @(posedge clk);
    address = 11'h0;
    din = 32'hBABABABA;
    
    @(posedge clk);
    address = 11'h20;
    din = 32'hCECECECE;
    
    @(posedge clk);
    address = 11'h100;
    din = 32'hBE756845;
    
    @(posedge clk);
    address = 11'h80;
    din = 32'h12345678;
    
    write_read_en = 1;
    @(posedge clk);
    @(posedge clk);
    address = 11'h0;
    
    @(posedge clk);
    address = 11'h300;
    din = 32'h10021003;
    
    @(posedge clk);
    address = 11'h20;
    
    @(posedge clk);
    address = 11'h100;
    
    @(posedge clk);
    address = 11'h80;
    
    @(posedge clk);
    address = 11'h300;
    
    write_read_en = 0;
    @(posedge clk);
    @(posedge clk);
    address = 11'h310;
    din = 32'h80030056;
    
    write_read_en = 1;
    @(posedge clk);
    @(posedge clk);
    address = 11'h710;

    @(posedge clk);
    reset = 1;
    
    @(posedge clk);
    reset = 0;
    
    @(posedge clk);
    address = 11'h300;
    din = 32'h10021003;
    
    write_read_en = 0;
    @(posedge clk);
    @(posedge clk);
    address = 11'h700;
    din = 32'h10021003;
    
    write_read_en = 1;
    @(posedge clk);
    @(posedge clk);
    address = 11'h300;
    
    @(posedge clk);
    address = 11'h700;
    
    @(posedge clk);

    $finish;
    
    end
endmodule
