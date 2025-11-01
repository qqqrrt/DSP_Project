module seq_detector_101(
    input clk,
    input rst_n,
    input x,
    output reg z
);

    //channel state

    parameter S0 = 2'b00; // 0
    parameter S1 = 2'b01; // 1
    parameter S2 = 2'b10; // 10

    reg [1:0] state, next_state;

    //state reg(順序邏輯)
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            state <= S0;
        else 
            state <= next_state;
    end

    //次態邏輯(組合邏輯)
    always @(*) begin
        case(state)
            S0: next_state = (x == 1'b1) ? S1 : S0;
            S1: next_state = (x == 1'b1) ? S1 : S2;
            S2: next_state = (x == 1'b1) ? S1 : S0;
        endcase 
    
    end


    always @(*) begin
        z = (state == S2) && (x==1'b1);

    end
endmodule