`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:27 12/15/2013 
// Design Name: 
// Module Name:    Karpentium_Processor_III 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Karpentium_Processor_III(clk,clr,in,out);
	input clk,clr;
	input [15:0]in;
	output [15:0]out;
	
	//Registers
	reg [15:0]rIn;	//Input Register
	reg [15:0]out;	//Output register
	
	//Wire
	wire [2:0]s1;
	wire [3:0]OPCODE;
	
	//BUSes
	wire [5:0]addrBUS;
	wire [15:0]dataBUS;
	
	memory_address_register MAR(clk,addrBUS,en2,c2);
	program_counter PC(clk,addrBUS,c1,clr,en1);
	controller Controller(clk,OPCODE,c1,c2,c3,c4,en1,en2,en3,en4,en5,en6,s1);
	program_memory #(6,16) PM(clk,addrBUS,dataBUS,en3,clr);
	alu_with_acc ALU (clk,dataBUS,dataBUS,s1,en4);
	instruction_register IR (clk,dataBUS,dataBUS,OPCODE,c3,en5,clr);
	memory_data_register MDR (clk,dataBUS,dataBUS,c4,en6,clr);
	random_access_memory #(6,16) RAM(clk,addrBUS,dataBUS,en3,clr);

	always @(posedge clk) begin
		out = dataBUS;
		rIn = in;
	end

endmodule
