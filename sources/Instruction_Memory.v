`timescale 1ns / 1ps
module Instruction_Memory(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction
    );
    
    reg [7:0] InstructionMemory [256:0];
    

       initial begin
       
       // prev working bubble sort code -----------
            // {InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h10000293; //1
            // {InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00700313; //2
            // {InstructionMemory[11], InstructionMemory[10], InstructionMemory[9], InstructionMemory[8]} = 32'h00000413; //3
            // {InstructionMemory[15], InstructionMemory[14], InstructionMemory[13], InstructionMemory[12]} = 32'h04640a63; //4
            // {InstructionMemory[19], InstructionMemory[18], InstructionMemory[17], InstructionMemory[16]} = 32'h10000293; //5
            // {InstructionMemory[23], InstructionMemory[22], InstructionMemory[21], InstructionMemory[20]} = 32'hfff30493; //6
            // {InstructionMemory[27], InstructionMemory[26], InstructionMemory[25], InstructionMemory[24]} = 32'h408484b3; //7
            // {InstructionMemory[31], InstructionMemory[30], InstructionMemory[29], InstructionMemory[28]} = 32'h00000513; //8
            // {InstructionMemory[35], InstructionMemory[34], InstructionMemory[33], InstructionMemory[32]} = 32'h02950c63; //9
            // {InstructionMemory[39], InstructionMemory[38], InstructionMemory[37], InstructionMemory[36]} = 32'h00251593; //10
            // {InstructionMemory[43], InstructionMemory[42], InstructionMemory[41], InstructionMemory[40]} = 32'h00b285b3; //11
            // {InstructionMemory[47], InstructionMemory[46], InstructionMemory[45], InstructionMemory[44]} = 32'h00150613; //12
            // {InstructionMemory[51], InstructionMemory[50], InstructionMemory[49], InstructionMemory[48]} = 32'h00261613; //13
            // {InstructionMemory[55], InstructionMemory[54], InstructionMemory[53], InstructionMemory[52]} = 32'h00c28633; //14
            // {InstructionMemory[59], InstructionMemory[58], InstructionMemory[57], InstructionMemory[56]} = 32'h0005a683; //15
            // {InstructionMemory[63], InstructionMemory[62], InstructionMemory[61], InstructionMemory[60]} = 32'h00062703; //16
            // {InstructionMemory[67], InstructionMemory[66], InstructionMemory[65], InstructionMemory[64]} = 32'h00d74463; //17
            // {InstructionMemory[71], InstructionMemory[70], InstructionMemory[69], InstructionMemory[68]} = 32'h00000663; //18
            // {InstructionMemory[75], InstructionMemory[74], InstructionMemory[73], InstructionMemory[72]} = 32'h00e5a023; //19
            // {InstructionMemory[79], InstructionMemory[78], InstructionMemory[77], InstructionMemory[76]} = 32'h00d62023; //20
            // {InstructionMemory[83], InstructionMemory[82], InstructionMemory[81], InstructionMemory[80]} = 32'h00150513; //21
            // {InstructionMemory[87], InstructionMemory[86], InstructionMemory[85], InstructionMemory[84]} = 32'hfc0006e3; //22
            // {InstructionMemory[91], InstructionMemory[90], InstructionMemory[89], InstructionMemory[88]} = 32'h00140413; //23
            // {InstructionMemory[95], InstructionMemory[94], InstructionMemory[93], InstructionMemory[92]} = 32'hfa0008e3; //24
            // {InstructionMemory[99], InstructionMemory[98], InstructionMemory[97], InstructionMemory[96]} = 32'h00000013; //25
        //---------------------------------------------
        
        
        
        // Bubble sort with nops (to make it work without flushing)
            {InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h10000293; //1
            {InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00700313; //2    
            {InstructionMemory[11], InstructionMemory[10], InstructionMemory[9], InstructionMemory[8]} = 32'h00000413; //3  
            {InstructionMemory[15], InstructionMemory[14], InstructionMemory[13], InstructionMemory[12]} = 32'h08640e63; //4
            {InstructionMemory[19], InstructionMemory[18], InstructionMemory[17], InstructionMemory[16]} = 32'h00000013; //5
            {InstructionMemory[23], InstructionMemory[22], InstructionMemory[21], InstructionMemory[20]} = 32'h00000013; //6
            {InstructionMemory[27], InstructionMemory[26], InstructionMemory[25], InstructionMemory[24]} = 32'h00000013; //7      
            {InstructionMemory[31], InstructionMemory[30], InstructionMemory[29], InstructionMemory[28]} = 32'h10000293; //8      
            {InstructionMemory[35], InstructionMemory[34], InstructionMemory[33], InstructionMemory[32]} = 32'hfff30493; //9      
            {InstructionMemory[39], InstructionMemory[38], InstructionMemory[37], InstructionMemory[36]} = 32'h408484b3; //10     
            {InstructionMemory[43], InstructionMemory[42], InstructionMemory[41], InstructionMemory[40]} = 32'h00000513; //11     
            {InstructionMemory[47], InstructionMemory[46], InstructionMemory[45], InstructionMemory[44]} = 32'h06950463; //12     
            {InstructionMemory[51], InstructionMemory[50], InstructionMemory[49], InstructionMemory[48]} = 32'h00000013; //13     
            {InstructionMemory[55], InstructionMemory[54], InstructionMemory[53], InstructionMemory[52]} = 32'h00000013; //14     
            {InstructionMemory[59], InstructionMemory[58], InstructionMemory[57], InstructionMemory[56]} = 32'h00000013; //15     
            {InstructionMemory[63], InstructionMemory[62], InstructionMemory[61], InstructionMemory[60]} = 32'h00251593; //16     
            {InstructionMemory[67], InstructionMemory[66], InstructionMemory[65], InstructionMemory[64]} = 32'h00b285b3; //17     
            {InstructionMemory[71], InstructionMemory[70], InstructionMemory[69], InstructionMemory[68]} = 32'h00150613; //18     
            {InstructionMemory[75], InstructionMemory[74], InstructionMemory[73], InstructionMemory[72]} = 32'h00261613; //19     
            {InstructionMemory[79], InstructionMemory[78], InstructionMemory[77], InstructionMemory[76]} = 32'h00c28633; //20     
            {InstructionMemory[83], InstructionMemory[82], InstructionMemory[81], InstructionMemory[80]} = 32'h0005a683; //21     
            {InstructionMemory[87], InstructionMemory[86], InstructionMemory[85], InstructionMemory[84]} = 32'h00062703; //22     
            {InstructionMemory[91], InstructionMemory[90], InstructionMemory[89], InstructionMemory[88]} = 32'h02d74063; //23     
            {InstructionMemory[95], InstructionMemory[94], InstructionMemory[93], InstructionMemory[92]} = 32'h00000013; //24
            {InstructionMemory[99], InstructionMemory[98], InstructionMemory[97], InstructionMemory[96]} = 32'h00000013; //25     
            {InstructionMemory[103], InstructionMemory[102], InstructionMemory[101], InstructionMemory[100]} = 32'h00000013; //26
            {InstructionMemory[107], InstructionMemory[106], InstructionMemory[105], InstructionMemory[104]} = 32'h00000c63; //27 
            {InstructionMemory[111], InstructionMemory[110], InstructionMemory[109], InstructionMemory[108]} = 32'h00000013; //28 
            {InstructionMemory[115], InstructionMemory[114], InstructionMemory[113], InstructionMemory[112]} = 32'h00000013; //29 
            {InstructionMemory[119], InstructionMemory[118], InstructionMemory[117], InstructionMemory[116]} = 32'h00000013; //30 
            {InstructionMemory[123], InstructionMemory[122], InstructionMemory[121], InstructionMemory[120]} = 32'h00e5a023; //31 
            {InstructionMemory[127], InstructionMemory[126], InstructionMemory[125], InstructionMemory[124]} = 32'h00d62023; //32 
            {InstructionMemory[131], InstructionMemory[130], InstructionMemory[129], InstructionMemory[128]} = 32'h00150513; //33 
            {InstructionMemory[135], InstructionMemory[134], InstructionMemory[133], InstructionMemory[132]} = 32'hfa0004e3; //34 
            {InstructionMemory[139], InstructionMemory[138], InstructionMemory[137], InstructionMemory[136]} = 32'h00000013; //35 
            {InstructionMemory[143], InstructionMemory[142], InstructionMemory[141], InstructionMemory[140]} = 32'h00000013; //36 
            {InstructionMemory[147], InstructionMemory[146], InstructionMemory[145], InstructionMemory[144]} = 32'h00000013; //37 
            {InstructionMemory[151], InstructionMemory[150], InstructionMemory[149], InstructionMemory[148]} = 32'h00140413; //38 
            {InstructionMemory[155], InstructionMemory[154], InstructionMemory[153], InstructionMemory[152]} = 32'hf6000ae3; //39
            {InstructionMemory[159], InstructionMemory[158], InstructionMemory[157], InstructionMemory[156]} = 32'h00000013; //40 
            {InstructionMemory[163], InstructionMemory[162], InstructionMemory[161], InstructionMemory[160]} = 32'h00000013; //41 
            {InstructionMemory[167], InstructionMemory[166], InstructionMemory[165], InstructionMemory[164]} = 32'h00000013; //42 
            {InstructionMemory[171], InstructionMemory[170], InstructionMemory[169], InstructionMemory[168]} = 32'h00000013; //43
        
        
        // Forwarding test cases 
        
//        add x1, x2, x3
//        add x4, x1, x2
//        {InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h003100b3; //1
//        {InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00208233; //2
        
//        
//        add x2 x3 x4 
//        add x1 x3 x2    
//        {InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h00418133; //1
//        {InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h002180b3; //2
// 


//        add x3 x1 x2
//        add x4 x1 x2
//        add x2 x3 x2
//{InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h002081b3; //1
//{InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00208233; //2
//{InstructionMemory[11], InstructionMemory[10], InstructionMemory[9], InstructionMemory[8]} = 32'h00218133; //3  



//      add x1 x3 x4
//      add x2 x1 x4
//      add x3 x1 x2
//{InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h004180b3; //1
//{InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00408133; //2
//{InstructionMemory[11], InstructionMemory[10], InstructionMemory[9], InstructionMemory[8]} = 32'h002081b3; //3 
        
        // load use hazard 
        //lw x1 256(X0)  
        //add x2 x1 x3
//        {InstructionMemory[3], InstructionMemory[2], InstructionMemory[1], InstructionMemory[0]} = 32'h10002083;
//        {InstructionMemory[7], InstructionMemory[6], InstructionMemory[5], InstructionMemory[4]} = 32'h00308133;

        
    end
       
       
       always @(Inst_Address) begin
            Instruction[31:24] <= InstructionMemory[Inst_Address + 3];
            Instruction[23:16] <= InstructionMemory[Inst_Address + 2];
            Instruction[15:8] <= InstructionMemory[Inst_Address + 1];
            Instruction[7:0] <= InstructionMemory[Inst_Address];
       end
    
endmodule
