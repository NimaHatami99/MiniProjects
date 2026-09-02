
module nazem_tb ();
reg r1, r2, r3;
reg g1, g2, g3;

initial begin
	#5
	r1 = 1;
	#20
	r2 = 1;
	#20
	r1 = 0;
	r2 = 0;
	r3 = 1;
	#20
	r1 =1;
	r2 = 1;
	r3 = 1;
	#20;
	
end

nazem n(r1, r2, r3, g1, g2, g3);

endmodule


