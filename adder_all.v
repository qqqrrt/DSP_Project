module adder_all(sum,carry,a,b,cin);
    output sum;
    output carry;
    input a,b,cin;
    wire sum1,sum2,carry1,carry2;

    adder_half m1(sum1,carry1,a,b);
    adder_half m2(sum2,carry2,sum1,cin);

    or(carry, carry1, carry2);
    assign sum = sum2;



endmodule