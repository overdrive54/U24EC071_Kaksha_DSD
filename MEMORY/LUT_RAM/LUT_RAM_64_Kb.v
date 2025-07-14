`timescale 1ns / 1ps

module LUT_RAM_64_Kb#(
    parameter WIDTH = 32,
    parameter DEPTH = 2048
)(
    input wire clk,
    input wire reset,
    input wire write_read_en,
    input wire [$clog2(DEPTH)-1:0] address,
    input wire [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout
);

reg [(WIDTH*DEPTH)-1:0] registers_flat;

wire write_en = ~write_read_en;
wire read_en = write_read_en;

always @(posedge clk) begin
    if (reset)
        registers_flat <= 65536'b0;
    else if (write_en)
        registers_flat[address*32 +: 32] <= din;
end

always @(posedge clk & read_en)begin
    dout <= registers_flat[address*32 +: 32];
end

endmodule
