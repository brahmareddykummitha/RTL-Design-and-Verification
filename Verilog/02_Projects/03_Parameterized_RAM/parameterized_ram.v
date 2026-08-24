module parameterized_ram_8x8 #(parameter DATA_WIDTH=8 , ADDR_WIDTH=3)(
        input clk,rst,
        input wr_en,
        input [DATA_WIDTH-1:0]data_in,
        input [ADDR_WIDTH-1:0]wr_addr,rd_addr,
        output reg[DATA_WIDTH-1:0]d_out
    );
    reg[DATA_WIDTH-1:0]mem[0:(1<<ADDR_WIDTH)-1];
    integer i;
    always@(posedge clk or posedge rst)begin
    if(rst) begin
        d_out<=0;
        for(i=0;i<(1<<ADDR_WIDTH);i=i+1)
            mem[i]<={DATA_WIDTH{1'b0}};
   end
    else if(wr_en)begin
            mem[wr_addr]<=data_in;
   end
   else 
           d_out<=mem[rd_addr];
  end
endmodule