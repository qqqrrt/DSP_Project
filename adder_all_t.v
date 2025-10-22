`timescale 1ns/100ps
//最小執行時間單位 1ns
//精細度 100ps
module test;
    reg[2:0] count;
    wire sum, carry;
    integer i;

    add_all a1(sum,carry,count[0],count[1],count[2]);

    initial #100 $finish;
    
    initial begin
        $dumpfile("adder_all.vcd");
        $dumpvars;
    end

    initial begin
        for (i=0; i<8; i=i+1) begin
            count = i[2:0];
            #10
            $display("in = %d, sum = %d, carry = %d",count, sum, carry );
        end
    end

endmodule