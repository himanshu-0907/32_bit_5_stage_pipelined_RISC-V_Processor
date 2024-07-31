`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2024 21:52:55
// Design Name: 
// Module Name: test_2
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

// Loading a word from Memory Loacation 120, adding 45 to it and storing the result in the Memory Location 121
module test_2;

reg clk1, clk2;
integer k;

pipelined_processor dut2 (.clk1(clk1),.clk2(clk2));

initial begin
clk1 = 0; clk2 = 0;
repeat(50) begin        //Generating two-phase clock
#5 clk1 = 1; #5 clk1 = 0;
#5 clk2 = 1; #5 clk2 = 0;
end
end

initial begin
for(k = 0; k<32; k = k+1)
dut2.reg_bank[k] = k;

dut2.mem[0] = 32'h28010078; //ADDI R1, R0, 120;
dut2.mem[1] = 32'h0c631800; //OR R3,R3,R3;  Dummy Instruction
dut2.mem[2] = 32'h20220000; //LW R2,0(R1);
dut2.mem[3] = 32'h0c631800; //OR R3,R3,R3;  Dummy Instruction
dut2.mem[4] = 32'h2842002d; //ADDI R2, R2, 45;
dut2.mem[5] = 32'h0c631800; //OR R3,R3,R3;  Dummy Instruction
dut2.mem[6] = 32'h24220001; //SW R2, 1(R1);
dut2.mem[7] = 32'hfc000000; //HLT;

dut2.mem[120] = 85;
dut2.HALTED = 0;
dut2.PC = 0;
dut2.TAKEN_BRANCH = 0;

#500
$display("mem[120] : %4d\n mem[121] : %4d",dut2.mem[120], dut2.mem[121]);
end

initial begin
$dumpfile("dut2.vcd"); $dumpvars(0,test_2);
#600 $finish;
end

endmodule
