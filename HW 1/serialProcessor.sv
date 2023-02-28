module serialProcessor(

	input serIn, // Serial data input
	input clk, // System clock
	input reset, // Reset signal
	input reg [1:0] state, // Current state of the system

	output reg [1:0] d, // Current activated port
	output p0, p1, p2, p3, // The ports
	output reg [3:0] bytes // Amount of bytes to be transferred
	);

	always @(posedge clk) begin // Serial Processor functions on POSITIVE EDGE
		if (reset) begin //When reset is activated, clear all ports and memory
			d <= 2'b00;
			p0 <= 0;
			p1 <= 0;
			p2 <= 0;
			p3 <= 0;
			bytes = 4'b0000;
		end

		case (state)
			2'b00: d <= 2'b00; // State 0: reset port memory
			2'b01: d <= (d << 1) + serIn; // State 1: receive port data
			2'b10: bytes <= (bytes << 1) + serIn; // State 2: receive byte count data
			2'b11: case (d) // State 3: redirect serIn to port in memory
				2'b00: p0 <= serIn;
				2'b01: p1 <= serIn;
				2'b10: p2 <= serIn;		
				2'b11: p3 <= serIn;
				endcase	
		endcase

	end
endmodule