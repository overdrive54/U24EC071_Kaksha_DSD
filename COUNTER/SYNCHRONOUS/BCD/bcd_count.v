module T_ff (
    input  wire clk,
    input  wire pre,
    input  wire rst_n,
    input  wire T,
    output reg  q,
    output wire qbar
);
    always @(posedge clk or posedge rst_n or posedge pre) begin
        if (rst_n)
            q <= 1'b0;
        else if (pre)
            q <= 1'b1;
        else if (T)
            q <= ~q;
    end

    assign qbar = ~q;
endmodule



module bcd_count (
    input  wire clk,
    output wire [4:0] q,
    output wire [4:0] qbar
);

    wire rst_10 = (q[3] & qbar[2] & q[1] & qbar[0]);
    
    wire qbar_4, qbar_3, qbar_2, qbar_1, qbar_0;
    assign qbar = {qbar_4, qbar_3, qbar_2, qbar_1, qbar_0};
        
    // Q0
    T_ff ff0 ( .clk(clk), .pre(1'b0), .rst_n(rst_10), .T(1'b1), .q(q[0]), .qbar(qbar_0) );
    // Q1
    T_ff ff1 ( .clk(clk), .pre(1'b0), .rst_n(rst_10), .T(q[0]), .q(q[1]), .qbar(qbar_1) );
    // Q2
    T_ff ff2 ( .clk(clk), .pre(1'b0), .rst_n(rst_10), .T(q[0] & q[1]), .q(q[2]), .qbar(qbar_2) );
    // Q3
    T_ff ff3 ( .clk(clk), .pre(1'b0), .rst_n(rst_10), .T(q[0] & q[1] & q[2]), .q(q[3]), .qbar(qbar_3) );
    // Q4
    T_ff ff4 ( .clk(clk), .pre(rst_10 & (qbar_4)), .rst_n(rst_10 & (q[4])), .T(1'b0), .q(q[4]), .qbar(qbar_4) );
    

endmodule
