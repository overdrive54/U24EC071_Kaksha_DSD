`timescale 1ns / 1ps

module XOR_TB;
    reg a, b;     // input variables
    wire y;       // output wire

    // Instantiate design module
    XOR uut (
      .a(a),
      .b(b),
      .y(y)
    );

    // Dump waveform for simulation
    initial begin
        $dumpfile("xor_gate_tb.vcd");
        $dumpvars(0, XOR_TB);  // Corrected module name
    end

    // Test stimulus
    initial begin
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish; // End simulation
    end

endmodule
