

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../test/printing.hpp"

_thread *_thread::running = nullptr;


_thread *_thread::createThread(Body body, void* args)
{
    _thread* newThread = new _thread(body, args);
    return newThread;
}

void _thread::dispatch()
{
    _thread *old = running;
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    running = Scheduler::get();
    if (running == nullptr) {
        printString("vratili smo null\n");
    }

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    Riscv::popSppSpie();
    while(!running->isStarted()) thread_dispatch();
    userMode();
    running->body(running->args);
    thread_exit();
}

int _thread::exitThread() {
    _thread::running->setFinished(true);
    thread_dispatch();
    return 0;
}

void _thread::setStart(bool b) {
    this->started = b;
}

void _thread::setBlock(bool b) {
    this->blocked = b;
}


