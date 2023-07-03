module ControlSignal (
    clk, CS_opcode, CS_ALU_OT, CS_Op1_load, CS_Op2_load, CS_PC_load, CS_Reg_load, CS_Ins_load, CS_PC_inc;
);


input clk, 
input [3:0] CS_opcode;
output CS_ALU_OT; //the ALU mode for picking which mode it will process 
//addressing mode/Arith/Logic
output CS_Ins_load; //Split the instruction set into different meaning
output CS_Op1_load; //load the data from chosen register into operand1
output CS_Op2_load; //load the data from chosen register into operand2
output CS_PC_load; //load the prg counter address into temporary slot
output CS_PC_inc; //increment the prg counter when execute 
output CS_Reg_load; //after processing addressing mode/arith/logic or consider as execute
//load the output data into the register inside the data mem
//Control Signal 
//ALU_OT, Op1_load, Op2_load, PC_load, PC_inc, Reg_load, Ins_load

// reg CS_ALU_OT;
// reg CS_Ins_load; 
// reg CS_Op1_load; 
// reg CS_Op2_load; 
// reg CS_PC_load; 
// reg CS_PC_inc; 
// reg CS_Reg_load;

endmodule