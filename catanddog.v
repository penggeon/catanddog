module catanddog(
	input clk_1kHz,			// 时钟信号，1MHz
	input btn_7,			// 猫
	input btn_6,			// 狗
	input btn_5,			// 鼠
	input btn_4,			// 鼠
	output [7:0] row,		// 行信号（低电平有效）
	output [7:0] col_r,		// 列信号_红（高电平有效）
	output [7:0] col_g,		// 列信号_绿（高电平有效）
	output [15:0] LD,

	output clk_1Hz,
	output clk_4Hz,

	output btn_7_out,
	output btn_6_out,
	output btn_5_out,
	output btn_4_out,

	output cat_crossing,
	output dog_crossing,
	output mouse_crossing,
	output canoe_crossing,
	output cat_position,
	output dog_position,
	output mouse_position,
	output canoe_position,
	output [1:0] cnt_cat,
	output [1:0] cnt_dog,
	output [1:0] cnt_mouse,
	output [3:0] cnt_canoe,

	output [1:0] gameState	// 0失败1成功2继续
);

// ---引用模块实例---
// wire clk_1Hz;
// wire btn_7_out;
// wire btn_6_out;
// wire btn_5_out;

debounce debounce_0(clk_1kHz,btn_7,btn_7_out);
debounce debounce_1(clk_1kHz,btn_6,btn_6_out);
debounce debounce_2(clk_1kHz,btn_5,btn_5_out);
debounce debounce_3(clk_1kHz,btn_4,btn_4_out);

divide_1000 divide_0(clk_1kHz,clk_1Hz);
divide_4Hz divide_4Hz_0(clk_1kHz,clk_4Hz);

scanning scan_0(clk_1kHz,clk_1Hz,clk_4Hz,btn_7_out,btn_6_out,btn_5_out,btn_4_out,
cat_position,dog_position,mouse_position,canoe_position,
cat_crossing,dog_crossing,mouse_crossing,canoe_crossing,
row,col_r,col_g,LD,
cnt_cat,cnt_dog,cnt_mouse,cnt_canoe,
gameState
);

endmodule
