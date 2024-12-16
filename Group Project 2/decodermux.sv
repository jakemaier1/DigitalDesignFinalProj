`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 02:39:22 PM
// Design Name: 
// Module Name: decodermux
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


module decodermux(
    input [13:0] zero, //score
    input [13:0] one, //switch inputs
    input [13:0] two, //last turn
    input [13:0] three, //random number
    input [1:0] Sel,
    output logic [13:0] Out
    );
    always_comb begin 
    if (Sel == 2'b00) Out = zero; 
    else if (Sel == 2'b01) Out = one; 
    else if (Sel == 2'b10) Out = two; 
    else Out = three;
    end
endmodule
