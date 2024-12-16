`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2024 06:06:04 PM
// Design Name: 
// Module Name: MUX
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


module mux #(parameter WIDTH = 1) ( // Default is 1 bit
    input  logic             sel,      
    input  logic [WIDTH-1:0] in0,      // output when select is 0
    input  logic [WIDTH-1:0] in1, 
    output logic [WIDTH-1:0] out
);
    always_comb begin
        if (sel)
            out = in1;                 
        else
            out = in0;                
    end
endmodule