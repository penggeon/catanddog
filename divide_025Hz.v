// -------------时钟分频模块------------------
module divide_025Hz(
	input clk_1kHz,			// 输入时钟
	output reg clk_025Hz		// 输出时钟
);

reg [11:0]cnt;

always @(posedge clk_1kHz)begin
	if(cnt == 12'd4000)
		cnt <= 12'd0;
	else
		cnt <= cnt+1;
	
	if(cnt < 12'd2000)
		clk_025Hz <= 0;
	else
		clk_025Hz <= 1;
end

endmodule
