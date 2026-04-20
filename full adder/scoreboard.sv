class scoreboard;
  mailbox mon2scb;
  
  int no_transactions;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if((trans.a+trans.b) == trans.c)
        $display("result is as expected");
      else 
        $error("wrong result \n \t expected: %0d actual: %0d", (trans.a+trans.b), trans.c);
      no_transactions++;
      trans.display("[scoreboard]");
    end
  endtask
  
endclass
  
