`timescale 1ns / 1ps

module OR (input a, input b, output y);
   assign y = a | b;
endmodule

module half_adder (input x, input y, output cout, output s);
   assign {cout, s} = x + y;
endmodule

module full_adder_structural (input a, input b, input cin, output cout, output s);
   wire c1, c2, sum;

   half_adder H1 (.x(a), .y(b), .cout(c1), .s(sum));
   half_adder H2 (.x(sum), .y(cin), .cout(c2), .s(s));
   OR O1 (.a(c1), .b(c2), .y(cout));
   
endmodule