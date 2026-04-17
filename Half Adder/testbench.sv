// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"

module tb;
  
  bit clk, rst;
  
  always #5 clk = ~clk;
  
  initial begin
    rst =1;
    #5 rst =0;
    $dumpfile("ex.vcd");
    $dumpvars(0,tb);
  end
  
  intf i_intf (clk, rst);// creating instance for interface, inorder to connect DUT and testcases
  
  test t1(i_intf);// testcase instance,  actual interface is passed to test 
  
  half_adder dut(.clk(i_intf.clk),
                 .rst(i_intf.rst),
                 .a(i_intf.a),
                 .b(i_intf.b),
                 .valid(i_intf.valid),
                 .sum(i_intf.sum),
                 .c_out(i_intf.c_out));
endmodule
