`timescale 1ns / 1ps

module ALU_8_bit(
    input [7:0] a, [7:0] b,
    input CarryIn,
    input [3:0] ALUOp,
    output [7:0] Result,
    output CarryOut
    );
    
    wire C1, C2, C3, C4, C5, C6, C7;
    
    ALU_1_bit A0 (a[0], b[0], CarryIn, ALUOp, Result[0], C1);
    ALU_1_bit A1 (a[1], b[1], C1, ALUOp, Result[1], C2);
    ALU_1_bit A2 (a[2], b[2], C2, ALUOp, Result[2], C3);
    ALU_1_bit A3 (a[3], b[3], C3, ALUOp, Result[3], C4);
    ALU_1_bit A4 (a[4], b[4], C4, ALUOp, Result[4], C5);
    ALU_1_bit A5 (a[5], b[5], C5, ALUOp, Result[5], C6);
    ALU_1_bit A6 (a[6], b[6], C6, ALUOp, Result[6], C7);
    ALU_1_bit A7 (a[7], b[7], C7, ALUOp, Result[7], CarryOut);
    
endmodule
