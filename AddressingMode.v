module AddressingMode (
    op1_data, op2_data, op1_regaddr, op2_regaddr, AM_opcode, AM_Outdata, AM_OutRegaddr;
);

input 
input [15:0] op1_data;
input [15:0] op2_data;
input [15:0] op1_regaddr;
input [15:0] op2_regaddr;
reg [2:0] AM_Accaddr;
input [3:0] AM_opcode;
output reg [15:0] AM_Outdata;
output reg [15:0] AM_OutRegaddr;

initial begin
    AM_Accaddr = 16'b0000000000000000;
end

always@(op1, op2, AM_opcode) begin
    
    case (AM_opcode)
        //MOV    R1 <- R2 
        4'b0000:  
        AM_Outdata <= op2_data;
        AM_OutRegaddr <= op1_regaddr;
        //mem[op1_regaddr] = op2_data;
        
        //MVI 
        4'b0001:
        AM_Outdata <= op2_regaddr;
        AM_OutRegaddr <= op1_regaddr;
        //mem[op1_regaddr] = op2_regaddr;

        //LDA
        4'b0010:
        AM_Outdata <= op1_data;
        AM_OutRegaddr <= AM_Accaddr;
        //mem[AM_Accaddr] = op1_data;

        default: AM_Outdata <= 16'b0000000000000000;
        AM_OutRegaddr <= 16'b0000000000000000;
    endcase
end


    
endmodule