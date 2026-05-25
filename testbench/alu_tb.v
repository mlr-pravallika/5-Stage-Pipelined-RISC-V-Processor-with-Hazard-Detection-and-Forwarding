module alu_tb;

reg [31:0] A;
reg [31:0] B;
reg [1:0] ALUControl;

wire [31:0] Result;

alu uut (
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .Result(Result)
);

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    A = 10;
    B = 5;

    ALUControl = 2'b00;
    #10;

    ALUControl = 2'b01;
    #10;

    ALUControl = 2'b10;
    #10;

    ALUControl = 2'b11;
    #10;

    $finish;
end

endmodule