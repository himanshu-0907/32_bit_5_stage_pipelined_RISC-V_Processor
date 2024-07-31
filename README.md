# 32_bit_5_stage_pipelined_RISC-V_Processor
Verilog Project
Hello everyone, I am Himanshu Gupta, a Final year student at Motilal Nehru National Institute of Technology. Here I am presenting you my project which is a 32-bit 5-staged pipelined processor based on RISC-V instruction set architecture.

The processor has 5 stages :
1. Instruction Fetch (IF)
2. Instruction Decode / Register Fetch (ID)
3. Execute / Effective Address Calculation Stage(EX)
4. Memory Access / Branch Completion Stage(MEM)
5. Writeback Stage(WB)

Following instructions have been implemented in the project :  
a) ******R-Type******  
1. ADD
2. SUB
3. AND
4. OR
5. SLT
6. MUL
7. HLT

b) ******I-Type******   
8.  LW 
9.  ADDI 
10.  SUBI 
11.  SLTI 
12.  BNEQZ 
13.  BEQZ 


I have checked the working of the processor using three testbenches :
1. test_1 : to add three numbers stored in registers R1, R2, R3 and store the result in the register R5.
2. test_2 : Loading a word from Memory Loacation 120, adding 45 to it and storing the result in the Memory Location 121
3. test_3 : to calculate the factorial of a number N stored in memory location mem[200] and storing the result in the memory location mem[198]


The code for the Processor is written in such a way that more instructions can be easily added in it in future.

Hope you like it !!

For doubts or any advice connect with me on LinkdIn.

"linkedin.com/in/himanshugupta0907"
