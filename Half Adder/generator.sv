class generator ;
  rand transaction trans ;
  int repeat_count ;
  mailbox gen2driv ;
  event ended ;
  // constructor 
  function new(mailbox gen2driv) ;
    this.gen2driv = gen2driv ;
  endfunction 

  task main() ;
    repeat(repeat_count) begin 
      trans = new () ;
      asser(trans.randomize()) ;
      trans.display("Generator");
      gen2driv.put(trans);
    end
    ->ended
  endtask
  
endclass
