module controller(
	input serIn, // Serial data input
	input clk, // System clock
	input reset, // Reset signal
	input reg [3:0] bytes, // Amount of bytes to be transferred
	
	output reg [1:0] state = 2'b00, // Current state of the system
	output outValid = 0, // Flag indicating there is data output occuring at a port
	output error = 0 // Flag indicating there has been an error in data output
	);
	
	parameter [1:0] s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11; // Shorthand for port numbers
	reg [7:0] cycle = 8'b00000000; // How many cycles have occurred since last reset
	
	
	always @(negedge clk) begin // Controller functions on NEGATIVE EDGE
		if (reset) begin // On reset, reset state, flags, and cycle count
			state <= s0;
			outValid <= 0;
			error <= 0;
			cycle <= 8'b0;
		end
		
		cycle <= cycle + 4'b1; // Incremement cycle count every clock tick
		
		case (state)
			s0: if (serIn == 0) begin
				if(bytes != 4'b0000 && cycle == (bytes * 8)) begin
					error <= 1; // Set error flag if serIn is not 1 when state changes back to 0
				end
				else begin
					state <= s1; // Move to next state once serIn drops to 0
					outValid <= 1; // Next 2 stages involve data output, set flag
					error <= 0; // Erase error flag if it was set previously
					cycle <= 8'b0; // Reset cycle counter
				end
			end
				
			s1: if (cycle == 1) begin // Stage 1 consists of 2 bits of data transfer
				state <= s2; // Move to next state after 2 cycle (2 bits of port data transfer)
				cycle <= 8'b0; // Reset cycle counter
				end
				
			s2: if (cycle == 3) begin // Stage 2 consists of 4 bits of data transfer
				state <= s3; // Move to next state after 4 cycle (4 bits of # of bytes data transfer)
				cycle <= 8'b0; // Reset cycle counter
				end
				
			s3: if (cycle == (bytes * 8) - 1) begin // Stage 2 consists of # of bytes * 8 bits of data transfer
				state <= s0; // Move to next state the cycle after data transfer is done ((# of bytes transferred * 8) + 1)
				outValid <= 0; // State 0 does not involve data transfer
				end
				
		endcase
	end
endmodule