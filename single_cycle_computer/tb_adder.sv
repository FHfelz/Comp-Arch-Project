
// FH
`ifndef TB_ADDER
`define TB_ADDER
`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter n = 32;

    logic [(n-1):0] a, b, y;

    adder uut(.A(a), .B(b), .Y(y));

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, uut);
        a = n'hFFFFFFFF;
        b = n'hFFFFFFFF;
        $monitor("a = 0x%0h b = 0x%0h y = 0x%0h", a, b, y);
    end

endmodule
`endif