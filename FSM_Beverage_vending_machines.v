module seller #(
    parameter S0 = 2'b00,
    parameter S5 = 2'b01,
    parameter S10 = 2'b10,
    parameter S15 = 2'b11
) (
    input clk,
    input rst_n,
    input coin_5, coin_10,
    output reg dispense,
    output reg  change
);
    reg [1:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;    
    end

    always @(*) begin
        case(state)
            S0: begin
                if (coin_5)
                    next_state = S5;
                else if (coin_10)
                    next_state = S10;
                else
                    next_state = S0;
                end
            S5: begin
                if (coin_5 == 1'b1)
                    next_state = S10;
                else if (coin_10 == 1'b1)
                    next_state = S15;
                else
                    next_state = S5;
                end            
            S10: begin
                if (coin_5 == 1'b1)
                    next_state = S15;
                else if (coin_10 == 1'b1)
                    next_state = S0;
                else
                    next_state = S10;
                end
            S15: next_state = S0;          
        endcase 
    
    end
    always @(*) begin
        dispense = ((coin_10 || coin_5) && (state == S10)) || ((coin_10)&&(state == S5)) || (state == S15) ; 
        change = (coin_10 == 1'b1) && (state == S10);
    end
    
endmodule