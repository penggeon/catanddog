/**
 * 模块名：Counter_2_025Hz
 * 描述：模2计数器(0.25kHz)
 */
module Counter_2_025Hz(
	input clk_025Hz,			// 输入时钟
	output reg count_2_025Hz		// 输出时钟
);

initial count_2_025Hz <= 0;

always @(posedge clk_025Hz) begin
	if(count_2_025Hz == 1'd1)
		count_2_025Hz <= 0;
	else
		count_2_025Hz <= count_2_025Hz + 1;
end

endmodule
