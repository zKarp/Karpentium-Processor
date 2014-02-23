`timescale 1ns / 1ps

module instruction_register(clk,in,out,opcode,ls,enable,clr);
	input clk,clr,ls,enable;
	input [15:0] in;
	output [15:0] out;
	output [3:0] opcode;
	reg [15:0] instr;
	
	always @(posedge(clk))
	begin
		if(clr) begin instr = 16'd0; end
		else if (ls) instr = in;
	end
	
	assign opcode = instr[15:12];
	assign out = (enable) ? instr : 16'hZZ;
	
endmodule
