module asynchronous_top_module #(parameter DATA_WIDTH=8 ,parameter ADDR_WIDTH=3)(
    input wclk,
    input rclk,
    input wrst_n,
    input rrst_n,
    input w_en,
    input r_en,
    input [DATA_WIDTH-1:0]data_in,
    output [DATA_WIDTH-1:0]data_out,
    output full,empty
    );
    wire [ADDR_WIDTH:0] b_wptr;
    wire [ADDR_WIDTH:0] g_wptr;
    wire [ADDR_WIDTH:0] b_rptr;
    wire [ADDR_WIDTH:0] g_rptr;
    wire [ADDR_WIDTH:0] g_wptr_sync;
    wire [ADDR_WIDTH:0] g_rptr_sync;
    wire [ADDR_WIDTH-1:0] waddr;
    wire [ADDR_WIDTH-1:0] raddr;
    assign waddr = b_wptr[ADDR_WIDTH-1:0];
    assign raddr = b_rptr[ADDR_WIDTH-1:0];
    wr_ptr_handler #(.ADDR_WIDTH(ADDR_WIDTH)) uut(.wclk(wclk),.wrst_n(wrst_n),.w_en(w_en),.g_rptr_sync(g_rptr_sync),.b_wptr(b_wptr),.g_wptr(g_wptr),.full(full));
    rd_ptr_handler #(.ADDR_WIDTH(ADDR_WIDTH))uut1(.rclk(rclk),.rrst_n(rrst_n),.r_en(r_en),.g_wptr_sync(g_wptr_sync),.b_rptr(b_rptr),.g_rptr(g_rptr),.empty(empty));
    sync_write_to_read #(.ADDR_WIDTH(ADDR_WIDTH))uut2(.rclk(rclk),.rrst_n(rrst_n),.g_wptr(g_wptr),.g_wptr_sync(g_wptr_sync));
    sync_read_to_write #(.ADDR_WIDTH(ADDR_WIDTH))uut3(.wclk(wclk),.wrst_n(wrst_n),.g_rptr(g_rptr),.g_rptr_sync(g_rptr_sync));
    fifo_mem #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH))uut4(.wclk(wclk),.wrst_n(wrst_n),.w_en(w_en),.data_in(data_in),.data_out(data_out),.rclk(rclk),.rrst_n(rrst_n),.r_en(r_en),.waddr(waddr),.raddr(raddr),.full(full),.empty(empty));
endmodule