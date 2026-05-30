# Single Cycle MIPS Processor

A simplified hardware implementation of a MIPS processor that executes one instruction per clock cycle. This project demonstrates fundamental concepts in computer architecture including instruction fetching, decoding, execution, and memory access.

## Overview

This is an educational implementation of a single-cycle MIPS processor written in Verilog. The processor executes MIPS instructions in a single clock cycle by performing all operations (fetch, decode, execute, memory access, and write-back) simultaneously.

### Key Features

- **32-bit Architecture**: Full 32-bit data path
- **32 Registers**: General-purpose register file
- **256-word Data Memory**: For load/store operations
- **128-word Instruction Memory**: Pre-loaded with sample programs
- **Supported Instructions**:
  - R-Type: ADD, SUB, AND, OR, SLT
  - I-Type: LW (Load Word), SW (Store Word), BEQ (Branch on Equal), ADDI (Add Immediate)

## Project Structure

```
Single Cycle MIPS/
├── Core Components
│   ├── alu.v                    # Arithmetic Logic Unit
│   ├── alu_control.v            # ALU control signal generator
│   ├── control_unit.v           # Main control decoder
│   ├── register_block.v         # 32-register file
│   ├── data_memory.v            # Data storage (RAM)
│   ├── instruction_memory.v     # Instruction storage (ROM)
│   
├── Support Components
│   ├── program_counter.v        # Instruction address counter
│   ├── adder.v                  # 32-bit adder for PC increment
│   ├── sign_extend.v            # 16-bit to 32-bit sign extension
│   ├── shift_left_2.v           # 2-bit left shift for branch addresses
│   ├── controller.v             # Alternative control decoder
│   
├── Top Module
│   ├── top.v                    # Main processor (ProcessorCore)
│   
├── Testbenches
│   ├── alu_tb.v                 # ALU tests
│   ├── alu_control_tb.v         # ALU control tests
│   ├── control_unit_tb.v        # Control unit tests
│   ├── data_memory_tb.v         # Data memory tests
│   ├── register_block_tb.v      # Register file tests
│   ├── testbench.v              # Full processor simulation
│   
└── Documentation
    └── README.md                # This file
```

## Component Description

### Compute Unit (`alu.v`)
The arithmetic logic unit that performs all mathematical and logical operations.

**Operations:**
- `0000`: AND
- `0001`: OR
- `0010`: ADD
- `0110`: SUB (Subtract)
- `0111`: SLT (Set on Less Than)
- `1100`: NOR

**Ports:**
- `operand_x`, `operand_y`: 32-bit inputs
- `operation_code`: 4-bit operation selector
- `result_value`: 32-bit output result
- `is_zero`: Flag indicating zero result

### Compute Control (`alu_control.v`)
Generates the 4-bit ALU control signal based on the 2-bit ALUOp field and 6-bit function code.

**ALUOp Encoding:**
- `00`: Load/Store operations (ADD)
- `01`: Branch operations (SUB)
- `10`: R-Type instructions (decode function code)

### Control Signals (`control_unit.v`)
Main control decoder that generates all control signals from the instruction opcode.

**Generated Signals:**
- `reg_select`: Register destination selection (R-type vs I-type)
- `branch_signal`: Enable branching
- `mem_read`: Enable memory read
- `mem_write`: Enable memory write
- `mem_to_reg`: Select data source (memory vs ALU)
- `alu_immediate`: Select ALU operand (register vs immediate)
- `reg_enable`: Enable register write
- `compute_op`: ALU operation selection (2-bit)

### Register File (`register_block.v`)
32 × 32-bit register storage with dual read and single write ports.

**Features:**
- Register 0 always reads/writes 0 (hard-wired)
- Asynchronous read
- Synchronous write (on clock edge)

### Data Memory (`data_memory.v`)
256-word × 32-bit RAM for data storage.

**Features:**
- Asynchronous read (combinational)
- Synchronous write (on clock edge)
- 10-bit address (256 locations)

### Instruction Memory (`instruction_memory.v`)
128-word × 32-bit ROM containing the program instructions (read-only).

### Program Counter (`program_counter.v`)
Holds the current instruction address and updates on clock edges.

### Address Counter Adder (`adder.v`)
32-bit adder for calculating PC + 4 or branch targets.

### Sign Extender (`sign_extend.v`)
Extends 16-bit immediate values to 32-bit by replicating the sign bit.

### Shift Left 2 (`shift_left_2.v`)
Implements a 2-bit left shift for branch address calculation (multiply by 4).

## Instruction Format

### R-Type Instruction (6 bits + 5 bits + 5 bits + 5 bits + 5 bits + 6 bits)
```
[opcode(6)] [rs(5)] [rt(5)] [rd(5)] [shamt(5)] [funct(6)]
[  31:26  ] [25:21] [20:16] [15:11] [ 10:6  ] [ 5:0  ]
```

### I-Type Instruction (6 bits + 5 bits + 5 bits + 16 bits)
```
[opcode(6)] [rs(5)] [rt(5)] [immediate(16)]
[  31:26  ] [25:21] [20:16] [    15:0    ]
```

## How to Use

### Running Simulations

1. **ALU Test**
   ```
   iverilog -o alu_sim alu.v alu_tb.v
   vvp alu_sim
   ```

