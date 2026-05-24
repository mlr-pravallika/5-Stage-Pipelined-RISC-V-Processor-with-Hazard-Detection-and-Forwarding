🚀 5-Stage Pipelined RISC-V Processor with Hazard Detection and Forwarding

Verilog HDL implementation of a complete 5-stage pipelined RISC-V processor featuring Hazard Detection Unit (HDU), Forwarding Unit, pipeline registers, and EPWave waveform verification using EDA Playground.

📌 Project Overview

This project implements a complete 5-stage pipelined RISC-V processor using Verilog HDL.

The processor supports pipelined instruction execution with proper handling of data hazards through:

• Hazard Detection Unit (HDU).


• Forwarding Unit.


• Pipeline registers.


• Control logic.


• ALU operations.


• Instruction & Data Memory.



The design was verified using:


• EDA Playground.


• Icarus Verilog.


• EPWave.

This project demonstrates concepts of:


• Computer Architecture.


• Pipeline Processing.


• Hazard Handling.


• Data Forwarding.


• RTL Design.


• Digital System Verification.


✨ Features


✅ Complete 5-Stage Pipeline Architecture.
✅ IF, ID, EX, MEM, WB stages.
✅ Hazard Detection Unit (HDU).
✅ Forwarding Unit.
✅ Pipeline Registers.
✅ ALU Operations.
✅ Register File.
✅ Instruction Memory.
✅ Data Memory.
✅ Pipeline Synchronization.
✅ Waveform Verification using EPWave.
✅ Modular Verilog HDL Design.
✅ Recruiter-Ready Documentation.


🧠 Problem Statement

In pipelined processors, multiple instructions execute simultaneously across different stages.


This improves performance but introduces challenges such as:


• Data Hazards


• Pipeline Dependencies


• Incorrect instruction execution



Without hazard handling mechanisms, the processor may produce incorrect outputs.


💡 Solution


This project solves pipeline dependency issues using:


🔴 Hazard Detection Unit


Detects load-use hazards and temporarily stalls the pipeline.


🟢 Forwarding Unit


Forwards ALU results from later stages to earlier stages to avoid unnecessary stalls.


These mechanisms improve:


• Instruction throughput.


• Pipeline efficiency.


• Correct execution flow



🏗️ Processor Architecture:


Overall 5-Stage Pipeline Flow



Instruction Fetch (IF)

        ↓
Instruction Decode (ID)

        ↓
Execute (EX)

        ↓
Memory Access (MEM)

        ↓
Write Back (WB)


## 📘 Pipeline Stages

### 1️⃣ IF — Instruction Fetch
Fetches instruction from instruction memory.

### 2️⃣ ID — Instruction Decode
Decodes instruction and reads register values.

### 3️⃣ EX — Execute
Performs ALU operations.

### 4️⃣ MEM — Memory Access
Handles memory read/write operations.

### 5️⃣ WB — Write Back
Writes result back to register file.


⚙️ Major Modules:


Module	                      |  Function


Program Counter (PC)	      |  Maintains instruction address

Instruction Memory	      | Stores instructions

Register File                 |	Stores processor registers

Control Unit	              | Generates control signals

ALU	                      | Performs arithmetic/logical operations

Data Memory	              | Handles memory operations

IF/ID Register	              | Stores IF stage outputs

ID/EX Register	              | Stores decode stage outputs

EX/MEM Register	              | Stores execute stage outputs

MEM/WB Register	              | Stores memory stage outputs

Hazard Detection Unit         |	Detects data hazards

Forwarding Unit	              | Resolves pipeline dependencies


🧩 Architecture Diagram


## 🏗️ Complete Processor Architecture


<img width="1536" height="1024" alt="processor_architecture" src="https://github.com/user-attachments/assets/d5916b8d-445c-4342-ac1e-8a5f02e55995" />


⚠️ Hazard Detection Unit (HDU)


The Hazard Detection Unit monitors instruction dependencies between pipeline stages.


Responsibilities


• Detect load-use hazards


• Stall pipeline when dependency occurs


• Prevent incorrect execution


Hazard Logic


If:

ID/EX.Rd == IF/ID.Rs1 or IF/ID.Rs2


Then:

stall = 1

🔄 Forwarding Unit


The Forwarding Unit reduces stalls by forwarding ALU results directly to dependent instructions.


Forwarding Paths:


• EX/MEM → EX Stage.

• MEM/WB → EX Stage.

Benefits:


✅ Reduces pipeline stalls

