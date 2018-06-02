module top(clk,
	   rst,
	   ubrr,
	   mode,
	   data_i,
	   data_o,
	   rxd,
	   txd,
	   led,
	   seg7_com_anode,
	   seg7_top_hor,
	   seg7_mid_hor,
	   seg7_bot_hor,
	   seg7_top_ver_left,
	   seg7_top_ver_right,
	   seg7_bot_ver_left,
	   seg7_bot_ver_right);

input clk;			// clock, 3.6864MHz = 3_686_400
input rst;			// reset, low active
input [11:0] ubrr;
input mode;
input [7:0] data_i;
input rxd;

output [7:0] data_o;
output txd;
output [7:0] led;
output seg7_com_anode;
output seg7_top_hor;
output seg7_mid_hor;
output seg7_bot_hor;
output seg7_top_ver_left;
output seg7_top_ver_right;
output seg7_bot_ver_left;
output seg7_bot_ver_right;

wire uclk;

udiv u0(.clk(clk),
	.rst(rst),
	.ubrr(ubrr),
	.uclk(uclk));
uart u1(.clk(uclk),
	.rst(rst),
	.mode(mode),
	.data_i(data_i),
	.data_o(data_o),
	.txd(txd),
	.rxd(rxd),
	.led(led),
	.seg7_com_anode(seg7_com_anode),
	.seg7_top_hor(seg7_top_hor),
	.seg7_mid_hor(seg7_mid_hor),
	.seg7_bot_hor(seg7_bot_hor),
	.seg7_top_ver_left(seg7_top_ver_left),
	.seg7_top_ver_right(seg7_top_ver_right),
	.seg7_bot_ver_left(seg7_bot_ver_left),
	.seg7_bot_ver_right(seg7_bot_ver_right));

endmodule
