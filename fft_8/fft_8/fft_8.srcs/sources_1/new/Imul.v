`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/11 11:50:51
// Design Name: 
// Module Name: Imul
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


module Imul(
    p,
    Ra_in,
    Ia_in,
    Rb_in,
    Ib_in,
    Rc_out,
    Ic_out,
    Rd_out,
    Id_out
    );
    input [1:0]p;
    input [17:0] Ra_in,Ia_in,Rb_in,Ib_in;
    
    output [31:0]Rc_out,Ic_out;
    reg[31:0] Rc_out,Ic_out; 
    
    output[31:0] Rd_out,Id_out; 
    reg[31:0] Rd_out,Id_out; 
    
    wire[18:0] Rb_in1={Rb_in[17],Rb_in[17:0]}; 
    wire[18:0] Ib_in1={Ib_in[17],Ib_in[17:0]};
    
    reg[10:0] cosaddsin,cossubsin,sin; 
    
    always @(p) 
    begin 
        case(p) 
            2'd0:
                begin 
                    cosaddsin = 11'd512;
                    cossubsin = 11'd512;
                    sin = 11'd0;
                end 
            2'd1:
                begin 
                    cosaddsin = 11'd724;
                    cossubsin = 11'd0;
                    sin= 11'd362;
                end 
            2'd2:
                begin 
                    cosaddsin = 11'd512;
                    cossubsin = 11'h600;
                    sin = 11'd512;
                end 
            2'd3:
                begin 
                    cosaddsin = 11'd0;
                    cossubsin = 11'h52c;
                    sin= 11'd362;
                end 
        endcase 
    end 
    
    
    wire[18:0] IR=Ib_in1-Rb_in1; 
    wire[29:0] R_sin; 
    
  
    mult19_11 mult19_11( 
                        .dataa(IR), 
                        .datab(sin), 
                        .result(R_sin)
    ); 
    
    wire[28:0] R_cosaddsin; 
    
    mult18_11 mult18_11A( 
                        .dataa(Rb_in), 
                        .datab(cosaddsin), 
                        .result(R_cosaddsin)
    );
     
     
    reg[30:0] R_Ra; 
    
    always @(Ra_in) 
    begin 
        if(Ra_in[17] == 1'b1) 
        begin 
            R_Ra = {4'hf,~{~Ra_in[17:0]+18'b1,9'b0}+27'b1};
        end 
        else 
        begin 
            R_Ra = {4'b0,Ra_in[17:0],9'b0}; 
        end 
    end 
    
    wire[30:0] R_cosaddsin1={R_cosaddsin[28],R_cosaddsin[28],R_cosaddsin[28:0]}; 
    reg[30:0] RRc; 
    
    always @(R_Ra or R_cosaddsin1) 
    begin 
        RRc = R_Ra+R_cosaddsin1; 
    end 
    
    wire[31:0] R_sin1={R_sin[29],R_sin[29],R_sin[29:0]}; 
    wire[31:0] RRc1={RRc[30],RRc[30:0]}; 
    
    always @(R_sin1 or RRc1) 
    begin 
        Rc_out = R_sin1+RRc1; 
    end 
    //*********************************************************** 
    
    wire[28:0] R_cossubsin; 
    mult18_11 mult18_11B( 
                        .dataa(Ib_in), 
                        .datab(cossubsin), 
                        .result(R_cossubsin)
    ); 
    
    reg[30:0] R_Ia; 
    
    always @(Ia_in) 
    begin 
        if(Ia_in[17] == 1'b1) 
        begin 
            R_Ia = {4'hf,~{~Ia_in[17:0]+18'b1,9'b0}+27'b1}; 
        end 
        else 
        begin 
            R_Ia = {4'b0,Ia_in[17:0],9'b0}; 
        end 
    end 
    
    wire[30:0] R_cossubsin1={R_cossubsin[28],R_cossubsin[28],R_cossubsin[28:0]}; 
    reg[30:0] RIc; 
    
    always @(R_Ia or R_cossubsin1) 
    begin
        RIc = R_Ia+R_cossubsin1; 
    end 
    
    wire[31:0] RIc1={RIc[30],RIc[30:0]}; 
    
    always @(R_sin1 or RIc1) 
    begin 
        Ic_out = R_sin1+RIc1; 
    end 
   
   reg[30:0] RRd; 
   
   always @(R_Ra or R_cosaddsin1) 
   begin 
        RRd = R_Ra-R_cosaddsin1; 
   end 
   
   wire[31:0] RRd1={RRd[30],RRd[30:0]}; 
   always @(R_sin1 or RRd1) 
   begin 
        Rd_out = RRd1-R_sin1; 
   end 
   
   reg[30:0] RId; 
   
   always @(R_Ia or R_cossubsin1) 
   begin 
        RId = R_Ia-R_cossubsin1; 
   end 
   
   wire[31:0] RId1={RId[30],RId[30:0]}; 
   always @(R_sin1 or RId1) 
   begin 
        Id_out = RId1-R_sin1; 
   end
endmodule
