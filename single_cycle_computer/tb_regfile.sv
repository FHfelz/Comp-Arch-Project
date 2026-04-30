// FH
`ifndef TB_REGFILE
`define TB_REGFILE
`timescale 1ns/100ps
`include "regfile.sv"
`include "clock.sv"

module tb_regfile;
    parameter n = 32;
    parameter r = 5;

    logic           clk, enable;
    logic           we3;
    logic [(r-1):0] ra1, ra2, wa3;
    logic [(n-1):0] wd3;
    logic [(n-1):0] rd1, rd2;

    regfile uut(.clk(clk), .we3(we3), .wa3(wa3),
                .ra1(ra1), .ra2(ra2), .wd3(wd3),
                .rd1(rd1), .rd2(rd2));
    clock   uut1(.ENABLE(enable), .CLOCK(clk));

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, uut, uut1);
        $monitor("time=%0t we3=%b wa3=%d wd3=%h ra1=%d rd1=%h ra2=%d rd2=%h",
                  $realtime, we3, wa3, wd3, ra1, rd1, ra2, rd2);

        enable = 0;
        we3    = 0;
        wa3    = 0;
        wd3    = 0;
        ra1    = 0;
        ra2    = 0;
        #10 enable = 1;

        // write 0xDEADBEEF to $t0 (reg 8)
        wa3 = 5'd8;  wd3 = n'hDEADBEEF; we3 = 1; #10;
        we3 = 0; #10;

        // write 0x0000FFFF to $t1 (reg 9)
        wa3 = 5'd9;  wd3 = n'h0000FFFF; we3 = 1; #10;
        we3 = 0; #10;

        // read $t0 and $t1 simultaneously
        ra1 = 5'd8; ra2 = 5'd9; #10;

        // attempt write to $zero (reg 0) - should be ignored
        wa3 = 5'd0; wd3 = n'hFFFFFFFF; we3 = 1; #10;
        we3 = 0;
        ra1 = 5'd0; #10;

        #20 enable = 0;
        $finish;
    end

endmodule
`endif