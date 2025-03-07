#include <stdint.h>
#include "util.h"
#include "stdio.h"
#include "multiboot.h"
#include "memory.h"


static uint32_t FrameMin;
static uint32_t FrameMax;
static uint32_t totalAlloc;

#define NUM_PAGES_DIR 256
#define NUM_PAGE_FRAMES (0x10000000 / 0x1000 / 8)

uint8_t physicalMemoryBitmap[NUM_PAGE_FRAMES];

static uint32_t pageDirs[NUM_PAGES_DIR][1024] __attribute__((aligned(4096)));
static uint8_t pageDirUsed[NUM_PAGES_DIR];

void pmm_init(uint32_t memLow, uint32_t memHigh){

    FrameMin = CEIL_DIVISION(memLow, 0x1000);
    FrameMax = memHigh / 0x1000;
    totalAlloc = 0;

    memset(physicalMemoryBitmap, 0, sizeof(physicalMemoryBitmap));
}


void initMemory(uint32_t memHigh, uint32_t physicalAddress){

    // boot_page_directory[0] = 0;
    // invalidate(0);

    // boot_page_directory[1023] = ((uint32_t) boot_page_directory - KERNEL_START);

    // invalidate(0xfffff000);

    // memset(pageDirs, 0, 0x1000 * NUM_PAGES_DIR);
    // memset(pageDirUsed, 0, NUM_PAGES_DIR);

    // pmm_init(memHigh, physicalAddress);
    
    printf("This is the end of initMem\n");

}

void invalidate(uint32_t vaddr){

    asm volatile ("invlpg %0" :: "m"(vaddr));
    
}