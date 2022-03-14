module shift_left_twice
#(parameter  width = 32)
(
    input    wire   [width-1:0]shift_in,
    output   wire   [width-1:0]shift_out
);
 
assign shift_out = shift_in<<2;

endmodule