/*
Design a Hamming(7,4) decoder that corrects a single-bit error.

A Hamming(7,4) codeword carries four data bits and three parity bits. Numbering its bits by position from 1 to 7, the parity bits sit at positions 1, 2 and 4, and the parity bit at position 2^k makes the XOR of every position whose number has bit k set equal to 0. A single flipped bit breaks exactly the checks whose bits spell out its position, which is how the decoder finds it.

codeword_in[i] is position i+1: in order from bit 0 they are p1, p2, d1, p4, d2, d3, d4.

syndrome_out is the syndrome of codeword_in: its bit k is the XOR of the bits at every position whose number has bit k set. A non-zero syndrome is taken as the position of a single flipped bit, and that bit is flipped back; a double-bit error is not told apart from a single one. data_out is d4, d3, d2, d1 of the corrected codeword, with d4 in its top bit. error_detected and error_corrected are both 1 exactly when the syndrome is non-zero.

The module is combinational.
*/

module hamming_decoder (
    input  logic [6:0] codeword_in,
    output logic [3:0] data_out,
    output logic       error_detected,
    output logic       error_corrected,
    output logic [2:0] syndrome_out
);
  // your code here
  logic [2:0] index;
  logic [6:0] correction;

  always @(*) begin
    syndrome_out[0] = codeword_in[0] ^ codeword_in[2] ^ codeword_in[4] ^ codeword_in[6];
    syndrome_out[1] = codeword_in[1] ^ codeword_in[2] ^ codeword_in[5] ^ codeword_in[6];
    syndrome_out[2] = codeword_in[3] ^ codeword_in[4] ^ codeword_in[5] ^ codeword_in[6];

    error_detected = syndrome_out != 0;

    correction = codeword_in;

    if (error_detected) begin
      case (syndrome_out)
        3'b001 : correction[0] = ! codeword_in[0];
        3'b010 : correction[1] = ! codeword_in[1];
        3'b011 : correction[2] = ! codeword_in[2];
        3'b100 : correction[3] = ! codeword_in[3];
        3'b101 : correction[4] = ! codeword_in[4];
        3'b110 : correction[5] = ! codeword_in[5];
        3'b111 : correction[6] = ! codeword_in[6];
      endcase
    end

    data_out = {correction[6:4], correction[2]};
    error_corrected = error_detected;
  end
endmodule