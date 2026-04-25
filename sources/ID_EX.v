`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 11:14:44 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input clk, reset,
    input RegWrite, MemToReg, Branch, MemWrite, MemRead, ALUsrc,  // control signals
    input [1:0] ALUop,
    input [63:0] IF_ID_PC_out, ReadData1, ReadData2, ImmData,
    input [3:0] Funct,
    input [4:0] RS1, RS2, RD,
    
    output reg ID_EX_RegWrite, ID_EX_MemToReg,ID_EX_Branch, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_ALUSrc,
    output reg [1:0] ID_EX_ALUOp,
    output reg [63:0] ID_EX_PC_out, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_ImmData,
    output reg [3:0] ID_EX_Funct,
    output reg [4:0] ID_EX_RS1, ID_EX_RS2, ID_EX_RD

    );
    always @(posedge clk) begin
        if (reset) begin
            // Reset all outputs to default values
            ID_EX_RegWrite <= 0;
            ID_EX_MemToReg <= 0;
            ID_EX_Branch <= 0;
            ID_EX_MemWrite <= 0;
            ID_EX_MemRead <= 0;
            ID_EX_ALUSrc <= 0;
            ID_EX_ALUOp <= 2'b00;
            
            ID_EX_PC_out <= 64'b0;
            ID_EX_ReadData1 <= 64'b0;
            ID_EX_ReadData2 <= 64'b0;
            ID_EX_ImmData <= 64'b0;
            
            ID_EX_Funct <= 4'b0;
            ID_EX_RS1 <= 5'b0;
            ID_EX_RS2 <= 5'b0;
            ID_EX_RD <= 5'b0;
        end
        else begin
            // Pass input values to outputs (pipeline register functionality)
            ID_EX_RegWrite <= RegWrite;
            ID_EX_MemToReg <= MemToReg;
            ID_EX_Branch <= Branch;
            ID_EX_MemWrite <= MemWrite;
            ID_EX_MemRead <= MemRead;
            ID_EX_ALUSrc <= ALUsrc;
            ID_EX_ALUOp <= ALUop;
            
            ID_EX_PC_out <= IF_ID_PC_out;
            ID_EX_ReadData1 <= ReadData1;
            ID_EX_ReadData2 <= ReadData2;
            ID_EX_ImmData <= ImmData;
            
            ID_EX_Funct <= Funct;
            ID_EX_RS1 <= RS1;
            ID_EX_RS2 <= RS2;
            ID_EX_RD <= RD;
        end
    end
        
endmodule

