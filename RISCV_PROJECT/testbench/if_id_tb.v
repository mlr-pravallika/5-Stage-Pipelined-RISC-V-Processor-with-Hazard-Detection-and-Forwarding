module if_id_tb;

reg clk;
reg reset;

reg [31:0] pc_in;
reg [31:0] instruction_in;

wire [31:0] pc_out;
wire [31:0] instruction_out;

if_id uut (

    .clk(clk),
    .reset(reset),

    .pc_in(pc_in),
    .instruction_in(instruction_in),

    .pc_out(pc_out),
    .instruction_out(instruction_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, if_id_tb);

    clk = 0;
    reset = 1;

    #10;

    reset = 0;

    pc_in = 4;
    instruction_in = 32'h12345678;

    #10;

    pc_in = 8;
    instruction_in = 32'h87654321;

    #10;

    $finish;

end

endmodule