/**
 * 模块名：DigitalTube
 * 描述：数码管显示模块
 */
module DigitalTube(
  input count_2,
  input sw6,
  input sw5,
  input [1:0] gameDifficulty,
  input [1:0] gameState,
  input [3:0] ones,
  input [3:0] tens,
  output reg [7:0] seg,
  output reg [7:0] cat
);

always @(*) begin
	case (sw6)
		1'd1:
			case (count_2)
				1'd0:begin		// 个位
					cat = 8'b1111_1110;
					case (sw5)
						1'd1:		// 设置难度
							case (gameDifficulty)
								0: seg = 8'b0110_1101;         // easy: 15
								1: seg = 8'b0100_1111;         // normal: 13
								2: seg = 8'b0110_1111;         // hard: 9
								default: seg = 8'b0000_0111;   // difficult: 7
							endcase
						default:		// 正常游戏
							case (gameState)
								0: seg = 8'b0111_0110;	// 失败
								1: seg = 8'b0011_1110;	// 成功
								default: 
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
							endcase
					endcase
				end
				default:begin	// 十位
					cat = 8'b1111_1101;
					case (sw5)
						1'd1:		// 设置难度
							case (gameDifficulty)
								0: seg = 8'b0000_0110;         // easy: 15
								1: seg = 8'b0000_0110;         // normal: 13
								2: seg = 8'b0011_1111;         // hard: 9
								default: seg = 8'b0011_1111;   // difficult: 7
							endcase
						default:		// 正常游戏
							case (gameState)
								0: seg = 8'b0111_0110;	// 失败
								1: seg = 8'b0011_1110;	// 成功
								default: 
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
							endcase
					endcase
				end
			endcase
		default: begin seg = 8'b0000_0000; cat = 8'b1111_1111; end
	endcase
end

endmodule
