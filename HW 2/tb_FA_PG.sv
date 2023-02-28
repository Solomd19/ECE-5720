`timescale 1ns/1ns

module tb_FA_PG();

	//Inputs
	logic X, Y, C;
	
	//Outputs
	logic S, P, G;

	FA_PG UUT(X, Y, C, S, P, G);	

	initial
		begin
			X <= 0;
			Y <= 0;
			C <= 0;
			#10
			X <= 1;
			Y <= 0;
			C <= 0;
			#10
			X <= 0;
			Y <= 1;
			C <= 0;
			#10
			X <= 1;
			Y <= 1;
			C <= 0;
			#10
			X <= 0;
			Y <= 0;
			C <= 1;
			#10
			X <= 1;
			Y <= 0;
			C <= 1;
			#10
			X <= 0;
			Y <= 1;
			C <= 1;
			#10
			X <= 1;
			Y <= 1;
			C <= 1;
			#10
			$stop;
		end
endmodule
