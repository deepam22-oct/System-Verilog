class scoreboard;

  transaction trans;
  int no_transactions;
  mailbox mon2scb;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction


  task main;
    transaction trans;
    logic [2:0] exp_out;

    forever begin
      // Get data from monitor
      mon2scb.get(trans);

      // Expected logic for 8:3 Encoder
      case (trans.in)
        8'b0000_0001 : exp_out = 3'b000;
        8'b0000_0010 : exp_out = 3'b001;
        8'b0000_0100 : exp_out = 3'b010;
        8'b0000_1000 : exp_out = 3'b011;
        8'b0001_0000 : exp_out = 3'b100;
        8'b0010_0000 : exp_out = 3'b101;
        8'b0100_0000 : exp_out = 3'b110;
        8'b1000_0000 : exp_out = 3'b111;
        default      : exp_out = 3'b000;
      endcase
      if (trans.out == exp_out)
        $display("Result is Correct");
      else
        $error("Wrong Result -> Expected = %0b , Got = %0b", exp_out, trans.out);

      no_transactions++;
      trans.display("[ SCOREBOARD ]");

    end
  endtask

endclass
