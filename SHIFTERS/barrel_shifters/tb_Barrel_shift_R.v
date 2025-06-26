`timescale 1ns / 1ps

module tb_Barrel_shift_R;
reg [31:0] shift_str;
reg [4:0] shift_amnt;
wire [31:0] shifted_str;

Barrel_shift_R uut(
.shift_str(shift_str),
.shift_amnt(shift_amnt),
.shifted_str(shifted_str)
);

initial begin
$dumpfile("shift_check.vcd");
$dumpvars(0,uut);

shift_amnt=5'b00100;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00010;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00011;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b00101;
shift_str=32'b11010110100101110101100101110001;
#20
shift_amnt=5'b01010;
shift_str=32'b11010110100101110101100101110001;
#20
$finish;
end
endmodule
