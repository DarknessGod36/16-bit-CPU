module Logic (
    op1, op2, Logic_opcode, Logic_Out, Logic_za, Logic_zb, Logic_eq, Logic_gt, Logic_lt
);

input [15:0] op1;
input [15:0] op2;
input [3:0] Logic_opcode;
output reg [15:0] Logic_Out;
output za, zb, eq, gt, lt;
reg za, zb, eq, gt, lt;


always@(op1, op2, Logic_opcode) begin
    
    case (Logic_opcode)
        4'b0100: Logic_Out = (op1 & op2); //AND gate
        4'b0101: Logic_Out = (op1 | op2); //OR gate
        4'b0110: Logic_Out = ~(op1 | op2); //NOR gate
        4'b0111: Logic_Out = (~op1); //INVERTED 
        4'b1000: Logic_Out = (~op2); //INVERTED
        4'b1001: Logic_Out = (op1 ^ op2); //XOR gate 
        4'b1010: Logic_Out = ~(op1 ^ op2); //XNOR gate
        default: Logic_Out = 16'b0000000000000000;
    endcase
end


always@(op1, op2) begin
    
    if(op1 == op2) begin
        Logic_eq = 1;
    end
    else begin
        Logic_eq = 0;
    end

    if(op1 > op2) begin
        Logic_gt = 1;
    end
    else begin
        Logic_gt = 0;
    end

    if(op1 < op2) begin
        Logic_lt = 1;
    end
    else begin
        Logic_lt = 0;
    end

    if(op1 == 16'b0000000000000000) begin
        Logic_za = 1;
    end
    else begin
        Logic_za = 0;
    end

    if(op2 == 16'b0000000000000000) begin
        Logic_zb = 1;
    end
    else begin
        Logic_zb = 0;
    end
end
endmodule