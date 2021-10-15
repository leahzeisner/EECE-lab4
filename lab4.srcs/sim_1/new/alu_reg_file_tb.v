`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 09:32:38 AM
// Design Name: 
// Module Name: alu_reg_file_tb
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


module alu_reg_file_tb();
    reg rst, clk, wr_en;              
    reg [1:0] rd0_addr, rd1_addr, wr_addr;
    reg [8:0] wr_data;    
    wire [7:0] rd0_data; 
    wire [7:0] rd1_data;  
    
    reg [7:0] Instr_i;
    reg mux_sel_1, mux_sel_2;
    wire [7:0] mux_out1;
    wire [7:0] mux_out2;
    
    reg [2:0] ALUOp;
    
    wire [7:0] f;
    wire ovf;
    wire take_branch;
    
    alu_regfile alu_reg_file1(rst, clk, wr_en, 
                              rd0_addr, rd1_addr, wr_addr, wr_data, rd0_data, rd1_data,
                              Instr_i, mux_sel_1, mux_sel_2, mux_out1, mux_out2,
                              ALUOp, f, ovf, take_branch ); 
 
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end
       
    initial begin
    
        rst = 0;
        #5 rst = 1;
        #5 rst = 0;
      
      
        // writing to / reading from register file and mux selection
        
        #10 wr_en = 1; wr_addr = 1; wr_data = 2;                        // write value 2 into register 1            
        #10 wr_en = 1; wr_addr = 2; wr_data = 1;                        // write value 1 into register 2    
        #10 wr_en = 0; rd0_addr = 1; rd1_addr = 2;                      // read values 2, 1 from registers 1, 2 respectively
        #10 mux_sel_1 = 1; mux_sel_2 = 0; Instr_i = 8'b0;               // select values 0 and 1
       
        // alu configurations --> a = 0, b = 1
        
        #10 ALUOp = 3'b000;                                             // add 0 + 1, expected 1
           
        #10 wr_en = 1; wr_addr = 1; wr_data = 127;                      // write value 127 into register 1 
        #10 wr_en = 0; rd0_addr = 1; rd1_addr = 2;                      // read values 127, 1 from registers 1, 2 respectively
        #10 mux_sel_1 = 0; mux_sel_2 = 0;                               // select values 127 and 1 --> a = 127, b = 1
        
        #10 ALUOp = 3'b000;                                             // add 127 + 1. expected -128 with ovf = 1
        #10 ALUOp = 3'b001;                                             // take inverse of 1, expected -1
        #10 ALUOp = 3'b010;                                             // 127 AND 1, expected 1
        #10 ALUOp = 3'b011;                                             // 127 OR 1, expected 127
        
        #10 wr_en = 1; wr_addr = 1; wr_data = 1;                        // write value 1 into register 1 
        #10 wr_en = 1; wr_addr = 2; wr_data = 2;                        // write value 2 into register 2  
        #10 wr_en = 0; rd0_addr = 1; rd1_addr = 2;                      // read values 1, 2 from registers 1, 2 respectively         
        #10 mux_sel_1 = 0; mux_sel_2 = 0;;                              // select values 1 and 2 --> a = 1, b = 2
        
        #10 ALUOp = 3'b100;                                             // shift 1 to the right by 1, expected 0
        #10 ALUOp = 3'b101;                                             // shift 1 to the left by 2, expected 4         
        #10 ALUOp = 3'b110;                                             // 1 == 2 ? --> expected 0 with take_branch 0
        #10 ALUOp = 3'b111;                                             // 1 != 2 ? --> expected 0 with take_branch 1
        
    end
    
    initial begin
        $monitor(
            "rd0_data: %b  rd1_data: %b  mux_out1: %b  mux_out2: %b  ALUOp: %d  f: %b  ovf: %d  take_branch: %d", 
            rd0_data, rd1_data, mux_out1, mux_out2, ALUOp, f, ovf, take_branch
        );
    end   
endmodule







