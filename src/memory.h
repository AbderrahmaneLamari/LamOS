
extern uint8_t boot_page_directory[4096]; 


void initMemory(uint32_t memHigh, uint32_t physicalAddress);
void pmm_init(uint32_t memLow, uint32_t memHigh);
void invalidate(uint32_t vaddr);


#define KERNEL_START 0xc0000000
#define PAGE_FLAG_PRESENT (1 << 0)
#define PAGE_FLAG_WRITE (1 << 1)