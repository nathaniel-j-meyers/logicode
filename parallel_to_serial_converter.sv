/*
Design a module that takes the input din and shifts its LSB to the output dout one bit at a time.

The module should begin shifting the input’s LSB when the the input enable signal din_en goes high. In other words, the input enable signal going high indicates that this module should start shifting the current input signal from it’s least significant bit, regardless of which bits the module has already shifted.

If all the input’s bits have been shifted so that there are no more bits to shift, the module should output 0.

When resetn is active, the module should treat the input value as 0. Even when reset goes back to being inactive, the input value should still be treated as 0, unless din_en makes the module begin shifting from the input again.
*/

module piso_shift_reg #(
    parameter DATA_WIDTH = 32
) (
    input  logic                  clk,
    input  logic                  resetn,
    input  logic [DATA_WIDTH-1:0] din,
    input  logic                  din_en,
    output logic                  dout
);
  // your code here
  logic [DATA_WIDTH-1:0] shift_q;

  always @(posedge clk) begin
    // shift_q def.
    if (!resetn)
      shift_q = 0;
    else if (din_en)
      shift_q = din;
    else
      shift_q = {1'b0, shift_q[DATA_WIDTH-1:1]};
  end

  always @(*) begin
    if (!resetn)
      dout = 0;
    else
      dout = shift_q[0];
  end

endmodule