module  Register (
    clk, Reg_addr_op1, Reg_addr_op2, Reg_Out_op1, Reg_Out_op2, Reg_data, Reg_addr, Reg_load, regA, regR1, regR2, regR3, regR4, regR5, regR6, regR7
);

input clk;
input Reg_load; //control signal 
input [2:0] Reg_addr_op1;
input [2:0] Reg_addr_op2;
input [2:0] Reg_addr; //address after instruction
input [15:0] Reg_data;//data after instruction 
output reg [2:0] Reg_Out_op1;
output reg [2:0] Reg_Out_op2;
output [15:0] regA, regR1, regR2, regR3, regR4, regR5, regR6, regR7;

reg [15:0] mem [0:7];

initial begin
    //inside mem's array is reg_addr
    //initial all the value inside the register array
    mem[3'b000] = 16'b0000000000001010;//10
    mem[3'b001] = 16'b0000001111101000;//1000
    mem[3'b010] = 16'b0000000001100100;//100
    mem[3'b011] = 16'b0000000000000001;//1
    mem[3'b100] = 16'b0010011100010000;//10000
    mem[3'b101] = 16'b0000000000000000;//0
    mem[3'b110] = 16'b0000000111110100;//500
    mem[3'b111] = 16'b0001001110001000;//5000
end


always@(clk, Reg_load) begin
    @(posedge clk) begin
        
        if(Reg_load == 1) begin
            mem[Reg_addr] = Reg_data;
            //mem[Reg_addr_op2] = Reg_data_op2;
        end

        else if (Reg_load == 0) begin

            Reg_Out_op1 = mem[Reg_addr_op1];
            Reg_Out_op2 = mem[Reg_addr_op2];
            
        end
    end
end

assign regA = mem[0];
assign regR1 = mem[1];
assign regR2 = mem[2];
assign regR3 = mem[3];
assign regR4 = mem[4];
assign regR5 = mem[5];
assign regR6 = mem[6];
assign regR7 = mem[7];
endmodule