module DataPath(

    input CLK,Reset,
    input [31:0]RD_in,Inst,
    input [2:0]ALUControl,
    input MemtoReg,ALUSrc,RegDst,RegWrite,Jump,Branch,
    input PCSrc,
    output Zero,
    output [31:0]PC,WriteData,ALUOut
);

wire [31:0] MUX_SRCB,SIGN_EX_OUT,RD_RF_OUT2,RD_RF_OUT1;
wire [31:0] DM_MUX_OUT;
wire [4:0] WriteReg;
wire [31:0] Shift_Out_32;
wire [31:0] PCPlus4,PCBranch,PCJump;
wire [31:0] mux_before_pc_mux_out;
wire [25:0] Shift_out_26;
wire [31:0] PC_bar;

assign PCJump= {PCPlus4[31:28],Inst[25:0],2'b00};

assign WriteData=RD_RF_OUT2;

//ALU mux
MUX u0(
    .mux_A(SIGN_EX_OUT),
    .mux_B(RD_RF_OUT2),
    .sel(ALUSrc),
    .mux_OUT(MUX_SRCB)
);
//RF mux
MUX #(.width(5)) u1(
    .mux_A(Inst[15:11]),
    .mux_B(Inst[20:16]),
    .sel(RegDst),
    .mux_OUT(WriteReg)
);
//PC mux
MUX u2(
    .mux_A(PCJump),
    .mux_B(mux_before_pc_mux_out),
    .sel(Jump),
    .mux_OUT(PC_bar)
);
//mux before pc mux
MUX u3(
    .mux_A(PCBranch),
    .mux_B(PCPlus4),
    .sel(PCSrc),
    .mux_OUT(mux_before_pc_mux_out)
);

//Data memory mux
MUX u4(
    .mux_A(RD_in),
    .mux_B(ALUOut),
    .sel(MemtoReg),
    .mux_OUT(DM_MUX_OUT)
);
 
ALU u5(
    .SrcA(RD_RF_OUT1),
    .SrcB(MUX_SRCB),
    .Zero_flag(Zero),
    .ALUControl(ALUControl),
    .ALU_Result(ALUOut)
);


PC u6(
    .PC_in(PC_bar),
    .CLK(CLK),
    .RST(Reset),
    .PC_out(PC) 
 );
//Pc branch Adder
Adder u7(
    .A(Shift_Out_32),
    .B(PCPlus4),
    .C(PCBranch) //output
);
//PC plus 4 adder
Adder u8(
    .A(PC),
    .B(32'd4),
    .C(PCPlus4) //output
);

SignExtend u9(
    .Instr(Inst[15:0]),
    .Signalmm(SIGN_EX_OUT) //output
);
//shift 32 (Sign Extend)
shift_left_twice u10(
    .shift_in(SIGN_EX_OUT),
    .shift_out(Shift_Out_32)
);

//shift 25
shift_left_twice #(.width(26))u11(
    .shift_in(Inst[25:0]),
    .shift_out(Shift_out_26)
);
RegisterFile u12(
    .A1(Inst[25:21]),
    .A2(Inst[20:16]),
    .A3(WriteReg),
    .WD3(DM_MUX_OUT),
    .WE3(RegWrite),
    .RD1(RD_RF_OUT1),
    .RD2(RD_RF_OUT2),
    .clk(CLK),
    .rst(Reset)
);

endmodule