`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 10:26:42 PM
// Design Name: 
// Module Name: Hazard_detection_unit
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


module Hazard_detection_unit(
    input [4:0] RS1, RS2, ID_EX_RD,
    input ID_EX_MemRead,
    output reg  IF_ID_write, PC_Write, mux_selector_bit
    
    );
    
    always @(*) begin
        if ((ID_EX_MemRead==1) && ((ID_EX_RD==RS1)||(ID_EX_RD==RS2))) begin
            mux_selector_bit = 1;
            IF_ID_write = 0;
            PC_Write = 0;
        end
        else begin
            mux_selector_bit= 0;
            IF_ID_write = 1;
            PC_Write = 1;
        end 

    end
    
endmodule
