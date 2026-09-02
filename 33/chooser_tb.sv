
module chooser_tb ();
reg a1 = 1;
reg a2 = 0;
reg a3 = 1;
reg g1, g2, g3;
reg aout;

initial begin
	#5
	g1 = 1;
	#20
	g1 = 0;
	g2 = 1;
	#20
	g2 = 0;
	g3 = 1;
	#20;
	
end

chooser c(r1, r2, r3, g1, g2, g3, aout);

endmodule



