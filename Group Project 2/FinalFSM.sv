`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 01:54:33 PM
// Design Name: 
// Module Name: FinalFSM
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


module FSM(
    input RESET,
    input ENTER,
    input win,
    input CLK,
    output logic disp_score,
    output logic sseg_mode,
    output logic newround
    );
    
    typedef enum {score,turn1,turn2,turn3,turn4,coolcrap}STATES;
    STATES PS,NS;
    
    always_ff @ (posedge CLK) // on every posedge of CLK
    begin
        if(RESET)
        begin
            PS <= score;
        end
        else
        begin
            PS <= NS;
        end
    end
    
    always_comb
    begin
    case(PS)
        score:
        begin
            disp_score = 1;
            sseg_mode = 0;
            newround = 1;
            if (ENTER)
            begin
                NS = turn1;
            end
            else
            begin
                NS = score;
            end
        end
        turn1:
        begin
            disp_score = 0;
            sseg_mode = 0;
            newround = 0;
            if(ENTER)
            begin
                if(win)
                begin
                    NS = coolcrap;
                end
                else
                begin
                    NS = turn2;
                end
            end
            else
            begin
                NS = turn1;
            end
        end
        turn2:
        begin
            disp_score = 0;
            sseg_mode = 0;
            newround = 0;
            if(ENTER)
            begin
                if(win) NS = coolcrap;
                else NS = turn3;
            end
            else
            begin
                NS = turn2;
            end
        end
        turn3:
        begin
            disp_score = 0;
            sseg_mode = 0;
            newround = 0;
            if(ENTER)
            begin
                if(win)NS = coolcrap;
                else NS = turn4;
            end
            else
            begin
                NS = turn3;
            end
        end
        turn4:
        begin
            disp_score = 0;
            sseg_mode = 0;
            newround = 0;
            if(ENTER) NS = coolcrap;
            else NS = turn4;
        end
        coolcrap:
        begin
            if(ENTER) NS = score;
            else NS = coolcrap;
            disp_score = 0;
            sseg_mode = 1;
            newround = 0;
        end
        default:
        begin
            NS = score;
        end
    endcase
    end
endmodule
