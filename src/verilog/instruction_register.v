`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//instruction_register.v
//
//A load/store register for the instuctions with the control table
//		ls		clr		function
//		d		1		clear register
//		0		0		store
//		1		0		load
//
///////////////////////////////////			

module instruction_register(clk,in,out,opcode,ls,enable,clr);
	input clk,clr,ls,enable; //clock,clear,load line,enable line
	input [15:0] in;			//input data
	output [15:0] out;		//output data
	output [3:0] opcode;		//first 4 bits of instruction (OPCODE)
	reg [15:0] instr;			//stored instruction
	
	initial begin instr = 16'dZ; end
	
	always @(posedge(clk))
	begin
		if(clr) begin
			instr = 16'dZ;
		end
		else if (ls) begin
			instr = in;
		end
		else begin
			instr = instr;
		end
	end
	
	assign opcode = instr[15:12];
	assign out = (enable) ? instr : 16'hZZ;
	

	//Clear instruction before load
	//Helps with controller indentifying sucessful instruction
	always @(posedge(ls))
	begin
		instr = 16'dZ;
	end
	
endmodule
