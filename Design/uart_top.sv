module Uart_Interface (uart_if uart);

  Uart_Transmitter tx_inst (.uart(uart));
  Uart_Receiver    rx_inst (.uart(uart));

endmodule
