`timescale 1ns / 1ps

module write (
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire [3:0] write_add,
    input wire [15:0] write_val,
    output reg [255:0] reg_flat
);

always @(posedge clk) begin
    if (reset) begin
        reg_flat <= 256'b0;
    end
    else if (write_enable) begin
        reg_flat[write_add*16 +: 16] <= write_val;
    end
end

endmodule

module read (
    input wire [3:0] read_1_add,
    input wire [3:0] read_2_add,
    input wire [255:0] reg_flat,
    output wire [15:0] read_1_val,
    output wire [15:0] read_2_val
);

assign read_1_val = reg_flat[read_1_add*16 +: 16];
assign read_2_val = reg_flat[read_2_add*16 +: 16];

endmodule

module register_16x16(
    input wire clk,
    input wire reset,
    input wire write_read_enable,    // 0: write, 1: read
    input wire [3:0] write_add,      // write address
    input wire [15:0] write_val,     // write value
    input wire [3:0] read_1_add,     // read address 1
    input wire [3:0] read_2_add,     // read address 2
    output wire [15:0] read_1_val,   // read value 1
    output wire [15:0] read_2_val    // read value 2
);

wire [255:0] registers_flat;

wire write_en = ~write_read_enable;

write write_inst (
    .clk(clk),
    .reset(reset),
    .write_enable(write_en),
    .write_add(write_add),
    .write_val(write_val),
    .reg_flat(registers_flat)
);

read read_inst (
    .read_1_add(read_1_add),
    .read_2_add(read_2_add),
    .reg_flat(registers_flat),
    .read_1_val(read_1_val),
    .read_2_val(read_2_val)
);

endmodule
