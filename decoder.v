// Code your design here
module decoder (
  input wire in,
  input wire [1:0] sel,
  output reg [3:0] out
);
  always@(*)
    begin
       out = 4'b0000;
       out[sel] = in;
	end
endmodule
