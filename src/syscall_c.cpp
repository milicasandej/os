//
// Created by os on 10/7/25.
//

#include "../h/syscall_c.hpp"
#include "../lib/mem.h"

#define READ_REG(var, regname) __asm__ volatile("mv %0, " regname: "=r"(var))
#define WRITE_REG(regname, val) __asm__ volatile("mv " regname ", %0" :: "r"(val))

void* mem_alloc(size_t size){
    return __mem_alloc(size); //TODO
}

int mem_free(void* ptr){
    return __mem_free(ptr); //TODO
}
//
//size_t mem_get_free_space(){
//    //TODO
//}
//
//size_t mem_get_largest_free_block(){
//    //TODO
//}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    void* stack = mem_alloc(DEFAULT_STACK_SIZE);

    WRITE_REG("a3", (uint64)stack + DEFAULT_STACK_SIZE);
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);

    __asm__ volatile("ecall");

    volatile uint64 ret;
    READ_REG(ret, "a0");
    return ret;
}

int thread_exit(){
    return -1;
}

void thread_dispatch(){
    return;
}

int sem_open(sem_t* handle, unsigned init){
    //TODO
    return -1;
}

int sem_close(sem_t handle) {
    //TODO
    return -1;
}

int sem_wait(sem_t id){
    //TODO
    return -1;
}

int sem_signal(sem_t id){
    //TODO
    return -1;
}