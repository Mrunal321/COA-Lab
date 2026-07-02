# COA Lab Work

This folder contains one self-contained lab handout PDF, Verilog source files, and simple associated testbenches for a beginner-level lab on adders, multipliers, and ALU design.

## Folder Structure

- `handout/` - LaTeX source and generated PDF handout. Use this PDF for both explanation and lab instructions.
- `verilog/01_adders/` - Half adder, full adder, and simple testbenches.
- `verilog/02_ripple_carry_adder/` - 4-bit ripple carry adder and testbench.
- `verilog/03_multiplier/` - 4-bit multiplier and testbench.
- `verilog/04_alu/` - 4-bit ALU and testbench.
- `demo/` - Suggested demo flow.

## Demo Order

1. Half adder
2. Full adder
3. 4-bit ripple carry adder
4. 4-bit multiplier
5. 4-bit ALU

The testbenches are intentionally simple. They only apply input values over time and then stop. They do not contain display tables or tool-specific instructions.

The design files avoid behavioral ALU code. The adders and ALU use `wire` and `assign`. The starter ALU implements ADD, SUB, AND, and OR; the remaining ALU opcodes are left for students to implement as assignment tasks.
