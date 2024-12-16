`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:52:53 PM
// Design Name: 
// Module Name: TOP
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


module TOP(
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [3:0] C,
    input logic [3:0] D,
    
    input logic clk,
    input logic Enter,
    input logic Reset,
    
    input logic disp_switches,
    input logic disp_random,
    input logic disp_score,

    output logic [3:0] anout,    // Output for an
    output logic [7:0] sseg_out     // Output for seven segment
);

    //define wires 

    //sseg outputs to ssegmux
    //1bit
    logic w5, w6, w7, w8, w15;
    
    logic [1:0] w9;
    logic [3:0] w10, w12;
    logic [7:0] w11, w13, w14;
    logic [13:0] w1, w2, w3, w4;
    //another thing
     
    
    univ_sseg sseg (
        .clk(clk),
        .cnt1(w4),
        .valid(1'b1),
        .dp_en(1'b0),
        .mod_sel(2'b10),
        .sign(1'b0),
        .ssegs(w11),
        .disp_en(w10)
    );
    
    Accum accm (
        .clk(clk),
        .LD(w5),
        .CLR(Reset),
        .D(8'b00000001),
        .Q(w14)
    );

    // Instantiate the 4-bit multiplexer
    mux #(8) ssegmux (
        .sel(w8),
        .in0(w11),
        .in1(w13),
        .out(sseg_out)
    );

    // Instantiate the 8-bit multiplexer
    mux #(4) anmux (
        .sel(w8),
        .in0(w10),
        .in1(w12),
        .out(anout)
    );
    
    BC_DEC bc_dec_inst (
        .CLK(clk),                      
        .Z(w5),                          
        .DISP_EN(w12),          
        .SEGMENTS(w13)         
    );
    
    octurdlecomp comp (
        .clk(clk),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .reset(Reset),
        .enter(Enter),
        .gen_rand(w6),   
        .rand_out(w3),
        .sw_out(w1),
        .win(w5),
        .disp(w2)                      
    );
    
    mux_select ms (
        .score(w15),
        .random(disp_random),
        .switches(disp_switches),
        .sel_bits(w9)                         
    );
    
    FSM mainfsm (
        .CLK(clk),
        .RESET(Reset),
        .ENTER(Enter),
        .win(w5),
        .disp_score(w7),
        .sseg_mode(w8),
        .newround(w6)                       
    );
    
    decodermux multichannelmux (
        .zero({6'b000000, w14}),
        .one(w1),
        .two(w2),
        .three(w3),
        .Sel(w9),
        .Out(w4)                         
    );
    
    assign w15 = disp_score | w7;

endmodule
