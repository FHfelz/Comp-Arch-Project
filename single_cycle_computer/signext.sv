
// By Fatin Hoque
`ifndef SIGNEXT
`define SIGNEXT
`timescale 1ns/100ps

module signext #(parameter n = 32, parameter i = 16)(
    output logic [(n-1):0] Y,
    input  logic [(i-1):0] A);

    assign Y = {{(n-i){A[i-1]}}, A};

endmodule
`endif