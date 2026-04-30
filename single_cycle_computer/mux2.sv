
// By Fatin Hoque
`ifndef MUX2
`define MUX2
`timescale 1ns/100ps

module mux2 #(parameter n = 32)(
    input  logic           S,
    input  logic [(n-1):0] D0,
    input  logic [(n-1):0] D1,
    output logic [(n-1):0] Y);

    assign Y = S ? D1 : D0;

endmodule
`endif