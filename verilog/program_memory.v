`timescale 1ns / 1ps

module program_memory #(parameter n=1, parameter m=1)(clk,address,data_out,enable,clr);
	//parameter n = 4; //Address Size
	//parameter m = 16; //Data Size
	parameter L = (2**n);
	integer i;
	input clk, enable,clr;
	input [n-1:0]address; //nBit Memory Addr. Register
	//input [m-1:0]data_in; //mBit IN Data
	output [m-1:0]data_out; //mBit OUT Data
	reg [m-1:0]pdra [L-1:0]; //L x mBit Program Data Register Array
	
	initial begin
		//$readmemb("program.bin",pdra); //Load program into Program Data Register
	end
	
	always @(posedge clk)
	begin
		//Clear the whole memory
		if (clr == 1) begin
			for(i=0;i<16;i=i+1) begin
				pdra[i] = 0;
			end
		end
		else if (enable == 1) begin
				//Output specified MDR to data out
				//data_out <= pdr[addr];
		end
	end
	
	assign data_out = enable ? pdra[address] : 16'hZZ;
endmodule
