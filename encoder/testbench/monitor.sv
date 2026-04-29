class monitor ;
  mailbox mon2scb ;
  transaction trans ;
  virtual intf vif ;

  function new(mailbox mon2scb , virtual intf vif );
    this.mon2scb = mon2scb ;
    this.vif = vif ;
  endfunction 

  task main();
    forever begin 
      trans = new();
      @(posedge vif.clk);
      wait(vif.valid);
      trans.in <= vif.in ;
      @(posedge vif.cli);
      trans.out <= vif.out ;
      @(posedge vif.clk);
      trans.display("[MONITOR]");
      mon2scb.put(trans);
    end
  endtask

endclass
