module ram_8x8(
    input clk,rst,wr_enable,
    input [2:0]wr_addr,rd_addr,
    input [7:0]data_in,
    output reg[7:0]data_out
    );
    reg [7:0]mem[0:7];
    integer i;
    always @(posedge clk or posedge rst)begin
    if(rst) begin
        data_out<=8'b0;
        for(i=0;i<8;i=i+1)
            mem[i]<=8'b0;
   end
   else if(wr_enable)begin
            mem[wr_addr]<=data_in;
   end
   else
            data_out<=mem[rd_addr];
  end
endmodule