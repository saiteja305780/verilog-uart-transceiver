`timescale 1ns / 1ps
module baudtick #(
    parameter integer CLK_FREQ = 50_000_000,
    parameter integer BAUD_RATE = 115200
    )
    (
        input wire clk,
        input wire rst_n,
        
        output reg baud_tick
    );
    
    // Number of system-clock cycles per UART bit
    
    localparam integer BAUD_DIV =  CLK_FREQ / BAUD_RATE;
    
    reg[31:0] counter;
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            counter <= 0;       // initial condition
            baud_tick <= 1'b0;
        end
        
        else begin
            if(counter == BAUD_DIV - 1)begin
            
                counter <= 0;
                baud_tick <= 1'b1; // tick generation
            end
            
            else begin
                counter <= counter + 1'b1;
                baud_tick <= 1'b0;    // other wise incriment upto the baud div
            end
        end
     end                     
endmodule












