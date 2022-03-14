module ALU
#(parameter width = 32)
(
    input       wire    [width-1:0]SrcA,SrcB,
    input       wire    [2:0]ALUControl,
    output      wire    [width-1:0]ALU_Result,
    output      wire     Zero_flag
);
reg Zero;
reg [width-1:0]ALUResult;

assign Zero_flag = Zero;
assign ALU_Result = ALUResult;

always@(*)
begin
    case(ALUControl)
    3'b000 : begin
                ALUResult = SrcA & SrcB;
            end 
    3'b001 : begin
                ALUResult = SrcA | SrcB;
             end
    3'b010 : begin
                ALUResult = SrcA + SrcB;
            end
    3'b100 : begin
                ALUResult = SrcA - SrcB;
             end
    3'b101 : begin
                ALUResult = SrcA * SrcB;
            end
    3'b110 : begin
                if(SrcA < SrcB)
                    begin
                        ALUResult = 1'b1;
                    end
                else
                    begin
                        ALUResult = 1'b0;
                    end
            end
    default: begin
            ALUResult = 1'b0;
            end
    endcase
    Zero = ~|ALUResult;
end
    endmodule