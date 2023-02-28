module datapath(
	input clk,
	input [3:0]M, // Multiplicand
	input [3:0]Q, // Multiplier
	input load, add, sub, shift, dc,

	output reg [3:0]Areg = 4'b0000,
	output reg [3:0]Qreg = 4'b0000, // DOUBLE CHECK IF THIS IS SUPPOSED TO HAPPEN
	output Qzero,
	output Qsub1,
	output [2:0]count
);

reg [3:0]Mreg = 4'b0000;
reg Qsub1reg = 0; // Set initially to 0

wire [3:0]A;

assign Qzero = Qreg[0];
assign Qsub1 = Qsub1reg;

// Handle registers
always @ (negedge clk) begin
	if(load) begin
		if (count == 4) begin
			Areg <= 4'b0000; // A resets on initial load of operation
			Mreg <= M;
			Qreg <= Q;
			Qsub1reg <= 0;
		end
		else begin
			Areg <= A;
		end
	end
	else if (shift) begin
		Qsub1reg <= Qreg[0];
		Qreg <= {Areg[0], Qreg[3:1]};
		Areg <= {Areg[3], Areg[3:1]};
	end
	
end

//always @ (posedge clk & shift) begin // Under this condition, shift all the registers in the block to the right by 1 bit

//end

// Instantiate add_sub_unit
add_sub_unit U1(
	.add(add), 
	.sub(sub),
	.operandA(Areg),
	.operandB(Mreg),
	.result(A)
);

// Instantiate down_counter
down_counter U2(
	.clk(clk),
	.dc(dc),
	.count(count)
);



endmodule
