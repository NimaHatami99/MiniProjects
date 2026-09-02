module adder (
	input clk,
	input in1,
	input in2,
	output reg cout,
	output reg [3:0] out
);

reg cin = 0;
reg [1:0] counter = 2'b00;
always @(posedge clk) begin
//  if(counter == 2'b00)
    //out <= 0;
	{cout, out[counter]} = in1 + in2 + cout;
	cin = cout;
	if(counter == 2'b11) begin
		counter <= 0;
		cout <= 0;
	end
	counter = counter + 1;
end

// assign {cout,out} = in1 + in2 + cin;

endmodule