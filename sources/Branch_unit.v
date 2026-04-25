`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 08:04:49 PM
// Design Name: 
// Module Name: Branch_unit
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


module Branch_unit(
    input [2:0] funct3,
    input [63:0] ReadData1, ReadData2,
    output reg branchSel
    );
    
    initial
    branchSel = 0;
    
    always @(*)
        begin
        case (funct3)
            3'b000: // beq
                begin
                    if (ReadData1 == ReadData2)
                        branchSel <= 1;
                    else
                        branchSel <= 0; 
                end
            3'b100: // blt
                begin
                    if (ReadData1 < ReadData2)
                        branchSel <= 1;
                    else
                        branchSel <= 0;
                end
            3'b101: // bge
                begin
                    if (ReadData1 >= ReadData2)
                        branchSel <= 1;
                    else
                        branchSel <= 0;
                end
            endcase
        end   
    
   
endmodule
