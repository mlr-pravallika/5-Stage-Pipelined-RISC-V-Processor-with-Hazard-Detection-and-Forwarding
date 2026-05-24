module id_ex(

    input clk,
    input reset,

    input [31:0] pc_in,
    input [31:0] read_data1_in,
    input [31:0] read_data2_in,

    input [1:0] alu_control_in,

    output reg [31:0] pc_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,

    output reg [1:0] alu_control_out

);

always @(posedge clk or posedge reset) begin

    if(reset) begin

        pc_out <= 0;
        read_data1_out <= 0;
        read_data2_out <= 0;
        alu_control_out <= 0;

    end

    else begin

        pc_out <= pc_in;
        read_data1_out <= read_data1_in;
        read_data2_out <= read_data2_in;
        alu_control_out <= alu_control_in;

    end

end

endmodule