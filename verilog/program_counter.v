`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:00 12/15/2013 
// Design Name: 
// Module Name:    program_counter 
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
module program_counter(clk,out,incr,clr,enable);
	input clk,incr,clr,enable;
	output [5:0]out;
	reg [5:0]count;
	
	initial begin
		count = 0;
	end
	
	always @(posedge clk)
	begin
		if(clr) count = 0;
		else if(incr) begin
			count = (count + 1'b1);
		end
		else begin
			//Do Nothing
		end
	end
	
	assign out[5:0] = (enable) ? count[5:0] : 6'bZZZZZZ;

endmodule
