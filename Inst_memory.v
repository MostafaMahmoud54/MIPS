module Inst_memory(
input [31:0]PC,
output [31:0]Inst
);
reg [31:0] dout_r;
assign Inst=dout_r;
reg [31:0] memory [0:31];
//initial $readmemh("Program 1_Machine Code.txt",memory) ;
initial $readmemh("Program 3_Machine Code.txt",memory) ;

always@(*)
begin
    dout_r<=memory[PC>>2];
end

endmodule