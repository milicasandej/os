//
// Created by os on 10/18/25.
//

#include "ThreadJoin.hpp"

#include "../h/syscall_cpp.hpp"

#include "printing.hpp"

class WorkerJoin: public Thread {
    void workerBodyJoin(void* arg);
public:
    WorkerJoin():Thread() {}

    void run() override {
        workerBodyJoin(nullptr);
    }
};


void WorkerJoin::workerBodyJoin(void *arg) {
    for (uint64 i = 0; i < 10; i++) {
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
        }
    }
    printString("worker finished!\n");
}


void ThreadJoin_test() {
    Thread* threads[2];

    threads[0] = new WorkerJoin();
    printString("Worker created\n");

    threads[1] = new WorkerJoin();
    printString("Worker created\n");

    for(int i=0; i<2; i++) {
        threads[i]->start();
    }

    threads[0]->join();
    threads[1]->join();
    printString("Main nit zavrsena\n");
    for (auto thread: threads) { delete thread; }
}
