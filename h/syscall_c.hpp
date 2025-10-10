//
// Created by os on 10/7/25.
//

#ifndef PROJECT_BASE_SYSCALL_C_HPP
#define PROJECT_BASE_SYSCALL_C_HPP

#include "../lib/hw.h"

namespace Num{
    constexpr uint8 SCALL_MEM_ALLOC = 0x01;
    constexpr uint8 SCALL_MEM_FREE = 0x02;
    constexpr uint8 SCALL_MEM_GET_FREE_SPACE = 0x03;
    constexpr uint8 SCALL_MEM_GET_LARGEST_FREE_BLOCK = 0x04;
    constexpr uint8 SCALL_THREAD_CREATE= 0x11;
    constexpr uint8 SCALL_THREAD_EXIT = 0x12;
    constexpr uint8 SCALL_THREAD_DISPATCH = 0x13;
    constexpr uint8 SCALL_SEM_OPEN = 0x21;
    constexpr uint8 SCALL_SEM_CLOSE = 0x22;
    constexpr uint8 SCALL_SEM_WAIT = 0x23;
    constexpr uint8 SCALL_SEM_SIGNAL = 0x24;
}



void* mem_alloc(size_t size);
int mem_free(void*);
size_t mem_get_free_space();
size_t mem_get_largest_free_block();
class _thread;
typedef _thread* thread_t;
int thread_create(
        thread_t* handle,
        void(*start_routine)(void*),
        void* arg
);
int thread_exit();
void thread_dispatch();
class _sem;
typedef _sem* sem_t;
int sem_open(
        sem_t* handle,
        unsigned init
);
int sem_close(sem_t handle);
int sem_wait(sem_t id);
int sem_signal(sem_t id);


#endif //PROJECT_BASE_SYSCALL_C_HPP
