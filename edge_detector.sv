/*
Design a rising-edge detector.

dout is high for one cycle, the cycle after one in which din is high and was low in the cycle before. In every other cycle dout is low.

resetn is a synchronous, active-low reset; while it is low, din counts as low.
*/

module edge_detector (
    input  logic clk,
    input  logic resetn,
    input  logic din,
    output logic dout
);
  // your code here
  reg dout_d;
  reg din_q;

  always_comb begin
    dout_d = resetn && din && !din_q;
  end

  always @(posedge clk) begin
    dout = dout_d;
    din_q <= din;
  end
endmodule