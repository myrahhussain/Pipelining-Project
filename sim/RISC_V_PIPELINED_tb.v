`timescale 1ns / 1ps

module RISC_V_PIPELINED_tb();
    // Inputs
    reg clk;
    reg reset;
    
    // Instantiate the processor
    RISC_V_Processor_Pipelined uut (
        .clk(clk),
        .reset(reset)
    );
    
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
    
    // Monitor all wires within the processor (these will be available in waveform)
    // IF stage wires
    wire [63:0] pc_in = uut.PC_in;
    wire [63:0] pc_out = uut.PC_out;
    wire [63:0] out1 = uut.Out1;
    wire [31:0] instruction = uut.Instruction;
    
    // IF/ID Pipeline Register outputs
    wire [63:0] if_id_pc_out = uut.IF_ID_PC_out;
    wire [31:0] if_id_instruction = uut.IF_ID_Instruction;
    
    // ID stage wires
    wire [6:0] opcode = uut.opcode;
    wire [4:0] rd = uut.RD;
    wire [2:0] func3 = uut.func3;
    wire [4:0] rs1 = uut.RS1;
    wire [4:0] rs2 = uut.RS2;
    wire [6:0] func7 = uut.func7;
    wire [63:0] immdata = uut.ImmData;
    wire [63:0] readdata1 = uut.ReadData1;
    wire [63:0] readdata2 = uut.ReadData2;
    
    // Control signals
    wire branch = uut.Branch;
    wire memread = uut.MemRead;
    wire memtoreg = uut.MemtoReg;
    wire [1:0] aluop = uut.ALUOp;
    wire memwrite = uut.MemWrite;
    wire alusrc = uut.ALUSrc;
    wire regwrite = uut.RegWrite;
    wire branch_mux = uut.Branch_mux;
    wire Final_zero=uut.Final_Zero;
    
    // ID/EX Pipeline Register outputs
    wire id_ex_regwrite = uut.ID_EX_RegWrite;
    wire id_ex_memtoreg = uut.ID_EX_MemtoReg;
    wire id_ex_branch = uut.ID_EX_Branch;
    wire id_ex_memwrite = uut.ID_EX_MemWrite;
    wire id_ex_memread = uut.ID_EX_MemRead;
    wire id_ex_alusrc = uut.ID_EX_ALUSrc;
    wire [1:0] id_ex_aluop = uut.ID_EX_ALUOp;
    wire [63:0] id_ex_pc_out = uut.ID_EX_PC_out;
    wire [63:0] id_ex_readdata1 = uut.ID_EX_ReadData1;
    wire [63:0] id_ex_readdata2 = uut.ID_EX_ReadData2;
    wire [63:0] id_ex_immdata = uut.ID_EX_ImmData;
    wire [3:0] id_ex_funct = uut.ID_EX_Funct;
    wire [4:0] id_ex_rd = uut.ID_EX_RD;
    
    // EXE stage wires
    wire [63:0] shifted_data = uut.shifted_data;
    wire [63:0] adder_out = uut.Adder_out;
    wire [63:0] data_out = uut.Data_Out;
    wire [3:0] operation = uut.Operation;
    wire [63:0] alu_result = uut.ALU_Result;
    wire zero = uut.Zero;
    
    // EX/MEM Pipeline Register outputs
    wire ex_mem_regwrite = uut.EX_MEM_RegWrite;
    wire ex_mem_memtoreg = uut.EX_MEM_MemtoReg;
    wire ex_mem_branch = uut.EX_MEM_Branch;
    wire ex_mem_memwrite = uut.EX_MEM_MemWrite;
    wire ex_mem_memread = uut.EX_MEM_MemRead;
    wire ex_mem_zero = uut.EX_MEM_Zero;
    wire [4:0] ex_mem_rd = uut.EX_MEM_RD;
    wire [63:0] ex_mem_adder_out = uut.EX_MEM_Adder_out;
    wire [63:0] ex_mem_alu_result = uut.EX_MEM_ALU_Result;
    wire [63:0] ex_mem_readdata2 = uut.EX_MEM_ReadData2;
    
    // MEM stage wires
    wire [63:0] readdata = uut.ReadData;
    wire branch_taken = (uut.EX_MEM_Branch & uut.EX_MEM_Zero);
    
    // MEM/WB Pipeline Register outputs
    wire mem_wb_regwrite = uut.MEM_WB_RegWrite;
    wire mem_wb_memtoreg = uut.MEM_WB_MemtoReg;
    wire [4:0] mem_wb_rd = uut.MEM_WB_RD;
    wire [63:0] mem_wb_readdata = uut.MEM_WB_ReadData;
    wire [63:0] mem_wb_alu_result = uut.MEM_WB_ALU_Result;
    
    // WB stage wires
    wire [63:0] writedata = uut.WriteData;
    
    // Data memory monitoring
    wire [63:0] mem_w0 = uut.w0;
    wire [63:0] mem_w1 = uut.w1;
    wire [63:0] mem_w2 = uut.w2;
    wire [63:0] mem_w3 = uut.w3;
    wire [63:0] mem_w4 = uut.w4;
    wire [63:0] mem_w5 = uut.w5;
    wire [63:0] mem_w6 = uut.w6;
    
    // Register file monitoring (key registers for our test program)
    wire [63:0] reg_x0 = uut.Registers.array[0];
    wire [63:0] reg_x1 = uut.Registers.array[1];
    wire [63:0] reg_x2 = uut.Registers.array[2];
    wire [63:0] reg_x3 = uut.Registers.array[3];
    wire [63:0] reg_x4 = uut.Registers.array[4];
    wire [63:0] reg_x5 = uut.Registers.array[5];
    wire [63:0] reg_x6 = uut.Registers.array[6];
    wire [63:0] reg_x7 = uut.Registers.array[7];
    wire [63:0] reg_x8 = uut.Registers.array[8];
    wire [63:0] reg_x9 = uut.Registers.array[9];
    wire [63:0] reg_x10 = uut.Registers.array[10];
    wire [63:0] reg_x13 = uut.Registers.array[13];
    wire [63:0] reg_x14 = uut.Registers.array[14];
    wire [63:0] reg_x15 = uut.Registers.array[15];
    wire [63:0] reg_x22 = uut.Registers.array[22];
    wire [63:0] reg_x30 = uut.Registers.array[30];
    wire [63:0] reg_x31 = uut.Registers.array[31];
    
   
endmodule