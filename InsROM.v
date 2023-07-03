module InsROM(clk, ROM_read, ROM_addr, ROM_InsSet);

input clk;
input reg [15:0] ROM_addr;
output reg [15:0] ROM_InsSet;

reg [15:0] mem_addr [15:0];
reg [15:0] mem_InsSet [15:0];


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
    ROM_addr = 16'b0000000000000000;

end

always@(posedge clk) begin

    case(ROM_addr)
    16'b0000000000000000: ROM_InsSet = 16'b0001000000000000;
    16'b0000000000000010: ROM_InsSet = 16'b0110001000000000;
    16'b0000000000000100: ROM_InsSet = 16'b1011111100000000;
    16'b0000000000000110: ROM_InsSet = 16'b0000000000000000;
    16'b0000000000001000: ROM_InsSet = 16'b0001000000000000;
    16'b0000000000001010: ROM_InsSet = 16'b0001000000000000;
    16'b0000000000001100: ROM_InsSet = 16'b0001000000000000;
    16'b0000000000001110: ROM_InsSet = 16'b0001000000000000;
endcase
end
endmodule






