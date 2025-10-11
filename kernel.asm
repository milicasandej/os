
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	be813103          	ld	sp,-1048(sp) # 80005be8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	278020ef          	jal	ra,80002294 <start>

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
    800010a4:	6d4000ef          	jal	ra,80001778 <_ZN5Riscv20handleSupervisorTrapEv>

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
    80001158:	2d4080e7          	jalr	724(ra) # 80004428 <__mem_alloc>
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
    80001180:	1e0080e7          	jalr	480(ra) # 8000435c <__mem_free>
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
    800012d4:	2ec080e7          	jalr	748(ra) # 800045bc <__getc>
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
    800012fc:	288080e7          	jalr	648(ra) # 80004580 <__putc>
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
    8000133c:	330080e7          	jalr	816(ra) # 80001668 <_Znwm>
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
    80001358:	33c080e7          	jalr	828(ra) # 80001690 <_Znam>
    8000135c:	0080006f          	j	80001364 <_ZN7_thread12createThreadEPFvvEPv+0x54>
    80001360:	00000513          	li	a0,0
            finished(false)
    80001364:	00a4b823          	sd	a0,16(s1)
    80001368:	00000797          	auipc	a5,0x0
    8000136c:	0e078793          	addi	a5,a5,224 # 80001448 <_ZN7_thread13threadWrapperEv>
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
    80001394:	5bc080e7          	jalr	1468(ra) # 8000194c <_ZN9Scheduler3putEP7_thread>
    80001398:	0280006f          	j	800013c0 <_ZN7_thread12createThreadEPFvvEPv+0xb0>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    8000139c:	00000793          	li	a5,0
    800013a0:	fe1ff06f          	j	80001380 <_ZN7_thread12createThreadEPFvvEPv+0x70>
    800013a4:	00050913          	mv	s2,a0
    800013a8:	00048513          	mv	a0,s1
    800013ac:	00000097          	auipc	ra,0x0
    800013b0:	30c080e7          	jalr	780(ra) # 800016b8 <_ZdlPv>
    800013b4:	00090513          	mv	a0,s2
    800013b8:	00006097          	auipc	ra,0x6
    800013bc:	980080e7          	jalr	-1664(ra) # 80006d38 <_Unwind_Resume>
    return newThread;
}
    800013c0:	00048513          	mv	a0,s1
    800013c4:	02813083          	ld	ra,40(sp)
    800013c8:	02013403          	ld	s0,32(sp)
    800013cc:	01813483          	ld	s1,24(sp)
    800013d0:	01013903          	ld	s2,16(sp)
    800013d4:	00813983          	ld	s3,8(sp)
    800013d8:	03010113          	addi	sp,sp,48
    800013dc:	00008067          	ret

00000000800013e0 <_ZN7_thread8dispatchEv>:

void _thread::dispatch()
{
    800013e0:	fe010113          	addi	sp,sp,-32
    800013e4:	00113c23          	sd	ra,24(sp)
    800013e8:	00813823          	sd	s0,16(sp)
    800013ec:	00913423          	sd	s1,8(sp)
    800013f0:	02010413          	addi	s0,sp,32
    _thread *old = running;
    800013f4:	00005497          	auipc	s1,0x5
    800013f8:	84c4b483          	ld	s1,-1972(s1) # 80005c40 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    800013fc:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished()) { Scheduler::put(old); }
    80001400:	02078c63          	beqz	a5,80001438 <_ZN7_thread8dispatchEv+0x58>
    running = Scheduler::get();
    80001404:	00000097          	auipc	ra,0x0
    80001408:	4e0080e7          	jalr	1248(ra) # 800018e4 <_ZN9Scheduler3getEv>
    8000140c:	00005797          	auipc	a5,0x5
    80001410:	82a7ba23          	sd	a0,-1996(a5) # 80005c40 <_ZN7_thread7runningE>

    _thread::contextSwitch(&old->context, &running->context);
    80001414:	01850593          	addi	a1,a0,24 # 8018 <_entry-0x7fff7fe8>
    80001418:	01848513          	addi	a0,s1,24
    8000141c:	00000097          	auipc	ra,0x0
    80001420:	d14080e7          	jalr	-748(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001424:	01813083          	ld	ra,24(sp)
    80001428:	01013403          	ld	s0,16(sp)
    8000142c:	00813483          	ld	s1,8(sp)
    80001430:	02010113          	addi	sp,sp,32
    80001434:	00008067          	ret
    if (!old->isFinished()) { Scheduler::put(old); }
    80001438:	00048513          	mv	a0,s1
    8000143c:	00000097          	auipc	ra,0x0
    80001440:	510080e7          	jalr	1296(ra) # 8000194c <_ZN9Scheduler3putEP7_thread>
    80001444:	fc1ff06f          	j	80001404 <_ZN7_thread8dispatchEv+0x24>

0000000080001448 <_ZN7_thread13threadWrapperEv>:

void _thread::threadWrapper()
{
    80001448:	fe010113          	addi	sp,sp,-32
    8000144c:	00113c23          	sd	ra,24(sp)
    80001450:	00813823          	sd	s0,16(sp)
    80001454:	00913423          	sd	s1,8(sp)
    80001458:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    8000145c:	00000097          	auipc	ra,0x0
    80001460:	2fc080e7          	jalr	764(ra) # 80001758 <_ZN5Riscv10popSppSpieEv>
    running->body();
    80001464:	00004497          	auipc	s1,0x4
    80001468:	7dc48493          	addi	s1,s1,2012 # 80005c40 <_ZN7_thread7runningE>
    8000146c:	0004b783          	ld	a5,0(s1)
    80001470:	0007b783          	ld	a5,0(a5)
    80001474:	000780e7          	jalr	a5
    running->setFinished(true);
    80001478:	0004b783          	ld	a5,0(s1)
    void setFinished(bool value) { finished = value; }
    8000147c:	00100713          	li	a4,1
    80001480:	02e78823          	sb	a4,48(a5)
    _thread::dispatch();
    80001484:	00000097          	auipc	ra,0x0
    80001488:	f5c080e7          	jalr	-164(ra) # 800013e0 <_ZN7_thread8dispatchEv>
}
    8000148c:	01813083          	ld	ra,24(sp)
    80001490:	01013403          	ld	s0,16(sp)
    80001494:	00813483          	ld	s1,8(sp)
    80001498:	02010113          	addi	sp,sp,32
    8000149c:	00008067          	ret

00000000800014a0 <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014a0:	ff010113          	addi	sp,sp,-16
    800014a4:	00113423          	sd	ra,8(sp)
    800014a8:	00813023          	sd	s0,0(sp)
    800014ac:	01010413          	addi	s0,sp,16
    800014b0:	00004797          	auipc	a5,0x4
    800014b4:	7907b783          	ld	a5,1936(a5) # 80005c40 <_ZN7_thread7runningE>
    800014b8:	00100713          	li	a4,1
    800014bc:	02e78823          	sb	a4,48(a5)
    _thread::running->setFinished(true);
    _thread::dispatch();
    800014c0:	00000097          	auipc	ra,0x0
    800014c4:	f20080e7          	jalr	-224(ra) # 800013e0 <_ZN7_thread8dispatchEv>
    return 0;
}
    800014c8:	00000513          	li	a0,0
    800014cc:	00813083          	ld	ra,8(sp)
    800014d0:	00013403          	ld	s0,0(sp)
    800014d4:	01010113          	addi	sp,sp,16
    800014d8:	00008067          	ret

00000000800014dc <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    800014dc:	fe010113          	addi	sp,sp,-32
    800014e0:	00113c23          	sd	ra,24(sp)
    800014e4:	00813823          	sd	s0,16(sp)
    800014e8:	00913423          	sd	s1,8(sp)
    800014ec:	01213023          	sd	s2,0(sp)
    800014f0:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    800014f4:	00004517          	auipc	a0,0x4
    800014f8:	b0c50513          	addi	a0,a0,-1268 # 80005000 <kvmincrease+0x960>
    800014fc:	00001097          	auipc	ra,0x1
    80001500:	ac8080e7          	jalr	-1336(ra) # 80001fc4 <_Z11printStringPKc>
    int test = getc() - '0';
    80001504:	00000097          	auipc	ra,0x0
    80001508:	dbc080e7          	jalr	-580(ra) # 800012c0 <_Z4getcv>
    8000150c:	0005091b          	sext.w	s2,a0
    80001510:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001514:	00000097          	auipc	ra,0x0
    80001518:	dac080e7          	jalr	-596(ra) # 800012c0 <_Z4getcv>
            printString("Nije navedeno da je zadatak 2 implementiran\n");
            return;
        }
    }

    if (test >= 3 && test <= 4) {
    8000151c:	fcd9071b          	addiw	a4,s2,-51
    80001520:	00100793          	li	a5,1
    80001524:	04e7f263          	bgeu	a5,a4,80001568 <_Z8userMainv+0x8c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001528:	fcb9091b          	addiw	s2,s2,-53
    8000152c:	00100793          	li	a5,1
    80001530:	0727f063          	bgeu	a5,s2,80001590 <_Z8userMainv+0xb4>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001534:	00600793          	li	a5,6
    80001538:	0697c663          	blt	a5,s1,800015a4 <_Z8userMainv+0xc8>
    8000153c:	00300793          	li	a5,3
    80001540:	02f4dc63          	bge	s1,a5,80001578 <_Z8userMainv+0x9c>
    80001544:	00100793          	li	a5,1
    80001548:	08f48463          	beq	s1,a5,800015d0 <_Z8userMainv+0xf4>
    8000154c:	00200793          	li	a5,2
    80001550:	08f49e63          	bne	s1,a5,800015ec <_Z8userMainv+0x110>
#endif
            break;
        case 2:
#if LEVEL_2_IMPLEMENTED == 1
//            Threads_CPP_API_test();
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001554:	00004517          	auipc	a0,0x4
    80001558:	b6c50513          	addi	a0,a0,-1172 # 800050c0 <kvmincrease+0xa20>
    8000155c:	00001097          	auipc	ra,0x1
    80001560:	a68080e7          	jalr	-1432(ra) # 80001fc4 <_Z11printStringPKc>
#endif
            break;
    80001564:	0140006f          	j	80001578 <_Z8userMainv+0x9c>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
    80001568:	00004517          	auipc	a0,0x4
    8000156c:	ab850513          	addi	a0,a0,-1352 # 80005020 <kvmincrease+0x980>
    80001570:	00001097          	auipc	ra,0x1
    80001574:	a54080e7          	jalr	-1452(ra) # 80001fc4 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80001578:	01813083          	ld	ra,24(sp)
    8000157c:	01013403          	ld	s0,16(sp)
    80001580:	00813483          	ld	s1,8(sp)
    80001584:	00013903          	ld	s2,0(sp)
    80001588:	02010113          	addi	sp,sp,32
    8000158c:	00008067          	ret
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001590:	00004517          	auipc	a0,0x4
    80001594:	ac050513          	addi	a0,a0,-1344 # 80005050 <kvmincrease+0x9b0>
    80001598:	00001097          	auipc	ra,0x1
    8000159c:	a2c080e7          	jalr	-1492(ra) # 80001fc4 <_Z11printStringPKc>
            return;
    800015a0:	fd9ff06f          	j	80001578 <_Z8userMainv+0x9c>
    switch (test) {
    800015a4:	00700793          	li	a5,7
    800015a8:	04f49263          	bne	s1,a5,800015ec <_Z8userMainv+0x110>
            printString("Test se nije uspesno zavrsio\n");
    800015ac:	00004517          	auipc	a0,0x4
    800015b0:	b5450513          	addi	a0,a0,-1196 # 80005100 <kvmincrease+0xa60>
    800015b4:	00001097          	auipc	ra,0x1
    800015b8:	a10080e7          	jalr	-1520(ra) # 80001fc4 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800015bc:	00004517          	auipc	a0,0x4
    800015c0:	b6450513          	addi	a0,a0,-1180 # 80005120 <kvmincrease+0xa80>
    800015c4:	00001097          	auipc	ra,0x1
    800015c8:	a00080e7          	jalr	-1536(ra) # 80001fc4 <_Z11printStringPKc>
            break;
    800015cc:	fadff06f          	j	80001578 <_Z8userMainv+0x9c>
            Threads_C_API_test();
    800015d0:	00001097          	auipc	ra,0x1
    800015d4:	8f8080e7          	jalr	-1800(ra) # 80001ec8 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800015d8:	00004517          	auipc	a0,0x4
    800015dc:	aa850513          	addi	a0,a0,-1368 # 80005080 <kvmincrease+0x9e0>
    800015e0:	00001097          	auipc	ra,0x1
    800015e4:	9e4080e7          	jalr	-1564(ra) # 80001fc4 <_Z11printStringPKc>
            break;
    800015e8:	f91ff06f          	j	80001578 <_Z8userMainv+0x9c>
            printString("Niste uneli odgovarajuci broj za test\n");
    800015ec:	00004517          	auipc	a0,0x4
    800015f0:	b8c50513          	addi	a0,a0,-1140 # 80005178 <kvmincrease+0xad8>
    800015f4:	00001097          	auipc	ra,0x1
    800015f8:	9d0080e7          	jalr	-1584(ra) # 80001fc4 <_Z11printStringPKc>
    800015fc:	f7dff06f          	j	80001578 <_Z8userMainv+0x9c>

0000000080001600 <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    80001600:	fe010113          	addi	sp,sp,-32
    80001604:	00113c23          	sd	ra,24(sp)
    80001608:	00813823          	sd	s0,16(sp)
    8000160c:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80001610:	00004797          	auipc	a5,0x4
    80001614:	5d07b783          	ld	a5,1488(a5) # 80005be0 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001618:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    8000161c:	00000613          	li	a2,0
    80001620:	00000593          	li	a1,0
    80001624:	fe840513          	addi	a0,s0,-24
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	b6c080e7          	jalr	-1172(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    80001630:	00004797          	auipc	a5,0x4
    80001634:	5a87b783          	ld	a5,1448(a5) # 80005bd8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001638:	fe843703          	ld	a4,-24(s0)
    8000163c:	00e7b023          	sd	a4,0(a5)

    // promena rezima

    // uposleno cekanje

    userMain();
    80001640:	00000097          	auipc	ra,0x0
    80001644:	e9c080e7          	jalr	-356(ra) # 800014dc <_Z8userMainv>
    printString("Finished\n");
    80001648:	00004517          	auipc	a0,0x4
    8000164c:	b5850513          	addi	a0,a0,-1192 # 800051a0 <kvmincrease+0xb00>
    80001650:	00001097          	auipc	ra,0x1
    80001654:	974080e7          	jalr	-1676(ra) # 80001fc4 <_Z11printStringPKc>
}
    80001658:	01813083          	ld	ra,24(sp)
    8000165c:	01013403          	ld	s0,16(sp)
    80001660:	02010113          	addi	sp,sp,32
    80001664:	00008067          	ret

0000000080001668 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001668:	ff010113          	addi	sp,sp,-16
    8000166c:	00113423          	sd	ra,8(sp)
    80001670:	00813023          	sd	s0,0(sp)
    80001674:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001678:	00003097          	auipc	ra,0x3
    8000167c:	db0080e7          	jalr	-592(ra) # 80004428 <__mem_alloc>
}
    80001680:	00813083          	ld	ra,8(sp)
    80001684:	00013403          	ld	s0,0(sp)
    80001688:	01010113          	addi	sp,sp,16
    8000168c:	00008067          	ret

0000000080001690 <_Znam>:

void *operator new[](size_t n)
{
    80001690:	ff010113          	addi	sp,sp,-16
    80001694:	00113423          	sd	ra,8(sp)
    80001698:	00813023          	sd	s0,0(sp)
    8000169c:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016a0:	00003097          	auipc	ra,0x3
    800016a4:	d88080e7          	jalr	-632(ra) # 80004428 <__mem_alloc>
}
    800016a8:	00813083          	ld	ra,8(sp)
    800016ac:	00013403          	ld	s0,0(sp)
    800016b0:	01010113          	addi	sp,sp,16
    800016b4:	00008067          	ret

00000000800016b8 <_ZdlPv>:

void operator delete(void *p)
{
    800016b8:	ff010113          	addi	sp,sp,-16
    800016bc:	00113423          	sd	ra,8(sp)
    800016c0:	00813023          	sd	s0,0(sp)
    800016c4:	01010413          	addi	s0,sp,16
    __mem_free(p);
    800016c8:	00003097          	auipc	ra,0x3
    800016cc:	c94080e7          	jalr	-876(ra) # 8000435c <__mem_free>
}
    800016d0:	00813083          	ld	ra,8(sp)
    800016d4:	00013403          	ld	s0,0(sp)
    800016d8:	01010113          	addi	sp,sp,16
    800016dc:	00008067          	ret

00000000800016e0 <_ZdaPv>:

void operator delete[](void *p)
{
    800016e0:	ff010113          	addi	sp,sp,-16
    800016e4:	00113423          	sd	ra,8(sp)
    800016e8:	00813023          	sd	s0,0(sp)
    800016ec:	01010413          	addi	s0,sp,16
    __mem_free(p);
    800016f0:	00003097          	auipc	ra,0x3
    800016f4:	c6c080e7          	jalr	-916(ra) # 8000435c <__mem_free>
}
    800016f8:	00813083          	ld	ra,8(sp)
    800016fc:	00013403          	ld	s0,0(sp)
    80001700:	01010113          	addi	sp,sp,16
    80001704:	00008067          	ret

0000000080001708 <_ZN7Console4getcEv>:

char Console::getc() {
    80001708:	ff010113          	addi	sp,sp,-16
    8000170c:	00113423          	sd	ra,8(sp)
    80001710:	00813023          	sd	s0,0(sp)
    80001714:	01010413          	addi	s0,sp,16
    return __getc();
    80001718:	00003097          	auipc	ra,0x3
    8000171c:	ea4080e7          	jalr	-348(ra) # 800045bc <__getc>
}
    80001720:	00813083          	ld	ra,8(sp)
    80001724:	00013403          	ld	s0,0(sp)
    80001728:	01010113          	addi	sp,sp,16
    8000172c:	00008067          	ret

0000000080001730 <_ZN7Console4putcEc>:

void Console::putc(char c) {
    80001730:	ff010113          	addi	sp,sp,-16
    80001734:	00113423          	sd	ra,8(sp)
    80001738:	00813023          	sd	s0,0(sp)
    8000173c:	01010413          	addi	s0,sp,16
    __putc(c);
    80001740:	00003097          	auipc	ra,0x3
    80001744:	e40080e7          	jalr	-448(ra) # 80004580 <__putc>
}
    80001748:	00813083          	ld	ra,8(sp)
    8000174c:	00013403          	ld	s0,0(sp)
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret

0000000080001758 <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00813423          	sd	s0,8(sp)
    80001760:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001764:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001768:	10200073          	sret
}
    8000176c:	00813403          	ld	s0,8(sp)
    80001770:	01010113          	addi	sp,sp,16
    80001774:	00008067          	ret

0000000080001778 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001778:	fb010113          	addi	sp,sp,-80
    8000177c:	04113423          	sd	ra,72(sp)
    80001780:	04813023          	sd	s0,64(sp)
    80001784:	02913c23          	sd	s1,56(sp)
    80001788:	03213823          	sd	s2,48(sp)
    8000178c:	03313423          	sd	s3,40(sp)
    80001790:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001794:	142027f3          	csrr	a5,scause
    80001798:	faf43c23          	sd	a5,-72(s0)
    return scause;
    8000179c:	fb843783          	ld	a5,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    800017a0:	fff00713          	li	a4,-1
    800017a4:	03f71713          	slli	a4,a4,0x3f
    800017a8:	00170713          	addi	a4,a4,1
    800017ac:	0ee78663          	beq	a5,a4,80001898 <_ZN5Riscv20handleSupervisorTrapEv+0x120>
    800017b0:	fff00713          	li	a4,-1
    800017b4:	03f71713          	slli	a4,a4,0x3f
    800017b8:	00170713          	addi	a4,a4,1
    800017bc:	06f76a63          	bltu	a4,a5,80001830 <_ZN5Riscv20handleSupervisorTrapEv+0xb8>
    800017c0:	ff878793          	addi	a5,a5,-8
    800017c4:	00100713          	li	a4,1
    800017c8:	04f76663          	bltu	a4,a5,80001814 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800017cc:	141027f3          	csrr	a5,sepc
    800017d0:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    800017d4:	fc843483          	ld	s1,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    800017d8:	00448493          	addi	s1,s1,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800017dc:	100027f3          	csrr	a5,sstatus
    800017e0:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    800017e4:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    800017e8:	00088793          	mv	a5,a7
            switch (scallnum) {
    800017ec:	01200713          	li	a4,18
    800017f0:	08e78063          	beq	a5,a4,80001870 <_ZN5Riscv20handleSupervisorTrapEv+0xf8>
    800017f4:	01300713          	li	a4,19
    800017f8:	08e78463          	beq	a5,a4,80001880 <_ZN5Riscv20handleSupervisorTrapEv+0x108>
    800017fc:	01100713          	li	a4,17
    80001800:	04e78663          	beq	a5,a4,8000184c <_ZN5Riscv20handleSupervisorTrapEv+0xd4>
    80001804:	00000793          	li	a5,0
                case SCALL_SEM_SIGNAL:
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
    80001808:	00078513          	mv	a0,a5
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    8000180c:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001810:	14149073          	csrw	sepc,s1
            console_handler();
            break;
        default:
            break;
    }
    80001814:	04813083          	ld	ra,72(sp)
    80001818:	04013403          	ld	s0,64(sp)
    8000181c:	03813483          	ld	s1,56(sp)
    80001820:	03013903          	ld	s2,48(sp)
    80001824:	02813983          	ld	s3,40(sp)
    80001828:	05010113          	addi	sp,sp,80
    8000182c:	00008067          	ret
    switch((uint64)scause){
    80001830:	fff00713          	li	a4,-1
    80001834:	03f71713          	slli	a4,a4,0x3f
    80001838:	00970713          	addi	a4,a4,9
    8000183c:	fce79ce3          	bne	a5,a4,80001814 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
            console_handler();
    80001840:	00003097          	auipc	ra,0x3
    80001844:	db4080e7          	jalr	-588(ra) # 800045f4 <console_handler>
    80001848:	fcdff06f          	j	80001814 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
                    READ_REG(handle, "a0");
    8000184c:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001850:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001854:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001858:	00000097          	auipc	ra,0x0
    8000185c:	ab8080e7          	jalr	-1352(ra) # 80001310 <_ZN7_thread12createThreadEPFvvEPv>
    80001860:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001864:	02050663          	beqz	a0,80001890 <_ZN5Riscv20handleSupervisorTrapEv+0x118>
    80001868:	00000793          	li	a5,0
    8000186c:	f9dff06f          	j	80001808 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    _thread::exitThread();
    80001870:	00000097          	auipc	ra,0x0
    80001874:	c30080e7          	jalr	-976(ra) # 800014a0 <_ZN7_thread10exitThreadEv>
            uint64 ret = 0;
    80001878:	00000793          	li	a5,0
                    break;
    8000187c:	f8dff06f          	j	80001808 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    _thread::dispatch();
    80001880:	00000097          	auipc	ra,0x0
    80001884:	b60080e7          	jalr	-1184(ra) # 800013e0 <_ZN7_thread8dispatchEv>
            uint64 ret = 0;
    80001888:	00000793          	li	a5,0
                    break;
    8000188c:	f7dff06f          	j	80001808 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
                    else ret = -1;
    80001890:	fff00793          	li	a5,-1
    80001894:	f75ff06f          	j	80001808 <_ZN5Riscv20handleSupervisorTrapEv+0x90>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001898:	00200793          	li	a5,2
    8000189c:	1447b073          	csrc	sip,a5
}
    800018a0:	f75ff06f          	j	80001814 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>

00000000800018a4 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    800018a4:	ff010113          	addi	sp,sp,-16
    800018a8:	00813423          	sd	s0,8(sp)
    800018ac:	01010413          	addi	s0,sp,16
    800018b0:	00100793          	li	a5,1
    800018b4:	00f50863          	beq	a0,a5,800018c4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800018b8:	00813403          	ld	s0,8(sp)
    800018bc:	01010113          	addi	sp,sp,16
    800018c0:	00008067          	ret
    800018c4:	000107b7          	lui	a5,0x10
    800018c8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800018cc:	fef596e3          	bne	a1,a5,800018b8 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    800018d0:	00004797          	auipc	a5,0x4
    800018d4:	37878793          	addi	a5,a5,888 # 80005c48 <_ZN9Scheduler16readyThreadQueueE>
    800018d8:	0007b023          	sd	zero,0(a5)
    800018dc:	0007b423          	sd	zero,8(a5)
    800018e0:	fd9ff06f          	j	800018b8 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800018e4 <_ZN9Scheduler3getEv>:
{
    800018e4:	fe010113          	addi	sp,sp,-32
    800018e8:	00113c23          	sd	ra,24(sp)
    800018ec:	00813823          	sd	s0,16(sp)
    800018f0:	00913423          	sd	s1,8(sp)
    800018f4:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    800018f8:	00004517          	auipc	a0,0x4
    800018fc:	35053503          	ld	a0,848(a0) # 80005c48 <_ZN9Scheduler16readyThreadQueueE>
    80001900:	04050263          	beqz	a0,80001944 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001904:	00853783          	ld	a5,8(a0)
    80001908:	00004717          	auipc	a4,0x4
    8000190c:	34f73023          	sd	a5,832(a4) # 80005c48 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001910:	02078463          	beqz	a5,80001938 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001914:	00053483          	ld	s1,0(a0)
        delete elem;
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	da0080e7          	jalr	-608(ra) # 800016b8 <_ZdlPv>
}
    80001920:	00048513          	mv	a0,s1
    80001924:	01813083          	ld	ra,24(sp)
    80001928:	01013403          	ld	s0,16(sp)
    8000192c:	00813483          	ld	s1,8(sp)
    80001930:	02010113          	addi	sp,sp,32
    80001934:	00008067          	ret
        if (!head) { tail = 0; }
    80001938:	00004797          	auipc	a5,0x4
    8000193c:	3007bc23          	sd	zero,792(a5) # 80005c50 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001940:	fd5ff06f          	j	80001914 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001944:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001948:	fd9ff06f          	j	80001920 <_ZN9Scheduler3getEv+0x3c>

