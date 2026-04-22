`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"

class enviroment ;
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;

  mailbox gen2driv;
  mailbox mon2scb;

  function new ( virtual intf vif);
    this.vif = vif ;
    gen2driv = new(); 
    mon2scb = new();
    gen = new(mailbox gen2driv);
    driv = new(mailbox gen2driv , virtual intf vif);
    mon = new(mailbox mon2scb , virtual intf vif);
    scb = new(mailbox mon2scb);
  endfunction 

  task pre_test();
    driv.reset();
  endtask 

  task test();
    fork
    gen.main();
    driv.main();
    mon.main();
    scb.main();
    join_any
  endtask

 task post_test();
   wait(gen.ended.triggered);
   wait(gen.repeat_count == driv.no_transactions);
   wait(gen.repeat_count == scb.no_transactions);
 endtask
      
task run;
  pre_test();
  test();
  post_test();
  $finish;
endtask
  
endclass

  
