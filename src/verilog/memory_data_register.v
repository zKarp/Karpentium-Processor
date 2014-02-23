`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//memory_data_register.v
//
//A load/store register that stores memory data with the control table
//
//		enable	ctrl	clr		function
//		1		d		1		Clear register
//		1		00		0		Load from data bus
//		1		01		0		Load from RAM
//		1		10		0 		Output to data bus
//		1		11		0		Output to RAM
//		0		d		d		Store
//
////////////////////////////////////
module memory_data_register (clk,RAMio,dBUSio,ctrl,enable,clr);
	input clk,clr,enable;
	input [1:0] ctrl;
	inout [15:0] dBUSio;
	inout [15:0] RAMio;
	reg [15:0] data;
	
	always @(posedge(clk))
	begin
		if(clr) begin data <= 16'd0; end
		else
			case({enable,ctrl})
			3'b100 : begin
				data <= dBUSio;
				end
			3'b101 : begin
				data <= RAMio;
				end
			default: begin 
				data <= data;
				end
			endcase
	end

	//Output stored data to dataBUS when enabled
	assign dBUSio = (enable && (ctrl==2)) ? data : 16'hZZ;
	assign RAMio = (enable && (ctrl==3)) ? data : 16'hZZ;
	
endmodule
