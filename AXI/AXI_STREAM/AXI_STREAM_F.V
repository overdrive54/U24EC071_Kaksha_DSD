`timescale 1ns / 1ps

module AXI_STREAM_F #(
    parameter t_data_w = 8
)(
    input wire aclk,
    input wire  aresetn,
    input  wire [t_data_w-1:0] info_bits,
    input  wire [(8*t_data_w)-1:0] dsp_in_data,
    input  wire full, 
    output wire [(8*t_data_w)-1:0] data_word,
    output wire w_en
);

    wire tvalid, tready;
    wire [(8*t_data_w)-1:0] tdata;
    wire [t_data_w-1:0] tkeep;


    AXI_SLAVE #(
        .t_data_w(t_data_w)
    ) slave_inst (
        .ACLK(aclk),
        .ARESETn(aresetn),
        .TDATA(tdata),
        .TKEEP(tkeep),
        .TVALID(tvalid),
        .TREADY(tready),
        .data_word(data_word),
        .w_en(w_en),
        .full(full)
    );

    AXI_MASTER #(
        .t_data_w(t_data_w)
    ) master_inst (
        .ACLK(aclk),
        .ARESETn(aresetn),
        .TDATA(tdata),
        .TKEEP(tkeep),
        .TVALID(tvalid),
        .TREADY(tready),
        .dsp_in_DATA(dsp_in_data),
        .info_bits(info_bits)
    );

endmodule

module AXI_SLAVE #(
    parameter t_data_w = 8
)(
    input  wire                     ACLK,
    input  wire                     ARESETn,
    input  wire [(8*t_data_w)-1:0]  TDATA,
    input  wire [t_data_w-1:0]       TKEEP,
    input  wire                      TVALID,
    output wire                      TREADY,
    output reg  [(8*t_data_w)-1:0]  data_word,
    output reg                      w_en,
    input  wire                      full
);

    assign TREADY = ~full;

    always @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            data_word <= { (8*t_data_w){1'b0} };
            w_en      <= 1'b0;
        end 
        else begin
            w_en <= 1'b0;
            if (TVALID && TREADY) begin
                if (TKEEP != 0 && TDATA != 0) begin
                    data_word <= TDATA;
                    w_en      <= 1'b1;
                end
            end
        end
    end

endmodule


module AXI_MASTER #(
    parameter t_data_w = 8
)(
    input  wire                       ACLK,
    input  wire                       ARESETn,
    input  wire                       TREADY,
    input  wire  [(8*t_data_w)-1:0]   dsp_in_DATA,
    input  wire  [t_data_w-1:0]       info_bits,
    output reg   [(8*t_data_w)-1:0]   TDATA,
    output reg   [t_data_w-1:0]       TKEEP,
    output reg                        TVALID
);

    always @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            TDATA  <= { (8*t_data_w){1'b0} };
            TKEEP  <= { t_data_w{1'b0} };
            TVALID <= 1'b0;
        end 
        else begin
            if (info_bits != 0) begin
                if (TREADY) begin
                    TDATA  <= dsp_in_DATA;
                    TKEEP  <= info_bits;
                    TVALID <= 1'b1;
                end 
                else begin
                    TVALID <= 1'b0;
                end
            end
            else begin
                TVALID <= 1'b0;
                TKEEP  <= { t_data_w{1'b0} };
            end
        end
    end

endmodule
