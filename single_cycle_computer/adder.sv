
// Engineer: Fatin Hoque

`define ADDER

`timescale 1ns/100ps

module adder
#(parameter n = 32)
(
    input  logic [n-1:0] A,
    input  logic [n-1:0] B,
    output logic [n-1:0] Y
);

    // simple combinational addition
    assign Y = A + B;

endmodule

`endif