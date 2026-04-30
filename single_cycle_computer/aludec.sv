
// Made by Fatin Hoque

`ifndef ALUDEC
`define ALUDEC
`timescale 1ns/100ps

module aludec #(parameter n = 32)(
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [3:0] alucontrol);

    always_comb begin
        if (aluop == 2'b00)
            alucontrol = 4'b0010;
        else if (aluop == 2'b01)
            alucontrol = 4'b0110;
        else begin
            if      (funct == 6'b100000) alucontrol = 4'b0010; // add
            else if (funct == 6'b100010) alucontrol = 4'b0110; // sub
            else if (funct == 6'b100100) alucontrol = 4'b0000; // and
            else if (funct == 6'b100101) alucontrol = 4'b0001; // or
            else if (funct == 6'b101010) alucontrol = 4'b0111; // slt
            else if (funct == 6'b100111) alucontrol = 4'b0011; // nor
            else if (funct == 6'b010000) alucontrol = 4'b0101; // mfhi
            else if (funct == 6'b010010) alucontrol = 4'b0100; // mflo
            else if (funct == 6'b011000) alucontrol = 4'b1000; // mult
            else if (funct == 6'b011010) alucontrol = 4'b1001; // div
            else                         alucontrol = 4'bxxxx;
        end
    end

endmodule
`endif