// ============================================================================
// File Name    : Multiplier_tb.v
// Description  : Testbench for parameterized N-bit multiplier (Verilog-2001)
// Author       : ChatGPT
// Standard     : IEEE 1364-2001 (Compatible with Vivado 2019)
// ============================================================================

`timescale 1ns / 1ps

module Multiplier_tb;

    // ------------------------------------------------
    // Parameter and DUT signals
    // ------------------------------------------------
    parameter N = 4;

    reg  [N-1:0] A;
    reg  [N-1:0] B;
    wire [2*N-1:0] Sum;

    // Device Under Test
    Multiplier #(.N(N)) dut (
        .A(A),
        .B(B),
        .Sum(Sum)
    );

    // ------------------------------------------------
    // Simulation control variables
    // ------------------------------------------------
    integer i, j;
    reg [2*N-1:0] expected;
    integer error_count;

    // ------------------------------------------------
    // Test process
    // ------------------------------------------------
    initial begin
        $display("=================================");
        $display(" Verilog-2001 Multiplier Test ");
        $display(" Parameter N = %0d", N);
        $display("=================================");

        error_count = 0;

        // Iterate all combinations of A and B
        for (i = 0; i < (1 << N); i = i + 1) begin
            for (j = 0; j < (1 << N); j = j + 1) begin
                A = i;
                B = j;
                #1; // small simulation delay for Sum to settle
                expected = i * j;

                if (Sum !== expected) begin
                    $display("FAIL: A=%0d, B=%0d, Expected=%0d, Got=%0d", A, B, expected, Sum);
                    error_count = error_count + 1;
                end
            end
        end

        if (error_count == 0)
            $display("All tests PASSED for N=%0d", N);
        else
            $display("Total %0d mismatches detected.", error_count);

        $display("=================================");
        $finish;
    end

endmodule
