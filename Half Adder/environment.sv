`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  //create handlers of all the class
  generator gen; 
  driver drv;
  monitor mon;
  scoreboard scb;
  
  mailbox gen2driv;
  mailbox mon2scb; 
  
  virtual intf vif;
  
  //constructor
  function new(virtual intf vif);
    this.vif = vif;
    
    //creating the mailbox (same mailbox will be share accross  gen ---> drv and mon --->scb
    gen2driv = new();
    mon2scb =new();
    
    //creating objects for class
    gen = new(gen2driv);
    drv = new(vif, gen2driv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
  endtask
  
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.repeat_count == drv.no_transactions);
    wait(gen.repeat_count == scb.no_transactions);
  endtask
  
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
endclass
