`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:03:22 12/15/2013 
// Design Name: 
// Module Name:    mar 
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
module memory_address_register(clk,addrBUS,en,ls);
	input clk,en,ls;
	inout [5:0]addrBUS;
	reg [5:0]AR;
	
	initial begin AR = 6'd15; end
	
	always @(posedge clk)
	begin
		if(ls) begin
			//Store the address from address bus
			AR = addrBUS;
		end
	end
	
	assign addrBUS = (en) ? AR : 6'bZZZZZZ;

endmodule
