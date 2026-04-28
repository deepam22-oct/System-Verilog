class driver ;
  mailbox gen2driv ;
  transaction trans;
  virtual intf vif ;
  int no_transactions ;

  function new(mailbox gen2driv , virtual intf vif);
    this.gen2driv = gen2driv ;
    this.vif = vif ;
  endfunction 

  task reset();
    wait(vif.reset);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.valid <= 0;
    vif.in <= 8'b0 ;
    wait(!vif.reset);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask 

  task main();
    forever begin 
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <= 1'b1 ;
      vif.in <= trans.in ;
      @(posedge vif.clk);
      vif.valid <= 0;
      trans.out   = vif.out;
      @(posedge vif.clk);
      trans.display("[ DRIVER ]");
      no_transactions++ ;
    end
  endtask

endclass
      
    
