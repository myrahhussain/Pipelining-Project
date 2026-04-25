`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 10:15:31 PM
// Design Name: 
// Module Name: forwarding_tb
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


module forwarding_tb();
    // Inputs
    reg clk;
    reg reset;
    
    // Instantiate the processor
    RISC_V_Processor_Pipelined uut (
        .clk(clk),
        .reset(reset)
    );
    
//    RISC_V_Pipelined_flushing uut(clk,reset);
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    
    // Test sequence
    initial begin
        // Initialize with reset
        reset = 1;
        #20; // Hold reset for 20ns
        reset = 0;
        
        #100;
        
    end
    
    
    // General processor state
    wire [63:0] pc_out = uut.PC_out;
    wire [31:0] instruction = uut.Instruction;
    
    // Register file values for key registers
    wire [63:0] reg_x1 = uut.Registers.array[1];
    wire [63:0] reg_x2 = uut.Registers.array[2];
    wire [63:0] reg_x3 = uut.Registers.array[3];
    wire [63:0] reg_x4 = uut.Registers.array[4];
    wire [63:0] reg_x5 = uut.Registers.array[5];
    
    // Data memory monitoring
    wire [63:0] mem_w0 = uut.w0;
    wire [63:0] mem_w1 = uut.w1;
    wire [63:0] mem_w2 = uut.w2;
    wire [63:0] mem_w3 = uut.w3;
    wire [63:0] mem_w4 = uut.w4;
    wire [63:0] mem_w5 = uut.w5;
    wire [63:0] mem_w6 = uut.w6;
    
    // Instruction decoding in ID stage
    wire [6:0] opcode = uut.opcode;
    wire [4:0] rs1 = uut.RS1;
    wire [4:0] rs2 = uut.RS2;
    wire [4:0] rd = uut.RD;
    
    //control signals
    wire branch = uut.Branch;
    wire memread = uut.MemRead;
    wire memtoreg = uut.MemtoReg;
    wire [1:0] aluop = uut.ALUOp;
    wire memwrite = uut.MemWrite;
    wire alusrc = uut.ALUSrc;
    wire regwrite = uut.RegWrite;
//    wire branchselect = uut.BranchSelect;
    
    // -------------------- FORWARDING SIGNALS --------------------
    
    // Forwarding control signals
    wire [1:0] forward_a = uut.ForwardA;
    wire [1:0] forward_b = uut.ForwardB;
    
    // Source register values
    wire [63:0] id_ex_rs1_val = uut.ID_EX_ReadData1;
    wire [63:0] id_ex_rs2_val = uut.ID_EX_ReadData2;
    
    // Forwarded values
    wire [63:0] forward_a_out = uut.ForwardA_out;
    wire [63:0] forward_b_out = uut.ForwardB_out;
    
    // Pipeline register values for tracking dependencies
    wire [4:0] id_ex_rs1 = uut.ID_EX_RS1;
    wire [4:0] id_ex_rs2 = uut.ID_EX_RS2;
    wire [4:0] id_ex_rd = uut.ID_EX_RD;
    wire [4:0] ex_mem_rd = uut.EX_MEM_RD;
    wire [4:0] mem_wb_rd = uut.MEM_WB_RD;
    
    // Result values in different stages
    wire [63:0] alu_result = uut.ALU_Result;
    wire [63:0] ex_mem_alu_result = uut.EX_MEM_ALU_Result;
    wire [63:0] mem_wb_alu_result = uut.MEM_WB_ALU_Result;
    wire [63:0] write_data = uut.WriteData;
    
    // -----Hazard detection------
    
    wire hazard_control_mux = uut.control_mux_selector_bit;
    wire PC_Write = uut.PC_Write;
    wire IF_ID_Write = uut.IF_ID_Write;

    // -------data mem
    
    
   
endmodule
