class driver ;
  transaction trans ;
  mailbox gen2driv ;
  virtual intf  vif ;
  int no_transaction ;

  function new(mailbox gen2driv , virtual intf vif );
    this.gen2driv  = gen2driv ;
    this.vif = vif ;
  endfunction
  task reset();
    wait(vif.rst);
    $display("-----------DRIVER RESET STARTED -----------");
    vif.i <= 0 ;
    vif.sel <= 3'b000 ;
    vif.valid <= 0 ;
    vif.out <= 8'd0 ;
    wait(!vif.rst);
    $display("-----------DRIVER RESET END -----------");
  endtask
  
  task main();
    forever begin 
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <= 1'b1 ;
      vif.i <= trans.i ;
      vif.sel <= trans.sel ;
      @(posedge vif.clk);
      vif.valid <= 1'b0 ;
      @(posedge vif.clk);
      trans.display("DRIVER");
      no_transaction++ ;
    end
  endtask 

endclass
      
      
  
