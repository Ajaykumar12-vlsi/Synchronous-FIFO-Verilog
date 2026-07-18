# Parameterized Synchronous FIFO (Verilog)

## Overview

This project implements a parameterized synchronous FIFO in Verilog HDL.

The design supports configurable FIFO depth and data width and includes additional status flags for robust operation.

---

## Features

- Parameterized FIFO Depth
- Parameterized Data Width
- Synchronous Read and Write
- Full Detection
- Empty Detection
- Overflow Detection
- Underflow Detection
- Occupancy Counter
- Almost Full Flag
- Almost Empty Flag

---

## Tools Used

- Vivado 2024.2
- Verilog HDL

---

## Files

sync_fifo.v      -> RTL Design

sync_fifotb.v    -> Testbench

---

## Verification

The FIFO was verified using multiple simulation scenarios including:

- Normal Write Operation
- Normal Read Operation
- Simultaneous Read/Write
- FIFO Full Condition
- FIFO Empty Condition
- Overflow Detection
- Underflow Detection
- Occupancy Counter Verification
- Almost Full Verification
- Almost Empty Verification

---

## Future Improvements

- Asynchronous FIFO
- SystemVerilog Assertions
- Functional Coverage
- UVM Testbench
