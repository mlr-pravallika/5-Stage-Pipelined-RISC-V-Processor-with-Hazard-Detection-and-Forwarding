module ex_mem(

    input clk,
    input reset,

    input [31:0] alu_result_in,
    input [31:0] write_data_in,

    input [4:0] rd_in,

    input mem_write_in,

    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,

    output reg [4:0] rd_out,

    output reg mem_write_out
);

always @(posedge clk or posedge reset) begin

    if(reset) begin

        alu_result_out <= 0;
        write_data_out <= 0;

        rd_out <= 0;

        mem_write_out <= 0;

    end

    else begin

        alu_result_out <= alu_result_in;
        write_data_out <= write_data_in;

        rd_out <= rd_in;

        mem_write_out <= mem_write_in;

    end

end

endmodule