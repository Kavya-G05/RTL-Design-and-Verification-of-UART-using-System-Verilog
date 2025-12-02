class generator;
  
  // Mailbox used for communication between generator and driver
  mailbox gen2drv;

  // Constructor: connects this generator to the shared mailbox
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  // Main behavior of generator: produces UART transactions
  task run();
    uart_transaction tr;               // handle for a transaction object
    byte message [5] = {"K", "A", "V", "Y", "A"}; // message to send

    // Loop through each character of the message
    for (int i = 0; i < $size(message); i++) begin
      tr = new();                      // create a new transaction
      tr.data = message[i];            // assign one character to data
      tr.display("GEN");               // display info with a tag “GEN”
      gen2drv.put(tr);                 // put the transaction into the mailbox
      #1000;                           // wait for some time (simulation delay)
    end
  endtask

endclass
