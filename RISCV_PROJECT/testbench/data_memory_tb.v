module data_memory_tb;

reg clk = 0;

reg mem_write = 0;
reg mem_read = 0;

reg [31:0] address = 0;
reg [31:0] write_data = 0;

wire [31:0] read_data;

data_memory uut(

    .clk(clk),

    .mem_write(mem_write),
    .mem_read(mem_read),

    .address(address),
    .write_data(write_data),

    .read_data(read_data)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, data_memory_tb);

    // WRITE DATA

    mem_write = 1;
    address = 4;
    write_data = 500;

    #10;

    mem_write = 0;

    // READ DATA

    mem_read = 1;
    address = 4;

    #10;

    // SECOND WRITE

    mem_write = 1;
    mem_read = 0;

    address = 8;
    write_data = 1000;

    #10;

    // SECOND READ

    mem_write = 0;
    mem_read = 1;

    address = 8;

    #10;

    $finish;

end

endmodule