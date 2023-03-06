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
	output [7:0] cat

	// output clk_1Hz,
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
	// output cat_position,
	// output dog_position,
	// output mouse_position,
	// output canoe_position,
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
wire clk_1Hz;
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
wire cat_position;
wire dog_position;
wire mouse_position;
wire canoe_position;
wire [1:0] cnt_cat;
wire [1:0] cnt_dog;
wire [1:0] cnt_mouse;
wire [3:0] cnt_canoe;

wire [3:0] ones;
wire [3:0] tens;

wire [1:0] gameDifficulty;
wire [1:0] gameState;

debounce debounce_0(clk_1kHz,btn_7,btn_7_out);
debounce debounce_1(clk_1kHz,btn_6,btn_6_out);
debounce debounce_2(clk_1kHz,btn_5,btn_5_out);
debounce debounce_3(clk_1kHz,btn_4,btn_4_out);
debounce debounce_5(clk_1kHz,btn_0,btn_0_out);

divide_1000 divide_0(clk_1kHz,clk_1Hz);
divide_4Hz divide_4Hz_0(clk_1kHz,clk_4Hz);
divide_025Hz divide_025Hz_0(clk_1kHz,clk_025Hz);

scanning scan_0(clk_1kHz,clk_4Hz,clk_025Hz,sw6,sw5,
btn_7_out,btn_6_out,btn_5_out,btn_4_out,btn_0_out,
cat_position,dog_position,mouse_position,canoe_position,
cat_crossing,dog_crossing,mouse_crossing,canoe_crossing,
ones,tens,
row,col_r,col_g,LD,
seg,cat,
cnt_cat,cnt_dog,cnt_mouse,cnt_canoe,
gameState,gameDifficulty
);

endmodule
