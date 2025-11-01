`timescale 1ns/1ps

module tb_FSM_Moore_1101;
  reg clk, rst_n, data_in;
  wire out;

  // Instantiate your FSM module
  FSM_Moore_1101 uut (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .out(out)
  );

  // Generate clock signal
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    rst_n = 0;
    data_in = 0;
    #10;
    rst_n = 1;
    // Test sequence: 1_1_0_1 (should detect at end)
    data_in = 1; #10;
    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    // Test: non-overlapping, start fresh
    data_in = 1; #10;
    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    // Random values
    data_in = 1; #10;
    data_in = 0; #10;
    data_in = 1; #10;
    data_in = 1; #10;
    // End test
    #30;
    $finish;
  end
  
  // For waveform viewing (most simulators)
  initial begin
    $dumpfile("tb_FSM_Moore_1101.vcd");
    $dumpvars(0, tb_FSM_Moore_1101);
  end

  // Optional: print status at each clock
  always @(posedge clk) begin
    $display("%t: data_in=%b, out=%b", $time, data_in, out);
  end
endmodule
