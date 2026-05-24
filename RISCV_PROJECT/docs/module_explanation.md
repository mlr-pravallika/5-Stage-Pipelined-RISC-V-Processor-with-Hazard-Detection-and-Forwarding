# Module Explanations

## 1. Program Counter (PC)

The Program Counter module is responsible for maintaining the address of the current instruction being executed in the processor. On every clock cycle, the PC updates to the next instruction address unless a stall condition occurs.

### Inputs
- clk
- reset
- next_pc

### Outputs
- pc

### Functionality
- Initializes PC to zero during reset
- Increments instruction address sequentially
- Supports pipeline stalling during hazards

---

## 2. Instruction Memory

The Instruction Memory module stores the processor instructions and provides the instruction corresponding to the current Program Counter value.

### Inputs
- address

### Outputs
- instruction

### Functionality
- Fetches instructions during IF stage
- Provides instruction data to IF/ID pipeline register
- Simulates instruction storage for processor execution

---

## 3. IF/ID Pipeline Register

The IF/ID pipeline register stores the fetched instruction and Program Counter value between the Instruction Fetch and Instruction Decode stages.

### Functionality
- Transfers instruction safely between stages
- Maintains synchronization of pipeline data
- Supports pipeline stalling during hazard detection

---

## 4. Register File

The Register File stores general-purpose registers used by the processor. It supports simultaneous reading of two registers and writing into one register.

### Features
- Two read ports
- One write port
- 32-bit register architecture

### Functionality
- Reads source operands for ALU operations
- Writes results back during WB stage
- Supports RISC-V register operations

---

## 5. Control Unit

The Control Unit decodes the instruction opcode and generates the required control signals for different processor stages.

### Outputs
- ALUControl
- RegWrite
- MemRead
- MemWrite
- MemtoReg

### Functionality
- Controls processor datapath
- Determines ALU operation type
- Controls memory and register access operations

---

## 6. ID/EX Pipeline Register

The ID/EX pipeline register transfers decoded instruction data, operands, and control signals from the Decode stage to the Execute stage.

### Functionality
- Stores register operands
- Stores ALU control signals
- Synchronizes EX stage execution

---

## 7. Arithmetic Logic Unit (ALU)

The ALU performs arithmetic and logical operations required during instruction execution.

### Supported Operations
- ADD
- SUB
- AND
- OR

### Functionality
- Executes arithmetic instructions
- Generates ALU results
- Supports forwarding operations for hazard resolution

---

## 8. EX/MEM Pipeline Register

The EX/MEM pipeline register stores ALU results and control signals between the Execute and Memory stages.

### Functionality
- Transfers ALU output to memory stage
- Stores destination register information
- Maintains pipeline synchronization

---

## 9. Data Memory

The Data Memory module performs memory read and write operations during load and store instructions.

### Functionality
- Supports memory access instructions
- Reads data from memory
- Writes data into memory
- Interfaces with MEM stage

---

## 10. MEM/WB Pipeline Register

The MEM/WB pipeline register transfers memory outputs and ALU results from the Memory stage to the Write Back stage.

### Functionality
- Stores memory read data
- Stores ALU computation results
- Transfers final execution data for register write-back

---

## 11. Hazard Detection Unit (HDU)

The Hazard Detection Unit detects data hazards occurring during pipeline execution and temporarily stalls the pipeline when necessary.

### Functionality
- Detects load-use hazards
- Prevents incorrect instruction execution
- Freezes Program Counter and IF/ID stage during stalls

### Benefits
- Improves processor correctness
- Avoids data corruption during execution

---

## 12. Forwarding Unit

The Forwarding Unit minimizes pipeline stalls by forwarding ALU results directly between pipeline stages.

### Functionality
- Detects data dependencies
- Forwards results from EX/MEM and MEM/WB stages
- Reduces performance loss caused by hazards

### Benefits
- Improves pipeline efficiency
- Reduces unnecessary stalls
- Enhances processor performance

---

# Summary

The complete processor design successfully integrates all five pipeline stages along with hazard handling mechanisms such as Hazard Detection and Data Forwarding. The modular Verilog implementation improves scalability, readability, and simulation-based verification using EDA Playground and EPWave.