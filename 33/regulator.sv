module nazem (
	input r1, r2, r3,
	output reg g1, g2,g3
);
always @(*) begin
	{g1,g2,g3} = 3'b000;
	if(r1 == 1)
		g1 <= 1;
	else if(r2 == 1)
		g2 <= 1;
	else if(r3 == 1)
		g3 <= 1;
end
endmodule
