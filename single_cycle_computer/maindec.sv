
// By Fatin Hoque
`ifndef MAINDEC
`define MAINDEC
`timescale 1ns/100ps

module maindec #(parameter n = 32)(
    input  logic [5:0] op,
    output logic       jump,
    output logic       memtoreg,
    output logic       memwrite,
    output logic       branch,
    output logic       alusrc,
    output logic       regdst,
    output logic       regwrite,
    output logic [1:0] aluop);

    logic [8:0] controls;

    assign {regwrite, regdst, alusrc, branch, memwrite,
            memtoreg, jump, aluop} = controls;

    always_comb begin
        if      (op == 6'b000000) controls = 9'b110000010; // RTYPE
        else if (op == 6'b100011) controls = 9'b101001000; // LW
        else if (op == 6'b101011) controls = 9'b001010000; // SW
        else if (op == 6'b000100) controls = 9'b000100001; // BEQ
        else if (op == 6'b001000) controls = 9'b101000000; // ADDI
        else if (op == 6'b000010) controls = 9'b000000100; // J
        else                      controls = 9'bxxxxxxxxx;
    end

endmodule
`endif