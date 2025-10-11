
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	1e013103          	ld	sp,480(sp) # 800071e0 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5e5020ef          	jal	ra,80002e00 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    800010a4:	0a5000ef          	jal	ra,80001948 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010a8:	00013003          	ld	zero,0(sp)
    800010ac:	00813083          	ld	ra,8(sp)
    800010b0:	01013103          	ld	sp,16(sp)
    800010b4:	01813183          	ld	gp,24(sp)
    800010b8:	02013203          	ld	tp,32(sp)
    800010bc:	02813283          	ld	t0,40(sp)
    800010c0:	03013303          	ld	t1,48(sp)
    800010c4:	03813383          	ld	t2,56(sp)
    800010c8:	04013403          	ld	s0,64(sp)
    800010cc:	04813483          	ld	s1,72(sp)
    800010d0:	05013503          	ld	a0,80(sp)
    800010d4:	05813583          	ld	a1,88(sp)
    800010d8:	06013603          	ld	a2,96(sp)
    800010dc:	06813683          	ld	a3,104(sp)
    800010e0:	07013703          	ld	a4,112(sp)
    800010e4:	07813783          	ld	a5,120(sp)
    800010e8:	08013803          	ld	a6,128(sp)
    800010ec:	08813883          	ld	a7,136(sp)
    800010f0:	09013903          	ld	s2,144(sp)
    800010f4:	09813983          	ld	s3,152(sp)
    800010f8:	0a013a03          	ld	s4,160(sp)
    800010fc:	0a813a83          	ld	s5,168(sp)
    80001100:	0b013b03          	ld	s6,176(sp)
    80001104:	0b813b83          	ld	s7,184(sp)
    80001108:	0c013c03          	ld	s8,192(sp)
    8000110c:	0c813c83          	ld	s9,200(sp)
    80001110:	0d013d03          	ld	s10,208(sp)
    80001114:	0d813d83          	ld	s11,216(sp)
    80001118:	0e013e03          	ld	t3,224(sp)
    8000111c:	0e813e83          	ld	t4,232(sp)
    80001120:	0f013f03          	ld	t5,240(sp)
    80001124:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001128:	10010113          	addi	sp,sp,256

    sret
    8000112c:	10200073          	sret

0000000080001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001130:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001134:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001138:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000113c:	0085b103          	ld	sp,8(a1)

    80001140:	00008067          	ret

0000000080001144 <_Z9mem_allocm>:
#include "../h/riscv.hpp"
#include "../lib/mem.h"
#include "../lib/console.h"


void* mem_alloc(size_t size){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00113423          	sd	ra,8(sp)
    8000114c:	00813023          	sd	s0,0(sp)
    80001150:	01010413          	addi	s0,sp,16
    return __mem_alloc(size); //TODO
    80001154:	00004097          	auipc	ra,0x4
    80001158:	e34080e7          	jalr	-460(ra) # 80004f88 <__mem_alloc>
}
    8000115c:	00813083          	ld	ra,8(sp)
    80001160:	00013403          	ld	s0,0(sp)
    80001164:	01010113          	addi	sp,sp,16
    80001168:	00008067          	ret

000000008000116c <_Z8mem_freePv>:

int mem_free(void* ptr){
    8000116c:	ff010113          	addi	sp,sp,-16
    80001170:	00113423          	sd	ra,8(sp)
    80001174:	00813023          	sd	s0,0(sp)
    80001178:	01010413          	addi	s0,sp,16
    return __mem_free(ptr); //TODO
    8000117c:	00004097          	auipc	ra,0x4
    80001180:	d40080e7          	jalr	-704(ra) # 80004ebc <__mem_free>
}
    80001184:	00813083          	ld	ra,8(sp)
    80001188:	00013403          	ld	s0,0(sp)
    8000118c:	01010113          	addi	sp,sp,16
    80001190:	00008067          	ret

0000000080001194 <_Z13thread_createPP7_threadPFvPvES2_>:
//
//size_t mem_get_largest_free_block(){
//    //TODO
//}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001194:	ff010113          	addi	sp,sp,-16
    80001198:	00813423          	sd	s0,8(sp)
    8000119c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);
    800011a0:	01100793          	li	a5,17
    800011a4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011a8:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011ac:	00050513          	mv	a0,a0
    return ret;
}
    800011b0:	0005051b          	sext.w	a0,a0
    800011b4:	00813403          	ld	s0,8(sp)
    800011b8:	01010113          	addi	sp,sp,16
    800011bc:	00008067          	ret

00000000800011c0 <_Z11thread_exitv>:

int thread_exit(){
    800011c0:	ff010113          	addi	sp,sp,-16
    800011c4:	00813423          	sd	s0,8(sp)
    800011c8:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);
    800011cc:	01200793          	li	a5,18
    800011d0:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011d4:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011d8:	00050513          	mv	a0,a0
    return ret;
}
    800011dc:	0005051b          	sext.w	a0,a0
    800011e0:	00813403          	ld	s0,8(sp)
    800011e4:	01010113          	addi	sp,sp,16
    800011e8:	00008067          	ret

00000000800011ec <_Z15thread_dispatchv>:

void thread_dispatch(){
    800011ec:	ff010113          	addi	sp,sp,-16
    800011f0:	00813423          	sd	s0,8(sp)
    800011f4:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);
    800011f8:	01300793          	li	a5,19
    800011fc:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001200:	00000073          	ecall
}
    80001204:	00813403          	ld	s0,8(sp)
    80001208:	01010113          	addi	sp,sp,16
    8000120c:	00008067          	ret

0000000080001210 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    80001210:	ff010113          	addi	sp,sp,-16
    80001214:	00813423          	sd	s0,8(sp)
    80001218:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);
    8000121c:	02100793          	li	a5,33
    80001220:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001224:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001228:	00050513          	mv	a0,a0
    return ret;
}
    8000122c:	0005051b          	sext.w	a0,a0
    80001230:	00813403          	ld	s0,8(sp)
    80001234:	01010113          	addi	sp,sp,16
    80001238:	00008067          	ret

000000008000123c <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle) {
    8000123c:	ff010113          	addi	sp,sp,-16
    80001240:	00813423          	sd	s0,8(sp)
    80001244:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);
    80001248:	02200793          	li	a5,34
    8000124c:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001250:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001254:	00050513          	mv	a0,a0
    return ret;
}
    80001258:	0005051b          	sext.w	a0,a0
    8000125c:	00813403          	ld	s0,8(sp)
    80001260:	01010113          	addi	sp,sp,16
    80001264:	00008067          	ret

0000000080001268 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t id){
    80001268:	ff010113          	addi	sp,sp,-16
    8000126c:	00813423          	sd	s0,8(sp)
    80001270:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);
    80001274:	02300793          	li	a5,35
    80001278:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    8000127c:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001280:	00050513          	mv	a0,a0
    return ret;
}
    80001284:	0005051b          	sext.w	a0,a0
    80001288:	00813403          	ld	s0,8(sp)
    8000128c:	01010113          	addi	sp,sp,16
    80001290:	00008067          	ret

0000000080001294 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t id){
    80001294:	ff010113          	addi	sp,sp,-16
    80001298:	00813423          	sd	s0,8(sp)
    8000129c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);
    800012a0:	02400793          	li	a5,36
    800012a4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012a8:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800012ac:	00050513          	mv	a0,a0
    return ret;
}
    800012b0:	0005051b          	sext.w	a0,a0
    800012b4:	00813403          	ld	s0,8(sp)
    800012b8:	01010113          	addi	sp,sp,16
    800012bc:	00008067          	ret

00000000800012c0 <_Z4getcv>:

char getc(){
    800012c0:	ff010113          	addi	sp,sp,-16
    800012c4:	00113423          	sd	ra,8(sp)
    800012c8:	00813023          	sd	s0,0(sp)
    800012cc:	01010413          	addi	s0,sp,16
    return __getc();
    800012d0:	00004097          	auipc	ra,0x4
    800012d4:	e4c080e7          	jalr	-436(ra) # 8000511c <__getc>
}
    800012d8:	00813083          	ld	ra,8(sp)
    800012dc:	00013403          	ld	s0,0(sp)
    800012e0:	01010113          	addi	sp,sp,16
    800012e4:	00008067          	ret

00000000800012e8 <_Z4putcc>:

void putc(char c){
    800012e8:	ff010113          	addi	sp,sp,-16
    800012ec:	00113423          	sd	ra,8(sp)
    800012f0:	00813023          	sd	s0,0(sp)
    800012f4:	01010413          	addi	s0,sp,16
    __putc(c);
    800012f8:	00004097          	auipc	ra,0x4
    800012fc:	de8080e7          	jalr	-536(ra) # 800050e0 <__putc>
    80001300:	00813083          	ld	ra,8(sp)
    80001304:	00013403          	ld	s0,0(sp)
    80001308:	01010113          	addi	sp,sp,16
    8000130c:	00008067          	ret

0000000080001310 <_ZN7_thread12createThreadEPFvPvES0_>:

_thread *_thread::running = nullptr;


_thread *_thread::createThread(Body body, void* args)
{
    80001310:	fd010113          	addi	sp,sp,-48
    80001314:	02113423          	sd	ra,40(sp)
    80001318:	02813023          	sd	s0,32(sp)
    8000131c:	00913c23          	sd	s1,24(sp)
    80001320:	01213823          	sd	s2,16(sp)
    80001324:	01313423          	sd	s3,8(sp)
    80001328:	03010413          	addi	s0,sp,48
    8000132c:	00050913          	mv	s2,a0
    80001330:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    80001334:	03800513          	li	a0,56
    80001338:	00000097          	auipc	ra,0x0
    8000133c:	36c080e7          	jalr	876(ra) # 800016a4 <_Znwm>
    80001340:	00050493          	mv	s1,a0
            context({
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true)
    80001344:	01253023          	sd	s2,0(a0)
    80001348:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    8000134c:	00090a63          	beqz	s2,80001360 <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    80001350:	00008537          	lui	a0,0x8
    80001354:	00000097          	auipc	ra,0x0
    80001358:	378080e7          	jalr	888(ra) # 800016cc <_Znam>
    8000135c:	0080006f          	j	80001364 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    80001360:	00000513          	li	a0,0
            started(true)
    80001364:	00a4b823          	sd	a0,16(s1)
    80001368:	00000797          	auipc	a5,0x0
    8000136c:	0e878793          	addi	a5,a5,232 # 80001450 <_ZN7_thread13threadWrapperEv>
    80001370:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001374:	02050863          	beqz	a0,800013a4 <_ZN7_thread12createThreadEPFvPvES0_+0x94>
    80001378:	000087b7          	lui	a5,0x8
    8000137c:	00f507b3          	add	a5,a0,a5
            started(true)
    80001380:	02f4b023          	sd	a5,32(s1)
    80001384:	02048823          	sb	zero,48(s1)
    80001388:	00100793          	li	a5,1
    8000138c:	02f488a3          	sb	a5,49(s1)
    {
            if (body != nullptr) { Scheduler::put(this);}
    80001390:	02090c63          	beqz	s2,800013c8 <_ZN7_thread12createThreadEPFvPvES0_+0xb8>
    80001394:	00048513          	mv	a0,s1
    80001398:	00000097          	auipc	ra,0x0
    8000139c:	784080e7          	jalr	1924(ra) # 80001b1c <_ZN9Scheduler3putEP7_thread>
    800013a0:	0280006f          	j	800013c8 <_ZN7_thread12createThreadEPFvPvES0_+0xb8>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    800013a4:	00000793          	li	a5,0
    800013a8:	fd9ff06f          	j	80001380 <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    800013ac:	00050913          	mv	s2,a0
    800013b0:	00048513          	mv	a0,s1
    800013b4:	00000097          	auipc	ra,0x0
    800013b8:	340080e7          	jalr	832(ra) # 800016f4 <_ZdlPv>
    800013bc:	00090513          	mv	a0,s2
    800013c0:	00007097          	auipc	ra,0x7
    800013c4:	f68080e7          	jalr	-152(ra) # 80008328 <_Unwind_Resume>
    return newThread;
}
    800013c8:	00048513          	mv	a0,s1
    800013cc:	02813083          	ld	ra,40(sp)
    800013d0:	02013403          	ld	s0,32(sp)
    800013d4:	01813483          	ld	s1,24(sp)
    800013d8:	01013903          	ld	s2,16(sp)
    800013dc:	00813983          	ld	s3,8(sp)
    800013e0:	03010113          	addi	sp,sp,48
    800013e4:	00008067          	ret

00000000800013e8 <_ZN7_thread8dispatchEv>:

void _thread::dispatch()
{
    800013e8:	fe010113          	addi	sp,sp,-32
    800013ec:	00113c23          	sd	ra,24(sp)
    800013f0:	00813823          	sd	s0,16(sp)
    800013f4:	00913423          	sd	s1,8(sp)
    800013f8:	02010413          	addi	s0,sp,32
    _thread *old = running;
    800013fc:	00006497          	auipc	s1,0x6
    80001400:	e344b483          	ld	s1,-460(s1) # 80007230 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001404:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished()) { Scheduler::put(old); }
    80001408:	02078c63          	beqz	a5,80001440 <_ZN7_thread8dispatchEv+0x58>
    running = Scheduler::get();
    8000140c:	00000097          	auipc	ra,0x0
    80001410:	6a8080e7          	jalr	1704(ra) # 80001ab4 <_ZN9Scheduler3getEv>
    80001414:	00006797          	auipc	a5,0x6
    80001418:	e0a7be23          	sd	a0,-484(a5) # 80007230 <_ZN7_thread7runningE>

    _thread::contextSwitch(&old->context, &running->context);
    8000141c:	01850593          	addi	a1,a0,24 # 8018 <_entry-0x7fff7fe8>
    80001420:	01848513          	addi	a0,s1,24
    80001424:	00000097          	auipc	ra,0x0
    80001428:	d0c080e7          	jalr	-756(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    8000142c:	01813083          	ld	ra,24(sp)
    80001430:	01013403          	ld	s0,16(sp)
    80001434:	00813483          	ld	s1,8(sp)
    80001438:	02010113          	addi	sp,sp,32
    8000143c:	00008067          	ret
    if (!old->isFinished()) { Scheduler::put(old); }
    80001440:	00048513          	mv	a0,s1
    80001444:	00000097          	auipc	ra,0x0
    80001448:	6d8080e7          	jalr	1752(ra) # 80001b1c <_ZN9Scheduler3putEP7_thread>
    8000144c:	fc1ff06f          	j	8000140c <_ZN7_thread8dispatchEv+0x24>

0000000080001450 <_ZN7_thread13threadWrapperEv>:

void _thread::threadWrapper()
{
    80001450:	ff010113          	addi	sp,sp,-16
    80001454:	00113423          	sd	ra,8(sp)
    80001458:	00813023          	sd	s0,0(sp)
    8000145c:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    80001460:	00000097          	auipc	ra,0x0
    80001464:	4c8080e7          	jalr	1224(ra) # 80001928 <_ZN5Riscv10popSppSpieEv>
    while(!running->started) _thread::dispatch();
    80001468:	00006797          	auipc	a5,0x6
    8000146c:	dc87b783          	ld	a5,-568(a5) # 80007230 <_ZN7_thread7runningE>
    80001470:	0317c703          	lbu	a4,49(a5)
    80001474:	00071863          	bnez	a4,80001484 <_ZN7_thread13threadWrapperEv+0x34>
    80001478:	00000097          	auipc	ra,0x0
    8000147c:	f70080e7          	jalr	-144(ra) # 800013e8 <_ZN7_thread8dispatchEv>
    80001480:	fe9ff06f          	j	80001468 <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    80001484:	0007b703          	ld	a4,0(a5)
    80001488:	0087b503          	ld	a0,8(a5)
    8000148c:	000700e7          	jalr	a4
    void setFinished(bool value) { finished = value; }
    80001490:	00006797          	auipc	a5,0x6
    80001494:	da07b783          	ld	a5,-608(a5) # 80007230 <_ZN7_thread7runningE>
    80001498:	00100713          	li	a4,1
    8000149c:	02e78823          	sb	a4,48(a5)
    running->setFinished(true);
    _thread::dispatch();
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	f48080e7          	jalr	-184(ra) # 800013e8 <_ZN7_thread8dispatchEv>
}
    800014a8:	00813083          	ld	ra,8(sp)
    800014ac:	00013403          	ld	s0,0(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret

00000000800014b8 <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014b8:	ff010113          	addi	sp,sp,-16
    800014bc:	00113423          	sd	ra,8(sp)
    800014c0:	00813023          	sd	s0,0(sp)
    800014c4:	01010413          	addi	s0,sp,16
    800014c8:	00006797          	auipc	a5,0x6
    800014cc:	d687b783          	ld	a5,-664(a5) # 80007230 <_ZN7_thread7runningE>
    800014d0:	00100713          	li	a4,1
    800014d4:	02e78823          	sb	a4,48(a5)
    _thread::running->setFinished(true);
    _thread::dispatch();
    800014d8:	00000097          	auipc	ra,0x0
    800014dc:	f10080e7          	jalr	-240(ra) # 800013e8 <_ZN7_thread8dispatchEv>
    return 0;
}
    800014e0:	00000513          	li	a0,0
    800014e4:	00813083          	ld	ra,8(sp)
    800014e8:	00013403          	ld	s0,0(sp)
    800014ec:	01010113          	addi	sp,sp,16
    800014f0:	00008067          	ret

00000000800014f4 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    800014f4:	ff010113          	addi	sp,sp,-16
    800014f8:	00813423          	sd	s0,8(sp)
    800014fc:	01010413          	addi	s0,sp,16
    this->started = b;
    80001500:	02b508a3          	sb	a1,49(a0)
}
    80001504:	00813403          	ld	s0,8(sp)
    80001508:	01010113          	addi	sp,sp,16
    8000150c:	00008067          	ret

0000000080001510 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001510:	fe010113          	addi	sp,sp,-32
    80001514:	00113c23          	sd	ra,24(sp)
    80001518:	00813823          	sd	s0,16(sp)
    8000151c:	00913423          	sd	s1,8(sp)
    80001520:	01213023          	sd	s2,0(sp)
    80001524:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80001528:	00005517          	auipc	a0,0x5
    8000152c:	ad850513          	addi	a0,a0,-1320 # 80006000 <kvmincrease+0xe00>
    80001530:	00001097          	auipc	ra,0x1
    80001534:	600080e7          	jalr	1536(ra) # 80002b30 <_Z11printStringPKc>
    int test = getc() - '0';
    80001538:	00000097          	auipc	ra,0x0
    8000153c:	d88080e7          	jalr	-632(ra) # 800012c0 <_Z4getcv>
    80001540:	0005091b          	sext.w	s2,a0
    80001544:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001548:	00000097          	auipc	ra,0x0
    8000154c:	d78080e7          	jalr	-648(ra) # 800012c0 <_Z4getcv>
            printString("Nije navedeno da je zadatak 2 implementiran\n");
            return;
        }
    }

    if (test >= 3 && test <= 4) {
    80001550:	fcd9071b          	addiw	a4,s2,-51
    80001554:	00100793          	li	a5,1
    80001558:	04e7f663          	bgeu	a5,a4,800015a4 <_Z8userMainv+0x94>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    8000155c:	fcb9091b          	addiw	s2,s2,-53
    80001560:	00100793          	li	a5,1
    80001564:	0727f463          	bgeu	a5,s2,800015cc <_Z8userMainv+0xbc>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001568:	00600793          	li	a5,6
    8000156c:	0697ca63          	blt	a5,s1,800015e0 <_Z8userMainv+0xd0>
    80001570:	00300793          	li	a5,3
    80001574:	04f4d063          	bge	s1,a5,800015b4 <_Z8userMainv+0xa4>
    80001578:	00100793          	li	a5,1
    8000157c:	08f48863          	beq	s1,a5,8000160c <_Z8userMainv+0xfc>
    80001580:	00200793          	li	a5,2
    80001584:	0af49263          	bne	s1,a5,80001628 <_Z8userMainv+0x118>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
#endif
            break;
        case 2:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_CPP_API_test();
    80001588:	00001097          	auipc	ra,0x1
    8000158c:	b10080e7          	jalr	-1264(ra) # 80002098 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001590:	00005517          	auipc	a0,0x5
    80001594:	b3050513          	addi	a0,a0,-1232 # 800060c0 <kvmincrease+0xec0>
    80001598:	00001097          	auipc	ra,0x1
    8000159c:	598080e7          	jalr	1432(ra) # 80002b30 <_Z11printStringPKc>
#endif
            break;
    800015a0:	0140006f          	j	800015b4 <_Z8userMainv+0xa4>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
    800015a4:	00005517          	auipc	a0,0x5
    800015a8:	a7c50513          	addi	a0,a0,-1412 # 80006020 <kvmincrease+0xe20>
    800015ac:	00001097          	auipc	ra,0x1
    800015b0:	584080e7          	jalr	1412(ra) # 80002b30 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800015b4:	01813083          	ld	ra,24(sp)
    800015b8:	01013403          	ld	s0,16(sp)
    800015bc:	00813483          	ld	s1,8(sp)
    800015c0:	00013903          	ld	s2,0(sp)
    800015c4:	02010113          	addi	sp,sp,32
    800015c8:	00008067          	ret
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015cc:	00005517          	auipc	a0,0x5
    800015d0:	a8450513          	addi	a0,a0,-1404 # 80006050 <kvmincrease+0xe50>
    800015d4:	00001097          	auipc	ra,0x1
    800015d8:	55c080e7          	jalr	1372(ra) # 80002b30 <_Z11printStringPKc>
            return;
    800015dc:	fd9ff06f          	j	800015b4 <_Z8userMainv+0xa4>
    switch (test) {
    800015e0:	00700793          	li	a5,7
    800015e4:	04f49263          	bne	s1,a5,80001628 <_Z8userMainv+0x118>
            printString("Test se nije uspesno zavrsio\n");
    800015e8:	00005517          	auipc	a0,0x5
    800015ec:	b1850513          	addi	a0,a0,-1256 # 80006100 <kvmincrease+0xf00>
    800015f0:	00001097          	auipc	ra,0x1
    800015f4:	540080e7          	jalr	1344(ra) # 80002b30 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800015f8:	00005517          	auipc	a0,0x5
    800015fc:	b2850513          	addi	a0,a0,-1240 # 80006120 <kvmincrease+0xf20>
    80001600:	00001097          	auipc	ra,0x1
    80001604:	530080e7          	jalr	1328(ra) # 80002b30 <_Z11printStringPKc>
            break;
    80001608:	fadff06f          	j	800015b4 <_Z8userMainv+0xa4>
            Threads_C_API_test();
    8000160c:	00001097          	auipc	ra,0x1
    80001610:	428080e7          	jalr	1064(ra) # 80002a34 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001614:	00005517          	auipc	a0,0x5
    80001618:	a6c50513          	addi	a0,a0,-1428 # 80006080 <kvmincrease+0xe80>
    8000161c:	00001097          	auipc	ra,0x1
    80001620:	514080e7          	jalr	1300(ra) # 80002b30 <_Z11printStringPKc>
            break;
    80001624:	f91ff06f          	j	800015b4 <_Z8userMainv+0xa4>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001628:	00005517          	auipc	a0,0x5
    8000162c:	b5050513          	addi	a0,a0,-1200 # 80006178 <kvmincrease+0xf78>
    80001630:	00001097          	auipc	ra,0x1
    80001634:	500080e7          	jalr	1280(ra) # 80002b30 <_Z11printStringPKc>
    80001638:	f7dff06f          	j	800015b4 <_Z8userMainv+0xa4>

000000008000163c <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    8000163c:	fe010113          	addi	sp,sp,-32
    80001640:	00113c23          	sd	ra,24(sp)
    80001644:	00813823          	sd	s0,16(sp)
    80001648:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    8000164c:	00006797          	auipc	a5,0x6
    80001650:	b8c7b783          	ld	a5,-1140(a5) # 800071d8 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001654:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    80001658:	00000613          	li	a2,0
    8000165c:	00000593          	li	a1,0
    80001660:	fe840513          	addi	a0,s0,-24
    80001664:	00000097          	auipc	ra,0x0
    80001668:	b30080e7          	jalr	-1232(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    8000166c:	00006797          	auipc	a5,0x6
    80001670:	b647b783          	ld	a5,-1180(a5) # 800071d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001674:	fe843703          	ld	a4,-24(s0)
    80001678:	00e7b023          	sd	a4,0(a5)

    // promena rezima

    // uposleno cekanje

    userMain();
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	e94080e7          	jalr	-364(ra) # 80001510 <_Z8userMainv>
    printString("Finished\n");
    80001684:	00005517          	auipc	a0,0x5
    80001688:	b1c50513          	addi	a0,a0,-1252 # 800061a0 <kvmincrease+0xfa0>
    8000168c:	00001097          	auipc	ra,0x1
    80001690:	4a4080e7          	jalr	1188(ra) # 80002b30 <_Z11printStringPKc>
}
    80001694:	01813083          	ld	ra,24(sp)
    80001698:	01013403          	ld	s0,16(sp)
    8000169c:	02010113          	addi	sp,sp,32
    800016a0:	00008067          	ret

00000000800016a4 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    800016a4:	ff010113          	addi	sp,sp,-16
    800016a8:	00113423          	sd	ra,8(sp)
    800016ac:	00813023          	sd	s0,0(sp)
    800016b0:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016b4:	00004097          	auipc	ra,0x4
    800016b8:	8d4080e7          	jalr	-1836(ra) # 80004f88 <__mem_alloc>
}
    800016bc:	00813083          	ld	ra,8(sp)
    800016c0:	00013403          	ld	s0,0(sp)
    800016c4:	01010113          	addi	sp,sp,16
    800016c8:	00008067          	ret

00000000800016cc <_Znam>:

void *operator new[](size_t n)
{
    800016cc:	ff010113          	addi	sp,sp,-16
    800016d0:	00113423          	sd	ra,8(sp)
    800016d4:	00813023          	sd	s0,0(sp)
    800016d8:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016dc:	00004097          	auipc	ra,0x4
    800016e0:	8ac080e7          	jalr	-1876(ra) # 80004f88 <__mem_alloc>
}
    800016e4:	00813083          	ld	ra,8(sp)
    800016e8:	00013403          	ld	s0,0(sp)
    800016ec:	01010113          	addi	sp,sp,16
    800016f0:	00008067          	ret

00000000800016f4 <_ZdlPv>:

void operator delete(void *p)
{
    800016f4:	ff010113          	addi	sp,sp,-16
    800016f8:	00113423          	sd	ra,8(sp)
    800016fc:	00813023          	sd	s0,0(sp)
    80001700:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001704:	00003097          	auipc	ra,0x3
    80001708:	7b8080e7          	jalr	1976(ra) # 80004ebc <__mem_free>
}
    8000170c:	00813083          	ld	ra,8(sp)
    80001710:	00013403          	ld	s0,0(sp)
    80001714:	01010113          	addi	sp,sp,16
    80001718:	00008067          	ret

000000008000171c <_ZdaPv>:

void operator delete[](void *p)
{
    8000171c:	ff010113          	addi	sp,sp,-16
    80001720:	00113423          	sd	ra,8(sp)
    80001724:	00813023          	sd	s0,0(sp)
    80001728:	01010413          	addi	s0,sp,16
    __mem_free(p);
    8000172c:	00003097          	auipc	ra,0x3
    80001730:	790080e7          	jalr	1936(ra) # 80004ebc <__mem_free>
}
    80001734:	00813083          	ld	ra,8(sp)
    80001738:	00013403          	ld	s0,0(sp)
    8000173c:	01010113          	addi	sp,sp,16
    80001740:	00008067          	ret

0000000080001744 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    80001744:	ff010113          	addi	sp,sp,-16
    80001748:	00813423          	sd	s0,8(sp)
    8000174c:	01010413          	addi	s0,sp,16

}
    80001750:	00813403          	ld	s0,8(sp)
    80001754:	01010113          	addi	sp,sp,16
    80001758:	00008067          	ret

000000008000175c <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    8000175c:	ff010113          	addi	sp,sp,-16
    80001760:	00113423          	sd	ra,8(sp)
    80001764:	00813023          	sd	s0,0(sp)
    80001768:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    8000176c:	00053783          	ld	a5,0(a0)
    80001770:	0107b783          	ld	a5,16(a5)
    80001774:	000780e7          	jalr	a5
}
    80001778:	00813083          	ld	ra,8(sp)
    8000177c:	00013403          	ld	s0,0(sp)
    80001780:	01010113          	addi	sp,sp,16
    80001784:	00008067          	ret

0000000080001788 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001788:	ff010113          	addi	sp,sp,-16
    8000178c:	00113423          	sd	ra,8(sp)
    80001790:	00813023          	sd	s0,0(sp)
    80001794:	01010413          	addi	s0,sp,16
}
    80001798:	00000097          	auipc	ra,0x0
    8000179c:	f5c080e7          	jalr	-164(ra) # 800016f4 <_ZdlPv>
    800017a0:	00813083          	ld	ra,8(sp)
    800017a4:	00013403          	ld	s0,0(sp)
    800017a8:	01010113          	addi	sp,sp,16
    800017ac:	00008067          	ret

00000000800017b0 <_ZN7Console4getcEv>:
char Console::getc() {
    800017b0:	ff010113          	addi	sp,sp,-16
    800017b4:	00113423          	sd	ra,8(sp)
    800017b8:	00813023          	sd	s0,0(sp)
    800017bc:	01010413          	addi	s0,sp,16
    return __getc();
    800017c0:	00004097          	auipc	ra,0x4
    800017c4:	95c080e7          	jalr	-1700(ra) # 8000511c <__getc>
}
    800017c8:	00813083          	ld	ra,8(sp)
    800017cc:	00013403          	ld	s0,0(sp)
    800017d0:	01010113          	addi	sp,sp,16
    800017d4:	00008067          	ret

00000000800017d8 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    800017d8:	ff010113          	addi	sp,sp,-16
    800017dc:	00113423          	sd	ra,8(sp)
    800017e0:	00813023          	sd	s0,0(sp)
    800017e4:	01010413          	addi	s0,sp,16
    __putc(c);
    800017e8:	00004097          	auipc	ra,0x4
    800017ec:	8f8080e7          	jalr	-1800(ra) # 800050e0 <__putc>
}
    800017f0:	00813083          	ld	ra,8(sp)
    800017f4:	00013403          	ld	s0,0(sp)
    800017f8:	01010113          	addi	sp,sp,16
    800017fc:	00008067          	ret

0000000080001800 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001800:	fe010113          	addi	sp,sp,-32
    80001804:	00113c23          	sd	ra,24(sp)
    80001808:	00813823          	sd	s0,16(sp)
    8000180c:	00913423          	sd	s1,8(sp)
    80001810:	02010413          	addi	s0,sp,32
    80001814:	00050493          	mv	s1,a0
    80001818:	00006797          	auipc	a5,0x6
    8000181c:	8e078793          	addi	a5,a5,-1824 # 800070f8 <_ZTV6Thread+0x10>
    80001820:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    80001824:	00850513          	addi	a0,a0,8
    80001828:	00000097          	auipc	ra,0x0
    8000182c:	96c080e7          	jalr	-1684(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001830:	00000593          	li	a1,0
    80001834:	0084b503          	ld	a0,8(s1)
    80001838:	00000097          	auipc	ra,0x0
    8000183c:	cbc080e7          	jalr	-836(ra) # 800014f4 <_ZN7_thread8setStartEb>
}
    80001840:	01813083          	ld	ra,24(sp)
    80001844:	01013403          	ld	s0,16(sp)
    80001848:	00813483          	ld	s1,8(sp)
    8000184c:	02010113          	addi	sp,sp,32
    80001850:	00008067          	ret

0000000080001854 <_ZN6Thread5startEv>:
int Thread::start() {
    80001854:	ff010113          	addi	sp,sp,-16
    80001858:	00113423          	sd	ra,8(sp)
    8000185c:	00813023          	sd	s0,0(sp)
    80001860:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001864:	00100593          	li	a1,1
    80001868:	00853503          	ld	a0,8(a0)
    8000186c:	00000097          	auipc	ra,0x0
    80001870:	c88080e7          	jalr	-888(ra) # 800014f4 <_ZN7_thread8setStartEb>
}
    80001874:	00000513          	li	a0,0
    80001878:	00813083          	ld	ra,8(sp)
    8000187c:	00013403          	ld	s0,0(sp)
    80001880:	01010113          	addi	sp,sp,16
    80001884:	00008067          	ret

0000000080001888 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001888:	ff010113          	addi	sp,sp,-16
    8000188c:	00113423          	sd	ra,8(sp)
    80001890:	00813023          	sd	s0,0(sp)
    80001894:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	954080e7          	jalr	-1708(ra) # 800011ec <_Z15thread_dispatchv>
}
    800018a0:	00813083          	ld	ra,8(sp)
    800018a4:	00013403          	ld	s0,0(sp)
    800018a8:	01010113          	addi	sp,sp,16
    800018ac:	00008067          	ret

00000000800018b0 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800018b0:	fe010113          	addi	sp,sp,-32
    800018b4:	00113c23          	sd	ra,24(sp)
    800018b8:	00813823          	sd	s0,16(sp)
    800018bc:	00913423          	sd	s1,8(sp)
    800018c0:	02010413          	addi	s0,sp,32
    800018c4:	00050493          	mv	s1,a0
    800018c8:	00006797          	auipc	a5,0x6
    800018cc:	83078793          	addi	a5,a5,-2000 # 800070f8 <_ZTV6Thread+0x10>
    800018d0:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    800018d4:	00050613          	mv	a2,a0
    800018d8:	00000597          	auipc	a1,0x0
    800018dc:	e8458593          	addi	a1,a1,-380 # 8000175c <_ZN6Thread12startWrapperEPv>
    800018e0:	00850513          	addi	a0,a0,8
    800018e4:	00000097          	auipc	ra,0x0
    800018e8:	8b0080e7          	jalr	-1872(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800018ec:	00000593          	li	a1,0
    800018f0:	0084b503          	ld	a0,8(s1)
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	c00080e7          	jalr	-1024(ra) # 800014f4 <_ZN7_thread8setStartEb>
}
    800018fc:	01813083          	ld	ra,24(sp)
    80001900:	01013403          	ld	s0,16(sp)
    80001904:	00813483          	ld	s1,8(sp)
    80001908:	02010113          	addi	sp,sp,32
    8000190c:	00008067          	ret

