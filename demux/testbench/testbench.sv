`include "interface.sv"
`include "test.sv"

// Testbench Module (Top-Level)
module tbench_top;

  // Clock and reset signal declaration
  bit clk;
  bit reset;

  // Clock generation
  always #5 clk = ~clk;

  // Reset Generation
  initial begin
    clk =0;
    $dumpfile("waveform.vcd");
    $dumpvars(0, tbench_top);
    reset = 1;
    #5 reset = 0;
  end

  // Creating an instance of the interface to connect DUT and Testcase
  intf i_intf(clk, reset);

  // DUT instance with corrected interface connections
  demux1_8 dut(
    .clk(i_intf.clk),
    .reset(i_intf.reset),
    .in(i_intf.in),
    .valid(i_intf.valid),
    .sel(i_intf.sel), 
    .out(i_intf.out)  
  );

  // Enable waveform dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
test t1(i_intf);
  
endmodule
