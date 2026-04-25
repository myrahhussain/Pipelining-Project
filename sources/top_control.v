`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2025 09:49:21 AM
// Design Name: 
// Module Name: top_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_control(
    input [6:0] Opcode,
    input [3:0] Funct,
    output Branch,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output [3:0] Operation
    );
    
    wire [1:0]ALUOp;
    control_unit cu(Opcode,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite);
    ALU_control ac(ALUOp,Funct,Operation);
    
endmodule