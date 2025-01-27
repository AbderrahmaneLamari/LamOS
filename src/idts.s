.global idt_flush
idt_flush:
    movl 4(%esp), %eax   # Load the IDT descriptor pointer from the stack into EAX
    lidt (%eax)          # Load the IDT using the descriptor pointer
    sti                  # Enable interrupts
    ret                  # Return

# Macro for ISRs without error codes
.macro ISR_NOERRCODE num
    .global isr\num
isr\num:
    cli                  # Disable interrupts
    pushl $0             # Push a dummy error code (0)
    pushl $\num          # Push the interrupt number
    jmp isr_common_stub  # Jump to the common ISR handler
.endm

# Macro for ISRs with error codes
.macro ISR_ERRCODE num
    .global isr\num
isr\num:
    cli                  # Disable interrupts
    pushl $\num          # Push the interrupt number
    jmp isr_common_stub  # Jump to the common ISR handler
.endm

# Macro for IRQs
.macro IRQ irq_num, int_num
    .global irq\irq_num
irq\irq_num:
    cli                  # Disable interrupts
    pushl $0             # Push a dummy error code (0)
    pushl $\int_num      # Push the interrupt number
    jmp irq_common_stub  # Jump to the common IRQ handler
.endm

# Define ISRs
ISR_NOERRCODE 0
ISR_NOERRCODE 1
ISR_NOERRCODE 2
ISR_NOERRCODE 3
ISR_NOERRCODE 4
ISR_NOERRCODE 5
ISR_NOERRCODE 6
ISR_NOERRCODE 7

ISR_ERRCODE 8
ISR_NOERRCODE 9
ISR_ERRCODE 10
ISR_ERRCODE 11
ISR_ERRCODE 12
ISR_ERRCODE 13
ISR_ERRCODE 14
ISR_NOERRCODE 15
ISR_NOERRCODE 16
ISR_NOERRCODE 17
ISR_NOERRCODE 18
ISR_NOERRCODE 19
ISR_NOERRCODE 20
ISR_NOERRCODE 21
ISR_NOERRCODE 22
ISR_NOERRCODE 23
ISR_NOERRCODE 24
ISR_NOERRCODE 25
ISR_NOERRCODE 26
ISR_NOERRCODE 27
ISR_NOERRCODE 28
ISR_NOERRCODE 29
ISR_NOERRCODE 30
ISR_NOERRCODE 31
ISR_NOERRCODE 128
ISR_NOERRCODE 177

# Define IRQs
IRQ 0, 32
IRQ 1, 33
IRQ 2, 34
IRQ 3, 35
IRQ 4, 36
IRQ 5, 37
IRQ 6, 38
IRQ 7, 39
IRQ 8, 40
IRQ 9, 41
IRQ 10, 42
IRQ 11, 43
IRQ 12, 44
IRQ 13, 45
IRQ 14, 46
IRQ 15, 47

# Common ISR stub
.extern isr_handler
isr_common_stub:
    pusha                # Save all general-purpose registers
    mov %ds, %eax        # Save the data segment descriptor
    push %eax
    mov %cr2, %eax       # Save the value of CR2 (page fault address)
    push %eax

    mov $0x10, %ax       # Load the kernel data segment descriptor
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs

    push %esp            # Push the stack pointer (points to the interrupt frame)
    call isr_handler     # Call the C ISR handler
    add $8, %esp         # Clean up the stack

    pop %ebx             # Restore the data segment descriptor
    mov %bx, %ds
    mov %bx, %es
    mov %bx, %fs
    mov %bx, %gs

    popa                 # Restore all general-purpose registers
    add $8, %esp         # Clean up the error code and interrupt number
    sti                  # Enable interrupts
    iret                 # Return from interrupt

# Common IRQ stub
.extern irq_handler
irq_common_stub:
    pusha                # Save all general-purpose registers
    mov %ds, %eax        # Save the data segment descriptor
    push %eax
    mov %cr2, %eax       # Save the value of CR2 (page fault address)
    push %eax

    mov $0x10, %ax       # Load the kernel data segment descriptor
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs

    push %esp            # Push the stack pointer (points to the interrupt frame)
    call irq_handler     # Call the C IRQ handler
    add $8, %esp         # Clean up the stack

    pop %ebx             # Restore the data segment descriptor
    mov %bx, %ds
    mov %bx, %es
    mov %bx, %fs
    mov %bx, %gs

    popa                 # Restore all general-purpose registers
    add $8, %esp         # Clean up the error code and interrupt number
    sti                  # Enable interrupts
    iret                 # Return from interrupt