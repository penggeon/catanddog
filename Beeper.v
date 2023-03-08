/**
 * 模块名: Beeper
 * 描述: 蜂鸣器输出模块
**/
module Beeper(
	input sw6,
	input sw5,
	input [1:0] gameState,
	input [2:0] count_8_4Hz,
	output reg beeper_out		// 蜂鸣器输出
);

always @(*) begin
	case (sw6)
		1'b1:
			case (sw5)
				1'b1: beeper_out = 0;
				default:
					case (gameState)
						2'd0:			// 失败
							case (count_8_4Hz)
								3'd0: beeper_out = 1;
								3'd1: beeper_out = 0;
								3'd2: beeper_out = 1;
								3'd3: beeper_out = 0;
								3'd4: beeper_out = 1;
								3'd5: beeper_out = 0;
								3'd6: beeper_out = 1;
								default: beeper_out = 0;
							endcase
						2'd1:			// 成功
							case (count_8_4Hz)
								3'd0: beeper_out = 0;
								3'd1: beeper_out = 0;
								3'd2: beeper_out = 0;
								3'd3: beeper_out = 1;
								3'd4: beeper_out = 0;
								3'd5: beeper_out = 0;
								3'd6: beeper_out = 0;
								default: beeper_out = 1;
							endcase
						default: beeper_out = 0;		// 继续游戏
					endcase
			endcase
		default: beeper_out = 0;
	endcase
end

endmodule