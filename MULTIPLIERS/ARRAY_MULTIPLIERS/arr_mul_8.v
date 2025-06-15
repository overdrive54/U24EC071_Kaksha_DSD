module full_adder(a, b, cin, cout, s);
  input a, b, cin;
  output reg cout, s;
  always @(*) begin
    {cout, s} = a + b + cin;
  end
endmodule

module half_adder(a, b, cout, s);
  input a, b;
  output reg cout, s;
  always @(*) begin
    {cout, s} = a + b;
  end
endmodule

module arr_mul_8(
    output [15:0] out,
    input [7:0] A, B
    );

  assign out[0] = A[0] & B[0];
  
  wire [64:0] s, c;
  
  half_adder h1((A[0] & B[1]), (A[1] & B[0]), c[0], out[1]);
  full_adder f1 ((A[1] & B[1]), (A[2] & B[0]), c[0], c[1], s[1]);
  full_adder f2 ((A[2] & B[1]), (A[3] & B[0]), c[1], c[2], s[2]);
  full_adder f3 ((A[3] & B[1]), (A[4] & B[0]), c[2], c[3], s[3]);
  full_adder f4 ((A[4] & B[1]), (A[5] & B[0]), c[3], c[4], s[4]);
  full_adder f5 ((A[5] & B[1]), (A[6] & B[0]), c[4], c[5], s[5]);
  full_adder f6 ((A[6] & B[1]), (A[7] & B[0]), c[5], c[6], s[6]);
  half_adder h2 ((A[7] & B[1]), c[6], c[7], s[7]);
  
  half_adder h3 ((A[0] & B[2]), s[1], c[8], out[2]);
  full_adder f7 ((A[1] & B[2]), s[2], c[8], c[9], s[9]);
  full_adder f8 ((A[2] & B[2]), s[3], c[9], c[10], s[10]);
  full_adder f9 ((A[3] & B[2]), s[4], c[10], c[11], s[11]);
  full_adder f10((A[4] & B[2]), s[5], c[11], c[12], s[12]);
  full_adder f11((A[5] & B[2]), s[6], c[12], c[13], s[13]);
  full_adder f12((A[6] & B[2]), s[7], c[13], c[14], s[14]);
  full_adder f13((A[7] & B[2]), c[7], c[14], c[15], s[15]);

  half_adder h4 ((A[0] & B[3]), s[9], c[16], out[3]);
  full_adder f14((A[1] & B[3]), s[10], c[16], c[17], s[17]);
  full_adder f15((A[2] & B[3]), s[11], c[17], c[18], s[18]);
  full_adder f16((A[3] & B[3]), s[12], c[18], c[19], s[19]);
  full_adder f17((A[4] & B[3]), s[13], c[19], c[20], s[20]);
  full_adder f18((A[5] & B[3]), s[14], c[20], c[21], s[21]);
  full_adder f19((A[6] & B[3]), s[15], c[21], c[22], s[22]);
  full_adder f20((A[7] & B[3]), c[15], c[22], c[23], s[23]);

  half_adder h5 ((A[0] & B[4]), s[17], c[24], out[4]);
  full_adder f21((A[1] & B[4]), s[18], c[24], c[25], s[25]);
  full_adder f22((A[2] & B[4]), s[19], c[25], c[26], s[26]);
  full_adder f23((A[3] & B[4]), s[20], c[26], c[27], s[27]);
  full_adder f24((A[4] & B[4]), s[21], c[27], c[28], s[28]);
  full_adder f25((A[5] & B[4]), s[22], c[28], c[29], s[29]);
  full_adder f26((A[6] & B[4]), s[23], c[29], c[30], s[30]);
  full_adder f27((A[7] & B[4]), c[23], c[30], c[31], s[31]);

  half_adder h7 ((A[0] & B[5]), s[25], c[32], out[5]);
  full_adder f28((A[1] & B[5]), s[26], c[32], c[33], s[33]);
  full_adder f29((A[2] & B[5]), s[27], c[33], c[34], s[34]);
  full_adder f30((A[3] & B[5]), s[28], c[34], c[35], s[35]);
  full_adder f31((A[4] & B[5]), s[29], c[35], c[36], s[36]);
  full_adder f32((A[5] & B[5]), s[30], c[36], c[37], s[37]);
  full_adder f34((A[6] & B[5]), s[31], c[37], c[38], s[38]);
  full_adder f35((A[7] & B[5]), c[31], c[38], c[39], s[39]);

  half_adder h8 ((A[0] & B[6]), s[33], c[40], out[6]);
  full_adder f36((A[1] & B[6]), s[34], c[40], c[41], s[41]);
  full_adder f37((A[2] & B[6]), s[35], c[41], c[42], s[42]);
  full_adder f38((A[3] & B[6]), s[36], c[42], c[43], s[43]);
  full_adder f39((A[4] & B[6]), s[37], c[43], c[44], s[44]);
  full_adder f40((A[5] & B[6]), s[38], c[44], c[45], s[45]);
  full_adder f41((A[6] & B[6]), s[39], c[45], c[46], s[46]);
  full_adder f42((A[7] & B[6]), c[39], c[46], c[47], s[47]);

  half_adder h9 ((A[0] & B[7]), s[41], c[48], out[7]);
  full_adder f43((A[1] & B[7]), s[42], c[48], c[49], s[49]);
  full_adder f44((A[2] & B[7]), s[43], c[49], c[50], s[50]);
  full_adder f45((A[3] & B[7]), s[44], c[50], c[51], s[51]);
  full_adder f46((A[4] & B[7]), s[45], c[51], c[52], s[52]);
  full_adder f47((A[5] & B[7]), s[46], c[52], c[53], s[53]);
  full_adder f48((A[6] & B[7]), s[47], c[53], c[54], s[54]);
  full_adder f49((A[7] & B[7]), c[47], c[54], c[55], s[55]);

  assign out[8]  = s[49];
  assign out[9]  = s[50];
  assign out[10] = s[51];
  assign out[11] = s[52];
  assign out[12] = s[53];
  assign out[13] = s[54];
  assign out[14] = s[55];
  assign out[15] = c[55];
  
endmodule
