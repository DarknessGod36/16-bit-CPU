module InsROM(clk, ROM_addr, ROM_addr_out, ROM_InsSet_out);

input clk;
input [15:0] ROM_addr;
output reg [15:0] ROM_addr_out;
reg [15:0] ROM_InsSet;
output reg [15:0] ROM_InsSet_out;



//mode  byte    opcode  operand1    operand2    operationtype
//00    00      0000    000         000         00
// byte 10 
// operand, register 16bit
// register1 + register2   = 0000 1000 0100 0101 
// 
//
// initial 
// begin
//     16'b0000000000000000 = 0001000000000000
//     16'b0000000000000010 = 0110001000000000
//     16'b0000000000000100 = 1011111100000000
//     16'b0000000000000110 = 0000000000000000
//     16'b0000000000001000 = 0000000000000000
//     16'b0000000000001010 = 0000000000000000
//     16'b0000000000001100 = 0000000000000000
//     16'b0000000000001110 = 0000000000000000
// end


initial begin
    ROM_InsSet = 16'b0000000000000000;

end

always@(posedge clk) begin

    case(ROM_addr)
    //MOV
    16'b0000000000000000: ROM_InsSet = 16'b0001101101011100; 
    //MVI
    16'b0000000000000001: ROM_InsSet = 16'b0110110001011000; //----> 1 byte
    16'b0000000000000010: ROM_InsSet = 16'b1000010110100001; //----> 2 byte
    //LDA
    16'b0000000000000011: ROM_InsSet = 16'b1010110111001100; //----> 1 byte
    16'b0000000000000100: ROM_InsSet = 16'b1000010001001001; //----> 2 byte
    //ADD
    16'b0000000000000101: ROM_InsSet = 16'b0001000000010101; //----> OP1(Acc Reg = 000) = ??, OP2(register addr = 101) = ??
    //SUB
    16'b0000000000000110: ROM_InsSet = 16'b0001001000011101; //----> OP1(Acc Reg = 000) = ??, OP2(register addr = 111) = ??
    //XOR
    16'b0000000000000111: ROM_InsSet = 16'b0001100101011010; //----> OP1(register addr = 010) = ??, OP2(register addr = 110) = ??
    //AND
    16'b0000000000001000: ROM_InsSet = 16'b0001010010000110; //----> OP1(register addr = 100) = ??, OP2(register addr = 001) = ??
endcase

    ROM_addr_out <= ROM_addr;
    ROM_InsSet_out <= ROM_InsSet;
end
endmodule






