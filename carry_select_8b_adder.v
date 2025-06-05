module mux2to1 (
    input  sel,
    input  in0,
    input  in1,
    output reg out
);
    always @(*) begin
        if (sel)
            out = in1;
        else
            out = in0;
    end
endmodule

module full_adder_4b_behavioral (
    input  [3:0] a,
    input  [3:0] b,
    input  cin,
    output reg cout,
    output reg [3:0] s
);
    always @(*) begin
        {cout, s} = a + b + cin;
    end
endmodule

module carry_select_8b_adder (
    input  [7:0] a,
    input  [7:0] b,
    input  cin,
    output cout,
    output [7:0] s
);

    wire lower_carry;
    wire [3:0] lower_sum;
    full_adder_4b_behavioral adder_lower (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(lower_carry),
        .s(lower_sum)
    );
  
    wire [3:0] upper_sum0, upper_sum1;
    wire upper_carry0, upper_carry1;
    
    full_adder_4b_behavioral adder_upper0 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(1'b0),
        .cout(upper_carry0),
        .s(upper_sum0)
    );
    
    full_adder_4b_behavioral adder_upper1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(1'b1),
        .cout(upper_carry1),
        .s(upper_sum1)
    );
    
    wire [3:0] selected_upper_sum;
    genvar i;
    generate
       for (i = 0; i < 4; i = i + 1) begin : upper_mux
           mux2to1 mux_bit (
               .sel(lower_carry),
               .in0(upper_sum0[i]),
               .in1(upper_sum1[i]),
               .out(selected_upper_sum[i])
           );
       end
    endgenerate

    wire selected_upper_carry;
    mux2to1 mux_carry (
        .sel(lower_carry),
        .in0(upper_carry0),
        .in1(upper_carry1),
        .out(selected_upper_carry)
    );
    
    assign s = {selected_upper_sum, lower_sum};
    assign cout = selected_upper_carry;
    
endmodule
