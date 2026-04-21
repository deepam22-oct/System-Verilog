class transaction ;
  rand bit[3:0] i ;
  rand bit[1:0] sel ;

  bit y ;

  function void display(string name);
    $display("--------------------");
    $display(" --%s", name);
    $display("--------------------");
    $display(" I: %4b || SEL : %2b ", i,sel);
    $display(" Q :%b ", y);
  endfunction

endclass
