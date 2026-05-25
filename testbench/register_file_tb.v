module register_file_tb;

reg clk;
reg RegWrite;

reg [4:0] ReadReg1;
reg [4:0] ReadReg2;
reg [4:0] WriteReg;

reg [31:0] WriteData;

wire [31:0] ReadData1;
wire [31:0] ReadData2;

register_file uut (

    .clk(clk),
    .RegWrite(RegWrite),

    .ReadReg1(ReadReg1),
    .ReadReg2(ReadReg2),

    .WriteReg(WriteReg),

    .WriteData(WriteData),

    .ReadData1(ReadData1),
    .ReadData2(ReadData2)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, register_file_tb);

    clk = 0;
  
    ReadReg1 = 0;
    ReadReg2 = 0;
    
    RegWrite = 1;

    WriteReg = 5;
    WriteData = 100;

    #10;

    WriteReg = 10;
    WriteData = 200;

    #10;

    ReadReg1 = 5;
    ReadReg2 = 10;

    #10;

    $finish;

end

endmodule
