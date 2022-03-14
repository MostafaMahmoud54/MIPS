module SignExtend (
    input  [15:0]Instr,
    output [31:0]Signalmm
);
assign Signalmm=Instr[15] ? {16'b1111111111111111,Instr}: {15'b0,Instr};
endmodule 