# UVM FIFO Project

This repository contains the Universal Verification Methodology (UVM) environment developed for a First-In-First-Out (FIFO) design written in SystemVerilog (SV). The project involves implementing a full verification environment using UVM to ensure the correctness of the FIFO design through a comprehensive verification plan. 

## Project Overview

In this project, a FIFO design was verified using UVM. The verification environment covers various aspects such as constrained random stimulus generation, functional coverage, and assertions to validate the behavior of the FIFO under various conditions.

### Steps Involved:
1. **UVM Environment Creation**:
    - A complete UVM environment was created for the FIFO design, including a driver, monitor, scoreboard, and coverage collector.
   
2. **Sequence Item Class Constraints**:
    - Constraints were added in the sequence item class to control the generation of random stimuli, ensuring that the generated sequences are valid according to the design's specifications.

3. **Coverage**:
    - Covergroups and coverpoints were added in the coverage collector class to track the functional coverage and ensure all design scenarios are verified.

4. **Assertions**:
    - Assertions were written and bound to the top module to verify specific conditions in the FIFO, such as overflow, underflow, and correct read/write functionality.
    
5. **Main Sequence Splitting**:
    - The main verification sequence was split into several smaller sequences based on the verification plan. These sequences include:
        - **write_only_sequence**: Verifies only the write functionality.
        - **read_only_sequence**: Verifies only the read functionality.
        - **write_read_sequence**: Verifies both read and write functionality together.

## Features
- **Full UVM environment** for FIFO verification.
- **Constrained random testing** via sequence item class constraints.
- **Functional coverage** using covergroups and coverpoints.
- **Assertions** to ensure key FIFO properties (e.g., underflow, overflow).
- **Multiple sequences** to target specific functionality like write-only, read-only, and combined write-read operations.

## Verification Plan
The verification plan focuses on covering all possible scenarios, such as:
- Write and read operations in isolation and in combination.
- Handling edge cases like FIFO full, FIFO empty, almost full, and almost empty.
- Overflow and underflow conditions.

## File Structure
- `/src/` - Contains the SystemVerilog FIFO design.
- `/tb/` - Contains the UVM testbench, including the driver, monitor, sequence, and scoreboard.
- `/coverage/` - Contains the functional and code coverage reports.
- `/docs/` - Documentation, including verification plan, UVM structure, and bug reports.

## Requirements
- **QuestaSim** for simulation and waveform analysis.
- **SystemVerilog** for design and testbench.
- **UVM** framework for verification.

## How to Run
1. Clone the repository:
   ```
   git clone https://github.com/yourusername/UVM_FIFO_Project.git
   ```
2. Set up your environment to support UVM and SystemVerilog simulation.
3. Run the UVM testbench:
   ```
   vsim -do run.do
   ```

## Reports
- **Code Coverage Report**: A detailed report showing which portions of the FIFO design were covered by the tests.
- **Functional Coverage Report**: Shows how well the verification plan's functional requirements were met.
- **Sequential Domain Coverage Report**: Covers the timing and order of operations like read/write sequences.
- **Bug Report**: Documents any issues found during the verification process.

