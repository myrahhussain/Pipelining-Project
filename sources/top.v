`timescale 1ns / 1ps
module top1(
    input [31:0] instruction,
    output [63:0] ReadData1,
    output [63:0] ReadData2
    );
    
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;
    wire [63:0] WriteData;
    wire RegWrite;
    wire Clk;
    wire Reset;
    
    instruction_parser IP (instruction, opcode, rd, funct3, rs1, rs2, funct7);
    registerFile RF (WriteData, rs1, rs2, rd, RegWrite, Clk, Reset, ReadData1, ReadData2);
    
endmodule
