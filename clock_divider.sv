/*
Design a clock divider that produces clocks with 2, 4 and 6 times the period of clk and a 50% duty cycle.

resetn is a synchronous, active-low reset that holds all three outputs low. The outputs are phase-aligned: all three rise together on the first rising edge of clk after reset is released.
*/

module divide_by_evens_clock (
    input  logic clk,
    input  logic resetn,
    output logic div2,
    output logic div4,
    output logic div6
);
  // your code here
  reg [3:0] count = 0;
  reg switch_div2;
  reg switch_div4;
  reg switch_div6;
  reg div2_d;
  reg div4_d;
  reg div6_d;

  always @(*) begin
    switch_div2 = resetn && (count % 1) == 0;
    switch_div4 = resetn && (count % 2) == 0;
    switch_div6 = resetn && (count % 3) == 0;

    div2_d = resetn && ((!div2 && switch_div2) || (!switch_div2 && div2));
    div4_d = resetn && ((!div4 && switch_div4) || (!switch_div4 && div4));
    div6_d = resetn && ((!div6 && switch_div6) || (!switch_div6 && div6));
  end
  
  always @(posedge clk) begin
    if (!resetn)
      count <= 0;
    else if (count == 11)
      count <= 0;
    else
      count <= count + 1;

    div2 <= div2_d;
    div4 <= div4_d;
    div6 <= div6_d;
  end
endmodule