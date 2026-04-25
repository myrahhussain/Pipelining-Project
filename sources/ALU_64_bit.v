`timescale 1ns / 1ps
module ALU_64_bit(
    input [63:0] a, [63:0] b,
    input [3:0] ALUOp,
    output reg [63:0] Result,
    output reg Zero,
    output reg LessThan
    );
   
     
     
     always @(ALUOp, a, b) begin
        case (ALUOp)
           4'b0000: Result <= a&b;
           4'b0001: Result <= a|b;
           4'b0010: Result <= a+b;
           4'b0110: Result <= a-b;
           4'b1100: Result <= ~a & ~b;
           4'b1000: Result <= a << b;
           default: Result <= 64'b0;
        endcase

        if (a==b) Zero<=1;
        else Zero<=0;
        
        if (a<b) LessThan<=1;
        else LessThan<=0;

     end           
    
    

endmodule
