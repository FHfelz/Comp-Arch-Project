
// By Fatin Hoque
`ifndef DATAPATH
`define DATAPATH
`timescale 1ns/100ps
`include "regfile.sv"
`include "alu.sv"
`include "dff.sv"
`include "adder.sv"
`include "sl2.sv"
`include "mux2.sv"
`include "signext.sv"

module datapath #(parameter n = 32)(
    input  logic           clk,
    input  logic           reset,
    input  logic           memtoreg,
    input  logic           pcsrc,
    input  logic           regdst,
    input  logic           alusrc,
    input  logic           regwrite,
    input  logic           jump,
    input  logic [3:0]     alucontrol,
    input  logic [(n-1):0] instr,
    input  logic [(n-1):0] readdata,
    output logic           zero,
    output logic [(n-1):0] pc,
    output logic [(n-1):0] aluout,
    output logic [(n-1):0] writedata);

    logic [4:0]     writereg;
    logic [(n-1):0] srca, srcb, result;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] pcnext, pcnextbr, pcplus4, pcbranch;

    signext     se(instr[15:0], signimm);
    sl2         immsh(signimm, signimmsh);

    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, 32'b100, pcplus4);
    adder       pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(n)   pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

    mux2 #(5)   wrmux(instr[20:16], instr[15:11], regdst, writereg);
    regfile     rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);

    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(clk, srca, srcb, alucontrol, aluout, zero);

endmodule
`endif