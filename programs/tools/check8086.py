#!/usr/bin/env python3
"""
Check assembly listing file for non-8086 instructions.
Usage: check8086.py <listing_file>

The tool parses the listing file and checks opcodes for instructions
that are not available on the 8086 CPU (but available on 80186+).

This is useful because as86 even with -0 option can produce 80186+ code
without warning.
"""

import sys
import re

# Invalid opcodes for 8086 (available on 80186 or later)
INVALID_OPCODES = {
    0x0F,              # 80186+ prefix for extended instructions
    0xC0, 0xC1,        # 80186+ shift/rotate with immediate count
    0xC8, 0xC9,        # ENTER, LEAVE (80186+)
    0xD6,              # Undocumented/80186+ SALC
    0xF1,              # Undocumented INT1/ICEBP
}

# Add 0x60-0x6F range (80186+ PUSHA, POPA, BOUND, etc.)
INVALID_OPCODES.update(range(0x60, 0x70))

# Add 0xD8-0xDF range (x87 FPU instructions)
INVALID_OPCODES.update(range(0xD8, 0xE0))

def parse_listing_line(line):
    """
    Parse a listing file line and extract line number, address, and opcode.

    Format:
    - Column 1-5 (0-based: 0-4): line number (decimal)
    - Column 7-10 (0-based: 6-9): hex address
    - Column 22-23 (0-based: 21-22): hex opcode

    Returns: (line_num, address, opcode) or (None, None, None) if parsing fails
    """
    if len(line) < 23:
        return None, None, None

    try:
        # Extract line number (columns 1-5, 1-based)
        line_num_str = line[0:5].strip()
        if not line_num_str:
            return None, None, None
        line_num = int(line_num_str)

        # Extract address (columns 7-10, 1-based = 6-9 0-based)
        addr_str = line[6:10].strip()
        if not addr_str:
            return None, None, None
        address = int(addr_str, 16)

        # Extract opcode (columns 22-23, 1-based = 21-22 0-based)
        opcode_str = line[21:23].strip()
        if not opcode_str or len(opcode_str) != 2:
            return None, None, None
        opcode = int(opcode_str, 16)

        return line_num, address, opcode

    except (ValueError, IndexError):
        return None, None, None

def check_listing_file(filename):
    """
    Check listing file for non-8086 instructions.

    Returns: (error_count, warnings)
    """
    errors = []

    try:
        with open(filename, 'r') as f:
            for line in f:
                line_num, address, opcode = parse_listing_line(line)

                # Skip lines that don't have valid instruction data
                if line_num is None:
                    continue

                # Check if opcode is invalid for 8086
                if opcode in INVALID_OPCODES:
                    # Determine instruction type for better error message
                    if opcode == 0x0F:
                        instr_type = "80186+ extended instruction prefix"
                    elif 0x60 <= opcode <= 0x6F:
                        instr_type = "80186+ instruction (PUSHA/POPA/BOUND/etc)"
                    elif opcode in (0xC0, 0xC1):
                        instr_type = "80186+ shift/rotate with immediate"
                    elif opcode in (0xC8, 0xC9):
                        instr_type = "80186+ ENTER/LEAVE"
                    elif 0xD8 <= opcode <= 0xDF:
                        instr_type = "x87 FPU instruction"
                    elif opcode == 0xD6:
                        instr_type = "undocumented/80186+ SALC"
                    elif opcode == 0xF1:
                        instr_type = "undocumented INT1/ICEBP"
                    else:
                        instr_type = "non-8086 instruction"

                    errors.append({
                        'line': line_num,
                        'address': address,
                        'opcode': opcode,
                        'type': instr_type,
                        'text': line.rstrip()
                    })

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found", file=sys.stderr)
        return -1, []
    except Exception as e:
        print(f"Error reading file: {e}", file=sys.stderr)
        return -1, []

    return len(errors), errors

def main():
    if len(sys.argv) != 2:
        print("Usage: check8086.py <listing_file>", file=sys.stderr)
        print("Example: check8086.py firmware.lst", file=sys.stderr)
        sys.exit(1)

    listing_file = sys.argv[1]

    print(f"Checking {listing_file} for non-8086 instructions...")

    error_count, errors = check_listing_file(listing_file)

    if error_count < 0:
        sys.exit(1)

    if error_count == 0:
        print("✓ No non-8086 instructions found")
        sys.exit(0)
    else:
        print(f"\n✗ Found {error_count} non-8086 instruction(s):\n")
        for err in errors:
            print(f"Line {err['line']:4d} @ 0x{err['address']:04X}: "
                  f"Opcode 0x{err['opcode']:02X} - {err['type']}")
            print(f"  {err['text']}")
            print()

        print(f"ERROR: {error_count} non-8086 instruction(s) detected!")
        print("These instructions are not available on the original 8086 CPU.")
        sys.exit(1)

if __name__ == "__main__":
    main()
