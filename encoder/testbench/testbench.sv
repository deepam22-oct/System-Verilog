`include "interface.sv"
`include "test.sv"

module tbench_top;

  // Clock and Reset
  bit clk;
  bit reset;

  // Clock generation
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    reset = 1;
    #5 reset = 0;
  end

  // Interface instance
  intf i_intf(clk, reset);

  // Test instance
  test t1(i_intf);
  
  encoder8_3 DUT (
    .clk   (i_intf.clk),
    .reset (i_intf.reset),
    .in    (i_intf.in),
    .valid (i_intf.valid),
    .out   (i_intf.out)
  );

  // Wave dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
