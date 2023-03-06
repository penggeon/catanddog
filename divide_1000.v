// -------------时钟分频模块------------------
module divide_1000(
	input clk_1kHz,			// 输入时钟
	output reg clk_1Hz		// 输出时钟
);

reg [19:0]cnt;

always @(posedge clk_1kHz)begin
	if(cnt==20'd999)
		cnt<=20'd0;
	else
		cnt<=cnt+1;
	
	if(cnt<20'd500)
		clk_1Hz<=0;
	else
		clk_1Hz<=1;
end

endmodule
