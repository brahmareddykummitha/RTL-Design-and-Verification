module traffic_light_controller(
    input clk,rst,
    output reg nr,ny,ng,er,ey,eg,sr,sy,sg,wr,wy,wg
    );
    parameter N_G_S0=3'b000;
    parameter N_Y_S1=3'b001;
    parameter E_G_S2=3'b010;
    parameter E_Y_S3=3'b011;
    parameter S_G_S4=3'b100;
    parameter S_Y_S5=3'b101;
    parameter W_G_S6=3'b110;
    parameter W_Y_S7=3'b111;
    
    reg[2:0]ps,ns;
    reg[3:0]count;
    always@(posedge clk or posedge rst)begin
    if(rst)
        ps<= N_G_S0;
   else
        ps<=ns;
  end
  always@(posedge clk or posedge rst)begin
  if(rst)
    count<=4'b0000;
  else begin
  case(ps)
  N_G_S0:count<=(count==4'd9)?4'b0000:count+1'b1;
  N_Y_S1:count<=(count==4'd2)?4'b0000:count+1'b1;
  E_G_S2:count<=(count==4'd9)?4'b0000:count+1'b1;
  E_Y_S3:count<=(count==4'd2)?4'b0000:count+1'b1;
  S_G_S4:count<=(count==4'd9)?4'b0000:count+1'b1;
  S_Y_S5:count<=(count==4'd2)?4'b0000:count+1'b1;
  W_G_S6:count<=(count==4'd9)?4'b0000:count+1'b1;
  W_Y_S7:count<=(count==4'd2)?4'b0000:count+1'b1;
  default:count<=4'b0000;
  endcase
  end
  end
  always@(*)begin
  case(ps)
  N_G_S0:ns=(count==4'd9)?N_Y_S1:N_G_S0;
  N_Y_S1:ns=(count==4'd2)?E_G_S2:N_Y_S1;
  E_G_S2:ns=(count==4'd9)?E_Y_S3:E_G_S2;
  E_Y_S3:ns=(count==4'd2)?S_G_S4:E_Y_S3;
  S_G_S4:ns=(count==4'd9)?S_Y_S5:S_G_S4;
  S_Y_S5:ns=(count==4'd2)?W_G_S6:S_Y_S5;
  W_G_S6:ns=(count==4'd9)?W_Y_S7:W_G_S6;
  W_Y_S7:ns=(count==4'd2)?N_G_S0:W_Y_S7;
  default:ns=N_G_S0;
  endcase
  end
  always@(*)begin
  case(ps)
   N_G_S0:begin
        nr=0;ny=0;ng=1;
        er=1;ey=0;eg=0;
        sr=1;sy=0;sg=0;
        wr=1;wy=0;wg=0;
  end
   N_Y_S1:begin
        nr=0;ny=1;ng=0;
        er=1;ey=0;eg=0;
        sr=1;sy=0;sg=0;
        wr=1;wy=0;wg=0;
  end
  E_G_S2:begin
        nr=1;ny=0;ng=0;
        er=0;ey=0;eg=1;
        sr=1;sy=0;sg=0;
        wr=1;wy=0;wg=0;
  end
  E_Y_S3:begin
        nr=1;ny=0;ng=0;
        er=0;ey=1;eg=0;
        sr=1;sy=0;sg=0;
        wr=1;wy=0;wg=0;
 end
 S_G_S4:begin
        nr=1;ny=0;ng=0;
        er=1;ey=0;eg=0;
        sr=0;sy=0;sg=1;
        wr=1;wy=0;wg=0;
 end
 S_Y_S5:begin
        nr=1;ny=0;ng=0;
        er=1;ey=0;eg=0;
        sr=0;sy=1;sg=0;
        wr=1;wy=0;wg=0;
 end
 W_G_S6:begin
        nr=1;ny=0;ng=0;
        er=1;ey=0;eg=0;
        sr=1;sy=0;sg=0;
        wr=0;wy=0;wg=1;
end
 W_Y_S7: begin
        nr=1;ny=0;ng=0;
        er=1;ey=0;eg=0;
        sr=1;sy=0;sg=0;
        wr=0;wy=1;wg=0;
end
default : begin
        nr=1;ny=0;ng=0;
        er=1;ey=0;eg=0;
        sr=1;sy=0;sg=0;
        wr=1;wy=0;wg=0;
end
endcase
end
endmodule