module alu(

    input [31:0] A,
    input [31:0] B,
    output [31:0] Result

);

assign Result = A + B;

endmodule



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
  
integer i;  

initial begin
  
    for(i = 0; i < 16; i = i + 1)
        memory[i] = 0;
  
    memory[0] = 32'd10;
    memory[1] = 32'd20;
    memory[2] = 32'd30;
    memory[3] = 32'd40;

end

assign instruction = memory[address/4];

endmodule



module processor(

    input clk,
    input reset

);

wire [31:0] pc_current;
wire [31:0] pc_next;

wire [31:0] instruction;

wire [31:0] alu_result;



assign pc_next = pc_current + 4;



pc PC (

    .clk(clk),
    .reset(reset),

    .next_pc(pc_next),

    .pc(pc_current)

);



instruction_memory IM (

    .address(pc_current),

    .instruction(instruction)

);



alu ALU (

    .A(instruction),

    .B(32'd5),

    .Result(alu_result)

);

endmodule
