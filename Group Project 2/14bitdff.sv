`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 05:11:04 PM
// Design Name: 
// Module Name: 4bitdff
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


module fourteenbitdff(
    input [13:0] D,
    input clk,
    input enter,
    input clr,
    input set,
    output logic [13:0] Q
    );
    
    always_ff @ (posedge clk)
    begin 
    if (clr)
        Q<=14'b00000000000000;
    else if (set)
        Q<=14'b11111111111111;
    else if (enter)
        Q<=D;
    end
endmodule
