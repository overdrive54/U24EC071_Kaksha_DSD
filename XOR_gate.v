// Code your design here
// Code your design here
module NAND (input a,
            input b,
            output y);
   assign y = ~(a & b);
endmodule

module XOR_gate(input a, input b, output y);
    wire nand_AB, nand_A_AB, nand_B_AB;

  NAND U1 (.a(a), .b(b), .y(nand_AB));
  NAND U2 (.a(nand_AB), .b(a), .y(nand_A_AB));
  NAND U3 (.a(nand_AB), .b(b), .y(nand_B_AB));
  NAND U4 (.a(nand_A_AB), .b(nand_B_AB), .y(y));
    
endmodule    