`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//program_memory.v
//
//A parameterized ROM, preloaded with programs
//
//		rw		enable		function
//		d		0			nothing			
//		0		1			MDR <- Memory
//		1		1			Memory <- MDR
//
// s_addr: The address size
// s_word: The data word size
//
////////////////////////////////////

module random_access_memory#(parameter n=1, parameter m=1)(clk,address,MDR_line,enable,clr,rw);
	parameter L = (2**n);
	integer i;
	input clk, enable,clr,rw;
	input [n-1:0]address; //nBit Memory Addr. Register
	inout [m-1:0]MDR_line; //mBit In/Out line with MDR
	reg [m-1:0]MEM [L-1:0]; //L x mBit Data Register Array
	
	initial begin
		//$readmemb("program.bin",pdra); //Load program into Program Data Register
	end
	
	always @(posedge clk)
	begin
		if (clr == 1) begin
			//Clear the whole memory
			for(i=0;i<L;i=i+1) begin
				MEM[i] <= 0;
			end
		end
		else if(enable && rw) begin
			//Write from MDR to memory
			MEM[address] <= MDR_line;
		end
		else if(enable && ~rw) begin
			//Feed memory to MDR
		end
		else begin
			//Do what
		end		
	end
	
	//Output contents of MEM[address] to MDR
	assign MDR_line = (enable && ~rw) ? MEM[address] : 16'hZZ;
endmodule
