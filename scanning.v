//-------------扫描显示模块---------------------
module scanning(
	input clk_1kHz,
	input clk_4Hz,
	input sw6,

	input btn_7_out,
	input btn_6_out,
	input btn_5_out,
	input btn_4_out,
	input btn_0_out,
	output reg cat_position,
	output reg dog_position,
	output reg mouse_position,
	output reg canoe_position,

	output reg cat_crossing,
	output reg dog_crossing,
	output reg mouse_crossing,
	output reg canoe_crossing,

	output reg [3:0] ones,
	output reg [3:0] tens,
	
	output reg [7:0] row,			// 行信号（低电平有效）
	output reg [7:0] col_r,			// 列信号_红（高电平有效）
	output reg [7:0] col_g,			// 列信号_绿（高电平有效）
	output reg [15:0] LD,

	output reg [7:0] seg,
	output reg [7:0] cat,

	output reg [1:0] cnt_cat,
	output reg [1:0] cnt_dog,
	output reg [1:0] cnt_mouse,
	output reg [3:0] cnt_canoe,

	output reg [1:0] gameState
);

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

	count_4 <= 0;
end

reg [1:0] count_4;	// 模4计数器

always @(posedge clk_4Hz, posedge btn_7_out,posedge btn_6_out, posedge btn_5_out, posedge btn_4_out, posedge btn_0_out)begin
	if(btn_7_out)begin
		if(cat_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)	// 防止重复按下按钮
			&& sw6)	cat_crossing <= 1;		// 开关控制
	end
	else if(btn_6_out)begin
		if(dog_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6)	dog_crossing <= 1;
	end
	else if(btn_5_out)begin
		if(mouse_position ~^ canoe_position && gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6)	mouse_crossing <= 1;
	end
	else if(btn_4_out)begin
		if(gameState == 2'd2
			&& !(cat_crossing | dog_crossing | mouse_crossing | canoe_crossing)
			&& sw6)	canoe_crossing <= 1;
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
		else gameState <= 2'd2;
	end
end

reg [2:0] cnt_8;	// 模8计数器

always @(posedge clk_1kHz)begin
	if(cnt_8 == 3'd7)
		cnt_8 <= 3'd0;
	else
		cnt_8 <= cnt_8 + 1;
end

always @(*)begin
	case (sw6)
		1'd1: 
			case(cnt_8)
				3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0011<<(cnt_cat*2);col_g = 8'b0000_0000;end
				3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0011<<(cnt_cat*2);col_g = 8'b0000_0000;end
				3'd5:begin row = 8'b1101_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
				3'd4:begin row = 8'b1110_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0011<<(cnt_dog*2);end
				3'd3:begin row = 8'b1111_0111;col_r = 8'b0000_0000;col_g = 8'b0000_0011<<(cnt_dog*2);end
				3'd2:begin row = 8'b1111_1011;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
				3'd1:begin row = 8'b1111_1101;col_r = 8'b0000_0011<<(cnt_mouse*2);col_g = 8'b0000_0011<<(cnt_mouse*2);end
				3'd0:begin row = 8'b1111_1110;col_r = 8'b0000_0011<<(cnt_mouse*2);col_g = 8'b0000_0011<<(cnt_mouse*2);end
			endcase
		default: begin row = 8'b1111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
	endcase
	
end

always @(*) begin
	case (sw6)
		1'd1:
			case (gameState)
				2'd0: LD = 16'b0000_0000_0000_0000;
				2'd1: LD = 16'b1111_1111_1111_1111;
				default: LD = 16'b1000_0000_0000_0000 >> cnt_canoe;
			endcase
		default: LD = 16'b0000_0000_0000_0000;
	endcase
end

// reg [3:0] ones;	// 个位
// reg [3:0] tens;	// 十位
initial begin
	ones <= 4'd0;
	tens <= 4'd0;
end
always @(*) begin
	case (sw6)
		1'd1:
			case (count_2)
				1'd0:begin		// 个位
					cat = 8'b1111_1110;
					case (ones)
						0: seg = 8'b0011_1111;
						1: seg = 8'b0000_0110;
						2: seg = 8'b0101_1011;
						3: seg = 8'b0100_1111;
						4: seg = 8'b0110_0110;
						5: seg = 8'b0110_1101;
						6: seg = 8'b0111_1101;
						7: seg = 8'b0000_0111;
						8: seg = 8'b0111_1111;
						default: seg = 8'b0110_1111;
					endcase
				end
				default:begin	// 十位
					cat = 8'b1111_1101;
					case (tens)
						0: seg = 8'b0011_1111;
						1: seg = 8'b0000_0110;
						2: seg = 8'b0101_1011;
						3: seg = 8'b0100_1111;
						4: seg = 8'b0110_0110;
						5: seg = 8'b0110_1101;
						6: seg = 8'b0111_1101;
						7: seg = 8'b0000_0111;
						8: seg = 8'b0111_1111;
						default: seg = 8'b0110_1111;
					endcase
				end
			endcase
		default: begin seg = 8'b0000_0000; cat = 8'b1111_1111; end
	endcase
end

reg count_2;
initial count_2 <= 0;
always @(posedge clk_1kHz) begin
	if(count_2 == 1'd1)	count_2 <= 0;
	else	count_2 <= count_2 + 1;
end

endmodule
