//-------------主模块---------------------
module Main(
	input clk_1kHz,
	input clk_4Hz,
	input clk_025Hz,
	input sw6,
	input sw5,

	input btn_7_out,
	input btn_6_out,
	input btn_5_out,
	input btn_4_out,
	input btn_0_out,

	output reg cat_crossing,
	output reg dog_crossing,
	output reg mouse_crossing,
	output reg canoe_crossing,

	output reg [3:0] ones,
	output reg [3:0] tens,

	output reg [1:0] cnt_cat,
	output reg [1:0] cnt_dog,
	output reg [1:0] cnt_mouse,
	output reg [3:0] cnt_canoe,

	output reg [1:0] gameState,
	output reg [1:0] gameDifficulty		// 游戏难度
);

// 寄存器定义
reg cat_position;
reg dog_position;
reg mouse_position;
reg canoe_position;

initial begin
	cat_crossing <= 0;
	dog_crossing <= 0;
	mouse_crossing <= 0;
	canoe_crossing <= 0;

	cnt_cat<=2'd0;
	cnt_dog<=2'd0;
	cnt_mouse<=2'd0;
	cnt_canoe<=4'd0;

	cat_position <= 0;
	dog_position <= 0;
	mouse_position <= 0;
	canoe_position <= 0;

	gameState <= 2'd2;
	gameDifficulty <= 2'd0;

	count_4 <= 0;

	ones <= 4'd0;
	tens <= 4'd0;
end

reg [1:0] count_4;	// 模4计数器

/* 游戏逻辑 */
always @(posedge clk_4Hz, posedge btn_7_out,posedge btn_6_out, posedge btn_5_out, posedge btn_4_out, posedge btn_0_out)begin
	if(btn_7_out)begin
		if(cat_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)	// 防止重复按下按钮
			&& sw6 && ~sw5)	cat_crossing <= 1;		// 开关控制
	end
	else if(btn_6_out)begin
		if(dog_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6 && ~sw5)	dog_crossing <= 1;
	end
	else if(btn_5_out)begin
		if(mouse_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6 && ~sw5)	mouse_crossing <= 1;
	end
	else if(btn_4_out)begin
		if(gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6 && ~sw5)	canoe_crossing <= 1;
	end
	else if (btn_0_out) begin	// 复位
		if(!(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6)begin
			cnt_cat<=2'd0;
			cnt_dog<=2'd0;
			cnt_mouse<=2'd0;
			cnt_canoe<=4'd0;

			cat_position <= 1'd0;
			dog_position <= 1'd0;
			mouse_position <= 1'd0;
			canoe_position <= 1'd0;

			ones <= 4'd0;
			tens <= 4'd0;

			gameState <= 2;
		end
	end
	else if(cat_crossing == 1'b1)begin	// 猫过河
		if(cat_position)begin		
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_cat==2'd0)begin
					cat_position<=0;		
					cat_crossing<=0;		
					canoe_position <= 0;	

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_cat<=cnt_cat-1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd0)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe - 1;
		end
		else begin
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_cat==2'd3)begin
					cat_position <= 1;
					cat_crossing <= 0;
					canoe_position <= 1;

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_cat <= cnt_cat + 1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd15)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe + 1;
		end
	end
	else if(dog_crossing == 1'b1)begin	// 狗过河
		if(dog_position)begin
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_dog == 2'd0)begin
					dog_position <= 0;
					dog_crossing <= 0;
					canoe_position <= 0;

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_dog <= cnt_dog - 1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd0)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe - 1;
		end
		else begin
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_dog == 2'd3)begin
					dog_position <= 1;
					dog_crossing <= 0;
					canoe_position <= 1;

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_dog <= cnt_dog + 1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd15)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe + 1;
		end
	end
	else if(mouse_crossing == 1'b1)begin	// 鼠过河
		if(mouse_position)begin
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_mouse == 2'd0)begin
					mouse_position <= 0;
					mouse_crossing <= 0;
					canoe_position <= 0;

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_mouse <= cnt_mouse - 1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd0)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe - 1;
		end
		else begin
			if(count_4==3)begin
				count_4 <= 0;

				if(cnt_mouse == 2'd3)begin
					mouse_position <= 1;
					mouse_crossing <= 0;
					canoe_position <= 1;

					// 次数加一
					if(ones == 4'd9)begin
						tens <= tens + 1;
						ones <= 4'd0;
					end
					else	ones <= ones + 1;
				end
				else cnt_mouse <= cnt_mouse + 1;
			end
			else count_4 <= count_4 + 1;

			if(cnt_canoe == 4'd15)	cnt_canoe <= cnt_canoe;
			else		cnt_canoe <= cnt_canoe + 1;
		end
	end
	else if (canoe_crossing == 1'b1) begin	// 单独过河
		if(canoe_position)begin
			if(cnt_canoe == 4'd0)begin
				canoe_position <= 0;
				canoe_crossing <= 0;

				// 次数加一
				if(ones == 4'd9)begin
					tens <= tens + 1;
					ones <= 4'd0;
				end
				else	ones <= ones + 1;
			end
			else
				cnt_canoe <= cnt_canoe - 1;
		end
		else begin
			if(cnt_canoe == 4'd15)begin
				canoe_position <= 1;
				canoe_crossing <= 0;

				// 次数加一
				if(ones == 4'd9)begin
					tens <= tens + 1;
					ones <= 4'd0;
				end
				else	ones <= ones + 1;
			end
			else
				cnt_canoe <= cnt_canoe + 1;
		end
	end
	else begin
		if(cat_position & dog_position & mouse_position)	gameState <= 2'd1;
		else if((cat_position ~^ dog_position && cat_position ^ canoe_position) || (cat_position ~^ mouse_position && cat_position ^ canoe_position))	gameState <= 2'd0;
		else begin
			case (gameDifficulty)
			0: if(tens == 1 &&  ones == 5) gameState <= 0;
			1: if(tens == 1 &&  ones == 3) gameState <= 0;
			2: if(tens == 0 &&  ones == 9) gameState <= 0;
			default: if(tens == 0 &&  ones == 7) gameState <= 0;
		endcase
		end
	end
end

/* 难度设置 */
always @(posedge clk_025Hz, posedge btn_0_out) begin
	if(btn_0_out)begin
		gameDifficulty <= sw6 ? 0 : gameDifficulty;
	end
	else begin
		gameDifficulty <= (sw5 && sw6) ? gameDifficulty + 1 : gameDifficulty;
	end
end

endmodule
