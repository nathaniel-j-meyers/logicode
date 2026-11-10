/*
Design a fractional clock divider that divides clk by MUL2_DIV_CLK/2, a half-integer ratio such as 3.5 for the default MUL2_DIV_CLK =7.

clk_div has a period of MUL2_DIV_CLK half-cycles of clk, so its edges fall on both rising and falling edges of clk. Each period begins with clk_div rising; it stays high for three half-cycles of clk and is low for the rest of the period. The first period begins at the first rising edge of clk after reset.

rst_n is an asynchronous, active-low reset that holds clk_div low.
*/

module freq_divbyfrac #(
    parameter integer MUL2_DIV_CLK = 7
) (
    input  logic rst_n,
    input  logic clk,

    output logic clk_div
);
  // your code here
  reg [2:0] count_d, count_q;

  always @(*) begin
    if (!rst_n || (count_q == 6)) begin
      count_d = 0;
    end else begin
      count_d = count_q + 1;
    end
  end

  always @(posedge clk, negedge clk) begin
    count_q <= count_d;
  end

  assign clk_div = rst_n && ((count_q == 2) || (count_q == 3) || (count_q == 4));
endmodule