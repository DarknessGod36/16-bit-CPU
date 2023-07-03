module Arith(Arith_opcode, Arith_Out, op1, op2); //to process arithmetric operation

input [3:0] Arith_opcode;
input [15:0] op1;
input [15:0] op2;
output reg [15:0] Arith_Out;

always@(op1, op2, Arith_opcode) begin
    
    case(Arith_opcode)

    4'b0000: Arith_Out = op1 + op2; 
    4'b0001: Arith_Out = op1 * op2;
    4'b0010: if(op1 > op2) begin
        Arith_Out = op1 - op2;
        end
        else begin
            Arith_Out = op2 - op1;
        end
    4'b0011: if (op1>op2) begin
        Arith_Out = op1/op2;
        end
        else begin
        Arith_Out = op2/op1;
        end
    default Arith_Out = 3'b000;
    endcase
end
endmodule