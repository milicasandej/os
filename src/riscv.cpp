

#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../lib/console.h"
#include "../h/memory.hpp"
#include "../h/_sem.hpp"
#include "../test/printing.hpp"

using namespace Num;
bool Riscv::userMode = false;


void Riscv::popSppSpie()
{
    if (userMode) mc_sstatus(SSTATUS_SPP);
    else ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");

}


void Riscv::handleSupervisorTrap()
{
    uint64 scause = r_scause();
    switch((uint64)scause){
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 volatile sepc = r_sepc() + 4;
            uint64 volatile sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
            switch (scallnum) {
                case SCALL_MEM_ALLOC:
                    size_t size;
                    READ_REG(size, "a0");
                    memory::allocateMemory(size);
                    break;
                case SCALL_MEM_FREE:
                    void* ptr;
                    READ_REG(ptr, "a0");
                    memory::freeMemory(ptr);
                    break;
                case SCALL_MEM_GET_FREE_SPACE:
                    memory::getFreeSpace();
                    break;
                case SCALL_MEM_GET_LARGEST_FREE_BLOCK:
                    memory::getLargestFreeBlock();
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
                    WRITE_REG("a0", ret);
                    break;
                }
                case SCALL_THREAD_EXIT:
                    _thread::exitThread();
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
                    WRITE_REG("a0", ret);
                    break;
                case SCALL_SEM_CLOSE:
                    sem_t handleClose;
                    READ_REG(handleClose, "a0");
                    handleClose->close();
                    break;
                case SCALL_SEM_WAIT:
                    sem_t idWait;
                    READ_REG(idWait, "a0");
                    idWait->wait();
                    break;
                case SCALL_SEM_SIGNAL:
                    sem_t idSignal;
                    READ_REG(idSignal, "a0");
                    idSignal->signal();
                    break;
                case SCALL_GETC:
                    __getc();
                    break;
                case SCALL_PUTC:
                    char c;
                    READ_REG(c, "a0");
                    __putc(c);
                    break;
                default:
                    break;
            }

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

            printString("Scause: ");
            printInt(scause);
            printString("\n");
            printString("Koraci ko laki oblaci, skoci da te zemlja odbaci!\n");
            if ((int)scause == 2) thread_exit();

            break;
    }
}