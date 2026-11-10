/*
Design an 8-entry register file of 8-bit words with a single port shared by reads and writes.

wr is a synchronous write of din into entry addr, and rd is a synchronous read of entry addr. A read and a write in the same cycle is invalid, and nothing is stored. dout and error are registered and show the outcome of the previous cycle: after a valid read dout is the word read, and after any other cycle it may take any value; error is 1 only after an invalid cycle.

resetn is a synchronous, active-low reset; it clears every entry and error to 0.
*/

module reg_file #(
    parameter DEPTH = 8,                     // number of entries
    parameter WIDTH = 8,                     // bits per word
    parameter AW    = (DEPTH > 1) ? $clog2(DEPTH) : 1
) (
    input  logic [7:0] din,
    input  logic [2:0] addr,
    input  logic       wr,
    input  logic       rd,
    input  logic       clk,
    input  logic       resetn,
    output logic [7:0] dout,
    output logic       error
);
  // your code here


    // Data array: no reset, so it can map to LUT RAM or block RAM
    reg [WIDTH-1:0] mem   [0:DEPTH-1];
    // Only these flags are reset
    reg [DEPTH-1:0] wrote;

    wire in_range = (addr < DEPTH);          // constant true when DEPTH is a power of 2
    wire both     = rd & wr;
    wire do_wr    = wr & ~rd & in_range;
    wire do_rd    = rd & ~wr & in_range;

    // Data storage: plain write port, no reset and no reset mux in front of the flops
    always @(posedge clk) begin
        if (resetn && do_wr)
            mem[addr] <= din;
    end

    // Written flags: the only per-entry state that needs a reset
    always @(posedge clk) begin
        if (!resetn)
            wrote <= {DEPTH{1'b0}};
        else if (do_wr)
            wrote[addr] <= 1'b1;
    end

    // Registered outputs
    always @(posedge clk) begin
        if (!resetn) begin
            dout  <= {WIDTH{1'b0}};
            error <= 1'b0;
        end else begin
            error <= both;
            dout  <= (do_rd && wrote[addr]) ? mem[addr] : {WIDTH{1'b0}};
        end
    end


endmodule
