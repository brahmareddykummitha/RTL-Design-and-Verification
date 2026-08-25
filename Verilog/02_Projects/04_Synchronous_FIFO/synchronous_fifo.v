module synchronous_fifo(
    input clk,rst,wr_en,rd_en,
    input [7:0]data_in,
    output full,empty,
    output reg [7:0]d_out
    );
    reg [2:0]wr_ptr,rd_ptr;
    reg[7:0]fifo[0:7];
    reg [3:0]count;
    integer i;
    always@(posedge clk or posedge rst)begin
    if(rst)begin
        wr_ptr<=0;
        rd_ptr<=0;
        d_out<=0;
        count<=0;
        for(i=0;i<8;i=i+1)
            fifo[i]<=8'b0;
    end
    else begin
    if(wr_en && ~full)begin
        fifo[wr_ptr]<=data_in;
        wr_ptr<=wr_ptr+1;
    end
    if(rd_en && ~empty)begin
        d_out<=fifo[rd_ptr];
        rd_ptr<=rd_ptr+1;
   end
   case({wr_en && ~full,rd_en && ~empty})
   2'b10:count<=count+1;
   2'b01:count<=count-1;
   2'b11:count<=count;
   2'b00:count<=count;
   endcase
   end
   end
   assign full=(count==8);
   assign empty=(count==0);
   endmodule