//
// Created by os on 10/11/25.
//

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (--val < 0){
        _thread* cur = _thread::running;
        cur->setBlock(true);
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
}

int _sem::signal() {
    if(++val <= 0){
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
}

int _sem::close() {
    this->setWaitStatus(-1);
    while(_thread* cur = blocked.removeFirst()){
        cur->setBlock(false);
        Scheduler::put(cur);
    }
    delete this;
    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    _sem* newSemaphore = new _sem(init);
    return newSemaphore;
}
