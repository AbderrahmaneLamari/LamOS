.global gdt_flush

gdt_flush:
    movl 4(%esp), %eax   # Load the GDT pointer from the stack into EAX
    lgdt (%eax)          # Load the GDT using the pointer

    mov $0x10, %ax       # Load the data segment selector (0x10) into AX
    mov %ax, %ds         # Reload the data segment registers
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    ljmp $0x08, $.flush  # Far jump to reload CS with the code segment selector (0x08)
.flush:
    ret                  # Return

.global tss_flush

tss_flush:
    mov $0x2B, %ax       # Load the TSS segment selector (0x2B) into AX
    ltr %ax              # Load the task register (TR) with the TSS selector
    ret                  # Return