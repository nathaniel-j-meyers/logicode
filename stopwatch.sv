/*
Design a stopwatch that counts hours, minutes, and seconds.

secs increments every cycle and wraps from 59 to 0. mins increments each time secs wraps and itself wraps from 59 to 0. hours increments each time mins wraps and wraps from 23 to 0.

rst is an asynchronous, active-high reset that sets all three counts to 0.
*/

module stopwatch (
    input  logic       CLK,
    input  logic       RST,
    output logic [5:0] Hours,
    output logic [5:0] Mins,
    output logic [5:0] Secs
);
  // your code here
  logic wrap_hours, wrap_mins, wrap_secs;
  logic [5:0] secs_d, secs_q, mins_d, mins_q, hours_d, hours_q;

  always @(*) begin
    if (RST) begin
      secs_d = 0; mins_d = 0; hours_d = 0;
    end else begin
      wrap_secs = (secs_q == 59);
      wrap_mins = wrap_secs && (mins_q == 59);
      wrap_hours = wrap_mins && (hours_q == 23);

      if (wrap_secs)
        secs_d = 0;
      else
        secs_d = secs_q + 1;

      if (wrap_mins)
        mins_d = 0;
      else if (wrap_secs)
        mins_d = mins_q + 1;
      else
        mins_d = mins_q;

      if (wrap_hours)
        hours_d = 0;
      else if (wrap_mins)
        hours_d = hours_q + 1;
      else
        hours_d = hours_q;
    end
  end

  always @(posedge CLK) begin
    secs_q = secs_d; mins_q = mins_d; hours_q = hours_d;
  end

  always @(*) begin
    if (RST) begin
      Secs = 0; Mins = 0; Hours = 0;
    end else begin
      Secs = secs_q; Mins = mins_q; Hours = hours_q;
    end
  end

endmodule