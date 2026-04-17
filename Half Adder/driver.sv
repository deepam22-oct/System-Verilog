class driver;
  int no_transactions;
  
  virtual intf vif; //creating virtual interface for driver class
  
  mailbox gen2driv;
  
  function new(virtual intf vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset;
    wait(vif.rst);
    $display("DRIVER -------RESET STARTED------");
    vif.a <=0;
    vif.b <=0;
    vif.valid <=0;
    wait(!vif.rst);
    $display("DRIVER----------RESET ENDED-----------");
  endtask
  
  //driver the transaction item to interafec signals
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
      @(posedge vif.clk);
      vif.valid <=1;
      vif.a <=trans.a;
      vif.b <= trans.b;
      @(posedge vif.clk);
      vif.valid <=0;
      trans.sum <= vif.sum;
      trans.c_out <= vif.c_out;
      @(posedge vif.clk);
      trans.display("DRIVER");// inputs and the output
      no_transactions++;
    end
  endtask
endclass 
  
  
  
  
  
  
  
  
