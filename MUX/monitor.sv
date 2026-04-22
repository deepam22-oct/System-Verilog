class monitor ;
  transaction trans ;
  mailbox mon2scb ;
  virtual intf vif ;

  function new(mailbox mon2scb ,virtual intf vif );
    this.mon2scb = mon2scb ;
    this.vif = vif ;
  endfunction 

  task main();
    forever begin 
      trans = new();
      @(posedge vif.clk);
      wait(vif.valid)
      trans.i = vif.i ;
      trans.sel = vif.sel ;
      @(posedge vif.clk);
      trans.y  = vif.y ;
      @(posedge vif.clk);
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask

endclass
      
