class driver ;

  mailbox gen2driv ;
  virtual intf vif ;
  int no_transaction;

  function new( mailbox gen2driv , virtual intf vif );
    this.gen2driv = gen2driv ;
    this.vif = vif ;
  endfunction 

  task reset();
    wait(vif.rst);
    $display("------Reset started-----");
    vif.i <= 4'b0000;
    vif.sel <= 2'b00;
    vif.valid <= 1'b0 ;
    vif.y <= 1'b0 ;
    wait(!vif.rst);
    $display("------Reset end-----");
  endtask 

  task main();
    transaction trans ;
    forever begin 
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <= 1 ;
      vif.i <= trans.i ;
      vif.sel <= trans.sel ;
      @(posedge vif.clk);
      vif.valid <= 0 ;
      vif.y = trans.y ;
      @(posedge vif.clk);
      trans.display ("[driver]");
      no_transaction++;
    end
  endtask

endclass
  
