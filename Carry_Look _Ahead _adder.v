`timescale 1ns / 1ps

module cla (
    input  [7:0] A,
    input  [7:0] B,
    input        Cin,
    output [7:0] Sum,
    output       Cout
);
    wire [7:0] G, P;     
    wire [8:0] C;         
    assign G = A & B;     
    assign P = A ^ B;     

    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
                 (P[3] & P[2] & P[1] & G[0]) |
                 (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign C[5] = G[4] | (P[4] & C[4]);
    assign C[6] = G[5] | (P[5] & C[5]);
    assign C[7] = G[6] | (P[6] & C[6]);
    assign C[8] = G[7] | (P[7] & C[7]);  

    assign Sum = P ^ C[7:0]; 
    assign Cout = C[8];

endmodule




