`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2021 11:20:17 AM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input rst,                  // reset
    input clk,                  // clock
    input wr_en,                // if signal is activated, new data could be written to register file
    input [1:0] rd0_addr,       // source register number for ouputs 
    input [1:0] rd1_addr,       // source register number for ouputs 
    input [1:0] wr_addr,        // destination register number
    input signed [8:0] wr_data,        // data input, the data word that is to be written tothe register file
    output signed [7:0] rd0_data,      // data output, data word that's read from the register file
    output signed [7:0] rd1_data       // data output, data word that's read from the register file
    );
    
    reg [8:0] arrayname [3:0];  // reg [WIDTH-1:0] arrayname [0:DEPTH-1] --> widfth = 9, depth = 4
    integer i, j;
    
    assign rd0_data = arrayname[rd0_addr];
    assign rd1_data = arrayname[rd1_addr];
    
    always @ (negedge rst, posedge clk) begin
        if (rst)
            for (i = 0; i < 4; i = i + 1)
                for (j = 0; j < 9; j = j + 1)
                    arrayname[i][j] <= 0;            
        else if (wr_en)
            // new data written to register file
            arrayname[wr_addr] <= wr_data;
        end
      
endmodule



