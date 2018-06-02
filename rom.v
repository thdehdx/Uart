module rom(clk,
	   rst,
	   button_A,
	   button_B,
	   ubrr,
	   data_i);

input clk;			// clock, 3.6864MHz = 3_686_400
input rst;			// reset, low active
input button_A;
input button_B;

output [11:0] ubrr;
output [7:0] data_i;

reg [11:0] ubrr;
reg [7:0] data_i;

always @(posedge clk or negedge rst)begin
	if(rst==0)begin
		ubrr <= 12'b0;
		data_i <= 8'b0;
	end
	else begin
		ubrr <= 12'b0000_0001_0111; //23 -> 9600
		if(button_A == 1'b0)begin
			data_i <= 8'd65;
		end
		else if(button_B == 1'b0)begin
			data_i <= 8'd66;
		end
		else begin
			data_i <= data_i;
		end
	end
end

endmodule
