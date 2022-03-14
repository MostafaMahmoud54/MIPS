module PC(
    input  [31:0]PC_in,
    input  CLK,RST,
    output wire [31:0]PC_out
);

reg [31:0]PC_OUT_Reg;
assign PC_out=PC_OUT_Reg;
always@(posedge CLK,negedge RST)
begin
    if(~RST)
        PC_OUT_Reg<=32'b0;
    else 
        PC_OUT_Reg<=PC_in;
end

endmodule