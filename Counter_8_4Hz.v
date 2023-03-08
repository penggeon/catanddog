// -------------模8计数器 4Hz------------------
module Counter_8_4Hz(
	input clk_4Hz,			// 输入时钟
	output reg [2:0] count_8_4Hz		// 输出时钟
);

initial count_8_4Hz <= 0;

always @(posedge clk_4Hz) begin
	if(count_8_4Hz == 3'd7)
		count_8_4Hz <= 3'd0;
	else
		count_8_4Hz <= count_8_4Hz + 1;
end

endmodule
