class transaction;
  
  rand bit a;
  rand bit b;
  bit sum;
  bit c_out;
  
  function void display(string name);
    $display("---------------------------------");
    $display("[%s]", name);
    $display("---------------------------------");
    $display("A:%0d \t || \t B:%0d", a, b);
    $display("SUM:%0d \t || \t C_OUT : %0d", sum, c_out);
    $display("---------------------------------");
  endfunction
  
endclass
