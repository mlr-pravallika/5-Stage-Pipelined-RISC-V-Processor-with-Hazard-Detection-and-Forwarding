module control_unit(

    input [6:0] opcode,

    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,

    output reg [1:0] ALUOp

);

always @(*) begin

    case(opcode)

        7'b0110011: begin

            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            ALUOp = 2'b10;

        end

        7'b0000011: begin

            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            ALUOp = 2'b00;

        end

        7'b0100011: begin

            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            ALUOp = 2'b00;

        end

        default: begin

            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            ALUOp = 2'b00;

        end

    endcase

end

endmodule
