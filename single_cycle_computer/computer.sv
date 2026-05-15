
// By Fatin Hoque 
//Edited By Ishmam Raiyan
`include "../controller/controller.sv"
`include "../datapath/datapath.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"
`include "../cpu/cpu.sv"

`ifndef COMPUTER
`define COMPUTER
`timescale 1ns/100ps

module computer #(parameter n = 32)(
    input  logic           clk,
    input  logic           reset,
    output logic [(n-1):0] dataadr,   // Output to the outside world
    output logic [(n-1):0] writedata, // Output to the outside world
    output logic           memwrite);

    logic [(n-1):0] pc, instr, readdata;

    // imem provides 'instr' based on 'pc'
    imem imem (
        .addr(pc[7:2]), 
        .readdata(instr)
    );

    // dmem receives 'dataadr' and 'writedata' from the CPU
    dmem dmem (
        .clk(clk), 
        .write_enable(memwrite), 
        .addr(dataadr), 
        .writedata(writedata), 
        .readdata(readdata)
    );

    // cpu drives 'aluout' (which maps to dataadr), 'writedata', and 'memwrite'
    cpu mips (
        .clk(clk), 
        .reset(reset), 
        .pc(pc), 
        .instr(instr), 
        .memwrite(memwrite), 
        .aluout(dataadr),    // CPU drives the address
        .writedata(writedata), // CPU drives the data
        .readdata(readdata)    // CPU receives data from memory
    );
endmodule
`endif
