module four_bit_carry_lookahead_adder(X, Y, Ci, S, Co);

	parameter SIZE = 4; // Must be at least 2 if changed

	input [SIZE-1:0] X, Y;
	input Ci;

	output [SIZE-1:0] S;
	output Co;

	genvar i;

	wire [SIZE:0] C;
	wire [SIZE-1:0] P;
	wire [SIZE-1:0] G;

	assign C[0] = Ci;
	assign Co = C[SIZE];

	generate
		for (i=0; i<SIZE; i=i+1) begin
			FA_PG U (X[i], Y[i], C[i], S[i], P[i], G[i]);
		end
	endgenerate

	four_bit_carry_lookahead_logic U4(C[0], P[SIZE-1:0], G[SIZE-1:0], C[SIZE:1]);

endmodule
