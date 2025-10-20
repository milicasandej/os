//
// Created by os on 10/18/25.
//

#include "semMaxThreads.hpp"

#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.hpp"
#include "printing.hpp"

//int brojac = 20;

class WorkerSemMax: public Thread {
    void workerBody(void* arg);
public:
    WorkerSemMax():Thread() {}

    void run() override {
        workerBody(nullptr);
    }
};


void WorkerSemMax::workerBody(void *arg) {

    for (uint64 i = 0; i < 5; i++) {
        int id = getThreadId();
        printString("Hello! ID: ");
        printInt(id);
        printString("\n");
        for (uint64 j = 0; j < 1000; j++) {
            for (uint64 k = 0; k < 1000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    //brojac--;
}

void semMaxThreads_test() {

    //Thread::SetMaximumThreads(3);
    Thread* threads[20];

    for(int i=0; i<20; i++) {
        threads[i] = new WorkerSemMax();
    }

    for(int i=0; i<20; i++) {
        threads[i]->start();
    }

//    while(brojac) {
//        thread_dispatch();
//   }

    thread_joinAll();
}