0000000080001910 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001910:	ff010113          	addi	sp,sp,-16
    80001914:	00813423          	sd	s0,8(sp)
    80001918:	01010413          	addi	s0,sp,16
    8000191c:	00813403          	ld	s0,8(sp)
    80001920:	01010113          	addi	sp,sp,16
    80001924:	00008067          	ret

0000000080001928 <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001928:	ff010113          	addi	sp,sp,-16
    8000192c:	00813423          	sd	s0,8(sp)
    80001930:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001934:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001938:	10200073          	sret
}
    8000193c:	00813403          	ld	s0,8(sp)
    80001940:	01010113          	addi	sp,sp,16
    80001944:	00008067          	ret

0000000080001948 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001948:	fb010113          	addi	sp,sp,-80
    8000194c:	04113423          	sd	ra,72(sp)
    80001950:	04813023          	sd	s0,64(sp)
    80001954:	02913c23          	sd	s1,56(sp)
    80001958:	03213823          	sd	s2,48(sp)
    8000195c:	03313423          	sd	s3,40(sp)
    80001960:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001964:	142027f3          	csrr	a5,scause
    80001968:	faf43c23          	sd	a5,-72(s0)
    return scause;
    8000196c:	fb843783          	ld	a5,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001970:	fff00713          	li	a4,-1
    80001974:	03f71713          	slli	a4,a4,0x3f
    80001978:	00170713          	addi	a4,a4,1
    8000197c:	0ee78663          	beq	a5,a4,80001a68 <_ZN5Riscv20handleSupervisorTrapEv+0x120>
    80001980:	fff00713          	li	a4,-1
    80001984:	03f71713          	slli	a4,a4,0x3f
    80001988:	00170713          	addi	a4,a4,1
    8000198c:	06f76a63          	bltu	a4,a5,80001a00 <_ZN5Riscv20handleSupervisorTrapEv+0xb8>
    80001990:	ff878793          	addi	a5,a5,-8
    80001994:	00100713          	li	a4,1
    80001998:	04f76663          	bltu	a4,a5,800019e4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000199c:	141027f3          	csrr	a5,sepc
    800019a0:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    800019a4:	fc843483          	ld	s1,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    800019a8:	00448493          	addi	s1,s1,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800019ac:	100027f3          	csrr	a5,sstatus
    800019b0:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    800019b4:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    800019b8:	00088793          	mv	a5,a7
            switch (scallnum) {
    800019bc:	01200713          	li	a4,18
    800019c0:	08e78063          	beq	a5,a4,80001a40 <_ZN5Riscv20handleSupervisorTrapEv+0xf8>
    800019c4:	01300713          	li	a4,19
    800019c8:	08e78463          	beq	a5,a4,80001a50 <_ZN5Riscv20handleSupervisorTrapEv+0x108>
    800019cc:	01100713          	li	a4,17
    800019d0:	04e78663          	beq	a5,a4,80001a1c <_ZN5Riscv20handleSupervisorTrapEv+0xd4>
    800019d4:	00000793          	li	a5,0
                case SCALL_SEM_SIGNAL:
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
    800019d8:	00078513          	mv	a0,a5
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800019dc:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800019e0:	14149073          	csrw	sepc,s1
            console_handler();
            break;
        default:
            break;
    }
    800019e4:	04813083          	ld	ra,72(sp)
    800019e8:	04013403          	ld	s0,64(sp)
    800019ec:	03813483          	ld	s1,56(sp)
    800019f0:	03013903          	ld	s2,48(sp)
    800019f4:	02813983          	ld	s3,40(sp)
    800019f8:	05010113          	addi	sp,sp,80
    800019fc:	00008067          	ret
    switch((uint64)scause){
    80001a00:	fff00713          	li	a4,-1
    80001a04:	03f71713          	slli	a4,a4,0x3f
    80001a08:	00970713          	addi	a4,a4,9
    80001a0c:	fce79ce3          	bne	a5,a4,800019e4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
            console_handler();
    80001a10:	00003097          	auipc	ra,0x3
    80001a14:	744080e7          	jalr	1860(ra) # 80005154 <console_handler>
    80001a18:	fcdff06f          	j	800019e4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                    READ_REG(handle, "a0");
    80001a1c:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001a20:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001a24:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	8e8080e7          	jalr	-1816(ra) # 80001310 <_ZN7_thread12createThreadEPFvPvES0_>
    80001a30:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001a34:	02050663          	beqz	a0,80001a60 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
    80001a38:	00000793          	li	a5,0
    80001a3c:	f9dff06f          	j	800019d8 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    _thread::exitThread();
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	a78080e7          	jalr	-1416(ra) # 800014b8 <_ZN7_thread10exitThreadEv>
            uint64 ret = 0;
    80001a48:	00000793          	li	a5,0
                    break;
    80001a4c:	f8dff06f          	j	800019d8 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    _thread::dispatch();
    80001a50:	00000097          	auipc	ra,0x0
    80001a54:	998080e7          	jalr	-1640(ra) # 800013e8 <_ZN7_thread8dispatchEv>
            uint64 ret = 0;
    80001a58:	00000793          	li	a5,0
                    break;
    80001a5c:	f7dff06f          	j	800019d8 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    else ret = -1;
    80001a60:	fff00793          	li	a5,-1
    80001a64:	f75ff06f          	j	800019d8 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001a68:	00200793          	li	a5,2
    80001a6c:	1447b073          	csrc	sip,a5
}
    80001a70:	f75ff06f          	j	800019e4 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>

0000000080001a74 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001a74:	ff010113          	addi	sp,sp,-16
    80001a78:	00813423          	sd	s0,8(sp)
    80001a7c:	01010413          	addi	s0,sp,16
    80001a80:	00100793          	li	a5,1
    80001a84:	00f50863          	beq	a0,a5,80001a94 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001a88:	00813403          	ld	s0,8(sp)
    80001a8c:	01010113          	addi	sp,sp,16
    80001a90:	00008067          	ret
    80001a94:	000107b7          	lui	a5,0x10
    80001a98:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001a9c:	fef596e3          	bne	a1,a5,80001a88 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001aa0:	00005797          	auipc	a5,0x5
    80001aa4:	79878793          	addi	a5,a5,1944 # 80007238 <_ZN9Scheduler16readyThreadQueueE>
    80001aa8:	0007b023          	sd	zero,0(a5)
    80001aac:	0007b423          	sd	zero,8(a5)
    80001ab0:	fd9ff06f          	j	80001a88 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001ab4 <_ZN9Scheduler3getEv>:
{
    80001ab4:	fe010113          	addi	sp,sp,-32
    80001ab8:	00113c23          	sd	ra,24(sp)
    80001abc:	00813823          	sd	s0,16(sp)
    80001ac0:	00913423          	sd	s1,8(sp)
    80001ac4:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001ac8:	00005517          	auipc	a0,0x5
    80001acc:	77053503          	ld	a0,1904(a0) # 80007238 <_ZN9Scheduler16readyThreadQueueE>
    80001ad0:	04050263          	beqz	a0,80001b14 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001ad4:	00853783          	ld	a5,8(a0)
    80001ad8:	00005717          	auipc	a4,0x5
    80001adc:	76f73023          	sd	a5,1888(a4) # 80007238 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001ae0:	02078463          	beqz	a5,80001b08 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001ae4:	00053483          	ld	s1,0(a0)
        delete elem;
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	c0c080e7          	jalr	-1012(ra) # 800016f4 <_ZdlPv>
}
    80001af0:	00048513          	mv	a0,s1
    80001af4:	01813083          	ld	ra,24(sp)
    80001af8:	01013403          	ld	s0,16(sp)
    80001afc:	00813483          	ld	s1,8(sp)
    80001b00:	02010113          	addi	sp,sp,32
    80001b04:	00008067          	ret
        if (!head) { tail = 0; }
    80001b08:	00005797          	auipc	a5,0x5
    80001b0c:	7207bc23          	sd	zero,1848(a5) # 80007240 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b10:	fd5ff06f          	j	80001ae4 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001b14:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001b18:	fd9ff06f          	j	80001af0 <_ZN9Scheduler3getEv+0x3c>

0000000080001b1c <_ZN9Scheduler3putEP7_thread>:
{
    80001b1c:	fe010113          	addi	sp,sp,-32
    80001b20:	00113c23          	sd	ra,24(sp)
    80001b24:	00813823          	sd	s0,16(sp)
    80001b28:	00913423          	sd	s1,8(sp)
    80001b2c:	02010413          	addi	s0,sp,32
    80001b30:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001b34:	01000513          	li	a0,16
    80001b38:	00000097          	auipc	ra,0x0
    80001b3c:	b6c080e7          	jalr	-1172(ra) # 800016a4 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001b40:	00953023          	sd	s1,0(a0)
    80001b44:	00053423          	sd	zero,8(a0)
        if (tail)
    80001b48:	00005797          	auipc	a5,0x5
    80001b4c:	6f87b783          	ld	a5,1784(a5) # 80007240 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b50:	02078263          	beqz	a5,80001b74 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80001b54:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001b58:	00005797          	auipc	a5,0x5
    80001b5c:	6ea7b423          	sd	a0,1768(a5) # 80007240 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b60:	01813083          	ld	ra,24(sp)
    80001b64:	01013403          	ld	s0,16(sp)
    80001b68:	00813483          	ld	s1,8(sp)
    80001b6c:	02010113          	addi	sp,sp,32
    80001b70:	00008067          	ret
            head = tail = elem;
    80001b74:	00005797          	auipc	a5,0x5
    80001b78:	6c478793          	addi	a5,a5,1732 # 80007238 <_ZN9Scheduler16readyThreadQueueE>
    80001b7c:	00a7b423          	sd	a0,8(a5)
    80001b80:	00a7b023          	sd	a0,0(a5)
    80001b84:	fddff06f          	j	80001b60 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080001b88 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80001b88:	ff010113          	addi	sp,sp,-16
    80001b8c:	00113423          	sd	ra,8(sp)
    80001b90:	00813023          	sd	s0,0(sp)
    80001b94:	01010413          	addi	s0,sp,16
    80001b98:	000105b7          	lui	a1,0x10
    80001b9c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001ba0:	00100513          	li	a0,1
    80001ba4:	00000097          	auipc	ra,0x0
    80001ba8:	ed0080e7          	jalr	-304(ra) # 80001a74 <_Z41__static_initialization_and_destruction_0ii>
    80001bac:	00813083          	ld	ra,8(sp)
    80001bb0:	00013403          	ld	s0,0(sp)
    80001bb4:	01010113          	addi	sp,sp,16
    80001bb8:	00008067          	ret

0000000080001bbc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001bbc:	fe010113          	addi	sp,sp,-32
    80001bc0:	00113c23          	sd	ra,24(sp)
    80001bc4:	00813823          	sd	s0,16(sp)
    80001bc8:	00913423          	sd	s1,8(sp)
    80001bcc:	01213023          	sd	s2,0(sp)
    80001bd0:	02010413          	addi	s0,sp,32
    80001bd4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001bd8:	00100793          	li	a5,1
    80001bdc:	02a7f863          	bgeu	a5,a0,80001c0c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001be0:	00a00793          	li	a5,10
    80001be4:	02f577b3          	remu	a5,a0,a5
    80001be8:	02078e63          	beqz	a5,80001c24 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001bec:	fff48513          	addi	a0,s1,-1
    80001bf0:	00000097          	auipc	ra,0x0
    80001bf4:	fcc080e7          	jalr	-52(ra) # 80001bbc <_ZL9fibonaccim>
    80001bf8:	00050913          	mv	s2,a0
    80001bfc:	ffe48513          	addi	a0,s1,-2
    80001c00:	00000097          	auipc	ra,0x0
    80001c04:	fbc080e7          	jalr	-68(ra) # 80001bbc <_ZL9fibonaccim>
    80001c08:	00a90533          	add	a0,s2,a0
}
    80001c0c:	01813083          	ld	ra,24(sp)
    80001c10:	01013403          	ld	s0,16(sp)
    80001c14:	00813483          	ld	s1,8(sp)
    80001c18:	00013903          	ld	s2,0(sp)
    80001c1c:	02010113          	addi	sp,sp,32
    80001c20:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001c24:	fffff097          	auipc	ra,0xfffff
    80001c28:	5c8080e7          	jalr	1480(ra) # 800011ec <_Z15thread_dispatchv>
    80001c2c:	fc1ff06f          	j	80001bec <_ZL9fibonaccim+0x30>

0000000080001c30 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80001c30:	fe010113          	addi	sp,sp,-32
    80001c34:	00113c23          	sd	ra,24(sp)
    80001c38:	00813823          	sd	s0,16(sp)
    80001c3c:	00913423          	sd	s1,8(sp)
    80001c40:	01213023          	sd	s2,0(sp)
    80001c44:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001c48:	00000913          	li	s2,0
    80001c4c:	0380006f          	j	80001c84 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001c50:	fffff097          	auipc	ra,0xfffff
    80001c54:	59c080e7          	jalr	1436(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001c58:	00148493          	addi	s1,s1,1
    80001c5c:	000027b7          	lui	a5,0x2
    80001c60:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001c64:	0097ee63          	bltu	a5,s1,80001c80 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001c68:	00000713          	li	a4,0
    80001c6c:	000077b7          	lui	a5,0x7
    80001c70:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001c74:	fce7eee3          	bltu	a5,a4,80001c50 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80001c78:	00170713          	addi	a4,a4,1
    80001c7c:	ff1ff06f          	j	80001c6c <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001c80:	00190913          	addi	s2,s2,1
    80001c84:	00900793          	li	a5,9
    80001c88:	0527e063          	bltu	a5,s2,80001cc8 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001c8c:	00004517          	auipc	a0,0x4
    80001c90:	52450513          	addi	a0,a0,1316 # 800061b0 <kvmincrease+0xfb0>
    80001c94:	00001097          	auipc	ra,0x1
    80001c98:	e9c080e7          	jalr	-356(ra) # 80002b30 <_Z11printStringPKc>
    80001c9c:	00000613          	li	a2,0
    80001ca0:	00a00593          	li	a1,10
    80001ca4:	0009051b          	sext.w	a0,s2
    80001ca8:	00001097          	auipc	ra,0x1
    80001cac:	038080e7          	jalr	56(ra) # 80002ce0 <_Z8printIntiii>
    80001cb0:	00004517          	auipc	a0,0x4
    80001cb4:	4f850513          	addi	a0,a0,1272 # 800061a8 <kvmincrease+0xfa8>
    80001cb8:	00001097          	auipc	ra,0x1
    80001cbc:	e78080e7          	jalr	-392(ra) # 80002b30 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001cc0:	00000493          	li	s1,0
    80001cc4:	f99ff06f          	j	80001c5c <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80001cc8:	00004517          	auipc	a0,0x4
    80001ccc:	4f050513          	addi	a0,a0,1264 # 800061b8 <kvmincrease+0xfb8>
    80001cd0:	00001097          	auipc	ra,0x1
    80001cd4:	e60080e7          	jalr	-416(ra) # 80002b30 <_Z11printStringPKc>
    finishedA = true;
    80001cd8:	00100793          	li	a5,1
    80001cdc:	00005717          	auipc	a4,0x5
    80001ce0:	56f70623          	sb	a5,1388(a4) # 80007248 <_ZL9finishedA>
}
    80001ce4:	01813083          	ld	ra,24(sp)
    80001ce8:	01013403          	ld	s0,16(sp)
    80001cec:	00813483          	ld	s1,8(sp)
    80001cf0:	00013903          	ld	s2,0(sp)
    80001cf4:	02010113          	addi	sp,sp,32
    80001cf8:	00008067          	ret

