`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/11 16:33:43
// Design Name: 
// Module Name: FFT
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FFT(clk, 
    rst_n, 
    data_in, 
    data_in_ready, 
    data_out_R,
    data_out_I, 
    data_out_ready 
    ); 
    //************************************************************************ 
    input clk,rst_n; 
    input[15:0] data_in; 
    input data_in_ready; 
    output[31:0] data_out_R,data_out_I; 
    output data_out_ready; 
    
    reg[31:0] data_out_R,data_out_I; 
    reg working; 
    reg data_out_ready_reg; 
    
    wire working_flag=working || data_in_ready; 
    wire data_out_ready=data_out_ready_reg; 
    
    reg[2:0] collect_cnt; 
    
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            collect_cnt<= 3'd0;
        end
        else if (working_flag==1'b0)
        begin
            collect_cnt<= 3'd0; 
        end
        else
        begin
            collect_cnt<= collect_cnt+3'b1;
        end
    end

    
    reg[15:0] x0_reg0; 
    reg[15:0] x0_reg1; 
    reg[15:0] x0_reg2; 
    reg[15:0] x0_reg3; 
    reg[15:0] x0_regn; 
    
    always @(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
        begin
            x0_reg0<= 16'b0; 
            x0_reg1<= 16'b0; 
            x0_reg2<= 16'b0;
            x0_reg3<= 16'b0; 
            x0_regn<= 16'b0;
        end
        else if(working_flag==1'b1)
        begin
            case
            begin
                
            end
        end
    end

    else if(working_flag==1'b1) 
    begin 
     case(collect_cnt) 
     3'd0:x0_reg0< = data_in; 
     3'd1:x0_reg1< = data_in; 
     3'd2:x0_reg2< = data_in; 
     3'd3:x0_reg3< = data_in; 
     default:x0_regn< = data_in; 
     endcase 
    end
    
     
   
    //Level 1 
    reg[16:0] x1_reg0; 
    reg[16:0] x1_reg1; 
    reg[16:0] x1_reg2; 
    reg[16:0] x1_reg3; 
    reg[16:0] x1_reg4; 
    reg[16:0] x1_reg5; 
    reg[16:0] x1_reg6; 
    reg[16:0] x1_reg7; 
    reg[15:0] x0add_a,x0add_b; 
    wire[16:0] x0add_out; 
    add16 add16(.a(x0add_a),.b(x0add_b),.out(x0add_out)); 
    reg[15:0] x0sub_a,x0sub_b; 
    wire[16:0] x0sub_out; 
    sub16 sub16(.a(x0sub_a),.b(x0sub_b),.out(x0sub_out)); 
    always @(collect_cnt or x0_reg0 or x0_reg1 or x0_reg2 or x0_reg3 or x0_regn) 
    begin 
     case(collect_cnt) 
     3'd5:begin 
     x0add_a< = x0_reg0; 
     x0add_b< = x0_regn; 
     x0sub_a< = x0_reg0; 
     x0sub_b< = x0_regn; 
     end 
     3'd6:begin 
     x0add_a< = x0_reg1; 
     x0add_b< = x0_regn;
     x0sub_a< = x0_reg1; 
      x0sub_b< = x0_regn; 
      end 
      3'd7:begin 
      x0add_a< = x0_reg2; 
      x0add_b< = x0_regn; 
      x0sub_a< = x0_reg2; 
      x0sub_b< = x0_regn; 
      end 
      3'd0:begin 
      x0add_a< = x0_reg3; 
      x0add_b< = x0_regn; 
      x0sub_a< = x0_reg3; 
      x0sub_b< = x0_regn; 
      end 
      default:begin 
      x0add_a< = 16'b0; 
      x0add_b< = 16'b0; 
      x0sub_a< = 16'b0; 
      x0sub_b< = 16'b0; 
      x0add_a< = 16'b0; 
      x0add_b< = 16'b0; 
      x0sub_a< = 16'b0; 
      x0sub_b< = 16'b0; 
      end 
      endcase 
     end 
     always @(posedge clk or negedge rst_n) 
     if(!rst_n) 
     begin 
      x1_reg0< = 17'b0; 
      x1_reg1< = 17'b0; 
      x1_reg2< = 17'b0; 
      x1_reg3< = 17'b0; 
      x1_reg4< = 17'b0; 
      x1_reg5< = 17'b0; 
      x1_reg6< = 17'b0; 
      x1_reg7< = 17'b0; 
     end 
     else 
     begin 
      case(collect_cnt) 
      3'd5:begin
       x1_reg0< = x0add_out; 
      x1_reg4< = x0sub_out; 
      end 
      3'd6:begin 
      x1_reg1< = x0add_out; 
      x1_reg5< = x0sub_out; 
      end 
      3'd7:begin 
      x1_reg2< = x0add_out; 
      x1_reg6< = x0sub_out; 
      end 
      3'd0:begin 
      x1_reg3< = x0add_out; 
      x1_reg7< = x0sub_out; 
      end 
      default:; 
      endcase 
     end 
     //************************************************************************ 
     //Level 2 
     reg[17:0] x2_reg0; 
     reg[17:0] x2_reg1; 
     reg[17:0] x2_reg2; 
     reg[17:0] x2_reg3; 
     reg[17:0] x2_reg4_R,x2_reg4_I; 
     reg[17:0] x2_reg5_R,x2_reg5_I; 
     reg[17:0] x2_reg6_R,x2_reg6_I; 
     reg[17:0] x2_reg7_R,x2_reg7_I; 
     reg[16:0] x1add_a,x1add_b; 
     wire[17:0] x1add_out; 
     add17 add17(.a(x1add_a),.b(x1add_b),.out(x1add_out)); 
     reg[16:0] x1sub_a,x1sub_b; 
     wire[17:0] x1sub_out; 
     sub17 sub17(.a(x1sub_a),.b(x1sub_b),.out(x1sub_out)); 
     reg[16:0] x1addw2_a,x1addw2_b; 
     wire[17:0] x1addw2_Rout,x1addw2_Iout; 
     addw2_17 
     addw2_17(.a(x1addw2_a),.b(x1addw2_b),.Rout(x1addw2_Rout),.Iout(x1addw2_Iout)); 
     reg[16:0] x1subw2_a,x1subw2_b; 
     wire[17:0] x1subw2_Rout,x1subw2_Iout;
     subw2_17 subw2_17(.a(x1subw2_a),.b(x1subw2_b),.Rout(x1subw2_Rout),.Iout(x1subw2_Iout)); 
     always @(collect_cnt or x1_reg0 or x1_reg1 or x1_reg2 or x1_reg3 or x1_reg4 or x1_reg5 or 
     x1_reg6 or x1_reg7) 
     begin 
      case(collect_cnt) 
      3'd0:begin 
      x1add_a< = x1_reg0; 
      x1add_b< = x1_reg2; 
      x1sub_a< = x1_reg0; 
      x1sub_b< = x1_reg2; 
      x1addw2_a< = 17'b0; 
      x1addw2_b< = 17'b0; 
      x1subw2_a< = 17'b0; 
      x1subw2_b< = 17'b0; 
      end 
      3'd1:begin 
      x1addw2_a< = x1_reg4; 
      x1addw2_b< = x1_reg6; 
      x1subw2_a< = x1_reg4; 
      x1subw2_b< = x1_reg6; 
      x1add_a< = 17'b0; 
      x1add_b< = 17'b0; 
      x1sub_a< = 17'b0; 
      x1sub_b< = 17'b0; 
      end 
      3'd2:begin 
      x1add_a< = x1_reg1; 
      x1add_b< = x1_reg3; 
      x1sub_a< = x1_reg1; 
      x1sub_b< = x1_reg3; 
      x1addw2_a< = 17'b0; 
      x1addw2_b< = 17'b0; 
      x1subw2_a< = 17'b0; 
      x1subw2_b< = 17'b0; 
      end 
      3'd3:begin 
      x1addw2_a< = x1_reg5; 
      x1addw2_b< = x1_reg7; 
      x1subw2_a< = x1_reg5; 
      x1subw2_b< = x1_reg7;
      x1add_a< = 17'b0; 
       x1add_b< = 17'b0; 
       x1sub_a< = 17'b0; 
       x1sub_b< = 17'b0; 
       end 
       default:begin 
       x1add_a< = 17'b0; 
       x1add_b< = 17'b0; 
       x1sub_a< = 17'b0; 
       x1sub_b< = 17'b0; 
       x1addw2_a< = 17'b0; 
       x1addw2_b< = 17'b0; 
       x1subw2_a< = 17'b0; 
       x1subw2_b< = 17'b0; 
       end 
       endcase 
      end 
      always @(posedge clk or negedge rst_n) 
      if(!rst_n) 
      begin 
       x2_reg0< = 18'b0; 
       x2_reg1< = 18'b0; 
       x2_reg2< = 18'b0; 
       x2_reg3< = 18'b0; 
       x2_reg4_R< = 18'b0; 
       x2_reg5_R< = 18'b0; 
       x2_reg6_R< = 18'b0; 
       x2_reg7_R< = 18'b0; 
       x2_reg4_I< = 18'b0; 
       x2_reg5_I< = 18'b0; 
       x2_reg6_I< = 18'b0; 
       x2_reg7_I< = 18'b0; 
      end 
      else 
      begin 
       case(collect_cnt) 
       3'd0:begin 
       x2_reg0< = x1add_out; 
       x2_reg2< = x1sub_out; 
       end 
       3'd1:begin 
       x2_reg4_R< = x1addw2_Rout;
       x2_reg4_I< = x1addw2_Iout; 
        x2_reg6_R< = x1subw2_Rout; 
        x2_reg6_I< = x1subw2_Iout; 
        end 
        3'd2:begin 
        x2_reg1< = x1add_out; 
        x2_reg3< = x1sub_out; 
        end 
        3'd3:begin 
        x2_reg5_R< = x1addw2_Rout; 
        x2_reg5_I< = x1addw2_Iout; 
        x2_reg7_R< = x1subw2_Rout; 
        x2_reg7_I< = x1subw2_Iout; 
        end 
        default:; 
        endcase 
       end 
       //************************************************************************ 
       //Level 3 
       reg[1:0] Imul_p; 
       reg[17:0] Imul_Ra,Imul_Ia,Imul_Rb,Imul_Ib; 
       wire[31:0] Imulc_Rout,Imulc_Iout; 
       wire[31:0] Imuld_Rout,Imuld_Iout; 
       Imul Imul(.p(Imul_p), 
        .Ra_in(Imul_Ra),.Ia_in(Imul_Ia), 
       .Rb_in(Imul_Rb),.Ib_in(Imul_Ib), 
        .Rc_out(Imulc_Rout),.Ic_out(Imulc_Iout), 
        .Rd_out(Imuld_Rout),.Id_out(Imuld_Iout) 
       ); 
       always @(collect_cnt or x2_reg0 or x2_reg1 or x2_reg2 or x2_reg3 
        or x2_reg4_R or x2_reg4_I or x2_reg5_R or x2_reg5_I 
        or x2_reg6_R or x2_reg6_I or x2_reg7_R or x2_reg7_I) 
       begin 
        case(collect_cnt) 
        3'd4:begin//7 
        Imul_Ra< = x2_reg0; 
        Imul_Ia< = 18'b0; 
        Imul_Rb< = x2_reg1; 
        Imul_Ib< = 18'b0; 
        Imul_p< = 2'd0; 
        end 
        3'd5:begin//4
         Imul_Ra< = x2_reg2; 
        Imul_Ia< = 18'b0; 
        Imul_Rb< = x2_reg3; 
        Imul_Ib< = 18'b0; 
        Imul_p< = 2'd2; 
        end 
        3'd6:begin//6 
        Imul_Ra< = x2_reg4_R; 
        Imul_Ia< = x2_reg4_I; 
        Imul_Rb< = x2_reg5_R; 
        Imul_Ib< = x2_reg5_I; 
        Imul_p< = 2'd1; 
        end 
        3'd7:begin//5 
        Imul_Ra< = x2_reg6_R; 
        Imul_Ia< = x2_reg6_I; 
        Imul_Rb< = x2_reg7_R; 
        Imul_Ib< = x2_reg7_I; 
        Imul_p< = 2'd3; 
        end 
        default:begin 
        Imul_Ra< = 18'b0; 
        Imul_Ia< = 18'b0; 
        Imul_Rb< = 18'b0; 
        Imul_Ib< = 18'b0; 
        Imul_p< = 2'd0; 
        end 
        endcase 
       end 
       reg[31:0] out_reg0_R,out_reg0_I; 
       reg[31:0] out_reg1_R,out_reg1_I; 
       reg[31:0] out_reg2_R,out_reg2_I; 
       reg[31:0] out_reg3_R,out_reg3_I; 
       reg[31:0] out_reg4_R,out_reg4_I; 
       reg[31:0] out_reg5_R,out_reg5_I; 
       reg[31:0] out_reg6_R,out_reg6_I; 
       reg[31:0] out_reg7_R,out_reg7_I; 
       always @(posedge clk or negedge rst_n)
       if(!rst_n) 
       begin 
        out_reg0_R< = 32'b0; 
        out_reg0_I< = 32'b0; 
        out_reg1_R< = 32'b0; 
        out_reg1_I< = 32'b0; 
        out_reg2_R< = 32'b0; 
        out_reg2_I< = 32'b0; 
        out_reg3_R< = 32'b0; 
        out_reg3_I< = 32'b0; 
        out_reg4_R< = 32'b0; 
        out_reg4_I< = 32'b0; 
        out_reg5_R< = 32'b0; 
        out_reg5_I< = 32'b0; 
        out_reg6_R< = 32'b0; 
        out_reg6_I< = 32'b0; 
        out_reg7_R< = 32'b0; 
        out_reg7_I< = 32'b0; 
       end 
       else 
       begin 
        case(collect_cnt) 
        3'd4:begin//0 
        out_reg0_R< = Imulc_Rout; 
        out_reg0_I< = Imulc_Iout; 
        out_reg4_R< = Imuld_Rout; 
        out_reg4_I< = Imuld_Iout; 
        end 
        3'd5:begin//4 
        out_reg2_R< = Imulc_Rout; 
        out_reg2_I< = Imulc_Iout; 
        out_reg6_R< = Imuld_Rout; 
        out_reg6_I< = Imuld_Iout; 
        end 
        3'd6:begin//2 
        out_reg1_R< = Imulc_Rout; 
        out_reg1_I< = Imulc_Iout; 
        out_reg5_R< = Imuld_Rout; 
        out_reg5_I< = Imuld_Iout; 
        end 
        3'd7:begin//6 
        out_reg3_R< = Imulc_Rout; 
        out_reg3_I< = Imulc_Iout; 
        out_reg7_R< = Imuld_Rout; 
        out_reg7_I< = Imuld_Iout; 
        end 
        default; 
        endcase 
       end 
       always @(posedge clk or negedge rst_n) 
       if(!rst_n) 
       begin 
        data_out_R< = 32'b0; 
        data_out_I< = 32'b0; 
       end 
       else 
       begin 
        case(collect_cnt) 
        3'd6:begin//4 
        data_out_R< = out_reg0_R; 
        data_out_I< = out_reg0_I; 
        end 
        3'd7:begin//2 
        data_out_R< = out_reg1_R; 
        data_out_I< = out_reg1_I; 
        end 
        3'd0:begin//6 
        data_out_R< = out_reg2_R; 
        data_out_I< = out_reg2_I; 
        end 
        3'd1:begin//1 
        data_out_R< = out_reg3_R; 
        data_out_I< = out_reg3_I; 
        end 
        3'd2:begin//5 
        data_out_R< = out_reg4_R; 
        data_out_I< = out_reg4_I; 
        end 
        3'd3:begin//3 
        data_out_R< = out_reg5_R; 
        data_out_I< = out_reg5_I; 
        end 
        3'd4:begin//7 
        data_out_R< = out_reg6_R; 
        data_out_I< = out_reg6_I; 
        end 
        3'd5:begin//0 
        data_out_R< = out_reg7_R; 
        data_out_I< = out_reg7_I; 
        end 
        endcase 
       end 
       //************************************************************************* 
       reg[3:0] idle_cnt; 
       reg enflag; 
       always @(posedge clk or negedge rst_n) 
       if(!rst_n) 
       begin 
        idle_cnt< = 4'd0; 
        working< = 1'b0; 
       end 
       else 
       begin 
        if(data_in_ready == 1'b1) 
        begin 
        working< = 1'b1; 
        if(collect_cnt == 3'd7) 
        idle_cnt = 4'd13; 
       else 
        idle_cnt< = 4'd12-{1'b0,collect_cnt}; 
        end 
        else 
        begin 
        if(idle_cnt == 4'd0) 
        working< = 1'b0; 
       else 
        idle_cnt< = idle_cnt-4'd1; 
        end 
       end 
       always @(posedge clk or negedge rst_n) 
       if(!rst_n) 
       begin 
        data_out_ready_reg< = 1'b0; 
        enflag< = 1'b0; 
       end 
       else 
       begin 
        if(enflag == 1'b0) 
        begin 
        if(collect_cnt == 3'd6)enflag<= 1'b1; 
        end 
        else 
        begin 
        if(collect_cnt == 3'd6)data_out_ready_reg<= 1'b1; 
        end 
        if(working_flag == 1'b0)data_out_ready_reg<= 1'b0; 
       end 
       endmodule