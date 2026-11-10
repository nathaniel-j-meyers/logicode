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


    reg [WIDTH-1:0] mem   [0:DEPTH-1];       // array of flip-flops
    reg [DEPTH-1:0] wrote;                   // per-entry "has been written" flag

    wire in_range = (addr < DEPTH);

    integer i;

    always @(posedge clk) begin
        if (!resetn) begin
            for (i = 0; i < DEPTH; i = i + 1) mem[i] <= {WIDTH{1'b0}};
            wrote <= {DEPTH{1'b0}};
            dout  <= {WIDTH{1'b0}};
            error <= 1'b0;
        end else begin
            dout  <= {WIDTH{1'b0}};          // default: 0 unless a valid read occurs
            error <= 1'b0;

            if (rd && wr) begin
                error <= 1'b1;               // invalid: both at once, nothing is written
            end else if (wr) begin
                if (in_range) begin
                    mem[addr]   <= din;
                    wrote[addr] <= 1'b1;
                end
            end else if (rd) begin
                if (in_range && wrote[addr])
                    dout <= mem[addr];       // never-written address leaves dout = 0, error = 0
            end
        end
    end

endmodule