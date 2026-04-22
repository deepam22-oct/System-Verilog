class scoreboard ;
  mailbox mon2scb ;
  transaction trans ;
  int no_transaction;
  logic expected_output;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb ;
  endfunction 

  task main();
    forever begin 
      mon2scb.get(trans);
      expected_output = trans.i[trans.sel];             // y = i[sel] ;
      if (expected_output == trans.y)
        $display("result is correct");
      else 
        $display("wrong result");
      no_transaction++;
      trans.display("[scoreboard]");
    end
  endtask

endclass
      
