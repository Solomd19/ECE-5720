`timescale 1ns/1ns

module tb_four_bit_carry_lookahead_logic();

	//Inputs
	logic C0;
	logic [3:0] P;
	logic [3:0] G;
	
	//Outputs
	logic [3:0] Cout;

	four_bit_carry_lookahead_logic UUT(C0, P, G, Cout);	

	initial
		begin
			P <= 4'b0000;
			G <= 4'b0000;
			C0 <= 0;
			#10
			P <= 4'b0001;
			G <= 4'b0000;
			#10
			P <= 4'b0000;
			G <= 4'b0001;
			#10
			P <= 4'b0001;
			G <= 4'b0001;
			#10
			P <= 4'b0000;
			G <= 4'b0000;
			C0 <= 1;
			#10
			P <= 4'b0001;
			G <= 4'b0000;
			#10
			P <= 4'b0000;
			G <= 4'b0001;
			#10
			P <= 4'b0001;
			G <= 4'b0001;
			#10
/////////////////////////////////////////////////////////////
			P <= 4'b0010;
			G <= 4'b0000;
			#10
			P <= 4'b0000;
			G <= 4'b0010;
			#10
			P <= 4'b0010;
			G <= 4'b0010;
			#10
/////////////////////////////////////////////////////////////
			P <= 4'b0100;
			G <= 4'b0000;
			#10
			P <= 4'b0000;
			G <= 4'b0100;
			#10
			P <= 4'b0100;
			G <= 4'b0100;
			#10
/////////////////////////////////////////////////////////////
			P <= 4'b1000;
			G <= 4'b0000;
			#10
			P <= 4'b0000;
			G <= 4'b1000;
			#10
			P <= 4'b1000;
			G <= 4'b1000;
			#10
			$stop;
		end
endmodule
