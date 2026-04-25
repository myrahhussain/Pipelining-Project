`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2025 09:57:50 AM
// Design Name: 
// Module Name: RISC_V_Pipelined_flushing
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


module RISC_V_Pipelined_flushing(
    input clk, reset
    );
    
//testing
    // wires same as single cucle
    wire [63:0] PC_in, PC_out, ReadData, ReadData1, ReadData2, WriteData, ImmData, ALU_Result; 
    wire [63:0] shifted_data, Data_Out, Out1, Adder_out;
    wire [31:0] Instruction;
    wire [6:0] opcode, func7; 
    wire [2:0] func3;  
    wire [4:0] RS1, RS2, RD;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Zero, Branch, BranchSelect ; // PCSrc 
    
    // IF_ID wires
    wire [63:0] IF_ID_PC_out;
    wire [31:0] IF_ID_Instruction;
    
    // ID_EX wires
    wire ID_EX_RegWrite, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_Branch, ID_EX_ALUSrc; // 1 bit
    wire [1:0] ID_EX_ALUOp; //2 bits
    wire [63:0] ID_EX_PC_out, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_ImmData; // 64 bits
    wire [3:0] ID_EX_Funct; // 4 bits
    wire [4:0] ID_EX_RS1, ID_EX_RS2, ID_EX_RD ; // 5 bits
    
    // EX_MEM wires
    wire  EX_MEM_RegWrite, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_Branch, EX_MEM_Zero; // 1 bit
    wire [4:0] EX_MEM_RD; // 5 bits
    wire [63:0] EX_MEM_Adder_out, EX_MEM_ALU_Result, EX_MEM_ReadData2; // 64 bits
    
    // MEM_WB wires
    wire MEM_WB_RegWrite, MEM_WB_MemtoReg; // 1 bit
    wire [4:0] MEM_WB_RD; //  5 bits
    wire [63:0] MEM_WB_ReadData, MEM_WB_ALU_Result; // 64 bits
    
    // Checking Data Memory wires
    wire [63:0] w0, w1, w2, w3, w4, w5, w6;
    
    // forwardin_unit wires 
    wire [1:0] ForwardA, ForwardB;
    wire [63:0] ForwardA_out, ForwardB_out;

    //Hazard detection unit wires 
    wire IF_ID_Write, PC_Write, control_mux_selector_bit;
    
    reg flush;
    
    initial 
        flush<=0;
    
    
    
    // IF -----------
    
    Adder FOURADDER(64'd4, PC_out, Out1);
//  mux BRANCH(Out1, EX_MEM_Adder_out, (Branch & BranchSelect), PC_in);   // this seems wrong  
    mux branch_mux(Out1, EX_MEM_Adder_out, flush, PC_in);
    Program_Counter Program_count(clk, reset,PC_Write, PC_in, PC_out);
    Instruction_Memory Instr_mem(PC_out, Instruction); 
    

 //---------------

    IF_ID IF_ID_reg(
    .clk(clk),
    .reset(flush),
    .Instr(Instruction),
    .PC_OUT_IN(PC_out),
    .IF_ID_Write(IF_ID_Write),
    .IF_ID_instruction_out(IF_ID_Instruction),
    .IF_ID_pc_out(IF_ID_PC_out)
    );

    // ID -----------   
    assign Funct = {IF_ID_Instruction[30],IF_ID_Instruction[14:12]};
    instruction_parser Instr_pars(IF_ID_Instruction, opcode, RD, func3, RS1, RS2, func7);

    Hazard_detection_unit HazardD(RS1, RS2, ID_EX_RD, ID_EX_MemRead, IF_ID_Write, PC_Write, control_mux_selector_bit);

    immediate_data_extractor Imm_gen(IF_ID_Instruction, ImmData);
    control_unit conrol_unit(opcode, control_mux_selector_bit, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    registerFile Registers(WriteData, RS1, RS2, MEM_WB_RD, MEM_WB_RegWrite, clk, reset, ReadData1, ReadData2);
    //----------

    ID_EX ID_EX_reg(
    .clk(clk),
    .reset(flush),
    // Control signal inputs
    .RegWrite(RegWrite),
    .MemToReg(MemtoReg),
    .Branch(Branch),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .ALUsrc(ALUSrc),
    .ALUop(ALUOp),
    // Data inputs
    .IF_ID_PC_out(IF_ID_PC_out),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .ImmData(ImmData),
    .Funct(Funct),
    .RS1(RS1),
    .RS2(RS2),
    .RD(RD),
    // Control signal outputs
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_MemToReg(ID_EX_MemtoReg),
    .ID_EX_Branch(ID_EX_Branch),
    .ID_EX_MemWrite(ID_EX_MemWrite),
    .ID_EX_MemRead(ID_EX_MemRead),
    .ID_EX_ALUSrc(ID_EX_ALUSrc),
    .ID_EX_ALUOp(ID_EX_ALUOp),
    // Data outputs
    .ID_EX_PC_out(ID_EX_PC_out),
    .ID_EX_ReadData1(ID_EX_ReadData1),
    .ID_EX_ReadData2(ID_EX_ReadData2),
    .ID_EX_ImmData(ID_EX_ImmData),
    .ID_EX_Funct(ID_EX_Funct),
    .ID_EX_RS1(ID_EX_RS1),
    .ID_EX_RS2(ID_EX_RS2),
    .ID_EX_RD(ID_EX_RD)
    );


                    
    // EXE -----------------
    forwarding_unit f_unit(EX_MEM_RD, MEM_WB_RD, ID_EX_RS1, ID_EX_RS2, EX_MEM_RegWrite, MEM_WB_RegWrite, ForwardA, ForwardB);
    mux_3to1 mux_ForwardA(ID_EX_ReadData1, WriteData, EX_MEM_ALU_Result, ForwardA, ForwardA_out);
    mux_3to1 mux_ForwardB(ID_EX_ReadData2, WriteData, EX_MEM_ALU_Result, ForwardB, ForwardB_out);
    

    assign shifted_data = ID_EX_ImmData << 1;
    Adder BRANCHADDER(ID_EX_PC_out, shifted_data, Adder_out); 
    mux MuxALUSrc(ForwardB_out, ID_EX_ImmData, ID_EX_ALUSrc, Data_Out); 
    ALU_control ALUC(ID_EX_ALUOp, ID_EX_Funct, Operation);
    ALU_64_bit ALU(ForwardA_out, Data_Out, Operation, ALU_Result, Zero);
    Branch_unit Branch_decision(ID_EX_Funct[2:0], ForwardA_out, Data_Out, BranchSelect);
    // ----------------


    EX_MEM EX_MEM_reg(
    .clk(clk), 
    .reset(flush),
    // Control signal inputs
    .ID_EX_RegWrite(ID_EX_RegWrite), 
    .ID_EX_MemRead(ID_EX_MemRead), 
    .ID_EX_MemToReg(ID_EX_MemtoReg), 
    .ID_EX_MemWrite(ID_EX_MemWrite), 
    .ID_EX_Branch(ID_EX_Branch), 
    .Zero(BranchSelect),
    // Data inputs 
    .ID_EX_RD(ID_EX_RD),
    .Adder_out(Adder_out), 
    .ALU_Result(ALU_Result), 
    .ID_EX_ReadData2(ForwardB_out),
    // Control signal outputs
    .EX_MEM_RegWrite(EX_MEM_RegWrite), 
    .EX_MEM_MemRead(EX_MEM_MemRead), 
    .EX_MEM_MemToReg(EX_MEM_MemtoReg), 
    .EX_MEM_MemWrite(EX_MEM_MemWrite), 
    .EX_MEM_Branch(EX_MEM_Branch), 
    .EX_MEM_Zero(EX_MEM_Zero),
    // Data outputs
    .EX_MEM_RD(EX_MEM_RD),
    .EX_MEM_Adder_out(EX_MEM_Adder_out), 
    .EX_MEM_ALU_Result(EX_MEM_ALU_Result), 
    .EX_MEM_ReadData2(EX_MEM_ReadData2)
    );
    
    always @(posedge EX_MEM_Branch or posedge EX_MEM_Zero) begin
    flush <= EX_MEM_Branch & EX_MEM_Zero; end
    
    // MEM ---------
    Data_Memory DM(EX_MEM_ALU_Result, EX_MEM_ReadData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead, ReadData, w0, w1, w2, w3, w4, w5, w6);
    // --------------
    
    MEM_WB MEM_WB_reg(
    .clk(clk),
    .reset(reset),
    // Input control signals
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .EX_MEM_MemToReg(EX_MEM_MemtoReg),
    .EX_MEM_RD(EX_MEM_RD),
    // Input data
    .ReadData(ReadData),
    .EX_MEM_ALU_Result(EX_MEM_ALU_Result),
    // Output control signals
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .MEM_WB_MemToReg(MEM_WB_MemtoReg),
    .MEM_WB_RD(MEM_WB_RD),
    // Output data
    .MEM_WB_ReadData(MEM_WB_ReadData),
    .MEM_WB_ALU_Result(MEM_WB_ALU_Result)
    );


    // WB
    mux WB_mux(MEM_WB_ALU_Result, MEM_WB_ReadData, MEM_WB_MemtoReg, WriteData);


    //updating repo
endmodule
