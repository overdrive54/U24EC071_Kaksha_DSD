module BoothMul (
    input  signed [7:0] X,
    input  signed [7:0] Y,
    output signed [15:0] Z
);

    reg signed [15:0] result;
    reg signed [15:0] acc;
    reg signed [15:0] Y_ext;
    reg [8:0] Booth_X;
    integer i;

    always @(*) begin
        result  = 16'd0;
        Y_ext   = { {8{Y[7]}}, Y };
        Booth_X = {X, 1'b0};

        for (i = 0; i < 8; i = i + 1) begin
            case (Booth_X[i +: 2])
                2'b01: acc =  Y_ext << i;
                2'b10: acc = -Y_ext << i;
                default: acc = 16'd0;
            endcase
            result = result + acc;
        end

    end

    assign Z = result;

endmodule
