`timescale 1ns / 1ps

module ADDER_TB;
    reg a, b, cin;     // input variables
    wire cout, s;       // output wire

    // Instantiate design module
    full_adder_dataflow uut (
      .a(a),
      .b(b),
      .cin(cin),
      .cout(cout),
      .s(s)
    );

    // Dump waveform for simulation
    initial begin
      $dumpfile("adder_tb.vcd");
      $dumpvars(0, ADDER_TB); 
    end

    // Test stimulus
    initial begin
        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;
        $finish; // End simulation
    end

endmodule