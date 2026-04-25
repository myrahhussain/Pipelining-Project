`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 12:57:04 PM
// Design Name: 
// Module Name: mux_3to1
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


module mux_3to1(
    input [63:0] a,        
    input [63:0] b,        
    input [63:0] c,        
    input [1:0] sel,       // Selection signal from forwarding unit
    output reg [63:0] out  // Selected output value
    );
    always @(a,b,c,sel) begin
        case(sel)
            2'b00: out <= a;    // No forwarding, use original value
            2'b01: out <= b;   
            2'b10: out <= c;
        endcase
    end 
endmodule