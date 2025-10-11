//
// Created by os on 10/10/25.
//

#include "../h/syscall_cpp.hpp"
#include "../h/_thread.hpp"
#include "../lib/console.h"


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
