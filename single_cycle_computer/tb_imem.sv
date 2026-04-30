
// FH
`ifndef TB_IMEM
`define TB_IMEM
`timescale 1ns/100ps
`include "imem.sv"

module tb_imem;
    parameter n = 32;
    parameter r = 6;

    logic [(n-1):0] readdata;
    logic [(r-1):0] imem_addr;

    imem uut(.addr(imem_addr), .readdata(readdata));

    initial begin
        $dumpfile("imem.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t imem_addr=%b readdata=%h", $realtime, imem_addr, readdata);

        imem_addr = r'b000000; #10;
        imem_addr = r'b000001; #10;
        imem_addr = r'b000010; #10;
        $finish;
    end

endmodule
`endif