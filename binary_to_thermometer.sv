/*
Design a binary-to-thermometer decoder.

A thermometer (unary) code writes a number as a word whose lowest bits are 1 and the rest 0, like mercury rising in a thermometer.

dout is the thermometer code of din: its lowest din bits are 1 and all higher bits are 0. So din=0 gives all 0s, and the largest din leaves only the top bit of dout at 0.

The module is combinational.
*/

module bin_to_thermo #(
    parameter DIN_WIDTH = 8
) (
    input logic [DIN_WIDTH-1:0] din,
    output logic [2**DIN_WIDTH-1:0] dout
);
  // your code here
  genvar i;
  generate
    for (i = 0; i < 2**DIN_WIDTH; i = i + 1) begin
      assign dout[i] = din > i;
    end
  endgenerate
endmodule