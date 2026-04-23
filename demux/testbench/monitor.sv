class monitor ;
  mailbox mon2scb ;
  transaction trans ;
  virtual intf vif ;

  function new(mailbox mon2scb , virtual intf vif);
    this.mon2scb = mon2scb ;
    this.vif = vif ;
  endfunction 

  task main();
    forever begin 
      trans = new();
      @(posedge vif.clk);
      wait(vif.valid);
      trans.in <= vif.in ;
      trans.sel <= vif.sel ;
      @(posedge vif.clk);
      trans.out <= vif.out ;
      @(posedge vif.clk);
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask

endclass
      
