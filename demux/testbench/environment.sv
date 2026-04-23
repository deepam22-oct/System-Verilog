`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment ;
  generator gen ;
  driver driv ;
  monitor mon ;
  scorebaord scb ;

  mailbox gen2driv ;
  mailbox mon2scb ;
  virtual intf vif ;

  function new(virtual intf vif);
    gen2driv = new();
    mon2scb = new();
    gen = new(gen2driv);
    driv = new(gen2driv , vif );
    mon = new(mon2scb , vif);
    scb = new(mon2scb);
  endfunction

  task pre_test();
    driv.reset();
  endtask;

  task test();
    fork 
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any 
  endtask

  task post_test();
    wait(gen.ended.triggred);
    wait(gen.repeat_count == driv.no_transaction);
    wait(gen.repeat_count == scb.no_transaction);
    $finish;
  endtask

  task run();
    pre_test();
    test();
    post_test();
  endtask

endclass
    
