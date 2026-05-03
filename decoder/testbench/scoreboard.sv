class scoreboard;
   
  mailbox mon2scb;
  int no_transactions;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  // expected result for 3:8 decoder
  function bit [7:0] expected_result(input bit [2:0] in);
    expected_result = (8'b00000001 << in);
  endfunction
  
  task main;
    transaction trans;
    bit [7:0] expected;
    forever begin
      mon2scb.get(trans);
      expected = expected_result(trans.in);
      if(expected == trans.out)
        $display("Result is as Expected");
      else
        $error("Wrong Result");
      no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
  
endclass
