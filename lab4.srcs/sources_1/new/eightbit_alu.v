`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 01:44:46 PM
// Design Name: 
// Module Name: eightbit_alu
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


module eightbit_alu(
    input signed [7:0] a,
    input signed [7:0] b,
    input [2:0] sel,
    
    output reg signed [7:0] f,
    output reg ovf,
    output reg take_branch );
    
     always @ (*) begin
        case(sel)
            3'b000 : begin
                        f = a + b;
                        ovf = (a[7] && b[7] && ~f[7]) || (~a[7] && ~b[7] && f[7]);
                        take_branch = 0;
                    end
            3'b001 : begin
                        f = ~b;
                        ovf = 0;
                        take_branch = 0;
                    end
            3'b010 : begin
                        f = a & b;
                        ovf = 0;
                        take_branch = 0;
                    end
            3'b011 : begin
                        f = a | b;
                        ovf = 0;
                        take_branch = 0;
                    end
            3'b100 : begin
                        f = a[7] == 1 ? (a >>> 1) + 8'b10000000 : a >>> 1;
                        ovf = 0;
                        take_branch = 0;
                    end
            3'b101 : begin
                        f = a << b;
                        ovf = 0;
                        take_branch = 0;
                    end
            3'b110 : begin
                        f = 0;
                        ovf = 0;
                        take_branch = (a == b);
                    end  
            3'b111 : begin
                        f = 0;
                        ovf = 0;
                        take_branch = (a != b);
                    end         
            default : begin
                        f = 0;
                        ovf = 0;
                        take_branch = 0;
                      end
        endcase
    end
endmodule
