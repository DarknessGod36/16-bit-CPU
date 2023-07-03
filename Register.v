module  Register (
    Reg_addr_op1, Reg_addr_op2, Reg_Out_op1, Reg_Out_op2, Reg_data_op1, Reg_data_op2, Reg_load
);

input Reg_load; //control signal 
input [2:0] Reg_addr_op1;
input [2:0] Reg_addr_op2;
input [15:0] Reg_data;//data received from moving value exchange
output reg [15:0] Reg_Out;

reg [15:0] mem [0:15];

initial begin
    //inside mem's array is reg_addr
    //initial all the value inside the register array
    mem[000] = 16'b0000000000001010;//10
    mem[001] = 16'b0000001111101000;//1000
    mem[010] = 16'b0000000001100100;//100
    mem[011] = 16'b0000000000000001;//1
    mem[100] = 16'b0010011100010000;//10000
    mem[101] = 16'b0000000000000000;//0
    mem[110] = 16'b0000000111110100;//500
    mem[111] = 16'b0001001110001000;//5000
end


always(clk, Reg_load) begin
    @(posedge clk) begin
        
        if(Reg_load == 1) begin
            mem[Reg_addr_op1] = Reg_data_op1;
            mem[Reg_addr_op2] = Reg_data_op2;
        end

        else if (Reg_load == 0) begin

            Reg_Out_op1 = mem[Reg_addr_op1];
            Reg_Out_op2 = mem[Reg_addr_op2];
            
        end
    end
end
endmodule