// FH
`ifndef TB_MAINDEC
`define TB_MAINDEC
`timescale 1ns/100ps
`include "maindec.sv"

module tb_maindec;
    parameter n = 32;

    logic [5:0] op;
    logic       jump, memtoreg, memwrite;
    logic       branch, alusrc, regdst, regwrite;
    logic [1:0] aluop;

    maindec uut(.op(op), .jump(jump), .memtoreg(memtoreg), .memwrite(memwrite),
                .branch(branch), .alusrc(alusrc), .regdst(regdst),
                .regwrite(regwrite), .aluop(aluop));

    initial begin
        $dumpfile("maindec.vcd");
        $dumpvars(0, uut);
        $monitor("op=%b | regwrite=%b regdst=%b alusrc=%b branch=%b memwrite=%b memtoreg=%b jump=%b aluop=%b",
                  op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop);

        op = 6'b000000; #10; // RTYPE
        op = 6'b100011; #10; // LW
        op = 6'b101011; #10; // SW
        op = 6'b000100; #10; // BEQ
        op = 6'b001000; #10; // ADDI
        op = 6'b000010; #10; // J
        op = 6'b111111; #10; // illegal

        $finish;
    end

endmodule
`endif