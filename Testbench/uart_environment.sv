class environment;

  // Component handles
  generator  g;
  driver     d;
  monitor    m;
  scoreboard s;

  // Communication channels (mailboxes)
  mailbox gen2drv = new();
  mailbox mon2scb = new();

  // Virtual interface handle (to connect TB classes to DUT)
  virtual uart_if uart;

  // Constructor
  function new(virtual uart_if uart);
    this.uart = uart;
    g = new(gen2drv);           // Generator sends transactions to driver
    d = new(uart, gen2drv);     // Driver drives signals to DUT
    m = new(uart, mon2scb);     // Monitor observes DUT signals
    s = new(mon2scb);           // Scoreboard checks results
  endfunction

  // Main execution task
  task run();
    fork
      g.run();
      d.run();
      m.run();
      s.run();
    join
  endtask

endclass
