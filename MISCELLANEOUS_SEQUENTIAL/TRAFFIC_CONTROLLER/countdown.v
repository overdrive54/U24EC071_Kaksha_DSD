`timescale 1s / 100ms
module countdown (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire [6:0] preset_value,
    output reg  [6:0] count_out,
    output wire active
);
    assign active = (count_out != 0);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count_out <= 7'd0;
        else if (start)
            count_out <= preset_value;
        else if (count_out != 0)
            count_out <= count_out - 1'b1;
    end
endmodule
