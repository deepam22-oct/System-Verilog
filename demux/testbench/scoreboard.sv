class scoreboard;

  transaction trans;
  mailbox mon2scb;

  logic [7:0] expected_output;
  int no_transaction;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task main();
    forever begin 
      mon2scb.get(trans);
      expected_output = 8'd0;

      if (trans.valid)
        expected_output = (8'b00000001 << trans.sel) & {8{trans.in}};

      if(expected_output == trans.out) 
        $display("✅ CORRECT: expected=%b actual=%b", expected_output, trans.out);
      else 
        $display("❌ WRONG: expected=%b actual=%b", expected_output, trans.out);

      no_transaction++;
      trans.display("Scoreboard");
    end 
  endtask

endclass
