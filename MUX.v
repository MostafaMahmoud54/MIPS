module MUX
#(parameter  width = 32)
(
    input    wire   [width-1:0]mux_A,mux_B,
    input    wire   sel,
    output   wire   [width-1:0]mux_OUT
);
 
assign mux_OUT = (sel)? mux_A:mux_B;

endmodule