module half_adder ( input clk,
                   input rst,
                   input a, b, 
                   input valid,
                   output sum, 
                   output c_out);
  
  reg tmp_sum, tmp_cout;
  
 always @(posedge clk or posedge rst) begin
     if(rst) begin
       tmp_sum <= 0;
       tmp_cout <=0;
     end
    
     else if(valid) begin
       tmp_sum <= a^b;
       tmp_cout <= a&b;
     end
   end
  
   assign sum = tmp_sum;
   assign c_out = tmp_cout;
endmodule
