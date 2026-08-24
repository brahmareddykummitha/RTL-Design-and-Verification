module ram_8x8_tb;
    reg clk,rst,wr_enable;
    reg [2:0] wr_addr,rd_addr;
    reg [7:0] data_in;
    wire [7:0] data_out;
    ram_8x8 uut(clk,rst,wr_enable,wr_addr,rd_addr,data_in,data_out);
    initial begin
        {clk,rst,wr_enable,wr_addr,rd_addr,data_in}=0;
        rst=1;
        #10 rst=0;
        // Write to address 2
        #10 wr_enable=1;
        #10 wr_addr=3'b010;
        #10 data_in=8'b1010_0101;
        // Read from address 2
        #10 wr_enable=0;
        #10 rd_addr=3'b010;
        // Write to address 4
        #10 wr_enable=1;
        #10 wr_addr=3'b100;
        #10 data_in=8'b0101_1111;
        // Read from address 4
        #10 wr_enable=0;
        #10 rd_addr=3'b100;
        #50 $finish;
    end
    always #5 clk=~clk;
endmodule