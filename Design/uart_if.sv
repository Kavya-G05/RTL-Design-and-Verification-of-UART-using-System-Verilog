interface uart_if;
  logic clk;
  logic reset;
  logic transmit;
  logic [7:0] TxData;
  logic TxD;          // Transmit line
  logic busy;
  logic [7:0] RxData;
  logic valid_rx;
  logic [7:0] RS232_TxData;
  logic [7:0] RS232_RxData;
endinterface
