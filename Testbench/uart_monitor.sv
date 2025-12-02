class monitor;

  // Virtual interface to observe DUT signals
  virtual uart_if uart;

  // Mailbox to send observed transactions to the scoreboard
  mailbox mon2scb;

  // Constructor
  function new(virtual uart_if uart, mailbox mon2scb);
    this.uart = uart;
    this.mon2scb = mon2scb;
  endfunction

  // Task that continuously monitors the DUT outputs
  task run();
    int count = 0;

    while (count < 5) begin
      @(posedge uart.clk);

      // Check when valid data is received
      if (uart.valid_rx) begin
        uart_transaction tr = new();
        tr.received_data = uart.RxData;

        $display("[MON] Received: %s (%0h)", tr.received_data, tr.received_data);

        // Send this observed transaction to the scoreboard
        mon2scb.put(tr);

        count++;
      end
    end
  endtask

endclass
