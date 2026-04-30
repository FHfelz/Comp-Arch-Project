
// By Fatin Hoque
`ifndef DMEM
`define DMEM
`timescale 1ns/100ps

module dmem #(parameter n = 32, parameter r = 6)(
    input  logic           clk,
    input  logic           write_enable,
    input  logic [(n-1):0] addr,
    input  logic [(n-1):0] writedata,
    output logic [(n-1):0] readdata);

    logic [(n-1):0] RAM[0:(2**r-1)];

    always_ff @(posedge clk)
        if (write_enable) RAM[addr[(n-1):2]] <= writedata;

    assign readdata = RAM[addr[(n-1):2]];

endmodule
`endif