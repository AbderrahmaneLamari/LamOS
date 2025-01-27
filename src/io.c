#include "io.h"


// Inline functions for reading/writing I/O ports
unsigned char inb(unsigned short port) {
    unsigned char result;
    asm volatile ("inb %1, %0" : "=a" (result) : "d" (port));
    return result;
}

void outb(unsigned char value, unsigned short port) {
    asm volatile ("outb %0, %1" : : "a" (value), "d" (port));
}