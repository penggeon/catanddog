# 猫狗过河实验

这是 BUPT 某学生的数字系统设计实验——猫狗过河的源代码，仅供学习参考

仅给出了实验过程的源代码，需手动复制粘贴至自己项目中

> 注意：
>
> 1. 在网址 https://www.studysomething.top/other/catanddog.html 查看此文档更为方便
> 2. 主模块默认名为 <code>catanddog</code>，若需使用请自行修改

[toc]

# 一、设计课题的任务要求

## 1.1 任务描述

一个人要将 1 只狗、 1 只猫、 1 只老鼠渡过河，独木舟一次只能装载人和一只动物，但猫和狗不能单独在一起，而猫和老鼠也不能友好相处，试模拟这个人将三只动物安全渡过河的过程。

## 1.2 基本要求

1、 SW6 作为整机开关， SW6=0 为关机状态， 点阵、 数码管和发光二极管为全灭状态；

SW6=1 时，启动游戏，在 8× 8 点阵显示猫、狗、鼠均在左岸的情况（如图 3-1 所示），其中红色方块表示猫， 绿色方块表示狗， 黄色方块表示鼠； 数码管 DISP1-DISP0显示渡河次数，启动时显示“00”； LD15 和 LD0 显示独木舟所在位置， LD15 亮表示独木舟在左岸， LD0 亮表示独木舟在右岸，启动时独木舟在左岸；

 ![image-20230408142754845](http://images.studysomething.top/img/image-20230408142754845.png)

*图表 1 启动时点阵图案*

2、 BTN0 为复位键，任何时候按下复位都重新启动游戏；

3、 BTN7 代表猫， BTN6 代表狗， BTN5 代表鼠，按下对应的按键表示带该动物过河，同时点阵上显示过河动画。 例如按下 BTN6 选择狗，点阵按图 3-2 所示过程显示过河动画，每秒切换一幅图案；

 ![image-20230408142819955](http://images.studysomething.top/img/image-20230408142819955.png)

*图表 2 狗从左岸到右岸的点阵动画过程*

4、 带某动物过河时要求独木舟和该动物在河的同侧， 如果不在同侧，则按键无效；

5、 BTN4 代表独木舟单独往返，按下后在 LD0~LD15 上显示渡河过程，根据独木舟当前所在位置，依次点亮 LD0~LD15 或 LD15~LD0，每 0.25 秒切换一个 LED；

6、 在数码管 DISP1-DISP0 显示渡河次数， 带动物过河或者独木舟单独往返渡河次数均加 1；

7、 将三只动物全部带到右岸则游戏成功， LD0~LD15 全亮表示成功，按 BTN0 可重新启动游戏；

8、 如果出现猫和鼠或者猫和狗单独在河的某侧，则游戏失败， LD0~LD15 全灭表示失败，按 BTN0 可重新启动游戏。

## 1.3 提高要求

1、 游戏难度可以设置，不同难度要在不同的渡河次数之内完成游戏，在规定步数内未完成游戏则为失败；

2、 在不同情况下播放不同的音效或乐曲；

3、 自拟其它功能。

# 二、系统设计（设计思路、总体框图、分块设计）

## 2.1 设计思路

模块化设计，自顶向下设计，自下向上实现。

时钟分频模块将1kHz时钟分频为4Hz与0.25Hz供其他模块使用，消抖模块将按钮经过消抖输出有效短脉冲信号，计数器模块产生需要的计数器供其他模块使用，LED模块、点阵模块、数码管模块、蜂鸣器模块实现底层功能，Main模块实现主要的游戏逻辑。

## 2.2 总体框图

 ![image-20230408142837394](http://images.studysomething.top/img/image-20230408142837394.png)

*图表 3 总体框图*

## 2.3 分块设计

### 2.3.1 顶层模块

顶层模块负责各自模块之间的连接

### 2.3.2 主模块

Main模块，负责主要逻辑的实现。

包括按下各个按钮后标志位的更新、游戏状态实时更新，正常游戏时猫、狗、鼠位置变量的变换即过河动画，复位键按下后标志位置初始值、位置变量置零等操作。

### 2.3.3 时钟分频模块（系列）

时钟频率选用1kHz，项目中需要采用其他频率时钟，故而进行时钟分频。

包括divide_4Hz，divide_025Hz两个时钟分频模块，分别产生4Hz时钟与0.25Hz时钟。

### 2.3.4 计数器模块（系列）

项目设计中需要各种计数器，故将计数器单独拿出，封装为了不同的模块。

包括Counter_8，Counter_2，Counter_2_025Hz，Counter_8_4Hz四个计数器模块，前两者分别是1kHz时钟下产生的模8计数器与模2计数器，后两者分别是0.25Hz时钟下产生的模8计数器与模2计数器。

### 2.3.5 消抖模块

由于机械按键按下后可能会产生抖动，导致一次的按键按下事件被识别为多次按键按下，故按键信号均需经过消抖模块进行处理。该项目利用debounce模块进行消抖。

### 2.3.6 LED模块

LED模块采用组合逻辑设计。

第一步判断开机拨码sw6，sw6为0时输出信号全为0，sw6为1时继续判断。

第二步判断难度设置拨码sw5，sw5为1时根据counter_2_025Hz计数器输出信号来实现LED的闪烁效果，表示此时正处于难度设置中，sw5为0时继续判断。

第三步判断游戏状态标志位，若成功，则LED输出信号全为1，若失败，则LED输出信号全为0，若正在处于游戏中，则根据Main模块的输出信号cnt_canoe来判断此时的独木舟处于何处，并正确显示。

### 2.3.7 点阵模块

点阵模块采用组合逻辑设计。

第一步判断开机拨码sw6，sw6为0时行信号输出为1，列信号输出为0，sw6为1时继续判断。

第二步判断难度设置拨码sw5。

若sw为1，则根据游戏难度，显示不同的动画，提示用户不同的游戏难度，其中点阵行扫描采用计数器Counter_8的输出信号实现。

若sw为0，则根据游戏状态，显示不同的动画。

游戏失败：显示叉号。

游戏成功：显示对勾。

游戏进行中：通过Main的输出信号判断猫、狗、鼠的位置显示不同的点阵动画。

### 2.3.8 数码管模块

数码管模块采用组合逻辑设计。

第一步判断开机拨码sw6，sw6为0时阴极信号cat全为1，阳极信号seg全为0，sw6为1时继续判断。

第二步判断模2计数器输出信号，判断是显示个位还是十位。

第三步判断难度设置拨码sw5。

若sw为1，则根据游戏难度，显示不同的数字（个位与十位不同），提示用户不同的渡河次数限制。

若sw为0，则根据游戏状态，显示不同的动画。

游戏失败：显示HH，表示失败。

游戏成功：显示UU，表示成功。

游戏进行中：通过Main的输出信号tens与ones分别显示当前的渡河次数。

### 2.3.9 蜂鸣器模块

蜂鸣器模块采用组合逻辑设计。

第一步判断开机拨码sw6，sw6为0时蜂鸣器输出信号为0，，sw6为1时继续判断。

第二步判断开机拨码sw5，sw6为1时蜂鸣器输出信号为0，，sw6为0时继续判断。

第三步判断游戏状态，通过count_8_4Hz信号改变蜂鸣器输出。

游戏失败：输出周期1s，占空比为25%的信号。

游戏成功：输出周期0.5s，占空比为50%的信号。

游戏进行中：输出信号为0。

# 三、功能说明及资源利用情况

## 3.1 功能说明

### 3.1.1 拨码开关

拨码开关sw6为总开关，只有拨上sw6才能正常进行游戏。

拨码开关sw5为游戏难度设置，当sw5拨上时，每隔4s切换一次游戏难度，游戏难度由0到3依次变换，难度默认为0。当难度为0时，最多渡河次数为15次；难度为1时，最多渡河次数为13次；难度为2时，最多渡河次数为9次；难度为3时，最多渡河次数为6次

### 3.1.2 按键

按键BTN7为猫过河按键，按下猫过河。

按键BTN6为狗过河按键，按下狗过河。

按键BTN5为鼠过河按键，按下鼠过河。

按键BTN4为独木舟过河按键，按下独木舟单独过河。

按键BTN0为复位建，按下游戏复位。

### 3.1.3 游戏难度设置

处于游戏难度设置时，LED灯闪烁，数码管提示次数，点阵显示难度。

难度为0时，数码管显示15，点阵显示绿色小火。

难度为1时，数码管显示13，点阵显示绿色中火。

难度为2时，数码管显示9，点阵显示黄色中火。

难度为3时，数码管显示7，点阵显示红色大火。

### 3.1.4 游戏状态

游戏成功时，LED灯全亮，点阵显示对勾，数码管显示UU，蜂鸣器间断蜂鸣，占空比为25%。

游戏失败时，LED灯全灭，点阵显示叉号，数码管显示HH，蜂鸣器间断蜂鸣，占空比为50%。

## 3.2 资源利用情况

### 3.2.1 晶振时钟

利用情况：利用

使用1kHz时钟作为总时钟输入。

### 3.2.2 SW拨码

利用情况：SW6，SW5

SW6，游戏开关拨码。

SW5，游戏难度设置拨码。

### 3.2.3 BTN按钮

利用情况：BTN7，BTN6，BTN5，BTN4，BTN0

BTN７，猫过河按键。

BTN６，狗过河按键。

BTN５，鼠过河按键。

BTN４，独木舟单独过河按键。

BTN０，复位键。

### 3.2.4 LED灯

利用情况：LED15~0

作用：表示游戏难度设置，游戏成功，游戏失败，独木舟位置

### 3.2.5 点阵

利用情况：row15~0，col_r15~0，col_g15~0

作用：表示游戏难度设置，游戏成功，游戏失败，猫狗鼠位置

### 3.2.6 数码管

利用情况：DISP1~0

作用：表示最多渡河次数，游戏成功，游戏失败，当前渡河次数

### 3.2.7 蜂鸣器

利用情况：利用

作用：表示游戏成功，游戏失败

# 四、故障及问题分析

## 4.1 组合逻辑与时序逻辑

原本LED、点阵、数码管与蜂鸣器模块是采用时序逻辑实现的，但在仿真以及下载中出现了问题，实现现象为各个输出信号均无法确定。

由于这些模块并不需要每隔一段时间更改一次，于是改为采用组合逻辑实现。只需根据不同的情况，使输出连接不同的信号即可。

## 4.2 时序逻辑always块设计

在 <code>always@(posedge clk or posedge btn7 or posedge btn6)</code> 之类的 always 块中，应当首先判断 btn7、btn6 是否按下即

```verilog
if(btn7)begin

end
else if (btn6)beign

end
else beign
	// 此处编写时钟上升沿触发后的逻辑
end
```

反之，若在 if 中判断诸如 sw6 或者敏感条件列表中不存在的信号，会报错，硬件是不支持这样设计的。
若需在 btn7 按下同时判断 sw6 ，可以采用以下代码实现

```verilog
if(btn7)begin
   If(sw6)begin
		// 此处编写正常逻辑
	end
end
```

# 五、总结和结论

## 5.1 Verilog设计

Verilog设计时应采用自顶向下设计，自下向上实现的思路。在各个模块中实现简单或目标清晰的功能，确认各模块功能正常后，拼接子模块，实现整体功能的实现。

## 5.2 猫狗过河实现思路

猫狗过河实验中重要的一些变量（reg型）为标志位，各个子模块（LED、点阵等模块）可根据标志位改变自己的输出信号，而不需要关心标志位的更改。

在Main模块中实现主要的功能，此时可以更改标志位，表示猫的位置，或独木舟的位置，以及游戏是否成功等，而不需要关心在具体的状态时底层如何显示。