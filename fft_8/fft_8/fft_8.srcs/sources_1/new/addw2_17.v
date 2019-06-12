`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/11 11:36:30
// Design Name: 
// Module Name: addw2_17
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

module addw2_17(a,b,Rout,Iout); 
input[16:0] a,b; 
output[17:0] Rout,Iout; 
reg[17:0] Rout,Iout; 
wire[17:0] a1={a[16],a[16:0]}; 
wire[17:0] b1={b[16],b[16:0]}; 
always @(a1 or b1) 
begin 
 Rout = a1; 
 Iout = 18'b0-b1; 
end 
endmodule
