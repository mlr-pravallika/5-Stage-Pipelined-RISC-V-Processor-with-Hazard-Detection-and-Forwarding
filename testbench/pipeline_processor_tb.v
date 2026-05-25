module pipeline_processor_tb;

reg clk = 0;
reg reset = 0;

pipeline_processor uut(

    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, pipeline_processor_tb);

    reset = 1;

    #10;

    reset = 0;

    #100;

    $finish;

end

endmodule