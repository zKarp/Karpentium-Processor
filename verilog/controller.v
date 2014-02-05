`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
c0:
c1: PC Increment
c2: MAR Load/Store
c3: IR Load/Store
c4: MDR Load/Store

en0:
en1: PC enable (addrBUS <- addr)
en2: MAR enable (addrBUS <- addr)
en3: PM enable (dataBUS <- data)
en4: ALU enable  
en5: IR enable (dataBUS <- instruction)
en6: MDR enable (dataBUS <- data)

s1: ALU Select Line
s2:


*/
//////////////////////////////////////////////////////////////////////////////////
module controller(clk,opcode,c1,c2,c3,c4,en1,en2,en3,en4,en5,en6,s1);
	//Inputs
	input clk;
	input [3:0]opcode;
	
	//Controls
	output c1,c2,c3,c4;
	reg c1,c2,c3,c4;
	
	//Enables
	output en1,en2,en3,en4,en5,en6; //Enables
	reg en1,en2,en3,en4,en5,en6;
	
	//Select Lines
	output [2:0]s1;
	reg [2:0]s1;
	
	//Internals
	reg [5:0]curr_state;
	reg [5:0]next_state;
	
	initial begin
		curr_state = 6'd0;
		next_state = 6'd0;
		
		c1 = 1;
		c2 = 0;
		c3 = 1;
		c4 = 1;
		en1 = 1;
		en2 = 0;
		en3 = 1;
		en4 = 1;
		en5 = 1;
		en6 = 0;
		s1 = 3'b000;
	end
	
	always @(posedge clk) begin
		c1 = ~c1;
		c2 = ~c2;
		en1 = ~en1;
		en2 = ~en2;
		en3 = ~en3;
	end


endmodule
