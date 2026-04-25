`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025 10:41:43 PM
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch (
    input clk,
    input reset,
    output reg [31:0] Instruction
);

    wire [63:0] PC_Out, PC_In;
    
    Program_Counter PC (.clk(clk),.reset(reset),.PC_In(PC_In),.PC_Out(PC_Out));
    Adder Add (.a(PC_Out),.b(4),.out(PC_In)  );

    wire [31:0] Inst;
    Instruction_Memory IM (.Instr_Addr(PC_Out),.Instruction(Inst));

    always @(posedge clk or posedge reset) begin 
        if (reset) begin
                Instruction <= 0;
            end
            else begin
                Instruction <= Inst;
            end
    end

endmodule
