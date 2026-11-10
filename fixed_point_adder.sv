/*
Design a parameterized fixed-point adder for sign-magnitude operands.

a, b and c are N-bit sign-magnitude values: bit N−1 is the sign (1 for negative) and the low N−1 bits are the magnitude. Q is the number of fractional bits; both operands share it, so it does not change the addition.

When a and b have the same sign, c has that sign and its magnitude is the low N−1 bits of the sum of the two magnitudes, so a sum that does not fit wraps. When the signs differ, the magnitude of c is the difference of the two magnitudes and its sign is that of the operand with the larger magnitude; equal magnitudes give +0.

The module is combinational.
*/

module fixed_point_adder #(
    parameter Q = 15,
    parameter N = 32
) (
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,

    output logic [N-1:0] c
);
  // your code here
  always @(*) begin
  // case: same sign
    if (a[31] == b[31]) begin
      c[31] = a[31];
      c[30:0] = a[30:0] + b[30:0];
    end
  // case: different sign, different magnitude
    else if (a[30:0] > b[30:0]) begin
      c[31] = a[31];
      c[30:0] = a[30:0] - b[30:0];
    end else if (a[30:0] < b[30:0]) begin
      c[31] = b[31];
      c[30:0] = b[30:0] - a[30:0];
    end
  // case: different sign, same magnitude
    else
      c = 32'b00000000000000000000000000000000;
  end
endmodule