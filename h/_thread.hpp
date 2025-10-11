

#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP

#include "../lib/hw.h"
#include "scheduler.hpp"

typedef _thread* thread_t;

// Thread Control Block
class _thread
{
public:
    ~_thread() { delete[] stack; }

    bool isFinished() const { return finished; }

    void setFinished(bool value) { finished = value; }

    using Body = void (*)();

    static _thread *createThread(Body body, void* args);

    static void yield();

    static _thread *running;

    static int exitThread();

    void setStart(bool b);

private:
    _thread(Body body, void* args) :
            body(body),
            args(args),
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
            context({
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true)
    {
            if (body != nullptr) { Scheduler::put(this);}
    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    Body body;
    void* args;
    uint64 *stack;
    Context context;
    uint64 timeSlice;
    bool finished, started;

    friend class Riscv;

    static void threadWrapper();

    static void contextSwitch(Context *oldContext, Context *runningContext);

    static void dispatch();




};

#endif //OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_TCB_HPP
