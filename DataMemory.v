module DataMemory#(
    parameter width = 32,
    parameter depth = 32
)
(
    input  [width-1:0]WD,
    input  [width-1:0]A,
    output [width-1:0]RD,
    output [(width/2)-1:0]test_value,
    input clk,rst,WE
);

reg [width-1:0] memory [depth-1:0];
integer i;
always@(posedge clk, negedge rst)
begin 
    if(~rst)
        begin
            for (i=0;i<depth;i=i+1)
                begin
                    memory[i] <= {(width) {1'b0}};
                end
        end
    else if (WE)
        begin
            memory[A] <= WD;
        end
end 
assign RD=memory[A];
assign test_value=memory[32'h0000_0000];
endmodule 