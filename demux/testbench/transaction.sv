class transaction ;
  rand bit in ;
  rand bit[2:0] sel ;

  bit[7:0] out ;

  function void display(string name);
    $display("--------------------");
    $display(" --%s", name);
    $display("--------------------");
    $display(" IN: %b || SEL : %3b ", in,sel);
    $display(" OUT :%8b ", out);
  endfunction

endclass
