# Parameterised Combinational Building Blocks

## Project Overview
A reusable Verilog RTL library implementing parameterised combinational circuits. This project demonstrates hierarchical design, parameterisation, generate loops and functional verification.

## Modules Implemented

1. **Full Adder:** Basic 1-bit full adder.
2. **N-bit Adder:** Parameterised ripple-carry adder using full-adder instances and generate loops.
3. **N-bit Multiplexer:** Parameterised 2-to-1 multiplexer.
4. **Priority Encoder:** Parameterised priority encoder with valid output.
5. **Top Module:** Instantiates all three building blocks at 4-bit and 8-bit widths.

## Design Features
- Parameterised and reusable RTL.
- Named port connections.
- Hierarchical module instantiation.
- Generate loop implementation.
- Combinational logic only.
- No inferred latches.
- No clock or sequential logic.

## Verification
A self-checking Verilog testbench verifies:

- 4-bit and 8-bit adders.
- 4-bit and 8-bit multiplexers.
- 4-bit and 8-bit priority encoders.
- Exhaustive input combinations for adders and encoders.

## Simulation Result
**ALL TESTS PASSED SUCCESSFULLY!**

Simulation tool: Icarus Verilog

Waveform viewer: GTKWave

## Tools Used
- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code
- Git and GitHub

## Author
Niraj Kumar