# Verification and Simulation

## Simulation Environment

The complete 5-stage pipelined RISC-V processor was verified using industry-standard simulation tools on EDA Playground.

### Tools Used
- EDA Playground
- Icarus Verilog Compiler
- EPWave Waveform Viewer

### Purpose of Verification
The verification process was performed to ensure:
- Correct instruction execution
- Proper pipeline stage operation
- Accurate data propagation
- Correct hazard handling
- Successful forwarding operation
- Stable processor functionality without critical errors

---

# Compilation and Simulation Flow

The processor design was compiled using the Icarus Verilog simulator. All Verilog modules including pipeline registers, memory units, control logic, hazard detection, and forwarding logic were integrated and tested together using a dedicated testbench.

### Verification Flow
1. Designed individual processor modules
2. Verified each module independently
3. Integrated all pipeline stages
4. Connected pipeline registers
5. Added hazard detection logic
6. Added forwarding logic
7. Simulated the complete processor
8. Analyzed waveform outputs in EPWave

---

# Pipeline Verification

The processor pipeline was verified stage-by-stage to ensure proper instruction movement and synchronization.

## 1. Instruction Fetch (IF) Verification

Verified:
- Program Counter increment
- Instruction fetching from Instruction Memory
- Correct PC update behavior
- Stall handling during hazards

### Observed Signals
- pc_current
- pc_next
- instruction

---

## 2. Instruction Decode (ID) Verification

Verified:
- Instruction decoding
- Register operand reading
- Control signal generation
- IF/ID pipeline data transfer

### Observed Signals
- ifid_instruction
- read_data1
- read_data2
- alu_control

---

## 3. Execute (EX) Verification

Verified:
- ALU arithmetic and logical operations
- Operand forwarding
- Correct ALU result generation
- ID/EX pipeline register propagation

### Observed Signals
- idex_read_data1
- idex_read_data2
- alu_result
- exmem_alu_result

---

## 4. Memory Access (MEM) Verification

Verified:
- Data memory read/write operations
- EX/MEM pipeline transfer
- Memory stage synchronization

### Observed Signals
- mem_read_data
- exmem_mem_write

---

## 5. Write Back (WB) Verification

Verified:
- Register write-back operations
- MEM/WB pipeline transfer
- Final data propagation to Register File

### Observed Signals
- memwb_read_data
- memwb_alu_result
- memwb_reg_write

---

# Hazard Detection Verification

The Hazard Detection Unit (HDU) was tested to verify proper detection of data hazards occurring during pipeline execution.

### Verified Conditions
- Load-use hazards
- Pipeline stall generation
- Program Counter freeze operation
- IF/ID register stall behavior

### Result
The processor successfully detected hazards and prevented incorrect instruction execution by stalling the pipeline whenever required.

---

# Forwarding Unit Verification

The Forwarding Unit was verified to ensure efficient data forwarding between pipeline stages.

### Verified Operations
- EX/MEM forwarding
- MEM/WB forwarding
- ALU operand forwarding
- Data dependency resolution

### Result
The forwarding logic successfully minimized unnecessary stalls and improved pipeline efficiency.

---

# Waveform Analysis

EPWave waveform analysis was used to observe real-time processor behavior during simulation.

### Verified Through Waveforms
- Pipeline stage transitions
- Instruction propagation
- Register updates
- ALU execution
- Hazard stall signals
- Forwarding paths
- Memory operations

The waveform outputs confirmed correct synchronization and timing across all five pipeline stages.

---

# Final Verification Result

The complete 5-stage pipelined RISC-V processor was successfully simulated and verified without critical compilation or execution errors.

### Successfully Implemented Features
- 5-stage pipelined architecture
- Pipeline registers
- Program Counter logic
- Instruction Memory
- Register File
- Control Unit
- Arithmetic Logic Unit (ALU)
- Data Memory
- Hazard Detection Unit
- Forwarding Unit

### Conclusion

The processor achieved correct instruction flow, efficient hazard handling, successful forwarding operations, and stable pipeline execution. The modular Verilog HDL design was fully validated using waveform-based simulation in EDA Playground and EPWave.