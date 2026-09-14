module fifo_mem #(parameter DATA_WIDTH=8 ,parameter ADDR_WIDTH=3)(
    input wclk,
    input wrst_n,
    input w_en,
    input [DATA_WIDTH-1:0]data_in,
    input rclk,
    input rrst_n,
    input r_en,
    input [ADDR_WIDTH-1:0]waddr,
    input [ADDR_WIDTH-1:0]raddr,
    input full,empty,
    output reg[DATA_WIDTH-1:0]data_out
    );
    reg [DATA_WIDTH-1:0]mem[0:(1<<ADDR_WIDTH)-1];
    always@(posedge wclk)begin
    if(w_en && !full)
        mem[waddr]<=data_in;
    end
    always @(posedge rclk) begin
        if (rrst_n)
            data_out <= 0;
        else if (r_en && !empty)
            data_out <= mem[raddr];
    end   
endmodule