module asynchronous_top_module_tb;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3;
    reg wclk;
    reg rclk;
    reg wrst_n;
    reg rrst_n;
    reg w_en;
    reg r_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;
    asynchronous_top_module #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (.wclk(wclk),.rclk(rclk),.wrst_n(wrst_n),.rrst_n(rrst_n),.w_en(w_en),.r_en(r_en),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));
    initial begin
      $monitor("Time=%0t | WCLK=%b RCLK=%b | W_EN=%b R_EN=%b | DATA_IN=%h DATA_OUT=%h | FULL=%b EMPTY=%b",$time, wclk, rclk, w_en, r_en, data_in, data_out, full, empty);
      wclk=0;
      rclk=0;
      wrst_n=1;
      rrst_n=1;
      w_en=0;
      r_en=0;
      data_in=0;
      #20
      wrst_n=0;
      rrst_n=0;
      
      @(negedge wclk) w_en=1; data_in=8'h11;
      @(negedge wclk) data_in=8'h22;
      @(negedge wclk) data_in=8'h33;
      @(negedge wclk) data_in=8'h44;
      @(negedge wclk) data_in=8'h55;
      @(negedge wclk) data_in=8'h66;
      @(negedge wclk) data_in=8'h77;
      @(negedge wclk) data_in=8'h88;
      @(negedge wclk) w_en=0;
      #30;
      @(negedge rclk) r_en=1;
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk)
      @(negedge rclk) r_en=0;
      #30 $finish;
      end
    always #5 wclk=~wclk;
    always #7 rclk=~rclk;
endmodule