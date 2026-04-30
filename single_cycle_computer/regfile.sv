
// By Fatin Hoque
`ifndef REGFILE
`define REGFILE
`timescale 1ns/100ps

module regfile #(parameter n = 32, parameter r = 5)(
    input  logic           clk,
    input  logic           we3,
    input  logic [(r-1):0] wa3,
    input  logic [(r-1):0] ra1,
    input  logic [(r-1):0] ra2,
    input  logic [(n-1):0] wd3,
    output logic [(n-1):0] rd1,
    output logic [(n-1):0] rd2);

    logic [(n-1):0] rf[(2**5-1):0];

    always_ff @(posedge clk)
        if (we3 && wa3 != 0) rf[wa3] <= wd3;

    assign rd1 = (ra1 != 0) ? rf[ra1] : '0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : '0;

endmodule
`endif