`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/11 11:34:56
// Design Name: 
// Module Name: sub16
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

module sub16(a,b,out); 
input[15:0] a,b; 
output[16:0] out; 
reg[16:0] out; 
wire[16:0] a1={a[15],a[15:0]}; 
wire[16:0] b1={b[15],b[15:0]}; 
always @(a1 or b1) 
begin 
 out = a1-b1; 
end 
endmodule