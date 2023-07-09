module AddressingMode (
    op2_data, op1_regaddr, op2_regaddr, AM_opcode, AM_Outdata, AM_OutRegaddr
);

input [15:0] op2_data;
input [2:0] op1_regaddr;
input [15:0] op2_regaddr;
reg [2:0] AM_Accaddr;
input [3:0] AM_opcode;
output reg [15:0] AM_Outdata;
output reg [2:0] AM_OutRegaddr;
//op2_regaddr will be only assign on the next pc instruction set 
initial begin
    AM_Accaddr = 3'b000;
end

always@(op2_data, op1_regaddr, op2_regaddr, AM_opcode) begin
    
    case (AM_opcode)
        //MOV    R1 <- R2 
        4'b1011:  begin
        AM_Outdata <= op2_data;
        AM_OutRegaddr <= op1_regaddr; //this op1 reg will be received form the op1 output 
        //mem[op1_regaddr] = op2_data;
        end
        //MVI 
        4'b1100:  begin
        AM_Outdata <= op2_regaddr;
        AM_OutRegaddr <= op1_regaddr;
        //mem[op1_regaddr] = op2_regaddr;
		  end
		
        //LDA
        4'b1101: begin
        AM_Outdata <= op2_regaddr; //this op1_data will be the 2 byte instruction set  
        AM_OutRegaddr <= AM_Accaddr;
        //mem[AM_Accaddr] = op1_data;
		  end

        default: begin
		  AM_Outdata <= 16'b0000000000000000;
        AM_OutRegaddr <= 3'b000;
		  end
    endcase
end


    
endmodule