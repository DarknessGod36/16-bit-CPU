module PC(clk, Ins_addr,PC_load, PC_inc, PC_addr);

//PC_load & PC_inc are the control signal received from the CPU
//PC_load is the address from the instruction set/represent the instruction set load into PC
input clk, PC_load, PC_inc;
input [15:0] Ins_addr;
output reg [15:0] PC_addr; //this will go in InsROM

reg [15:0] temp;


always@(posedge clk) begin

    if(PC_load == 0 && PC_inc == 0) begin
        temp <= 16'b0000000000000000;
    end

    else if(PC_load == 1 && PC_inc == 0) begin
        temp <= Ins_addr;
    end

    else if(PC_load == 0 && PC_inc == 1) begin
        temp = temp + 16'b0000000000000001;
    end

    else begin
        temp <= temp; //PC_load && PC_inc should not be 1 on the same time
    end

    PC_addr <= temp;
end
endmodule







