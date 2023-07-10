module RAM(clk, RAM_addr, RAM_out);

input clk; 
input [15:0] RAM_addr;  
output reg [15:0] RAM_out;
reg [15:0] RAM_data;


initial begin
    RAM_out = 16'd0000;
end
always@(posedge clk) begin 

    case (RAM_addr)
        16'b1000010110100001: RAM_data = 16'd1000;
        16'b1000010001001001: RAM_data = 16'd5000;
    endcase
    RAM_out <= RAM_data;
    
end
endmodule

//instruction = 4 
//0000 , 1:0 = instruction = 4 
// 3:2 = register = 4 
//logic = 1, arith = 0-> 0000, 0001, 0010, 0011 -> logical instruction , opcode used = 4 
//arith = 1, logic = 0 -> 0000, 0001, 0010, 0011 -> arithmetric instruction, opcode used = 4
//addressing mode =1 -> 0000, 0001, 0010, 0011 
//00 01 10 11 
//00 = operand1 = R0, operand2 = R1;
//01 = operand1 = R0, operand2 = R1;
//10 = operand1 = R1, operand2 = R2;
//11 = operand1 = R1, operand2 = R2;
//opcode 00/00
//opcode add = load acc, load op1's register 1 
//opcode mvi = next pc instruction set value, load op1's register 2
//opcode lda = load acc, load next pc instruction's value 
//              , next pc instruction's value => acc
//operand1 = 001 
//operand2 = 010 

//opcode = 0000 
//mode = 00 

//controller = loadAcc = 1, loadOp1 = 1
//Todo: hardcore register 1 - 7 value
//Todo: accumulator register value 
//





//opcode : 0000 & op1 : 000 & op2 : 000
//opcode : 000000 
//op1 : 00
//op2 : 00
//([1:0] op1, 00,01,10,11) , ([3:2] op2, 00,01,10,11) 
//op1 : 00 (register1) ---> 6 
//op2 : 00 (register5) ---> 10
//op1 : 4 register = register 1,2,3,4 00(1)
//op2 : 4 reigster = register 5,6,7,8

//opcode : 000/000/0000
//opcode : 001/010/0000
//opcode : 0000/000/000
//opcode : 1000/111/110
//case 
//op1 = register 1 load register 1
//op2 = register 2 load register 2


// 00 register 1 
// 01 regidter 2
// 10 regidter 3
// 11 register 4 
// 00 register 5
// 01 register 6
// 10 register 7
// 11 register 8