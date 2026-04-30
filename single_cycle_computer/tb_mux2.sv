
// FH
`ifndef TB_MUX2
`define TB_MUX2
`timescale 1ns/100ps
`include "mux2.sv"
`include "clock.sv"

module tb_mux2;
    parameter n = 32;

    logic           s, enable;
    logic [(n-1):0] d0, d1, y;
    wire            clk;

    mux2  uut0(.S(s), .D0(d0), .D1(d1), .Y(y));
    clock uut1(.ENABLE(enable), .CLOCK(clk));

    initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, uut0, uut1);
        $monitor("time=%0t enable=%0b s=%0b y=%h d0=%h d1=%h", $realtime, enable, s, y, d0, d1);

        d0     = n'h80000000;
        d1     = n'h00000001;
        enable = 0;
        s      = 0;
        #10 enable = 1;
        #10 s      = 1'b0;
        #20 s      = 1'b1;
        #100 enable = 0;
        $finish;
    end

endmodule
`endif