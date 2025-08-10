`timescale 1ns/1ps

module tb_AXI_STREAM;

    parameter t_data_w = 4;
    localparam DATA_BITS = 8 * t_data_w;

    reg aclk;
    reg aresetn;
    reg [t_data_w-1:0] info_bits;
    reg [DATA_BITS-1:0] dsp_in_data;
    reg full;

    wire [DATA_BITS-1:0] data_word;
    wire w_en;

    AXI_STREAM_F #(
        .t_data_w(t_data_w)
    ) dut (
        .aclk(aclk),
        .aresetn(aresetn),
        .info_bits(info_bits),
        .dsp_in_data(dsp_in_data),
        .full(full),
        .data_word(data_word),
        .w_en(w_en)
    );

    initial begin
        aclk = 0;
        forever #5 aclk = ~aclk;
    end

    initial begin
        aresetn     = 0;
        info_bits   = 0;
        dsp_in_data = 0;
        full        = 0;

        #20;
        aresetn = 1;

        #10;
        info_bits   = 4'b1111;
        dsp_in_data = 32'hAABB_CCDD;
        full        = 0;

        #10;

        full = 1;
        #20;
        full = 0;

        info_bits   = 4'b0011;
        dsp_in_data = 32'h1122_3344;

        #10;

        info_bits   = 4'b0000;
        dsp_in_data = 32'hDEAD_BEEF;

        #10;

        info_bits   = 4'b1111;
        dsp_in_data = 32'h0000_0000;

        #10;

        repeat (5) begin
            @(posedge aclk);
            info_bits   = $random;
            dsp_in_data = $random;
            full        = $random % 2;
        end

        #50;
        $stop;
    end

endmodule
