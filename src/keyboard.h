#ifndef KEYBOARD_H
#define KEYBOARD_H
#include <stdint.h>
#include "util.h"  // To define the InterruptRegisters structure
#include "terminal.h"     // For terminal output

// Keyboard I/O ports
#define KEYBOARD_PORT 0x60
#define KEYBOARD_CMD_PORT 0x64

// Keyboard scancodes
#define KEYBOARD_SCANCODE_COUNT 58

extern const char scancode_to_char[KEYBOARD_SCANCODE_COUNT];

// Function to initialize the keyboard interrupt
void init_keyboard_interrupt(void);

// Keyboard interrupt handler function
void keyboard_handler(struct InterruptRegisters *regs);

#endif // KEYBOARD_H
