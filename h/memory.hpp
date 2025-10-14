//
// Created by os on 10/14/25.
//

#ifndef PROJECT_BASE_MEMORY_HPP
#define PROJECT_BASE_MEMORY_HPP

#include "../lib/hw.h"

class memory {
private:
    struct FreeBlock{
        FreeBlock* next;
        size_t size;
    };

    static FreeBlock* freeHead;

    static void tryToJoin(FreeBlock* block);

public:
    static void initialize();

    static void* allocateMemory(size_t size);
    static int freeMemory(void* ptr);
    static size_t getFreeSpace();
    static size_t getLargestFreeBlock();
};


#endif //PROJECT_BASE_MEMORY_HPP
