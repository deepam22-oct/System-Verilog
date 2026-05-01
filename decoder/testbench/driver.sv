class driver;
  
  int no_transactions;
  virtual intf vif;
  mailbox gen2driv;
  function new(virtual intf vif,mailbox gen2driv);
    this.vif = vif; 
    this.gen2driv = gen2driv;
  endfunction
  
  task reset;
    wait(vif.rst);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.valid <= 0;
    wait(!vif.rst);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <= 1;
      vif.in    <= trans.in;
      @(posedge vif.clk);
      vif.valid <= 0;
      trans.out   = vif.out;
      @(posedge vif.clk);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass
