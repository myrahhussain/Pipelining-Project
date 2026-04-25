`timescale 1ns / 1ps
module mux(
        input [63:0] a, input [63:0] b, input sel, output reg [63:0] data_out
    );
    
    always @(a,b,sel) //parameters which trigger reevaluation- their values change
begin


if (sel)
    data_out <= b;
else
    data_out <= a;

end
    
endmodule
