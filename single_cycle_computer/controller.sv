
// By Fatin Hoque
`ifndef CONTROLLER
`define CONTROLLER
`timescale 1ns/100ps
`include "maindec.sv"
`include "aludec.sv"

module controller #(parameter n = 32)(
    input  logic [5:0] op,
    input  logic [5:0] funct,
    input  logic       zero,
    output logic       jump,
    output logic       memtoreg,
    output logic       memwrite,
    output logic       alusrc,
    output logic       regdst,
    output logic       regwrite,
    output logic       pcsrc,
    output logic [3:0] alucontrol);

    logic [1:0] aluop;
    logic       branch;
    logic       regwrite_md;

    logic mult_or_div;
    assign mult_or_div = (op == 6'b000000) && (funct == 6'b011000 || funct == 6'b011010);
    assign regwrite    = regwrite_md & ~mult_or_div;
    assign pcsrc       = branch & zero;

    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite_md, jump, aluop);
    aludec  ad(funct, aluop, alucontrol);

endmodule
`endif