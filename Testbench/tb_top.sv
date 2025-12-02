`timescale 1ns/1ps

`include "uart_if.sv"
`include "uart_transaction.sv"
`include "uart_generator.sv"
`include "uart_driver.sv"
`include "uart_monitor.sv"
`include "uart_scoreboard.sv"
`include "uart_environment.sv"
`include "uart_transmitter.sv"
`include "uart_receiver.sv"
`include "uart_top.sv"

module tb_uart_interface;

  // Instantiate UART interface
  uart_if uart();

  // Instantiate DUT (Design Under Test)
  Uart_Interface dut (.uart(uart));

  // Clock generation (50 MHz => 20 ns period)
  initial uart.clk = 0;
  always #10 uart.clk = ~uart.clk;

  // Environment handle
  environment env;

  initial begin
    // Setup waveform dump
    $dumpfile("uart.vcd");
    $dumpvars(0, tb_uart_interface);

    // Initial conditions
    uart.reset    = 1;
    uart.transmit = 0;
    uart.TxData   = 0;

    // Apply reset
    #100;
    uart.reset = 0;

    // Wait for system stabilization
    #100;

    // Create environment and start simulation
    env = new(uart);
    env.run();

    $display("[TB] Simulation completed.");
    $finish;
  end

endmodule
