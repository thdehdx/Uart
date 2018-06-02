module udiv(clk,
	   rst,
	   ubrr,
	   uclk);

input clk;			// clock, 3.6864MHz = 3_686_400
input rst;			// reset, low active
input [11:0] ubrr;

output uclk;

reg [15:0] ubrr_cnt;
reg [15:0] cnt;
reg uclk;

always @(posedge clk or negedge rst) begin
	ubrr_cnt <= (ubrr + 1'b1) << 3;
end

always @(posedge clk or negedge rst) begin
	if(rst == 0) begin
		cnt <= 16'b0;
		uclk <= 1'b0;
	end
	else begin
		cnt <= cnt + 1'b1;
		if(cnt == ubrr_cnt)begin
			uclk <= ~uclk;
			cnt <= 4'b0;
		end
		else uclk <= uclk;
	end
end

endmodule
