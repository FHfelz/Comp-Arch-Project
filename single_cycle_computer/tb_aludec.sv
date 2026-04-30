//FH
`ifndef TB_ALUDEC
`define TB_ALUDEC
`timescale 1ns/100ps
`include "aludec.sv"

module tb_aludec;
    parameter n = 32;

    logic [5:0] funct;
    logic [1:0] aluop;
    logic [3:0] alucontrol;

    aludec uut(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));

    initial begin
        $dumpfile("aludec.vcd");
        $dumpvars(0, uut);
        $monitor("aluop=%b funct=%b alucontrol=%b", aluop, funct, alucontrol);

        // LW/SW/ADDI (aluop=00 -> add)
        aluop = 2'b00; funct = 6'bxxxxxx; #10;
        // BEQ (aluop=01 -> sub)
        aluop = 2'b01; funct = 6'bxxxxxx; #10;
        // R-type
        aluop = 2'b10;
        funct = 6'b100000; #10; // add
        funct = 6'b100010; #10; // sub
        funct = 6'b100100; #10; // and
        funct = 6'b100101; #10; // or
        funct = 6'b100111; #10; // nor
        funct = 6'b101010; #10; // slt
        funct = 6'b011000; #10; // mult
        funct = 6'b011010; #10; // div
        funct = 6'b010010; #10; // mflo
        funct = 6'b010000; #10; // mfhi

        $finish;
    end

endmodule
`endif