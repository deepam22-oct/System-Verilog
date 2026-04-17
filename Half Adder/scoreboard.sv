class scoreboard;
  
  mailbox mon2scb;
  
  int no_transactions;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  //compares the actual result with the expected result
  
  task main;
    transaction trans;
    
    forever begin
      mon2scb.get(trans);
      if((trans.a ^ trans.b) == trans.sum && (trans.a & trans.b) == trans.c_out)
        $display("RESULT IS AS EXPECTED");
      else
        $error("RESULT IS WRONG");
      no_transactions++;
      trans.display("SCB");
    end
  endtask
endclass
      
