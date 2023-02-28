`timescale 1ns/1ns

module tb_HW1();

	//Inputs
	reg serIn = 1;
	reg clk = 1;
	reg reset = 0;
	
	//Outputs
	reg [1:0] d;
	reg p0, p1, p2, p3;
	reg outValid;
	reg error;
	
	DrewSolomon_HW1 UUT(

		.serIn(serIn),
		.clk(clk),
		.reset(reset),

		.d(d),
		.p0(p0),
		.p1(p1),
		.p2(p2),
		.p3(p3),
		.outValid(outValid),
		.error(error)
	);
	
	always begin
		#5
		clk = ~clk;
	end
		

	initial
		begin
			serIn = 0; //Switch state to 1
			
			#5 serIn = 0;
			#10 serIn = 0; //Set port 0, Switch to state 2
			
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 1; //Set 1 byte of transmission, switch to state 3
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			
			#10 serIn = 1; // Flip serIn to state 1 to end transmission
			#10
			/////////////////////////////////////////////////////////////////////////
			#5 serIn = 0; //Switch state to 1
			
			#5 serIn = 1;
			#10 serIn = 1; //Set port 3, Switch to state 2
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0; //Set 8 bytes of transmission, switch to state 3
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 1; // Send 11111111
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 1; // Send 10000001
			
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0; // Send 00011000
			
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0; // Send 00000000
			
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 0; // Send 11001100
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			
			//#10 serIn = 1; // Don't flip serIn back to 1 so error signal shows
			#30
			$stop;
	
		end
endmodule