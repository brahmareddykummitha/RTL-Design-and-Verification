module sync_write_to_read #(parameter ADDR_WIDTH=3)(
    input rclk,
    input rrst_n,
    input [ADDR_WIDTH:0]g_wptr,
    output reg [ADDR_WIDTH:0]g_wptr_sync
    );
    reg [ADDR_WIDTH:0]sync_ff1;
    always@(posedge rclk or posedge rrst_n)begin
    if(rrst_n)begin
        sync_ff1<=0;
        g_wptr_sync<=0;
   end else begin 
        sync_ff1<=g_wptr;
        g_wptr_sync<=sync_ff1;
   end
   end
endmodule