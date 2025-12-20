NASM ?= nasm
PY   ?= python
BCC ?= bcc
AS86 ?= as86
LD86 ?= ld86

SRCS := $(wildcard *.asm)
BINS := $(SRCS:.asm=.bin)
HEXS := $(SRCS:.asm=.hex)

# Select which program to install as program.hex for the SoC
PROGRAM ?= blinky

.PHONY: all clean

all: $(BINS) $(HEXS) soc_hdmi.hex

# Assemble NASM flat binaries
%.bin: %.asm
	$(NASM) -f bin -o $@ $<

# Convert to contiguous 128KB hex using hexdump:
# - Prepend 64KB of zeros, then place program in the upper 64KB
# - Truncate/pad program to exactly 64KB so total is 128KB
%.hex: %.bin
	dd if=/dev/zero of="$@.img" bs=65536 count=2
	dd if="$<" of="$@.img" bs=65536 count=1 seek=1 conv=notrunc
	hexdump -v -e '1/1 "%02x\n"' "$@.img" > "$@"
	rm -f "$@.img"

soc_hdmi.bin: soc_hdmi.c
	$(BCC) -0 -S soc_hdmi.s soc_hdmi.c
	$(AS86) -0 soc_hdmi.s -o soc_hdmi.o -l soc_hdmi.lst
	$(PY) tools/check8086.py soc_hdmi.lst
	$(LD86) -d -o $@ soc_hdmi.o

soc_hdmi.hex: soc_hdmi.bin
	$(PY) tools/build_hex.py soc_hdmi && cp soc_hdmi.hex ../src/soc_hdmi/

clean:
	rm -f $(BINS) $(HEXS) soc_hdmi.s soc_hdmi.o soc_hdmi.lst soc_hdmi.bin soc_hdmi.hex
