`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//Karpentium_Processor_III.v
//
//An accummulator based processor
//
////////////////////////////////////

module Karpentium_Processor(clk,clr,in,out,en);
	input clk,clr,en;
	input [15:0]in;
	output [15:0]out;
	
	//Registers
	reg [15:0]rIn;	//Input Register
	reg [15:0]out;	//Output register
	
	//Wire
	wire [2:0]s1;
	wire [3:0]OPCODE;
	wire [5:0]PC_out,MAR_in,MAR_out;
	wire [1:0]c0,c4;
	wire c1,c2,c3; //Control Lines
	wire [15:0]acc,RAMio;
	//BUS
	wire [15:0]dataBUS;
	
	controller Controller(clk,clr,OPCODE,c0,c1,c2,c3,c4,en0,en1,en2,en3,en4,en5,en6,en7,s1,s2);
	program_counter PC(clk,dataBUS[5:0],PC_out,c0,clr);
	program_memory #(6,16) PM(clk,PC_out,dataBUS,en3);
	instruction_register IR (clk,dataBUS,dataBUS,OPCODE,c3,en5,clr);
	memory_address_register MAR(clk,MAR_in,MAR_out,c2);
	memory_data_register MDR (clk,RAMio,dataBUS,c4,en6,clr);
	alu_with_acc ALU (clk,dataBUS,dataBUS,s1,en4);
	random_access_memory #(6,16) RAM(clk,MAR_out,RAMio,en7,clr,c1);
	
	always @(posedge clk) begin
		out = en0 ? dataBUS : 16'hZZ;
		rIn = in;
	end
	
	// MAR input mux handling
	assign MAR_in = (s2) ? dataBUS[5:0] : dataBUS[5:0];
	
endmodule
