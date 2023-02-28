module booth_multiplier(
	input [3:0]M, // Multiplicand
	input [3:0]Q, // Multiplier
	input clk,

	output [7:0]result,
	output valid
);

wire load, add, sub, shift, dc;

wire [3:0]Areg;
wire [3:0]Qreg;
wire Qsub1, Qzero;
wire [2:0]count;

assign result = {Areg, Qreg};

// Instantiate datapath
datapath U1(
	.clk(clk),
	.M(M), // Multiplicand
	.Q(Q), // Multiplier
	.load(load),
	.add(add),
	.sub(sub),
	.shift(shift),
	.dc(dc),

	.Areg(Areg),
	.Qreg(Qreg),
	.Qsub1(Qsub1),
	.Qzero(Qzero),
	.count(count)
);

// Instantiate controller
controller U2 (
	.clk(clk), 
	.Qzero(Qzero), 
	.Qsub1(Qsub1), 
	.count(count),
 
	.load(load), 
	.add(add), 
	.sub(sub), 
	.shift(shift), 
	.dc(dc), // Control signals
	.valid(valid)
);

endmodule