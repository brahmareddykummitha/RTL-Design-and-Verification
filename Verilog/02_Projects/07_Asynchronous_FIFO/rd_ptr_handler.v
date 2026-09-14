module rd_ptr_handler #(parameter ADDR_WIDTH=3)(
    input rclk,
    input rrst_n,
    input r_en,
    input [ADDR_WIDTH:0]g_wptr_sync,
    output reg[ADDR_WIDTH:0]b_rptr,
    output reg[ADDR_WIDTH:0]g_rptr,
    output reg empty
    );
    wire [ADDR_WIDTH:0]b_rptr_next;
    wire [ADDR_WIDTH:0]g_rptr_next;
    assign b_rptr_next=b_rptr+(r_en &&!empty);
    assign g_rptr_next=(b_rptr_next>>1)^b_rptr_next;
    always@(posedge rclk or posedge rrst_n)begin
    if(rrst_n)begin
        b_rptr<=0;
        g_rptr<=0;
    end
    else begin
        b_rptr<=b_rptr_next;
        g_rptr<=g_rptr_next;
   end
   end
   always@(posedge rclk or posedge rrst_n)begin
   if(rrst_n)
        empty<=1'b1;
   else if(g_rptr_next==g_wptr_sync)
        empty<=1'b1;
   else
        empty<=1'b0;
   end
endmodule