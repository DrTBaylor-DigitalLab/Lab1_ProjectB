# Lab1_ProjectB: Hex to 7-Segment Display

## Objective

Complete a hex-to-7-segment decoder by implementing the missing case for the digit "8".

## Logic Function

Convert a 4-bit binary input to the appropriate 7-segment display pattern.

**Note:** The 7-segment display on the Basys3 is **active LOW** - a segment lights up when its signal is 0, not 1.

## I/O Mapping

| Signal | Direction | FPGA Pin | Description |
|--------|-----------|----------|-------------|
| sw[0]  | Input     | V17      | Hex bit 0 (LSB) |
| sw[1]  | Input     | V16      | Hex bit 1 |
| sw[2]  | Input     | W16      | Hex bit 2 |
| sw[3]  | Input     | W17      | Hex bit 3 (MSB) |
| seg[0] | Output    | W7       | Segment a (top) |
| seg[1] | Output    | W6       | Segment b (upper right) |
| seg[2] | Output    | U8       | Segment c (lower right) |
| seg[3] | Output    | V8       | Segment d (bottom) |
| seg[4] | Output    | U5       | Segment e (lower left) |
| seg[5] | Output    | V5       | Segment f (upper left) |
| seg[6] | Output    | U7       | Segment g (middle) |
| an[0]  | Output    | U2       | Digit 0 anode (rightmost) |
| an[1]  | Output    | U4       | Digit 1 anode |
| an[2]  | Output    | V4       | Digit 2 anode |
| an[3]  | Output    | W4       | Digit 3 anode |

## 7-Segment Layout

```
   aaaa
  f    b
  f    b
   gggg
  e    c
  e    c
   dddd
```

## Your Task

Edit **`rtl/hex_to_7seg.v`** and fix line 36 to display the digit "8" correctly.

Look at the pattern: the digit "8" lights up **all seven segments** (a through g).

Since the display is **active LOW**, what value should `seg_reg` be when all segments are ON?

### Hint

Look at the other cases in the file:
- When a segment should be ON, its bit is `0`
- When a segment should be OFF, its bit is `1`

For example, the digit "0" uses `7'b1000000` because segment g (middle) is OFF and all others are ON.

### Expected Patterns (Active LOW)

| Hex | Display | seg[6:0] (gfedcba) | Segments ON |
|-----|---------|-------------------|-------------|
| 0   | 0       | 1000000 | a,b,c,d,e,f |
| 1   | 1       | 1111001 | b,c |
| 2   | 2       | 0100100 | a,b,d,e,g |
| 3   | 3       | 0110000 | a,b,c,d,g |
| 4   | 4       | 0011001 | b,c,f,g |
| 5   | 5       | 0010010 | a,c,d,f,g |
| 6   | 6       | 0000010 | a,c,d,e,f,g |
| 7   | 7       | 1111000 | a,b,c |
| **8** | **8** | **???????** | **a,b,c,d,e,f,g** |
| 9   | 9       | 0010000 | a,b,c,d,f,g |
| A   | A       | 0001000 | a,b,c,e,f,g |
| B   | b       | 0000011 | c,d,e,f,g |
| C   | C       | 1000110 | a,d,e,f |
| D   | d       | 0100001 | b,c,d,e,g |
| E   | E       | 0000110 | a,d,e,f,g |
| F   | F       | 0001110 | a,e,f,g |

## Verification

### 1. Automated Testing (CI)

Push your changes to GitHub. The CI workflow will:
- Compile your Verilog code with Icarus Verilog
- Run the self-checking testbench
- Report PASS/FAIL for all 16 hex values

### 2. Hardware Testing

1. Open Vivado and create a new project
2. Add source files from `rtl/` folder
3. Add constraints file from `constraints/` folder
4. Set `hex_to_7seg_wrapper` as the top module
5. Run Synthesis, Implementation, and Generate Bitstream
6. Program the Basys3 board
7. Toggle sw[3:0] and verify the rightmost display shows the correct hex digit
8. **Specifically test sw = 1000 (binary) to verify "8" displays correctly**

## Project Structure

```
Lab1_ProjectB/
├── rtl/
│   ├── hex_to_7seg.v           # Core module (FIX LINE 36)
│   └── hex_to_7seg_wrapper.v   # Hardware wrapper (DO NOT MODIFY)
├── tb/
│   └── hex_to_7seg_tb.v        # Self-checking testbench
├── constraints/
│   └── basys3.xdc              # Pin constraints
├── .github/workflows/
│   └── test.yml                # CI workflow
├── .gitignore
└── README.md
```
