`timescale 1ns / 1ps
////////////////////////////////////
//Zachary Karpinski
//Karpentium Processor
//
//controller.v
//
//Control unit for the Karpentium Processor
/*

///SIGNALS///
c0: PC Control Line
c1: RAM RW control
c2: MAR Load/Store
c3: IR Load/Store
c4: MDR Load/Store

en0:
en1: 
en2:
en3: PM enable (dataBUS <- data)
en4: ALU enable  
en5: IR enable (dataBUS <- instruction)
en6: MDR enable (dataBUS/RAM <- data)
en7: RAM enable (MDR <- data)

s0:
s1: ALU Select Line
s2: MAR Input mux select line

///OPCODES///
0000: HALT
0001: ADD 
0010: SUB 
0011: JMP
0100: LOAD
0101: Fetch/Read

*/
///////////////////////////////////////

module controller(clk,clr,in_op,c0,c1,c2,c3,c4,en0,en1,en2,en3,en4,en5,en6,en7,s1,s2);
	//Inputs
	input clk,clr;
	input [3:0]in_op; //OPCODE from IR
	
	//Controls
	output reg c1,c2,c3;
	output reg [1:0] c0,c4;
	
	//Enables
	output en0,en1,en2,en3,en4,en5,en6,en7;
	reg en0,en1,en2,en3,en4,en5,en6,en7;
	
	//Select Lines
	output reg s2;
	output reg [2:0]s1;
	
	//Internals
	reg [3:0]opcode;
	reg [5:0]curr_state;
	reg [5:0]next_state;

	//Definitions
	`define SIGNALS {c0,c1,c2,c3,c4,en0,en1,en2,en3,en4,en5,en6,en7,s1,s2}
	`define ENABLES {en0,en1,en2,en3,en4,en5,en6,en7}
	
	initial begin
		curr_state = 6'd0;
		next_state = 6'd0;
		opcode = 4'bZZZZ;
		`SIGNALS = 0;
	end
	
	always @(posedge clk) begin
		//Update state to the next state
		curr_state = next_state;
	end
	
	always @(posedge clk) begin
		if(clr) begin
			//Clear Singals, OPCODE and state
			`SIGNALS = 0;
			next_state = 6'b0;
			opcode = 4'bZZZZ;
		end
		else begin
			opcode = in_op;
		//Begin Cycles		
		case(curr_state)
/////////Fetch Cycle////////////////////////////////////////
			6'd0 : begin next_state = 6'd1;
				en3 = 1; c3 = 1;	// IR <- PM[PC]
			end
			6'd1 : begin next_state = 6'd2;
				en3 = 0;
				c0 = 1; //Increment PC
			end
			6'd2 : begin
				c3 = 0;
				c0 = 0; //Stop PC incr
				next_state = 6'd3;
			end
			
/////////Decode Cycle////////////////////////////////////////
			6'd3 : begin
				case(opcode)
					4'b0000 : begin //HALT
					
					end
					4'b0001 : begin //ADD
						next_state = 6'd4;
						en3 = 0; c3 = 0; //Stop IR Load
						en5 = 1; c2 = 1; s2 = 0;//MAR <- IR[5:0];
						s1 = 3'b000; //ALU Addition
					end
					4'b0010 : begin //SUB
						next_state = 6'd4;
						en3 = 0; c3 = 0; //Stop IR Load
						en5 = 1; c2 = 1; s2 = 0;//MAR <- IR[5:0];
						s1 = 3'b001; //ALU Subtract
					end
					4'b0011 : begin //JUMP
						en3 = 0; c3 = 0; //Stop IR Load
						en5 = 1;c0 = 2'b10; //PC <- IR;
						next_state = 6'd7;
					end
					4'b0100 : begin //LOAD
						next_state = 6'd15;
						en5 = 1; c2 = 1; s2 = 0;// MAR <- IR[5:0];
					end
					4'b0101 : begin //Fetch
					
					end
					4'bZZZZ : begin
						//Keep waiting
					end
					default : begin
						//Invalid OPCODE
					end
				endcase
			end
			
/////////Execution Cycle////////////////////////////////////////
	///////ADD/SUB Instruction//////
			6'd4 : begin
				c2 = 0;
				c0 = 2'b00; //Kill incr signal
				en5 = 0; //Disable IR output
				en7 = 1; c4 = 1; en6 = 1; c0 = 0; //MDR <- RAM[MAR_out]
				next_state = 6'd5;
			end
			6'd5 : begin
				en7 = 0; //Disable RAM
				en4 = 1; c4 = 2; //ALU_a <- MDR
				next_state = (next_state) + 1;
			end
			6'd6 : begin
				en4 = 0; //Stop ALU
				next_state = 6'd63;
			end
	 ///////JMP Instruction//////
			6'd7 : begin
				//Operations Finished in Decode cycle
				next_state = 6'd63;
			end
			
	///////LOAD Instruction//////
			6'd15 : begin
				next_state = 6'd16;
				en5 = 0; //Disable IR output
				c2 = 0;
				en3 = 1; // MDR <- PM[PC]
			end
			6'd16 : begin
				//Add Stage RegisterLATER
				en3 = 0; //
				c4 = 0; en6 = 1; //Load into MDR
				next_state = 6'd17;
			end
			6'd17 : begin next_state = 6'd63;
				c0 = 1; //Increment PC
				c4 = 3; en7 = 1; c1 = 1; //RAM WRITE
			end
				
	///////Reset Cycles/////////
			6'd63 : begin next_state = 6'd0;
				`SIGNALS = 0;
			end
			default: begin
				//Invalid state
			end
		endcase
		end
	end
endmodule
