module sync_read_to_write #(parameter ADDR_WIDTH=3)(
    input wclk,
    input wrst_n,
    input [ADDR_WIDTH:0]g_rptr,
    output reg [ADDR_WIDTH:0]g_rptr_sync
    );
    reg [ADDR_WIDTH:0]sync_ff1;
    always@(posedge wclk or posedge wrst_n)begin
    if(wrst_n)begin
        sync_ff1<=0;
        g_rptr_sync<=0;
   end else begin 
        sync_ff1<=g_rptr;
        g_rptr_sync<=sync_ff1;
   end
   end
endmodule