class driver;

  // Virtual interface handle to access DUT signals
  virtual uart_if uart;

  // Mailbox for communication between generator and driver
  mailbox gen2drv;

  // Constructor
  function new(virtual uart_if uart, mailbox gen2drv);
    this.uart = uart;
    this.gen2drv = gen2drv;
  endfunction

  // Main task that drives transactions onto the DUT
  task run();
    uart_transaction tr;
    
    repeat (5) begin
      // Wait for next transaction from generator
      gen2drv.get(tr);
      
      // Wait for falling clock edge for synchronization
      @(negedge uart.clk);
      
      // Wait until UART is not busy (previous transmission done)
      while (uart.busy)
        @(negedge uart.clk);
      
      // Drive the data and assert transmit signal
      uart.TxData = tr.data;
      uart.transmit = 1;

      // Pulse transmit for one clock cycle
      @(negedge uart.clk);
      uart.transmit = 0;
    end
  endtask

endclass
