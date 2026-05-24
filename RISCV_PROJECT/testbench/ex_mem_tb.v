module ex_mem_tb;

reg clk = 0;
reg reset = 0;

reg [31:0] alu_result_in = 0;
reg [31:0] write_data_in = 0;

reg [4:0] rd_in = 0;

reg mem_write_in = 0;

wire [31:0] alu_result_out = 0;
wire [31:0] write_data_out = 0;

wire [4:0] rd_out = 0;

wire mem_write_out = 0;

ex_mem uut (

    .clk(clk),
    .reset(reset),

    .alu_result_in(alu_result_in),
    .write_data_in(write_data_in),

    .rd_in(rd_in),

    .mem_write_in(mem_write_in),

    .alu_result_out(alu_result_out),
    .write_data_out(write_data_out),

    .rd_out(rd_out),

    .mem_write_out(mem_write_out)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, ex_mem_tb);

    clk = 0;
    reset = 1;

    alu_result_in = 0;
    write_data_in = 0;

    rd_in = 0;

    mem_write_in = 0;

    #10;

    reset = 0;

    alu_result_in = 500;
    write_data_in = 100;

    rd_in = 10;

    mem_write_in = 1;

    #10;

    alu_result_in = 1000;
    write_data_in = 200;

    rd_in = 15;

    mem_write_in = 0;

    #10;

    $finish;

end

endmodule