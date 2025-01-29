#include "idt.h"
#include "gdt.h"
#include "terminal.h"
#include "timer.h"
#include "keyboard.h"
#include "stdio.h"
#include "multiboot.h"
#include "memory.h"

/* Check if the compiler thinks you are targeting the wrong operating system. */
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

/* This tutorial will only work for the 32-bit ix86 targets. */
#if !defined(__i386__)
#error "This tutorial needs to be compiled with a ix86-elf compiler"
#endif

void kernel_main(uint32_t magic, struct multiboot_info* bootInfo);

void kernel_main(uint32_t magic, struct multiboot_info* bootInfo) 
{
	/* Initialize terminal interface */
	terminal_initialize();
	terminal_writestring("Terminal is Initialized\n");
	
	/* Initialize the Global Descriptor Table */
	initGdt();
	terminal_writestring("GDT is Done Loading\n");
	
	/* Load interrupt vector */
	initIdt();
	terminal_writestring("IDT is Done Loading\n");

	/* Initialize timer interrupt handler */
	initTimer();

	/* Load Keyboard handler */
	init_keyboard();

	/* Initialize Memory */
	initMemory(bootInfo);
	

	for(;;);
}