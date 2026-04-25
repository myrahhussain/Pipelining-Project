`timescale 1ns / 1ps
module Data_Memory(
    input [63:0] Memory_Address,
    input [63:0] Write_Data,
    input clk,
    input MemWrite,
    input MemRead,
    output reg [63:0] ReadData,
    
    // outputs for waveform display
    output [63:0] w0, w1, w2, w3, w4, w5, w6
    );
    
    
    reg [7:0] DataMemory [511:0];  // Expanded to allow for byte 256+
    
    integer i;
    initial
    begin
        for (i = 0; i < 512; i = i + 1)
            DataMemory[i] = 0;
        // Changed to 4-byte spacing (32-bit words) starting at byte 256
        DataMemory[256] = 7;  // First element (7)
        DataMemory[260] = 6;  // Second element (6)
        DataMemory[264] = 5;  // Third element (5)
        DataMemory[268] = 4;  // Fourth element (4)
        DataMemory[272] = 3;  // Fifth element (3)
        DataMemory[276] = 2;  // Sixth element (2)
        DataMemory[280] = 1;  // Seventh element (1)
    end
    
    
    // Modified to display 32-bit values with 32 upper bits as zeros
    assign w0 = {32'b0, DataMemory[259], DataMemory[258], DataMemory[257], DataMemory[256]};
    assign w1 = {32'b0, DataMemory[263], DataMemory[262], DataMemory[261], DataMemory[260]};
    assign w2 = {32'b0, DataMemory[267], DataMemory[266], DataMemory[265], DataMemory[264]};
    assign w3 = {32'b0, DataMemory[271], DataMemory[270], DataMemory[269], DataMemory[268]};
    assign w4 = {32'b0, DataMemory[275], DataMemory[274], DataMemory[273], DataMemory[272]};
    assign w5 = {32'b0, DataMemory[279], DataMemory[278], DataMemory[277], DataMemory[276]};
    assign w6 = {32'b0, DataMemory[283], DataMemory[282], DataMemory[281], DataMemory[280]};
    
    always @ (*)
    begin
        if (MemWrite==1'b1) begin
            // Only write the lower 32 bits (4 bytes)
            DataMemory[Memory_Address+3] <= Write_Data[31:24];
            DataMemory[Memory_Address+2] <= Write_Data[23:16];
            DataMemory[Memory_Address+1] <= Write_Data[15:8];
            DataMemory[Memory_Address] <= Write_Data[7:0];
        end
    end
    
    always @ (*)
    begin
        if (MemRead==1'b1) begin
             // Read 32 bits and zero-extend to 64 bits
             ReadData[7:0] <= DataMemory[Memory_Address+0];
             ReadData[15:8] <= DataMemory[Memory_Address+1];
             ReadData[23:16] <= DataMemory[Memory_Address+2];
             ReadData[31:24] <= DataMemory[Memory_Address+3];
             ReadData[63:32] <= 32'b0; // Zero-extend upper 32 bits
        end
        else begin
            ReadData = 64'bx; // Default value when not reading
        end
    end
    
endmodule