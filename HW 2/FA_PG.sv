module FA_PG( // Full Adder_Propogate Generate
	input X, Y, C,
	output S, P, G
);

	assign S = C ^ P; // Sum Output
	assign P = X ^ Y; // Carry Propogate (Will pass on a carried over 1 to next place)
	assign G = X & Y; // Carry Generate (Will generate a 1 which will be carried over to next place, regardless of C)

endmodule
