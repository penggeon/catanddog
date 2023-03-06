// -----------防抖模块--------------------
module debounce(
	input clk_1kHz,			// 时钟信号
	input key,				// 输入
	output reg key_out		// 防抖后输出
);

reg [3:0]cnt;				// 计数器

always @(posedge clk_1kHz)begin

	if(!key)
		cnt<=0;
	else if(cnt==4'd10)
		cnt<=4'd10;
	else
		cnt<=cnt+1;

	if(cnt==4'd9)
		key_out<=1;
	else
		key_out<=0;

end

endmodule
