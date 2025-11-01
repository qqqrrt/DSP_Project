module tb_seller;
  reg clk, rst_n, coin_5, coin_10;
  wire dispense, change;

  seller uut(
    .clk(clk),
    .rst_n(rst_n),
    .coin_5(coin_5),
    .coin_10(coin_10),
    .dispense(dispense),
    .change(change)
  );

  // 產生時鐘
  initial clk = 0;
  always #5 clk = ~clk;
  
  always @(posedge clk) begin
    $display("%t | state=%b | coin_5=%b | coin_10=%b | dispense=%b | change=%b", $time, uut.state, coin_5, coin_10, dispense, change);
  end

  initial begin
    // 初始狀態全0
    rst_n = 0; coin_5 = 0; coin_10 = 0;
    #12;
    rst_n = 1;
    #10;
    // 狀態 S0 → S5
    coin_5 = 1; #10;
    coin_5 = 0; #10;
    // 狀態 S5 → S10(繼續投5元)
    coin_5 = 1; #10;
    coin_5 = 0; #10;
    // 狀態 S10 → S15(再投5元)
    coin_5 = 1; #10;
    coin_5 = 0; #10;
    // Reset回S0
    rst_n = 0; #10; rst_n = 1; #10;
    // S0 → S10(投10元)
    coin_10 = 1; #10;
    coin_10 = 0; #10;
    // S10(累積10) → S15(再投5元)
    coin_5 = 1; #10;
    coin_5 = 0; #10;
    // Reset回S0
    rst_n = 0; #10; rst_n = 1; #10;
    // S0 → S5(投5元)
    coin_5 = 1; #10;
    coin_5 = 0; #10;
    // S5 → S15(投10元，剛好15)
    coin_10 = 1; #10;
    coin_10 = 0; #10;
    // S0 → S10(投10元)、S10 → S15(再投10元，20元，找零)
    coin_10 = 1; #10;
    coin_10 = 0; #10; // 進入S10
    coin_10 = 1; #10;
    coin_10 = 0; #10;
    $stop;
  end
endmodule
