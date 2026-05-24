module id_ex_tb;

reg clk;
reg reset;

reg [31:0] pc_in;
reg [31:0] read_data1_in;
reg [31:0] read_data2_in;

reg [1:0] alu_control_in;

wire [31:0] pc_out;
wire [31:0] read_data1_out;
wire [31:0] read_data2_out;

wire [1:0] alu_control_out;

id_ex uut(

    .clk(clk),
    .reset(reset),

    .pc_in(pc_in),
    .read_data1_in(read_data1_in),
    .read_data2_in(read_data2_in),

    .alu_control_in(alu_control_in),

    .pc_out(pc_out),
    .read_data1_out(read_data1_out),
    .read_data2_out(read_data2_out),

    .alu_control_out(alu_control_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, id_ex_tb);

    clk = 0;
    reset = 1;

    #10;

    reset = 0;

    pc_in = 4;
    read_data1_in = 100;
    read_data2_in = 50;

    alu_control_in = 2'b00;

    #10;

    pc_in = 8;
    read_data1_in = 200;
    read_data2_in = 25;

    alu_control_in = 2'b01;

    #10;

    $finish;

end

endmodule