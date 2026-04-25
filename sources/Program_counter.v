`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025 10:39:47 PM
// Design Name: 
// Module Name: Program_counter
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


module Program_Counter(
input clk, reset, PC_Write,
input [63:0] PC_In,
output reg [63:0] PC_Out
    );
    initial
    PC_Out = 64'b0;
    
    always @ (posedge clk)
        begin
        
        if (reset == 1'b1)
            PC_Out <= 64'b0;
        else if (PC_Write==1'b0)
            PC_Out <= PC_Out;
        else
            PC_Out <= PC_In;
        
        end

endmodule
