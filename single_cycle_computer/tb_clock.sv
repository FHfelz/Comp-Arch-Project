
// FH
`ifndef TB_CLOCK
`define TB_CLOCK
`timescale 1ns/100ps
`include "clock.sv"

module tb_clock;

    logic enable;
    wire  clk;

    clock uut(.ENABLE(enable), .CLOCK(clk));

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t enable=%b clk=%b", $realtime, enable, clk);
        enable = 0;
        #10  enable = 1;
        #100 enable = 0;
        $finish;
    end

endmodule
`endif