✅ Improves performance

✅ Maintains correct execution

📊 EPWave Simulation


The waveform simulation verifies:


• Pipeline execution flow

• Register propagation

• ALU execution

• Forwarding logic

• Clock synchronization


The uploaded waveform demonstrates successful instruction propagation through all five pipeline stages.


No explicit hazard stalls are shown in the current waveform because the executed instruction sequence does not contain data dependency conflicts requiring stalls.


📷 Screenshots


🔹 EPWave Simulation


<img width="1886" height="838" alt="final_waveform" src="https://github.com/user-attachments/assets/91dc038a-6694-43b3-81c2-2d438d9050a8" />


🔹 Hazard Detection Verification


<img width="1886" height="838" alt="hazard_forwarding_waveform" src="https://github.com/user-attachments/assets/138779e0-caee-429e-a1a4-032f2fa87174" />


🔹 Processor Architecture


<img width="1536" height="1024" alt="processor_architecture" src="https://github.com/user-attachments/assets/cf2826f1-958d-4886-9f6b-8e432ed8733c" />


🧪 Verification and Testing


 Simulation Tools

 
• EDA Playground

• Icarus Verilog

• EPWave


Verification Steps


✅ Compilation

All Verilog modules compiled successfully without critical errors.

✅ Functional Simulation

Processor executed instructions correctly across all pipeline stages.

✅ Pipeline Verification

Verified proper propagation through:


• IF/ID
• ID/EX
• EX/MEM
• MEM/WB

✅ Hazard Handling


Verified:


Hazard detection logic

Pipeline stall conditions

Forwarding paths


✅ Waveform Analysis


Observed:


• Clock synchronization

• PC updates

• ALU results

• Register propagation

• Memory operations


📡 Observed Signals:


Signal	                  |      Purpose


pc_current	          |  Current program counter

pc_next	                  |  Next instruction address

instruction               |	Current instruction

ifid_instruction          |	IF/ID pipeline instruction

idex_read_data1	          |  Source operand 1

idex_read_data2           |	Source operand 2

alu_result                |	ALU output

memwb_read_data           |	Memory read output

forwardA	          |  Forwarding control signal

forwardB	          |  Forwarding control signal


🛠️ Technologies Used


  Technology                | 	  Purpose

  
Verilog HDL	    q       |   Hardware design

RISC-V Architecture	    |   Processor ISA

EDA Playground	            |   Online simulation

Icarus Verilog	            |   Verilog compiler

EPWave	                    |    Waveform visualization

GitHub                      | 	Version control & documentation


📂 Project Folder Structure


5-Stage-Pipelined-RISC-V-Processor-with-Hazard-Detection-and-Forwarding/
|
├── rtl/
│   ├── alu.v
│   ├── pc.v
│   ├── instruction_memory.v
│   ├── register_file.v
│   ├── control_unit.v
│   └── processor.v
│
├── testbench/
│   ├── alu_tb.v
│   ├── pc_tb.v
│   ├── instruction_memory_tb.v
│   ├── register_file_tb.v
│   ├── control_unit_tb.v
│   └── processor_tb.v
|
├── docs/
│   ├── architecture.md
│   ├── module_explanation.md
│   └── verification.md
│
├── images/
|
├── screenshots/
│
├── waveforms/
│
└── README.md


▶️ How to Run


Using EDA Playground


1. Open EDA Playground
2. Upload:
 ৹ design.sv
 ৹ testbench.sv
3. Select:
 ৹ Icarus Verilog
4. Enable:
 ৹ Open EPWave after run
5. Click Run
6. Observe waveform in EPWave


🎯 Key Learnings


• Pipeline processor design.

• Verilog HDL implementation.

• Hazard handling techniques.

• Forwarding mechanisms.

• RTL verification.

• Waveform debugging.

• Computer architecture concepts.


🌟 Project Impact


This project demonstrates practical knowledge of:


• Computer Architecture.

• RTL Design.

• Digital Logic Design.

• Pipeline Hazard Handling.

• Processor Verification.


It showcases the ability to design and verify a modular pipelined processor using industry-relevant concepts.


👩‍💻 Author


Marri Lalitha Raga Pravallika


📌 Recruiter Note


This project demonstrates:


✅ Verilog HDL proficiency.

✅ Understanding of pipelined processor architecture.

✅ Hazard detection implementation.

✅ Forwarding logic implementation.

✅ Simulation and verification skills.

✅ Strong documentation and modular design practices.




