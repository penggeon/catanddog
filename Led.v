// -------------LED显示模块------------------
module Led(
  input count_2_025Hz,
  input sw6,
  input sw5,
  input [1:0] gameState,
	input [3:0] cnt_canoe,
  output reg [15:0] LD
);

always @(*) begin
	case (sw6)
		1'd1:
			case (sw5)
				1'd1:		// 设置游戏难度
					case (count_2_025Hz)
						1'd0: LD = 16'b1001_1001_1001_1001;
						default: LD = 16'b0110_0110_0110_0110;
					endcase
				default:	// 正常游戏
					case (gameState)
						2'd0: LD = 16'b0000_0000_0000_0000;
						2'd1: LD = 16'b1111_1111_1111_1111;
						default: LD = 16'b1000_0000_0000_0000 >> cnt_canoe;
					endcase
			endcase
		default: LD = 16'b0000_0000_0000_0000;
	endcase
end

endmodule
