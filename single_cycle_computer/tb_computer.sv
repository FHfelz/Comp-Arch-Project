// Fatin Hoque
// Edited by Ishmam Raiyan
`timescale 1ns/100ps


`include "../computer/computer.sv"
`include "../clock/clock.sv"

module tb_computer;

    parameter n = 32;

    logic clk;
    logic reset;
    logic clk_enable;

    logic [(n-1):0] dataadr;
    logic [(n-1):0] writedata;
    logic memwrite;

    computer #(n) dut (
        .clk(clk),
        .reset(reset),
        .dataadr(dataadr),    // Connected to DUT output
        .writedata(writedata), // Connected to DUT output
        .memwrite(memwrite)   // Connected to DUT output
    );

  
    clock #(10) clk_gen (
        .ENABLE(clk_enable),
        .CLOCK(clk)
    );

    initial begin
        // Setup for Waveform dumping
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_computer);

        clk_enable = 0;
        reset = 1;     
        
        #50;
        reset = 0;      
        #20;
        clk_enable = 1; 

        #5000;          
        $display("Simulation Finished.");
        $finish;
    end

endmodule
