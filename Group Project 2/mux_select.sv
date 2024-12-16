`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ella Reinhardt
// 
// Create Date: 12/02/2024 02:30:33 PM
// Design Name: 
// Module Name: mux_select
// Project Name: octurdle
// Target Devices: 
// Tool Versions: 
// Description: module to control priority of what is displayed on seven seg
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_select(
    input score, 
    input random,
    input switches, 
    output logic [1:0] sel_bits
    );
    
    always_comb begin
    if (random) sel_bits = 2'b11;
    else if (score) sel_bits = 2'b00;
    else if (switches) sel_bits = 2'b01;
    else sel_bits = 2'b10;
    end
endmodule
