// Code your design here
module mux2to1 (
    input  sel,
    input  in0,
    input  in1,
    output out
);
    assign out = sel ? in1 : in0;
endmodule

module and_gate(input a,
                input b,
                output wire y);
  
  mux2to1 m1 (.sel(!b), .in0(a), .in1(0), .out(y));
  
endmodule
