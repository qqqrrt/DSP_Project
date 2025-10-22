`timescale 1ns/100ps
//最小執行時間單位 1ns
//精細度 100ps
module test;
    reg[1:0] count;
    wire sum, carry;
    integer i;

    adder_half a1(sum,carry,count[0],count[1]);


    initial begin
        for (i=0; i<4; i=i+1) begin
            count = i[1:0];
            #10
            $display("in = %d, sum = %d, carry = %d",count, sum, carry );
        end
    end

endmodule