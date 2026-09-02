module chooser (
	input a1, a2, a3, g1, g2, g3,
	output reg aout
);
always @(*) begin
	if(g1 == 1)
		aout <= a1;
	else if(g2 == 1)
		aout <= a2;
	else if(g3 == 1)
		aout <= a3;
end
endmodule
