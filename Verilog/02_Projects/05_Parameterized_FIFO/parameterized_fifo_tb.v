module parameterized_fifo_tb;
parameter DATA_WIDTH=8;
parameter ADDR_WIDTH=3;
reg clk,rst,wr_en,rd_en;
reg [DATA_WIDTH-1:0]data_in;
wire full,empty;
wire [DATA_WIDTH-1:0]d_out;
parameterized_fifo #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))uut(clk,rst,wr_en,rd_en,data_in,full,empty,d_out);
initial begin
$monitor("Time=%0t | clk=%b rst=%b wr_en=%b rd_en=%b data_in=%d uut.count=%d full=%b empty=%b d_out=%d",$time,clk,rst,wr_en,rd_en,data_in,uut.count,full,empty,d_out);
{clk,rst,wr_en,rd_en,data_in}=0;
rst=1;
#10 rst=0;
#10 wr_en=1; data_in=8'd9;
#10 data_in=8'd8;
#10 data_in=8'd7;
#10 data_in=8'd5;
#10 data_in=8'd6;
#10 data_in=8'd2;
#10 data_in=8'd3;
#10 data_in=8'd10;
#10 wr_en=0;
#10 rd_en=1;
#90 rd_en=0;
#10 $finish;
end
always #5 clk=~clk;
endmodule
