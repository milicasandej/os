

#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"


void Riscv::popSppSpie()
{
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}


void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    switch((uint64)scause){
        case 0x0000000000000008UL:

        case 0x0000000000000009UL:
            uint64 volatile sepc = r_sepc() + 4;
            uint64 volatile sstatus = r_sstatus();
            // ovde
            w_sstatus(sstatus);
            w_sepc(sepc);
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
            break;
        default:
            // unexpected trap clause
    }
}