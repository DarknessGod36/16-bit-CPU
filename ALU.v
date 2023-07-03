module ALU (
    clk, op1, op2, ALU_opcode, ALU_OT, za, zb, eq, gt, lt, ALU_out, op1_regaddr, op2_regaddr, Addr_out
);

input clk;
input [15:0] op1;
input [15:0] op2;
input [3:0] ALU_opcode;
input [1:0] ALU_OT; //control signal
output reg [15:0] ALU_out;
output reg [15:0] Addr_out;
output za, zb, eq, gt, lt;

reg za, zb, eq, gt, lt;

wire [15:0] outlg;
wire [15:0] outalu;
wire [15:0] outaddr;
wire [15:0] outdata;

//inside the bracket is the variable from this module
//after the dot is the variable name from other module
Arith a1 (.Arith_opcode(ALU_opcode), .Arith_Out(outalu), .op1(op1), .op2(op2));
Logic l1 (.op1(op1), .op2(op2), .Logic_opcode(ALU_opcode), .Logic_Out(outlg), .Logic_za(tza), .Logic_zb(tzb), .Logic_eq(teq), .Logic_gt(tgt), .Logic_lt(tlt));
AddressingMode m1 (.op1_data(op1), .op2_data(op1), .op1_regaddr(op1_regaddr), .op2_regaddr(op2_regaddr), .AM_opcode(ALU_opcode), .AM_Outdata(outdata), .AM_OutRegaddr(outaddr));


always@(op1, op2, ALU_OT, ALU_opcode) begin
    
    if(ALU_OT == 2'b00) begin
        ALU_Out = outdata;
        Addr_out = outaddr;
    end
    else if (ALU_OT == 2'b01) begin
        ALU_Out = outalu;
    end
    
    else if (ALU_OT == 2'b10) begin
        ALU_Out = outlg;
    end

    else begin
        ALU_Out = 16'b0000000000000000;
        Addr_out = 16'b0000000000000000;
    end

    za = tza;
    zb = tzb;
    eq = teq;
    gt = tgt;
    lt = tlt;
end

endmodule