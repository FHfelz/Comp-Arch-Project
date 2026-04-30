
// Fatin Hoque
`ifndef DFF
`define DFF
`timescale 1ns/100ps

module dff #(parameter n = 32)(
    input  logic           CLOCK,
    input  logic           RESET,
    input  logic [(n-1):0] D,
    output logic [(n-1):0] Q);

    always_ff @(posedge CLOCK or posedge RESET) begin
        if (RESET) Q <= '0;
        else       Q <= D;
    end

endmodule
`endif