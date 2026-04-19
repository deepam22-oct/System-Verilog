// Code your design here
module addr (input clk, 
             input rst,
             input [3:0] a,
             input [3:0] b,
             input valid,
             output [4:0] c);
  
  
  reg [8:0] tmp_c;
  
  always_ff @(posedge clk or posedge rst) begin
    if(rst)
      tmp_c <=0;
  else if(valid)
    tmp_c <= a+b;
  end
  
  assign c = tmp_c;
 // assign c = a+b;
endmodule
