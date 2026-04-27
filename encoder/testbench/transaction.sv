class transaction;  
  rand bit[7:0] in ;
  bit [2:0] out ;
    
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display(" IN = %8b " ,in);
    $display(" OUT = %3d",out);
    $display("-------------------------");
  endfunction
endclass
