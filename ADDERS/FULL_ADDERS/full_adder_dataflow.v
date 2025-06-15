module full_adder_dataflow(a,b,cin,cout,s);
  input a, b, cin;
  output cout, s;
  assign s = a ^ b^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule
