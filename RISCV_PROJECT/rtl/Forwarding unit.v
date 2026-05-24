module pc(
    input clk,
    input reset,
    input [31:0] next_pc,
    output reg [31:0] pc
);

always @(posedge clk or posedge reset) begin

    if(reset)
        pc <= 0;

    else
        pc <= next_pc;

end

endmodule

module instruction_memory(

    input [31:0] address,
    output [31:0] instruction

);

reg [31:0] memory [0:15];

initial begin

    memory[0] = 32'h00000001;
    memory[1] = 32'h00000002;
    memory[2] = 32'h00000003;
    memory[3] = 32'h00000004;

end

assign instruction = memory[address/4];

endmodule

module if_id(
    input clk,
    input reset,

    input [31:0] pc_in,
    input [31:0] instruction_in,

    output reg [31:0] pc_out,
    output reg [31:0] instruction_out
);

always @(posedge clk or posedge reset) begin

    if(reset) begin
        pc_out <= 0;
        instruction_out <= 0;
    end

    else begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
    end

end

endmodule

module register_file(

    input clk,
    input RegWrite,

    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,

    input [31:0] WriteData,

    output [31:0] ReadData1,
    output [31:0] ReadData2

);

reg [31:0] registers [0:31];

integer i;

initial begin

    for(i = 0; i < 32; i = i + 1)
        registers[i] = 0;

end  

assign ReadData1 = registers[ReadReg1];
assign ReadData2 = registers[ReadReg2];

always @(posedge clk) begin

    if(RegWrite)
        registers[WriteReg] <= WriteData;

end

endmodule


module control_unit(

    input [6:0] opcode,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,

  output reg [1:0] alu_control

);

always @(*) begin

    case(opcode)

        7'b0110011: begin

            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            alu_control = 2'b10;

        end

        7'b0000011: begin

            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            alu_control = 2'b00;

        end

        7'b0100011: begin

            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            alu_control = 2'b00;

        end

        default: begin

            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            alu_control = 2'b00;

        end

    endcase

end

endmodule

module id_ex(

    input clk,
    input reset,

    input [31:0] pc_in,
    input [31:0] read_data1_in,
    input [31:0] read_data2_in,

    input [1:0] alu_control_in,

    output reg [31:0] pc_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,

    output reg [1:0] alu_control_out

);

always @(posedge clk or posedge reset) begin

    if(reset) begin

        pc_out <= 0;
        read_data1_out <= 0;
        read_data2_out <= 0;
        alu_control_out <= 0;

    end

    else begin

        pc_out <= pc_in;
        read_data1_out <= read_data1_in;
        read_data2_out <= read_data2_in;
        alu_control_out <= alu_control_in;

    end

end

endmodule

module alu(
    input [31:0] A,
    input [31:0] B,
    input [1:0] ALUControl,
    output reg [31:0] Result
);

always @(*) begin
    case(ALUControl)

        2'b00: Result = A + B;

        2'b01: Result = A - B;

        2'b10: Result = A & B;

        2'b11: Result = A | B;

    endcase
end

endmodule

module ex_mem(

    input clk,
    input reset,

    input [31:0] alu_result_in,
    input [31:0] write_data_in,

    input [4:0] rd_in,

    input mem_write_in,

    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,

    output reg [4:0] rd_out,

    output reg mem_write_out
);

always @(posedge clk or posedge reset) begin

    if(reset) begin

        alu_result_out <= 0;
        write_data_out <= 0;

        rd_out <= 0;

        mem_write_out <= 0;

    end

    else begin

        alu_result_out <= alu_result_in;
        write_data_out <= write_data_in;

        rd_out <= rd_in;

        mem_write_out <= mem_write_in;

    end

end

endmodule

module data_memory(

    input clk,

    input mem_write,
    input mem_read,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data
);

reg [31:0] memory [0:255];

integer i;

initial begin

    for(i = 0; i < 256; i = i + 1)
        memory[i] = 0;

end

always @(posedge clk) begin

    if(mem_write)
        memory[address] <= write_data;

end

always @(*) begin

    if(mem_read)
        read_data = memory[address];

    else
        read_data = 0;

end

endmodule

module mem_wb(

    input clk,
    input reset,

    input [31:0] read_data_in,
    input [31:0] alu_result_in,

    input [4:0] rd_in,

    input reg_write_in,

    output reg [31:0] read_data_out,
    output reg [31:0] alu_result_out,

    output reg [4:0] rd_out,

    output reg reg_write_out
);

always @(posedge clk or posedge reset) begin

    if(reset) begin

        read_data_out <= 0;
        alu_result_out <= 0;

        rd_out <= 0;

        reg_write_out <= 0;

    end

    else begin

        read_data_out <= read_data_in;
        alu_result_out <= alu_result_in;

        rd_out <= rd_in;

        reg_write_out <= reg_write_in;

    end

end

endmodule

module hazard_detection(

    input mem_read_ex,
    
    input [4:0] rd_ex,
    
    input [4:0] rs1_id,
    input [4:0] rs2_id,

    output reg stall

);

always @(*) begin

    if(mem_read_ex &&
      ((rd_ex == rs1_id) || (rd_ex == rs2_id)))

        stall = 1;

    else

        stall = 0;

end

endmodule

module forwarding_unit(

    input [4:0] rs1_ex,
    input [4:0] rs2_ex,

    input [4:0] rd_mem,
    input [4:0] rd_wb,

    input reg_write_mem,
    input reg_write_wb,

    output reg [1:0] forwardA,
    output reg [1:0] forwardB

);

always @(*) begin

    // defaults

    forwardA = 2'b00;
    forwardB = 2'b00;

    // EX hazard

    if(reg_write_mem &&
      (rd_mem != 0) &&
      (rd_mem == rs1_ex))

        forwardA = 2'b10;

    if(reg_write_mem &&
      (rd_mem != 0) &&
      (rd_mem == rs2_ex))

        forwardB = 2'b10;

    // MEM hazard

    if(reg_write_wb &&
      (rd_wb != 0) &&
      !(reg_write_mem &&
       (rd_mem != 0) &&
       (rd_mem == rs1_ex)) &&
      (rd_wb == rs1_ex))

        forwardA = 2'b01;

    if(reg_write_wb &&
      (rd_wb != 0) &&
      !(reg_write_mem &&
       (rd_mem != 0) &&
       (rd_mem == rs2_ex)) &&
      (rd_wb == rs2_ex))

        forwardB = 2'b01;

end

endmodule

module pipeline_processor(

    input clk,
    input reset
);

//
// PC
//

wire [31:0] pc_current;
wire [31:0] pc_next;
wire stall;
wire [1:0] forwardA;
wire [1:0] forwardB;  

assign pc_next = stall ? pc_current : (pc_current + 4);

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
  
// Hazard Detection Unit

hazard_detection hdu(

    .mem_read_ex(exmem_mem_write),

    .rd_ex(exmem_rd),

    .rs1_id(ifid_instruction[19:15]),

    .rs2_id(ifid_instruction[24:20]),

    .stall(stall)

); 
  
forwarding_unit fu(

    .rs1_ex(ifid_instruction[19:15]),
    .rs2_ex(ifid_instruction[24:20]),

    .rd_mem(exmem_rd),
    .rd_wb(memwb_rd),

    .reg_write_mem(exmem_mem_write),
    .reg_write_wb(memwb_reg_write),

    .forwardA(forwardA),
    .forwardB(forwardB)

);  

//
// Control Unit
//

wire [1:0] alu_control;

control_unit cu(

    .opcode(ifid_instruction[6:0]),
    .alu_control(alu_control)
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

wire [31:0] alu_inputA;
wire [31:0] alu_inputB;
wire [31:0] alu_result;

// Forwarding Logic

assign alu_inputA =
    (forwardA == 2'b10) ? exmem_alu_result :
    (forwardA == 2'b01) ? memwb_alu_result :
                          idex_read_data1;

assign alu_inputB =
    (forwardB == 2'b10) ? exmem_alu_result :
    (forwardB == 2'b01) ? memwb_alu_result :
                          idex_read_data2;

// ALU Module

alu alu_module(

    .A(alu_inputA),
    .B(alu_inputB),

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