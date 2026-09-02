
module testbench ();
reg clk = 0;
reg r1, r2, r3;
reg g1, g2,g3;
reg  a1 = 1;
reg a2 = 0;
reg a3 = 1;
reg b = 1;
reg cout;
reg [3:0] out;

initial begin
	#10
	r1 = 1;
	#30
	r1 = 0;
	#50
	r2 = 1;
	r3 = 1;
	#10
	r2 = 0;
	r3 = 0;
	#70
	r2 = 1;
	#10
	r2 = 0;
	#20
	r1 = 1;
	#50
	r1 = 0;
	#80
	r1 = 1;
	r2 = 1;
	#10
	r1 = 0;
	r2 = 0;
	#70
	r1 = 1;
	r3 = 1;
	#10
	r1 = 0;
	r3 = 0;
	#80;
end

initial begin
    repeat(100)#10 clk = ~clk;
end

nazem n(r1, r2, r3, g1, g2, g3);
chooser c(a1, a2, a3, g1, g2, g3, aout);
adder a(clk, aout, b, cout, out);

endmodule

