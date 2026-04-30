//FH
`ifndef TB_CPU
`define TB_CPU
`timescale 1ns/100ps
`include "cpu.sv"

module tb_cpu;
    parameter n = 32;

    logic           clk, reset;
    logic [n-1:0]   instr, readdata;
    logic [n-1:0]   pc, aluout, writedata;
    logic           memwrite;

    cpu uut(.clk(clk), .reset(reset),
            .instr(instr), .readdata(readdata),
            .pc(pc), .memwrite(memwrite),
            .aluout(aluout), .writedata(writedata));

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, uut);
        $monitor("t=%t clk=%b reset=%b pc=0x%8h instr=0x%8h aluout=0x%8h writedata=0x%8h memwrite=%b",
                  $realtime, clk, reset, pc, instr, aluout, writedata, memwrite);
        clk = 0;

        // reset
        reset = 1; instr = 32'h0; readdata = 32'h0; #10;
        reset = 0;

        // ADDI $t0, $zero, 5  (op=001000, rs=00000, rt=01000, imm=0005)
        instr = 32'b001000_00000_01000_0000000000000101; #10;
        // ADDI $t1, $zero, 3
        instr = 32'b001000_00000_01001_0000000000000011; #10;
        // ADD $v0, $t0, $t1  (op=000000, rs=01000, rt=01001, rd=00010, funct=100000)
        instr = 32'b000000_01000_01001_00010_00000_100000; #10;
        // SW $v0, 84($zero)
        instr = 32'b101011_00000_00010_0000000001010100; #10;

        $finish;
    end

    always #5 clk = ~clk;

endmodule
`endif