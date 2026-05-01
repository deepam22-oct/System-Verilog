class transaction;  
  rand bit[2:0] in;
  bit[7:0] out ;
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- in = %0d",in);
    $display("- out = %0d",out);
    $display("-------------------------");
  endfunction
endclass
