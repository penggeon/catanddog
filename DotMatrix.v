/**
 * 模块名：DotMatrix
 * 描述：点阵显示模块
 */
module DotMatrix(
  input [2:0] count_8,
  input sw6,
  input sw5,
  input [1:0] gameDifficulty,
  input [1:0] gameState,

	input [1:0] cnt_cat,
	input [1:0] cnt_dog,
	input [1:0] cnt_mouse,

  output reg [7:0] row,
  output reg [7:0] col_r,
  output reg [7:0] col_g
);

always @(*)begin
	case (sw6)
		1'd1: 
			case (sw5)
				1'd1:
					case (gameDifficulty)
						0:				// 游戏难度 0
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b0000_0000;col_g = 8'b0010_0010;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b0000_0000;col_g = 8'b0110_1010;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b0000_0000;col_g = 8'b1110_1111;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b0000_0000;col_g = 8'b1111_1111;end
							endcase
						1:				// 游戏难度 1
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0000_0000;col_g = 8'b1000_1000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0000_0000;col_g = 8'b1010_1010;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b0000_0000;col_g = 8'b1010_1011;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b0000_0000;col_g = 8'b1111_1111;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b0000_0000;col_g = 8'b1111_1111;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b0000_0000;col_g = 8'b1111_1111;end
							endcase
						2:				// 游戏难度 2
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b1000_1000;col_g = 8'b1000_1000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b1010_1010;col_g = 8'b1010_1010;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b1010_1011;col_g = 8'b1010_1011;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b1111_1111;col_g = 8'b1111_1111;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b1111_1111;col_g = 8'b1111_1111;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b1111_1111;col_g = 8'b1111_1111;end
							endcase
						default:		// 游戏难度 3
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0010_1000;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0011_1000;col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0011_1010;col_g = 8'b0000_0000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0111_1110;col_g = 8'b0000_0000;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b1111_1111;col_g = 8'b0000_0000;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b1111_1111;col_g = 8'b0000_0000;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b1111_1111;col_g = 8'b0000_0000;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b1111_1111;col_g = 8'b0000_0000;end
							endcase
					endcase
				default:		// 正常游戏
					case (gameState)
						0:			// 失败
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b1100_0011;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b1110_0111;col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0111_1110;col_g = 8'b0000_0000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0011_1100;col_g = 8'b0000_0000;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b0011_1100;col_g = 8'b0000_0000;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b0111_1110;col_g = 8'b0000_0000;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b1110_0111;col_g = 8'b0000_0000;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b1100_0011;col_g = 8'b0000_0000;end
							endcase
						1:			// 成功
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0000;col_g = 8'b1000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0000_0000;col_g = 8'b1100_0000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0000_0000;col_g = 8'b0110_0001;end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b0000_0000;col_g = 8'b0011_0011;end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b0000_0000;col_g = 8'b0001_1110;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b0000_0000;col_g = 8'b0000_1100;end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
							endcase
						default:	// 继续游戏
							case(count_8)
								3'd7:begin row = 8'b0111_1111;col_r = 8'b0000_0011<<(cnt_cat*2);col_g = 8'b0000_0000;end
								3'd6:begin row = 8'b1011_1111;col_r = 8'b0000_0011<<(cnt_cat*2);col_g = 8'b0000_0000;end
								3'd5:begin row = 8'b1101_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd4:begin row = 8'b1110_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0011<<(cnt_dog*2);end
								3'd3:begin row = 8'b1111_0111;col_r = 8'b0000_0000;col_g = 8'b0000_0011<<(cnt_dog*2);end
								3'd2:begin row = 8'b1111_1011;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
								3'd1:begin row = 8'b1111_1101;col_r = 8'b0000_0011<<(cnt_mouse*2);col_g = 8'b0000_0011<<(cnt_mouse*2);end
								3'd0:begin row = 8'b1111_1110;col_r = 8'b0000_0011<<(cnt_mouse*2);col_g = 8'b0000_0011<<(cnt_mouse*2);end
							endcase
					endcase
			endcase
		default: begin row = 8'b1111_1111;col_r = 8'b0000_0000;col_g = 8'b0000_0000;end
	endcase
end

endmodule
