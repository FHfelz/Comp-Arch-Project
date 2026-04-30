
// Fatin Hoque
`ifndef SL2
`define SL2
`timescale 1ns/100ps

module sl2 #(parameter n = 32)(
    output logic [(n-1):0] Y,
    input  logic [(n-1):0] A);

    assign Y = A << 2;

endmodule
`endif