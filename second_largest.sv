/*
Design a module that tracks the second-largest of a sequence of unsigned values.

Each cycle without a reset, din is the next value of the sequence. dout is the second-largest value of the sequence so far: the second value when the values are sorted from largest to smallest, repeats included. It is 0 while the sequence has fewer than two values. dout is registered: it covers the values up to the cycle before.

resetn is a synchronous, active-low reset that empties the sequence.
*/

module second_largest #(
    parameter DATA_WIDTH = 32
) (
    input logic clk,
    input logic resetn,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);
  // your code here
  reg [DATA_WIDTH-1:0] largest_d;
  reg [DATA_WIDTH-1:0] second_d;
  reg [DATA_WIDTH-1:0] largest_q;
  reg [DATA_WIDTH-1:0] second_q;

  always @(*) begin
    if (!resetn) begin
      largest_d = din;
      second_d  = 0;
    end else if (din >= largest_q) begin
      largest_d = din;
      second_d  = largest_q;
    end else if ((din < largest_q) && (din >= second_q)) begin
      largest_d = largest_q;
      second_d  = din;
    end else begin
      largest_d = largest_q;
      second_d  = second_q;
    end
  end

  always @(posedge clk) begin
      largest_q = largest_d;
      second_q  = second_d;
  end

  assign dout = second_q;
endmodule