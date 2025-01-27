#include "keyboard.h"
#include "idt.h"
#include "io.h"




// Scancode to character mapping for a simple US layout
const char scancode_to_char[KEYBOARD_SCANCODE_COUNT] = {
    0, 0, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 
    0, 0, 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 
    0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', 
    0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, 
    0, ' ', 0, 0
};

// Keyboard interrupt handler
void keyboard_handler(struct InterruptRegisters *regs) {
    // Read the scancode from the keyboard port (0x60)
    // The mask 0x7f retrieves only the key code, without the information of press/relesase.

    unsigned char scancode = inb(0x60) & 0x7f;

    // This tells us if the key was pressed or released
    unsigned char pressed = inb(0x60) & 0x80; 
    terminal_writestring("AA");
}

// Initialize the keyboard interrupt
void init_keyboard_interrupt() {
    for(size_t i = 0; i < 16; i++)
    {
         irq_install_handler(i, &keyboard_handler);  // Install the handler for IRQ1 (keyboard)
    }
   
}
