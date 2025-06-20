module full_adder(input a, b, cin, output cout, sum);
  assign {cout, sum} = a + b + cin;
endmodule

module arr_mul_16(
  input [15:0] A, B,
  output [31:0] out
);
  wire [255:0] pp;
  wire [31:0] sum [0:16];
  wire [31:0] carry [0:16];

  genvar i, j;

  generate
    for (i = 0; i < 16; i = i + 1) begin: gen_pp
      for (j = 0; j < 16; j = j + 1) begin: gen_bits
        assign pp[i*16 + j] = A[j] & B[i];
      end
    end
  endgenerate

  assign sum[0] = 32'b0;
  assign carry[0] = 32'b0;

  generate
    for (i = 0; i < 16; i = i + 1) begin: stage
      for (j = 0; j < 32; j = j + 1) begin: bitwise
        wire a = (j >= i && j < i + 16) ? pp[i*16 + (j - i)] : 0;
        wire b = sum[i][j];
        wire cin = carry[i][j];

        wire s, c;
        full_adder fa (
          .a(a),
          .b(b),
          .cin(cin),
          .sum(s),
          .cout(c)
        );

        assign sum[i+1][j] = s;
        assign carry[i+1][j+1] = (j < 31) ? c : 1'b0; 
      end
    end
  endgenerate

  assign out = sum[16];

endmodule
