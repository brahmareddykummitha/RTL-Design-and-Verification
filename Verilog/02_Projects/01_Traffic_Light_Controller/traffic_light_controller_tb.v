module traffic_light_controller_tb;
    reg clk,rst;
    wire nr,ny,ng,er,ey,eg,sr,sy,sg,wr,wy,wg;
    traffic_light_controller uut(clk,rst,nr,ny,ng,er,ey,eg,sr,sy,sg,wr,wy,wg);
    initial begin
    $monitor("Time=%0t clk=%b rst=%b nr=%b ny=%b ng=%b er=%b ey=%b eg=%b sr=%b sy=%b sg=%b wr=%b wy=%b wg=%b",$time,clk,rst,nr,ny,ng,er,ey,eg,sr,sy,sg,wr,wy,wg);
    {clk,rst}=0;
    rst=1;
    #10 rst=0;
    #600 $finish;
    end
    always #5clk=~clk;
endmodule