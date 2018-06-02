`timescale 1ns / 1ps

module uart_tb();

reg clk;	// 3.6864MHz = 3_686_400
reg rst;	// 9600 -> 23 19200 -> 11
reg [11:0] ubrr;
reg mode0;
reg mode1;
reg [7:0] data_i;
reg rxd;

wire [7:0] data_o;
wire txd;

initial begin
	clk = 0;
	forever #136 clk = ~clk;
end

initial begin
	rst <= 0;	 
	#2 rst <= 1;
	#2 rst <=0;
	#1 rst <=1;
end

initial begin
	ubrr <= 12'b0000_0000_0000;	 
	#1 ubrr <= 12'b0000_0001_0111; //9600//ubrr=23
end

initial begin
	mode0 <= 1'b0;
	#1 mode0 <= 1'b1;
	#1 mode0 <= 1'b0;
end

initial begin
	mode1 <= 1'b1;
	#1 mode1 <= 1'b0;
	#1 mode1 <= 1'b1;
end

initial begin
	data_i = 8'b0000000;
	#1 data_i = 8'h37;
	#152038 data_i = 8'h72;
end

initial begin
	rxd = 1;
        // data receiver test
        // H : 8'h48 - 0100 1000
        #5 rxd = 0;     // start bit
        #52038 rxd = 0;     // bit 0
        #52038 rxd = 0;     // bit 1
        #52038 rxd = 0;     // bit 2
        #52038 rxd = 1;     // bit 3
        #52038 rxd = 0;     // bit 4
        #52038 rxd = 0;     // bit 5
        #52038 rxd = 1;     // bit 6
        #52038 rxd = 0;     // bit 7
        #52038 rxd = 1;     // stop bit
end

top TX (.clk(clk), .rst(rst), .ubrr(ubrr), .mode(mode1), .data_i(data_i), .data_o(), .rxd(), .txd(txd));
top RX (.clk(clk), .rst(rst), .ubrr(ubrr), .mode(mode0), .data_i(), .data_o(data_o), .rxd(txd), .txd());
endmodule
