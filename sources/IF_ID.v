`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2025 11:04:29 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
input clk, reset, 
    input [31:0] Instr,
    input [63:0] PC_OUT_IN,
    input IF_ID_Write,
    output reg [31:0] IF_ID_instruction_out,
    output reg [63:0] IF_ID_pc_out
    ); 
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IF_ID_pc_out <= 0;
            IF_ID_instruction_out <= 0;
        end 
        else if (IF_ID_Write==1'b0) begin
            IF_ID_pc_out <= IF_ID_pc_out;
            IF_ID_instruction_out <= IF_ID_instruction_out;
        end
        else begin
            IF_ID_pc_out <= PC_OUT_IN;
            IF_ID_instruction_out <= Instr;
        end
    end
endmodule
