
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	bf813103          	ld	sp,-1032(sp) # 80005bf8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	29c020ef          	jal	ra,800022b8 <start>

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
    800010a4:	6fc000ef          	jal	ra,800017a0 <_ZN5Riscv20handleSupervisorTrapEv>

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
    80001154:	00003097          	auipc	ra,0x3
    80001158:	2f4080e7          	jalr	756(ra) # 80004448 <__mem_alloc>
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
    8000117c:	00003097          	auipc	ra,0x3
    80001180:	200080e7          	jalr	512(ra) # 8000437c <__mem_free>
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
    800012d0:	00003097          	auipc	ra,0x3
    800012d4:	30c080e7          	jalr	780(ra) # 800045dc <__getc>
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
    800012f8:	00003097          	auipc	ra,0x3
    800012fc:	2a8080e7          	jalr	680(ra) # 800045a0 <__putc>
    80001300:	00813083          	ld	ra,8(sp)
    80001304:	00013403          	ld	s0,0(sp)
    80001308:	01010113          	addi	sp,sp,16
    8000130c:	00008067          	ret

0000000080001310 <_ZN7_thread12createThreadEPFvvEPv>:

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
    8000133c:	358080e7          	jalr	856(ra) # 80001690 <_Znwm>
    80001340:	00050493          	mv	s1,a0
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
            context({
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false)
    80001344:	01253023          	sd	s2,0(a0)
    80001348:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    8000134c:	00090a63          	beqz	s2,80001360 <_ZN7_thread12createThreadEPFvvEPv+0x50>
    80001350:	00008537          	lui	a0,0x8
    80001354:	00000097          	auipc	ra,0x0
    80001358:	364080e7          	jalr	868(ra) # 800016b8 <_Znam>
    8000135c:	0080006f          	j	80001364 <_ZN7_thread12createThreadEPFvvEPv+0x54>
    80001360:	00000513          	li	a0,0
            finished(false)
    80001364:	00a4b823          	sd	a0,16(s1)
    80001368:	00000797          	auipc	a5,0x0
    8000136c:	0a078793          	addi	a5,a5,160 # 80001408 <_ZN7_thread13threadWrapperEv>
    80001370:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001374:	02050463          	beqz	a0,8000139c <_ZN7_thread12createThreadEPFvvEPv+0x8c>
    80001378:	000087b7          	lui	a5,0x8
    8000137c:	00f507b3          	add	a5,a0,a5
            finished(false)
    80001380:	02f4b023          	sd	a5,32(s1)
    80001384:	02048823          	sb	zero,48(s1)
    {
        if (body != nullptr) { Scheduler::put(this); }
    80001388:	02090c63          	beqz	s2,800013c0 <_ZN7_thread12createThreadEPFvvEPv+0xb0>
    8000138c:	00048513          	mv	a0,s1
    80001390:	00000097          	auipc	ra,0x0
    80001394:	5e0080e7          	jalr	1504(ra) # 80001970 <_ZN9Scheduler3putEP7_thread>
    80001398:	0280006f          	j	800013c0 <_ZN7_thread12createThreadEPFvvEPv+0xb0>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    8000139c:	00000793          	li	a5,0
    800013a0:	fe1ff06f          	j	80001380 <_ZN7_thread12createThreadEPFvvEPv+0x70>
    800013a4:	00050913          	mv	s2,a0
    800013a8:	00048513          	mv	a0,s1
    800013ac:	00000097          	auipc	ra,0x0
    800013b0:	334080e7          	jalr	820(ra) # 800016e0 <_ZdlPv>
    800013b4:	00090513          	mv	a0,s2
    800013b8:	00006097          	auipc	ra,0x6
    800013bc:	990080e7          	jalr	-1648(ra) # 80006d48 <_Unwind_Resume>
    Scheduler::put(newThread);
    800013c0:	00048513          	mv	a0,s1
    800013c4:	00000097          	auipc	ra,0x0
    800013c8:	5ac080e7          	jalr	1452(ra) # 80001970 <_ZN9Scheduler3putEP7_thread>
    return newThread;
}
    800013cc:	00048513          	mv	a0,s1
    800013d0:	02813083          	ld	ra,40(sp)
    800013d4:	02013403          	ld	s0,32(sp)
    800013d8:	01813483          	ld	s1,24(sp)
    800013dc:	01013903          	ld	s2,16(sp)
    800013e0:	00813983          	ld	s3,8(sp)
    800013e4:	03010113          	addi	sp,sp,48
    800013e8:	00008067          	ret

00000000800013ec <_ZN7_thread5yieldEv>:

void _thread::yield()
{
    800013ec:	ff010113          	addi	sp,sp,-16
    800013f0:	00813423          	sd	s0,8(sp)
    800013f4:	01010413          	addi	s0,sp,16
    __asm__ volatile ("ecall");
    800013f8:	00000073          	ecall
}
    800013fc:	00813403          	ld	s0,8(sp)
    80001400:	01010113          	addi	sp,sp,16
    80001404:	00008067          	ret

0000000080001408 <_ZN7_thread13threadWrapperEv>:

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    80001408:	fe010113          	addi	sp,sp,-32
    8000140c:	00113c23          	sd	ra,24(sp)
    80001410:	00813823          	sd	s0,16(sp)
    80001414:	00913423          	sd	s1,8(sp)
    80001418:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    8000141c:	00000097          	auipc	ra,0x0
    80001420:	364080e7          	jalr	868(ra) # 80001780 <_ZN5Riscv10popSppSpieEv>
    running->body();
    80001424:	00005497          	auipc	s1,0x5
    80001428:	82c48493          	addi	s1,s1,-2004 # 80005c50 <_ZN7_thread7runningE>
    8000142c:	0004b783          	ld	a5,0(s1)
    80001430:	0007b783          	ld	a5,0(a5) # 8000 <_entry-0x7fff8000>
    80001434:	000780e7          	jalr	a5
    running->setFinished(true);
    80001438:	0004b783          	ld	a5,0(s1)
    void setFinished(bool value) { finished = value; }
    8000143c:	00100713          	li	a4,1
    80001440:	02e78823          	sb	a4,48(a5)
    _thread::yield();
    80001444:	00000097          	auipc	ra,0x0
    80001448:	fa8080e7          	jalr	-88(ra) # 800013ec <_ZN7_thread5yieldEv>
}
    8000144c:	01813083          	ld	ra,24(sp)
    80001450:	01013403          	ld	s0,16(sp)
    80001454:	00813483          	ld	s1,8(sp)
    80001458:	02010113          	addi	sp,sp,32
    8000145c:	00008067          	ret

0000000080001460 <_ZN7_thread8dispatchEv>:
{
    80001460:	fe010113          	addi	sp,sp,-32
    80001464:	00113c23          	sd	ra,24(sp)
    80001468:	00813823          	sd	s0,16(sp)
    8000146c:	00913423          	sd	s1,8(sp)
    80001470:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001474:	00004497          	auipc	s1,0x4
    80001478:	7dc4b483          	ld	s1,2012(s1) # 80005c50 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    8000147c:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished()) { Scheduler::put(old); }
    80001480:	02078c63          	beqz	a5,800014b8 <_ZN7_thread8dispatchEv+0x58>
    running = Scheduler::get();
    80001484:	00000097          	auipc	ra,0x0
    80001488:	484080e7          	jalr	1156(ra) # 80001908 <_ZN9Scheduler3getEv>
    8000148c:	00004797          	auipc	a5,0x4
    80001490:	7ca7b223          	sd	a0,1988(a5) # 80005c50 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    80001494:	01850593          	addi	a1,a0,24 # 8018 <_entry-0x7fff7fe8>
    80001498:	01848513          	addi	a0,s1,24
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	c94080e7          	jalr	-876(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800014a4:	01813083          	ld	ra,24(sp)
    800014a8:	01013403          	ld	s0,16(sp)
    800014ac:	00813483          	ld	s1,8(sp)
    800014b0:	02010113          	addi	sp,sp,32
    800014b4:	00008067          	ret
    if (!old->isFinished()) { Scheduler::put(old); }
    800014b8:	00048513          	mv	a0,s1
    800014bc:	00000097          	auipc	ra,0x0
    800014c0:	4b4080e7          	jalr	1204(ra) # 80001970 <_ZN9Scheduler3putEP7_thread>
    800014c4:	fc1ff06f          	j	80001484 <_ZN7_thread8dispatchEv+0x24>

00000000800014c8 <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014c8:	ff010113          	addi	sp,sp,-16
    800014cc:	00113423          	sd	ra,8(sp)
    800014d0:	00813023          	sd	s0,0(sp)
    800014d4:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    800014d8:	00004797          	auipc	a5,0x4
    800014dc:	7787b783          	ld	a5,1912(a5) # 80005c50 <_ZN7_thread7runningE>
    800014e0:	00100713          	li	a4,1
    800014e4:	02e78823          	sb	a4,48(a5)
    _thread::running->setFinished(true);
    _thread::dispatch();
    800014e8:	00000097          	auipc	ra,0x0
    800014ec:	f78080e7          	jalr	-136(ra) # 80001460 <_ZN7_thread8dispatchEv>
    return 0;
}
    800014f0:	00000513          	li	a0,0
    800014f4:	00813083          	ld	ra,8(sp)
    800014f8:	00013403          	ld	s0,0(sp)
    800014fc:	01010113          	addi	sp,sp,16
    80001500:	00008067          	ret

0000000080001504 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001504:	fe010113          	addi	sp,sp,-32
    80001508:	00113c23          	sd	ra,24(sp)
    8000150c:	00813823          	sd	s0,16(sp)
    80001510:	00913423          	sd	s1,8(sp)
    80001514:	01213023          	sd	s2,0(sp)
    80001518:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    8000151c:	00004517          	auipc	a0,0x4
    80001520:	ae450513          	addi	a0,a0,-1308 # 80005000 <kvmincrease+0x940>
    80001524:	00001097          	auipc	ra,0x1
    80001528:	ac4080e7          	jalr	-1340(ra) # 80001fe8 <_Z11printStringPKc>
    int test = getc() - '0';
    8000152c:	00000097          	auipc	ra,0x0
    80001530:	d94080e7          	jalr	-620(ra) # 800012c0 <_Z4getcv>
    80001534:	0005091b          	sext.w	s2,a0
    80001538:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	d84080e7          	jalr	-636(ra) # 800012c0 <_Z4getcv>
            printString("Nije navedeno da je zadatak 2 implementiran\n");
            return;
        }
    }

    if (test >= 3 && test <= 4) {
    80001544:	fcd9071b          	addiw	a4,s2,-51
    80001548:	00100793          	li	a5,1
    8000154c:	04e7f263          	bgeu	a5,a4,80001590 <_Z8userMainv+0x8c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001550:	fcb9091b          	addiw	s2,s2,-53
    80001554:	00100793          	li	a5,1
    80001558:	0727f063          	bgeu	a5,s2,800015b8 <_Z8userMainv+0xb4>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    8000155c:	00600793          	li	a5,6
    80001560:	0697c663          	blt	a5,s1,800015cc <_Z8userMainv+0xc8>
    80001564:	00300793          	li	a5,3
    80001568:	02f4dc63          	bge	s1,a5,800015a0 <_Z8userMainv+0x9c>
    8000156c:	00100793          	li	a5,1
    80001570:	08f48463          	beq	s1,a5,800015f8 <_Z8userMainv+0xf4>
    80001574:	00200793          	li	a5,2
    80001578:	08f49e63          	bne	s1,a5,80001614 <_Z8userMainv+0x110>
#endif
            break;
        case 2:
#if LEVEL_2_IMPLEMENTED == 1
//            Threads_CPP_API_test();
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000157c:	00004517          	auipc	a0,0x4
    80001580:	b4450513          	addi	a0,a0,-1212 # 800050c0 <kvmincrease+0xa00>
    80001584:	00001097          	auipc	ra,0x1
    80001588:	a64080e7          	jalr	-1436(ra) # 80001fe8 <_Z11printStringPKc>
#endif
            break;
    8000158c:	0140006f          	j	800015a0 <_Z8userMainv+0x9c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
    80001590:	00004517          	auipc	a0,0x4
    80001594:	a9050513          	addi	a0,a0,-1392 # 80005020 <kvmincrease+0x960>
    80001598:	00001097          	auipc	ra,0x1
    8000159c:	a50080e7          	jalr	-1456(ra) # 80001fe8 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800015a0:	01813083          	ld	ra,24(sp)
    800015a4:	01013403          	ld	s0,16(sp)
    800015a8:	00813483          	ld	s1,8(sp)
    800015ac:	00013903          	ld	s2,0(sp)
    800015b0:	02010113          	addi	sp,sp,32
    800015b4:	00008067          	ret
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015b8:	00004517          	auipc	a0,0x4
    800015bc:	a9850513          	addi	a0,a0,-1384 # 80005050 <kvmincrease+0x990>
    800015c0:	00001097          	auipc	ra,0x1
    800015c4:	a28080e7          	jalr	-1496(ra) # 80001fe8 <_Z11printStringPKc>
            return;
    800015c8:	fd9ff06f          	j	800015a0 <_Z8userMainv+0x9c>
    switch (test) {
    800015cc:	00700793          	li	a5,7
    800015d0:	04f49263          	bne	s1,a5,80001614 <_Z8userMainv+0x110>
            printString("Test se nije uspesno zavrsio\n");
    800015d4:	00004517          	auipc	a0,0x4
    800015d8:	b2c50513          	addi	a0,a0,-1236 # 80005100 <kvmincrease+0xa40>
    800015dc:	00001097          	auipc	ra,0x1
    800015e0:	a0c080e7          	jalr	-1524(ra) # 80001fe8 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800015e4:	00004517          	auipc	a0,0x4
    800015e8:	b3c50513          	addi	a0,a0,-1220 # 80005120 <kvmincrease+0xa60>
    800015ec:	00001097          	auipc	ra,0x1
    800015f0:	9fc080e7          	jalr	-1540(ra) # 80001fe8 <_Z11printStringPKc>
            break;
    800015f4:	fadff06f          	j	800015a0 <_Z8userMainv+0x9c>
            Threads_C_API_test();
    800015f8:	00001097          	auipc	ra,0x1
    800015fc:	8f4080e7          	jalr	-1804(ra) # 80001eec <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001600:	00004517          	auipc	a0,0x4
    80001604:	a8050513          	addi	a0,a0,-1408 # 80005080 <kvmincrease+0x9c0>
    80001608:	00001097          	auipc	ra,0x1
    8000160c:	9e0080e7          	jalr	-1568(ra) # 80001fe8 <_Z11printStringPKc>
            break;
    80001610:	f91ff06f          	j	800015a0 <_Z8userMainv+0x9c>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001614:	00004517          	auipc	a0,0x4
    80001618:	b6450513          	addi	a0,a0,-1180 # 80005178 <kvmincrease+0xab8>
    8000161c:	00001097          	auipc	ra,0x1
    80001620:	9cc080e7          	jalr	-1588(ra) # 80001fe8 <_Z11printStringPKc>
    80001624:	f7dff06f          	j	800015a0 <_Z8userMainv+0x9c>

0000000080001628 <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    80001628:	fe010113          	addi	sp,sp,-32
    8000162c:	00113c23          	sd	ra,24(sp)
    80001630:	00813823          	sd	s0,16(sp)
    80001634:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80001638:	00004797          	auipc	a5,0x4
    8000163c:	5b87b783          	ld	a5,1464(a5) # 80005bf0 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001640:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    80001644:	00000613          	li	a2,0
    80001648:	00000593          	li	a1,0
    8000164c:	fe840513          	addi	a0,s0,-24
    80001650:	00000097          	auipc	ra,0x0
    80001654:	b44080e7          	jalr	-1212(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    80001658:	00004797          	auipc	a5,0x4
    8000165c:	5907b783          	ld	a5,1424(a5) # 80005be8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001660:	fe843703          	ld	a4,-24(s0)
    80001664:	00e7b023          	sd	a4,0(a5)

    // promena rezima

    // uposleno cekanje

    userMain();
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	e9c080e7          	jalr	-356(ra) # 80001504 <_Z8userMainv>
    printString("Finished\n");
    80001670:	00004517          	auipc	a0,0x4
    80001674:	b3050513          	addi	a0,a0,-1232 # 800051a0 <kvmincrease+0xae0>
    80001678:	00001097          	auipc	ra,0x1
    8000167c:	970080e7          	jalr	-1680(ra) # 80001fe8 <_Z11printStringPKc>
}
    80001680:	01813083          	ld	ra,24(sp)
    80001684:	01013403          	ld	s0,16(sp)
    80001688:	02010113          	addi	sp,sp,32
    8000168c:	00008067          	ret

0000000080001690 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001690:	ff010113          	addi	sp,sp,-16
    80001694:	00113423          	sd	ra,8(sp)
    80001698:	00813023          	sd	s0,0(sp)
    8000169c:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016a0:	00003097          	auipc	ra,0x3
    800016a4:	da8080e7          	jalr	-600(ra) # 80004448 <__mem_alloc>
}
    800016a8:	00813083          	ld	ra,8(sp)
    800016ac:	00013403          	ld	s0,0(sp)
    800016b0:	01010113          	addi	sp,sp,16
    800016b4:	00008067          	ret

00000000800016b8 <_Znam>:

void *operator new[](size_t n)
{
    800016b8:	ff010113          	addi	sp,sp,-16
    800016bc:	00113423          	sd	ra,8(sp)
    800016c0:	00813023          	sd	s0,0(sp)
    800016c4:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016c8:	00003097          	auipc	ra,0x3
    800016cc:	d80080e7          	jalr	-640(ra) # 80004448 <__mem_alloc>
}
    800016d0:	00813083          	ld	ra,8(sp)
    800016d4:	00013403          	ld	s0,0(sp)
    800016d8:	01010113          	addi	sp,sp,16
    800016dc:	00008067          	ret

00000000800016e0 <_ZdlPv>:

void operator delete(void *p)
{
    800016e0:	ff010113          	addi	sp,sp,-16
    800016e4:	00113423          	sd	ra,8(sp)
    800016e8:	00813023          	sd	s0,0(sp)
    800016ec:	01010413          	addi	s0,sp,16
    __mem_free(p);
    800016f0:	00003097          	auipc	ra,0x3
    800016f4:	c8c080e7          	jalr	-884(ra) # 8000437c <__mem_free>
}
    800016f8:	00813083          	ld	ra,8(sp)
    800016fc:	00013403          	ld	s0,0(sp)
    80001700:	01010113          	addi	sp,sp,16
    80001704:	00008067          	ret

0000000080001708 <_ZdaPv>:

void operator delete[](void *p)
{
    80001708:	ff010113          	addi	sp,sp,-16
    8000170c:	00113423          	sd	ra,8(sp)
    80001710:	00813023          	sd	s0,0(sp)
    80001714:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001718:	00003097          	auipc	ra,0x3
    8000171c:	c64080e7          	jalr	-924(ra) # 8000437c <__mem_free>
}
    80001720:	00813083          	ld	ra,8(sp)
    80001724:	00013403          	ld	s0,0(sp)
    80001728:	01010113          	addi	sp,sp,16
    8000172c:	00008067          	ret

0000000080001730 <_ZN7Console4getcEv>:

char Console::getc() {
    80001730:	ff010113          	addi	sp,sp,-16
    80001734:	00113423          	sd	ra,8(sp)
    80001738:	00813023          	sd	s0,0(sp)
    8000173c:	01010413          	addi	s0,sp,16
    return __getc();
    80001740:	00003097          	auipc	ra,0x3
    80001744:	e9c080e7          	jalr	-356(ra) # 800045dc <__getc>
}
    80001748:	00813083          	ld	ra,8(sp)
    8000174c:	00013403          	ld	s0,0(sp)
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret

0000000080001758 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00113423          	sd	ra,8(sp)
    80001760:	00813023          	sd	s0,0(sp)
    80001764:	01010413          	addi	s0,sp,16
    __putc(c);
    80001768:	00003097          	auipc	ra,0x3
    8000176c:	e38080e7          	jalr	-456(ra) # 800045a0 <__putc>
}
    80001770:	00813083          	ld	ra,8(sp)
    80001774:	00013403          	ld	s0,0(sp)
    80001778:	01010113          	addi	sp,sp,16
    8000177c:	00008067          	ret

0000000080001780 <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001780:	ff010113          	addi	sp,sp,-16
    80001784:	00813423          	sd	s0,8(sp)
    80001788:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    8000178c:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001790:	10200073          	sret
}
    80001794:	00813403          	ld	s0,8(sp)
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret

00000000800017a0 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    800017a0:	fb010113          	addi	sp,sp,-80
    800017a4:	04113423          	sd	ra,72(sp)
    800017a8:	04813023          	sd	s0,64(sp)
    800017ac:	02913c23          	sd	s1,56(sp)
    800017b0:	03213823          	sd	s2,48(sp)
    800017b4:	03313423          	sd	s3,40(sp)
    800017b8:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800017bc:	142027f3          	csrr	a5,scause
    800017c0:	faf43c23          	sd	a5,-72(s0)
    return scause;
    800017c4:	fb843783          	ld	a5,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    800017c8:	fff00713          	li	a4,-1
    800017cc:	03f71713          	slli	a4,a4,0x3f
    800017d0:	00170713          	addi	a4,a4,1
    800017d4:	0ee78463          	beq	a5,a4,800018bc <_ZN5Riscv20handleSupervisorTrapEv+0x11c>
    800017d8:	fff00713          	li	a4,-1
    800017dc:	03f71713          	slli	a4,a4,0x3f
    800017e0:	00170713          	addi	a4,a4,1
    800017e4:	06f76a63          	bltu	a4,a5,80001858 <_ZN5Riscv20handleSupervisorTrapEv+0xb8>
    800017e8:	ff878793          	addi	a5,a5,-8
    800017ec:	00100713          	li	a4,1
    800017f0:	04f76663          	bltu	a4,a5,8000183c <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017f4:	141027f3          	csrr	a5,sepc
    800017f8:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    800017fc:	fc843483          	ld	s1,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    80001800:	00448493          	addi	s1,s1,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001804:	100027f3          	csrr	a5,sstatus
    80001808:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    8000180c:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001810:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001814:	01200713          	li	a4,18
    80001818:	08e78063          	beq	a5,a4,80001898 <_ZN5Riscv20handleSupervisorTrapEv+0xf8>
    8000181c:	01300713          	li	a4,19
    80001820:	08e78263          	beq	a5,a4,800018a4 <_ZN5Riscv20handleSupervisorTrapEv+0x104>
    80001824:	01100713          	li	a4,17
    80001828:	04e78663          	beq	a5,a4,80001874 <_ZN5Riscv20handleSupervisorTrapEv+0xd4>
    8000182c:	00000513          	li	a0,0
                case SCALL_SEM_SIGNAL:
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
    80001830:	00050513          	mv	a0,a0
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001834:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001838:	14149073          	csrw	sepc,s1
            console_handler();
            break;
        default:
            break;
    }
    8000183c:	04813083          	ld	ra,72(sp)
    80001840:	04013403          	ld	s0,64(sp)
    80001844:	03813483          	ld	s1,56(sp)
    80001848:	03013903          	ld	s2,48(sp)
    8000184c:	02813983          	ld	s3,40(sp)
    80001850:	05010113          	addi	sp,sp,80
    80001854:	00008067          	ret
    switch((uint64)scause){
    80001858:	fff00713          	li	a4,-1
    8000185c:	03f71713          	slli	a4,a4,0x3f
    80001860:	00970713          	addi	a4,a4,9
    80001864:	fce79ce3          	bne	a5,a4,8000183c <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
            console_handler();
    80001868:	00003097          	auipc	ra,0x3
    8000186c:	dac080e7          	jalr	-596(ra) # 80004614 <console_handler>
    80001870:	fcdff06f          	j	8000183c <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                    READ_REG(handle, "a0");
    80001874:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001878:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    8000187c:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001880:	00000097          	auipc	ra,0x0
    80001884:	a90080e7          	jalr	-1392(ra) # 80001310 <_ZN7_thread12createThreadEPFvvEPv>
    80001888:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    8000188c:	02050463          	beqz	a0,800018b4 <_ZN5Riscv20handleSupervisorTrapEv+0x114>
    80001890:	00000513          	li	a0,0
    80001894:	f9dff06f          	j	80001830 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    ret = _thread::exitThread();
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	c30080e7          	jalr	-976(ra) # 800014c8 <_ZN7_thread10exitThreadEv>
                    break;
    800018a0:	f91ff06f          	j	80001830 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    _thread::dispatch();
    800018a4:	00000097          	auipc	ra,0x0
    800018a8:	bbc080e7          	jalr	-1092(ra) # 80001460 <_ZN7_thread8dispatchEv>
            uint64 ret = 0;
    800018ac:	00000513          	li	a0,0
                    break;
    800018b0:	f81ff06f          	j	80001830 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    else ret = -1;
    800018b4:	fff00513          	li	a0,-1
    800018b8:	f79ff06f          	j	80001830 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    800018bc:	00200793          	li	a5,2
    800018c0:	1447b073          	csrc	sip,a5
}
    800018c4:	f79ff06f          	j	8000183c <_ZN5Riscv20handleSupervisorTrapEv+0x9c>

00000000800018c8 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    800018c8:	ff010113          	addi	sp,sp,-16
    800018cc:	00813423          	sd	s0,8(sp)
    800018d0:	01010413          	addi	s0,sp,16
    800018d4:	00100793          	li	a5,1
    800018d8:	00f50863          	beq	a0,a5,800018e8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800018dc:	00813403          	ld	s0,8(sp)
    800018e0:	01010113          	addi	sp,sp,16
    800018e4:	00008067          	ret
    800018e8:	000107b7          	lui	a5,0x10
    800018ec:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800018f0:	fef596e3          	bne	a1,a5,800018dc <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    800018f4:	00004797          	auipc	a5,0x4
    800018f8:	36478793          	addi	a5,a5,868 # 80005c58 <_ZN9Scheduler16readyThreadQueueE>
    800018fc:	0007b023          	sd	zero,0(a5)
    80001900:	0007b423          	sd	zero,8(a5)
    80001904:	fd9ff06f          	j	800018dc <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001908 <_ZN9Scheduler3getEv>:
{
    80001908:	fe010113          	addi	sp,sp,-32
    8000190c:	00113c23          	sd	ra,24(sp)
    80001910:	00813823          	sd	s0,16(sp)
    80001914:	00913423          	sd	s1,8(sp)
    80001918:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    8000191c:	00004517          	auipc	a0,0x4
    80001920:	33c53503          	ld	a0,828(a0) # 80005c58 <_ZN9Scheduler16readyThreadQueueE>
    80001924:	04050263          	beqz	a0,80001968 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001928:	00853783          	ld	a5,8(a0)
    8000192c:	00004717          	auipc	a4,0x4
    80001930:	32f73623          	sd	a5,812(a4) # 80005c58 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001934:	02078463          	beqz	a5,8000195c <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001938:	00053483          	ld	s1,0(a0)
        delete elem;
    8000193c:	00000097          	auipc	ra,0x0
    80001940:	da4080e7          	jalr	-604(ra) # 800016e0 <_ZdlPv>
}
    80001944:	00048513          	mv	a0,s1
    80001948:	01813083          	ld	ra,24(sp)
    8000194c:	01013403          	ld	s0,16(sp)
    80001950:	00813483          	ld	s1,8(sp)
    80001954:	02010113          	addi	sp,sp,32
    80001958:	00008067          	ret
        if (!head) { tail = 0; }
    8000195c:	00004797          	auipc	a5,0x4
    80001960:	3007b223          	sd	zero,772(a5) # 80005c60 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001964:	fd5ff06f          	j	80001938 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001968:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    8000196c:	fd9ff06f          	j	80001944 <_ZN9Scheduler3getEv+0x3c>

