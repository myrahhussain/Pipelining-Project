`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 11:44:19 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input clk, reset,
    input EX_MEM_RegWrite, EX_MEM_MemToReg, // 1 bit
    input [4:0] EX_MEM_RD, // 5 bits
    input [63:0] ReadData, EX_MEM_ALU_Result, // 64 bits

//outputs
    output reg MEM_WB_RegWrite, MEM_WB_MemToReg, // 1 bit
    output reg [4:0] MEM_WB_RD, //  5 bits
    output reg [63:0] MEM_WB_ReadData, MEM_WB_ALU_Result // 64 bits
);

    always @(posedge clk) begin
        if (reset==1'b1) begin
            // Reset all outputs to default values
            MEM_WB_RegWrite <= 0;
            MEM_WB_MemToReg <= 0;
            
            MEM_WB_ReadData <= 64'b0;
            MEM_WB_ALU_Result <= 64'b0;
            
            MEM_WB_RD <= 5'b0;
        end
        else begin
            // Pass input values to outputs (pipeline register functionality)
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemToReg <= EX_MEM_MemToReg;
            
            MEM_WB_ReadData <= ReadData;
            MEM_WB_ALU_Result <= EX_MEM_ALU_Result;
            
            MEM_WB_RD <= EX_MEM_RD;
        end
    end
endmodule
