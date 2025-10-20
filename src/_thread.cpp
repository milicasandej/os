

#include "../h/_thread.hpp"
#include "../h/riscv.hpp"
#include "../h/syscall_c.hpp"
#include "../test/printing.hpp"

_thread *_thread::running = nullptr;
int _thread::ID = 0;


_thread *_thread::createThread(Body body, void* args)
{
    _thread* newThread = new _thread(body, args);
    if(_thread::running){
        _thread::running->children.addLast(newThread);
    }
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

void _thread::joinAll(){
    while (_thread* curr = children.removeFirst()){
        join(&curr);
    }

}

void _thread::threadWrapper()
{

    Riscv::popSppSpie();
    while(!running->isStarted()) thread_dispatch();
    running->body(running->args);
//    if(_thread::semMaxThreads) sem_signal(_thread::semMaxThreads);
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

void _thread::join(thread_t *handle) {
    while(!(*handle)->isFinished()) thread_dispatch();
}

int _thread::getThreadID() {
    thread_dispatch();
    return myID;
}





