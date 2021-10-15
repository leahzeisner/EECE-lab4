`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2021 12:35:50 PM
// Design Name: 
// Module Name: alu_regfile
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


module alu_regfile(
    input rst,                  // reset
    input clk,                  // clock
    input RegWrite,                // if signal is activated, new data could be written to register file
    input [1:0] ReadAddr1,       // source register number for ouputs 
    input [1:0] ReadAddr2,       // source register number for ouputs 
    input [1:0] WriteAddr,        // destination register number
    input signed [8:0] WriteData,        // data input, the data word that is to be written to the register file
    output signed [7:0] ReadData1, 
    output signed [7:0] ReadData2,
    input [7:0] Instr_i,
    input  ALUSrc1,
    input  ALUSrc2,
    output signed [7:0] input1, 
    output signed [7:0] input2,
    input [2:0] ALUOp,
    output signed [7:0] result,
    output ovf,
    output take_branch 
    );
    
    reg [7:0] zero = 8'b0; 
       
    reg_file regfile1(rst, clk, RegWrite, ReadAddr1, ReadAddr2, WriteAddr, WriteData, ReadData1, ReadData2); 
                      
    //mux mux1(ReadData1, zero, ALUSrc1, input1);
    //mux mux2(ReadData2, Instr_i, ALUSrc2, input2);
    
    assign input1 = ALUSrc1 ? zero : ReadData1;
    assign input2 = ALUSrc2 ? Instr_i : ReadData2;
    
    eightbit_alu alu(input1, input2, ALUOp, result, ovf, take_branch); 
endmodule




















