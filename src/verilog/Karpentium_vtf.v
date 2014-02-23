`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:04:19 12/8/2013
// Design Name:   Karpentium_Processor_III
// Module Name:   C:/Documents and Settings/Administrator/My Documents/EE480/Karpentium_Processor_III/Karpentium_vtf.v
// Project Name:  Karpentium_Processor_III
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Karpentium_Processor_III
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Karpentium_vtf;

	// Inputs
	reg clk;
	reg clr;
	reg [15:0] in;

	// Outputs
	wire [15:0] out;
	
	// Instantiate the Unit Under Test (UUT)
	Karpentium_Processor_III uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);
	
	//Internal Connections
	wire [15:0]MEM [63:0];
	wire [15:0]PM [63:0];
	wire [15:0] dataBUS;
	wire [15:0]accumulator;
	wire [5:0] PC_IN;
	wire [5:0] MAR_out;
	wire [15:0] MDR;
	wire [5:0] PC, MAR_in, MAR;
	wire [1:0] c0;
	wire [1:0] c4;
	wire [2:0] c_line;
	wire [7:0] en_line;
	wire [4:0] s_line;
	wire [5:0] curr_state,next_state;
	wire [15:0] instr;
	wire [3:0] opcode;

	assign dataBUS = uut.dataBUS;
	assign MAR_out = uut.MAR_out;
	assign PC_IN = uut.PC.in;
	assign opcode = uut.IR.instr[15:12];
	assign instr = uut.IR.instr;
	assign c0 = {uut.c0};
	assign c_line = {uut.c3,uut.c2,uut.c1};
	assign c4 = {uut.c4};
	assign en_line = {uut.en7,uut.en6,uut.en5,uut.en4,uut.en3,uut.en2,uut.en1,uut.en0};
	assign s_line = {uut.s2,uut.s1};
	assign curr_state = uut.Controller.curr_state;
	assign next_state = uut.Controller.next_state;
	assign PC = uut.PC_out;
	assign MDR = uut.MDR.data;
	assign MAR_in = uut.MAR_in;
	assign MAR = uut.MAR.out;
	assign accumulator = uut.ALU.accumulator;
	
	genvar i;
	for(i=0;i<64;i=i+1) begin: Memory
		assign MEM[i] = uut.RAM.MEM[i];
	end
	for(i=0;i<64;i=i+1) begin: PrograMEM
		assign PM[i] = uut.PM.pdra[i];
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 1;
		in = 0;
        
		// Add stimulus here
		#25 clr = 0;
	end
	
	always begin
		#20 clk = ~clk;
	end
      
endmodule

