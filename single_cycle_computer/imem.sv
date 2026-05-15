//Made by Fatin Hoque, Edited by Ishmam Raiyan

`ifndef IMEM
`define IMEM
`timescale 1ns/100ps

module imem #(parameter n = 32, parameter r = 6)(
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] readdata);

    logic [(n-1):0] RAM[0:(2**r-1)];

    // Initialize RAM with zeros so it isn't 'x' if the program is short
    initial begin
        for (int i = 0; i < (2**r); i++) RAM[i] = '0;
        $readmemh("../programs/mult-prog_exe", RAM);
    end

    assign readdata = RAM[addr]; 

endmodule
`endif
