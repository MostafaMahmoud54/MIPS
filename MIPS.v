module MIPS(
    input CLK,RESET,
    output wire [15:0]test_value
);

wire MemtoReg_c, MemWrite_c , Branch_c , ALUSrc_c , RegDst_c , RegWrite_c , Jump_C , PCSrc_a;
wire Zero_D;
wire [2:0]ALUControl_c;
wire [31:0]ALUOut_D , WriteData_D , readData_D , Instruction_D , PC_I;

DataPath u0(
    .CLK(CLK),
    .Reset(RESET),
    .RD_in(readData_D),
    .Inst(Instruction_D),
    .ALUControl(ALUControl_c),
    .MemtoReg(MemtoReg_c),
    .ALUSrc(ALUSrc_c),
    .RegDst(RegDst_c),
    .RegWrite(RegWrite_c),
    .Jump(Jump_C),
    .Branch(Branch_c),
    .Zero(Zero_D),//output
    .PC(PC_I),//output
    .WriteData(WriteData_D),//output
    .PCSrc(PCSrc_a),
    .ALUOut(ALUOut_D)//output
);

ControlUnit u1(
    .Inst(Instruction_D),
    .MemtoReg(MemtoReg_c),
    .MemWrite(MemWrite_c),
    .Branch(Branch_c),
    .ALUSrc(ALUSrc_c),
    .RegDst(RegDst_c),
    .RegWrite(RegWrite_c),
    .Jump(Jump_C),
    .ALUControl(ALUControl_c)
);

Inst_memory u2(
    .PC(PC_I),
    .Inst(Instruction_D)
);

DataMemory u3(
    .WD(WriteData_D),
    .A(ALUOut_D),
    .RD(readData_D),
    .test_value(test_value),
    .clk(CLK),
    .rst(RESET),
    .WE(MemWrite_c)
);

And_Gate u4(
    .IN1(Zero_D),
    .IN2(Branch_c),
    .AND_out(PCSrc_a)
);
endmodule