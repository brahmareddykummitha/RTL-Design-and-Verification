module wr_ptr_handler #(parameter ADDR_WIDTH=3)(
    input wclk,
    input wrst_n,
    input w_en,
    input [ADDR_WIDTH:0]g_rptr_sync,
    output reg[ADDR_WIDTH:0]b_wptr,
    output reg[ADDR_WIDTH:0]g_wptr,
    output reg full
    );
    wire [ADDR_WIDTH:0]b_wptr_next;
    wire [ADDR_WIDTH:0]g_wptr_next;
    assign b_wptr_next=b_wptr+(w_en &&!full);
    assign g_wptr_next=(b_wptr_next>>1)^b_wptr_next;
    always@(posedge wclk or posedge wrst_n)begin
    if(wrst_n)begin
        b_wptr<=0;
        g_wptr<=0;
    end
    else begin
        b_wptr<=b_wptr_next;
        g_wptr<=g_wptr_next;
   end
   end
   always@(posedge wclk or posedge wrst_n)begin
   if(wrst_n)
        full<=1'b0;
   else if(g_wptr_next=={~g_rptr_sync[ADDR_WIDTH:ADDR_WIDTH-1],g_rptr_sync[ADDR_WIDTH-2:0]})
        full<=1'b1;
   else
        full<=1'b0;
   end
endmodule