0000000080001970 <_ZN9Scheduler3putEP7_thread>:
{
    80001970:	fe010113          	addi	sp,sp,-32
    80001974:	00113c23          	sd	ra,24(sp)
    80001978:	00813823          	sd	s0,16(sp)
    8000197c:	00913423          	sd	s1,8(sp)
    80001980:	02010413          	addi	s0,sp,32
    80001984:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001988:	01000513          	li	a0,16
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	d04080e7          	jalr	-764(ra) # 80001690 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001994:	00953023          	sd	s1,0(a0)
    80001998:	00053423          	sd	zero,8(a0)
        if (tail)
    8000199c:	00004797          	auipc	a5,0x4
    800019a0:	2c47b783          	ld	a5,708(a5) # 80005c60 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800019a4:	02078263          	beqz	a5,800019c8 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800019a8:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800019ac:	00004797          	auipc	a5,0x4
    800019b0:	2aa7ba23          	sd	a0,692(a5) # 80005c60 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800019b4:	01813083          	ld	ra,24(sp)
    800019b8:	01013403          	ld	s0,16(sp)
    800019bc:	00813483          	ld	s1,8(sp)
    800019c0:	02010113          	addi	sp,sp,32
    800019c4:	00008067          	ret
            head = tail = elem;
    800019c8:	00004797          	auipc	a5,0x4
    800019cc:	29078793          	addi	a5,a5,656 # 80005c58 <_ZN9Scheduler16readyThreadQueueE>
    800019d0:	00a7b423          	sd	a0,8(a5)
    800019d4:	00a7b023          	sd	a0,0(a5)
    800019d8:	fddff06f          	j	800019b4 <_ZN9Scheduler3putEP7_thread+0x44>

00000000800019dc <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    800019dc:	ff010113          	addi	sp,sp,-16
    800019e0:	00113423          	sd	ra,8(sp)
    800019e4:	00813023          	sd	s0,0(sp)
    800019e8:	01010413          	addi	s0,sp,16
    800019ec:	000105b7          	lui	a1,0x10
    800019f0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800019f4:	00100513          	li	a0,1
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	ed0080e7          	jalr	-304(ra) # 800018c8 <_Z41__static_initialization_and_destruction_0ii>
    80001a00:	00813083          	ld	ra,8(sp)
    80001a04:	00013403          	ld	s0,0(sp)
    80001a08:	01010113          	addi	sp,sp,16
    80001a0c:	00008067          	ret

0000000080001a10 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80001a10:	fe010113          	addi	sp,sp,-32
    80001a14:	00113c23          	sd	ra,24(sp)
    80001a18:	00813823          	sd	s0,16(sp)
    80001a1c:	00913423          	sd	s1,8(sp)
    80001a20:	01213023          	sd	s2,0(sp)
    80001a24:	02010413          	addi	s0,sp,32
    80001a28:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001a2c:	00100793          	li	a5,1
    80001a30:	02a7f863          	bgeu	a5,a0,80001a60 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001a34:	00a00793          	li	a5,10
    80001a38:	02f577b3          	remu	a5,a0,a5
    80001a3c:	02078e63          	beqz	a5,80001a78 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001a40:	fff48513          	addi	a0,s1,-1
    80001a44:	00000097          	auipc	ra,0x0
    80001a48:	fcc080e7          	jalr	-52(ra) # 80001a10 <_ZL9fibonaccim>
    80001a4c:	00050913          	mv	s2,a0
    80001a50:	ffe48513          	addi	a0,s1,-2
    80001a54:	00000097          	auipc	ra,0x0
    80001a58:	fbc080e7          	jalr	-68(ra) # 80001a10 <_ZL9fibonaccim>
    80001a5c:	00a90533          	add	a0,s2,a0
}
    80001a60:	01813083          	ld	ra,24(sp)
    80001a64:	01013403          	ld	s0,16(sp)
    80001a68:	00813483          	ld	s1,8(sp)
    80001a6c:	00013903          	ld	s2,0(sp)
    80001a70:	02010113          	addi	sp,sp,32
    80001a74:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001a78:	fffff097          	auipc	ra,0xfffff
    80001a7c:	774080e7          	jalr	1908(ra) # 800011ec <_Z15thread_dispatchv>
    80001a80:	fc1ff06f          	j	80001a40 <_ZL9fibonaccim+0x30>

