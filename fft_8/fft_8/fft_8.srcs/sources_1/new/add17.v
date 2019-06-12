`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/11 11:35:30
// Design Name: 
// Module Name: add17
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


module add17(a,b,out); 
input[16:0] a,b; 
output[17:0] out; 
reg[17:0] out; 
wire[17:0] a1={a[16],a[16:0]}; 
wire[17:0] b1={b[16],b[16:0]}; 
always @(a1 or b1) 
begin 
 out = a1+b1; 
end 
endmodule
