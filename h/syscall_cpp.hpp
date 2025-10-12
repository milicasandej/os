//
// Created by os on 10/10/25.
//

#ifndef PROJECT_BASE_SYSCALL_CPP_HPP
#define PROJECT_BASE_SYSCALL_CPP_HPP
#include "syscall_c.hpp"

void* operator new (size_t);
void operator delete (void*);

class Thread {
public:
    Thread (void (*body) (void*), void* arg);
    virtual ~Thread();

    int start();

    static void dispatch();



protected:
    Thread();
    virtual void run() {}

private:
    thread_t myHandle;
    void (*body)(void*); void* arg;
    static void startWrapper(void* thread);

};

class Semaphore{
public:

    explicit Semaphore(unsigned init = 1);
    virtual ~Semaphore();

    int wait();
    int signal();

private:
    sem_t myHandle;
};

class Console{
public:
    static char getc();
    static void putc(char c);
};
#endif //PROJECT_BASE_SYSCALL_CPP_HPP
