// Code your design here
module XOR (input a,
            input b,
            output reg y);
  always @(*) begin
        y = a ^ b; // XOR operation
    end

endmodule