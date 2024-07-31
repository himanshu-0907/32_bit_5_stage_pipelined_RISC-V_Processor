`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2024 21:52:55
// Design Name: 
// Module Name: test_1
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


//Program to add three numbers stored in registers R1, R2, R3 and store the result in the register R5
module test_1;

reg clk1, clk2;
integer k;

pipelined_processor dut1 (.clk1(clk1),.clk2(clk2));

initial begin
clk1 = 0; clk2 = 0;
repeat(20) begin        //Generating two-phase clock
#5 clk1 = 1; #5 clk1 = 0;
#5 clk2 = 1; #5 clk2 = 0;
end
end

initial begin
for(k = 0; k<32; k = k+1)
dut1.reg_bank[k] = k;

dut1.mem[0] = 32'h2801000a; //ADDI R1, R0, 10;
dut1.mem[1] = 32'h28020014; //ADDI R2, R0, 20;
dut1.mem[2] = 32'h28030019; //ADDI R3, R0, 25;
dut1.mem[3] = 32'h0ce77800; //OR R7, R7, R7;    Dummy Instruction
dut1.mem[4] = 32'h0ce77800; //OR R7, R7, R7;    Dummy Instruction
dut1.mem[5] = 32'h00222000; //ADD R4, R1, R2;
dut1.mem[6] = 32'h0ce77800; //OR R7, R7, R7;    Dummy Instruction
dut1.mem[7] = 32'h00832800; //ADD R5, R4, R3;
dut1.mem[8] = 32'hfc000000; //HLT

dut1.HALTED = 0;
dut1.PC = 0;
dut1.TAKEN_BRANCH = 0;

#280
for(k = 0; k < 6; k = k+1)
$display("R%1d = %2d",k,dut1.reg_bank[k]);
end

initial begin
$dumpfile("dut1.vcd"); $dumpvars(0,test_1);
#300 $finish;
end

endmodule
