module FSM_Moore_1101 #(
    parameter S0 = 3'b000, //inital
    parameter S1 = 3'b001, //1
    parameter S2 = 3'b010, //11
    parameter S3 = 3'b011, //110
    parameter S4 = 3'b100  //1101

) (
    input clk,
    input rst_n,
    input data_in,
    output reg out
);

    reg[2:0] state, next_state;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state)
            S0: next_state = (data_in == 1'b1 )? S1 : S0;
            S1: next_state = (data_in == 1'b1 )? S2 : S0;
            S2: next_state = (data_in == 1'b0 )? S3 : S2;
            S3: next_state = (data_in == 1'b1 )? S4 : S0;
            S4: next_state = (data_in == 1'b1 )? S1 : S0;
            default: next_state = S0;

        endcase
    end
    always @(*) begin
        out = (state == S4);
    end
    
endmodule