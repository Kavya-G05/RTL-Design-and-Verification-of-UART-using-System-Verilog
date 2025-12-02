class uart_transaction;

  // Randomizable data byte to be transmitted
  rand bit [7:0] data;

  // Captured data byte after reception (used for comparison)
  bit [7:0] received_data;

  // Display function for debugging and tracking transactions
  function void display(string tag);
    $display("[%s] Data: %s (%0h)", tag, data, data);
  endfunction

endclass
