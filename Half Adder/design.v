// Code your design here
module half_adder ( input clk,
                   input rst,
                   input a, b, 
                   input valid,
                   output sum, 
                   output c_out);
  
  assign sum = a^b;
  assign c_out = a&b;
endmodule
