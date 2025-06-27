`timescale 1ns / 1ps

module tb_Barrel_shift_sel;
reg [4:0] shift_amnt;
reg L_R;// L:0  R:1
reg [31:0] shift_str;
wire [31:0] shifted_str;

Barrel_shift_sel uut(
.shift_amnt(shift_amnt),
.L_R(L_R),
.shift_str(shift_str),
.shifted_str(shifted_str)
);

initial begin
$dumpfile("shift_check.vcd");
$dumpvars(0,uut);

shift_amnt=5'b00100;
L_R = 1'b0;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00010;
L_R=1'b1;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00011;
L_R=1'b1;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00101;
L_R=1'b0;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b01010;
L_R=1'b1;
shift_str=32'b11010110100101110101100101110001;
#20
$finish;
end
endmodule
