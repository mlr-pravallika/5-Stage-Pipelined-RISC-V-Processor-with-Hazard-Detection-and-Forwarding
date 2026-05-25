module pipeline_processor(

    input clk,
    input reset
);

//
// PC
//

wire [31:0] pc_current;
wire [31:0] pc_next;

assign pc_next = pc_current + 4;

pc pc_module(
    .clk(clk),
    .reset(reset),
    .next_pc(pc_next),
    .pc(pc_current)
);

//
// Instruction Memory
//

wire [31:0] instruction;

instruction_memory imem(
    .address(pc_current),
    .instruction(instruction)
);

//
// IF/ID
//

wire [31:0] ifid_instruction;
wire [31:0] ifid_pc;

if_id ifid(

    .clk(clk),
    .reset(reset),

    .instruction_in(instruction),
    .pc_in(pc_current),

    .instruction_out(ifid_instruction),
    .pc_out(ifid_pc)
);

//
// Register File
//

wire [31:0] read_data1;
wire [31:0] read_data2;

register_file rf(

    .clk(clk),

    .RegWrite(1'b1),

    .ReadReg1(ifid_instruction[19:15]),
    .ReadReg2(ifid_instruction[24:20]),

    .WriteReg(memwb_rd),

    .WriteData(memwb_alu_result),

    .ReadData1(read_data1),
    .ReadData2(read_data2)
);

//
// Control Unit
//

wire [1:0] alu_control;

control_unit cu(

    .opcode(ifid_instruction[6:0]),
    .ALUControl(alu_control)
);

//
// ID/EX
//

wire [31:0] idex_pc;
wire [31:0] idex_read_data1;
wire [31:0] idex_read_data2;

wire [1:0] idex_alu_control;

id_ex idex(

    .clk(clk),
    .reset(reset),

    .pc_in(ifid_pc),

    .read_data1_in(read_data1),
    .read_data2_in(read_data2),

    .alu_control_in(alu_control),

    .pc_out(idex_pc),

    .read_data1_out(idex_read_data1),
    .read_data2_out(idex_read_data2),

    .alu_control_out(idex_alu_control)
);

//
// ALU
//

wire [31:0] alu_result;

alu alu_module(

    .A(idex_read_data1),
    .B(idex_read_data2),

    .ALUControl(idex_alu_control),

    .Result(alu_result)
);

//
// EX/MEM
//

wire [31:0] exmem_alu_result;
wire [31:0] exmem_write_data;

wire [4:0] exmem_rd;

wire exmem_mem_write;

ex_mem exmem(

    .clk(clk),
    .reset(reset),

    .alu_result_in(alu_result),

    .write_data_in(idex_read_data2),

    .rd_in(5'd1),

    .mem_write_in(1'b1),

    .alu_result_out(exmem_alu_result),
    .write_data_out(exmem_write_data),

    .rd_out(exmem_rd),

    .mem_write_out(exmem_mem_write)
);

//
// DATA MEMORY
//

wire [31:0] mem_read_data;

data_memory dmem(

    .clk(clk),

    .mem_write(exmem_mem_write),
    .mem_read(1'b1),

    .address(exmem_alu_result),

    .write_data(exmem_write_data),

    .read_data(mem_read_data)
);

//
// MEM/WB
//

wire [31:0] memwb_read_data;
wire [31:0] memwb_alu_result;

wire [4:0] memwb_rd;

wire memwb_reg_write;

mem_wb memwb(

    .clk(clk),
    .reset(reset),

    .read_data_in(mem_read_data),
    .alu_result_in(exmem_alu_result),

    .rd_in(exmem_rd),

    .reg_write_in(1'b1),

    .read_data_out(memwb_read_data),
    .alu_result_out(memwb_alu_result),

    .rd_out(memwb_rd),

    .reg_write_out(memwb_reg_write)
);

endmodule