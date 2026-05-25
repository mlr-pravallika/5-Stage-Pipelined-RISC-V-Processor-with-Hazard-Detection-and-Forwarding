module mem_wb_tb;

reg clk = 0;
reg reset = 0;

reg [31:0] read_data_in = 0;
reg [31:0] alu_result_in = 0;

reg [4:0] rd_in = 0;

reg reg_write_in = 0;

wire [31:0] read_data_out;
wire [31:0] alu_result_out;

wire [4:0] rd_out;

wire reg_write_out;

mem_wb uut(

    .clk(clk),
    .reset(reset),

    .read_data_in(read_data_in),
    .alu_result_in(alu_result_in),

    .rd_in(rd_in),

    .reg_write_in(reg_write_in),

    .read_data_out(read_data_out),
    .alu_result_out(alu_result_out),

    .rd_out(rd_out),

    .reg_write_out(reg_write_out)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, mem_wb_tb);

    reset = 1;

    #10;

    reset = 0;

    read_data_in = 500;
    alu_result_in = 1000;

    rd_in = 5;

    reg_write_in = 1;

    #10;

    read_data_in = 700;
    alu_result_in = 2000;

    rd_in = 10;

    reg_write_in = 0;

    #10;

    $finish;

end

endmodule