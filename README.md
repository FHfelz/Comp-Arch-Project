# ECE251 - Comp Arc Final Project
# BY Fatin Hoque, Ishmam Raiyan

## Description
This Computer Architecture project applies a 32-bit single-cycle CPU using SystemVerilog. The design is based on the ISA structure and uses it to support R, I, and J-type instructions. The Verilog-based CPU can execute arithmetic, control flow, logic, and memory instructions.

# CPU Design and Documentation

## Overall Design Diagram
<img width="648" height="419" alt="Raiyan_Comp_Arc_ DesignDiagram" src="https://github.com/user-attachments/assets/cb17c151-aeab-4a94-8ffc-f9d8f1720f9a" />

## Overall Design Explanation

### 1. Instruction Fetch
Instructions are received from the memory, and the addresses are prepared for the next instruction.
1. The Program Counter contains the memory address of the current instruction.
2. The Instruction Memory receives the PC address and outputs a 32-bit instruction.
3. PC Update Logic
   -  Add unit increments PC (+4) to point to the next sequential instruction.
   -  SHIFT Left 2 calculates the branch offset.
   -  MUX selects between the sequential address (PC + 4) and the branch target address based on the PCSRC signal.

### 2. Instruction Decode / Register read
The processor splits the 32-bit instruction into specific fields for controlling hardware.
1. The Control unit takes the opcode (Instruction [31-26]) and generates all relevant control signals: ALUOp, Branch, MemRead, MemtoReg, MemWrite, RegDst, and RegWrite.
2. Register files:
   - Uses bits  [25-21] and [20-16] for selecting source registers.
   - Outputs 2 different pieces of data (Read Datas 1 and 2).
3. The Sign Extend converts a 16-bit immediate value (Instruction [15-0]) to a 32-bit value for the ALU to process it.

### 3. Execute
Where actual arithmetic or logical operations happen.
1. AL MUX: multiplexer decides whether ALu's second operand comes from the register file (R-type instructions, e.g., add) or Sign-Extended immediate values. (I-type instructions, e.g., addi)
2. ALU: Performs operations dictated by the ALU Control unit
3. ALU Result: Output can be used as a calculated value or as a memory address for the next stage.
4. Zero Flag: ALU outputs  "Zero" signal, which is used in conjunction with the Branch control signal to determine if a conditional branch (e.g., beq) should be taken.

### 4. Memory Acess
Only active for instructions that interact with data memory (Load/ Store).
1. Data Memory: Uses ALU Result as Address.
2. Read/Write: Controlled by MemRead and MemWrite signals. If a load instruction occurs, data is read from the memory. If a store instruction occurs, data from the Register File is written to memory.

### 5. Write Back
Final part, writes the result back to the Register File
1. MemtoReg MUX: Multiplexer selects whether data written to the destination register comes from ALU Results (arithmetic Operations or Data Memory (load operations)).
2. RegWrite: Control Unit enables a signal to ensure the result is saved in the correct register.

## Test Benches
There are test benches for every program used to make the CPU, including the adder.sv, alu.sv, aludec.sv, cluck.sv, computer.sv, controller.sv, cpu.sv, datapath.sv, dff.sv, dmem.sv, imem.sv, maindec.sv, mux2.sv, regfile.sv signext.sv, and the sl2.sv. These testbenches are all written in Verilog and used to verify that each program for the different parts of the CPU works.

# How to Demo code:
//Step 1:

iverilog -g2012 -o sim tb_computer.sv ../computer/computer.sv ../datapath/datapath.sv ../cpu/cpu.sv ../controller/controller.sv ../imem/imem.sv ../dmem/dmem.sv ../adder/adder.sv ../alu/alu.sv ../regfile/regfile.sv ../dff/dff.sv ../sl2/sl2.sv ../mux2/mux2.sv ../signext/signext.sv

//Step 2:

vvp sim

//Step 3 (NEEDED for viewing RIJ Graphs):

gtkwave waves.vcd
