
// FH
`ifndef TB_COMPUTER
`define TB_COMPUTER
`timescale 1ns/100ps
`include "computer.sv"
`include "clock.sv"

module tb_computer;
    parameter n = 32;
    parameter m = 5;

    logic clk, clk_enable, reset;
    logic memwrite;
    logic [31:0] writedata, dataadr;
    logic firstTest, secondTest;

    computer dut(clk, reset, writedata, dataadr, memwrite);
    clock    dut1(.ENABLE(clk_enable), .CLOCK(clk));

    initial begin
        firstTest  = 1'b0;
        secondTest = 1'b0;
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, dut1, clk, reset, writedata, dataadr, memwrite);
        $monitor("t=%t\t0x%7h\t%7d\t%8d", $realtime, writedata, dataadr, memwrite);
    end

    initial begin
        clk_enable = 0;
        #50 reset = 1;
        #50 reset = 0;
        #50 clk_enable = 1;
        #100 $finish;
    end

    always @(posedge clk) begin
        $display("+");
        $display("\t+instr       = 0x%8h", dut.instr);
        $display("\t+op          = 0b%6b", dut.mips.c.op);
        $display("\t+controls    = 0b%9b", dut.mips.c.md.controls);
        $display("\t+funct       = 0b%6b", dut.mips.c.ad.funct);
        $display("\t+aluop       = 0b%2b", dut.mips.c.ad.aluop);
        $display("\t+alucontrol  = 0b%3b", dut.mips.c.ad.alucontrol);
        $display("\t+alu result  = 0x%8h", dut.mips.dp.alu.result);
        $display("\t+HiLo        = 0x%8h", dut.mips.dp.alu.HiLo);
        $display("\t+$v0 = 0x%4h", dut.mips.dp.rf.rf[2]);
        $display("\t+$v1 = 0x%4h", dut.mips.dp.rf.rf[3]);
        $display("\t+$a0 = 0x%4h", dut.mips.dp.rf.rf[4]);
        $display("\t+$a1 = 0x%4h", dut.mips.dp.rf.rf[5]);
        $display("\t+$t0 = 0x%4h", dut.mips.dp.rf.rf[8]);
        $display("\t+$t1 = 0x%4h", dut.mips.dp.rf.rf[9]);
        $display("\t+ra1=%d ra2=%d we3=%d wa3=%d wd3=%d rd1=%d rd2=%d",
            dut.mips.dp.rf.ra1, dut.mips.dp.rf.ra2,
            dut.mips.dp.rf.we3, dut.mips.dp.rf.wa3,
            dut.mips.dp.rf.wd3, dut.mips.dp.rf.rd1,
            dut.mips.dp.rf.rd2);
        $display("\t+RAM[%4d] = %4d", dut.dmem.addr, dut.dmem.readdata);
        $display("writedata\tdataadr\tmemwrite");
    end

    always @(negedge clk) begin
        $display("-");
        $display("\t-instr       = 0x%8h", dut.instr);
        $display("\t-op          = 0b%6b", dut.mips.c.op);
        $display("\t-controls    = 0b%9b", dut.mips.c.md.controls);
        $display("\t-funct       = 0b%6b", dut.mips.c.ad.funct);
        $display("\t-aluop       = 0b%2b", dut.mips.c.ad.aluop);
        $display("\t-alucontrol  = 0b%3b", dut.mips.c.ad.alucontrol);
        $display("\t-alu result  = 0x%8h", dut.mips.dp.alu.result);
        $display("\t-HiLo        = 0x%8h", dut.mips.dp.alu.HiLo);
        $display("\t-$v0 = 0x%4h", dut.mips.dp.rf.rf[2]);
        $display("\t-$v1 = 0x%4h", dut.mips.dp.rf.rf[3]);
        $display("\t-$a0 = 0x%4h", dut.mips.dp.rf.rf[4]);
        $display("\t-$a1 = 0x%4h", dut.mips.dp.rf.rf[5]);
        $display("\t-$t0 = 0x%4h", dut.mips.dp.rf.rf[8]);
        $display("\t-$t1 = 0x%4h", dut.mips.dp.rf.rf[9]);
        $display("\t-ra1=%d ra2=%d we3=%d wa3=%d wd3=%d rd1=%d rd2=%d",
            dut.mips.dp.rf.ra1, dut.mips.dp.rf.ra2,
            dut.mips.dp.rf.we3, dut.mips.dp.rf.wa3,
            dut.mips.dp.rf.wd3, dut.mips.dp.rf.rd1,
            dut.mips.dp.rf.rd2);
        $display("\t-RAM[%4d] = %4d", dut.dmem.addr, dut.dmem.readdata);
        $display("writedata\tdataadr\tmemwrite");
    end

    always @(negedge clk, posedge clk) begin
        if (dut.dmem.RAM[21] === 32'h96) begin
            $display("Successfully wrote 0x%4h at RAM[%3d]", 84, 32'h0096);
            firstTest = 1'b1;
        end
        if (memwrite && dataadr === 84 && writedata === 32'h96) begin
            $display("Successfully wrote 0x%4h at RAM[%3d]", writedata, dataadr);
            firstTest = 1'b1;
        end
        if (firstTest === 1'b1) begin
            $display("Program successfully completed");
            $finish;
        end
    end

endmodule
`endif