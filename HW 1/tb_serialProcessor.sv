`timescale 1ns/1ns

module tb_serialProcessor();

	parameter [1:0] s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;

	//Inputs
	reg serIn = 1;
	reg clk = 1;
	reg reset = 0;
	reg [1:0] state = s0;
	
	//Outputs
	reg [1:0] d;
	reg p0, p1, p2, p3;
	reg [3:0] bytes;

	serialProcessor U1(.serIn(serIn),
							.clk(clk),
							.reset(reset),
							.state(state),
							
							.d(d),
							.p0(p0),
							.p1(p1),
							.p2(p2),
							.p3(p3),
							.bytes(bytes)
							);
	
	always begin
		#5
		clk = ~clk;
	end
		

	initial
		begin
			serIn = 0; //Switch state to 1
			#5 state = s1;
			
			serIn = 0;
			#10 serIn = 0; //Set port 0, Switch to state 2
			#10 state = s2;
			
			serIn = 0;
			#10 serIn = 0;
			#10 serIn = 0;
			#10 serIn = 1; //Set 1 byte of transmission, switch to state 3
			//bytes = 4'b0001;
			#10 state = s3;
			
			serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0;
			#10 serIn = 1;
			#10 serIn = 0; // Send 10101010
			#10 state = s0;
			
			serIn = 1; // Flip serIn to state 1
			#10
			$stop;
	
		end
endmodule