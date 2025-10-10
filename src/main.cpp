

#include "../h/print.hpp"
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"

void main()
{

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);

    // promena rezima

    // uposleno cekanje

    printString("Finished\n");
}
