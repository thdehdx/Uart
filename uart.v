module uart(clk,
	    rst,
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

input clk;
input rst;			// reset, low active
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

reg [7:0] data_o;
reg [7:0] led;
reg [1:0] start;
reg [3:0] rxd_index;
reg [7:0] rxd_buffer;
reg [3:0] rxd_cnt;
reg txd;
reg [3:0] txd_index;
reg [7:0] txd_buffer;
reg [3:0] txd_cnt;
reg [11:0] tb_ubrr;
reg stop;
reg seg7_com_anode;
reg seg7_top_hor;
reg seg7_mid_hor;
reg seg7_bot_hor;
reg seg7_top_ver_left;
reg seg7_top_ver_right;
reg seg7_bot_ver_left;
reg seg7_bot_ver_right;
//reg [11:0] debug;

always @(posedge clk or negedge rst)begin
	if(rst==0)begin
		txd_index <= 4'b0;
		txd_buffer <= 8'b00000000;
		txd_cnt <= 4'b0;
		rxd_index <= 4'b0;
		rxd_buffer <= 8'b0;
		rxd_cnt <= 4'b0;
		data_o <=8'b0;
		stop <= 1'b1;//if stop=1, txd mode is stop
		start <= 2'b0;
		seg7_com_anode <= 1'b1;
		seg7_top_hor <= 1'b1;
		seg7_mid_hor <= 1'b0;
		seg7_bot_hor <= 1'b1;
		seg7_top_ver_left <= 1'b1;
		seg7_top_ver_right <= 1'b1;
		seg7_bot_ver_left <= 1'b1;
 		seg7_bot_ver_right <= 1'b1;
	end
	else begin
		if(mode == 1)begin
			seg7_top_hor <= 1'b0;
			seg7_mid_hor <= 1'b1;
			seg7_bot_hor <= 1'b0;
			seg7_top_ver_left <= 1'b0;
			seg7_top_ver_right <= 1'b0;
			seg7_bot_ver_left <= 1'b0;
	 		seg7_bot_ver_right <= 1'b0;
			case(txd_cnt)
				4'b0000:begin
					txd <= 1'b0;//start bit
					if(stop == 1'b1)
						txd_buffer <= data_i;
						led <= data_i;
					stop <= 1'b0;
					if(txd_buffer != 8'b0)
						txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0001:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0010:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0011:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0100:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0101:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0110:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b0111:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b1000:begin
					txd <= txd_buffer[txd_index];
					txd_index <= txd_index + 1'b1;
					txd_cnt <= txd_cnt + 1'b1;
				end
				4'b1001:begin
					txd <= 1;
					txd_index <= 4'b0;
					txd_cnt <= 4'b0;
					stop <= 1'b1;
				end
				default:begin
					txd <= txd;
					txd_index <= txd_index;
					txd_cnt <= 4'b0;
					stop <= stop;
				end
			endcase
		end
		if(start == 2'b10)begin//for first trun
			if(mode == 0)begin
				seg7_top_hor <= 1'b0;
				seg7_mid_hor <= 1'b1;
				seg7_bot_hor <= 1'b0;
				seg7_top_ver_left <= 1'b0;
				seg7_top_ver_right <= 1'b0;
				seg7_bot_ver_left <= 1'b0;
		 		seg7_bot_ver_right <= 1'b0;
				case(rxd_cnt)
					4'b0000:begin
						if(rxd == 0)
							rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0001:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0010:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0011:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0100:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0101:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0110:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0111:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b1000:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b1001:begin
						rxd_index <= 4'b0;
						rxd_cnt <= 4'b0;
						data_o <= rxd_buffer;
					end
					default:begin
						rxd_buffer[rxd_index] <= rxd_buffer[rxd_index];
						rxd_index <= rxd_index;
						rxd_cnt <= 4'b0;
						data_o <= data_o;
					end
				endcase
			end
		end
		else if(start == 2'b10)begin
			if(mode == 0)begin
				seg7_top_hor <= 1'b0;
				seg7_mid_hor <= 1'b1;
				seg7_bot_hor <= 1'b0;
				seg7_top_ver_left <= 1'b0;
				seg7_top_ver_right <= 1'b0;
				seg7_bot_ver_left <= 1'b0;
		 		seg7_bot_ver_right <= 1'b0;
				case(rxd_cnt)
					4'b0000:begin
						if(rxd == 0)
							rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0001:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0010:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0011:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0100:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0101:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0110:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b0111:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b1000:begin
						rxd_buffer[rxd_index] <= rxd;
						rxd_index <= rxd_index + 1'b1;
						rxd_cnt <= rxd_cnt + 1'b1;
					end
					4'b1001:begin
						rxd_index <= 4'b0;
						rxd_cnt <= 4'b0;
						data_o <= rxd_buffer;
					end
					default:begin
						rxd_buffer[rxd_index] <= rxd_buffer[rxd_index];
						rxd_index <= rxd_index;
						rxd_cnt <= 4'b0;
						data_o <= data_o;
					end
				endcase
			end
		end
		if(start != 2'b10)
			start <= start + 1'b1;
	end
end

endmodule
