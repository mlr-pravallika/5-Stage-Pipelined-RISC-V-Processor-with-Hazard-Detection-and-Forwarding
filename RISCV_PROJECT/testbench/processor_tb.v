module processor_tb;

reg clk;
reg reset;

processor uut (

    .clk(clk),
    .reset(reset)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, processor_tb);

    clk = 0;

    reset = 1;

    #10;

    reset = 0;

    #50;

    $finish;

end

endmodule
