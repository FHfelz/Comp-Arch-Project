# ECE251 - Comp Arc Final Project
# BY Fatin Hoque, Ishmam Raiyan

## Description
The Computer Architecture projects applies a 32 bit single-cycle CPU using SystemVerilog. The design is based on the ISA strucure and uses it to suports R, I, J -type instructions. The Verilog based CPU is able to execute aritmetic, control flow, logic, and memory instructions.

# CPU Design and Documentation

## Overall Design Diagram
<img width="648" height="419" alt="Raiyan_Comp_Arc_ DesignDiagram" src="https://github.com/user-attachments/assets/cb17c151-aeab-4a94-8ffc-f9d8f1720f9a" />

## Overall Design Explanation

### 1. Instruction Fetch
Retrieves instruction from memory and prepares address for the next instruction.
1. Program Counter: Holds current instruction's memory adress.
2. Instruction Memory: Recieves PC adress/ outputs 32-bit instruction.
3. Program Counter
   -  Add unit increments PC (+4) to point to next sequential instruction.
   -  SHIFT Left 2 calculates branch offset.
   -  MUX selects between sequential adress (PC + 4) and branch target adress based on PCSRC signal.

### 2. Instruction Decode / Register read
Processor splits the 32 bit instruction to specific fields to control hardware.
1. Control unit: Takes opcode (Instruction [31-26]) and generates all relevant control signals: ALUOp, Branch, MemRead, MemtoReg, MemWrite, RegDst, and RegWrite.
2. Register files:
   - Uses bits  [25-21] and [20-16] for selecting source registers.
   - Outputs 2 pieces of data (Read Data 1/2).
3. Sign Extend: Converts 16-bit immediate value (Instruction [15-0]) to 32-bit value in order for it to be processed by ALU.

### 3. Execute
Where actual arithmetic or logic opperations happen.
1. AL MUX: multiplexer decides whether ALu's second opperand come from register file (R-type instructions. Ex. add) or Sign Extended immediate values. (I-type instructions. Ex. addi
2. ALU: PReforms opperations dictated by ALU Control unit
3. ALU Result: Output can be used as a calculated value or as a memory adress for next stage.
4. Zera Flag: ALU outputs  "Zero" signa, which is used for conjuction with Branch control signal to determine if conditional branch (Ex. beq) should be taken.

### 4. Memory Acess
Only active for instructions that interact with data memory (Load/ Store).
1. Data Memory: Uses ALU Result as Address.
2. Read/Write: Controlled by MemRead and MemWrite signals. If Load instruction -> data is read for memory, if store instruction -> data from Register File is written to memory.

### 5. Write Back
Final part, writes result back to Register File
1. MemtoReg MUX: Multiplexer selects wheter data written to destintion register comes from ALU Results (arithmetic Operations or Data Memory (load opperations).
2. RegWrite: Control Unit enables signal to ensure result is saved in correct register.

# How to Demo code:
//Step 2:
iverilog -g2012 -o sim tb_computer.sv ../computer/computer.sv ../datapath/datapath.sv ../cpu/cpu.sv ../controller/controller.sv ../imem/imem.sv ../dmem/dmem.sv ../adder/adder.sv ../alu/alu.sv ../regfile/regfile.sv ../dff/dff.sv ../sl2/sl2.sv ../mux2/mux2.sv ../signext/signext.sv
//Step 2:
vvp sim

//Step 3 (NEEDED for viewing RIJ Graphs:
gtkwave waves.vcd
