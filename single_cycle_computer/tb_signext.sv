
// FH
`ifndef TB_SIGNEXT
`define TB_SIGNEXT
`timescale 1ns/100ps
`include "signext.sv"

module tb_signext;
    parameter n = 32;
    parameter i = n/2;

    logic [(i-1):0] a;
    logic [(n-1):0] y;

    signext uut(.A(a), .Y(y));

    initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t a=%b y=%b", $realtime, a, y);

        // positive number (MSB=0, should zero-extend)
        a = i'h0001; #10;
        a = i'h7FFF; #10;
        // negative number (MSB=1, should sign-extend)
        a = i'h8000; #10;
        a = i'hFFFF; #10;

        $finish;
    end

endmodule
`endif