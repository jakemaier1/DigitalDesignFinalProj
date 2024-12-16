`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: California Polytechnic State University
// Engineer: Ella Reinhardt
// 
// Create Date: 11/28/2024 11:22:44 AM
// Design Name: octurdle comparator - the "brains" of our game
// Module Name: octurdlecomp
// Project Name: Octurdle
// Target Devices: 
// Tool Versions: 
// Description: the user's guess (ABCD) consists of 4 3 bit inputs, input A is "most significant guess", D is least.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module octurdlecomp(
    input [2:0] A,
    input [2:0] B,
    input [2:0] C,
    input [2:0] D,
    input reset,
    input clk,
    input enter,
    input gen_rand, 
    output [13:0] rand_out,
    output [13:0] sw_out,
    output logic win,
    output [13:0] disp
    );
    logic [11:0] random;
    logic [13:0] store_rand;
    logic [13:0] dispff_in;
    logic [3:0] dispA;
    logic [3:0] dispB;
    logic [3:0] dispC;
    logic [3:0] dispD;
    
    
    always begin 
    #10 random = $urandom();
    end    fourteenbitdff holdrandff (.D({2'b00, random[11:0]}), .clk(clk), .enter(gen_rand), .clr(reset), .Q(store_rand));
    fourteenbitdff outff (.D(dispff_in), .clk(clk), .clr(reset), .enter(enter), .Q(disp));
    
    assign sw_out = (A*1000) + (B*100) + (C*10) + D;
    assign rand_out = (store_rand[11:9]*1000) + (store_rand[8:6]*100) + (store_rand[5:3]*10) + store_rand[2:0];
    assign dispff_in = (dispA*1000) + (dispB*100) + (dispC*10) + dispD;
    
    always_comb
    begin
    win = 1'b0;
    if (D == store_rand[2:0]) dispD = {1'b0,D};
    else if (D == store_rand[11:9] || 
                D == store_rand[8:6] || 
                D == store_rand[5:3]) dispD = 4'b1000;
    else dispD = 4'b1001; 
    if (C == store_rand[5:3]) dispC = {1'b0,C};
    else if (C == store_rand[11:9] || 
                C == store_rand[8:6] || 
                C == store_rand[2:0]) dispC = 4'b1000;
    else dispC = 4'b1001; 
    if (B == store_rand[8:6]) dispB = {1'b0,B};
    else if (B == store_rand[11:9] || 
                B == store_rand[2:0] || 
                B == store_rand[5:3]) dispB = 4'b1000;
    else dispB = 4'b1001; 
    if (A == store_rand[11:9]) dispA = {1'b0,A};
    else if (A == store_rand[2:0] || 
                A == store_rand[8:6] || 
                A == store_rand[5:3]) dispA = 4'b1000;
    else dispA = 4'b1001; 
    
    if (disp == rand_out) win = 1'b1;
    else win = 1'b0;
    end
endmodule
