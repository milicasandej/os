

#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../lib/console.h"
#include "../lib/mem.h"
#include "../h/_sem.hpp"

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
                    thread_t* handle;
                    _thread::Body body;
                    void* args;
                    READ_REG(handle, "a0");
                    READ_REG(body, "a1");
                    READ_REG(args, "a2");
                    *handle = _thread::createThread(body, args);
                    if(*handle != nullptr) ret = 0;
                    else ret = -1;
                    break;
                }
                case SCALL_THREAD_EXIT:
                    ret = _thread::exitThread();
                    break;
                case SCALL_THREAD_DISPATCH:
                    _thread::dispatch();
                    break;
                case SCALL_SEM_OPEN:
                    sem_t* handle;
                    uint32 init;
                    READ_REG(handle, "a0");
                    READ_REG(init, "a1");
                    *handle = _sem::createSemaphore(init);
                    if(*handle != nullptr) ret = 0;
                    else ret = -1;
                    break;
                case SCALL_SEM_CLOSE:
                    sem_t handleClose;
                    READ_REG(handleClose, "a0");
                    ret = handleClose->close();
                    break;
                case SCALL_SEM_WAIT:
                    sem_t idWait;
                    READ_REG(idWait, "a0");
                    ret = idWait->wait();
                    break;
                case SCALL_SEM_SIGNAL:
                    sem_t idSignal;
                    READ_REG(idSignal, "a0");
                    ret = idSignal->signal();
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
            w_sstatus(sstatus);
            w_sepc(sepc);
            break;
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