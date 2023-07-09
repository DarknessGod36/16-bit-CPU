module MiniProject 
(clk, en, za, zb, eq, gt, lt, ALU_Out, Addr_out, tPC_load, tPC_inc, oregA, oregR1, oregR2, oregR3, oregR4, oregR5, oregR6, oregR7, tReg_load);

input clk;
input en;
output za;
output zb;
output eq;
output gt;
output lt;
output [15:0] ALU_Out;
output [2:0] Addr_out;
output tPC_inc;
output tPC_load;
output tReg_load;
output [15:0] oregA, oregR1, oregR2, oregR3, oregR4, oregR5, oregR6, oregR7;




wire [15:0] addr_ROM; //PC
wire [15:0] ROM_InsSet; //Instruction Code/Set
wire [15:0] addr_ROM_out;
wire [1:0] byte_ins; //number of byte instruction
wire Ins_load; //control signal for loading instruction code/spliting the instruction set
//Ins_addr = ROM_InsSet
wire [1:0] mode_ins; //mode 00(register addressing), 01(Immediate addressing), 10(Direct addressing)
wire [1:0] OT_ins_CS; //operation type 00(Normal move), 01(Arithmetric), 10(Logic), 11(Not allowed)
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
wire [15:0] output_op1; //data output from operand1 after register send value into it
wire [15:0] output_addr_op1; //address output from operand1 after register send value into it
wire [15:0] output_op2;
wire [15:0] byte2_addr_op2;
wire [15:0] out_ALU;
wire [2:0] out_Addr;
wire CPU_eq;
wire CPU_gt;
wire CPU_lt;
wire CPU_za;
wire CPU_zb;
wire [15:0] out_RAM;
wire [15:0] out_Addr_RAM;
wire [15:0] regA, regR1, regR2, regR3, regR4, regR5, regR6, regR7;
 







InsROM ro1 (.clk(clk), .ROM_addr(addr_ROM), .ROM_addr_out(addr_ROM_out), .ROM_InsSet_out(ROM_InsSet));

ControlSignal c1 (.clk(clk), .en(en), .CS_opcode(opcode_ins), .CS_ALU_OT(OT_ins_CS), .CS_Op1_load(load_op1), .CS_Op2_load(load_op2), .CS_PC_load(load_pc), .CS_Reg_load(load_reg), .CS_Ins_load(load_INS), .CS_PC_inc(inc_pc));

SplInsSet s1 (.clk(clk), .Ins_byte(byte_ins), .Ins_load(load_INS), .Ins_addr(ROM_InsSet), .Ins_mode(mode_ins), .Ins_Op1(op1_ins), .Ins_Op2(op2_ins), .Ins_Opcode(opcode_ins), .Ins_addr_output(addr_output_ins));

Register r1 (.clk(clk), .Reg_addr_op1(op1_ins), .Reg_addr_op2(op2_ins), .Reg_Out_op1(op1_reg_out), .Reg_Out_op2(op2_reg_out), .Reg_data(out_ALU), .Reg_addr(out_Addr), .Reg_load(load_reg), .regA(regA), .regR1(regR1), .regR2(regR2), .regR3(regR3), .regR4(regR4), .regR5(regR5), .regR6(regR6), .regR7(regR7));

PC p1 (.clk(clk), .Ins_addr(addr_ROM_out), .PC_load(load_pc), .PC_inc(inc_pc), .PC_addr(addr_ROM));

Op1 o1 (.clk(clk), .Op1_datafromReg(op1_reg_out), .Op1_output(output_op1), .Op1_load(load_op1), .Op1_addr(op1_ins), .Op1_addr_output(output_addr_op1));

Op2 o2 (.clk(clk), .Op2_datafromReg(op2_reg_out), .Op2_output(output_op2), .Op2_load(load_op2));

ALU al1 (.clk(clk), .op1(output_op1), .op2(output_op2), .ALU_opcode(opcode_ins), .ALU_OT(OT_ins_CS), .za(CPU_za), .zb(CPU_zb), .eq(CPU_eq), .gt(CPU_gt), .lt(CPU_lt), .ALU_out(out_ALU), .op1_regaddr(output_addr_op1), .op2_regaddr(out_RAM), .Addr_out(out_Addr));

RAM ra1 (.clk(clk), .RAM_addr(addr_output_ins), .RAM_out(out_RAM));

assign za = CPU_za;
assign zb = CPU_zb;
assign eq = CPU_eq;
assign gt = CPU_gt;
assign lt = CPU_lt;
assign ALU_Out = out_ALU;
assign Addr_out = out_Addr;
assign tPC_load = load_pc;
assign tPC_inc = inc_pc;
assign oregA = regA;
assign oregR1 = regR1;
assign oregR2 = regR2;
assign oregR3 = regR3;
assign oregR4 = regR4;
assign oregR5 = regR5;
assign oregR6 = regR6; 
assign oregR7 = regR7;
assign tReg_load = load_reg;


     
endmodule