//FH
`ifndef TB_DATAPATH
`define TB_DATAPATH
`timescale 1ns/100ps
`include "datapath.sv"

module tb_datapath;
    parameter n = 32;

    logic           clk, reset;
    logic           memtoreg, pcsrc;
    logic           alusrc, regdst;
    logic           regwrite, jump;
    logic [3:0]     alucontrol;
    logic [n-1:0]   instr, readdata;
    logic           zero;
    logic [n-1:0]   pc, aluout, writedata;

    datapath uut(.clk(clk), .reset(reset),
                 .memtoreg(memtoreg), .pcsrc(pcsrc),
                 .alusrc(alusrc), .regdst(regdst),
                 .regwrite(regwrite), .jump(jump),
                 .alucontrol(alucontrol),
                 .instr(instr), .readdata(readdata),
                 .zero(zero), .pc(pc),
                 .aluout(aluout), .writedata(writedata));

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, uut);
        $monitor("t=%t clk=%b pc=0x%8h aluout=0x%8h writedata=0x%8h zero=%b",
                  $realtime, clk, pc, aluout, writedata, zero);
        clk = 0;

        // reset
        reset = 1; #10;
        reset = 0;

        // set control signals for ADDI $t0, $zero, 5
        memtoreg = 0; pcsrc  = 0; alusrc  = 1;
        regdst   = 0; regwrite = 1; jump  = 0;
        alucontrol = 4'b0010;
        instr    = 32'b001000_00000_01000_0000000000000101;
        readdata = 32'h0; #10;

        // set control signals for ADD $v0, $t0, $t1
        memtoreg = 0; pcsrc  = 0; alusrc  = 0;
        regdst   = 1; regwrite = 1; jump  = 0;
        alucontrol = 4'b0010;
        instr    = 32'b000000_01000_01001_00010_00000_100000;
        readdata = 32'h0; #10;

        // set control signals for LW $t1, 0($zero)
        memtoreg = 1; pcsrc  = 0; alusrc  = 1;
        regdst   = 0; regwrite = 1; jump  = 0;
        alucontrol = 4'b0010;
        instr    = 32'b100011_00000_01001_0000000000000000;
        readdata = 32'hDEADBEEF; #10;

        $finish;
    end

    always #5 clk = ~clk;

endmodule
`endif