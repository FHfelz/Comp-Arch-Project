
// FH
`ifndef TB_SL2
`define TB_SL2
`timescale 1ns/100ps
`include "sl2.sv"

module tb_sl2;
    parameter n = 32;

    logic [(n-1):0] a, y;

    sl2 uut(.A(a), .Y(y));

    initial begin
        $dumpfile("sl2.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t a=%b y=%b", $realtime, a, y);

        a = n'h0000000F; #10;
        a = n'h80000000; #10;
        a = n'hFFFFFFFF; #10;
        a = n'h00000001; #10;

        $finish;
    end

endmodule
`endif