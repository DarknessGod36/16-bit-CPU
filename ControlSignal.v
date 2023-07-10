module ControlSignal (
    clk, en, CS_opcode, CS_ALU_OT, CS_Op1_load, CS_Op2_load, CS_PC_load, CS_Reg_load, CS_Ins_load, CS_PC_inc, byte2opcode);


input clk;
input en; //enable the control signal
input [3:0] CS_opcode;
output reg [1:0] CS_ALU_OT; //the ALU mode for picking which mode it will process 
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
output reg [3:0] byte2opcode;

reg CS_Ins_load; 
reg CS_Op1_load; 
reg CS_Op2_load; 
reg CS_PC_load; 
reg CS_PC_inc; 
reg CS_Reg_load;


reg [2:0] state;
reg [2:0] next_state ;

parameter reset = 3'b000, load = 3'b001, execute = 3'b010, byte2load = 3'b011, byte2execute = 3'b100, savedata = 3'b101;
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
        CS_PC_inc = 1;
        CS_PC_load = 1;
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

            execute: begin
                case (CS_opcode)
                    //Mode 00 which is addressing mode
                    4'b1011: begin
                    //Opcode 0000 -> normal move
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; //the op1 module wont run or the op1 variable will receive the value beforehand but wont proceed to any operation 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state =savedata;
                        byte2opcode = CS_opcode;
                        next_state = reset;
                    end 
                    
                    4'b1100: begin
                    //Opcode 0001 -> MVI
                        CS_ALU_OT = 2'bXX;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; //since i create an op1_addr at op1 module so i will load it and save the addr into that variable
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        byte2opcode = CS_opcode;
                        next_state = byte2load;
                    end

                    4'b1101: begin
                    //Opcode 0010 -> LDA
                    //this operation we already set the accumulator to have a 000 address which mean we no need to load anything on the first pc
                        CS_ALU_OT = 2'bXX;
                        CS_Ins_load = 0;
                        CS_Op1_load = 0; 
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        byte2opcode = CS_opcode;
                        next_state = byte2load;
                    end
                    //Mode 01 which is Arithmetric mode
                    4'b0000: begin
                    //Opcode 0000 -> ADD 
                        CS_ALU_OT = 2'b01;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;

                    end
                    4'b0001: begin
                    //Opcode 0001 -> MUL 
                        CS_ALU_OT = 2'b01;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;

                    end
                    4'b0010: begin
                    //Opcode 0010 -> SUB
                        CS_ALU_OT = 2'b01;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;

                    end
                    4'b0011: begin
                    //Opcode 0011 -> DIV
                        CS_ALU_OT = 2'b01;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    //mode 10 which is Logical MOde
                    4'b0100: begin
                    //Opcode 0100 -> AND
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b0101: begin
                    //Opcode 0101 -> OR
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b0110: begin
                    //Opcode 0110 -> NOR
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b0111: begin
                    //Opcode 0111 -> INV(op1)
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b1000: begin
                    //Opcode 1000 -> INV(op2)
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 0; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b1001: begin
                    //Opcode 1001 -> XOR
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    4'b1010: begin
                    //Opcode 1010 -> XNOR
                        CS_ALU_OT = 2'b10;
                        CS_Ins_load = 0;
                        CS_Op1_load = 1; 
                        CS_Op2_load = 1;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 1;
                        //next_state = savedata;
                        next_state = reset;
                        
                    end
                    default:begin
                        CS_ALU_OT = 2'bZZ;
                        CS_Ins_load = 1;
                        CS_Op1_load = 0; 
                        CS_Op2_load = 0;
                        CS_PC_inc = 0;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        next_state = reset;
                        
                    end 

                endcase
            end

            byte2load: begin 
                        CS_ALU_OT = 2'bXX;
                        CS_Ins_load = 1; 
                        CS_Op1_load = 0;
                        CS_Op2_load = 0;
                        CS_PC_inc = 0;
                        CS_PC_load = 1;
                        CS_Reg_load = 0;
                        next_state = byte2execute;
            end

            byte2execute: begin
                     //this will need op2_data as an output
                        CS_ALU_OT = 2'b00;
                        CS_Ins_load = 0; 
                        CS_Op1_load = 0;
                        CS_Op2_load = 0;
                        CS_PC_inc = 1;
                        CS_PC_load = 0;
                        CS_Reg_load = 0;
                        //next_state = savedata;
                        next_state = reset;
                     //this will need the 2-byte instruciton pc and it will be processed on the the InsROM, the pc will be wired to op1_data in Addressing Mode       
            end

            savedata: begin
                CS_Reg_load = 1;
                next_state = reset;
            end
        endcase
    end
end

endmodule