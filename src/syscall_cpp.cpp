//
// Created by os on 10/10/25.
//

#include "../h/syscall_cpp.hpp"
#include "../h/_thread.hpp"
#include "../lib/console.h"

sem_t _thread::semMaxThreads = nullptr;

char Console::getc() {
    return __getc();
}

void Console::putc(char c) {
    __putc(c);
}

Thread::Thread(void (*body)(void *), void *arg) {
    thread_create(&myHandle, body, arg);
    myHandle->setStart(false);
}

int Thread::start() {
    //sem_wait(_thread::semMaxThreads);
    myHandle->setStart(true);
    return 0;
}

void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {

}

Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    Thread* t = (Thread*)thread;
    t->run();
}

void Thread::join() {
    thread_join(&myHandle);
}

//void Thread::SetMaximumThreads(int num_of_threads) {
//    sem_open(&_thread::semMaxThreads, num_of_threads);
//}


int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    sem_close(myHandle);

}



