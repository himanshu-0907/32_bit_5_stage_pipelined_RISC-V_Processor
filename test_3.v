`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2024 21:52:55
// Design Name: 
// Module Name: test_3
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

//Program to calculate the factorial of a number N stored in memory location mem[200]
//and storing the result in the memory location mem[198]
module test_3;

reg clk1, clk2;
integer k;

pipelined_processor dut3 (.clk1(clk1),.clk2(clk2));

initial begin
clk1 = 0; clk2 = 0;
repeat(50) begin        //Generating two-phase clock
#5 clk1 = 1; #5 clk1 = 0;
#5 clk2 = 1; #5 clk2 = 0;
end
end

initial begin
for(k = 0; k<32; k = k+1)
dut3.reg_bank[k] = k;

dut3.mem[0] = 32'h280a00c8; //ADDI R10, R0, 200;
dut3.mem[1] = 32'h28020001; //ADDI R2, R0, 1;
dut3.mem[2] = 32'h0e94a000; //OR R20,R20,R20;  Dummy Instruction
dut3.mem[3] = 32'h21430000; //LW R3, 0(R10);
dut3.mem[4] = 32'h0e94a000; //0R R20,R20,R20;  Dummy Instruction
dut3.mem[5] = 32'h2c630001; // Loop: MUL R2, R2, R3;
dut3.mem[6] = 32'h24220001; //SUBI R3, R3, 1;
dut3.mem[7] = 32'h0e94a000; //OR R20,R20,R20;  Dummy Instruction
dut3.mem[8] = 32'h3460fffc; //BNEQZ R3, Loop; ----(i.e. -4 offset)
dut3.mem[9] = 32'h2542fffe; //SW R2, -2(R10);
dut3.mem[10] = 32'hfc000000; //HLT;

dut3.mem[200] = 7;          //to find the factorial of 7

dut3.HALTED = 0;
dut3.PC = 0;
dut3.TAKEN_BRANCH = 0;

#2000
$display("mem[200] : %2d\n mem[198] : %6d",dut3.mem[200], dut3.mem[198]);
end

initial begin
$dumpfile("dut3.vcd"); $dumpvars(0,test_3);
#3000 $finish;
end

endmodule

