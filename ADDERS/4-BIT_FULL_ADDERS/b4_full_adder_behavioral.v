module b4_full_adder_behavioral(input [3:0] a, input [3:0] b, input cin, output reg cout, output reg [3:0] s);

    always @(*) begin
        {cout, s} = a + b + cin;
    end
endmodule
