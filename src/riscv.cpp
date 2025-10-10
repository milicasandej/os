

#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../lib/console.h"
#include "../lib/mem.h"

using namespace Num;

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
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
            switch (scallnum) {
                case SCALL_MEM_ALLOC:
                    break;
                case SCALL_MEM_FREE:
                    break;
                case SCALL_MEM_GET_FREE_SPACE:
                    break;
                case SCALL_MEM_GET_LARGEST_FREE_BLOCK:
                    break;
                case SCALL_THREAD_CREATE: {
                    uint64 param1, param2, param3;
                    READ_REG(param1, "a0");
                    READ_REG(param2, "a1");
                    READ_REG(param3, "a2");

                    break;
                }
                case SCALL_THREAD_EXIT:
                    break;
                case SCALL_THREAD_DISPATCH:
                    break;
                case SCALL_SEM_OPEN:
                    break;
                case SCALL_SEM_CLOSE:
                    break;
                case SCALL_SEM_WAIT:
                    break;
                case SCALL_SEM_SIGNAL:
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
            break;
        default:
            break;
    }
}