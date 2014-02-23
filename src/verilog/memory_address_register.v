`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//memory_address_register.v
//
//A load/store register for memory address's with the control table
//
//		ls		function
//		0		store
//		1		load
//
////////////////////////////////////
module memory_address_register(clk,in,out,ls);
	input clk,ls;
	input [5:0]in;
	output reg [5:0]out;
	
	initial begin out = 6'bZZZZZZ; end
	
	always @(posedge clk)
	begin
		if(ls) begin
			//Store the address from input mux
			out <= in;
		end
	end
endmodule
