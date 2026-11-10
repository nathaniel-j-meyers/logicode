/*
Design a module that computes the dot product of two length-3 vectors, A=[a1,a2,a3] and B=[b1,b2,b3], whose elements arrive one per cycle on din in the order a1, a2, a3, b1, b2, b3. The elements are unsigned.

In the cycle after b3 is registered, run is asserted and dout is the dot product a1b1+a2b2+a3b3. run is high for that one cycle only, and dout may take any value while run is low. The next pair of vectors follows without a gap: their a1 arrives in that same cycle.

resetn is a synchronous, active-low reset. It discards any partly received vectors and puts the module in the state it is in when a result is ready, with run high and dout zero, so the next element to arrive is a1.
*/

module dot_prod (
    input logic [7:0] din,
    input logic clk,
    input logic resetn,

    output logic [17:0] dout,
    output logic run
);
  // your code here
  reg [7:0]  a1_d, a2_d, a3_d, b1_d, b2_d, b3_d;
  reg [2:0]  count_d;
  reg        run_d;

  reg [7:0]  a1_q, a2_q, a3_q, b1_q, b2_q, b3_q;
  reg [2:0]  count_q;
  reg        resetn_q;
  reg [17:0] dout_q;
  reg        run_q;

  integer i;

  always @(*) begin
    if (!resetn || (count_q == 5)) begin
      count_d = 0;
      run_d = 1;
    end else begin
      count_d = count_q + 1;
      run_d = 0;
    end

    for (i = 0; i < 8; i = i + 1) begin
      a1_d[i] = resetn && (((count_q == 0) &&  din[i]) ||    // case set
                           ((count_q >  0) && a1_q[i]));    // case hold
      a2_d[i] = resetn && (((count_q == 1) &&  din[i]) ||    // case set
                           ((count_q >  1) && a2_q[i]));    // case hold
      a3_d[i] = resetn && (((count_q == 2) &&  din[i]) ||    // case set
                           ((count_q >  2) && a3_q[i]));    // case hold
      b1_d[i] = resetn && (((count_q == 3) &&  din[i]) ||    // case set
                           ((count_q >  3) && b1_q[i]));    // case hold
      b2_d[i] = resetn && (((count_q == 4) &&  din[i]) ||    // case set
                           ((count_q >  4) && b2_q[i]));    // case hold
      b3_d[i] = resetn && (((count_q == 5) &&  din[i]) ||    // case set
                           ((count_q >  5) && b3_q[i]));    // case hold
    end
  end

  always @(posedge clk) begin
    resetn_q <= resetn;
    count_q <= count_d;
    a1_q <= a1_d;
    a2_q <= a2_d;
    a3_q <= a3_d;
    b1_q <= b1_d;
    b2_q <= b2_d;
    b3_q <= b3_d;
    dout_q <= dout;
    run_q <= run_d;
  end

  always @(*) begin
    run = !resetn_q || run_q;
    if (run)
      dout = (a1_q * b1_q) + (a2_q * b2_q) + (a3_q * b3_q);
    else
      dout = dout_q;
  end
endmodule