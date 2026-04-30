//FH
`ifndef TB_CONTROLLER
`define TB_CONTROLLER
`timescale 1ns/100ps
`include "controller.sv"

module tb_controller;
    parameter n = 32;

    logic [5:0] op, funct;
    logic       zero;
    logic       jump, memtoreg, memwrite;
    logic       alusrc, regdst, regwrite, pcsrc;
    logic [3:0] alucontrol;

    controller uut(.op(op), .funct(funct), .zero(zero),
                   .jump(jump), .memtoreg(memtoreg), .memwrite(memwrite),
                   .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite),
                   .pcsrc(pcsrc), .alucontrol(alucontrol));

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, uut);
        $monitor("op=%b funct=%b zero=%b | regwrite=%b regdst=%b alusrc=%b memwrite=%b memtoreg=%b jump=%b pcsrc=%b alucontrol=%b",
                  op, funct, zero, regwrite, regdst, alusrc, memwrite, memtoreg, jump, pcsrc, alucontrol);

        // RTYPE add
        op = 6'b000000; funct = 6'b100000; zero = 0; #10;
        // RTYPE sub
        op = 6'b000000; funct = 6'b100010; zero = 0; #10;
        // RTYPE mult
        op = 6'b000000; funct = 6'b011000; zero = 0; #10;
        // RTYPE div
        op = 6'b000000; funct = 6'b011010; zero = 0; #10;
        // LW
        op = 6'b100011; funct = 6'bxxxxxx; zero = 0; #10;
        // SW
        op = 6'b101011; funct = 6'bxxxxxx; zero = 0; #10;
        // BEQ not taken
        op = 6'b000100; funct = 6'bxxxxxx; zero = 0; #10;
        // BEQ taken
        op = 6'b000100; funct = 6'bxxxxxx; zero = 1; #10;
        // ADDI
        op = 6'b001000; funct = 6'bxxxxxx; zero = 0; #10;
        // J
        op = 6'b000010; funct = 6'bxxxxxx; zero = 0; #10;

        $finish;
    end

endmodule
`endif