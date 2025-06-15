`timescale 1ns / 1ps

module tb_carry_skip_adder_8bit;
    reg  [7:0] A, B;
    reg        Cin;
    wire [7:0] Sum;
    wire       Cout;

    carry_skip_adder uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $display("Time\tA\tB\tCin\tSum\tCout");
        $monitor("%0dns\t%h\t%h\t%b\t%h\t%b", $time, A, B, Cin, Sum, Cout);

        A = 8'h00; B = 8'h00; Cin = 0; #10;
        A = 8'h0F; B = 8'h01; Cin = 0; #10;
        A = 8'hF0; B = 8'h0F; Cin = 1; #10;
        A = 8'h55; B = 8'hAA; Cin = 0; #10;
        A = 8'hFF; B = 8'h01; Cin = 1; #10;

        $finish;
    end
endmodule
