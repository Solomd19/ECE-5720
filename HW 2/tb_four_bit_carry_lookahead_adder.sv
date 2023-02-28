`timescale 1ns/1ns

module tb_four_bit_carry_lookahead_adder();

	//Inputs
	logic [3:0] X;
	logic [3:0] Y;
	logic Ci;
	
	//Outputs
	logic [3:0] S;
	logic Co;

	four_bit_carry_lookahead_adder UUT(X, Y, Ci, S, Co);	

	initial
		begin
			X <= 4'b0000;
			Y <= 4'b0000;
			Ci <= 0;
			#10
			X <= 4'b0001;
			Y <= 4'b0001;
			#10
			X <= 4'b0010;
			Y <= 4'b0010;
			#10
			X <= 4'b0100;
			Y <= 4'b0100;
			#10
			X <= 4'b1000;
			Y <= 4'b1000;
			#10
			X <= 4'b1111;
			Y <= 4'b1111;
			Ci <= 1;
			#10
			$stop;
		end
endmodule
