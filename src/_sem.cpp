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
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
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
    setWaitStatus(-1);
    while(_thread* cur = blocked.removeFirst()){
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
