`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//program_memory.v
//
//A parameterized ROM, preloaded with programs
//	
//	enable		function
//	0			High impedence output to databus
//	1			Feed data from the memory to databus
//
// s_addr: The address size
// s_word: The data word size
//
////////////////////////////////////

module program_memory #(parameter s_addr=1, parameter s_word=1)(clk,address,data_out,enable);
	parameter s_rom = (2**s_addr); //Number of ROMs
	parameter tclk = (5*2*20); //Wait 5 clock cycles
	integer i;
	input clk, enable;
	input [s_addr-1:0]address; //nBit Memory Addr. Register
	output reg [s_rom-1:0]data_out; //mBit OUT Data
	reg ready;
	reg [s_word-1:0]pdra [s_rom-1:0]; //64 x 16Bit Program Data Register Array
	
	initial begin
		//Load desired program into the Program Data Register
		$readmemb("program.mem",pdra);
		//$readmemb("program2.mem",pdra);
		//$readmemb("program3.mem",pdra);
	end
	
	always @(posedge clk)
	begin
		if (enable == 1) begin
			//#(5*tclk);
				data_out = pdra[address];
			ready = 1;
				
		end
		else begin
			ready = 0;
			data_out = 16'hZZ;
		end
	end
	
	//assign data_out = enable ? pdra[address] : 16'hZZ;
endmodule
