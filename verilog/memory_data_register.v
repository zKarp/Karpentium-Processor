`timescale 1ns / 1ps

module memory_data_register (clk,in,out,ls,enable,clr);
	input clk,clr,ls,enable;
	input [15:0] in;
	output [15:0] out;
	reg [15:0] data;
	
	always @(posedge(clk))
	begin
		if(clr) begin data = 16'd0; end
		else if (ls) data = in;
	end

	assign out = (enable) ? data : 16'hZZ;
	
endmodule
