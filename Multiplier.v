module Multiplier #(parameter N = 4) (
    input  [N-1:0] A,
    input  [N-1:0] B,
    output [2*N-1:0] Sum
);

    // 定義部分積 (partial products)
    reg [2*N-1:0] partial [0:N-1];
    reg [2*N-1:0] temp_sum;
    integer i;

    // 產生部分積
    always @(*) begin
        for (i = 0; i < N; i = i + 1) begin
            partial[i] = { {N{1'b0}}, (A & {N{B[i]}}) } << i;
        end
    end

    // 將所有部分積加總
    always @(*) begin
        temp_sum = {2*N{1'b0}};
        for (i = 0; i < N; i = i + 1) begin
            temp_sum = temp_sum + partial[i];
        end
    end

    assign Sum = temp_sum;

endmodule