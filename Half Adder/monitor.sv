class monitor;
  virtual intf vif;
  
  mailbox mon2scb; 
  
  function new(virtual intf vif, mailbox mon2scb);
    this.vif =vif;
    this.mon2scb = mon2scb;
  endfunction
  
  //samples the interface signal and send the pins to packet (transaction class)
  task main;
    forever begin
      transaction trans;
      trans = new();
      @(posedge vif.clk);
      wait(vif.valid);
      trans.a <= vif.a;
      trans.b <= vif.b;
      @(posedge vif.clk);
      trans.sum <= vif.sum;
      trans.c_out <= vif.c_out;
      @(posedge vif.clk);
      mon2scb.put(trans);
      trans.display("MONITOR");
    end
  endtask
endclass
      
