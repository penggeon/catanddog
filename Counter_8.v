/**
 * 模块名：Counter_8
 * 描述：模8计数器(1kHz)
 */
module Counter_8(
	input clk_1kHz,			// 输入时钟
	output reg [2:0] count_8		// 输出时钟
);

initial count_8 <= 0;

always @(posedge clk_1kHz)begin
	if(count_8 == 3'd7)
		count_8 <= 3'd0;
	else
		count_8 <= count_8 + 1;
end

endmodule
