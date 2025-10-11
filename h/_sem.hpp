//
// Created by os on 10/11/25.
//


#ifndef PROJECT_BASE__SEM_HPP
#define PROJECT_BASE__SEM_HPP

#include "../h/list.hpp"
#include "../h/_thread.hpp"
#include "../lib/hw.h"
#include "../h/syscall_c.hpp"


typedef _sem* sem_t;

class _sem {

public:
    _sem(uint32 init = 1) : val(init), waitStatus(0) {}
    static _sem* createSemaphore(uint32 init);

    int wait();
    int signal();
    int close();

    int value() const { return val; }
    void setWaitStatus(int s) { waitStatus = s;}
    int getWaitStatus() { return waitStatus;}



private:
    int val, waitStatus;
    List<_thread> blocked;
};


#endif //PROJECT_BASE__SEM_HPP
