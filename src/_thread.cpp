

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

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
    while(!running->isStarted()) _thread::dispatch();
    running->body(running->args);
    running->setFinished(true);
    _thread::dispatch();
}

int _thread::exitThread() {
    _thread::running->setFinished(true);
    _thread::dispatch();
    return 0;
}

void _thread::setStart(bool b) {
    this->started = b;
}

void _thread::setBlock(bool b) {
    this->blocked = b;
}