0000000080001cfc <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80001cfc:	fe010113          	addi	sp,sp,-32
    80001d00:	00113c23          	sd	ra,24(sp)
    80001d04:	00813823          	sd	s0,16(sp)
    80001d08:	00913423          	sd	s1,8(sp)
    80001d0c:	01213023          	sd	s2,0(sp)
    80001d10:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001d14:	00000913          	li	s2,0
    80001d18:	0380006f          	j	80001d50 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80001d1c:	fffff097          	auipc	ra,0xfffff
    80001d20:	4d0080e7          	jalr	1232(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001d24:	00148493          	addi	s1,s1,1
    80001d28:	000027b7          	lui	a5,0x2
    80001d2c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001d30:	0097ee63          	bltu	a5,s1,80001d4c <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001d34:	00000713          	li	a4,0
    80001d38:	000077b7          	lui	a5,0x7
    80001d3c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001d40:	fce7eee3          	bltu	a5,a4,80001d1c <_ZN7WorkerB11workerBodyBEPv+0x20>
    80001d44:	00170713          	addi	a4,a4,1
    80001d48:	ff1ff06f          	j	80001d38 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001d4c:	00190913          	addi	s2,s2,1
    80001d50:	00f00793          	li	a5,15
    80001d54:	0527e063          	bltu	a5,s2,80001d94 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001d58:	00004517          	auipc	a0,0x4
    80001d5c:	47050513          	addi	a0,a0,1136 # 800061c8 <kvmincrease+0xfc8>
    80001d60:	00001097          	auipc	ra,0x1
    80001d64:	dd0080e7          	jalr	-560(ra) # 80002b30 <_Z11printStringPKc>
    80001d68:	00000613          	li	a2,0
    80001d6c:	00a00593          	li	a1,10
    80001d70:	0009051b          	sext.w	a0,s2
    80001d74:	00001097          	auipc	ra,0x1
    80001d78:	f6c080e7          	jalr	-148(ra) # 80002ce0 <_Z8printIntiii>
    80001d7c:	00004517          	auipc	a0,0x4
    80001d80:	42c50513          	addi	a0,a0,1068 # 800061a8 <kvmincrease+0xfa8>
    80001d84:	00001097          	auipc	ra,0x1
    80001d88:	dac080e7          	jalr	-596(ra) # 80002b30 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001d8c:	00000493          	li	s1,0
    80001d90:	f99ff06f          	j	80001d28 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80001d94:	00004517          	auipc	a0,0x4
    80001d98:	43c50513          	addi	a0,a0,1084 # 800061d0 <kvmincrease+0xfd0>
    80001d9c:	00001097          	auipc	ra,0x1
    80001da0:	d94080e7          	jalr	-620(ra) # 80002b30 <_Z11printStringPKc>
    finishedB = true;
    80001da4:	00100793          	li	a5,1
    80001da8:	00005717          	auipc	a4,0x5
    80001dac:	4af700a3          	sb	a5,1185(a4) # 80007249 <_ZL9finishedB>
    thread_dispatch();
    80001db0:	fffff097          	auipc	ra,0xfffff
    80001db4:	43c080e7          	jalr	1084(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001db8:	01813083          	ld	ra,24(sp)
    80001dbc:	01013403          	ld	s0,16(sp)
    80001dc0:	00813483          	ld	s1,8(sp)
    80001dc4:	00013903          	ld	s2,0(sp)
    80001dc8:	02010113          	addi	sp,sp,32
    80001dcc:	00008067          	ret

0000000080001dd0 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80001dd0:	fe010113          	addi	sp,sp,-32
    80001dd4:	00113c23          	sd	ra,24(sp)
    80001dd8:	00813823          	sd	s0,16(sp)
    80001ddc:	00913423          	sd	s1,8(sp)
    80001de0:	01213023          	sd	s2,0(sp)
    80001de4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001de8:	00000493          	li	s1,0
    80001dec:	0400006f          	j	80001e2c <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001df0:	00004517          	auipc	a0,0x4
    80001df4:	3f050513          	addi	a0,a0,1008 # 800061e0 <kvmincrease+0xfe0>
    80001df8:	00001097          	auipc	ra,0x1
    80001dfc:	d38080e7          	jalr	-712(ra) # 80002b30 <_Z11printStringPKc>
    80001e00:	00000613          	li	a2,0
    80001e04:	00a00593          	li	a1,10
    80001e08:	00048513          	mv	a0,s1
    80001e0c:	00001097          	auipc	ra,0x1
    80001e10:	ed4080e7          	jalr	-300(ra) # 80002ce0 <_Z8printIntiii>
    80001e14:	00004517          	auipc	a0,0x4
    80001e18:	39450513          	addi	a0,a0,916 # 800061a8 <kvmincrease+0xfa8>
    80001e1c:	00001097          	auipc	ra,0x1
    80001e20:	d14080e7          	jalr	-748(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001e24:	0014849b          	addiw	s1,s1,1
    80001e28:	0ff4f493          	andi	s1,s1,255
    80001e2c:	00200793          	li	a5,2
    80001e30:	fc97f0e3          	bgeu	a5,s1,80001df0 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80001e34:	00004517          	auipc	a0,0x4
    80001e38:	3b450513          	addi	a0,a0,948 # 800061e8 <kvmincrease+0xfe8>
    80001e3c:	00001097          	auipc	ra,0x1
    80001e40:	cf4080e7          	jalr	-780(ra) # 80002b30 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001e44:	00700313          	li	t1,7
    thread_dispatch();
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	3a4080e7          	jalr	932(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001e50:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80001e54:	00004517          	auipc	a0,0x4
    80001e58:	3a450513          	addi	a0,a0,932 # 800061f8 <kvmincrease+0xff8>
    80001e5c:	00001097          	auipc	ra,0x1
    80001e60:	cd4080e7          	jalr	-812(ra) # 80002b30 <_Z11printStringPKc>
    80001e64:	00000613          	li	a2,0
    80001e68:	00a00593          	li	a1,10
    80001e6c:	0009051b          	sext.w	a0,s2
    80001e70:	00001097          	auipc	ra,0x1
    80001e74:	e70080e7          	jalr	-400(ra) # 80002ce0 <_Z8printIntiii>
    80001e78:	00004517          	auipc	a0,0x4
    80001e7c:	33050513          	addi	a0,a0,816 # 800061a8 <kvmincrease+0xfa8>
    80001e80:	00001097          	auipc	ra,0x1
    80001e84:	cb0080e7          	jalr	-848(ra) # 80002b30 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80001e88:	00c00513          	li	a0,12
    80001e8c:	00000097          	auipc	ra,0x0
    80001e90:	d30080e7          	jalr	-720(ra) # 80001bbc <_ZL9fibonaccim>
    80001e94:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001e98:	00004517          	auipc	a0,0x4
    80001e9c:	36850513          	addi	a0,a0,872 # 80006200 <kvmincrease+0x1000>
    80001ea0:	00001097          	auipc	ra,0x1
    80001ea4:	c90080e7          	jalr	-880(ra) # 80002b30 <_Z11printStringPKc>
    80001ea8:	00000613          	li	a2,0
    80001eac:	00a00593          	li	a1,10
    80001eb0:	0009051b          	sext.w	a0,s2
    80001eb4:	00001097          	auipc	ra,0x1
    80001eb8:	e2c080e7          	jalr	-468(ra) # 80002ce0 <_Z8printIntiii>
    80001ebc:	00004517          	auipc	a0,0x4
    80001ec0:	2ec50513          	addi	a0,a0,748 # 800061a8 <kvmincrease+0xfa8>
    80001ec4:	00001097          	auipc	ra,0x1
    80001ec8:	c6c080e7          	jalr	-916(ra) # 80002b30 <_Z11printStringPKc>
    80001ecc:	0400006f          	j	80001f0c <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80001ed0:	00004517          	auipc	a0,0x4
    80001ed4:	31050513          	addi	a0,a0,784 # 800061e0 <kvmincrease+0xfe0>
    80001ed8:	00001097          	auipc	ra,0x1
    80001edc:	c58080e7          	jalr	-936(ra) # 80002b30 <_Z11printStringPKc>
    80001ee0:	00000613          	li	a2,0
    80001ee4:	00a00593          	li	a1,10
    80001ee8:	00048513          	mv	a0,s1
    80001eec:	00001097          	auipc	ra,0x1
    80001ef0:	df4080e7          	jalr	-524(ra) # 80002ce0 <_Z8printIntiii>
    80001ef4:	00004517          	auipc	a0,0x4
    80001ef8:	2b450513          	addi	a0,a0,692 # 800061a8 <kvmincrease+0xfa8>
    80001efc:	00001097          	auipc	ra,0x1
    80001f00:	c34080e7          	jalr	-972(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001f04:	0014849b          	addiw	s1,s1,1
    80001f08:	0ff4f493          	andi	s1,s1,255
    80001f0c:	00500793          	li	a5,5
    80001f10:	fc97f0e3          	bgeu	a5,s1,80001ed0 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80001f14:	00004517          	auipc	a0,0x4
    80001f18:	2a450513          	addi	a0,a0,676 # 800061b8 <kvmincrease+0xfb8>
    80001f1c:	00001097          	auipc	ra,0x1
    80001f20:	c14080e7          	jalr	-1004(ra) # 80002b30 <_Z11printStringPKc>
    finishedC = true;
    80001f24:	00100793          	li	a5,1
    80001f28:	00005717          	auipc	a4,0x5
    80001f2c:	32f70123          	sb	a5,802(a4) # 8000724a <_ZL9finishedC>
    thread_dispatch();
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	2bc080e7          	jalr	700(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001f38:	01813083          	ld	ra,24(sp)
    80001f3c:	01013403          	ld	s0,16(sp)
    80001f40:	00813483          	ld	s1,8(sp)
    80001f44:	00013903          	ld	s2,0(sp)
    80001f48:	02010113          	addi	sp,sp,32
    80001f4c:	00008067          	ret

0000000080001f50 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80001f50:	fe010113          	addi	sp,sp,-32
    80001f54:	00113c23          	sd	ra,24(sp)
    80001f58:	00813823          	sd	s0,16(sp)
    80001f5c:	00913423          	sd	s1,8(sp)
    80001f60:	01213023          	sd	s2,0(sp)
    80001f64:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001f68:	00a00493          	li	s1,10
    80001f6c:	0400006f          	j	80001fac <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001f70:	00004517          	auipc	a0,0x4
    80001f74:	2a050513          	addi	a0,a0,672 # 80006210 <kvmincrease+0x1010>
    80001f78:	00001097          	auipc	ra,0x1
    80001f7c:	bb8080e7          	jalr	-1096(ra) # 80002b30 <_Z11printStringPKc>
    80001f80:	00000613          	li	a2,0
    80001f84:	00a00593          	li	a1,10
    80001f88:	00048513          	mv	a0,s1
    80001f8c:	00001097          	auipc	ra,0x1
    80001f90:	d54080e7          	jalr	-684(ra) # 80002ce0 <_Z8printIntiii>
    80001f94:	00004517          	auipc	a0,0x4
    80001f98:	21450513          	addi	a0,a0,532 # 800061a8 <kvmincrease+0xfa8>
    80001f9c:	00001097          	auipc	ra,0x1
    80001fa0:	b94080e7          	jalr	-1132(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001fa4:	0014849b          	addiw	s1,s1,1
    80001fa8:	0ff4f493          	andi	s1,s1,255
    80001fac:	00c00793          	li	a5,12
    80001fb0:	fc97f0e3          	bgeu	a5,s1,80001f70 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80001fb4:	00004517          	auipc	a0,0x4
    80001fb8:	26450513          	addi	a0,a0,612 # 80006218 <kvmincrease+0x1018>
    80001fbc:	00001097          	auipc	ra,0x1
    80001fc0:	b74080e7          	jalr	-1164(ra) # 80002b30 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001fc4:	00500313          	li	t1,5
    thread_dispatch();
    80001fc8:	fffff097          	auipc	ra,0xfffff
    80001fcc:	224080e7          	jalr	548(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001fd0:	01000513          	li	a0,16
    80001fd4:	00000097          	auipc	ra,0x0
    80001fd8:	be8080e7          	jalr	-1048(ra) # 80001bbc <_ZL9fibonaccim>
    80001fdc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001fe0:	00004517          	auipc	a0,0x4
    80001fe4:	24850513          	addi	a0,a0,584 # 80006228 <kvmincrease+0x1028>
    80001fe8:	00001097          	auipc	ra,0x1
    80001fec:	b48080e7          	jalr	-1208(ra) # 80002b30 <_Z11printStringPKc>
    80001ff0:	00000613          	li	a2,0
    80001ff4:	00a00593          	li	a1,10
    80001ff8:	0009051b          	sext.w	a0,s2
    80001ffc:	00001097          	auipc	ra,0x1
    80002000:	ce4080e7          	jalr	-796(ra) # 80002ce0 <_Z8printIntiii>
    80002004:	00004517          	auipc	a0,0x4
    80002008:	1a450513          	addi	a0,a0,420 # 800061a8 <kvmincrease+0xfa8>
    8000200c:	00001097          	auipc	ra,0x1
    80002010:	b24080e7          	jalr	-1244(ra) # 80002b30 <_Z11printStringPKc>
    80002014:	0400006f          	j	80002054 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002018:	00004517          	auipc	a0,0x4
    8000201c:	1f850513          	addi	a0,a0,504 # 80006210 <kvmincrease+0x1010>
    80002020:	00001097          	auipc	ra,0x1
    80002024:	b10080e7          	jalr	-1264(ra) # 80002b30 <_Z11printStringPKc>
    80002028:	00000613          	li	a2,0
    8000202c:	00a00593          	li	a1,10
    80002030:	00048513          	mv	a0,s1
    80002034:	00001097          	auipc	ra,0x1
    80002038:	cac080e7          	jalr	-852(ra) # 80002ce0 <_Z8printIntiii>
    8000203c:	00004517          	auipc	a0,0x4
    80002040:	16c50513          	addi	a0,a0,364 # 800061a8 <kvmincrease+0xfa8>
    80002044:	00001097          	auipc	ra,0x1
    80002048:	aec080e7          	jalr	-1300(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000204c:	0014849b          	addiw	s1,s1,1
    80002050:	0ff4f493          	andi	s1,s1,255
    80002054:	00f00793          	li	a5,15
    80002058:	fc97f0e3          	bgeu	a5,s1,80002018 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    8000205c:	00004517          	auipc	a0,0x4
    80002060:	1dc50513          	addi	a0,a0,476 # 80006238 <kvmincrease+0x1038>
    80002064:	00001097          	auipc	ra,0x1
    80002068:	acc080e7          	jalr	-1332(ra) # 80002b30 <_Z11printStringPKc>
    finishedD = true;
    8000206c:	00100793          	li	a5,1
    80002070:	00005717          	auipc	a4,0x5
    80002074:	1cf70da3          	sb	a5,475(a4) # 8000724b <_ZL9finishedD>
    thread_dispatch();
    80002078:	fffff097          	auipc	ra,0xfffff
    8000207c:	174080e7          	jalr	372(ra) # 800011ec <_Z15thread_dispatchv>
}
    80002080:	01813083          	ld	ra,24(sp)
    80002084:	01013403          	ld	s0,16(sp)
    80002088:	00813483          	ld	s1,8(sp)
    8000208c:	00013903          	ld	s2,0(sp)
    80002090:	02010113          	addi	sp,sp,32
    80002094:	00008067          	ret

0000000080002098 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002098:	fc010113          	addi	sp,sp,-64
    8000209c:	02113c23          	sd	ra,56(sp)
    800020a0:	02813823          	sd	s0,48(sp)
    800020a4:	02913423          	sd	s1,40(sp)
    800020a8:	03213023          	sd	s2,32(sp)
    800020ac:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800020b0:	02000513          	li	a0,32
    800020b4:	fffff097          	auipc	ra,0xfffff
    800020b8:	5f0080e7          	jalr	1520(ra) # 800016a4 <_Znwm>
    800020bc:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	7f0080e7          	jalr	2032(ra) # 800018b0 <_ZN6ThreadC1Ev>
    800020c8:	00005797          	auipc	a5,0x5
    800020cc:	05878793          	addi	a5,a5,88 # 80007120 <_ZTV7WorkerA+0x10>
    800020d0:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    800020d4:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    800020d8:	00004517          	auipc	a0,0x4
    800020dc:	17050513          	addi	a0,a0,368 # 80006248 <kvmincrease+0x1048>
    800020e0:	00001097          	auipc	ra,0x1
    800020e4:	a50080e7          	jalr	-1456(ra) # 80002b30 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800020e8:	02000513          	li	a0,32
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	5b8080e7          	jalr	1464(ra) # 800016a4 <_Znwm>
    800020f4:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800020f8:	fffff097          	auipc	ra,0xfffff
    800020fc:	7b8080e7          	jalr	1976(ra) # 800018b0 <_ZN6ThreadC1Ev>
    80002100:	00005797          	auipc	a5,0x5
    80002104:	04878793          	addi	a5,a5,72 # 80007148 <_ZTV7WorkerB+0x10>
    80002108:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    8000210c:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002110:	00004517          	auipc	a0,0x4
    80002114:	15050513          	addi	a0,a0,336 # 80006260 <kvmincrease+0x1060>
    80002118:	00001097          	auipc	ra,0x1
    8000211c:	a18080e7          	jalr	-1512(ra) # 80002b30 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002120:	02000513          	li	a0,32
    80002124:	fffff097          	auipc	ra,0xfffff
    80002128:	580080e7          	jalr	1408(ra) # 800016a4 <_Znwm>
    8000212c:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	780080e7          	jalr	1920(ra) # 800018b0 <_ZN6ThreadC1Ev>
    80002138:	00005797          	auipc	a5,0x5
    8000213c:	03878793          	addi	a5,a5,56 # 80007170 <_ZTV7WorkerC+0x10>
    80002140:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002144:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002148:	00004517          	auipc	a0,0x4
    8000214c:	13050513          	addi	a0,a0,304 # 80006278 <kvmincrease+0x1078>
    80002150:	00001097          	auipc	ra,0x1
    80002154:	9e0080e7          	jalr	-1568(ra) # 80002b30 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002158:	02000513          	li	a0,32
    8000215c:	fffff097          	auipc	ra,0xfffff
    80002160:	548080e7          	jalr	1352(ra) # 800016a4 <_Znwm>
    80002164:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	748080e7          	jalr	1864(ra) # 800018b0 <_ZN6ThreadC1Ev>
    80002170:	00005797          	auipc	a5,0x5
    80002174:	02878793          	addi	a5,a5,40 # 80007198 <_ZTV7WorkerD+0x10>
    80002178:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    8000217c:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002180:	00004517          	auipc	a0,0x4
    80002184:	11050513          	addi	a0,a0,272 # 80006290 <kvmincrease+0x1090>
    80002188:	00001097          	auipc	ra,0x1
    8000218c:	9a8080e7          	jalr	-1624(ra) # 80002b30 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002190:	00000493          	li	s1,0
    80002194:	00300793          	li	a5,3
    80002198:	0297c663          	blt	a5,s1,800021c4 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    8000219c:	00349793          	slli	a5,s1,0x3
    800021a0:	fe040713          	addi	a4,s0,-32
    800021a4:	00f707b3          	add	a5,a4,a5
    800021a8:	fe07b503          	ld	a0,-32(a5)
    800021ac:	fffff097          	auipc	ra,0xfffff
    800021b0:	6a8080e7          	jalr	1704(ra) # 80001854 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    800021b4:	0014849b          	addiw	s1,s1,1
    800021b8:	fddff06f          	j	80002194 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    800021bc:	fffff097          	auipc	ra,0xfffff
    800021c0:	6cc080e7          	jalr	1740(ra) # 80001888 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800021c4:	00005797          	auipc	a5,0x5
    800021c8:	0847c783          	lbu	a5,132(a5) # 80007248 <_ZL9finishedA>
    800021cc:	fe0788e3          	beqz	a5,800021bc <_Z20Threads_CPP_API_testv+0x124>
    800021d0:	00005797          	auipc	a5,0x5
    800021d4:	0797c783          	lbu	a5,121(a5) # 80007249 <_ZL9finishedB>
    800021d8:	fe0782e3          	beqz	a5,800021bc <_Z20Threads_CPP_API_testv+0x124>
    800021dc:	00005797          	auipc	a5,0x5
    800021e0:	06e7c783          	lbu	a5,110(a5) # 8000724a <_ZL9finishedC>
    800021e4:	fc078ce3          	beqz	a5,800021bc <_Z20Threads_CPP_API_testv+0x124>
    800021e8:	00005797          	auipc	a5,0x5
    800021ec:	0637c783          	lbu	a5,99(a5) # 8000724b <_ZL9finishedD>
    800021f0:	fc0786e3          	beqz	a5,800021bc <_Z20Threads_CPP_API_testv+0x124>
    800021f4:	fc040493          	addi	s1,s0,-64
    800021f8:	0080006f          	j	80002200 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    800021fc:	00848493          	addi	s1,s1,8
    80002200:	fe040793          	addi	a5,s0,-32
    80002204:	08f48663          	beq	s1,a5,80002290 <_Z20Threads_CPP_API_testv+0x1f8>
    80002208:	0004b503          	ld	a0,0(s1)
    8000220c:	fe0508e3          	beqz	a0,800021fc <_Z20Threads_CPP_API_testv+0x164>
    80002210:	00053783          	ld	a5,0(a0)
    80002214:	0087b783          	ld	a5,8(a5)
    80002218:	000780e7          	jalr	a5
    8000221c:	fe1ff06f          	j	800021fc <_Z20Threads_CPP_API_testv+0x164>
    80002220:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002224:	00048513          	mv	a0,s1
    80002228:	fffff097          	auipc	ra,0xfffff
    8000222c:	4cc080e7          	jalr	1228(ra) # 800016f4 <_ZdlPv>
    80002230:	00090513          	mv	a0,s2
    80002234:	00006097          	auipc	ra,0x6
    80002238:	0f4080e7          	jalr	244(ra) # 80008328 <_Unwind_Resume>
    8000223c:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002240:	00048513          	mv	a0,s1
    80002244:	fffff097          	auipc	ra,0xfffff
    80002248:	4b0080e7          	jalr	1200(ra) # 800016f4 <_ZdlPv>
    8000224c:	00090513          	mv	a0,s2
    80002250:	00006097          	auipc	ra,0x6
    80002254:	0d8080e7          	jalr	216(ra) # 80008328 <_Unwind_Resume>
    80002258:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    8000225c:	00048513          	mv	a0,s1
    80002260:	fffff097          	auipc	ra,0xfffff
    80002264:	494080e7          	jalr	1172(ra) # 800016f4 <_ZdlPv>
    80002268:	00090513          	mv	a0,s2
    8000226c:	00006097          	auipc	ra,0x6
    80002270:	0bc080e7          	jalr	188(ra) # 80008328 <_Unwind_Resume>
    80002274:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002278:	00048513          	mv	a0,s1
    8000227c:	fffff097          	auipc	ra,0xfffff
    80002280:	478080e7          	jalr	1144(ra) # 800016f4 <_ZdlPv>
    80002284:	00090513          	mv	a0,s2
    80002288:	00006097          	auipc	ra,0x6
    8000228c:	0a0080e7          	jalr	160(ra) # 80008328 <_Unwind_Resume>
}
    80002290:	03813083          	ld	ra,56(sp)
    80002294:	03013403          	ld	s0,48(sp)
    80002298:	02813483          	ld	s1,40(sp)
    8000229c:	02013903          	ld	s2,32(sp)
    800022a0:	04010113          	addi	sp,sp,64
    800022a4:	00008067          	ret

00000000800022a8 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    800022a8:	ff010113          	addi	sp,sp,-16
    800022ac:	00113423          	sd	ra,8(sp)
    800022b0:	00813023          	sd	s0,0(sp)
    800022b4:	01010413          	addi	s0,sp,16
    800022b8:	00005797          	auipc	a5,0x5
    800022bc:	e6878793          	addi	a5,a5,-408 # 80007120 <_ZTV7WorkerA+0x10>
    800022c0:	00f53023          	sd	a5,0(a0)
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	480080e7          	jalr	1152(ra) # 80001744 <_ZN6ThreadD1Ev>
    800022cc:	00813083          	ld	ra,8(sp)
    800022d0:	00013403          	ld	s0,0(sp)
    800022d4:	01010113          	addi	sp,sp,16
    800022d8:	00008067          	ret

00000000800022dc <_ZN7WorkerAD0Ev>:
    800022dc:	fe010113          	addi	sp,sp,-32
    800022e0:	00113c23          	sd	ra,24(sp)
    800022e4:	00813823          	sd	s0,16(sp)
    800022e8:	00913423          	sd	s1,8(sp)
    800022ec:	02010413          	addi	s0,sp,32
    800022f0:	00050493          	mv	s1,a0
    800022f4:	00005797          	auipc	a5,0x5
    800022f8:	e2c78793          	addi	a5,a5,-468 # 80007120 <_ZTV7WorkerA+0x10>
    800022fc:	00f53023          	sd	a5,0(a0)
    80002300:	fffff097          	auipc	ra,0xfffff
    80002304:	444080e7          	jalr	1092(ra) # 80001744 <_ZN6ThreadD1Ev>
    80002308:	00048513          	mv	a0,s1
    8000230c:	fffff097          	auipc	ra,0xfffff
    80002310:	3e8080e7          	jalr	1000(ra) # 800016f4 <_ZdlPv>
    80002314:	01813083          	ld	ra,24(sp)
    80002318:	01013403          	ld	s0,16(sp)
    8000231c:	00813483          	ld	s1,8(sp)
    80002320:	02010113          	addi	sp,sp,32
    80002324:	00008067          	ret

0000000080002328 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00113423          	sd	ra,8(sp)
    80002330:	00813023          	sd	s0,0(sp)
    80002334:	01010413          	addi	s0,sp,16
    80002338:	00005797          	auipc	a5,0x5
    8000233c:	e1078793          	addi	a5,a5,-496 # 80007148 <_ZTV7WorkerB+0x10>
    80002340:	00f53023          	sd	a5,0(a0)
    80002344:	fffff097          	auipc	ra,0xfffff
    80002348:	400080e7          	jalr	1024(ra) # 80001744 <_ZN6ThreadD1Ev>
    8000234c:	00813083          	ld	ra,8(sp)
    80002350:	00013403          	ld	s0,0(sp)
    80002354:	01010113          	addi	sp,sp,16
    80002358:	00008067          	ret

000000008000235c <_ZN7WorkerBD0Ev>:
    8000235c:	fe010113          	addi	sp,sp,-32
    80002360:	00113c23          	sd	ra,24(sp)
    80002364:	00813823          	sd	s0,16(sp)
    80002368:	00913423          	sd	s1,8(sp)
    8000236c:	02010413          	addi	s0,sp,32
    80002370:	00050493          	mv	s1,a0
    80002374:	00005797          	auipc	a5,0x5
    80002378:	dd478793          	addi	a5,a5,-556 # 80007148 <_ZTV7WorkerB+0x10>
    8000237c:	00f53023          	sd	a5,0(a0)
    80002380:	fffff097          	auipc	ra,0xfffff
    80002384:	3c4080e7          	jalr	964(ra) # 80001744 <_ZN6ThreadD1Ev>
    80002388:	00048513          	mv	a0,s1
    8000238c:	fffff097          	auipc	ra,0xfffff
    80002390:	368080e7          	jalr	872(ra) # 800016f4 <_ZdlPv>
    80002394:	01813083          	ld	ra,24(sp)
    80002398:	01013403          	ld	s0,16(sp)
    8000239c:	00813483          	ld	s1,8(sp)
    800023a0:	02010113          	addi	sp,sp,32
    800023a4:	00008067          	ret

00000000800023a8 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    800023a8:	ff010113          	addi	sp,sp,-16
    800023ac:	00113423          	sd	ra,8(sp)
    800023b0:	00813023          	sd	s0,0(sp)
    800023b4:	01010413          	addi	s0,sp,16
    800023b8:	00005797          	auipc	a5,0x5
    800023bc:	db878793          	addi	a5,a5,-584 # 80007170 <_ZTV7WorkerC+0x10>
    800023c0:	00f53023          	sd	a5,0(a0)
    800023c4:	fffff097          	auipc	ra,0xfffff
    800023c8:	380080e7          	jalr	896(ra) # 80001744 <_ZN6ThreadD1Ev>
    800023cc:	00813083          	ld	ra,8(sp)
    800023d0:	00013403          	ld	s0,0(sp)
    800023d4:	01010113          	addi	sp,sp,16
    800023d8:	00008067          	ret

00000000800023dc <_ZN7WorkerCD0Ev>:
    800023dc:	fe010113          	addi	sp,sp,-32
    800023e0:	00113c23          	sd	ra,24(sp)
    800023e4:	00813823          	sd	s0,16(sp)
    800023e8:	00913423          	sd	s1,8(sp)
    800023ec:	02010413          	addi	s0,sp,32
    800023f0:	00050493          	mv	s1,a0
    800023f4:	00005797          	auipc	a5,0x5
    800023f8:	d7c78793          	addi	a5,a5,-644 # 80007170 <_ZTV7WorkerC+0x10>
    800023fc:	00f53023          	sd	a5,0(a0)
    80002400:	fffff097          	auipc	ra,0xfffff
    80002404:	344080e7          	jalr	836(ra) # 80001744 <_ZN6ThreadD1Ev>
    80002408:	00048513          	mv	a0,s1
    8000240c:	fffff097          	auipc	ra,0xfffff
    80002410:	2e8080e7          	jalr	744(ra) # 800016f4 <_ZdlPv>
    80002414:	01813083          	ld	ra,24(sp)
    80002418:	01013403          	ld	s0,16(sp)
    8000241c:	00813483          	ld	s1,8(sp)
    80002420:	02010113          	addi	sp,sp,32
    80002424:	00008067          	ret

0000000080002428 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002428:	ff010113          	addi	sp,sp,-16
    8000242c:	00113423          	sd	ra,8(sp)
    80002430:	00813023          	sd	s0,0(sp)
    80002434:	01010413          	addi	s0,sp,16
    80002438:	00005797          	auipc	a5,0x5
    8000243c:	d6078793          	addi	a5,a5,-672 # 80007198 <_ZTV7WorkerD+0x10>
    80002440:	00f53023          	sd	a5,0(a0)
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	300080e7          	jalr	768(ra) # 80001744 <_ZN6ThreadD1Ev>
    8000244c:	00813083          	ld	ra,8(sp)
    80002450:	00013403          	ld	s0,0(sp)
    80002454:	01010113          	addi	sp,sp,16
    80002458:	00008067          	ret

000000008000245c <_ZN7WorkerDD0Ev>:
    8000245c:	fe010113          	addi	sp,sp,-32
    80002460:	00113c23          	sd	ra,24(sp)
    80002464:	00813823          	sd	s0,16(sp)
    80002468:	00913423          	sd	s1,8(sp)
    8000246c:	02010413          	addi	s0,sp,32
    80002470:	00050493          	mv	s1,a0
    80002474:	00005797          	auipc	a5,0x5
    80002478:	d2478793          	addi	a5,a5,-732 # 80007198 <_ZTV7WorkerD+0x10>
    8000247c:	00f53023          	sd	a5,0(a0)
    80002480:	fffff097          	auipc	ra,0xfffff
    80002484:	2c4080e7          	jalr	708(ra) # 80001744 <_ZN6ThreadD1Ev>
    80002488:	00048513          	mv	a0,s1
    8000248c:	fffff097          	auipc	ra,0xfffff
    80002490:	268080e7          	jalr	616(ra) # 800016f4 <_ZdlPv>
    80002494:	01813083          	ld	ra,24(sp)
    80002498:	01013403          	ld	s0,16(sp)
    8000249c:	00813483          	ld	s1,8(sp)
    800024a0:	02010113          	addi	sp,sp,32
    800024a4:	00008067          	ret

00000000800024a8 <_ZN7WorkerA3runEv>:
    void run() override {
    800024a8:	ff010113          	addi	sp,sp,-16
    800024ac:	00113423          	sd	ra,8(sp)
    800024b0:	00813023          	sd	s0,0(sp)
    800024b4:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    800024b8:	00000593          	li	a1,0
    800024bc:	fffff097          	auipc	ra,0xfffff
    800024c0:	774080e7          	jalr	1908(ra) # 80001c30 <_ZN7WorkerA11workerBodyAEPv>
    }
    800024c4:	00813083          	ld	ra,8(sp)
    800024c8:	00013403          	ld	s0,0(sp)
    800024cc:	01010113          	addi	sp,sp,16
    800024d0:	00008067          	ret

00000000800024d4 <_ZN7WorkerB3runEv>:
    void run() override {
    800024d4:	ff010113          	addi	sp,sp,-16
    800024d8:	00113423          	sd	ra,8(sp)
    800024dc:	00813023          	sd	s0,0(sp)
    800024e0:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    800024e4:	00000593          	li	a1,0
    800024e8:	00000097          	auipc	ra,0x0
    800024ec:	814080e7          	jalr	-2028(ra) # 80001cfc <_ZN7WorkerB11workerBodyBEPv>
    }
    800024f0:	00813083          	ld	ra,8(sp)
    800024f4:	00013403          	ld	s0,0(sp)
    800024f8:	01010113          	addi	sp,sp,16
    800024fc:	00008067          	ret

0000000080002500 <_ZN7WorkerC3runEv>:
    void run() override {
    80002500:	ff010113          	addi	sp,sp,-16
    80002504:	00113423          	sd	ra,8(sp)
    80002508:	00813023          	sd	s0,0(sp)
    8000250c:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002510:	00000593          	li	a1,0
    80002514:	00000097          	auipc	ra,0x0
    80002518:	8bc080e7          	jalr	-1860(ra) # 80001dd0 <_ZN7WorkerC11workerBodyCEPv>
    }
    8000251c:	00813083          	ld	ra,8(sp)
    80002520:	00013403          	ld	s0,0(sp)
    80002524:	01010113          	addi	sp,sp,16
    80002528:	00008067          	ret

000000008000252c <_ZN7WorkerD3runEv>:
    void run() override {
    8000252c:	ff010113          	addi	sp,sp,-16
    80002530:	00113423          	sd	ra,8(sp)
    80002534:	00813023          	sd	s0,0(sp)
    80002538:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    8000253c:	00000593          	li	a1,0
    80002540:	00000097          	auipc	ra,0x0
    80002544:	a10080e7          	jalr	-1520(ra) # 80001f50 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002548:	00813083          	ld	ra,8(sp)
    8000254c:	00013403          	ld	s0,0(sp)
    80002550:	01010113          	addi	sp,sp,16
    80002554:	00008067          	ret

0000000080002558 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002558:	fe010113          	addi	sp,sp,-32
    8000255c:	00113c23          	sd	ra,24(sp)
    80002560:	00813823          	sd	s0,16(sp)
    80002564:	00913423          	sd	s1,8(sp)
    80002568:	01213023          	sd	s2,0(sp)
    8000256c:	02010413          	addi	s0,sp,32
    80002570:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002574:	00100793          	li	a5,1
    80002578:	02a7f863          	bgeu	a5,a0,800025a8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000257c:	00a00793          	li	a5,10
    80002580:	02f577b3          	remu	a5,a0,a5
    80002584:	02078e63          	beqz	a5,800025c0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002588:	fff48513          	addi	a0,s1,-1
    8000258c:	00000097          	auipc	ra,0x0
    80002590:	fcc080e7          	jalr	-52(ra) # 80002558 <_ZL9fibonaccim>
    80002594:	00050913          	mv	s2,a0
    80002598:	ffe48513          	addi	a0,s1,-2
    8000259c:	00000097          	auipc	ra,0x0
    800025a0:	fbc080e7          	jalr	-68(ra) # 80002558 <_ZL9fibonaccim>
    800025a4:	00a90533          	add	a0,s2,a0
}
    800025a8:	01813083          	ld	ra,24(sp)
    800025ac:	01013403          	ld	s0,16(sp)
    800025b0:	00813483          	ld	s1,8(sp)
    800025b4:	00013903          	ld	s2,0(sp)
    800025b8:	02010113          	addi	sp,sp,32
    800025bc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800025c0:	fffff097          	auipc	ra,0xfffff
    800025c4:	c2c080e7          	jalr	-980(ra) # 800011ec <_Z15thread_dispatchv>
    800025c8:	fc1ff06f          	j	80002588 <_ZL9fibonaccim+0x30>

00000000800025cc <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800025cc:	fe010113          	addi	sp,sp,-32
    800025d0:	00113c23          	sd	ra,24(sp)
    800025d4:	00813823          	sd	s0,16(sp)
    800025d8:	00913423          	sd	s1,8(sp)
    800025dc:	01213023          	sd	s2,0(sp)
    800025e0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800025e4:	00a00493          	li	s1,10
    800025e8:	0400006f          	j	80002628 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800025ec:	00004517          	auipc	a0,0x4
    800025f0:	c2450513          	addi	a0,a0,-988 # 80006210 <kvmincrease+0x1010>
    800025f4:	00000097          	auipc	ra,0x0
    800025f8:	53c080e7          	jalr	1340(ra) # 80002b30 <_Z11printStringPKc>
    800025fc:	00000613          	li	a2,0
    80002600:	00a00593          	li	a1,10
    80002604:	00048513          	mv	a0,s1
    80002608:	00000097          	auipc	ra,0x0
    8000260c:	6d8080e7          	jalr	1752(ra) # 80002ce0 <_Z8printIntiii>
    80002610:	00004517          	auipc	a0,0x4
    80002614:	b9850513          	addi	a0,a0,-1128 # 800061a8 <kvmincrease+0xfa8>
    80002618:	00000097          	auipc	ra,0x0
    8000261c:	518080e7          	jalr	1304(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002620:	0014849b          	addiw	s1,s1,1
    80002624:	0ff4f493          	andi	s1,s1,255
    80002628:	00c00793          	li	a5,12
    8000262c:	fc97f0e3          	bgeu	a5,s1,800025ec <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002630:	00004517          	auipc	a0,0x4
    80002634:	be850513          	addi	a0,a0,-1048 # 80006218 <kvmincrease+0x1018>
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	4f8080e7          	jalr	1272(ra) # 80002b30 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002640:	00500313          	li	t1,5
    thread_dispatch();
    80002644:	fffff097          	auipc	ra,0xfffff
    80002648:	ba8080e7          	jalr	-1112(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000264c:	01000513          	li	a0,16
    80002650:	00000097          	auipc	ra,0x0
    80002654:	f08080e7          	jalr	-248(ra) # 80002558 <_ZL9fibonaccim>
    80002658:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000265c:	00004517          	auipc	a0,0x4
    80002660:	bcc50513          	addi	a0,a0,-1076 # 80006228 <kvmincrease+0x1028>
    80002664:	00000097          	auipc	ra,0x0
    80002668:	4cc080e7          	jalr	1228(ra) # 80002b30 <_Z11printStringPKc>
    8000266c:	00000613          	li	a2,0
    80002670:	00a00593          	li	a1,10
    80002674:	0009051b          	sext.w	a0,s2
    80002678:	00000097          	auipc	ra,0x0
    8000267c:	668080e7          	jalr	1640(ra) # 80002ce0 <_Z8printIntiii>
    80002680:	00004517          	auipc	a0,0x4
    80002684:	b2850513          	addi	a0,a0,-1240 # 800061a8 <kvmincrease+0xfa8>
    80002688:	00000097          	auipc	ra,0x0
    8000268c:	4a8080e7          	jalr	1192(ra) # 80002b30 <_Z11printStringPKc>
    80002690:	0400006f          	j	800026d0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002694:	00004517          	auipc	a0,0x4
    80002698:	b7c50513          	addi	a0,a0,-1156 # 80006210 <kvmincrease+0x1010>
    8000269c:	00000097          	auipc	ra,0x0
    800026a0:	494080e7          	jalr	1172(ra) # 80002b30 <_Z11printStringPKc>
    800026a4:	00000613          	li	a2,0
    800026a8:	00a00593          	li	a1,10
    800026ac:	00048513          	mv	a0,s1
    800026b0:	00000097          	auipc	ra,0x0
    800026b4:	630080e7          	jalr	1584(ra) # 80002ce0 <_Z8printIntiii>
    800026b8:	00004517          	auipc	a0,0x4
    800026bc:	af050513          	addi	a0,a0,-1296 # 800061a8 <kvmincrease+0xfa8>
    800026c0:	00000097          	auipc	ra,0x0
    800026c4:	470080e7          	jalr	1136(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800026c8:	0014849b          	addiw	s1,s1,1
    800026cc:	0ff4f493          	andi	s1,s1,255
    800026d0:	00f00793          	li	a5,15
    800026d4:	fc97f0e3          	bgeu	a5,s1,80002694 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800026d8:	00004517          	auipc	a0,0x4
    800026dc:	b6050513          	addi	a0,a0,-1184 # 80006238 <kvmincrease+0x1038>
    800026e0:	00000097          	auipc	ra,0x0
    800026e4:	450080e7          	jalr	1104(ra) # 80002b30 <_Z11printStringPKc>
    finishedD = true;
    800026e8:	00100793          	li	a5,1
    800026ec:	00005717          	auipc	a4,0x5
    800026f0:	b6f70023          	sb	a5,-1184(a4) # 8000724c <_ZL9finishedD>
    thread_dispatch();
    800026f4:	fffff097          	auipc	ra,0xfffff
    800026f8:	af8080e7          	jalr	-1288(ra) # 800011ec <_Z15thread_dispatchv>
}
    800026fc:	01813083          	ld	ra,24(sp)
    80002700:	01013403          	ld	s0,16(sp)
    80002704:	00813483          	ld	s1,8(sp)
    80002708:	00013903          	ld	s2,0(sp)
    8000270c:	02010113          	addi	sp,sp,32
    80002710:	00008067          	ret

0000000080002714 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80002714:	fe010113          	addi	sp,sp,-32
    80002718:	00113c23          	sd	ra,24(sp)
    8000271c:	00813823          	sd	s0,16(sp)
    80002720:	00913423          	sd	s1,8(sp)
    80002724:	01213023          	sd	s2,0(sp)
    80002728:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000272c:	00000493          	li	s1,0
    80002730:	0400006f          	j	80002770 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80002734:	00004517          	auipc	a0,0x4
    80002738:	aac50513          	addi	a0,a0,-1364 # 800061e0 <kvmincrease+0xfe0>
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	3f4080e7          	jalr	1012(ra) # 80002b30 <_Z11printStringPKc>
    80002744:	00000613          	li	a2,0
    80002748:	00a00593          	li	a1,10
    8000274c:	00048513          	mv	a0,s1
    80002750:	00000097          	auipc	ra,0x0
    80002754:	590080e7          	jalr	1424(ra) # 80002ce0 <_Z8printIntiii>
    80002758:	00004517          	auipc	a0,0x4
    8000275c:	a5050513          	addi	a0,a0,-1456 # 800061a8 <kvmincrease+0xfa8>
    80002760:	00000097          	auipc	ra,0x0
    80002764:	3d0080e7          	jalr	976(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002768:	0014849b          	addiw	s1,s1,1
    8000276c:	0ff4f493          	andi	s1,s1,255
    80002770:	00200793          	li	a5,2
    80002774:	fc97f0e3          	bgeu	a5,s1,80002734 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80002778:	00004517          	auipc	a0,0x4
    8000277c:	a7050513          	addi	a0,a0,-1424 # 800061e8 <kvmincrease+0xfe8>
    80002780:	00000097          	auipc	ra,0x0
    80002784:	3b0080e7          	jalr	944(ra) # 80002b30 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002788:	00700313          	li	t1,7
    thread_dispatch();
    8000278c:	fffff097          	auipc	ra,0xfffff
    80002790:	a60080e7          	jalr	-1440(ra) # 800011ec <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002794:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002798:	00004517          	auipc	a0,0x4
    8000279c:	a6050513          	addi	a0,a0,-1440 # 800061f8 <kvmincrease+0xff8>
    800027a0:	00000097          	auipc	ra,0x0
    800027a4:	390080e7          	jalr	912(ra) # 80002b30 <_Z11printStringPKc>
    800027a8:	00000613          	li	a2,0
    800027ac:	00a00593          	li	a1,10
    800027b0:	0009051b          	sext.w	a0,s2
    800027b4:	00000097          	auipc	ra,0x0
    800027b8:	52c080e7          	jalr	1324(ra) # 80002ce0 <_Z8printIntiii>
    800027bc:	00004517          	auipc	a0,0x4
    800027c0:	9ec50513          	addi	a0,a0,-1556 # 800061a8 <kvmincrease+0xfa8>
    800027c4:	00000097          	auipc	ra,0x0
    800027c8:	36c080e7          	jalr	876(ra) # 80002b30 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800027cc:	00c00513          	li	a0,12
    800027d0:	00000097          	auipc	ra,0x0
    800027d4:	d88080e7          	jalr	-632(ra) # 80002558 <_ZL9fibonaccim>
    800027d8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800027dc:	00004517          	auipc	a0,0x4
    800027e0:	a2450513          	addi	a0,a0,-1500 # 80006200 <kvmincrease+0x1000>
    800027e4:	00000097          	auipc	ra,0x0
    800027e8:	34c080e7          	jalr	844(ra) # 80002b30 <_Z11printStringPKc>
    800027ec:	00000613          	li	a2,0
    800027f0:	00a00593          	li	a1,10
    800027f4:	0009051b          	sext.w	a0,s2
    800027f8:	00000097          	auipc	ra,0x0
    800027fc:	4e8080e7          	jalr	1256(ra) # 80002ce0 <_Z8printIntiii>
    80002800:	00004517          	auipc	a0,0x4
    80002804:	9a850513          	addi	a0,a0,-1624 # 800061a8 <kvmincrease+0xfa8>
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	328080e7          	jalr	808(ra) # 80002b30 <_Z11printStringPKc>
    80002810:	0400006f          	j	80002850 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80002814:	00004517          	auipc	a0,0x4
    80002818:	9cc50513          	addi	a0,a0,-1588 # 800061e0 <kvmincrease+0xfe0>
    8000281c:	00000097          	auipc	ra,0x0
    80002820:	314080e7          	jalr	788(ra) # 80002b30 <_Z11printStringPKc>
    80002824:	00000613          	li	a2,0
    80002828:	00a00593          	li	a1,10
    8000282c:	00048513          	mv	a0,s1
    80002830:	00000097          	auipc	ra,0x0
    80002834:	4b0080e7          	jalr	1200(ra) # 80002ce0 <_Z8printIntiii>
    80002838:	00004517          	auipc	a0,0x4
    8000283c:	97050513          	addi	a0,a0,-1680 # 800061a8 <kvmincrease+0xfa8>
    80002840:	00000097          	auipc	ra,0x0
    80002844:	2f0080e7          	jalr	752(ra) # 80002b30 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002848:	0014849b          	addiw	s1,s1,1
    8000284c:	0ff4f493          	andi	s1,s1,255
    80002850:	00500793          	li	a5,5
    80002854:	fc97f0e3          	bgeu	a5,s1,80002814 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80002858:	00004517          	auipc	a0,0x4
    8000285c:	a5050513          	addi	a0,a0,-1456 # 800062a8 <kvmincrease+0x10a8>
    80002860:	00000097          	auipc	ra,0x0
    80002864:	2d0080e7          	jalr	720(ra) # 80002b30 <_Z11printStringPKc>
    finishedC = true;
    80002868:	00100793          	li	a5,1
    8000286c:	00005717          	auipc	a4,0x5
    80002870:	9ef700a3          	sb	a5,-1567(a4) # 8000724d <_ZL9finishedC>
    thread_dispatch();
    80002874:	fffff097          	auipc	ra,0xfffff
    80002878:	978080e7          	jalr	-1672(ra) # 800011ec <_Z15thread_dispatchv>
}
    8000287c:	01813083          	ld	ra,24(sp)
    80002880:	01013403          	ld	s0,16(sp)
    80002884:	00813483          	ld	s1,8(sp)
    80002888:	00013903          	ld	s2,0(sp)
    8000288c:	02010113          	addi	sp,sp,32
    80002890:	00008067          	ret

0000000080002894 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80002894:	fe010113          	addi	sp,sp,-32
    80002898:	00113c23          	sd	ra,24(sp)
    8000289c:	00813823          	sd	s0,16(sp)
    800028a0:	00913423          	sd	s1,8(sp)
    800028a4:	01213023          	sd	s2,0(sp)
    800028a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800028ac:	00000913          	li	s2,0
    800028b0:	0380006f          	j	800028e8 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    800028b4:	fffff097          	auipc	ra,0xfffff
    800028b8:	938080e7          	jalr	-1736(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800028bc:	00148493          	addi	s1,s1,1
    800028c0:	000027b7          	lui	a5,0x2
    800028c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800028c8:	0097ee63          	bltu	a5,s1,800028e4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800028cc:	00000713          	li	a4,0
    800028d0:	000077b7          	lui	a5,0x7
    800028d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800028d8:	fce7eee3          	bltu	a5,a4,800028b4 <_ZL11workerBodyBPv+0x20>
    800028dc:	00170713          	addi	a4,a4,1
    800028e0:	ff1ff06f          	j	800028d0 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800028e4:	00190913          	addi	s2,s2,1
    800028e8:	00f00793          	li	a5,15
    800028ec:	0527e063          	bltu	a5,s2,8000292c <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800028f0:	00004517          	auipc	a0,0x4
    800028f4:	8d850513          	addi	a0,a0,-1832 # 800061c8 <kvmincrease+0xfc8>
    800028f8:	00000097          	auipc	ra,0x0
    800028fc:	238080e7          	jalr	568(ra) # 80002b30 <_Z11printStringPKc>
    80002900:	00000613          	li	a2,0
    80002904:	00a00593          	li	a1,10
    80002908:	0009051b          	sext.w	a0,s2
    8000290c:	00000097          	auipc	ra,0x0
    80002910:	3d4080e7          	jalr	980(ra) # 80002ce0 <_Z8printIntiii>
    80002914:	00004517          	auipc	a0,0x4
    80002918:	89450513          	addi	a0,a0,-1900 # 800061a8 <kvmincrease+0xfa8>
    8000291c:	00000097          	auipc	ra,0x0
    80002920:	214080e7          	jalr	532(ra) # 80002b30 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002924:	00000493          	li	s1,0
    80002928:	f99ff06f          	j	800028c0 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    8000292c:	00004517          	auipc	a0,0x4
    80002930:	8a450513          	addi	a0,a0,-1884 # 800061d0 <kvmincrease+0xfd0>
    80002934:	00000097          	auipc	ra,0x0
    80002938:	1fc080e7          	jalr	508(ra) # 80002b30 <_Z11printStringPKc>
    finishedB = true;
    8000293c:	00100793          	li	a5,1
    80002940:	00005717          	auipc	a4,0x5
    80002944:	90f70723          	sb	a5,-1778(a4) # 8000724e <_ZL9finishedB>
    thread_dispatch();
    80002948:	fffff097          	auipc	ra,0xfffff
    8000294c:	8a4080e7          	jalr	-1884(ra) # 800011ec <_Z15thread_dispatchv>
}
    80002950:	01813083          	ld	ra,24(sp)
    80002954:	01013403          	ld	s0,16(sp)
    80002958:	00813483          	ld	s1,8(sp)
    8000295c:	00013903          	ld	s2,0(sp)
    80002960:	02010113          	addi	sp,sp,32
    80002964:	00008067          	ret

0000000080002968 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80002968:	fe010113          	addi	sp,sp,-32
    8000296c:	00113c23          	sd	ra,24(sp)
    80002970:	00813823          	sd	s0,16(sp)
    80002974:	00913423          	sd	s1,8(sp)
    80002978:	01213023          	sd	s2,0(sp)
    8000297c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002980:	00000913          	li	s2,0
    80002984:	0380006f          	j	800029bc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80002988:	fffff097          	auipc	ra,0xfffff
    8000298c:	864080e7          	jalr	-1948(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002990:	00148493          	addi	s1,s1,1
    80002994:	000027b7          	lui	a5,0x2
    80002998:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000299c:	0097ee63          	bltu	a5,s1,800029b8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800029a0:	00000713          	li	a4,0
    800029a4:	000077b7          	lui	a5,0x7
    800029a8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800029ac:	fce7eee3          	bltu	a5,a4,80002988 <_ZL11workerBodyAPv+0x20>
    800029b0:	00170713          	addi	a4,a4,1
    800029b4:	ff1ff06f          	j	800029a4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800029b8:	00190913          	addi	s2,s2,1
    800029bc:	00900793          	li	a5,9
    800029c0:	0527e063          	bltu	a5,s2,80002a00 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800029c4:	00003517          	auipc	a0,0x3
    800029c8:	7ec50513          	addi	a0,a0,2028 # 800061b0 <kvmincrease+0xfb0>
    800029cc:	00000097          	auipc	ra,0x0
    800029d0:	164080e7          	jalr	356(ra) # 80002b30 <_Z11printStringPKc>
    800029d4:	00000613          	li	a2,0
    800029d8:	00a00593          	li	a1,10
    800029dc:	0009051b          	sext.w	a0,s2
    800029e0:	00000097          	auipc	ra,0x0
    800029e4:	300080e7          	jalr	768(ra) # 80002ce0 <_Z8printIntiii>
    800029e8:	00003517          	auipc	a0,0x3
    800029ec:	7c050513          	addi	a0,a0,1984 # 800061a8 <kvmincrease+0xfa8>
    800029f0:	00000097          	auipc	ra,0x0
    800029f4:	140080e7          	jalr	320(ra) # 80002b30 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800029f8:	00000493          	li	s1,0
    800029fc:	f99ff06f          	j	80002994 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80002a00:	00003517          	auipc	a0,0x3
    80002a04:	7b850513          	addi	a0,a0,1976 # 800061b8 <kvmincrease+0xfb8>
    80002a08:	00000097          	auipc	ra,0x0
    80002a0c:	128080e7          	jalr	296(ra) # 80002b30 <_Z11printStringPKc>
    finishedA = true;
    80002a10:	00100793          	li	a5,1
    80002a14:	00005717          	auipc	a4,0x5
    80002a18:	82f70da3          	sb	a5,-1989(a4) # 8000724f <_ZL9finishedA>
}
    80002a1c:	01813083          	ld	ra,24(sp)
    80002a20:	01013403          	ld	s0,16(sp)
    80002a24:	00813483          	ld	s1,8(sp)
    80002a28:	00013903          	ld	s2,0(sp)
    80002a2c:	02010113          	addi	sp,sp,32
    80002a30:	00008067          	ret

0000000080002a34 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80002a34:	fd010113          	addi	sp,sp,-48
    80002a38:	02113423          	sd	ra,40(sp)
    80002a3c:	02813023          	sd	s0,32(sp)
    80002a40:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002a44:	00000613          	li	a2,0
    80002a48:	00000597          	auipc	a1,0x0
    80002a4c:	f2058593          	addi	a1,a1,-224 # 80002968 <_ZL11workerBodyAPv>
    80002a50:	fd040513          	addi	a0,s0,-48
    80002a54:	ffffe097          	auipc	ra,0xffffe
    80002a58:	740080e7          	jalr	1856(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80002a5c:	00003517          	auipc	a0,0x3
    80002a60:	7ec50513          	addi	a0,a0,2028 # 80006248 <kvmincrease+0x1048>
    80002a64:	00000097          	auipc	ra,0x0
    80002a68:	0cc080e7          	jalr	204(ra) # 80002b30 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002a6c:	00000613          	li	a2,0
    80002a70:	00000597          	auipc	a1,0x0
    80002a74:	e2458593          	addi	a1,a1,-476 # 80002894 <_ZL11workerBodyBPv>
    80002a78:	fd840513          	addi	a0,s0,-40
    80002a7c:	ffffe097          	auipc	ra,0xffffe
    80002a80:	718080e7          	jalr	1816(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80002a84:	00003517          	auipc	a0,0x3
    80002a88:	7dc50513          	addi	a0,a0,2012 # 80006260 <kvmincrease+0x1060>
    80002a8c:	00000097          	auipc	ra,0x0
    80002a90:	0a4080e7          	jalr	164(ra) # 80002b30 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80002a94:	00000613          	li	a2,0
    80002a98:	00000597          	auipc	a1,0x0
    80002a9c:	c7c58593          	addi	a1,a1,-900 # 80002714 <_ZL11workerBodyCPv>
    80002aa0:	fe040513          	addi	a0,s0,-32
    80002aa4:	ffffe097          	auipc	ra,0xffffe
    80002aa8:	6f0080e7          	jalr	1776(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80002aac:	00003517          	auipc	a0,0x3
    80002ab0:	7cc50513          	addi	a0,a0,1996 # 80006278 <kvmincrease+0x1078>
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	07c080e7          	jalr	124(ra) # 80002b30 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002abc:	00000613          	li	a2,0
    80002ac0:	00000597          	auipc	a1,0x0
    80002ac4:	b0c58593          	addi	a1,a1,-1268 # 800025cc <_ZL11workerBodyDPv>
    80002ac8:	fe840513          	addi	a0,s0,-24
    80002acc:	ffffe097          	auipc	ra,0xffffe
    80002ad0:	6c8080e7          	jalr	1736(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80002ad4:	00003517          	auipc	a0,0x3
    80002ad8:	7bc50513          	addi	a0,a0,1980 # 80006290 <kvmincrease+0x1090>
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	054080e7          	jalr	84(ra) # 80002b30 <_Z11printStringPKc>
    80002ae4:	00c0006f          	j	80002af0 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80002ae8:	ffffe097          	auipc	ra,0xffffe
    80002aec:	704080e7          	jalr	1796(ra) # 800011ec <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002af0:	00004797          	auipc	a5,0x4
    80002af4:	75f7c783          	lbu	a5,1887(a5) # 8000724f <_ZL9finishedA>
    80002af8:	fe0788e3          	beqz	a5,80002ae8 <_Z18Threads_C_API_testv+0xb4>
    80002afc:	00004797          	auipc	a5,0x4
    80002b00:	7527c783          	lbu	a5,1874(a5) # 8000724e <_ZL9finishedB>
    80002b04:	fe0782e3          	beqz	a5,80002ae8 <_Z18Threads_C_API_testv+0xb4>
    80002b08:	00004797          	auipc	a5,0x4
    80002b0c:	7457c783          	lbu	a5,1861(a5) # 8000724d <_ZL9finishedC>
    80002b10:	fc078ce3          	beqz	a5,80002ae8 <_Z18Threads_C_API_testv+0xb4>
    80002b14:	00004797          	auipc	a5,0x4
    80002b18:	7387c783          	lbu	a5,1848(a5) # 8000724c <_ZL9finishedD>
    80002b1c:	fc0786e3          	beqz	a5,80002ae8 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80002b20:	02813083          	ld	ra,40(sp)
    80002b24:	02013403          	ld	s0,32(sp)
    80002b28:	03010113          	addi	sp,sp,48
    80002b2c:	00008067          	ret

0000000080002b30 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80002b30:	fe010113          	addi	sp,sp,-32
    80002b34:	00113c23          	sd	ra,24(sp)
    80002b38:	00813823          	sd	s0,16(sp)
    80002b3c:	00913423          	sd	s1,8(sp)
    80002b40:	02010413          	addi	s0,sp,32
    80002b44:	00050493          	mv	s1,a0
    LOCK();
    80002b48:	00100613          	li	a2,1
    80002b4c:	00000593          	li	a1,0
    80002b50:	00004517          	auipc	a0,0x4
    80002b54:	70050513          	addi	a0,a0,1792 # 80007250 <lockPrint>
    80002b58:	ffffe097          	auipc	ra,0xffffe
    80002b5c:	4a8080e7          	jalr	1192(ra) # 80001000 <copy_and_swap>
    80002b60:	00050863          	beqz	a0,80002b70 <_Z11printStringPKc+0x40>
    80002b64:	ffffe097          	auipc	ra,0xffffe
    80002b68:	688080e7          	jalr	1672(ra) # 800011ec <_Z15thread_dispatchv>
    80002b6c:	fddff06f          	j	80002b48 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002b70:	0004c503          	lbu	a0,0(s1)
    80002b74:	00050a63          	beqz	a0,80002b88 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80002b78:	ffffe097          	auipc	ra,0xffffe
    80002b7c:	770080e7          	jalr	1904(ra) # 800012e8 <_Z4putcc>
        string++;
    80002b80:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002b84:	fedff06f          	j	80002b70 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80002b88:	00000613          	li	a2,0
    80002b8c:	00100593          	li	a1,1
    80002b90:	00004517          	auipc	a0,0x4
    80002b94:	6c050513          	addi	a0,a0,1728 # 80007250 <lockPrint>
    80002b98:	ffffe097          	auipc	ra,0xffffe
    80002b9c:	468080e7          	jalr	1128(ra) # 80001000 <copy_and_swap>
    80002ba0:	fe0514e3          	bnez	a0,80002b88 <_Z11printStringPKc+0x58>
}
    80002ba4:	01813083          	ld	ra,24(sp)
    80002ba8:	01013403          	ld	s0,16(sp)
    80002bac:	00813483          	ld	s1,8(sp)
    80002bb0:	02010113          	addi	sp,sp,32
    80002bb4:	00008067          	ret

0000000080002bb8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002bb8:	fd010113          	addi	sp,sp,-48
    80002bbc:	02113423          	sd	ra,40(sp)
    80002bc0:	02813023          	sd	s0,32(sp)
    80002bc4:	00913c23          	sd	s1,24(sp)
    80002bc8:	01213823          	sd	s2,16(sp)
    80002bcc:	01313423          	sd	s3,8(sp)
    80002bd0:	01413023          	sd	s4,0(sp)
    80002bd4:	03010413          	addi	s0,sp,48
    80002bd8:	00050993          	mv	s3,a0
    80002bdc:	00058a13          	mv	s4,a1
    LOCK();
    80002be0:	00100613          	li	a2,1
    80002be4:	00000593          	li	a1,0
    80002be8:	00004517          	auipc	a0,0x4
    80002bec:	66850513          	addi	a0,a0,1640 # 80007250 <lockPrint>
    80002bf0:	ffffe097          	auipc	ra,0xffffe
    80002bf4:	410080e7          	jalr	1040(ra) # 80001000 <copy_and_swap>
    80002bf8:	00050863          	beqz	a0,80002c08 <_Z9getStringPci+0x50>
    80002bfc:	ffffe097          	auipc	ra,0xffffe
    80002c00:	5f0080e7          	jalr	1520(ra) # 800011ec <_Z15thread_dispatchv>
    80002c04:	fddff06f          	j	80002be0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80002c08:	00000913          	li	s2,0
    80002c0c:	00090493          	mv	s1,s2
    80002c10:	0019091b          	addiw	s2,s2,1
    80002c14:	03495a63          	bge	s2,s4,80002c48 <_Z9getStringPci+0x90>
        cc = getc();
    80002c18:	ffffe097          	auipc	ra,0xffffe
    80002c1c:	6a8080e7          	jalr	1704(ra) # 800012c0 <_Z4getcv>
        if(cc < 1)
    80002c20:	02050463          	beqz	a0,80002c48 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80002c24:	009984b3          	add	s1,s3,s1
    80002c28:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80002c2c:	00a00793          	li	a5,10
    80002c30:	00f50a63          	beq	a0,a5,80002c44 <_Z9getStringPci+0x8c>
    80002c34:	00d00793          	li	a5,13
    80002c38:	fcf51ae3          	bne	a0,a5,80002c0c <_Z9getStringPci+0x54>
        buf[i++] = c;
    80002c3c:	00090493          	mv	s1,s2
    80002c40:	0080006f          	j	80002c48 <_Z9getStringPci+0x90>
    80002c44:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002c48:	009984b3          	add	s1,s3,s1
    80002c4c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002c50:	00000613          	li	a2,0
    80002c54:	00100593          	li	a1,1
    80002c58:	00004517          	auipc	a0,0x4
    80002c5c:	5f850513          	addi	a0,a0,1528 # 80007250 <lockPrint>
    80002c60:	ffffe097          	auipc	ra,0xffffe
    80002c64:	3a0080e7          	jalr	928(ra) # 80001000 <copy_and_swap>
    80002c68:	fe0514e3          	bnez	a0,80002c50 <_Z9getStringPci+0x98>
    return buf;
}
    80002c6c:	00098513          	mv	a0,s3
    80002c70:	02813083          	ld	ra,40(sp)
    80002c74:	02013403          	ld	s0,32(sp)
    80002c78:	01813483          	ld	s1,24(sp)
    80002c7c:	01013903          	ld	s2,16(sp)
    80002c80:	00813983          	ld	s3,8(sp)
    80002c84:	00013a03          	ld	s4,0(sp)
    80002c88:	03010113          	addi	sp,sp,48
    80002c8c:	00008067          	ret

0000000080002c90 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002c90:	ff010113          	addi	sp,sp,-16
    80002c94:	00813423          	sd	s0,8(sp)
    80002c98:	01010413          	addi	s0,sp,16
    80002c9c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002ca0:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002ca4:	0006c603          	lbu	a2,0(a3)
    80002ca8:	fd06071b          	addiw	a4,a2,-48
    80002cac:	0ff77713          	andi	a4,a4,255
    80002cb0:	00900793          	li	a5,9
    80002cb4:	02e7e063          	bltu	a5,a4,80002cd4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002cb8:	0025179b          	slliw	a5,a0,0x2
    80002cbc:	00a787bb          	addw	a5,a5,a0
    80002cc0:	0017979b          	slliw	a5,a5,0x1
    80002cc4:	00168693          	addi	a3,a3,1
    80002cc8:	00c787bb          	addw	a5,a5,a2
    80002ccc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002cd0:	fd5ff06f          	j	80002ca4 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002cd4:	00813403          	ld	s0,8(sp)
    80002cd8:	01010113          	addi	sp,sp,16
    80002cdc:	00008067          	ret

0000000080002ce0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002ce0:	fc010113          	addi	sp,sp,-64
    80002ce4:	02113c23          	sd	ra,56(sp)
    80002ce8:	02813823          	sd	s0,48(sp)
    80002cec:	02913423          	sd	s1,40(sp)
    80002cf0:	03213023          	sd	s2,32(sp)
    80002cf4:	01313c23          	sd	s3,24(sp)
    80002cf8:	04010413          	addi	s0,sp,64
    80002cfc:	00050493          	mv	s1,a0
    80002d00:	00058913          	mv	s2,a1
    80002d04:	00060993          	mv	s3,a2
    LOCK();
    80002d08:	00100613          	li	a2,1
    80002d0c:	00000593          	li	a1,0
    80002d10:	00004517          	auipc	a0,0x4
    80002d14:	54050513          	addi	a0,a0,1344 # 80007250 <lockPrint>
    80002d18:	ffffe097          	auipc	ra,0xffffe
    80002d1c:	2e8080e7          	jalr	744(ra) # 80001000 <copy_and_swap>
    80002d20:	00050863          	beqz	a0,80002d30 <_Z8printIntiii+0x50>
    80002d24:	ffffe097          	auipc	ra,0xffffe
    80002d28:	4c8080e7          	jalr	1224(ra) # 800011ec <_Z15thread_dispatchv>
    80002d2c:	fddff06f          	j	80002d08 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80002d30:	00098463          	beqz	s3,80002d38 <_Z8printIntiii+0x58>
    80002d34:	0804c463          	bltz	s1,80002dbc <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80002d38:	0004851b          	sext.w	a0,s1
    neg = 0;
    80002d3c:	00000593          	li	a1,0
    }

    i = 0;
    80002d40:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80002d44:	0009079b          	sext.w	a5,s2
    80002d48:	0325773b          	remuw	a4,a0,s2
    80002d4c:	00048613          	mv	a2,s1
    80002d50:	0014849b          	addiw	s1,s1,1
    80002d54:	02071693          	slli	a3,a4,0x20
    80002d58:	0206d693          	srli	a3,a3,0x20
    80002d5c:	00004717          	auipc	a4,0x4
    80002d60:	45470713          	addi	a4,a4,1108 # 800071b0 <digits>
    80002d64:	00d70733          	add	a4,a4,a3
    80002d68:	00074683          	lbu	a3,0(a4)
    80002d6c:	fd040713          	addi	a4,s0,-48
    80002d70:	00c70733          	add	a4,a4,a2
    80002d74:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002d78:	0005071b          	sext.w	a4,a0
    80002d7c:	0325553b          	divuw	a0,a0,s2
    80002d80:	fcf772e3          	bgeu	a4,a5,80002d44 <_Z8printIntiii+0x64>
    if(neg)
    80002d84:	00058c63          	beqz	a1,80002d9c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80002d88:	fd040793          	addi	a5,s0,-48
    80002d8c:	009784b3          	add	s1,a5,s1
    80002d90:	02d00793          	li	a5,45
    80002d94:	fef48823          	sb	a5,-16(s1)
    80002d98:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002d9c:	fff4849b          	addiw	s1,s1,-1
    80002da0:	0204c463          	bltz	s1,80002dc8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80002da4:	fd040793          	addi	a5,s0,-48
    80002da8:	009787b3          	add	a5,a5,s1
    80002dac:	ff07c503          	lbu	a0,-16(a5)
    80002db0:	ffffe097          	auipc	ra,0xffffe
    80002db4:	538080e7          	jalr	1336(ra) # 800012e8 <_Z4putcc>
    80002db8:	fe5ff06f          	j	80002d9c <_Z8printIntiii+0xbc>
        x = -xx;
    80002dbc:	4090053b          	negw	a0,s1
        neg = 1;
    80002dc0:	00100593          	li	a1,1
        x = -xx;
    80002dc4:	f7dff06f          	j	80002d40 <_Z8printIntiii+0x60>

    UNLOCK();
    80002dc8:	00000613          	li	a2,0
    80002dcc:	00100593          	li	a1,1
    80002dd0:	00004517          	auipc	a0,0x4
    80002dd4:	48050513          	addi	a0,a0,1152 # 80007250 <lockPrint>
    80002dd8:	ffffe097          	auipc	ra,0xffffe
    80002ddc:	228080e7          	jalr	552(ra) # 80001000 <copy_and_swap>
    80002de0:	fe0514e3          	bnez	a0,80002dc8 <_Z8printIntiii+0xe8>
    80002de4:	03813083          	ld	ra,56(sp)
    80002de8:	03013403          	ld	s0,48(sp)
    80002dec:	02813483          	ld	s1,40(sp)
    80002df0:	02013903          	ld	s2,32(sp)
    80002df4:	01813983          	ld	s3,24(sp)
    80002df8:	04010113          	addi	sp,sp,64
    80002dfc:	00008067          	ret

0000000080002e00 <start>:
    80002e00:	ff010113          	addi	sp,sp,-16
    80002e04:	00813423          	sd	s0,8(sp)
    80002e08:	01010413          	addi	s0,sp,16
    80002e0c:	300027f3          	csrr	a5,mstatus
    80002e10:	ffffe737          	lui	a4,0xffffe
    80002e14:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff632f>
    80002e18:	00e7f7b3          	and	a5,a5,a4
    80002e1c:	00001737          	lui	a4,0x1
    80002e20:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002e24:	00e7e7b3          	or	a5,a5,a4
    80002e28:	30079073          	csrw	mstatus,a5
    80002e2c:	00000797          	auipc	a5,0x0
    80002e30:	16078793          	addi	a5,a5,352 # 80002f8c <system_main>
    80002e34:	34179073          	csrw	mepc,a5
    80002e38:	00000793          	li	a5,0
    80002e3c:	18079073          	csrw	satp,a5
    80002e40:	000107b7          	lui	a5,0x10
    80002e44:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002e48:	30279073          	csrw	medeleg,a5
    80002e4c:	30379073          	csrw	mideleg,a5
    80002e50:	104027f3          	csrr	a5,sie
    80002e54:	2227e793          	ori	a5,a5,546
    80002e58:	10479073          	csrw	sie,a5
    80002e5c:	fff00793          	li	a5,-1
    80002e60:	00a7d793          	srli	a5,a5,0xa
    80002e64:	3b079073          	csrw	pmpaddr0,a5
    80002e68:	00f00793          	li	a5,15
    80002e6c:	3a079073          	csrw	pmpcfg0,a5
    80002e70:	f14027f3          	csrr	a5,mhartid
    80002e74:	0200c737          	lui	a4,0x200c
    80002e78:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002e7c:	0007869b          	sext.w	a3,a5
    80002e80:	00269713          	slli	a4,a3,0x2
    80002e84:	000f4637          	lui	a2,0xf4
    80002e88:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002e8c:	00d70733          	add	a4,a4,a3
    80002e90:	0037979b          	slliw	a5,a5,0x3
    80002e94:	020046b7          	lui	a3,0x2004
    80002e98:	00d787b3          	add	a5,a5,a3
    80002e9c:	00c585b3          	add	a1,a1,a2
    80002ea0:	00371693          	slli	a3,a4,0x3
    80002ea4:	00004717          	auipc	a4,0x4
    80002ea8:	3bc70713          	addi	a4,a4,956 # 80007260 <timer_scratch>
    80002eac:	00b7b023          	sd	a1,0(a5)
    80002eb0:	00d70733          	add	a4,a4,a3
    80002eb4:	00f73c23          	sd	a5,24(a4)
    80002eb8:	02c73023          	sd	a2,32(a4)
    80002ebc:	34071073          	csrw	mscratch,a4
    80002ec0:	00000797          	auipc	a5,0x0
    80002ec4:	6e078793          	addi	a5,a5,1760 # 800035a0 <timervec>
    80002ec8:	30579073          	csrw	mtvec,a5
    80002ecc:	300027f3          	csrr	a5,mstatus
    80002ed0:	0087e793          	ori	a5,a5,8
    80002ed4:	30079073          	csrw	mstatus,a5
    80002ed8:	304027f3          	csrr	a5,mie
    80002edc:	0807e793          	ori	a5,a5,128
    80002ee0:	30479073          	csrw	mie,a5
    80002ee4:	f14027f3          	csrr	a5,mhartid
    80002ee8:	0007879b          	sext.w	a5,a5
    80002eec:	00078213          	mv	tp,a5
    80002ef0:	30200073          	mret
    80002ef4:	00813403          	ld	s0,8(sp)
    80002ef8:	01010113          	addi	sp,sp,16
    80002efc:	00008067          	ret

0000000080002f00 <timerinit>:
    80002f00:	ff010113          	addi	sp,sp,-16
    80002f04:	00813423          	sd	s0,8(sp)
    80002f08:	01010413          	addi	s0,sp,16
    80002f0c:	f14027f3          	csrr	a5,mhartid
    80002f10:	0200c737          	lui	a4,0x200c
    80002f14:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002f18:	0007869b          	sext.w	a3,a5
    80002f1c:	00269713          	slli	a4,a3,0x2
    80002f20:	000f4637          	lui	a2,0xf4
    80002f24:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002f28:	00d70733          	add	a4,a4,a3
    80002f2c:	0037979b          	slliw	a5,a5,0x3
    80002f30:	020046b7          	lui	a3,0x2004
    80002f34:	00d787b3          	add	a5,a5,a3
    80002f38:	00c585b3          	add	a1,a1,a2
    80002f3c:	00371693          	slli	a3,a4,0x3
    80002f40:	00004717          	auipc	a4,0x4
    80002f44:	32070713          	addi	a4,a4,800 # 80007260 <timer_scratch>
    80002f48:	00b7b023          	sd	a1,0(a5)
    80002f4c:	00d70733          	add	a4,a4,a3
    80002f50:	00f73c23          	sd	a5,24(a4)
    80002f54:	02c73023          	sd	a2,32(a4)
    80002f58:	34071073          	csrw	mscratch,a4
    80002f5c:	00000797          	auipc	a5,0x0
    80002f60:	64478793          	addi	a5,a5,1604 # 800035a0 <timervec>
    80002f64:	30579073          	csrw	mtvec,a5
    80002f68:	300027f3          	csrr	a5,mstatus
    80002f6c:	0087e793          	ori	a5,a5,8
    80002f70:	30079073          	csrw	mstatus,a5
    80002f74:	304027f3          	csrr	a5,mie
    80002f78:	0807e793          	ori	a5,a5,128
    80002f7c:	30479073          	csrw	mie,a5
    80002f80:	00813403          	ld	s0,8(sp)
    80002f84:	01010113          	addi	sp,sp,16
    80002f88:	00008067          	ret

0000000080002f8c <system_main>:
    80002f8c:	fe010113          	addi	sp,sp,-32
    80002f90:	00813823          	sd	s0,16(sp)
    80002f94:	00913423          	sd	s1,8(sp)
    80002f98:	00113c23          	sd	ra,24(sp)
    80002f9c:	02010413          	addi	s0,sp,32
    80002fa0:	00000097          	auipc	ra,0x0
    80002fa4:	0c4080e7          	jalr	196(ra) # 80003064 <cpuid>
    80002fa8:	00004497          	auipc	s1,0x4
    80002fac:	25848493          	addi	s1,s1,600 # 80007200 <started>
    80002fb0:	02050263          	beqz	a0,80002fd4 <system_main+0x48>
    80002fb4:	0004a783          	lw	a5,0(s1)
    80002fb8:	0007879b          	sext.w	a5,a5
    80002fbc:	fe078ce3          	beqz	a5,80002fb4 <system_main+0x28>
    80002fc0:	0ff0000f          	fence
    80002fc4:	00003517          	auipc	a0,0x3
    80002fc8:	32450513          	addi	a0,a0,804 # 800062e8 <kvmincrease+0x10e8>
    80002fcc:	00001097          	auipc	ra,0x1
    80002fd0:	a70080e7          	jalr	-1424(ra) # 80003a3c <panic>
    80002fd4:	00001097          	auipc	ra,0x1
    80002fd8:	9c4080e7          	jalr	-1596(ra) # 80003998 <consoleinit>
    80002fdc:	00001097          	auipc	ra,0x1
    80002fe0:	150080e7          	jalr	336(ra) # 8000412c <printfinit>
    80002fe4:	00003517          	auipc	a0,0x3
    80002fe8:	1c450513          	addi	a0,a0,452 # 800061a8 <kvmincrease+0xfa8>
    80002fec:	00001097          	auipc	ra,0x1
    80002ff0:	aac080e7          	jalr	-1364(ra) # 80003a98 <__printf>
    80002ff4:	00003517          	auipc	a0,0x3
    80002ff8:	2c450513          	addi	a0,a0,708 # 800062b8 <kvmincrease+0x10b8>
    80002ffc:	00001097          	auipc	ra,0x1
    80003000:	a9c080e7          	jalr	-1380(ra) # 80003a98 <__printf>
    80003004:	00003517          	auipc	a0,0x3
    80003008:	1a450513          	addi	a0,a0,420 # 800061a8 <kvmincrease+0xfa8>
    8000300c:	00001097          	auipc	ra,0x1
    80003010:	a8c080e7          	jalr	-1396(ra) # 80003a98 <__printf>
    80003014:	00001097          	auipc	ra,0x1
    80003018:	4a4080e7          	jalr	1188(ra) # 800044b8 <kinit>
    8000301c:	00000097          	auipc	ra,0x0
    80003020:	148080e7          	jalr	328(ra) # 80003164 <trapinit>
    80003024:	00000097          	auipc	ra,0x0
    80003028:	16c080e7          	jalr	364(ra) # 80003190 <trapinithart>
    8000302c:	00000097          	auipc	ra,0x0
    80003030:	5b4080e7          	jalr	1460(ra) # 800035e0 <plicinit>
    80003034:	00000097          	auipc	ra,0x0
    80003038:	5d4080e7          	jalr	1492(ra) # 80003608 <plicinithart>
    8000303c:	00000097          	auipc	ra,0x0
    80003040:	078080e7          	jalr	120(ra) # 800030b4 <userinit>
    80003044:	0ff0000f          	fence
    80003048:	00100793          	li	a5,1
    8000304c:	00003517          	auipc	a0,0x3
    80003050:	28450513          	addi	a0,a0,644 # 800062d0 <kvmincrease+0x10d0>
    80003054:	00f4a023          	sw	a5,0(s1)
    80003058:	00001097          	auipc	ra,0x1
    8000305c:	a40080e7          	jalr	-1472(ra) # 80003a98 <__printf>
    80003060:	0000006f          	j	80003060 <system_main+0xd4>

0000000080003064 <cpuid>:
    80003064:	ff010113          	addi	sp,sp,-16
    80003068:	00813423          	sd	s0,8(sp)
    8000306c:	01010413          	addi	s0,sp,16
    80003070:	00020513          	mv	a0,tp
    80003074:	00813403          	ld	s0,8(sp)
    80003078:	0005051b          	sext.w	a0,a0
    8000307c:	01010113          	addi	sp,sp,16
    80003080:	00008067          	ret

0000000080003084 <mycpu>:
    80003084:	ff010113          	addi	sp,sp,-16
    80003088:	00813423          	sd	s0,8(sp)
    8000308c:	01010413          	addi	s0,sp,16
    80003090:	00020793          	mv	a5,tp
    80003094:	00813403          	ld	s0,8(sp)
    80003098:	0007879b          	sext.w	a5,a5
    8000309c:	00779793          	slli	a5,a5,0x7
    800030a0:	00005517          	auipc	a0,0x5
    800030a4:	1f050513          	addi	a0,a0,496 # 80008290 <cpus>
    800030a8:	00f50533          	add	a0,a0,a5
    800030ac:	01010113          	addi	sp,sp,16
    800030b0:	00008067          	ret

00000000800030b4 <userinit>:
    800030b4:	ff010113          	addi	sp,sp,-16
    800030b8:	00813423          	sd	s0,8(sp)
    800030bc:	01010413          	addi	s0,sp,16
    800030c0:	00813403          	ld	s0,8(sp)
    800030c4:	01010113          	addi	sp,sp,16
    800030c8:	ffffe317          	auipc	t1,0xffffe
    800030cc:	57430067          	jr	1396(t1) # 8000163c <main>

00000000800030d0 <either_copyout>:
    800030d0:	ff010113          	addi	sp,sp,-16
    800030d4:	00813023          	sd	s0,0(sp)
    800030d8:	00113423          	sd	ra,8(sp)
    800030dc:	01010413          	addi	s0,sp,16
    800030e0:	02051663          	bnez	a0,8000310c <either_copyout+0x3c>
    800030e4:	00058513          	mv	a0,a1
    800030e8:	00060593          	mv	a1,a2
    800030ec:	0006861b          	sext.w	a2,a3
    800030f0:	00002097          	auipc	ra,0x2
    800030f4:	c54080e7          	jalr	-940(ra) # 80004d44 <__memmove>
    800030f8:	00813083          	ld	ra,8(sp)
    800030fc:	00013403          	ld	s0,0(sp)
    80003100:	00000513          	li	a0,0
    80003104:	01010113          	addi	sp,sp,16
    80003108:	00008067          	ret
    8000310c:	00003517          	auipc	a0,0x3
    80003110:	20450513          	addi	a0,a0,516 # 80006310 <kvmincrease+0x1110>
    80003114:	00001097          	auipc	ra,0x1
    80003118:	928080e7          	jalr	-1752(ra) # 80003a3c <panic>

000000008000311c <either_copyin>:
    8000311c:	ff010113          	addi	sp,sp,-16
    80003120:	00813023          	sd	s0,0(sp)
    80003124:	00113423          	sd	ra,8(sp)
    80003128:	01010413          	addi	s0,sp,16
    8000312c:	02059463          	bnez	a1,80003154 <either_copyin+0x38>
    80003130:	00060593          	mv	a1,a2
    80003134:	0006861b          	sext.w	a2,a3
    80003138:	00002097          	auipc	ra,0x2
    8000313c:	c0c080e7          	jalr	-1012(ra) # 80004d44 <__memmove>
    80003140:	00813083          	ld	ra,8(sp)
    80003144:	00013403          	ld	s0,0(sp)
    80003148:	00000513          	li	a0,0
    8000314c:	01010113          	addi	sp,sp,16
    80003150:	00008067          	ret
    80003154:	00003517          	auipc	a0,0x3
    80003158:	1e450513          	addi	a0,a0,484 # 80006338 <kvmincrease+0x1138>
    8000315c:	00001097          	auipc	ra,0x1
    80003160:	8e0080e7          	jalr	-1824(ra) # 80003a3c <panic>

0000000080003164 <trapinit>:
    80003164:	ff010113          	addi	sp,sp,-16
    80003168:	00813423          	sd	s0,8(sp)
    8000316c:	01010413          	addi	s0,sp,16
    80003170:	00813403          	ld	s0,8(sp)
    80003174:	00003597          	auipc	a1,0x3
    80003178:	1ec58593          	addi	a1,a1,492 # 80006360 <kvmincrease+0x1160>
    8000317c:	00005517          	auipc	a0,0x5
    80003180:	19450513          	addi	a0,a0,404 # 80008310 <tickslock>
    80003184:	01010113          	addi	sp,sp,16
    80003188:	00001317          	auipc	t1,0x1
    8000318c:	5c030067          	jr	1472(t1) # 80004748 <initlock>

0000000080003190 <trapinithart>:
    80003190:	ff010113          	addi	sp,sp,-16
    80003194:	00813423          	sd	s0,8(sp)
    80003198:	01010413          	addi	s0,sp,16
    8000319c:	00000797          	auipc	a5,0x0
    800031a0:	2f478793          	addi	a5,a5,756 # 80003490 <kernelvec>
    800031a4:	10579073          	csrw	stvec,a5
    800031a8:	00813403          	ld	s0,8(sp)
    800031ac:	01010113          	addi	sp,sp,16
    800031b0:	00008067          	ret

00000000800031b4 <usertrap>:
    800031b4:	ff010113          	addi	sp,sp,-16
    800031b8:	00813423          	sd	s0,8(sp)
    800031bc:	01010413          	addi	s0,sp,16
    800031c0:	00813403          	ld	s0,8(sp)
    800031c4:	01010113          	addi	sp,sp,16
    800031c8:	00008067          	ret

00000000800031cc <usertrapret>:
    800031cc:	ff010113          	addi	sp,sp,-16
    800031d0:	00813423          	sd	s0,8(sp)
    800031d4:	01010413          	addi	s0,sp,16
    800031d8:	00813403          	ld	s0,8(sp)
    800031dc:	01010113          	addi	sp,sp,16
    800031e0:	00008067          	ret

00000000800031e4 <kerneltrap>:
    800031e4:	fe010113          	addi	sp,sp,-32
    800031e8:	00813823          	sd	s0,16(sp)
    800031ec:	00113c23          	sd	ra,24(sp)
    800031f0:	00913423          	sd	s1,8(sp)
    800031f4:	02010413          	addi	s0,sp,32
    800031f8:	142025f3          	csrr	a1,scause
    800031fc:	100027f3          	csrr	a5,sstatus
    80003200:	0027f793          	andi	a5,a5,2
    80003204:	10079c63          	bnez	a5,8000331c <kerneltrap+0x138>
    80003208:	142027f3          	csrr	a5,scause
    8000320c:	0207ce63          	bltz	a5,80003248 <kerneltrap+0x64>
    80003210:	00003517          	auipc	a0,0x3
    80003214:	19850513          	addi	a0,a0,408 # 800063a8 <kvmincrease+0x11a8>
    80003218:	00001097          	auipc	ra,0x1
    8000321c:	880080e7          	jalr	-1920(ra) # 80003a98 <__printf>
    80003220:	141025f3          	csrr	a1,sepc
    80003224:	14302673          	csrr	a2,stval
    80003228:	00003517          	auipc	a0,0x3
    8000322c:	19050513          	addi	a0,a0,400 # 800063b8 <kvmincrease+0x11b8>
    80003230:	00001097          	auipc	ra,0x1
    80003234:	868080e7          	jalr	-1944(ra) # 80003a98 <__printf>
    80003238:	00003517          	auipc	a0,0x3
    8000323c:	19850513          	addi	a0,a0,408 # 800063d0 <kvmincrease+0x11d0>
    80003240:	00000097          	auipc	ra,0x0
    80003244:	7fc080e7          	jalr	2044(ra) # 80003a3c <panic>
    80003248:	0ff7f713          	andi	a4,a5,255
    8000324c:	00900693          	li	a3,9
    80003250:	04d70063          	beq	a4,a3,80003290 <kerneltrap+0xac>
    80003254:	fff00713          	li	a4,-1
    80003258:	03f71713          	slli	a4,a4,0x3f
    8000325c:	00170713          	addi	a4,a4,1
    80003260:	fae798e3          	bne	a5,a4,80003210 <kerneltrap+0x2c>
    80003264:	00000097          	auipc	ra,0x0
    80003268:	e00080e7          	jalr	-512(ra) # 80003064 <cpuid>
    8000326c:	06050663          	beqz	a0,800032d8 <kerneltrap+0xf4>
    80003270:	144027f3          	csrr	a5,sip
    80003274:	ffd7f793          	andi	a5,a5,-3
    80003278:	14479073          	csrw	sip,a5
    8000327c:	01813083          	ld	ra,24(sp)
    80003280:	01013403          	ld	s0,16(sp)
    80003284:	00813483          	ld	s1,8(sp)
    80003288:	02010113          	addi	sp,sp,32
    8000328c:	00008067          	ret
    80003290:	00000097          	auipc	ra,0x0
    80003294:	3c4080e7          	jalr	964(ra) # 80003654 <plic_claim>
    80003298:	00a00793          	li	a5,10
    8000329c:	00050493          	mv	s1,a0
    800032a0:	06f50863          	beq	a0,a5,80003310 <kerneltrap+0x12c>
    800032a4:	fc050ce3          	beqz	a0,8000327c <kerneltrap+0x98>
    800032a8:	00050593          	mv	a1,a0
    800032ac:	00003517          	auipc	a0,0x3
    800032b0:	0dc50513          	addi	a0,a0,220 # 80006388 <kvmincrease+0x1188>
    800032b4:	00000097          	auipc	ra,0x0
    800032b8:	7e4080e7          	jalr	2020(ra) # 80003a98 <__printf>
    800032bc:	01013403          	ld	s0,16(sp)
    800032c0:	01813083          	ld	ra,24(sp)
    800032c4:	00048513          	mv	a0,s1
    800032c8:	00813483          	ld	s1,8(sp)
    800032cc:	02010113          	addi	sp,sp,32
    800032d0:	00000317          	auipc	t1,0x0
    800032d4:	3bc30067          	jr	956(t1) # 8000368c <plic_complete>
    800032d8:	00005517          	auipc	a0,0x5
    800032dc:	03850513          	addi	a0,a0,56 # 80008310 <tickslock>
    800032e0:	00001097          	auipc	ra,0x1
    800032e4:	48c080e7          	jalr	1164(ra) # 8000476c <acquire>
    800032e8:	00004717          	auipc	a4,0x4
    800032ec:	f1c70713          	addi	a4,a4,-228 # 80007204 <ticks>
    800032f0:	00072783          	lw	a5,0(a4)
    800032f4:	00005517          	auipc	a0,0x5
    800032f8:	01c50513          	addi	a0,a0,28 # 80008310 <tickslock>
    800032fc:	0017879b          	addiw	a5,a5,1
    80003300:	00f72023          	sw	a5,0(a4)
    80003304:	00001097          	auipc	ra,0x1
    80003308:	534080e7          	jalr	1332(ra) # 80004838 <release>
    8000330c:	f65ff06f          	j	80003270 <kerneltrap+0x8c>
    80003310:	00001097          	auipc	ra,0x1
    80003314:	090080e7          	jalr	144(ra) # 800043a0 <uartintr>
    80003318:	fa5ff06f          	j	800032bc <kerneltrap+0xd8>
    8000331c:	00003517          	auipc	a0,0x3
    80003320:	04c50513          	addi	a0,a0,76 # 80006368 <kvmincrease+0x1168>
    80003324:	00000097          	auipc	ra,0x0
    80003328:	718080e7          	jalr	1816(ra) # 80003a3c <panic>

000000008000332c <clockintr>:
    8000332c:	fe010113          	addi	sp,sp,-32
    80003330:	00813823          	sd	s0,16(sp)
    80003334:	00913423          	sd	s1,8(sp)
    80003338:	00113c23          	sd	ra,24(sp)
    8000333c:	02010413          	addi	s0,sp,32
    80003340:	00005497          	auipc	s1,0x5
    80003344:	fd048493          	addi	s1,s1,-48 # 80008310 <tickslock>
    80003348:	00048513          	mv	a0,s1
    8000334c:	00001097          	auipc	ra,0x1
    80003350:	420080e7          	jalr	1056(ra) # 8000476c <acquire>
    80003354:	00004717          	auipc	a4,0x4
    80003358:	eb070713          	addi	a4,a4,-336 # 80007204 <ticks>
    8000335c:	00072783          	lw	a5,0(a4)
    80003360:	01013403          	ld	s0,16(sp)
    80003364:	01813083          	ld	ra,24(sp)
    80003368:	00048513          	mv	a0,s1
    8000336c:	0017879b          	addiw	a5,a5,1
    80003370:	00813483          	ld	s1,8(sp)
    80003374:	00f72023          	sw	a5,0(a4)
    80003378:	02010113          	addi	sp,sp,32
    8000337c:	00001317          	auipc	t1,0x1
    80003380:	4bc30067          	jr	1212(t1) # 80004838 <release>

0000000080003384 <devintr>:
    80003384:	142027f3          	csrr	a5,scause
    80003388:	00000513          	li	a0,0
    8000338c:	0007c463          	bltz	a5,80003394 <devintr+0x10>
    80003390:	00008067          	ret
    80003394:	fe010113          	addi	sp,sp,-32
    80003398:	00813823          	sd	s0,16(sp)
    8000339c:	00113c23          	sd	ra,24(sp)
    800033a0:	00913423          	sd	s1,8(sp)
    800033a4:	02010413          	addi	s0,sp,32
    800033a8:	0ff7f713          	andi	a4,a5,255
    800033ac:	00900693          	li	a3,9
    800033b0:	04d70c63          	beq	a4,a3,80003408 <devintr+0x84>
    800033b4:	fff00713          	li	a4,-1
    800033b8:	03f71713          	slli	a4,a4,0x3f
    800033bc:	00170713          	addi	a4,a4,1
    800033c0:	00e78c63          	beq	a5,a4,800033d8 <devintr+0x54>
    800033c4:	01813083          	ld	ra,24(sp)
    800033c8:	01013403          	ld	s0,16(sp)
    800033cc:	00813483          	ld	s1,8(sp)
    800033d0:	02010113          	addi	sp,sp,32
    800033d4:	00008067          	ret
    800033d8:	00000097          	auipc	ra,0x0
    800033dc:	c8c080e7          	jalr	-884(ra) # 80003064 <cpuid>
    800033e0:	06050663          	beqz	a0,8000344c <devintr+0xc8>
    800033e4:	144027f3          	csrr	a5,sip
    800033e8:	ffd7f793          	andi	a5,a5,-3
    800033ec:	14479073          	csrw	sip,a5
    800033f0:	01813083          	ld	ra,24(sp)
    800033f4:	01013403          	ld	s0,16(sp)
    800033f8:	00813483          	ld	s1,8(sp)
    800033fc:	00200513          	li	a0,2
    80003400:	02010113          	addi	sp,sp,32
    80003404:	00008067          	ret
    80003408:	00000097          	auipc	ra,0x0
    8000340c:	24c080e7          	jalr	588(ra) # 80003654 <plic_claim>
    80003410:	00a00793          	li	a5,10
    80003414:	00050493          	mv	s1,a0
    80003418:	06f50663          	beq	a0,a5,80003484 <devintr+0x100>
    8000341c:	00100513          	li	a0,1
    80003420:	fa0482e3          	beqz	s1,800033c4 <devintr+0x40>
    80003424:	00048593          	mv	a1,s1
    80003428:	00003517          	auipc	a0,0x3
    8000342c:	f6050513          	addi	a0,a0,-160 # 80006388 <kvmincrease+0x1188>
    80003430:	00000097          	auipc	ra,0x0
    80003434:	668080e7          	jalr	1640(ra) # 80003a98 <__printf>
    80003438:	00048513          	mv	a0,s1
    8000343c:	00000097          	auipc	ra,0x0
    80003440:	250080e7          	jalr	592(ra) # 8000368c <plic_complete>
    80003444:	00100513          	li	a0,1
    80003448:	f7dff06f          	j	800033c4 <devintr+0x40>
    8000344c:	00005517          	auipc	a0,0x5
    80003450:	ec450513          	addi	a0,a0,-316 # 80008310 <tickslock>
    80003454:	00001097          	auipc	ra,0x1
    80003458:	318080e7          	jalr	792(ra) # 8000476c <acquire>
    8000345c:	00004717          	auipc	a4,0x4
    80003460:	da870713          	addi	a4,a4,-600 # 80007204 <ticks>
    80003464:	00072783          	lw	a5,0(a4)
    80003468:	00005517          	auipc	a0,0x5
    8000346c:	ea850513          	addi	a0,a0,-344 # 80008310 <tickslock>
    80003470:	0017879b          	addiw	a5,a5,1
    80003474:	00f72023          	sw	a5,0(a4)
    80003478:	00001097          	auipc	ra,0x1
    8000347c:	3c0080e7          	jalr	960(ra) # 80004838 <release>
    80003480:	f65ff06f          	j	800033e4 <devintr+0x60>
    80003484:	00001097          	auipc	ra,0x1
    80003488:	f1c080e7          	jalr	-228(ra) # 800043a0 <uartintr>
    8000348c:	fadff06f          	j	80003438 <devintr+0xb4>

0000000080003490 <kernelvec>:
    80003490:	f0010113          	addi	sp,sp,-256
    80003494:	00113023          	sd	ra,0(sp)
    80003498:	00213423          	sd	sp,8(sp)
    8000349c:	00313823          	sd	gp,16(sp)
    800034a0:	00413c23          	sd	tp,24(sp)
    800034a4:	02513023          	sd	t0,32(sp)
    800034a8:	02613423          	sd	t1,40(sp)
    800034ac:	02713823          	sd	t2,48(sp)
    800034b0:	02813c23          	sd	s0,56(sp)
    800034b4:	04913023          	sd	s1,64(sp)
    800034b8:	04a13423          	sd	a0,72(sp)
    800034bc:	04b13823          	sd	a1,80(sp)
    800034c0:	04c13c23          	sd	a2,88(sp)
    800034c4:	06d13023          	sd	a3,96(sp)
    800034c8:	06e13423          	sd	a4,104(sp)
    800034cc:	06f13823          	sd	a5,112(sp)
    800034d0:	07013c23          	sd	a6,120(sp)
    800034d4:	09113023          	sd	a7,128(sp)
    800034d8:	09213423          	sd	s2,136(sp)
    800034dc:	09313823          	sd	s3,144(sp)
    800034e0:	09413c23          	sd	s4,152(sp)
    800034e4:	0b513023          	sd	s5,160(sp)
    800034e8:	0b613423          	sd	s6,168(sp)
    800034ec:	0b713823          	sd	s7,176(sp)
    800034f0:	0b813c23          	sd	s8,184(sp)
    800034f4:	0d913023          	sd	s9,192(sp)
    800034f8:	0da13423          	sd	s10,200(sp)
    800034fc:	0db13823          	sd	s11,208(sp)
    80003500:	0dc13c23          	sd	t3,216(sp)
    80003504:	0fd13023          	sd	t4,224(sp)
    80003508:	0fe13423          	sd	t5,232(sp)
    8000350c:	0ff13823          	sd	t6,240(sp)
    80003510:	cd5ff0ef          	jal	ra,800031e4 <kerneltrap>
    80003514:	00013083          	ld	ra,0(sp)
    80003518:	00813103          	ld	sp,8(sp)
    8000351c:	01013183          	ld	gp,16(sp)
    80003520:	02013283          	ld	t0,32(sp)
    80003524:	02813303          	ld	t1,40(sp)
    80003528:	03013383          	ld	t2,48(sp)
    8000352c:	03813403          	ld	s0,56(sp)
    80003530:	04013483          	ld	s1,64(sp)
    80003534:	04813503          	ld	a0,72(sp)
    80003538:	05013583          	ld	a1,80(sp)
    8000353c:	05813603          	ld	a2,88(sp)
    80003540:	06013683          	ld	a3,96(sp)
    80003544:	06813703          	ld	a4,104(sp)
    80003548:	07013783          	ld	a5,112(sp)
    8000354c:	07813803          	ld	a6,120(sp)
    80003550:	08013883          	ld	a7,128(sp)
    80003554:	08813903          	ld	s2,136(sp)
    80003558:	09013983          	ld	s3,144(sp)
    8000355c:	09813a03          	ld	s4,152(sp)
    80003560:	0a013a83          	ld	s5,160(sp)
    80003564:	0a813b03          	ld	s6,168(sp)
    80003568:	0b013b83          	ld	s7,176(sp)
    8000356c:	0b813c03          	ld	s8,184(sp)
    80003570:	0c013c83          	ld	s9,192(sp)
    80003574:	0c813d03          	ld	s10,200(sp)
    80003578:	0d013d83          	ld	s11,208(sp)
    8000357c:	0d813e03          	ld	t3,216(sp)
    80003580:	0e013e83          	ld	t4,224(sp)
    80003584:	0e813f03          	ld	t5,232(sp)
    80003588:	0f013f83          	ld	t6,240(sp)
    8000358c:	10010113          	addi	sp,sp,256
    80003590:	10200073          	sret
    80003594:	00000013          	nop
    80003598:	00000013          	nop
    8000359c:	00000013          	nop

00000000800035a0 <timervec>:
    800035a0:	34051573          	csrrw	a0,mscratch,a0
    800035a4:	00b53023          	sd	a1,0(a0)
    800035a8:	00c53423          	sd	a2,8(a0)
    800035ac:	00d53823          	sd	a3,16(a0)
    800035b0:	01853583          	ld	a1,24(a0)
    800035b4:	02053603          	ld	a2,32(a0)
    800035b8:	0005b683          	ld	a3,0(a1)
    800035bc:	00c686b3          	add	a3,a3,a2
    800035c0:	00d5b023          	sd	a3,0(a1)
    800035c4:	00200593          	li	a1,2
    800035c8:	14459073          	csrw	sip,a1
    800035cc:	01053683          	ld	a3,16(a0)
    800035d0:	00853603          	ld	a2,8(a0)
    800035d4:	00053583          	ld	a1,0(a0)
    800035d8:	34051573          	csrrw	a0,mscratch,a0
    800035dc:	30200073          	mret

00000000800035e0 <plicinit>:
    800035e0:	ff010113          	addi	sp,sp,-16
    800035e4:	00813423          	sd	s0,8(sp)
    800035e8:	01010413          	addi	s0,sp,16
    800035ec:	00813403          	ld	s0,8(sp)
    800035f0:	0c0007b7          	lui	a5,0xc000
    800035f4:	00100713          	li	a4,1
    800035f8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800035fc:	00e7a223          	sw	a4,4(a5)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <plicinithart>:
    80003608:	ff010113          	addi	sp,sp,-16
    8000360c:	00813023          	sd	s0,0(sp)
    80003610:	00113423          	sd	ra,8(sp)
    80003614:	01010413          	addi	s0,sp,16
    80003618:	00000097          	auipc	ra,0x0
    8000361c:	a4c080e7          	jalr	-1460(ra) # 80003064 <cpuid>
    80003620:	0085171b          	slliw	a4,a0,0x8
    80003624:	0c0027b7          	lui	a5,0xc002
    80003628:	00e787b3          	add	a5,a5,a4
    8000362c:	40200713          	li	a4,1026
    80003630:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003634:	00813083          	ld	ra,8(sp)
    80003638:	00013403          	ld	s0,0(sp)
    8000363c:	00d5151b          	slliw	a0,a0,0xd
    80003640:	0c2017b7          	lui	a5,0xc201
    80003644:	00a78533          	add	a0,a5,a0
    80003648:	00052023          	sw	zero,0(a0)
    8000364c:	01010113          	addi	sp,sp,16
    80003650:	00008067          	ret

0000000080003654 <plic_claim>:
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00813023          	sd	s0,0(sp)
    8000365c:	00113423          	sd	ra,8(sp)
    80003660:	01010413          	addi	s0,sp,16
    80003664:	00000097          	auipc	ra,0x0
    80003668:	a00080e7          	jalr	-1536(ra) # 80003064 <cpuid>
    8000366c:	00813083          	ld	ra,8(sp)
    80003670:	00013403          	ld	s0,0(sp)
    80003674:	00d5151b          	slliw	a0,a0,0xd
    80003678:	0c2017b7          	lui	a5,0xc201
    8000367c:	00a78533          	add	a0,a5,a0
    80003680:	00452503          	lw	a0,4(a0)
    80003684:	01010113          	addi	sp,sp,16
    80003688:	00008067          	ret

000000008000368c <plic_complete>:
    8000368c:	fe010113          	addi	sp,sp,-32
    80003690:	00813823          	sd	s0,16(sp)
    80003694:	00913423          	sd	s1,8(sp)
    80003698:	00113c23          	sd	ra,24(sp)
    8000369c:	02010413          	addi	s0,sp,32
    800036a0:	00050493          	mv	s1,a0
    800036a4:	00000097          	auipc	ra,0x0
    800036a8:	9c0080e7          	jalr	-1600(ra) # 80003064 <cpuid>
    800036ac:	01813083          	ld	ra,24(sp)
    800036b0:	01013403          	ld	s0,16(sp)
    800036b4:	00d5179b          	slliw	a5,a0,0xd
    800036b8:	0c201737          	lui	a4,0xc201
    800036bc:	00f707b3          	add	a5,a4,a5
    800036c0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800036c4:	00813483          	ld	s1,8(sp)
    800036c8:	02010113          	addi	sp,sp,32
    800036cc:	00008067          	ret

00000000800036d0 <consolewrite>:
    800036d0:	fb010113          	addi	sp,sp,-80
    800036d4:	04813023          	sd	s0,64(sp)
    800036d8:	04113423          	sd	ra,72(sp)
    800036dc:	02913c23          	sd	s1,56(sp)
    800036e0:	03213823          	sd	s2,48(sp)
    800036e4:	03313423          	sd	s3,40(sp)
    800036e8:	03413023          	sd	s4,32(sp)
    800036ec:	01513c23          	sd	s5,24(sp)
    800036f0:	05010413          	addi	s0,sp,80
    800036f4:	06c05c63          	blez	a2,8000376c <consolewrite+0x9c>
    800036f8:	00060993          	mv	s3,a2
    800036fc:	00050a13          	mv	s4,a0
    80003700:	00058493          	mv	s1,a1
    80003704:	00000913          	li	s2,0
    80003708:	fff00a93          	li	s5,-1
    8000370c:	01c0006f          	j	80003728 <consolewrite+0x58>
    80003710:	fbf44503          	lbu	a0,-65(s0)
    80003714:	0019091b          	addiw	s2,s2,1
    80003718:	00148493          	addi	s1,s1,1
    8000371c:	00001097          	auipc	ra,0x1
    80003720:	a9c080e7          	jalr	-1380(ra) # 800041b8 <uartputc>
    80003724:	03298063          	beq	s3,s2,80003744 <consolewrite+0x74>
    80003728:	00048613          	mv	a2,s1
    8000372c:	00100693          	li	a3,1
    80003730:	000a0593          	mv	a1,s4
    80003734:	fbf40513          	addi	a0,s0,-65
    80003738:	00000097          	auipc	ra,0x0
    8000373c:	9e4080e7          	jalr	-1564(ra) # 8000311c <either_copyin>
    80003740:	fd5518e3          	bne	a0,s5,80003710 <consolewrite+0x40>
    80003744:	04813083          	ld	ra,72(sp)
    80003748:	04013403          	ld	s0,64(sp)
    8000374c:	03813483          	ld	s1,56(sp)
    80003750:	02813983          	ld	s3,40(sp)
    80003754:	02013a03          	ld	s4,32(sp)
    80003758:	01813a83          	ld	s5,24(sp)
    8000375c:	00090513          	mv	a0,s2
    80003760:	03013903          	ld	s2,48(sp)
    80003764:	05010113          	addi	sp,sp,80
    80003768:	00008067          	ret
    8000376c:	00000913          	li	s2,0
    80003770:	fd5ff06f          	j	80003744 <consolewrite+0x74>

0000000080003774 <consoleread>:
    80003774:	f9010113          	addi	sp,sp,-112
    80003778:	06813023          	sd	s0,96(sp)
    8000377c:	04913c23          	sd	s1,88(sp)
    80003780:	05213823          	sd	s2,80(sp)
    80003784:	05313423          	sd	s3,72(sp)
    80003788:	05413023          	sd	s4,64(sp)
    8000378c:	03513c23          	sd	s5,56(sp)
    80003790:	03613823          	sd	s6,48(sp)
    80003794:	03713423          	sd	s7,40(sp)
    80003798:	03813023          	sd	s8,32(sp)
    8000379c:	06113423          	sd	ra,104(sp)
    800037a0:	01913c23          	sd	s9,24(sp)
    800037a4:	07010413          	addi	s0,sp,112
    800037a8:	00060b93          	mv	s7,a2
    800037ac:	00050913          	mv	s2,a0
    800037b0:	00058c13          	mv	s8,a1
    800037b4:	00060b1b          	sext.w	s6,a2
    800037b8:	00005497          	auipc	s1,0x5
    800037bc:	b8048493          	addi	s1,s1,-1152 # 80008338 <cons>
    800037c0:	00400993          	li	s3,4
    800037c4:	fff00a13          	li	s4,-1
    800037c8:	00a00a93          	li	s5,10
    800037cc:	05705e63          	blez	s7,80003828 <consoleread+0xb4>
    800037d0:	09c4a703          	lw	a4,156(s1)
    800037d4:	0984a783          	lw	a5,152(s1)
    800037d8:	0007071b          	sext.w	a4,a4
    800037dc:	08e78463          	beq	a5,a4,80003864 <consoleread+0xf0>
    800037e0:	07f7f713          	andi	a4,a5,127
    800037e4:	00e48733          	add	a4,s1,a4
    800037e8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800037ec:	0017869b          	addiw	a3,a5,1
    800037f0:	08d4ac23          	sw	a3,152(s1)
    800037f4:	00070c9b          	sext.w	s9,a4
    800037f8:	0b370663          	beq	a4,s3,800038a4 <consoleread+0x130>
    800037fc:	00100693          	li	a3,1
    80003800:	f9f40613          	addi	a2,s0,-97
    80003804:	000c0593          	mv	a1,s8
    80003808:	00090513          	mv	a0,s2
    8000380c:	f8e40fa3          	sb	a4,-97(s0)
    80003810:	00000097          	auipc	ra,0x0
    80003814:	8c0080e7          	jalr	-1856(ra) # 800030d0 <either_copyout>
    80003818:	01450863          	beq	a0,s4,80003828 <consoleread+0xb4>
    8000381c:	001c0c13          	addi	s8,s8,1
    80003820:	fffb8b9b          	addiw	s7,s7,-1
    80003824:	fb5c94e3          	bne	s9,s5,800037cc <consoleread+0x58>
    80003828:	000b851b          	sext.w	a0,s7
    8000382c:	06813083          	ld	ra,104(sp)
    80003830:	06013403          	ld	s0,96(sp)
    80003834:	05813483          	ld	s1,88(sp)
    80003838:	05013903          	ld	s2,80(sp)
    8000383c:	04813983          	ld	s3,72(sp)
    80003840:	04013a03          	ld	s4,64(sp)
    80003844:	03813a83          	ld	s5,56(sp)
    80003848:	02813b83          	ld	s7,40(sp)
    8000384c:	02013c03          	ld	s8,32(sp)
    80003850:	01813c83          	ld	s9,24(sp)
    80003854:	40ab053b          	subw	a0,s6,a0
    80003858:	03013b03          	ld	s6,48(sp)
    8000385c:	07010113          	addi	sp,sp,112
    80003860:	00008067          	ret
    80003864:	00001097          	auipc	ra,0x1
    80003868:	1d8080e7          	jalr	472(ra) # 80004a3c <push_on>
    8000386c:	0984a703          	lw	a4,152(s1)
    80003870:	09c4a783          	lw	a5,156(s1)
    80003874:	0007879b          	sext.w	a5,a5
    80003878:	fef70ce3          	beq	a4,a5,80003870 <consoleread+0xfc>
    8000387c:	00001097          	auipc	ra,0x1
    80003880:	234080e7          	jalr	564(ra) # 80004ab0 <pop_on>
    80003884:	0984a783          	lw	a5,152(s1)
    80003888:	07f7f713          	andi	a4,a5,127
    8000388c:	00e48733          	add	a4,s1,a4
    80003890:	01874703          	lbu	a4,24(a4)
    80003894:	0017869b          	addiw	a3,a5,1
    80003898:	08d4ac23          	sw	a3,152(s1)
    8000389c:	00070c9b          	sext.w	s9,a4
    800038a0:	f5371ee3          	bne	a4,s3,800037fc <consoleread+0x88>
    800038a4:	000b851b          	sext.w	a0,s7
    800038a8:	f96bf2e3          	bgeu	s7,s6,8000382c <consoleread+0xb8>
    800038ac:	08f4ac23          	sw	a5,152(s1)
    800038b0:	f7dff06f          	j	8000382c <consoleread+0xb8>

00000000800038b4 <consputc>:
    800038b4:	10000793          	li	a5,256
    800038b8:	00f50663          	beq	a0,a5,800038c4 <consputc+0x10>
    800038bc:	00001317          	auipc	t1,0x1
    800038c0:	9f430067          	jr	-1548(t1) # 800042b0 <uartputc_sync>
    800038c4:	ff010113          	addi	sp,sp,-16
    800038c8:	00113423          	sd	ra,8(sp)
    800038cc:	00813023          	sd	s0,0(sp)
    800038d0:	01010413          	addi	s0,sp,16
    800038d4:	00800513          	li	a0,8
    800038d8:	00001097          	auipc	ra,0x1
    800038dc:	9d8080e7          	jalr	-1576(ra) # 800042b0 <uartputc_sync>
    800038e0:	02000513          	li	a0,32
    800038e4:	00001097          	auipc	ra,0x1
    800038e8:	9cc080e7          	jalr	-1588(ra) # 800042b0 <uartputc_sync>
    800038ec:	00013403          	ld	s0,0(sp)
    800038f0:	00813083          	ld	ra,8(sp)
    800038f4:	00800513          	li	a0,8
    800038f8:	01010113          	addi	sp,sp,16
    800038fc:	00001317          	auipc	t1,0x1
    80003900:	9b430067          	jr	-1612(t1) # 800042b0 <uartputc_sync>

0000000080003904 <consoleintr>:
    80003904:	fe010113          	addi	sp,sp,-32
    80003908:	00813823          	sd	s0,16(sp)
    8000390c:	00913423          	sd	s1,8(sp)
    80003910:	01213023          	sd	s2,0(sp)
    80003914:	00113c23          	sd	ra,24(sp)
    80003918:	02010413          	addi	s0,sp,32
    8000391c:	00005917          	auipc	s2,0x5
    80003920:	a1c90913          	addi	s2,s2,-1508 # 80008338 <cons>
    80003924:	00050493          	mv	s1,a0
    80003928:	00090513          	mv	a0,s2
    8000392c:	00001097          	auipc	ra,0x1
    80003930:	e40080e7          	jalr	-448(ra) # 8000476c <acquire>
    80003934:	02048c63          	beqz	s1,8000396c <consoleintr+0x68>
    80003938:	0a092783          	lw	a5,160(s2)
    8000393c:	09892703          	lw	a4,152(s2)
    80003940:	07f00693          	li	a3,127
    80003944:	40e7873b          	subw	a4,a5,a4
    80003948:	02e6e263          	bltu	a3,a4,8000396c <consoleintr+0x68>
    8000394c:	00d00713          	li	a4,13
    80003950:	04e48063          	beq	s1,a4,80003990 <consoleintr+0x8c>
    80003954:	07f7f713          	andi	a4,a5,127
    80003958:	00e90733          	add	a4,s2,a4
    8000395c:	0017879b          	addiw	a5,a5,1
    80003960:	0af92023          	sw	a5,160(s2)
    80003964:	00970c23          	sb	s1,24(a4)
    80003968:	08f92e23          	sw	a5,156(s2)
    8000396c:	01013403          	ld	s0,16(sp)
    80003970:	01813083          	ld	ra,24(sp)
    80003974:	00813483          	ld	s1,8(sp)
    80003978:	00013903          	ld	s2,0(sp)
    8000397c:	00005517          	auipc	a0,0x5
    80003980:	9bc50513          	addi	a0,a0,-1604 # 80008338 <cons>
    80003984:	02010113          	addi	sp,sp,32
    80003988:	00001317          	auipc	t1,0x1
    8000398c:	eb030067          	jr	-336(t1) # 80004838 <release>
    80003990:	00a00493          	li	s1,10
    80003994:	fc1ff06f          	j	80003954 <consoleintr+0x50>

0000000080003998 <consoleinit>:
    80003998:	fe010113          	addi	sp,sp,-32
    8000399c:	00113c23          	sd	ra,24(sp)
    800039a0:	00813823          	sd	s0,16(sp)
    800039a4:	00913423          	sd	s1,8(sp)
    800039a8:	02010413          	addi	s0,sp,32
    800039ac:	00005497          	auipc	s1,0x5
    800039b0:	98c48493          	addi	s1,s1,-1652 # 80008338 <cons>
    800039b4:	00048513          	mv	a0,s1
    800039b8:	00003597          	auipc	a1,0x3
    800039bc:	a2858593          	addi	a1,a1,-1496 # 800063e0 <kvmincrease+0x11e0>
    800039c0:	00001097          	auipc	ra,0x1
    800039c4:	d88080e7          	jalr	-632(ra) # 80004748 <initlock>
    800039c8:	00000097          	auipc	ra,0x0
    800039cc:	7ac080e7          	jalr	1964(ra) # 80004174 <uartinit>
    800039d0:	01813083          	ld	ra,24(sp)
    800039d4:	01013403          	ld	s0,16(sp)
    800039d8:	00000797          	auipc	a5,0x0
    800039dc:	d9c78793          	addi	a5,a5,-612 # 80003774 <consoleread>
    800039e0:	0af4bc23          	sd	a5,184(s1)
    800039e4:	00000797          	auipc	a5,0x0
    800039e8:	cec78793          	addi	a5,a5,-788 # 800036d0 <consolewrite>
    800039ec:	0cf4b023          	sd	a5,192(s1)
    800039f0:	00813483          	ld	s1,8(sp)
    800039f4:	02010113          	addi	sp,sp,32
    800039f8:	00008067          	ret

00000000800039fc <console_read>:
    800039fc:	ff010113          	addi	sp,sp,-16
    80003a00:	00813423          	sd	s0,8(sp)
    80003a04:	01010413          	addi	s0,sp,16
    80003a08:	00813403          	ld	s0,8(sp)
    80003a0c:	00005317          	auipc	t1,0x5
    80003a10:	9e433303          	ld	t1,-1564(t1) # 800083f0 <devsw+0x10>
    80003a14:	01010113          	addi	sp,sp,16
    80003a18:	00030067          	jr	t1

0000000080003a1c <console_write>:
    80003a1c:	ff010113          	addi	sp,sp,-16
    80003a20:	00813423          	sd	s0,8(sp)
    80003a24:	01010413          	addi	s0,sp,16
    80003a28:	00813403          	ld	s0,8(sp)
    80003a2c:	00005317          	auipc	t1,0x5
    80003a30:	9cc33303          	ld	t1,-1588(t1) # 800083f8 <devsw+0x18>
    80003a34:	01010113          	addi	sp,sp,16
    80003a38:	00030067          	jr	t1

0000000080003a3c <panic>:
    80003a3c:	fe010113          	addi	sp,sp,-32
    80003a40:	00113c23          	sd	ra,24(sp)
    80003a44:	00813823          	sd	s0,16(sp)
    80003a48:	00913423          	sd	s1,8(sp)
    80003a4c:	02010413          	addi	s0,sp,32
    80003a50:	00050493          	mv	s1,a0
    80003a54:	00003517          	auipc	a0,0x3
    80003a58:	99450513          	addi	a0,a0,-1644 # 800063e8 <kvmincrease+0x11e8>
    80003a5c:	00005797          	auipc	a5,0x5
    80003a60:	a207ae23          	sw	zero,-1476(a5) # 80008498 <pr+0x18>
    80003a64:	00000097          	auipc	ra,0x0
    80003a68:	034080e7          	jalr	52(ra) # 80003a98 <__printf>
    80003a6c:	00048513          	mv	a0,s1
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	028080e7          	jalr	40(ra) # 80003a98 <__printf>
    80003a78:	00002517          	auipc	a0,0x2
    80003a7c:	73050513          	addi	a0,a0,1840 # 800061a8 <kvmincrease+0xfa8>
    80003a80:	00000097          	auipc	ra,0x0
    80003a84:	018080e7          	jalr	24(ra) # 80003a98 <__printf>
    80003a88:	00100793          	li	a5,1
    80003a8c:	00003717          	auipc	a4,0x3
    80003a90:	76f72e23          	sw	a5,1916(a4) # 80007208 <panicked>
    80003a94:	0000006f          	j	80003a94 <panic+0x58>

0000000080003a98 <__printf>:
    80003a98:	f3010113          	addi	sp,sp,-208
    80003a9c:	08813023          	sd	s0,128(sp)
    80003aa0:	07313423          	sd	s3,104(sp)
    80003aa4:	09010413          	addi	s0,sp,144
    80003aa8:	05813023          	sd	s8,64(sp)
    80003aac:	08113423          	sd	ra,136(sp)
    80003ab0:	06913c23          	sd	s1,120(sp)
    80003ab4:	07213823          	sd	s2,112(sp)
    80003ab8:	07413023          	sd	s4,96(sp)
    80003abc:	05513c23          	sd	s5,88(sp)
    80003ac0:	05613823          	sd	s6,80(sp)
    80003ac4:	05713423          	sd	s7,72(sp)
    80003ac8:	03913c23          	sd	s9,56(sp)
    80003acc:	03a13823          	sd	s10,48(sp)
    80003ad0:	03b13423          	sd	s11,40(sp)
    80003ad4:	00005317          	auipc	t1,0x5
    80003ad8:	9ac30313          	addi	t1,t1,-1620 # 80008480 <pr>
    80003adc:	01832c03          	lw	s8,24(t1)
    80003ae0:	00b43423          	sd	a1,8(s0)
    80003ae4:	00c43823          	sd	a2,16(s0)
    80003ae8:	00d43c23          	sd	a3,24(s0)
    80003aec:	02e43023          	sd	a4,32(s0)
    80003af0:	02f43423          	sd	a5,40(s0)
    80003af4:	03043823          	sd	a6,48(s0)
    80003af8:	03143c23          	sd	a7,56(s0)
    80003afc:	00050993          	mv	s3,a0
    80003b00:	4a0c1663          	bnez	s8,80003fac <__printf+0x514>
    80003b04:	60098c63          	beqz	s3,8000411c <__printf+0x684>
    80003b08:	0009c503          	lbu	a0,0(s3)
    80003b0c:	00840793          	addi	a5,s0,8
    80003b10:	f6f43c23          	sd	a5,-136(s0)
    80003b14:	00000493          	li	s1,0
    80003b18:	22050063          	beqz	a0,80003d38 <__printf+0x2a0>
    80003b1c:	00002a37          	lui	s4,0x2
    80003b20:	00018ab7          	lui	s5,0x18
    80003b24:	000f4b37          	lui	s6,0xf4
    80003b28:	00989bb7          	lui	s7,0x989
    80003b2c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003b30:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003b34:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003b38:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80003b3c:	00148c9b          	addiw	s9,s1,1
    80003b40:	02500793          	li	a5,37
    80003b44:	01998933          	add	s2,s3,s9
    80003b48:	38f51263          	bne	a0,a5,80003ecc <__printf+0x434>
    80003b4c:	00094783          	lbu	a5,0(s2)
    80003b50:	00078c9b          	sext.w	s9,a5
    80003b54:	1e078263          	beqz	a5,80003d38 <__printf+0x2a0>
    80003b58:	0024849b          	addiw	s1,s1,2
    80003b5c:	07000713          	li	a4,112
    80003b60:	00998933          	add	s2,s3,s1
    80003b64:	38e78a63          	beq	a5,a4,80003ef8 <__printf+0x460>
    80003b68:	20f76863          	bltu	a4,a5,80003d78 <__printf+0x2e0>
    80003b6c:	42a78863          	beq	a5,a0,80003f9c <__printf+0x504>
    80003b70:	06400713          	li	a4,100
    80003b74:	40e79663          	bne	a5,a4,80003f80 <__printf+0x4e8>
    80003b78:	f7843783          	ld	a5,-136(s0)
    80003b7c:	0007a603          	lw	a2,0(a5)
    80003b80:	00878793          	addi	a5,a5,8
    80003b84:	f6f43c23          	sd	a5,-136(s0)
    80003b88:	42064a63          	bltz	a2,80003fbc <__printf+0x524>
    80003b8c:	00a00713          	li	a4,10
    80003b90:	02e677bb          	remuw	a5,a2,a4
    80003b94:	00003d97          	auipc	s11,0x3
    80003b98:	87cd8d93          	addi	s11,s11,-1924 # 80006410 <digits>
    80003b9c:	00900593          	li	a1,9
    80003ba0:	0006051b          	sext.w	a0,a2
    80003ba4:	00000c93          	li	s9,0
    80003ba8:	02079793          	slli	a5,a5,0x20
    80003bac:	0207d793          	srli	a5,a5,0x20
    80003bb0:	00fd87b3          	add	a5,s11,a5
    80003bb4:	0007c783          	lbu	a5,0(a5)
    80003bb8:	02e656bb          	divuw	a3,a2,a4
    80003bbc:	f8f40023          	sb	a5,-128(s0)
    80003bc0:	14c5d863          	bge	a1,a2,80003d10 <__printf+0x278>
    80003bc4:	06300593          	li	a1,99
    80003bc8:	00100c93          	li	s9,1
    80003bcc:	02e6f7bb          	remuw	a5,a3,a4
    80003bd0:	02079793          	slli	a5,a5,0x20
    80003bd4:	0207d793          	srli	a5,a5,0x20
    80003bd8:	00fd87b3          	add	a5,s11,a5
    80003bdc:	0007c783          	lbu	a5,0(a5)
    80003be0:	02e6d73b          	divuw	a4,a3,a4
    80003be4:	f8f400a3          	sb	a5,-127(s0)
    80003be8:	12a5f463          	bgeu	a1,a0,80003d10 <__printf+0x278>
    80003bec:	00a00693          	li	a3,10
    80003bf0:	00900593          	li	a1,9
    80003bf4:	02d777bb          	remuw	a5,a4,a3
    80003bf8:	02079793          	slli	a5,a5,0x20
    80003bfc:	0207d793          	srli	a5,a5,0x20
    80003c00:	00fd87b3          	add	a5,s11,a5
    80003c04:	0007c503          	lbu	a0,0(a5)
    80003c08:	02d757bb          	divuw	a5,a4,a3
    80003c0c:	f8a40123          	sb	a0,-126(s0)
    80003c10:	48e5f263          	bgeu	a1,a4,80004094 <__printf+0x5fc>
    80003c14:	06300513          	li	a0,99
    80003c18:	02d7f5bb          	remuw	a1,a5,a3
    80003c1c:	02059593          	slli	a1,a1,0x20
    80003c20:	0205d593          	srli	a1,a1,0x20
    80003c24:	00bd85b3          	add	a1,s11,a1
    80003c28:	0005c583          	lbu	a1,0(a1)
    80003c2c:	02d7d7bb          	divuw	a5,a5,a3
    80003c30:	f8b401a3          	sb	a1,-125(s0)
    80003c34:	48e57263          	bgeu	a0,a4,800040b8 <__printf+0x620>
    80003c38:	3e700513          	li	a0,999
    80003c3c:	02d7f5bb          	remuw	a1,a5,a3
    80003c40:	02059593          	slli	a1,a1,0x20
    80003c44:	0205d593          	srli	a1,a1,0x20
    80003c48:	00bd85b3          	add	a1,s11,a1
    80003c4c:	0005c583          	lbu	a1,0(a1)
    80003c50:	02d7d7bb          	divuw	a5,a5,a3
    80003c54:	f8b40223          	sb	a1,-124(s0)
    80003c58:	46e57663          	bgeu	a0,a4,800040c4 <__printf+0x62c>
    80003c5c:	02d7f5bb          	remuw	a1,a5,a3
    80003c60:	02059593          	slli	a1,a1,0x20
    80003c64:	0205d593          	srli	a1,a1,0x20
    80003c68:	00bd85b3          	add	a1,s11,a1
    80003c6c:	0005c583          	lbu	a1,0(a1)
    80003c70:	02d7d7bb          	divuw	a5,a5,a3
    80003c74:	f8b402a3          	sb	a1,-123(s0)
    80003c78:	46ea7863          	bgeu	s4,a4,800040e8 <__printf+0x650>
    80003c7c:	02d7f5bb          	remuw	a1,a5,a3
    80003c80:	02059593          	slli	a1,a1,0x20
    80003c84:	0205d593          	srli	a1,a1,0x20
    80003c88:	00bd85b3          	add	a1,s11,a1
    80003c8c:	0005c583          	lbu	a1,0(a1)
    80003c90:	02d7d7bb          	divuw	a5,a5,a3
    80003c94:	f8b40323          	sb	a1,-122(s0)
    80003c98:	3eeaf863          	bgeu	s5,a4,80004088 <__printf+0x5f0>
    80003c9c:	02d7f5bb          	remuw	a1,a5,a3
    80003ca0:	02059593          	slli	a1,a1,0x20
    80003ca4:	0205d593          	srli	a1,a1,0x20
    80003ca8:	00bd85b3          	add	a1,s11,a1
    80003cac:	0005c583          	lbu	a1,0(a1)
    80003cb0:	02d7d7bb          	divuw	a5,a5,a3
    80003cb4:	f8b403a3          	sb	a1,-121(s0)
    80003cb8:	42eb7e63          	bgeu	s6,a4,800040f4 <__printf+0x65c>
    80003cbc:	02d7f5bb          	remuw	a1,a5,a3
    80003cc0:	02059593          	slli	a1,a1,0x20
    80003cc4:	0205d593          	srli	a1,a1,0x20
    80003cc8:	00bd85b3          	add	a1,s11,a1
    80003ccc:	0005c583          	lbu	a1,0(a1)
    80003cd0:	02d7d7bb          	divuw	a5,a5,a3
    80003cd4:	f8b40423          	sb	a1,-120(s0)
    80003cd8:	42ebfc63          	bgeu	s7,a4,80004110 <__printf+0x678>
    80003cdc:	02079793          	slli	a5,a5,0x20
    80003ce0:	0207d793          	srli	a5,a5,0x20
    80003ce4:	00fd8db3          	add	s11,s11,a5
    80003ce8:	000dc703          	lbu	a4,0(s11)
    80003cec:	00a00793          	li	a5,10
    80003cf0:	00900c93          	li	s9,9
    80003cf4:	f8e404a3          	sb	a4,-119(s0)
    80003cf8:	00065c63          	bgez	a2,80003d10 <__printf+0x278>
    80003cfc:	f9040713          	addi	a4,s0,-112
    80003d00:	00f70733          	add	a4,a4,a5
    80003d04:	02d00693          	li	a3,45
    80003d08:	fed70823          	sb	a3,-16(a4)
    80003d0c:	00078c93          	mv	s9,a5
    80003d10:	f8040793          	addi	a5,s0,-128
    80003d14:	01978cb3          	add	s9,a5,s9
    80003d18:	f7f40d13          	addi	s10,s0,-129
    80003d1c:	000cc503          	lbu	a0,0(s9)
    80003d20:	fffc8c93          	addi	s9,s9,-1
    80003d24:	00000097          	auipc	ra,0x0
    80003d28:	b90080e7          	jalr	-1136(ra) # 800038b4 <consputc>
    80003d2c:	ffac98e3          	bne	s9,s10,80003d1c <__printf+0x284>
    80003d30:	00094503          	lbu	a0,0(s2)
    80003d34:	e00514e3          	bnez	a0,80003b3c <__printf+0xa4>
    80003d38:	1a0c1663          	bnez	s8,80003ee4 <__printf+0x44c>
    80003d3c:	08813083          	ld	ra,136(sp)
    80003d40:	08013403          	ld	s0,128(sp)
    80003d44:	07813483          	ld	s1,120(sp)
    80003d48:	07013903          	ld	s2,112(sp)
    80003d4c:	06813983          	ld	s3,104(sp)
    80003d50:	06013a03          	ld	s4,96(sp)
    80003d54:	05813a83          	ld	s5,88(sp)
    80003d58:	05013b03          	ld	s6,80(sp)
    80003d5c:	04813b83          	ld	s7,72(sp)
    80003d60:	04013c03          	ld	s8,64(sp)
    80003d64:	03813c83          	ld	s9,56(sp)
    80003d68:	03013d03          	ld	s10,48(sp)
    80003d6c:	02813d83          	ld	s11,40(sp)
    80003d70:	0d010113          	addi	sp,sp,208
    80003d74:	00008067          	ret
    80003d78:	07300713          	li	a4,115
    80003d7c:	1ce78a63          	beq	a5,a4,80003f50 <__printf+0x4b8>
    80003d80:	07800713          	li	a4,120
    80003d84:	1ee79e63          	bne	a5,a4,80003f80 <__printf+0x4e8>
    80003d88:	f7843783          	ld	a5,-136(s0)
    80003d8c:	0007a703          	lw	a4,0(a5)
    80003d90:	00878793          	addi	a5,a5,8
    80003d94:	f6f43c23          	sd	a5,-136(s0)
    80003d98:	28074263          	bltz	a4,8000401c <__printf+0x584>
    80003d9c:	00002d97          	auipc	s11,0x2
    80003da0:	674d8d93          	addi	s11,s11,1652 # 80006410 <digits>
    80003da4:	00f77793          	andi	a5,a4,15
    80003da8:	00fd87b3          	add	a5,s11,a5
    80003dac:	0007c683          	lbu	a3,0(a5)
    80003db0:	00f00613          	li	a2,15
    80003db4:	0007079b          	sext.w	a5,a4
    80003db8:	f8d40023          	sb	a3,-128(s0)
    80003dbc:	0047559b          	srliw	a1,a4,0x4
    80003dc0:	0047569b          	srliw	a3,a4,0x4
    80003dc4:	00000c93          	li	s9,0
    80003dc8:	0ee65063          	bge	a2,a4,80003ea8 <__printf+0x410>
    80003dcc:	00f6f693          	andi	a3,a3,15
    80003dd0:	00dd86b3          	add	a3,s11,a3
    80003dd4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003dd8:	0087d79b          	srliw	a5,a5,0x8
    80003ddc:	00100c93          	li	s9,1
    80003de0:	f8d400a3          	sb	a3,-127(s0)
    80003de4:	0cb67263          	bgeu	a2,a1,80003ea8 <__printf+0x410>
    80003de8:	00f7f693          	andi	a3,a5,15
    80003dec:	00dd86b3          	add	a3,s11,a3
    80003df0:	0006c583          	lbu	a1,0(a3)
    80003df4:	00f00613          	li	a2,15
    80003df8:	0047d69b          	srliw	a3,a5,0x4
    80003dfc:	f8b40123          	sb	a1,-126(s0)
    80003e00:	0047d593          	srli	a1,a5,0x4
    80003e04:	28f67e63          	bgeu	a2,a5,800040a0 <__printf+0x608>
    80003e08:	00f6f693          	andi	a3,a3,15
    80003e0c:	00dd86b3          	add	a3,s11,a3
    80003e10:	0006c503          	lbu	a0,0(a3)
    80003e14:	0087d813          	srli	a6,a5,0x8
    80003e18:	0087d69b          	srliw	a3,a5,0x8
    80003e1c:	f8a401a3          	sb	a0,-125(s0)
    80003e20:	28b67663          	bgeu	a2,a1,800040ac <__printf+0x614>
    80003e24:	00f6f693          	andi	a3,a3,15
    80003e28:	00dd86b3          	add	a3,s11,a3
    80003e2c:	0006c583          	lbu	a1,0(a3)
    80003e30:	00c7d513          	srli	a0,a5,0xc
    80003e34:	00c7d69b          	srliw	a3,a5,0xc
    80003e38:	f8b40223          	sb	a1,-124(s0)
    80003e3c:	29067a63          	bgeu	a2,a6,800040d0 <__printf+0x638>
    80003e40:	00f6f693          	andi	a3,a3,15
    80003e44:	00dd86b3          	add	a3,s11,a3
    80003e48:	0006c583          	lbu	a1,0(a3)
    80003e4c:	0107d813          	srli	a6,a5,0x10
    80003e50:	0107d69b          	srliw	a3,a5,0x10
    80003e54:	f8b402a3          	sb	a1,-123(s0)
    80003e58:	28a67263          	bgeu	a2,a0,800040dc <__printf+0x644>
    80003e5c:	00f6f693          	andi	a3,a3,15
    80003e60:	00dd86b3          	add	a3,s11,a3
    80003e64:	0006c683          	lbu	a3,0(a3)
    80003e68:	0147d79b          	srliw	a5,a5,0x14
    80003e6c:	f8d40323          	sb	a3,-122(s0)
    80003e70:	21067663          	bgeu	a2,a6,8000407c <__printf+0x5e4>
    80003e74:	02079793          	slli	a5,a5,0x20
    80003e78:	0207d793          	srli	a5,a5,0x20
    80003e7c:	00fd8db3          	add	s11,s11,a5
    80003e80:	000dc683          	lbu	a3,0(s11)
    80003e84:	00800793          	li	a5,8
    80003e88:	00700c93          	li	s9,7
    80003e8c:	f8d403a3          	sb	a3,-121(s0)
    80003e90:	00075c63          	bgez	a4,80003ea8 <__printf+0x410>
    80003e94:	f9040713          	addi	a4,s0,-112
    80003e98:	00f70733          	add	a4,a4,a5
    80003e9c:	02d00693          	li	a3,45
    80003ea0:	fed70823          	sb	a3,-16(a4)
    80003ea4:	00078c93          	mv	s9,a5
    80003ea8:	f8040793          	addi	a5,s0,-128
    80003eac:	01978cb3          	add	s9,a5,s9
    80003eb0:	f7f40d13          	addi	s10,s0,-129
    80003eb4:	000cc503          	lbu	a0,0(s9)
    80003eb8:	fffc8c93          	addi	s9,s9,-1
    80003ebc:	00000097          	auipc	ra,0x0
    80003ec0:	9f8080e7          	jalr	-1544(ra) # 800038b4 <consputc>
    80003ec4:	ff9d18e3          	bne	s10,s9,80003eb4 <__printf+0x41c>
    80003ec8:	0100006f          	j	80003ed8 <__printf+0x440>
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	9e8080e7          	jalr	-1560(ra) # 800038b4 <consputc>
    80003ed4:	000c8493          	mv	s1,s9
    80003ed8:	00094503          	lbu	a0,0(s2)
    80003edc:	c60510e3          	bnez	a0,80003b3c <__printf+0xa4>
    80003ee0:	e40c0ee3          	beqz	s8,80003d3c <__printf+0x2a4>
    80003ee4:	00004517          	auipc	a0,0x4
    80003ee8:	59c50513          	addi	a0,a0,1436 # 80008480 <pr>
    80003eec:	00001097          	auipc	ra,0x1
    80003ef0:	94c080e7          	jalr	-1716(ra) # 80004838 <release>
    80003ef4:	e49ff06f          	j	80003d3c <__printf+0x2a4>
    80003ef8:	f7843783          	ld	a5,-136(s0)
    80003efc:	03000513          	li	a0,48
    80003f00:	01000d13          	li	s10,16
    80003f04:	00878713          	addi	a4,a5,8
    80003f08:	0007bc83          	ld	s9,0(a5)
    80003f0c:	f6e43c23          	sd	a4,-136(s0)
    80003f10:	00000097          	auipc	ra,0x0
    80003f14:	9a4080e7          	jalr	-1628(ra) # 800038b4 <consputc>
    80003f18:	07800513          	li	a0,120
    80003f1c:	00000097          	auipc	ra,0x0
    80003f20:	998080e7          	jalr	-1640(ra) # 800038b4 <consputc>
    80003f24:	00002d97          	auipc	s11,0x2
    80003f28:	4ecd8d93          	addi	s11,s11,1260 # 80006410 <digits>
    80003f2c:	03ccd793          	srli	a5,s9,0x3c
    80003f30:	00fd87b3          	add	a5,s11,a5
    80003f34:	0007c503          	lbu	a0,0(a5)
    80003f38:	fffd0d1b          	addiw	s10,s10,-1
    80003f3c:	004c9c93          	slli	s9,s9,0x4
    80003f40:	00000097          	auipc	ra,0x0
    80003f44:	974080e7          	jalr	-1676(ra) # 800038b4 <consputc>
    80003f48:	fe0d12e3          	bnez	s10,80003f2c <__printf+0x494>
    80003f4c:	f8dff06f          	j	80003ed8 <__printf+0x440>
    80003f50:	f7843783          	ld	a5,-136(s0)
    80003f54:	0007bc83          	ld	s9,0(a5)
    80003f58:	00878793          	addi	a5,a5,8
    80003f5c:	f6f43c23          	sd	a5,-136(s0)
    80003f60:	000c9a63          	bnez	s9,80003f74 <__printf+0x4dc>
    80003f64:	1080006f          	j	8000406c <__printf+0x5d4>
    80003f68:	001c8c93          	addi	s9,s9,1
    80003f6c:	00000097          	auipc	ra,0x0
    80003f70:	948080e7          	jalr	-1720(ra) # 800038b4 <consputc>
    80003f74:	000cc503          	lbu	a0,0(s9)
    80003f78:	fe0518e3          	bnez	a0,80003f68 <__printf+0x4d0>
    80003f7c:	f5dff06f          	j	80003ed8 <__printf+0x440>
    80003f80:	02500513          	li	a0,37
    80003f84:	00000097          	auipc	ra,0x0
    80003f88:	930080e7          	jalr	-1744(ra) # 800038b4 <consputc>
    80003f8c:	000c8513          	mv	a0,s9
    80003f90:	00000097          	auipc	ra,0x0
    80003f94:	924080e7          	jalr	-1756(ra) # 800038b4 <consputc>
    80003f98:	f41ff06f          	j	80003ed8 <__printf+0x440>
    80003f9c:	02500513          	li	a0,37
    80003fa0:	00000097          	auipc	ra,0x0
    80003fa4:	914080e7          	jalr	-1772(ra) # 800038b4 <consputc>
    80003fa8:	f31ff06f          	j	80003ed8 <__printf+0x440>
    80003fac:	00030513          	mv	a0,t1
    80003fb0:	00000097          	auipc	ra,0x0
    80003fb4:	7bc080e7          	jalr	1980(ra) # 8000476c <acquire>
    80003fb8:	b4dff06f          	j	80003b04 <__printf+0x6c>
    80003fbc:	40c0053b          	negw	a0,a2
    80003fc0:	00a00713          	li	a4,10
    80003fc4:	02e576bb          	remuw	a3,a0,a4
    80003fc8:	00002d97          	auipc	s11,0x2
    80003fcc:	448d8d93          	addi	s11,s11,1096 # 80006410 <digits>
    80003fd0:	ff700593          	li	a1,-9
    80003fd4:	02069693          	slli	a3,a3,0x20
    80003fd8:	0206d693          	srli	a3,a3,0x20
    80003fdc:	00dd86b3          	add	a3,s11,a3
    80003fe0:	0006c683          	lbu	a3,0(a3)
    80003fe4:	02e557bb          	divuw	a5,a0,a4
    80003fe8:	f8d40023          	sb	a3,-128(s0)
    80003fec:	10b65e63          	bge	a2,a1,80004108 <__printf+0x670>
    80003ff0:	06300593          	li	a1,99
    80003ff4:	02e7f6bb          	remuw	a3,a5,a4
    80003ff8:	02069693          	slli	a3,a3,0x20
    80003ffc:	0206d693          	srli	a3,a3,0x20
    80004000:	00dd86b3          	add	a3,s11,a3
    80004004:	0006c683          	lbu	a3,0(a3)
    80004008:	02e7d73b          	divuw	a4,a5,a4
    8000400c:	00200793          	li	a5,2
    80004010:	f8d400a3          	sb	a3,-127(s0)
    80004014:	bca5ece3          	bltu	a1,a0,80003bec <__printf+0x154>
    80004018:	ce5ff06f          	j	80003cfc <__printf+0x264>
    8000401c:	40e007bb          	negw	a5,a4
    80004020:	00002d97          	auipc	s11,0x2
    80004024:	3f0d8d93          	addi	s11,s11,1008 # 80006410 <digits>
    80004028:	00f7f693          	andi	a3,a5,15
    8000402c:	00dd86b3          	add	a3,s11,a3
    80004030:	0006c583          	lbu	a1,0(a3)
    80004034:	ff100613          	li	a2,-15
    80004038:	0047d69b          	srliw	a3,a5,0x4
    8000403c:	f8b40023          	sb	a1,-128(s0)
    80004040:	0047d59b          	srliw	a1,a5,0x4
    80004044:	0ac75e63          	bge	a4,a2,80004100 <__printf+0x668>
    80004048:	00f6f693          	andi	a3,a3,15
    8000404c:	00dd86b3          	add	a3,s11,a3
    80004050:	0006c603          	lbu	a2,0(a3)
    80004054:	00f00693          	li	a3,15
    80004058:	0087d79b          	srliw	a5,a5,0x8
    8000405c:	f8c400a3          	sb	a2,-127(s0)
    80004060:	d8b6e4e3          	bltu	a3,a1,80003de8 <__printf+0x350>
    80004064:	00200793          	li	a5,2
    80004068:	e2dff06f          	j	80003e94 <__printf+0x3fc>
    8000406c:	00002c97          	auipc	s9,0x2
    80004070:	384c8c93          	addi	s9,s9,900 # 800063f0 <kvmincrease+0x11f0>
    80004074:	02800513          	li	a0,40
    80004078:	ef1ff06f          	j	80003f68 <__printf+0x4d0>
    8000407c:	00700793          	li	a5,7
    80004080:	00600c93          	li	s9,6
    80004084:	e0dff06f          	j	80003e90 <__printf+0x3f8>
    80004088:	00700793          	li	a5,7
    8000408c:	00600c93          	li	s9,6
    80004090:	c69ff06f          	j	80003cf8 <__printf+0x260>
    80004094:	00300793          	li	a5,3
    80004098:	00200c93          	li	s9,2
    8000409c:	c5dff06f          	j	80003cf8 <__printf+0x260>
    800040a0:	00300793          	li	a5,3
    800040a4:	00200c93          	li	s9,2
    800040a8:	de9ff06f          	j	80003e90 <__printf+0x3f8>
    800040ac:	00400793          	li	a5,4
    800040b0:	00300c93          	li	s9,3
    800040b4:	dddff06f          	j	80003e90 <__printf+0x3f8>
    800040b8:	00400793          	li	a5,4
    800040bc:	00300c93          	li	s9,3
    800040c0:	c39ff06f          	j	80003cf8 <__printf+0x260>
    800040c4:	00500793          	li	a5,5
    800040c8:	00400c93          	li	s9,4
    800040cc:	c2dff06f          	j	80003cf8 <__printf+0x260>
    800040d0:	00500793          	li	a5,5
    800040d4:	00400c93          	li	s9,4
    800040d8:	db9ff06f          	j	80003e90 <__printf+0x3f8>
    800040dc:	00600793          	li	a5,6
    800040e0:	00500c93          	li	s9,5
    800040e4:	dadff06f          	j	80003e90 <__printf+0x3f8>
    800040e8:	00600793          	li	a5,6
    800040ec:	00500c93          	li	s9,5
    800040f0:	c09ff06f          	j	80003cf8 <__printf+0x260>
    800040f4:	00800793          	li	a5,8
    800040f8:	00700c93          	li	s9,7
    800040fc:	bfdff06f          	j	80003cf8 <__printf+0x260>
    80004100:	00100793          	li	a5,1
    80004104:	d91ff06f          	j	80003e94 <__printf+0x3fc>
    80004108:	00100793          	li	a5,1
    8000410c:	bf1ff06f          	j	80003cfc <__printf+0x264>
    80004110:	00900793          	li	a5,9
    80004114:	00800c93          	li	s9,8
    80004118:	be1ff06f          	j	80003cf8 <__printf+0x260>
    8000411c:	00002517          	auipc	a0,0x2
    80004120:	2dc50513          	addi	a0,a0,732 # 800063f8 <kvmincrease+0x11f8>
    80004124:	00000097          	auipc	ra,0x0
    80004128:	918080e7          	jalr	-1768(ra) # 80003a3c <panic>

000000008000412c <printfinit>:
    8000412c:	fe010113          	addi	sp,sp,-32
    80004130:	00813823          	sd	s0,16(sp)
    80004134:	00913423          	sd	s1,8(sp)
    80004138:	00113c23          	sd	ra,24(sp)
    8000413c:	02010413          	addi	s0,sp,32
    80004140:	00004497          	auipc	s1,0x4
    80004144:	34048493          	addi	s1,s1,832 # 80008480 <pr>
    80004148:	00048513          	mv	a0,s1
    8000414c:	00002597          	auipc	a1,0x2
    80004150:	2bc58593          	addi	a1,a1,700 # 80006408 <kvmincrease+0x1208>
    80004154:	00000097          	auipc	ra,0x0
    80004158:	5f4080e7          	jalr	1524(ra) # 80004748 <initlock>
    8000415c:	01813083          	ld	ra,24(sp)
    80004160:	01013403          	ld	s0,16(sp)
    80004164:	0004ac23          	sw	zero,24(s1)
    80004168:	00813483          	ld	s1,8(sp)
    8000416c:	02010113          	addi	sp,sp,32
    80004170:	00008067          	ret

0000000080004174 <uartinit>:
    80004174:	ff010113          	addi	sp,sp,-16
    80004178:	00813423          	sd	s0,8(sp)
    8000417c:	01010413          	addi	s0,sp,16
    80004180:	100007b7          	lui	a5,0x10000
    80004184:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004188:	f8000713          	li	a4,-128
    8000418c:	00e781a3          	sb	a4,3(a5)
    80004190:	00300713          	li	a4,3
    80004194:	00e78023          	sb	a4,0(a5)
    80004198:	000780a3          	sb	zero,1(a5)
    8000419c:	00e781a3          	sb	a4,3(a5)
    800041a0:	00700693          	li	a3,7
    800041a4:	00d78123          	sb	a3,2(a5)
    800041a8:	00e780a3          	sb	a4,1(a5)
    800041ac:	00813403          	ld	s0,8(sp)
    800041b0:	01010113          	addi	sp,sp,16
    800041b4:	00008067          	ret

00000000800041b8 <uartputc>:
    800041b8:	00003797          	auipc	a5,0x3
    800041bc:	0507a783          	lw	a5,80(a5) # 80007208 <panicked>
    800041c0:	00078463          	beqz	a5,800041c8 <uartputc+0x10>
    800041c4:	0000006f          	j	800041c4 <uartputc+0xc>
    800041c8:	fd010113          	addi	sp,sp,-48
    800041cc:	02813023          	sd	s0,32(sp)
    800041d0:	00913c23          	sd	s1,24(sp)
    800041d4:	01213823          	sd	s2,16(sp)
    800041d8:	01313423          	sd	s3,8(sp)
    800041dc:	02113423          	sd	ra,40(sp)
    800041e0:	03010413          	addi	s0,sp,48
    800041e4:	00003917          	auipc	s2,0x3
    800041e8:	02c90913          	addi	s2,s2,44 # 80007210 <uart_tx_r>
    800041ec:	00093783          	ld	a5,0(s2)
    800041f0:	00003497          	auipc	s1,0x3
    800041f4:	02848493          	addi	s1,s1,40 # 80007218 <uart_tx_w>
    800041f8:	0004b703          	ld	a4,0(s1)
    800041fc:	02078693          	addi	a3,a5,32
    80004200:	00050993          	mv	s3,a0
    80004204:	02e69c63          	bne	a3,a4,8000423c <uartputc+0x84>
    80004208:	00001097          	auipc	ra,0x1
    8000420c:	834080e7          	jalr	-1996(ra) # 80004a3c <push_on>
    80004210:	00093783          	ld	a5,0(s2)
    80004214:	0004b703          	ld	a4,0(s1)
    80004218:	02078793          	addi	a5,a5,32
    8000421c:	00e79463          	bne	a5,a4,80004224 <uartputc+0x6c>
    80004220:	0000006f          	j	80004220 <uartputc+0x68>
    80004224:	00001097          	auipc	ra,0x1
    80004228:	88c080e7          	jalr	-1908(ra) # 80004ab0 <pop_on>
    8000422c:	00093783          	ld	a5,0(s2)
    80004230:	0004b703          	ld	a4,0(s1)
    80004234:	02078693          	addi	a3,a5,32
    80004238:	fce688e3          	beq	a3,a4,80004208 <uartputc+0x50>
    8000423c:	01f77693          	andi	a3,a4,31
    80004240:	00004597          	auipc	a1,0x4
    80004244:	26058593          	addi	a1,a1,608 # 800084a0 <uart_tx_buf>
    80004248:	00d586b3          	add	a3,a1,a3
    8000424c:	00170713          	addi	a4,a4,1
    80004250:	01368023          	sb	s3,0(a3)
    80004254:	00e4b023          	sd	a4,0(s1)
    80004258:	10000637          	lui	a2,0x10000
    8000425c:	02f71063          	bne	a4,a5,8000427c <uartputc+0xc4>
    80004260:	0340006f          	j	80004294 <uartputc+0xdc>
    80004264:	00074703          	lbu	a4,0(a4)
    80004268:	00f93023          	sd	a5,0(s2)
    8000426c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004270:	00093783          	ld	a5,0(s2)
    80004274:	0004b703          	ld	a4,0(s1)
    80004278:	00f70e63          	beq	a4,a5,80004294 <uartputc+0xdc>
    8000427c:	00564683          	lbu	a3,5(a2)
    80004280:	01f7f713          	andi	a4,a5,31
    80004284:	00e58733          	add	a4,a1,a4
    80004288:	0206f693          	andi	a3,a3,32
    8000428c:	00178793          	addi	a5,a5,1
    80004290:	fc069ae3          	bnez	a3,80004264 <uartputc+0xac>
    80004294:	02813083          	ld	ra,40(sp)
    80004298:	02013403          	ld	s0,32(sp)
    8000429c:	01813483          	ld	s1,24(sp)
    800042a0:	01013903          	ld	s2,16(sp)
    800042a4:	00813983          	ld	s3,8(sp)
    800042a8:	03010113          	addi	sp,sp,48
    800042ac:	00008067          	ret

00000000800042b0 <uartputc_sync>:
    800042b0:	ff010113          	addi	sp,sp,-16
    800042b4:	00813423          	sd	s0,8(sp)
    800042b8:	01010413          	addi	s0,sp,16
    800042bc:	00003717          	auipc	a4,0x3
    800042c0:	f4c72703          	lw	a4,-180(a4) # 80007208 <panicked>
    800042c4:	02071663          	bnez	a4,800042f0 <uartputc_sync+0x40>
    800042c8:	00050793          	mv	a5,a0
    800042cc:	100006b7          	lui	a3,0x10000
    800042d0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800042d4:	02077713          	andi	a4,a4,32
    800042d8:	fe070ce3          	beqz	a4,800042d0 <uartputc_sync+0x20>
    800042dc:	0ff7f793          	andi	a5,a5,255
    800042e0:	00f68023          	sb	a5,0(a3)
    800042e4:	00813403          	ld	s0,8(sp)
    800042e8:	01010113          	addi	sp,sp,16
    800042ec:	00008067          	ret
    800042f0:	0000006f          	j	800042f0 <uartputc_sync+0x40>

00000000800042f4 <uartstart>:
    800042f4:	ff010113          	addi	sp,sp,-16
    800042f8:	00813423          	sd	s0,8(sp)
    800042fc:	01010413          	addi	s0,sp,16
    80004300:	00003617          	auipc	a2,0x3
    80004304:	f1060613          	addi	a2,a2,-240 # 80007210 <uart_tx_r>
    80004308:	00003517          	auipc	a0,0x3
    8000430c:	f1050513          	addi	a0,a0,-240 # 80007218 <uart_tx_w>
    80004310:	00063783          	ld	a5,0(a2)
    80004314:	00053703          	ld	a4,0(a0)
    80004318:	04f70263          	beq	a4,a5,8000435c <uartstart+0x68>
    8000431c:	100005b7          	lui	a1,0x10000
    80004320:	00004817          	auipc	a6,0x4
    80004324:	18080813          	addi	a6,a6,384 # 800084a0 <uart_tx_buf>
    80004328:	01c0006f          	j	80004344 <uartstart+0x50>
    8000432c:	0006c703          	lbu	a4,0(a3)
    80004330:	00f63023          	sd	a5,0(a2)
    80004334:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004338:	00063783          	ld	a5,0(a2)
    8000433c:	00053703          	ld	a4,0(a0)
    80004340:	00f70e63          	beq	a4,a5,8000435c <uartstart+0x68>
    80004344:	01f7f713          	andi	a4,a5,31
    80004348:	00e806b3          	add	a3,a6,a4
    8000434c:	0055c703          	lbu	a4,5(a1)
    80004350:	00178793          	addi	a5,a5,1
    80004354:	02077713          	andi	a4,a4,32
    80004358:	fc071ae3          	bnez	a4,8000432c <uartstart+0x38>
    8000435c:	00813403          	ld	s0,8(sp)
    80004360:	01010113          	addi	sp,sp,16
    80004364:	00008067          	ret

0000000080004368 <uartgetc>:
    80004368:	ff010113          	addi	sp,sp,-16
    8000436c:	00813423          	sd	s0,8(sp)
    80004370:	01010413          	addi	s0,sp,16
    80004374:	10000737          	lui	a4,0x10000
    80004378:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000437c:	0017f793          	andi	a5,a5,1
    80004380:	00078c63          	beqz	a5,80004398 <uartgetc+0x30>
    80004384:	00074503          	lbu	a0,0(a4)
    80004388:	0ff57513          	andi	a0,a0,255
    8000438c:	00813403          	ld	s0,8(sp)
    80004390:	01010113          	addi	sp,sp,16
    80004394:	00008067          	ret
    80004398:	fff00513          	li	a0,-1
    8000439c:	ff1ff06f          	j	8000438c <uartgetc+0x24>

00000000800043a0 <uartintr>:
    800043a0:	100007b7          	lui	a5,0x10000
    800043a4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800043a8:	0017f793          	andi	a5,a5,1
    800043ac:	0a078463          	beqz	a5,80004454 <uartintr+0xb4>
    800043b0:	fe010113          	addi	sp,sp,-32
    800043b4:	00813823          	sd	s0,16(sp)
    800043b8:	00913423          	sd	s1,8(sp)
    800043bc:	00113c23          	sd	ra,24(sp)
    800043c0:	02010413          	addi	s0,sp,32
    800043c4:	100004b7          	lui	s1,0x10000
    800043c8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800043cc:	0ff57513          	andi	a0,a0,255
    800043d0:	fffff097          	auipc	ra,0xfffff
    800043d4:	534080e7          	jalr	1332(ra) # 80003904 <consoleintr>
    800043d8:	0054c783          	lbu	a5,5(s1)
    800043dc:	0017f793          	andi	a5,a5,1
    800043e0:	fe0794e3          	bnez	a5,800043c8 <uartintr+0x28>
    800043e4:	00003617          	auipc	a2,0x3
    800043e8:	e2c60613          	addi	a2,a2,-468 # 80007210 <uart_tx_r>
    800043ec:	00003517          	auipc	a0,0x3
    800043f0:	e2c50513          	addi	a0,a0,-468 # 80007218 <uart_tx_w>
    800043f4:	00063783          	ld	a5,0(a2)
    800043f8:	00053703          	ld	a4,0(a0)
    800043fc:	04f70263          	beq	a4,a5,80004440 <uartintr+0xa0>
    80004400:	100005b7          	lui	a1,0x10000
    80004404:	00004817          	auipc	a6,0x4
    80004408:	09c80813          	addi	a6,a6,156 # 800084a0 <uart_tx_buf>
    8000440c:	01c0006f          	j	80004428 <uartintr+0x88>
    80004410:	0006c703          	lbu	a4,0(a3)
    80004414:	00f63023          	sd	a5,0(a2)
    80004418:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000441c:	00063783          	ld	a5,0(a2)
    80004420:	00053703          	ld	a4,0(a0)
    80004424:	00f70e63          	beq	a4,a5,80004440 <uartintr+0xa0>
    80004428:	01f7f713          	andi	a4,a5,31
    8000442c:	00e806b3          	add	a3,a6,a4
    80004430:	0055c703          	lbu	a4,5(a1)
    80004434:	00178793          	addi	a5,a5,1
    80004438:	02077713          	andi	a4,a4,32
    8000443c:	fc071ae3          	bnez	a4,80004410 <uartintr+0x70>
    80004440:	01813083          	ld	ra,24(sp)
    80004444:	01013403          	ld	s0,16(sp)
    80004448:	00813483          	ld	s1,8(sp)
    8000444c:	02010113          	addi	sp,sp,32
    80004450:	00008067          	ret
    80004454:	00003617          	auipc	a2,0x3
    80004458:	dbc60613          	addi	a2,a2,-580 # 80007210 <uart_tx_r>
    8000445c:	00003517          	auipc	a0,0x3
    80004460:	dbc50513          	addi	a0,a0,-580 # 80007218 <uart_tx_w>
    80004464:	00063783          	ld	a5,0(a2)
    80004468:	00053703          	ld	a4,0(a0)
    8000446c:	04f70263          	beq	a4,a5,800044b0 <uartintr+0x110>
    80004470:	100005b7          	lui	a1,0x10000
    80004474:	00004817          	auipc	a6,0x4
    80004478:	02c80813          	addi	a6,a6,44 # 800084a0 <uart_tx_buf>
    8000447c:	01c0006f          	j	80004498 <uartintr+0xf8>
    80004480:	0006c703          	lbu	a4,0(a3)
    80004484:	00f63023          	sd	a5,0(a2)
    80004488:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000448c:	00063783          	ld	a5,0(a2)
    80004490:	00053703          	ld	a4,0(a0)
    80004494:	02f70063          	beq	a4,a5,800044b4 <uartintr+0x114>
    80004498:	01f7f713          	andi	a4,a5,31
    8000449c:	00e806b3          	add	a3,a6,a4
    800044a0:	0055c703          	lbu	a4,5(a1)
    800044a4:	00178793          	addi	a5,a5,1
    800044a8:	02077713          	andi	a4,a4,32
    800044ac:	fc071ae3          	bnez	a4,80004480 <uartintr+0xe0>
    800044b0:	00008067          	ret
    800044b4:	00008067          	ret

00000000800044b8 <kinit>:
    800044b8:	fc010113          	addi	sp,sp,-64
    800044bc:	02913423          	sd	s1,40(sp)
    800044c0:	fffff7b7          	lui	a5,0xfffff
    800044c4:	00005497          	auipc	s1,0x5
    800044c8:	00b48493          	addi	s1,s1,11 # 800094cf <end+0xfff>
    800044cc:	02813823          	sd	s0,48(sp)
    800044d0:	01313c23          	sd	s3,24(sp)
    800044d4:	00f4f4b3          	and	s1,s1,a5
    800044d8:	02113c23          	sd	ra,56(sp)
    800044dc:	03213023          	sd	s2,32(sp)
    800044e0:	01413823          	sd	s4,16(sp)
    800044e4:	01513423          	sd	s5,8(sp)
    800044e8:	04010413          	addi	s0,sp,64
    800044ec:	000017b7          	lui	a5,0x1
    800044f0:	01100993          	li	s3,17
    800044f4:	00f487b3          	add	a5,s1,a5
    800044f8:	01b99993          	slli	s3,s3,0x1b
    800044fc:	06f9e063          	bltu	s3,a5,8000455c <kinit+0xa4>
    80004500:	00004a97          	auipc	s5,0x4
    80004504:	fd0a8a93          	addi	s5,s5,-48 # 800084d0 <end>
    80004508:	0754ec63          	bltu	s1,s5,80004580 <kinit+0xc8>
    8000450c:	0734fa63          	bgeu	s1,s3,80004580 <kinit+0xc8>
    80004510:	00088a37          	lui	s4,0x88
    80004514:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004518:	00003917          	auipc	s2,0x3
    8000451c:	d0890913          	addi	s2,s2,-760 # 80007220 <kmem>
    80004520:	00ca1a13          	slli	s4,s4,0xc
    80004524:	0140006f          	j	80004538 <kinit+0x80>
    80004528:	000017b7          	lui	a5,0x1
    8000452c:	00f484b3          	add	s1,s1,a5
    80004530:	0554e863          	bltu	s1,s5,80004580 <kinit+0xc8>
    80004534:	0534f663          	bgeu	s1,s3,80004580 <kinit+0xc8>
    80004538:	00001637          	lui	a2,0x1
    8000453c:	00100593          	li	a1,1
    80004540:	00048513          	mv	a0,s1
    80004544:	00000097          	auipc	ra,0x0
    80004548:	5e4080e7          	jalr	1508(ra) # 80004b28 <__memset>
    8000454c:	00093783          	ld	a5,0(s2)
    80004550:	00f4b023          	sd	a5,0(s1)
    80004554:	00993023          	sd	s1,0(s2)
    80004558:	fd4498e3          	bne	s1,s4,80004528 <kinit+0x70>
    8000455c:	03813083          	ld	ra,56(sp)
    80004560:	03013403          	ld	s0,48(sp)
    80004564:	02813483          	ld	s1,40(sp)
    80004568:	02013903          	ld	s2,32(sp)
    8000456c:	01813983          	ld	s3,24(sp)
    80004570:	01013a03          	ld	s4,16(sp)
    80004574:	00813a83          	ld	s5,8(sp)
    80004578:	04010113          	addi	sp,sp,64
    8000457c:	00008067          	ret
    80004580:	00002517          	auipc	a0,0x2
    80004584:	ea850513          	addi	a0,a0,-344 # 80006428 <digits+0x18>
    80004588:	fffff097          	auipc	ra,0xfffff
    8000458c:	4b4080e7          	jalr	1204(ra) # 80003a3c <panic>

0000000080004590 <freerange>:
    80004590:	fc010113          	addi	sp,sp,-64
    80004594:	000017b7          	lui	a5,0x1
    80004598:	02913423          	sd	s1,40(sp)
    8000459c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800045a0:	009504b3          	add	s1,a0,s1
    800045a4:	fffff537          	lui	a0,0xfffff
    800045a8:	02813823          	sd	s0,48(sp)
    800045ac:	02113c23          	sd	ra,56(sp)
    800045b0:	03213023          	sd	s2,32(sp)
    800045b4:	01313c23          	sd	s3,24(sp)
    800045b8:	01413823          	sd	s4,16(sp)
    800045bc:	01513423          	sd	s5,8(sp)
    800045c0:	01613023          	sd	s6,0(sp)
    800045c4:	04010413          	addi	s0,sp,64
    800045c8:	00a4f4b3          	and	s1,s1,a0
    800045cc:	00f487b3          	add	a5,s1,a5
    800045d0:	06f5e463          	bltu	a1,a5,80004638 <freerange+0xa8>
    800045d4:	00004a97          	auipc	s5,0x4
    800045d8:	efca8a93          	addi	s5,s5,-260 # 800084d0 <end>
    800045dc:	0954e263          	bltu	s1,s5,80004660 <freerange+0xd0>
    800045e0:	01100993          	li	s3,17
    800045e4:	01b99993          	slli	s3,s3,0x1b
    800045e8:	0734fc63          	bgeu	s1,s3,80004660 <freerange+0xd0>
    800045ec:	00058a13          	mv	s4,a1
    800045f0:	00003917          	auipc	s2,0x3
    800045f4:	c3090913          	addi	s2,s2,-976 # 80007220 <kmem>
    800045f8:	00002b37          	lui	s6,0x2
    800045fc:	0140006f          	j	80004610 <freerange+0x80>
    80004600:	000017b7          	lui	a5,0x1
    80004604:	00f484b3          	add	s1,s1,a5
    80004608:	0554ec63          	bltu	s1,s5,80004660 <freerange+0xd0>
    8000460c:	0534fa63          	bgeu	s1,s3,80004660 <freerange+0xd0>
    80004610:	00001637          	lui	a2,0x1
    80004614:	00100593          	li	a1,1
    80004618:	00048513          	mv	a0,s1
    8000461c:	00000097          	auipc	ra,0x0
    80004620:	50c080e7          	jalr	1292(ra) # 80004b28 <__memset>
    80004624:	00093703          	ld	a4,0(s2)
    80004628:	016487b3          	add	a5,s1,s6
    8000462c:	00e4b023          	sd	a4,0(s1)
    80004630:	00993023          	sd	s1,0(s2)
    80004634:	fcfa76e3          	bgeu	s4,a5,80004600 <freerange+0x70>
    80004638:	03813083          	ld	ra,56(sp)
    8000463c:	03013403          	ld	s0,48(sp)
    80004640:	02813483          	ld	s1,40(sp)
    80004644:	02013903          	ld	s2,32(sp)
    80004648:	01813983          	ld	s3,24(sp)
    8000464c:	01013a03          	ld	s4,16(sp)
    80004650:	00813a83          	ld	s5,8(sp)
    80004654:	00013b03          	ld	s6,0(sp)
    80004658:	04010113          	addi	sp,sp,64
    8000465c:	00008067          	ret
    80004660:	00002517          	auipc	a0,0x2
    80004664:	dc850513          	addi	a0,a0,-568 # 80006428 <digits+0x18>
    80004668:	fffff097          	auipc	ra,0xfffff
    8000466c:	3d4080e7          	jalr	980(ra) # 80003a3c <panic>

0000000080004670 <kfree>:
    80004670:	fe010113          	addi	sp,sp,-32
    80004674:	00813823          	sd	s0,16(sp)
    80004678:	00113c23          	sd	ra,24(sp)
    8000467c:	00913423          	sd	s1,8(sp)
    80004680:	02010413          	addi	s0,sp,32
    80004684:	03451793          	slli	a5,a0,0x34
    80004688:	04079c63          	bnez	a5,800046e0 <kfree+0x70>
    8000468c:	00004797          	auipc	a5,0x4
    80004690:	e4478793          	addi	a5,a5,-444 # 800084d0 <end>
    80004694:	00050493          	mv	s1,a0
    80004698:	04f56463          	bltu	a0,a5,800046e0 <kfree+0x70>
    8000469c:	01100793          	li	a5,17
    800046a0:	01b79793          	slli	a5,a5,0x1b
    800046a4:	02f57e63          	bgeu	a0,a5,800046e0 <kfree+0x70>
    800046a8:	00001637          	lui	a2,0x1
    800046ac:	00100593          	li	a1,1
    800046b0:	00000097          	auipc	ra,0x0
    800046b4:	478080e7          	jalr	1144(ra) # 80004b28 <__memset>
    800046b8:	00003797          	auipc	a5,0x3
    800046bc:	b6878793          	addi	a5,a5,-1176 # 80007220 <kmem>
    800046c0:	0007b703          	ld	a4,0(a5)
    800046c4:	01813083          	ld	ra,24(sp)
    800046c8:	01013403          	ld	s0,16(sp)
    800046cc:	00e4b023          	sd	a4,0(s1)
    800046d0:	0097b023          	sd	s1,0(a5)
    800046d4:	00813483          	ld	s1,8(sp)
    800046d8:	02010113          	addi	sp,sp,32
    800046dc:	00008067          	ret
    800046e0:	00002517          	auipc	a0,0x2
    800046e4:	d4850513          	addi	a0,a0,-696 # 80006428 <digits+0x18>
    800046e8:	fffff097          	auipc	ra,0xfffff
    800046ec:	354080e7          	jalr	852(ra) # 80003a3c <panic>

00000000800046f0 <kalloc>:
    800046f0:	fe010113          	addi	sp,sp,-32
    800046f4:	00813823          	sd	s0,16(sp)
    800046f8:	00913423          	sd	s1,8(sp)
    800046fc:	00113c23          	sd	ra,24(sp)
    80004700:	02010413          	addi	s0,sp,32
    80004704:	00003797          	auipc	a5,0x3
    80004708:	b1c78793          	addi	a5,a5,-1252 # 80007220 <kmem>
    8000470c:	0007b483          	ld	s1,0(a5)
    80004710:	02048063          	beqz	s1,80004730 <kalloc+0x40>
    80004714:	0004b703          	ld	a4,0(s1)
    80004718:	00001637          	lui	a2,0x1
    8000471c:	00500593          	li	a1,5
    80004720:	00048513          	mv	a0,s1
    80004724:	00e7b023          	sd	a4,0(a5)
    80004728:	00000097          	auipc	ra,0x0
    8000472c:	400080e7          	jalr	1024(ra) # 80004b28 <__memset>
    80004730:	01813083          	ld	ra,24(sp)
    80004734:	01013403          	ld	s0,16(sp)
    80004738:	00048513          	mv	a0,s1
    8000473c:	00813483          	ld	s1,8(sp)
    80004740:	02010113          	addi	sp,sp,32
    80004744:	00008067          	ret

0000000080004748 <initlock>:
    80004748:	ff010113          	addi	sp,sp,-16
    8000474c:	00813423          	sd	s0,8(sp)
    80004750:	01010413          	addi	s0,sp,16
    80004754:	00813403          	ld	s0,8(sp)
    80004758:	00b53423          	sd	a1,8(a0)
    8000475c:	00052023          	sw	zero,0(a0)
    80004760:	00053823          	sd	zero,16(a0)
    80004764:	01010113          	addi	sp,sp,16
    80004768:	00008067          	ret

000000008000476c <acquire>:
    8000476c:	fe010113          	addi	sp,sp,-32
    80004770:	00813823          	sd	s0,16(sp)
    80004774:	00913423          	sd	s1,8(sp)
    80004778:	00113c23          	sd	ra,24(sp)
    8000477c:	01213023          	sd	s2,0(sp)
    80004780:	02010413          	addi	s0,sp,32
    80004784:	00050493          	mv	s1,a0
    80004788:	10002973          	csrr	s2,sstatus
    8000478c:	100027f3          	csrr	a5,sstatus
    80004790:	ffd7f793          	andi	a5,a5,-3
    80004794:	10079073          	csrw	sstatus,a5
    80004798:	fffff097          	auipc	ra,0xfffff
    8000479c:	8ec080e7          	jalr	-1812(ra) # 80003084 <mycpu>
    800047a0:	07852783          	lw	a5,120(a0)
    800047a4:	06078e63          	beqz	a5,80004820 <acquire+0xb4>
    800047a8:	fffff097          	auipc	ra,0xfffff
    800047ac:	8dc080e7          	jalr	-1828(ra) # 80003084 <mycpu>
    800047b0:	07852783          	lw	a5,120(a0)
    800047b4:	0004a703          	lw	a4,0(s1)
    800047b8:	0017879b          	addiw	a5,a5,1
    800047bc:	06f52c23          	sw	a5,120(a0)
    800047c0:	04071063          	bnez	a4,80004800 <acquire+0x94>
    800047c4:	00100713          	li	a4,1
    800047c8:	00070793          	mv	a5,a4
    800047cc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800047d0:	0007879b          	sext.w	a5,a5
    800047d4:	fe079ae3          	bnez	a5,800047c8 <acquire+0x5c>
    800047d8:	0ff0000f          	fence
    800047dc:	fffff097          	auipc	ra,0xfffff
    800047e0:	8a8080e7          	jalr	-1880(ra) # 80003084 <mycpu>
    800047e4:	01813083          	ld	ra,24(sp)
    800047e8:	01013403          	ld	s0,16(sp)
    800047ec:	00a4b823          	sd	a0,16(s1)
    800047f0:	00013903          	ld	s2,0(sp)
    800047f4:	00813483          	ld	s1,8(sp)
    800047f8:	02010113          	addi	sp,sp,32
    800047fc:	00008067          	ret
    80004800:	0104b903          	ld	s2,16(s1)
    80004804:	fffff097          	auipc	ra,0xfffff
    80004808:	880080e7          	jalr	-1920(ra) # 80003084 <mycpu>
    8000480c:	faa91ce3          	bne	s2,a0,800047c4 <acquire+0x58>
    80004810:	00002517          	auipc	a0,0x2
    80004814:	c2050513          	addi	a0,a0,-992 # 80006430 <digits+0x20>
    80004818:	fffff097          	auipc	ra,0xfffff
    8000481c:	224080e7          	jalr	548(ra) # 80003a3c <panic>
    80004820:	00195913          	srli	s2,s2,0x1
    80004824:	fffff097          	auipc	ra,0xfffff
    80004828:	860080e7          	jalr	-1952(ra) # 80003084 <mycpu>
    8000482c:	00197913          	andi	s2,s2,1
    80004830:	07252e23          	sw	s2,124(a0)
    80004834:	f75ff06f          	j	800047a8 <acquire+0x3c>

0000000080004838 <release>:
    80004838:	fe010113          	addi	sp,sp,-32
    8000483c:	00813823          	sd	s0,16(sp)
    80004840:	00113c23          	sd	ra,24(sp)
    80004844:	00913423          	sd	s1,8(sp)
    80004848:	01213023          	sd	s2,0(sp)
    8000484c:	02010413          	addi	s0,sp,32
    80004850:	00052783          	lw	a5,0(a0)
    80004854:	00079a63          	bnez	a5,80004868 <release+0x30>
    80004858:	00002517          	auipc	a0,0x2
    8000485c:	be050513          	addi	a0,a0,-1056 # 80006438 <digits+0x28>
    80004860:	fffff097          	auipc	ra,0xfffff
    80004864:	1dc080e7          	jalr	476(ra) # 80003a3c <panic>
    80004868:	01053903          	ld	s2,16(a0)
    8000486c:	00050493          	mv	s1,a0
    80004870:	fffff097          	auipc	ra,0xfffff
    80004874:	814080e7          	jalr	-2028(ra) # 80003084 <mycpu>
    80004878:	fea910e3          	bne	s2,a0,80004858 <release+0x20>
    8000487c:	0004b823          	sd	zero,16(s1)
    80004880:	0ff0000f          	fence
    80004884:	0f50000f          	fence	iorw,ow
    80004888:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000488c:	ffffe097          	auipc	ra,0xffffe
    80004890:	7f8080e7          	jalr	2040(ra) # 80003084 <mycpu>
    80004894:	100027f3          	csrr	a5,sstatus
    80004898:	0027f793          	andi	a5,a5,2
    8000489c:	04079a63          	bnez	a5,800048f0 <release+0xb8>
    800048a0:	07852783          	lw	a5,120(a0)
    800048a4:	02f05e63          	blez	a5,800048e0 <release+0xa8>
    800048a8:	fff7871b          	addiw	a4,a5,-1
    800048ac:	06e52c23          	sw	a4,120(a0)
    800048b0:	00071c63          	bnez	a4,800048c8 <release+0x90>
    800048b4:	07c52783          	lw	a5,124(a0)
    800048b8:	00078863          	beqz	a5,800048c8 <release+0x90>
    800048bc:	100027f3          	csrr	a5,sstatus
    800048c0:	0027e793          	ori	a5,a5,2
    800048c4:	10079073          	csrw	sstatus,a5
    800048c8:	01813083          	ld	ra,24(sp)
    800048cc:	01013403          	ld	s0,16(sp)
    800048d0:	00813483          	ld	s1,8(sp)
    800048d4:	00013903          	ld	s2,0(sp)
    800048d8:	02010113          	addi	sp,sp,32
    800048dc:	00008067          	ret
    800048e0:	00002517          	auipc	a0,0x2
    800048e4:	b7850513          	addi	a0,a0,-1160 # 80006458 <digits+0x48>
    800048e8:	fffff097          	auipc	ra,0xfffff
    800048ec:	154080e7          	jalr	340(ra) # 80003a3c <panic>
    800048f0:	00002517          	auipc	a0,0x2
    800048f4:	b5050513          	addi	a0,a0,-1200 # 80006440 <digits+0x30>
    800048f8:	fffff097          	auipc	ra,0xfffff
    800048fc:	144080e7          	jalr	324(ra) # 80003a3c <panic>

0000000080004900 <holding>:
    80004900:	00052783          	lw	a5,0(a0)
    80004904:	00079663          	bnez	a5,80004910 <holding+0x10>
    80004908:	00000513          	li	a0,0
    8000490c:	00008067          	ret
    80004910:	fe010113          	addi	sp,sp,-32
    80004914:	00813823          	sd	s0,16(sp)
    80004918:	00913423          	sd	s1,8(sp)
    8000491c:	00113c23          	sd	ra,24(sp)
    80004920:	02010413          	addi	s0,sp,32
    80004924:	01053483          	ld	s1,16(a0)
    80004928:	ffffe097          	auipc	ra,0xffffe
    8000492c:	75c080e7          	jalr	1884(ra) # 80003084 <mycpu>
    80004930:	01813083          	ld	ra,24(sp)
    80004934:	01013403          	ld	s0,16(sp)
    80004938:	40a48533          	sub	a0,s1,a0
    8000493c:	00153513          	seqz	a0,a0
    80004940:	00813483          	ld	s1,8(sp)
    80004944:	02010113          	addi	sp,sp,32
    80004948:	00008067          	ret

000000008000494c <push_off>:
    8000494c:	fe010113          	addi	sp,sp,-32
    80004950:	00813823          	sd	s0,16(sp)
    80004954:	00113c23          	sd	ra,24(sp)
    80004958:	00913423          	sd	s1,8(sp)
    8000495c:	02010413          	addi	s0,sp,32
    80004960:	100024f3          	csrr	s1,sstatus
    80004964:	100027f3          	csrr	a5,sstatus
    80004968:	ffd7f793          	andi	a5,a5,-3
    8000496c:	10079073          	csrw	sstatus,a5
    80004970:	ffffe097          	auipc	ra,0xffffe
    80004974:	714080e7          	jalr	1812(ra) # 80003084 <mycpu>
    80004978:	07852783          	lw	a5,120(a0)
    8000497c:	02078663          	beqz	a5,800049a8 <push_off+0x5c>
    80004980:	ffffe097          	auipc	ra,0xffffe
    80004984:	704080e7          	jalr	1796(ra) # 80003084 <mycpu>
    80004988:	07852783          	lw	a5,120(a0)
    8000498c:	01813083          	ld	ra,24(sp)
    80004990:	01013403          	ld	s0,16(sp)
    80004994:	0017879b          	addiw	a5,a5,1
    80004998:	06f52c23          	sw	a5,120(a0)
    8000499c:	00813483          	ld	s1,8(sp)
    800049a0:	02010113          	addi	sp,sp,32
    800049a4:	00008067          	ret
    800049a8:	0014d493          	srli	s1,s1,0x1
    800049ac:	ffffe097          	auipc	ra,0xffffe
    800049b0:	6d8080e7          	jalr	1752(ra) # 80003084 <mycpu>
    800049b4:	0014f493          	andi	s1,s1,1
    800049b8:	06952e23          	sw	s1,124(a0)
    800049bc:	fc5ff06f          	j	80004980 <push_off+0x34>

00000000800049c0 <pop_off>:
    800049c0:	ff010113          	addi	sp,sp,-16
    800049c4:	00813023          	sd	s0,0(sp)
    800049c8:	00113423          	sd	ra,8(sp)
    800049cc:	01010413          	addi	s0,sp,16
    800049d0:	ffffe097          	auipc	ra,0xffffe
    800049d4:	6b4080e7          	jalr	1716(ra) # 80003084 <mycpu>
    800049d8:	100027f3          	csrr	a5,sstatus
    800049dc:	0027f793          	andi	a5,a5,2
    800049e0:	04079663          	bnez	a5,80004a2c <pop_off+0x6c>
    800049e4:	07852783          	lw	a5,120(a0)
    800049e8:	02f05a63          	blez	a5,80004a1c <pop_off+0x5c>
    800049ec:	fff7871b          	addiw	a4,a5,-1
    800049f0:	06e52c23          	sw	a4,120(a0)
    800049f4:	00071c63          	bnez	a4,80004a0c <pop_off+0x4c>
    800049f8:	07c52783          	lw	a5,124(a0)
    800049fc:	00078863          	beqz	a5,80004a0c <pop_off+0x4c>
    80004a00:	100027f3          	csrr	a5,sstatus
    80004a04:	0027e793          	ori	a5,a5,2
    80004a08:	10079073          	csrw	sstatus,a5
    80004a0c:	00813083          	ld	ra,8(sp)
    80004a10:	00013403          	ld	s0,0(sp)
    80004a14:	01010113          	addi	sp,sp,16
    80004a18:	00008067          	ret
    80004a1c:	00002517          	auipc	a0,0x2
    80004a20:	a3c50513          	addi	a0,a0,-1476 # 80006458 <digits+0x48>
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	018080e7          	jalr	24(ra) # 80003a3c <panic>
    80004a2c:	00002517          	auipc	a0,0x2
    80004a30:	a1450513          	addi	a0,a0,-1516 # 80006440 <digits+0x30>
    80004a34:	fffff097          	auipc	ra,0xfffff
    80004a38:	008080e7          	jalr	8(ra) # 80003a3c <panic>

0000000080004a3c <push_on>:
    80004a3c:	fe010113          	addi	sp,sp,-32
    80004a40:	00813823          	sd	s0,16(sp)
    80004a44:	00113c23          	sd	ra,24(sp)
    80004a48:	00913423          	sd	s1,8(sp)
    80004a4c:	02010413          	addi	s0,sp,32
    80004a50:	100024f3          	csrr	s1,sstatus
    80004a54:	100027f3          	csrr	a5,sstatus
    80004a58:	0027e793          	ori	a5,a5,2
    80004a5c:	10079073          	csrw	sstatus,a5
    80004a60:	ffffe097          	auipc	ra,0xffffe
    80004a64:	624080e7          	jalr	1572(ra) # 80003084 <mycpu>
    80004a68:	07852783          	lw	a5,120(a0)
    80004a6c:	02078663          	beqz	a5,80004a98 <push_on+0x5c>
    80004a70:	ffffe097          	auipc	ra,0xffffe
    80004a74:	614080e7          	jalr	1556(ra) # 80003084 <mycpu>
    80004a78:	07852783          	lw	a5,120(a0)
    80004a7c:	01813083          	ld	ra,24(sp)
    80004a80:	01013403          	ld	s0,16(sp)
    80004a84:	0017879b          	addiw	a5,a5,1
    80004a88:	06f52c23          	sw	a5,120(a0)
    80004a8c:	00813483          	ld	s1,8(sp)
    80004a90:	02010113          	addi	sp,sp,32
    80004a94:	00008067          	ret
    80004a98:	0014d493          	srli	s1,s1,0x1
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	5e8080e7          	jalr	1512(ra) # 80003084 <mycpu>
    80004aa4:	0014f493          	andi	s1,s1,1
    80004aa8:	06952e23          	sw	s1,124(a0)
    80004aac:	fc5ff06f          	j	80004a70 <push_on+0x34>

0000000080004ab0 <pop_on>:
    80004ab0:	ff010113          	addi	sp,sp,-16
    80004ab4:	00813023          	sd	s0,0(sp)
    80004ab8:	00113423          	sd	ra,8(sp)
    80004abc:	01010413          	addi	s0,sp,16
    80004ac0:	ffffe097          	auipc	ra,0xffffe
    80004ac4:	5c4080e7          	jalr	1476(ra) # 80003084 <mycpu>
    80004ac8:	100027f3          	csrr	a5,sstatus
    80004acc:	0027f793          	andi	a5,a5,2
    80004ad0:	04078463          	beqz	a5,80004b18 <pop_on+0x68>
    80004ad4:	07852783          	lw	a5,120(a0)
    80004ad8:	02f05863          	blez	a5,80004b08 <pop_on+0x58>
    80004adc:	fff7879b          	addiw	a5,a5,-1
    80004ae0:	06f52c23          	sw	a5,120(a0)
    80004ae4:	07853783          	ld	a5,120(a0)
    80004ae8:	00079863          	bnez	a5,80004af8 <pop_on+0x48>
    80004aec:	100027f3          	csrr	a5,sstatus
    80004af0:	ffd7f793          	andi	a5,a5,-3
    80004af4:	10079073          	csrw	sstatus,a5
    80004af8:	00813083          	ld	ra,8(sp)
    80004afc:	00013403          	ld	s0,0(sp)
    80004b00:	01010113          	addi	sp,sp,16
    80004b04:	00008067          	ret
    80004b08:	00002517          	auipc	a0,0x2
    80004b0c:	97850513          	addi	a0,a0,-1672 # 80006480 <digits+0x70>
    80004b10:	fffff097          	auipc	ra,0xfffff
    80004b14:	f2c080e7          	jalr	-212(ra) # 80003a3c <panic>
    80004b18:	00002517          	auipc	a0,0x2
    80004b1c:	94850513          	addi	a0,a0,-1720 # 80006460 <digits+0x50>
    80004b20:	fffff097          	auipc	ra,0xfffff
    80004b24:	f1c080e7          	jalr	-228(ra) # 80003a3c <panic>

0000000080004b28 <__memset>:
    80004b28:	ff010113          	addi	sp,sp,-16
    80004b2c:	00813423          	sd	s0,8(sp)
    80004b30:	01010413          	addi	s0,sp,16
    80004b34:	1a060e63          	beqz	a2,80004cf0 <__memset+0x1c8>
    80004b38:	40a007b3          	neg	a5,a0
    80004b3c:	0077f793          	andi	a5,a5,7
    80004b40:	00778693          	addi	a3,a5,7
    80004b44:	00b00813          	li	a6,11
    80004b48:	0ff5f593          	andi	a1,a1,255
    80004b4c:	fff6071b          	addiw	a4,a2,-1
    80004b50:	1b06e663          	bltu	a3,a6,80004cfc <__memset+0x1d4>
    80004b54:	1cd76463          	bltu	a4,a3,80004d1c <__memset+0x1f4>
    80004b58:	1a078e63          	beqz	a5,80004d14 <__memset+0x1ec>
    80004b5c:	00b50023          	sb	a1,0(a0)
    80004b60:	00100713          	li	a4,1
    80004b64:	1ae78463          	beq	a5,a4,80004d0c <__memset+0x1e4>
    80004b68:	00b500a3          	sb	a1,1(a0)
    80004b6c:	00200713          	li	a4,2
    80004b70:	1ae78a63          	beq	a5,a4,80004d24 <__memset+0x1fc>
    80004b74:	00b50123          	sb	a1,2(a0)
    80004b78:	00300713          	li	a4,3
    80004b7c:	18e78463          	beq	a5,a4,80004d04 <__memset+0x1dc>
    80004b80:	00b501a3          	sb	a1,3(a0)
    80004b84:	00400713          	li	a4,4
    80004b88:	1ae78263          	beq	a5,a4,80004d2c <__memset+0x204>
    80004b8c:	00b50223          	sb	a1,4(a0)
    80004b90:	00500713          	li	a4,5
    80004b94:	1ae78063          	beq	a5,a4,80004d34 <__memset+0x20c>
    80004b98:	00b502a3          	sb	a1,5(a0)
    80004b9c:	00700713          	li	a4,7
    80004ba0:	18e79e63          	bne	a5,a4,80004d3c <__memset+0x214>
    80004ba4:	00b50323          	sb	a1,6(a0)
    80004ba8:	00700e93          	li	t4,7
    80004bac:	00859713          	slli	a4,a1,0x8
    80004bb0:	00e5e733          	or	a4,a1,a4
    80004bb4:	01059e13          	slli	t3,a1,0x10
    80004bb8:	01c76e33          	or	t3,a4,t3
    80004bbc:	01859313          	slli	t1,a1,0x18
    80004bc0:	006e6333          	or	t1,t3,t1
    80004bc4:	02059893          	slli	a7,a1,0x20
    80004bc8:	40f60e3b          	subw	t3,a2,a5
    80004bcc:	011368b3          	or	a7,t1,a7
    80004bd0:	02859813          	slli	a6,a1,0x28
    80004bd4:	0108e833          	or	a6,a7,a6
    80004bd8:	03059693          	slli	a3,a1,0x30
    80004bdc:	003e589b          	srliw	a7,t3,0x3
    80004be0:	00d866b3          	or	a3,a6,a3
    80004be4:	03859713          	slli	a4,a1,0x38
    80004be8:	00389813          	slli	a6,a7,0x3
    80004bec:	00f507b3          	add	a5,a0,a5
    80004bf0:	00e6e733          	or	a4,a3,a4
    80004bf4:	000e089b          	sext.w	a7,t3
    80004bf8:	00f806b3          	add	a3,a6,a5
    80004bfc:	00e7b023          	sd	a4,0(a5)
    80004c00:	00878793          	addi	a5,a5,8
    80004c04:	fed79ce3          	bne	a5,a3,80004bfc <__memset+0xd4>
    80004c08:	ff8e7793          	andi	a5,t3,-8
    80004c0c:	0007871b          	sext.w	a4,a5
    80004c10:	01d787bb          	addw	a5,a5,t4
    80004c14:	0ce88e63          	beq	a7,a4,80004cf0 <__memset+0x1c8>
    80004c18:	00f50733          	add	a4,a0,a5
    80004c1c:	00b70023          	sb	a1,0(a4)
    80004c20:	0017871b          	addiw	a4,a5,1
    80004c24:	0cc77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c28:	00e50733          	add	a4,a0,a4
    80004c2c:	00b70023          	sb	a1,0(a4)
    80004c30:	0027871b          	addiw	a4,a5,2
    80004c34:	0ac77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c38:	00e50733          	add	a4,a0,a4
    80004c3c:	00b70023          	sb	a1,0(a4)
    80004c40:	0037871b          	addiw	a4,a5,3
    80004c44:	0ac77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c48:	00e50733          	add	a4,a0,a4
    80004c4c:	00b70023          	sb	a1,0(a4)
    80004c50:	0047871b          	addiw	a4,a5,4
    80004c54:	08c77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c58:	00e50733          	add	a4,a0,a4
    80004c5c:	00b70023          	sb	a1,0(a4)
    80004c60:	0057871b          	addiw	a4,a5,5
    80004c64:	08c77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c68:	00e50733          	add	a4,a0,a4
    80004c6c:	00b70023          	sb	a1,0(a4)
    80004c70:	0067871b          	addiw	a4,a5,6
    80004c74:	06c77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c78:	00e50733          	add	a4,a0,a4
    80004c7c:	00b70023          	sb	a1,0(a4)
    80004c80:	0077871b          	addiw	a4,a5,7
    80004c84:	06c77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c88:	00e50733          	add	a4,a0,a4
    80004c8c:	00b70023          	sb	a1,0(a4)
    80004c90:	0087871b          	addiw	a4,a5,8
    80004c94:	04c77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004c98:	00e50733          	add	a4,a0,a4
    80004c9c:	00b70023          	sb	a1,0(a4)
    80004ca0:	0097871b          	addiw	a4,a5,9
    80004ca4:	04c77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004ca8:	00e50733          	add	a4,a0,a4
    80004cac:	00b70023          	sb	a1,0(a4)
    80004cb0:	00a7871b          	addiw	a4,a5,10
    80004cb4:	02c77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004cb8:	00e50733          	add	a4,a0,a4
    80004cbc:	00b70023          	sb	a1,0(a4)
    80004cc0:	00b7871b          	addiw	a4,a5,11
    80004cc4:	02c77663          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004cc8:	00e50733          	add	a4,a0,a4
    80004ccc:	00b70023          	sb	a1,0(a4)
    80004cd0:	00c7871b          	addiw	a4,a5,12
    80004cd4:	00c77e63          	bgeu	a4,a2,80004cf0 <__memset+0x1c8>
    80004cd8:	00e50733          	add	a4,a0,a4
    80004cdc:	00b70023          	sb	a1,0(a4)
    80004ce0:	00d7879b          	addiw	a5,a5,13
    80004ce4:	00c7f663          	bgeu	a5,a2,80004cf0 <__memset+0x1c8>
    80004ce8:	00f507b3          	add	a5,a0,a5
    80004cec:	00b78023          	sb	a1,0(a5)
    80004cf0:	00813403          	ld	s0,8(sp)
    80004cf4:	01010113          	addi	sp,sp,16
    80004cf8:	00008067          	ret
    80004cfc:	00b00693          	li	a3,11
    80004d00:	e55ff06f          	j	80004b54 <__memset+0x2c>
    80004d04:	00300e93          	li	t4,3
    80004d08:	ea5ff06f          	j	80004bac <__memset+0x84>
    80004d0c:	00100e93          	li	t4,1
    80004d10:	e9dff06f          	j	80004bac <__memset+0x84>
    80004d14:	00000e93          	li	t4,0
    80004d18:	e95ff06f          	j	80004bac <__memset+0x84>
    80004d1c:	00000793          	li	a5,0
    80004d20:	ef9ff06f          	j	80004c18 <__memset+0xf0>
    80004d24:	00200e93          	li	t4,2
    80004d28:	e85ff06f          	j	80004bac <__memset+0x84>
    80004d2c:	00400e93          	li	t4,4
    80004d30:	e7dff06f          	j	80004bac <__memset+0x84>
    80004d34:	00500e93          	li	t4,5
    80004d38:	e75ff06f          	j	80004bac <__memset+0x84>
    80004d3c:	00600e93          	li	t4,6
    80004d40:	e6dff06f          	j	80004bac <__memset+0x84>

0000000080004d44 <__memmove>:
    80004d44:	ff010113          	addi	sp,sp,-16
    80004d48:	00813423          	sd	s0,8(sp)
    80004d4c:	01010413          	addi	s0,sp,16
    80004d50:	0e060863          	beqz	a2,80004e40 <__memmove+0xfc>
    80004d54:	fff6069b          	addiw	a3,a2,-1
    80004d58:	0006881b          	sext.w	a6,a3
    80004d5c:	0ea5e863          	bltu	a1,a0,80004e4c <__memmove+0x108>
    80004d60:	00758713          	addi	a4,a1,7
    80004d64:	00a5e7b3          	or	a5,a1,a0
    80004d68:	40a70733          	sub	a4,a4,a0
    80004d6c:	0077f793          	andi	a5,a5,7
    80004d70:	00f73713          	sltiu	a4,a4,15
    80004d74:	00174713          	xori	a4,a4,1
    80004d78:	0017b793          	seqz	a5,a5
    80004d7c:	00e7f7b3          	and	a5,a5,a4
    80004d80:	10078863          	beqz	a5,80004e90 <__memmove+0x14c>
    80004d84:	00900793          	li	a5,9
    80004d88:	1107f463          	bgeu	a5,a6,80004e90 <__memmove+0x14c>
    80004d8c:	0036581b          	srliw	a6,a2,0x3
    80004d90:	fff8081b          	addiw	a6,a6,-1
    80004d94:	02081813          	slli	a6,a6,0x20
    80004d98:	01d85893          	srli	a7,a6,0x1d
    80004d9c:	00858813          	addi	a6,a1,8
    80004da0:	00058793          	mv	a5,a1
    80004da4:	00050713          	mv	a4,a0
    80004da8:	01088833          	add	a6,a7,a6
    80004dac:	0007b883          	ld	a7,0(a5)
    80004db0:	00878793          	addi	a5,a5,8
    80004db4:	00870713          	addi	a4,a4,8
    80004db8:	ff173c23          	sd	a7,-8(a4)
    80004dbc:	ff0798e3          	bne	a5,a6,80004dac <__memmove+0x68>
    80004dc0:	ff867713          	andi	a4,a2,-8
    80004dc4:	02071793          	slli	a5,a4,0x20
    80004dc8:	0207d793          	srli	a5,a5,0x20
    80004dcc:	00f585b3          	add	a1,a1,a5
    80004dd0:	40e686bb          	subw	a3,a3,a4
    80004dd4:	00f507b3          	add	a5,a0,a5
    80004dd8:	06e60463          	beq	a2,a4,80004e40 <__memmove+0xfc>
    80004ddc:	0005c703          	lbu	a4,0(a1)
    80004de0:	00e78023          	sb	a4,0(a5)
    80004de4:	04068e63          	beqz	a3,80004e40 <__memmove+0xfc>
    80004de8:	0015c603          	lbu	a2,1(a1)
    80004dec:	00100713          	li	a4,1
    80004df0:	00c780a3          	sb	a2,1(a5)
    80004df4:	04e68663          	beq	a3,a4,80004e40 <__memmove+0xfc>
    80004df8:	0025c603          	lbu	a2,2(a1)
    80004dfc:	00200713          	li	a4,2
    80004e00:	00c78123          	sb	a2,2(a5)
    80004e04:	02e68e63          	beq	a3,a4,80004e40 <__memmove+0xfc>
    80004e08:	0035c603          	lbu	a2,3(a1)
    80004e0c:	00300713          	li	a4,3
    80004e10:	00c781a3          	sb	a2,3(a5)
    80004e14:	02e68663          	beq	a3,a4,80004e40 <__memmove+0xfc>
    80004e18:	0045c603          	lbu	a2,4(a1)
    80004e1c:	00400713          	li	a4,4
    80004e20:	00c78223          	sb	a2,4(a5)
    80004e24:	00e68e63          	beq	a3,a4,80004e40 <__memmove+0xfc>
    80004e28:	0055c603          	lbu	a2,5(a1)
    80004e2c:	00500713          	li	a4,5
    80004e30:	00c782a3          	sb	a2,5(a5)
    80004e34:	00e68663          	beq	a3,a4,80004e40 <__memmove+0xfc>
    80004e38:	0065c703          	lbu	a4,6(a1)
    80004e3c:	00e78323          	sb	a4,6(a5)
    80004e40:	00813403          	ld	s0,8(sp)
    80004e44:	01010113          	addi	sp,sp,16
    80004e48:	00008067          	ret
    80004e4c:	02061713          	slli	a4,a2,0x20
    80004e50:	02075713          	srli	a4,a4,0x20
    80004e54:	00e587b3          	add	a5,a1,a4
    80004e58:	f0f574e3          	bgeu	a0,a5,80004d60 <__memmove+0x1c>
    80004e5c:	02069613          	slli	a2,a3,0x20
    80004e60:	02065613          	srli	a2,a2,0x20
    80004e64:	fff64613          	not	a2,a2
    80004e68:	00e50733          	add	a4,a0,a4
    80004e6c:	00c78633          	add	a2,a5,a2
    80004e70:	fff7c683          	lbu	a3,-1(a5)
    80004e74:	fff78793          	addi	a5,a5,-1
    80004e78:	fff70713          	addi	a4,a4,-1
    80004e7c:	00d70023          	sb	a3,0(a4)
    80004e80:	fec798e3          	bne	a5,a2,80004e70 <__memmove+0x12c>
    80004e84:	00813403          	ld	s0,8(sp)
    80004e88:	01010113          	addi	sp,sp,16
    80004e8c:	00008067          	ret
    80004e90:	02069713          	slli	a4,a3,0x20
    80004e94:	02075713          	srli	a4,a4,0x20
    80004e98:	00170713          	addi	a4,a4,1
    80004e9c:	00e50733          	add	a4,a0,a4
    80004ea0:	00050793          	mv	a5,a0
    80004ea4:	0005c683          	lbu	a3,0(a1)
    80004ea8:	00178793          	addi	a5,a5,1
    80004eac:	00158593          	addi	a1,a1,1
    80004eb0:	fed78fa3          	sb	a3,-1(a5)
    80004eb4:	fee798e3          	bne	a5,a4,80004ea4 <__memmove+0x160>
    80004eb8:	f89ff06f          	j	80004e40 <__memmove+0xfc>

0000000080004ebc <__mem_free>:
    80004ebc:	ff010113          	addi	sp,sp,-16
    80004ec0:	00813423          	sd	s0,8(sp)
    80004ec4:	01010413          	addi	s0,sp,16
    80004ec8:	00002597          	auipc	a1,0x2
    80004ecc:	36058593          	addi	a1,a1,864 # 80007228 <freep>
    80004ed0:	0005b783          	ld	a5,0(a1)
    80004ed4:	ff050693          	addi	a3,a0,-16
    80004ed8:	0007b703          	ld	a4,0(a5)
    80004edc:	00d7fc63          	bgeu	a5,a3,80004ef4 <__mem_free+0x38>
    80004ee0:	00e6ee63          	bltu	a3,a4,80004efc <__mem_free+0x40>
    80004ee4:	00e7fc63          	bgeu	a5,a4,80004efc <__mem_free+0x40>
    80004ee8:	00070793          	mv	a5,a4
    80004eec:	0007b703          	ld	a4,0(a5)
    80004ef0:	fed7e8e3          	bltu	a5,a3,80004ee0 <__mem_free+0x24>
    80004ef4:	fee7eae3          	bltu	a5,a4,80004ee8 <__mem_free+0x2c>
    80004ef8:	fee6f8e3          	bgeu	a3,a4,80004ee8 <__mem_free+0x2c>
    80004efc:	ff852803          	lw	a6,-8(a0)
    80004f00:	02081613          	slli	a2,a6,0x20
    80004f04:	01c65613          	srli	a2,a2,0x1c
    80004f08:	00c68633          	add	a2,a3,a2
    80004f0c:	02c70a63          	beq	a4,a2,80004f40 <__mem_free+0x84>
    80004f10:	fee53823          	sd	a4,-16(a0)
    80004f14:	0087a503          	lw	a0,8(a5)
    80004f18:	02051613          	slli	a2,a0,0x20
    80004f1c:	01c65613          	srli	a2,a2,0x1c
    80004f20:	00c78633          	add	a2,a5,a2
    80004f24:	04c68263          	beq	a3,a2,80004f68 <__mem_free+0xac>
    80004f28:	00813403          	ld	s0,8(sp)
    80004f2c:	00d7b023          	sd	a3,0(a5)
    80004f30:	00f5b023          	sd	a5,0(a1)
    80004f34:	00000513          	li	a0,0
    80004f38:	01010113          	addi	sp,sp,16
    80004f3c:	00008067          	ret
    80004f40:	00872603          	lw	a2,8(a4)
    80004f44:	00073703          	ld	a4,0(a4)
    80004f48:	0106083b          	addw	a6,a2,a6
    80004f4c:	ff052c23          	sw	a6,-8(a0)
    80004f50:	fee53823          	sd	a4,-16(a0)
    80004f54:	0087a503          	lw	a0,8(a5)
    80004f58:	02051613          	slli	a2,a0,0x20
    80004f5c:	01c65613          	srli	a2,a2,0x1c
    80004f60:	00c78633          	add	a2,a5,a2
    80004f64:	fcc692e3          	bne	a3,a2,80004f28 <__mem_free+0x6c>
    80004f68:	00813403          	ld	s0,8(sp)
    80004f6c:	0105053b          	addw	a0,a0,a6
    80004f70:	00a7a423          	sw	a0,8(a5)
    80004f74:	00e7b023          	sd	a4,0(a5)
    80004f78:	00f5b023          	sd	a5,0(a1)
    80004f7c:	00000513          	li	a0,0
    80004f80:	01010113          	addi	sp,sp,16
    80004f84:	00008067          	ret

0000000080004f88 <__mem_alloc>:
    80004f88:	fc010113          	addi	sp,sp,-64
    80004f8c:	02813823          	sd	s0,48(sp)
    80004f90:	02913423          	sd	s1,40(sp)
    80004f94:	03213023          	sd	s2,32(sp)
    80004f98:	01513423          	sd	s5,8(sp)
    80004f9c:	02113c23          	sd	ra,56(sp)
    80004fa0:	01313c23          	sd	s3,24(sp)
    80004fa4:	01413823          	sd	s4,16(sp)
    80004fa8:	01613023          	sd	s6,0(sp)
    80004fac:	04010413          	addi	s0,sp,64
    80004fb0:	00002a97          	auipc	s5,0x2
    80004fb4:	278a8a93          	addi	s5,s5,632 # 80007228 <freep>
    80004fb8:	00f50913          	addi	s2,a0,15
    80004fbc:	000ab683          	ld	a3,0(s5)
    80004fc0:	00495913          	srli	s2,s2,0x4
    80004fc4:	0019049b          	addiw	s1,s2,1
    80004fc8:	00048913          	mv	s2,s1
    80004fcc:	0c068c63          	beqz	a3,800050a4 <__mem_alloc+0x11c>
    80004fd0:	0006b503          	ld	a0,0(a3)
    80004fd4:	00852703          	lw	a4,8(a0)
    80004fd8:	10977063          	bgeu	a4,s1,800050d8 <__mem_alloc+0x150>
    80004fdc:	000017b7          	lui	a5,0x1
    80004fe0:	0009099b          	sext.w	s3,s2
    80004fe4:	0af4e863          	bltu	s1,a5,80005094 <__mem_alloc+0x10c>
    80004fe8:	02099a13          	slli	s4,s3,0x20
    80004fec:	01ca5a13          	srli	s4,s4,0x1c
    80004ff0:	fff00b13          	li	s6,-1
    80004ff4:	0100006f          	j	80005004 <__mem_alloc+0x7c>
    80004ff8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80004ffc:	00852703          	lw	a4,8(a0)
    80005000:	04977463          	bgeu	a4,s1,80005048 <__mem_alloc+0xc0>
    80005004:	00050793          	mv	a5,a0
    80005008:	fea698e3          	bne	a3,a0,80004ff8 <__mem_alloc+0x70>
    8000500c:	000a0513          	mv	a0,s4
    80005010:	00000097          	auipc	ra,0x0
    80005014:	1f0080e7          	jalr	496(ra) # 80005200 <kvmincrease>
    80005018:	00050793          	mv	a5,a0
    8000501c:	01050513          	addi	a0,a0,16
    80005020:	07678e63          	beq	a5,s6,8000509c <__mem_alloc+0x114>
    80005024:	0137a423          	sw	s3,8(a5)
    80005028:	00000097          	auipc	ra,0x0
    8000502c:	e94080e7          	jalr	-364(ra) # 80004ebc <__mem_free>
    80005030:	000ab783          	ld	a5,0(s5)
    80005034:	06078463          	beqz	a5,8000509c <__mem_alloc+0x114>
    80005038:	0007b503          	ld	a0,0(a5)
    8000503c:	00078693          	mv	a3,a5
    80005040:	00852703          	lw	a4,8(a0)
    80005044:	fc9760e3          	bltu	a4,s1,80005004 <__mem_alloc+0x7c>
    80005048:	08e48263          	beq	s1,a4,800050cc <__mem_alloc+0x144>
    8000504c:	4127073b          	subw	a4,a4,s2
    80005050:	02071693          	slli	a3,a4,0x20
    80005054:	01c6d693          	srli	a3,a3,0x1c
    80005058:	00e52423          	sw	a4,8(a0)
    8000505c:	00d50533          	add	a0,a0,a3
    80005060:	01252423          	sw	s2,8(a0)
    80005064:	00fab023          	sd	a5,0(s5)
    80005068:	01050513          	addi	a0,a0,16
    8000506c:	03813083          	ld	ra,56(sp)
    80005070:	03013403          	ld	s0,48(sp)
    80005074:	02813483          	ld	s1,40(sp)
    80005078:	02013903          	ld	s2,32(sp)
    8000507c:	01813983          	ld	s3,24(sp)
    80005080:	01013a03          	ld	s4,16(sp)
    80005084:	00813a83          	ld	s5,8(sp)
    80005088:	00013b03          	ld	s6,0(sp)
    8000508c:	04010113          	addi	sp,sp,64
    80005090:	00008067          	ret
    80005094:	000019b7          	lui	s3,0x1
    80005098:	f51ff06f          	j	80004fe8 <__mem_alloc+0x60>
    8000509c:	00000513          	li	a0,0
    800050a0:	fcdff06f          	j	8000506c <__mem_alloc+0xe4>
    800050a4:	00003797          	auipc	a5,0x3
    800050a8:	41c78793          	addi	a5,a5,1052 # 800084c0 <base>
    800050ac:	00078513          	mv	a0,a5
    800050b0:	00fab023          	sd	a5,0(s5)
    800050b4:	00f7b023          	sd	a5,0(a5)
    800050b8:	00000713          	li	a4,0
    800050bc:	00003797          	auipc	a5,0x3
    800050c0:	4007a623          	sw	zero,1036(a5) # 800084c8 <base+0x8>
    800050c4:	00050693          	mv	a3,a0
    800050c8:	f11ff06f          	j	80004fd8 <__mem_alloc+0x50>
    800050cc:	00053703          	ld	a4,0(a0)
    800050d0:	00e7b023          	sd	a4,0(a5)
    800050d4:	f91ff06f          	j	80005064 <__mem_alloc+0xdc>
    800050d8:	00068793          	mv	a5,a3
    800050dc:	f6dff06f          	j	80005048 <__mem_alloc+0xc0>

00000000800050e0 <__putc>:
    800050e0:	fe010113          	addi	sp,sp,-32
    800050e4:	00813823          	sd	s0,16(sp)
    800050e8:	00113c23          	sd	ra,24(sp)
    800050ec:	02010413          	addi	s0,sp,32
    800050f0:	00050793          	mv	a5,a0
    800050f4:	fef40593          	addi	a1,s0,-17
    800050f8:	00100613          	li	a2,1
    800050fc:	00000513          	li	a0,0
    80005100:	fef407a3          	sb	a5,-17(s0)
    80005104:	fffff097          	auipc	ra,0xfffff
    80005108:	918080e7          	jalr	-1768(ra) # 80003a1c <console_write>
    8000510c:	01813083          	ld	ra,24(sp)
    80005110:	01013403          	ld	s0,16(sp)
    80005114:	02010113          	addi	sp,sp,32
    80005118:	00008067          	ret

000000008000511c <__getc>:
    8000511c:	fe010113          	addi	sp,sp,-32
    80005120:	00813823          	sd	s0,16(sp)
    80005124:	00113c23          	sd	ra,24(sp)
    80005128:	02010413          	addi	s0,sp,32
    8000512c:	fe840593          	addi	a1,s0,-24
    80005130:	00100613          	li	a2,1
    80005134:	00000513          	li	a0,0
    80005138:	fffff097          	auipc	ra,0xfffff
    8000513c:	8c4080e7          	jalr	-1852(ra) # 800039fc <console_read>
    80005140:	fe844503          	lbu	a0,-24(s0)
    80005144:	01813083          	ld	ra,24(sp)
    80005148:	01013403          	ld	s0,16(sp)
    8000514c:	02010113          	addi	sp,sp,32
    80005150:	00008067          	ret

0000000080005154 <console_handler>:
    80005154:	fe010113          	addi	sp,sp,-32
    80005158:	00813823          	sd	s0,16(sp)
    8000515c:	00113c23          	sd	ra,24(sp)
    80005160:	00913423          	sd	s1,8(sp)
    80005164:	02010413          	addi	s0,sp,32
    80005168:	14202773          	csrr	a4,scause
    8000516c:	100027f3          	csrr	a5,sstatus
    80005170:	0027f793          	andi	a5,a5,2
    80005174:	06079e63          	bnez	a5,800051f0 <console_handler+0x9c>
    80005178:	00074c63          	bltz	a4,80005190 <console_handler+0x3c>
    8000517c:	01813083          	ld	ra,24(sp)
    80005180:	01013403          	ld	s0,16(sp)
    80005184:	00813483          	ld	s1,8(sp)
    80005188:	02010113          	addi	sp,sp,32
    8000518c:	00008067          	ret
    80005190:	0ff77713          	andi	a4,a4,255
    80005194:	00900793          	li	a5,9
    80005198:	fef712e3          	bne	a4,a5,8000517c <console_handler+0x28>
    8000519c:	ffffe097          	auipc	ra,0xffffe
    800051a0:	4b8080e7          	jalr	1208(ra) # 80003654 <plic_claim>
    800051a4:	00a00793          	li	a5,10
    800051a8:	00050493          	mv	s1,a0
    800051ac:	02f50c63          	beq	a0,a5,800051e4 <console_handler+0x90>
    800051b0:	fc0506e3          	beqz	a0,8000517c <console_handler+0x28>
    800051b4:	00050593          	mv	a1,a0
    800051b8:	00001517          	auipc	a0,0x1
    800051bc:	1d050513          	addi	a0,a0,464 # 80006388 <kvmincrease+0x1188>
    800051c0:	fffff097          	auipc	ra,0xfffff
    800051c4:	8d8080e7          	jalr	-1832(ra) # 80003a98 <__printf>
    800051c8:	01013403          	ld	s0,16(sp)
    800051cc:	01813083          	ld	ra,24(sp)
    800051d0:	00048513          	mv	a0,s1
    800051d4:	00813483          	ld	s1,8(sp)
    800051d8:	02010113          	addi	sp,sp,32
    800051dc:	ffffe317          	auipc	t1,0xffffe
    800051e0:	4b030067          	jr	1200(t1) # 8000368c <plic_complete>
    800051e4:	fffff097          	auipc	ra,0xfffff
    800051e8:	1bc080e7          	jalr	444(ra) # 800043a0 <uartintr>
    800051ec:	fddff06f          	j	800051c8 <console_handler+0x74>
    800051f0:	00001517          	auipc	a0,0x1
    800051f4:	29850513          	addi	a0,a0,664 # 80006488 <digits+0x78>
    800051f8:	fffff097          	auipc	ra,0xfffff
    800051fc:	844080e7          	jalr	-1980(ra) # 80003a3c <panic>

0000000080005200 <kvmincrease>:
    80005200:	fe010113          	addi	sp,sp,-32
    80005204:	01213023          	sd	s2,0(sp)
    80005208:	00001937          	lui	s2,0x1
    8000520c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80005210:	00813823          	sd	s0,16(sp)
    80005214:	00113c23          	sd	ra,24(sp)
    80005218:	00913423          	sd	s1,8(sp)
    8000521c:	02010413          	addi	s0,sp,32
    80005220:	01250933          	add	s2,a0,s2
    80005224:	00c95913          	srli	s2,s2,0xc
    80005228:	02090863          	beqz	s2,80005258 <kvmincrease+0x58>
    8000522c:	00000493          	li	s1,0
    80005230:	00148493          	addi	s1,s1,1
    80005234:	fffff097          	auipc	ra,0xfffff
    80005238:	4bc080e7          	jalr	1212(ra) # 800046f0 <kalloc>
    8000523c:	fe991ae3          	bne	s2,s1,80005230 <kvmincrease+0x30>
    80005240:	01813083          	ld	ra,24(sp)
    80005244:	01013403          	ld	s0,16(sp)
    80005248:	00813483          	ld	s1,8(sp)
    8000524c:	00013903          	ld	s2,0(sp)
    80005250:	02010113          	addi	sp,sp,32
    80005254:	00008067          	ret
    80005258:	01813083          	ld	ra,24(sp)
    8000525c:	01013403          	ld	s0,16(sp)
    80005260:	00813483          	ld	s1,8(sp)
    80005264:	00013903          	ld	s2,0(sp)
    80005268:	00000513          	li	a0,0
    8000526c:	02010113          	addi	sp,sp,32
    80005270:	00008067          	ret
	...
