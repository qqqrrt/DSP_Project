module adder_n #(parameter n = 8)(
    input [n-1:0] A,
    input [n-1:0] B,
    input Cin,
    output [n-1:0] Sum,
    output Cout
);
    wire [n:0] carry; // 多一位，carry[0] = Cin
    assign carry[0] = Cin;
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : adder_chain
            adder_all fa (
                .sum(Sum[i]),
                .carry(carry[i+1]),
                .a(A[i]),
                .b(B[i]),
                .cin(carry[i])
            );
        end
    endgenerate
    assign Cout = carry[n];
endmodule
