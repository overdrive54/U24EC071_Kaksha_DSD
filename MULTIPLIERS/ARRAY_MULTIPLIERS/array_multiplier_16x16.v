module array_multiplier_16x16 (
    input [15:0] A,
    input [15:0] B,
    output [31:0] P
);
    reg [31:0] product;
    integer i;

    always @(*) begin
        product = 0;
        for (i = 0; i < 16; i = i + 1) begin
            if (B[i]) 
                product = product + (A << i);
        end
    end

    assign P = product;

endmodule
