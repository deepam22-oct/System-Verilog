
`include "interface.sv"
`include "test.sv"

module top;
  
  bit clk, rst;
  
  always #5 clk = ~clk;
  
  initial begin
    rst =1;
    #5 rst =0;
  end
  
  intf i_intf (clk,rst);
  
  test t1 (i_intf);
  
  full_adder dut (.clk(i_intf.clk),
            .rst(i_intf.rst),
            .a(i_intf.a),
            .b(i_intf.b),
            .valid(i_intf.valid),
            .c(i_intf.c));
  
  
  initial begin
    $dumpfile("ex.vcd");
    $dumpvars;
  end
endmodule
