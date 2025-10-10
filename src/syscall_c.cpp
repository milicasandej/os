//
// Created by os on 10/7/25.
//

#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../lib/mem.h"
#include "../lib/console.h"


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
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

int thread_exit(){
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

void thread_dispatch(){
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);

    __asm__ volatile("ecall");
}

int sem_open(sem_t* handle, unsigned init){
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

int sem_close(sem_t handle) {
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

int sem_wait(sem_t id){
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

int sem_signal(sem_t id){
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);

    __asm__ volatile("ecall");

    int ret;
    READ_REG(ret, "a0");
    return ret;
}

char getc(){
    return __getc();
}

void putc(char c){
    __putc(c);
}