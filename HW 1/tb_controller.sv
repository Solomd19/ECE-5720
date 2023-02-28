`timescale 1ns/1ns

module tb_controller();

	//Inputs
	reg serIn = 1;
	reg clk = 1;
	reg reset = 0;
	reg [3:0] bytes;
	
	//Outputs
	reg [1:0] state;
	wire outValid;
	wire error;

	controller U1(.serIn(serIn),
						.clk(clk),
						.reset(reset),
						.bytes(bytes),
						
						.state(state),
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
			#5 bytes = 4'b0001;
			
			#5 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			
			#10 serIn = 1; // Flip serIn to state 1
			#10
			$stop;
	
		end
endmodule