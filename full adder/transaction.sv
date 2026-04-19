class transaction ;
  rand [3:0] a ;
  rand [3:0] b ;
  bit[4:0] c ;

  function void display(string name);
    $display("----------------------------");
    $display("-%s ", name);
    $display("----------------------------");
    $display("-a: %0d |||| -b:%0d", a,b);
    $display("-c: %0d", c);
    $display("---------------------------");
  endfunction
endclass
