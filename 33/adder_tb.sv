
module adder_tb ();
reg clk = 0;
reg in1 = 0;
reg in2 = 0;
reg cin = 0;
reg cout;
reg [3:0] out;

initial begin
	#10
	in1 = 1;
	#80
	in2 = 1;
	#80;
end

initial begin
  //func = 3'b001;
    repeat(100)#10 clk = ~clk;
end

//function_generator f (clk, rst, func, out);
adder a(clk, in1, in2, cout, out);

endmodule



