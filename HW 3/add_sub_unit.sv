module add_sub_unit(
	input add, sub,
	input [3:0]operandA, 
	input [3:0]operandB,
	
	output [3:0]result
);

wire [3:0]myCalc;
reg [3:0]outputBuffer = 4'b0000;

assign myCalc = (add & ~sub) ? operandA + operandB :
		(~add & sub) ? operandA - operandB :
		4'bZZZZ;

assign result = outputBuffer;

always @ (posedge add, posedge sub) begin
	outputBuffer <= myCalc;
end


endmodule
