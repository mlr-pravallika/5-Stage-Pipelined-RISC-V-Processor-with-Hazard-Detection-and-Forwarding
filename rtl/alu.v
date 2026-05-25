
module alu(
    input [31:0] A,
    input [31:0] B,
    input [1:0] ALUControl,
    output reg [31:0] Result
);

always @(*) begin
    case(ALUControl)

        2'b00: Result = A + B;

        2'b01: Result = A - B;

        2'b10: Result = A & B;

        2'b11: Result = A | B;

    endcase
end

endmodule


