

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"

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

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    Riscv::popSppSpie();
    while(!running->isStarted()) thread_dispatch();
    running->body(running->args);
    running->setFinished(true);
    thread_dispatch();
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


