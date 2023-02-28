`timescale 1ns/1ns
module tb_booth_multiplier();

	//Inputs
	reg [3:0]M = 4'b0000;
	reg [3:0]Q = 4'b0000;
	reg clk = 0;
	
	//Outputs
	reg [7:0] result;
	reg valid;
	
	booth_multiplier UUT(

		.M(M), // Multiplicand
		.Q(Q), // Multiplier
		.clk(clk),

		.result(result),
		.valid(valid)
	);
	
	always begin
		#5
		clk = ~clk;
	end
		

	initial
		begin

			M <= 4'b1011; // -5
			Q <= 4'b1001; // -7
			// Should produce 0010 0011

			#180

			M <= 4'b0001;
			Q <= 4'b0001;
			// Should produce 0000 0001
			
			#110

			$stop;
		end

endmodule
