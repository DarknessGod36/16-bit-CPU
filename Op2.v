module Op2 (clk, Op2_datafromReg, Op2_output, Op2_load);
 //for operand1 reg0 will be acc, op1 and op2 using the same register bank
//thus the register of op1 and op2 will not be the same
input clk;
input [15:0] Op2_datafromReg;
input Op2_load; //control signal
output [15:0] Op2_output;

reg [15:0] temp;

parameter Reg0 = 16'b0000000000001010;//10
parameter Reg1 = 16'b0000001111101000;//1000
parameter Reg2 = 16'b0000000001100100;//100
parameter Reg3 = 16'b0000000000000001;//1
parameter Reg4 = 16'b0010011100010000;//10000
parameter Reg5 = 16'b0000000000000000;//0
parameter Reg6 = 16'b0000000111110100;//500
parameter Reg7 = 16'b0001001110001000;//5000


always@(clk, Op2_load)
//it depend on the changes of variable that inside the always's bracket
begin
    @(posedge clk)
    begin
        if(Op2_load == 1) begin
           Op2_output <= Op2_datafromReg;
           temp <= Op2_datafromReg;
        end

        else if (Op2_load == 0) begin
            Op2_output <= temp;
            
        end
    end
end

endmodule