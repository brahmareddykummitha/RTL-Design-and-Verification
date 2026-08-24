module parameterized_ram_8x8_tb;
parameter DATA_WIDTH=8;
parameter ADDR_WIDTH=3;
reg clk,rst,wr_en;
reg [DATA_WIDTH-1:0]data_in;
reg [ADDR_WIDTH-1:0]wr_addr,rd_addr;
wire [DATA_WIDTH-1:0]data_out;
parameterized_ram_8x8 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut(clk,rst,wr_en,data_in,wr_addr,rd_addr,data_out);
initial begin
$monitor("Time=%0t clk=%b rst=%b wr_en=%b data_in=%b wr_addr=%b rd_addr=%b data_out=%b",$time,clk,rst,wr_en,data_in,wr_addr,rd_addr,data_out);
{clk,rst,wr_en,data_in,wr_addr,rd_addr}=0;
rst=1;
#10 rst=0;

#10 wr_en=1;
#10 wr_addr=3'b010;
#10 data_in=8'b0101_1100;

#10 wr_en=0;
#10 rd_addr=3'b010;

#10 wr_en=1;
#10 wr_addr=3'b011;
#10 data_in=8'b1000_1100;

#10 wr_en=0;
#10 rd_addr=3'b011;

#10 wr_en=1;
#10 wr_addr=3'b111;
#10 data_in=8'b1010_0011;

#10 wr_en=0;
#10 rd_addr=3'b111;

#20$finish;
end
always #5 clk=~clk;
endmodule