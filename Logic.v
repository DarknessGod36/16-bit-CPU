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
        4'b0000: Logic_Out = (op1 & op2);
        4'b0001: Logic_Out = (op1 | op2);
        4'b0010: Logic_Out = ~(op1 | op2);
        4'b0011: Logic_Out = (~op1);
        4'b0100: Logic_Out = (~op2);
        4'b0101: Logic_Out = (op1 ^ op2);
        4'b0110: Logic_Out = ~(op1 ^ op2);
        default: Logic_Out = 16'b0000000000000000;
    endcase
end


always@(op1, op2) begin
    
    if(op1 == op2) begin
        eq = 1;
    end
    else begin
        eq = 0;
    end

    if(op1 > op2) begin
        gt = 1;
    end
    else begin
        gt = 0;
    end

    if(op1 < op2) begin
        lt = 1;
    end
    else begin
        lt = 0;
    end

    if(op1 == 16'b0000000000000000) begin
        za = 1;
    end
    else begin
        za = 0;
    end

    if(op2 == 16'b0000000000000000) begin
        zb = 1;
    end
    else begin
        zb = 0;
    end
end
endmodule