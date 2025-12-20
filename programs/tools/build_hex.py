#!/usr/bin/env python3
"""
Build firmware.hex from firmware.bin and firmware.lst

Creates a 128KB memory image:
- First 64KB (0x00000-0x0FFFF): Lower RAM
- Second 64KB (0x10000-0x1FFFF): Firmware at F000:0000
- Reset vector at 0x1FFF0: FAR JMP to F000:start
- Byte at 0x1FFFF: 0xFF
"""

import sys
import struct
import re

def find_start_address(lst_file):
    """
    Find the address of the 'start' symbol from the listing file.

    Looks for patterns like:
    - "export _start" or "export start"
    - "_start:" or "start:" with address

    Returns: start address (16-bit) or None if not found
    """
    try:
        with open(lst_file, 'r') as f:
            # First pass: find exported start symbol name
            start_name = None
            for line in f:
                if 'export' in line.lower() and 'start' in line.lower():
                    # Extract symbol name from export line
                    match = re.search(r'export\s+(_?\w*start\w*)', line, re.IGNORECASE)
                    if match:
                        start_name = match.group(1)
                        print(f"Found exported symbol: {start_name}")
                        break

            # If no export found, look for start label directly
            if not start_name:
                start_name = 'start'
                print(f"No export found, looking for label: {start_name}")

            # Second pass: find the address of the start symbol
            f.seek(0)
            for line in f:
                # Look for label definition with address
                # Format: "00275                       000000E2>           start:"
                # or:     "00276 00E2           FA                     cli"
                if f'{start_name}:' in line:
                    # Try to extract address from label format: "000000E2>           start:"
                    match = re.search(r'([0-9A-Fa-f]{8})>\s+' + re.escape(start_name) + r':', line)
                    if match:
                        # Extract last 4 hex digits (offset within segment)
                        addr = int(match.group(1)[-4:], 16)
                        print(f"Found {start_name} at address: 0x{addr:04X}")
                        return addr

                    # Try instruction format: address at columns 7-10
                    if len(line) > 10:
                        addr_str = line[6:10].strip()
                        if addr_str and addr_str.replace(' ', ''):
                            try:
                                addr = int(addr_str, 16)
                                print(f"Found {start_name} at address: 0x{addr:04X}")
                                return addr
                            except ValueError:
                                pass

            print(f"Warning: Could not find '{start_name}' address in listing file")
            return 0  # Default to 0 if not found

    except FileNotFoundError:
        print(f"Error: Listing file '{lst_file}' not found")
        return 0
    except Exception as e:
        print(f"Error parsing listing file: {e}")
        return 0

def build_firmware_hex(bin_file, lst_file, hex_file):
    """
    Build firmware.hex from firmware.bin and firmware.lst
    """
    # Read firmware binary
    try:
        with open(bin_file, 'rb') as f:
            firmware = f.read()
    except FileNotFoundError:
        print(f"Error: Binary file '{bin_file}' not found")
        sys.exit(1)

    firmware_size = len(firmware)
    print(f"Read {firmware_size} bytes from {bin_file}")

    # Find start address from listing file
    start_addr = find_start_address(lst_file)
    print(f"Start address: 0x{start_addr:04X}")

    # Create 128KB zero-filled image
    image = bytearray(128 * 1024)

    # Place firmware at offset 64KB (0x10000)
    # This maps to segment F000:0000 in real mode
    firmware_offset = 64 * 1024
    image[firmware_offset:firmware_offset + firmware_size] = firmware
    print(f"Placed firmware at offset 0x{firmware_offset:05X}")

    # Build reset vector at 0x1FFF0 (physical address FFFF0h = F000:FFF0)
    # Format: EA <offset_low> <offset_high> <segment_low> <segment_high>
    # This is a FAR JMP to F000:start
    reset_vector_offset = 0x1FFF0

    # FAR JMP opcode
    image[reset_vector_offset] = 0xEA

    # Offset (start address)
    image[reset_vector_offset + 1] = start_addr & 0xFF        # Low byte
    image[reset_vector_offset + 2] = (start_addr >> 8) & 0xFF # High byte

    # Segment (F000h)
    image[reset_vector_offset + 3] = 0x00  # Segment low byte
    image[reset_vector_offset + 4] = 0xF0  # Segment high byte

    print(f"Reset vector at 0x{reset_vector_offset:05X}: "
          f"FAR JMP to F000:{start_addr:04X}")

    # Set last byte to 0xFF
    image[0x1FFFF] = 0xFF
    print(f"Set byte at 0x1FFFF to 0xFF")

    # Write hex file (one byte per line)
    with open(hex_file, 'w') as f:
        for byte in image:
            f.write(f"{byte:02x}\n")

    print(f"Generated {hex_file} ({len(image)} bytes)")

def main():
    bin_file = f'{sys.argv[1]}.bin'
    lst_file = f'{sys.argv[1]}.lst'
    hex_file = f'{sys.argv[1]}.hex'

    build_firmware_hex(bin_file, lst_file, hex_file)

if __name__ == "__main__":
    main()
