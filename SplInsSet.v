module SplInsSet(clk, Ins_byte, Ins_load, Ins_addr, Ins_mode, Ins_OT, Ins_Op1, Ins_Op2, Ins_Opcode, Ins_addr_output);
input clk;
input Ins_load; //control signal from CPU
input [15:0]Ins_addr; //Instruction set from ROM 
output reg [1:0] Ins_mode; //Mode from Instruction set 
output reg [1:0] Ins_OT; //Operation type from Instruction set ---> operation type will be used on ALU 
output reg [2:0] Ins_Op1; //Operand 1 address from Instruction set ---> address will be used in register module 
output reg [2:0] Ins_Op2; //Operand 2 address from Instruction set ---> address will be used in register module 
output reg [3:0] Ins_Opcode; //Opcode from the instruction set ----> will be used on the control signal, Arith, Logic and Addressing Mode
output reg [1:0] Ins_byte; //number of byte instruction from the instruction set  ----> will be used on control signal 
output reg [15:0] Ins_addr_output; //the instruction set output  ----> will be used in addressing mode 

reg [15:0] temp;

always@(posedge clk) begin
    
    if(Ins_load == 1) begin
        temp <= Ins_addr;
    end

    Ins_addr_output <= Ins_addr;
    Ins_byte <= temp[13:12];
    Ins_mode <= temp[15:14];
    Ins_OT <= temp [1:0];
    Ins_Op1 <= temp [7:5];
    Ins_Op2 <= temp [4:2];
    Ins_Opcode <= temp [11:8];
end
endmodule

