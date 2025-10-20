

#include "../test/printing.hpp"
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../h/memory.hpp"
#include "../h/syscall_cpp.hpp"
#include "../test/ThreadJoin.hpp"
#include "../test/semMaxThreads.hpp"



extern void userMain();

void userMainWrapper(void* arg){
    //userMain();
    //ThreadJoin_test();
    semMaxThreads_test();
}

void main()
{

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    memory::initialize();

    // idle nit
    thread_t idleThread = nullptr;
    thread_create(&idleThread, nullptr, nullptr);
    _thread::running = idleThread;

    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    Riscv::setUserMode(true);

    uint8 userCode = 0x0;
    WRITE_REG("a7", userCode);
    __asm__ volatile("ecall");

    thread_t userThread;
    thread_create(&userThread, &userMainWrapper, nullptr);
    while (!userThread->isFinished()) thread_dispatch();


    printString("FINISHED!\n");
}
