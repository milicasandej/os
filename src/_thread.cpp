

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread *_thread::running = nullptr;


_thread *_thread::createThread(Body body, void* args)
{
    _thread* newThread = new _thread(body, args);
    Scheduler::put(newThread);
    return newThread;
}

void _thread::yield()
{
    __asm__ volatile ("ecall");
}

void _thread::dispatch()
{
    _thread *old = running;
    if (!old->isFinished()) { Scheduler::put(old); }
    running = Scheduler::get();

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    Riscv::popSppSpie();
    running->body();
    running->setFinished(true);
    _thread::yield();
}

int _thread::exitThread() {
    _thread::running->setFinished(true);
    _thread::dispatch();
    return 0;
}
