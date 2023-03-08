module catanddog(
	input clk_1kHz,			// 时钟信号，1MHz
	input btn_7,			// 猫
	input btn_6,			// 狗
	input btn_5,			// 鼠
	input btn_4,			// 独木舟
	input btn_0,			// 复位键
	input sw6,				// 开关拨码
	input sw5,				// 选择难度

	output [7:0] row,		// 行信号（低电平有效）
	output [7:0] col_r,		// 列信号_红（高电平有效）
	output [7:0] col_g,		// 列信号_绿（高电平有效）
	output [15:0] LD,

	output [7:0] seg,
	output [7:0] cat,

	output beeper_out

	// output clk_4Hz,
	// output clk_025Hz,

	// output btn_7_out,
	// output btn_6_out,
	// output btn_5_out,
	// output btn_4_out,
	// output btn_0_out,

	// output cat_crossing,
	// output dog_crossing,
	// output mouse_crossing,
	// output canoe_crossing,
	// output [1:0] cnt_cat,
	// output [1:0] cnt_dog,
	// output [1:0] cnt_mouse,
	// output [3:0] cnt_canoe,

	// output [3:0] ones,
	// output [3:0] tens,

	// output [1:0] gameDifficulty,
	// output [1:0] gameState	// 0失败1成功2继续
);

// ---引用模块实例---
wire clk_4Hz;
wire clk_025Hz;

wire btn_7_out;
wire btn_6_out;
wire btn_5_out;
wire btn_4_out;
wire btn_0_out;

wire cat_crossing;
wire dog_crossing;
wire mouse_crossing;
wire canoe_crossing;
wire [1:0] cnt_cat;
wire [1:0] cnt_dog;
wire [1:0] cnt_mouse;
wire [3:0] cnt_canoe;

wire [3:0] ones;
wire [3:0] tens;

wire [1:0] gameDifficulty;
wire [1:0] gameState;

// 导线定义
wire count_2;
wire [2:0] count_8;
wire count_2_025Hz;
wire [2:0] count_8_4Hz;

// 消抖模块
debounce debounce_0(clk_1kHz,btn_7,btn_7_out);
debounce debounce_1(clk_1kHz,btn_6,btn_6_out);
debounce debounce_2(clk_1kHz,btn_5,btn_5_out);
debounce debounce_3(clk_1kHz,btn_4,btn_4_out);
debounce debounce_5(clk_1kHz,btn_0,btn_0_out);

// 时钟分频
divide_4Hz divide_4Hz_0(clk_1kHz,clk_4Hz);
divide_025Hz divide_025Hz_0(clk_1kHz,clk_025Hz);

// 计数器模块
Counter_8 Counter_8_0(clk_1kHz, count_8);
Counter_2 Counter_2_0(clk_1kHz, count_2);
Counter_2_025Hz Counter_2_025Hz_0(clk_025Hz, count_2_025Hz);
Counter_8_4Hz Counter_8_4Hz_0(clk_4Hz, count_8_4Hz);

// 主模块
Main Main_0(clk_1kHz,clk_4Hz,clk_025Hz,sw6,sw5,
btn_7_out,btn_6_out,btn_5_out,btn_4_out,btn_0_out,
cat_crossing,dog_crossing,mouse_crossing,canoe_crossing,
ones,tens,
cnt_cat,cnt_dog,cnt_mouse,cnt_canoe,
gameState,gameDifficulty
);

// 重要子模块
Led Led_0(count_2_025Hz, sw6, sw5, gameState, cnt_canoe, LD);
DotMatrix DotMatrix_0(count_8, sw6, sw5, gameDifficulty, gameState,
cnt_cat, cnt_dog, cnt_mouse,
row, col_r, col_g
);
DigitalTube DigitalTube_0(count_2, sw6, sw5, gameDifficulty, gameState,
ones, tens, seg, cat
);
Beeper Beeper_0(sw6, sw5, gameState, count_8_4Hz, beeper_out);

endmodule
