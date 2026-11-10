/*
Design a thermometer code detector.

A thermometer (unary) code writes a number m as a word whose lowest m bits are 1 and the rest 0, like mercury rising in a thermometer.

isThermometer is 1 when codeIn is a thermometer code read from either end: its 1s form one run that starts at bit 0 or at the top bit, and it has at least one 1 and at least one 0. So all-0s and all-1s words are not thermometer codes.

The module is combinational.
*/

module thermo_code_detector (
    input  logic [7:0] codeIn,
    output logic       isThermometer
);
  // your code here
  logic [6:0] transitions;
  integer i;

  always @(*) begin
    transitions = codeIn[6:0] ^ codeIn[7:1];
    isThermometer = transitions && !(transitions & (transitions - 1));
  end
endmodule