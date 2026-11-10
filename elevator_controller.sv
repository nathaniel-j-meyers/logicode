/*
Design an elevator controller FSM with states IDLE, MOVING_UP, and MOVING_DOWN, reported on state as 00, 01, and 10. up_request is high while there is demand above the car and down_request while there is demand below it.

The FSM takes at most one transition per cycle. From IDLE it enters MOVING_UP when up_request is high, or MOVING_DOWN when only down_request is high. Once moving, it stays in that state while its own request is high and returns to IDLE in the cycle after that request goes low; the other request is ignored until then.

reset is an asynchronous, active-high reset to IDLE.
*/

module elevator_cont (
    input  logic       clk,
    input  logic       reset,
    input  logic       up_request,
    input  logic       down_request,
    output logic [1:0] state
);
  // your code here
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else if (up_request)
      state <= 2'b01;
    else if (down_request)
      state <= 2'b10;
    else
      state <= 2'b00;
  end
endmodule