// Engineer: Fatin Hoque 
`ifndef ALU_SV
`define ALU_SV

`timescale 1ns/100ps

module alu
#(parameter n = 32)
(
    input  logic               clk,
    input  logic [n-1:0]       a, b,
    input  logic [3:0]         alucontrol,
    output logic [n-1:0]       result,
    output logic               zero
);

    // ------------------------------------------------------------
    // Internal signals
    // ------------------------------------------------------------
    logic [n-1:0] condinvb;
    logic [n-1:0] sumSlt;
    logic [2*n-1:0] HiLo;

    // ------------------------------------------------------------
    // Combinatorics
    // ------------------------------------------------------------
    assign condinvb = alucontrol[2] ? ~b : b;
    assign sumSlt   = a + condinvb + alucontrol[2];
    assign zero      = (result == {n{1'b0}});

    // ------------------------------------------------------------
    // Multiplication/Division storage (Hi/Lo register)
    // ------------------------------------------------------------
    initial begin
        HiLo = {(2*n){1'b0}};
    end

    // ------------------------------------------------------------
    // Main ALU operation
    // ------------------------------------------------------------
    always @(*) begin
        case (alucontrol)
            4'b0000: result = a & b;                 // AND
            4'b0001: result = a | b;                 // OR
            4'b0010: result = a + b;                 // ADD
            4'b0011: result = ~(a | b);              // NOR
            4'b0100: result = HiLo[n-1:0];           // MFLO
            4'b0101: result = HiLo[2*n-1:n];         // MFHI
            4'b0110: result = sumSlt;                // SUB

            4'b0111: begin                           // SLT
                if (a[n-1] != b[n-1]) begin
                    result = (a[n-1] > b[n-1]) ? 1 : 0; // Signed SLT logic
                end else begin
                    result = (a < b) ? 1 : 0;
                end
            end

            default: result = {n{1'bx}};
        endcase
    end

    // ------------------------------------------------------------
    // Sequential block for MULT/DIV operations
    // ------------------------------------------------------------
    always @(negedge clk) begin
        case (alucontrol)
            4'b1000: begin
                HiLo <= a * b;
            end
            4'b1001: begin
                if (b != 0) begin
                    HiLo[n-1:0]     <= a / b;
                    HiLo[2*n-1:n]   <= a % b;
                end
            end
            default: begin
                HiLo <= HiLo;
            end
        endcase
    end

endmodule

`endif