000000008000194c <_ZN9Scheduler3putEP7_thread>:
{
    8000194c:	fe010113          	addi	sp,sp,-32
    80001950:	00113c23          	sd	ra,24(sp)
    80001954:	00813823          	sd	s0,16(sp)
    80001958:	00913423          	sd	s1,8(sp)
    8000195c:	02010413          	addi	s0,sp,32
    80001960:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001964:	01000513          	li	a0,16
    80001968:	00000097          	auipc	ra,0x0
    8000196c:	d00080e7          	jalr	-768(ra) # 80001668 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001970:	00953023          	sd	s1,0(a0)
    80001974:	00053423          	sd	zero,8(a0)
        if (tail)
    80001978:	00004797          	auipc	a5,0x4
    8000197c:	2d87b783          	ld	a5,728(a5) # 80005c50 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001980:	02078263          	beqz	a5,800019a4 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80001984:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001988:	00004797          	auipc	a5,0x4
    8000198c:	2ca7b423          	sd	a0,712(a5) # 80005c50 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001990:	01813083          	ld	ra,24(sp)
    80001994:	01013403          	ld	s0,16(sp)
    80001998:	00813483          	ld	s1,8(sp)
    8000199c:	02010113          	addi	sp,sp,32
    800019a0:	00008067          	ret
            head = tail = elem;
    800019a4:	00004797          	auipc	a5,0x4
    800019a8:	2a478793          	addi	a5,a5,676 # 80005c48 <_ZN9Scheduler16readyThreadQueueE>
    800019ac:	00a7b423          	sd	a0,8(a5)
    800019b0:	00a7b023          	sd	a0,0(a5)
    800019b4:	fddff06f          	j	80001990 <_ZN9Scheduler3putEP7_thread+0x44>

00000000800019b8 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    800019b8:	ff010113          	addi	sp,sp,-16
    800019bc:	00113423          	sd	ra,8(sp)
    800019c0:	00813023          	sd	s0,0(sp)
    800019c4:	01010413          	addi	s0,sp,16
    800019c8:	000105b7          	lui	a1,0x10
    800019cc:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800019d0:	00100513          	li	a0,1
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	ed0080e7          	jalr	-304(ra) # 800018a4 <_Z41__static_initialization_and_destruction_0ii>
    800019dc:	00813083          	ld	ra,8(sp)
    800019e0:	00013403          	ld	s0,0(sp)
    800019e4:	01010113          	addi	sp,sp,16
    800019e8:	00008067          	ret

00000000800019ec <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800019ec:	fe010113          	addi	sp,sp,-32
    800019f0:	00113c23          	sd	ra,24(sp)
    800019f4:	00813823          	sd	s0,16(sp)
    800019f8:	00913423          	sd	s1,8(sp)
    800019fc:	01213023          	sd	s2,0(sp)
    80001a00:	02010413          	addi	s0,sp,32
    80001a04:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80001a08:	00100793          	li	a5,1
    80001a0c:	02a7f863          	bgeu	a5,a0,80001a3c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80001a10:	00a00793          	li	a5,10
    80001a14:	02f577b3          	remu	a5,a0,a5
    80001a18:	02078e63          	beqz	a5,80001a54 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80001a1c:	fff48513          	addi	a0,s1,-1
    80001a20:	00000097          	auipc	ra,0x0
    80001a24:	fcc080e7          	jalr	-52(ra) # 800019ec <_ZL9fibonaccim>
    80001a28:	00050913          	mv	s2,a0
    80001a2c:	ffe48513          	addi	a0,s1,-2
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	fbc080e7          	jalr	-68(ra) # 800019ec <_ZL9fibonaccim>
    80001a38:	00a90533          	add	a0,s2,a0
}
    80001a3c:	01813083          	ld	ra,24(sp)
    80001a40:	01013403          	ld	s0,16(sp)
    80001a44:	00813483          	ld	s1,8(sp)
    80001a48:	00013903          	ld	s2,0(sp)
    80001a4c:	02010113          	addi	sp,sp,32
    80001a50:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80001a54:	fffff097          	auipc	ra,0xfffff
    80001a58:	798080e7          	jalr	1944(ra) # 800011ec <_Z15thread_dispatchv>
    80001a5c:	fc1ff06f          	j	80001a1c <_ZL9fibonaccim+0x30>

