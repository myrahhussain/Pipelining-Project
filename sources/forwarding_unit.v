`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 11:17:09 AM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input [4:0] EX_MEM_RD, MEM_WB_RD, // RD registers 
    input [4:0] ID_EX_RS1, ID_EX_RS2, // RS1, RS2 from ID/EX pipline reg
    input EX_MEM_RegWrite, MEM_WB_RegWrite, // control signals

    output reg [1:0] ForwardA, ForwardB  //outputs for muxes 

    );

    always @(*) begin

        // 1a. EX/MEM.RegisterRd = ID/EX.RegisterRs1
        if ((EX_MEM_RegWrite==1) && (EX_MEM_RD!=0) && (EX_MEM_RD==ID_EX_RS1))
            ForwardA=2'b10;
        // 2a. MEM/WB.RegisterRd = ID/EX.RegisterRs1
        else if ((MEM_WB_RegWrite==1) && (MEM_WB_RD!=0) && (MEM_WB_RD==ID_EX_RS1) && !(EX_MEM_RegWrite == 1 && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS1))
            ForwardA=2'b01;
        else 
            ForwardA=2'b00;

        // 1b. EX/MEM.RegisterRd = ID/EX.RegisterRs2
        if ((EX_MEM_RegWrite==1) && (EX_MEM_RD!=0) && (EX_MEM_RD==ID_EX_RS2))
            ForwardB=2'b10;
        // 2b. MEM/WB.RegisterRd = ID/EX.RegisterRs2
        else if ((MEM_WB_RegWrite==1) && (MEM_WB_RD!=0) && (MEM_WB_RD==ID_EX_RS2) && !(EX_MEM_RegWrite == 1 && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS2))
            ForwardB=2'b01;
        else 
            ForwardB=2'b00;
    end
endmodule
