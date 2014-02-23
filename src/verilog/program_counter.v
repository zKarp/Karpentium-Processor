`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//program_counter.v
//
//A program counter with the control table
//
//		clr		ctrl	function
//		1		d		clears the register to 0
//		0		00		store
//		0		01		increment by 1
//		0		10		load input
//		0		11		**ADD LATER OPTION**
//
////////////////////////////////////
module program_counter(clk,in,out,ctrl,clr);
	input clk,clr;		//clock,clear
	input [1:0] ctrl;	//Control Line
	input [5:0] in;	//Input data
	output reg [5:0]out;	//PC out
	
	initial begin
		out <= 0;
	end
	
	always @(posedge clk)
	begin
		if(clr)
			out <= 0;
		else begin
			case(ctrl)
			0 : out <= out; //Store
			1 : out <= (out + 1); //Increment by one
			2 : out <= in; //Load new count
			default: out <= out;
			endcase
		end
	end
endmodule
