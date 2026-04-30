
// Made by Fatin Hoque
`ifndef COMPUTER
`define COMPUTER
`timescale 1ns/100ps
`include "cpu.sv"
`include "imem.sv"
`include "dmem.sv"

module computer #(parameter n = 32)(
    input  logic           clk,
    input  logic           reset,
    output logic [(n-1):0] dataadr,
    output logic [(n-1):0] writedata,
    output logic           memwrite);

    logic [(n-1):0] pc, instr, readdata;

    dmem dmem(clk, memwrite, dataadr, writedata, readdata);
    imem imem(pc[7:2], instr);
    cpu  mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);

endmodule
`endif