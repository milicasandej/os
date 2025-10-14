//
// Created by os on 10/14/25.
//

#include "../h/memory.hpp"

memory::FreeBlock* memory::freeHead = nullptr;

void memory::initialize() {
    freeHead = (FreeBlock*) HEAP_START_ADDR;
    freeHead->size = (size_t)((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR);
    freeHead->next = nullptr;
}

void *memory::allocateMemory(size_t size) {
    if (size == 0) return nullptr;

    // zaokruzujemo na MEM_BLOCK_SIZE
    size = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE * MEM_BLOCK_SIZE;

    // rezervisemo i header za slobodni blok ako ga cepamo
    size_t totalSize = size + sizeof(FreeBlock);

    FreeBlock* bestPrev = nullptr;
    FreeBlock* best = nullptr;
    FreeBlock* prev = nullptr;

    // pronalazak najmanjeg dovoljno velikog bloka (best-fit)
    for(FreeBlock* curr = freeHead; curr; curr = curr->next){
        if (curr->size >= totalSize){
            if (!best || curr->size < best->size){
                best = curr;
                bestPrev = prev;
            }
        }
        prev = curr;
    }

    if (!best) return nullptr; // nema dovoljno memorije

    size_t remaining = best->size - totalSize;

    if (remaining >= sizeof(FreeBlock) + MEM_BLOCK_SIZE){
        // cepamo blok
        FreeBlock* newBlock = (FreeBlock*)((char*)best + totalSize);
        newBlock->size = remaining;
        newBlock->next = best->next;
        best->size = totalSize;
        if (bestPrev) bestPrev->next = newBlock;
        else freeHead = newBlock;
    }
    else{
        // koristimo ceo blok
        if (bestPrev) bestPrev->next = best->next;
        else freeHead = best->next;
    }

    // vracamo pokazivac na korisnicki deo, posle headera
    return (void *)((char*)best + sizeof(FreeBlock));
}

int memory::freeMemory(void *ptr) {
    if (!ptr) return -1;

    FreeBlock* block = (FreeBlock*)((char*)ptr - sizeof(FreeBlock));

    if (block < (FreeBlock*)HEAP_START_ADDR || block >= (FreeBlock*)HEAP_END_ADDR) return -2; // van heapa

    if (!freeHead || block < freeHead){
        block->next = freeHead;
        freeHead = block;
        tryToJoin(block);
        return 0;
    }

    FreeBlock* curr = freeHead;
    while(curr->next && curr->next < block) curr = curr->next;

    block->next = curr->next;
    curr->next = block;

    tryToJoin(curr);
    return 0;
}

void memory::tryToJoin(memory::FreeBlock *block) {
    if(!block || !block->next) return;

    char* endOfBlock = (char*)block + block->size;
    if (endOfBlock == (char*)block->next){
        block->size += block->next->size;
        block->next = block->next->next;
    }
}

size_t memory::getFreeSpace() {
    size_t total = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next) total += curr->size;
    return total;
}

size_t memory::getLargestFreeBlock() {
    size_t largest = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next){
        if (curr->size > largest) largest = curr->size;
    }
    return largest;
}
