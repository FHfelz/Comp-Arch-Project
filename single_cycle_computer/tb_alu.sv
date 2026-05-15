//FH
`include "../alu/alu.sv"

`ifndef TB_ALU
`define TB_ALU
`timescale 1ns/100ps


module tb_alu;
    parameter n = 32;

    logic           clk;
    logic [n-1:0]   a, b;
    logic [3:0]     alucontrol;
    logic [n-1:0]   result;
    logic           zero;

    alu uut(.clk(clk), .a(a), .b(b), .alucontrol(alucontrol), .result(result), .zero(zero));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, uut);
        $monitor("a=0x%0h b=0x%0h alucontrol=%b result=0x%0h zero=%b", a, b, alucontrol, result, zero);

        clk = 0;

        // AND
        a = 32'hFFFFFFFF; b = 32'h0F0F0F0F; alucontrol = 4'b0000; #10;
        // OR
        a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; alucontrol = 4'b0001; #10;
        // ADD
        a = 32'h00000001; b = 32'h00000001; alucontrol = 4'b0010; #10;
        // NOR
        a = 32'hFFFFFFFF; b = 32'h00000000; alucontrol = 4'b0011; #10;
        // SUB
        a = 32'h00000005; b = 32'h00000005; alucontrol = 4'b0110; #10;
        // SLT
        a = 32'h00000001; b = 32'h00000002; alucontrol = 4'b0111; #10;
        // MULT
        a = 32'h00000003; b = 32'h00000004; alucontrol = 4'b1000; #10;
        // MFLO
        alucontrol = 4'b0100; #10;
        // MFHI
        alucontrol = 4'b0101; #10;
        // DIV
        a = 32'h00000009; b = 32'h00000002; alucontrol = 4'b1001; #10;
        // MFLO
        alucontrol = 4'b0100; #10;
        // MFHI
        alucontrol = 4'b0101; #10;

        $finish;
    end

    always #5 clk = ~clk;

endmodule
`endif
