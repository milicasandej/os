

#include "../h/scheduler.hpp"

List<_thread> Scheduler::readyThreadQueue;

_thread *Scheduler::get()
{
    return readyThreadQueue.removeFirst();
}

void Scheduler::put(_thread *tcb)
{
    readyThreadQueue.addLast(tcb);
}