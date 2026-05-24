module control_unit_tb;

reg [6:0] opcode;

wire RegWrite;
wire MemRead;
wire MemWrite;

wire [1:0] ALUOp;

control_unit uut (

    .opcode(opcode),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .ALUOp(ALUOp)

);

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, control_unit_tb);

    opcode = 7'b0110011;
    #10;

    opcode = 7'b0000011;
    #10;

    opcode = 7'b0100011;
    #10;

    $finish;

end

endmodule