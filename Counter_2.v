// -------------模2计数器------------------
module Counter_2(
	input clk_1kHz,			// 输入时钟
	output reg count_2		// 输出时钟
);

initial count_2 <= 0;

always @(posedge clk_1kHz) begin
	if(count_2 == 1'd1)
		count_2 <= 0;
	else
		count_2 <= count_2 + 1;
end

endmodule