0000000080001a60 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80001a60:	fe010113          	addi	sp,sp,-32
    80001a64:	00113c23          	sd	ra,24(sp)
    80001a68:	00813823          	sd	s0,16(sp)
    80001a6c:	00913423          	sd	s1,8(sp)
    80001a70:	01213023          	sd	s2,0(sp)
    80001a74:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001a78:	00a00493          	li	s1,10
    80001a7c:	0400006f          	j	80001abc <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001a80:	00003517          	auipc	a0,0x3
    80001a84:	73050513          	addi	a0,a0,1840 # 800051b0 <kvmincrease+0xb10>
    80001a88:	00000097          	auipc	ra,0x0
    80001a8c:	53c080e7          	jalr	1340(ra) # 80001fc4 <_Z11printStringPKc>
    80001a90:	00000613          	li	a2,0
    80001a94:	00a00593          	li	a1,10
    80001a98:	00048513          	mv	a0,s1
    80001a9c:	00000097          	auipc	ra,0x0
    80001aa0:	6d8080e7          	jalr	1752(ra) # 80002174 <_Z8printIntiii>
    80001aa4:	00003517          	auipc	a0,0x3
    80001aa8:	70450513          	addi	a0,a0,1796 # 800051a8 <kvmincrease+0xb08>
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	518080e7          	jalr	1304(ra) # 80001fc4 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80001ab4:	0014849b          	addiw	s1,s1,1
    80001ab8:	0ff4f493          	andi	s1,s1,255
    80001abc:	00c00793          	li	a5,12
    80001ac0:	fc97f0e3          	bgeu	a5,s1,80001a80 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80001ac4:	00003517          	auipc	a0,0x3
    80001ac8:	6f450513          	addi	a0,a0,1780 # 800051b8 <kvmincrease+0xb18>
    80001acc:	00000097          	auipc	ra,0x0
    80001ad0:	4f8080e7          	jalr	1272(ra) # 80001fc4 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80001ad4:	00500313          	li	t1,5
    thread_dispatch();
    80001ad8:	fffff097          	auipc	ra,0xfffff
    80001adc:	714080e7          	jalr	1812(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80001ae0:	01000513          	li	a0,16
    80001ae4:	00000097          	auipc	ra,0x0
    80001ae8:	f08080e7          	jalr	-248(ra) # 800019ec <_ZL9fibonaccim>
    80001aec:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80001af0:	00003517          	auipc	a0,0x3
    80001af4:	6d850513          	addi	a0,a0,1752 # 800051c8 <kvmincrease+0xb28>
    80001af8:	00000097          	auipc	ra,0x0
    80001afc:	4cc080e7          	jalr	1228(ra) # 80001fc4 <_Z11printStringPKc>
    80001b00:	00000613          	li	a2,0
    80001b04:	00a00593          	li	a1,10
    80001b08:	0009051b          	sext.w	a0,s2
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	668080e7          	jalr	1640(ra) # 80002174 <_Z8printIntiii>
    80001b14:	00003517          	auipc	a0,0x3
    80001b18:	69450513          	addi	a0,a0,1684 # 800051a8 <kvmincrease+0xb08>
    80001b1c:	00000097          	auipc	ra,0x0
    80001b20:	4a8080e7          	jalr	1192(ra) # 80001fc4 <_Z11printStringPKc>
    80001b24:	0400006f          	j	80001b64 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80001b28:	00003517          	auipc	a0,0x3
    80001b2c:	68850513          	addi	a0,a0,1672 # 800051b0 <kvmincrease+0xb10>
    80001b30:	00000097          	auipc	ra,0x0
    80001b34:	494080e7          	jalr	1172(ra) # 80001fc4 <_Z11printStringPKc>
    80001b38:	00000613          	li	a2,0
    80001b3c:	00a00593          	li	a1,10
    80001b40:	00048513          	mv	a0,s1
    80001b44:	00000097          	auipc	ra,0x0
    80001b48:	630080e7          	jalr	1584(ra) # 80002174 <_Z8printIntiii>
    80001b4c:	00003517          	auipc	a0,0x3
    80001b50:	65c50513          	addi	a0,a0,1628 # 800051a8 <kvmincrease+0xb08>
    80001b54:	00000097          	auipc	ra,0x0
    80001b58:	470080e7          	jalr	1136(ra) # 80001fc4 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80001b5c:	0014849b          	addiw	s1,s1,1
    80001b60:	0ff4f493          	andi	s1,s1,255
    80001b64:	00f00793          	li	a5,15
    80001b68:	fc97f0e3          	bgeu	a5,s1,80001b28 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80001b6c:	00003517          	auipc	a0,0x3
    80001b70:	66c50513          	addi	a0,a0,1644 # 800051d8 <kvmincrease+0xb38>
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	450080e7          	jalr	1104(ra) # 80001fc4 <_Z11printStringPKc>
    finishedD = true;
    80001b7c:	00100793          	li	a5,1
    80001b80:	00004717          	auipc	a4,0x4
    80001b84:	0cf70c23          	sb	a5,216(a4) # 80005c58 <_ZL9finishedD>
    thread_dispatch();
    80001b88:	fffff097          	auipc	ra,0xfffff
    80001b8c:	664080e7          	jalr	1636(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001b90:	01813083          	ld	ra,24(sp)
    80001b94:	01013403          	ld	s0,16(sp)
    80001b98:	00813483          	ld	s1,8(sp)
    80001b9c:	00013903          	ld	s2,0(sp)
    80001ba0:	02010113          	addi	sp,sp,32
    80001ba4:	00008067          	ret

0000000080001ba8 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80001ba8:	fe010113          	addi	sp,sp,-32
    80001bac:	00113c23          	sd	ra,24(sp)
    80001bb0:	00813823          	sd	s0,16(sp)
    80001bb4:	00913423          	sd	s1,8(sp)
    80001bb8:	01213023          	sd	s2,0(sp)
    80001bbc:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001bc0:	00000493          	li	s1,0
    80001bc4:	0400006f          	j	80001c04 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80001bc8:	00003517          	auipc	a0,0x3
    80001bcc:	62050513          	addi	a0,a0,1568 # 800051e8 <kvmincrease+0xb48>
    80001bd0:	00000097          	auipc	ra,0x0
    80001bd4:	3f4080e7          	jalr	1012(ra) # 80001fc4 <_Z11printStringPKc>
    80001bd8:	00000613          	li	a2,0
    80001bdc:	00a00593          	li	a1,10
    80001be0:	00048513          	mv	a0,s1
    80001be4:	00000097          	auipc	ra,0x0
    80001be8:	590080e7          	jalr	1424(ra) # 80002174 <_Z8printIntiii>
    80001bec:	00003517          	auipc	a0,0x3
    80001bf0:	5bc50513          	addi	a0,a0,1468 # 800051a8 <kvmincrease+0xb08>
    80001bf4:	00000097          	auipc	ra,0x0
    80001bf8:	3d0080e7          	jalr	976(ra) # 80001fc4 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80001bfc:	0014849b          	addiw	s1,s1,1
    80001c00:	0ff4f493          	andi	s1,s1,255
    80001c04:	00200793          	li	a5,2
    80001c08:	fc97f0e3          	bgeu	a5,s1,80001bc8 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80001c0c:	00003517          	auipc	a0,0x3
    80001c10:	5e450513          	addi	a0,a0,1508 # 800051f0 <kvmincrease+0xb50>
    80001c14:	00000097          	auipc	ra,0x0
    80001c18:	3b0080e7          	jalr	944(ra) # 80001fc4 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80001c1c:	00700313          	li	t1,7
    thread_dispatch();
    80001c20:	fffff097          	auipc	ra,0xfffff
    80001c24:	5cc080e7          	jalr	1484(ra) # 800011ec <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80001c28:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80001c2c:	00003517          	auipc	a0,0x3
    80001c30:	5d450513          	addi	a0,a0,1492 # 80005200 <kvmincrease+0xb60>
    80001c34:	00000097          	auipc	ra,0x0
    80001c38:	390080e7          	jalr	912(ra) # 80001fc4 <_Z11printStringPKc>
    80001c3c:	00000613          	li	a2,0
    80001c40:	00a00593          	li	a1,10
    80001c44:	0009051b          	sext.w	a0,s2
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	52c080e7          	jalr	1324(ra) # 80002174 <_Z8printIntiii>
    80001c50:	00003517          	auipc	a0,0x3
    80001c54:	55850513          	addi	a0,a0,1368 # 800051a8 <kvmincrease+0xb08>
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	36c080e7          	jalr	876(ra) # 80001fc4 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80001c60:	00c00513          	li	a0,12
    80001c64:	00000097          	auipc	ra,0x0
    80001c68:	d88080e7          	jalr	-632(ra) # 800019ec <_ZL9fibonaccim>
    80001c6c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80001c70:	00003517          	auipc	a0,0x3
    80001c74:	59850513          	addi	a0,a0,1432 # 80005208 <kvmincrease+0xb68>
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	34c080e7          	jalr	844(ra) # 80001fc4 <_Z11printStringPKc>
    80001c80:	00000613          	li	a2,0
    80001c84:	00a00593          	li	a1,10
    80001c88:	0009051b          	sext.w	a0,s2
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	4e8080e7          	jalr	1256(ra) # 80002174 <_Z8printIntiii>
    80001c94:	00003517          	auipc	a0,0x3
    80001c98:	51450513          	addi	a0,a0,1300 # 800051a8 <kvmincrease+0xb08>
    80001c9c:	00000097          	auipc	ra,0x0
    80001ca0:	328080e7          	jalr	808(ra) # 80001fc4 <_Z11printStringPKc>
    80001ca4:	0400006f          	j	80001ce4 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80001ca8:	00003517          	auipc	a0,0x3
    80001cac:	54050513          	addi	a0,a0,1344 # 800051e8 <kvmincrease+0xb48>
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	314080e7          	jalr	788(ra) # 80001fc4 <_Z11printStringPKc>
    80001cb8:	00000613          	li	a2,0
    80001cbc:	00a00593          	li	a1,10
    80001cc0:	00048513          	mv	a0,s1
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	4b0080e7          	jalr	1200(ra) # 80002174 <_Z8printIntiii>
    80001ccc:	00003517          	auipc	a0,0x3
    80001cd0:	4dc50513          	addi	a0,a0,1244 # 800051a8 <kvmincrease+0xb08>
    80001cd4:	00000097          	auipc	ra,0x0
    80001cd8:	2f0080e7          	jalr	752(ra) # 80001fc4 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80001cdc:	0014849b          	addiw	s1,s1,1
    80001ce0:	0ff4f493          	andi	s1,s1,255
    80001ce4:	00500793          	li	a5,5
    80001ce8:	fc97f0e3          	bgeu	a5,s1,80001ca8 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80001cec:	00003517          	auipc	a0,0x3
    80001cf0:	52c50513          	addi	a0,a0,1324 # 80005218 <kvmincrease+0xb78>
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	2d0080e7          	jalr	720(ra) # 80001fc4 <_Z11printStringPKc>
    finishedC = true;
    80001cfc:	00100793          	li	a5,1
    80001d00:	00004717          	auipc	a4,0x4
    80001d04:	f4f70ca3          	sb	a5,-167(a4) # 80005c59 <_ZL9finishedC>
    thread_dispatch();
    80001d08:	fffff097          	auipc	ra,0xfffff
    80001d0c:	4e4080e7          	jalr	1252(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001d10:	01813083          	ld	ra,24(sp)
    80001d14:	01013403          	ld	s0,16(sp)
    80001d18:	00813483          	ld	s1,8(sp)
    80001d1c:	00013903          	ld	s2,0(sp)
    80001d20:	02010113          	addi	sp,sp,32
    80001d24:	00008067          	ret

0000000080001d28 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80001d28:	fe010113          	addi	sp,sp,-32
    80001d2c:	00113c23          	sd	ra,24(sp)
    80001d30:	00813823          	sd	s0,16(sp)
    80001d34:	00913423          	sd	s1,8(sp)
    80001d38:	01213023          	sd	s2,0(sp)
    80001d3c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80001d40:	00000913          	li	s2,0
    80001d44:	0380006f          	j	80001d7c <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80001d48:	fffff097          	auipc	ra,0xfffff
    80001d4c:	4a4080e7          	jalr	1188(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001d50:	00148493          	addi	s1,s1,1
    80001d54:	000027b7          	lui	a5,0x2
    80001d58:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001d5c:	0097ee63          	bltu	a5,s1,80001d78 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001d60:	00000713          	li	a4,0
    80001d64:	000077b7          	lui	a5,0x7
    80001d68:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001d6c:	fce7eee3          	bltu	a5,a4,80001d48 <_ZL11workerBodyBPv+0x20>
    80001d70:	00170713          	addi	a4,a4,1
    80001d74:	ff1ff06f          	j	80001d64 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80001d78:	00190913          	addi	s2,s2,1
    80001d7c:	00f00793          	li	a5,15
    80001d80:	0527e063          	bltu	a5,s2,80001dc0 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80001d84:	00003517          	auipc	a0,0x3
    80001d88:	4a450513          	addi	a0,a0,1188 # 80005228 <kvmincrease+0xb88>
    80001d8c:	00000097          	auipc	ra,0x0
    80001d90:	238080e7          	jalr	568(ra) # 80001fc4 <_Z11printStringPKc>
    80001d94:	00000613          	li	a2,0
    80001d98:	00a00593          	li	a1,10
    80001d9c:	0009051b          	sext.w	a0,s2
    80001da0:	00000097          	auipc	ra,0x0
    80001da4:	3d4080e7          	jalr	980(ra) # 80002174 <_Z8printIntiii>
    80001da8:	00003517          	auipc	a0,0x3
    80001dac:	40050513          	addi	a0,a0,1024 # 800051a8 <kvmincrease+0xb08>
    80001db0:	00000097          	auipc	ra,0x0
    80001db4:	214080e7          	jalr	532(ra) # 80001fc4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001db8:	00000493          	li	s1,0
    80001dbc:	f99ff06f          	j	80001d54 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80001dc0:	00003517          	auipc	a0,0x3
    80001dc4:	47050513          	addi	a0,a0,1136 # 80005230 <kvmincrease+0xb90>
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	1fc080e7          	jalr	508(ra) # 80001fc4 <_Z11printStringPKc>
    finishedB = true;
    80001dd0:	00100793          	li	a5,1
    80001dd4:	00004717          	auipc	a4,0x4
    80001dd8:	e8f70323          	sb	a5,-378(a4) # 80005c5a <_ZL9finishedB>
    thread_dispatch();
    80001ddc:	fffff097          	auipc	ra,0xfffff
    80001de0:	410080e7          	jalr	1040(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001de4:	01813083          	ld	ra,24(sp)
    80001de8:	01013403          	ld	s0,16(sp)
    80001dec:	00813483          	ld	s1,8(sp)
    80001df0:	00013903          	ld	s2,0(sp)
    80001df4:	02010113          	addi	sp,sp,32
    80001df8:	00008067          	ret

0000000080001dfc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80001dfc:	fe010113          	addi	sp,sp,-32
    80001e00:	00113c23          	sd	ra,24(sp)
    80001e04:	00813823          	sd	s0,16(sp)
    80001e08:	00913423          	sd	s1,8(sp)
    80001e0c:	01213023          	sd	s2,0(sp)
    80001e10:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80001e14:	00000913          	li	s2,0
    80001e18:	0380006f          	j	80001e50 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80001e1c:	fffff097          	auipc	ra,0xfffff
    80001e20:	3d0080e7          	jalr	976(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80001e24:	00148493          	addi	s1,s1,1
    80001e28:	000027b7          	lui	a5,0x2
    80001e2c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001e30:	0097ee63          	bltu	a5,s1,80001e4c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80001e34:	00000713          	li	a4,0
    80001e38:	000077b7          	lui	a5,0x7
    80001e3c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001e40:	fce7eee3          	bltu	a5,a4,80001e1c <_ZL11workerBodyAPv+0x20>
    80001e44:	00170713          	addi	a4,a4,1
    80001e48:	ff1ff06f          	j	80001e38 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80001e4c:	00190913          	addi	s2,s2,1
    80001e50:	00900793          	li	a5,9
    80001e54:	0527e063          	bltu	a5,s2,80001e94 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80001e58:	00003517          	auipc	a0,0x3
    80001e5c:	3e850513          	addi	a0,a0,1000 # 80005240 <kvmincrease+0xba0>
    80001e60:	00000097          	auipc	ra,0x0
    80001e64:	164080e7          	jalr	356(ra) # 80001fc4 <_Z11printStringPKc>
    80001e68:	00000613          	li	a2,0
    80001e6c:	00a00593          	li	a1,10
    80001e70:	0009051b          	sext.w	a0,s2
    80001e74:	00000097          	auipc	ra,0x0
    80001e78:	300080e7          	jalr	768(ra) # 80002174 <_Z8printIntiii>
    80001e7c:	00003517          	auipc	a0,0x3
    80001e80:	32c50513          	addi	a0,a0,812 # 800051a8 <kvmincrease+0xb08>
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	140080e7          	jalr	320(ra) # 80001fc4 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80001e8c:	00000493          	li	s1,0
    80001e90:	f99ff06f          	j	80001e28 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80001e94:	00003517          	auipc	a0,0x3
    80001e98:	3b450513          	addi	a0,a0,948 # 80005248 <kvmincrease+0xba8>
    80001e9c:	00000097          	auipc	ra,0x0
    80001ea0:	128080e7          	jalr	296(ra) # 80001fc4 <_Z11printStringPKc>
    finishedA = true;
    80001ea4:	00100793          	li	a5,1
    80001ea8:	00004717          	auipc	a4,0x4
    80001eac:	daf709a3          	sb	a5,-589(a4) # 80005c5b <_ZL9finishedA>
}
    80001eb0:	01813083          	ld	ra,24(sp)
    80001eb4:	01013403          	ld	s0,16(sp)
    80001eb8:	00813483          	ld	s1,8(sp)
    80001ebc:	00013903          	ld	s2,0(sp)
    80001ec0:	02010113          	addi	sp,sp,32
    80001ec4:	00008067          	ret

0000000080001ec8 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80001ec8:	fd010113          	addi	sp,sp,-48
    80001ecc:	02113423          	sd	ra,40(sp)
    80001ed0:	02813023          	sd	s0,32(sp)
    80001ed4:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80001ed8:	00000613          	li	a2,0
    80001edc:	00000597          	auipc	a1,0x0
    80001ee0:	f2058593          	addi	a1,a1,-224 # 80001dfc <_ZL11workerBodyAPv>
    80001ee4:	fd040513          	addi	a0,s0,-48
    80001ee8:	fffff097          	auipc	ra,0xfffff
    80001eec:	2ac080e7          	jalr	684(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80001ef0:	00003517          	auipc	a0,0x3
    80001ef4:	36850513          	addi	a0,a0,872 # 80005258 <kvmincrease+0xbb8>
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	0cc080e7          	jalr	204(ra) # 80001fc4 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80001f00:	00000613          	li	a2,0
    80001f04:	00000597          	auipc	a1,0x0
    80001f08:	e2458593          	addi	a1,a1,-476 # 80001d28 <_ZL11workerBodyBPv>
    80001f0c:	fd840513          	addi	a0,s0,-40
    80001f10:	fffff097          	auipc	ra,0xfffff
    80001f14:	284080e7          	jalr	644(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80001f18:	00003517          	auipc	a0,0x3
    80001f1c:	35850513          	addi	a0,a0,856 # 80005270 <kvmincrease+0xbd0>
    80001f20:	00000097          	auipc	ra,0x0
    80001f24:	0a4080e7          	jalr	164(ra) # 80001fc4 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80001f28:	00000613          	li	a2,0
    80001f2c:	00000597          	auipc	a1,0x0
    80001f30:	c7c58593          	addi	a1,a1,-900 # 80001ba8 <_ZL11workerBodyCPv>
    80001f34:	fe040513          	addi	a0,s0,-32
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	25c080e7          	jalr	604(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80001f40:	00003517          	auipc	a0,0x3
    80001f44:	34850513          	addi	a0,a0,840 # 80005288 <kvmincrease+0xbe8>
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	07c080e7          	jalr	124(ra) # 80001fc4 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80001f50:	00000613          	li	a2,0
    80001f54:	00000597          	auipc	a1,0x0
    80001f58:	b0c58593          	addi	a1,a1,-1268 # 80001a60 <_ZL11workerBodyDPv>
    80001f5c:	fe840513          	addi	a0,s0,-24
    80001f60:	fffff097          	auipc	ra,0xfffff
    80001f64:	234080e7          	jalr	564(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80001f68:	00003517          	auipc	a0,0x3
    80001f6c:	33850513          	addi	a0,a0,824 # 800052a0 <kvmincrease+0xc00>
    80001f70:	00000097          	auipc	ra,0x0
    80001f74:	054080e7          	jalr	84(ra) # 80001fc4 <_Z11printStringPKc>
    80001f78:	00c0006f          	j	80001f84 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80001f7c:	fffff097          	auipc	ra,0xfffff
    80001f80:	270080e7          	jalr	624(ra) # 800011ec <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80001f84:	00004797          	auipc	a5,0x4
    80001f88:	cd77c783          	lbu	a5,-809(a5) # 80005c5b <_ZL9finishedA>
    80001f8c:	fe0788e3          	beqz	a5,80001f7c <_Z18Threads_C_API_testv+0xb4>
    80001f90:	00004797          	auipc	a5,0x4
    80001f94:	cca7c783          	lbu	a5,-822(a5) # 80005c5a <_ZL9finishedB>
    80001f98:	fe0782e3          	beqz	a5,80001f7c <_Z18Threads_C_API_testv+0xb4>
    80001f9c:	00004797          	auipc	a5,0x4
    80001fa0:	cbd7c783          	lbu	a5,-835(a5) # 80005c59 <_ZL9finishedC>
    80001fa4:	fc078ce3          	beqz	a5,80001f7c <_Z18Threads_C_API_testv+0xb4>
    80001fa8:	00004797          	auipc	a5,0x4
    80001fac:	cb07c783          	lbu	a5,-848(a5) # 80005c58 <_ZL9finishedD>
    80001fb0:	fc0786e3          	beqz	a5,80001f7c <_Z18Threads_C_API_testv+0xb4>
    }

}
    80001fb4:	02813083          	ld	ra,40(sp)
    80001fb8:	02013403          	ld	s0,32(sp)
    80001fbc:	03010113          	addi	sp,sp,48
    80001fc0:	00008067          	ret

0000000080001fc4 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001fc4:	fe010113          	addi	sp,sp,-32
    80001fc8:	00113c23          	sd	ra,24(sp)
    80001fcc:	00813823          	sd	s0,16(sp)
    80001fd0:	00913423          	sd	s1,8(sp)
    80001fd4:	02010413          	addi	s0,sp,32
    80001fd8:	00050493          	mv	s1,a0
    LOCK();
    80001fdc:	00100613          	li	a2,1
    80001fe0:	00000593          	li	a1,0
    80001fe4:	00004517          	auipc	a0,0x4
    80001fe8:	c7c50513          	addi	a0,a0,-900 # 80005c60 <lockPrint>
    80001fec:	fffff097          	auipc	ra,0xfffff
    80001ff0:	014080e7          	jalr	20(ra) # 80001000 <copy_and_swap>
    80001ff4:	00050863          	beqz	a0,80002004 <_Z11printStringPKc+0x40>
    80001ff8:	fffff097          	auipc	ra,0xfffff
    80001ffc:	1f4080e7          	jalr	500(ra) # 800011ec <_Z15thread_dispatchv>
    80002000:	fddff06f          	j	80001fdc <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002004:	0004c503          	lbu	a0,0(s1)
    80002008:	00050a63          	beqz	a0,8000201c <_Z11printStringPKc+0x58>
    {
        putc(*string);
    8000200c:	fffff097          	auipc	ra,0xfffff
    80002010:	2dc080e7          	jalr	732(ra) # 800012e8 <_Z4putcc>
        string++;
    80002014:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002018:	fedff06f          	j	80002004 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    8000201c:	00000613          	li	a2,0
    80002020:	00100593          	li	a1,1
    80002024:	00004517          	auipc	a0,0x4
    80002028:	c3c50513          	addi	a0,a0,-964 # 80005c60 <lockPrint>
    8000202c:	fffff097          	auipc	ra,0xfffff
    80002030:	fd4080e7          	jalr	-44(ra) # 80001000 <copy_and_swap>
    80002034:	fe0514e3          	bnez	a0,8000201c <_Z11printStringPKc+0x58>
}
    80002038:	01813083          	ld	ra,24(sp)
    8000203c:	01013403          	ld	s0,16(sp)
    80002040:	00813483          	ld	s1,8(sp)
    80002044:	02010113          	addi	sp,sp,32
    80002048:	00008067          	ret

000000008000204c <_Z9getStringPci>:

char* getString(char *buf, int max) {
    8000204c:	fd010113          	addi	sp,sp,-48
    80002050:	02113423          	sd	ra,40(sp)
    80002054:	02813023          	sd	s0,32(sp)
    80002058:	00913c23          	sd	s1,24(sp)
    8000205c:	01213823          	sd	s2,16(sp)
    80002060:	01313423          	sd	s3,8(sp)
    80002064:	01413023          	sd	s4,0(sp)
    80002068:	03010413          	addi	s0,sp,48
    8000206c:	00050993          	mv	s3,a0
    80002070:	00058a13          	mv	s4,a1
    LOCK();
    80002074:	00100613          	li	a2,1
    80002078:	00000593          	li	a1,0
    8000207c:	00004517          	auipc	a0,0x4
    80002080:	be450513          	addi	a0,a0,-1052 # 80005c60 <lockPrint>
    80002084:	fffff097          	auipc	ra,0xfffff
    80002088:	f7c080e7          	jalr	-132(ra) # 80001000 <copy_and_swap>
    8000208c:	00050863          	beqz	a0,8000209c <_Z9getStringPci+0x50>
    80002090:	fffff097          	auipc	ra,0xfffff
    80002094:	15c080e7          	jalr	348(ra) # 800011ec <_Z15thread_dispatchv>
    80002098:	fddff06f          	j	80002074 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    8000209c:	00000913          	li	s2,0
    800020a0:	00090493          	mv	s1,s2
    800020a4:	0019091b          	addiw	s2,s2,1
    800020a8:	03495a63          	bge	s2,s4,800020dc <_Z9getStringPci+0x90>
        cc = getc();
    800020ac:	fffff097          	auipc	ra,0xfffff
    800020b0:	214080e7          	jalr	532(ra) # 800012c0 <_Z4getcv>
        if(cc < 1)
    800020b4:	02050463          	beqz	a0,800020dc <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    800020b8:	009984b3          	add	s1,s3,s1
    800020bc:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800020c0:	00a00793          	li	a5,10
    800020c4:	00f50a63          	beq	a0,a5,800020d8 <_Z9getStringPci+0x8c>
    800020c8:	00d00793          	li	a5,13
    800020cc:	fcf51ae3          	bne	a0,a5,800020a0 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800020d0:	00090493          	mv	s1,s2
    800020d4:	0080006f          	j	800020dc <_Z9getStringPci+0x90>
    800020d8:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800020dc:	009984b3          	add	s1,s3,s1
    800020e0:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800020e4:	00000613          	li	a2,0
    800020e8:	00100593          	li	a1,1
    800020ec:	00004517          	auipc	a0,0x4
    800020f0:	b7450513          	addi	a0,a0,-1164 # 80005c60 <lockPrint>
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	f0c080e7          	jalr	-244(ra) # 80001000 <copy_and_swap>
    800020fc:	fe0514e3          	bnez	a0,800020e4 <_Z9getStringPci+0x98>
    return buf;
}
    80002100:	00098513          	mv	a0,s3
    80002104:	02813083          	ld	ra,40(sp)
    80002108:	02013403          	ld	s0,32(sp)
    8000210c:	01813483          	ld	s1,24(sp)
    80002110:	01013903          	ld	s2,16(sp)
    80002114:	00813983          	ld	s3,8(sp)
    80002118:	00013a03          	ld	s4,0(sp)
    8000211c:	03010113          	addi	sp,sp,48
    80002120:	00008067          	ret

0000000080002124 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002124:	ff010113          	addi	sp,sp,-16
    80002128:	00813423          	sd	s0,8(sp)
    8000212c:	01010413          	addi	s0,sp,16
    80002130:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002134:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002138:	0006c603          	lbu	a2,0(a3)
    8000213c:	fd06071b          	addiw	a4,a2,-48
    80002140:	0ff77713          	andi	a4,a4,255
    80002144:	00900793          	li	a5,9
    80002148:	02e7e063          	bltu	a5,a4,80002168 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    8000214c:	0025179b          	slliw	a5,a0,0x2
    80002150:	00a787bb          	addw	a5,a5,a0
    80002154:	0017979b          	slliw	a5,a5,0x1
    80002158:	00168693          	addi	a3,a3,1
    8000215c:	00c787bb          	addw	a5,a5,a2
    80002160:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002164:	fd5ff06f          	j	80002138 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002168:	00813403          	ld	s0,8(sp)
    8000216c:	01010113          	addi	sp,sp,16
    80002170:	00008067          	ret

0000000080002174 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002174:	fc010113          	addi	sp,sp,-64
    80002178:	02113c23          	sd	ra,56(sp)
    8000217c:	02813823          	sd	s0,48(sp)
    80002180:	02913423          	sd	s1,40(sp)
    80002184:	03213023          	sd	s2,32(sp)
    80002188:	01313c23          	sd	s3,24(sp)
    8000218c:	04010413          	addi	s0,sp,64
    80002190:	00050493          	mv	s1,a0
    80002194:	00058913          	mv	s2,a1
    80002198:	00060993          	mv	s3,a2
    LOCK();
    8000219c:	00100613          	li	a2,1
    800021a0:	00000593          	li	a1,0
    800021a4:	00004517          	auipc	a0,0x4
    800021a8:	abc50513          	addi	a0,a0,-1348 # 80005c60 <lockPrint>
    800021ac:	fffff097          	auipc	ra,0xfffff
    800021b0:	e54080e7          	jalr	-428(ra) # 80001000 <copy_and_swap>
    800021b4:	00050863          	beqz	a0,800021c4 <_Z8printIntiii+0x50>
    800021b8:	fffff097          	auipc	ra,0xfffff
    800021bc:	034080e7          	jalr	52(ra) # 800011ec <_Z15thread_dispatchv>
    800021c0:	fddff06f          	j	8000219c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800021c4:	00098463          	beqz	s3,800021cc <_Z8printIntiii+0x58>
    800021c8:	0804c463          	bltz	s1,80002250 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800021cc:	0004851b          	sext.w	a0,s1
    neg = 0;
    800021d0:	00000593          	li	a1,0
    }

    i = 0;
    800021d4:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800021d8:	0009079b          	sext.w	a5,s2
    800021dc:	0325773b          	remuw	a4,a0,s2
    800021e0:	00048613          	mv	a2,s1
    800021e4:	0014849b          	addiw	s1,s1,1
    800021e8:	02071693          	slli	a3,a4,0x20
    800021ec:	0206d693          	srli	a3,a3,0x20
    800021f0:	00004717          	auipc	a4,0x4
    800021f4:	9c870713          	addi	a4,a4,-1592 # 80005bb8 <digits>
    800021f8:	00d70733          	add	a4,a4,a3
    800021fc:	00074683          	lbu	a3,0(a4)
    80002200:	fd040713          	addi	a4,s0,-48
    80002204:	00c70733          	add	a4,a4,a2
    80002208:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    8000220c:	0005071b          	sext.w	a4,a0
    80002210:	0325553b          	divuw	a0,a0,s2
    80002214:	fcf772e3          	bgeu	a4,a5,800021d8 <_Z8printIntiii+0x64>
    if(neg)
    80002218:	00058c63          	beqz	a1,80002230 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    8000221c:	fd040793          	addi	a5,s0,-48
    80002220:	009784b3          	add	s1,a5,s1
    80002224:	02d00793          	li	a5,45
    80002228:	fef48823          	sb	a5,-16(s1)
    8000222c:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80002230:	fff4849b          	addiw	s1,s1,-1
    80002234:	0204c463          	bltz	s1,8000225c <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80002238:	fd040793          	addi	a5,s0,-48
    8000223c:	009787b3          	add	a5,a5,s1
    80002240:	ff07c503          	lbu	a0,-16(a5)
    80002244:	fffff097          	auipc	ra,0xfffff
    80002248:	0a4080e7          	jalr	164(ra) # 800012e8 <_Z4putcc>
    8000224c:	fe5ff06f          	j	80002230 <_Z8printIntiii+0xbc>
        x = -xx;
    80002250:	4090053b          	negw	a0,s1
        neg = 1;
    80002254:	00100593          	li	a1,1
        x = -xx;
    80002258:	f7dff06f          	j	800021d4 <_Z8printIntiii+0x60>

    UNLOCK();
    8000225c:	00000613          	li	a2,0
    80002260:	00100593          	li	a1,1
    80002264:	00004517          	auipc	a0,0x4
    80002268:	9fc50513          	addi	a0,a0,-1540 # 80005c60 <lockPrint>
    8000226c:	fffff097          	auipc	ra,0xfffff
    80002270:	d94080e7          	jalr	-620(ra) # 80001000 <copy_and_swap>
    80002274:	fe0514e3          	bnez	a0,8000225c <_Z8printIntiii+0xe8>
    80002278:	03813083          	ld	ra,56(sp)
    8000227c:	03013403          	ld	s0,48(sp)
    80002280:	02813483          	ld	s1,40(sp)
    80002284:	02013903          	ld	s2,32(sp)
    80002288:	01813983          	ld	s3,24(sp)
    8000228c:	04010113          	addi	sp,sp,64
    80002290:	00008067          	ret

0000000080002294 <start>:
    80002294:	ff010113          	addi	sp,sp,-16
    80002298:	00813423          	sd	s0,8(sp)
    8000229c:	01010413          	addi	s0,sp,16
    800022a0:	300027f3          	csrr	a5,mstatus
    800022a4:	ffffe737          	lui	a4,0xffffe
    800022a8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff791f>
    800022ac:	00e7f7b3          	and	a5,a5,a4
    800022b0:	00001737          	lui	a4,0x1
    800022b4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800022b8:	00e7e7b3          	or	a5,a5,a4
    800022bc:	30079073          	csrw	mstatus,a5
    800022c0:	00000797          	auipc	a5,0x0
    800022c4:	16078793          	addi	a5,a5,352 # 80002420 <system_main>
    800022c8:	34179073          	csrw	mepc,a5
    800022cc:	00000793          	li	a5,0
    800022d0:	18079073          	csrw	satp,a5
    800022d4:	000107b7          	lui	a5,0x10
    800022d8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022dc:	30279073          	csrw	medeleg,a5
    800022e0:	30379073          	csrw	mideleg,a5
    800022e4:	104027f3          	csrr	a5,sie
    800022e8:	2227e793          	ori	a5,a5,546
    800022ec:	10479073          	csrw	sie,a5
    800022f0:	fff00793          	li	a5,-1
    800022f4:	00a7d793          	srli	a5,a5,0xa
    800022f8:	3b079073          	csrw	pmpaddr0,a5
    800022fc:	00f00793          	li	a5,15
    80002300:	3a079073          	csrw	pmpcfg0,a5
    80002304:	f14027f3          	csrr	a5,mhartid
    80002308:	0200c737          	lui	a4,0x200c
    8000230c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002310:	0007869b          	sext.w	a3,a5
    80002314:	00269713          	slli	a4,a3,0x2
    80002318:	000f4637          	lui	a2,0xf4
    8000231c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002320:	00d70733          	add	a4,a4,a3
    80002324:	0037979b          	slliw	a5,a5,0x3
    80002328:	020046b7          	lui	a3,0x2004
    8000232c:	00d787b3          	add	a5,a5,a3
    80002330:	00c585b3          	add	a1,a1,a2
    80002334:	00371693          	slli	a3,a4,0x3
    80002338:	00004717          	auipc	a4,0x4
    8000233c:	93870713          	addi	a4,a4,-1736 # 80005c70 <timer_scratch>
    80002340:	00b7b023          	sd	a1,0(a5)
    80002344:	00d70733          	add	a4,a4,a3
    80002348:	00f73c23          	sd	a5,24(a4)
    8000234c:	02c73023          	sd	a2,32(a4)
    80002350:	34071073          	csrw	mscratch,a4
    80002354:	00000797          	auipc	a5,0x0
    80002358:	6ec78793          	addi	a5,a5,1772 # 80002a40 <timervec>
    8000235c:	30579073          	csrw	mtvec,a5
    80002360:	300027f3          	csrr	a5,mstatus
    80002364:	0087e793          	ori	a5,a5,8
    80002368:	30079073          	csrw	mstatus,a5
    8000236c:	304027f3          	csrr	a5,mie
    80002370:	0807e793          	ori	a5,a5,128
    80002374:	30479073          	csrw	mie,a5
    80002378:	f14027f3          	csrr	a5,mhartid
    8000237c:	0007879b          	sext.w	a5,a5
    80002380:	00078213          	mv	tp,a5
    80002384:	30200073          	mret
    80002388:	00813403          	ld	s0,8(sp)
    8000238c:	01010113          	addi	sp,sp,16
    80002390:	00008067          	ret

0000000080002394 <timerinit>:
    80002394:	ff010113          	addi	sp,sp,-16
    80002398:	00813423          	sd	s0,8(sp)
    8000239c:	01010413          	addi	s0,sp,16
    800023a0:	f14027f3          	csrr	a5,mhartid
    800023a4:	0200c737          	lui	a4,0x200c
    800023a8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800023ac:	0007869b          	sext.w	a3,a5
    800023b0:	00269713          	slli	a4,a3,0x2
    800023b4:	000f4637          	lui	a2,0xf4
    800023b8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800023bc:	00d70733          	add	a4,a4,a3
    800023c0:	0037979b          	slliw	a5,a5,0x3
    800023c4:	020046b7          	lui	a3,0x2004
    800023c8:	00d787b3          	add	a5,a5,a3
    800023cc:	00c585b3          	add	a1,a1,a2
    800023d0:	00371693          	slli	a3,a4,0x3
    800023d4:	00004717          	auipc	a4,0x4
    800023d8:	89c70713          	addi	a4,a4,-1892 # 80005c70 <timer_scratch>
    800023dc:	00b7b023          	sd	a1,0(a5)
    800023e0:	00d70733          	add	a4,a4,a3
    800023e4:	00f73c23          	sd	a5,24(a4)
    800023e8:	02c73023          	sd	a2,32(a4)
    800023ec:	34071073          	csrw	mscratch,a4
    800023f0:	00000797          	auipc	a5,0x0
    800023f4:	65078793          	addi	a5,a5,1616 # 80002a40 <timervec>
    800023f8:	30579073          	csrw	mtvec,a5
    800023fc:	300027f3          	csrr	a5,mstatus
    80002400:	0087e793          	ori	a5,a5,8
    80002404:	30079073          	csrw	mstatus,a5
    80002408:	304027f3          	csrr	a5,mie
    8000240c:	0807e793          	ori	a5,a5,128
    80002410:	30479073          	csrw	mie,a5
    80002414:	00813403          	ld	s0,8(sp)
    80002418:	01010113          	addi	sp,sp,16
    8000241c:	00008067          	ret

0000000080002420 <system_main>:
    80002420:	fe010113          	addi	sp,sp,-32
    80002424:	00813823          	sd	s0,16(sp)
    80002428:	00913423          	sd	s1,8(sp)
    8000242c:	00113c23          	sd	ra,24(sp)
    80002430:	02010413          	addi	s0,sp,32
    80002434:	00000097          	auipc	ra,0x0
    80002438:	0c4080e7          	jalr	196(ra) # 800024f8 <cpuid>
    8000243c:	00003497          	auipc	s1,0x3
    80002440:	7d448493          	addi	s1,s1,2004 # 80005c10 <started>
    80002444:	02050263          	beqz	a0,80002468 <system_main+0x48>
    80002448:	0004a783          	lw	a5,0(s1)
    8000244c:	0007879b          	sext.w	a5,a5
    80002450:	fe078ce3          	beqz	a5,80002448 <system_main+0x28>
    80002454:	0ff0000f          	fence
    80002458:	00003517          	auipc	a0,0x3
    8000245c:	e9050513          	addi	a0,a0,-368 # 800052e8 <kvmincrease+0xc48>
    80002460:	00001097          	auipc	ra,0x1
    80002464:	a7c080e7          	jalr	-1412(ra) # 80002edc <panic>
    80002468:	00001097          	auipc	ra,0x1
    8000246c:	9d0080e7          	jalr	-1584(ra) # 80002e38 <consoleinit>
    80002470:	00001097          	auipc	ra,0x1
    80002474:	15c080e7          	jalr	348(ra) # 800035cc <printfinit>
    80002478:	00003517          	auipc	a0,0x3
    8000247c:	d3050513          	addi	a0,a0,-720 # 800051a8 <kvmincrease+0xb08>
    80002480:	00001097          	auipc	ra,0x1
    80002484:	ab8080e7          	jalr	-1352(ra) # 80002f38 <__printf>
    80002488:	00003517          	auipc	a0,0x3
    8000248c:	e3050513          	addi	a0,a0,-464 # 800052b8 <kvmincrease+0xc18>
    80002490:	00001097          	auipc	ra,0x1
    80002494:	aa8080e7          	jalr	-1368(ra) # 80002f38 <__printf>
    80002498:	00003517          	auipc	a0,0x3
    8000249c:	d1050513          	addi	a0,a0,-752 # 800051a8 <kvmincrease+0xb08>
    800024a0:	00001097          	auipc	ra,0x1
    800024a4:	a98080e7          	jalr	-1384(ra) # 80002f38 <__printf>
    800024a8:	00001097          	auipc	ra,0x1
    800024ac:	4b0080e7          	jalr	1200(ra) # 80003958 <kinit>
    800024b0:	00000097          	auipc	ra,0x0
    800024b4:	148080e7          	jalr	328(ra) # 800025f8 <trapinit>
    800024b8:	00000097          	auipc	ra,0x0
    800024bc:	16c080e7          	jalr	364(ra) # 80002624 <trapinithart>
    800024c0:	00000097          	auipc	ra,0x0
    800024c4:	5c0080e7          	jalr	1472(ra) # 80002a80 <plicinit>
    800024c8:	00000097          	auipc	ra,0x0
    800024cc:	5e0080e7          	jalr	1504(ra) # 80002aa8 <plicinithart>
    800024d0:	00000097          	auipc	ra,0x0
    800024d4:	078080e7          	jalr	120(ra) # 80002548 <userinit>
    800024d8:	0ff0000f          	fence
    800024dc:	00100793          	li	a5,1
    800024e0:	00003517          	auipc	a0,0x3
    800024e4:	df050513          	addi	a0,a0,-528 # 800052d0 <kvmincrease+0xc30>
    800024e8:	00f4a023          	sw	a5,0(s1)
    800024ec:	00001097          	auipc	ra,0x1
    800024f0:	a4c080e7          	jalr	-1460(ra) # 80002f38 <__printf>
    800024f4:	0000006f          	j	800024f4 <system_main+0xd4>

00000000800024f8 <cpuid>:
    800024f8:	ff010113          	addi	sp,sp,-16
    800024fc:	00813423          	sd	s0,8(sp)
    80002500:	01010413          	addi	s0,sp,16
    80002504:	00020513          	mv	a0,tp
    80002508:	00813403          	ld	s0,8(sp)
    8000250c:	0005051b          	sext.w	a0,a0
    80002510:	01010113          	addi	sp,sp,16
    80002514:	00008067          	ret

0000000080002518 <mycpu>:
    80002518:	ff010113          	addi	sp,sp,-16
    8000251c:	00813423          	sd	s0,8(sp)
    80002520:	01010413          	addi	s0,sp,16
    80002524:	00020793          	mv	a5,tp
    80002528:	00813403          	ld	s0,8(sp)
    8000252c:	0007879b          	sext.w	a5,a5
    80002530:	00779793          	slli	a5,a5,0x7
    80002534:	00004517          	auipc	a0,0x4
    80002538:	76c50513          	addi	a0,a0,1900 # 80006ca0 <cpus>
    8000253c:	00f50533          	add	a0,a0,a5
    80002540:	01010113          	addi	sp,sp,16
    80002544:	00008067          	ret

0000000080002548 <userinit>:
    80002548:	ff010113          	addi	sp,sp,-16
    8000254c:	00813423          	sd	s0,8(sp)
    80002550:	01010413          	addi	s0,sp,16
    80002554:	00813403          	ld	s0,8(sp)
    80002558:	01010113          	addi	sp,sp,16
    8000255c:	fffff317          	auipc	t1,0xfffff
    80002560:	0a430067          	jr	164(t1) # 80001600 <main>

0000000080002564 <either_copyout>:
    80002564:	ff010113          	addi	sp,sp,-16
    80002568:	00813023          	sd	s0,0(sp)
    8000256c:	00113423          	sd	ra,8(sp)
    80002570:	01010413          	addi	s0,sp,16
    80002574:	02051663          	bnez	a0,800025a0 <either_copyout+0x3c>
    80002578:	00058513          	mv	a0,a1
    8000257c:	00060593          	mv	a1,a2
    80002580:	0006861b          	sext.w	a2,a3
    80002584:	00002097          	auipc	ra,0x2
    80002588:	c60080e7          	jalr	-928(ra) # 800041e4 <__memmove>
    8000258c:	00813083          	ld	ra,8(sp)
    80002590:	00013403          	ld	s0,0(sp)
    80002594:	00000513          	li	a0,0
    80002598:	01010113          	addi	sp,sp,16
    8000259c:	00008067          	ret
    800025a0:	00003517          	auipc	a0,0x3
    800025a4:	d7050513          	addi	a0,a0,-656 # 80005310 <kvmincrease+0xc70>
    800025a8:	00001097          	auipc	ra,0x1
    800025ac:	934080e7          	jalr	-1740(ra) # 80002edc <panic>

00000000800025b0 <either_copyin>:
    800025b0:	ff010113          	addi	sp,sp,-16
    800025b4:	00813023          	sd	s0,0(sp)
    800025b8:	00113423          	sd	ra,8(sp)
    800025bc:	01010413          	addi	s0,sp,16
    800025c0:	02059463          	bnez	a1,800025e8 <either_copyin+0x38>
    800025c4:	00060593          	mv	a1,a2
    800025c8:	0006861b          	sext.w	a2,a3
    800025cc:	00002097          	auipc	ra,0x2
    800025d0:	c18080e7          	jalr	-1000(ra) # 800041e4 <__memmove>
    800025d4:	00813083          	ld	ra,8(sp)
    800025d8:	00013403          	ld	s0,0(sp)
    800025dc:	00000513          	li	a0,0
    800025e0:	01010113          	addi	sp,sp,16
    800025e4:	00008067          	ret
    800025e8:	00003517          	auipc	a0,0x3
    800025ec:	d5050513          	addi	a0,a0,-688 # 80005338 <kvmincrease+0xc98>
    800025f0:	00001097          	auipc	ra,0x1
    800025f4:	8ec080e7          	jalr	-1812(ra) # 80002edc <panic>

00000000800025f8 <trapinit>:
    800025f8:	ff010113          	addi	sp,sp,-16
    800025fc:	00813423          	sd	s0,8(sp)
    80002600:	01010413          	addi	s0,sp,16
    80002604:	00813403          	ld	s0,8(sp)
    80002608:	00003597          	auipc	a1,0x3
    8000260c:	d5858593          	addi	a1,a1,-680 # 80005360 <kvmincrease+0xcc0>
    80002610:	00004517          	auipc	a0,0x4
    80002614:	71050513          	addi	a0,a0,1808 # 80006d20 <tickslock>
    80002618:	01010113          	addi	sp,sp,16
    8000261c:	00001317          	auipc	t1,0x1
    80002620:	5cc30067          	jr	1484(t1) # 80003be8 <initlock>

0000000080002624 <trapinithart>:
    80002624:	ff010113          	addi	sp,sp,-16
    80002628:	00813423          	sd	s0,8(sp)
    8000262c:	01010413          	addi	s0,sp,16
    80002630:	00000797          	auipc	a5,0x0
    80002634:	30078793          	addi	a5,a5,768 # 80002930 <kernelvec>
    80002638:	10579073          	csrw	stvec,a5
    8000263c:	00813403          	ld	s0,8(sp)
    80002640:	01010113          	addi	sp,sp,16
    80002644:	00008067          	ret

0000000080002648 <usertrap>:
    80002648:	ff010113          	addi	sp,sp,-16
    8000264c:	00813423          	sd	s0,8(sp)
    80002650:	01010413          	addi	s0,sp,16
    80002654:	00813403          	ld	s0,8(sp)
    80002658:	01010113          	addi	sp,sp,16
    8000265c:	00008067          	ret

0000000080002660 <usertrapret>:
    80002660:	ff010113          	addi	sp,sp,-16
    80002664:	00813423          	sd	s0,8(sp)
    80002668:	01010413          	addi	s0,sp,16
    8000266c:	00813403          	ld	s0,8(sp)
    80002670:	01010113          	addi	sp,sp,16
    80002674:	00008067          	ret

0000000080002678 <kerneltrap>:
    80002678:	fe010113          	addi	sp,sp,-32
    8000267c:	00813823          	sd	s0,16(sp)
    80002680:	00113c23          	sd	ra,24(sp)
    80002684:	00913423          	sd	s1,8(sp)
    80002688:	02010413          	addi	s0,sp,32
    8000268c:	142025f3          	csrr	a1,scause
    80002690:	100027f3          	csrr	a5,sstatus
    80002694:	0027f793          	andi	a5,a5,2
    80002698:	10079c63          	bnez	a5,800027b0 <kerneltrap+0x138>
    8000269c:	142027f3          	csrr	a5,scause
    800026a0:	0207ce63          	bltz	a5,800026dc <kerneltrap+0x64>
    800026a4:	00003517          	auipc	a0,0x3
    800026a8:	d0450513          	addi	a0,a0,-764 # 800053a8 <kvmincrease+0xd08>
    800026ac:	00001097          	auipc	ra,0x1
    800026b0:	88c080e7          	jalr	-1908(ra) # 80002f38 <__printf>
    800026b4:	141025f3          	csrr	a1,sepc
    800026b8:	14302673          	csrr	a2,stval
    800026bc:	00003517          	auipc	a0,0x3
    800026c0:	cfc50513          	addi	a0,a0,-772 # 800053b8 <kvmincrease+0xd18>
    800026c4:	00001097          	auipc	ra,0x1
    800026c8:	874080e7          	jalr	-1932(ra) # 80002f38 <__printf>
    800026cc:	00003517          	auipc	a0,0x3
    800026d0:	d0450513          	addi	a0,a0,-764 # 800053d0 <kvmincrease+0xd30>
    800026d4:	00001097          	auipc	ra,0x1
    800026d8:	808080e7          	jalr	-2040(ra) # 80002edc <panic>
    800026dc:	0ff7f713          	andi	a4,a5,255
    800026e0:	00900693          	li	a3,9
    800026e4:	04d70063          	beq	a4,a3,80002724 <kerneltrap+0xac>
    800026e8:	fff00713          	li	a4,-1
    800026ec:	03f71713          	slli	a4,a4,0x3f
    800026f0:	00170713          	addi	a4,a4,1
    800026f4:	fae798e3          	bne	a5,a4,800026a4 <kerneltrap+0x2c>
    800026f8:	00000097          	auipc	ra,0x0
    800026fc:	e00080e7          	jalr	-512(ra) # 800024f8 <cpuid>
    80002700:	06050663          	beqz	a0,8000276c <kerneltrap+0xf4>
    80002704:	144027f3          	csrr	a5,sip
    80002708:	ffd7f793          	andi	a5,a5,-3
    8000270c:	14479073          	csrw	sip,a5
    80002710:	01813083          	ld	ra,24(sp)
    80002714:	01013403          	ld	s0,16(sp)
    80002718:	00813483          	ld	s1,8(sp)
    8000271c:	02010113          	addi	sp,sp,32
    80002720:	00008067          	ret
    80002724:	00000097          	auipc	ra,0x0
    80002728:	3d0080e7          	jalr	976(ra) # 80002af4 <plic_claim>
    8000272c:	00a00793          	li	a5,10
    80002730:	00050493          	mv	s1,a0
    80002734:	06f50863          	beq	a0,a5,800027a4 <kerneltrap+0x12c>
    80002738:	fc050ce3          	beqz	a0,80002710 <kerneltrap+0x98>
    8000273c:	00050593          	mv	a1,a0
    80002740:	00003517          	auipc	a0,0x3
    80002744:	c4850513          	addi	a0,a0,-952 # 80005388 <kvmincrease+0xce8>
    80002748:	00000097          	auipc	ra,0x0
    8000274c:	7f0080e7          	jalr	2032(ra) # 80002f38 <__printf>
    80002750:	01013403          	ld	s0,16(sp)
    80002754:	01813083          	ld	ra,24(sp)
    80002758:	00048513          	mv	a0,s1
    8000275c:	00813483          	ld	s1,8(sp)
    80002760:	02010113          	addi	sp,sp,32
    80002764:	00000317          	auipc	t1,0x0
    80002768:	3c830067          	jr	968(t1) # 80002b2c <plic_complete>
    8000276c:	00004517          	auipc	a0,0x4
    80002770:	5b450513          	addi	a0,a0,1460 # 80006d20 <tickslock>
    80002774:	00001097          	auipc	ra,0x1
    80002778:	498080e7          	jalr	1176(ra) # 80003c0c <acquire>
    8000277c:	00003717          	auipc	a4,0x3
    80002780:	49870713          	addi	a4,a4,1176 # 80005c14 <ticks>
    80002784:	00072783          	lw	a5,0(a4)
    80002788:	00004517          	auipc	a0,0x4
    8000278c:	59850513          	addi	a0,a0,1432 # 80006d20 <tickslock>
    80002790:	0017879b          	addiw	a5,a5,1
    80002794:	00f72023          	sw	a5,0(a4)
    80002798:	00001097          	auipc	ra,0x1
    8000279c:	540080e7          	jalr	1344(ra) # 80003cd8 <release>
    800027a0:	f65ff06f          	j	80002704 <kerneltrap+0x8c>
    800027a4:	00001097          	auipc	ra,0x1
    800027a8:	09c080e7          	jalr	156(ra) # 80003840 <uartintr>
    800027ac:	fa5ff06f          	j	80002750 <kerneltrap+0xd8>
    800027b0:	00003517          	auipc	a0,0x3
    800027b4:	bb850513          	addi	a0,a0,-1096 # 80005368 <kvmincrease+0xcc8>
    800027b8:	00000097          	auipc	ra,0x0
    800027bc:	724080e7          	jalr	1828(ra) # 80002edc <panic>

00000000800027c0 <clockintr>:
    800027c0:	fe010113          	addi	sp,sp,-32
    800027c4:	00813823          	sd	s0,16(sp)
    800027c8:	00913423          	sd	s1,8(sp)
    800027cc:	00113c23          	sd	ra,24(sp)
    800027d0:	02010413          	addi	s0,sp,32
    800027d4:	00004497          	auipc	s1,0x4
    800027d8:	54c48493          	addi	s1,s1,1356 # 80006d20 <tickslock>
    800027dc:	00048513          	mv	a0,s1
    800027e0:	00001097          	auipc	ra,0x1
    800027e4:	42c080e7          	jalr	1068(ra) # 80003c0c <acquire>
    800027e8:	00003717          	auipc	a4,0x3
    800027ec:	42c70713          	addi	a4,a4,1068 # 80005c14 <ticks>
    800027f0:	00072783          	lw	a5,0(a4)
    800027f4:	01013403          	ld	s0,16(sp)
    800027f8:	01813083          	ld	ra,24(sp)
    800027fc:	00048513          	mv	a0,s1
    80002800:	0017879b          	addiw	a5,a5,1
    80002804:	00813483          	ld	s1,8(sp)
    80002808:	00f72023          	sw	a5,0(a4)
    8000280c:	02010113          	addi	sp,sp,32
    80002810:	00001317          	auipc	t1,0x1
    80002814:	4c830067          	jr	1224(t1) # 80003cd8 <release>

0000000080002818 <devintr>:
    80002818:	142027f3          	csrr	a5,scause
    8000281c:	00000513          	li	a0,0
    80002820:	0007c463          	bltz	a5,80002828 <devintr+0x10>
    80002824:	00008067          	ret
    80002828:	fe010113          	addi	sp,sp,-32
    8000282c:	00813823          	sd	s0,16(sp)
    80002830:	00113c23          	sd	ra,24(sp)
    80002834:	00913423          	sd	s1,8(sp)
    80002838:	02010413          	addi	s0,sp,32
    8000283c:	0ff7f713          	andi	a4,a5,255
    80002840:	00900693          	li	a3,9
    80002844:	04d70c63          	beq	a4,a3,8000289c <devintr+0x84>
    80002848:	fff00713          	li	a4,-1
    8000284c:	03f71713          	slli	a4,a4,0x3f
    80002850:	00170713          	addi	a4,a4,1
    80002854:	00e78c63          	beq	a5,a4,8000286c <devintr+0x54>
    80002858:	01813083          	ld	ra,24(sp)
    8000285c:	01013403          	ld	s0,16(sp)
    80002860:	00813483          	ld	s1,8(sp)
    80002864:	02010113          	addi	sp,sp,32
    80002868:	00008067          	ret
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	c8c080e7          	jalr	-884(ra) # 800024f8 <cpuid>
    80002874:	06050663          	beqz	a0,800028e0 <devintr+0xc8>
    80002878:	144027f3          	csrr	a5,sip
    8000287c:	ffd7f793          	andi	a5,a5,-3
    80002880:	14479073          	csrw	sip,a5
    80002884:	01813083          	ld	ra,24(sp)
    80002888:	01013403          	ld	s0,16(sp)
    8000288c:	00813483          	ld	s1,8(sp)
    80002890:	00200513          	li	a0,2
    80002894:	02010113          	addi	sp,sp,32
    80002898:	00008067          	ret
    8000289c:	00000097          	auipc	ra,0x0
    800028a0:	258080e7          	jalr	600(ra) # 80002af4 <plic_claim>
    800028a4:	00a00793          	li	a5,10
    800028a8:	00050493          	mv	s1,a0
    800028ac:	06f50663          	beq	a0,a5,80002918 <devintr+0x100>
    800028b0:	00100513          	li	a0,1
    800028b4:	fa0482e3          	beqz	s1,80002858 <devintr+0x40>
    800028b8:	00048593          	mv	a1,s1
    800028bc:	00003517          	auipc	a0,0x3
    800028c0:	acc50513          	addi	a0,a0,-1332 # 80005388 <kvmincrease+0xce8>
    800028c4:	00000097          	auipc	ra,0x0
    800028c8:	674080e7          	jalr	1652(ra) # 80002f38 <__printf>
    800028cc:	00048513          	mv	a0,s1
    800028d0:	00000097          	auipc	ra,0x0
    800028d4:	25c080e7          	jalr	604(ra) # 80002b2c <plic_complete>
    800028d8:	00100513          	li	a0,1
    800028dc:	f7dff06f          	j	80002858 <devintr+0x40>
    800028e0:	00004517          	auipc	a0,0x4
    800028e4:	44050513          	addi	a0,a0,1088 # 80006d20 <tickslock>
    800028e8:	00001097          	auipc	ra,0x1
    800028ec:	324080e7          	jalr	804(ra) # 80003c0c <acquire>
    800028f0:	00003717          	auipc	a4,0x3
    800028f4:	32470713          	addi	a4,a4,804 # 80005c14 <ticks>
    800028f8:	00072783          	lw	a5,0(a4)
    800028fc:	00004517          	auipc	a0,0x4
    80002900:	42450513          	addi	a0,a0,1060 # 80006d20 <tickslock>
    80002904:	0017879b          	addiw	a5,a5,1
    80002908:	00f72023          	sw	a5,0(a4)
    8000290c:	00001097          	auipc	ra,0x1
    80002910:	3cc080e7          	jalr	972(ra) # 80003cd8 <release>
    80002914:	f65ff06f          	j	80002878 <devintr+0x60>
    80002918:	00001097          	auipc	ra,0x1
    8000291c:	f28080e7          	jalr	-216(ra) # 80003840 <uartintr>
    80002920:	fadff06f          	j	800028cc <devintr+0xb4>
	...

0000000080002930 <kernelvec>:
    80002930:	f0010113          	addi	sp,sp,-256
    80002934:	00113023          	sd	ra,0(sp)
    80002938:	00213423          	sd	sp,8(sp)
    8000293c:	00313823          	sd	gp,16(sp)
    80002940:	00413c23          	sd	tp,24(sp)
    80002944:	02513023          	sd	t0,32(sp)
    80002948:	02613423          	sd	t1,40(sp)
    8000294c:	02713823          	sd	t2,48(sp)
    80002950:	02813c23          	sd	s0,56(sp)
    80002954:	04913023          	sd	s1,64(sp)
    80002958:	04a13423          	sd	a0,72(sp)
    8000295c:	04b13823          	sd	a1,80(sp)
    80002960:	04c13c23          	sd	a2,88(sp)
    80002964:	06d13023          	sd	a3,96(sp)
    80002968:	06e13423          	sd	a4,104(sp)
    8000296c:	06f13823          	sd	a5,112(sp)
    80002970:	07013c23          	sd	a6,120(sp)
    80002974:	09113023          	sd	a7,128(sp)
    80002978:	09213423          	sd	s2,136(sp)
    8000297c:	09313823          	sd	s3,144(sp)
    80002980:	09413c23          	sd	s4,152(sp)
    80002984:	0b513023          	sd	s5,160(sp)
    80002988:	0b613423          	sd	s6,168(sp)
    8000298c:	0b713823          	sd	s7,176(sp)
    80002990:	0b813c23          	sd	s8,184(sp)
    80002994:	0d913023          	sd	s9,192(sp)
    80002998:	0da13423          	sd	s10,200(sp)
    8000299c:	0db13823          	sd	s11,208(sp)
    800029a0:	0dc13c23          	sd	t3,216(sp)
    800029a4:	0fd13023          	sd	t4,224(sp)
    800029a8:	0fe13423          	sd	t5,232(sp)
    800029ac:	0ff13823          	sd	t6,240(sp)
    800029b0:	cc9ff0ef          	jal	ra,80002678 <kerneltrap>
    800029b4:	00013083          	ld	ra,0(sp)
    800029b8:	00813103          	ld	sp,8(sp)
    800029bc:	01013183          	ld	gp,16(sp)
    800029c0:	02013283          	ld	t0,32(sp)
    800029c4:	02813303          	ld	t1,40(sp)
    800029c8:	03013383          	ld	t2,48(sp)
    800029cc:	03813403          	ld	s0,56(sp)
    800029d0:	04013483          	ld	s1,64(sp)
    800029d4:	04813503          	ld	a0,72(sp)
    800029d8:	05013583          	ld	a1,80(sp)
    800029dc:	05813603          	ld	a2,88(sp)
    800029e0:	06013683          	ld	a3,96(sp)
    800029e4:	06813703          	ld	a4,104(sp)
    800029e8:	07013783          	ld	a5,112(sp)
    800029ec:	07813803          	ld	a6,120(sp)
    800029f0:	08013883          	ld	a7,128(sp)
    800029f4:	08813903          	ld	s2,136(sp)
    800029f8:	09013983          	ld	s3,144(sp)
    800029fc:	09813a03          	ld	s4,152(sp)
    80002a00:	0a013a83          	ld	s5,160(sp)
    80002a04:	0a813b03          	ld	s6,168(sp)
    80002a08:	0b013b83          	ld	s7,176(sp)
    80002a0c:	0b813c03          	ld	s8,184(sp)
    80002a10:	0c013c83          	ld	s9,192(sp)
    80002a14:	0c813d03          	ld	s10,200(sp)
    80002a18:	0d013d83          	ld	s11,208(sp)
    80002a1c:	0d813e03          	ld	t3,216(sp)
    80002a20:	0e013e83          	ld	t4,224(sp)
    80002a24:	0e813f03          	ld	t5,232(sp)
    80002a28:	0f013f83          	ld	t6,240(sp)
    80002a2c:	10010113          	addi	sp,sp,256
    80002a30:	10200073          	sret
    80002a34:	00000013          	nop
    80002a38:	00000013          	nop
    80002a3c:	00000013          	nop

0000000080002a40 <timervec>:
    80002a40:	34051573          	csrrw	a0,mscratch,a0
    80002a44:	00b53023          	sd	a1,0(a0)
    80002a48:	00c53423          	sd	a2,8(a0)
    80002a4c:	00d53823          	sd	a3,16(a0)
    80002a50:	01853583          	ld	a1,24(a0)
    80002a54:	02053603          	ld	a2,32(a0)
    80002a58:	0005b683          	ld	a3,0(a1)
    80002a5c:	00c686b3          	add	a3,a3,a2
    80002a60:	00d5b023          	sd	a3,0(a1)
    80002a64:	00200593          	li	a1,2
    80002a68:	14459073          	csrw	sip,a1
    80002a6c:	01053683          	ld	a3,16(a0)
    80002a70:	00853603          	ld	a2,8(a0)
    80002a74:	00053583          	ld	a1,0(a0)
    80002a78:	34051573          	csrrw	a0,mscratch,a0
    80002a7c:	30200073          	mret

0000000080002a80 <plicinit>:
    80002a80:	ff010113          	addi	sp,sp,-16
    80002a84:	00813423          	sd	s0,8(sp)
    80002a88:	01010413          	addi	s0,sp,16
    80002a8c:	00813403          	ld	s0,8(sp)
    80002a90:	0c0007b7          	lui	a5,0xc000
    80002a94:	00100713          	li	a4,1
    80002a98:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002a9c:	00e7a223          	sw	a4,4(a5)
    80002aa0:	01010113          	addi	sp,sp,16
    80002aa4:	00008067          	ret

0000000080002aa8 <plicinithart>:
    80002aa8:	ff010113          	addi	sp,sp,-16
    80002aac:	00813023          	sd	s0,0(sp)
    80002ab0:	00113423          	sd	ra,8(sp)
    80002ab4:	01010413          	addi	s0,sp,16
    80002ab8:	00000097          	auipc	ra,0x0
    80002abc:	a40080e7          	jalr	-1472(ra) # 800024f8 <cpuid>
    80002ac0:	0085171b          	slliw	a4,a0,0x8
    80002ac4:	0c0027b7          	lui	a5,0xc002
    80002ac8:	00e787b3          	add	a5,a5,a4
    80002acc:	40200713          	li	a4,1026
    80002ad0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002ad4:	00813083          	ld	ra,8(sp)
    80002ad8:	00013403          	ld	s0,0(sp)
    80002adc:	00d5151b          	slliw	a0,a0,0xd
    80002ae0:	0c2017b7          	lui	a5,0xc201
    80002ae4:	00a78533          	add	a0,a5,a0
    80002ae8:	00052023          	sw	zero,0(a0)
    80002aec:	01010113          	addi	sp,sp,16
    80002af0:	00008067          	ret

0000000080002af4 <plic_claim>:
    80002af4:	ff010113          	addi	sp,sp,-16
    80002af8:	00813023          	sd	s0,0(sp)
    80002afc:	00113423          	sd	ra,8(sp)
    80002b00:	01010413          	addi	s0,sp,16
    80002b04:	00000097          	auipc	ra,0x0
    80002b08:	9f4080e7          	jalr	-1548(ra) # 800024f8 <cpuid>
    80002b0c:	00813083          	ld	ra,8(sp)
    80002b10:	00013403          	ld	s0,0(sp)
    80002b14:	00d5151b          	slliw	a0,a0,0xd
    80002b18:	0c2017b7          	lui	a5,0xc201
    80002b1c:	00a78533          	add	a0,a5,a0
    80002b20:	00452503          	lw	a0,4(a0)
    80002b24:	01010113          	addi	sp,sp,16
    80002b28:	00008067          	ret

0000000080002b2c <plic_complete>:
    80002b2c:	fe010113          	addi	sp,sp,-32
    80002b30:	00813823          	sd	s0,16(sp)
    80002b34:	00913423          	sd	s1,8(sp)
    80002b38:	00113c23          	sd	ra,24(sp)
    80002b3c:	02010413          	addi	s0,sp,32
    80002b40:	00050493          	mv	s1,a0
    80002b44:	00000097          	auipc	ra,0x0
    80002b48:	9b4080e7          	jalr	-1612(ra) # 800024f8 <cpuid>
    80002b4c:	01813083          	ld	ra,24(sp)
    80002b50:	01013403          	ld	s0,16(sp)
    80002b54:	00d5179b          	slliw	a5,a0,0xd
    80002b58:	0c201737          	lui	a4,0xc201
    80002b5c:	00f707b3          	add	a5,a4,a5
    80002b60:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002b64:	00813483          	ld	s1,8(sp)
    80002b68:	02010113          	addi	sp,sp,32
    80002b6c:	00008067          	ret

0000000080002b70 <consolewrite>:
    80002b70:	fb010113          	addi	sp,sp,-80
    80002b74:	04813023          	sd	s0,64(sp)
    80002b78:	04113423          	sd	ra,72(sp)
    80002b7c:	02913c23          	sd	s1,56(sp)
    80002b80:	03213823          	sd	s2,48(sp)
    80002b84:	03313423          	sd	s3,40(sp)
    80002b88:	03413023          	sd	s4,32(sp)
    80002b8c:	01513c23          	sd	s5,24(sp)
    80002b90:	05010413          	addi	s0,sp,80
    80002b94:	06c05c63          	blez	a2,80002c0c <consolewrite+0x9c>
    80002b98:	00060993          	mv	s3,a2
    80002b9c:	00050a13          	mv	s4,a0
    80002ba0:	00058493          	mv	s1,a1
    80002ba4:	00000913          	li	s2,0
    80002ba8:	fff00a93          	li	s5,-1
    80002bac:	01c0006f          	j	80002bc8 <consolewrite+0x58>
    80002bb0:	fbf44503          	lbu	a0,-65(s0)
    80002bb4:	0019091b          	addiw	s2,s2,1
    80002bb8:	00148493          	addi	s1,s1,1
    80002bbc:	00001097          	auipc	ra,0x1
    80002bc0:	a9c080e7          	jalr	-1380(ra) # 80003658 <uartputc>
    80002bc4:	03298063          	beq	s3,s2,80002be4 <consolewrite+0x74>
    80002bc8:	00048613          	mv	a2,s1
    80002bcc:	00100693          	li	a3,1
    80002bd0:	000a0593          	mv	a1,s4
    80002bd4:	fbf40513          	addi	a0,s0,-65
    80002bd8:	00000097          	auipc	ra,0x0
    80002bdc:	9d8080e7          	jalr	-1576(ra) # 800025b0 <either_copyin>
    80002be0:	fd5518e3          	bne	a0,s5,80002bb0 <consolewrite+0x40>
    80002be4:	04813083          	ld	ra,72(sp)
    80002be8:	04013403          	ld	s0,64(sp)
    80002bec:	03813483          	ld	s1,56(sp)
    80002bf0:	02813983          	ld	s3,40(sp)
    80002bf4:	02013a03          	ld	s4,32(sp)
    80002bf8:	01813a83          	ld	s5,24(sp)
    80002bfc:	00090513          	mv	a0,s2
    80002c00:	03013903          	ld	s2,48(sp)
    80002c04:	05010113          	addi	sp,sp,80
    80002c08:	00008067          	ret
    80002c0c:	00000913          	li	s2,0
    80002c10:	fd5ff06f          	j	80002be4 <consolewrite+0x74>

0000000080002c14 <consoleread>:
    80002c14:	f9010113          	addi	sp,sp,-112
    80002c18:	06813023          	sd	s0,96(sp)
    80002c1c:	04913c23          	sd	s1,88(sp)
    80002c20:	05213823          	sd	s2,80(sp)
    80002c24:	05313423          	sd	s3,72(sp)
    80002c28:	05413023          	sd	s4,64(sp)
    80002c2c:	03513c23          	sd	s5,56(sp)
    80002c30:	03613823          	sd	s6,48(sp)
    80002c34:	03713423          	sd	s7,40(sp)
    80002c38:	03813023          	sd	s8,32(sp)
    80002c3c:	06113423          	sd	ra,104(sp)
    80002c40:	01913c23          	sd	s9,24(sp)
    80002c44:	07010413          	addi	s0,sp,112
    80002c48:	00060b93          	mv	s7,a2
    80002c4c:	00050913          	mv	s2,a0
    80002c50:	00058c13          	mv	s8,a1
    80002c54:	00060b1b          	sext.w	s6,a2
    80002c58:	00004497          	auipc	s1,0x4
    80002c5c:	0f048493          	addi	s1,s1,240 # 80006d48 <cons>
    80002c60:	00400993          	li	s3,4
    80002c64:	fff00a13          	li	s4,-1
    80002c68:	00a00a93          	li	s5,10
    80002c6c:	05705e63          	blez	s7,80002cc8 <consoleread+0xb4>
    80002c70:	09c4a703          	lw	a4,156(s1)
    80002c74:	0984a783          	lw	a5,152(s1)
    80002c78:	0007071b          	sext.w	a4,a4
    80002c7c:	08e78463          	beq	a5,a4,80002d04 <consoleread+0xf0>
    80002c80:	07f7f713          	andi	a4,a5,127
    80002c84:	00e48733          	add	a4,s1,a4
    80002c88:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002c8c:	0017869b          	addiw	a3,a5,1
    80002c90:	08d4ac23          	sw	a3,152(s1)
    80002c94:	00070c9b          	sext.w	s9,a4
    80002c98:	0b370663          	beq	a4,s3,80002d44 <consoleread+0x130>
    80002c9c:	00100693          	li	a3,1
    80002ca0:	f9f40613          	addi	a2,s0,-97
    80002ca4:	000c0593          	mv	a1,s8
    80002ca8:	00090513          	mv	a0,s2
    80002cac:	f8e40fa3          	sb	a4,-97(s0)
    80002cb0:	00000097          	auipc	ra,0x0
    80002cb4:	8b4080e7          	jalr	-1868(ra) # 80002564 <either_copyout>
    80002cb8:	01450863          	beq	a0,s4,80002cc8 <consoleread+0xb4>
    80002cbc:	001c0c13          	addi	s8,s8,1
    80002cc0:	fffb8b9b          	addiw	s7,s7,-1
    80002cc4:	fb5c94e3          	bne	s9,s5,80002c6c <consoleread+0x58>
    80002cc8:	000b851b          	sext.w	a0,s7
    80002ccc:	06813083          	ld	ra,104(sp)
    80002cd0:	06013403          	ld	s0,96(sp)
    80002cd4:	05813483          	ld	s1,88(sp)
    80002cd8:	05013903          	ld	s2,80(sp)
    80002cdc:	04813983          	ld	s3,72(sp)
    80002ce0:	04013a03          	ld	s4,64(sp)
    80002ce4:	03813a83          	ld	s5,56(sp)
    80002ce8:	02813b83          	ld	s7,40(sp)
    80002cec:	02013c03          	ld	s8,32(sp)
    80002cf0:	01813c83          	ld	s9,24(sp)
    80002cf4:	40ab053b          	subw	a0,s6,a0
    80002cf8:	03013b03          	ld	s6,48(sp)
    80002cfc:	07010113          	addi	sp,sp,112
    80002d00:	00008067          	ret
    80002d04:	00001097          	auipc	ra,0x1
    80002d08:	1d8080e7          	jalr	472(ra) # 80003edc <push_on>
    80002d0c:	0984a703          	lw	a4,152(s1)
    80002d10:	09c4a783          	lw	a5,156(s1)
    80002d14:	0007879b          	sext.w	a5,a5
    80002d18:	fef70ce3          	beq	a4,a5,80002d10 <consoleread+0xfc>
    80002d1c:	00001097          	auipc	ra,0x1
    80002d20:	234080e7          	jalr	564(ra) # 80003f50 <pop_on>
    80002d24:	0984a783          	lw	a5,152(s1)
    80002d28:	07f7f713          	andi	a4,a5,127
    80002d2c:	00e48733          	add	a4,s1,a4
    80002d30:	01874703          	lbu	a4,24(a4)
    80002d34:	0017869b          	addiw	a3,a5,1
    80002d38:	08d4ac23          	sw	a3,152(s1)
    80002d3c:	00070c9b          	sext.w	s9,a4
    80002d40:	f5371ee3          	bne	a4,s3,80002c9c <consoleread+0x88>
    80002d44:	000b851b          	sext.w	a0,s7
    80002d48:	f96bf2e3          	bgeu	s7,s6,80002ccc <consoleread+0xb8>
    80002d4c:	08f4ac23          	sw	a5,152(s1)
    80002d50:	f7dff06f          	j	80002ccc <consoleread+0xb8>

0000000080002d54 <consputc>:
    80002d54:	10000793          	li	a5,256
    80002d58:	00f50663          	beq	a0,a5,80002d64 <consputc+0x10>
    80002d5c:	00001317          	auipc	t1,0x1
    80002d60:	9f430067          	jr	-1548(t1) # 80003750 <uartputc_sync>
    80002d64:	ff010113          	addi	sp,sp,-16
    80002d68:	00113423          	sd	ra,8(sp)
    80002d6c:	00813023          	sd	s0,0(sp)
    80002d70:	01010413          	addi	s0,sp,16
    80002d74:	00800513          	li	a0,8
    80002d78:	00001097          	auipc	ra,0x1
    80002d7c:	9d8080e7          	jalr	-1576(ra) # 80003750 <uartputc_sync>
    80002d80:	02000513          	li	a0,32
    80002d84:	00001097          	auipc	ra,0x1
    80002d88:	9cc080e7          	jalr	-1588(ra) # 80003750 <uartputc_sync>
    80002d8c:	00013403          	ld	s0,0(sp)
    80002d90:	00813083          	ld	ra,8(sp)
    80002d94:	00800513          	li	a0,8
    80002d98:	01010113          	addi	sp,sp,16
    80002d9c:	00001317          	auipc	t1,0x1
    80002da0:	9b430067          	jr	-1612(t1) # 80003750 <uartputc_sync>

0000000080002da4 <consoleintr>:
    80002da4:	fe010113          	addi	sp,sp,-32
    80002da8:	00813823          	sd	s0,16(sp)
    80002dac:	00913423          	sd	s1,8(sp)
    80002db0:	01213023          	sd	s2,0(sp)
    80002db4:	00113c23          	sd	ra,24(sp)
    80002db8:	02010413          	addi	s0,sp,32
    80002dbc:	00004917          	auipc	s2,0x4
    80002dc0:	f8c90913          	addi	s2,s2,-116 # 80006d48 <cons>
    80002dc4:	00050493          	mv	s1,a0
    80002dc8:	00090513          	mv	a0,s2
    80002dcc:	00001097          	auipc	ra,0x1
    80002dd0:	e40080e7          	jalr	-448(ra) # 80003c0c <acquire>
    80002dd4:	02048c63          	beqz	s1,80002e0c <consoleintr+0x68>
    80002dd8:	0a092783          	lw	a5,160(s2)
    80002ddc:	09892703          	lw	a4,152(s2)
    80002de0:	07f00693          	li	a3,127
    80002de4:	40e7873b          	subw	a4,a5,a4
    80002de8:	02e6e263          	bltu	a3,a4,80002e0c <consoleintr+0x68>
    80002dec:	00d00713          	li	a4,13
    80002df0:	04e48063          	beq	s1,a4,80002e30 <consoleintr+0x8c>
    80002df4:	07f7f713          	andi	a4,a5,127
    80002df8:	00e90733          	add	a4,s2,a4
    80002dfc:	0017879b          	addiw	a5,a5,1
    80002e00:	0af92023          	sw	a5,160(s2)
    80002e04:	00970c23          	sb	s1,24(a4)
    80002e08:	08f92e23          	sw	a5,156(s2)
    80002e0c:	01013403          	ld	s0,16(sp)
    80002e10:	01813083          	ld	ra,24(sp)
    80002e14:	00813483          	ld	s1,8(sp)
    80002e18:	00013903          	ld	s2,0(sp)
    80002e1c:	00004517          	auipc	a0,0x4
    80002e20:	f2c50513          	addi	a0,a0,-212 # 80006d48 <cons>
    80002e24:	02010113          	addi	sp,sp,32
    80002e28:	00001317          	auipc	t1,0x1
    80002e2c:	eb030067          	jr	-336(t1) # 80003cd8 <release>
    80002e30:	00a00493          	li	s1,10
    80002e34:	fc1ff06f          	j	80002df4 <consoleintr+0x50>

0000000080002e38 <consoleinit>:
    80002e38:	fe010113          	addi	sp,sp,-32
    80002e3c:	00113c23          	sd	ra,24(sp)
    80002e40:	00813823          	sd	s0,16(sp)
    80002e44:	00913423          	sd	s1,8(sp)
    80002e48:	02010413          	addi	s0,sp,32
    80002e4c:	00004497          	auipc	s1,0x4
    80002e50:	efc48493          	addi	s1,s1,-260 # 80006d48 <cons>
    80002e54:	00048513          	mv	a0,s1
    80002e58:	00002597          	auipc	a1,0x2
    80002e5c:	58858593          	addi	a1,a1,1416 # 800053e0 <kvmincrease+0xd40>
    80002e60:	00001097          	auipc	ra,0x1
    80002e64:	d88080e7          	jalr	-632(ra) # 80003be8 <initlock>
    80002e68:	00000097          	auipc	ra,0x0
    80002e6c:	7ac080e7          	jalr	1964(ra) # 80003614 <uartinit>
    80002e70:	01813083          	ld	ra,24(sp)
    80002e74:	01013403          	ld	s0,16(sp)
    80002e78:	00000797          	auipc	a5,0x0
    80002e7c:	d9c78793          	addi	a5,a5,-612 # 80002c14 <consoleread>
    80002e80:	0af4bc23          	sd	a5,184(s1)
    80002e84:	00000797          	auipc	a5,0x0
    80002e88:	cec78793          	addi	a5,a5,-788 # 80002b70 <consolewrite>
    80002e8c:	0cf4b023          	sd	a5,192(s1)
    80002e90:	00813483          	ld	s1,8(sp)
    80002e94:	02010113          	addi	sp,sp,32
    80002e98:	00008067          	ret

0000000080002e9c <console_read>:
    80002e9c:	ff010113          	addi	sp,sp,-16
    80002ea0:	00813423          	sd	s0,8(sp)
    80002ea4:	01010413          	addi	s0,sp,16
    80002ea8:	00813403          	ld	s0,8(sp)
    80002eac:	00004317          	auipc	t1,0x4
    80002eb0:	f5433303          	ld	t1,-172(t1) # 80006e00 <devsw+0x10>
    80002eb4:	01010113          	addi	sp,sp,16
    80002eb8:	00030067          	jr	t1

0000000080002ebc <console_write>:
    80002ebc:	ff010113          	addi	sp,sp,-16
    80002ec0:	00813423          	sd	s0,8(sp)
    80002ec4:	01010413          	addi	s0,sp,16
    80002ec8:	00813403          	ld	s0,8(sp)
    80002ecc:	00004317          	auipc	t1,0x4
    80002ed0:	f3c33303          	ld	t1,-196(t1) # 80006e08 <devsw+0x18>
    80002ed4:	01010113          	addi	sp,sp,16
    80002ed8:	00030067          	jr	t1

0000000080002edc <panic>:
    80002edc:	fe010113          	addi	sp,sp,-32
    80002ee0:	00113c23          	sd	ra,24(sp)
    80002ee4:	00813823          	sd	s0,16(sp)
    80002ee8:	00913423          	sd	s1,8(sp)
    80002eec:	02010413          	addi	s0,sp,32
    80002ef0:	00050493          	mv	s1,a0
    80002ef4:	00002517          	auipc	a0,0x2
    80002ef8:	4f450513          	addi	a0,a0,1268 # 800053e8 <kvmincrease+0xd48>
    80002efc:	00004797          	auipc	a5,0x4
    80002f00:	fa07a623          	sw	zero,-84(a5) # 80006ea8 <pr+0x18>
    80002f04:	00000097          	auipc	ra,0x0
    80002f08:	034080e7          	jalr	52(ra) # 80002f38 <__printf>
    80002f0c:	00048513          	mv	a0,s1
    80002f10:	00000097          	auipc	ra,0x0
    80002f14:	028080e7          	jalr	40(ra) # 80002f38 <__printf>
    80002f18:	00002517          	auipc	a0,0x2
    80002f1c:	29050513          	addi	a0,a0,656 # 800051a8 <kvmincrease+0xb08>
    80002f20:	00000097          	auipc	ra,0x0
    80002f24:	018080e7          	jalr	24(ra) # 80002f38 <__printf>
    80002f28:	00100793          	li	a5,1
    80002f2c:	00003717          	auipc	a4,0x3
    80002f30:	cef72623          	sw	a5,-788(a4) # 80005c18 <panicked>
    80002f34:	0000006f          	j	80002f34 <panic+0x58>

0000000080002f38 <__printf>:
    80002f38:	f3010113          	addi	sp,sp,-208
    80002f3c:	08813023          	sd	s0,128(sp)
    80002f40:	07313423          	sd	s3,104(sp)
    80002f44:	09010413          	addi	s0,sp,144
    80002f48:	05813023          	sd	s8,64(sp)
    80002f4c:	08113423          	sd	ra,136(sp)
    80002f50:	06913c23          	sd	s1,120(sp)
    80002f54:	07213823          	sd	s2,112(sp)
    80002f58:	07413023          	sd	s4,96(sp)
    80002f5c:	05513c23          	sd	s5,88(sp)
    80002f60:	05613823          	sd	s6,80(sp)
    80002f64:	05713423          	sd	s7,72(sp)
    80002f68:	03913c23          	sd	s9,56(sp)
    80002f6c:	03a13823          	sd	s10,48(sp)
    80002f70:	03b13423          	sd	s11,40(sp)
    80002f74:	00004317          	auipc	t1,0x4
    80002f78:	f1c30313          	addi	t1,t1,-228 # 80006e90 <pr>
    80002f7c:	01832c03          	lw	s8,24(t1)
    80002f80:	00b43423          	sd	a1,8(s0)
    80002f84:	00c43823          	sd	a2,16(s0)
    80002f88:	00d43c23          	sd	a3,24(s0)
    80002f8c:	02e43023          	sd	a4,32(s0)
    80002f90:	02f43423          	sd	a5,40(s0)
    80002f94:	03043823          	sd	a6,48(s0)
    80002f98:	03143c23          	sd	a7,56(s0)
    80002f9c:	00050993          	mv	s3,a0
    80002fa0:	4a0c1663          	bnez	s8,8000344c <__printf+0x514>
    80002fa4:	60098c63          	beqz	s3,800035bc <__printf+0x684>
    80002fa8:	0009c503          	lbu	a0,0(s3)
    80002fac:	00840793          	addi	a5,s0,8
    80002fb0:	f6f43c23          	sd	a5,-136(s0)
    80002fb4:	00000493          	li	s1,0
    80002fb8:	22050063          	beqz	a0,800031d8 <__printf+0x2a0>
    80002fbc:	00002a37          	lui	s4,0x2
    80002fc0:	00018ab7          	lui	s5,0x18
    80002fc4:	000f4b37          	lui	s6,0xf4
    80002fc8:	00989bb7          	lui	s7,0x989
    80002fcc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002fd0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002fd4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002fd8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002fdc:	00148c9b          	addiw	s9,s1,1
    80002fe0:	02500793          	li	a5,37
    80002fe4:	01998933          	add	s2,s3,s9
    80002fe8:	38f51263          	bne	a0,a5,8000336c <__printf+0x434>
    80002fec:	00094783          	lbu	a5,0(s2)
    80002ff0:	00078c9b          	sext.w	s9,a5
    80002ff4:	1e078263          	beqz	a5,800031d8 <__printf+0x2a0>
    80002ff8:	0024849b          	addiw	s1,s1,2
    80002ffc:	07000713          	li	a4,112
    80003000:	00998933          	add	s2,s3,s1
    80003004:	38e78a63          	beq	a5,a4,80003398 <__printf+0x460>
    80003008:	20f76863          	bltu	a4,a5,80003218 <__printf+0x2e0>
    8000300c:	42a78863          	beq	a5,a0,8000343c <__printf+0x504>
    80003010:	06400713          	li	a4,100
    80003014:	40e79663          	bne	a5,a4,80003420 <__printf+0x4e8>
    80003018:	f7843783          	ld	a5,-136(s0)
    8000301c:	0007a603          	lw	a2,0(a5)
    80003020:	00878793          	addi	a5,a5,8
    80003024:	f6f43c23          	sd	a5,-136(s0)
    80003028:	42064a63          	bltz	a2,8000345c <__printf+0x524>
    8000302c:	00a00713          	li	a4,10
    80003030:	02e677bb          	remuw	a5,a2,a4
    80003034:	00002d97          	auipc	s11,0x2
    80003038:	3dcd8d93          	addi	s11,s11,988 # 80005410 <digits>
    8000303c:	00900593          	li	a1,9
    80003040:	0006051b          	sext.w	a0,a2
    80003044:	00000c93          	li	s9,0
    80003048:	02079793          	slli	a5,a5,0x20
    8000304c:	0207d793          	srli	a5,a5,0x20
    80003050:	00fd87b3          	add	a5,s11,a5
    80003054:	0007c783          	lbu	a5,0(a5)
    80003058:	02e656bb          	divuw	a3,a2,a4
    8000305c:	f8f40023          	sb	a5,-128(s0)
    80003060:	14c5d863          	bge	a1,a2,800031b0 <__printf+0x278>
    80003064:	06300593          	li	a1,99
    80003068:	00100c93          	li	s9,1
    8000306c:	02e6f7bb          	remuw	a5,a3,a4
    80003070:	02079793          	slli	a5,a5,0x20
    80003074:	0207d793          	srli	a5,a5,0x20
    80003078:	00fd87b3          	add	a5,s11,a5
    8000307c:	0007c783          	lbu	a5,0(a5)
    80003080:	02e6d73b          	divuw	a4,a3,a4
    80003084:	f8f400a3          	sb	a5,-127(s0)
    80003088:	12a5f463          	bgeu	a1,a0,800031b0 <__printf+0x278>
    8000308c:	00a00693          	li	a3,10
    80003090:	00900593          	li	a1,9
    80003094:	02d777bb          	remuw	a5,a4,a3
    80003098:	02079793          	slli	a5,a5,0x20
    8000309c:	0207d793          	srli	a5,a5,0x20
    800030a0:	00fd87b3          	add	a5,s11,a5
    800030a4:	0007c503          	lbu	a0,0(a5)
    800030a8:	02d757bb          	divuw	a5,a4,a3
    800030ac:	f8a40123          	sb	a0,-126(s0)
    800030b0:	48e5f263          	bgeu	a1,a4,80003534 <__printf+0x5fc>
    800030b4:	06300513          	li	a0,99
    800030b8:	02d7f5bb          	remuw	a1,a5,a3
    800030bc:	02059593          	slli	a1,a1,0x20
    800030c0:	0205d593          	srli	a1,a1,0x20
    800030c4:	00bd85b3          	add	a1,s11,a1
    800030c8:	0005c583          	lbu	a1,0(a1)
    800030cc:	02d7d7bb          	divuw	a5,a5,a3
    800030d0:	f8b401a3          	sb	a1,-125(s0)
    800030d4:	48e57263          	bgeu	a0,a4,80003558 <__printf+0x620>
    800030d8:	3e700513          	li	a0,999
    800030dc:	02d7f5bb          	remuw	a1,a5,a3
    800030e0:	02059593          	slli	a1,a1,0x20
    800030e4:	0205d593          	srli	a1,a1,0x20
    800030e8:	00bd85b3          	add	a1,s11,a1
    800030ec:	0005c583          	lbu	a1,0(a1)
    800030f0:	02d7d7bb          	divuw	a5,a5,a3
    800030f4:	f8b40223          	sb	a1,-124(s0)
    800030f8:	46e57663          	bgeu	a0,a4,80003564 <__printf+0x62c>
    800030fc:	02d7f5bb          	remuw	a1,a5,a3
    80003100:	02059593          	slli	a1,a1,0x20
    80003104:	0205d593          	srli	a1,a1,0x20
    80003108:	00bd85b3          	add	a1,s11,a1
    8000310c:	0005c583          	lbu	a1,0(a1)
    80003110:	02d7d7bb          	divuw	a5,a5,a3
    80003114:	f8b402a3          	sb	a1,-123(s0)
    80003118:	46ea7863          	bgeu	s4,a4,80003588 <__printf+0x650>
    8000311c:	02d7f5bb          	remuw	a1,a5,a3
    80003120:	02059593          	slli	a1,a1,0x20
    80003124:	0205d593          	srli	a1,a1,0x20
    80003128:	00bd85b3          	add	a1,s11,a1
    8000312c:	0005c583          	lbu	a1,0(a1)
    80003130:	02d7d7bb          	divuw	a5,a5,a3
    80003134:	f8b40323          	sb	a1,-122(s0)
    80003138:	3eeaf863          	bgeu	s5,a4,80003528 <__printf+0x5f0>
    8000313c:	02d7f5bb          	remuw	a1,a5,a3
    80003140:	02059593          	slli	a1,a1,0x20
    80003144:	0205d593          	srli	a1,a1,0x20
    80003148:	00bd85b3          	add	a1,s11,a1
    8000314c:	0005c583          	lbu	a1,0(a1)
    80003150:	02d7d7bb          	divuw	a5,a5,a3
    80003154:	f8b403a3          	sb	a1,-121(s0)
    80003158:	42eb7e63          	bgeu	s6,a4,80003594 <__printf+0x65c>
    8000315c:	02d7f5bb          	remuw	a1,a5,a3
    80003160:	02059593          	slli	a1,a1,0x20
    80003164:	0205d593          	srli	a1,a1,0x20
    80003168:	00bd85b3          	add	a1,s11,a1
    8000316c:	0005c583          	lbu	a1,0(a1)
    80003170:	02d7d7bb          	divuw	a5,a5,a3
    80003174:	f8b40423          	sb	a1,-120(s0)
    80003178:	42ebfc63          	bgeu	s7,a4,800035b0 <__printf+0x678>
    8000317c:	02079793          	slli	a5,a5,0x20
    80003180:	0207d793          	srli	a5,a5,0x20
    80003184:	00fd8db3          	add	s11,s11,a5
    80003188:	000dc703          	lbu	a4,0(s11)
    8000318c:	00a00793          	li	a5,10
    80003190:	00900c93          	li	s9,9
    80003194:	f8e404a3          	sb	a4,-119(s0)
    80003198:	00065c63          	bgez	a2,800031b0 <__printf+0x278>
    8000319c:	f9040713          	addi	a4,s0,-112
    800031a0:	00f70733          	add	a4,a4,a5
    800031a4:	02d00693          	li	a3,45
    800031a8:	fed70823          	sb	a3,-16(a4)
    800031ac:	00078c93          	mv	s9,a5
    800031b0:	f8040793          	addi	a5,s0,-128
    800031b4:	01978cb3          	add	s9,a5,s9
    800031b8:	f7f40d13          	addi	s10,s0,-129
    800031bc:	000cc503          	lbu	a0,0(s9)
    800031c0:	fffc8c93          	addi	s9,s9,-1
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	b90080e7          	jalr	-1136(ra) # 80002d54 <consputc>
    800031cc:	ffac98e3          	bne	s9,s10,800031bc <__printf+0x284>
    800031d0:	00094503          	lbu	a0,0(s2)
    800031d4:	e00514e3          	bnez	a0,80002fdc <__printf+0xa4>
    800031d8:	1a0c1663          	bnez	s8,80003384 <__printf+0x44c>
    800031dc:	08813083          	ld	ra,136(sp)
    800031e0:	08013403          	ld	s0,128(sp)
    800031e4:	07813483          	ld	s1,120(sp)
    800031e8:	07013903          	ld	s2,112(sp)
    800031ec:	06813983          	ld	s3,104(sp)
    800031f0:	06013a03          	ld	s4,96(sp)
    800031f4:	05813a83          	ld	s5,88(sp)
    800031f8:	05013b03          	ld	s6,80(sp)
    800031fc:	04813b83          	ld	s7,72(sp)
    80003200:	04013c03          	ld	s8,64(sp)
    80003204:	03813c83          	ld	s9,56(sp)
    80003208:	03013d03          	ld	s10,48(sp)
    8000320c:	02813d83          	ld	s11,40(sp)
    80003210:	0d010113          	addi	sp,sp,208
    80003214:	00008067          	ret
    80003218:	07300713          	li	a4,115
    8000321c:	1ce78a63          	beq	a5,a4,800033f0 <__printf+0x4b8>
    80003220:	07800713          	li	a4,120
    80003224:	1ee79e63          	bne	a5,a4,80003420 <__printf+0x4e8>
    80003228:	f7843783          	ld	a5,-136(s0)
    8000322c:	0007a703          	lw	a4,0(a5)
    80003230:	00878793          	addi	a5,a5,8
    80003234:	f6f43c23          	sd	a5,-136(s0)
    80003238:	28074263          	bltz	a4,800034bc <__printf+0x584>
    8000323c:	00002d97          	auipc	s11,0x2
    80003240:	1d4d8d93          	addi	s11,s11,468 # 80005410 <digits>
    80003244:	00f77793          	andi	a5,a4,15
    80003248:	00fd87b3          	add	a5,s11,a5
    8000324c:	0007c683          	lbu	a3,0(a5)
    80003250:	00f00613          	li	a2,15
    80003254:	0007079b          	sext.w	a5,a4
    80003258:	f8d40023          	sb	a3,-128(s0)
    8000325c:	0047559b          	srliw	a1,a4,0x4
    80003260:	0047569b          	srliw	a3,a4,0x4
    80003264:	00000c93          	li	s9,0
    80003268:	0ee65063          	bge	a2,a4,80003348 <__printf+0x410>
    8000326c:	00f6f693          	andi	a3,a3,15
    80003270:	00dd86b3          	add	a3,s11,a3
    80003274:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003278:	0087d79b          	srliw	a5,a5,0x8
    8000327c:	00100c93          	li	s9,1
    80003280:	f8d400a3          	sb	a3,-127(s0)
    80003284:	0cb67263          	bgeu	a2,a1,80003348 <__printf+0x410>
    80003288:	00f7f693          	andi	a3,a5,15
    8000328c:	00dd86b3          	add	a3,s11,a3
    80003290:	0006c583          	lbu	a1,0(a3)
    80003294:	00f00613          	li	a2,15
    80003298:	0047d69b          	srliw	a3,a5,0x4
    8000329c:	f8b40123          	sb	a1,-126(s0)
    800032a0:	0047d593          	srli	a1,a5,0x4
    800032a4:	28f67e63          	bgeu	a2,a5,80003540 <__printf+0x608>
    800032a8:	00f6f693          	andi	a3,a3,15
    800032ac:	00dd86b3          	add	a3,s11,a3
    800032b0:	0006c503          	lbu	a0,0(a3)
    800032b4:	0087d813          	srli	a6,a5,0x8
    800032b8:	0087d69b          	srliw	a3,a5,0x8
    800032bc:	f8a401a3          	sb	a0,-125(s0)
    800032c0:	28b67663          	bgeu	a2,a1,8000354c <__printf+0x614>
    800032c4:	00f6f693          	andi	a3,a3,15
    800032c8:	00dd86b3          	add	a3,s11,a3
    800032cc:	0006c583          	lbu	a1,0(a3)
    800032d0:	00c7d513          	srli	a0,a5,0xc
    800032d4:	00c7d69b          	srliw	a3,a5,0xc
    800032d8:	f8b40223          	sb	a1,-124(s0)
    800032dc:	29067a63          	bgeu	a2,a6,80003570 <__printf+0x638>
    800032e0:	00f6f693          	andi	a3,a3,15
    800032e4:	00dd86b3          	add	a3,s11,a3
    800032e8:	0006c583          	lbu	a1,0(a3)
    800032ec:	0107d813          	srli	a6,a5,0x10
    800032f0:	0107d69b          	srliw	a3,a5,0x10
    800032f4:	f8b402a3          	sb	a1,-123(s0)
    800032f8:	28a67263          	bgeu	a2,a0,8000357c <__printf+0x644>
    800032fc:	00f6f693          	andi	a3,a3,15
    80003300:	00dd86b3          	add	a3,s11,a3
    80003304:	0006c683          	lbu	a3,0(a3)
    80003308:	0147d79b          	srliw	a5,a5,0x14
    8000330c:	f8d40323          	sb	a3,-122(s0)
    80003310:	21067663          	bgeu	a2,a6,8000351c <__printf+0x5e4>
    80003314:	02079793          	slli	a5,a5,0x20
    80003318:	0207d793          	srli	a5,a5,0x20
    8000331c:	00fd8db3          	add	s11,s11,a5
    80003320:	000dc683          	lbu	a3,0(s11)
    80003324:	00800793          	li	a5,8
    80003328:	00700c93          	li	s9,7
    8000332c:	f8d403a3          	sb	a3,-121(s0)
    80003330:	00075c63          	bgez	a4,80003348 <__printf+0x410>
    80003334:	f9040713          	addi	a4,s0,-112
    80003338:	00f70733          	add	a4,a4,a5
    8000333c:	02d00693          	li	a3,45
    80003340:	fed70823          	sb	a3,-16(a4)
    80003344:	00078c93          	mv	s9,a5
    80003348:	f8040793          	addi	a5,s0,-128
    8000334c:	01978cb3          	add	s9,a5,s9
    80003350:	f7f40d13          	addi	s10,s0,-129
    80003354:	000cc503          	lbu	a0,0(s9)
    80003358:	fffc8c93          	addi	s9,s9,-1
    8000335c:	00000097          	auipc	ra,0x0
    80003360:	9f8080e7          	jalr	-1544(ra) # 80002d54 <consputc>
    80003364:	ff9d18e3          	bne	s10,s9,80003354 <__printf+0x41c>
    80003368:	0100006f          	j	80003378 <__printf+0x440>
    8000336c:	00000097          	auipc	ra,0x0
    80003370:	9e8080e7          	jalr	-1560(ra) # 80002d54 <consputc>
    80003374:	000c8493          	mv	s1,s9
    80003378:	00094503          	lbu	a0,0(s2)
    8000337c:	c60510e3          	bnez	a0,80002fdc <__printf+0xa4>
    80003380:	e40c0ee3          	beqz	s8,800031dc <__printf+0x2a4>
    80003384:	00004517          	auipc	a0,0x4
    80003388:	b0c50513          	addi	a0,a0,-1268 # 80006e90 <pr>
    8000338c:	00001097          	auipc	ra,0x1
    80003390:	94c080e7          	jalr	-1716(ra) # 80003cd8 <release>
    80003394:	e49ff06f          	j	800031dc <__printf+0x2a4>
    80003398:	f7843783          	ld	a5,-136(s0)
    8000339c:	03000513          	li	a0,48
    800033a0:	01000d13          	li	s10,16
    800033a4:	00878713          	addi	a4,a5,8
    800033a8:	0007bc83          	ld	s9,0(a5)
    800033ac:	f6e43c23          	sd	a4,-136(s0)
    800033b0:	00000097          	auipc	ra,0x0
    800033b4:	9a4080e7          	jalr	-1628(ra) # 80002d54 <consputc>
    800033b8:	07800513          	li	a0,120
    800033bc:	00000097          	auipc	ra,0x0
    800033c0:	998080e7          	jalr	-1640(ra) # 80002d54 <consputc>
    800033c4:	00002d97          	auipc	s11,0x2
    800033c8:	04cd8d93          	addi	s11,s11,76 # 80005410 <digits>
    800033cc:	03ccd793          	srli	a5,s9,0x3c
    800033d0:	00fd87b3          	add	a5,s11,a5
    800033d4:	0007c503          	lbu	a0,0(a5)
    800033d8:	fffd0d1b          	addiw	s10,s10,-1
    800033dc:	004c9c93          	slli	s9,s9,0x4
    800033e0:	00000097          	auipc	ra,0x0
    800033e4:	974080e7          	jalr	-1676(ra) # 80002d54 <consputc>
    800033e8:	fe0d12e3          	bnez	s10,800033cc <__printf+0x494>
    800033ec:	f8dff06f          	j	80003378 <__printf+0x440>
    800033f0:	f7843783          	ld	a5,-136(s0)
    800033f4:	0007bc83          	ld	s9,0(a5)
    800033f8:	00878793          	addi	a5,a5,8
    800033fc:	f6f43c23          	sd	a5,-136(s0)
    80003400:	000c9a63          	bnez	s9,80003414 <__printf+0x4dc>
    80003404:	1080006f          	j	8000350c <__printf+0x5d4>
    80003408:	001c8c93          	addi	s9,s9,1
    8000340c:	00000097          	auipc	ra,0x0
    80003410:	948080e7          	jalr	-1720(ra) # 80002d54 <consputc>
    80003414:	000cc503          	lbu	a0,0(s9)
    80003418:	fe0518e3          	bnez	a0,80003408 <__printf+0x4d0>
    8000341c:	f5dff06f          	j	80003378 <__printf+0x440>
    80003420:	02500513          	li	a0,37
    80003424:	00000097          	auipc	ra,0x0
    80003428:	930080e7          	jalr	-1744(ra) # 80002d54 <consputc>
    8000342c:	000c8513          	mv	a0,s9
    80003430:	00000097          	auipc	ra,0x0
    80003434:	924080e7          	jalr	-1756(ra) # 80002d54 <consputc>
    80003438:	f41ff06f          	j	80003378 <__printf+0x440>
    8000343c:	02500513          	li	a0,37
    80003440:	00000097          	auipc	ra,0x0
    80003444:	914080e7          	jalr	-1772(ra) # 80002d54 <consputc>
    80003448:	f31ff06f          	j	80003378 <__printf+0x440>
    8000344c:	00030513          	mv	a0,t1
    80003450:	00000097          	auipc	ra,0x0
    80003454:	7bc080e7          	jalr	1980(ra) # 80003c0c <acquire>
    80003458:	b4dff06f          	j	80002fa4 <__printf+0x6c>
    8000345c:	40c0053b          	negw	a0,a2
    80003460:	00a00713          	li	a4,10
    80003464:	02e576bb          	remuw	a3,a0,a4
    80003468:	00002d97          	auipc	s11,0x2
    8000346c:	fa8d8d93          	addi	s11,s11,-88 # 80005410 <digits>
    80003470:	ff700593          	li	a1,-9
    80003474:	02069693          	slli	a3,a3,0x20
    80003478:	0206d693          	srli	a3,a3,0x20
    8000347c:	00dd86b3          	add	a3,s11,a3
    80003480:	0006c683          	lbu	a3,0(a3)
    80003484:	02e557bb          	divuw	a5,a0,a4
    80003488:	f8d40023          	sb	a3,-128(s0)
    8000348c:	10b65e63          	bge	a2,a1,800035a8 <__printf+0x670>
    80003490:	06300593          	li	a1,99
    80003494:	02e7f6bb          	remuw	a3,a5,a4
    80003498:	02069693          	slli	a3,a3,0x20
    8000349c:	0206d693          	srli	a3,a3,0x20
    800034a0:	00dd86b3          	add	a3,s11,a3
    800034a4:	0006c683          	lbu	a3,0(a3)
    800034a8:	02e7d73b          	divuw	a4,a5,a4
    800034ac:	00200793          	li	a5,2
    800034b0:	f8d400a3          	sb	a3,-127(s0)
    800034b4:	bca5ece3          	bltu	a1,a0,8000308c <__printf+0x154>
    800034b8:	ce5ff06f          	j	8000319c <__printf+0x264>
    800034bc:	40e007bb          	negw	a5,a4
    800034c0:	00002d97          	auipc	s11,0x2
    800034c4:	f50d8d93          	addi	s11,s11,-176 # 80005410 <digits>
    800034c8:	00f7f693          	andi	a3,a5,15
    800034cc:	00dd86b3          	add	a3,s11,a3
    800034d0:	0006c583          	lbu	a1,0(a3)
    800034d4:	ff100613          	li	a2,-15
    800034d8:	0047d69b          	srliw	a3,a5,0x4
    800034dc:	f8b40023          	sb	a1,-128(s0)
    800034e0:	0047d59b          	srliw	a1,a5,0x4
    800034e4:	0ac75e63          	bge	a4,a2,800035a0 <__printf+0x668>
    800034e8:	00f6f693          	andi	a3,a3,15
    800034ec:	00dd86b3          	add	a3,s11,a3
    800034f0:	0006c603          	lbu	a2,0(a3)
    800034f4:	00f00693          	li	a3,15
    800034f8:	0087d79b          	srliw	a5,a5,0x8
    800034fc:	f8c400a3          	sb	a2,-127(s0)
    80003500:	d8b6e4e3          	bltu	a3,a1,80003288 <__printf+0x350>
    80003504:	00200793          	li	a5,2
    80003508:	e2dff06f          	j	80003334 <__printf+0x3fc>
    8000350c:	00002c97          	auipc	s9,0x2
    80003510:	ee4c8c93          	addi	s9,s9,-284 # 800053f0 <kvmincrease+0xd50>
    80003514:	02800513          	li	a0,40
    80003518:	ef1ff06f          	j	80003408 <__printf+0x4d0>
    8000351c:	00700793          	li	a5,7
    80003520:	00600c93          	li	s9,6
    80003524:	e0dff06f          	j	80003330 <__printf+0x3f8>
    80003528:	00700793          	li	a5,7
    8000352c:	00600c93          	li	s9,6
    80003530:	c69ff06f          	j	80003198 <__printf+0x260>
    80003534:	00300793          	li	a5,3
    80003538:	00200c93          	li	s9,2
    8000353c:	c5dff06f          	j	80003198 <__printf+0x260>
    80003540:	00300793          	li	a5,3
    80003544:	00200c93          	li	s9,2
    80003548:	de9ff06f          	j	80003330 <__printf+0x3f8>
    8000354c:	00400793          	li	a5,4
    80003550:	00300c93          	li	s9,3
    80003554:	dddff06f          	j	80003330 <__printf+0x3f8>
    80003558:	00400793          	li	a5,4
    8000355c:	00300c93          	li	s9,3
    80003560:	c39ff06f          	j	80003198 <__printf+0x260>
    80003564:	00500793          	li	a5,5
    80003568:	00400c93          	li	s9,4
    8000356c:	c2dff06f          	j	80003198 <__printf+0x260>
    80003570:	00500793          	li	a5,5
    80003574:	00400c93          	li	s9,4
    80003578:	db9ff06f          	j	80003330 <__printf+0x3f8>
    8000357c:	00600793          	li	a5,6
    80003580:	00500c93          	li	s9,5
    80003584:	dadff06f          	j	80003330 <__printf+0x3f8>
    80003588:	00600793          	li	a5,6
    8000358c:	00500c93          	li	s9,5
    80003590:	c09ff06f          	j	80003198 <__printf+0x260>
    80003594:	00800793          	li	a5,8
    80003598:	00700c93          	li	s9,7
    8000359c:	bfdff06f          	j	80003198 <__printf+0x260>
    800035a0:	00100793          	li	a5,1
    800035a4:	d91ff06f          	j	80003334 <__printf+0x3fc>
    800035a8:	00100793          	li	a5,1
    800035ac:	bf1ff06f          	j	8000319c <__printf+0x264>
    800035b0:	00900793          	li	a5,9
    800035b4:	00800c93          	li	s9,8
    800035b8:	be1ff06f          	j	80003198 <__printf+0x260>
    800035bc:	00002517          	auipc	a0,0x2
    800035c0:	e3c50513          	addi	a0,a0,-452 # 800053f8 <kvmincrease+0xd58>
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	918080e7          	jalr	-1768(ra) # 80002edc <panic>

00000000800035cc <printfinit>:
    800035cc:	fe010113          	addi	sp,sp,-32
    800035d0:	00813823          	sd	s0,16(sp)
    800035d4:	00913423          	sd	s1,8(sp)
    800035d8:	00113c23          	sd	ra,24(sp)
    800035dc:	02010413          	addi	s0,sp,32
    800035e0:	00004497          	auipc	s1,0x4
    800035e4:	8b048493          	addi	s1,s1,-1872 # 80006e90 <pr>
    800035e8:	00048513          	mv	a0,s1
    800035ec:	00002597          	auipc	a1,0x2
    800035f0:	e1c58593          	addi	a1,a1,-484 # 80005408 <kvmincrease+0xd68>
    800035f4:	00000097          	auipc	ra,0x0
    800035f8:	5f4080e7          	jalr	1524(ra) # 80003be8 <initlock>
    800035fc:	01813083          	ld	ra,24(sp)
    80003600:	01013403          	ld	s0,16(sp)
    80003604:	0004ac23          	sw	zero,24(s1)
    80003608:	00813483          	ld	s1,8(sp)
    8000360c:	02010113          	addi	sp,sp,32
    80003610:	00008067          	ret

0000000080003614 <uartinit>:
    80003614:	ff010113          	addi	sp,sp,-16
    80003618:	00813423          	sd	s0,8(sp)
    8000361c:	01010413          	addi	s0,sp,16
    80003620:	100007b7          	lui	a5,0x10000
    80003624:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003628:	f8000713          	li	a4,-128
    8000362c:	00e781a3          	sb	a4,3(a5)
    80003630:	00300713          	li	a4,3
    80003634:	00e78023          	sb	a4,0(a5)
    80003638:	000780a3          	sb	zero,1(a5)
    8000363c:	00e781a3          	sb	a4,3(a5)
    80003640:	00700693          	li	a3,7
    80003644:	00d78123          	sb	a3,2(a5)
    80003648:	00e780a3          	sb	a4,1(a5)
    8000364c:	00813403          	ld	s0,8(sp)
    80003650:	01010113          	addi	sp,sp,16
    80003654:	00008067          	ret

0000000080003658 <uartputc>:
    80003658:	00002797          	auipc	a5,0x2
    8000365c:	5c07a783          	lw	a5,1472(a5) # 80005c18 <panicked>
    80003660:	00078463          	beqz	a5,80003668 <uartputc+0x10>
    80003664:	0000006f          	j	80003664 <uartputc+0xc>
    80003668:	fd010113          	addi	sp,sp,-48
    8000366c:	02813023          	sd	s0,32(sp)
    80003670:	00913c23          	sd	s1,24(sp)
    80003674:	01213823          	sd	s2,16(sp)
    80003678:	01313423          	sd	s3,8(sp)
    8000367c:	02113423          	sd	ra,40(sp)
    80003680:	03010413          	addi	s0,sp,48
    80003684:	00002917          	auipc	s2,0x2
    80003688:	59c90913          	addi	s2,s2,1436 # 80005c20 <uart_tx_r>
    8000368c:	00093783          	ld	a5,0(s2)
    80003690:	00002497          	auipc	s1,0x2
    80003694:	59848493          	addi	s1,s1,1432 # 80005c28 <uart_tx_w>
    80003698:	0004b703          	ld	a4,0(s1)
    8000369c:	02078693          	addi	a3,a5,32
    800036a0:	00050993          	mv	s3,a0
    800036a4:	02e69c63          	bne	a3,a4,800036dc <uartputc+0x84>
    800036a8:	00001097          	auipc	ra,0x1
    800036ac:	834080e7          	jalr	-1996(ra) # 80003edc <push_on>
    800036b0:	00093783          	ld	a5,0(s2)
    800036b4:	0004b703          	ld	a4,0(s1)
    800036b8:	02078793          	addi	a5,a5,32
    800036bc:	00e79463          	bne	a5,a4,800036c4 <uartputc+0x6c>
    800036c0:	0000006f          	j	800036c0 <uartputc+0x68>
    800036c4:	00001097          	auipc	ra,0x1
    800036c8:	88c080e7          	jalr	-1908(ra) # 80003f50 <pop_on>
    800036cc:	00093783          	ld	a5,0(s2)
    800036d0:	0004b703          	ld	a4,0(s1)
    800036d4:	02078693          	addi	a3,a5,32
    800036d8:	fce688e3          	beq	a3,a4,800036a8 <uartputc+0x50>
    800036dc:	01f77693          	andi	a3,a4,31
    800036e0:	00003597          	auipc	a1,0x3
    800036e4:	7d058593          	addi	a1,a1,2000 # 80006eb0 <uart_tx_buf>
    800036e8:	00d586b3          	add	a3,a1,a3
    800036ec:	00170713          	addi	a4,a4,1
    800036f0:	01368023          	sb	s3,0(a3)
    800036f4:	00e4b023          	sd	a4,0(s1)
    800036f8:	10000637          	lui	a2,0x10000
    800036fc:	02f71063          	bne	a4,a5,8000371c <uartputc+0xc4>
    80003700:	0340006f          	j	80003734 <uartputc+0xdc>
    80003704:	00074703          	lbu	a4,0(a4)
    80003708:	00f93023          	sd	a5,0(s2)
    8000370c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003710:	00093783          	ld	a5,0(s2)
    80003714:	0004b703          	ld	a4,0(s1)
    80003718:	00f70e63          	beq	a4,a5,80003734 <uartputc+0xdc>
    8000371c:	00564683          	lbu	a3,5(a2)
    80003720:	01f7f713          	andi	a4,a5,31
    80003724:	00e58733          	add	a4,a1,a4
    80003728:	0206f693          	andi	a3,a3,32
    8000372c:	00178793          	addi	a5,a5,1
    80003730:	fc069ae3          	bnez	a3,80003704 <uartputc+0xac>
    80003734:	02813083          	ld	ra,40(sp)
    80003738:	02013403          	ld	s0,32(sp)
    8000373c:	01813483          	ld	s1,24(sp)
    80003740:	01013903          	ld	s2,16(sp)
    80003744:	00813983          	ld	s3,8(sp)
    80003748:	03010113          	addi	sp,sp,48
    8000374c:	00008067          	ret

0000000080003750 <uartputc_sync>:
    80003750:	ff010113          	addi	sp,sp,-16
    80003754:	00813423          	sd	s0,8(sp)
    80003758:	01010413          	addi	s0,sp,16
    8000375c:	00002717          	auipc	a4,0x2
    80003760:	4bc72703          	lw	a4,1212(a4) # 80005c18 <panicked>
    80003764:	02071663          	bnez	a4,80003790 <uartputc_sync+0x40>
    80003768:	00050793          	mv	a5,a0
    8000376c:	100006b7          	lui	a3,0x10000
    80003770:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003774:	02077713          	andi	a4,a4,32
    80003778:	fe070ce3          	beqz	a4,80003770 <uartputc_sync+0x20>
    8000377c:	0ff7f793          	andi	a5,a5,255
    80003780:	00f68023          	sb	a5,0(a3)
    80003784:	00813403          	ld	s0,8(sp)
    80003788:	01010113          	addi	sp,sp,16
    8000378c:	00008067          	ret
    80003790:	0000006f          	j	80003790 <uartputc_sync+0x40>

0000000080003794 <uartstart>:
    80003794:	ff010113          	addi	sp,sp,-16
    80003798:	00813423          	sd	s0,8(sp)
    8000379c:	01010413          	addi	s0,sp,16
    800037a0:	00002617          	auipc	a2,0x2
    800037a4:	48060613          	addi	a2,a2,1152 # 80005c20 <uart_tx_r>
    800037a8:	00002517          	auipc	a0,0x2
    800037ac:	48050513          	addi	a0,a0,1152 # 80005c28 <uart_tx_w>
    800037b0:	00063783          	ld	a5,0(a2)
    800037b4:	00053703          	ld	a4,0(a0)
    800037b8:	04f70263          	beq	a4,a5,800037fc <uartstart+0x68>
    800037bc:	100005b7          	lui	a1,0x10000
    800037c0:	00003817          	auipc	a6,0x3
    800037c4:	6f080813          	addi	a6,a6,1776 # 80006eb0 <uart_tx_buf>
    800037c8:	01c0006f          	j	800037e4 <uartstart+0x50>
    800037cc:	0006c703          	lbu	a4,0(a3)
    800037d0:	00f63023          	sd	a5,0(a2)
    800037d4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800037d8:	00063783          	ld	a5,0(a2)
    800037dc:	00053703          	ld	a4,0(a0)
    800037e0:	00f70e63          	beq	a4,a5,800037fc <uartstart+0x68>
    800037e4:	01f7f713          	andi	a4,a5,31
    800037e8:	00e806b3          	add	a3,a6,a4
    800037ec:	0055c703          	lbu	a4,5(a1)
    800037f0:	00178793          	addi	a5,a5,1
    800037f4:	02077713          	andi	a4,a4,32
    800037f8:	fc071ae3          	bnez	a4,800037cc <uartstart+0x38>
    800037fc:	00813403          	ld	s0,8(sp)
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret

0000000080003808 <uartgetc>:
    80003808:	ff010113          	addi	sp,sp,-16
    8000380c:	00813423          	sd	s0,8(sp)
    80003810:	01010413          	addi	s0,sp,16
    80003814:	10000737          	lui	a4,0x10000
    80003818:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000381c:	0017f793          	andi	a5,a5,1
    80003820:	00078c63          	beqz	a5,80003838 <uartgetc+0x30>
    80003824:	00074503          	lbu	a0,0(a4)
    80003828:	0ff57513          	andi	a0,a0,255
    8000382c:	00813403          	ld	s0,8(sp)
    80003830:	01010113          	addi	sp,sp,16
    80003834:	00008067          	ret
    80003838:	fff00513          	li	a0,-1
    8000383c:	ff1ff06f          	j	8000382c <uartgetc+0x24>

0000000080003840 <uartintr>:
    80003840:	100007b7          	lui	a5,0x10000
    80003844:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003848:	0017f793          	andi	a5,a5,1
    8000384c:	0a078463          	beqz	a5,800038f4 <uartintr+0xb4>
    80003850:	fe010113          	addi	sp,sp,-32
    80003854:	00813823          	sd	s0,16(sp)
    80003858:	00913423          	sd	s1,8(sp)
    8000385c:	00113c23          	sd	ra,24(sp)
    80003860:	02010413          	addi	s0,sp,32
    80003864:	100004b7          	lui	s1,0x10000
    80003868:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000386c:	0ff57513          	andi	a0,a0,255
    80003870:	fffff097          	auipc	ra,0xfffff
    80003874:	534080e7          	jalr	1332(ra) # 80002da4 <consoleintr>
    80003878:	0054c783          	lbu	a5,5(s1)
    8000387c:	0017f793          	andi	a5,a5,1
    80003880:	fe0794e3          	bnez	a5,80003868 <uartintr+0x28>
    80003884:	00002617          	auipc	a2,0x2
    80003888:	39c60613          	addi	a2,a2,924 # 80005c20 <uart_tx_r>
    8000388c:	00002517          	auipc	a0,0x2
    80003890:	39c50513          	addi	a0,a0,924 # 80005c28 <uart_tx_w>
    80003894:	00063783          	ld	a5,0(a2)
    80003898:	00053703          	ld	a4,0(a0)
    8000389c:	04f70263          	beq	a4,a5,800038e0 <uartintr+0xa0>
    800038a0:	100005b7          	lui	a1,0x10000
    800038a4:	00003817          	auipc	a6,0x3
    800038a8:	60c80813          	addi	a6,a6,1548 # 80006eb0 <uart_tx_buf>
    800038ac:	01c0006f          	j	800038c8 <uartintr+0x88>
    800038b0:	0006c703          	lbu	a4,0(a3)
    800038b4:	00f63023          	sd	a5,0(a2)
    800038b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800038bc:	00063783          	ld	a5,0(a2)
    800038c0:	00053703          	ld	a4,0(a0)
    800038c4:	00f70e63          	beq	a4,a5,800038e0 <uartintr+0xa0>
    800038c8:	01f7f713          	andi	a4,a5,31
    800038cc:	00e806b3          	add	a3,a6,a4
    800038d0:	0055c703          	lbu	a4,5(a1)
    800038d4:	00178793          	addi	a5,a5,1
    800038d8:	02077713          	andi	a4,a4,32
    800038dc:	fc071ae3          	bnez	a4,800038b0 <uartintr+0x70>
    800038e0:	01813083          	ld	ra,24(sp)
    800038e4:	01013403          	ld	s0,16(sp)
    800038e8:	00813483          	ld	s1,8(sp)
    800038ec:	02010113          	addi	sp,sp,32
    800038f0:	00008067          	ret
    800038f4:	00002617          	auipc	a2,0x2
    800038f8:	32c60613          	addi	a2,a2,812 # 80005c20 <uart_tx_r>
    800038fc:	00002517          	auipc	a0,0x2
    80003900:	32c50513          	addi	a0,a0,812 # 80005c28 <uart_tx_w>
    80003904:	00063783          	ld	a5,0(a2)
    80003908:	00053703          	ld	a4,0(a0)
    8000390c:	04f70263          	beq	a4,a5,80003950 <uartintr+0x110>
    80003910:	100005b7          	lui	a1,0x10000
    80003914:	00003817          	auipc	a6,0x3
    80003918:	59c80813          	addi	a6,a6,1436 # 80006eb0 <uart_tx_buf>
    8000391c:	01c0006f          	j	80003938 <uartintr+0xf8>
    80003920:	0006c703          	lbu	a4,0(a3)
    80003924:	00f63023          	sd	a5,0(a2)
    80003928:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000392c:	00063783          	ld	a5,0(a2)
    80003930:	00053703          	ld	a4,0(a0)
    80003934:	02f70063          	beq	a4,a5,80003954 <uartintr+0x114>
    80003938:	01f7f713          	andi	a4,a5,31
    8000393c:	00e806b3          	add	a3,a6,a4
    80003940:	0055c703          	lbu	a4,5(a1)
    80003944:	00178793          	addi	a5,a5,1
    80003948:	02077713          	andi	a4,a4,32
    8000394c:	fc071ae3          	bnez	a4,80003920 <uartintr+0xe0>
    80003950:	00008067          	ret
    80003954:	00008067          	ret

0000000080003958 <kinit>:
    80003958:	fc010113          	addi	sp,sp,-64
    8000395c:	02913423          	sd	s1,40(sp)
    80003960:	fffff7b7          	lui	a5,0xfffff
    80003964:	00004497          	auipc	s1,0x4
    80003968:	57b48493          	addi	s1,s1,1403 # 80007edf <end+0xfff>
    8000396c:	02813823          	sd	s0,48(sp)
    80003970:	01313c23          	sd	s3,24(sp)
    80003974:	00f4f4b3          	and	s1,s1,a5
    80003978:	02113c23          	sd	ra,56(sp)
    8000397c:	03213023          	sd	s2,32(sp)
    80003980:	01413823          	sd	s4,16(sp)
    80003984:	01513423          	sd	s5,8(sp)
    80003988:	04010413          	addi	s0,sp,64
    8000398c:	000017b7          	lui	a5,0x1
    80003990:	01100993          	li	s3,17
    80003994:	00f487b3          	add	a5,s1,a5
    80003998:	01b99993          	slli	s3,s3,0x1b
    8000399c:	06f9e063          	bltu	s3,a5,800039fc <kinit+0xa4>
    800039a0:	00003a97          	auipc	s5,0x3
    800039a4:	540a8a93          	addi	s5,s5,1344 # 80006ee0 <end>
    800039a8:	0754ec63          	bltu	s1,s5,80003a20 <kinit+0xc8>
    800039ac:	0734fa63          	bgeu	s1,s3,80003a20 <kinit+0xc8>
    800039b0:	00088a37          	lui	s4,0x88
    800039b4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800039b8:	00002917          	auipc	s2,0x2
    800039bc:	27890913          	addi	s2,s2,632 # 80005c30 <kmem>
    800039c0:	00ca1a13          	slli	s4,s4,0xc
    800039c4:	0140006f          	j	800039d8 <kinit+0x80>
    800039c8:	000017b7          	lui	a5,0x1
    800039cc:	00f484b3          	add	s1,s1,a5
    800039d0:	0554e863          	bltu	s1,s5,80003a20 <kinit+0xc8>
    800039d4:	0534f663          	bgeu	s1,s3,80003a20 <kinit+0xc8>
    800039d8:	00001637          	lui	a2,0x1
    800039dc:	00100593          	li	a1,1
    800039e0:	00048513          	mv	a0,s1
    800039e4:	00000097          	auipc	ra,0x0
    800039e8:	5e4080e7          	jalr	1508(ra) # 80003fc8 <__memset>
    800039ec:	00093783          	ld	a5,0(s2)
    800039f0:	00f4b023          	sd	a5,0(s1)
    800039f4:	00993023          	sd	s1,0(s2)
    800039f8:	fd4498e3          	bne	s1,s4,800039c8 <kinit+0x70>
    800039fc:	03813083          	ld	ra,56(sp)
    80003a00:	03013403          	ld	s0,48(sp)
    80003a04:	02813483          	ld	s1,40(sp)
    80003a08:	02013903          	ld	s2,32(sp)
    80003a0c:	01813983          	ld	s3,24(sp)
    80003a10:	01013a03          	ld	s4,16(sp)
    80003a14:	00813a83          	ld	s5,8(sp)
    80003a18:	04010113          	addi	sp,sp,64
    80003a1c:	00008067          	ret
    80003a20:	00002517          	auipc	a0,0x2
    80003a24:	a0850513          	addi	a0,a0,-1528 # 80005428 <digits+0x18>
    80003a28:	fffff097          	auipc	ra,0xfffff
    80003a2c:	4b4080e7          	jalr	1204(ra) # 80002edc <panic>

0000000080003a30 <freerange>:
    80003a30:	fc010113          	addi	sp,sp,-64
    80003a34:	000017b7          	lui	a5,0x1
    80003a38:	02913423          	sd	s1,40(sp)
    80003a3c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003a40:	009504b3          	add	s1,a0,s1
    80003a44:	fffff537          	lui	a0,0xfffff
    80003a48:	02813823          	sd	s0,48(sp)
    80003a4c:	02113c23          	sd	ra,56(sp)
    80003a50:	03213023          	sd	s2,32(sp)
    80003a54:	01313c23          	sd	s3,24(sp)
    80003a58:	01413823          	sd	s4,16(sp)
    80003a5c:	01513423          	sd	s5,8(sp)
    80003a60:	01613023          	sd	s6,0(sp)
    80003a64:	04010413          	addi	s0,sp,64
    80003a68:	00a4f4b3          	and	s1,s1,a0
    80003a6c:	00f487b3          	add	a5,s1,a5
    80003a70:	06f5e463          	bltu	a1,a5,80003ad8 <freerange+0xa8>
    80003a74:	00003a97          	auipc	s5,0x3
    80003a78:	46ca8a93          	addi	s5,s5,1132 # 80006ee0 <end>
    80003a7c:	0954e263          	bltu	s1,s5,80003b00 <freerange+0xd0>
    80003a80:	01100993          	li	s3,17
    80003a84:	01b99993          	slli	s3,s3,0x1b
    80003a88:	0734fc63          	bgeu	s1,s3,80003b00 <freerange+0xd0>
    80003a8c:	00058a13          	mv	s4,a1
    80003a90:	00002917          	auipc	s2,0x2
    80003a94:	1a090913          	addi	s2,s2,416 # 80005c30 <kmem>
    80003a98:	00002b37          	lui	s6,0x2
    80003a9c:	0140006f          	j	80003ab0 <freerange+0x80>
    80003aa0:	000017b7          	lui	a5,0x1
    80003aa4:	00f484b3          	add	s1,s1,a5
    80003aa8:	0554ec63          	bltu	s1,s5,80003b00 <freerange+0xd0>
    80003aac:	0534fa63          	bgeu	s1,s3,80003b00 <freerange+0xd0>
    80003ab0:	00001637          	lui	a2,0x1
    80003ab4:	00100593          	li	a1,1
    80003ab8:	00048513          	mv	a0,s1
    80003abc:	00000097          	auipc	ra,0x0
    80003ac0:	50c080e7          	jalr	1292(ra) # 80003fc8 <__memset>
    80003ac4:	00093703          	ld	a4,0(s2)
    80003ac8:	016487b3          	add	a5,s1,s6
    80003acc:	00e4b023          	sd	a4,0(s1)
    80003ad0:	00993023          	sd	s1,0(s2)
    80003ad4:	fcfa76e3          	bgeu	s4,a5,80003aa0 <freerange+0x70>
    80003ad8:	03813083          	ld	ra,56(sp)
    80003adc:	03013403          	ld	s0,48(sp)
    80003ae0:	02813483          	ld	s1,40(sp)
    80003ae4:	02013903          	ld	s2,32(sp)
    80003ae8:	01813983          	ld	s3,24(sp)
    80003aec:	01013a03          	ld	s4,16(sp)
    80003af0:	00813a83          	ld	s5,8(sp)
    80003af4:	00013b03          	ld	s6,0(sp)
    80003af8:	04010113          	addi	sp,sp,64
    80003afc:	00008067          	ret
    80003b00:	00002517          	auipc	a0,0x2
    80003b04:	92850513          	addi	a0,a0,-1752 # 80005428 <digits+0x18>
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	3d4080e7          	jalr	980(ra) # 80002edc <panic>

0000000080003b10 <kfree>:
    80003b10:	fe010113          	addi	sp,sp,-32
    80003b14:	00813823          	sd	s0,16(sp)
    80003b18:	00113c23          	sd	ra,24(sp)
    80003b1c:	00913423          	sd	s1,8(sp)
    80003b20:	02010413          	addi	s0,sp,32
    80003b24:	03451793          	slli	a5,a0,0x34
    80003b28:	04079c63          	bnez	a5,80003b80 <kfree+0x70>
    80003b2c:	00003797          	auipc	a5,0x3
    80003b30:	3b478793          	addi	a5,a5,948 # 80006ee0 <end>
    80003b34:	00050493          	mv	s1,a0
    80003b38:	04f56463          	bltu	a0,a5,80003b80 <kfree+0x70>
    80003b3c:	01100793          	li	a5,17
    80003b40:	01b79793          	slli	a5,a5,0x1b
    80003b44:	02f57e63          	bgeu	a0,a5,80003b80 <kfree+0x70>
    80003b48:	00001637          	lui	a2,0x1
    80003b4c:	00100593          	li	a1,1
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	478080e7          	jalr	1144(ra) # 80003fc8 <__memset>
    80003b58:	00002797          	auipc	a5,0x2
    80003b5c:	0d878793          	addi	a5,a5,216 # 80005c30 <kmem>
    80003b60:	0007b703          	ld	a4,0(a5)
    80003b64:	01813083          	ld	ra,24(sp)
    80003b68:	01013403          	ld	s0,16(sp)
    80003b6c:	00e4b023          	sd	a4,0(s1)
    80003b70:	0097b023          	sd	s1,0(a5)
    80003b74:	00813483          	ld	s1,8(sp)
    80003b78:	02010113          	addi	sp,sp,32
    80003b7c:	00008067          	ret
    80003b80:	00002517          	auipc	a0,0x2
    80003b84:	8a850513          	addi	a0,a0,-1880 # 80005428 <digits+0x18>
    80003b88:	fffff097          	auipc	ra,0xfffff
    80003b8c:	354080e7          	jalr	852(ra) # 80002edc <panic>

0000000080003b90 <kalloc>:
    80003b90:	fe010113          	addi	sp,sp,-32
    80003b94:	00813823          	sd	s0,16(sp)
    80003b98:	00913423          	sd	s1,8(sp)
    80003b9c:	00113c23          	sd	ra,24(sp)
    80003ba0:	02010413          	addi	s0,sp,32
    80003ba4:	00002797          	auipc	a5,0x2
    80003ba8:	08c78793          	addi	a5,a5,140 # 80005c30 <kmem>
    80003bac:	0007b483          	ld	s1,0(a5)
    80003bb0:	02048063          	beqz	s1,80003bd0 <kalloc+0x40>
    80003bb4:	0004b703          	ld	a4,0(s1)
    80003bb8:	00001637          	lui	a2,0x1
    80003bbc:	00500593          	li	a1,5
    80003bc0:	00048513          	mv	a0,s1
    80003bc4:	00e7b023          	sd	a4,0(a5)
    80003bc8:	00000097          	auipc	ra,0x0
    80003bcc:	400080e7          	jalr	1024(ra) # 80003fc8 <__memset>
    80003bd0:	01813083          	ld	ra,24(sp)
    80003bd4:	01013403          	ld	s0,16(sp)
    80003bd8:	00048513          	mv	a0,s1
    80003bdc:	00813483          	ld	s1,8(sp)
    80003be0:	02010113          	addi	sp,sp,32
    80003be4:	00008067          	ret

0000000080003be8 <initlock>:
    80003be8:	ff010113          	addi	sp,sp,-16
    80003bec:	00813423          	sd	s0,8(sp)
    80003bf0:	01010413          	addi	s0,sp,16
    80003bf4:	00813403          	ld	s0,8(sp)
    80003bf8:	00b53423          	sd	a1,8(a0)
    80003bfc:	00052023          	sw	zero,0(a0)
    80003c00:	00053823          	sd	zero,16(a0)
    80003c04:	01010113          	addi	sp,sp,16
    80003c08:	00008067          	ret

0000000080003c0c <acquire>:
    80003c0c:	fe010113          	addi	sp,sp,-32
    80003c10:	00813823          	sd	s0,16(sp)
    80003c14:	00913423          	sd	s1,8(sp)
    80003c18:	00113c23          	sd	ra,24(sp)
    80003c1c:	01213023          	sd	s2,0(sp)
    80003c20:	02010413          	addi	s0,sp,32
    80003c24:	00050493          	mv	s1,a0
    80003c28:	10002973          	csrr	s2,sstatus
    80003c2c:	100027f3          	csrr	a5,sstatus
    80003c30:	ffd7f793          	andi	a5,a5,-3
    80003c34:	10079073          	csrw	sstatus,a5
    80003c38:	fffff097          	auipc	ra,0xfffff
    80003c3c:	8e0080e7          	jalr	-1824(ra) # 80002518 <mycpu>
    80003c40:	07852783          	lw	a5,120(a0)
    80003c44:	06078e63          	beqz	a5,80003cc0 <acquire+0xb4>
    80003c48:	fffff097          	auipc	ra,0xfffff
    80003c4c:	8d0080e7          	jalr	-1840(ra) # 80002518 <mycpu>
    80003c50:	07852783          	lw	a5,120(a0)
    80003c54:	0004a703          	lw	a4,0(s1)
    80003c58:	0017879b          	addiw	a5,a5,1
    80003c5c:	06f52c23          	sw	a5,120(a0)
    80003c60:	04071063          	bnez	a4,80003ca0 <acquire+0x94>
    80003c64:	00100713          	li	a4,1
    80003c68:	00070793          	mv	a5,a4
    80003c6c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003c70:	0007879b          	sext.w	a5,a5
    80003c74:	fe079ae3          	bnez	a5,80003c68 <acquire+0x5c>
    80003c78:	0ff0000f          	fence
    80003c7c:	fffff097          	auipc	ra,0xfffff
    80003c80:	89c080e7          	jalr	-1892(ra) # 80002518 <mycpu>
    80003c84:	01813083          	ld	ra,24(sp)
    80003c88:	01013403          	ld	s0,16(sp)
    80003c8c:	00a4b823          	sd	a0,16(s1)
    80003c90:	00013903          	ld	s2,0(sp)
    80003c94:	00813483          	ld	s1,8(sp)
    80003c98:	02010113          	addi	sp,sp,32
    80003c9c:	00008067          	ret
    80003ca0:	0104b903          	ld	s2,16(s1)
    80003ca4:	fffff097          	auipc	ra,0xfffff
    80003ca8:	874080e7          	jalr	-1932(ra) # 80002518 <mycpu>
    80003cac:	faa91ce3          	bne	s2,a0,80003c64 <acquire+0x58>
    80003cb0:	00001517          	auipc	a0,0x1
    80003cb4:	78050513          	addi	a0,a0,1920 # 80005430 <digits+0x20>
    80003cb8:	fffff097          	auipc	ra,0xfffff
    80003cbc:	224080e7          	jalr	548(ra) # 80002edc <panic>
    80003cc0:	00195913          	srli	s2,s2,0x1
    80003cc4:	fffff097          	auipc	ra,0xfffff
    80003cc8:	854080e7          	jalr	-1964(ra) # 80002518 <mycpu>
    80003ccc:	00197913          	andi	s2,s2,1
    80003cd0:	07252e23          	sw	s2,124(a0)
    80003cd4:	f75ff06f          	j	80003c48 <acquire+0x3c>

0000000080003cd8 <release>:
    80003cd8:	fe010113          	addi	sp,sp,-32
    80003cdc:	00813823          	sd	s0,16(sp)
    80003ce0:	00113c23          	sd	ra,24(sp)
    80003ce4:	00913423          	sd	s1,8(sp)
    80003ce8:	01213023          	sd	s2,0(sp)
    80003cec:	02010413          	addi	s0,sp,32
    80003cf0:	00052783          	lw	a5,0(a0)
    80003cf4:	00079a63          	bnez	a5,80003d08 <release+0x30>
    80003cf8:	00001517          	auipc	a0,0x1
    80003cfc:	74050513          	addi	a0,a0,1856 # 80005438 <digits+0x28>
    80003d00:	fffff097          	auipc	ra,0xfffff
    80003d04:	1dc080e7          	jalr	476(ra) # 80002edc <panic>
    80003d08:	01053903          	ld	s2,16(a0)
    80003d0c:	00050493          	mv	s1,a0
    80003d10:	fffff097          	auipc	ra,0xfffff
    80003d14:	808080e7          	jalr	-2040(ra) # 80002518 <mycpu>
    80003d18:	fea910e3          	bne	s2,a0,80003cf8 <release+0x20>
    80003d1c:	0004b823          	sd	zero,16(s1)
    80003d20:	0ff0000f          	fence
    80003d24:	0f50000f          	fence	iorw,ow
    80003d28:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003d2c:	ffffe097          	auipc	ra,0xffffe
    80003d30:	7ec080e7          	jalr	2028(ra) # 80002518 <mycpu>
    80003d34:	100027f3          	csrr	a5,sstatus
    80003d38:	0027f793          	andi	a5,a5,2
    80003d3c:	04079a63          	bnez	a5,80003d90 <release+0xb8>
    80003d40:	07852783          	lw	a5,120(a0)
    80003d44:	02f05e63          	blez	a5,80003d80 <release+0xa8>
    80003d48:	fff7871b          	addiw	a4,a5,-1
    80003d4c:	06e52c23          	sw	a4,120(a0)
    80003d50:	00071c63          	bnez	a4,80003d68 <release+0x90>
    80003d54:	07c52783          	lw	a5,124(a0)
    80003d58:	00078863          	beqz	a5,80003d68 <release+0x90>
    80003d5c:	100027f3          	csrr	a5,sstatus
    80003d60:	0027e793          	ori	a5,a5,2
    80003d64:	10079073          	csrw	sstatus,a5
    80003d68:	01813083          	ld	ra,24(sp)
    80003d6c:	01013403          	ld	s0,16(sp)
    80003d70:	00813483          	ld	s1,8(sp)
    80003d74:	00013903          	ld	s2,0(sp)
    80003d78:	02010113          	addi	sp,sp,32
    80003d7c:	00008067          	ret
    80003d80:	00001517          	auipc	a0,0x1
    80003d84:	6d850513          	addi	a0,a0,1752 # 80005458 <digits+0x48>
    80003d88:	fffff097          	auipc	ra,0xfffff
    80003d8c:	154080e7          	jalr	340(ra) # 80002edc <panic>
    80003d90:	00001517          	auipc	a0,0x1
    80003d94:	6b050513          	addi	a0,a0,1712 # 80005440 <digits+0x30>
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	144080e7          	jalr	324(ra) # 80002edc <panic>

0000000080003da0 <holding>:
    80003da0:	00052783          	lw	a5,0(a0)
    80003da4:	00079663          	bnez	a5,80003db0 <holding+0x10>
    80003da8:	00000513          	li	a0,0
    80003dac:	00008067          	ret
    80003db0:	fe010113          	addi	sp,sp,-32
    80003db4:	00813823          	sd	s0,16(sp)
    80003db8:	00913423          	sd	s1,8(sp)
    80003dbc:	00113c23          	sd	ra,24(sp)
    80003dc0:	02010413          	addi	s0,sp,32
    80003dc4:	01053483          	ld	s1,16(a0)
    80003dc8:	ffffe097          	auipc	ra,0xffffe
    80003dcc:	750080e7          	jalr	1872(ra) # 80002518 <mycpu>
    80003dd0:	01813083          	ld	ra,24(sp)
    80003dd4:	01013403          	ld	s0,16(sp)
    80003dd8:	40a48533          	sub	a0,s1,a0
    80003ddc:	00153513          	seqz	a0,a0
    80003de0:	00813483          	ld	s1,8(sp)
    80003de4:	02010113          	addi	sp,sp,32
    80003de8:	00008067          	ret

0000000080003dec <push_off>:
    80003dec:	fe010113          	addi	sp,sp,-32
    80003df0:	00813823          	sd	s0,16(sp)
    80003df4:	00113c23          	sd	ra,24(sp)
    80003df8:	00913423          	sd	s1,8(sp)
    80003dfc:	02010413          	addi	s0,sp,32
    80003e00:	100024f3          	csrr	s1,sstatus
    80003e04:	100027f3          	csrr	a5,sstatus
    80003e08:	ffd7f793          	andi	a5,a5,-3
    80003e0c:	10079073          	csrw	sstatus,a5
    80003e10:	ffffe097          	auipc	ra,0xffffe
    80003e14:	708080e7          	jalr	1800(ra) # 80002518 <mycpu>
    80003e18:	07852783          	lw	a5,120(a0)
    80003e1c:	02078663          	beqz	a5,80003e48 <push_off+0x5c>
    80003e20:	ffffe097          	auipc	ra,0xffffe
    80003e24:	6f8080e7          	jalr	1784(ra) # 80002518 <mycpu>
    80003e28:	07852783          	lw	a5,120(a0)
    80003e2c:	01813083          	ld	ra,24(sp)
    80003e30:	01013403          	ld	s0,16(sp)
    80003e34:	0017879b          	addiw	a5,a5,1
    80003e38:	06f52c23          	sw	a5,120(a0)
    80003e3c:	00813483          	ld	s1,8(sp)
    80003e40:	02010113          	addi	sp,sp,32
    80003e44:	00008067          	ret
    80003e48:	0014d493          	srli	s1,s1,0x1
    80003e4c:	ffffe097          	auipc	ra,0xffffe
    80003e50:	6cc080e7          	jalr	1740(ra) # 80002518 <mycpu>
    80003e54:	0014f493          	andi	s1,s1,1
    80003e58:	06952e23          	sw	s1,124(a0)
    80003e5c:	fc5ff06f          	j	80003e20 <push_off+0x34>

0000000080003e60 <pop_off>:
    80003e60:	ff010113          	addi	sp,sp,-16
    80003e64:	00813023          	sd	s0,0(sp)
    80003e68:	00113423          	sd	ra,8(sp)
    80003e6c:	01010413          	addi	s0,sp,16
    80003e70:	ffffe097          	auipc	ra,0xffffe
    80003e74:	6a8080e7          	jalr	1704(ra) # 80002518 <mycpu>
    80003e78:	100027f3          	csrr	a5,sstatus
    80003e7c:	0027f793          	andi	a5,a5,2
    80003e80:	04079663          	bnez	a5,80003ecc <pop_off+0x6c>
    80003e84:	07852783          	lw	a5,120(a0)
    80003e88:	02f05a63          	blez	a5,80003ebc <pop_off+0x5c>
    80003e8c:	fff7871b          	addiw	a4,a5,-1
    80003e90:	06e52c23          	sw	a4,120(a0)
    80003e94:	00071c63          	bnez	a4,80003eac <pop_off+0x4c>
    80003e98:	07c52783          	lw	a5,124(a0)
    80003e9c:	00078863          	beqz	a5,80003eac <pop_off+0x4c>
    80003ea0:	100027f3          	csrr	a5,sstatus
    80003ea4:	0027e793          	ori	a5,a5,2
    80003ea8:	10079073          	csrw	sstatus,a5
    80003eac:	00813083          	ld	ra,8(sp)
    80003eb0:	00013403          	ld	s0,0(sp)
    80003eb4:	01010113          	addi	sp,sp,16
    80003eb8:	00008067          	ret
    80003ebc:	00001517          	auipc	a0,0x1
    80003ec0:	59c50513          	addi	a0,a0,1436 # 80005458 <digits+0x48>
    80003ec4:	fffff097          	auipc	ra,0xfffff
    80003ec8:	018080e7          	jalr	24(ra) # 80002edc <panic>
    80003ecc:	00001517          	auipc	a0,0x1
    80003ed0:	57450513          	addi	a0,a0,1396 # 80005440 <digits+0x30>
    80003ed4:	fffff097          	auipc	ra,0xfffff
    80003ed8:	008080e7          	jalr	8(ra) # 80002edc <panic>

0000000080003edc <push_on>:
    80003edc:	fe010113          	addi	sp,sp,-32
    80003ee0:	00813823          	sd	s0,16(sp)
    80003ee4:	00113c23          	sd	ra,24(sp)
    80003ee8:	00913423          	sd	s1,8(sp)
    80003eec:	02010413          	addi	s0,sp,32
    80003ef0:	100024f3          	csrr	s1,sstatus
    80003ef4:	100027f3          	csrr	a5,sstatus
    80003ef8:	0027e793          	ori	a5,a5,2
    80003efc:	10079073          	csrw	sstatus,a5
    80003f00:	ffffe097          	auipc	ra,0xffffe
    80003f04:	618080e7          	jalr	1560(ra) # 80002518 <mycpu>
    80003f08:	07852783          	lw	a5,120(a0)
    80003f0c:	02078663          	beqz	a5,80003f38 <push_on+0x5c>
    80003f10:	ffffe097          	auipc	ra,0xffffe
    80003f14:	608080e7          	jalr	1544(ra) # 80002518 <mycpu>
    80003f18:	07852783          	lw	a5,120(a0)
    80003f1c:	01813083          	ld	ra,24(sp)
    80003f20:	01013403          	ld	s0,16(sp)
    80003f24:	0017879b          	addiw	a5,a5,1
    80003f28:	06f52c23          	sw	a5,120(a0)
    80003f2c:	00813483          	ld	s1,8(sp)
    80003f30:	02010113          	addi	sp,sp,32
    80003f34:	00008067          	ret
    80003f38:	0014d493          	srli	s1,s1,0x1
    80003f3c:	ffffe097          	auipc	ra,0xffffe
    80003f40:	5dc080e7          	jalr	1500(ra) # 80002518 <mycpu>
    80003f44:	0014f493          	andi	s1,s1,1
    80003f48:	06952e23          	sw	s1,124(a0)
    80003f4c:	fc5ff06f          	j	80003f10 <push_on+0x34>

0000000080003f50 <pop_on>:
    80003f50:	ff010113          	addi	sp,sp,-16
    80003f54:	00813023          	sd	s0,0(sp)
    80003f58:	00113423          	sd	ra,8(sp)
    80003f5c:	01010413          	addi	s0,sp,16
    80003f60:	ffffe097          	auipc	ra,0xffffe
    80003f64:	5b8080e7          	jalr	1464(ra) # 80002518 <mycpu>
    80003f68:	100027f3          	csrr	a5,sstatus
    80003f6c:	0027f793          	andi	a5,a5,2
    80003f70:	04078463          	beqz	a5,80003fb8 <pop_on+0x68>
    80003f74:	07852783          	lw	a5,120(a0)
    80003f78:	02f05863          	blez	a5,80003fa8 <pop_on+0x58>
    80003f7c:	fff7879b          	addiw	a5,a5,-1
    80003f80:	06f52c23          	sw	a5,120(a0)
    80003f84:	07853783          	ld	a5,120(a0)
    80003f88:	00079863          	bnez	a5,80003f98 <pop_on+0x48>
    80003f8c:	100027f3          	csrr	a5,sstatus
    80003f90:	ffd7f793          	andi	a5,a5,-3
    80003f94:	10079073          	csrw	sstatus,a5
    80003f98:	00813083          	ld	ra,8(sp)
    80003f9c:	00013403          	ld	s0,0(sp)
    80003fa0:	01010113          	addi	sp,sp,16
    80003fa4:	00008067          	ret
    80003fa8:	00001517          	auipc	a0,0x1
    80003fac:	4d850513          	addi	a0,a0,1240 # 80005480 <digits+0x70>
    80003fb0:	fffff097          	auipc	ra,0xfffff
    80003fb4:	f2c080e7          	jalr	-212(ra) # 80002edc <panic>
    80003fb8:	00001517          	auipc	a0,0x1
    80003fbc:	4a850513          	addi	a0,a0,1192 # 80005460 <digits+0x50>
    80003fc0:	fffff097          	auipc	ra,0xfffff
    80003fc4:	f1c080e7          	jalr	-228(ra) # 80002edc <panic>

0000000080003fc8 <__memset>:
    80003fc8:	ff010113          	addi	sp,sp,-16
    80003fcc:	00813423          	sd	s0,8(sp)
    80003fd0:	01010413          	addi	s0,sp,16
    80003fd4:	1a060e63          	beqz	a2,80004190 <__memset+0x1c8>
    80003fd8:	40a007b3          	neg	a5,a0
    80003fdc:	0077f793          	andi	a5,a5,7
    80003fe0:	00778693          	addi	a3,a5,7
    80003fe4:	00b00813          	li	a6,11
    80003fe8:	0ff5f593          	andi	a1,a1,255
    80003fec:	fff6071b          	addiw	a4,a2,-1
    80003ff0:	1b06e663          	bltu	a3,a6,8000419c <__memset+0x1d4>
    80003ff4:	1cd76463          	bltu	a4,a3,800041bc <__memset+0x1f4>
    80003ff8:	1a078e63          	beqz	a5,800041b4 <__memset+0x1ec>
    80003ffc:	00b50023          	sb	a1,0(a0)
    80004000:	00100713          	li	a4,1
    80004004:	1ae78463          	beq	a5,a4,800041ac <__memset+0x1e4>
    80004008:	00b500a3          	sb	a1,1(a0)
    8000400c:	00200713          	li	a4,2
    80004010:	1ae78a63          	beq	a5,a4,800041c4 <__memset+0x1fc>
    80004014:	00b50123          	sb	a1,2(a0)
    80004018:	00300713          	li	a4,3
    8000401c:	18e78463          	beq	a5,a4,800041a4 <__memset+0x1dc>
    80004020:	00b501a3          	sb	a1,3(a0)
    80004024:	00400713          	li	a4,4
    80004028:	1ae78263          	beq	a5,a4,800041cc <__memset+0x204>
    8000402c:	00b50223          	sb	a1,4(a0)
    80004030:	00500713          	li	a4,5
    80004034:	1ae78063          	beq	a5,a4,800041d4 <__memset+0x20c>
    80004038:	00b502a3          	sb	a1,5(a0)
    8000403c:	00700713          	li	a4,7
    80004040:	18e79e63          	bne	a5,a4,800041dc <__memset+0x214>
    80004044:	00b50323          	sb	a1,6(a0)
    80004048:	00700e93          	li	t4,7
    8000404c:	00859713          	slli	a4,a1,0x8
    80004050:	00e5e733          	or	a4,a1,a4
    80004054:	01059e13          	slli	t3,a1,0x10
    80004058:	01c76e33          	or	t3,a4,t3
    8000405c:	01859313          	slli	t1,a1,0x18
    80004060:	006e6333          	or	t1,t3,t1
    80004064:	02059893          	slli	a7,a1,0x20
    80004068:	40f60e3b          	subw	t3,a2,a5
    8000406c:	011368b3          	or	a7,t1,a7
    80004070:	02859813          	slli	a6,a1,0x28
    80004074:	0108e833          	or	a6,a7,a6
    80004078:	03059693          	slli	a3,a1,0x30
    8000407c:	003e589b          	srliw	a7,t3,0x3
    80004080:	00d866b3          	or	a3,a6,a3
    80004084:	03859713          	slli	a4,a1,0x38
    80004088:	00389813          	slli	a6,a7,0x3
    8000408c:	00f507b3          	add	a5,a0,a5
    80004090:	00e6e733          	or	a4,a3,a4
    80004094:	000e089b          	sext.w	a7,t3
    80004098:	00f806b3          	add	a3,a6,a5
    8000409c:	00e7b023          	sd	a4,0(a5)
    800040a0:	00878793          	addi	a5,a5,8
    800040a4:	fed79ce3          	bne	a5,a3,8000409c <__memset+0xd4>
    800040a8:	ff8e7793          	andi	a5,t3,-8
    800040ac:	0007871b          	sext.w	a4,a5
    800040b0:	01d787bb          	addw	a5,a5,t4
    800040b4:	0ce88e63          	beq	a7,a4,80004190 <__memset+0x1c8>
    800040b8:	00f50733          	add	a4,a0,a5
    800040bc:	00b70023          	sb	a1,0(a4)
    800040c0:	0017871b          	addiw	a4,a5,1
    800040c4:	0cc77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    800040c8:	00e50733          	add	a4,a0,a4
    800040cc:	00b70023          	sb	a1,0(a4)
    800040d0:	0027871b          	addiw	a4,a5,2
    800040d4:	0ac77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    800040d8:	00e50733          	add	a4,a0,a4
    800040dc:	00b70023          	sb	a1,0(a4)
    800040e0:	0037871b          	addiw	a4,a5,3
    800040e4:	0ac77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    800040e8:	00e50733          	add	a4,a0,a4
    800040ec:	00b70023          	sb	a1,0(a4)
    800040f0:	0047871b          	addiw	a4,a5,4
    800040f4:	08c77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    800040f8:	00e50733          	add	a4,a0,a4
    800040fc:	00b70023          	sb	a1,0(a4)
    80004100:	0057871b          	addiw	a4,a5,5
    80004104:	08c77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004108:	00e50733          	add	a4,a0,a4
    8000410c:	00b70023          	sb	a1,0(a4)
    80004110:	0067871b          	addiw	a4,a5,6
    80004114:	06c77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004118:	00e50733          	add	a4,a0,a4
    8000411c:	00b70023          	sb	a1,0(a4)
    80004120:	0077871b          	addiw	a4,a5,7
    80004124:	06c77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00b70023          	sb	a1,0(a4)
    80004130:	0087871b          	addiw	a4,a5,8
    80004134:	04c77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004138:	00e50733          	add	a4,a0,a4
    8000413c:	00b70023          	sb	a1,0(a4)
    80004140:	0097871b          	addiw	a4,a5,9
    80004144:	04c77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004148:	00e50733          	add	a4,a0,a4
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	00a7871b          	addiw	a4,a5,10
    80004154:	02c77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004158:	00e50733          	add	a4,a0,a4
    8000415c:	00b70023          	sb	a1,0(a4)
    80004160:	00b7871b          	addiw	a4,a5,11
    80004164:	02c77663          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004168:	00e50733          	add	a4,a0,a4
    8000416c:	00b70023          	sb	a1,0(a4)
    80004170:	00c7871b          	addiw	a4,a5,12
    80004174:	00c77e63          	bgeu	a4,a2,80004190 <__memset+0x1c8>
    80004178:	00e50733          	add	a4,a0,a4
    8000417c:	00b70023          	sb	a1,0(a4)
    80004180:	00d7879b          	addiw	a5,a5,13
    80004184:	00c7f663          	bgeu	a5,a2,80004190 <__memset+0x1c8>
    80004188:	00f507b3          	add	a5,a0,a5
    8000418c:	00b78023          	sb	a1,0(a5)
    80004190:	00813403          	ld	s0,8(sp)
    80004194:	01010113          	addi	sp,sp,16
    80004198:	00008067          	ret
    8000419c:	00b00693          	li	a3,11
    800041a0:	e55ff06f          	j	80003ff4 <__memset+0x2c>
    800041a4:	00300e93          	li	t4,3
    800041a8:	ea5ff06f          	j	8000404c <__memset+0x84>
    800041ac:	00100e93          	li	t4,1
    800041b0:	e9dff06f          	j	8000404c <__memset+0x84>
    800041b4:	00000e93          	li	t4,0
    800041b8:	e95ff06f          	j	8000404c <__memset+0x84>
    800041bc:	00000793          	li	a5,0
    800041c0:	ef9ff06f          	j	800040b8 <__memset+0xf0>
    800041c4:	00200e93          	li	t4,2
    800041c8:	e85ff06f          	j	8000404c <__memset+0x84>
    800041cc:	00400e93          	li	t4,4
    800041d0:	e7dff06f          	j	8000404c <__memset+0x84>
    800041d4:	00500e93          	li	t4,5
    800041d8:	e75ff06f          	j	8000404c <__memset+0x84>
    800041dc:	00600e93          	li	t4,6
    800041e0:	e6dff06f          	j	8000404c <__memset+0x84>

00000000800041e4 <__memmove>:
    800041e4:	ff010113          	addi	sp,sp,-16
    800041e8:	00813423          	sd	s0,8(sp)
    800041ec:	01010413          	addi	s0,sp,16
    800041f0:	0e060863          	beqz	a2,800042e0 <__memmove+0xfc>
    800041f4:	fff6069b          	addiw	a3,a2,-1
    800041f8:	0006881b          	sext.w	a6,a3
    800041fc:	0ea5e863          	bltu	a1,a0,800042ec <__memmove+0x108>
    80004200:	00758713          	addi	a4,a1,7
    80004204:	00a5e7b3          	or	a5,a1,a0
    80004208:	40a70733          	sub	a4,a4,a0
    8000420c:	0077f793          	andi	a5,a5,7
    80004210:	00f73713          	sltiu	a4,a4,15
    80004214:	00174713          	xori	a4,a4,1
    80004218:	0017b793          	seqz	a5,a5
    8000421c:	00e7f7b3          	and	a5,a5,a4
    80004220:	10078863          	beqz	a5,80004330 <__memmove+0x14c>
    80004224:	00900793          	li	a5,9
    80004228:	1107f463          	bgeu	a5,a6,80004330 <__memmove+0x14c>
    8000422c:	0036581b          	srliw	a6,a2,0x3
    80004230:	fff8081b          	addiw	a6,a6,-1
    80004234:	02081813          	slli	a6,a6,0x20
    80004238:	01d85893          	srli	a7,a6,0x1d
    8000423c:	00858813          	addi	a6,a1,8
    80004240:	00058793          	mv	a5,a1
    80004244:	00050713          	mv	a4,a0
    80004248:	01088833          	add	a6,a7,a6
    8000424c:	0007b883          	ld	a7,0(a5)
    80004250:	00878793          	addi	a5,a5,8
    80004254:	00870713          	addi	a4,a4,8
    80004258:	ff173c23          	sd	a7,-8(a4)
    8000425c:	ff0798e3          	bne	a5,a6,8000424c <__memmove+0x68>
    80004260:	ff867713          	andi	a4,a2,-8
    80004264:	02071793          	slli	a5,a4,0x20
    80004268:	0207d793          	srli	a5,a5,0x20
    8000426c:	00f585b3          	add	a1,a1,a5
    80004270:	40e686bb          	subw	a3,a3,a4
    80004274:	00f507b3          	add	a5,a0,a5
    80004278:	06e60463          	beq	a2,a4,800042e0 <__memmove+0xfc>
    8000427c:	0005c703          	lbu	a4,0(a1)
    80004280:	00e78023          	sb	a4,0(a5)
    80004284:	04068e63          	beqz	a3,800042e0 <__memmove+0xfc>
    80004288:	0015c603          	lbu	a2,1(a1)
    8000428c:	00100713          	li	a4,1
    80004290:	00c780a3          	sb	a2,1(a5)
    80004294:	04e68663          	beq	a3,a4,800042e0 <__memmove+0xfc>
    80004298:	0025c603          	lbu	a2,2(a1)
    8000429c:	00200713          	li	a4,2
    800042a0:	00c78123          	sb	a2,2(a5)
    800042a4:	02e68e63          	beq	a3,a4,800042e0 <__memmove+0xfc>
    800042a8:	0035c603          	lbu	a2,3(a1)
    800042ac:	00300713          	li	a4,3
    800042b0:	00c781a3          	sb	a2,3(a5)
    800042b4:	02e68663          	beq	a3,a4,800042e0 <__memmove+0xfc>
    800042b8:	0045c603          	lbu	a2,4(a1)
    800042bc:	00400713          	li	a4,4
    800042c0:	00c78223          	sb	a2,4(a5)
    800042c4:	00e68e63          	beq	a3,a4,800042e0 <__memmove+0xfc>
    800042c8:	0055c603          	lbu	a2,5(a1)
    800042cc:	00500713          	li	a4,5
    800042d0:	00c782a3          	sb	a2,5(a5)
    800042d4:	00e68663          	beq	a3,a4,800042e0 <__memmove+0xfc>
    800042d8:	0065c703          	lbu	a4,6(a1)
    800042dc:	00e78323          	sb	a4,6(a5)
    800042e0:	00813403          	ld	s0,8(sp)
    800042e4:	01010113          	addi	sp,sp,16
    800042e8:	00008067          	ret
    800042ec:	02061713          	slli	a4,a2,0x20
    800042f0:	02075713          	srli	a4,a4,0x20
    800042f4:	00e587b3          	add	a5,a1,a4
    800042f8:	f0f574e3          	bgeu	a0,a5,80004200 <__memmove+0x1c>
    800042fc:	02069613          	slli	a2,a3,0x20
    80004300:	02065613          	srli	a2,a2,0x20
    80004304:	fff64613          	not	a2,a2
    80004308:	00e50733          	add	a4,a0,a4
    8000430c:	00c78633          	add	a2,a5,a2
    80004310:	fff7c683          	lbu	a3,-1(a5)
    80004314:	fff78793          	addi	a5,a5,-1
    80004318:	fff70713          	addi	a4,a4,-1
    8000431c:	00d70023          	sb	a3,0(a4)
    80004320:	fec798e3          	bne	a5,a2,80004310 <__memmove+0x12c>
    80004324:	00813403          	ld	s0,8(sp)
    80004328:	01010113          	addi	sp,sp,16
    8000432c:	00008067          	ret
    80004330:	02069713          	slli	a4,a3,0x20
    80004334:	02075713          	srli	a4,a4,0x20
    80004338:	00170713          	addi	a4,a4,1
    8000433c:	00e50733          	add	a4,a0,a4
    80004340:	00050793          	mv	a5,a0
    80004344:	0005c683          	lbu	a3,0(a1)
    80004348:	00178793          	addi	a5,a5,1
    8000434c:	00158593          	addi	a1,a1,1
    80004350:	fed78fa3          	sb	a3,-1(a5)
    80004354:	fee798e3          	bne	a5,a4,80004344 <__memmove+0x160>
    80004358:	f89ff06f          	j	800042e0 <__memmove+0xfc>

000000008000435c <__mem_free>:
    8000435c:	ff010113          	addi	sp,sp,-16
    80004360:	00813423          	sd	s0,8(sp)
    80004364:	01010413          	addi	s0,sp,16
    80004368:	00002597          	auipc	a1,0x2
    8000436c:	8d058593          	addi	a1,a1,-1840 # 80005c38 <freep>
    80004370:	0005b783          	ld	a5,0(a1)
    80004374:	ff050693          	addi	a3,a0,-16
    80004378:	0007b703          	ld	a4,0(a5)
    8000437c:	00d7fc63          	bgeu	a5,a3,80004394 <__mem_free+0x38>
    80004380:	00e6ee63          	bltu	a3,a4,8000439c <__mem_free+0x40>
    80004384:	00e7fc63          	bgeu	a5,a4,8000439c <__mem_free+0x40>
    80004388:	00070793          	mv	a5,a4
    8000438c:	0007b703          	ld	a4,0(a5)
    80004390:	fed7e8e3          	bltu	a5,a3,80004380 <__mem_free+0x24>
    80004394:	fee7eae3          	bltu	a5,a4,80004388 <__mem_free+0x2c>
    80004398:	fee6f8e3          	bgeu	a3,a4,80004388 <__mem_free+0x2c>
    8000439c:	ff852803          	lw	a6,-8(a0)
    800043a0:	02081613          	slli	a2,a6,0x20
    800043a4:	01c65613          	srli	a2,a2,0x1c
    800043a8:	00c68633          	add	a2,a3,a2
    800043ac:	02c70a63          	beq	a4,a2,800043e0 <__mem_free+0x84>
    800043b0:	fee53823          	sd	a4,-16(a0)
    800043b4:	0087a503          	lw	a0,8(a5)
    800043b8:	02051613          	slli	a2,a0,0x20
    800043bc:	01c65613          	srli	a2,a2,0x1c
    800043c0:	00c78633          	add	a2,a5,a2
    800043c4:	04c68263          	beq	a3,a2,80004408 <__mem_free+0xac>
    800043c8:	00813403          	ld	s0,8(sp)
    800043cc:	00d7b023          	sd	a3,0(a5)
    800043d0:	00f5b023          	sd	a5,0(a1)
    800043d4:	00000513          	li	a0,0
    800043d8:	01010113          	addi	sp,sp,16
    800043dc:	00008067          	ret
    800043e0:	00872603          	lw	a2,8(a4)
    800043e4:	00073703          	ld	a4,0(a4)
    800043e8:	0106083b          	addw	a6,a2,a6
    800043ec:	ff052c23          	sw	a6,-8(a0)
    800043f0:	fee53823          	sd	a4,-16(a0)
    800043f4:	0087a503          	lw	a0,8(a5)
    800043f8:	02051613          	slli	a2,a0,0x20
    800043fc:	01c65613          	srli	a2,a2,0x1c
    80004400:	00c78633          	add	a2,a5,a2
    80004404:	fcc692e3          	bne	a3,a2,800043c8 <__mem_free+0x6c>
    80004408:	00813403          	ld	s0,8(sp)
    8000440c:	0105053b          	addw	a0,a0,a6
    80004410:	00a7a423          	sw	a0,8(a5)
    80004414:	00e7b023          	sd	a4,0(a5)
    80004418:	00f5b023          	sd	a5,0(a1)
    8000441c:	00000513          	li	a0,0
    80004420:	01010113          	addi	sp,sp,16
    80004424:	00008067          	ret

0000000080004428 <__mem_alloc>:
    80004428:	fc010113          	addi	sp,sp,-64
    8000442c:	02813823          	sd	s0,48(sp)
    80004430:	02913423          	sd	s1,40(sp)
    80004434:	03213023          	sd	s2,32(sp)
    80004438:	01513423          	sd	s5,8(sp)
    8000443c:	02113c23          	sd	ra,56(sp)
    80004440:	01313c23          	sd	s3,24(sp)
    80004444:	01413823          	sd	s4,16(sp)
    80004448:	01613023          	sd	s6,0(sp)
    8000444c:	04010413          	addi	s0,sp,64
    80004450:	00001a97          	auipc	s5,0x1
    80004454:	7e8a8a93          	addi	s5,s5,2024 # 80005c38 <freep>
    80004458:	00f50913          	addi	s2,a0,15
    8000445c:	000ab683          	ld	a3,0(s5)
    80004460:	00495913          	srli	s2,s2,0x4
    80004464:	0019049b          	addiw	s1,s2,1
    80004468:	00048913          	mv	s2,s1
    8000446c:	0c068c63          	beqz	a3,80004544 <__mem_alloc+0x11c>
    80004470:	0006b503          	ld	a0,0(a3)
    80004474:	00852703          	lw	a4,8(a0)
    80004478:	10977063          	bgeu	a4,s1,80004578 <__mem_alloc+0x150>
    8000447c:	000017b7          	lui	a5,0x1
    80004480:	0009099b          	sext.w	s3,s2
    80004484:	0af4e863          	bltu	s1,a5,80004534 <__mem_alloc+0x10c>
    80004488:	02099a13          	slli	s4,s3,0x20
    8000448c:	01ca5a13          	srli	s4,s4,0x1c
    80004490:	fff00b13          	li	s6,-1
    80004494:	0100006f          	j	800044a4 <__mem_alloc+0x7c>
    80004498:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    8000449c:	00852703          	lw	a4,8(a0)
    800044a0:	04977463          	bgeu	a4,s1,800044e8 <__mem_alloc+0xc0>
    800044a4:	00050793          	mv	a5,a0
    800044a8:	fea698e3          	bne	a3,a0,80004498 <__mem_alloc+0x70>
    800044ac:	000a0513          	mv	a0,s4
    800044b0:	00000097          	auipc	ra,0x0
    800044b4:	1f0080e7          	jalr	496(ra) # 800046a0 <kvmincrease>
    800044b8:	00050793          	mv	a5,a0
    800044bc:	01050513          	addi	a0,a0,16
    800044c0:	07678e63          	beq	a5,s6,8000453c <__mem_alloc+0x114>
    800044c4:	0137a423          	sw	s3,8(a5)
    800044c8:	00000097          	auipc	ra,0x0
    800044cc:	e94080e7          	jalr	-364(ra) # 8000435c <__mem_free>
    800044d0:	000ab783          	ld	a5,0(s5)
    800044d4:	06078463          	beqz	a5,8000453c <__mem_alloc+0x114>
    800044d8:	0007b503          	ld	a0,0(a5)
    800044dc:	00078693          	mv	a3,a5
    800044e0:	00852703          	lw	a4,8(a0)
    800044e4:	fc9760e3          	bltu	a4,s1,800044a4 <__mem_alloc+0x7c>
    800044e8:	08e48263          	beq	s1,a4,8000456c <__mem_alloc+0x144>
    800044ec:	4127073b          	subw	a4,a4,s2
    800044f0:	02071693          	slli	a3,a4,0x20
    800044f4:	01c6d693          	srli	a3,a3,0x1c
    800044f8:	00e52423          	sw	a4,8(a0)
    800044fc:	00d50533          	add	a0,a0,a3
    80004500:	01252423          	sw	s2,8(a0)
    80004504:	00fab023          	sd	a5,0(s5)
    80004508:	01050513          	addi	a0,a0,16
    8000450c:	03813083          	ld	ra,56(sp)
    80004510:	03013403          	ld	s0,48(sp)
    80004514:	02813483          	ld	s1,40(sp)
    80004518:	02013903          	ld	s2,32(sp)
    8000451c:	01813983          	ld	s3,24(sp)
    80004520:	01013a03          	ld	s4,16(sp)
    80004524:	00813a83          	ld	s5,8(sp)
    80004528:	00013b03          	ld	s6,0(sp)
    8000452c:	04010113          	addi	sp,sp,64
    80004530:	00008067          	ret
    80004534:	000019b7          	lui	s3,0x1
    80004538:	f51ff06f          	j	80004488 <__mem_alloc+0x60>
    8000453c:	00000513          	li	a0,0
    80004540:	fcdff06f          	j	8000450c <__mem_alloc+0xe4>
    80004544:	00003797          	auipc	a5,0x3
    80004548:	98c78793          	addi	a5,a5,-1652 # 80006ed0 <base>
    8000454c:	00078513          	mv	a0,a5
    80004550:	00fab023          	sd	a5,0(s5)
    80004554:	00f7b023          	sd	a5,0(a5)
    80004558:	00000713          	li	a4,0
    8000455c:	00003797          	auipc	a5,0x3
    80004560:	9607ae23          	sw	zero,-1668(a5) # 80006ed8 <base+0x8>
    80004564:	00050693          	mv	a3,a0
    80004568:	f11ff06f          	j	80004478 <__mem_alloc+0x50>
    8000456c:	00053703          	ld	a4,0(a0)
    80004570:	00e7b023          	sd	a4,0(a5)
    80004574:	f91ff06f          	j	80004504 <__mem_alloc+0xdc>
    80004578:	00068793          	mv	a5,a3
    8000457c:	f6dff06f          	j	800044e8 <__mem_alloc+0xc0>

0000000080004580 <__putc>:
    80004580:	fe010113          	addi	sp,sp,-32
    80004584:	00813823          	sd	s0,16(sp)
    80004588:	00113c23          	sd	ra,24(sp)
    8000458c:	02010413          	addi	s0,sp,32
    80004590:	00050793          	mv	a5,a0
    80004594:	fef40593          	addi	a1,s0,-17
    80004598:	00100613          	li	a2,1
    8000459c:	00000513          	li	a0,0
    800045a0:	fef407a3          	sb	a5,-17(s0)
    800045a4:	fffff097          	auipc	ra,0xfffff
    800045a8:	918080e7          	jalr	-1768(ra) # 80002ebc <console_write>
    800045ac:	01813083          	ld	ra,24(sp)
    800045b0:	01013403          	ld	s0,16(sp)
    800045b4:	02010113          	addi	sp,sp,32
    800045b8:	00008067          	ret

00000000800045bc <__getc>:
    800045bc:	fe010113          	addi	sp,sp,-32
    800045c0:	00813823          	sd	s0,16(sp)
    800045c4:	00113c23          	sd	ra,24(sp)
    800045c8:	02010413          	addi	s0,sp,32
    800045cc:	fe840593          	addi	a1,s0,-24
    800045d0:	00100613          	li	a2,1
    800045d4:	00000513          	li	a0,0
    800045d8:	fffff097          	auipc	ra,0xfffff
    800045dc:	8c4080e7          	jalr	-1852(ra) # 80002e9c <console_read>
    800045e0:	fe844503          	lbu	a0,-24(s0)
    800045e4:	01813083          	ld	ra,24(sp)
    800045e8:	01013403          	ld	s0,16(sp)
    800045ec:	02010113          	addi	sp,sp,32
    800045f0:	00008067          	ret

00000000800045f4 <console_handler>:
    800045f4:	fe010113          	addi	sp,sp,-32
    800045f8:	00813823          	sd	s0,16(sp)
    800045fc:	00113c23          	sd	ra,24(sp)
    80004600:	00913423          	sd	s1,8(sp)
    80004604:	02010413          	addi	s0,sp,32
    80004608:	14202773          	csrr	a4,scause
    8000460c:	100027f3          	csrr	a5,sstatus
    80004610:	0027f793          	andi	a5,a5,2
    80004614:	06079e63          	bnez	a5,80004690 <console_handler+0x9c>
    80004618:	00074c63          	bltz	a4,80004630 <console_handler+0x3c>
    8000461c:	01813083          	ld	ra,24(sp)
    80004620:	01013403          	ld	s0,16(sp)
    80004624:	00813483          	ld	s1,8(sp)
    80004628:	02010113          	addi	sp,sp,32
    8000462c:	00008067          	ret
    80004630:	0ff77713          	andi	a4,a4,255
    80004634:	00900793          	li	a5,9
    80004638:	fef712e3          	bne	a4,a5,8000461c <console_handler+0x28>
    8000463c:	ffffe097          	auipc	ra,0xffffe
    80004640:	4b8080e7          	jalr	1208(ra) # 80002af4 <plic_claim>
    80004644:	00a00793          	li	a5,10
    80004648:	00050493          	mv	s1,a0
    8000464c:	02f50c63          	beq	a0,a5,80004684 <console_handler+0x90>
    80004650:	fc0506e3          	beqz	a0,8000461c <console_handler+0x28>
    80004654:	00050593          	mv	a1,a0
    80004658:	00001517          	auipc	a0,0x1
    8000465c:	d3050513          	addi	a0,a0,-720 # 80005388 <kvmincrease+0xce8>
    80004660:	fffff097          	auipc	ra,0xfffff
    80004664:	8d8080e7          	jalr	-1832(ra) # 80002f38 <__printf>
    80004668:	01013403          	ld	s0,16(sp)
    8000466c:	01813083          	ld	ra,24(sp)
    80004670:	00048513          	mv	a0,s1
    80004674:	00813483          	ld	s1,8(sp)
    80004678:	02010113          	addi	sp,sp,32
    8000467c:	ffffe317          	auipc	t1,0xffffe
    80004680:	4b030067          	jr	1200(t1) # 80002b2c <plic_complete>
    80004684:	fffff097          	auipc	ra,0xfffff
    80004688:	1bc080e7          	jalr	444(ra) # 80003840 <uartintr>
    8000468c:	fddff06f          	j	80004668 <console_handler+0x74>
    80004690:	00001517          	auipc	a0,0x1
    80004694:	df850513          	addi	a0,a0,-520 # 80005488 <digits+0x78>
    80004698:	fffff097          	auipc	ra,0xfffff
    8000469c:	844080e7          	jalr	-1980(ra) # 80002edc <panic>

00000000800046a0 <kvmincrease>:
    800046a0:	fe010113          	addi	sp,sp,-32
    800046a4:	01213023          	sd	s2,0(sp)
    800046a8:	00001937          	lui	s2,0x1
    800046ac:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    800046b0:	00813823          	sd	s0,16(sp)
    800046b4:	00113c23          	sd	ra,24(sp)
    800046b8:	00913423          	sd	s1,8(sp)
    800046bc:	02010413          	addi	s0,sp,32
    800046c0:	01250933          	add	s2,a0,s2
    800046c4:	00c95913          	srli	s2,s2,0xc
    800046c8:	02090863          	beqz	s2,800046f8 <kvmincrease+0x58>
    800046cc:	00000493          	li	s1,0
    800046d0:	00148493          	addi	s1,s1,1
    800046d4:	fffff097          	auipc	ra,0xfffff
    800046d8:	4bc080e7          	jalr	1212(ra) # 80003b90 <kalloc>
    800046dc:	fe991ae3          	bne	s2,s1,800046d0 <kvmincrease+0x30>
    800046e0:	01813083          	ld	ra,24(sp)
    800046e4:	01013403          	ld	s0,16(sp)
    800046e8:	00813483          	ld	s1,8(sp)
    800046ec:	00013903          	ld	s2,0(sp)
    800046f0:	02010113          	addi	sp,sp,32
    800046f4:	00008067          	ret
    800046f8:	01813083          	ld	ra,24(sp)
    800046fc:	01013403          	ld	s0,16(sp)
    80004700:	00813483          	ld	s1,8(sp)
    80004704:	00013903          	ld	s2,0(sp)
    80004708:	00000513          	li	a0,0
    8000470c:	02010113          	addi	sp,sp,32
    80004710:	00008067          	ret
	...
