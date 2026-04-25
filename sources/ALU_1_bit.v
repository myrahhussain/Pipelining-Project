`timescale 1ns / 1ps
module ALU_1_bit(
    input a,
    input b,
    input CarryIn,
    input [3:0] ALUOp,
    output Result,
    output CarryOut
    );
    
    wire Ainvert = ALUOp[3];
    wire Binvert = ALUOp[2];
    wire [1:0] Operation = ALUOp[1:0];
    
    wire mux1out = Ainvert ? ~a : a;
    wire mux2out = Binvert ? ~b : b;
    
    wire andValue = mux1out && mux2out;
    wire orValue = mux1out || mux2out;
    
    assign CarryOut = (b && CarryIn) || (a && CarryIn) || (a && b) || (a && b && CarryIn);
    wire sumBit = (~mux1out && ~mux2out && CarryIn) || (~mux1out && mux2out && ~CarryIn)
                  || (mux1out && ~mux2out && ~CarryIn) || (mux1out && mux2out && CarryIn);
                  
    assign Result = Operation == 2'b00 ? andValue : Operation == 2'b01 ? orValue : sumBit;
    
endmodule
