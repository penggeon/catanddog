// -------------时钟分频模块------------------
module divide_4Hz(
	input clk_1kHz,			// 输入时钟
	output reg clk_4Hz		// 输出时钟
);

reg [7:0]cnt;

always @(posedge clk_1kHz)begin
	if(cnt == 8'd250)
		cnt <= 8'd0;
	else
		cnt <= cnt+1;
	
	if(cnt < 8'd125)
		clk_4Hz <= 0;
	else
		clk_4Hz <= 1;
end

endmodule
