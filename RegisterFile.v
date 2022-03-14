module RegisterFile #(
    parameter width = 32,
    parameter depth = 32
)
(
    output [width-1:0] RD1,RD2,
    input [width-1:0] WD3,
    input [$clog2 (width)-1:0] A1,A2,A3,
    input WE3,
    input clk,rst
);

reg [width-1:0] memory [0:depth-1];
integer i;

always@(posedge clk, negedge rst)
begin
    if(~rst)
        begin
            for(i=0;i<depth;i=i+1)
                begin
                    memory[i] <= {(width) {1'b0}};
                end
        end
    else if (WE3)
        begin
            memory[A3] <= WD3;
        end
end
assign RD1=memory[A1];
assign RD2=memory[A2];

endmodule