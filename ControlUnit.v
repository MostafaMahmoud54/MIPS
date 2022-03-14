module ControlUnit(
    input [31:0]Inst,
    output MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump,
    output [2:0]ALUControl
);

wire [5:0]OPcode = Inst[31:26];
wire [5:0]Funct  = Inst[5:0];
wire [1:0]ALUOp ;

reg MemtoReg_reg,MemWrite_reg,Branch_reg,ALUSrc_reg,RegDst_reg,RegWrite_reg,Jump_reg;
reg [1:0]ALUOp_reg;
reg [2:0]ALUControl_reg;

assign MemtoReg = MemtoReg_reg;
assign MemWrite = MemWrite_reg;
assign Branch   = Branch_reg;
assign ALUSrc   = ALUSrc_reg;
assign RegDst   = RegDst_reg;
assign RegWrite = RegWrite_reg;
assign Jump     = Jump_reg;
assign ALUOp    = ALUOp_reg;
assign ALUControl= ALUControl_reg;

parameter add=6'b100000;
parameter sub=6'b100010;
parameter slt=6'b101010;
parameter mul=6'b011100;

always@(*)
begin
    case (OPcode)
    6'b100011: begin
        MemtoReg_reg <=1;
        MemWrite_reg <=0;
        Branch_reg <=0;
        ALUSrc_reg <=1;
        RegDst_reg <=0;
        RegWrite_reg <=1;
        Jump_reg <=0;
        ALUOp_reg <=2'b00;
    end
    6'b101011: begin
        MemtoReg_reg <=1;
        MemWrite_reg <=1;
        Branch_reg <=0;
        ALUSrc_reg <=1;
        RegDst_reg <=0;
        RegWrite_reg <=0;
        Jump_reg <=0;
        ALUOp_reg <=2'b00;
    end
    6'b000000: begin
        MemtoReg_reg <=0;
        MemWrite_reg <=0;
        Branch_reg <=0;
        ALUSrc_reg <=0;
        RegDst_reg <=1;
        RegWrite_reg <=1;
        Jump_reg <=0;
        ALUOp_reg <=2'b10;
    end
    6'b001000: begin
        MemtoReg_reg <=0;
        MemWrite_reg <=0;
        Branch_reg <=0;
        ALUSrc_reg <=1;
        RegDst_reg <=0;
        RegWrite_reg <=1;
        Jump_reg <=0;
        ALUOp_reg <=2'b00;
    end
    6'b000100: begin
        MemtoReg_reg <=0;
        MemWrite_reg <=0;
        Branch_reg <=1;
        ALUSrc_reg <=0;
        RegDst_reg <=0;
        RegWrite_reg <=0;
        Jump_reg <=0;
        ALUOp_reg <=2'b01;
    end
    6'b000010: begin
        MemtoReg_reg <=0;
        MemWrite_reg <=0;
        Branch_reg <=0;
        ALUSrc_reg <=0;
        RegDst_reg <=0;
        RegWrite_reg <=0;
        Jump_reg <=1;
        ALUOp_reg <=2'b00;
    end
    default: begin
        MemtoReg_reg <=0;
        MemWrite_reg <=0;
        Branch_reg <=0;
        ALUSrc_reg <=0;
        RegDst_reg <=0;
        RegWrite_reg <=0;
        Jump_reg <=0;
        ALUOp_reg <=2'b00;
    end
    endcase
end

always@(ALUOp_reg)
begin 
    case (ALUOp_reg)
    2'b00: begin
        ALUControl_reg=3'b010;
    end 
    2'b01: begin
        ALUControl_reg=3'b100;
    end
    2'b10: begin
        if(Funct==add)
            begin
                ALUControl_reg=3'b010;
            end
        else if(Funct==sub)
            begin
                ALUControl_reg=3'b100;
            end
        else if(Funct==slt)
            begin
                ALUControl_reg=3'b110;
            end
        else if(Funct==mul)
            begin
                ALUControl_reg=3'b101;
            end
        end
    default : 
    begin
            ALUControl_reg=3'b010;
    end

    endcase
end 
endmodule 