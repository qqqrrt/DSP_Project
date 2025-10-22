module adder_half(sum,carry,a,b);
    output sum;
    output carry;
    input a,b;

    xor(sum, a, b);
    and(carry, a, b);




endmodule