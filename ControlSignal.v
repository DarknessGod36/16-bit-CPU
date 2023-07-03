module ControlSignal (
    clk, en, CS_opcode, CS_ALU_OT, CS_Op1_load, CS_Op2_load, CS_PC_load, CS_Reg_load, CS_Ins_load, CS_PC_inc;
);


input clk, 
input en; //enable the control signal
input [3:0] CS_opcode;
output [2:0] CS_ALU_OT; //the ALU mode for picking which mode it will process 
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

reg CS_ALU_OT;
reg CS_Ins_load; 
reg CS_Op1_load; 
reg CS_Op2_load; 
reg CS_PC_load; 
reg CS_PC_inc; 
reg CS_Reg_load;


reg [2:0] state;
reg [2:0] next_state ;

parameter reset = 4'b0000, load = 4'b0010, execute = 4'b0100, 2byteload = 4'b1000;
always@(posedge clk) begin
    if(en == 0) begin
        state = reset;
    end
    else if (en == 1) begin
        state = next_state;
    end
end

always@(*) begin
    if (en == 0) begin
        CS_ALU_OT = 2'bZZ;
        CS_Ins_load = 0;
        CS_Op1_load = 0;
        CS_Op2_load = 0;
        CS_PC_inc = 0;
        CS_PC_load = 0;
        CS_Reg_load = 0;
        next_state = reset;
    end

    else begin
        case (state)
            reset: begin
                CS_ALU_OT = 2'bZZ;
                CS_Ins_load = 0;
                CS_Op1_load = 0;
                CS_Op2_load = 0;
                CS_PC_inc = 0;
                CS_PC_load = 0;
                CS_Reg_load = 0;
                next_state = load;
            end

            load: begin
                CS_ALU_OT = 2'bZZ;
                CS_Ins_load = 1;
                CS_Op1_load = 0;
                CS_Op2_load = 0;
                CS_PC_inc = 0;
                CS_PC_load = 1;
                CS_Reg_load = 0; 
                next_state = execute;

                //for this CS_Reg_load may need to change later or create 
                //another state to delay it as the instruction only load into for spliting 
                //it may cause a slight delay for the register/mem to receive the value and
                //load into the op1 or op2 or acc
            end

            2byteload: begin
                case (CS_opcode)
                    0001: begin
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 1; //this is the next pc split and the ins_set in the split module will be overwrite from the previous pc value 
                        CS_Op1_load = 0;
                        CS_Op2_load = 0;
                        CS_PC_inc = 0;
                        CS_PC_load = 1;
                        CS_Reg_load = 1;
                    end 

                    0010: begin
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 1; 
                        CS_Op1_load = 1;
                        CS_Op2_load = 0;
                        CS_PC_inc = 0;
                        CS_PC_load = 1;
                        CS_Reg_load = 1;
                    end
                    default: 
                endcase
            end

            execute: begin
                case (CS_opcode)
                    //Mode 00 which is addressing mode
                    0000: begin
                    //Opcode 0000 -> normal move
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 0;
                        CS_Op1_load = 0; //the op1 module wont run or the op1 variable will receive the value beforehand but wont proceed to any operation 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                    end 
                    
                    0001: begin
                    //Opcode 0001 -> MVI
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; //since i create an op1_addr at op1 module so i will load it and save the addr into that variable
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        next_state = 2byteload;
                    end

                    0010: begin
                    //Opcode 0010 -> LDA
                    //this operation we already set the accumulator to have a 000 address which mean we no need to load anything on the first pc
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 0;
                        CS_Op1_load = 0; 
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        next_state = 2byteload;
                    end
                    default: 
                endcase
            end


            default: 
        endcase
    end
end

endmodule