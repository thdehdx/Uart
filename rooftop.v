module rooftop(clk,
	       rst,
	       mode,
	       button_A,
	       button_B,
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
input mode;
input button_A;
input button_B;
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

wire [11:0] ubrr;
wire [7:0] data_i;

rom r0(.clk(clk),
	.rst(rst),
	.button_A(button_A),
	.button_B(button_B),
	.ubrr(ubrr),
	.data_i(data_i));

top t0(.clk(clk),
	.rst(rst),
	.ubrr(ubrr),
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
