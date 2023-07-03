module Op1 (clk, Op1_datafromReg, Op1_output, Op1_load, Op1_addr, Op1_addr_output);
 //for operand1 reg0 will be acc, op1 and op2 using the same register bank
//thus the register of op1 and op2 will not be the same
input clk;
input [3:0] Op1_addr;
input [15:0] Op1_datafromReg; //retrieve from the register module
input Op1_load; //control signal
output reg [15:0] Op1_output;
output reg [3:0] Op1_addr_output; //this will be assigned to addressing mode op1_addr
//the data inside register should be assigned in data mem
reg [15:0] temp;


always@(clk, Op1_load)
//it depend on the changes of variable that inside the always's bracket
begin
    @(posedge clk)
    begin
        if(Op1_load == 1) begin
            Op1_output <= Op1_datafromReg;
            Op1_addr_output <= Op1_addr;
            temp <= Op1_datafromReg;
        end

        else if (Op_load == 0) begin
            Op1_output <= temp;
        end
    end
end

endmodule