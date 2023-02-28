module DrewSolomon_HW1(

	input serIn, // Serial data input
	input clk, // System clock
	input reset, // Reset signal

	output reg [1:0] d, // Current activated port
	output p0, p1, p2, p3, // The ports
	output outValid, // Flag indicating there is data output occuring at a port
	output error // Flag indicating there has been an error in data output
	);

	wire [3:0] bytes; // Amount of bytes to be transferred
	wire [1:0] state; // Current state of the system
	

	controller U1(.serIn(serIn),
						.clk(clk),
						.reset(reset),
						.bytes(bytes),
						
						.state(state),
						.outValid(outValid),
						.error(error)
						);
						
	serialProcessor U2(.serIn(serIn), // This is the entire datapath
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

endmodule