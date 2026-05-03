`include "test.sv"
module tbench_top;
  
  bit clk;
  bit reset;
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  intf i_intf(clk,reset);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  decoder3_8 DUT (
    .clk(i_intf.clk),
    .reset(i_intf.reset),
    .in(i_intf.in),
    .valid(i_intf.valid),
    .out(i_intf.out)
   );
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
