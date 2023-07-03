module Op2 (clk, Op2_datafromReg, Op2_output, Op2_load);
 //for operand1 reg0 will be acc, op1 and op2 using the same register bank
//thus the register of op1 and op2 will not be the same
input clk;
input [15:0] Op2_datafromReg;
input Op2_load; //control signal
output [15:0] Op2_output;

reg [15:0] temp;


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
            Op2_output <= temp; //Todo: this may need to change
            
        end
    end
end

endmodule