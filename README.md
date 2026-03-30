# FIFO_Verification_using-_SV
# FIFO Design & Verification (SystemVerilog) – Industry-Level

## Overview

This project implements a parameterized synchronous FIFO along with a complete SystemVerilog verification environment. It includes assertions (SVA), functional coverage, a reference model (scoreboard), and error injection to validate robustness under corner cases.

---

## Features

### RTL Design

* Parameterized depth and data width
* Synchronous FIFO architecture
* Separate read/write pointers
* Status flags: `full`, `empty`
* Count tracking

### Verification Environment

* Transaction-based stimulus
* Mailbox-driven communication
* Reference model using queue
* Self-checking scoreboard

### Advanced Verification

* Assertions for protocol correctness
* Functional coverage for scenario tracking
* Error injection for stress testing

---

## FIFO Architecture

* Write pointer increments on valid write
* Read pointer increments on valid read
* Memory implemented as register array
* `count` tracks number of elements
* `full` when count = depth
* `empty` when count = 0

---

## Interface Signals

### Inputs

* `clk` : Clock
* `rst` : Reset
* `wr_en` : Write enable
* `rd_en` : Read enable
* `din` : Input data

### Outputs

* `dout` : Output data
* `full` : FIFO full flag
* `empty` : FIFO empty flag
* `count` : Number of stored elements

---

## Verification Components

### Transaction

Represents read/write operations with data payload.

### Driver

* Drives `wr_en`, `rd_en`, and `din`
* Includes error injection:

  * Forced writes during full (overflow)
  * Forced reads during empty (underflow)

### Monitor

* Observes DUT signals
* Sends transactions to scoreboard

### Scoreboard

* Implements reference model using queue
* Compares expected vs actual data
* Reports PASS/FAIL

### Environment

* Connects all components
* Runs them in parallel

---

## Assertions (SVA)

### Purpose

Ensure protocol correctness and catch design violations early.

### Checks Implemented

* No write when FIFO is full (overflow protection)
* No read when FIFO is empty (underflow protection)
* Basic state validity checks

### Benefits

* Immediate detection of illegal operations
* Improves design reliability
* Supports formal verification extension

---

## Functional Coverage

### Coverage Points

* Write operations (`wr_en`)
* Read operations (`rd_en`)
* FIFO fill levels:

  * Empty
  * Mid-range
  * Full

### Cross Coverage

* Write × Read × FIFO level

### Benefits

* Measures verification completeness
* Ensures all FIFO states are exercised
* Helps achieve coverage closure

---

## Error Injection

### Purpose

Validate FIFO robustness under invalid or extreme conditions.

### Types

* **Overflow Injection**

  * Write enabled even when FIFO is full

* **Underflow Injection**

  * Read enabled even when FIFO is empty

### Benefits

* Tests boundary conditions
* Verifies flag correctness
* Ensures safe failure behavior

---

## Simulation Flow

1. Apply reset
2. Driver generates read/write operations
3. Error injection randomly triggers invalid scenarios
4. DUT processes transactions
5. Monitor captures outputs
6. Scoreboard validates behavior
7. Assertions check protocol rules
8. Coverage collects statistics

---

## Design Assumptions

* Single clock domain (synchronous FIFO)
* No simultaneous write/read hazards beyond basic handling
* Immediate read-after-write visibility depends on design timing

---

## Limitations

* No asynchronous FIFO support
* No almost full/empty flags
* Basic assertion set
* No backpressure modeling

---

## Possible Extensions

* Asynchronous FIFO (dual clock)
* Almost full/empty thresholds
* Latency and ordering checks
* Full UVM-based environment
* Formal verification integration
* Performance metrics tracking

---

## File Structure

* `fifo_sync.sv` : FIFO RTL
* `fifo_if.sv` : Interface
* `fifo_txn.sv` : Transaction class
* `fifo_driver.sv` : Driver with error injection
* `fifo_monitor.sv` : Monitor
* `fifo_scoreboard.sv` : Reference model
* `fifo_assertions.sv` : SVA checks
* `fifo_coverage.sv` : Coverage model
* `fifo_env.sv` : Environment
* `tb.sv` : Testbench

---

## Requirements

* SystemVerilog simulator (VCS, Questa, Xcelium)
* Support for assertions and coverage

---

## Verification Goals

* Ensure correct FIFO data ordering (FIFO property)
* Validate full/empty flag behavior
* Detect overflow/underflow conditions
* Achieve high functional coverage
* Verify robustness using error injection

---

## License

Free for educational and learning purposes
