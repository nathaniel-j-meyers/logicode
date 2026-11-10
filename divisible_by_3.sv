/*
Design a serial checker for divisibility by three.

The bits of an unsigned number of any length arrive on din, one per cycle, most-significant bit first. dout is 1 when the number formed by the bits received since reset is divisible by three, and 0 otherwise; a bit is included from the cycle after it is on din. Before any bit has been received dout is 0.

resetn is a synchronous, active-low reset; it discards the bits received so far and holds dout at 0. A bit on din during reset is not received.
*/

module div_by_three (
    input  logic clk,
    input  logic resetn,
    input  logic din,
    output logic dout
);
  // your code here

    // One-hot remainder: s[k] is 1 when (value so far) mod 3 == k.
    reg [2:0] s;

    // Each next-state bit is a function of only 3 inputs (din plus two
    // state bits), so it fits in a single LUT / one or two gate levels.
    // new_rem = (2*rem + din) mod 3
    wire n0 = (s[0] & ~din) | (s[1] &  din);   // -> remainder 0
    wire n1 = (s[0] &  din) | (s[2] & ~din);   // -> remainder 1
    wire n2 = (s[1] & ~din) | (s[2] &  din);   // -> remainder 2

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            s    <= 3'b001;   // remainder 0, all earlier bits forgotten
            dout <= 1'b0;     // output is 0 during reset
        end else begin
            s    <= {n2, n1, n0};
            dout <= n0;       // directly registered, no compare after the next-state logic
        end
    end
endmodule