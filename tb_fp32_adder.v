`timescale 1ns / 1ps

module tb_fp32_adder;
    // Inputs
    reg [31:0] a;
    reg [31:0] b;
    // Outputs
    wire [31:0] result;
    // Expected result
    reg [31:0] expected;

    // Instantiate the Unit Under Test (UUT)
    fp32_adder uut (
        .a(a),
        .b(b),
        .result(result)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        a = 0;
        b = 0;
        expected = 0;

        // Wait for global reset
        #10;
        $display("Time | a (hex)    | b (hex)    | result (hex) | Expected (hex) | Status");
        $display("---------------------------------------------------------------");

        // Test Case 1: Normal addition (1.0 + 2.0 = 3.0)
        a = 32'h3F800000; b = 32'h40000000; expected = 32'h40400000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 2: NaN handling (NaN + 1.0 = NaN)
        a = 32'h7FC00000; b = 32'h3F800000; expected = 32'h7FC00000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 3: Infinity handling (+inf + 1.0 = +inf)
        a = 32'h7F800000; b = 32'h3F800000; expected = 32'h7F800000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 4: 3.0 + 3.0 = 6.0
        a = 32'h40400000; b = 32'h40400000; expected = 32'h40C00000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 5: 0.5 + 0.5 = 1.0
        a = 32'h3F000000; b = 32'h3F000000; expected = 32'h3F800000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 6: 1.0 + (-1.0) = 0.0
        a = 32'h3F800000; b = 32'hBF800000; expected = 32'h00000000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 7: 2.0 + (-2.0) = 0.0
        a = 32'h40000000; b = 32'hC0000000; expected = 32'h00000000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 8: 1.0 + 0.5 = 1.5
        a = 32'h3F800000; b = 32'h3F000000; expected = 32'h3FC00000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 9: 1.0 + 0.75 = 1.75
        a = 32'h3F800000; b = 32'h3F400000; expected = 32'h3FE00000; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // Test Case 10: 1.0 + 0.333 = ~1.333
        a = 32'h3F800000; b = 32'h3EAAAAAB; expected = 32'h3FAAAAAB; #10;
        $display("%0t | %h | %h | %h | %h | %s", $time, a, b, result, expected, (result == expected) ? "Pass" : "Fail");

        // End simulation
        #10;
        $display("Simulation completed.");
        $finish;
    end
endmodule