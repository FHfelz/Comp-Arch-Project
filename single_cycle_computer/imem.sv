
// By Fatin Hoque
`ifndef IMEM
`define IMEM
`timescale 1ns/100ps

module imem #(parameter n = 32, parameter r = 6)(
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] readdata);

    logic [(n-1):0] RAM[0:(2**r-1)];

    assign readdata = RAM[addr];

    initial $readmemh("../programs/mult-prog_exe", RAM);

endmodule
`endif