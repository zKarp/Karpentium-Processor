`timescale 1ns / 1ps

module alu_with_acc(clk,in,out,select,enable);
	parameter n = 16; //Bits for Input and Output
	parameter m = 3; //Bits for Select Line
	
	input clk, enable;
	input [n-1:0] in;
	input [m-1:0] select;
	output [n-1:0] out;
	reg [n-1:0] accumulator;
	
	always @(posedge(clk))
	begin
		if (enable == 1) begin
			case (select)
			3'b000 : accumulator <= accumulator + in; //ADD
			3'b001 : accumulator <= accumulator - ~in + 1; //Subtract
			3'b010 : accumulator <= accumulator + 1'b1; //Increment by 1
			3'b011 : accumulator <= accumulator - 1'b1; //De-increment by 1
			//3'b100 : //Shift Left
			//3'b101 : //Shift Right
			//3'b110 :
			//3'b111 :
			endcase
		end
		//else ALU_out <=9'bZ;
	end
	
	assign out = select[2] ? accumulator : 16'hZZ;
	
endmodule
