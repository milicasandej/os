

#include "../test/printing.hpp"
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../h/_thread.hpp"

extern void userMain();

void main()
{

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    _thread::running = idleThread;

    //userMode();

    userMain();
    printString("Finished\n");
}
