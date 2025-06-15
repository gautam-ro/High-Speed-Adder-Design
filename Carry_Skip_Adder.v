`timescale 1ns / 1ps

module carry_skip_adder (
    input  [7:0] A,
    input  [7:0] B,
    input        Cin,
    output [7:0] Sum,
    output       Cout
);
    wire [3:0] P0, P1;         
    wire       C4, C8;         
    wire [3:0] S0;
    wire       C1, C2, C3;

    assign P0[0] = A[0] ^ B[0];
    assign S0[0] = P0[0] ^ Cin;
    assign C1    = (A[0] & B[0]) | (P0[0] & Cin);

    assign P0[1] = A[1] ^ B[1];
    assign S0[1] = P0[1] ^ C1;
    assign C2    = (A[1] & B[1]) | (P0[1] & C1);

    assign P0[2] = A[2] ^ B[2];
    assign S0[2] = P0[2] ^ C2;
    assign C3    = (A[2] & B[2]) | (P0[2] & C2);

    assign P0[3] = A[3] ^ B[3];
    assign S0[3] = P0[3] ^ C3;
    assign C4    = (A[3] & B[3]) | (P0[3] & C3);

    wire P_block0 = P0[0] & P0[1] & P0[2] & P0[3];
    wire Cskip    = P_block0 ? Cin : C4;

    wire [3:0] S1;
    wire       C5, C6, C7;

    assign P1[0] = A[4] ^ B[4];
    assign S1[0] = P1[0] ^ Cskip;
    assign C5    = (A[4] & B[4]) | (P1[0] & Cskip);

    assign P1[1] = A[5] ^ B[5];
    assign S1[1] = P1[1] ^ C5;
    assign C6    = (A[5] & B[5]) | (P1[1] & C5);

    assign P1[2] = A[6] ^ B[6];
    assign S1[2] = P1[2] ^ C6;
    assign C7    = (A[6] & B[6]) | (P1[2] & C6);

    assign P1[3] = A[7] ^ B[7];
    assign S1[3] = P1[3] ^ C7;
    assign C8    = (A[7] & B[7]) | (P1[3] & C7);

    assign Sum  = {S1, S0};
    assign Cout = C8;

endmodule


