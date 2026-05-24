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