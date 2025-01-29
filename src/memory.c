#include <stdint.h>
#include "stdio.h"
#include "multiboot.h"



void initMemory(struct multiboot_info* bootInfo){

    uint32_t offset = 0;
    
    while (offset < bootInfo->mmap_length) {
        struct multiboot_mmap_entry* mmmt = (struct multiboot_mmap_entry*)(bootInfo->mmap_addr + offset);

        printf("Low Addr: %x | High Addr: %x | Length Low: %x | Length High: %x | Type: %d\n",
            mmmt->addr_low, mmmt->addr_high, mmmt->len_low, mmmt->len_high, mmmt->type);

        // Move to the next entry
        offset += mmmt->size + 4;
    }
    // for( uint32_t i = 0; i < bootInfo->mmap_length; i += sizeof(struct multiboot_mmap_entry))
    // {
    //     struct multiboot_mmap_entry *mmmt = (struct multiboot_mmap_entry*)(bootInfo->mmap_addr + i);

    //     printf("Low Addr: %x | High Addr: %x | Length Low: %x | Length High: %x | Type: %d",
    //         mmmt->addr_low, mmmt->addr_high, mmmt->len_low, mmmt->len_high, mmmt->type);
    // }
}