# Compiler and Assembler
AS = /usr/opt/cross/bin/i686-elf-as
CC = /usr/opt/cross/bin/i686-elf-gcc
LD = /usr/opt/cross/bin/i686-elf-gcc

# Flags
CFLAGS = -c -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T src/linker.ld -ffreestanding -O2 -nostdlib -lgcc

# Files
C_SRC = $(wildcard src/*.c)
ASM_SRC = $(wildcard src/*.s)
C_OBJ = $(patsubst src/%.c, build/%.o, $(C_SRC))
ASM_OBJ = $(patsubst src/%.s, build/%.o, $(ASM_SRC))
IMG_NAME = myos.bin
ISO_NAME = myos.iso

# Default target
all: $(IMG_NAME)

# Ensure build directory exists
build:
	mkdir -p build

# Compile C code (handles all .c files automatically)
build/%.o: src/%.c | build
	$(CC) $(CFLAGS) $< -o $@

# Assemble all ASM files (handles all .s files automatically)
build/%.o: src/%.s | build
	$(AS) $< -o $@

# Link everything into a binary OS image
$(IMG_NAME): $(ASM_OBJ) $(C_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# Create an ISO using GRUB
$(ISO_NAME): $(IMG_NAME)
	./make_bootable.sh

# Clean up
clean:
	rm -rf build $(IMG_NAME) $(ISO_NAME)
