
// By Fatin Hoque and Ishmam

`ifndef CPU
`define CPU
`timescale 1ns/100ps
`include "controller.sv"
`include "datapath.sv"

module cpu #(parameter n = 32)(
    input  logic           clk,
    input  logic           reset,
    input  logic [(n-1):0] instr,
    input  logic [(n-1):0] readdata,
    output logic [(n-1):0] pc,
    output logic           memwrite,
    output logic [(n-1):0] aluout,
    output logic [(n-1):0] writedata);

    logic       zero, memtoreg, alusrc;
    logic       regdst, regwrite, jump, pcsrc;
    logic [3:0] alucontrol;

    datapath dp(clk, reset, memtoreg, pcsrc,
                alusrc, regdst, regwrite, jump,
                alucontrol, zero, pc, instr,
                aluout, writedata, readdata);

    controller c(instr[31:26], instr[5:0], zero,
                 memtoreg, memwrite, pcsrc,
                 alusrc, regdst, regwrite, jump,
                 alucontrol);

endmodule
`endif