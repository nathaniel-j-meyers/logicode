/*
Design a Fibonacci sequence generator.

The sequence starts F0=1, F1=1, and each later term is the sum of the two before it (1, 1, 2, 3, 5, 8, 13, …). fib shows the terms in order, one per cycle.

resetn is a synchronous, active-low reset to F0.
*/

module fib_gen #(
    parameter int DATA_WIDTH = 32
) (
    input  logic                  clk,
    input  logic                  resetn,
    output logic [DATA_WIDTH-1:0] out
);
  // your code here
  reg [DATA_WIDTH-1:0] f0_d; 
  reg [DATA_WIDTH-1:0] f1_d;
  reg [DATA_WIDTH-1:0] f0_q; 
  reg [DATA_WIDTH-1:0] f1_q;

  always @(*) begin
    if (!resetn) begin
      f0_d = 0;
      f1_d = 1;
    end else begin
      f0_d = out;
      f1_d = f0_q;
    end

  end

  always @(posedge clk) begin
    f0_q = f0_d;
    f1_q = f1_d;
  end

  assign out = f0_q + f1_q;

endmodule