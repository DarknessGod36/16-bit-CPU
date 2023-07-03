module SplInsSet(clk, Ins_byte, Ins_load, Ins_addr, Ins_mode, Ins_OT, Ins_Op1, Ins_Op2, Ins_Opcode);
input clk;
input Ins_load; //control signal from CPU
input [15:0]Ins_addr;
output reg [1:0] Ins_mode;
output reg [1:0] Ins_OT;
output reg [2:0] Ins_Op1;
output reg [2:0] Ins_Op2;
output reg [3:0] Ins_Opcode;
output reg [1:0] Ins_byte;

reg [15:0] temp;

always@(posedge clk) begin
    
    if(Ins_load == 1) begin
        temp <= Ins_addr;
    end

    Ins_byte <= temp[13:12];
    Ins_mode <= temp[15:14];
    Ins_OT <= temp [1:0];
    Ins_Op1 <= temp [7:5];
    Ins_Op2 <= temp [4:2];
    Ins_Opcode <= temp [11:8];
end
endmodule