2. **Register File Test**
   ```
   iverilog -o reg_sim register_block.v register_block_tb.v
   vvp reg_sim
   ```

3. **Full Processor Simulation**
   ```
   iverilog -o proc_sim top.v adder.v alu.v alu_control.v control_unit.v \
            data_memory.v instruction_memory.v program_counter.v \
            sign_extend.v shift_left_2.v testbench.v
   vvp proc_sim
   ```

### Expected Output

The testbench runs a predefined program stored in instruction memory. The simulation succeeds when the processor correctly writes the value -5 to memory address 84.

## Variable Naming Convention

This project uses descriptive naming to replace single-letter variables for better code clarity:

- `A, B` → `operand_x, operand_y`
- `clk` → `clk` (standard)
- `ALUControl` → `operation_code`
- `ALUResult` → `result_value`
- `Zero` → `is_zero`
- `pc` → `pc_val`
- `instr` → `fetched_instr`
- `readdata` → `mem_read_val`
- `writedata` → `store_data`
- `regdst` → `sel_reg_dest`
- `memread` → `mem_rd_en`
- `memwrite` → `mem_wr_en_int`
- `regwrite` → `reg_wr_en`
- `alusrc` → `sel_alu_imm`
- `memtoreg` → `sel_mem_data`
- `branch` → `branch_en`
- `zero` → `is_equal`
- `pcsrc` → `branch_take`

## Architecture Diagram

```
┌─────────────────┐
│  Instruction    │
│  Memory (ROM)   │
└────────┬────────┘
         │ instruction
         ▼
    ┌────────────┐
    │   Control  │
    │   Decoder  │────► Control Signals
    └────────────┘
         │
    ┌────┴────┬──────────────┐
    ▼         ▼              ▼
┌───────┐ ┌──────────┐  ┌──────────┐
│ ALU   │ │ Register │  │   Data   │
│Control│ │   File   │  │ Memory   │
└──┬────┘ └────┬─────┘  └────┬─────┘
   │           │             │
   └───────┬───┴─────────────┘
           ▼
       ┌────────┐
       │ Program│
       │Counter │
       └────┬───┘
            │
            ▼
    [Next Instruction]
```

## Program Counter Update Logic

**Branching:**
```
if (branch_enable & zero_flag)
    next_pc = current_pc + (sign_extended_offset << 2)
else
    next_pc = current_pc + 4
```

## Clock Timing

- **Clock Period**: Configurable (typically 10ns)
- **All Operations**: Occur within single clock cycle
- **Register Updates**: On rising clock edge

## Supported MIPS Instructions

| Instruction | Opcode | Type | Description |
|------------|--------|------|-------------|
| ADD | 000000 | R | Add: rd ← rs + rt |
| SUB | 000000 | R | Subtract: rd ← rs - rt |
| AND | 000000 | R | And: rd ← rs & rt |
| OR | 000000 | R | Or: rd ← rs \| rt |
| SLT | 000000 | R | Set on Less Than: rd ← (rs < rt) ? 1 : 0 |
| LW | 100011 | I | Load Word: rt ← memory[rs + offset] |
| SW | 101011 | I | Store Word: memory[rs + offset] ← rt |
| BEQ | 000100 | I | Branch on Equal: if rs == rt, pc ← pc + 4 + (offset << 2) |
| ADDI | 001000 | I | Add Immediate: rt ← rs + sign_extended(offset) |

## Memory Layout

### Instruction Memory
- **Size**: 128 words (32-bit each)
- **Access**: Read-only
- **Pre-loaded**: Yes (sample program)

### Data Memory
- **Size**: 256 words (32-bit each)
- **Access**: Read/Write
- **Initial State**: All zeros

### Register File
- **Size**: 32 registers (32-bit each)
- **Register 0**: Hard-wired to 0
- **Registers 1-31**: General purpose

## Example Program Flow

```
1. Fetch instruction from memory at PC
2. Decode instruction to generate control signals
3. Read operands from register file
4. Sign-extend immediate values if needed
5. Execute ALU operation
6. Read/Write data memory if needed
7. Write results back to register file
8. Update PC for next instruction
```

## Limitations

- Single-cycle execution limits clock frequency
- No pipelining (poor performance)
- No hazard detection
- No cache
- No exception handling
- Limited instruction set

## Future Enhancements

- [ ] Add pipelining for better performance
- [ ] Implement forwarding for hazard resolution
- [ ] Add jump instructions (J, JAL, JR)
- [ ] Implement more ALU operations
- [ ] Add floating-point support
- [ ] Implement interrupt handling

## Testing & Validation

Each component has an associated testbench:
- `alu_tb.v`: Tests all ALU operations
- `alu_control_tb.v`: Tests ALU control generation
- `control_unit_tb.v`: Tests control signal generation
- `data_memory_tb.v`: Tests memory read/write
- `register_block_tb.v`: Tests register operations
- `testbench.v`: Full processor integration test

Run testbenches individually or integrated for comprehensive validation.

## References

- MIPS Instruction Set Architecture (ISA)
- Computer Organization and Design (Patterson & Hennessy)
- Verilog HDL Reference Manual

## Author

Created as an educational project for learning computer architecture and Verilog hardware description language.

## License

This project is provided for educational purposes.

---

**Note**: This is a simplified processor designed for educational purposes. It demonstrates fundamental concepts but lacks many features found in real MIPS implementations.
