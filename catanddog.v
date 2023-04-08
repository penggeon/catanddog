/**
 * 模块名：catanddog
 * 描述：顶层模块，负责其他模块调用
 * 注意事项：有些注释是为了方便仿真设置的
 */
module catanddog(
	input clk_1kHz,		// 时钟信号，1MHz
	input btn_7,			// 猫
	input btn_6,			// 狗
	input btn_5,			// 鼠
	input btn_4,			// 独木舟
	input btn_0,			// 复位键
	input sw6,				// 开关拨码
	input sw5,				// 选择难度

	output [7:0] row,			// 行信号（低电平有效）
	output [7:0] col_r,		// 列信号_红（高电平有效）
	output [7:0] col_g,		// 列信号_绿（高电平有效）
	output [15:0] LD,			// LD输出信号

	output [7:0] seg,		// 数码管阳极信号
	output [7:0] cat,		// 数码管阴极信号

	output beeper_out		// 蜂鸣器输出信号

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
	// output [1:0] gameState,	// 0失败1成功2继续

	// output count_2,
	// output [2:0] count_8,
	// output count_2_025Hz,
	// output [2:0] count_8_4Hz
);

// ---引用模块实例---
wire clk_4Hz;			// 4Hz时钟
wire clk_025Hz;		// 0.25Hz时钟

wire btn_7_out;		// BTN7消抖后输出信号
wire btn_6_out;		// BTN6消抖后输出信号
wire btn_5_out;		// BTN5消抖后输出信号
wire btn_4_out;		// BTN4消抖后输出信号
wire btn_0_out;		// BTN0消抖后输出信号

wire cat_crossing;		// 猫过河标志位
wire dog_crossing;		// 狗过河标志位
wire mouse_crossing;	// 鼠过河标志位
wire canoe_crossing;	// 独木舟过河标志位
wire [1:0] cnt_cat;		// 存储猫位置寄存器
wire [1:0] cnt_dog;		// 存储狗位置寄存器
wire [1:0] cnt_mouse;	// 存储鼠位置寄存器
wire [3:0] cnt_canoe;	// 存储独木舟位置寄存器

wire [3:0] ones;		// 渡河次数个位
wire [3:0] tens;		// 渡河次数十位

wire [1:0] gameDifficulty;	// 游戏难度,0表示15次,1表示13次,2表示9次,3表示7次
wire [1:0] gameState;				// 游戏状态,0表示失败,1表示成功,2表示游戏进行中

// 导线定义
wire count_2;						// 模2计数器(1kHz)
wire [2:0] count_8;			// 模8计数器(1kHz)
wire count_2_025Hz;			// 模2计数器(0.25Hz)
wire [2:0] count_8_4Hz;	// 模8计数器(4Hz)

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
Main Main_0(clk_4Hz,clk_025Hz,sw6,sw5,
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
