module synchronous_fifo_tb;
reg clk,rst,wr_en,rd_en;
reg [7:0]data_in;
wire full,empty;
wire [7:0]data_out;
synchronous_fifo uut(clk,rst,wr_en,rd_en,data_in,full,empty,data_out);
initial begin
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
#70 rd_en=0;
#20$finish;
end
always #5clk=~clk;
endmodule