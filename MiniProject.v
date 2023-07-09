module MiniProject 
(clk, en, za, zb, eq, gt, lt);

input clk;
input en;
output reg za;
output reg zb;
output reg eq;
output reg gt;
output reg lt;
output reg [15:0] ALU_out;
output reg [15:0] Addr_out;



wire [15:0] addr_ROM; //PC
wire [15:0] ROM_InsSet; //Instruction Code/Set
wire [15:0] addr_ROM_out;
wire [1:0] byte_ins; //number of byte instruction
wire Ins_load; //control signal for loading instruction code/spliting the instruction set
//Ins_addr = ROM_InsSet
wire [1:0] mode_ins; //mode 00(register addressing), 01(Immediate addressing), 10(Direct addressing)
wire [1:0] OT_ins; //operation type 00(Normal move), 01(Arithmetric), 10(Logic), 11(Not allowed)
wire [2:0] op1_ins; //operand instruction register, operand value will be follow the value inside the register(3 bit)
wire [2:0] op2_ins; //operand instruction register, operand value will be follow the value inside the register(3 bit)
wire [3:0] opcode_ins;//operation code that the operands will do
wire [15:0] addr_output_ins; //instruction set/code output here 
wire load_op1; //control signal for loading data into operand 1 as an output for ALU 
wire load_op2; //control signal for loading data into operand 2 as an output for ALU
wire load_pc; //control signal for loading the value of ROM_addr into pc module for storing on a variable for later process
wire load_reg; //load register when 1 it will save the output from ALU into the certain register that had been set 
wire load_INS; //it will split the instruction code and save each of the meaning of the code into each variable
wire inc_pc; //increment a program counter everytime an execute occurs
wire [15:0] op1_reg_out; //the output value from the register that assign to op1 
wire [15:0] op2_reg_out; //the output value from the register that assign to op2
wire [15:0] data_reg_out; //the output data after processing of ALU
wire [15:0] addr_reg_out; //the 3 bit register that assign to save the output data PS: LOGIC and ARITHMETRIC is the same but addressing mode is different
wire [15:0] output_op1; //data output from operand1 after register send value into it
wire [15:0] output_addr_op1; //address output from operand1 after register send value into it
wire [15:0] output_op2;
wire [15:0] 2byte_addr_op2;
wire [15:0] out_ALU;
wire [15:0] out_Addr;
wire CPU_eq;
wire CPU_gt;
wire CPU_lt;
wire CPU_za;
wire CPU_zb;
wire [15:0] out_RAM;
wire [15:0] out_Addr_RAM;
 







InsROM ro1 (.clk(clk), .ROM_addr(addr_ROM), .ROM_addr_out(addr_ROM_out), .ROM_InsSet_out(ROM_InsSet));
ControlSignal c1 (.clk(clk), .en(en), .CS_opcode(opcode_ins), .CS_ALU_OT(OT_ins), .CS_Op1_load(load_op1), .CS_Op2_load(load_op2), .CS_PC_load(load_pc), .CS_Reg_load(load_reg), .CS_Ins_load(load_INS), .CS_PC_inc(inc_pc));
SplInsSet s1 (.clk(clk), .Ins_byte(byte_ins), .Ins_load(Ins_load), .Ins_addr(ROM_InsSet), .Ins_mode(mode_ins), .Ins_OT(OT_ins), .Ins_Op1(op1_ins), .Ins_Op2(op2_ins), .Ins_Opcode(opcode_ins), .Ins_addr_output(addr_output_ins));
Register r1 (.clk(clk), .Reg_addr_op1(op1_ins), .Reg_addr_op2(op2_ins), .Reg_Out_op1(op1_reg_out), .Reg_Out_op2(op2_reg_out), .Reg_data(data_reg_out), .Reg_addr(addr_reg_out), .Reg_load(load_reg));
PC p1 (.clk(clk), .Ins_addr(addr_ROM_out), .PC_load(load_pc), .PC_inc(inc_pc), .PC_addr(addr_ROM));
Op1 o1 (.clk(clk), .Op1_datafromReg(op1_reg_out), .Op1_output(output_op1), .Op1_load(load_op1), .Op1_addr(op1_ins), .Op1_addr_output(output_addr_op1));
Op2 o2 (.clk(clk), .Op2_datafromReg(op2_reg_out), .Op2_output(output_op2), .Op2_load(load_op2));
ALU al1 (.clk(clk), .op1(output_op1), .op2(output_op2), .ALU_opcode(opcode_ins), .ALU_OT(OT_ins), .za(CPU_za), .zb(CPU_zb), .eq(CPU_eq), .gt(CPU_gt), .lt(CPU_lt), .ALU_out(out_ALU), .op1_regaddr(output_addr_op1), .op2_regaddr(out_RAM), .Addr_out(out_Addr));
RAM ra1 (.clk(clk), .RAM_addr(addr_output_ins), .RAM_out(out_RAM));




     
endmodule