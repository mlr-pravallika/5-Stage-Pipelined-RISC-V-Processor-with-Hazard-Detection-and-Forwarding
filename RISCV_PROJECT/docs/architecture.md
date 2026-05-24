# 5-Stage Pipelined RISC-V Processor Architecture

## Overview

This project implements a complete 5-stage pipelined RISC-V processor using Verilog HDL.

The processor is divided into the following stages:

1. IF  - Instruction Fetch
2. ID  - Instruction Decode
3. EX  - Execute
4. MEM - Memory Access
5. WB  - Write Back

The design also includes:

- Hazard Detection Unit (HDU)
- Forwarding Unit
- Pipeline Registers
- ALU
- Register File
- Instruction Memory
- Data Memory

---

# Pipeline Stages

## 1. Instruction Fetch (IF)

- Fetches instruction from Instruction Memory
- Updates Program Counter (PC)
- Sends instruction to IF/ID pipeline register

### Components
- Program Counter
- Instruction Memory
- PC Adder

---

## 2. Instruction Decode (ID)

- Decodes instruction opcode
- Reads operands from Register File
- Generates control signals

### Components
- Register File
- Control Unit
- IF/ID Register

---

## 3. Execute (EX)

- Performs arithmetic and logical operations
- Uses ALU
- Handles forwarding logic

### Components
- ALU
- Forwarding Unit
- ID/EX Register

---

## 4. Memory Access (MEM)

- Reads/Writes data memory

### Components
- Data Memory
- EX/MEM Register

---

## 5. Write Back (WB)

- Writes ALU or memory result back to Register File

### Components
- MEM/WB Register

### Final Pipelining Flow:
 The final pipelining flow can be given as
                       PC
                       ↓
                    Instruction Memory
                       ↓
                      IF/ID
                       ↓
                    Control Unit + Register File
                       ↓
                      ID/EX
                       ↓
                      ALU
                       ↓
                      EX/MEM
                       ↓
                      Data Memory
                       ↓
                      MEM/WB
                       ↓
                    Write Back

---

# Hazard Handling

## Hazard Detection Unit

A Hazard Detection Unit detects data hazards in pipelined processors and temporarily stalls the pipeline to avoid incorrect execution.

Detects load-use hazards and stalls pipeline when required.

## Forwarding Unit

Forwards ALU results between stages to avoid unnecessary stalls.

---

# Features

- 5-stage pipelined architecture
- Modular Verilog design
- Hazard detection
- Data forwarding
- EPWave verification
- EDA Playground simulation support