`timescale 1ns/1ps

module tb_adder_n;
    parameter n = 16; // 你可以改成 8、32、64 等
    reg  [n-1:0] A, B;
    reg          Cin;
    wire [n-1:0] Sum;
    wire         Cout;

    // 實例化待測模組
    adder_n #(n) uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        // 測試向量1
        A = {n{1'b0}}; B = {n{1'b0}}; Cin = 0;
        #10 $display("A=%h B=%h Cin=%b | Sum=%h Cout=%b", A, B, Cin, Sum, Cout);

        // 測試向量2
        A = {n{1'b1}}; B = {n{1'b0}}; Cin = 0;
        #10 $display("A=%h B=%h Cin=%b | Sum=%h Cout=%b", A, B, Cin, Sum, Cout);

        // 測試向量3
        A = {n{1'b1}}; B = {n{1'b1}}; Cin = 1;
        #10 $display("A=%h B=%h Cin=%b | Sum=%h Cout=%b", A, B, Cin, Sum, Cout);

        // 測試向量4
        A = 1; B = 1; Cin = 0;
        #10 $display("A=%h B=%h Cin=%b | Sum=%h Cout=%b", A, B, Cin, Sum, Cout);

        // 隨機測試
        repeat (5) begin
            A = $random;
            B = $random;
            Cin = $random % 2;
            #10 $display("A=%h B=%h Cin=%b | Sum=%h Cout=%b", A, B, Cin, Sum, Cout);
        end

        $finish;
    end
endmodule
