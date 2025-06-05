module mux2to1 (
    input  sel,
    input  in0,
    input  in1,
    output out
);
    assign out = sel ? in1 : in0;
endmodule

module adder4bit (
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout,
    output       prop
);
    wire [4:0] c;
    assign c[0] = cin;
    
    genvar i;
    generate
        for(i = 0; i < 4; i = i + 1) begin : full_adder_gen
            wire p, g;
            assign p = a[i] ^ b[i];
            assign g = a[i] & b[i];
            assign sum[i] = p ^ c[i];
            assign c[i+1] = g | (p & c[i]);
        end
    endgenerate
    assign cout = c[4];
    
    assign prop = (a[0] ^ b[0]) &
                  (a[1] ^ b[1]) &
                  (a[2] ^ b[2]) &
                  (a[3] ^ b[3]);
endmodule


module carry_skip_32bit_adder (
    input  [31:0] a,
    input  [31:0] b,
    input         cin,
    output [31:0] sum,
    output        cout
);

    wire [8:0] carry;
    assign carry[0] = cin;
    
    genvar i;
    generate
        for(i = 0; i < 8; i = i + 1) begin : block
            wire [3:0] block_sum;
            wire       block_cout;
            wire       block_prop;


            adder4bit adder_inst (
                .a(a[4*i+3 -: 4]),
                .b(b[4*i+3 -: 4]),
                .cin(carry[i]),
                .sum(block_sum),
                .cout(block_cout),
                .prop(block_prop)
            );
            
            assign sum[4*i+3 -: 4] = block_sum;
            
            mux2to1 skip_mux (
                .sel(block_prop),
                .in0(block_cout),
                .in1(carry[i]),
                .out(carry[i+1])
            );
        end
    endgenerate
    
    // The final carry out of the 32-bit adder is the carry from the last block.
    assign cout = carry[8];
endmodule