0000000080001a84 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80001a84:	fe010113          	addi	sp,sp,-32
    80001a88:	00113c23          	sd	ra,24(sp)
    80001a8c:	00813823          	sd	s0,16(sp)
    80001a90:	00913423          	sd	s1,8(sp)
    80001a94:	01213023          	sd	s2,0(sp)
    80001a98:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001a9c:	00a00493          	li	s1,10
    80001aa0:	0400006f          	j	80001ae0 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001aa4:	00003517          	auipc	a0,0x3
    80001aa8:	70c50513          	addi	a0,a0,1804 # 800051b0 <kvmincrease+0xaf0>
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	53c080e7          	jalr	1340(ra) # 80001fe8 <_Z11printStringPKc>
    80001ab4:	00000613          	li	a2,0
    80001ab8:	00a00593          	li	a1,10
    80001abc:	00048513          	mv	a0,s1
    80001ac0:	00000097          	auipc	ra,0x0
    80001ac4:	6d8080e7          	jalr	1752(ra) # 80002198 <_Z8printIntiii>
    80001ac8:	00003517          	auipc	a0,0x3
    80001acc:	6e050513          	addi	a0,a0,1760 # 800051a8 <kvmincrease+0xae8>
    80001ad0:	00000097          	auipc	ra,0x0
    80001ad4:	518080e7          	jalr	1304(ra) # 80001fe8 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001ad8:	0014849b          	addiw	s1,s1,1
    80001adc:	0ff4f493          	andi	s1,s1,255
    80001ae0:	00c00793          	li	a5,12
    80001ae4:	fc97f0e3          	bgeu	a5,s1,80001aa4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80001ae8:	00003517          	auipc	a0,0x3
    80001aec:	6d050513          	addi	a0,a0,1744 # 800051b8 <kvmincrease+0xaf8>
    80001af0:	00000097          	auipc	ra,0x0
    80001af4:	4f8080e7          	jalr	1272(ra) # 80001fe8 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001af8:	00500313          	li	t1,5
    thread_dispatch();
    80001afc:	fffff097          	auipc	ra,0xfffff
    80001b00:	6f0080e7          	jalr	1776(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001b04:	01000513          	li	a0,16
    80001b08:	00000097          	auipc	ra,0x0
    80001b0c:	f08080e7          	jalr	-248(ra) # 80001a10 <_ZL9fibonaccim>
    80001b10:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001b14:	00003517          	auipc	a0,0x3
    80001b18:	6b450513          	addi	a0,a0,1716 # 800051c8 <kvmincrease+0xb08>
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	4cc080e7          	jalr	1228(ra) # 80001fe8 <_Z11printStringPKc>
    80001b24:	00000613          	li	a2,0
    80001b28:	00a00593          	li	a1,10
    80001b2c:	0009051b          	sext.w	a0,s2
    80001b30:	00000097          	auipc	ra,0x0
    80001b34:	668080e7          	jalr	1640(ra) # 80002198 <_Z8printIntiii>
    80001b38:	00003517          	auipc	a0,0x3
    80001b3c:	67050513          	addi	a0,a0,1648 # 800051a8 <kvmincrease+0xae8>
    80001b40:	00000097          	auipc	ra,0x0
    80001b44:	4a8080e7          	jalr	1192(ra) # 80001fe8 <_Z11printStringPKc>
    80001b48:	0400006f          	j	80001b88 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001b4c:	00003517          	auipc	a0,0x3
    80001b50:	66450513          	addi	a0,a0,1636 # 800051b0 <kvmincrease+0xaf0>
    80001b54:	00000097          	auipc	ra,0x0
    80001b58:	494080e7          	jalr	1172(ra) # 80001fe8 <_Z11printStringPKc>
    80001b5c:	00000613          	li	a2,0
    80001b60:	00a00593          	li	a1,10
    80001b64:	00048513          	mv	a0,s1
    80001b68:	00000097          	auipc	ra,0x0
    80001b6c:	630080e7          	jalr	1584(ra) # 80002198 <_Z8printIntiii>
    80001b70:	00003517          	auipc	a0,0x3
    80001b74:	63850513          	addi	a0,a0,1592 # 800051a8 <kvmincrease+0xae8>
    80001b78:	00000097          	auipc	ra,0x0
    80001b7c:	470080e7          	jalr	1136(ra) # 80001fe8 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001b80:	0014849b          	addiw	s1,s1,1
    80001b84:	0ff4f493          	andi	s1,s1,255
    80001b88:	00f00793          	li	a5,15
    80001b8c:	fc97f0e3          	bgeu	a5,s1,80001b4c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80001b90:	00003517          	auipc	a0,0x3
    80001b94:	64850513          	addi	a0,a0,1608 # 800051d8 <kvmincrease+0xb18>
    80001b98:	00000097          	auipc	ra,0x0
    80001b9c:	450080e7          	jalr	1104(ra) # 80001fe8 <_Z11printStringPKc>
    finishedD = true;
    80001ba0:	00100793          	li	a5,1
    80001ba4:	00004717          	auipc	a4,0x4
    80001ba8:	0cf70223          	sb	a5,196(a4) # 80005c68 <_ZL9finishedD>
    thread_dispatch();
    80001bac:	fffff097          	auipc	ra,0xfffff
    80001bb0:	640080e7          	jalr	1600(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001bb4:	01813083          	ld	ra,24(sp)
    80001bb8:	01013403          	ld	s0,16(sp)
    80001bbc:	00813483          	ld	s1,8(sp)
    80001bc0:	00013903          	ld	s2,0(sp)
    80001bc4:	02010113          	addi	sp,sp,32
    80001bc8:	00008067          	ret

0000000080001bcc <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80001bcc:	fe010113          	addi	sp,sp,-32
    80001bd0:	00113c23          	sd	ra,24(sp)
    80001bd4:	00813823          	sd	s0,16(sp)
    80001bd8:	00913423          	sd	s1,8(sp)
    80001bdc:	01213023          	sd	s2,0(sp)
    80001be0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001be4:	00000493          	li	s1,0
    80001be8:	0400006f          	j	80001c28 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80001bec:	00003517          	auipc	a0,0x3
    80001bf0:	5fc50513          	addi	a0,a0,1532 # 800051e8 <kvmincrease+0xb28>
    80001bf4:	00000097          	auipc	ra,0x0
    80001bf8:	3f4080e7          	jalr	1012(ra) # 80001fe8 <_Z11printStringPKc>
    80001bfc:	00000613          	li	a2,0
    80001c00:	00a00593          	li	a1,10
    80001c04:	00048513          	mv	a0,s1
    80001c08:	00000097          	auipc	ra,0x0
    80001c0c:	590080e7          	jalr	1424(ra) # 80002198 <_Z8printIntiii>
    80001c10:	00003517          	auipc	a0,0x3
    80001c14:	59850513          	addi	a0,a0,1432 # 800051a8 <kvmincrease+0xae8>
    80001c18:	00000097          	auipc	ra,0x0
    80001c1c:	3d0080e7          	jalr	976(ra) # 80001fe8 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001c20:	0014849b          	addiw	s1,s1,1
    80001c24:	0ff4f493          	andi	s1,s1,255
    80001c28:	00200793          	li	a5,2
    80001c2c:	fc97f0e3          	bgeu	a5,s1,80001bec <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80001c30:	00003517          	auipc	a0,0x3
    80001c34:	5c050513          	addi	a0,a0,1472 # 800051f0 <kvmincrease+0xb30>
    80001c38:	00000097          	auipc	ra,0x0
    80001c3c:	3b0080e7          	jalr	944(ra) # 80001fe8 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001c40:	00700313          	li	t1,7
    thread_dispatch();
    80001c44:	fffff097          	auipc	ra,0xfffff
    80001c48:	5a8080e7          	jalr	1448(ra) # 800011ec <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001c4c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80001c50:	00003517          	auipc	a0,0x3
    80001c54:	5b050513          	addi	a0,a0,1456 # 80005200 <kvmincrease+0xb40>
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	390080e7          	jalr	912(ra) # 80001fe8 <_Z11printStringPKc>
    80001c60:	00000613          	li	a2,0
    80001c64:	00a00593          	li	a1,10
    80001c68:	0009051b          	sext.w	a0,s2
    80001c6c:	00000097          	auipc	ra,0x0
    80001c70:	52c080e7          	jalr	1324(ra) # 80002198 <_Z8printIntiii>
    80001c74:	00003517          	auipc	a0,0x3
    80001c78:	53450513          	addi	a0,a0,1332 # 800051a8 <kvmincrease+0xae8>
    80001c7c:	00000097          	auipc	ra,0x0
    80001c80:	36c080e7          	jalr	876(ra) # 80001fe8 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80001c84:	00c00513          	li	a0,12
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	d88080e7          	jalr	-632(ra) # 80001a10 <_ZL9fibonaccim>
    80001c90:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001c94:	00003517          	auipc	a0,0x3
    80001c98:	57450513          	addi	a0,a0,1396 # 80005208 <kvmincrease+0xb48>
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	34c080e7          	jalr	844(ra) # 80001fe8 <_Z11printStringPKc>
    80001ca4:	00000613          	li	a2,0
    80001ca8:	00a00593          	li	a1,10
    80001cac:	0009051b          	sext.w	a0,s2
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	4e8080e7          	jalr	1256(ra) # 80002198 <_Z8printIntiii>
    80001cb8:	00003517          	auipc	a0,0x3
    80001cbc:	4f050513          	addi	a0,a0,1264 # 800051a8 <kvmincrease+0xae8>
    80001cc0:	00000097          	auipc	ra,0x0
    80001cc4:	328080e7          	jalr	808(ra) # 80001fe8 <_Z11printStringPKc>
    80001cc8:	0400006f          	j	80001d08 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80001ccc:	00003517          	auipc	a0,0x3
    80001cd0:	51c50513          	addi	a0,a0,1308 # 800051e8 <kvmincrease+0xb28>
    80001cd4:	00000097          	auipc	ra,0x0
    80001cd8:	314080e7          	jalr	788(ra) # 80001fe8 <_Z11printStringPKc>
    80001cdc:	00000613          	li	a2,0
    80001ce0:	00a00593          	li	a1,10
    80001ce4:	00048513          	mv	a0,s1
    80001ce8:	00000097          	auipc	ra,0x0
    80001cec:	4b0080e7          	jalr	1200(ra) # 80002198 <_Z8printIntiii>
    80001cf0:	00003517          	auipc	a0,0x3
    80001cf4:	4b850513          	addi	a0,a0,1208 # 800051a8 <kvmincrease+0xae8>
    80001cf8:	00000097          	auipc	ra,0x0
    80001cfc:	2f0080e7          	jalr	752(ra) # 80001fe8 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001d00:	0014849b          	addiw	s1,s1,1
    80001d04:	0ff4f493          	andi	s1,s1,255
    80001d08:	00500793          	li	a5,5
    80001d0c:	fc97f0e3          	bgeu	a5,s1,80001ccc <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80001d10:	00003517          	auipc	a0,0x3
    80001d14:	50850513          	addi	a0,a0,1288 # 80005218 <kvmincrease+0xb58>
    80001d18:	00000097          	auipc	ra,0x0
    80001d1c:	2d0080e7          	jalr	720(ra) # 80001fe8 <_Z11printStringPKc>
    finishedC = true;
    80001d20:	00100793          	li	a5,1
    80001d24:	00004717          	auipc	a4,0x4
    80001d28:	f4f702a3          	sb	a5,-187(a4) # 80005c69 <_ZL9finishedC>
    thread_dispatch();
    80001d2c:	fffff097          	auipc	ra,0xfffff
    80001d30:	4c0080e7          	jalr	1216(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001d34:	01813083          	ld	ra,24(sp)
    80001d38:	01013403          	ld	s0,16(sp)
    80001d3c:	00813483          	ld	s1,8(sp)
    80001d40:	00013903          	ld	s2,0(sp)
    80001d44:	02010113          	addi	sp,sp,32
    80001d48:	00008067          	ret

0000000080001d4c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80001d4c:	fe010113          	addi	sp,sp,-32
    80001d50:	00113c23          	sd	ra,24(sp)
    80001d54:	00813823          	sd	s0,16(sp)
    80001d58:	00913423          	sd	s1,8(sp)
    80001d5c:	01213023          	sd	s2,0(sp)
    80001d60:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001d64:	00000913          	li	s2,0
    80001d68:	0380006f          	j	80001da0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80001d6c:	fffff097          	auipc	ra,0xfffff
    80001d70:	480080e7          	jalr	1152(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001d74:	00148493          	addi	s1,s1,1
    80001d78:	000027b7          	lui	a5,0x2
    80001d7c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001d80:	0097ee63          	bltu	a5,s1,80001d9c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001d84:	00000713          	li	a4,0
    80001d88:	000077b7          	lui	a5,0x7
    80001d8c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001d90:	fce7eee3          	bltu	a5,a4,80001d6c <_ZL11workerBodyBPv+0x20>
    80001d94:	00170713          	addi	a4,a4,1
    80001d98:	ff1ff06f          	j	80001d88 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001d9c:	00190913          	addi	s2,s2,1
    80001da0:	00f00793          	li	a5,15
    80001da4:	0527e063          	bltu	a5,s2,80001de4 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001da8:	00003517          	auipc	a0,0x3
    80001dac:	48050513          	addi	a0,a0,1152 # 80005228 <kvmincrease+0xb68>
    80001db0:	00000097          	auipc	ra,0x0
    80001db4:	238080e7          	jalr	568(ra) # 80001fe8 <_Z11printStringPKc>
    80001db8:	00000613          	li	a2,0
    80001dbc:	00a00593          	li	a1,10
    80001dc0:	0009051b          	sext.w	a0,s2
    80001dc4:	00000097          	auipc	ra,0x0
    80001dc8:	3d4080e7          	jalr	980(ra) # 80002198 <_Z8printIntiii>
    80001dcc:	00003517          	auipc	a0,0x3
    80001dd0:	3dc50513          	addi	a0,a0,988 # 800051a8 <kvmincrease+0xae8>
    80001dd4:	00000097          	auipc	ra,0x0
    80001dd8:	214080e7          	jalr	532(ra) # 80001fe8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001ddc:	00000493          	li	s1,0
    80001de0:	f99ff06f          	j	80001d78 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80001de4:	00003517          	auipc	a0,0x3
    80001de8:	44c50513          	addi	a0,a0,1100 # 80005230 <kvmincrease+0xb70>
    80001dec:	00000097          	auipc	ra,0x0
    80001df0:	1fc080e7          	jalr	508(ra) # 80001fe8 <_Z11printStringPKc>
    finishedB = true;
    80001df4:	00100793          	li	a5,1
    80001df8:	00004717          	auipc	a4,0x4
    80001dfc:	e6f70923          	sb	a5,-398(a4) # 80005c6a <_ZL9finishedB>
    thread_dispatch();
    80001e00:	fffff097          	auipc	ra,0xfffff
    80001e04:	3ec080e7          	jalr	1004(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001e08:	01813083          	ld	ra,24(sp)
    80001e0c:	01013403          	ld	s0,16(sp)
    80001e10:	00813483          	ld	s1,8(sp)
    80001e14:	00013903          	ld	s2,0(sp)
    80001e18:	02010113          	addi	sp,sp,32
    80001e1c:	00008067          	ret

0000000080001e20 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80001e20:	fe010113          	addi	sp,sp,-32
    80001e24:	00113c23          	sd	ra,24(sp)
    80001e28:	00813823          	sd	s0,16(sp)
    80001e2c:	00913423          	sd	s1,8(sp)
    80001e30:	01213023          	sd	s2,0(sp)
    80001e34:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001e38:	00000913          	li	s2,0
    80001e3c:	0380006f          	j	80001e74 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80001e40:	fffff097          	auipc	ra,0xfffff
    80001e44:	3ac080e7          	jalr	940(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001e48:	00148493          	addi	s1,s1,1
    80001e4c:	000027b7          	lui	a5,0x2
    80001e50:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001e54:	0097ee63          	bltu	a5,s1,80001e70 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001e58:	00000713          	li	a4,0
    80001e5c:	000077b7          	lui	a5,0x7
    80001e60:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001e64:	fce7eee3          	bltu	a5,a4,80001e40 <_ZL11workerBodyAPv+0x20>
    80001e68:	00170713          	addi	a4,a4,1
    80001e6c:	ff1ff06f          	j	80001e5c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001e70:	00190913          	addi	s2,s2,1
    80001e74:	00900793          	li	a5,9
    80001e78:	0527e063          	bltu	a5,s2,80001eb8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001e7c:	00003517          	auipc	a0,0x3
    80001e80:	3c450513          	addi	a0,a0,964 # 80005240 <kvmincrease+0xb80>
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	164080e7          	jalr	356(ra) # 80001fe8 <_Z11printStringPKc>
    80001e8c:	00000613          	li	a2,0
    80001e90:	00a00593          	li	a1,10
    80001e94:	0009051b          	sext.w	a0,s2
    80001e98:	00000097          	auipc	ra,0x0
    80001e9c:	300080e7          	jalr	768(ra) # 80002198 <_Z8printIntiii>
    80001ea0:	00003517          	auipc	a0,0x3
    80001ea4:	30850513          	addi	a0,a0,776 # 800051a8 <kvmincrease+0xae8>
    80001ea8:	00000097          	auipc	ra,0x0
    80001eac:	140080e7          	jalr	320(ra) # 80001fe8 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001eb0:	00000493          	li	s1,0
    80001eb4:	f99ff06f          	j	80001e4c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80001eb8:	00003517          	auipc	a0,0x3
    80001ebc:	36050513          	addi	a0,a0,864 # 80005218 <kvmincrease+0xb58>
    80001ec0:	00000097          	auipc	ra,0x0
    80001ec4:	128080e7          	jalr	296(ra) # 80001fe8 <_Z11printStringPKc>
    finishedA = true;
    80001ec8:	00100793          	li	a5,1
    80001ecc:	00004717          	auipc	a4,0x4
    80001ed0:	d8f70fa3          	sb	a5,-609(a4) # 80005c6b <_ZL9finishedA>
}
    80001ed4:	01813083          	ld	ra,24(sp)
    80001ed8:	01013403          	ld	s0,16(sp)
    80001edc:	00813483          	ld	s1,8(sp)
    80001ee0:	00013903          	ld	s2,0(sp)
    80001ee4:	02010113          	addi	sp,sp,32
    80001ee8:	00008067          	ret

0000000080001eec <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80001eec:	fd010113          	addi	sp,sp,-48
    80001ef0:	02113423          	sd	ra,40(sp)
    80001ef4:	02813023          	sd	s0,32(sp)
    80001ef8:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80001efc:	00000613          	li	a2,0
    80001f00:	00000597          	auipc	a1,0x0
    80001f04:	f2058593          	addi	a1,a1,-224 # 80001e20 <_ZL11workerBodyAPv>
    80001f08:	fd040513          	addi	a0,s0,-48
    80001f0c:	fffff097          	auipc	ra,0xfffff
    80001f10:	288080e7          	jalr	648(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80001f14:	00003517          	auipc	a0,0x3
    80001f18:	33450513          	addi	a0,a0,820 # 80005248 <kvmincrease+0xb88>
    80001f1c:	00000097          	auipc	ra,0x0
    80001f20:	0cc080e7          	jalr	204(ra) # 80001fe8 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80001f24:	00000613          	li	a2,0
    80001f28:	00000597          	auipc	a1,0x0
    80001f2c:	e2458593          	addi	a1,a1,-476 # 80001d4c <_ZL11workerBodyBPv>
    80001f30:	fd840513          	addi	a0,s0,-40
    80001f34:	fffff097          	auipc	ra,0xfffff
    80001f38:	260080e7          	jalr	608(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80001f3c:	00003517          	auipc	a0,0x3
    80001f40:	32450513          	addi	a0,a0,804 # 80005260 <kvmincrease+0xba0>
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	0a4080e7          	jalr	164(ra) # 80001fe8 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80001f4c:	00000613          	li	a2,0
    80001f50:	00000597          	auipc	a1,0x0
    80001f54:	c7c58593          	addi	a1,a1,-900 # 80001bcc <_ZL11workerBodyCPv>
    80001f58:	fe040513          	addi	a0,s0,-32
    80001f5c:	fffff097          	auipc	ra,0xfffff
    80001f60:	238080e7          	jalr	568(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80001f64:	00003517          	auipc	a0,0x3
    80001f68:	31450513          	addi	a0,a0,788 # 80005278 <kvmincrease+0xbb8>
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	07c080e7          	jalr	124(ra) # 80001fe8 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80001f74:	00000613          	li	a2,0
    80001f78:	00000597          	auipc	a1,0x0
    80001f7c:	b0c58593          	addi	a1,a1,-1268 # 80001a84 <_ZL11workerBodyDPv>
    80001f80:	fe840513          	addi	a0,s0,-24
    80001f84:	fffff097          	auipc	ra,0xfffff
    80001f88:	210080e7          	jalr	528(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80001f8c:	00003517          	auipc	a0,0x3
    80001f90:	30450513          	addi	a0,a0,772 # 80005290 <kvmincrease+0xbd0>
    80001f94:	00000097          	auipc	ra,0x0
    80001f98:	054080e7          	jalr	84(ra) # 80001fe8 <_Z11printStringPKc>
    80001f9c:	00c0006f          	j	80001fa8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80001fa0:	fffff097          	auipc	ra,0xfffff
    80001fa4:	24c080e7          	jalr	588(ra) # 800011ec <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80001fa8:	00004797          	auipc	a5,0x4
    80001fac:	cc37c783          	lbu	a5,-829(a5) # 80005c6b <_ZL9finishedA>
    80001fb0:	fe0788e3          	beqz	a5,80001fa0 <_Z18Threads_C_API_testv+0xb4>
    80001fb4:	00004797          	auipc	a5,0x4
    80001fb8:	cb67c783          	lbu	a5,-842(a5) # 80005c6a <_ZL9finishedB>
    80001fbc:	fe0782e3          	beqz	a5,80001fa0 <_Z18Threads_C_API_testv+0xb4>
    80001fc0:	00004797          	auipc	a5,0x4
    80001fc4:	ca97c783          	lbu	a5,-855(a5) # 80005c69 <_ZL9finishedC>
    80001fc8:	fc078ce3          	beqz	a5,80001fa0 <_Z18Threads_C_API_testv+0xb4>
    80001fcc:	00004797          	auipc	a5,0x4
    80001fd0:	c9c7c783          	lbu	a5,-868(a5) # 80005c68 <_ZL9finishedD>
    80001fd4:	fc0786e3          	beqz	a5,80001fa0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80001fd8:	02813083          	ld	ra,40(sp)
    80001fdc:	02013403          	ld	s0,32(sp)
    80001fe0:	03010113          	addi	sp,sp,48
    80001fe4:	00008067          	ret

0000000080001fe8 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001fe8:	fe010113          	addi	sp,sp,-32
    80001fec:	00113c23          	sd	ra,24(sp)
    80001ff0:	00813823          	sd	s0,16(sp)
    80001ff4:	00913423          	sd	s1,8(sp)
    80001ff8:	02010413          	addi	s0,sp,32
    80001ffc:	00050493          	mv	s1,a0
    LOCK();
    80002000:	00100613          	li	a2,1
    80002004:	00000593          	li	a1,0
    80002008:	00004517          	auipc	a0,0x4
    8000200c:	c6850513          	addi	a0,a0,-920 # 80005c70 <lockPrint>
    80002010:	fffff097          	auipc	ra,0xfffff
    80002014:	ff0080e7          	jalr	-16(ra) # 80001000 <copy_and_swap>
    80002018:	00050863          	beqz	a0,80002028 <_Z11printStringPKc+0x40>
    8000201c:	fffff097          	auipc	ra,0xfffff
    80002020:	1d0080e7          	jalr	464(ra) # 800011ec <_Z15thread_dispatchv>
    80002024:	fddff06f          	j	80002000 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002028:	0004c503          	lbu	a0,0(s1)
    8000202c:	00050a63          	beqz	a0,80002040 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80002030:	fffff097          	auipc	ra,0xfffff
    80002034:	2b8080e7          	jalr	696(ra) # 800012e8 <_Z4putcc>
        string++;
    80002038:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    8000203c:	fedff06f          	j	80002028 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80002040:	00000613          	li	a2,0
    80002044:	00100593          	li	a1,1
    80002048:	00004517          	auipc	a0,0x4
    8000204c:	c2850513          	addi	a0,a0,-984 # 80005c70 <lockPrint>
    80002050:	fffff097          	auipc	ra,0xfffff
    80002054:	fb0080e7          	jalr	-80(ra) # 80001000 <copy_and_swap>
    80002058:	fe0514e3          	bnez	a0,80002040 <_Z11printStringPKc+0x58>
}
    8000205c:	01813083          	ld	ra,24(sp)
    80002060:	01013403          	ld	s0,16(sp)
    80002064:	00813483          	ld	s1,8(sp)
    80002068:	02010113          	addi	sp,sp,32
    8000206c:	00008067          	ret

0000000080002070 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002070:	fd010113          	addi	sp,sp,-48
    80002074:	02113423          	sd	ra,40(sp)
    80002078:	02813023          	sd	s0,32(sp)
    8000207c:	00913c23          	sd	s1,24(sp)
    80002080:	01213823          	sd	s2,16(sp)
    80002084:	01313423          	sd	s3,8(sp)
    80002088:	01413023          	sd	s4,0(sp)
    8000208c:	03010413          	addi	s0,sp,48
    80002090:	00050993          	mv	s3,a0
    80002094:	00058a13          	mv	s4,a1
    LOCK();
    80002098:	00100613          	li	a2,1
    8000209c:	00000593          	li	a1,0
    800020a0:	00004517          	auipc	a0,0x4
    800020a4:	bd050513          	addi	a0,a0,-1072 # 80005c70 <lockPrint>
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	f58080e7          	jalr	-168(ra) # 80001000 <copy_and_swap>
    800020b0:	00050863          	beqz	a0,800020c0 <_Z9getStringPci+0x50>
    800020b4:	fffff097          	auipc	ra,0xfffff
    800020b8:	138080e7          	jalr	312(ra) # 800011ec <_Z15thread_dispatchv>
    800020bc:	fddff06f          	j	80002098 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800020c0:	00000913          	li	s2,0
    800020c4:	00090493          	mv	s1,s2
    800020c8:	0019091b          	addiw	s2,s2,1
    800020cc:	03495a63          	bge	s2,s4,80002100 <_Z9getStringPci+0x90>
        cc = getc();
    800020d0:	fffff097          	auipc	ra,0xfffff
    800020d4:	1f0080e7          	jalr	496(ra) # 800012c0 <_Z4getcv>
        if(cc < 1)
    800020d8:	02050463          	beqz	a0,80002100 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    800020dc:	009984b3          	add	s1,s3,s1
    800020e0:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800020e4:	00a00793          	li	a5,10
    800020e8:	00f50a63          	beq	a0,a5,800020fc <_Z9getStringPci+0x8c>
    800020ec:	00d00793          	li	a5,13
    800020f0:	fcf51ae3          	bne	a0,a5,800020c4 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800020f4:	00090493          	mv	s1,s2
    800020f8:	0080006f          	j	80002100 <_Z9getStringPci+0x90>
    800020fc:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80002100:	009984b3          	add	s1,s3,s1
    80002104:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002108:	00000613          	li	a2,0
    8000210c:	00100593          	li	a1,1
    80002110:	00004517          	auipc	a0,0x4
    80002114:	b6050513          	addi	a0,a0,-1184 # 80005c70 <lockPrint>
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	ee8080e7          	jalr	-280(ra) # 80001000 <copy_and_swap>
    80002120:	fe0514e3          	bnez	a0,80002108 <_Z9getStringPci+0x98>
    return buf;
}
    80002124:	00098513          	mv	a0,s3
    80002128:	02813083          	ld	ra,40(sp)
    8000212c:	02013403          	ld	s0,32(sp)
    80002130:	01813483          	ld	s1,24(sp)
    80002134:	01013903          	ld	s2,16(sp)
    80002138:	00813983          	ld	s3,8(sp)
    8000213c:	00013a03          	ld	s4,0(sp)
    80002140:	03010113          	addi	sp,sp,48
    80002144:	00008067          	ret

0000000080002148 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00813423          	sd	s0,8(sp)
    80002150:	01010413          	addi	s0,sp,16
    80002154:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002158:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    8000215c:	0006c603          	lbu	a2,0(a3)
    80002160:	fd06071b          	addiw	a4,a2,-48
    80002164:	0ff77713          	andi	a4,a4,255
    80002168:	00900793          	li	a5,9
    8000216c:	02e7e063          	bltu	a5,a4,8000218c <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002170:	0025179b          	slliw	a5,a0,0x2
    80002174:	00a787bb          	addw	a5,a5,a0
    80002178:	0017979b          	slliw	a5,a5,0x1
    8000217c:	00168693          	addi	a3,a3,1
    80002180:	00c787bb          	addw	a5,a5,a2
    80002184:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002188:	fd5ff06f          	j	8000215c <_Z11stringToIntPKc+0x14>
    return n;
}
    8000218c:	00813403          	ld	s0,8(sp)
    80002190:	01010113          	addi	sp,sp,16
    80002194:	00008067          	ret

0000000080002198 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002198:	fc010113          	addi	sp,sp,-64
    8000219c:	02113c23          	sd	ra,56(sp)
    800021a0:	02813823          	sd	s0,48(sp)
    800021a4:	02913423          	sd	s1,40(sp)
    800021a8:	03213023          	sd	s2,32(sp)
    800021ac:	01313c23          	sd	s3,24(sp)
    800021b0:	04010413          	addi	s0,sp,64
    800021b4:	00050493          	mv	s1,a0
    800021b8:	00058913          	mv	s2,a1
    800021bc:	00060993          	mv	s3,a2
    LOCK();
    800021c0:	00100613          	li	a2,1
    800021c4:	00000593          	li	a1,0
    800021c8:	00004517          	auipc	a0,0x4
    800021cc:	aa850513          	addi	a0,a0,-1368 # 80005c70 <lockPrint>
    800021d0:	fffff097          	auipc	ra,0xfffff
    800021d4:	e30080e7          	jalr	-464(ra) # 80001000 <copy_and_swap>
    800021d8:	00050863          	beqz	a0,800021e8 <_Z8printIntiii+0x50>
    800021dc:	fffff097          	auipc	ra,0xfffff
    800021e0:	010080e7          	jalr	16(ra) # 800011ec <_Z15thread_dispatchv>
    800021e4:	fddff06f          	j	800021c0 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800021e8:	00098463          	beqz	s3,800021f0 <_Z8printIntiii+0x58>
    800021ec:	0804c463          	bltz	s1,80002274 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800021f0:	0004851b          	sext.w	a0,s1
    neg = 0;
    800021f4:	00000593          	li	a1,0
    }

    i = 0;
    800021f8:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800021fc:	0009079b          	sext.w	a5,s2
    80002200:	0325773b          	remuw	a4,a0,s2
    80002204:	00048613          	mv	a2,s1
    80002208:	0014849b          	addiw	s1,s1,1
    8000220c:	02071693          	slli	a3,a4,0x20
    80002210:	0206d693          	srli	a3,a3,0x20
    80002214:	00004717          	auipc	a4,0x4
    80002218:	9b470713          	addi	a4,a4,-1612 # 80005bc8 <digits>
    8000221c:	00d70733          	add	a4,a4,a3
    80002220:	00074683          	lbu	a3,0(a4)
    80002224:	fd040713          	addi	a4,s0,-48
    80002228:	00c70733          	add	a4,a4,a2
    8000222c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002230:	0005071b          	sext.w	a4,a0
    80002234:	0325553b          	divuw	a0,a0,s2
    80002238:	fcf772e3          	bgeu	a4,a5,800021fc <_Z8printIntiii+0x64>
    if(neg)
    8000223c:	00058c63          	beqz	a1,80002254 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80002240:	fd040793          	addi	a5,s0,-48
    80002244:	009784b3          	add	s1,a5,s1
    80002248:	02d00793          	li	a5,45
    8000224c:	fef48823          	sb	a5,-16(s1)
    80002250:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002254:	fff4849b          	addiw	s1,s1,-1
    80002258:	0204c463          	bltz	s1,80002280 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    8000225c:	fd040793          	addi	a5,s0,-48
    80002260:	009787b3          	add	a5,a5,s1
    80002264:	ff07c503          	lbu	a0,-16(a5)
    80002268:	fffff097          	auipc	ra,0xfffff
    8000226c:	080080e7          	jalr	128(ra) # 800012e8 <_Z4putcc>
    80002270:	fe5ff06f          	j	80002254 <_Z8printIntiii+0xbc>
        x = -xx;
    80002274:	4090053b          	negw	a0,s1
        neg = 1;
    80002278:	00100593          	li	a1,1
        x = -xx;
    8000227c:	f7dff06f          	j	800021f8 <_Z8printIntiii+0x60>

    UNLOCK();
    80002280:	00000613          	li	a2,0
    80002284:	00100593          	li	a1,1
    80002288:	00004517          	auipc	a0,0x4
    8000228c:	9e850513          	addi	a0,a0,-1560 # 80005c70 <lockPrint>
    80002290:	fffff097          	auipc	ra,0xfffff
    80002294:	d70080e7          	jalr	-656(ra) # 80001000 <copy_and_swap>
    80002298:	fe0514e3          	bnez	a0,80002280 <_Z8printIntiii+0xe8>
    8000229c:	03813083          	ld	ra,56(sp)
    800022a0:	03013403          	ld	s0,48(sp)
    800022a4:	02813483          	ld	s1,40(sp)
    800022a8:	02013903          	ld	s2,32(sp)
    800022ac:	01813983          	ld	s3,24(sp)
    800022b0:	04010113          	addi	sp,sp,64
    800022b4:	00008067          	ret

00000000800022b8 <start>:
    800022b8:	ff010113          	addi	sp,sp,-16
    800022bc:	00813423          	sd	s0,8(sp)
    800022c0:	01010413          	addi	s0,sp,16
    800022c4:	300027f3          	csrr	a5,mstatus
    800022c8:	ffffe737          	lui	a4,0xffffe
    800022cc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff790f>
    800022d0:	00e7f7b3          	and	a5,a5,a4
    800022d4:	00001737          	lui	a4,0x1
    800022d8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800022dc:	00e7e7b3          	or	a5,a5,a4
    800022e0:	30079073          	csrw	mstatus,a5
    800022e4:	00000797          	auipc	a5,0x0
    800022e8:	16078793          	addi	a5,a5,352 # 80002444 <system_main>
    800022ec:	34179073          	csrw	mepc,a5
    800022f0:	00000793          	li	a5,0
    800022f4:	18079073          	csrw	satp,a5
    800022f8:	000107b7          	lui	a5,0x10
    800022fc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002300:	30279073          	csrw	medeleg,a5
    80002304:	30379073          	csrw	mideleg,a5
    80002308:	104027f3          	csrr	a5,sie
    8000230c:	2227e793          	ori	a5,a5,546
    80002310:	10479073          	csrw	sie,a5
    80002314:	fff00793          	li	a5,-1
    80002318:	00a7d793          	srli	a5,a5,0xa
    8000231c:	3b079073          	csrw	pmpaddr0,a5
    80002320:	00f00793          	li	a5,15
    80002324:	3a079073          	csrw	pmpcfg0,a5
    80002328:	f14027f3          	csrr	a5,mhartid
    8000232c:	0200c737          	lui	a4,0x200c
    80002330:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002334:	0007869b          	sext.w	a3,a5
    80002338:	00269713          	slli	a4,a3,0x2
    8000233c:	000f4637          	lui	a2,0xf4
    80002340:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002344:	00d70733          	add	a4,a4,a3
    80002348:	0037979b          	slliw	a5,a5,0x3
    8000234c:	020046b7          	lui	a3,0x2004
    80002350:	00d787b3          	add	a5,a5,a3
    80002354:	00c585b3          	add	a1,a1,a2
    80002358:	00371693          	slli	a3,a4,0x3
    8000235c:	00004717          	auipc	a4,0x4
    80002360:	92470713          	addi	a4,a4,-1756 # 80005c80 <timer_scratch>
    80002364:	00b7b023          	sd	a1,0(a5)
    80002368:	00d70733          	add	a4,a4,a3
    8000236c:	00f73c23          	sd	a5,24(a4)
    80002370:	02c73023          	sd	a2,32(a4)
    80002374:	34071073          	csrw	mscratch,a4
    80002378:	00000797          	auipc	a5,0x0
    8000237c:	6e878793          	addi	a5,a5,1768 # 80002a60 <timervec>
    80002380:	30579073          	csrw	mtvec,a5
    80002384:	300027f3          	csrr	a5,mstatus
    80002388:	0087e793          	ori	a5,a5,8
    8000238c:	30079073          	csrw	mstatus,a5
    80002390:	304027f3          	csrr	a5,mie
    80002394:	0807e793          	ori	a5,a5,128
    80002398:	30479073          	csrw	mie,a5
    8000239c:	f14027f3          	csrr	a5,mhartid
    800023a0:	0007879b          	sext.w	a5,a5
    800023a4:	00078213          	mv	tp,a5
    800023a8:	30200073          	mret
    800023ac:	00813403          	ld	s0,8(sp)
    800023b0:	01010113          	addi	sp,sp,16
    800023b4:	00008067          	ret

00000000800023b8 <timerinit>:
    800023b8:	ff010113          	addi	sp,sp,-16
    800023bc:	00813423          	sd	s0,8(sp)
    800023c0:	01010413          	addi	s0,sp,16
    800023c4:	f14027f3          	csrr	a5,mhartid
    800023c8:	0200c737          	lui	a4,0x200c
    800023cc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800023d0:	0007869b          	sext.w	a3,a5
    800023d4:	00269713          	slli	a4,a3,0x2
    800023d8:	000f4637          	lui	a2,0xf4
    800023dc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800023e0:	00d70733          	add	a4,a4,a3
    800023e4:	0037979b          	slliw	a5,a5,0x3
    800023e8:	020046b7          	lui	a3,0x2004
    800023ec:	00d787b3          	add	a5,a5,a3
    800023f0:	00c585b3          	add	a1,a1,a2
    800023f4:	00371693          	slli	a3,a4,0x3
    800023f8:	00004717          	auipc	a4,0x4
    800023fc:	88870713          	addi	a4,a4,-1912 # 80005c80 <timer_scratch>
    80002400:	00b7b023          	sd	a1,0(a5)
    80002404:	00d70733          	add	a4,a4,a3
    80002408:	00f73c23          	sd	a5,24(a4)
    8000240c:	02c73023          	sd	a2,32(a4)
    80002410:	34071073          	csrw	mscratch,a4
    80002414:	00000797          	auipc	a5,0x0
    80002418:	64c78793          	addi	a5,a5,1612 # 80002a60 <timervec>
    8000241c:	30579073          	csrw	mtvec,a5
    80002420:	300027f3          	csrr	a5,mstatus
    80002424:	0087e793          	ori	a5,a5,8
    80002428:	30079073          	csrw	mstatus,a5
    8000242c:	304027f3          	csrr	a5,mie
    80002430:	0807e793          	ori	a5,a5,128
    80002434:	30479073          	csrw	mie,a5
    80002438:	00813403          	ld	s0,8(sp)
    8000243c:	01010113          	addi	sp,sp,16
    80002440:	00008067          	ret

0000000080002444 <system_main>:
    80002444:	fe010113          	addi	sp,sp,-32
    80002448:	00813823          	sd	s0,16(sp)
    8000244c:	00913423          	sd	s1,8(sp)
    80002450:	00113c23          	sd	ra,24(sp)
    80002454:	02010413          	addi	s0,sp,32
    80002458:	00000097          	auipc	ra,0x0
    8000245c:	0c4080e7          	jalr	196(ra) # 8000251c <cpuid>
    80002460:	00003497          	auipc	s1,0x3
    80002464:	7c048493          	addi	s1,s1,1984 # 80005c20 <started>
    80002468:	02050263          	beqz	a0,8000248c <system_main+0x48>
    8000246c:	0004a783          	lw	a5,0(s1)
    80002470:	0007879b          	sext.w	a5,a5
    80002474:	fe078ce3          	beqz	a5,8000246c <system_main+0x28>
    80002478:	0ff0000f          	fence
    8000247c:	00003517          	auipc	a0,0x3
    80002480:	e5c50513          	addi	a0,a0,-420 # 800052d8 <kvmincrease+0xc18>
    80002484:	00001097          	auipc	ra,0x1
    80002488:	a78080e7          	jalr	-1416(ra) # 80002efc <panic>
    8000248c:	00001097          	auipc	ra,0x1
    80002490:	9cc080e7          	jalr	-1588(ra) # 80002e58 <consoleinit>
    80002494:	00001097          	auipc	ra,0x1
    80002498:	158080e7          	jalr	344(ra) # 800035ec <printfinit>
    8000249c:	00003517          	auipc	a0,0x3
    800024a0:	d0c50513          	addi	a0,a0,-756 # 800051a8 <kvmincrease+0xae8>
    800024a4:	00001097          	auipc	ra,0x1
    800024a8:	ab4080e7          	jalr	-1356(ra) # 80002f58 <__printf>
    800024ac:	00003517          	auipc	a0,0x3
    800024b0:	dfc50513          	addi	a0,a0,-516 # 800052a8 <kvmincrease+0xbe8>
    800024b4:	00001097          	auipc	ra,0x1
    800024b8:	aa4080e7          	jalr	-1372(ra) # 80002f58 <__printf>
    800024bc:	00003517          	auipc	a0,0x3
    800024c0:	cec50513          	addi	a0,a0,-788 # 800051a8 <kvmincrease+0xae8>
    800024c4:	00001097          	auipc	ra,0x1
    800024c8:	a94080e7          	jalr	-1388(ra) # 80002f58 <__printf>
    800024cc:	00001097          	auipc	ra,0x1
    800024d0:	4ac080e7          	jalr	1196(ra) # 80003978 <kinit>
    800024d4:	00000097          	auipc	ra,0x0
    800024d8:	148080e7          	jalr	328(ra) # 8000261c <trapinit>
    800024dc:	00000097          	auipc	ra,0x0
    800024e0:	16c080e7          	jalr	364(ra) # 80002648 <trapinithart>
    800024e4:	00000097          	auipc	ra,0x0
    800024e8:	5bc080e7          	jalr	1468(ra) # 80002aa0 <plicinit>
    800024ec:	00000097          	auipc	ra,0x0
    800024f0:	5dc080e7          	jalr	1500(ra) # 80002ac8 <plicinithart>
    800024f4:	00000097          	auipc	ra,0x0
    800024f8:	078080e7          	jalr	120(ra) # 8000256c <userinit>
    800024fc:	0ff0000f          	fence
    80002500:	00100793          	li	a5,1
    80002504:	00003517          	auipc	a0,0x3
    80002508:	dbc50513          	addi	a0,a0,-580 # 800052c0 <kvmincrease+0xc00>
    8000250c:	00f4a023          	sw	a5,0(s1)
    80002510:	00001097          	auipc	ra,0x1
    80002514:	a48080e7          	jalr	-1464(ra) # 80002f58 <__printf>
    80002518:	0000006f          	j	80002518 <system_main+0xd4>

000000008000251c <cpuid>:
    8000251c:	ff010113          	addi	sp,sp,-16
    80002520:	00813423          	sd	s0,8(sp)
    80002524:	01010413          	addi	s0,sp,16
    80002528:	00020513          	mv	a0,tp
    8000252c:	00813403          	ld	s0,8(sp)
    80002530:	0005051b          	sext.w	a0,a0
    80002534:	01010113          	addi	sp,sp,16
    80002538:	00008067          	ret

000000008000253c <mycpu>:
    8000253c:	ff010113          	addi	sp,sp,-16
    80002540:	00813423          	sd	s0,8(sp)
    80002544:	01010413          	addi	s0,sp,16
    80002548:	00020793          	mv	a5,tp
    8000254c:	00813403          	ld	s0,8(sp)
    80002550:	0007879b          	sext.w	a5,a5
    80002554:	00779793          	slli	a5,a5,0x7
    80002558:	00004517          	auipc	a0,0x4
    8000255c:	75850513          	addi	a0,a0,1880 # 80006cb0 <cpus>
    80002560:	00f50533          	add	a0,a0,a5
    80002564:	01010113          	addi	sp,sp,16
    80002568:	00008067          	ret

000000008000256c <userinit>:
    8000256c:	ff010113          	addi	sp,sp,-16
    80002570:	00813423          	sd	s0,8(sp)
    80002574:	01010413          	addi	s0,sp,16
    80002578:	00813403          	ld	s0,8(sp)
    8000257c:	01010113          	addi	sp,sp,16
    80002580:	fffff317          	auipc	t1,0xfffff
    80002584:	0a830067          	jr	168(t1) # 80001628 <main>

0000000080002588 <either_copyout>:
    80002588:	ff010113          	addi	sp,sp,-16
    8000258c:	00813023          	sd	s0,0(sp)
    80002590:	00113423          	sd	ra,8(sp)
    80002594:	01010413          	addi	s0,sp,16
    80002598:	02051663          	bnez	a0,800025c4 <either_copyout+0x3c>
    8000259c:	00058513          	mv	a0,a1
    800025a0:	00060593          	mv	a1,a2
    800025a4:	0006861b          	sext.w	a2,a3
    800025a8:	00002097          	auipc	ra,0x2
    800025ac:	c5c080e7          	jalr	-932(ra) # 80004204 <__memmove>
    800025b0:	00813083          	ld	ra,8(sp)
    800025b4:	00013403          	ld	s0,0(sp)
    800025b8:	00000513          	li	a0,0
    800025bc:	01010113          	addi	sp,sp,16
    800025c0:	00008067          	ret
    800025c4:	00003517          	auipc	a0,0x3
    800025c8:	d3c50513          	addi	a0,a0,-708 # 80005300 <kvmincrease+0xc40>
    800025cc:	00001097          	auipc	ra,0x1
    800025d0:	930080e7          	jalr	-1744(ra) # 80002efc <panic>

00000000800025d4 <either_copyin>:
    800025d4:	ff010113          	addi	sp,sp,-16
    800025d8:	00813023          	sd	s0,0(sp)
    800025dc:	00113423          	sd	ra,8(sp)
    800025e0:	01010413          	addi	s0,sp,16
    800025e4:	02059463          	bnez	a1,8000260c <either_copyin+0x38>
    800025e8:	00060593          	mv	a1,a2
    800025ec:	0006861b          	sext.w	a2,a3
    800025f0:	00002097          	auipc	ra,0x2
    800025f4:	c14080e7          	jalr	-1004(ra) # 80004204 <__memmove>
    800025f8:	00813083          	ld	ra,8(sp)
    800025fc:	00013403          	ld	s0,0(sp)
    80002600:	00000513          	li	a0,0
    80002604:	01010113          	addi	sp,sp,16
    80002608:	00008067          	ret
    8000260c:	00003517          	auipc	a0,0x3
    80002610:	d1c50513          	addi	a0,a0,-740 # 80005328 <kvmincrease+0xc68>
    80002614:	00001097          	auipc	ra,0x1
    80002618:	8e8080e7          	jalr	-1816(ra) # 80002efc <panic>

000000008000261c <trapinit>:
    8000261c:	ff010113          	addi	sp,sp,-16
    80002620:	00813423          	sd	s0,8(sp)
    80002624:	01010413          	addi	s0,sp,16
    80002628:	00813403          	ld	s0,8(sp)
    8000262c:	00003597          	auipc	a1,0x3
    80002630:	d2458593          	addi	a1,a1,-732 # 80005350 <kvmincrease+0xc90>
    80002634:	00004517          	auipc	a0,0x4
    80002638:	6fc50513          	addi	a0,a0,1788 # 80006d30 <tickslock>
    8000263c:	01010113          	addi	sp,sp,16
    80002640:	00001317          	auipc	t1,0x1
    80002644:	5c830067          	jr	1480(t1) # 80003c08 <initlock>

0000000080002648 <trapinithart>:
    80002648:	ff010113          	addi	sp,sp,-16
    8000264c:	00813423          	sd	s0,8(sp)
    80002650:	01010413          	addi	s0,sp,16
    80002654:	00000797          	auipc	a5,0x0
    80002658:	2fc78793          	addi	a5,a5,764 # 80002950 <kernelvec>
    8000265c:	10579073          	csrw	stvec,a5
    80002660:	00813403          	ld	s0,8(sp)
    80002664:	01010113          	addi	sp,sp,16
    80002668:	00008067          	ret

000000008000266c <usertrap>:
    8000266c:	ff010113          	addi	sp,sp,-16
    80002670:	00813423          	sd	s0,8(sp)
    80002674:	01010413          	addi	s0,sp,16
    80002678:	00813403          	ld	s0,8(sp)
    8000267c:	01010113          	addi	sp,sp,16
    80002680:	00008067          	ret

0000000080002684 <usertrapret>:
    80002684:	ff010113          	addi	sp,sp,-16
    80002688:	00813423          	sd	s0,8(sp)
    8000268c:	01010413          	addi	s0,sp,16
    80002690:	00813403          	ld	s0,8(sp)
    80002694:	01010113          	addi	sp,sp,16
    80002698:	00008067          	ret

000000008000269c <kerneltrap>:
    8000269c:	fe010113          	addi	sp,sp,-32
    800026a0:	00813823          	sd	s0,16(sp)
    800026a4:	00113c23          	sd	ra,24(sp)
    800026a8:	00913423          	sd	s1,8(sp)
    800026ac:	02010413          	addi	s0,sp,32
    800026b0:	142025f3          	csrr	a1,scause
    800026b4:	100027f3          	csrr	a5,sstatus
    800026b8:	0027f793          	andi	a5,a5,2
    800026bc:	10079c63          	bnez	a5,800027d4 <kerneltrap+0x138>
    800026c0:	142027f3          	csrr	a5,scause
    800026c4:	0207ce63          	bltz	a5,80002700 <kerneltrap+0x64>
    800026c8:	00003517          	auipc	a0,0x3
    800026cc:	cd050513          	addi	a0,a0,-816 # 80005398 <kvmincrease+0xcd8>
    800026d0:	00001097          	auipc	ra,0x1
    800026d4:	888080e7          	jalr	-1912(ra) # 80002f58 <__printf>
    800026d8:	141025f3          	csrr	a1,sepc
    800026dc:	14302673          	csrr	a2,stval
    800026e0:	00003517          	auipc	a0,0x3
    800026e4:	cc850513          	addi	a0,a0,-824 # 800053a8 <kvmincrease+0xce8>
    800026e8:	00001097          	auipc	ra,0x1
    800026ec:	870080e7          	jalr	-1936(ra) # 80002f58 <__printf>
    800026f0:	00003517          	auipc	a0,0x3
    800026f4:	cd050513          	addi	a0,a0,-816 # 800053c0 <kvmincrease+0xd00>
    800026f8:	00001097          	auipc	ra,0x1
    800026fc:	804080e7          	jalr	-2044(ra) # 80002efc <panic>
    80002700:	0ff7f713          	andi	a4,a5,255
    80002704:	00900693          	li	a3,9
    80002708:	04d70063          	beq	a4,a3,80002748 <kerneltrap+0xac>
    8000270c:	fff00713          	li	a4,-1
    80002710:	03f71713          	slli	a4,a4,0x3f
    80002714:	00170713          	addi	a4,a4,1
    80002718:	fae798e3          	bne	a5,a4,800026c8 <kerneltrap+0x2c>
    8000271c:	00000097          	auipc	ra,0x0
    80002720:	e00080e7          	jalr	-512(ra) # 8000251c <cpuid>
    80002724:	06050663          	beqz	a0,80002790 <kerneltrap+0xf4>
    80002728:	144027f3          	csrr	a5,sip
    8000272c:	ffd7f793          	andi	a5,a5,-3
    80002730:	14479073          	csrw	sip,a5
    80002734:	01813083          	ld	ra,24(sp)
    80002738:	01013403          	ld	s0,16(sp)
    8000273c:	00813483          	ld	s1,8(sp)
    80002740:	02010113          	addi	sp,sp,32
    80002744:	00008067          	ret
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	3cc080e7          	jalr	972(ra) # 80002b14 <plic_claim>
    80002750:	00a00793          	li	a5,10
    80002754:	00050493          	mv	s1,a0
    80002758:	06f50863          	beq	a0,a5,800027c8 <kerneltrap+0x12c>
    8000275c:	fc050ce3          	beqz	a0,80002734 <kerneltrap+0x98>
    80002760:	00050593          	mv	a1,a0
    80002764:	00003517          	auipc	a0,0x3
    80002768:	c1450513          	addi	a0,a0,-1004 # 80005378 <kvmincrease+0xcb8>
    8000276c:	00000097          	auipc	ra,0x0
    80002770:	7ec080e7          	jalr	2028(ra) # 80002f58 <__printf>
    80002774:	01013403          	ld	s0,16(sp)
    80002778:	01813083          	ld	ra,24(sp)
    8000277c:	00048513          	mv	a0,s1
    80002780:	00813483          	ld	s1,8(sp)
    80002784:	02010113          	addi	sp,sp,32
    80002788:	00000317          	auipc	t1,0x0
    8000278c:	3c430067          	jr	964(t1) # 80002b4c <plic_complete>
    80002790:	00004517          	auipc	a0,0x4
    80002794:	5a050513          	addi	a0,a0,1440 # 80006d30 <tickslock>
    80002798:	00001097          	auipc	ra,0x1
    8000279c:	494080e7          	jalr	1172(ra) # 80003c2c <acquire>
    800027a0:	00003717          	auipc	a4,0x3
    800027a4:	48470713          	addi	a4,a4,1156 # 80005c24 <ticks>
    800027a8:	00072783          	lw	a5,0(a4)
    800027ac:	00004517          	auipc	a0,0x4
    800027b0:	58450513          	addi	a0,a0,1412 # 80006d30 <tickslock>
    800027b4:	0017879b          	addiw	a5,a5,1
    800027b8:	00f72023          	sw	a5,0(a4)
    800027bc:	00001097          	auipc	ra,0x1
    800027c0:	53c080e7          	jalr	1340(ra) # 80003cf8 <release>
    800027c4:	f65ff06f          	j	80002728 <kerneltrap+0x8c>
    800027c8:	00001097          	auipc	ra,0x1
    800027cc:	098080e7          	jalr	152(ra) # 80003860 <uartintr>
    800027d0:	fa5ff06f          	j	80002774 <kerneltrap+0xd8>
    800027d4:	00003517          	auipc	a0,0x3
    800027d8:	b8450513          	addi	a0,a0,-1148 # 80005358 <kvmincrease+0xc98>
    800027dc:	00000097          	auipc	ra,0x0
    800027e0:	720080e7          	jalr	1824(ra) # 80002efc <panic>

00000000800027e4 <clockintr>:
    800027e4:	fe010113          	addi	sp,sp,-32
    800027e8:	00813823          	sd	s0,16(sp)
    800027ec:	00913423          	sd	s1,8(sp)
    800027f0:	00113c23          	sd	ra,24(sp)
    800027f4:	02010413          	addi	s0,sp,32
    800027f8:	00004497          	auipc	s1,0x4
    800027fc:	53848493          	addi	s1,s1,1336 # 80006d30 <tickslock>
    80002800:	00048513          	mv	a0,s1
    80002804:	00001097          	auipc	ra,0x1
    80002808:	428080e7          	jalr	1064(ra) # 80003c2c <acquire>
    8000280c:	00003717          	auipc	a4,0x3
    80002810:	41870713          	addi	a4,a4,1048 # 80005c24 <ticks>
    80002814:	00072783          	lw	a5,0(a4)
    80002818:	01013403          	ld	s0,16(sp)
    8000281c:	01813083          	ld	ra,24(sp)
    80002820:	00048513          	mv	a0,s1
    80002824:	0017879b          	addiw	a5,a5,1
    80002828:	00813483          	ld	s1,8(sp)
    8000282c:	00f72023          	sw	a5,0(a4)
    80002830:	02010113          	addi	sp,sp,32
    80002834:	00001317          	auipc	t1,0x1
    80002838:	4c430067          	jr	1220(t1) # 80003cf8 <release>

000000008000283c <devintr>:
    8000283c:	142027f3          	csrr	a5,scause
    80002840:	00000513          	li	a0,0
    80002844:	0007c463          	bltz	a5,8000284c <devintr+0x10>
    80002848:	00008067          	ret
    8000284c:	fe010113          	addi	sp,sp,-32
    80002850:	00813823          	sd	s0,16(sp)
    80002854:	00113c23          	sd	ra,24(sp)
    80002858:	00913423          	sd	s1,8(sp)
    8000285c:	02010413          	addi	s0,sp,32
    80002860:	0ff7f713          	andi	a4,a5,255
    80002864:	00900693          	li	a3,9
    80002868:	04d70c63          	beq	a4,a3,800028c0 <devintr+0x84>
    8000286c:	fff00713          	li	a4,-1
    80002870:	03f71713          	slli	a4,a4,0x3f
    80002874:	00170713          	addi	a4,a4,1
    80002878:	00e78c63          	beq	a5,a4,80002890 <devintr+0x54>
    8000287c:	01813083          	ld	ra,24(sp)
    80002880:	01013403          	ld	s0,16(sp)
    80002884:	00813483          	ld	s1,8(sp)
    80002888:	02010113          	addi	sp,sp,32
    8000288c:	00008067          	ret
    80002890:	00000097          	auipc	ra,0x0
    80002894:	c8c080e7          	jalr	-884(ra) # 8000251c <cpuid>
    80002898:	06050663          	beqz	a0,80002904 <devintr+0xc8>
    8000289c:	144027f3          	csrr	a5,sip
    800028a0:	ffd7f793          	andi	a5,a5,-3
    800028a4:	14479073          	csrw	sip,a5
    800028a8:	01813083          	ld	ra,24(sp)
    800028ac:	01013403          	ld	s0,16(sp)
    800028b0:	00813483          	ld	s1,8(sp)
    800028b4:	00200513          	li	a0,2
    800028b8:	02010113          	addi	sp,sp,32
    800028bc:	00008067          	ret
    800028c0:	00000097          	auipc	ra,0x0
    800028c4:	254080e7          	jalr	596(ra) # 80002b14 <plic_claim>
    800028c8:	00a00793          	li	a5,10
    800028cc:	00050493          	mv	s1,a0
    800028d0:	06f50663          	beq	a0,a5,8000293c <devintr+0x100>
    800028d4:	00100513          	li	a0,1
    800028d8:	fa0482e3          	beqz	s1,8000287c <devintr+0x40>
    800028dc:	00048593          	mv	a1,s1
    800028e0:	00003517          	auipc	a0,0x3
    800028e4:	a9850513          	addi	a0,a0,-1384 # 80005378 <kvmincrease+0xcb8>
    800028e8:	00000097          	auipc	ra,0x0
    800028ec:	670080e7          	jalr	1648(ra) # 80002f58 <__printf>
    800028f0:	00048513          	mv	a0,s1
    800028f4:	00000097          	auipc	ra,0x0
    800028f8:	258080e7          	jalr	600(ra) # 80002b4c <plic_complete>
    800028fc:	00100513          	li	a0,1
    80002900:	f7dff06f          	j	8000287c <devintr+0x40>
    80002904:	00004517          	auipc	a0,0x4
    80002908:	42c50513          	addi	a0,a0,1068 # 80006d30 <tickslock>
    8000290c:	00001097          	auipc	ra,0x1
    80002910:	320080e7          	jalr	800(ra) # 80003c2c <acquire>
    80002914:	00003717          	auipc	a4,0x3
    80002918:	31070713          	addi	a4,a4,784 # 80005c24 <ticks>
    8000291c:	00072783          	lw	a5,0(a4)
    80002920:	00004517          	auipc	a0,0x4
    80002924:	41050513          	addi	a0,a0,1040 # 80006d30 <tickslock>
    80002928:	0017879b          	addiw	a5,a5,1
    8000292c:	00f72023          	sw	a5,0(a4)
    80002930:	00001097          	auipc	ra,0x1
    80002934:	3c8080e7          	jalr	968(ra) # 80003cf8 <release>
    80002938:	f65ff06f          	j	8000289c <devintr+0x60>
    8000293c:	00001097          	auipc	ra,0x1
    80002940:	f24080e7          	jalr	-220(ra) # 80003860 <uartintr>
    80002944:	fadff06f          	j	800028f0 <devintr+0xb4>
	...

0000000080002950 <kernelvec>:
    80002950:	f0010113          	addi	sp,sp,-256
    80002954:	00113023          	sd	ra,0(sp)
    80002958:	00213423          	sd	sp,8(sp)
    8000295c:	00313823          	sd	gp,16(sp)
    80002960:	00413c23          	sd	tp,24(sp)
    80002964:	02513023          	sd	t0,32(sp)
    80002968:	02613423          	sd	t1,40(sp)
    8000296c:	02713823          	sd	t2,48(sp)
    80002970:	02813c23          	sd	s0,56(sp)
    80002974:	04913023          	sd	s1,64(sp)
    80002978:	04a13423          	sd	a0,72(sp)
    8000297c:	04b13823          	sd	a1,80(sp)
    80002980:	04c13c23          	sd	a2,88(sp)
    80002984:	06d13023          	sd	a3,96(sp)
    80002988:	06e13423          	sd	a4,104(sp)
    8000298c:	06f13823          	sd	a5,112(sp)
    80002990:	07013c23          	sd	a6,120(sp)
    80002994:	09113023          	sd	a7,128(sp)
    80002998:	09213423          	sd	s2,136(sp)
    8000299c:	09313823          	sd	s3,144(sp)
    800029a0:	09413c23          	sd	s4,152(sp)
    800029a4:	0b513023          	sd	s5,160(sp)
    800029a8:	0b613423          	sd	s6,168(sp)
    800029ac:	0b713823          	sd	s7,176(sp)
    800029b0:	0b813c23          	sd	s8,184(sp)
    800029b4:	0d913023          	sd	s9,192(sp)
    800029b8:	0da13423          	sd	s10,200(sp)
    800029bc:	0db13823          	sd	s11,208(sp)
    800029c0:	0dc13c23          	sd	t3,216(sp)
    800029c4:	0fd13023          	sd	t4,224(sp)
    800029c8:	0fe13423          	sd	t5,232(sp)
    800029cc:	0ff13823          	sd	t6,240(sp)
    800029d0:	ccdff0ef          	jal	ra,8000269c <kerneltrap>
    800029d4:	00013083          	ld	ra,0(sp)
    800029d8:	00813103          	ld	sp,8(sp)
    800029dc:	01013183          	ld	gp,16(sp)
    800029e0:	02013283          	ld	t0,32(sp)
    800029e4:	02813303          	ld	t1,40(sp)
    800029e8:	03013383          	ld	t2,48(sp)
    800029ec:	03813403          	ld	s0,56(sp)
    800029f0:	04013483          	ld	s1,64(sp)
    800029f4:	04813503          	ld	a0,72(sp)
    800029f8:	05013583          	ld	a1,80(sp)
    800029fc:	05813603          	ld	a2,88(sp)
    80002a00:	06013683          	ld	a3,96(sp)
    80002a04:	06813703          	ld	a4,104(sp)
    80002a08:	07013783          	ld	a5,112(sp)
    80002a0c:	07813803          	ld	a6,120(sp)
    80002a10:	08013883          	ld	a7,128(sp)
    80002a14:	08813903          	ld	s2,136(sp)
    80002a18:	09013983          	ld	s3,144(sp)
    80002a1c:	09813a03          	ld	s4,152(sp)
    80002a20:	0a013a83          	ld	s5,160(sp)
    80002a24:	0a813b03          	ld	s6,168(sp)
    80002a28:	0b013b83          	ld	s7,176(sp)
    80002a2c:	0b813c03          	ld	s8,184(sp)
    80002a30:	0c013c83          	ld	s9,192(sp)
    80002a34:	0c813d03          	ld	s10,200(sp)
    80002a38:	0d013d83          	ld	s11,208(sp)
    80002a3c:	0d813e03          	ld	t3,216(sp)
    80002a40:	0e013e83          	ld	t4,224(sp)
    80002a44:	0e813f03          	ld	t5,232(sp)
    80002a48:	0f013f83          	ld	t6,240(sp)
    80002a4c:	10010113          	addi	sp,sp,256
    80002a50:	10200073          	sret
    80002a54:	00000013          	nop
    80002a58:	00000013          	nop
    80002a5c:	00000013          	nop

0000000080002a60 <timervec>:
    80002a60:	34051573          	csrrw	a0,mscratch,a0
    80002a64:	00b53023          	sd	a1,0(a0)
    80002a68:	00c53423          	sd	a2,8(a0)
    80002a6c:	00d53823          	sd	a3,16(a0)
    80002a70:	01853583          	ld	a1,24(a0)
    80002a74:	02053603          	ld	a2,32(a0)
    80002a78:	0005b683          	ld	a3,0(a1)
    80002a7c:	00c686b3          	add	a3,a3,a2
    80002a80:	00d5b023          	sd	a3,0(a1)
    80002a84:	00200593          	li	a1,2
    80002a88:	14459073          	csrw	sip,a1
    80002a8c:	01053683          	ld	a3,16(a0)
    80002a90:	00853603          	ld	a2,8(a0)
    80002a94:	00053583          	ld	a1,0(a0)
    80002a98:	34051573          	csrrw	a0,mscratch,a0
    80002a9c:	30200073          	mret

0000000080002aa0 <plicinit>:
    80002aa0:	ff010113          	addi	sp,sp,-16
    80002aa4:	00813423          	sd	s0,8(sp)
    80002aa8:	01010413          	addi	s0,sp,16
    80002aac:	00813403          	ld	s0,8(sp)
    80002ab0:	0c0007b7          	lui	a5,0xc000
    80002ab4:	00100713          	li	a4,1
    80002ab8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002abc:	00e7a223          	sw	a4,4(a5)
    80002ac0:	01010113          	addi	sp,sp,16
    80002ac4:	00008067          	ret

0000000080002ac8 <plicinithart>:
    80002ac8:	ff010113          	addi	sp,sp,-16
    80002acc:	00813023          	sd	s0,0(sp)
    80002ad0:	00113423          	sd	ra,8(sp)
    80002ad4:	01010413          	addi	s0,sp,16
    80002ad8:	00000097          	auipc	ra,0x0
    80002adc:	a44080e7          	jalr	-1468(ra) # 8000251c <cpuid>
    80002ae0:	0085171b          	slliw	a4,a0,0x8
    80002ae4:	0c0027b7          	lui	a5,0xc002
    80002ae8:	00e787b3          	add	a5,a5,a4
    80002aec:	40200713          	li	a4,1026
    80002af0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002af4:	00813083          	ld	ra,8(sp)
    80002af8:	00013403          	ld	s0,0(sp)
    80002afc:	00d5151b          	slliw	a0,a0,0xd
    80002b00:	0c2017b7          	lui	a5,0xc201
    80002b04:	00a78533          	add	a0,a5,a0
    80002b08:	00052023          	sw	zero,0(a0)
    80002b0c:	01010113          	addi	sp,sp,16
    80002b10:	00008067          	ret

0000000080002b14 <plic_claim>:
    80002b14:	ff010113          	addi	sp,sp,-16
    80002b18:	00813023          	sd	s0,0(sp)
    80002b1c:	00113423          	sd	ra,8(sp)
    80002b20:	01010413          	addi	s0,sp,16
    80002b24:	00000097          	auipc	ra,0x0
    80002b28:	9f8080e7          	jalr	-1544(ra) # 8000251c <cpuid>
    80002b2c:	00813083          	ld	ra,8(sp)
    80002b30:	00013403          	ld	s0,0(sp)
    80002b34:	00d5151b          	slliw	a0,a0,0xd
    80002b38:	0c2017b7          	lui	a5,0xc201
    80002b3c:	00a78533          	add	a0,a5,a0
    80002b40:	00452503          	lw	a0,4(a0)
    80002b44:	01010113          	addi	sp,sp,16
    80002b48:	00008067          	ret

0000000080002b4c <plic_complete>:
    80002b4c:	fe010113          	addi	sp,sp,-32
    80002b50:	00813823          	sd	s0,16(sp)
    80002b54:	00913423          	sd	s1,8(sp)
    80002b58:	00113c23          	sd	ra,24(sp)
    80002b5c:	02010413          	addi	s0,sp,32
    80002b60:	00050493          	mv	s1,a0
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	9b8080e7          	jalr	-1608(ra) # 8000251c <cpuid>
    80002b6c:	01813083          	ld	ra,24(sp)
    80002b70:	01013403          	ld	s0,16(sp)
    80002b74:	00d5179b          	slliw	a5,a0,0xd
    80002b78:	0c201737          	lui	a4,0xc201
    80002b7c:	00f707b3          	add	a5,a4,a5
    80002b80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002b84:	00813483          	ld	s1,8(sp)
    80002b88:	02010113          	addi	sp,sp,32
    80002b8c:	00008067          	ret

0000000080002b90 <consolewrite>:
    80002b90:	fb010113          	addi	sp,sp,-80
    80002b94:	04813023          	sd	s0,64(sp)
    80002b98:	04113423          	sd	ra,72(sp)
    80002b9c:	02913c23          	sd	s1,56(sp)
    80002ba0:	03213823          	sd	s2,48(sp)
    80002ba4:	03313423          	sd	s3,40(sp)
    80002ba8:	03413023          	sd	s4,32(sp)
    80002bac:	01513c23          	sd	s5,24(sp)
    80002bb0:	05010413          	addi	s0,sp,80
    80002bb4:	06c05c63          	blez	a2,80002c2c <consolewrite+0x9c>
    80002bb8:	00060993          	mv	s3,a2
    80002bbc:	00050a13          	mv	s4,a0
    80002bc0:	00058493          	mv	s1,a1
    80002bc4:	00000913          	li	s2,0
    80002bc8:	fff00a93          	li	s5,-1
    80002bcc:	01c0006f          	j	80002be8 <consolewrite+0x58>
    80002bd0:	fbf44503          	lbu	a0,-65(s0)
    80002bd4:	0019091b          	addiw	s2,s2,1
    80002bd8:	00148493          	addi	s1,s1,1
    80002bdc:	00001097          	auipc	ra,0x1
    80002be0:	a9c080e7          	jalr	-1380(ra) # 80003678 <uartputc>
    80002be4:	03298063          	beq	s3,s2,80002c04 <consolewrite+0x74>
    80002be8:	00048613          	mv	a2,s1
    80002bec:	00100693          	li	a3,1
    80002bf0:	000a0593          	mv	a1,s4
    80002bf4:	fbf40513          	addi	a0,s0,-65
    80002bf8:	00000097          	auipc	ra,0x0
    80002bfc:	9dc080e7          	jalr	-1572(ra) # 800025d4 <either_copyin>
    80002c00:	fd5518e3          	bne	a0,s5,80002bd0 <consolewrite+0x40>
    80002c04:	04813083          	ld	ra,72(sp)
    80002c08:	04013403          	ld	s0,64(sp)
    80002c0c:	03813483          	ld	s1,56(sp)
    80002c10:	02813983          	ld	s3,40(sp)
    80002c14:	02013a03          	ld	s4,32(sp)
    80002c18:	01813a83          	ld	s5,24(sp)
    80002c1c:	00090513          	mv	a0,s2
    80002c20:	03013903          	ld	s2,48(sp)
    80002c24:	05010113          	addi	sp,sp,80
    80002c28:	00008067          	ret
    80002c2c:	00000913          	li	s2,0
    80002c30:	fd5ff06f          	j	80002c04 <consolewrite+0x74>

0000000080002c34 <consoleread>:
    80002c34:	f9010113          	addi	sp,sp,-112
    80002c38:	06813023          	sd	s0,96(sp)
    80002c3c:	04913c23          	sd	s1,88(sp)
    80002c40:	05213823          	sd	s2,80(sp)
    80002c44:	05313423          	sd	s3,72(sp)
    80002c48:	05413023          	sd	s4,64(sp)
    80002c4c:	03513c23          	sd	s5,56(sp)
    80002c50:	03613823          	sd	s6,48(sp)
    80002c54:	03713423          	sd	s7,40(sp)
    80002c58:	03813023          	sd	s8,32(sp)
    80002c5c:	06113423          	sd	ra,104(sp)
    80002c60:	01913c23          	sd	s9,24(sp)
    80002c64:	07010413          	addi	s0,sp,112
    80002c68:	00060b93          	mv	s7,a2
    80002c6c:	00050913          	mv	s2,a0
    80002c70:	00058c13          	mv	s8,a1
    80002c74:	00060b1b          	sext.w	s6,a2
    80002c78:	00004497          	auipc	s1,0x4
    80002c7c:	0e048493          	addi	s1,s1,224 # 80006d58 <cons>
    80002c80:	00400993          	li	s3,4
    80002c84:	fff00a13          	li	s4,-1
    80002c88:	00a00a93          	li	s5,10
    80002c8c:	05705e63          	blez	s7,80002ce8 <consoleread+0xb4>
    80002c90:	09c4a703          	lw	a4,156(s1)
    80002c94:	0984a783          	lw	a5,152(s1)
    80002c98:	0007071b          	sext.w	a4,a4
    80002c9c:	08e78463          	beq	a5,a4,80002d24 <consoleread+0xf0>
    80002ca0:	07f7f713          	andi	a4,a5,127
    80002ca4:	00e48733          	add	a4,s1,a4
    80002ca8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002cac:	0017869b          	addiw	a3,a5,1
    80002cb0:	08d4ac23          	sw	a3,152(s1)
    80002cb4:	00070c9b          	sext.w	s9,a4
    80002cb8:	0b370663          	beq	a4,s3,80002d64 <consoleread+0x130>
    80002cbc:	00100693          	li	a3,1
    80002cc0:	f9f40613          	addi	a2,s0,-97
    80002cc4:	000c0593          	mv	a1,s8
    80002cc8:	00090513          	mv	a0,s2
    80002ccc:	f8e40fa3          	sb	a4,-97(s0)
    80002cd0:	00000097          	auipc	ra,0x0
    80002cd4:	8b8080e7          	jalr	-1864(ra) # 80002588 <either_copyout>
    80002cd8:	01450863          	beq	a0,s4,80002ce8 <consoleread+0xb4>
    80002cdc:	001c0c13          	addi	s8,s8,1
    80002ce0:	fffb8b9b          	addiw	s7,s7,-1
    80002ce4:	fb5c94e3          	bne	s9,s5,80002c8c <consoleread+0x58>
    80002ce8:	000b851b          	sext.w	a0,s7
    80002cec:	06813083          	ld	ra,104(sp)
    80002cf0:	06013403          	ld	s0,96(sp)
    80002cf4:	05813483          	ld	s1,88(sp)
    80002cf8:	05013903          	ld	s2,80(sp)
    80002cfc:	04813983          	ld	s3,72(sp)
    80002d00:	04013a03          	ld	s4,64(sp)
    80002d04:	03813a83          	ld	s5,56(sp)
    80002d08:	02813b83          	ld	s7,40(sp)
    80002d0c:	02013c03          	ld	s8,32(sp)
    80002d10:	01813c83          	ld	s9,24(sp)
    80002d14:	40ab053b          	subw	a0,s6,a0
    80002d18:	03013b03          	ld	s6,48(sp)
    80002d1c:	07010113          	addi	sp,sp,112
    80002d20:	00008067          	ret
    80002d24:	00001097          	auipc	ra,0x1
    80002d28:	1d8080e7          	jalr	472(ra) # 80003efc <push_on>
    80002d2c:	0984a703          	lw	a4,152(s1)
    80002d30:	09c4a783          	lw	a5,156(s1)
    80002d34:	0007879b          	sext.w	a5,a5
    80002d38:	fef70ce3          	beq	a4,a5,80002d30 <consoleread+0xfc>
    80002d3c:	00001097          	auipc	ra,0x1
    80002d40:	234080e7          	jalr	564(ra) # 80003f70 <pop_on>
    80002d44:	0984a783          	lw	a5,152(s1)
    80002d48:	07f7f713          	andi	a4,a5,127
    80002d4c:	00e48733          	add	a4,s1,a4
    80002d50:	01874703          	lbu	a4,24(a4)
    80002d54:	0017869b          	addiw	a3,a5,1
    80002d58:	08d4ac23          	sw	a3,152(s1)
    80002d5c:	00070c9b          	sext.w	s9,a4
    80002d60:	f5371ee3          	bne	a4,s3,80002cbc <consoleread+0x88>
    80002d64:	000b851b          	sext.w	a0,s7
    80002d68:	f96bf2e3          	bgeu	s7,s6,80002cec <consoleread+0xb8>
    80002d6c:	08f4ac23          	sw	a5,152(s1)
    80002d70:	f7dff06f          	j	80002cec <consoleread+0xb8>

0000000080002d74 <consputc>:
    80002d74:	10000793          	li	a5,256
    80002d78:	00f50663          	beq	a0,a5,80002d84 <consputc+0x10>
    80002d7c:	00001317          	auipc	t1,0x1
    80002d80:	9f430067          	jr	-1548(t1) # 80003770 <uartputc_sync>
    80002d84:	ff010113          	addi	sp,sp,-16
    80002d88:	00113423          	sd	ra,8(sp)
    80002d8c:	00813023          	sd	s0,0(sp)
    80002d90:	01010413          	addi	s0,sp,16
    80002d94:	00800513          	li	a0,8
    80002d98:	00001097          	auipc	ra,0x1
    80002d9c:	9d8080e7          	jalr	-1576(ra) # 80003770 <uartputc_sync>
    80002da0:	02000513          	li	a0,32
    80002da4:	00001097          	auipc	ra,0x1
    80002da8:	9cc080e7          	jalr	-1588(ra) # 80003770 <uartputc_sync>
    80002dac:	00013403          	ld	s0,0(sp)
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00800513          	li	a0,8
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00001317          	auipc	t1,0x1
    80002dc0:	9b430067          	jr	-1612(t1) # 80003770 <uartputc_sync>

0000000080002dc4 <consoleintr>:
    80002dc4:	fe010113          	addi	sp,sp,-32
    80002dc8:	00813823          	sd	s0,16(sp)
    80002dcc:	00913423          	sd	s1,8(sp)
    80002dd0:	01213023          	sd	s2,0(sp)
    80002dd4:	00113c23          	sd	ra,24(sp)
    80002dd8:	02010413          	addi	s0,sp,32
    80002ddc:	00004917          	auipc	s2,0x4
    80002de0:	f7c90913          	addi	s2,s2,-132 # 80006d58 <cons>
    80002de4:	00050493          	mv	s1,a0
    80002de8:	00090513          	mv	a0,s2
    80002dec:	00001097          	auipc	ra,0x1
    80002df0:	e40080e7          	jalr	-448(ra) # 80003c2c <acquire>
    80002df4:	02048c63          	beqz	s1,80002e2c <consoleintr+0x68>
    80002df8:	0a092783          	lw	a5,160(s2)
    80002dfc:	09892703          	lw	a4,152(s2)
    80002e00:	07f00693          	li	a3,127
    80002e04:	40e7873b          	subw	a4,a5,a4
    80002e08:	02e6e263          	bltu	a3,a4,80002e2c <consoleintr+0x68>
    80002e0c:	00d00713          	li	a4,13
    80002e10:	04e48063          	beq	s1,a4,80002e50 <consoleintr+0x8c>
    80002e14:	07f7f713          	andi	a4,a5,127
    80002e18:	00e90733          	add	a4,s2,a4
    80002e1c:	0017879b          	addiw	a5,a5,1
    80002e20:	0af92023          	sw	a5,160(s2)
    80002e24:	00970c23          	sb	s1,24(a4)
    80002e28:	08f92e23          	sw	a5,156(s2)
    80002e2c:	01013403          	ld	s0,16(sp)
    80002e30:	01813083          	ld	ra,24(sp)
    80002e34:	00813483          	ld	s1,8(sp)
    80002e38:	00013903          	ld	s2,0(sp)
    80002e3c:	00004517          	auipc	a0,0x4
    80002e40:	f1c50513          	addi	a0,a0,-228 # 80006d58 <cons>
    80002e44:	02010113          	addi	sp,sp,32
    80002e48:	00001317          	auipc	t1,0x1
    80002e4c:	eb030067          	jr	-336(t1) # 80003cf8 <release>
    80002e50:	00a00493          	li	s1,10
    80002e54:	fc1ff06f          	j	80002e14 <consoleintr+0x50>

0000000080002e58 <consoleinit>:
    80002e58:	fe010113          	addi	sp,sp,-32
    80002e5c:	00113c23          	sd	ra,24(sp)
    80002e60:	00813823          	sd	s0,16(sp)
    80002e64:	00913423          	sd	s1,8(sp)
    80002e68:	02010413          	addi	s0,sp,32
    80002e6c:	00004497          	auipc	s1,0x4
    80002e70:	eec48493          	addi	s1,s1,-276 # 80006d58 <cons>
    80002e74:	00048513          	mv	a0,s1
    80002e78:	00002597          	auipc	a1,0x2
    80002e7c:	55858593          	addi	a1,a1,1368 # 800053d0 <kvmincrease+0xd10>
    80002e80:	00001097          	auipc	ra,0x1
    80002e84:	d88080e7          	jalr	-632(ra) # 80003c08 <initlock>
    80002e88:	00000097          	auipc	ra,0x0
    80002e8c:	7ac080e7          	jalr	1964(ra) # 80003634 <uartinit>
    80002e90:	01813083          	ld	ra,24(sp)
    80002e94:	01013403          	ld	s0,16(sp)
    80002e98:	00000797          	auipc	a5,0x0
    80002e9c:	d9c78793          	addi	a5,a5,-612 # 80002c34 <consoleread>
    80002ea0:	0af4bc23          	sd	a5,184(s1)
    80002ea4:	00000797          	auipc	a5,0x0
    80002ea8:	cec78793          	addi	a5,a5,-788 # 80002b90 <consolewrite>
    80002eac:	0cf4b023          	sd	a5,192(s1)
    80002eb0:	00813483          	ld	s1,8(sp)
    80002eb4:	02010113          	addi	sp,sp,32
    80002eb8:	00008067          	ret

0000000080002ebc <console_read>:
    80002ebc:	ff010113          	addi	sp,sp,-16
    80002ec0:	00813423          	sd	s0,8(sp)
    80002ec4:	01010413          	addi	s0,sp,16
    80002ec8:	00813403          	ld	s0,8(sp)
    80002ecc:	00004317          	auipc	t1,0x4
    80002ed0:	f4433303          	ld	t1,-188(t1) # 80006e10 <devsw+0x10>
    80002ed4:	01010113          	addi	sp,sp,16
    80002ed8:	00030067          	jr	t1

0000000080002edc <console_write>:
    80002edc:	ff010113          	addi	sp,sp,-16
    80002ee0:	00813423          	sd	s0,8(sp)
    80002ee4:	01010413          	addi	s0,sp,16
    80002ee8:	00813403          	ld	s0,8(sp)
    80002eec:	00004317          	auipc	t1,0x4
    80002ef0:	f2c33303          	ld	t1,-212(t1) # 80006e18 <devsw+0x18>
    80002ef4:	01010113          	addi	sp,sp,16
    80002ef8:	00030067          	jr	t1

0000000080002efc <panic>:
    80002efc:	fe010113          	addi	sp,sp,-32
    80002f00:	00113c23          	sd	ra,24(sp)
    80002f04:	00813823          	sd	s0,16(sp)
    80002f08:	00913423          	sd	s1,8(sp)
    80002f0c:	02010413          	addi	s0,sp,32
    80002f10:	00050493          	mv	s1,a0
    80002f14:	00002517          	auipc	a0,0x2
    80002f18:	4c450513          	addi	a0,a0,1220 # 800053d8 <kvmincrease+0xd18>
    80002f1c:	00004797          	auipc	a5,0x4
    80002f20:	f807ae23          	sw	zero,-100(a5) # 80006eb8 <pr+0x18>
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	034080e7          	jalr	52(ra) # 80002f58 <__printf>
    80002f2c:	00048513          	mv	a0,s1
    80002f30:	00000097          	auipc	ra,0x0
    80002f34:	028080e7          	jalr	40(ra) # 80002f58 <__printf>
    80002f38:	00002517          	auipc	a0,0x2
    80002f3c:	27050513          	addi	a0,a0,624 # 800051a8 <kvmincrease+0xae8>
    80002f40:	00000097          	auipc	ra,0x0
    80002f44:	018080e7          	jalr	24(ra) # 80002f58 <__printf>
    80002f48:	00100793          	li	a5,1
    80002f4c:	00003717          	auipc	a4,0x3
    80002f50:	ccf72e23          	sw	a5,-804(a4) # 80005c28 <panicked>
    80002f54:	0000006f          	j	80002f54 <panic+0x58>

0000000080002f58 <__printf>:
    80002f58:	f3010113          	addi	sp,sp,-208
    80002f5c:	08813023          	sd	s0,128(sp)
    80002f60:	07313423          	sd	s3,104(sp)
    80002f64:	09010413          	addi	s0,sp,144
    80002f68:	05813023          	sd	s8,64(sp)
    80002f6c:	08113423          	sd	ra,136(sp)
    80002f70:	06913c23          	sd	s1,120(sp)
    80002f74:	07213823          	sd	s2,112(sp)
    80002f78:	07413023          	sd	s4,96(sp)
    80002f7c:	05513c23          	sd	s5,88(sp)
    80002f80:	05613823          	sd	s6,80(sp)
    80002f84:	05713423          	sd	s7,72(sp)
    80002f88:	03913c23          	sd	s9,56(sp)
    80002f8c:	03a13823          	sd	s10,48(sp)
    80002f90:	03b13423          	sd	s11,40(sp)
    80002f94:	00004317          	auipc	t1,0x4
    80002f98:	f0c30313          	addi	t1,t1,-244 # 80006ea0 <pr>
    80002f9c:	01832c03          	lw	s8,24(t1)
    80002fa0:	00b43423          	sd	a1,8(s0)
    80002fa4:	00c43823          	sd	a2,16(s0)
    80002fa8:	00d43c23          	sd	a3,24(s0)
    80002fac:	02e43023          	sd	a4,32(s0)
    80002fb0:	02f43423          	sd	a5,40(s0)
    80002fb4:	03043823          	sd	a6,48(s0)
    80002fb8:	03143c23          	sd	a7,56(s0)
    80002fbc:	00050993          	mv	s3,a0
    80002fc0:	4a0c1663          	bnez	s8,8000346c <__printf+0x514>
    80002fc4:	60098c63          	beqz	s3,800035dc <__printf+0x684>
    80002fc8:	0009c503          	lbu	a0,0(s3)
    80002fcc:	00840793          	addi	a5,s0,8
    80002fd0:	f6f43c23          	sd	a5,-136(s0)
    80002fd4:	00000493          	li	s1,0
    80002fd8:	22050063          	beqz	a0,800031f8 <__printf+0x2a0>
    80002fdc:	00002a37          	lui	s4,0x2
    80002fe0:	00018ab7          	lui	s5,0x18
    80002fe4:	000f4b37          	lui	s6,0xf4
    80002fe8:	00989bb7          	lui	s7,0x989
    80002fec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002ff0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002ff4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002ff8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002ffc:	00148c9b          	addiw	s9,s1,1
    80003000:	02500793          	li	a5,37
    80003004:	01998933          	add	s2,s3,s9
    80003008:	38f51263          	bne	a0,a5,8000338c <__printf+0x434>
    8000300c:	00094783          	lbu	a5,0(s2)
    80003010:	00078c9b          	sext.w	s9,a5
    80003014:	1e078263          	beqz	a5,800031f8 <__printf+0x2a0>
    80003018:	0024849b          	addiw	s1,s1,2
    8000301c:	07000713          	li	a4,112
    80003020:	00998933          	add	s2,s3,s1
    80003024:	38e78a63          	beq	a5,a4,800033b8 <__printf+0x460>
    80003028:	20f76863          	bltu	a4,a5,80003238 <__printf+0x2e0>
    8000302c:	42a78863          	beq	a5,a0,8000345c <__printf+0x504>
    80003030:	06400713          	li	a4,100
    80003034:	40e79663          	bne	a5,a4,80003440 <__printf+0x4e8>
    80003038:	f7843783          	ld	a5,-136(s0)
    8000303c:	0007a603          	lw	a2,0(a5)
    80003040:	00878793          	addi	a5,a5,8
    80003044:	f6f43c23          	sd	a5,-136(s0)
    80003048:	42064a63          	bltz	a2,8000347c <__printf+0x524>
    8000304c:	00a00713          	li	a4,10
    80003050:	02e677bb          	remuw	a5,a2,a4
    80003054:	00002d97          	auipc	s11,0x2
    80003058:	3acd8d93          	addi	s11,s11,940 # 80005400 <digits>
    8000305c:	00900593          	li	a1,9
    80003060:	0006051b          	sext.w	a0,a2
    80003064:	00000c93          	li	s9,0
    80003068:	02079793          	slli	a5,a5,0x20
    8000306c:	0207d793          	srli	a5,a5,0x20
    80003070:	00fd87b3          	add	a5,s11,a5
    80003074:	0007c783          	lbu	a5,0(a5)
    80003078:	02e656bb          	divuw	a3,a2,a4
    8000307c:	f8f40023          	sb	a5,-128(s0)
    80003080:	14c5d863          	bge	a1,a2,800031d0 <__printf+0x278>
    80003084:	06300593          	li	a1,99
    80003088:	00100c93          	li	s9,1
    8000308c:	02e6f7bb          	remuw	a5,a3,a4
    80003090:	02079793          	slli	a5,a5,0x20
    80003094:	0207d793          	srli	a5,a5,0x20
    80003098:	00fd87b3          	add	a5,s11,a5
    8000309c:	0007c783          	lbu	a5,0(a5)
    800030a0:	02e6d73b          	divuw	a4,a3,a4
    800030a4:	f8f400a3          	sb	a5,-127(s0)
    800030a8:	12a5f463          	bgeu	a1,a0,800031d0 <__printf+0x278>
    800030ac:	00a00693          	li	a3,10
    800030b0:	00900593          	li	a1,9
    800030b4:	02d777bb          	remuw	a5,a4,a3
    800030b8:	02079793          	slli	a5,a5,0x20
    800030bc:	0207d793          	srli	a5,a5,0x20
    800030c0:	00fd87b3          	add	a5,s11,a5
    800030c4:	0007c503          	lbu	a0,0(a5)
    800030c8:	02d757bb          	divuw	a5,a4,a3
    800030cc:	f8a40123          	sb	a0,-126(s0)
    800030d0:	48e5f263          	bgeu	a1,a4,80003554 <__printf+0x5fc>
    800030d4:	06300513          	li	a0,99
    800030d8:	02d7f5bb          	remuw	a1,a5,a3
    800030dc:	02059593          	slli	a1,a1,0x20
    800030e0:	0205d593          	srli	a1,a1,0x20
    800030e4:	00bd85b3          	add	a1,s11,a1
    800030e8:	0005c583          	lbu	a1,0(a1)
    800030ec:	02d7d7bb          	divuw	a5,a5,a3
    800030f0:	f8b401a3          	sb	a1,-125(s0)
    800030f4:	48e57263          	bgeu	a0,a4,80003578 <__printf+0x620>
    800030f8:	3e700513          	li	a0,999
    800030fc:	02d7f5bb          	remuw	a1,a5,a3
    80003100:	02059593          	slli	a1,a1,0x20
    80003104:	0205d593          	srli	a1,a1,0x20
    80003108:	00bd85b3          	add	a1,s11,a1
    8000310c:	0005c583          	lbu	a1,0(a1)
    80003110:	02d7d7bb          	divuw	a5,a5,a3
    80003114:	f8b40223          	sb	a1,-124(s0)
    80003118:	46e57663          	bgeu	a0,a4,80003584 <__printf+0x62c>
    8000311c:	02d7f5bb          	remuw	a1,a5,a3
    80003120:	02059593          	slli	a1,a1,0x20
    80003124:	0205d593          	srli	a1,a1,0x20
    80003128:	00bd85b3          	add	a1,s11,a1
    8000312c:	0005c583          	lbu	a1,0(a1)
    80003130:	02d7d7bb          	divuw	a5,a5,a3
    80003134:	f8b402a3          	sb	a1,-123(s0)
    80003138:	46ea7863          	bgeu	s4,a4,800035a8 <__printf+0x650>
    8000313c:	02d7f5bb          	remuw	a1,a5,a3
    80003140:	02059593          	slli	a1,a1,0x20
    80003144:	0205d593          	srli	a1,a1,0x20
    80003148:	00bd85b3          	add	a1,s11,a1
    8000314c:	0005c583          	lbu	a1,0(a1)
    80003150:	02d7d7bb          	divuw	a5,a5,a3
    80003154:	f8b40323          	sb	a1,-122(s0)
    80003158:	3eeaf863          	bgeu	s5,a4,80003548 <__printf+0x5f0>
    8000315c:	02d7f5bb          	remuw	a1,a5,a3
    80003160:	02059593          	slli	a1,a1,0x20
    80003164:	0205d593          	srli	a1,a1,0x20
    80003168:	00bd85b3          	add	a1,s11,a1
    8000316c:	0005c583          	lbu	a1,0(a1)
    80003170:	02d7d7bb          	divuw	a5,a5,a3
    80003174:	f8b403a3          	sb	a1,-121(s0)
    80003178:	42eb7e63          	bgeu	s6,a4,800035b4 <__printf+0x65c>
    8000317c:	02d7f5bb          	remuw	a1,a5,a3
    80003180:	02059593          	slli	a1,a1,0x20
    80003184:	0205d593          	srli	a1,a1,0x20
    80003188:	00bd85b3          	add	a1,s11,a1
    8000318c:	0005c583          	lbu	a1,0(a1)
    80003190:	02d7d7bb          	divuw	a5,a5,a3
    80003194:	f8b40423          	sb	a1,-120(s0)
    80003198:	42ebfc63          	bgeu	s7,a4,800035d0 <__printf+0x678>
    8000319c:	02079793          	slli	a5,a5,0x20
    800031a0:	0207d793          	srli	a5,a5,0x20
    800031a4:	00fd8db3          	add	s11,s11,a5
    800031a8:	000dc703          	lbu	a4,0(s11)
    800031ac:	00a00793          	li	a5,10
    800031b0:	00900c93          	li	s9,9
    800031b4:	f8e404a3          	sb	a4,-119(s0)
    800031b8:	00065c63          	bgez	a2,800031d0 <__printf+0x278>
    800031bc:	f9040713          	addi	a4,s0,-112
    800031c0:	00f70733          	add	a4,a4,a5
    800031c4:	02d00693          	li	a3,45
    800031c8:	fed70823          	sb	a3,-16(a4)
    800031cc:	00078c93          	mv	s9,a5
    800031d0:	f8040793          	addi	a5,s0,-128
    800031d4:	01978cb3          	add	s9,a5,s9
    800031d8:	f7f40d13          	addi	s10,s0,-129
    800031dc:	000cc503          	lbu	a0,0(s9)
    800031e0:	fffc8c93          	addi	s9,s9,-1
    800031e4:	00000097          	auipc	ra,0x0
    800031e8:	b90080e7          	jalr	-1136(ra) # 80002d74 <consputc>
    800031ec:	ffac98e3          	bne	s9,s10,800031dc <__printf+0x284>
    800031f0:	00094503          	lbu	a0,0(s2)
    800031f4:	e00514e3          	bnez	a0,80002ffc <__printf+0xa4>
    800031f8:	1a0c1663          	bnez	s8,800033a4 <__printf+0x44c>
    800031fc:	08813083          	ld	ra,136(sp)
    80003200:	08013403          	ld	s0,128(sp)
    80003204:	07813483          	ld	s1,120(sp)
    80003208:	07013903          	ld	s2,112(sp)
    8000320c:	06813983          	ld	s3,104(sp)
    80003210:	06013a03          	ld	s4,96(sp)
    80003214:	05813a83          	ld	s5,88(sp)
    80003218:	05013b03          	ld	s6,80(sp)
    8000321c:	04813b83          	ld	s7,72(sp)
    80003220:	04013c03          	ld	s8,64(sp)
    80003224:	03813c83          	ld	s9,56(sp)
    80003228:	03013d03          	ld	s10,48(sp)
    8000322c:	02813d83          	ld	s11,40(sp)
    80003230:	0d010113          	addi	sp,sp,208
    80003234:	00008067          	ret
    80003238:	07300713          	li	a4,115
    8000323c:	1ce78a63          	beq	a5,a4,80003410 <__printf+0x4b8>
    80003240:	07800713          	li	a4,120
    80003244:	1ee79e63          	bne	a5,a4,80003440 <__printf+0x4e8>
    80003248:	f7843783          	ld	a5,-136(s0)
    8000324c:	0007a703          	lw	a4,0(a5)
    80003250:	00878793          	addi	a5,a5,8
    80003254:	f6f43c23          	sd	a5,-136(s0)
    80003258:	28074263          	bltz	a4,800034dc <__printf+0x584>
    8000325c:	00002d97          	auipc	s11,0x2
    80003260:	1a4d8d93          	addi	s11,s11,420 # 80005400 <digits>
    80003264:	00f77793          	andi	a5,a4,15
    80003268:	00fd87b3          	add	a5,s11,a5
    8000326c:	0007c683          	lbu	a3,0(a5)
    80003270:	00f00613          	li	a2,15
    80003274:	0007079b          	sext.w	a5,a4
    80003278:	f8d40023          	sb	a3,-128(s0)
    8000327c:	0047559b          	srliw	a1,a4,0x4
    80003280:	0047569b          	srliw	a3,a4,0x4
    80003284:	00000c93          	li	s9,0
    80003288:	0ee65063          	bge	a2,a4,80003368 <__printf+0x410>
    8000328c:	00f6f693          	andi	a3,a3,15
    80003290:	00dd86b3          	add	a3,s11,a3
    80003294:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003298:	0087d79b          	srliw	a5,a5,0x8
    8000329c:	00100c93          	li	s9,1
    800032a0:	f8d400a3          	sb	a3,-127(s0)
    800032a4:	0cb67263          	bgeu	a2,a1,80003368 <__printf+0x410>
    800032a8:	00f7f693          	andi	a3,a5,15
    800032ac:	00dd86b3          	add	a3,s11,a3
    800032b0:	0006c583          	lbu	a1,0(a3)
    800032b4:	00f00613          	li	a2,15
    800032b8:	0047d69b          	srliw	a3,a5,0x4
    800032bc:	f8b40123          	sb	a1,-126(s0)
    800032c0:	0047d593          	srli	a1,a5,0x4
    800032c4:	28f67e63          	bgeu	a2,a5,80003560 <__printf+0x608>
    800032c8:	00f6f693          	andi	a3,a3,15
    800032cc:	00dd86b3          	add	a3,s11,a3
    800032d0:	0006c503          	lbu	a0,0(a3)
    800032d4:	0087d813          	srli	a6,a5,0x8
    800032d8:	0087d69b          	srliw	a3,a5,0x8
    800032dc:	f8a401a3          	sb	a0,-125(s0)
    800032e0:	28b67663          	bgeu	a2,a1,8000356c <__printf+0x614>
    800032e4:	00f6f693          	andi	a3,a3,15
    800032e8:	00dd86b3          	add	a3,s11,a3
    800032ec:	0006c583          	lbu	a1,0(a3)
    800032f0:	00c7d513          	srli	a0,a5,0xc
    800032f4:	00c7d69b          	srliw	a3,a5,0xc
    800032f8:	f8b40223          	sb	a1,-124(s0)
    800032fc:	29067a63          	bgeu	a2,a6,80003590 <__printf+0x638>
    80003300:	00f6f693          	andi	a3,a3,15
    80003304:	00dd86b3          	add	a3,s11,a3
    80003308:	0006c583          	lbu	a1,0(a3)
    8000330c:	0107d813          	srli	a6,a5,0x10
    80003310:	0107d69b          	srliw	a3,a5,0x10
    80003314:	f8b402a3          	sb	a1,-123(s0)
    80003318:	28a67263          	bgeu	a2,a0,8000359c <__printf+0x644>
    8000331c:	00f6f693          	andi	a3,a3,15
    80003320:	00dd86b3          	add	a3,s11,a3
    80003324:	0006c683          	lbu	a3,0(a3)
    80003328:	0147d79b          	srliw	a5,a5,0x14
    8000332c:	f8d40323          	sb	a3,-122(s0)
    80003330:	21067663          	bgeu	a2,a6,8000353c <__printf+0x5e4>
    80003334:	02079793          	slli	a5,a5,0x20
    80003338:	0207d793          	srli	a5,a5,0x20
    8000333c:	00fd8db3          	add	s11,s11,a5
    80003340:	000dc683          	lbu	a3,0(s11)
    80003344:	00800793          	li	a5,8
    80003348:	00700c93          	li	s9,7
    8000334c:	f8d403a3          	sb	a3,-121(s0)
    80003350:	00075c63          	bgez	a4,80003368 <__printf+0x410>
    80003354:	f9040713          	addi	a4,s0,-112
    80003358:	00f70733          	add	a4,a4,a5
    8000335c:	02d00693          	li	a3,45
    80003360:	fed70823          	sb	a3,-16(a4)
    80003364:	00078c93          	mv	s9,a5
    80003368:	f8040793          	addi	a5,s0,-128
    8000336c:	01978cb3          	add	s9,a5,s9
    80003370:	f7f40d13          	addi	s10,s0,-129
    80003374:	000cc503          	lbu	a0,0(s9)
    80003378:	fffc8c93          	addi	s9,s9,-1
    8000337c:	00000097          	auipc	ra,0x0
    80003380:	9f8080e7          	jalr	-1544(ra) # 80002d74 <consputc>
    80003384:	ff9d18e3          	bne	s10,s9,80003374 <__printf+0x41c>
    80003388:	0100006f          	j	80003398 <__printf+0x440>
    8000338c:	00000097          	auipc	ra,0x0
    80003390:	9e8080e7          	jalr	-1560(ra) # 80002d74 <consputc>
    80003394:	000c8493          	mv	s1,s9
    80003398:	00094503          	lbu	a0,0(s2)
    8000339c:	c60510e3          	bnez	a0,80002ffc <__printf+0xa4>
    800033a0:	e40c0ee3          	beqz	s8,800031fc <__printf+0x2a4>
    800033a4:	00004517          	auipc	a0,0x4
    800033a8:	afc50513          	addi	a0,a0,-1284 # 80006ea0 <pr>
    800033ac:	00001097          	auipc	ra,0x1
    800033b0:	94c080e7          	jalr	-1716(ra) # 80003cf8 <release>
    800033b4:	e49ff06f          	j	800031fc <__printf+0x2a4>
    800033b8:	f7843783          	ld	a5,-136(s0)
    800033bc:	03000513          	li	a0,48
    800033c0:	01000d13          	li	s10,16
    800033c4:	00878713          	addi	a4,a5,8
    800033c8:	0007bc83          	ld	s9,0(a5)
    800033cc:	f6e43c23          	sd	a4,-136(s0)
    800033d0:	00000097          	auipc	ra,0x0
    800033d4:	9a4080e7          	jalr	-1628(ra) # 80002d74 <consputc>
    800033d8:	07800513          	li	a0,120
    800033dc:	00000097          	auipc	ra,0x0
    800033e0:	998080e7          	jalr	-1640(ra) # 80002d74 <consputc>
    800033e4:	00002d97          	auipc	s11,0x2
    800033e8:	01cd8d93          	addi	s11,s11,28 # 80005400 <digits>
    800033ec:	03ccd793          	srli	a5,s9,0x3c
    800033f0:	00fd87b3          	add	a5,s11,a5
    800033f4:	0007c503          	lbu	a0,0(a5)
    800033f8:	fffd0d1b          	addiw	s10,s10,-1
    800033fc:	004c9c93          	slli	s9,s9,0x4
    80003400:	00000097          	auipc	ra,0x0
    80003404:	974080e7          	jalr	-1676(ra) # 80002d74 <consputc>
    80003408:	fe0d12e3          	bnez	s10,800033ec <__printf+0x494>
    8000340c:	f8dff06f          	j	80003398 <__printf+0x440>
    80003410:	f7843783          	ld	a5,-136(s0)
    80003414:	0007bc83          	ld	s9,0(a5)
    80003418:	00878793          	addi	a5,a5,8
    8000341c:	f6f43c23          	sd	a5,-136(s0)
    80003420:	000c9a63          	bnez	s9,80003434 <__printf+0x4dc>
    80003424:	1080006f          	j	8000352c <__printf+0x5d4>
    80003428:	001c8c93          	addi	s9,s9,1
    8000342c:	00000097          	auipc	ra,0x0
    80003430:	948080e7          	jalr	-1720(ra) # 80002d74 <consputc>
    80003434:	000cc503          	lbu	a0,0(s9)
    80003438:	fe0518e3          	bnez	a0,80003428 <__printf+0x4d0>
    8000343c:	f5dff06f          	j	80003398 <__printf+0x440>
    80003440:	02500513          	li	a0,37
    80003444:	00000097          	auipc	ra,0x0
    80003448:	930080e7          	jalr	-1744(ra) # 80002d74 <consputc>
    8000344c:	000c8513          	mv	a0,s9
    80003450:	00000097          	auipc	ra,0x0
    80003454:	924080e7          	jalr	-1756(ra) # 80002d74 <consputc>
    80003458:	f41ff06f          	j	80003398 <__printf+0x440>
    8000345c:	02500513          	li	a0,37
    80003460:	00000097          	auipc	ra,0x0
    80003464:	914080e7          	jalr	-1772(ra) # 80002d74 <consputc>
    80003468:	f31ff06f          	j	80003398 <__printf+0x440>
    8000346c:	00030513          	mv	a0,t1
    80003470:	00000097          	auipc	ra,0x0
    80003474:	7bc080e7          	jalr	1980(ra) # 80003c2c <acquire>
    80003478:	b4dff06f          	j	80002fc4 <__printf+0x6c>
    8000347c:	40c0053b          	negw	a0,a2
    80003480:	00a00713          	li	a4,10
    80003484:	02e576bb          	remuw	a3,a0,a4
    80003488:	00002d97          	auipc	s11,0x2
    8000348c:	f78d8d93          	addi	s11,s11,-136 # 80005400 <digits>
    80003490:	ff700593          	li	a1,-9
    80003494:	02069693          	slli	a3,a3,0x20
    80003498:	0206d693          	srli	a3,a3,0x20
    8000349c:	00dd86b3          	add	a3,s11,a3
    800034a0:	0006c683          	lbu	a3,0(a3)
    800034a4:	02e557bb          	divuw	a5,a0,a4
    800034a8:	f8d40023          	sb	a3,-128(s0)
    800034ac:	10b65e63          	bge	a2,a1,800035c8 <__printf+0x670>
    800034b0:	06300593          	li	a1,99
    800034b4:	02e7f6bb          	remuw	a3,a5,a4
    800034b8:	02069693          	slli	a3,a3,0x20
    800034bc:	0206d693          	srli	a3,a3,0x20
    800034c0:	00dd86b3          	add	a3,s11,a3
    800034c4:	0006c683          	lbu	a3,0(a3)
    800034c8:	02e7d73b          	divuw	a4,a5,a4
    800034cc:	00200793          	li	a5,2
    800034d0:	f8d400a3          	sb	a3,-127(s0)
    800034d4:	bca5ece3          	bltu	a1,a0,800030ac <__printf+0x154>
    800034d8:	ce5ff06f          	j	800031bc <__printf+0x264>
    800034dc:	40e007bb          	negw	a5,a4
    800034e0:	00002d97          	auipc	s11,0x2
    800034e4:	f20d8d93          	addi	s11,s11,-224 # 80005400 <digits>
    800034e8:	00f7f693          	andi	a3,a5,15
    800034ec:	00dd86b3          	add	a3,s11,a3
    800034f0:	0006c583          	lbu	a1,0(a3)
    800034f4:	ff100613          	li	a2,-15
    800034f8:	0047d69b          	srliw	a3,a5,0x4
    800034fc:	f8b40023          	sb	a1,-128(s0)
    80003500:	0047d59b          	srliw	a1,a5,0x4
    80003504:	0ac75e63          	bge	a4,a2,800035c0 <__printf+0x668>
    80003508:	00f6f693          	andi	a3,a3,15
    8000350c:	00dd86b3          	add	a3,s11,a3
    80003510:	0006c603          	lbu	a2,0(a3)
    80003514:	00f00693          	li	a3,15
    80003518:	0087d79b          	srliw	a5,a5,0x8
    8000351c:	f8c400a3          	sb	a2,-127(s0)
    80003520:	d8b6e4e3          	bltu	a3,a1,800032a8 <__printf+0x350>
    80003524:	00200793          	li	a5,2
    80003528:	e2dff06f          	j	80003354 <__printf+0x3fc>
    8000352c:	00002c97          	auipc	s9,0x2
    80003530:	eb4c8c93          	addi	s9,s9,-332 # 800053e0 <kvmincrease+0xd20>
    80003534:	02800513          	li	a0,40
    80003538:	ef1ff06f          	j	80003428 <__printf+0x4d0>
    8000353c:	00700793          	li	a5,7
    80003540:	00600c93          	li	s9,6
    80003544:	e0dff06f          	j	80003350 <__printf+0x3f8>
    80003548:	00700793          	li	a5,7
    8000354c:	00600c93          	li	s9,6
    80003550:	c69ff06f          	j	800031b8 <__printf+0x260>
    80003554:	00300793          	li	a5,3
    80003558:	00200c93          	li	s9,2
    8000355c:	c5dff06f          	j	800031b8 <__printf+0x260>
    80003560:	00300793          	li	a5,3
    80003564:	00200c93          	li	s9,2
    80003568:	de9ff06f          	j	80003350 <__printf+0x3f8>
    8000356c:	00400793          	li	a5,4
    80003570:	00300c93          	li	s9,3
    80003574:	dddff06f          	j	80003350 <__printf+0x3f8>
    80003578:	00400793          	li	a5,4
    8000357c:	00300c93          	li	s9,3
    80003580:	c39ff06f          	j	800031b8 <__printf+0x260>
    80003584:	00500793          	li	a5,5
    80003588:	00400c93          	li	s9,4
    8000358c:	c2dff06f          	j	800031b8 <__printf+0x260>
    80003590:	00500793          	li	a5,5
    80003594:	00400c93          	li	s9,4
    80003598:	db9ff06f          	j	80003350 <__printf+0x3f8>
    8000359c:	00600793          	li	a5,6
    800035a0:	00500c93          	li	s9,5
    800035a4:	dadff06f          	j	80003350 <__printf+0x3f8>
    800035a8:	00600793          	li	a5,6
    800035ac:	00500c93          	li	s9,5
    800035b0:	c09ff06f          	j	800031b8 <__printf+0x260>
    800035b4:	00800793          	li	a5,8
    800035b8:	00700c93          	li	s9,7
    800035bc:	bfdff06f          	j	800031b8 <__printf+0x260>
    800035c0:	00100793          	li	a5,1
    800035c4:	d91ff06f          	j	80003354 <__printf+0x3fc>
    800035c8:	00100793          	li	a5,1
    800035cc:	bf1ff06f          	j	800031bc <__printf+0x264>
    800035d0:	00900793          	li	a5,9
    800035d4:	00800c93          	li	s9,8
    800035d8:	be1ff06f          	j	800031b8 <__printf+0x260>
    800035dc:	00002517          	auipc	a0,0x2
    800035e0:	e0c50513          	addi	a0,a0,-500 # 800053e8 <kvmincrease+0xd28>
    800035e4:	00000097          	auipc	ra,0x0
    800035e8:	918080e7          	jalr	-1768(ra) # 80002efc <panic>

00000000800035ec <printfinit>:
    800035ec:	fe010113          	addi	sp,sp,-32
    800035f0:	00813823          	sd	s0,16(sp)
    800035f4:	00913423          	sd	s1,8(sp)
    800035f8:	00113c23          	sd	ra,24(sp)
    800035fc:	02010413          	addi	s0,sp,32
    80003600:	00004497          	auipc	s1,0x4
    80003604:	8a048493          	addi	s1,s1,-1888 # 80006ea0 <pr>
    80003608:	00048513          	mv	a0,s1
    8000360c:	00002597          	auipc	a1,0x2
    80003610:	dec58593          	addi	a1,a1,-532 # 800053f8 <kvmincrease+0xd38>
    80003614:	00000097          	auipc	ra,0x0
    80003618:	5f4080e7          	jalr	1524(ra) # 80003c08 <initlock>
    8000361c:	01813083          	ld	ra,24(sp)
    80003620:	01013403          	ld	s0,16(sp)
    80003624:	0004ac23          	sw	zero,24(s1)
    80003628:	00813483          	ld	s1,8(sp)
    8000362c:	02010113          	addi	sp,sp,32
    80003630:	00008067          	ret

0000000080003634 <uartinit>:
    80003634:	ff010113          	addi	sp,sp,-16
    80003638:	00813423          	sd	s0,8(sp)
    8000363c:	01010413          	addi	s0,sp,16
    80003640:	100007b7          	lui	a5,0x10000
    80003644:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003648:	f8000713          	li	a4,-128
    8000364c:	00e781a3          	sb	a4,3(a5)
    80003650:	00300713          	li	a4,3
    80003654:	00e78023          	sb	a4,0(a5)
    80003658:	000780a3          	sb	zero,1(a5)
    8000365c:	00e781a3          	sb	a4,3(a5)
    80003660:	00700693          	li	a3,7
    80003664:	00d78123          	sb	a3,2(a5)
    80003668:	00e780a3          	sb	a4,1(a5)
    8000366c:	00813403          	ld	s0,8(sp)
    80003670:	01010113          	addi	sp,sp,16
    80003674:	00008067          	ret

0000000080003678 <uartputc>:
    80003678:	00002797          	auipc	a5,0x2
    8000367c:	5b07a783          	lw	a5,1456(a5) # 80005c28 <panicked>
    80003680:	00078463          	beqz	a5,80003688 <uartputc+0x10>
    80003684:	0000006f          	j	80003684 <uartputc+0xc>
    80003688:	fd010113          	addi	sp,sp,-48
    8000368c:	02813023          	sd	s0,32(sp)
    80003690:	00913c23          	sd	s1,24(sp)
    80003694:	01213823          	sd	s2,16(sp)
    80003698:	01313423          	sd	s3,8(sp)
    8000369c:	02113423          	sd	ra,40(sp)
    800036a0:	03010413          	addi	s0,sp,48
    800036a4:	00002917          	auipc	s2,0x2
    800036a8:	58c90913          	addi	s2,s2,1420 # 80005c30 <uart_tx_r>
    800036ac:	00093783          	ld	a5,0(s2)
    800036b0:	00002497          	auipc	s1,0x2
    800036b4:	58848493          	addi	s1,s1,1416 # 80005c38 <uart_tx_w>
    800036b8:	0004b703          	ld	a4,0(s1)
    800036bc:	02078693          	addi	a3,a5,32
    800036c0:	00050993          	mv	s3,a0
    800036c4:	02e69c63          	bne	a3,a4,800036fc <uartputc+0x84>
    800036c8:	00001097          	auipc	ra,0x1
    800036cc:	834080e7          	jalr	-1996(ra) # 80003efc <push_on>
    800036d0:	00093783          	ld	a5,0(s2)
    800036d4:	0004b703          	ld	a4,0(s1)
    800036d8:	02078793          	addi	a5,a5,32
    800036dc:	00e79463          	bne	a5,a4,800036e4 <uartputc+0x6c>
    800036e0:	0000006f          	j	800036e0 <uartputc+0x68>
    800036e4:	00001097          	auipc	ra,0x1
    800036e8:	88c080e7          	jalr	-1908(ra) # 80003f70 <pop_on>
    800036ec:	00093783          	ld	a5,0(s2)
    800036f0:	0004b703          	ld	a4,0(s1)
    800036f4:	02078693          	addi	a3,a5,32
    800036f8:	fce688e3          	beq	a3,a4,800036c8 <uartputc+0x50>
    800036fc:	01f77693          	andi	a3,a4,31
    80003700:	00003597          	auipc	a1,0x3
    80003704:	7c058593          	addi	a1,a1,1984 # 80006ec0 <uart_tx_buf>
    80003708:	00d586b3          	add	a3,a1,a3
    8000370c:	00170713          	addi	a4,a4,1
    80003710:	01368023          	sb	s3,0(a3)
    80003714:	00e4b023          	sd	a4,0(s1)
    80003718:	10000637          	lui	a2,0x10000
    8000371c:	02f71063          	bne	a4,a5,8000373c <uartputc+0xc4>
    80003720:	0340006f          	j	80003754 <uartputc+0xdc>
    80003724:	00074703          	lbu	a4,0(a4)
    80003728:	00f93023          	sd	a5,0(s2)
    8000372c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003730:	00093783          	ld	a5,0(s2)
    80003734:	0004b703          	ld	a4,0(s1)
    80003738:	00f70e63          	beq	a4,a5,80003754 <uartputc+0xdc>
    8000373c:	00564683          	lbu	a3,5(a2)
    80003740:	01f7f713          	andi	a4,a5,31
    80003744:	00e58733          	add	a4,a1,a4
    80003748:	0206f693          	andi	a3,a3,32
    8000374c:	00178793          	addi	a5,a5,1
    80003750:	fc069ae3          	bnez	a3,80003724 <uartputc+0xac>
    80003754:	02813083          	ld	ra,40(sp)
    80003758:	02013403          	ld	s0,32(sp)
    8000375c:	01813483          	ld	s1,24(sp)
    80003760:	01013903          	ld	s2,16(sp)
    80003764:	00813983          	ld	s3,8(sp)
    80003768:	03010113          	addi	sp,sp,48
    8000376c:	00008067          	ret

0000000080003770 <uartputc_sync>:
    80003770:	ff010113          	addi	sp,sp,-16
    80003774:	00813423          	sd	s0,8(sp)
    80003778:	01010413          	addi	s0,sp,16
    8000377c:	00002717          	auipc	a4,0x2
    80003780:	4ac72703          	lw	a4,1196(a4) # 80005c28 <panicked>
    80003784:	02071663          	bnez	a4,800037b0 <uartputc_sync+0x40>
    80003788:	00050793          	mv	a5,a0
    8000378c:	100006b7          	lui	a3,0x10000
    80003790:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003794:	02077713          	andi	a4,a4,32
    80003798:	fe070ce3          	beqz	a4,80003790 <uartputc_sync+0x20>
    8000379c:	0ff7f793          	andi	a5,a5,255
    800037a0:	00f68023          	sb	a5,0(a3)
    800037a4:	00813403          	ld	s0,8(sp)
    800037a8:	01010113          	addi	sp,sp,16
    800037ac:	00008067          	ret
    800037b0:	0000006f          	j	800037b0 <uartputc_sync+0x40>

00000000800037b4 <uartstart>:
    800037b4:	ff010113          	addi	sp,sp,-16
    800037b8:	00813423          	sd	s0,8(sp)
    800037bc:	01010413          	addi	s0,sp,16
    800037c0:	00002617          	auipc	a2,0x2
    800037c4:	47060613          	addi	a2,a2,1136 # 80005c30 <uart_tx_r>
    800037c8:	00002517          	auipc	a0,0x2
    800037cc:	47050513          	addi	a0,a0,1136 # 80005c38 <uart_tx_w>
    800037d0:	00063783          	ld	a5,0(a2)
    800037d4:	00053703          	ld	a4,0(a0)
    800037d8:	04f70263          	beq	a4,a5,8000381c <uartstart+0x68>
    800037dc:	100005b7          	lui	a1,0x10000
    800037e0:	00003817          	auipc	a6,0x3
    800037e4:	6e080813          	addi	a6,a6,1760 # 80006ec0 <uart_tx_buf>
    800037e8:	01c0006f          	j	80003804 <uartstart+0x50>
    800037ec:	0006c703          	lbu	a4,0(a3)
    800037f0:	00f63023          	sd	a5,0(a2)
    800037f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800037f8:	00063783          	ld	a5,0(a2)
    800037fc:	00053703          	ld	a4,0(a0)
    80003800:	00f70e63          	beq	a4,a5,8000381c <uartstart+0x68>
    80003804:	01f7f713          	andi	a4,a5,31
    80003808:	00e806b3          	add	a3,a6,a4
    8000380c:	0055c703          	lbu	a4,5(a1)
    80003810:	00178793          	addi	a5,a5,1
    80003814:	02077713          	andi	a4,a4,32
    80003818:	fc071ae3          	bnez	a4,800037ec <uartstart+0x38>
    8000381c:	00813403          	ld	s0,8(sp)
    80003820:	01010113          	addi	sp,sp,16
    80003824:	00008067          	ret

0000000080003828 <uartgetc>:
    80003828:	ff010113          	addi	sp,sp,-16
    8000382c:	00813423          	sd	s0,8(sp)
    80003830:	01010413          	addi	s0,sp,16
    80003834:	10000737          	lui	a4,0x10000
    80003838:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000383c:	0017f793          	andi	a5,a5,1
    80003840:	00078c63          	beqz	a5,80003858 <uartgetc+0x30>
    80003844:	00074503          	lbu	a0,0(a4)
    80003848:	0ff57513          	andi	a0,a0,255
    8000384c:	00813403          	ld	s0,8(sp)
    80003850:	01010113          	addi	sp,sp,16
    80003854:	00008067          	ret
    80003858:	fff00513          	li	a0,-1
    8000385c:	ff1ff06f          	j	8000384c <uartgetc+0x24>

0000000080003860 <uartintr>:
    80003860:	100007b7          	lui	a5,0x10000
    80003864:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003868:	0017f793          	andi	a5,a5,1
    8000386c:	0a078463          	beqz	a5,80003914 <uartintr+0xb4>
    80003870:	fe010113          	addi	sp,sp,-32
    80003874:	00813823          	sd	s0,16(sp)
    80003878:	00913423          	sd	s1,8(sp)
    8000387c:	00113c23          	sd	ra,24(sp)
    80003880:	02010413          	addi	s0,sp,32
    80003884:	100004b7          	lui	s1,0x10000
    80003888:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000388c:	0ff57513          	andi	a0,a0,255
    80003890:	fffff097          	auipc	ra,0xfffff
    80003894:	534080e7          	jalr	1332(ra) # 80002dc4 <consoleintr>
    80003898:	0054c783          	lbu	a5,5(s1)
    8000389c:	0017f793          	andi	a5,a5,1
    800038a0:	fe0794e3          	bnez	a5,80003888 <uartintr+0x28>
    800038a4:	00002617          	auipc	a2,0x2
    800038a8:	38c60613          	addi	a2,a2,908 # 80005c30 <uart_tx_r>
    800038ac:	00002517          	auipc	a0,0x2
    800038b0:	38c50513          	addi	a0,a0,908 # 80005c38 <uart_tx_w>
    800038b4:	00063783          	ld	a5,0(a2)
    800038b8:	00053703          	ld	a4,0(a0)
    800038bc:	04f70263          	beq	a4,a5,80003900 <uartintr+0xa0>
    800038c0:	100005b7          	lui	a1,0x10000
    800038c4:	00003817          	auipc	a6,0x3
    800038c8:	5fc80813          	addi	a6,a6,1532 # 80006ec0 <uart_tx_buf>
    800038cc:	01c0006f          	j	800038e8 <uartintr+0x88>
    800038d0:	0006c703          	lbu	a4,0(a3)
    800038d4:	00f63023          	sd	a5,0(a2)
    800038d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800038dc:	00063783          	ld	a5,0(a2)
    800038e0:	00053703          	ld	a4,0(a0)
    800038e4:	00f70e63          	beq	a4,a5,80003900 <uartintr+0xa0>
    800038e8:	01f7f713          	andi	a4,a5,31
    800038ec:	00e806b3          	add	a3,a6,a4
    800038f0:	0055c703          	lbu	a4,5(a1)
    800038f4:	00178793          	addi	a5,a5,1
    800038f8:	02077713          	andi	a4,a4,32
    800038fc:	fc071ae3          	bnez	a4,800038d0 <uartintr+0x70>
    80003900:	01813083          	ld	ra,24(sp)
    80003904:	01013403          	ld	s0,16(sp)
    80003908:	00813483          	ld	s1,8(sp)
    8000390c:	02010113          	addi	sp,sp,32
    80003910:	00008067          	ret
    80003914:	00002617          	auipc	a2,0x2
    80003918:	31c60613          	addi	a2,a2,796 # 80005c30 <uart_tx_r>
    8000391c:	00002517          	auipc	a0,0x2
    80003920:	31c50513          	addi	a0,a0,796 # 80005c38 <uart_tx_w>
    80003924:	00063783          	ld	a5,0(a2)
    80003928:	00053703          	ld	a4,0(a0)
    8000392c:	04f70263          	beq	a4,a5,80003970 <uartintr+0x110>
    80003930:	100005b7          	lui	a1,0x10000
    80003934:	00003817          	auipc	a6,0x3
    80003938:	58c80813          	addi	a6,a6,1420 # 80006ec0 <uart_tx_buf>
    8000393c:	01c0006f          	j	80003958 <uartintr+0xf8>
    80003940:	0006c703          	lbu	a4,0(a3)
    80003944:	00f63023          	sd	a5,0(a2)
    80003948:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000394c:	00063783          	ld	a5,0(a2)
    80003950:	00053703          	ld	a4,0(a0)
    80003954:	02f70063          	beq	a4,a5,80003974 <uartintr+0x114>
    80003958:	01f7f713          	andi	a4,a5,31
    8000395c:	00e806b3          	add	a3,a6,a4
    80003960:	0055c703          	lbu	a4,5(a1)
    80003964:	00178793          	addi	a5,a5,1
    80003968:	02077713          	andi	a4,a4,32
    8000396c:	fc071ae3          	bnez	a4,80003940 <uartintr+0xe0>
    80003970:	00008067          	ret
    80003974:	00008067          	ret

0000000080003978 <kinit>:
    80003978:	fc010113          	addi	sp,sp,-64
    8000397c:	02913423          	sd	s1,40(sp)
    80003980:	fffff7b7          	lui	a5,0xfffff
    80003984:	00004497          	auipc	s1,0x4
    80003988:	56b48493          	addi	s1,s1,1387 # 80007eef <end+0xfff>
    8000398c:	02813823          	sd	s0,48(sp)
    80003990:	01313c23          	sd	s3,24(sp)
    80003994:	00f4f4b3          	and	s1,s1,a5
    80003998:	02113c23          	sd	ra,56(sp)
    8000399c:	03213023          	sd	s2,32(sp)
    800039a0:	01413823          	sd	s4,16(sp)
    800039a4:	01513423          	sd	s5,8(sp)
    800039a8:	04010413          	addi	s0,sp,64
    800039ac:	000017b7          	lui	a5,0x1
    800039b0:	01100993          	li	s3,17
    800039b4:	00f487b3          	add	a5,s1,a5
    800039b8:	01b99993          	slli	s3,s3,0x1b
    800039bc:	06f9e063          	bltu	s3,a5,80003a1c <kinit+0xa4>
    800039c0:	00003a97          	auipc	s5,0x3
    800039c4:	530a8a93          	addi	s5,s5,1328 # 80006ef0 <end>
    800039c8:	0754ec63          	bltu	s1,s5,80003a40 <kinit+0xc8>
    800039cc:	0734fa63          	bgeu	s1,s3,80003a40 <kinit+0xc8>
    800039d0:	00088a37          	lui	s4,0x88
    800039d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800039d8:	00002917          	auipc	s2,0x2
    800039dc:	26890913          	addi	s2,s2,616 # 80005c40 <kmem>
    800039e0:	00ca1a13          	slli	s4,s4,0xc
    800039e4:	0140006f          	j	800039f8 <kinit+0x80>
    800039e8:	000017b7          	lui	a5,0x1
    800039ec:	00f484b3          	add	s1,s1,a5
    800039f0:	0554e863          	bltu	s1,s5,80003a40 <kinit+0xc8>
    800039f4:	0534f663          	bgeu	s1,s3,80003a40 <kinit+0xc8>
    800039f8:	00001637          	lui	a2,0x1
    800039fc:	00100593          	li	a1,1
    80003a00:	00048513          	mv	a0,s1
    80003a04:	00000097          	auipc	ra,0x0
    80003a08:	5e4080e7          	jalr	1508(ra) # 80003fe8 <__memset>
    80003a0c:	00093783          	ld	a5,0(s2)
    80003a10:	00f4b023          	sd	a5,0(s1)
    80003a14:	00993023          	sd	s1,0(s2)
    80003a18:	fd4498e3          	bne	s1,s4,800039e8 <kinit+0x70>
    80003a1c:	03813083          	ld	ra,56(sp)
    80003a20:	03013403          	ld	s0,48(sp)
    80003a24:	02813483          	ld	s1,40(sp)
    80003a28:	02013903          	ld	s2,32(sp)
    80003a2c:	01813983          	ld	s3,24(sp)
    80003a30:	01013a03          	ld	s4,16(sp)
    80003a34:	00813a83          	ld	s5,8(sp)
    80003a38:	04010113          	addi	sp,sp,64
    80003a3c:	00008067          	ret
    80003a40:	00002517          	auipc	a0,0x2
    80003a44:	9d850513          	addi	a0,a0,-1576 # 80005418 <digits+0x18>
    80003a48:	fffff097          	auipc	ra,0xfffff
    80003a4c:	4b4080e7          	jalr	1204(ra) # 80002efc <panic>

0000000080003a50 <freerange>:
    80003a50:	fc010113          	addi	sp,sp,-64
    80003a54:	000017b7          	lui	a5,0x1
    80003a58:	02913423          	sd	s1,40(sp)
    80003a5c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003a60:	009504b3          	add	s1,a0,s1
    80003a64:	fffff537          	lui	a0,0xfffff
    80003a68:	02813823          	sd	s0,48(sp)
    80003a6c:	02113c23          	sd	ra,56(sp)
    80003a70:	03213023          	sd	s2,32(sp)
    80003a74:	01313c23          	sd	s3,24(sp)
    80003a78:	01413823          	sd	s4,16(sp)
    80003a7c:	01513423          	sd	s5,8(sp)
    80003a80:	01613023          	sd	s6,0(sp)
    80003a84:	04010413          	addi	s0,sp,64
    80003a88:	00a4f4b3          	and	s1,s1,a0
    80003a8c:	00f487b3          	add	a5,s1,a5
    80003a90:	06f5e463          	bltu	a1,a5,80003af8 <freerange+0xa8>
    80003a94:	00003a97          	auipc	s5,0x3
    80003a98:	45ca8a93          	addi	s5,s5,1116 # 80006ef0 <end>
    80003a9c:	0954e263          	bltu	s1,s5,80003b20 <freerange+0xd0>
    80003aa0:	01100993          	li	s3,17
    80003aa4:	01b99993          	slli	s3,s3,0x1b
    80003aa8:	0734fc63          	bgeu	s1,s3,80003b20 <freerange+0xd0>
    80003aac:	00058a13          	mv	s4,a1
    80003ab0:	00002917          	auipc	s2,0x2
    80003ab4:	19090913          	addi	s2,s2,400 # 80005c40 <kmem>
    80003ab8:	00002b37          	lui	s6,0x2
    80003abc:	0140006f          	j	80003ad0 <freerange+0x80>
    80003ac0:	000017b7          	lui	a5,0x1
    80003ac4:	00f484b3          	add	s1,s1,a5
    80003ac8:	0554ec63          	bltu	s1,s5,80003b20 <freerange+0xd0>
    80003acc:	0534fa63          	bgeu	s1,s3,80003b20 <freerange+0xd0>
    80003ad0:	00001637          	lui	a2,0x1
    80003ad4:	00100593          	li	a1,1
    80003ad8:	00048513          	mv	a0,s1
    80003adc:	00000097          	auipc	ra,0x0
    80003ae0:	50c080e7          	jalr	1292(ra) # 80003fe8 <__memset>
    80003ae4:	00093703          	ld	a4,0(s2)
    80003ae8:	016487b3          	add	a5,s1,s6
    80003aec:	00e4b023          	sd	a4,0(s1)
    80003af0:	00993023          	sd	s1,0(s2)
    80003af4:	fcfa76e3          	bgeu	s4,a5,80003ac0 <freerange+0x70>
    80003af8:	03813083          	ld	ra,56(sp)
    80003afc:	03013403          	ld	s0,48(sp)
    80003b00:	02813483          	ld	s1,40(sp)
    80003b04:	02013903          	ld	s2,32(sp)
    80003b08:	01813983          	ld	s3,24(sp)
    80003b0c:	01013a03          	ld	s4,16(sp)
    80003b10:	00813a83          	ld	s5,8(sp)
    80003b14:	00013b03          	ld	s6,0(sp)
    80003b18:	04010113          	addi	sp,sp,64
    80003b1c:	00008067          	ret
    80003b20:	00002517          	auipc	a0,0x2
    80003b24:	8f850513          	addi	a0,a0,-1800 # 80005418 <digits+0x18>
    80003b28:	fffff097          	auipc	ra,0xfffff
    80003b2c:	3d4080e7          	jalr	980(ra) # 80002efc <panic>

0000000080003b30 <kfree>:
    80003b30:	fe010113          	addi	sp,sp,-32
    80003b34:	00813823          	sd	s0,16(sp)
    80003b38:	00113c23          	sd	ra,24(sp)
    80003b3c:	00913423          	sd	s1,8(sp)
    80003b40:	02010413          	addi	s0,sp,32
    80003b44:	03451793          	slli	a5,a0,0x34
    80003b48:	04079c63          	bnez	a5,80003ba0 <kfree+0x70>
    80003b4c:	00003797          	auipc	a5,0x3
    80003b50:	3a478793          	addi	a5,a5,932 # 80006ef0 <end>
    80003b54:	00050493          	mv	s1,a0
    80003b58:	04f56463          	bltu	a0,a5,80003ba0 <kfree+0x70>
    80003b5c:	01100793          	li	a5,17
    80003b60:	01b79793          	slli	a5,a5,0x1b
    80003b64:	02f57e63          	bgeu	a0,a5,80003ba0 <kfree+0x70>
    80003b68:	00001637          	lui	a2,0x1
    80003b6c:	00100593          	li	a1,1
    80003b70:	00000097          	auipc	ra,0x0
    80003b74:	478080e7          	jalr	1144(ra) # 80003fe8 <__memset>
    80003b78:	00002797          	auipc	a5,0x2
    80003b7c:	0c878793          	addi	a5,a5,200 # 80005c40 <kmem>
    80003b80:	0007b703          	ld	a4,0(a5)
    80003b84:	01813083          	ld	ra,24(sp)
    80003b88:	01013403          	ld	s0,16(sp)
    80003b8c:	00e4b023          	sd	a4,0(s1)
    80003b90:	0097b023          	sd	s1,0(a5)
    80003b94:	00813483          	ld	s1,8(sp)
    80003b98:	02010113          	addi	sp,sp,32
    80003b9c:	00008067          	ret
    80003ba0:	00002517          	auipc	a0,0x2
    80003ba4:	87850513          	addi	a0,a0,-1928 # 80005418 <digits+0x18>
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	354080e7          	jalr	852(ra) # 80002efc <panic>

0000000080003bb0 <kalloc>:
    80003bb0:	fe010113          	addi	sp,sp,-32
    80003bb4:	00813823          	sd	s0,16(sp)
    80003bb8:	00913423          	sd	s1,8(sp)
    80003bbc:	00113c23          	sd	ra,24(sp)
    80003bc0:	02010413          	addi	s0,sp,32
    80003bc4:	00002797          	auipc	a5,0x2
    80003bc8:	07c78793          	addi	a5,a5,124 # 80005c40 <kmem>
    80003bcc:	0007b483          	ld	s1,0(a5)
    80003bd0:	02048063          	beqz	s1,80003bf0 <kalloc+0x40>
    80003bd4:	0004b703          	ld	a4,0(s1)
    80003bd8:	00001637          	lui	a2,0x1
    80003bdc:	00500593          	li	a1,5
    80003be0:	00048513          	mv	a0,s1
    80003be4:	00e7b023          	sd	a4,0(a5)
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	400080e7          	jalr	1024(ra) # 80003fe8 <__memset>
    80003bf0:	01813083          	ld	ra,24(sp)
    80003bf4:	01013403          	ld	s0,16(sp)
    80003bf8:	00048513          	mv	a0,s1
    80003bfc:	00813483          	ld	s1,8(sp)
    80003c00:	02010113          	addi	sp,sp,32
    80003c04:	00008067          	ret

0000000080003c08 <initlock>:
    80003c08:	ff010113          	addi	sp,sp,-16
    80003c0c:	00813423          	sd	s0,8(sp)
    80003c10:	01010413          	addi	s0,sp,16
    80003c14:	00813403          	ld	s0,8(sp)
    80003c18:	00b53423          	sd	a1,8(a0)
    80003c1c:	00052023          	sw	zero,0(a0)
    80003c20:	00053823          	sd	zero,16(a0)
    80003c24:	01010113          	addi	sp,sp,16
    80003c28:	00008067          	ret

0000000080003c2c <acquire>:
    80003c2c:	fe010113          	addi	sp,sp,-32
    80003c30:	00813823          	sd	s0,16(sp)
    80003c34:	00913423          	sd	s1,8(sp)
    80003c38:	00113c23          	sd	ra,24(sp)
    80003c3c:	01213023          	sd	s2,0(sp)
    80003c40:	02010413          	addi	s0,sp,32
    80003c44:	00050493          	mv	s1,a0
    80003c48:	10002973          	csrr	s2,sstatus
    80003c4c:	100027f3          	csrr	a5,sstatus
    80003c50:	ffd7f793          	andi	a5,a5,-3
    80003c54:	10079073          	csrw	sstatus,a5
    80003c58:	fffff097          	auipc	ra,0xfffff
    80003c5c:	8e4080e7          	jalr	-1820(ra) # 8000253c <mycpu>
    80003c60:	07852783          	lw	a5,120(a0)
    80003c64:	06078e63          	beqz	a5,80003ce0 <acquire+0xb4>
    80003c68:	fffff097          	auipc	ra,0xfffff
    80003c6c:	8d4080e7          	jalr	-1836(ra) # 8000253c <mycpu>
    80003c70:	07852783          	lw	a5,120(a0)
    80003c74:	0004a703          	lw	a4,0(s1)
    80003c78:	0017879b          	addiw	a5,a5,1
    80003c7c:	06f52c23          	sw	a5,120(a0)
    80003c80:	04071063          	bnez	a4,80003cc0 <acquire+0x94>
    80003c84:	00100713          	li	a4,1
    80003c88:	00070793          	mv	a5,a4
    80003c8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003c90:	0007879b          	sext.w	a5,a5
    80003c94:	fe079ae3          	bnez	a5,80003c88 <acquire+0x5c>
    80003c98:	0ff0000f          	fence
    80003c9c:	fffff097          	auipc	ra,0xfffff
    80003ca0:	8a0080e7          	jalr	-1888(ra) # 8000253c <mycpu>
    80003ca4:	01813083          	ld	ra,24(sp)
    80003ca8:	01013403          	ld	s0,16(sp)
    80003cac:	00a4b823          	sd	a0,16(s1)
    80003cb0:	00013903          	ld	s2,0(sp)
    80003cb4:	00813483          	ld	s1,8(sp)
    80003cb8:	02010113          	addi	sp,sp,32
    80003cbc:	00008067          	ret
    80003cc0:	0104b903          	ld	s2,16(s1)
    80003cc4:	fffff097          	auipc	ra,0xfffff
    80003cc8:	878080e7          	jalr	-1928(ra) # 8000253c <mycpu>
    80003ccc:	faa91ce3          	bne	s2,a0,80003c84 <acquire+0x58>
    80003cd0:	00001517          	auipc	a0,0x1
    80003cd4:	75050513          	addi	a0,a0,1872 # 80005420 <digits+0x20>
    80003cd8:	fffff097          	auipc	ra,0xfffff
    80003cdc:	224080e7          	jalr	548(ra) # 80002efc <panic>
    80003ce0:	00195913          	srli	s2,s2,0x1
    80003ce4:	fffff097          	auipc	ra,0xfffff
    80003ce8:	858080e7          	jalr	-1960(ra) # 8000253c <mycpu>
    80003cec:	00197913          	andi	s2,s2,1
    80003cf0:	07252e23          	sw	s2,124(a0)
    80003cf4:	f75ff06f          	j	80003c68 <acquire+0x3c>

0000000080003cf8 <release>:
    80003cf8:	fe010113          	addi	sp,sp,-32
    80003cfc:	00813823          	sd	s0,16(sp)
    80003d00:	00113c23          	sd	ra,24(sp)
    80003d04:	00913423          	sd	s1,8(sp)
    80003d08:	01213023          	sd	s2,0(sp)
    80003d0c:	02010413          	addi	s0,sp,32
    80003d10:	00052783          	lw	a5,0(a0)
    80003d14:	00079a63          	bnez	a5,80003d28 <release+0x30>
    80003d18:	00001517          	auipc	a0,0x1
    80003d1c:	71050513          	addi	a0,a0,1808 # 80005428 <digits+0x28>
    80003d20:	fffff097          	auipc	ra,0xfffff
    80003d24:	1dc080e7          	jalr	476(ra) # 80002efc <panic>
    80003d28:	01053903          	ld	s2,16(a0)
    80003d2c:	00050493          	mv	s1,a0
    80003d30:	fffff097          	auipc	ra,0xfffff
    80003d34:	80c080e7          	jalr	-2036(ra) # 8000253c <mycpu>
    80003d38:	fea910e3          	bne	s2,a0,80003d18 <release+0x20>
    80003d3c:	0004b823          	sd	zero,16(s1)
    80003d40:	0ff0000f          	fence
    80003d44:	0f50000f          	fence	iorw,ow
    80003d48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003d4c:	ffffe097          	auipc	ra,0xffffe
    80003d50:	7f0080e7          	jalr	2032(ra) # 8000253c <mycpu>
    80003d54:	100027f3          	csrr	a5,sstatus
    80003d58:	0027f793          	andi	a5,a5,2
    80003d5c:	04079a63          	bnez	a5,80003db0 <release+0xb8>
    80003d60:	07852783          	lw	a5,120(a0)
    80003d64:	02f05e63          	blez	a5,80003da0 <release+0xa8>
    80003d68:	fff7871b          	addiw	a4,a5,-1
    80003d6c:	06e52c23          	sw	a4,120(a0)
    80003d70:	00071c63          	bnez	a4,80003d88 <release+0x90>
    80003d74:	07c52783          	lw	a5,124(a0)
    80003d78:	00078863          	beqz	a5,80003d88 <release+0x90>
    80003d7c:	100027f3          	csrr	a5,sstatus
    80003d80:	0027e793          	ori	a5,a5,2
    80003d84:	10079073          	csrw	sstatus,a5
    80003d88:	01813083          	ld	ra,24(sp)
    80003d8c:	01013403          	ld	s0,16(sp)
    80003d90:	00813483          	ld	s1,8(sp)
    80003d94:	00013903          	ld	s2,0(sp)
    80003d98:	02010113          	addi	sp,sp,32
    80003d9c:	00008067          	ret
    80003da0:	00001517          	auipc	a0,0x1
    80003da4:	6a850513          	addi	a0,a0,1704 # 80005448 <digits+0x48>
    80003da8:	fffff097          	auipc	ra,0xfffff
    80003dac:	154080e7          	jalr	340(ra) # 80002efc <panic>
    80003db0:	00001517          	auipc	a0,0x1
    80003db4:	68050513          	addi	a0,a0,1664 # 80005430 <digits+0x30>
    80003db8:	fffff097          	auipc	ra,0xfffff
    80003dbc:	144080e7          	jalr	324(ra) # 80002efc <panic>

0000000080003dc0 <holding>:
    80003dc0:	00052783          	lw	a5,0(a0)
    80003dc4:	00079663          	bnez	a5,80003dd0 <holding+0x10>
    80003dc8:	00000513          	li	a0,0
    80003dcc:	00008067          	ret
    80003dd0:	fe010113          	addi	sp,sp,-32
    80003dd4:	00813823          	sd	s0,16(sp)
    80003dd8:	00913423          	sd	s1,8(sp)
    80003ddc:	00113c23          	sd	ra,24(sp)
    80003de0:	02010413          	addi	s0,sp,32
    80003de4:	01053483          	ld	s1,16(a0)
    80003de8:	ffffe097          	auipc	ra,0xffffe
    80003dec:	754080e7          	jalr	1876(ra) # 8000253c <mycpu>
    80003df0:	01813083          	ld	ra,24(sp)
    80003df4:	01013403          	ld	s0,16(sp)
    80003df8:	40a48533          	sub	a0,s1,a0
    80003dfc:	00153513          	seqz	a0,a0
    80003e00:	00813483          	ld	s1,8(sp)
    80003e04:	02010113          	addi	sp,sp,32
    80003e08:	00008067          	ret

0000000080003e0c <push_off>:
    80003e0c:	fe010113          	addi	sp,sp,-32
    80003e10:	00813823          	sd	s0,16(sp)
    80003e14:	00113c23          	sd	ra,24(sp)
    80003e18:	00913423          	sd	s1,8(sp)
    80003e1c:	02010413          	addi	s0,sp,32
    80003e20:	100024f3          	csrr	s1,sstatus
    80003e24:	100027f3          	csrr	a5,sstatus
    80003e28:	ffd7f793          	andi	a5,a5,-3
    80003e2c:	10079073          	csrw	sstatus,a5
    80003e30:	ffffe097          	auipc	ra,0xffffe
    80003e34:	70c080e7          	jalr	1804(ra) # 8000253c <mycpu>
    80003e38:	07852783          	lw	a5,120(a0)
    80003e3c:	02078663          	beqz	a5,80003e68 <push_off+0x5c>
    80003e40:	ffffe097          	auipc	ra,0xffffe
    80003e44:	6fc080e7          	jalr	1788(ra) # 8000253c <mycpu>
    80003e48:	07852783          	lw	a5,120(a0)
    80003e4c:	01813083          	ld	ra,24(sp)
    80003e50:	01013403          	ld	s0,16(sp)
    80003e54:	0017879b          	addiw	a5,a5,1
    80003e58:	06f52c23          	sw	a5,120(a0)
    80003e5c:	00813483          	ld	s1,8(sp)
    80003e60:	02010113          	addi	sp,sp,32
    80003e64:	00008067          	ret
    80003e68:	0014d493          	srli	s1,s1,0x1
    80003e6c:	ffffe097          	auipc	ra,0xffffe
    80003e70:	6d0080e7          	jalr	1744(ra) # 8000253c <mycpu>
    80003e74:	0014f493          	andi	s1,s1,1
    80003e78:	06952e23          	sw	s1,124(a0)
    80003e7c:	fc5ff06f          	j	80003e40 <push_off+0x34>

0000000080003e80 <pop_off>:
    80003e80:	ff010113          	addi	sp,sp,-16
    80003e84:	00813023          	sd	s0,0(sp)
    80003e88:	00113423          	sd	ra,8(sp)
    80003e8c:	01010413          	addi	s0,sp,16
    80003e90:	ffffe097          	auipc	ra,0xffffe
    80003e94:	6ac080e7          	jalr	1708(ra) # 8000253c <mycpu>
    80003e98:	100027f3          	csrr	a5,sstatus
    80003e9c:	0027f793          	andi	a5,a5,2
    80003ea0:	04079663          	bnez	a5,80003eec <pop_off+0x6c>
    80003ea4:	07852783          	lw	a5,120(a0)
    80003ea8:	02f05a63          	blez	a5,80003edc <pop_off+0x5c>
    80003eac:	fff7871b          	addiw	a4,a5,-1
    80003eb0:	06e52c23          	sw	a4,120(a0)
    80003eb4:	00071c63          	bnez	a4,80003ecc <pop_off+0x4c>
    80003eb8:	07c52783          	lw	a5,124(a0)
    80003ebc:	00078863          	beqz	a5,80003ecc <pop_off+0x4c>
    80003ec0:	100027f3          	csrr	a5,sstatus
    80003ec4:	0027e793          	ori	a5,a5,2
    80003ec8:	10079073          	csrw	sstatus,a5
    80003ecc:	00813083          	ld	ra,8(sp)
    80003ed0:	00013403          	ld	s0,0(sp)
    80003ed4:	01010113          	addi	sp,sp,16
    80003ed8:	00008067          	ret
    80003edc:	00001517          	auipc	a0,0x1
    80003ee0:	56c50513          	addi	a0,a0,1388 # 80005448 <digits+0x48>
    80003ee4:	fffff097          	auipc	ra,0xfffff
    80003ee8:	018080e7          	jalr	24(ra) # 80002efc <panic>
    80003eec:	00001517          	auipc	a0,0x1
    80003ef0:	54450513          	addi	a0,a0,1348 # 80005430 <digits+0x30>
    80003ef4:	fffff097          	auipc	ra,0xfffff
    80003ef8:	008080e7          	jalr	8(ra) # 80002efc <panic>

0000000080003efc <push_on>:
    80003efc:	fe010113          	addi	sp,sp,-32
    80003f00:	00813823          	sd	s0,16(sp)
    80003f04:	00113c23          	sd	ra,24(sp)
    80003f08:	00913423          	sd	s1,8(sp)
    80003f0c:	02010413          	addi	s0,sp,32
    80003f10:	100024f3          	csrr	s1,sstatus
    80003f14:	100027f3          	csrr	a5,sstatus
    80003f18:	0027e793          	ori	a5,a5,2
    80003f1c:	10079073          	csrw	sstatus,a5
    80003f20:	ffffe097          	auipc	ra,0xffffe
    80003f24:	61c080e7          	jalr	1564(ra) # 8000253c <mycpu>
    80003f28:	07852783          	lw	a5,120(a0)
    80003f2c:	02078663          	beqz	a5,80003f58 <push_on+0x5c>
    80003f30:	ffffe097          	auipc	ra,0xffffe
    80003f34:	60c080e7          	jalr	1548(ra) # 8000253c <mycpu>
    80003f38:	07852783          	lw	a5,120(a0)
    80003f3c:	01813083          	ld	ra,24(sp)
    80003f40:	01013403          	ld	s0,16(sp)
    80003f44:	0017879b          	addiw	a5,a5,1
    80003f48:	06f52c23          	sw	a5,120(a0)
    80003f4c:	00813483          	ld	s1,8(sp)
    80003f50:	02010113          	addi	sp,sp,32
    80003f54:	00008067          	ret
    80003f58:	0014d493          	srli	s1,s1,0x1
    80003f5c:	ffffe097          	auipc	ra,0xffffe
    80003f60:	5e0080e7          	jalr	1504(ra) # 8000253c <mycpu>
    80003f64:	0014f493          	andi	s1,s1,1
    80003f68:	06952e23          	sw	s1,124(a0)
    80003f6c:	fc5ff06f          	j	80003f30 <push_on+0x34>

0000000080003f70 <pop_on>:
    80003f70:	ff010113          	addi	sp,sp,-16
    80003f74:	00813023          	sd	s0,0(sp)
    80003f78:	00113423          	sd	ra,8(sp)
    80003f7c:	01010413          	addi	s0,sp,16
    80003f80:	ffffe097          	auipc	ra,0xffffe
    80003f84:	5bc080e7          	jalr	1468(ra) # 8000253c <mycpu>
    80003f88:	100027f3          	csrr	a5,sstatus
    80003f8c:	0027f793          	andi	a5,a5,2
    80003f90:	04078463          	beqz	a5,80003fd8 <pop_on+0x68>
    80003f94:	07852783          	lw	a5,120(a0)
    80003f98:	02f05863          	blez	a5,80003fc8 <pop_on+0x58>
    80003f9c:	fff7879b          	addiw	a5,a5,-1
    80003fa0:	06f52c23          	sw	a5,120(a0)
    80003fa4:	07853783          	ld	a5,120(a0)
    80003fa8:	00079863          	bnez	a5,80003fb8 <pop_on+0x48>
    80003fac:	100027f3          	csrr	a5,sstatus
    80003fb0:	ffd7f793          	andi	a5,a5,-3
    80003fb4:	10079073          	csrw	sstatus,a5
    80003fb8:	00813083          	ld	ra,8(sp)
    80003fbc:	00013403          	ld	s0,0(sp)
    80003fc0:	01010113          	addi	sp,sp,16
    80003fc4:	00008067          	ret
    80003fc8:	00001517          	auipc	a0,0x1
    80003fcc:	4a850513          	addi	a0,a0,1192 # 80005470 <digits+0x70>
    80003fd0:	fffff097          	auipc	ra,0xfffff
    80003fd4:	f2c080e7          	jalr	-212(ra) # 80002efc <panic>
    80003fd8:	00001517          	auipc	a0,0x1
    80003fdc:	47850513          	addi	a0,a0,1144 # 80005450 <digits+0x50>
    80003fe0:	fffff097          	auipc	ra,0xfffff
    80003fe4:	f1c080e7          	jalr	-228(ra) # 80002efc <panic>

0000000080003fe8 <__memset>:
    80003fe8:	ff010113          	addi	sp,sp,-16
    80003fec:	00813423          	sd	s0,8(sp)
    80003ff0:	01010413          	addi	s0,sp,16
    80003ff4:	1a060e63          	beqz	a2,800041b0 <__memset+0x1c8>
    80003ff8:	40a007b3          	neg	a5,a0
    80003ffc:	0077f793          	andi	a5,a5,7
    80004000:	00778693          	addi	a3,a5,7
    80004004:	00b00813          	li	a6,11
    80004008:	0ff5f593          	andi	a1,a1,255
    8000400c:	fff6071b          	addiw	a4,a2,-1
    80004010:	1b06e663          	bltu	a3,a6,800041bc <__memset+0x1d4>
    80004014:	1cd76463          	bltu	a4,a3,800041dc <__memset+0x1f4>
    80004018:	1a078e63          	beqz	a5,800041d4 <__memset+0x1ec>
    8000401c:	00b50023          	sb	a1,0(a0)
    80004020:	00100713          	li	a4,1
    80004024:	1ae78463          	beq	a5,a4,800041cc <__memset+0x1e4>
    80004028:	00b500a3          	sb	a1,1(a0)
    8000402c:	00200713          	li	a4,2
    80004030:	1ae78a63          	beq	a5,a4,800041e4 <__memset+0x1fc>
    80004034:	00b50123          	sb	a1,2(a0)
    80004038:	00300713          	li	a4,3
    8000403c:	18e78463          	beq	a5,a4,800041c4 <__memset+0x1dc>
    80004040:	00b501a3          	sb	a1,3(a0)
    80004044:	00400713          	li	a4,4
    80004048:	1ae78263          	beq	a5,a4,800041ec <__memset+0x204>
    8000404c:	00b50223          	sb	a1,4(a0)
    80004050:	00500713          	li	a4,5
    80004054:	1ae78063          	beq	a5,a4,800041f4 <__memset+0x20c>
    80004058:	00b502a3          	sb	a1,5(a0)
    8000405c:	00700713          	li	a4,7
    80004060:	18e79e63          	bne	a5,a4,800041fc <__memset+0x214>
    80004064:	00b50323          	sb	a1,6(a0)
    80004068:	00700e93          	li	t4,7
    8000406c:	00859713          	slli	a4,a1,0x8
    80004070:	00e5e733          	or	a4,a1,a4
    80004074:	01059e13          	slli	t3,a1,0x10
    80004078:	01c76e33          	or	t3,a4,t3
    8000407c:	01859313          	slli	t1,a1,0x18
    80004080:	006e6333          	or	t1,t3,t1
    80004084:	02059893          	slli	a7,a1,0x20
    80004088:	40f60e3b          	subw	t3,a2,a5
    8000408c:	011368b3          	or	a7,t1,a7
    80004090:	02859813          	slli	a6,a1,0x28
    80004094:	0108e833          	or	a6,a7,a6
    80004098:	03059693          	slli	a3,a1,0x30
    8000409c:	003e589b          	srliw	a7,t3,0x3
    800040a0:	00d866b3          	or	a3,a6,a3
    800040a4:	03859713          	slli	a4,a1,0x38
    800040a8:	00389813          	slli	a6,a7,0x3
    800040ac:	00f507b3          	add	a5,a0,a5
    800040b0:	00e6e733          	or	a4,a3,a4
    800040b4:	000e089b          	sext.w	a7,t3
    800040b8:	00f806b3          	add	a3,a6,a5
    800040bc:	00e7b023          	sd	a4,0(a5)
    800040c0:	00878793          	addi	a5,a5,8
    800040c4:	fed79ce3          	bne	a5,a3,800040bc <__memset+0xd4>
    800040c8:	ff8e7793          	andi	a5,t3,-8
    800040cc:	0007871b          	sext.w	a4,a5
    800040d0:	01d787bb          	addw	a5,a5,t4
    800040d4:	0ce88e63          	beq	a7,a4,800041b0 <__memset+0x1c8>
    800040d8:	00f50733          	add	a4,a0,a5
    800040dc:	00b70023          	sb	a1,0(a4)
    800040e0:	0017871b          	addiw	a4,a5,1
    800040e4:	0cc77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    800040e8:	00e50733          	add	a4,a0,a4
    800040ec:	00b70023          	sb	a1,0(a4)
    800040f0:	0027871b          	addiw	a4,a5,2
    800040f4:	0ac77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    800040f8:	00e50733          	add	a4,a0,a4
    800040fc:	00b70023          	sb	a1,0(a4)
    80004100:	0037871b          	addiw	a4,a5,3
    80004104:	0ac77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004108:	00e50733          	add	a4,a0,a4
    8000410c:	00b70023          	sb	a1,0(a4)
    80004110:	0047871b          	addiw	a4,a5,4
    80004114:	08c77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004118:	00e50733          	add	a4,a0,a4
    8000411c:	00b70023          	sb	a1,0(a4)
    80004120:	0057871b          	addiw	a4,a5,5
    80004124:	08c77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00b70023          	sb	a1,0(a4)
    80004130:	0067871b          	addiw	a4,a5,6
    80004134:	06c77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004138:	00e50733          	add	a4,a0,a4
    8000413c:	00b70023          	sb	a1,0(a4)
    80004140:	0077871b          	addiw	a4,a5,7
    80004144:	06c77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004148:	00e50733          	add	a4,a0,a4
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	0087871b          	addiw	a4,a5,8
    80004154:	04c77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004158:	00e50733          	add	a4,a0,a4
    8000415c:	00b70023          	sb	a1,0(a4)
    80004160:	0097871b          	addiw	a4,a5,9
    80004164:	04c77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004168:	00e50733          	add	a4,a0,a4
    8000416c:	00b70023          	sb	a1,0(a4)
    80004170:	00a7871b          	addiw	a4,a5,10
    80004174:	02c77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004178:	00e50733          	add	a4,a0,a4
    8000417c:	00b70023          	sb	a1,0(a4)
    80004180:	00b7871b          	addiw	a4,a5,11
    80004184:	02c77663          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004188:	00e50733          	add	a4,a0,a4
    8000418c:	00b70023          	sb	a1,0(a4)
    80004190:	00c7871b          	addiw	a4,a5,12
    80004194:	00c77e63          	bgeu	a4,a2,800041b0 <__memset+0x1c8>
    80004198:	00e50733          	add	a4,a0,a4
    8000419c:	00b70023          	sb	a1,0(a4)
    800041a0:	00d7879b          	addiw	a5,a5,13
    800041a4:	00c7f663          	bgeu	a5,a2,800041b0 <__memset+0x1c8>
    800041a8:	00f507b3          	add	a5,a0,a5
    800041ac:	00b78023          	sb	a1,0(a5)
    800041b0:	00813403          	ld	s0,8(sp)
    800041b4:	01010113          	addi	sp,sp,16
    800041b8:	00008067          	ret
    800041bc:	00b00693          	li	a3,11
    800041c0:	e55ff06f          	j	80004014 <__memset+0x2c>
    800041c4:	00300e93          	li	t4,3
    800041c8:	ea5ff06f          	j	8000406c <__memset+0x84>
    800041cc:	00100e93          	li	t4,1
    800041d0:	e9dff06f          	j	8000406c <__memset+0x84>
    800041d4:	00000e93          	li	t4,0
    800041d8:	e95ff06f          	j	8000406c <__memset+0x84>
    800041dc:	00000793          	li	a5,0
    800041e0:	ef9ff06f          	j	800040d8 <__memset+0xf0>
    800041e4:	00200e93          	li	t4,2
    800041e8:	e85ff06f          	j	8000406c <__memset+0x84>
    800041ec:	00400e93          	li	t4,4
    800041f0:	e7dff06f          	j	8000406c <__memset+0x84>
    800041f4:	00500e93          	li	t4,5
    800041f8:	e75ff06f          	j	8000406c <__memset+0x84>
    800041fc:	00600e93          	li	t4,6
    80004200:	e6dff06f          	j	8000406c <__memset+0x84>

0000000080004204 <__memmove>:
    80004204:	ff010113          	addi	sp,sp,-16
    80004208:	00813423          	sd	s0,8(sp)
    8000420c:	01010413          	addi	s0,sp,16
    80004210:	0e060863          	beqz	a2,80004300 <__memmove+0xfc>
    80004214:	fff6069b          	addiw	a3,a2,-1
    80004218:	0006881b          	sext.w	a6,a3
    8000421c:	0ea5e863          	bltu	a1,a0,8000430c <__memmove+0x108>
    80004220:	00758713          	addi	a4,a1,7
    80004224:	00a5e7b3          	or	a5,a1,a0
    80004228:	40a70733          	sub	a4,a4,a0
    8000422c:	0077f793          	andi	a5,a5,7
    80004230:	00f73713          	sltiu	a4,a4,15
    80004234:	00174713          	xori	a4,a4,1
    80004238:	0017b793          	seqz	a5,a5
    8000423c:	00e7f7b3          	and	a5,a5,a4
    80004240:	10078863          	beqz	a5,80004350 <__memmove+0x14c>
    80004244:	00900793          	li	a5,9
    80004248:	1107f463          	bgeu	a5,a6,80004350 <__memmove+0x14c>
    8000424c:	0036581b          	srliw	a6,a2,0x3
    80004250:	fff8081b          	addiw	a6,a6,-1
    80004254:	02081813          	slli	a6,a6,0x20
    80004258:	01d85893          	srli	a7,a6,0x1d
    8000425c:	00858813          	addi	a6,a1,8
    80004260:	00058793          	mv	a5,a1
    80004264:	00050713          	mv	a4,a0
    80004268:	01088833          	add	a6,a7,a6
    8000426c:	0007b883          	ld	a7,0(a5)
    80004270:	00878793          	addi	a5,a5,8
    80004274:	00870713          	addi	a4,a4,8
    80004278:	ff173c23          	sd	a7,-8(a4)
    8000427c:	ff0798e3          	bne	a5,a6,8000426c <__memmove+0x68>
    80004280:	ff867713          	andi	a4,a2,-8
    80004284:	02071793          	slli	a5,a4,0x20
    80004288:	0207d793          	srli	a5,a5,0x20
    8000428c:	00f585b3          	add	a1,a1,a5
    80004290:	40e686bb          	subw	a3,a3,a4
    80004294:	00f507b3          	add	a5,a0,a5
    80004298:	06e60463          	beq	a2,a4,80004300 <__memmove+0xfc>
    8000429c:	0005c703          	lbu	a4,0(a1)
    800042a0:	00e78023          	sb	a4,0(a5)
    800042a4:	04068e63          	beqz	a3,80004300 <__memmove+0xfc>
    800042a8:	0015c603          	lbu	a2,1(a1)
    800042ac:	00100713          	li	a4,1
    800042b0:	00c780a3          	sb	a2,1(a5)
    800042b4:	04e68663          	beq	a3,a4,80004300 <__memmove+0xfc>
    800042b8:	0025c603          	lbu	a2,2(a1)
    800042bc:	00200713          	li	a4,2
    800042c0:	00c78123          	sb	a2,2(a5)
    800042c4:	02e68e63          	beq	a3,a4,80004300 <__memmove+0xfc>
    800042c8:	0035c603          	lbu	a2,3(a1)
    800042cc:	00300713          	li	a4,3
    800042d0:	00c781a3          	sb	a2,3(a5)
    800042d4:	02e68663          	beq	a3,a4,80004300 <__memmove+0xfc>
    800042d8:	0045c603          	lbu	a2,4(a1)
    800042dc:	00400713          	li	a4,4
    800042e0:	00c78223          	sb	a2,4(a5)
    800042e4:	00e68e63          	beq	a3,a4,80004300 <__memmove+0xfc>
    800042e8:	0055c603          	lbu	a2,5(a1)
    800042ec:	00500713          	li	a4,5
    800042f0:	00c782a3          	sb	a2,5(a5)
    800042f4:	00e68663          	beq	a3,a4,80004300 <__memmove+0xfc>
    800042f8:	0065c703          	lbu	a4,6(a1)
    800042fc:	00e78323          	sb	a4,6(a5)
    80004300:	00813403          	ld	s0,8(sp)
    80004304:	01010113          	addi	sp,sp,16
    80004308:	00008067          	ret
    8000430c:	02061713          	slli	a4,a2,0x20
    80004310:	02075713          	srli	a4,a4,0x20
    80004314:	00e587b3          	add	a5,a1,a4
    80004318:	f0f574e3          	bgeu	a0,a5,80004220 <__memmove+0x1c>
    8000431c:	02069613          	slli	a2,a3,0x20
    80004320:	02065613          	srli	a2,a2,0x20
    80004324:	fff64613          	not	a2,a2
    80004328:	00e50733          	add	a4,a0,a4
    8000432c:	00c78633          	add	a2,a5,a2
    80004330:	fff7c683          	lbu	a3,-1(a5)
    80004334:	fff78793          	addi	a5,a5,-1
    80004338:	fff70713          	addi	a4,a4,-1
    8000433c:	00d70023          	sb	a3,0(a4)
    80004340:	fec798e3          	bne	a5,a2,80004330 <__memmove+0x12c>
    80004344:	00813403          	ld	s0,8(sp)
    80004348:	01010113          	addi	sp,sp,16
    8000434c:	00008067          	ret
    80004350:	02069713          	slli	a4,a3,0x20
    80004354:	02075713          	srli	a4,a4,0x20
    80004358:	00170713          	addi	a4,a4,1
    8000435c:	00e50733          	add	a4,a0,a4
    80004360:	00050793          	mv	a5,a0
    80004364:	0005c683          	lbu	a3,0(a1)
    80004368:	00178793          	addi	a5,a5,1
    8000436c:	00158593          	addi	a1,a1,1
    80004370:	fed78fa3          	sb	a3,-1(a5)
    80004374:	fee798e3          	bne	a5,a4,80004364 <__memmove+0x160>
    80004378:	f89ff06f          	j	80004300 <__memmove+0xfc>

000000008000437c <__mem_free>:
    8000437c:	ff010113          	addi	sp,sp,-16
    80004380:	00813423          	sd	s0,8(sp)
    80004384:	01010413          	addi	s0,sp,16
    80004388:	00002597          	auipc	a1,0x2
    8000438c:	8c058593          	addi	a1,a1,-1856 # 80005c48 <freep>
    80004390:	0005b783          	ld	a5,0(a1)
    80004394:	ff050693          	addi	a3,a0,-16
    80004398:	0007b703          	ld	a4,0(a5)
    8000439c:	00d7fc63          	bgeu	a5,a3,800043b4 <__mem_free+0x38>
    800043a0:	00e6ee63          	bltu	a3,a4,800043bc <__mem_free+0x40>
    800043a4:	00e7fc63          	bgeu	a5,a4,800043bc <__mem_free+0x40>
    800043a8:	00070793          	mv	a5,a4
    800043ac:	0007b703          	ld	a4,0(a5)
    800043b0:	fed7e8e3          	bltu	a5,a3,800043a0 <__mem_free+0x24>
    800043b4:	fee7eae3          	bltu	a5,a4,800043a8 <__mem_free+0x2c>
    800043b8:	fee6f8e3          	bgeu	a3,a4,800043a8 <__mem_free+0x2c>
    800043bc:	ff852803          	lw	a6,-8(a0)
    800043c0:	02081613          	slli	a2,a6,0x20
    800043c4:	01c65613          	srli	a2,a2,0x1c
    800043c8:	00c68633          	add	a2,a3,a2
    800043cc:	02c70a63          	beq	a4,a2,80004400 <__mem_free+0x84>
    800043d0:	fee53823          	sd	a4,-16(a0)
    800043d4:	0087a503          	lw	a0,8(a5)
    800043d8:	02051613          	slli	a2,a0,0x20
    800043dc:	01c65613          	srli	a2,a2,0x1c
    800043e0:	00c78633          	add	a2,a5,a2
    800043e4:	04c68263          	beq	a3,a2,80004428 <__mem_free+0xac>
    800043e8:	00813403          	ld	s0,8(sp)
    800043ec:	00d7b023          	sd	a3,0(a5)
    800043f0:	00f5b023          	sd	a5,0(a1)
    800043f4:	00000513          	li	a0,0
    800043f8:	01010113          	addi	sp,sp,16
    800043fc:	00008067          	ret
    80004400:	00872603          	lw	a2,8(a4)
    80004404:	00073703          	ld	a4,0(a4)
    80004408:	0106083b          	addw	a6,a2,a6
    8000440c:	ff052c23          	sw	a6,-8(a0)
    80004410:	fee53823          	sd	a4,-16(a0)
    80004414:	0087a503          	lw	a0,8(a5)
    80004418:	02051613          	slli	a2,a0,0x20
    8000441c:	01c65613          	srli	a2,a2,0x1c
    80004420:	00c78633          	add	a2,a5,a2
    80004424:	fcc692e3          	bne	a3,a2,800043e8 <__mem_free+0x6c>
    80004428:	00813403          	ld	s0,8(sp)
    8000442c:	0105053b          	addw	a0,a0,a6
    80004430:	00a7a423          	sw	a0,8(a5)
    80004434:	00e7b023          	sd	a4,0(a5)
    80004438:	00f5b023          	sd	a5,0(a1)
    8000443c:	00000513          	li	a0,0
    80004440:	01010113          	addi	sp,sp,16
    80004444:	00008067          	ret

0000000080004448 <__mem_alloc>:
    80004448:	fc010113          	addi	sp,sp,-64
    8000444c:	02813823          	sd	s0,48(sp)
    80004450:	02913423          	sd	s1,40(sp)
    80004454:	03213023          	sd	s2,32(sp)
    80004458:	01513423          	sd	s5,8(sp)
    8000445c:	02113c23          	sd	ra,56(sp)
    80004460:	01313c23          	sd	s3,24(sp)
    80004464:	01413823          	sd	s4,16(sp)
    80004468:	01613023          	sd	s6,0(sp)
    8000446c:	04010413          	addi	s0,sp,64
    80004470:	00001a97          	auipc	s5,0x1
    80004474:	7d8a8a93          	addi	s5,s5,2008 # 80005c48 <freep>
    80004478:	00f50913          	addi	s2,a0,15
    8000447c:	000ab683          	ld	a3,0(s5)
    80004480:	00495913          	srli	s2,s2,0x4
    80004484:	0019049b          	addiw	s1,s2,1
    80004488:	00048913          	mv	s2,s1
    8000448c:	0c068c63          	beqz	a3,80004564 <__mem_alloc+0x11c>
    80004490:	0006b503          	ld	a0,0(a3)
    80004494:	00852703          	lw	a4,8(a0)
    80004498:	10977063          	bgeu	a4,s1,80004598 <__mem_alloc+0x150>
    8000449c:	000017b7          	lui	a5,0x1
    800044a0:	0009099b          	sext.w	s3,s2
    800044a4:	0af4e863          	bltu	s1,a5,80004554 <__mem_alloc+0x10c>
    800044a8:	02099a13          	slli	s4,s3,0x20
    800044ac:	01ca5a13          	srli	s4,s4,0x1c
    800044b0:	fff00b13          	li	s6,-1
    800044b4:	0100006f          	j	800044c4 <__mem_alloc+0x7c>
    800044b8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    800044bc:	00852703          	lw	a4,8(a0)
    800044c0:	04977463          	bgeu	a4,s1,80004508 <__mem_alloc+0xc0>
    800044c4:	00050793          	mv	a5,a0
    800044c8:	fea698e3          	bne	a3,a0,800044b8 <__mem_alloc+0x70>
    800044cc:	000a0513          	mv	a0,s4
    800044d0:	00000097          	auipc	ra,0x0
    800044d4:	1f0080e7          	jalr	496(ra) # 800046c0 <kvmincrease>
    800044d8:	00050793          	mv	a5,a0
    800044dc:	01050513          	addi	a0,a0,16
    800044e0:	07678e63          	beq	a5,s6,8000455c <__mem_alloc+0x114>
    800044e4:	0137a423          	sw	s3,8(a5)
    800044e8:	00000097          	auipc	ra,0x0
    800044ec:	e94080e7          	jalr	-364(ra) # 8000437c <__mem_free>
    800044f0:	000ab783          	ld	a5,0(s5)
    800044f4:	06078463          	beqz	a5,8000455c <__mem_alloc+0x114>
    800044f8:	0007b503          	ld	a0,0(a5)
    800044fc:	00078693          	mv	a3,a5
    80004500:	00852703          	lw	a4,8(a0)
    80004504:	fc9760e3          	bltu	a4,s1,800044c4 <__mem_alloc+0x7c>
    80004508:	08e48263          	beq	s1,a4,8000458c <__mem_alloc+0x144>
    8000450c:	4127073b          	subw	a4,a4,s2
    80004510:	02071693          	slli	a3,a4,0x20
    80004514:	01c6d693          	srli	a3,a3,0x1c
    80004518:	00e52423          	sw	a4,8(a0)
    8000451c:	00d50533          	add	a0,a0,a3
    80004520:	01252423          	sw	s2,8(a0)
    80004524:	00fab023          	sd	a5,0(s5)
    80004528:	01050513          	addi	a0,a0,16
    8000452c:	03813083          	ld	ra,56(sp)
    80004530:	03013403          	ld	s0,48(sp)
    80004534:	02813483          	ld	s1,40(sp)
    80004538:	02013903          	ld	s2,32(sp)
    8000453c:	01813983          	ld	s3,24(sp)
    80004540:	01013a03          	ld	s4,16(sp)
    80004544:	00813a83          	ld	s5,8(sp)
    80004548:	00013b03          	ld	s6,0(sp)
    8000454c:	04010113          	addi	sp,sp,64
    80004550:	00008067          	ret
    80004554:	000019b7          	lui	s3,0x1
    80004558:	f51ff06f          	j	800044a8 <__mem_alloc+0x60>
    8000455c:	00000513          	li	a0,0
    80004560:	fcdff06f          	j	8000452c <__mem_alloc+0xe4>
    80004564:	00003797          	auipc	a5,0x3
    80004568:	97c78793          	addi	a5,a5,-1668 # 80006ee0 <base>
    8000456c:	00078513          	mv	a0,a5
    80004570:	00fab023          	sd	a5,0(s5)
    80004574:	00f7b023          	sd	a5,0(a5)
    80004578:	00000713          	li	a4,0
    8000457c:	00003797          	auipc	a5,0x3
    80004580:	9607a623          	sw	zero,-1684(a5) # 80006ee8 <base+0x8>
    80004584:	00050693          	mv	a3,a0
    80004588:	f11ff06f          	j	80004498 <__mem_alloc+0x50>
    8000458c:	00053703          	ld	a4,0(a0)
    80004590:	00e7b023          	sd	a4,0(a5)
    80004594:	f91ff06f          	j	80004524 <__mem_alloc+0xdc>
    80004598:	00068793          	mv	a5,a3
    8000459c:	f6dff06f          	j	80004508 <__mem_alloc+0xc0>

00000000800045a0 <__putc>:
    800045a0:	fe010113          	addi	sp,sp,-32
    800045a4:	00813823          	sd	s0,16(sp)
    800045a8:	00113c23          	sd	ra,24(sp)
    800045ac:	02010413          	addi	s0,sp,32
    800045b0:	00050793          	mv	a5,a0
    800045b4:	fef40593          	addi	a1,s0,-17
    800045b8:	00100613          	li	a2,1
    800045bc:	00000513          	li	a0,0
    800045c0:	fef407a3          	sb	a5,-17(s0)
    800045c4:	fffff097          	auipc	ra,0xfffff
    800045c8:	918080e7          	jalr	-1768(ra) # 80002edc <console_write>
    800045cc:	01813083          	ld	ra,24(sp)
    800045d0:	01013403          	ld	s0,16(sp)
    800045d4:	02010113          	addi	sp,sp,32
    800045d8:	00008067          	ret

00000000800045dc <__getc>:
    800045dc:	fe010113          	addi	sp,sp,-32
    800045e0:	00813823          	sd	s0,16(sp)
    800045e4:	00113c23          	sd	ra,24(sp)
    800045e8:	02010413          	addi	s0,sp,32
    800045ec:	fe840593          	addi	a1,s0,-24
    800045f0:	00100613          	li	a2,1
    800045f4:	00000513          	li	a0,0
    800045f8:	fffff097          	auipc	ra,0xfffff
    800045fc:	8c4080e7          	jalr	-1852(ra) # 80002ebc <console_read>
    80004600:	fe844503          	lbu	a0,-24(s0)
    80004604:	01813083          	ld	ra,24(sp)
    80004608:	01013403          	ld	s0,16(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret

0000000080004614 <console_handler>:
    80004614:	fe010113          	addi	sp,sp,-32
    80004618:	00813823          	sd	s0,16(sp)
    8000461c:	00113c23          	sd	ra,24(sp)
    80004620:	00913423          	sd	s1,8(sp)
    80004624:	02010413          	addi	s0,sp,32
    80004628:	14202773          	csrr	a4,scause
    8000462c:	100027f3          	csrr	a5,sstatus
    80004630:	0027f793          	andi	a5,a5,2
    80004634:	06079e63          	bnez	a5,800046b0 <console_handler+0x9c>
    80004638:	00074c63          	bltz	a4,80004650 <console_handler+0x3c>
    8000463c:	01813083          	ld	ra,24(sp)
    80004640:	01013403          	ld	s0,16(sp)
    80004644:	00813483          	ld	s1,8(sp)
    80004648:	02010113          	addi	sp,sp,32
    8000464c:	00008067          	ret
    80004650:	0ff77713          	andi	a4,a4,255
    80004654:	00900793          	li	a5,9
    80004658:	fef712e3          	bne	a4,a5,8000463c <console_handler+0x28>
    8000465c:	ffffe097          	auipc	ra,0xffffe
    80004660:	4b8080e7          	jalr	1208(ra) # 80002b14 <plic_claim>
    80004664:	00a00793          	li	a5,10
    80004668:	00050493          	mv	s1,a0
    8000466c:	02f50c63          	beq	a0,a5,800046a4 <console_handler+0x90>
    80004670:	fc0506e3          	beqz	a0,8000463c <console_handler+0x28>
    80004674:	00050593          	mv	a1,a0
    80004678:	00001517          	auipc	a0,0x1
    8000467c:	d0050513          	addi	a0,a0,-768 # 80005378 <kvmincrease+0xcb8>
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	8d8080e7          	jalr	-1832(ra) # 80002f58 <__printf>
    80004688:	01013403          	ld	s0,16(sp)
    8000468c:	01813083          	ld	ra,24(sp)
    80004690:	00048513          	mv	a0,s1
    80004694:	00813483          	ld	s1,8(sp)
    80004698:	02010113          	addi	sp,sp,32
    8000469c:	ffffe317          	auipc	t1,0xffffe
    800046a0:	4b030067          	jr	1200(t1) # 80002b4c <plic_complete>
    800046a4:	fffff097          	auipc	ra,0xfffff
    800046a8:	1bc080e7          	jalr	444(ra) # 80003860 <uartintr>
    800046ac:	fddff06f          	j	80004688 <console_handler+0x74>
    800046b0:	00001517          	auipc	a0,0x1
    800046b4:	dc850513          	addi	a0,a0,-568 # 80005478 <digits+0x78>
    800046b8:	fffff097          	auipc	ra,0xfffff
    800046bc:	844080e7          	jalr	-1980(ra) # 80002efc <panic>

00000000800046c0 <kvmincrease>:
    800046c0:	fe010113          	addi	sp,sp,-32
    800046c4:	01213023          	sd	s2,0(sp)
    800046c8:	00001937          	lui	s2,0x1
    800046cc:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    800046d0:	00813823          	sd	s0,16(sp)
    800046d4:	00113c23          	sd	ra,24(sp)
    800046d8:	00913423          	sd	s1,8(sp)
    800046dc:	02010413          	addi	s0,sp,32
    800046e0:	01250933          	add	s2,a0,s2
    800046e4:	00c95913          	srli	s2,s2,0xc
    800046e8:	02090863          	beqz	s2,80004718 <kvmincrease+0x58>
    800046ec:	00000493          	li	s1,0
    800046f0:	00148493          	addi	s1,s1,1
    800046f4:	fffff097          	auipc	ra,0xfffff
    800046f8:	4bc080e7          	jalr	1212(ra) # 80003bb0 <kalloc>
    800046fc:	fe991ae3          	bne	s2,s1,800046f0 <kvmincrease+0x30>
    80004700:	01813083          	ld	ra,24(sp)
    80004704:	01013403          	ld	s0,16(sp)
    80004708:	00813483          	ld	s1,8(sp)
    8000470c:	00013903          	ld	s2,0(sp)
    80004710:	02010113          	addi	sp,sp,32
    80004714:	00008067          	ret
    80004718:	01813083          	ld	ra,24(sp)
    8000471c:	01013403          	ld	s0,16(sp)
    80004720:	00813483          	ld	s1,8(sp)
    80004724:	00013903          	ld	s2,0(sp)
    80004728:	00000513          	li	a0,0
    8000472c:	02010113          	addi	sp,sp,32
    80004730:	00008067          	ret
	...
