module controller(
	input clk, Qzero, Qsub1,
	input [2:0]count,

	output reg load = 0, // Control signals
	output add,
	output sub,
	output reg shift = 0,
	output reg  dc = 0,
	output reg valid = 0
);

parameter [1:0] s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11; // Shorthand for port numbers

reg [1:0]nextState = s0;
reg [1:0]currentState = 2'bZZ;

assign sub = (Qzero == 1 & Qsub1 == 0) ? 1 : 0;
assign add = (Qzero == 0 & Qsub1 == 1) ? 1 : 0;

always @ (posedge clk) begin
	currentState <= nextState;
	case (nextState)
		s0: begin // Load in operands (also count resets)
			load <= 1;
			//shift <= 0;
			dc <= 1;

			if(shift)begin
				valid <= 1;
				shift <= 0;
			end

			//valid <= 0;

			//@(negedge clk);
			//load <= 0;

			nextState <= s1; // Do we need a buffer for next state?
		end

		s1: begin // Add or subtract if needed
			load <= 0;
			shift <= 0;
			dc <= 0;
			valid <= 0;
		
			if((add & ~sub) | (~add & sub)) begin
				load <= 1;
			end
			
			nextState <= s2;
		end

		s2: begin // Arithmetic shift right
			load <= 0;
			shift <= 1;
			dc <= 1;

			if(count <= 0) begin
				nextState <= s0;
				//valid <= 1;
				//load <= 1; //
			end
			else begin
				nextState <= s1;
				//shift <= 1; //
			end

			//@(negedge clk);
			//shift <= 0;
		end
	endcase
end

endmodule
