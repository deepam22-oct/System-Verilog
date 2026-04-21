class driver ;

  int no_oftransaction ;
  virtual intf vif ;
  mailbox gen2driv ;

  function new(mailbox gen2driv , virtual intf vif);
    this.gen2driv = gen2driv ;
    this.vif = vif ;
  endfunction 

  task reset() ;
    wait(vif.rst);
    $display("------------- DRIVER RESET ENDED ------------");
    vif.a <= 4'b0 ;
    vif.b <= 4'b0 ;
    vif.c <= 5'b0 ;
    wait(!vif.rst);
    $display("------------- DRIVER RESET ENDED ------------");
  endtask
  
  task main();
    transaction trnas ;
    forever begin 
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <=1;
      vif.a <=trans.a;
      vif.b <= trans.b;
      @(posedge vif.clk);
      vif.valid <=0;
      trans.c <= vif.c;
      @(posedge vif.clk);
      trans.display("Driver");
      no_transactions++;
    end
  endtask
endclass
