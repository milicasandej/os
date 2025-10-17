//
// Created by os on 10/11/25.
//

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (isClosed()) return -1;
    if (--val < 0){
        _thread* cur = _thread::running;
        cur->setBlock(true);
        cur->setSemStatus(0);
        blocked.addLast(cur);
        thread_dispatch();
    }

    return _thread::running->getSemStatus();
}

int _sem::signal() {
    if (isClosed()) return -1;
    if(++val <= 0){
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
}

int _sem::close() {
    setClosed(true);
    while(_thread* cur = blocked.removeFirst()){
        cur->setSemStatus(-1);
        cur->setBlock(false);
        Scheduler::put(cur);
    }

    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    _sem* newSemaphore = new _sem(init);
    return newSemaphore;
}

void _sem::setClosed(bool b) {
    closed = b;
}
