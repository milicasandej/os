
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	f1813103          	ld	sp,-232(sp) # 80009f18 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4d5040ef          	jal	ra,80004cf0 <start>

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
    800010a4:	219000ef          	jal	ra,80001abc <_ZN5Riscv20handleSupervisorTrapEv>


    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
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
    800010d0:	05813583          	ld	a1,88(sp)
    800010d4:	06013603          	ld	a2,96(sp)
    800010d8:	06813683          	ld	a3,104(sp)
    800010dc:	07013703          	ld	a4,112(sp)
    800010e0:	07813783          	ld	a5,120(sp)
    800010e4:	08013803          	ld	a6,128(sp)
    800010e8:	08813883          	ld	a7,136(sp)
    800010ec:	09013903          	ld	s2,144(sp)
    800010f0:	09813983          	ld	s3,152(sp)
    800010f4:	0a013a03          	ld	s4,160(sp)
    800010f8:	0a813a83          	ld	s5,168(sp)
    800010fc:	0b013b03          	ld	s6,176(sp)
    80001100:	0b813b83          	ld	s7,184(sp)
    80001104:	0c013c03          	ld	s8,192(sp)
    80001108:	0c813c83          	ld	s9,200(sp)
    8000110c:	0d013d03          	ld	s10,208(sp)
    80001110:	0d813d83          	ld	s11,216(sp)
    80001114:	0e013e03          	ld	t3,224(sp)
    80001118:	0e813e83          	ld	t4,232(sp)
    8000111c:	0f013f03          	ld	t5,240(sp)
    80001120:	0f813f83          	ld	t6,248(sp)

    addi sp, sp, 256
    80001124:	10010113          	addi	sp,sp,256

    sret
    80001128:	10200073          	sret
    8000112c:	0000                	unimp
	...

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

0000000080001144 <_Z8userModev>:
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../lib/mem.h"
#include "../lib/console.h"

void userMode(){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_USER_MODE);
    80001150:	00000793          	li	a5,0
    80001154:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001158:	00000073          	ecall
}
    8000115c:	00813403          	ld	s0,8(sp)
    80001160:	01010113          	addi	sp,sp,16
    80001164:	00008067          	ret

0000000080001168 <_Z9mem_allocm>:

void* mem_alloc(size_t size){
    80001168:	ff010113          	addi	sp,sp,-16
    8000116c:	00813423          	sd	s0,8(sp)
    80001170:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_ALLOC);
    80001174:	00100793          	li	a5,1
    80001178:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    8000117c:	00000073          	ecall

    void* ret;
    READ_REG(ret, "a0");
    80001180:	00050513          	mv	a0,a0
    return ret;
}
    80001184:	00813403          	ld	s0,8(sp)
    80001188:	01010113          	addi	sp,sp,16
    8000118c:	00008067          	ret

0000000080001190 <_Z8mem_freePv>:

int mem_free(void* ptr){
    80001190:	ff010113          	addi	sp,sp,-16
    80001194:	00813423          	sd	s0,8(sp)
    80001198:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_FREE);
    8000119c:	00200793          	li	a5,2
    800011a0:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011a4:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011a8:	00050513          	mv	a0,a0
    return ret;
}
    800011ac:	0005051b          	sext.w	a0,a0
    800011b0:	00813403          	ld	s0,8(sp)
    800011b4:	01010113          	addi	sp,sp,16
    800011b8:	00008067          	ret

00000000800011bc <_Z13thread_createPP7_threadPFvPvES2_>:
//
//size_t mem_get_largest_free_block(){
//    //TODO
//}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    800011bc:	ff010113          	addi	sp,sp,-16
    800011c0:	00813423          	sd	s0,8(sp)
    800011c4:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);
    800011c8:	01100793          	li	a5,17
    800011cc:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011d0:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011d4:	00050513          	mv	a0,a0
    return ret;
}
    800011d8:	0005051b          	sext.w	a0,a0
    800011dc:	00813403          	ld	s0,8(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret

00000000800011e8 <_Z11thread_exitv>:

int thread_exit(){
    800011e8:	ff010113          	addi	sp,sp,-16
    800011ec:	00813423          	sd	s0,8(sp)
    800011f0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);
    800011f4:	01200793          	li	a5,18
    800011f8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011fc:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001200:	00050513          	mv	a0,a0
    return ret;
}
    80001204:	0005051b          	sext.w	a0,a0
    80001208:	00813403          	ld	s0,8(sp)
    8000120c:	01010113          	addi	sp,sp,16
    80001210:	00008067          	ret

0000000080001214 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001214:	ff010113          	addi	sp,sp,-16
    80001218:	00813423          	sd	s0,8(sp)
    8000121c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);
    80001220:	01300793          	li	a5,19
    80001224:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001228:	00000073          	ecall
}
    8000122c:	00813403          	ld	s0,8(sp)
    80001230:	01010113          	addi	sp,sp,16
    80001234:	00008067          	ret

0000000080001238 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    80001238:	ff010113          	addi	sp,sp,-16
    8000123c:	00813423          	sd	s0,8(sp)
    80001240:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);
    80001244:	02100793          	li	a5,33
    80001248:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    8000124c:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001250:	00050513          	mv	a0,a0
    return ret;
}
    80001254:	0005051b          	sext.w	a0,a0
    80001258:	00813403          	ld	s0,8(sp)
    8000125c:	01010113          	addi	sp,sp,16
    80001260:	00008067          	ret

0000000080001264 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle) {
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00813423          	sd	s0,8(sp)
    8000126c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);
    80001270:	02200793          	li	a5,34
    80001274:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001278:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    8000127c:	00050513          	mv	a0,a0
    return ret;
}
    80001280:	0005051b          	sext.w	a0,a0
    80001284:	00813403          	ld	s0,8(sp)
    80001288:	01010113          	addi	sp,sp,16
    8000128c:	00008067          	ret

0000000080001290 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t id){
    80001290:	ff010113          	addi	sp,sp,-16
    80001294:	00813423          	sd	s0,8(sp)
    80001298:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);
    8000129c:	02300793          	li	a5,35
    800012a0:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012a4:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800012a8:	00050513          	mv	a0,a0
    return ret;
}
    800012ac:	0005051b          	sext.w	a0,a0
    800012b0:	00813403          	ld	s0,8(sp)
    800012b4:	01010113          	addi	sp,sp,16
    800012b8:	00008067          	ret

00000000800012bc <_Z10sem_signalP4_sem>:

int sem_signal(sem_t id){
    800012bc:	ff010113          	addi	sp,sp,-16
    800012c0:	00813423          	sd	s0,8(sp)
    800012c4:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);
    800012c8:	02400793          	li	a5,36
    800012cc:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012d0:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800012d4:	00050513          	mv	a0,a0
    return ret;
}
    800012d8:	0005051b          	sext.w	a0,a0
    800012dc:	00813403          	ld	s0,8(sp)
    800012e0:	01010113          	addi	sp,sp,16
    800012e4:	00008067          	ret

00000000800012e8 <_Z4getcv>:

char getc(){
    800012e8:	ff010113          	addi	sp,sp,-16
    800012ec:	00813423          	sd	s0,8(sp)
    800012f0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_GETC);
    800012f4:	04100793          	li	a5,65
    800012f8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012fc:	00000073          	ecall

    char ret;
    READ_REG(ret, "a0");
    80001300:	00050513          	mv	a0,a0
    return ret;
}
    80001304:	0ff57513          	andi	a0,a0,255
    80001308:	00813403          	ld	s0,8(sp)
    8000130c:	01010113          	addi	sp,sp,16
    80001310:	00008067          	ret

0000000080001314 <_Z4putcc>:

void putc(char c){
    80001314:	ff010113          	addi	sp,sp,-16
    80001318:	00813423          	sd	s0,8(sp)
    8000131c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_PUTC);
    80001320:	04200793          	li	a5,66
    80001324:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001328:	00000073          	ecall

    8000132c:	00813403          	ld	s0,8(sp)
    80001330:	01010113          	addi	sp,sp,16
    80001334:	00008067          	ret

0000000080001338 <_ZN7_thread13threadWrapperEv>:

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    80001338:	ff010113          	addi	sp,sp,-16
    8000133c:	00113423          	sd	ra,8(sp)
    80001340:	00813023          	sd	s0,0(sp)
    80001344:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    80001348:	00000097          	auipc	ra,0x0
    8000134c:	754080e7          	jalr	1876(ra) # 80001a9c <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) thread_dispatch();
    80001350:	00009797          	auipc	a5,0x9
    80001354:	c207b783          	ld	a5,-992(a5) # 80009f70 <_ZN7_thread7runningE>

    static int exitThread();

    void setStart(bool b);

    bool isStarted() const { return started; }
    80001358:	0297c703          	lbu	a4,41(a5)
    8000135c:	00071863          	bnez	a4,8000136c <_ZN7_thread13threadWrapperEv+0x34>
    80001360:	00000097          	auipc	ra,0x0
    80001364:	eb4080e7          	jalr	-332(ra) # 80001214 <_Z15thread_dispatchv>
    80001368:	fe9ff06f          	j	80001350 <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    8000136c:	0007b703          	ld	a4,0(a5)
    80001370:	0087b503          	ld	a0,8(a5)
    80001374:	000700e7          	jalr	a4
    void setFinished(bool value) { finished = value; }
    80001378:	00009797          	auipc	a5,0x9
    8000137c:	bf87b783          	ld	a5,-1032(a5) # 80009f70 <_ZN7_thread7runningE>
    80001380:	00100713          	li	a4,1
    80001384:	02e78423          	sb	a4,40(a5)
    running->setFinished(true);
    thread_dispatch();
    80001388:	00000097          	auipc	ra,0x0
    8000138c:	e8c080e7          	jalr	-372(ra) # 80001214 <_Z15thread_dispatchv>
}
    80001390:	00813083          	ld	ra,8(sp)
    80001394:	00013403          	ld	s0,0(sp)
    80001398:	01010113          	addi	sp,sp,16
    8000139c:	00008067          	ret

00000000800013a0 <_ZN7_thread12createThreadEPFvPvES0_>:
{
    800013a0:	fd010113          	addi	sp,sp,-48
    800013a4:	02113423          	sd	ra,40(sp)
    800013a8:	02813023          	sd	s0,32(sp)
    800013ac:	00913c23          	sd	s1,24(sp)
    800013b0:	01213823          	sd	s2,16(sp)
    800013b4:	01313423          	sd	s3,8(sp)
    800013b8:	03010413          	addi	s0,sp,48
    800013bc:	00050913          	mv	s2,a0
    800013c0:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    800013c4:	03000513          	li	a0,48
    800013c8:	00000097          	auipc	ra,0x0
    800013cc:	348080e7          	jalr	840(ra) # 80001710 <_Znwm>
    800013d0:	00050493          	mv	s1,a0
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true),
            blocked(false)
    800013d4:	01253023          	sd	s2,0(a0)
    800013d8:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    800013dc:	00090a63          	beqz	s2,800013f0 <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    800013e0:	00008537          	lui	a0,0x8
    800013e4:	00000097          	auipc	ra,0x0
    800013e8:	354080e7          	jalr	852(ra) # 80001738 <_Znam>
    800013ec:	0080006f          	j	800013f4 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    800013f0:	00000513          	li	a0,0
            blocked(false)
    800013f4:	00a4b823          	sd	a0,16(s1)
    800013f8:	00000797          	auipc	a5,0x0
    800013fc:	f4078793          	addi	a5,a5,-192 # 80001338 <_ZN7_thread13threadWrapperEv>
    80001400:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001404:	02050a63          	beqz	a0,80001438 <_ZN7_thread12createThreadEPFvPvES0_+0x98>
    80001408:	000087b7          	lui	a5,0x8
    8000140c:	00f507b3          	add	a5,a0,a5
            blocked(false)
    80001410:	02f4b023          	sd	a5,32(s1)
    80001414:	02048423          	sb	zero,40(s1)
    80001418:	00100793          	li	a5,1
    8000141c:	02f484a3          	sb	a5,41(s1)
    80001420:	02048523          	sb	zero,42(s1)
    {
            if (body != nullptr) { Scheduler::put(this);}
    80001424:	02090c63          	beqz	s2,8000145c <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
    80001428:	00048513          	mv	a0,s1
    8000142c:	00001097          	auipc	ra,0x1
    80001430:	b60080e7          	jalr	-1184(ra) # 80001f8c <_ZN9Scheduler3putEP7_thread>
    80001434:	0280006f          	j	8000145c <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001438:	00000793          	li	a5,0
    8000143c:	fd5ff06f          	j	80001410 <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    80001440:	00050913          	mv	s2,a0
    80001444:	00048513          	mv	a0,s1
    80001448:	00000097          	auipc	ra,0x0
    8000144c:	318080e7          	jalr	792(ra) # 80001760 <_ZdlPv>
    80001450:	00090513          	mv	a0,s2
    80001454:	0000a097          	auipc	ra,0xa
    80001458:	c34080e7          	jalr	-972(ra) # 8000b088 <_Unwind_Resume>
}
    8000145c:	00048513          	mv	a0,s1
    80001460:	02813083          	ld	ra,40(sp)
    80001464:	02013403          	ld	s0,32(sp)
    80001468:	01813483          	ld	s1,24(sp)
    8000146c:	01013903          	ld	s2,16(sp)
    80001470:	00813983          	ld	s3,8(sp)
    80001474:	03010113          	addi	sp,sp,48
    80001478:	00008067          	ret

000000008000147c <_ZN7_thread8dispatchEv>:
{
    8000147c:	fe010113          	addi	sp,sp,-32
    80001480:	00113c23          	sd	ra,24(sp)
    80001484:	00813823          	sd	s0,16(sp)
    80001488:	00913423          	sd	s1,8(sp)
    8000148c:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001490:	00009497          	auipc	s1,0x9
    80001494:	ae04b483          	ld	s1,-1312(s1) # 80009f70 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001498:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    8000149c:	00079663          	bnez	a5,800014a8 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    800014a0:	02a4c783          	lbu	a5,42(s1)
    800014a4:	02078c63          	beqz	a5,800014dc <_ZN7_thread8dispatchEv+0x60>
    running = Scheduler::get();
    800014a8:	00001097          	auipc	ra,0x1
    800014ac:	a7c080e7          	jalr	-1412(ra) # 80001f24 <_ZN9Scheduler3getEv>
    800014b0:	00009797          	auipc	a5,0x9
    800014b4:	aca7b023          	sd	a0,-1344(a5) # 80009f70 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    800014b8:	01850593          	addi	a1,a0,24 # 8018 <_entry-0x7fff7fe8>
    800014bc:	01848513          	addi	a0,s1,24
    800014c0:	00000097          	auipc	ra,0x0
    800014c4:	c70080e7          	jalr	-912(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800014c8:	01813083          	ld	ra,24(sp)
    800014cc:	01013403          	ld	s0,16(sp)
    800014d0:	00813483          	ld	s1,8(sp)
    800014d4:	02010113          	addi	sp,sp,32
    800014d8:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    800014dc:	00048513          	mv	a0,s1
    800014e0:	00001097          	auipc	ra,0x1
    800014e4:	aac080e7          	jalr	-1364(ra) # 80001f8c <_ZN9Scheduler3putEP7_thread>
    800014e8:	fc1ff06f          	j	800014a8 <_ZN7_thread8dispatchEv+0x2c>

00000000800014ec <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014ec:	ff010113          	addi	sp,sp,-16
    800014f0:	00113423          	sd	ra,8(sp)
    800014f4:	00813023          	sd	s0,0(sp)
    800014f8:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    800014fc:	00009797          	auipc	a5,0x9
    80001500:	a747b783          	ld	a5,-1420(a5) # 80009f70 <_ZN7_thread7runningE>
    80001504:	00100713          	li	a4,1
    80001508:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    8000150c:	00000097          	auipc	ra,0x0
    80001510:	d08080e7          	jalr	-760(ra) # 80001214 <_Z15thread_dispatchv>
    return 0;
}
    80001514:	00000513          	li	a0,0
    80001518:	00813083          	ld	ra,8(sp)
    8000151c:	00013403          	ld	s0,0(sp)
    80001520:	01010113          	addi	sp,sp,16
    80001524:	00008067          	ret

0000000080001528 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001528:	ff010113          	addi	sp,sp,-16
    8000152c:	00813423          	sd	s0,8(sp)
    80001530:	01010413          	addi	s0,sp,16
    this->started = b;
    80001534:	02b504a3          	sb	a1,41(a0)
}
    80001538:	00813403          	ld	s0,8(sp)
    8000153c:	01010113          	addi	sp,sp,16
    80001540:	00008067          	ret

0000000080001544 <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    80001544:	ff010113          	addi	sp,sp,-16
    80001548:	00813423          	sd	s0,8(sp)
    8000154c:	01010413          	addi	s0,sp,16
    this->blocked = b;
    80001550:	02b50523          	sb	a1,42(a0)
}
    80001554:	00813403          	ld	s0,8(sp)
    80001558:	01010113          	addi	sp,sp,16
    8000155c:	00008067          	ret

0000000080001560 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001560:	fe010113          	addi	sp,sp,-32
    80001564:	00113c23          	sd	ra,24(sp)
    80001568:	00813823          	sd	s0,16(sp)
    8000156c:	00913423          	sd	s1,8(sp)
    80001570:	01213023          	sd	s2,0(sp)
    80001574:	02010413          	addi	s0,sp,32


    printString("Unesite broj testa? [1-7]\n");
    80001578:	00007517          	auipc	a0,0x7
    8000157c:	a8850513          	addi	a0,a0,-1400 # 80008000 <kvmincrease+0xf10>
    80001580:	00002097          	auipc	ra,0x2
    80001584:	7a0080e7          	jalr	1952(ra) # 80003d20 <_Z11printStringPKc>
    int test = getc() - '0';
    80001588:	00000097          	auipc	ra,0x0
    8000158c:	d60080e7          	jalr	-672(ra) # 800012e8 <_Z4getcv>
    80001590:	00050913          	mv	s2,a0
    80001594:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001598:	00000097          	auipc	ra,0x0
    8000159c:	d50080e7          	jalr	-688(ra) # 800012e8 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800015a0:	fcb9091b          	addiw	s2,s2,-53
    800015a4:	00100793          	li	a5,1
    800015a8:	0327f463          	bgeu	a5,s2,800015d0 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800015ac:	00700793          	li	a5,7
    800015b0:	0e97e263          	bltu	a5,s1,80001694 <_Z8userMainv+0x134>
    800015b4:	00249493          	slli	s1,s1,0x2
    800015b8:	00007717          	auipc	a4,0x7
    800015bc:	c6070713          	addi	a4,a4,-928 # 80008218 <kvmincrease+0x1128>
    800015c0:	00e484b3          	add	s1,s1,a4
    800015c4:	0004a783          	lw	a5,0(s1)
    800015c8:	00e787b3          	add	a5,a5,a4
    800015cc:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015d0:	00007517          	auipc	a0,0x7
    800015d4:	a5050513          	addi	a0,a0,-1456 # 80008020 <kvmincrease+0xf30>
    800015d8:	00002097          	auipc	ra,0x2
    800015dc:	748080e7          	jalr	1864(ra) # 80003d20 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800015e0:	01813083          	ld	ra,24(sp)
    800015e4:	01013403          	ld	s0,16(sp)
    800015e8:	00813483          	ld	s1,8(sp)
    800015ec:	00013903          	ld	s2,0(sp)
    800015f0:	02010113          	addi	sp,sp,32
    800015f4:	00008067          	ret
            Threads_C_API_test();
    800015f8:	00002097          	auipc	ra,0x2
    800015fc:	da0080e7          	jalr	-608(ra) # 80003398 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001600:	00007517          	auipc	a0,0x7
    80001604:	a5050513          	addi	a0,a0,-1456 # 80008050 <kvmincrease+0xf60>
    80001608:	00002097          	auipc	ra,0x2
    8000160c:	718080e7          	jalr	1816(ra) # 80003d20 <_Z11printStringPKc>
            break;
    80001610:	fd1ff06f          	j	800015e0 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001614:	00001097          	auipc	ra,0x1
    80001618:	3e8080e7          	jalr	1000(ra) # 800029fc <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000161c:	00007517          	auipc	a0,0x7
    80001620:	a7450513          	addi	a0,a0,-1420 # 80008090 <kvmincrease+0xfa0>
    80001624:	00002097          	auipc	ra,0x2
    80001628:	6fc080e7          	jalr	1788(ra) # 80003d20 <_Z11printStringPKc>
            break;
    8000162c:	fb5ff06f          	j	800015e0 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001630:	00001097          	auipc	ra,0x1
    80001634:	c20080e7          	jalr	-992(ra) # 80002250 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001638:	00007517          	auipc	a0,0x7
    8000163c:	a9850513          	addi	a0,a0,-1384 # 800080d0 <kvmincrease+0xfe0>
    80001640:	00002097          	auipc	ra,0x2
    80001644:	6e0080e7          	jalr	1760(ra) # 80003d20 <_Z11printStringPKc>
            break;
    80001648:	f99ff06f          	j	800015e0 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    8000164c:	00002097          	auipc	ra,0x2
    80001650:	090080e7          	jalr	144(ra) # 800036dc <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001654:	00007517          	auipc	a0,0x7
    80001658:	acc50513          	addi	a0,a0,-1332 # 80008120 <kvmincrease+0x1030>
    8000165c:	00002097          	auipc	ra,0x2
    80001660:	6c4080e7          	jalr	1732(ra) # 80003d20 <_Z11printStringPKc>
            break;
    80001664:	f7dff06f          	j	800015e0 <_Z8userMainv+0x80>
            System_Mode_test();
    80001668:	00003097          	auipc	ra,0x3
    8000166c:	26c080e7          	jalr	620(ra) # 800048d4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80001670:	00007517          	auipc	a0,0x7
    80001674:	b0850513          	addi	a0,a0,-1272 # 80008178 <kvmincrease+0x1088>
    80001678:	00002097          	auipc	ra,0x2
    8000167c:	6a8080e7          	jalr	1704(ra) # 80003d20 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001680:	00007517          	auipc	a0,0x7
    80001684:	b1850513          	addi	a0,a0,-1256 # 80008198 <kvmincrease+0x10a8>
    80001688:	00002097          	auipc	ra,0x2
    8000168c:	698080e7          	jalr	1688(ra) # 80003d20 <_Z11printStringPKc>
            break;
    80001690:	f51ff06f          	j	800015e0 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001694:	00007517          	auipc	a0,0x7
    80001698:	b5c50513          	addi	a0,a0,-1188 # 800081f0 <kvmincrease+0x1100>
    8000169c:	00002097          	auipc	ra,0x2
    800016a0:	684080e7          	jalr	1668(ra) # 80003d20 <_Z11printStringPKc>
    800016a4:	f3dff06f          	j	800015e0 <_Z8userMainv+0x80>

00000000800016a8 <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    800016a8:	fe010113          	addi	sp,sp,-32
    800016ac:	00113c23          	sd	ra,24(sp)
    800016b0:	00813823          	sd	s0,16(sp)
    800016b4:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800016b8:	00009797          	auipc	a5,0x9
    800016bc:	8587b783          	ld	a5,-1960(a5) # 80009f10 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800016c0:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    800016c4:	00000613          	li	a2,0
    800016c8:	00000593          	li	a1,0
    800016cc:	fe840513          	addi	a0,s0,-24
    800016d0:	00000097          	auipc	ra,0x0
    800016d4:	aec080e7          	jalr	-1300(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    800016d8:	00009797          	auipc	a5,0x9
    800016dc:	8307b783          	ld	a5,-2000(a5) # 80009f08 <_GLOBAL_OFFSET_TABLE_+0x8>
    800016e0:	fe843703          	ld	a4,-24(s0)
    800016e4:	00e7b023          	sd	a4,0(a5)

    //userMode();

    userMain();
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	e78080e7          	jalr	-392(ra) # 80001560 <_Z8userMainv>
    printString("Finished\n");
    800016f0:	00007517          	auipc	a0,0x7
    800016f4:	b4850513          	addi	a0,a0,-1208 # 80008238 <kvmincrease+0x1148>
    800016f8:	00002097          	auipc	ra,0x2
    800016fc:	628080e7          	jalr	1576(ra) # 80003d20 <_Z11printStringPKc>
}
    80001700:	01813083          	ld	ra,24(sp)
    80001704:	01013403          	ld	s0,16(sp)
    80001708:	02010113          	addi	sp,sp,32
    8000170c:	00008067          	ret

0000000080001710 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001710:	ff010113          	addi	sp,sp,-16
    80001714:	00113423          	sd	ra,8(sp)
    80001718:	00813023          	sd	s0,0(sp)
    8000171c:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001720:	00005097          	auipc	ra,0x5
    80001724:	758080e7          	jalr	1880(ra) # 80006e78 <__mem_alloc>
}
    80001728:	00813083          	ld	ra,8(sp)
    8000172c:	00013403          	ld	s0,0(sp)
    80001730:	01010113          	addi	sp,sp,16
    80001734:	00008067          	ret

0000000080001738 <_Znam>:

void *operator new[](size_t n)
{
    80001738:	ff010113          	addi	sp,sp,-16
    8000173c:	00113423          	sd	ra,8(sp)
    80001740:	00813023          	sd	s0,0(sp)
    80001744:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001748:	00005097          	auipc	ra,0x5
    8000174c:	730080e7          	jalr	1840(ra) # 80006e78 <__mem_alloc>
}
    80001750:	00813083          	ld	ra,8(sp)
    80001754:	00013403          	ld	s0,0(sp)
    80001758:	01010113          	addi	sp,sp,16
    8000175c:	00008067          	ret

0000000080001760 <_ZdlPv>:

void operator delete(void *p)
{
    80001760:	ff010113          	addi	sp,sp,-16
    80001764:	00113423          	sd	ra,8(sp)
    80001768:	00813023          	sd	s0,0(sp)
    8000176c:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001770:	00005097          	auipc	ra,0x5
    80001774:	63c080e7          	jalr	1596(ra) # 80006dac <__mem_free>
}
    80001778:	00813083          	ld	ra,8(sp)
    8000177c:	00013403          	ld	s0,0(sp)
    80001780:	01010113          	addi	sp,sp,16
    80001784:	00008067          	ret

0000000080001788 <_ZdaPv>:

void operator delete[](void *p)
{
    80001788:	ff010113          	addi	sp,sp,-16
    8000178c:	00113423          	sd	ra,8(sp)
    80001790:	00813023          	sd	s0,0(sp)
    80001794:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001798:	00005097          	auipc	ra,0x5
    8000179c:	614080e7          	jalr	1556(ra) # 80006dac <__mem_free>
}
    800017a0:	00813083          	ld	ra,8(sp)
    800017a4:	00013403          	ld	s0,0(sp)
    800017a8:	01010113          	addi	sp,sp,16
    800017ac:	00008067          	ret

00000000800017b0 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    800017b0:	ff010113          	addi	sp,sp,-16
    800017b4:	00813423          	sd	s0,8(sp)
    800017b8:	01010413          	addi	s0,sp,16

}
    800017bc:	00813403          	ld	s0,8(sp)
    800017c0:	01010113          	addi	sp,sp,16
    800017c4:	00008067          	ret

00000000800017c8 <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    800017c8:	ff010113          	addi	sp,sp,-16
    800017cc:	00113423          	sd	ra,8(sp)
    800017d0:	00813023          	sd	s0,0(sp)
    800017d4:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    800017d8:	00053783          	ld	a5,0(a0)
    800017dc:	0107b783          	ld	a5,16(a5)
    800017e0:	000780e7          	jalr	a5
}
    800017e4:	00813083          	ld	ra,8(sp)
    800017e8:	00013403          	ld	s0,0(sp)
    800017ec:	01010113          	addi	sp,sp,16
    800017f0:	00008067          	ret

00000000800017f4 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800017f4:	ff010113          	addi	sp,sp,-16
    800017f8:	00113423          	sd	ra,8(sp)
    800017fc:	00813023          	sd	s0,0(sp)
    80001800:	01010413          	addi	s0,sp,16
}
    80001804:	00000097          	auipc	ra,0x0
    80001808:	f5c080e7          	jalr	-164(ra) # 80001760 <_ZdlPv>
    8000180c:	00813083          	ld	ra,8(sp)
    80001810:	00013403          	ld	s0,0(sp)
    80001814:	01010113          	addi	sp,sp,16
    80001818:	00008067          	ret

000000008000181c <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    8000181c:	ff010113          	addi	sp,sp,-16
    80001820:	00113423          	sd	ra,8(sp)
    80001824:	00813023          	sd	s0,0(sp)
    80001828:	01010413          	addi	s0,sp,16
    8000182c:	00008797          	auipc	a5,0x8
    80001830:	59478793          	addi	a5,a5,1428 # 80009dc0 <_ZTV9Semaphore+0x10>
    80001834:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80001838:	00853503          	ld	a0,8(a0)
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	a28080e7          	jalr	-1496(ra) # 80001264 <_Z9sem_closeP4_sem>

}
    80001844:	00813083          	ld	ra,8(sp)
    80001848:	00013403          	ld	s0,0(sp)
    8000184c:	01010113          	addi	sp,sp,16
    80001850:	00008067          	ret

0000000080001854 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001854:	fe010113          	addi	sp,sp,-32
    80001858:	00113c23          	sd	ra,24(sp)
    8000185c:	00813823          	sd	s0,16(sp)
    80001860:	00913423          	sd	s1,8(sp)
    80001864:	02010413          	addi	s0,sp,32
    80001868:	00050493          	mv	s1,a0
}
    8000186c:	00000097          	auipc	ra,0x0
    80001870:	fb0080e7          	jalr	-80(ra) # 8000181c <_ZN9SemaphoreD1Ev>
    80001874:	00048513          	mv	a0,s1
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	ee8080e7          	jalr	-280(ra) # 80001760 <_ZdlPv>
    80001880:	01813083          	ld	ra,24(sp)
    80001884:	01013403          	ld	s0,16(sp)
    80001888:	00813483          	ld	s1,8(sp)
    8000188c:	02010113          	addi	sp,sp,32
    80001890:	00008067          	ret

0000000080001894 <_ZN7Console4getcEv>:
char Console::getc() {
    80001894:	ff010113          	addi	sp,sp,-16
    80001898:	00113423          	sd	ra,8(sp)
    8000189c:	00813023          	sd	s0,0(sp)
    800018a0:	01010413          	addi	s0,sp,16
    return __getc();
    800018a4:	00005097          	auipc	ra,0x5
    800018a8:	768080e7          	jalr	1896(ra) # 8000700c <__getc>
}
    800018ac:	00813083          	ld	ra,8(sp)
    800018b0:	00013403          	ld	s0,0(sp)
    800018b4:	01010113          	addi	sp,sp,16
    800018b8:	00008067          	ret

00000000800018bc <_ZN7Console4putcEc>:
void Console::putc(char c) {
    800018bc:	ff010113          	addi	sp,sp,-16
    800018c0:	00113423          	sd	ra,8(sp)
    800018c4:	00813023          	sd	s0,0(sp)
    800018c8:	01010413          	addi	s0,sp,16
    __putc(c);
    800018cc:	00005097          	auipc	ra,0x5
    800018d0:	704080e7          	jalr	1796(ra) # 80006fd0 <__putc>
}
    800018d4:	00813083          	ld	ra,8(sp)
    800018d8:	00013403          	ld	s0,0(sp)
    800018dc:	01010113          	addi	sp,sp,16
    800018e0:	00008067          	ret

00000000800018e4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800018e4:	fe010113          	addi	sp,sp,-32
    800018e8:	00113c23          	sd	ra,24(sp)
    800018ec:	00813823          	sd	s0,16(sp)
    800018f0:	00913423          	sd	s1,8(sp)
    800018f4:	02010413          	addi	s0,sp,32
    800018f8:	00050493          	mv	s1,a0
    800018fc:	00008797          	auipc	a5,0x8
    80001900:	49c78793          	addi	a5,a5,1180 # 80009d98 <_ZTV6Thread+0x10>
    80001904:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    80001908:	00850513          	addi	a0,a0,8
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	8b0080e7          	jalr	-1872(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001914:	00000593          	li	a1,0
    80001918:	0084b503          	ld	a0,8(s1)
    8000191c:	00000097          	auipc	ra,0x0
    80001920:	c0c080e7          	jalr	-1012(ra) # 80001528 <_ZN7_thread8setStartEb>
}
    80001924:	01813083          	ld	ra,24(sp)
    80001928:	01013403          	ld	s0,16(sp)
    8000192c:	00813483          	ld	s1,8(sp)
    80001930:	02010113          	addi	sp,sp,32
    80001934:	00008067          	ret

0000000080001938 <_ZN6Thread5startEv>:
int Thread::start() {
    80001938:	ff010113          	addi	sp,sp,-16
    8000193c:	00113423          	sd	ra,8(sp)
    80001940:	00813023          	sd	s0,0(sp)
    80001944:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001948:	00100593          	li	a1,1
    8000194c:	00853503          	ld	a0,8(a0)
    80001950:	00000097          	auipc	ra,0x0
    80001954:	bd8080e7          	jalr	-1064(ra) # 80001528 <_ZN7_thread8setStartEb>
}
    80001958:	00000513          	li	a0,0
    8000195c:	00813083          	ld	ra,8(sp)
    80001960:	00013403          	ld	s0,0(sp)
    80001964:	01010113          	addi	sp,sp,16
    80001968:	00008067          	ret

000000008000196c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000196c:	ff010113          	addi	sp,sp,-16
    80001970:	00113423          	sd	ra,8(sp)
    80001974:	00813023          	sd	s0,0(sp)
    80001978:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000197c:	00000097          	auipc	ra,0x0
    80001980:	898080e7          	jalr	-1896(ra) # 80001214 <_Z15thread_dispatchv>
}
    80001984:	00813083          	ld	ra,8(sp)
    80001988:	00013403          	ld	s0,0(sp)
    8000198c:	01010113          	addi	sp,sp,16
    80001990:	00008067          	ret

0000000080001994 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001994:	fe010113          	addi	sp,sp,-32
    80001998:	00113c23          	sd	ra,24(sp)
    8000199c:	00813823          	sd	s0,16(sp)
    800019a0:	00913423          	sd	s1,8(sp)
    800019a4:	02010413          	addi	s0,sp,32
    800019a8:	00050493          	mv	s1,a0
    800019ac:	00008797          	auipc	a5,0x8
    800019b0:	3ec78793          	addi	a5,a5,1004 # 80009d98 <_ZTV6Thread+0x10>
    800019b4:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    800019b8:	00050613          	mv	a2,a0
    800019bc:	00000597          	auipc	a1,0x0
    800019c0:	e0c58593          	addi	a1,a1,-500 # 800017c8 <_ZN6Thread12startWrapperEPv>
    800019c4:	00850513          	addi	a0,a0,8
    800019c8:	fffff097          	auipc	ra,0xfffff
    800019cc:	7f4080e7          	jalr	2036(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800019d0:	00000593          	li	a1,0
    800019d4:	0084b503          	ld	a0,8(s1)
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	b50080e7          	jalr	-1200(ra) # 80001528 <_ZN7_thread8setStartEb>
}
    800019e0:	01813083          	ld	ra,24(sp)
    800019e4:	01013403          	ld	s0,16(sp)
    800019e8:	00813483          	ld	s1,8(sp)
    800019ec:	02010113          	addi	sp,sp,32
    800019f0:	00008067          	ret

00000000800019f4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800019f4:	ff010113          	addi	sp,sp,-16
    800019f8:	00113423          	sd	ra,8(sp)
    800019fc:	00813023          	sd	s0,0(sp)
    80001a00:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001a04:	00853503          	ld	a0,8(a0)
    80001a08:	00000097          	auipc	ra,0x0
    80001a0c:	888080e7          	jalr	-1912(ra) # 80001290 <_Z8sem_waitP4_sem>
}
    80001a10:	00813083          	ld	ra,8(sp)
    80001a14:	00013403          	ld	s0,0(sp)
    80001a18:	01010113          	addi	sp,sp,16
    80001a1c:	00008067          	ret

0000000080001a20 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001a20:	ff010113          	addi	sp,sp,-16
    80001a24:	00113423          	sd	ra,8(sp)
    80001a28:	00813023          	sd	s0,0(sp)
    80001a2c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001a30:	00853503          	ld	a0,8(a0)
    80001a34:	00000097          	auipc	ra,0x0
    80001a38:	888080e7          	jalr	-1912(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    80001a3c:	00813083          	ld	ra,8(sp)
    80001a40:	00013403          	ld	s0,0(sp)
    80001a44:	01010113          	addi	sp,sp,16
    80001a48:	00008067          	ret

0000000080001a4c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001a4c:	ff010113          	addi	sp,sp,-16
    80001a50:	00113423          	sd	ra,8(sp)
    80001a54:	00813023          	sd	s0,0(sp)
    80001a58:	01010413          	addi	s0,sp,16
    80001a5c:	00008797          	auipc	a5,0x8
    80001a60:	36478793          	addi	a5,a5,868 # 80009dc0 <_ZTV9Semaphore+0x10>
    80001a64:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001a68:	00850513          	addi	a0,a0,8
    80001a6c:	fffff097          	auipc	ra,0xfffff
    80001a70:	7cc080e7          	jalr	1996(ra) # 80001238 <_Z8sem_openPP4_semj>
}
    80001a74:	00813083          	ld	ra,8(sp)
    80001a78:	00013403          	ld	s0,0(sp)
    80001a7c:	01010113          	addi	sp,sp,16
    80001a80:	00008067          	ret

0000000080001a84 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001a84:	ff010113          	addi	sp,sp,-16
    80001a88:	00813423          	sd	s0,8(sp)
    80001a8c:	01010413          	addi	s0,sp,16
    80001a90:	00813403          	ld	s0,8(sp)
    80001a94:	01010113          	addi	sp,sp,16
    80001a98:	00008067          	ret

0000000080001a9c <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001a9c:	ff010113          	addi	sp,sp,-16
    80001aa0:	00813423          	sd	s0,8(sp)
    80001aa4:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001aa8:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001aac:	10200073          	sret

}
    80001ab0:	00813403          	ld	s0,8(sp)
    80001ab4:	01010113          	addi	sp,sp,16
    80001ab8:	00008067          	ret

0000000080001abc <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001abc:	fb010113          	addi	sp,sp,-80
    80001ac0:	04113423          	sd	ra,72(sp)
    80001ac4:	04813023          	sd	s0,64(sp)
    80001ac8:	02913c23          	sd	s1,56(sp)
    80001acc:	03213823          	sd	s2,48(sp)
    80001ad0:	03313423          	sd	s3,40(sp)
    80001ad4:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001ad8:	142027f3          	csrr	a5,scause
    80001adc:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80001ae0:	fb843483          	ld	s1,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001ae4:	fff00793          	li	a5,-1
    80001ae8:	03f79793          	slli	a5,a5,0x3f
    80001aec:	00178793          	addi	a5,a5,1
    80001af0:	18f48463          	beq	s1,a5,80001c78 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
    80001af4:	fff00793          	li	a5,-1
    80001af8:	03f79793          	slli	a5,a5,0x3f
    80001afc:	00178793          	addi	a5,a5,1
    80001b00:	0497ea63          	bltu	a5,s1,80001b54 <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    80001b04:	ff848793          	addi	a5,s1,-8
    80001b08:	00100713          	li	a4,1
    80001b0c:	18f76863          	bltu	a4,a5,80001c9c <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001b10:	141027f3          	csrr	a5,sepc
    80001b14:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80001b18:	fc843783          	ld	a5,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    80001b1c:	00478493          	addi	s1,a5,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001b20:	100027f3          	csrr	a5,sstatus
    80001b24:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    80001b28:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001b2c:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001b30:	04200713          	li	a4,66
    80001b34:	06f76063          	bltu	a4,a5,80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
    80001b38:	00279793          	slli	a5,a5,0x2
    80001b3c:	00006717          	auipc	a4,0x6
    80001b40:	71870713          	addi	a4,a4,1816 # 80008254 <kvmincrease+0x1164>
    80001b44:	00e787b3          	add	a5,a5,a4
    80001b48:	0007a783          	lw	a5,0(a5)
    80001b4c:	00e787b3          	add	a5,a5,a4
    80001b50:	00078067          	jr	a5
    switch((uint64)scause){
    80001b54:	fff00793          	li	a5,-1
    80001b58:	03f79793          	slli	a5,a5,0x3f
    80001b5c:	00978793          	addi	a5,a5,9
    80001b60:	12f49e63          	bne	s1,a5,80001c9c <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001b64:	00005097          	auipc	ra,0x5
    80001b68:	4e0080e7          	jalr	1248(ra) # 80007044 <console_handler>
            break;
    80001b6c:	1140006f          	j	80001c80 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001b70:	10000793          	li	a5,256
    80001b74:	1007b073          	csrc	sstatus,a5
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001b78:	00200793          	li	a5,2
    80001b7c:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001b80:	14149073          	csrw	sepc,s1
}
    80001b84:	0fc0006f          	j	80001c80 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
                    READ_REG(size, "a0");
    80001b88:	00050513          	mv	a0,a0
                    __mem_alloc(size);
    80001b8c:	00005097          	auipc	ra,0x5
    80001b90:	2ec080e7          	jalr	748(ra) # 80006e78 <__mem_alloc>
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001b94:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001b98:	14149073          	csrw	sepc,s1
}
    80001b9c:	0e40006f          	j	80001c80 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
                    READ_REG(ptr, "a0");
    80001ba0:	00050513          	mv	a0,a0
                    __mem_free(ptr);
    80001ba4:	00005097          	auipc	ra,0x5
    80001ba8:	208080e7          	jalr	520(ra) # 80006dac <__mem_free>
                    break;
    80001bac:	fe9ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(handle, "a0");
    80001bb0:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001bb4:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001bb8:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001bbc:	fffff097          	auipc	ra,0xfffff
    80001bc0:	7e4080e7          	jalr	2020(ra) # 800013a0 <_ZN7_thread12createThreadEPFvPvES0_>
    80001bc4:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001bc8:	00050863          	beqz	a0,80001bd8 <_ZN5Riscv20handleSupervisorTrapEv+0x11c>
    80001bcc:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001bd0:	00078513          	mv	a0,a5
                    break;
    80001bd4:	fc1ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    else ret = -1;
    80001bd8:	fff00793          	li	a5,-1
    80001bdc:	ff5ff06f          	j	80001bd0 <_ZN5Riscv20handleSupervisorTrapEv+0x114>
                    _thread::exitThread();
    80001be0:	00000097          	auipc	ra,0x0
    80001be4:	90c080e7          	jalr	-1780(ra) # 800014ec <_ZN7_thread10exitThreadEv>
                    break;
    80001be8:	fadff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    _thread::dispatch();
    80001bec:	00000097          	auipc	ra,0x0
    80001bf0:	890080e7          	jalr	-1904(ra) # 8000147c <_ZN7_thread8dispatchEv>
                    break;
    80001bf4:	fa1ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(handle, "a0");
    80001bf8:	00050993          	mv	s3,a0
                    READ_REG(init, "a1");
    80001bfc:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001c00:	0005051b          	sext.w	a0,a0
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	298080e7          	jalr	664(ra) # 80001e9c <_ZN4_sem15createSemaphoreEj>
    80001c0c:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001c10:	00050863          	beqz	a0,80001c20 <_ZN5Riscv20handleSupervisorTrapEv+0x164>
    80001c14:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001c18:	00078513          	mv	a0,a5
                    break;
    80001c1c:	f79ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    else ret = -1;
    80001c20:	fff00793          	li	a5,-1
    80001c24:	ff5ff06f          	j	80001c18 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>
                    READ_REG(handleClose, "a0");
    80001c28:	00050513          	mv	a0,a0
                    handleClose->close();
    80001c2c:	00000097          	auipc	ra,0x0
    80001c30:	1d8080e7          	jalr	472(ra) # 80001e04 <_ZN4_sem5closeEv>
                    break;
    80001c34:	f61ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(idWait, "a0");
    80001c38:	00050513          	mv	a0,a0
                    idWait->wait();
    80001c3c:	00000097          	auipc	ra,0x0
    80001c40:	090080e7          	jalr	144(ra) # 80001ccc <_ZN4_sem4waitEv>
                    break;
    80001c44:	f51ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(idSignal, "a0");
    80001c48:	00050513          	mv	a0,a0
                    idSignal->signal();
    80001c4c:	00000097          	auipc	ra,0x0
    80001c50:	124080e7          	jalr	292(ra) # 80001d70 <_ZN4_sem6signalEv>
                    break;
    80001c54:	f41ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    __getc();
    80001c58:	00005097          	auipc	ra,0x5
    80001c5c:	3b4080e7          	jalr	948(ra) # 8000700c <__getc>
                    break;
    80001c60:	f35ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(c, "a0");
    80001c64:	00050513          	mv	a0,a0
                    __putc(c);
    80001c68:	0ff57513          	andi	a0,a0,255
    80001c6c:	00005097          	auipc	ra,0x5
    80001c70:	364080e7          	jalr	868(ra) # 80006fd0 <__putc>
                    break;
    80001c74:	f21ff06f          	j	80001b94 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001c78:	00200793          	li	a5,2
    80001c7c:	1447b073          	csrc	sip,a5
            printString("\nScause: ");
            printInt(scause);
            thread_exit();
            break;
    }
    80001c80:	04813083          	ld	ra,72(sp)
    80001c84:	04013403          	ld	s0,64(sp)
    80001c88:	03813483          	ld	s1,56(sp)
    80001c8c:	03013903          	ld	s2,48(sp)
    80001c90:	02813983          	ld	s3,40(sp)
    80001c94:	05010113          	addi	sp,sp,80
    80001c98:	00008067          	ret
            printString("\nScause: ");
    80001c9c:	00006517          	auipc	a0,0x6
    80001ca0:	5ac50513          	addi	a0,a0,1452 # 80008248 <kvmincrease+0x1158>
    80001ca4:	00002097          	auipc	ra,0x2
    80001ca8:	07c080e7          	jalr	124(ra) # 80003d20 <_Z11printStringPKc>
            printInt(scause);
    80001cac:	00000613          	li	a2,0
    80001cb0:	00a00593          	li	a1,10
    80001cb4:	0004851b          	sext.w	a0,s1
    80001cb8:	00002097          	auipc	ra,0x2
    80001cbc:	218080e7          	jalr	536(ra) # 80003ed0 <_Z8printIntiii>
            thread_exit();
    80001cc0:	fffff097          	auipc	ra,0xfffff
    80001cc4:	528080e7          	jalr	1320(ra) # 800011e8 <_Z11thread_exitv>
            break;
    80001cc8:	fb9ff06f          	j	80001c80 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>

0000000080001ccc <_ZN4_sem4waitEv>:
//

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    80001ccc:	fe010113          	addi	sp,sp,-32
    80001cd0:	00113c23          	sd	ra,24(sp)
    80001cd4:	00813823          	sd	s0,16(sp)
    80001cd8:	00913423          	sd	s1,8(sp)
    80001cdc:	01213023          	sd	s2,0(sp)
    80001ce0:	02010413          	addi	s0,sp,32
    80001ce4:	00050493          	mv	s1,a0
    if (--val < 0){
    80001ce8:	00052783          	lw	a5,0(a0)
    80001cec:	fff7879b          	addiw	a5,a5,-1
    80001cf0:	00f52023          	sw	a5,0(a0)
    80001cf4:	02079713          	slli	a4,a5,0x20
    80001cf8:	02074063          	bltz	a4,80001d18 <_ZN4_sem4waitEv+0x4c>
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
}
    80001cfc:	0044a503          	lw	a0,4(s1)
    80001d00:	01813083          	ld	ra,24(sp)
    80001d04:	01013403          	ld	s0,16(sp)
    80001d08:	00813483          	ld	s1,8(sp)
    80001d0c:	00013903          	ld	s2,0(sp)
    80001d10:	02010113          	addi	sp,sp,32
    80001d14:	00008067          	ret
        _thread* cur = _thread::running;
    80001d18:	00008797          	auipc	a5,0x8
    80001d1c:	1f07b783          	ld	a5,496(a5) # 80009f08 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001d20:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    80001d24:	00100593          	li	a1,1
    80001d28:	00090513          	mv	a0,s2
    80001d2c:	00000097          	auipc	ra,0x0
    80001d30:	818080e7          	jalr	-2024(ra) # 80001544 <_ZN7_thread8setBlockEb>
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001d34:	01000513          	li	a0,16
    80001d38:	00000097          	auipc	ra,0x0
    80001d3c:	9d8080e7          	jalr	-1576(ra) # 80001710 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001d40:	01253023          	sd	s2,0(a0)
    80001d44:	00053423          	sd	zero,8(a0)
        if (tail)
    80001d48:	0104b783          	ld	a5,16(s1)
    80001d4c:	00078c63          	beqz	a5,80001d64 <_ZN4_sem4waitEv+0x98>
        {
            tail->next = elem;
    80001d50:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001d54:	00a4b823          	sd	a0,16(s1)
        thread_dispatch();
    80001d58:	fffff097          	auipc	ra,0xfffff
    80001d5c:	4bc080e7          	jalr	1212(ra) # 80001214 <_Z15thread_dispatchv>
    80001d60:	f9dff06f          	j	80001cfc <_ZN4_sem4waitEv+0x30>
        } else
        {
            head = tail = elem;
    80001d64:	00a4b823          	sd	a0,16(s1)
    80001d68:	00a4b423          	sd	a0,8(s1)
    80001d6c:	fedff06f          	j	80001d58 <_ZN4_sem4waitEv+0x8c>

0000000080001d70 <_ZN4_sem6signalEv>:

int _sem::signal() {
    if(++val <= 0){
    80001d70:	00052703          	lw	a4,0(a0)
    80001d74:	0017071b          	addiw	a4,a4,1
    80001d78:	0007069b          	sext.w	a3,a4
    80001d7c:	00e52023          	sw	a4,0(a0)
    80001d80:	00d05663          	blez	a3,80001d8c <_ZN4_sem6signalEv+0x1c>
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
}
    80001d84:	00000513          	li	a0,0
    80001d88:	00008067          	ret
    80001d8c:	00050793          	mv	a5,a0
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001d90:	00853503          	ld	a0,8(a0)
    80001d94:	fe0508e3          	beqz	a0,80001d84 <_ZN4_sem6signalEv+0x14>
int _sem::signal() {
    80001d98:	fe010113          	addi	sp,sp,-32
    80001d9c:	00113c23          	sd	ra,24(sp)
    80001da0:	00813823          	sd	s0,16(sp)
    80001da4:	00913423          	sd	s1,8(sp)
    80001da8:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    80001dac:	00853703          	ld	a4,8(a0)
    80001db0:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001db4:	04070463          	beqz	a4,80001dfc <_ZN4_sem6signalEv+0x8c>

        T *ret = elem->data;
    80001db8:	00053483          	ld	s1,0(a0)
        delete elem;
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	9a4080e7          	jalr	-1628(ra) # 80001760 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80001dc4:	02048063          	beqz	s1,80001de4 <_ZN4_sem6signalEv+0x74>
            cur->setBlock(false);
    80001dc8:	00000593          	li	a1,0
    80001dcc:	00048513          	mv	a0,s1
    80001dd0:	fffff097          	auipc	ra,0xfffff
    80001dd4:	774080e7          	jalr	1908(ra) # 80001544 <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80001dd8:	00048513          	mv	a0,s1
    80001ddc:	00000097          	auipc	ra,0x0
    80001de0:	1b0080e7          	jalr	432(ra) # 80001f8c <_ZN9Scheduler3putEP7_thread>
}
    80001de4:	00000513          	li	a0,0
    80001de8:	01813083          	ld	ra,24(sp)
    80001dec:	01013403          	ld	s0,16(sp)
    80001df0:	00813483          	ld	s1,8(sp)
    80001df4:	02010113          	addi	sp,sp,32
    80001df8:	00008067          	ret
        if (!head) { tail = 0; }
    80001dfc:	0007b823          	sd	zero,16(a5)
    80001e00:	fb9ff06f          	j	80001db8 <_ZN4_sem6signalEv+0x48>

0000000080001e04 <_ZN4_sem5closeEv>:

int _sem::close() {
    80001e04:	fe010113          	addi	sp,sp,-32
    80001e08:	00113c23          	sd	ra,24(sp)
    80001e0c:	00813823          	sd	s0,16(sp)
    80001e10:	00913423          	sd	s1,8(sp)
    80001e14:	01213023          	sd	s2,0(sp)
    80001e18:	02010413          	addi	s0,sp,32
    80001e1c:	00050913          	mv	s2,a0
    int wait();
    int signal();
    int close();

    int value() const { return val; }
    void setWaitStatus(int s) { waitStatus = s;}
    80001e20:	fff00793          	li	a5,-1
    80001e24:	00f52223          	sw	a5,4(a0)
    80001e28:	0340006f          	j	80001e5c <_ZN4_sem5closeEv+0x58>
    80001e2c:	00093823          	sd	zero,16(s2)
        T *ret = elem->data;
    80001e30:	00053483          	ld	s1,0(a0)
        delete elem;
    80001e34:	00000097          	auipc	ra,0x0
    80001e38:	92c080e7          	jalr	-1748(ra) # 80001760 <_ZdlPv>
    this->setWaitStatus(-1);
    while(_thread* cur = blocked.removeFirst()){
    80001e3c:	02048c63          	beqz	s1,80001e74 <_ZN4_sem5closeEv+0x70>
        cur->setBlock(false);
    80001e40:	00000593          	li	a1,0
    80001e44:	00048513          	mv	a0,s1
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	6fc080e7          	jalr	1788(ra) # 80001544 <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    80001e50:	00048513          	mv	a0,s1
    80001e54:	00000097          	auipc	ra,0x0
    80001e58:	138080e7          	jalr	312(ra) # 80001f8c <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80001e5c:	00893503          	ld	a0,8(s2)
    80001e60:	00050a63          	beqz	a0,80001e74 <_ZN4_sem5closeEv+0x70>
        head = head->next;
    80001e64:	00853783          	ld	a5,8(a0)
    80001e68:	00f93423          	sd	a5,8(s2)
        if (!head) { tail = 0; }
    80001e6c:	fc0792e3          	bnez	a5,80001e30 <_ZN4_sem5closeEv+0x2c>
    80001e70:	fbdff06f          	j	80001e2c <_ZN4_sem5closeEv+0x28>
    }
    delete this;
    80001e74:	00090513          	mv	a0,s2
    80001e78:	00000097          	auipc	ra,0x0
    80001e7c:	8e8080e7          	jalr	-1816(ra) # 80001760 <_ZdlPv>
    return 0;
}
    80001e80:	00000513          	li	a0,0
    80001e84:	01813083          	ld	ra,24(sp)
    80001e88:	01013403          	ld	s0,16(sp)
    80001e8c:	00813483          	ld	s1,8(sp)
    80001e90:	00013903          	ld	s2,0(sp)
    80001e94:	02010113          	addi	sp,sp,32
    80001e98:	00008067          	ret

0000000080001e9c <_ZN4_sem15createSemaphoreEj>:

_sem* _sem::createSemaphore(uint32 init) {
    80001e9c:	fe010113          	addi	sp,sp,-32
    80001ea0:	00113c23          	sd	ra,24(sp)
    80001ea4:	00813823          	sd	s0,16(sp)
    80001ea8:	00913423          	sd	s1,8(sp)
    80001eac:	02010413          	addi	s0,sp,32
    80001eb0:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    80001eb4:	01800513          	li	a0,24
    80001eb8:	00000097          	auipc	ra,0x0
    80001ebc:	858080e7          	jalr	-1960(ra) # 80001710 <_Znwm>
    _sem(uint32 init = 1) : val(init), waitStatus(0) {}
    80001ec0:	00952023          	sw	s1,0(a0)
    80001ec4:	00052223          	sw	zero,4(a0)
    List() : head(0), tail(0) {}
    80001ec8:	00053423          	sd	zero,8(a0)
    80001ecc:	00053823          	sd	zero,16(a0)
    return newSemaphore;
}
    80001ed0:	01813083          	ld	ra,24(sp)
    80001ed4:	01013403          	ld	s0,16(sp)
    80001ed8:	00813483          	ld	s1,8(sp)
    80001edc:	02010113          	addi	sp,sp,32
    80001ee0:	00008067          	ret

0000000080001ee4 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001ee4:	ff010113          	addi	sp,sp,-16
    80001ee8:	00813423          	sd	s0,8(sp)
    80001eec:	01010413          	addi	s0,sp,16
    80001ef0:	00100793          	li	a5,1
    80001ef4:	00f50863          	beq	a0,a5,80001f04 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001ef8:	00813403          	ld	s0,8(sp)
    80001efc:	01010113          	addi	sp,sp,16
    80001f00:	00008067          	ret
    80001f04:	000107b7          	lui	a5,0x10
    80001f08:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001f0c:	fef596e3          	bne	a1,a5,80001ef8 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001f10:	00008797          	auipc	a5,0x8
    80001f14:	06878793          	addi	a5,a5,104 # 80009f78 <_ZN9Scheduler16readyThreadQueueE>
    80001f18:	0007b023          	sd	zero,0(a5)
    80001f1c:	0007b423          	sd	zero,8(a5)
    80001f20:	fd9ff06f          	j	80001ef8 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001f24 <_ZN9Scheduler3getEv>:
{
    80001f24:	fe010113          	addi	sp,sp,-32
    80001f28:	00113c23          	sd	ra,24(sp)
    80001f2c:	00813823          	sd	s0,16(sp)
    80001f30:	00913423          	sd	s1,8(sp)
    80001f34:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001f38:	00008517          	auipc	a0,0x8
    80001f3c:	04053503          	ld	a0,64(a0) # 80009f78 <_ZN9Scheduler16readyThreadQueueE>
    80001f40:	04050263          	beqz	a0,80001f84 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001f44:	00853783          	ld	a5,8(a0)
    80001f48:	00008717          	auipc	a4,0x8
    80001f4c:	02f73823          	sd	a5,48(a4) # 80009f78 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001f50:	02078463          	beqz	a5,80001f78 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001f54:	00053483          	ld	s1,0(a0)
        delete elem;
    80001f58:	00000097          	auipc	ra,0x0
    80001f5c:	808080e7          	jalr	-2040(ra) # 80001760 <_ZdlPv>
}
    80001f60:	00048513          	mv	a0,s1
    80001f64:	01813083          	ld	ra,24(sp)
    80001f68:	01013403          	ld	s0,16(sp)
    80001f6c:	00813483          	ld	s1,8(sp)
    80001f70:	02010113          	addi	sp,sp,32
    80001f74:	00008067          	ret
        if (!head) { tail = 0; }
    80001f78:	00008797          	auipc	a5,0x8
    80001f7c:	0007b423          	sd	zero,8(a5) # 80009f80 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001f80:	fd5ff06f          	j	80001f54 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001f84:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001f88:	fd9ff06f          	j	80001f60 <_ZN9Scheduler3getEv+0x3c>

0000000080001f8c <_ZN9Scheduler3putEP7_thread>:
{
    80001f8c:	fe010113          	addi	sp,sp,-32
    80001f90:	00113c23          	sd	ra,24(sp)
    80001f94:	00813823          	sd	s0,16(sp)
    80001f98:	00913423          	sd	s1,8(sp)
    80001f9c:	02010413          	addi	s0,sp,32
    80001fa0:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001fa4:	01000513          	li	a0,16
    80001fa8:	fffff097          	auipc	ra,0xfffff
    80001fac:	768080e7          	jalr	1896(ra) # 80001710 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001fb0:	00953023          	sd	s1,0(a0)
    80001fb4:	00053423          	sd	zero,8(a0)
        if (tail)
    80001fb8:	00008797          	auipc	a5,0x8
    80001fbc:	fc87b783          	ld	a5,-56(a5) # 80009f80 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001fc0:	02078263          	beqz	a5,80001fe4 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80001fc4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001fc8:	00008797          	auipc	a5,0x8
    80001fcc:	faa7bc23          	sd	a0,-72(a5) # 80009f80 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001fd0:	01813083          	ld	ra,24(sp)
    80001fd4:	01013403          	ld	s0,16(sp)
    80001fd8:	00813483          	ld	s1,8(sp)
    80001fdc:	02010113          	addi	sp,sp,32
    80001fe0:	00008067          	ret
            head = tail = elem;
    80001fe4:	00008797          	auipc	a5,0x8
    80001fe8:	f9478793          	addi	a5,a5,-108 # 80009f78 <_ZN9Scheduler16readyThreadQueueE>
    80001fec:	00a7b423          	sd	a0,8(a5)
    80001ff0:	00a7b023          	sd	a0,0(a5)
    80001ff4:	fddff06f          	j	80001fd0 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080001ff8 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80001ff8:	ff010113          	addi	sp,sp,-16
    80001ffc:	00113423          	sd	ra,8(sp)
    80002000:	00813023          	sd	s0,0(sp)
    80002004:	01010413          	addi	s0,sp,16
    80002008:	000105b7          	lui	a1,0x10
    8000200c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002010:	00100513          	li	a0,1
    80002014:	00000097          	auipc	ra,0x0
    80002018:	ed0080e7          	jalr	-304(ra) # 80001ee4 <_Z41__static_initialization_and_destruction_0ii>
    8000201c:	00813083          	ld	ra,8(sp)
    80002020:	00013403          	ld	s0,0(sp)
    80002024:	01010113          	addi	sp,sp,16
    80002028:	00008067          	ret

000000008000202c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    8000202c:	fe010113          	addi	sp,sp,-32
    80002030:	00113c23          	sd	ra,24(sp)
    80002034:	00813823          	sd	s0,16(sp)
    80002038:	00913423          	sd	s1,8(sp)
    8000203c:	01213023          	sd	s2,0(sp)
    80002040:	02010413          	addi	s0,sp,32
    80002044:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002048:	00000913          	li	s2,0
    8000204c:	00c0006f          	j	80002058 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002050:	fffff097          	auipc	ra,0xfffff
    80002054:	1c4080e7          	jalr	452(ra) # 80001214 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002058:	fffff097          	auipc	ra,0xfffff
    8000205c:	290080e7          	jalr	656(ra) # 800012e8 <_Z4getcv>
    80002060:	0005059b          	sext.w	a1,a0
    80002064:	01b00793          	li	a5,27
    80002068:	02f58a63          	beq	a1,a5,8000209c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    8000206c:	0084b503          	ld	a0,8(s1)
    80002070:	00003097          	auipc	ra,0x3
    80002074:	9fc080e7          	jalr	-1540(ra) # 80004a6c <_ZN6Buffer3putEi>
        i++;
    80002078:	0019071b          	addiw	a4,s2,1
    8000207c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002080:	0004a683          	lw	a3,0(s1)
    80002084:	0026979b          	slliw	a5,a3,0x2
    80002088:	00d787bb          	addw	a5,a5,a3
    8000208c:	0017979b          	slliw	a5,a5,0x1
    80002090:	02f767bb          	remw	a5,a4,a5
    80002094:	fc0792e3          	bnez	a5,80002058 <_ZL16producerKeyboardPv+0x2c>
    80002098:	fb9ff06f          	j	80002050 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000209c:	00100793          	li	a5,1
    800020a0:	00008717          	auipc	a4,0x8
    800020a4:	eef72423          	sw	a5,-280(a4) # 80009f88 <_ZL9threadEnd>
    data->buffer->put('!');
    800020a8:	02100593          	li	a1,33
    800020ac:	0084b503          	ld	a0,8(s1)
    800020b0:	00003097          	auipc	ra,0x3
    800020b4:	9bc080e7          	jalr	-1604(ra) # 80004a6c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800020b8:	0104b503          	ld	a0,16(s1)
    800020bc:	fffff097          	auipc	ra,0xfffff
    800020c0:	200080e7          	jalr	512(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    800020c4:	01813083          	ld	ra,24(sp)
    800020c8:	01013403          	ld	s0,16(sp)
    800020cc:	00813483          	ld	s1,8(sp)
    800020d0:	00013903          	ld	s2,0(sp)
    800020d4:	02010113          	addi	sp,sp,32
    800020d8:	00008067          	ret

00000000800020dc <_ZL8producerPv>:

static void producer(void *arg) {
    800020dc:	fe010113          	addi	sp,sp,-32
    800020e0:	00113c23          	sd	ra,24(sp)
    800020e4:	00813823          	sd	s0,16(sp)
    800020e8:	00913423          	sd	s1,8(sp)
    800020ec:	01213023          	sd	s2,0(sp)
    800020f0:	02010413          	addi	s0,sp,32
    800020f4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800020f8:	00000913          	li	s2,0
    800020fc:	00c0006f          	j	80002108 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002100:	fffff097          	auipc	ra,0xfffff
    80002104:	114080e7          	jalr	276(ra) # 80001214 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002108:	00008797          	auipc	a5,0x8
    8000210c:	e807a783          	lw	a5,-384(a5) # 80009f88 <_ZL9threadEnd>
    80002110:	02079e63          	bnez	a5,8000214c <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002114:	0004a583          	lw	a1,0(s1)
    80002118:	0305859b          	addiw	a1,a1,48
    8000211c:	0084b503          	ld	a0,8(s1)
    80002120:	00003097          	auipc	ra,0x3
    80002124:	94c080e7          	jalr	-1716(ra) # 80004a6c <_ZN6Buffer3putEi>
        i++;
    80002128:	0019071b          	addiw	a4,s2,1
    8000212c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002130:	0004a683          	lw	a3,0(s1)
    80002134:	0026979b          	slliw	a5,a3,0x2
    80002138:	00d787bb          	addw	a5,a5,a3
    8000213c:	0017979b          	slliw	a5,a5,0x1
    80002140:	02f767bb          	remw	a5,a4,a5
    80002144:	fc0792e3          	bnez	a5,80002108 <_ZL8producerPv+0x2c>
    80002148:	fb9ff06f          	j	80002100 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    8000214c:	0104b503          	ld	a0,16(s1)
    80002150:	fffff097          	auipc	ra,0xfffff
    80002154:	16c080e7          	jalr	364(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    80002158:	01813083          	ld	ra,24(sp)
    8000215c:	01013403          	ld	s0,16(sp)
    80002160:	00813483          	ld	s1,8(sp)
    80002164:	00013903          	ld	s2,0(sp)
    80002168:	02010113          	addi	sp,sp,32
    8000216c:	00008067          	ret

0000000080002170 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002170:	fd010113          	addi	sp,sp,-48
    80002174:	02113423          	sd	ra,40(sp)
    80002178:	02813023          	sd	s0,32(sp)
    8000217c:	00913c23          	sd	s1,24(sp)
    80002180:	01213823          	sd	s2,16(sp)
    80002184:	01313423          	sd	s3,8(sp)
    80002188:	03010413          	addi	s0,sp,48
    8000218c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002190:	00000993          	li	s3,0
    80002194:	01c0006f          	j	800021b0 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002198:	fffff097          	auipc	ra,0xfffff
    8000219c:	07c080e7          	jalr	124(ra) # 80001214 <_Z15thread_dispatchv>
    800021a0:	0500006f          	j	800021f0 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800021a4:	00a00513          	li	a0,10
    800021a8:	fffff097          	auipc	ra,0xfffff
    800021ac:	16c080e7          	jalr	364(ra) # 80001314 <_Z4putcc>
    while (!threadEnd) {
    800021b0:	00008797          	auipc	a5,0x8
    800021b4:	dd87a783          	lw	a5,-552(a5) # 80009f88 <_ZL9threadEnd>
    800021b8:	06079063          	bnez	a5,80002218 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800021bc:	00893503          	ld	a0,8(s2)
    800021c0:	00003097          	auipc	ra,0x3
    800021c4:	93c080e7          	jalr	-1732(ra) # 80004afc <_ZN6Buffer3getEv>
        i++;
    800021c8:	0019849b          	addiw	s1,s3,1
    800021cc:	0004899b          	sext.w	s3,s1
        putc(key);
    800021d0:	0ff57513          	andi	a0,a0,255
    800021d4:	fffff097          	auipc	ra,0xfffff
    800021d8:	140080e7          	jalr	320(ra) # 80001314 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800021dc:	00092703          	lw	a4,0(s2)
    800021e0:	0027179b          	slliw	a5,a4,0x2
    800021e4:	00e787bb          	addw	a5,a5,a4
    800021e8:	02f4e7bb          	remw	a5,s1,a5
    800021ec:	fa0786e3          	beqz	a5,80002198 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800021f0:	05000793          	li	a5,80
    800021f4:	02f4e4bb          	remw	s1,s1,a5
    800021f8:	fa049ce3          	bnez	s1,800021b0 <_ZL8consumerPv+0x40>
    800021fc:	fa9ff06f          	j	800021a4 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002200:	00893503          	ld	a0,8(s2)
    80002204:	00003097          	auipc	ra,0x3
    80002208:	8f8080e7          	jalr	-1800(ra) # 80004afc <_ZN6Buffer3getEv>
        putc(key);
    8000220c:	0ff57513          	andi	a0,a0,255
    80002210:	fffff097          	auipc	ra,0xfffff
    80002214:	104080e7          	jalr	260(ra) # 80001314 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002218:	00893503          	ld	a0,8(s2)
    8000221c:	00003097          	auipc	ra,0x3
    80002220:	96c080e7          	jalr	-1684(ra) # 80004b88 <_ZN6Buffer6getCntEv>
    80002224:	fca04ee3          	bgtz	a0,80002200 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002228:	01093503          	ld	a0,16(s2)
    8000222c:	fffff097          	auipc	ra,0xfffff
    80002230:	090080e7          	jalr	144(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    80002234:	02813083          	ld	ra,40(sp)
    80002238:	02013403          	ld	s0,32(sp)
    8000223c:	01813483          	ld	s1,24(sp)
    80002240:	01013903          	ld	s2,16(sp)
    80002244:	00813983          	ld	s3,8(sp)
    80002248:	03010113          	addi	sp,sp,48
    8000224c:	00008067          	ret

0000000080002250 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002250:	f9010113          	addi	sp,sp,-112
    80002254:	06113423          	sd	ra,104(sp)
    80002258:	06813023          	sd	s0,96(sp)
    8000225c:	04913c23          	sd	s1,88(sp)
    80002260:	05213823          	sd	s2,80(sp)
    80002264:	05313423          	sd	s3,72(sp)
    80002268:	05413023          	sd	s4,64(sp)
    8000226c:	03513c23          	sd	s5,56(sp)
    80002270:	03613823          	sd	s6,48(sp)
    80002274:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002278:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    8000227c:	00006517          	auipc	a0,0x6
    80002280:	0e450513          	addi	a0,a0,228 # 80008360 <kvmincrease+0x1270>
    80002284:	00002097          	auipc	ra,0x2
    80002288:	a9c080e7          	jalr	-1380(ra) # 80003d20 <_Z11printStringPKc>
    getString(input, 30);
    8000228c:	01e00593          	li	a1,30
    80002290:	fa040493          	addi	s1,s0,-96
    80002294:	00048513          	mv	a0,s1
    80002298:	00002097          	auipc	ra,0x2
    8000229c:	b10080e7          	jalr	-1264(ra) # 80003da8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800022a0:	00048513          	mv	a0,s1
    800022a4:	00002097          	auipc	ra,0x2
    800022a8:	bdc080e7          	jalr	-1060(ra) # 80003e80 <_Z11stringToIntPKc>
    800022ac:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800022b0:	00006517          	auipc	a0,0x6
    800022b4:	0d050513          	addi	a0,a0,208 # 80008380 <kvmincrease+0x1290>
    800022b8:	00002097          	auipc	ra,0x2
    800022bc:	a68080e7          	jalr	-1432(ra) # 80003d20 <_Z11printStringPKc>
    getString(input, 30);
    800022c0:	01e00593          	li	a1,30
    800022c4:	00048513          	mv	a0,s1
    800022c8:	00002097          	auipc	ra,0x2
    800022cc:	ae0080e7          	jalr	-1312(ra) # 80003da8 <_Z9getStringPci>
    n = stringToInt(input);
    800022d0:	00048513          	mv	a0,s1
    800022d4:	00002097          	auipc	ra,0x2
    800022d8:	bac080e7          	jalr	-1108(ra) # 80003e80 <_Z11stringToIntPKc>
    800022dc:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800022e0:	00006517          	auipc	a0,0x6
    800022e4:	0c050513          	addi	a0,a0,192 # 800083a0 <kvmincrease+0x12b0>
    800022e8:	00002097          	auipc	ra,0x2
    800022ec:	a38080e7          	jalr	-1480(ra) # 80003d20 <_Z11printStringPKc>
    800022f0:	00000613          	li	a2,0
    800022f4:	00a00593          	li	a1,10
    800022f8:	00090513          	mv	a0,s2
    800022fc:	00002097          	auipc	ra,0x2
    80002300:	bd4080e7          	jalr	-1068(ra) # 80003ed0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002304:	00006517          	auipc	a0,0x6
    80002308:	0b450513          	addi	a0,a0,180 # 800083b8 <kvmincrease+0x12c8>
    8000230c:	00002097          	auipc	ra,0x2
    80002310:	a14080e7          	jalr	-1516(ra) # 80003d20 <_Z11printStringPKc>
    80002314:	00000613          	li	a2,0
    80002318:	00a00593          	li	a1,10
    8000231c:	00048513          	mv	a0,s1
    80002320:	00002097          	auipc	ra,0x2
    80002324:	bb0080e7          	jalr	-1104(ra) # 80003ed0 <_Z8printIntiii>
    printString(".\n");
    80002328:	00006517          	auipc	a0,0x6
    8000232c:	0a850513          	addi	a0,a0,168 # 800083d0 <kvmincrease+0x12e0>
    80002330:	00002097          	auipc	ra,0x2
    80002334:	9f0080e7          	jalr	-1552(ra) # 80003d20 <_Z11printStringPKc>
    if(threadNum > n) {
    80002338:	0324c463          	blt	s1,s2,80002360 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    8000233c:	03205c63          	blez	s2,80002374 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002340:	03800513          	li	a0,56
    80002344:	fffff097          	auipc	ra,0xfffff
    80002348:	3cc080e7          	jalr	972(ra) # 80001710 <_Znwm>
    8000234c:	00050a13          	mv	s4,a0
    80002350:	00048593          	mv	a1,s1
    80002354:	00002097          	auipc	ra,0x2
    80002358:	67c080e7          	jalr	1660(ra) # 800049d0 <_ZN6BufferC1Ei>
    8000235c:	0300006f          	j	8000238c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002360:	00006517          	auipc	a0,0x6
    80002364:	07850513          	addi	a0,a0,120 # 800083d8 <kvmincrease+0x12e8>
    80002368:	00002097          	auipc	ra,0x2
    8000236c:	9b8080e7          	jalr	-1608(ra) # 80003d20 <_Z11printStringPKc>
        return;
    80002370:	0140006f          	j	80002384 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002374:	00006517          	auipc	a0,0x6
    80002378:	0a450513          	addi	a0,a0,164 # 80008418 <kvmincrease+0x1328>
    8000237c:	00002097          	auipc	ra,0x2
    80002380:	9a4080e7          	jalr	-1628(ra) # 80003d20 <_Z11printStringPKc>
        return;
    80002384:	000b0113          	mv	sp,s6
    80002388:	1500006f          	j	800024d8 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    8000238c:	00000593          	li	a1,0
    80002390:	00008517          	auipc	a0,0x8
    80002394:	c0050513          	addi	a0,a0,-1024 # 80009f90 <_ZL10waitForAll>
    80002398:	fffff097          	auipc	ra,0xfffff
    8000239c:	ea0080e7          	jalr	-352(ra) # 80001238 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800023a0:	00391793          	slli	a5,s2,0x3
    800023a4:	00f78793          	addi	a5,a5,15
    800023a8:	ff07f793          	andi	a5,a5,-16
    800023ac:	40f10133          	sub	sp,sp,a5
    800023b0:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800023b4:	0019071b          	addiw	a4,s2,1
    800023b8:	00171793          	slli	a5,a4,0x1
    800023bc:	00e787b3          	add	a5,a5,a4
    800023c0:	00379793          	slli	a5,a5,0x3
    800023c4:	00f78793          	addi	a5,a5,15
    800023c8:	ff07f793          	andi	a5,a5,-16
    800023cc:	40f10133          	sub	sp,sp,a5
    800023d0:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800023d4:	00191613          	slli	a2,s2,0x1
    800023d8:	012607b3          	add	a5,a2,s2
    800023dc:	00379793          	slli	a5,a5,0x3
    800023e0:	00f987b3          	add	a5,s3,a5
    800023e4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800023e8:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800023ec:	00008717          	auipc	a4,0x8
    800023f0:	ba473703          	ld	a4,-1116(a4) # 80009f90 <_ZL10waitForAll>
    800023f4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800023f8:	00078613          	mv	a2,a5
    800023fc:	00000597          	auipc	a1,0x0
    80002400:	d7458593          	addi	a1,a1,-652 # 80002170 <_ZL8consumerPv>
    80002404:	f9840513          	addi	a0,s0,-104
    80002408:	fffff097          	auipc	ra,0xfffff
    8000240c:	db4080e7          	jalr	-588(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002410:	00000493          	li	s1,0
    80002414:	0280006f          	j	8000243c <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002418:	00000597          	auipc	a1,0x0
    8000241c:	c1458593          	addi	a1,a1,-1004 # 8000202c <_ZL16producerKeyboardPv>
                      data + i);
    80002420:	00179613          	slli	a2,a5,0x1
    80002424:	00f60633          	add	a2,a2,a5
    80002428:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    8000242c:	00c98633          	add	a2,s3,a2
    80002430:	fffff097          	auipc	ra,0xfffff
    80002434:	d8c080e7          	jalr	-628(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002438:	0014849b          	addiw	s1,s1,1
    8000243c:	0524d263          	bge	s1,s2,80002480 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002440:	00149793          	slli	a5,s1,0x1
    80002444:	009787b3          	add	a5,a5,s1
    80002448:	00379793          	slli	a5,a5,0x3
    8000244c:	00f987b3          	add	a5,s3,a5
    80002450:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002454:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002458:	00008717          	auipc	a4,0x8
    8000245c:	b3873703          	ld	a4,-1224(a4) # 80009f90 <_ZL10waitForAll>
    80002460:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002464:	00048793          	mv	a5,s1
    80002468:	00349513          	slli	a0,s1,0x3
    8000246c:	00aa8533          	add	a0,s5,a0
    80002470:	fa9054e3          	blez	s1,80002418 <_Z22producerConsumer_C_APIv+0x1c8>
    80002474:	00000597          	auipc	a1,0x0
    80002478:	c6858593          	addi	a1,a1,-920 # 800020dc <_ZL8producerPv>
    8000247c:	fa5ff06f          	j	80002420 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002480:	fffff097          	auipc	ra,0xfffff
    80002484:	d94080e7          	jalr	-620(ra) # 80001214 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002488:	00000493          	li	s1,0
    8000248c:	00994e63          	blt	s2,s1,800024a8 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002490:	00008517          	auipc	a0,0x8
    80002494:	b0053503          	ld	a0,-1280(a0) # 80009f90 <_ZL10waitForAll>
    80002498:	fffff097          	auipc	ra,0xfffff
    8000249c:	df8080e7          	jalr	-520(ra) # 80001290 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800024a0:	0014849b          	addiw	s1,s1,1
    800024a4:	fe9ff06f          	j	8000248c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800024a8:	00008517          	auipc	a0,0x8
    800024ac:	ae853503          	ld	a0,-1304(a0) # 80009f90 <_ZL10waitForAll>
    800024b0:	fffff097          	auipc	ra,0xfffff
    800024b4:	db4080e7          	jalr	-588(ra) # 80001264 <_Z9sem_closeP4_sem>
    delete buffer;
    800024b8:	000a0e63          	beqz	s4,800024d4 <_Z22producerConsumer_C_APIv+0x284>
    800024bc:	000a0513          	mv	a0,s4
    800024c0:	00002097          	auipc	ra,0x2
    800024c4:	750080e7          	jalr	1872(ra) # 80004c10 <_ZN6BufferD1Ev>
    800024c8:	000a0513          	mv	a0,s4
    800024cc:	fffff097          	auipc	ra,0xfffff
    800024d0:	294080e7          	jalr	660(ra) # 80001760 <_ZdlPv>
    800024d4:	000b0113          	mv	sp,s6

}
    800024d8:	f9040113          	addi	sp,s0,-112
    800024dc:	06813083          	ld	ra,104(sp)
    800024e0:	06013403          	ld	s0,96(sp)
    800024e4:	05813483          	ld	s1,88(sp)
    800024e8:	05013903          	ld	s2,80(sp)
    800024ec:	04813983          	ld	s3,72(sp)
    800024f0:	04013a03          	ld	s4,64(sp)
    800024f4:	03813a83          	ld	s5,56(sp)
    800024f8:	03013b03          	ld	s6,48(sp)
    800024fc:	07010113          	addi	sp,sp,112
    80002500:	00008067          	ret
    80002504:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002508:	000a0513          	mv	a0,s4
    8000250c:	fffff097          	auipc	ra,0xfffff
    80002510:	254080e7          	jalr	596(ra) # 80001760 <_ZdlPv>
    80002514:	00048513          	mv	a0,s1
    80002518:	00009097          	auipc	ra,0x9
    8000251c:	b70080e7          	jalr	-1168(ra) # 8000b088 <_Unwind_Resume>

0000000080002520 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002520:	fe010113          	addi	sp,sp,-32
    80002524:	00113c23          	sd	ra,24(sp)
    80002528:	00813823          	sd	s0,16(sp)
    8000252c:	00913423          	sd	s1,8(sp)
    80002530:	01213023          	sd	s2,0(sp)
    80002534:	02010413          	addi	s0,sp,32
    80002538:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000253c:	00100793          	li	a5,1
    80002540:	02a7f863          	bgeu	a5,a0,80002570 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002544:	00a00793          	li	a5,10
    80002548:	02f577b3          	remu	a5,a0,a5
    8000254c:	02078e63          	beqz	a5,80002588 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002550:	fff48513          	addi	a0,s1,-1
    80002554:	00000097          	auipc	ra,0x0
    80002558:	fcc080e7          	jalr	-52(ra) # 80002520 <_ZL9fibonaccim>
    8000255c:	00050913          	mv	s2,a0
    80002560:	ffe48513          	addi	a0,s1,-2
    80002564:	00000097          	auipc	ra,0x0
    80002568:	fbc080e7          	jalr	-68(ra) # 80002520 <_ZL9fibonaccim>
    8000256c:	00a90533          	add	a0,s2,a0
}
    80002570:	01813083          	ld	ra,24(sp)
    80002574:	01013403          	ld	s0,16(sp)
    80002578:	00813483          	ld	s1,8(sp)
    8000257c:	00013903          	ld	s2,0(sp)
    80002580:	02010113          	addi	sp,sp,32
    80002584:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002588:	fffff097          	auipc	ra,0xfffff
    8000258c:	c8c080e7          	jalr	-884(ra) # 80001214 <_Z15thread_dispatchv>
    80002590:	fc1ff06f          	j	80002550 <_ZL9fibonaccim+0x30>

0000000080002594 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002594:	fe010113          	addi	sp,sp,-32
    80002598:	00113c23          	sd	ra,24(sp)
    8000259c:	00813823          	sd	s0,16(sp)
    800025a0:	00913423          	sd	s1,8(sp)
    800025a4:	01213023          	sd	s2,0(sp)
    800025a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800025ac:	00000913          	li	s2,0
    800025b0:	0380006f          	j	800025e8 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800025b4:	fffff097          	auipc	ra,0xfffff
    800025b8:	c60080e7          	jalr	-928(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800025bc:	00148493          	addi	s1,s1,1
    800025c0:	000027b7          	lui	a5,0x2
    800025c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800025c8:	0097ee63          	bltu	a5,s1,800025e4 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800025cc:	00000713          	li	a4,0
    800025d0:	000077b7          	lui	a5,0x7
    800025d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800025d8:	fce7eee3          	bltu	a5,a4,800025b4 <_ZN7WorkerA11workerBodyAEPv+0x20>
    800025dc:	00170713          	addi	a4,a4,1
    800025e0:	ff1ff06f          	j	800025d0 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800025e4:	00190913          	addi	s2,s2,1
    800025e8:	00900793          	li	a5,9
    800025ec:	0527e063          	bltu	a5,s2,8000262c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800025f0:	00006517          	auipc	a0,0x6
    800025f4:	e5850513          	addi	a0,a0,-424 # 80008448 <kvmincrease+0x1358>
    800025f8:	00001097          	auipc	ra,0x1
    800025fc:	728080e7          	jalr	1832(ra) # 80003d20 <_Z11printStringPKc>
    80002600:	00000613          	li	a2,0
    80002604:	00a00593          	li	a1,10
    80002608:	0009051b          	sext.w	a0,s2
    8000260c:	00002097          	auipc	ra,0x2
    80002610:	8c4080e7          	jalr	-1852(ra) # 80003ed0 <_Z8printIntiii>
    80002614:	00006517          	auipc	a0,0x6
    80002618:	b5c50513          	addi	a0,a0,-1188 # 80008170 <kvmincrease+0x1080>
    8000261c:	00001097          	auipc	ra,0x1
    80002620:	704080e7          	jalr	1796(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002624:	00000493          	li	s1,0
    80002628:	f99ff06f          	j	800025c0 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000262c:	00006517          	auipc	a0,0x6
    80002630:	e2450513          	addi	a0,a0,-476 # 80008450 <kvmincrease+0x1360>
    80002634:	00001097          	auipc	ra,0x1
    80002638:	6ec080e7          	jalr	1772(ra) # 80003d20 <_Z11printStringPKc>
    finishedA = true;
    8000263c:	00100793          	li	a5,1
    80002640:	00008717          	auipc	a4,0x8
    80002644:	94f70c23          	sb	a5,-1704(a4) # 80009f98 <_ZL9finishedA>
}
    80002648:	01813083          	ld	ra,24(sp)
    8000264c:	01013403          	ld	s0,16(sp)
    80002650:	00813483          	ld	s1,8(sp)
    80002654:	00013903          	ld	s2,0(sp)
    80002658:	02010113          	addi	sp,sp,32
    8000265c:	00008067          	ret

0000000080002660 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002660:	fe010113          	addi	sp,sp,-32
    80002664:	00113c23          	sd	ra,24(sp)
    80002668:	00813823          	sd	s0,16(sp)
    8000266c:	00913423          	sd	s1,8(sp)
    80002670:	01213023          	sd	s2,0(sp)
    80002674:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002678:	00000913          	li	s2,0
    8000267c:	0380006f          	j	800026b4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002680:	fffff097          	auipc	ra,0xfffff
    80002684:	b94080e7          	jalr	-1132(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002688:	00148493          	addi	s1,s1,1
    8000268c:	000027b7          	lui	a5,0x2
    80002690:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002694:	0097ee63          	bltu	a5,s1,800026b0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002698:	00000713          	li	a4,0
    8000269c:	000077b7          	lui	a5,0x7
    800026a0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800026a4:	fce7eee3          	bltu	a5,a4,80002680 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800026a8:	00170713          	addi	a4,a4,1
    800026ac:	ff1ff06f          	j	8000269c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800026b0:	00190913          	addi	s2,s2,1
    800026b4:	00f00793          	li	a5,15
    800026b8:	0527e063          	bltu	a5,s2,800026f8 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800026bc:	00006517          	auipc	a0,0x6
    800026c0:	da450513          	addi	a0,a0,-604 # 80008460 <kvmincrease+0x1370>
    800026c4:	00001097          	auipc	ra,0x1
    800026c8:	65c080e7          	jalr	1628(ra) # 80003d20 <_Z11printStringPKc>
    800026cc:	00000613          	li	a2,0
    800026d0:	00a00593          	li	a1,10
    800026d4:	0009051b          	sext.w	a0,s2
    800026d8:	00001097          	auipc	ra,0x1
    800026dc:	7f8080e7          	jalr	2040(ra) # 80003ed0 <_Z8printIntiii>
    800026e0:	00006517          	auipc	a0,0x6
    800026e4:	a9050513          	addi	a0,a0,-1392 # 80008170 <kvmincrease+0x1080>
    800026e8:	00001097          	auipc	ra,0x1
    800026ec:	638080e7          	jalr	1592(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800026f0:	00000493          	li	s1,0
    800026f4:	f99ff06f          	j	8000268c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800026f8:	00006517          	auipc	a0,0x6
    800026fc:	d7050513          	addi	a0,a0,-656 # 80008468 <kvmincrease+0x1378>
    80002700:	00001097          	auipc	ra,0x1
    80002704:	620080e7          	jalr	1568(ra) # 80003d20 <_Z11printStringPKc>
    finishedB = true;
    80002708:	00100793          	li	a5,1
    8000270c:	00008717          	auipc	a4,0x8
    80002710:	88f706a3          	sb	a5,-1907(a4) # 80009f99 <_ZL9finishedB>
    thread_dispatch();
    80002714:	fffff097          	auipc	ra,0xfffff
    80002718:	b00080e7          	jalr	-1280(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000271c:	01813083          	ld	ra,24(sp)
    80002720:	01013403          	ld	s0,16(sp)
    80002724:	00813483          	ld	s1,8(sp)
    80002728:	00013903          	ld	s2,0(sp)
    8000272c:	02010113          	addi	sp,sp,32
    80002730:	00008067          	ret

0000000080002734 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002734:	fe010113          	addi	sp,sp,-32
    80002738:	00113c23          	sd	ra,24(sp)
    8000273c:	00813823          	sd	s0,16(sp)
    80002740:	00913423          	sd	s1,8(sp)
    80002744:	01213023          	sd	s2,0(sp)
    80002748:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000274c:	00000493          	li	s1,0
    80002750:	0400006f          	j	80002790 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002754:	00006517          	auipc	a0,0x6
    80002758:	d2450513          	addi	a0,a0,-732 # 80008478 <kvmincrease+0x1388>
    8000275c:	00001097          	auipc	ra,0x1
    80002760:	5c4080e7          	jalr	1476(ra) # 80003d20 <_Z11printStringPKc>
    80002764:	00000613          	li	a2,0
    80002768:	00a00593          	li	a1,10
    8000276c:	00048513          	mv	a0,s1
    80002770:	00001097          	auipc	ra,0x1
    80002774:	760080e7          	jalr	1888(ra) # 80003ed0 <_Z8printIntiii>
    80002778:	00006517          	auipc	a0,0x6
    8000277c:	9f850513          	addi	a0,a0,-1544 # 80008170 <kvmincrease+0x1080>
    80002780:	00001097          	auipc	ra,0x1
    80002784:	5a0080e7          	jalr	1440(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002788:	0014849b          	addiw	s1,s1,1
    8000278c:	0ff4f493          	andi	s1,s1,255
    80002790:	00200793          	li	a5,2
    80002794:	fc97f0e3          	bgeu	a5,s1,80002754 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002798:	00006517          	auipc	a0,0x6
    8000279c:	ce850513          	addi	a0,a0,-792 # 80008480 <kvmincrease+0x1390>
    800027a0:	00001097          	auipc	ra,0x1
    800027a4:	580080e7          	jalr	1408(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800027a8:	00700313          	li	t1,7
    thread_dispatch();
    800027ac:	fffff097          	auipc	ra,0xfffff
    800027b0:	a68080e7          	jalr	-1432(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800027b4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800027b8:	00006517          	auipc	a0,0x6
    800027bc:	cd850513          	addi	a0,a0,-808 # 80008490 <kvmincrease+0x13a0>
    800027c0:	00001097          	auipc	ra,0x1
    800027c4:	560080e7          	jalr	1376(ra) # 80003d20 <_Z11printStringPKc>
    800027c8:	00000613          	li	a2,0
    800027cc:	00a00593          	li	a1,10
    800027d0:	0009051b          	sext.w	a0,s2
    800027d4:	00001097          	auipc	ra,0x1
    800027d8:	6fc080e7          	jalr	1788(ra) # 80003ed0 <_Z8printIntiii>
    800027dc:	00006517          	auipc	a0,0x6
    800027e0:	99450513          	addi	a0,a0,-1644 # 80008170 <kvmincrease+0x1080>
    800027e4:	00001097          	auipc	ra,0x1
    800027e8:	53c080e7          	jalr	1340(ra) # 80003d20 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800027ec:	00c00513          	li	a0,12
    800027f0:	00000097          	auipc	ra,0x0
    800027f4:	d30080e7          	jalr	-720(ra) # 80002520 <_ZL9fibonaccim>
    800027f8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800027fc:	00006517          	auipc	a0,0x6
    80002800:	c9c50513          	addi	a0,a0,-868 # 80008498 <kvmincrease+0x13a8>
    80002804:	00001097          	auipc	ra,0x1
    80002808:	51c080e7          	jalr	1308(ra) # 80003d20 <_Z11printStringPKc>
    8000280c:	00000613          	li	a2,0
    80002810:	00a00593          	li	a1,10
    80002814:	0009051b          	sext.w	a0,s2
    80002818:	00001097          	auipc	ra,0x1
    8000281c:	6b8080e7          	jalr	1720(ra) # 80003ed0 <_Z8printIntiii>
    80002820:	00006517          	auipc	a0,0x6
    80002824:	95050513          	addi	a0,a0,-1712 # 80008170 <kvmincrease+0x1080>
    80002828:	00001097          	auipc	ra,0x1
    8000282c:	4f8080e7          	jalr	1272(ra) # 80003d20 <_Z11printStringPKc>
    80002830:	0400006f          	j	80002870 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002834:	00006517          	auipc	a0,0x6
    80002838:	c4450513          	addi	a0,a0,-956 # 80008478 <kvmincrease+0x1388>
    8000283c:	00001097          	auipc	ra,0x1
    80002840:	4e4080e7          	jalr	1252(ra) # 80003d20 <_Z11printStringPKc>
    80002844:	00000613          	li	a2,0
    80002848:	00a00593          	li	a1,10
    8000284c:	00048513          	mv	a0,s1
    80002850:	00001097          	auipc	ra,0x1
    80002854:	680080e7          	jalr	1664(ra) # 80003ed0 <_Z8printIntiii>
    80002858:	00006517          	auipc	a0,0x6
    8000285c:	91850513          	addi	a0,a0,-1768 # 80008170 <kvmincrease+0x1080>
    80002860:	00001097          	auipc	ra,0x1
    80002864:	4c0080e7          	jalr	1216(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002868:	0014849b          	addiw	s1,s1,1
    8000286c:	0ff4f493          	andi	s1,s1,255
    80002870:	00500793          	li	a5,5
    80002874:	fc97f0e3          	bgeu	a5,s1,80002834 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002878:	00006517          	auipc	a0,0x6
    8000287c:	bd850513          	addi	a0,a0,-1064 # 80008450 <kvmincrease+0x1360>
    80002880:	00001097          	auipc	ra,0x1
    80002884:	4a0080e7          	jalr	1184(ra) # 80003d20 <_Z11printStringPKc>
    finishedC = true;
    80002888:	00100793          	li	a5,1
    8000288c:	00007717          	auipc	a4,0x7
    80002890:	70f70723          	sb	a5,1806(a4) # 80009f9a <_ZL9finishedC>
    thread_dispatch();
    80002894:	fffff097          	auipc	ra,0xfffff
    80002898:	980080e7          	jalr	-1664(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000289c:	01813083          	ld	ra,24(sp)
    800028a0:	01013403          	ld	s0,16(sp)
    800028a4:	00813483          	ld	s1,8(sp)
    800028a8:	00013903          	ld	s2,0(sp)
    800028ac:	02010113          	addi	sp,sp,32
    800028b0:	00008067          	ret

00000000800028b4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800028b4:	fe010113          	addi	sp,sp,-32
    800028b8:	00113c23          	sd	ra,24(sp)
    800028bc:	00813823          	sd	s0,16(sp)
    800028c0:	00913423          	sd	s1,8(sp)
    800028c4:	01213023          	sd	s2,0(sp)
    800028c8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800028cc:	00a00493          	li	s1,10
    800028d0:	0400006f          	j	80002910 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800028d4:	00006517          	auipc	a0,0x6
    800028d8:	bd450513          	addi	a0,a0,-1068 # 800084a8 <kvmincrease+0x13b8>
    800028dc:	00001097          	auipc	ra,0x1
    800028e0:	444080e7          	jalr	1092(ra) # 80003d20 <_Z11printStringPKc>
    800028e4:	00000613          	li	a2,0
    800028e8:	00a00593          	li	a1,10
    800028ec:	00048513          	mv	a0,s1
    800028f0:	00001097          	auipc	ra,0x1
    800028f4:	5e0080e7          	jalr	1504(ra) # 80003ed0 <_Z8printIntiii>
    800028f8:	00006517          	auipc	a0,0x6
    800028fc:	87850513          	addi	a0,a0,-1928 # 80008170 <kvmincrease+0x1080>
    80002900:	00001097          	auipc	ra,0x1
    80002904:	420080e7          	jalr	1056(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002908:	0014849b          	addiw	s1,s1,1
    8000290c:	0ff4f493          	andi	s1,s1,255
    80002910:	00c00793          	li	a5,12
    80002914:	fc97f0e3          	bgeu	a5,s1,800028d4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002918:	00006517          	auipc	a0,0x6
    8000291c:	b9850513          	addi	a0,a0,-1128 # 800084b0 <kvmincrease+0x13c0>
    80002920:	00001097          	auipc	ra,0x1
    80002924:	400080e7          	jalr	1024(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002928:	00500313          	li	t1,5
    thread_dispatch();
    8000292c:	fffff097          	auipc	ra,0xfffff
    80002930:	8e8080e7          	jalr	-1816(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002934:	01000513          	li	a0,16
    80002938:	00000097          	auipc	ra,0x0
    8000293c:	be8080e7          	jalr	-1048(ra) # 80002520 <_ZL9fibonaccim>
    80002940:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002944:	00006517          	auipc	a0,0x6
    80002948:	b7c50513          	addi	a0,a0,-1156 # 800084c0 <kvmincrease+0x13d0>
    8000294c:	00001097          	auipc	ra,0x1
    80002950:	3d4080e7          	jalr	980(ra) # 80003d20 <_Z11printStringPKc>
    80002954:	00000613          	li	a2,0
    80002958:	00a00593          	li	a1,10
    8000295c:	0009051b          	sext.w	a0,s2
    80002960:	00001097          	auipc	ra,0x1
    80002964:	570080e7          	jalr	1392(ra) # 80003ed0 <_Z8printIntiii>
    80002968:	00006517          	auipc	a0,0x6
    8000296c:	80850513          	addi	a0,a0,-2040 # 80008170 <kvmincrease+0x1080>
    80002970:	00001097          	auipc	ra,0x1
    80002974:	3b0080e7          	jalr	944(ra) # 80003d20 <_Z11printStringPKc>
    80002978:	0400006f          	j	800029b8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000297c:	00006517          	auipc	a0,0x6
    80002980:	b2c50513          	addi	a0,a0,-1236 # 800084a8 <kvmincrease+0x13b8>
    80002984:	00001097          	auipc	ra,0x1
    80002988:	39c080e7          	jalr	924(ra) # 80003d20 <_Z11printStringPKc>
    8000298c:	00000613          	li	a2,0
    80002990:	00a00593          	li	a1,10
    80002994:	00048513          	mv	a0,s1
    80002998:	00001097          	auipc	ra,0x1
    8000299c:	538080e7          	jalr	1336(ra) # 80003ed0 <_Z8printIntiii>
    800029a0:	00005517          	auipc	a0,0x5
    800029a4:	7d050513          	addi	a0,a0,2000 # 80008170 <kvmincrease+0x1080>
    800029a8:	00001097          	auipc	ra,0x1
    800029ac:	378080e7          	jalr	888(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800029b0:	0014849b          	addiw	s1,s1,1
    800029b4:	0ff4f493          	andi	s1,s1,255
    800029b8:	00f00793          	li	a5,15
    800029bc:	fc97f0e3          	bgeu	a5,s1,8000297c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800029c0:	00006517          	auipc	a0,0x6
    800029c4:	b1050513          	addi	a0,a0,-1264 # 800084d0 <kvmincrease+0x13e0>
    800029c8:	00001097          	auipc	ra,0x1
    800029cc:	358080e7          	jalr	856(ra) # 80003d20 <_Z11printStringPKc>
    finishedD = true;
    800029d0:	00100793          	li	a5,1
    800029d4:	00007717          	auipc	a4,0x7
    800029d8:	5cf703a3          	sb	a5,1479(a4) # 80009f9b <_ZL9finishedD>
    thread_dispatch();
    800029dc:	fffff097          	auipc	ra,0xfffff
    800029e0:	838080e7          	jalr	-1992(ra) # 80001214 <_Z15thread_dispatchv>
}
    800029e4:	01813083          	ld	ra,24(sp)
    800029e8:	01013403          	ld	s0,16(sp)
    800029ec:	00813483          	ld	s1,8(sp)
    800029f0:	00013903          	ld	s2,0(sp)
    800029f4:	02010113          	addi	sp,sp,32
    800029f8:	00008067          	ret

00000000800029fc <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800029fc:	fc010113          	addi	sp,sp,-64
    80002a00:	02113c23          	sd	ra,56(sp)
    80002a04:	02813823          	sd	s0,48(sp)
    80002a08:	02913423          	sd	s1,40(sp)
    80002a0c:	03213023          	sd	s2,32(sp)
    80002a10:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002a14:	02000513          	li	a0,32
    80002a18:	fffff097          	auipc	ra,0xfffff
    80002a1c:	cf8080e7          	jalr	-776(ra) # 80001710 <_Znwm>
    80002a20:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002a24:	fffff097          	auipc	ra,0xfffff
    80002a28:	f70080e7          	jalr	-144(ra) # 80001994 <_ZN6ThreadC1Ev>
    80002a2c:	00007797          	auipc	a5,0x7
    80002a30:	3b478793          	addi	a5,a5,948 # 80009de0 <_ZTV7WorkerA+0x10>
    80002a34:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80002a38:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80002a3c:	00006517          	auipc	a0,0x6
    80002a40:	aa450513          	addi	a0,a0,-1372 # 800084e0 <kvmincrease+0x13f0>
    80002a44:	00001097          	auipc	ra,0x1
    80002a48:	2dc080e7          	jalr	732(ra) # 80003d20 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002a4c:	02000513          	li	a0,32
    80002a50:	fffff097          	auipc	ra,0xfffff
    80002a54:	cc0080e7          	jalr	-832(ra) # 80001710 <_Znwm>
    80002a58:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80002a5c:	fffff097          	auipc	ra,0xfffff
    80002a60:	f38080e7          	jalr	-200(ra) # 80001994 <_ZN6ThreadC1Ev>
    80002a64:	00007797          	auipc	a5,0x7
    80002a68:	3a478793          	addi	a5,a5,932 # 80009e08 <_ZTV7WorkerB+0x10>
    80002a6c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002a70:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002a74:	00006517          	auipc	a0,0x6
    80002a78:	a8450513          	addi	a0,a0,-1404 # 800084f8 <kvmincrease+0x1408>
    80002a7c:	00001097          	auipc	ra,0x1
    80002a80:	2a4080e7          	jalr	676(ra) # 80003d20 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002a84:	02000513          	li	a0,32
    80002a88:	fffff097          	auipc	ra,0xfffff
    80002a8c:	c88080e7          	jalr	-888(ra) # 80001710 <_Znwm>
    80002a90:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002a94:	fffff097          	auipc	ra,0xfffff
    80002a98:	f00080e7          	jalr	-256(ra) # 80001994 <_ZN6ThreadC1Ev>
    80002a9c:	00007797          	auipc	a5,0x7
    80002aa0:	39478793          	addi	a5,a5,916 # 80009e30 <_ZTV7WorkerC+0x10>
    80002aa4:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002aa8:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002aac:	00006517          	auipc	a0,0x6
    80002ab0:	a6450513          	addi	a0,a0,-1436 # 80008510 <kvmincrease+0x1420>
    80002ab4:	00001097          	auipc	ra,0x1
    80002ab8:	26c080e7          	jalr	620(ra) # 80003d20 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002abc:	02000513          	li	a0,32
    80002ac0:	fffff097          	auipc	ra,0xfffff
    80002ac4:	c50080e7          	jalr	-944(ra) # 80001710 <_Znwm>
    80002ac8:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002acc:	fffff097          	auipc	ra,0xfffff
    80002ad0:	ec8080e7          	jalr	-312(ra) # 80001994 <_ZN6ThreadC1Ev>
    80002ad4:	00007797          	auipc	a5,0x7
    80002ad8:	38478793          	addi	a5,a5,900 # 80009e58 <_ZTV7WorkerD+0x10>
    80002adc:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002ae0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002ae4:	00006517          	auipc	a0,0x6
    80002ae8:	a4450513          	addi	a0,a0,-1468 # 80008528 <kvmincrease+0x1438>
    80002aec:	00001097          	auipc	ra,0x1
    80002af0:	234080e7          	jalr	564(ra) # 80003d20 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002af4:	00000493          	li	s1,0
    80002af8:	00300793          	li	a5,3
    80002afc:	0297c663          	blt	a5,s1,80002b28 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002b00:	00349793          	slli	a5,s1,0x3
    80002b04:	fe040713          	addi	a4,s0,-32
    80002b08:	00f707b3          	add	a5,a4,a5
    80002b0c:	fe07b503          	ld	a0,-32(a5)
    80002b10:	fffff097          	auipc	ra,0xfffff
    80002b14:	e28080e7          	jalr	-472(ra) # 80001938 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002b18:	0014849b          	addiw	s1,s1,1
    80002b1c:	fddff06f          	j	80002af8 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002b20:	fffff097          	auipc	ra,0xfffff
    80002b24:	e4c080e7          	jalr	-436(ra) # 8000196c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002b28:	00007797          	auipc	a5,0x7
    80002b2c:	4707c783          	lbu	a5,1136(a5) # 80009f98 <_ZL9finishedA>
    80002b30:	fe0788e3          	beqz	a5,80002b20 <_Z20Threads_CPP_API_testv+0x124>
    80002b34:	00007797          	auipc	a5,0x7
    80002b38:	4657c783          	lbu	a5,1125(a5) # 80009f99 <_ZL9finishedB>
    80002b3c:	fe0782e3          	beqz	a5,80002b20 <_Z20Threads_CPP_API_testv+0x124>
    80002b40:	00007797          	auipc	a5,0x7
    80002b44:	45a7c783          	lbu	a5,1114(a5) # 80009f9a <_ZL9finishedC>
    80002b48:	fc078ce3          	beqz	a5,80002b20 <_Z20Threads_CPP_API_testv+0x124>
    80002b4c:	00007797          	auipc	a5,0x7
    80002b50:	44f7c783          	lbu	a5,1103(a5) # 80009f9b <_ZL9finishedD>
    80002b54:	fc0786e3          	beqz	a5,80002b20 <_Z20Threads_CPP_API_testv+0x124>
    80002b58:	fc040493          	addi	s1,s0,-64
    80002b5c:	0080006f          	j	80002b64 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002b60:	00848493          	addi	s1,s1,8
    80002b64:	fe040793          	addi	a5,s0,-32
    80002b68:	08f48663          	beq	s1,a5,80002bf4 <_Z20Threads_CPP_API_testv+0x1f8>
    80002b6c:	0004b503          	ld	a0,0(s1)
    80002b70:	fe0508e3          	beqz	a0,80002b60 <_Z20Threads_CPP_API_testv+0x164>
    80002b74:	00053783          	ld	a5,0(a0)
    80002b78:	0087b783          	ld	a5,8(a5)
    80002b7c:	000780e7          	jalr	a5
    80002b80:	fe1ff06f          	j	80002b60 <_Z20Threads_CPP_API_testv+0x164>
    80002b84:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002b88:	00048513          	mv	a0,s1
    80002b8c:	fffff097          	auipc	ra,0xfffff
    80002b90:	bd4080e7          	jalr	-1068(ra) # 80001760 <_ZdlPv>
    80002b94:	00090513          	mv	a0,s2
    80002b98:	00008097          	auipc	ra,0x8
    80002b9c:	4f0080e7          	jalr	1264(ra) # 8000b088 <_Unwind_Resume>
    80002ba0:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002ba4:	00048513          	mv	a0,s1
    80002ba8:	fffff097          	auipc	ra,0xfffff
    80002bac:	bb8080e7          	jalr	-1096(ra) # 80001760 <_ZdlPv>
    80002bb0:	00090513          	mv	a0,s2
    80002bb4:	00008097          	auipc	ra,0x8
    80002bb8:	4d4080e7          	jalr	1236(ra) # 8000b088 <_Unwind_Resume>
    80002bbc:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002bc0:	00048513          	mv	a0,s1
    80002bc4:	fffff097          	auipc	ra,0xfffff
    80002bc8:	b9c080e7          	jalr	-1124(ra) # 80001760 <_ZdlPv>
    80002bcc:	00090513          	mv	a0,s2
    80002bd0:	00008097          	auipc	ra,0x8
    80002bd4:	4b8080e7          	jalr	1208(ra) # 8000b088 <_Unwind_Resume>
    80002bd8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002bdc:	00048513          	mv	a0,s1
    80002be0:	fffff097          	auipc	ra,0xfffff
    80002be4:	b80080e7          	jalr	-1152(ra) # 80001760 <_ZdlPv>
    80002be8:	00090513          	mv	a0,s2
    80002bec:	00008097          	auipc	ra,0x8
    80002bf0:	49c080e7          	jalr	1180(ra) # 8000b088 <_Unwind_Resume>
}
    80002bf4:	03813083          	ld	ra,56(sp)
    80002bf8:	03013403          	ld	s0,48(sp)
    80002bfc:	02813483          	ld	s1,40(sp)
    80002c00:	02013903          	ld	s2,32(sp)
    80002c04:	04010113          	addi	sp,sp,64
    80002c08:	00008067          	ret

0000000080002c0c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002c0c:	ff010113          	addi	sp,sp,-16
    80002c10:	00113423          	sd	ra,8(sp)
    80002c14:	00813023          	sd	s0,0(sp)
    80002c18:	01010413          	addi	s0,sp,16
    80002c1c:	00007797          	auipc	a5,0x7
    80002c20:	1c478793          	addi	a5,a5,452 # 80009de0 <_ZTV7WorkerA+0x10>
    80002c24:	00f53023          	sd	a5,0(a0)
    80002c28:	fffff097          	auipc	ra,0xfffff
    80002c2c:	b88080e7          	jalr	-1144(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002c30:	00813083          	ld	ra,8(sp)
    80002c34:	00013403          	ld	s0,0(sp)
    80002c38:	01010113          	addi	sp,sp,16
    80002c3c:	00008067          	ret

0000000080002c40 <_ZN7WorkerAD0Ev>:
    80002c40:	fe010113          	addi	sp,sp,-32
    80002c44:	00113c23          	sd	ra,24(sp)
    80002c48:	00813823          	sd	s0,16(sp)
    80002c4c:	00913423          	sd	s1,8(sp)
    80002c50:	02010413          	addi	s0,sp,32
    80002c54:	00050493          	mv	s1,a0
    80002c58:	00007797          	auipc	a5,0x7
    80002c5c:	18878793          	addi	a5,a5,392 # 80009de0 <_ZTV7WorkerA+0x10>
    80002c60:	00f53023          	sd	a5,0(a0)
    80002c64:	fffff097          	auipc	ra,0xfffff
    80002c68:	b4c080e7          	jalr	-1204(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002c6c:	00048513          	mv	a0,s1
    80002c70:	fffff097          	auipc	ra,0xfffff
    80002c74:	af0080e7          	jalr	-1296(ra) # 80001760 <_ZdlPv>
    80002c78:	01813083          	ld	ra,24(sp)
    80002c7c:	01013403          	ld	s0,16(sp)
    80002c80:	00813483          	ld	s1,8(sp)
    80002c84:	02010113          	addi	sp,sp,32
    80002c88:	00008067          	ret

0000000080002c8c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002c8c:	ff010113          	addi	sp,sp,-16
    80002c90:	00113423          	sd	ra,8(sp)
    80002c94:	00813023          	sd	s0,0(sp)
    80002c98:	01010413          	addi	s0,sp,16
    80002c9c:	00007797          	auipc	a5,0x7
    80002ca0:	16c78793          	addi	a5,a5,364 # 80009e08 <_ZTV7WorkerB+0x10>
    80002ca4:	00f53023          	sd	a5,0(a0)
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	b08080e7          	jalr	-1272(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002cb0:	00813083          	ld	ra,8(sp)
    80002cb4:	00013403          	ld	s0,0(sp)
    80002cb8:	01010113          	addi	sp,sp,16
    80002cbc:	00008067          	ret

0000000080002cc0 <_ZN7WorkerBD0Ev>:
    80002cc0:	fe010113          	addi	sp,sp,-32
    80002cc4:	00113c23          	sd	ra,24(sp)
    80002cc8:	00813823          	sd	s0,16(sp)
    80002ccc:	00913423          	sd	s1,8(sp)
    80002cd0:	02010413          	addi	s0,sp,32
    80002cd4:	00050493          	mv	s1,a0
    80002cd8:	00007797          	auipc	a5,0x7
    80002cdc:	13078793          	addi	a5,a5,304 # 80009e08 <_ZTV7WorkerB+0x10>
    80002ce0:	00f53023          	sd	a5,0(a0)
    80002ce4:	fffff097          	auipc	ra,0xfffff
    80002ce8:	acc080e7          	jalr	-1332(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002cec:	00048513          	mv	a0,s1
    80002cf0:	fffff097          	auipc	ra,0xfffff
    80002cf4:	a70080e7          	jalr	-1424(ra) # 80001760 <_ZdlPv>
    80002cf8:	01813083          	ld	ra,24(sp)
    80002cfc:	01013403          	ld	s0,16(sp)
    80002d00:	00813483          	ld	s1,8(sp)
    80002d04:	02010113          	addi	sp,sp,32
    80002d08:	00008067          	ret

0000000080002d0c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002d0c:	ff010113          	addi	sp,sp,-16
    80002d10:	00113423          	sd	ra,8(sp)
    80002d14:	00813023          	sd	s0,0(sp)
    80002d18:	01010413          	addi	s0,sp,16
    80002d1c:	00007797          	auipc	a5,0x7
    80002d20:	11478793          	addi	a5,a5,276 # 80009e30 <_ZTV7WorkerC+0x10>
    80002d24:	00f53023          	sd	a5,0(a0)
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	a88080e7          	jalr	-1400(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002d30:	00813083          	ld	ra,8(sp)
    80002d34:	00013403          	ld	s0,0(sp)
    80002d38:	01010113          	addi	sp,sp,16
    80002d3c:	00008067          	ret

0000000080002d40 <_ZN7WorkerCD0Ev>:
    80002d40:	fe010113          	addi	sp,sp,-32
    80002d44:	00113c23          	sd	ra,24(sp)
    80002d48:	00813823          	sd	s0,16(sp)
    80002d4c:	00913423          	sd	s1,8(sp)
    80002d50:	02010413          	addi	s0,sp,32
    80002d54:	00050493          	mv	s1,a0
    80002d58:	00007797          	auipc	a5,0x7
    80002d5c:	0d878793          	addi	a5,a5,216 # 80009e30 <_ZTV7WorkerC+0x10>
    80002d60:	00f53023          	sd	a5,0(a0)
    80002d64:	fffff097          	auipc	ra,0xfffff
    80002d68:	a4c080e7          	jalr	-1460(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002d6c:	00048513          	mv	a0,s1
    80002d70:	fffff097          	auipc	ra,0xfffff
    80002d74:	9f0080e7          	jalr	-1552(ra) # 80001760 <_ZdlPv>
    80002d78:	01813083          	ld	ra,24(sp)
    80002d7c:	01013403          	ld	s0,16(sp)
    80002d80:	00813483          	ld	s1,8(sp)
    80002d84:	02010113          	addi	sp,sp,32
    80002d88:	00008067          	ret

0000000080002d8c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
    80002d9c:	00007797          	auipc	a5,0x7
    80002da0:	0bc78793          	addi	a5,a5,188 # 80009e58 <_ZTV7WorkerD+0x10>
    80002da4:	00f53023          	sd	a5,0(a0)
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	a08080e7          	jalr	-1528(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00013403          	ld	s0,0(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN7WorkerDD0Ev>:
    80002dc0:	fe010113          	addi	sp,sp,-32
    80002dc4:	00113c23          	sd	ra,24(sp)
    80002dc8:	00813823          	sd	s0,16(sp)
    80002dcc:	00913423          	sd	s1,8(sp)
    80002dd0:	02010413          	addi	s0,sp,32
    80002dd4:	00050493          	mv	s1,a0
    80002dd8:	00007797          	auipc	a5,0x7
    80002ddc:	08078793          	addi	a5,a5,128 # 80009e58 <_ZTV7WorkerD+0x10>
    80002de0:	00f53023          	sd	a5,0(a0)
    80002de4:	fffff097          	auipc	ra,0xfffff
    80002de8:	9cc080e7          	jalr	-1588(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80002dec:	00048513          	mv	a0,s1
    80002df0:	fffff097          	auipc	ra,0xfffff
    80002df4:	970080e7          	jalr	-1680(ra) # 80001760 <_ZdlPv>
    80002df8:	01813083          	ld	ra,24(sp)
    80002dfc:	01013403          	ld	s0,16(sp)
    80002e00:	00813483          	ld	s1,8(sp)
    80002e04:	02010113          	addi	sp,sp,32
    80002e08:	00008067          	ret

0000000080002e0c <_ZN7WorkerA3runEv>:
    void run() override {
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00113423          	sd	ra,8(sp)
    80002e14:	00813023          	sd	s0,0(sp)
    80002e18:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002e1c:	00000593          	li	a1,0
    80002e20:	fffff097          	auipc	ra,0xfffff
    80002e24:	774080e7          	jalr	1908(ra) # 80002594 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002e28:	00813083          	ld	ra,8(sp)
    80002e2c:	00013403          	ld	s0,0(sp)
    80002e30:	01010113          	addi	sp,sp,16
    80002e34:	00008067          	ret

0000000080002e38 <_ZN7WorkerB3runEv>:
    void run() override {
    80002e38:	ff010113          	addi	sp,sp,-16
    80002e3c:	00113423          	sd	ra,8(sp)
    80002e40:	00813023          	sd	s0,0(sp)
    80002e44:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002e48:	00000593          	li	a1,0
    80002e4c:	00000097          	auipc	ra,0x0
    80002e50:	814080e7          	jalr	-2028(ra) # 80002660 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002e54:	00813083          	ld	ra,8(sp)
    80002e58:	00013403          	ld	s0,0(sp)
    80002e5c:	01010113          	addi	sp,sp,16
    80002e60:	00008067          	ret

0000000080002e64 <_ZN7WorkerC3runEv>:
    void run() override {
    80002e64:	ff010113          	addi	sp,sp,-16
    80002e68:	00113423          	sd	ra,8(sp)
    80002e6c:	00813023          	sd	s0,0(sp)
    80002e70:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002e74:	00000593          	li	a1,0
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	8bc080e7          	jalr	-1860(ra) # 80002734 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002e80:	00813083          	ld	ra,8(sp)
    80002e84:	00013403          	ld	s0,0(sp)
    80002e88:	01010113          	addi	sp,sp,16
    80002e8c:	00008067          	ret

0000000080002e90 <_ZN7WorkerD3runEv>:
    void run() override {
    80002e90:	ff010113          	addi	sp,sp,-16
    80002e94:	00113423          	sd	ra,8(sp)
    80002e98:	00813023          	sd	s0,0(sp)
    80002e9c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002ea0:	00000593          	li	a1,0
    80002ea4:	00000097          	auipc	ra,0x0
    80002ea8:	a10080e7          	jalr	-1520(ra) # 800028b4 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002eac:	00813083          	ld	ra,8(sp)
    80002eb0:	00013403          	ld	s0,0(sp)
    80002eb4:	01010113          	addi	sp,sp,16
    80002eb8:	00008067          	ret

0000000080002ebc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002ebc:	fe010113          	addi	sp,sp,-32
    80002ec0:	00113c23          	sd	ra,24(sp)
    80002ec4:	00813823          	sd	s0,16(sp)
    80002ec8:	00913423          	sd	s1,8(sp)
    80002ecc:	01213023          	sd	s2,0(sp)
    80002ed0:	02010413          	addi	s0,sp,32
    80002ed4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002ed8:	00100793          	li	a5,1
    80002edc:	02a7f863          	bgeu	a5,a0,80002f0c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) {
    80002ee0:	00a00793          	li	a5,10
    80002ee4:	02f577b3          	remu	a5,a0,a5
    80002ee8:	02078e63          	beqz	a5,80002f24 <_ZL9fibonaccim+0x68>
        thread_dispatch();
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002eec:	fff48513          	addi	a0,s1,-1
    80002ef0:	00000097          	auipc	ra,0x0
    80002ef4:	fcc080e7          	jalr	-52(ra) # 80002ebc <_ZL9fibonaccim>
    80002ef8:	00050913          	mv	s2,a0
    80002efc:	ffe48513          	addi	a0,s1,-2
    80002f00:	00000097          	auipc	ra,0x0
    80002f04:	fbc080e7          	jalr	-68(ra) # 80002ebc <_ZL9fibonaccim>
    80002f08:	00a90533          	add	a0,s2,a0
}
    80002f0c:	01813083          	ld	ra,24(sp)
    80002f10:	01013403          	ld	s0,16(sp)
    80002f14:	00813483          	ld	s1,8(sp)
    80002f18:	00013903          	ld	s2,0(sp)
    80002f1c:	02010113          	addi	sp,sp,32
    80002f20:	00008067          	ret
        thread_dispatch();
    80002f24:	ffffe097          	auipc	ra,0xffffe
    80002f28:	2f0080e7          	jalr	752(ra) # 80001214 <_Z15thread_dispatchv>
    80002f2c:	fc1ff06f          	j	80002eec <_ZL9fibonaccim+0x30>

0000000080002f30 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002f30:	fe010113          	addi	sp,sp,-32
    80002f34:	00113c23          	sd	ra,24(sp)
    80002f38:	00813823          	sd	s0,16(sp)
    80002f3c:	00913423          	sd	s1,8(sp)
    80002f40:	01213023          	sd	s2,0(sp)
    80002f44:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002f48:	00a00493          	li	s1,10
    80002f4c:	0400006f          	j	80002f8c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f50:	00005517          	auipc	a0,0x5
    80002f54:	55850513          	addi	a0,a0,1368 # 800084a8 <kvmincrease+0x13b8>
    80002f58:	00001097          	auipc	ra,0x1
    80002f5c:	dc8080e7          	jalr	-568(ra) # 80003d20 <_Z11printStringPKc>
    80002f60:	00000613          	li	a2,0
    80002f64:	00a00593          	li	a1,10
    80002f68:	00048513          	mv	a0,s1
    80002f6c:	00001097          	auipc	ra,0x1
    80002f70:	f64080e7          	jalr	-156(ra) # 80003ed0 <_Z8printIntiii>
    80002f74:	00005517          	auipc	a0,0x5
    80002f78:	1fc50513          	addi	a0,a0,508 # 80008170 <kvmincrease+0x1080>
    80002f7c:	00001097          	auipc	ra,0x1
    80002f80:	da4080e7          	jalr	-604(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002f84:	0014849b          	addiw	s1,s1,1
    80002f88:	0ff4f493          	andi	s1,s1,255
    80002f8c:	00c00793          	li	a5,12
    80002f90:	fc97f0e3          	bgeu	a5,s1,80002f50 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002f94:	00005517          	auipc	a0,0x5
    80002f98:	51c50513          	addi	a0,a0,1308 # 800084b0 <kvmincrease+0x13c0>
    80002f9c:	00001097          	auipc	ra,0x1
    80002fa0:	d84080e7          	jalr	-636(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002fa4:	00500313          	li	t1,5
    thread_dispatch();
    80002fa8:	ffffe097          	auipc	ra,0xffffe
    80002fac:	26c080e7          	jalr	620(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002fb0:	01000513          	li	a0,16
    80002fb4:	00000097          	auipc	ra,0x0
    80002fb8:	f08080e7          	jalr	-248(ra) # 80002ebc <_ZL9fibonaccim>
    80002fbc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002fc0:	00005517          	auipc	a0,0x5
    80002fc4:	50050513          	addi	a0,a0,1280 # 800084c0 <kvmincrease+0x13d0>
    80002fc8:	00001097          	auipc	ra,0x1
    80002fcc:	d58080e7          	jalr	-680(ra) # 80003d20 <_Z11printStringPKc>
    80002fd0:	00000613          	li	a2,0
    80002fd4:	00a00593          	li	a1,10
    80002fd8:	0009051b          	sext.w	a0,s2
    80002fdc:	00001097          	auipc	ra,0x1
    80002fe0:	ef4080e7          	jalr	-268(ra) # 80003ed0 <_Z8printIntiii>
    80002fe4:	00005517          	auipc	a0,0x5
    80002fe8:	18c50513          	addi	a0,a0,396 # 80008170 <kvmincrease+0x1080>
    80002fec:	00001097          	auipc	ra,0x1
    80002ff0:	d34080e7          	jalr	-716(ra) # 80003d20 <_Z11printStringPKc>
    80002ff4:	0400006f          	j	80003034 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002ff8:	00005517          	auipc	a0,0x5
    80002ffc:	4b050513          	addi	a0,a0,1200 # 800084a8 <kvmincrease+0x13b8>
    80003000:	00001097          	auipc	ra,0x1
    80003004:	d20080e7          	jalr	-736(ra) # 80003d20 <_Z11printStringPKc>
    80003008:	00000613          	li	a2,0
    8000300c:	00a00593          	li	a1,10
    80003010:	00048513          	mv	a0,s1
    80003014:	00001097          	auipc	ra,0x1
    80003018:	ebc080e7          	jalr	-324(ra) # 80003ed0 <_Z8printIntiii>
    8000301c:	00005517          	auipc	a0,0x5
    80003020:	15450513          	addi	a0,a0,340 # 80008170 <kvmincrease+0x1080>
    80003024:	00001097          	auipc	ra,0x1
    80003028:	cfc080e7          	jalr	-772(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000302c:	0014849b          	addiw	s1,s1,1
    80003030:	0ff4f493          	andi	s1,s1,255
    80003034:	00f00793          	li	a5,15
    80003038:	fc97f0e3          	bgeu	a5,s1,80002ff8 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000303c:	00005517          	auipc	a0,0x5
    80003040:	49450513          	addi	a0,a0,1172 # 800084d0 <kvmincrease+0x13e0>
    80003044:	00001097          	auipc	ra,0x1
    80003048:	cdc080e7          	jalr	-804(ra) # 80003d20 <_Z11printStringPKc>
    finishedD = true;
    8000304c:	00100793          	li	a5,1
    80003050:	00007717          	auipc	a4,0x7
    80003054:	f4f70623          	sb	a5,-180(a4) # 80009f9c <_ZL9finishedD>
    thread_dispatch();
    80003058:	ffffe097          	auipc	ra,0xffffe
    8000305c:	1bc080e7          	jalr	444(ra) # 80001214 <_Z15thread_dispatchv>
}
    80003060:	01813083          	ld	ra,24(sp)
    80003064:	01013403          	ld	s0,16(sp)
    80003068:	00813483          	ld	s1,8(sp)
    8000306c:	00013903          	ld	s2,0(sp)
    80003070:	02010113          	addi	sp,sp,32
    80003074:	00008067          	ret

0000000080003078 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003078:	fe010113          	addi	sp,sp,-32
    8000307c:	00113c23          	sd	ra,24(sp)
    80003080:	00813823          	sd	s0,16(sp)
    80003084:	00913423          	sd	s1,8(sp)
    80003088:	01213023          	sd	s2,0(sp)
    8000308c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003090:	00000493          	li	s1,0
    80003094:	0400006f          	j	800030d4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003098:	00005517          	auipc	a0,0x5
    8000309c:	3e050513          	addi	a0,a0,992 # 80008478 <kvmincrease+0x1388>
    800030a0:	00001097          	auipc	ra,0x1
    800030a4:	c80080e7          	jalr	-896(ra) # 80003d20 <_Z11printStringPKc>
    800030a8:	00000613          	li	a2,0
    800030ac:	00a00593          	li	a1,10
    800030b0:	00048513          	mv	a0,s1
    800030b4:	00001097          	auipc	ra,0x1
    800030b8:	e1c080e7          	jalr	-484(ra) # 80003ed0 <_Z8printIntiii>
    800030bc:	00005517          	auipc	a0,0x5
    800030c0:	0b450513          	addi	a0,a0,180 # 80008170 <kvmincrease+0x1080>
    800030c4:	00001097          	auipc	ra,0x1
    800030c8:	c5c080e7          	jalr	-932(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800030cc:	0014849b          	addiw	s1,s1,1
    800030d0:	0ff4f493          	andi	s1,s1,255
    800030d4:	00200793          	li	a5,2
    800030d8:	fc97f0e3          	bgeu	a5,s1,80003098 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800030dc:	00005517          	auipc	a0,0x5
    800030e0:	3a450513          	addi	a0,a0,932 # 80008480 <kvmincrease+0x1390>
    800030e4:	00001097          	auipc	ra,0x1
    800030e8:	c3c080e7          	jalr	-964(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800030ec:	00700313          	li	t1,7
    thread_dispatch();
    800030f0:	ffffe097          	auipc	ra,0xffffe
    800030f4:	124080e7          	jalr	292(ra) # 80001214 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800030f8:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800030fc:	00005517          	auipc	a0,0x5
    80003100:	39450513          	addi	a0,a0,916 # 80008490 <kvmincrease+0x13a0>
    80003104:	00001097          	auipc	ra,0x1
    80003108:	c1c080e7          	jalr	-996(ra) # 80003d20 <_Z11printStringPKc>
    8000310c:	00000613          	li	a2,0
    80003110:	00a00593          	li	a1,10
    80003114:	0009051b          	sext.w	a0,s2
    80003118:	00001097          	auipc	ra,0x1
    8000311c:	db8080e7          	jalr	-584(ra) # 80003ed0 <_Z8printIntiii>
    80003120:	00005517          	auipc	a0,0x5
    80003124:	05050513          	addi	a0,a0,80 # 80008170 <kvmincrease+0x1080>
    80003128:	00001097          	auipc	ra,0x1
    8000312c:	bf8080e7          	jalr	-1032(ra) # 80003d20 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003130:	00c00513          	li	a0,12
    80003134:	00000097          	auipc	ra,0x0
    80003138:	d88080e7          	jalr	-632(ra) # 80002ebc <_ZL9fibonaccim>
    8000313c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003140:	00005517          	auipc	a0,0x5
    80003144:	35850513          	addi	a0,a0,856 # 80008498 <kvmincrease+0x13a8>
    80003148:	00001097          	auipc	ra,0x1
    8000314c:	bd8080e7          	jalr	-1064(ra) # 80003d20 <_Z11printStringPKc>
    80003150:	00000613          	li	a2,0
    80003154:	00a00593          	li	a1,10
    80003158:	0009051b          	sext.w	a0,s2
    8000315c:	00001097          	auipc	ra,0x1
    80003160:	d74080e7          	jalr	-652(ra) # 80003ed0 <_Z8printIntiii>
    80003164:	00005517          	auipc	a0,0x5
    80003168:	00c50513          	addi	a0,a0,12 # 80008170 <kvmincrease+0x1080>
    8000316c:	00001097          	auipc	ra,0x1
    80003170:	bb4080e7          	jalr	-1100(ra) # 80003d20 <_Z11printStringPKc>
    80003174:	0400006f          	j	800031b4 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003178:	00005517          	auipc	a0,0x5
    8000317c:	30050513          	addi	a0,a0,768 # 80008478 <kvmincrease+0x1388>
    80003180:	00001097          	auipc	ra,0x1
    80003184:	ba0080e7          	jalr	-1120(ra) # 80003d20 <_Z11printStringPKc>
    80003188:	00000613          	li	a2,0
    8000318c:	00a00593          	li	a1,10
    80003190:	00048513          	mv	a0,s1
    80003194:	00001097          	auipc	ra,0x1
    80003198:	d3c080e7          	jalr	-708(ra) # 80003ed0 <_Z8printIntiii>
    8000319c:	00005517          	auipc	a0,0x5
    800031a0:	fd450513          	addi	a0,a0,-44 # 80008170 <kvmincrease+0x1080>
    800031a4:	00001097          	auipc	ra,0x1
    800031a8:	b7c080e7          	jalr	-1156(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800031ac:	0014849b          	addiw	s1,s1,1
    800031b0:	0ff4f493          	andi	s1,s1,255
    800031b4:	00500793          	li	a5,5
    800031b8:	fc97f0e3          	bgeu	a5,s1,80003178 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    800031bc:	00005517          	auipc	a0,0x5
    800031c0:	38450513          	addi	a0,a0,900 # 80008540 <kvmincrease+0x1450>
    800031c4:	00001097          	auipc	ra,0x1
    800031c8:	b5c080e7          	jalr	-1188(ra) # 80003d20 <_Z11printStringPKc>
    finishedC = true;
    800031cc:	00100793          	li	a5,1
    800031d0:	00007717          	auipc	a4,0x7
    800031d4:	dcf706a3          	sb	a5,-563(a4) # 80009f9d <_ZL9finishedC>
    thread_dispatch();
    800031d8:	ffffe097          	auipc	ra,0xffffe
    800031dc:	03c080e7          	jalr	60(ra) # 80001214 <_Z15thread_dispatchv>
}
    800031e0:	01813083          	ld	ra,24(sp)
    800031e4:	01013403          	ld	s0,16(sp)
    800031e8:	00813483          	ld	s1,8(sp)
    800031ec:	00013903          	ld	s2,0(sp)
    800031f0:	02010113          	addi	sp,sp,32
    800031f4:	00008067          	ret

00000000800031f8 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800031f8:	fe010113          	addi	sp,sp,-32
    800031fc:	00113c23          	sd	ra,24(sp)
    80003200:	00813823          	sd	s0,16(sp)
    80003204:	00913423          	sd	s1,8(sp)
    80003208:	01213023          	sd	s2,0(sp)
    8000320c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003210:	00000913          	li	s2,0
    80003214:	0380006f          	j	8000324c <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003218:	ffffe097          	auipc	ra,0xffffe
    8000321c:	ffc080e7          	jalr	-4(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003220:	00148493          	addi	s1,s1,1
    80003224:	000027b7          	lui	a5,0x2
    80003228:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000322c:	0097ee63          	bltu	a5,s1,80003248 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003230:	00000713          	li	a4,0
    80003234:	000077b7          	lui	a5,0x7
    80003238:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000323c:	fce7eee3          	bltu	a5,a4,80003218 <_ZL11workerBodyBPv+0x20>
    80003240:	00170713          	addi	a4,a4,1
    80003244:	ff1ff06f          	j	80003234 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003248:	00190913          	addi	s2,s2,1
    8000324c:	00f00793          	li	a5,15
    80003250:	0527e063          	bltu	a5,s2,80003290 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003254:	00005517          	auipc	a0,0x5
    80003258:	20c50513          	addi	a0,a0,524 # 80008460 <kvmincrease+0x1370>
    8000325c:	00001097          	auipc	ra,0x1
    80003260:	ac4080e7          	jalr	-1340(ra) # 80003d20 <_Z11printStringPKc>
    80003264:	00000613          	li	a2,0
    80003268:	00a00593          	li	a1,10
    8000326c:	0009051b          	sext.w	a0,s2
    80003270:	00001097          	auipc	ra,0x1
    80003274:	c60080e7          	jalr	-928(ra) # 80003ed0 <_Z8printIntiii>
    80003278:	00005517          	auipc	a0,0x5
    8000327c:	ef850513          	addi	a0,a0,-264 # 80008170 <kvmincrease+0x1080>
    80003280:	00001097          	auipc	ra,0x1
    80003284:	aa0080e7          	jalr	-1376(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003288:	00000493          	li	s1,0
    8000328c:	f99ff06f          	j	80003224 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003290:	00005517          	auipc	a0,0x5
    80003294:	1d850513          	addi	a0,a0,472 # 80008468 <kvmincrease+0x1378>
    80003298:	00001097          	auipc	ra,0x1
    8000329c:	a88080e7          	jalr	-1400(ra) # 80003d20 <_Z11printStringPKc>
    finishedB = true;
    800032a0:	00100793          	li	a5,1
    800032a4:	00007717          	auipc	a4,0x7
    800032a8:	cef70d23          	sb	a5,-774(a4) # 80009f9e <_ZL9finishedB>
    thread_dispatch();
    800032ac:	ffffe097          	auipc	ra,0xffffe
    800032b0:	f68080e7          	jalr	-152(ra) # 80001214 <_Z15thread_dispatchv>
}
    800032b4:	01813083          	ld	ra,24(sp)
    800032b8:	01013403          	ld	s0,16(sp)
    800032bc:	00813483          	ld	s1,8(sp)
    800032c0:	00013903          	ld	s2,0(sp)
    800032c4:	02010113          	addi	sp,sp,32
    800032c8:	00008067          	ret

00000000800032cc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800032cc:	fe010113          	addi	sp,sp,-32
    800032d0:	00113c23          	sd	ra,24(sp)
    800032d4:	00813823          	sd	s0,16(sp)
    800032d8:	00913423          	sd	s1,8(sp)
    800032dc:	01213023          	sd	s2,0(sp)
    800032e0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800032e4:	00000913          	li	s2,0
    800032e8:	0380006f          	j	80003320 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800032ec:	ffffe097          	auipc	ra,0xffffe
    800032f0:	f28080e7          	jalr	-216(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800032f4:	00148493          	addi	s1,s1,1
    800032f8:	000027b7          	lui	a5,0x2
    800032fc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003300:	0097ee63          	bltu	a5,s1,8000331c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003304:	00000713          	li	a4,0
    80003308:	000077b7          	lui	a5,0x7
    8000330c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003310:	fce7eee3          	bltu	a5,a4,800032ec <_ZL11workerBodyAPv+0x20>
    80003314:	00170713          	addi	a4,a4,1
    80003318:	ff1ff06f          	j	80003308 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000331c:	00190913          	addi	s2,s2,1
    80003320:	00900793          	li	a5,9
    80003324:	0527e063          	bltu	a5,s2,80003364 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003328:	00005517          	auipc	a0,0x5
    8000332c:	12050513          	addi	a0,a0,288 # 80008448 <kvmincrease+0x1358>
    80003330:	00001097          	auipc	ra,0x1
    80003334:	9f0080e7          	jalr	-1552(ra) # 80003d20 <_Z11printStringPKc>
    80003338:	00000613          	li	a2,0
    8000333c:	00a00593          	li	a1,10
    80003340:	0009051b          	sext.w	a0,s2
    80003344:	00001097          	auipc	ra,0x1
    80003348:	b8c080e7          	jalr	-1140(ra) # 80003ed0 <_Z8printIntiii>
    8000334c:	00005517          	auipc	a0,0x5
    80003350:	e2450513          	addi	a0,a0,-476 # 80008170 <kvmincrease+0x1080>
    80003354:	00001097          	auipc	ra,0x1
    80003358:	9cc080e7          	jalr	-1588(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000335c:	00000493          	li	s1,0
    80003360:	f99ff06f          	j	800032f8 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003364:	00005517          	auipc	a0,0x5
    80003368:	0ec50513          	addi	a0,a0,236 # 80008450 <kvmincrease+0x1360>
    8000336c:	00001097          	auipc	ra,0x1
    80003370:	9b4080e7          	jalr	-1612(ra) # 80003d20 <_Z11printStringPKc>
    finishedA = true;
    80003374:	00100793          	li	a5,1
    80003378:	00007717          	auipc	a4,0x7
    8000337c:	c2f703a3          	sb	a5,-985(a4) # 80009f9f <_ZL9finishedA>
}
    80003380:	01813083          	ld	ra,24(sp)
    80003384:	01013403          	ld	s0,16(sp)
    80003388:	00813483          	ld	s1,8(sp)
    8000338c:	00013903          	ld	s2,0(sp)
    80003390:	02010113          	addi	sp,sp,32
    80003394:	00008067          	ret

0000000080003398 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003398:	fd010113          	addi	sp,sp,-48
    8000339c:	02113423          	sd	ra,40(sp)
    800033a0:	02813023          	sd	s0,32(sp)
    800033a4:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800033a8:	00000613          	li	a2,0
    800033ac:	00000597          	auipc	a1,0x0
    800033b0:	f2058593          	addi	a1,a1,-224 # 800032cc <_ZL11workerBodyAPv>
    800033b4:	fd040513          	addi	a0,s0,-48
    800033b8:	ffffe097          	auipc	ra,0xffffe
    800033bc:	e04080e7          	jalr	-508(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800033c0:	00005517          	auipc	a0,0x5
    800033c4:	12050513          	addi	a0,a0,288 # 800084e0 <kvmincrease+0x13f0>
    800033c8:	00001097          	auipc	ra,0x1
    800033cc:	958080e7          	jalr	-1704(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800033d0:	00000613          	li	a2,0
    800033d4:	00000597          	auipc	a1,0x0
    800033d8:	e2458593          	addi	a1,a1,-476 # 800031f8 <_ZL11workerBodyBPv>
    800033dc:	fd840513          	addi	a0,s0,-40
    800033e0:	ffffe097          	auipc	ra,0xffffe
    800033e4:	ddc080e7          	jalr	-548(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    800033e8:	00005517          	auipc	a0,0x5
    800033ec:	11050513          	addi	a0,a0,272 # 800084f8 <kvmincrease+0x1408>
    800033f0:	00001097          	auipc	ra,0x1
    800033f4:	930080e7          	jalr	-1744(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800033f8:	00000613          	li	a2,0
    800033fc:	00000597          	auipc	a1,0x0
    80003400:	c7c58593          	addi	a1,a1,-900 # 80003078 <_ZL11workerBodyCPv>
    80003404:	fe040513          	addi	a0,s0,-32
    80003408:	ffffe097          	auipc	ra,0xffffe
    8000340c:	db4080e7          	jalr	-588(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003410:	00005517          	auipc	a0,0x5
    80003414:	10050513          	addi	a0,a0,256 # 80008510 <kvmincrease+0x1420>
    80003418:	00001097          	auipc	ra,0x1
    8000341c:	908080e7          	jalr	-1784(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003420:	00000613          	li	a2,0
    80003424:	00000597          	auipc	a1,0x0
    80003428:	b0c58593          	addi	a1,a1,-1268 # 80002f30 <_ZL11workerBodyDPv>
    8000342c:	fe840513          	addi	a0,s0,-24
    80003430:	ffffe097          	auipc	ra,0xffffe
    80003434:	d8c080e7          	jalr	-628(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80003438:	00005517          	auipc	a0,0x5
    8000343c:	0f050513          	addi	a0,a0,240 # 80008528 <kvmincrease+0x1438>
    80003440:	00001097          	auipc	ra,0x1
    80003444:	8e0080e7          	jalr	-1824(ra) # 80003d20 <_Z11printStringPKc>
    80003448:	00c0006f          	j	80003454 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000344c:	ffffe097          	auipc	ra,0xffffe
    80003450:	dc8080e7          	jalr	-568(ra) # 80001214 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003454:	00007797          	auipc	a5,0x7
    80003458:	b4b7c783          	lbu	a5,-1205(a5) # 80009f9f <_ZL9finishedA>
    8000345c:	fe0788e3          	beqz	a5,8000344c <_Z18Threads_C_API_testv+0xb4>
    80003460:	00007797          	auipc	a5,0x7
    80003464:	b3e7c783          	lbu	a5,-1218(a5) # 80009f9e <_ZL9finishedB>
    80003468:	fe0782e3          	beqz	a5,8000344c <_Z18Threads_C_API_testv+0xb4>
    8000346c:	00007797          	auipc	a5,0x7
    80003470:	b317c783          	lbu	a5,-1231(a5) # 80009f9d <_ZL9finishedC>
    80003474:	fc078ce3          	beqz	a5,8000344c <_Z18Threads_C_API_testv+0xb4>
    80003478:	00007797          	auipc	a5,0x7
    8000347c:	b247c783          	lbu	a5,-1244(a5) # 80009f9c <_ZL9finishedD>
    80003480:	fc0786e3          	beqz	a5,8000344c <_Z18Threads_C_API_testv+0xb4>
    }

}
    80003484:	02813083          	ld	ra,40(sp)
    80003488:	02013403          	ld	s0,32(sp)
    8000348c:	03010113          	addi	sp,sp,48
    80003490:	00008067          	ret

0000000080003494 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003494:	fd010113          	addi	sp,sp,-48
    80003498:	02113423          	sd	ra,40(sp)
    8000349c:	02813023          	sd	s0,32(sp)
    800034a0:	00913c23          	sd	s1,24(sp)
    800034a4:	01213823          	sd	s2,16(sp)
    800034a8:	01313423          	sd	s3,8(sp)
    800034ac:	03010413          	addi	s0,sp,48
    800034b0:	00050993          	mv	s3,a0
    800034b4:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800034b8:	00000913          	li	s2,0
    800034bc:	00c0006f          	j	800034c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800034c0:	ffffe097          	auipc	ra,0xffffe
    800034c4:	4ac080e7          	jalr	1196(ra) # 8000196c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800034c8:	ffffe097          	auipc	ra,0xffffe
    800034cc:	e20080e7          	jalr	-480(ra) # 800012e8 <_Z4getcv>
    800034d0:	0005059b          	sext.w	a1,a0
    800034d4:	01b00793          	li	a5,27
    800034d8:	02f58a63          	beq	a1,a5,8000350c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800034dc:	0084b503          	ld	a0,8(s1)
    800034e0:	00001097          	auipc	ra,0x1
    800034e4:	c64080e7          	jalr	-924(ra) # 80004144 <_ZN9BufferCPP3putEi>
        i++;
    800034e8:	0019071b          	addiw	a4,s2,1
    800034ec:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800034f0:	0004a683          	lw	a3,0(s1)
    800034f4:	0026979b          	slliw	a5,a3,0x2
    800034f8:	00d787bb          	addw	a5,a5,a3
    800034fc:	0017979b          	slliw	a5,a5,0x1
    80003500:	02f767bb          	remw	a5,a4,a5
    80003504:	fc0792e3          	bnez	a5,800034c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80003508:	fb9ff06f          	j	800034c0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000350c:	00100793          	li	a5,1
    80003510:	00007717          	auipc	a4,0x7
    80003514:	a8f72823          	sw	a5,-1392(a4) # 80009fa0 <_ZL9threadEnd>
    td->buffer->put('!');
    80003518:	0209b783          	ld	a5,32(s3)
    8000351c:	02100593          	li	a1,33
    80003520:	0087b503          	ld	a0,8(a5)
    80003524:	00001097          	auipc	ra,0x1
    80003528:	c20080e7          	jalr	-992(ra) # 80004144 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000352c:	0104b503          	ld	a0,16(s1)
    80003530:	ffffe097          	auipc	ra,0xffffe
    80003534:	4f0080e7          	jalr	1264(ra) # 80001a20 <_ZN9Semaphore6signalEv>
}
    80003538:	02813083          	ld	ra,40(sp)
    8000353c:	02013403          	ld	s0,32(sp)
    80003540:	01813483          	ld	s1,24(sp)
    80003544:	01013903          	ld	s2,16(sp)
    80003548:	00813983          	ld	s3,8(sp)
    8000354c:	03010113          	addi	sp,sp,48
    80003550:	00008067          	ret

0000000080003554 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003554:	fe010113          	addi	sp,sp,-32
    80003558:	00113c23          	sd	ra,24(sp)
    8000355c:	00813823          	sd	s0,16(sp)
    80003560:	00913423          	sd	s1,8(sp)
    80003564:	01213023          	sd	s2,0(sp)
    80003568:	02010413          	addi	s0,sp,32
    8000356c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003570:	00000913          	li	s2,0
    80003574:	00c0006f          	j	80003580 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003578:	ffffe097          	auipc	ra,0xffffe
    8000357c:	3f4080e7          	jalr	1012(ra) # 8000196c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80003580:	00007797          	auipc	a5,0x7
    80003584:	a207a783          	lw	a5,-1504(a5) # 80009fa0 <_ZL9threadEnd>
    80003588:	02079e63          	bnez	a5,800035c4 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000358c:	0004a583          	lw	a1,0(s1)
    80003590:	0305859b          	addiw	a1,a1,48
    80003594:	0084b503          	ld	a0,8(s1)
    80003598:	00001097          	auipc	ra,0x1
    8000359c:	bac080e7          	jalr	-1108(ra) # 80004144 <_ZN9BufferCPP3putEi>
        i++;
    800035a0:	0019071b          	addiw	a4,s2,1
    800035a4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800035a8:	0004a683          	lw	a3,0(s1)
    800035ac:	0026979b          	slliw	a5,a3,0x2
    800035b0:	00d787bb          	addw	a5,a5,a3
    800035b4:	0017979b          	slliw	a5,a5,0x1
    800035b8:	02f767bb          	remw	a5,a4,a5
    800035bc:	fc0792e3          	bnez	a5,80003580 <_ZN12ProducerSync8producerEPv+0x2c>
    800035c0:	fb9ff06f          	j	80003578 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800035c4:	0104b503          	ld	a0,16(s1)
    800035c8:	ffffe097          	auipc	ra,0xffffe
    800035cc:	458080e7          	jalr	1112(ra) # 80001a20 <_ZN9Semaphore6signalEv>
}
    800035d0:	01813083          	ld	ra,24(sp)
    800035d4:	01013403          	ld	s0,16(sp)
    800035d8:	00813483          	ld	s1,8(sp)
    800035dc:	00013903          	ld	s2,0(sp)
    800035e0:	02010113          	addi	sp,sp,32
    800035e4:	00008067          	ret

00000000800035e8 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800035e8:	fd010113          	addi	sp,sp,-48
    800035ec:	02113423          	sd	ra,40(sp)
    800035f0:	02813023          	sd	s0,32(sp)
    800035f4:	00913c23          	sd	s1,24(sp)
    800035f8:	01213823          	sd	s2,16(sp)
    800035fc:	01313423          	sd	s3,8(sp)
    80003600:	01413023          	sd	s4,0(sp)
    80003604:	03010413          	addi	s0,sp,48
    80003608:	00050993          	mv	s3,a0
    8000360c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003610:	00000a13          	li	s4,0
    80003614:	01c0006f          	j	80003630 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80003618:	ffffe097          	auipc	ra,0xffffe
    8000361c:	354080e7          	jalr	852(ra) # 8000196c <_ZN6Thread8dispatchEv>
    80003620:	0500006f          	j	80003670 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003624:	00a00513          	li	a0,10
    80003628:	ffffe097          	auipc	ra,0xffffe
    8000362c:	cec080e7          	jalr	-788(ra) # 80001314 <_Z4putcc>
    while (!threadEnd) {
    80003630:	00007797          	auipc	a5,0x7
    80003634:	9707a783          	lw	a5,-1680(a5) # 80009fa0 <_ZL9threadEnd>
    80003638:	06079263          	bnez	a5,8000369c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    8000363c:	00893503          	ld	a0,8(s2)
    80003640:	00001097          	auipc	ra,0x1
    80003644:	b94080e7          	jalr	-1132(ra) # 800041d4 <_ZN9BufferCPP3getEv>
        i++;
    80003648:	001a049b          	addiw	s1,s4,1
    8000364c:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003650:	0ff57513          	andi	a0,a0,255
    80003654:	ffffe097          	auipc	ra,0xffffe
    80003658:	cc0080e7          	jalr	-832(ra) # 80001314 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000365c:	00092703          	lw	a4,0(s2)
    80003660:	0027179b          	slliw	a5,a4,0x2
    80003664:	00e787bb          	addw	a5,a5,a4
    80003668:	02f4e7bb          	remw	a5,s1,a5
    8000366c:	fa0786e3          	beqz	a5,80003618 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003670:	05000793          	li	a5,80
    80003674:	02f4e4bb          	remw	s1,s1,a5
    80003678:	fa049ce3          	bnez	s1,80003630 <_ZN12ConsumerSync8consumerEPv+0x48>
    8000367c:	fa9ff06f          	j	80003624 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003680:	0209b783          	ld	a5,32(s3)
    80003684:	0087b503          	ld	a0,8(a5)
    80003688:	00001097          	auipc	ra,0x1
    8000368c:	b4c080e7          	jalr	-1204(ra) # 800041d4 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003690:	0ff57513          	andi	a0,a0,255
    80003694:	ffffe097          	auipc	ra,0xffffe
    80003698:	228080e7          	jalr	552(ra) # 800018bc <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    8000369c:	0209b783          	ld	a5,32(s3)
    800036a0:	0087b503          	ld	a0,8(a5)
    800036a4:	00001097          	auipc	ra,0x1
    800036a8:	bbc080e7          	jalr	-1092(ra) # 80004260 <_ZN9BufferCPP6getCntEv>
    800036ac:	fca04ae3          	bgtz	a0,80003680 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    800036b0:	01093503          	ld	a0,16(s2)
    800036b4:	ffffe097          	auipc	ra,0xffffe
    800036b8:	36c080e7          	jalr	876(ra) # 80001a20 <_ZN9Semaphore6signalEv>
}
    800036bc:	02813083          	ld	ra,40(sp)
    800036c0:	02013403          	ld	s0,32(sp)
    800036c4:	01813483          	ld	s1,24(sp)
    800036c8:	01013903          	ld	s2,16(sp)
    800036cc:	00813983          	ld	s3,8(sp)
    800036d0:	00013a03          	ld	s4,0(sp)
    800036d4:	03010113          	addi	sp,sp,48
    800036d8:	00008067          	ret

00000000800036dc <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800036dc:	f8010113          	addi	sp,sp,-128
    800036e0:	06113c23          	sd	ra,120(sp)
    800036e4:	06813823          	sd	s0,112(sp)
    800036e8:	06913423          	sd	s1,104(sp)
    800036ec:	07213023          	sd	s2,96(sp)
    800036f0:	05313c23          	sd	s3,88(sp)
    800036f4:	05413823          	sd	s4,80(sp)
    800036f8:	05513423          	sd	s5,72(sp)
    800036fc:	05613023          	sd	s6,64(sp)
    80003700:	03713c23          	sd	s7,56(sp)
    80003704:	03813823          	sd	s8,48(sp)
    80003708:	03913423          	sd	s9,40(sp)
    8000370c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003710:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003714:	00005517          	auipc	a0,0x5
    80003718:	c4c50513          	addi	a0,a0,-948 # 80008360 <kvmincrease+0x1270>
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	604080e7          	jalr	1540(ra) # 80003d20 <_Z11printStringPKc>
    getString(input, 30);
    80003724:	01e00593          	li	a1,30
    80003728:	f8040493          	addi	s1,s0,-128
    8000372c:	00048513          	mv	a0,s1
    80003730:	00000097          	auipc	ra,0x0
    80003734:	678080e7          	jalr	1656(ra) # 80003da8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003738:	00048513          	mv	a0,s1
    8000373c:	00000097          	auipc	ra,0x0
    80003740:	744080e7          	jalr	1860(ra) # 80003e80 <_Z11stringToIntPKc>
    80003744:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003748:	00005517          	auipc	a0,0x5
    8000374c:	c3850513          	addi	a0,a0,-968 # 80008380 <kvmincrease+0x1290>
    80003750:	00000097          	auipc	ra,0x0
    80003754:	5d0080e7          	jalr	1488(ra) # 80003d20 <_Z11printStringPKc>
    getString(input, 30);
    80003758:	01e00593          	li	a1,30
    8000375c:	00048513          	mv	a0,s1
    80003760:	00000097          	auipc	ra,0x0
    80003764:	648080e7          	jalr	1608(ra) # 80003da8 <_Z9getStringPci>
    n = stringToInt(input);
    80003768:	00048513          	mv	a0,s1
    8000376c:	00000097          	auipc	ra,0x0
    80003770:	714080e7          	jalr	1812(ra) # 80003e80 <_Z11stringToIntPKc>
    80003774:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003778:	00005517          	auipc	a0,0x5
    8000377c:	c2850513          	addi	a0,a0,-984 # 800083a0 <kvmincrease+0x12b0>
    80003780:	00000097          	auipc	ra,0x0
    80003784:	5a0080e7          	jalr	1440(ra) # 80003d20 <_Z11printStringPKc>
    80003788:	00000613          	li	a2,0
    8000378c:	00a00593          	li	a1,10
    80003790:	00090513          	mv	a0,s2
    80003794:	00000097          	auipc	ra,0x0
    80003798:	73c080e7          	jalr	1852(ra) # 80003ed0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000379c:	00005517          	auipc	a0,0x5
    800037a0:	c1c50513          	addi	a0,a0,-996 # 800083b8 <kvmincrease+0x12c8>
    800037a4:	00000097          	auipc	ra,0x0
    800037a8:	57c080e7          	jalr	1404(ra) # 80003d20 <_Z11printStringPKc>
    800037ac:	00000613          	li	a2,0
    800037b0:	00a00593          	li	a1,10
    800037b4:	00048513          	mv	a0,s1
    800037b8:	00000097          	auipc	ra,0x0
    800037bc:	718080e7          	jalr	1816(ra) # 80003ed0 <_Z8printIntiii>
    printString(".\n");
    800037c0:	00005517          	auipc	a0,0x5
    800037c4:	c1050513          	addi	a0,a0,-1008 # 800083d0 <kvmincrease+0x12e0>
    800037c8:	00000097          	auipc	ra,0x0
    800037cc:	558080e7          	jalr	1368(ra) # 80003d20 <_Z11printStringPKc>
    if(threadNum > n) {
    800037d0:	0324c463          	blt	s1,s2,800037f8 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800037d4:	03205c63          	blez	s2,8000380c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800037d8:	03800513          	li	a0,56
    800037dc:	ffffe097          	auipc	ra,0xffffe
    800037e0:	f34080e7          	jalr	-204(ra) # 80001710 <_Znwm>
    800037e4:	00050a93          	mv	s5,a0
    800037e8:	00048593          	mv	a1,s1
    800037ec:	00001097          	auipc	ra,0x1
    800037f0:	804080e7          	jalr	-2044(ra) # 80003ff0 <_ZN9BufferCPPC1Ei>
    800037f4:	0300006f          	j	80003824 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800037f8:	00005517          	auipc	a0,0x5
    800037fc:	be050513          	addi	a0,a0,-1056 # 800083d8 <kvmincrease+0x12e8>
    80003800:	00000097          	auipc	ra,0x0
    80003804:	520080e7          	jalr	1312(ra) # 80003d20 <_Z11printStringPKc>
        return;
    80003808:	0140006f          	j	8000381c <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000380c:	00005517          	auipc	a0,0x5
    80003810:	c0c50513          	addi	a0,a0,-1012 # 80008418 <kvmincrease+0x1328>
    80003814:	00000097          	auipc	ra,0x0
    80003818:	50c080e7          	jalr	1292(ra) # 80003d20 <_Z11printStringPKc>
        return;
    8000381c:	000b8113          	mv	sp,s7
    80003820:	2380006f          	j	80003a58 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003824:	01000513          	li	a0,16
    80003828:	ffffe097          	auipc	ra,0xffffe
    8000382c:	ee8080e7          	jalr	-280(ra) # 80001710 <_Znwm>
    80003830:	00050493          	mv	s1,a0
    80003834:	00000593          	li	a1,0
    80003838:	ffffe097          	auipc	ra,0xffffe
    8000383c:	214080e7          	jalr	532(ra) # 80001a4c <_ZN9SemaphoreC1Ej>
    80003840:	00006797          	auipc	a5,0x6
    80003844:	7697b423          	sd	s1,1896(a5) # 80009fa8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003848:	00391793          	slli	a5,s2,0x3
    8000384c:	00f78793          	addi	a5,a5,15
    80003850:	ff07f793          	andi	a5,a5,-16
    80003854:	40f10133          	sub	sp,sp,a5
    80003858:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000385c:	0019071b          	addiw	a4,s2,1
    80003860:	00171793          	slli	a5,a4,0x1
    80003864:	00e787b3          	add	a5,a5,a4
    80003868:	00379793          	slli	a5,a5,0x3
    8000386c:	00f78793          	addi	a5,a5,15
    80003870:	ff07f793          	andi	a5,a5,-16
    80003874:	40f10133          	sub	sp,sp,a5
    80003878:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000387c:	00191c13          	slli	s8,s2,0x1
    80003880:	012c07b3          	add	a5,s8,s2
    80003884:	00379793          	slli	a5,a5,0x3
    80003888:	00fa07b3          	add	a5,s4,a5
    8000388c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003890:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003894:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003898:	02800513          	li	a0,40
    8000389c:	ffffe097          	auipc	ra,0xffffe
    800038a0:	e74080e7          	jalr	-396(ra) # 80001710 <_Znwm>
    800038a4:	00050b13          	mv	s6,a0
    800038a8:	012c0c33          	add	s8,s8,s2
    800038ac:	003c1c13          	slli	s8,s8,0x3
    800038b0:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    800038b4:	ffffe097          	auipc	ra,0xffffe
    800038b8:	0e0080e7          	jalr	224(ra) # 80001994 <_ZN6ThreadC1Ev>
    800038bc:	00006797          	auipc	a5,0x6
    800038c0:	61478793          	addi	a5,a5,1556 # 80009ed0 <_ZTV12ConsumerSync+0x10>
    800038c4:	00fb3023          	sd	a5,0(s6)
    800038c8:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    800038cc:	000b0513          	mv	a0,s6
    800038d0:	ffffe097          	auipc	ra,0xffffe
    800038d4:	068080e7          	jalr	104(ra) # 80001938 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800038d8:	00000493          	li	s1,0
    800038dc:	0380006f          	j	80003914 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800038e0:	00006797          	auipc	a5,0x6
    800038e4:	5c878793          	addi	a5,a5,1480 # 80009ea8 <_ZTV12ProducerSync+0x10>
    800038e8:	00fcb023          	sd	a5,0(s9)
    800038ec:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    800038f0:	00349793          	slli	a5,s1,0x3
    800038f4:	00f987b3          	add	a5,s3,a5
    800038f8:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800038fc:	00349793          	slli	a5,s1,0x3
    80003900:	00f987b3          	add	a5,s3,a5
    80003904:	0007b503          	ld	a0,0(a5)
    80003908:	ffffe097          	auipc	ra,0xffffe
    8000390c:	030080e7          	jalr	48(ra) # 80001938 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003910:	0014849b          	addiw	s1,s1,1
    80003914:	0b24d063          	bge	s1,s2,800039b4 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003918:	00149793          	slli	a5,s1,0x1
    8000391c:	009787b3          	add	a5,a5,s1
    80003920:	00379793          	slli	a5,a5,0x3
    80003924:	00fa07b3          	add	a5,s4,a5
    80003928:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000392c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003930:	00006717          	auipc	a4,0x6
    80003934:	67873703          	ld	a4,1656(a4) # 80009fa8 <_ZL10waitForAll>
    80003938:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    8000393c:	02905863          	blez	s1,8000396c <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003940:	02800513          	li	a0,40
    80003944:	ffffe097          	auipc	ra,0xffffe
    80003948:	dcc080e7          	jalr	-564(ra) # 80001710 <_Znwm>
    8000394c:	00050c93          	mv	s9,a0
    80003950:	00149c13          	slli	s8,s1,0x1
    80003954:	009c0c33          	add	s8,s8,s1
    80003958:	003c1c13          	slli	s8,s8,0x3
    8000395c:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003960:	ffffe097          	auipc	ra,0xffffe
    80003964:	034080e7          	jalr	52(ra) # 80001994 <_ZN6ThreadC1Ev>
    80003968:	f79ff06f          	j	800038e0 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    8000396c:	02800513          	li	a0,40
    80003970:	ffffe097          	auipc	ra,0xffffe
    80003974:	da0080e7          	jalr	-608(ra) # 80001710 <_Znwm>
    80003978:	00050c93          	mv	s9,a0
    8000397c:	00149c13          	slli	s8,s1,0x1
    80003980:	009c0c33          	add	s8,s8,s1
    80003984:	003c1c13          	slli	s8,s8,0x3
    80003988:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    8000398c:	ffffe097          	auipc	ra,0xffffe
    80003990:	008080e7          	jalr	8(ra) # 80001994 <_ZN6ThreadC1Ev>
    80003994:	00006797          	auipc	a5,0x6
    80003998:	4ec78793          	addi	a5,a5,1260 # 80009e80 <_ZTV16ProducerKeyboard+0x10>
    8000399c:	00fcb023          	sd	a5,0(s9)
    800039a0:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    800039a4:	00349793          	slli	a5,s1,0x3
    800039a8:	00f987b3          	add	a5,s3,a5
    800039ac:	0197b023          	sd	s9,0(a5)
    800039b0:	f4dff06f          	j	800038fc <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    800039b4:	ffffe097          	auipc	ra,0xffffe
    800039b8:	fb8080e7          	jalr	-72(ra) # 8000196c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800039bc:	00000493          	li	s1,0
    800039c0:	00994e63          	blt	s2,s1,800039dc <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    800039c4:	00006517          	auipc	a0,0x6
    800039c8:	5e453503          	ld	a0,1508(a0) # 80009fa8 <_ZL10waitForAll>
    800039cc:	ffffe097          	auipc	ra,0xffffe
    800039d0:	028080e7          	jalr	40(ra) # 800019f4 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800039d4:	0014849b          	addiw	s1,s1,1
    800039d8:	fe9ff06f          	j	800039c0 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    800039dc:	00000493          	li	s1,0
    800039e0:	0080006f          	j	800039e8 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    800039e4:	0014849b          	addiw	s1,s1,1
    800039e8:	0324d263          	bge	s1,s2,80003a0c <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    800039ec:	00349793          	slli	a5,s1,0x3
    800039f0:	00f987b3          	add	a5,s3,a5
    800039f4:	0007b503          	ld	a0,0(a5)
    800039f8:	fe0506e3          	beqz	a0,800039e4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    800039fc:	00053783          	ld	a5,0(a0)
    80003a00:	0087b783          	ld	a5,8(a5)
    80003a04:	000780e7          	jalr	a5
    80003a08:	fddff06f          	j	800039e4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003a0c:	000b0a63          	beqz	s6,80003a20 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003a10:	000b3783          	ld	a5,0(s6)
    80003a14:	0087b783          	ld	a5,8(a5)
    80003a18:	000b0513          	mv	a0,s6
    80003a1c:	000780e7          	jalr	a5
    delete waitForAll;
    80003a20:	00006517          	auipc	a0,0x6
    80003a24:	58853503          	ld	a0,1416(a0) # 80009fa8 <_ZL10waitForAll>
    80003a28:	00050863          	beqz	a0,80003a38 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003a2c:	00053783          	ld	a5,0(a0)
    80003a30:	0087b783          	ld	a5,8(a5)
    80003a34:	000780e7          	jalr	a5
    delete buffer;
    80003a38:	000a8e63          	beqz	s5,80003a54 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003a3c:	000a8513          	mv	a0,s5
    80003a40:	00001097          	auipc	ra,0x1
    80003a44:	8a8080e7          	jalr	-1880(ra) # 800042e8 <_ZN9BufferCPPD1Ev>
    80003a48:	000a8513          	mv	a0,s5
    80003a4c:	ffffe097          	auipc	ra,0xffffe
    80003a50:	d14080e7          	jalr	-748(ra) # 80001760 <_ZdlPv>
    80003a54:	000b8113          	mv	sp,s7

}
    80003a58:	f8040113          	addi	sp,s0,-128
    80003a5c:	07813083          	ld	ra,120(sp)
    80003a60:	07013403          	ld	s0,112(sp)
    80003a64:	06813483          	ld	s1,104(sp)
    80003a68:	06013903          	ld	s2,96(sp)
    80003a6c:	05813983          	ld	s3,88(sp)
    80003a70:	05013a03          	ld	s4,80(sp)
    80003a74:	04813a83          	ld	s5,72(sp)
    80003a78:	04013b03          	ld	s6,64(sp)
    80003a7c:	03813b83          	ld	s7,56(sp)
    80003a80:	03013c03          	ld	s8,48(sp)
    80003a84:	02813c83          	ld	s9,40(sp)
    80003a88:	08010113          	addi	sp,sp,128
    80003a8c:	00008067          	ret
    80003a90:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003a94:	000a8513          	mv	a0,s5
    80003a98:	ffffe097          	auipc	ra,0xffffe
    80003a9c:	cc8080e7          	jalr	-824(ra) # 80001760 <_ZdlPv>
    80003aa0:	00048513          	mv	a0,s1
    80003aa4:	00007097          	auipc	ra,0x7
    80003aa8:	5e4080e7          	jalr	1508(ra) # 8000b088 <_Unwind_Resume>
    80003aac:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003ab0:	00048513          	mv	a0,s1
    80003ab4:	ffffe097          	auipc	ra,0xffffe
    80003ab8:	cac080e7          	jalr	-852(ra) # 80001760 <_ZdlPv>
    80003abc:	00090513          	mv	a0,s2
    80003ac0:	00007097          	auipc	ra,0x7
    80003ac4:	5c8080e7          	jalr	1480(ra) # 8000b088 <_Unwind_Resume>
    80003ac8:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003acc:	000b0513          	mv	a0,s6
    80003ad0:	ffffe097          	auipc	ra,0xffffe
    80003ad4:	c90080e7          	jalr	-880(ra) # 80001760 <_ZdlPv>
    80003ad8:	00048513          	mv	a0,s1
    80003adc:	00007097          	auipc	ra,0x7
    80003ae0:	5ac080e7          	jalr	1452(ra) # 8000b088 <_Unwind_Resume>
    80003ae4:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003ae8:	000c8513          	mv	a0,s9
    80003aec:	ffffe097          	auipc	ra,0xffffe
    80003af0:	c74080e7          	jalr	-908(ra) # 80001760 <_ZdlPv>
    80003af4:	00048513          	mv	a0,s1
    80003af8:	00007097          	auipc	ra,0x7
    80003afc:	590080e7          	jalr	1424(ra) # 8000b088 <_Unwind_Resume>
    80003b00:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003b04:	000c8513          	mv	a0,s9
    80003b08:	ffffe097          	auipc	ra,0xffffe
    80003b0c:	c58080e7          	jalr	-936(ra) # 80001760 <_ZdlPv>
    80003b10:	00048513          	mv	a0,s1
    80003b14:	00007097          	auipc	ra,0x7
    80003b18:	574080e7          	jalr	1396(ra) # 8000b088 <_Unwind_Resume>

0000000080003b1c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003b1c:	ff010113          	addi	sp,sp,-16
    80003b20:	00113423          	sd	ra,8(sp)
    80003b24:	00813023          	sd	s0,0(sp)
    80003b28:	01010413          	addi	s0,sp,16
    80003b2c:	00006797          	auipc	a5,0x6
    80003b30:	3a478793          	addi	a5,a5,932 # 80009ed0 <_ZTV12ConsumerSync+0x10>
    80003b34:	00f53023          	sd	a5,0(a0)
    80003b38:	ffffe097          	auipc	ra,0xffffe
    80003b3c:	c78080e7          	jalr	-904(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003b40:	00813083          	ld	ra,8(sp)
    80003b44:	00013403          	ld	s0,0(sp)
    80003b48:	01010113          	addi	sp,sp,16
    80003b4c:	00008067          	ret

0000000080003b50 <_ZN12ConsumerSyncD0Ev>:
    80003b50:	fe010113          	addi	sp,sp,-32
    80003b54:	00113c23          	sd	ra,24(sp)
    80003b58:	00813823          	sd	s0,16(sp)
    80003b5c:	00913423          	sd	s1,8(sp)
    80003b60:	02010413          	addi	s0,sp,32
    80003b64:	00050493          	mv	s1,a0
    80003b68:	00006797          	auipc	a5,0x6
    80003b6c:	36878793          	addi	a5,a5,872 # 80009ed0 <_ZTV12ConsumerSync+0x10>
    80003b70:	00f53023          	sd	a5,0(a0)
    80003b74:	ffffe097          	auipc	ra,0xffffe
    80003b78:	c3c080e7          	jalr	-964(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003b7c:	00048513          	mv	a0,s1
    80003b80:	ffffe097          	auipc	ra,0xffffe
    80003b84:	be0080e7          	jalr	-1056(ra) # 80001760 <_ZdlPv>
    80003b88:	01813083          	ld	ra,24(sp)
    80003b8c:	01013403          	ld	s0,16(sp)
    80003b90:	00813483          	ld	s1,8(sp)
    80003b94:	02010113          	addi	sp,sp,32
    80003b98:	00008067          	ret

0000000080003b9c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003b9c:	ff010113          	addi	sp,sp,-16
    80003ba0:	00113423          	sd	ra,8(sp)
    80003ba4:	00813023          	sd	s0,0(sp)
    80003ba8:	01010413          	addi	s0,sp,16
    80003bac:	00006797          	auipc	a5,0x6
    80003bb0:	2fc78793          	addi	a5,a5,764 # 80009ea8 <_ZTV12ProducerSync+0x10>
    80003bb4:	00f53023          	sd	a5,0(a0)
    80003bb8:	ffffe097          	auipc	ra,0xffffe
    80003bbc:	bf8080e7          	jalr	-1032(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003bc0:	00813083          	ld	ra,8(sp)
    80003bc4:	00013403          	ld	s0,0(sp)
    80003bc8:	01010113          	addi	sp,sp,16
    80003bcc:	00008067          	ret

0000000080003bd0 <_ZN12ProducerSyncD0Ev>:
    80003bd0:	fe010113          	addi	sp,sp,-32
    80003bd4:	00113c23          	sd	ra,24(sp)
    80003bd8:	00813823          	sd	s0,16(sp)
    80003bdc:	00913423          	sd	s1,8(sp)
    80003be0:	02010413          	addi	s0,sp,32
    80003be4:	00050493          	mv	s1,a0
    80003be8:	00006797          	auipc	a5,0x6
    80003bec:	2c078793          	addi	a5,a5,704 # 80009ea8 <_ZTV12ProducerSync+0x10>
    80003bf0:	00f53023          	sd	a5,0(a0)
    80003bf4:	ffffe097          	auipc	ra,0xffffe
    80003bf8:	bbc080e7          	jalr	-1092(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003bfc:	00048513          	mv	a0,s1
    80003c00:	ffffe097          	auipc	ra,0xffffe
    80003c04:	b60080e7          	jalr	-1184(ra) # 80001760 <_ZdlPv>
    80003c08:	01813083          	ld	ra,24(sp)
    80003c0c:	01013403          	ld	s0,16(sp)
    80003c10:	00813483          	ld	s1,8(sp)
    80003c14:	02010113          	addi	sp,sp,32
    80003c18:	00008067          	ret

0000000080003c1c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003c1c:	ff010113          	addi	sp,sp,-16
    80003c20:	00113423          	sd	ra,8(sp)
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	01010413          	addi	s0,sp,16
    80003c2c:	00006797          	auipc	a5,0x6
    80003c30:	25478793          	addi	a5,a5,596 # 80009e80 <_ZTV16ProducerKeyboard+0x10>
    80003c34:	00f53023          	sd	a5,0(a0)
    80003c38:	ffffe097          	auipc	ra,0xffffe
    80003c3c:	b78080e7          	jalr	-1160(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003c40:	00813083          	ld	ra,8(sp)
    80003c44:	00013403          	ld	s0,0(sp)
    80003c48:	01010113          	addi	sp,sp,16
    80003c4c:	00008067          	ret

0000000080003c50 <_ZN16ProducerKeyboardD0Ev>:
    80003c50:	fe010113          	addi	sp,sp,-32
    80003c54:	00113c23          	sd	ra,24(sp)
    80003c58:	00813823          	sd	s0,16(sp)
    80003c5c:	00913423          	sd	s1,8(sp)
    80003c60:	02010413          	addi	s0,sp,32
    80003c64:	00050493          	mv	s1,a0
    80003c68:	00006797          	auipc	a5,0x6
    80003c6c:	21878793          	addi	a5,a5,536 # 80009e80 <_ZTV16ProducerKeyboard+0x10>
    80003c70:	00f53023          	sd	a5,0(a0)
    80003c74:	ffffe097          	auipc	ra,0xffffe
    80003c78:	b3c080e7          	jalr	-1220(ra) # 800017b0 <_ZN6ThreadD1Ev>
    80003c7c:	00048513          	mv	a0,s1
    80003c80:	ffffe097          	auipc	ra,0xffffe
    80003c84:	ae0080e7          	jalr	-1312(ra) # 80001760 <_ZdlPv>
    80003c88:	01813083          	ld	ra,24(sp)
    80003c8c:	01013403          	ld	s0,16(sp)
    80003c90:	00813483          	ld	s1,8(sp)
    80003c94:	02010113          	addi	sp,sp,32
    80003c98:	00008067          	ret

0000000080003c9c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003c9c:	ff010113          	addi	sp,sp,-16
    80003ca0:	00113423          	sd	ra,8(sp)
    80003ca4:	00813023          	sd	s0,0(sp)
    80003ca8:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003cac:	02053583          	ld	a1,32(a0)
    80003cb0:	fffff097          	auipc	ra,0xfffff
    80003cb4:	7e4080e7          	jalr	2020(ra) # 80003494 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003cb8:	00813083          	ld	ra,8(sp)
    80003cbc:	00013403          	ld	s0,0(sp)
    80003cc0:	01010113          	addi	sp,sp,16
    80003cc4:	00008067          	ret

0000000080003cc8 <_ZN12ProducerSync3runEv>:
    void run() override {
    80003cc8:	ff010113          	addi	sp,sp,-16
    80003ccc:	00113423          	sd	ra,8(sp)
    80003cd0:	00813023          	sd	s0,0(sp)
    80003cd4:	01010413          	addi	s0,sp,16
        producer(td);
    80003cd8:	02053583          	ld	a1,32(a0)
    80003cdc:	00000097          	auipc	ra,0x0
    80003ce0:	878080e7          	jalr	-1928(ra) # 80003554 <_ZN12ProducerSync8producerEPv>
    }
    80003ce4:	00813083          	ld	ra,8(sp)
    80003ce8:	00013403          	ld	s0,0(sp)
    80003cec:	01010113          	addi	sp,sp,16
    80003cf0:	00008067          	ret

0000000080003cf4 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003cf4:	ff010113          	addi	sp,sp,-16
    80003cf8:	00113423          	sd	ra,8(sp)
    80003cfc:	00813023          	sd	s0,0(sp)
    80003d00:	01010413          	addi	s0,sp,16
        consumer(td);
    80003d04:	02053583          	ld	a1,32(a0)
    80003d08:	00000097          	auipc	ra,0x0
    80003d0c:	8e0080e7          	jalr	-1824(ra) # 800035e8 <_ZN12ConsumerSync8consumerEPv>
    }
    80003d10:	00813083          	ld	ra,8(sp)
    80003d14:	00013403          	ld	s0,0(sp)
    80003d18:	01010113          	addi	sp,sp,16
    80003d1c:	00008067          	ret

0000000080003d20 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003d20:	fe010113          	addi	sp,sp,-32
    80003d24:	00113c23          	sd	ra,24(sp)
    80003d28:	00813823          	sd	s0,16(sp)
    80003d2c:	00913423          	sd	s1,8(sp)
    80003d30:	02010413          	addi	s0,sp,32
    80003d34:	00050493          	mv	s1,a0
    LOCK();
    80003d38:	00100613          	li	a2,1
    80003d3c:	00000593          	li	a1,0
    80003d40:	00006517          	auipc	a0,0x6
    80003d44:	27050513          	addi	a0,a0,624 # 80009fb0 <lockPrint>
    80003d48:	ffffd097          	auipc	ra,0xffffd
    80003d4c:	2b8080e7          	jalr	696(ra) # 80001000 <copy_and_swap>
    80003d50:	00050863          	beqz	a0,80003d60 <_Z11printStringPKc+0x40>
    80003d54:	ffffd097          	auipc	ra,0xffffd
    80003d58:	4c0080e7          	jalr	1216(ra) # 80001214 <_Z15thread_dispatchv>
    80003d5c:	fddff06f          	j	80003d38 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003d60:	0004c503          	lbu	a0,0(s1)
    80003d64:	00050a63          	beqz	a0,80003d78 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003d68:	ffffd097          	auipc	ra,0xffffd
    80003d6c:	5ac080e7          	jalr	1452(ra) # 80001314 <_Z4putcc>
        string++;
    80003d70:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003d74:	fedff06f          	j	80003d60 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003d78:	00000613          	li	a2,0
    80003d7c:	00100593          	li	a1,1
    80003d80:	00006517          	auipc	a0,0x6
    80003d84:	23050513          	addi	a0,a0,560 # 80009fb0 <lockPrint>
    80003d88:	ffffd097          	auipc	ra,0xffffd
    80003d8c:	278080e7          	jalr	632(ra) # 80001000 <copy_and_swap>
    80003d90:	fe0514e3          	bnez	a0,80003d78 <_Z11printStringPKc+0x58>
}
    80003d94:	01813083          	ld	ra,24(sp)
    80003d98:	01013403          	ld	s0,16(sp)
    80003d9c:	00813483          	ld	s1,8(sp)
    80003da0:	02010113          	addi	sp,sp,32
    80003da4:	00008067          	ret

0000000080003da8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003da8:	fd010113          	addi	sp,sp,-48
    80003dac:	02113423          	sd	ra,40(sp)
    80003db0:	02813023          	sd	s0,32(sp)
    80003db4:	00913c23          	sd	s1,24(sp)
    80003db8:	01213823          	sd	s2,16(sp)
    80003dbc:	01313423          	sd	s3,8(sp)
    80003dc0:	01413023          	sd	s4,0(sp)
    80003dc4:	03010413          	addi	s0,sp,48
    80003dc8:	00050993          	mv	s3,a0
    80003dcc:	00058a13          	mv	s4,a1
    LOCK();
    80003dd0:	00100613          	li	a2,1
    80003dd4:	00000593          	li	a1,0
    80003dd8:	00006517          	auipc	a0,0x6
    80003ddc:	1d850513          	addi	a0,a0,472 # 80009fb0 <lockPrint>
    80003de0:	ffffd097          	auipc	ra,0xffffd
    80003de4:	220080e7          	jalr	544(ra) # 80001000 <copy_and_swap>
    80003de8:	00050863          	beqz	a0,80003df8 <_Z9getStringPci+0x50>
    80003dec:	ffffd097          	auipc	ra,0xffffd
    80003df0:	428080e7          	jalr	1064(ra) # 80001214 <_Z15thread_dispatchv>
    80003df4:	fddff06f          	j	80003dd0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003df8:	00000913          	li	s2,0
    80003dfc:	00090493          	mv	s1,s2
    80003e00:	0019091b          	addiw	s2,s2,1
    80003e04:	03495a63          	bge	s2,s4,80003e38 <_Z9getStringPci+0x90>
        cc = getc();
    80003e08:	ffffd097          	auipc	ra,0xffffd
    80003e0c:	4e0080e7          	jalr	1248(ra) # 800012e8 <_Z4getcv>
        if(cc < 1)
    80003e10:	02050463          	beqz	a0,80003e38 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003e14:	009984b3          	add	s1,s3,s1
    80003e18:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003e1c:	00a00793          	li	a5,10
    80003e20:	00f50a63          	beq	a0,a5,80003e34 <_Z9getStringPci+0x8c>
    80003e24:	00d00793          	li	a5,13
    80003e28:	fcf51ae3          	bne	a0,a5,80003dfc <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003e2c:	00090493          	mv	s1,s2
    80003e30:	0080006f          	j	80003e38 <_Z9getStringPci+0x90>
    80003e34:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003e38:	009984b3          	add	s1,s3,s1
    80003e3c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003e40:	00000613          	li	a2,0
    80003e44:	00100593          	li	a1,1
    80003e48:	00006517          	auipc	a0,0x6
    80003e4c:	16850513          	addi	a0,a0,360 # 80009fb0 <lockPrint>
    80003e50:	ffffd097          	auipc	ra,0xffffd
    80003e54:	1b0080e7          	jalr	432(ra) # 80001000 <copy_and_swap>
    80003e58:	fe0514e3          	bnez	a0,80003e40 <_Z9getStringPci+0x98>
    return buf;
}
    80003e5c:	00098513          	mv	a0,s3
    80003e60:	02813083          	ld	ra,40(sp)
    80003e64:	02013403          	ld	s0,32(sp)
    80003e68:	01813483          	ld	s1,24(sp)
    80003e6c:	01013903          	ld	s2,16(sp)
    80003e70:	00813983          	ld	s3,8(sp)
    80003e74:	00013a03          	ld	s4,0(sp)
    80003e78:	03010113          	addi	sp,sp,48
    80003e7c:	00008067          	ret

0000000080003e80 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003e80:	ff010113          	addi	sp,sp,-16
    80003e84:	00813423          	sd	s0,8(sp)
    80003e88:	01010413          	addi	s0,sp,16
    80003e8c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003e90:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003e94:	0006c603          	lbu	a2,0(a3)
    80003e98:	fd06071b          	addiw	a4,a2,-48
    80003e9c:	0ff77713          	andi	a4,a4,255
    80003ea0:	00900793          	li	a5,9
    80003ea4:	02e7e063          	bltu	a5,a4,80003ec4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003ea8:	0025179b          	slliw	a5,a0,0x2
    80003eac:	00a787bb          	addw	a5,a5,a0
    80003eb0:	0017979b          	slliw	a5,a5,0x1
    80003eb4:	00168693          	addi	a3,a3,1
    80003eb8:	00c787bb          	addw	a5,a5,a2
    80003ebc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003ec0:	fd5ff06f          	j	80003e94 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003ec4:	00813403          	ld	s0,8(sp)
    80003ec8:	01010113          	addi	sp,sp,16
    80003ecc:	00008067          	ret

0000000080003ed0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003ed0:	fc010113          	addi	sp,sp,-64
    80003ed4:	02113c23          	sd	ra,56(sp)
    80003ed8:	02813823          	sd	s0,48(sp)
    80003edc:	02913423          	sd	s1,40(sp)
    80003ee0:	03213023          	sd	s2,32(sp)
    80003ee4:	01313c23          	sd	s3,24(sp)
    80003ee8:	04010413          	addi	s0,sp,64
    80003eec:	00050493          	mv	s1,a0
    80003ef0:	00058913          	mv	s2,a1
    80003ef4:	00060993          	mv	s3,a2
    LOCK();
    80003ef8:	00100613          	li	a2,1
    80003efc:	00000593          	li	a1,0
    80003f00:	00006517          	auipc	a0,0x6
    80003f04:	0b050513          	addi	a0,a0,176 # 80009fb0 <lockPrint>
    80003f08:	ffffd097          	auipc	ra,0xffffd
    80003f0c:	0f8080e7          	jalr	248(ra) # 80001000 <copy_and_swap>
    80003f10:	00050863          	beqz	a0,80003f20 <_Z8printIntiii+0x50>
    80003f14:	ffffd097          	auipc	ra,0xffffd
    80003f18:	300080e7          	jalr	768(ra) # 80001214 <_Z15thread_dispatchv>
    80003f1c:	fddff06f          	j	80003ef8 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003f20:	00098463          	beqz	s3,80003f28 <_Z8printIntiii+0x58>
    80003f24:	0804c463          	bltz	s1,80003fac <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003f28:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003f2c:	00000593          	li	a1,0
    }

    i = 0;
    80003f30:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003f34:	0009079b          	sext.w	a5,s2
    80003f38:	0325773b          	remuw	a4,a0,s2
    80003f3c:	00048613          	mv	a2,s1
    80003f40:	0014849b          	addiw	s1,s1,1
    80003f44:	02071693          	slli	a3,a4,0x20
    80003f48:	0206d693          	srli	a3,a3,0x20
    80003f4c:	00006717          	auipc	a4,0x6
    80003f50:	f9c70713          	addi	a4,a4,-100 # 80009ee8 <digits>
    80003f54:	00d70733          	add	a4,a4,a3
    80003f58:	00074683          	lbu	a3,0(a4)
    80003f5c:	fd040713          	addi	a4,s0,-48
    80003f60:	00c70733          	add	a4,a4,a2
    80003f64:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003f68:	0005071b          	sext.w	a4,a0
    80003f6c:	0325553b          	divuw	a0,a0,s2
    80003f70:	fcf772e3          	bgeu	a4,a5,80003f34 <_Z8printIntiii+0x64>
    if(neg)
    80003f74:	00058c63          	beqz	a1,80003f8c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003f78:	fd040793          	addi	a5,s0,-48
    80003f7c:	009784b3          	add	s1,a5,s1
    80003f80:	02d00793          	li	a5,45
    80003f84:	fef48823          	sb	a5,-16(s1)
    80003f88:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003f8c:	fff4849b          	addiw	s1,s1,-1
    80003f90:	0204c463          	bltz	s1,80003fb8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80003f94:	fd040793          	addi	a5,s0,-48
    80003f98:	009787b3          	add	a5,a5,s1
    80003f9c:	ff07c503          	lbu	a0,-16(a5)
    80003fa0:	ffffd097          	auipc	ra,0xffffd
    80003fa4:	374080e7          	jalr	884(ra) # 80001314 <_Z4putcc>
    80003fa8:	fe5ff06f          	j	80003f8c <_Z8printIntiii+0xbc>
        x = -xx;
    80003fac:	4090053b          	negw	a0,s1
        neg = 1;
    80003fb0:	00100593          	li	a1,1
        x = -xx;
    80003fb4:	f7dff06f          	j	80003f30 <_Z8printIntiii+0x60>

    UNLOCK();
    80003fb8:	00000613          	li	a2,0
    80003fbc:	00100593          	li	a1,1
    80003fc0:	00006517          	auipc	a0,0x6
    80003fc4:	ff050513          	addi	a0,a0,-16 # 80009fb0 <lockPrint>
    80003fc8:	ffffd097          	auipc	ra,0xffffd
    80003fcc:	038080e7          	jalr	56(ra) # 80001000 <copy_and_swap>
    80003fd0:	fe0514e3          	bnez	a0,80003fb8 <_Z8printIntiii+0xe8>
    80003fd4:	03813083          	ld	ra,56(sp)
    80003fd8:	03013403          	ld	s0,48(sp)
    80003fdc:	02813483          	ld	s1,40(sp)
    80003fe0:	02013903          	ld	s2,32(sp)
    80003fe4:	01813983          	ld	s3,24(sp)
    80003fe8:	04010113          	addi	sp,sp,64
    80003fec:	00008067          	ret

0000000080003ff0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003ff0:	fd010113          	addi	sp,sp,-48
    80003ff4:	02113423          	sd	ra,40(sp)
    80003ff8:	02813023          	sd	s0,32(sp)
    80003ffc:	00913c23          	sd	s1,24(sp)
    80004000:	01213823          	sd	s2,16(sp)
    80004004:	01313423          	sd	s3,8(sp)
    80004008:	03010413          	addi	s0,sp,48
    8000400c:	00050493          	mv	s1,a0
    80004010:	00058913          	mv	s2,a1
    80004014:	0015879b          	addiw	a5,a1,1
    80004018:	0007851b          	sext.w	a0,a5
    8000401c:	00f4a023          	sw	a5,0(s1)
    80004020:	0004a823          	sw	zero,16(s1)
    80004024:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004028:	00251513          	slli	a0,a0,0x2
    8000402c:	ffffd097          	auipc	ra,0xffffd
    80004030:	13c080e7          	jalr	316(ra) # 80001168 <_Z9mem_allocm>
    80004034:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004038:	01000513          	li	a0,16
    8000403c:	ffffd097          	auipc	ra,0xffffd
    80004040:	6d4080e7          	jalr	1748(ra) # 80001710 <_Znwm>
    80004044:	00050993          	mv	s3,a0
    80004048:	00000593          	li	a1,0
    8000404c:	ffffe097          	auipc	ra,0xffffe
    80004050:	a00080e7          	jalr	-1536(ra) # 80001a4c <_ZN9SemaphoreC1Ej>
    80004054:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004058:	01000513          	li	a0,16
    8000405c:	ffffd097          	auipc	ra,0xffffd
    80004060:	6b4080e7          	jalr	1716(ra) # 80001710 <_Znwm>
    80004064:	00050993          	mv	s3,a0
    80004068:	00090593          	mv	a1,s2
    8000406c:	ffffe097          	auipc	ra,0xffffe
    80004070:	9e0080e7          	jalr	-1568(ra) # 80001a4c <_ZN9SemaphoreC1Ej>
    80004074:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004078:	01000513          	li	a0,16
    8000407c:	ffffd097          	auipc	ra,0xffffd
    80004080:	694080e7          	jalr	1684(ra) # 80001710 <_Znwm>
    80004084:	00050913          	mv	s2,a0
    80004088:	00100593          	li	a1,1
    8000408c:	ffffe097          	auipc	ra,0xffffe
    80004090:	9c0080e7          	jalr	-1600(ra) # 80001a4c <_ZN9SemaphoreC1Ej>
    80004094:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004098:	01000513          	li	a0,16
    8000409c:	ffffd097          	auipc	ra,0xffffd
    800040a0:	674080e7          	jalr	1652(ra) # 80001710 <_Znwm>
    800040a4:	00050913          	mv	s2,a0
    800040a8:	00100593          	li	a1,1
    800040ac:	ffffe097          	auipc	ra,0xffffe
    800040b0:	9a0080e7          	jalr	-1632(ra) # 80001a4c <_ZN9SemaphoreC1Ej>
    800040b4:	0324b823          	sd	s2,48(s1)
}
    800040b8:	02813083          	ld	ra,40(sp)
    800040bc:	02013403          	ld	s0,32(sp)
    800040c0:	01813483          	ld	s1,24(sp)
    800040c4:	01013903          	ld	s2,16(sp)
    800040c8:	00813983          	ld	s3,8(sp)
    800040cc:	03010113          	addi	sp,sp,48
    800040d0:	00008067          	ret
    800040d4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800040d8:	00098513          	mv	a0,s3
    800040dc:	ffffd097          	auipc	ra,0xffffd
    800040e0:	684080e7          	jalr	1668(ra) # 80001760 <_ZdlPv>
    800040e4:	00048513          	mv	a0,s1
    800040e8:	00007097          	auipc	ra,0x7
    800040ec:	fa0080e7          	jalr	-96(ra) # 8000b088 <_Unwind_Resume>
    800040f0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800040f4:	00098513          	mv	a0,s3
    800040f8:	ffffd097          	auipc	ra,0xffffd
    800040fc:	668080e7          	jalr	1640(ra) # 80001760 <_ZdlPv>
    80004100:	00048513          	mv	a0,s1
    80004104:	00007097          	auipc	ra,0x7
    80004108:	f84080e7          	jalr	-124(ra) # 8000b088 <_Unwind_Resume>
    8000410c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004110:	00090513          	mv	a0,s2
    80004114:	ffffd097          	auipc	ra,0xffffd
    80004118:	64c080e7          	jalr	1612(ra) # 80001760 <_ZdlPv>
    8000411c:	00048513          	mv	a0,s1
    80004120:	00007097          	auipc	ra,0x7
    80004124:	f68080e7          	jalr	-152(ra) # 8000b088 <_Unwind_Resume>
    80004128:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000412c:	00090513          	mv	a0,s2
    80004130:	ffffd097          	auipc	ra,0xffffd
    80004134:	630080e7          	jalr	1584(ra) # 80001760 <_ZdlPv>
    80004138:	00048513          	mv	a0,s1
    8000413c:	00007097          	auipc	ra,0x7
    80004140:	f4c080e7          	jalr	-180(ra) # 8000b088 <_Unwind_Resume>

0000000080004144 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004144:	fe010113          	addi	sp,sp,-32
    80004148:	00113c23          	sd	ra,24(sp)
    8000414c:	00813823          	sd	s0,16(sp)
    80004150:	00913423          	sd	s1,8(sp)
    80004154:	01213023          	sd	s2,0(sp)
    80004158:	02010413          	addi	s0,sp,32
    8000415c:	00050493          	mv	s1,a0
    80004160:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004164:	01853503          	ld	a0,24(a0)
    80004168:	ffffe097          	auipc	ra,0xffffe
    8000416c:	88c080e7          	jalr	-1908(ra) # 800019f4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004170:	0304b503          	ld	a0,48(s1)
    80004174:	ffffe097          	auipc	ra,0xffffe
    80004178:	880080e7          	jalr	-1920(ra) # 800019f4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000417c:	0084b783          	ld	a5,8(s1)
    80004180:	0144a703          	lw	a4,20(s1)
    80004184:	00271713          	slli	a4,a4,0x2
    80004188:	00e787b3          	add	a5,a5,a4
    8000418c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004190:	0144a783          	lw	a5,20(s1)
    80004194:	0017879b          	addiw	a5,a5,1
    80004198:	0004a703          	lw	a4,0(s1)
    8000419c:	02e7e7bb          	remw	a5,a5,a4
    800041a0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800041a4:	0304b503          	ld	a0,48(s1)
    800041a8:	ffffe097          	auipc	ra,0xffffe
    800041ac:	878080e7          	jalr	-1928(ra) # 80001a20 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800041b0:	0204b503          	ld	a0,32(s1)
    800041b4:	ffffe097          	auipc	ra,0xffffe
    800041b8:	86c080e7          	jalr	-1940(ra) # 80001a20 <_ZN9Semaphore6signalEv>

}
    800041bc:	01813083          	ld	ra,24(sp)
    800041c0:	01013403          	ld	s0,16(sp)
    800041c4:	00813483          	ld	s1,8(sp)
    800041c8:	00013903          	ld	s2,0(sp)
    800041cc:	02010113          	addi	sp,sp,32
    800041d0:	00008067          	ret

00000000800041d4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800041d4:	fe010113          	addi	sp,sp,-32
    800041d8:	00113c23          	sd	ra,24(sp)
    800041dc:	00813823          	sd	s0,16(sp)
    800041e0:	00913423          	sd	s1,8(sp)
    800041e4:	01213023          	sd	s2,0(sp)
    800041e8:	02010413          	addi	s0,sp,32
    800041ec:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800041f0:	02053503          	ld	a0,32(a0)
    800041f4:	ffffe097          	auipc	ra,0xffffe
    800041f8:	800080e7          	jalr	-2048(ra) # 800019f4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800041fc:	0284b503          	ld	a0,40(s1)
    80004200:	ffffd097          	auipc	ra,0xffffd
    80004204:	7f4080e7          	jalr	2036(ra) # 800019f4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004208:	0084b703          	ld	a4,8(s1)
    8000420c:	0104a783          	lw	a5,16(s1)
    80004210:	00279693          	slli	a3,a5,0x2
    80004214:	00d70733          	add	a4,a4,a3
    80004218:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000421c:	0017879b          	addiw	a5,a5,1
    80004220:	0004a703          	lw	a4,0(s1)
    80004224:	02e7e7bb          	remw	a5,a5,a4
    80004228:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000422c:	0284b503          	ld	a0,40(s1)
    80004230:	ffffd097          	auipc	ra,0xffffd
    80004234:	7f0080e7          	jalr	2032(ra) # 80001a20 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004238:	0184b503          	ld	a0,24(s1)
    8000423c:	ffffd097          	auipc	ra,0xffffd
    80004240:	7e4080e7          	jalr	2020(ra) # 80001a20 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004244:	00090513          	mv	a0,s2
    80004248:	01813083          	ld	ra,24(sp)
    8000424c:	01013403          	ld	s0,16(sp)
    80004250:	00813483          	ld	s1,8(sp)
    80004254:	00013903          	ld	s2,0(sp)
    80004258:	02010113          	addi	sp,sp,32
    8000425c:	00008067          	ret

0000000080004260 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004260:	fe010113          	addi	sp,sp,-32
    80004264:	00113c23          	sd	ra,24(sp)
    80004268:	00813823          	sd	s0,16(sp)
    8000426c:	00913423          	sd	s1,8(sp)
    80004270:	01213023          	sd	s2,0(sp)
    80004274:	02010413          	addi	s0,sp,32
    80004278:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000427c:	02853503          	ld	a0,40(a0)
    80004280:	ffffd097          	auipc	ra,0xffffd
    80004284:	774080e7          	jalr	1908(ra) # 800019f4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004288:	0304b503          	ld	a0,48(s1)
    8000428c:	ffffd097          	auipc	ra,0xffffd
    80004290:	768080e7          	jalr	1896(ra) # 800019f4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004294:	0144a783          	lw	a5,20(s1)
    80004298:	0104a903          	lw	s2,16(s1)
    8000429c:	0327ce63          	blt	a5,s2,800042d8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800042a0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800042a4:	0304b503          	ld	a0,48(s1)
    800042a8:	ffffd097          	auipc	ra,0xffffd
    800042ac:	778080e7          	jalr	1912(ra) # 80001a20 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800042b0:	0284b503          	ld	a0,40(s1)
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	76c080e7          	jalr	1900(ra) # 80001a20 <_ZN9Semaphore6signalEv>

    return ret;
}
    800042bc:	00090513          	mv	a0,s2
    800042c0:	01813083          	ld	ra,24(sp)
    800042c4:	01013403          	ld	s0,16(sp)
    800042c8:	00813483          	ld	s1,8(sp)
    800042cc:	00013903          	ld	s2,0(sp)
    800042d0:	02010113          	addi	sp,sp,32
    800042d4:	00008067          	ret
        ret = cap - head + tail;
    800042d8:	0004a703          	lw	a4,0(s1)
    800042dc:	4127093b          	subw	s2,a4,s2
    800042e0:	00f9093b          	addw	s2,s2,a5
    800042e4:	fc1ff06f          	j	800042a4 <_ZN9BufferCPP6getCntEv+0x44>

00000000800042e8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800042e8:	fe010113          	addi	sp,sp,-32
    800042ec:	00113c23          	sd	ra,24(sp)
    800042f0:	00813823          	sd	s0,16(sp)
    800042f4:	00913423          	sd	s1,8(sp)
    800042f8:	02010413          	addi	s0,sp,32
    800042fc:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004300:	00a00513          	li	a0,10
    80004304:	ffffd097          	auipc	ra,0xffffd
    80004308:	5b8080e7          	jalr	1464(ra) # 800018bc <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000430c:	00004517          	auipc	a0,0x4
    80004310:	24450513          	addi	a0,a0,580 # 80008550 <kvmincrease+0x1460>
    80004314:	00000097          	auipc	ra,0x0
    80004318:	a0c080e7          	jalr	-1524(ra) # 80003d20 <_Z11printStringPKc>
    while (getCnt()) {
    8000431c:	00048513          	mv	a0,s1
    80004320:	00000097          	auipc	ra,0x0
    80004324:	f40080e7          	jalr	-192(ra) # 80004260 <_ZN9BufferCPP6getCntEv>
    80004328:	02050c63          	beqz	a0,80004360 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000432c:	0084b783          	ld	a5,8(s1)
    80004330:	0104a703          	lw	a4,16(s1)
    80004334:	00271713          	slli	a4,a4,0x2
    80004338:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000433c:	0007c503          	lbu	a0,0(a5)
    80004340:	ffffd097          	auipc	ra,0xffffd
    80004344:	57c080e7          	jalr	1404(ra) # 800018bc <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004348:	0104a783          	lw	a5,16(s1)
    8000434c:	0017879b          	addiw	a5,a5,1
    80004350:	0004a703          	lw	a4,0(s1)
    80004354:	02e7e7bb          	remw	a5,a5,a4
    80004358:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000435c:	fc1ff06f          	j	8000431c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004360:	02100513          	li	a0,33
    80004364:	ffffd097          	auipc	ra,0xffffd
    80004368:	558080e7          	jalr	1368(ra) # 800018bc <_ZN7Console4putcEc>
    Console::putc('\n');
    8000436c:	00a00513          	li	a0,10
    80004370:	ffffd097          	auipc	ra,0xffffd
    80004374:	54c080e7          	jalr	1356(ra) # 800018bc <_ZN7Console4putcEc>
    mem_free(buffer);
    80004378:	0084b503          	ld	a0,8(s1)
    8000437c:	ffffd097          	auipc	ra,0xffffd
    80004380:	e14080e7          	jalr	-492(ra) # 80001190 <_Z8mem_freePv>
    delete itemAvailable;
    80004384:	0204b503          	ld	a0,32(s1)
    80004388:	00050863          	beqz	a0,80004398 <_ZN9BufferCPPD1Ev+0xb0>
    8000438c:	00053783          	ld	a5,0(a0)
    80004390:	0087b783          	ld	a5,8(a5)
    80004394:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004398:	0184b503          	ld	a0,24(s1)
    8000439c:	00050863          	beqz	a0,800043ac <_ZN9BufferCPPD1Ev+0xc4>
    800043a0:	00053783          	ld	a5,0(a0)
    800043a4:	0087b783          	ld	a5,8(a5)
    800043a8:	000780e7          	jalr	a5
    delete mutexTail;
    800043ac:	0304b503          	ld	a0,48(s1)
    800043b0:	00050863          	beqz	a0,800043c0 <_ZN9BufferCPPD1Ev+0xd8>
    800043b4:	00053783          	ld	a5,0(a0)
    800043b8:	0087b783          	ld	a5,8(a5)
    800043bc:	000780e7          	jalr	a5
    delete mutexHead;
    800043c0:	0284b503          	ld	a0,40(s1)
    800043c4:	00050863          	beqz	a0,800043d4 <_ZN9BufferCPPD1Ev+0xec>
    800043c8:	00053783          	ld	a5,0(a0)
    800043cc:	0087b783          	ld	a5,8(a5)
    800043d0:	000780e7          	jalr	a5
}
    800043d4:	01813083          	ld	ra,24(sp)
    800043d8:	01013403          	ld	s0,16(sp)
    800043dc:	00813483          	ld	s1,8(sp)
    800043e0:	02010113          	addi	sp,sp,32
    800043e4:	00008067          	ret

00000000800043e8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800043e8:	fe010113          	addi	sp,sp,-32
    800043ec:	00113c23          	sd	ra,24(sp)
    800043f0:	00813823          	sd	s0,16(sp)
    800043f4:	00913423          	sd	s1,8(sp)
    800043f8:	01213023          	sd	s2,0(sp)
    800043fc:	02010413          	addi	s0,sp,32
    80004400:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004404:	00100793          	li	a5,1
    80004408:	02a7f863          	bgeu	a5,a0,80004438 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000440c:	00a00793          	li	a5,10
    80004410:	02f577b3          	remu	a5,a0,a5
    80004414:	02078e63          	beqz	a5,80004450 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004418:	fff48513          	addi	a0,s1,-1
    8000441c:	00000097          	auipc	ra,0x0
    80004420:	fcc080e7          	jalr	-52(ra) # 800043e8 <_ZL9fibonaccim>
    80004424:	00050913          	mv	s2,a0
    80004428:	ffe48513          	addi	a0,s1,-2
    8000442c:	00000097          	auipc	ra,0x0
    80004430:	fbc080e7          	jalr	-68(ra) # 800043e8 <_ZL9fibonaccim>
    80004434:	00a90533          	add	a0,s2,a0
}
    80004438:	01813083          	ld	ra,24(sp)
    8000443c:	01013403          	ld	s0,16(sp)
    80004440:	00813483          	ld	s1,8(sp)
    80004444:	00013903          	ld	s2,0(sp)
    80004448:	02010113          	addi	sp,sp,32
    8000444c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004450:	ffffd097          	auipc	ra,0xffffd
    80004454:	dc4080e7          	jalr	-572(ra) # 80001214 <_Z15thread_dispatchv>
    80004458:	fc1ff06f          	j	80004418 <_ZL9fibonaccim+0x30>

000000008000445c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000445c:	fe010113          	addi	sp,sp,-32
    80004460:	00113c23          	sd	ra,24(sp)
    80004464:	00813823          	sd	s0,16(sp)
    80004468:	00913423          	sd	s1,8(sp)
    8000446c:	01213023          	sd	s2,0(sp)
    80004470:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004474:	00a00493          	li	s1,10
    80004478:	0400006f          	j	800044b8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000447c:	00004517          	auipc	a0,0x4
    80004480:	02c50513          	addi	a0,a0,44 # 800084a8 <kvmincrease+0x13b8>
    80004484:	00000097          	auipc	ra,0x0
    80004488:	89c080e7          	jalr	-1892(ra) # 80003d20 <_Z11printStringPKc>
    8000448c:	00000613          	li	a2,0
    80004490:	00a00593          	li	a1,10
    80004494:	00048513          	mv	a0,s1
    80004498:	00000097          	auipc	ra,0x0
    8000449c:	a38080e7          	jalr	-1480(ra) # 80003ed0 <_Z8printIntiii>
    800044a0:	00004517          	auipc	a0,0x4
    800044a4:	cd050513          	addi	a0,a0,-816 # 80008170 <kvmincrease+0x1080>
    800044a8:	00000097          	auipc	ra,0x0
    800044ac:	878080e7          	jalr	-1928(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800044b0:	0014849b          	addiw	s1,s1,1
    800044b4:	0ff4f493          	andi	s1,s1,255
    800044b8:	00c00793          	li	a5,12
    800044bc:	fc97f0e3          	bgeu	a5,s1,8000447c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800044c0:	00004517          	auipc	a0,0x4
    800044c4:	ff050513          	addi	a0,a0,-16 # 800084b0 <kvmincrease+0x13c0>
    800044c8:	00000097          	auipc	ra,0x0
    800044cc:	858080e7          	jalr	-1960(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800044d0:	00500313          	li	t1,5
    thread_dispatch();
    800044d4:	ffffd097          	auipc	ra,0xffffd
    800044d8:	d40080e7          	jalr	-704(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800044dc:	01000513          	li	a0,16
    800044e0:	00000097          	auipc	ra,0x0
    800044e4:	f08080e7          	jalr	-248(ra) # 800043e8 <_ZL9fibonaccim>
    800044e8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800044ec:	00004517          	auipc	a0,0x4
    800044f0:	fd450513          	addi	a0,a0,-44 # 800084c0 <kvmincrease+0x13d0>
    800044f4:	00000097          	auipc	ra,0x0
    800044f8:	82c080e7          	jalr	-2004(ra) # 80003d20 <_Z11printStringPKc>
    800044fc:	00000613          	li	a2,0
    80004500:	00a00593          	li	a1,10
    80004504:	0009051b          	sext.w	a0,s2
    80004508:	00000097          	auipc	ra,0x0
    8000450c:	9c8080e7          	jalr	-1592(ra) # 80003ed0 <_Z8printIntiii>
    80004510:	00004517          	auipc	a0,0x4
    80004514:	c6050513          	addi	a0,a0,-928 # 80008170 <kvmincrease+0x1080>
    80004518:	00000097          	auipc	ra,0x0
    8000451c:	808080e7          	jalr	-2040(ra) # 80003d20 <_Z11printStringPKc>
    80004520:	0400006f          	j	80004560 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004524:	00004517          	auipc	a0,0x4
    80004528:	f8450513          	addi	a0,a0,-124 # 800084a8 <kvmincrease+0x13b8>
    8000452c:	fffff097          	auipc	ra,0xfffff
    80004530:	7f4080e7          	jalr	2036(ra) # 80003d20 <_Z11printStringPKc>
    80004534:	00000613          	li	a2,0
    80004538:	00a00593          	li	a1,10
    8000453c:	00048513          	mv	a0,s1
    80004540:	00000097          	auipc	ra,0x0
    80004544:	990080e7          	jalr	-1648(ra) # 80003ed0 <_Z8printIntiii>
    80004548:	00004517          	auipc	a0,0x4
    8000454c:	c2850513          	addi	a0,a0,-984 # 80008170 <kvmincrease+0x1080>
    80004550:	fffff097          	auipc	ra,0xfffff
    80004554:	7d0080e7          	jalr	2000(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004558:	0014849b          	addiw	s1,s1,1
    8000455c:	0ff4f493          	andi	s1,s1,255
    80004560:	00f00793          	li	a5,15
    80004564:	fc97f0e3          	bgeu	a5,s1,80004524 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004568:	00004517          	auipc	a0,0x4
    8000456c:	f6850513          	addi	a0,a0,-152 # 800084d0 <kvmincrease+0x13e0>
    80004570:	fffff097          	auipc	ra,0xfffff
    80004574:	7b0080e7          	jalr	1968(ra) # 80003d20 <_Z11printStringPKc>
    finishedD = true;
    80004578:	00100793          	li	a5,1
    8000457c:	00006717          	auipc	a4,0x6
    80004580:	a2f70e23          	sb	a5,-1476(a4) # 80009fb8 <_ZL9finishedD>
    thread_dispatch();
    80004584:	ffffd097          	auipc	ra,0xffffd
    80004588:	c90080e7          	jalr	-880(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000458c:	01813083          	ld	ra,24(sp)
    80004590:	01013403          	ld	s0,16(sp)
    80004594:	00813483          	ld	s1,8(sp)
    80004598:	00013903          	ld	s2,0(sp)
    8000459c:	02010113          	addi	sp,sp,32
    800045a0:	00008067          	ret

00000000800045a4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800045a4:	fe010113          	addi	sp,sp,-32
    800045a8:	00113c23          	sd	ra,24(sp)
    800045ac:	00813823          	sd	s0,16(sp)
    800045b0:	00913423          	sd	s1,8(sp)
    800045b4:	01213023          	sd	s2,0(sp)
    800045b8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800045bc:	00000493          	li	s1,0
    800045c0:	0400006f          	j	80004600 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800045c4:	00004517          	auipc	a0,0x4
    800045c8:	eb450513          	addi	a0,a0,-332 # 80008478 <kvmincrease+0x1388>
    800045cc:	fffff097          	auipc	ra,0xfffff
    800045d0:	754080e7          	jalr	1876(ra) # 80003d20 <_Z11printStringPKc>
    800045d4:	00000613          	li	a2,0
    800045d8:	00a00593          	li	a1,10
    800045dc:	00048513          	mv	a0,s1
    800045e0:	00000097          	auipc	ra,0x0
    800045e4:	8f0080e7          	jalr	-1808(ra) # 80003ed0 <_Z8printIntiii>
    800045e8:	00004517          	auipc	a0,0x4
    800045ec:	b8850513          	addi	a0,a0,-1144 # 80008170 <kvmincrease+0x1080>
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	730080e7          	jalr	1840(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800045f8:	0014849b          	addiw	s1,s1,1
    800045fc:	0ff4f493          	andi	s1,s1,255
    80004600:	00200793          	li	a5,2
    80004604:	fc97f0e3          	bgeu	a5,s1,800045c4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004608:	00004517          	auipc	a0,0x4
    8000460c:	e7850513          	addi	a0,a0,-392 # 80008480 <kvmincrease+0x1390>
    80004610:	fffff097          	auipc	ra,0xfffff
    80004614:	710080e7          	jalr	1808(ra) # 80003d20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004618:	00700313          	li	t1,7
    thread_dispatch();
    8000461c:	ffffd097          	auipc	ra,0xffffd
    80004620:	bf8080e7          	jalr	-1032(ra) # 80001214 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004624:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004628:	00004517          	auipc	a0,0x4
    8000462c:	e6850513          	addi	a0,a0,-408 # 80008490 <kvmincrease+0x13a0>
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	6f0080e7          	jalr	1776(ra) # 80003d20 <_Z11printStringPKc>
    80004638:	00000613          	li	a2,0
    8000463c:	00a00593          	li	a1,10
    80004640:	0009051b          	sext.w	a0,s2
    80004644:	00000097          	auipc	ra,0x0
    80004648:	88c080e7          	jalr	-1908(ra) # 80003ed0 <_Z8printIntiii>
    8000464c:	00004517          	auipc	a0,0x4
    80004650:	b2450513          	addi	a0,a0,-1244 # 80008170 <kvmincrease+0x1080>
    80004654:	fffff097          	auipc	ra,0xfffff
    80004658:	6cc080e7          	jalr	1740(ra) # 80003d20 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000465c:	00c00513          	li	a0,12
    80004660:	00000097          	auipc	ra,0x0
    80004664:	d88080e7          	jalr	-632(ra) # 800043e8 <_ZL9fibonaccim>
    80004668:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000466c:	00004517          	auipc	a0,0x4
    80004670:	e2c50513          	addi	a0,a0,-468 # 80008498 <kvmincrease+0x13a8>
    80004674:	fffff097          	auipc	ra,0xfffff
    80004678:	6ac080e7          	jalr	1708(ra) # 80003d20 <_Z11printStringPKc>
    8000467c:	00000613          	li	a2,0
    80004680:	00a00593          	li	a1,10
    80004684:	0009051b          	sext.w	a0,s2
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	848080e7          	jalr	-1976(ra) # 80003ed0 <_Z8printIntiii>
    80004690:	00004517          	auipc	a0,0x4
    80004694:	ae050513          	addi	a0,a0,-1312 # 80008170 <kvmincrease+0x1080>
    80004698:	fffff097          	auipc	ra,0xfffff
    8000469c:	688080e7          	jalr	1672(ra) # 80003d20 <_Z11printStringPKc>
    800046a0:	0400006f          	j	800046e0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800046a4:	00004517          	auipc	a0,0x4
    800046a8:	dd450513          	addi	a0,a0,-556 # 80008478 <kvmincrease+0x1388>
    800046ac:	fffff097          	auipc	ra,0xfffff
    800046b0:	674080e7          	jalr	1652(ra) # 80003d20 <_Z11printStringPKc>
    800046b4:	00000613          	li	a2,0
    800046b8:	00a00593          	li	a1,10
    800046bc:	00048513          	mv	a0,s1
    800046c0:	00000097          	auipc	ra,0x0
    800046c4:	810080e7          	jalr	-2032(ra) # 80003ed0 <_Z8printIntiii>
    800046c8:	00004517          	auipc	a0,0x4
    800046cc:	aa850513          	addi	a0,a0,-1368 # 80008170 <kvmincrease+0x1080>
    800046d0:	fffff097          	auipc	ra,0xfffff
    800046d4:	650080e7          	jalr	1616(ra) # 80003d20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800046d8:	0014849b          	addiw	s1,s1,1
    800046dc:	0ff4f493          	andi	s1,s1,255
    800046e0:	00500793          	li	a5,5
    800046e4:	fc97f0e3          	bgeu	a5,s1,800046a4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800046e8:	00004517          	auipc	a0,0x4
    800046ec:	d6850513          	addi	a0,a0,-664 # 80008450 <kvmincrease+0x1360>
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	630080e7          	jalr	1584(ra) # 80003d20 <_Z11printStringPKc>
    finishedC = true;
    800046f8:	00100793          	li	a5,1
    800046fc:	00006717          	auipc	a4,0x6
    80004700:	8af70ea3          	sb	a5,-1859(a4) # 80009fb9 <_ZL9finishedC>
    thread_dispatch();
    80004704:	ffffd097          	auipc	ra,0xffffd
    80004708:	b10080e7          	jalr	-1264(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000470c:	01813083          	ld	ra,24(sp)
    80004710:	01013403          	ld	s0,16(sp)
    80004714:	00813483          	ld	s1,8(sp)
    80004718:	00013903          	ld	s2,0(sp)
    8000471c:	02010113          	addi	sp,sp,32
    80004720:	00008067          	ret

0000000080004724 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004724:	fe010113          	addi	sp,sp,-32
    80004728:	00113c23          	sd	ra,24(sp)
    8000472c:	00813823          	sd	s0,16(sp)
    80004730:	00913423          	sd	s1,8(sp)
    80004734:	01213023          	sd	s2,0(sp)
    80004738:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000473c:	00000913          	li	s2,0
    80004740:	0400006f          	j	80004780 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80004744:	ffffd097          	auipc	ra,0xffffd
    80004748:	ad0080e7          	jalr	-1328(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000474c:	00148493          	addi	s1,s1,1
    80004750:	000027b7          	lui	a5,0x2
    80004754:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004758:	0097ee63          	bltu	a5,s1,80004774 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000475c:	00000713          	li	a4,0
    80004760:	000077b7          	lui	a5,0x7
    80004764:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004768:	fce7eee3          	bltu	a5,a4,80004744 <_ZL11workerBodyBPv+0x20>
    8000476c:	00170713          	addi	a4,a4,1
    80004770:	ff1ff06f          	j	80004760 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80004774:	00a00793          	li	a5,10
    80004778:	04f90663          	beq	s2,a5,800047c4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    8000477c:	00190913          	addi	s2,s2,1
    80004780:	00f00793          	li	a5,15
    80004784:	0527e463          	bltu	a5,s2,800047cc <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80004788:	00004517          	auipc	a0,0x4
    8000478c:	cd850513          	addi	a0,a0,-808 # 80008460 <kvmincrease+0x1370>
    80004790:	fffff097          	auipc	ra,0xfffff
    80004794:	590080e7          	jalr	1424(ra) # 80003d20 <_Z11printStringPKc>
    80004798:	00000613          	li	a2,0
    8000479c:	00a00593          	li	a1,10
    800047a0:	0009051b          	sext.w	a0,s2
    800047a4:	fffff097          	auipc	ra,0xfffff
    800047a8:	72c080e7          	jalr	1836(ra) # 80003ed0 <_Z8printIntiii>
    800047ac:	00004517          	auipc	a0,0x4
    800047b0:	9c450513          	addi	a0,a0,-1596 # 80008170 <kvmincrease+0x1080>
    800047b4:	fffff097          	auipc	ra,0xfffff
    800047b8:	56c080e7          	jalr	1388(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800047bc:	00000493          	li	s1,0
    800047c0:	f91ff06f          	j	80004750 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800047c4:	14102ff3          	csrr	t6,sepc
    800047c8:	fb5ff06f          	j	8000477c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    800047cc:	00004517          	auipc	a0,0x4
    800047d0:	c9c50513          	addi	a0,a0,-868 # 80008468 <kvmincrease+0x1378>
    800047d4:	fffff097          	auipc	ra,0xfffff
    800047d8:	54c080e7          	jalr	1356(ra) # 80003d20 <_Z11printStringPKc>
    finishedB = true;
    800047dc:	00100793          	li	a5,1
    800047e0:	00005717          	auipc	a4,0x5
    800047e4:	7cf70d23          	sb	a5,2010(a4) # 80009fba <_ZL9finishedB>
    thread_dispatch();
    800047e8:	ffffd097          	auipc	ra,0xffffd
    800047ec:	a2c080e7          	jalr	-1492(ra) # 80001214 <_Z15thread_dispatchv>
}
    800047f0:	01813083          	ld	ra,24(sp)
    800047f4:	01013403          	ld	s0,16(sp)
    800047f8:	00813483          	ld	s1,8(sp)
    800047fc:	00013903          	ld	s2,0(sp)
    80004800:	02010113          	addi	sp,sp,32
    80004804:	00008067          	ret

0000000080004808 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004808:	fe010113          	addi	sp,sp,-32
    8000480c:	00113c23          	sd	ra,24(sp)
    80004810:	00813823          	sd	s0,16(sp)
    80004814:	00913423          	sd	s1,8(sp)
    80004818:	01213023          	sd	s2,0(sp)
    8000481c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004820:	00000913          	li	s2,0
    80004824:	0380006f          	j	8000485c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004828:	ffffd097          	auipc	ra,0xffffd
    8000482c:	9ec080e7          	jalr	-1556(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004830:	00148493          	addi	s1,s1,1
    80004834:	000027b7          	lui	a5,0x2
    80004838:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000483c:	0097ee63          	bltu	a5,s1,80004858 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004840:	00000713          	li	a4,0
    80004844:	000077b7          	lui	a5,0x7
    80004848:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000484c:	fce7eee3          	bltu	a5,a4,80004828 <_ZL11workerBodyAPv+0x20>
    80004850:	00170713          	addi	a4,a4,1
    80004854:	ff1ff06f          	j	80004844 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004858:	00190913          	addi	s2,s2,1
    8000485c:	00900793          	li	a5,9
    80004860:	0527e063          	bltu	a5,s2,800048a0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004864:	00004517          	auipc	a0,0x4
    80004868:	be450513          	addi	a0,a0,-1052 # 80008448 <kvmincrease+0x1358>
    8000486c:	fffff097          	auipc	ra,0xfffff
    80004870:	4b4080e7          	jalr	1204(ra) # 80003d20 <_Z11printStringPKc>
    80004874:	00000613          	li	a2,0
    80004878:	00a00593          	li	a1,10
    8000487c:	0009051b          	sext.w	a0,s2
    80004880:	fffff097          	auipc	ra,0xfffff
    80004884:	650080e7          	jalr	1616(ra) # 80003ed0 <_Z8printIntiii>
    80004888:	00004517          	auipc	a0,0x4
    8000488c:	8e850513          	addi	a0,a0,-1816 # 80008170 <kvmincrease+0x1080>
    80004890:	fffff097          	auipc	ra,0xfffff
    80004894:	490080e7          	jalr	1168(ra) # 80003d20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004898:	00000493          	li	s1,0
    8000489c:	f99ff06f          	j	80004834 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800048a0:	00004517          	auipc	a0,0x4
    800048a4:	bb050513          	addi	a0,a0,-1104 # 80008450 <kvmincrease+0x1360>
    800048a8:	fffff097          	auipc	ra,0xfffff
    800048ac:	478080e7          	jalr	1144(ra) # 80003d20 <_Z11printStringPKc>
    finishedA = true;
    800048b0:	00100793          	li	a5,1
    800048b4:	00005717          	auipc	a4,0x5
    800048b8:	70f703a3          	sb	a5,1799(a4) # 80009fbb <_ZL9finishedA>
}
    800048bc:	01813083          	ld	ra,24(sp)
    800048c0:	01013403          	ld	s0,16(sp)
    800048c4:	00813483          	ld	s1,8(sp)
    800048c8:	00013903          	ld	s2,0(sp)
    800048cc:	02010113          	addi	sp,sp,32
    800048d0:	00008067          	ret

00000000800048d4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    800048d4:	fd010113          	addi	sp,sp,-48
    800048d8:	02113423          	sd	ra,40(sp)
    800048dc:	02813023          	sd	s0,32(sp)
    800048e0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800048e4:	00000613          	li	a2,0
    800048e8:	00000597          	auipc	a1,0x0
    800048ec:	f2058593          	addi	a1,a1,-224 # 80004808 <_ZL11workerBodyAPv>
    800048f0:	fd040513          	addi	a0,s0,-48
    800048f4:	ffffd097          	auipc	ra,0xffffd
    800048f8:	8c8080e7          	jalr	-1848(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800048fc:	00004517          	auipc	a0,0x4
    80004900:	be450513          	addi	a0,a0,-1052 # 800084e0 <kvmincrease+0x13f0>
    80004904:	fffff097          	auipc	ra,0xfffff
    80004908:	41c080e7          	jalr	1052(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000490c:	00000613          	li	a2,0
    80004910:	00000597          	auipc	a1,0x0
    80004914:	e1458593          	addi	a1,a1,-492 # 80004724 <_ZL11workerBodyBPv>
    80004918:	fd840513          	addi	a0,s0,-40
    8000491c:	ffffd097          	auipc	ra,0xffffd
    80004920:	8a0080e7          	jalr	-1888(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004924:	00004517          	auipc	a0,0x4
    80004928:	bd450513          	addi	a0,a0,-1068 # 800084f8 <kvmincrease+0x1408>
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	3f4080e7          	jalr	1012(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004934:	00000613          	li	a2,0
    80004938:	00000597          	auipc	a1,0x0
    8000493c:	c6c58593          	addi	a1,a1,-916 # 800045a4 <_ZL11workerBodyCPv>
    80004940:	fe040513          	addi	a0,s0,-32
    80004944:	ffffd097          	auipc	ra,0xffffd
    80004948:	878080e7          	jalr	-1928(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000494c:	00004517          	auipc	a0,0x4
    80004950:	bc450513          	addi	a0,a0,-1084 # 80008510 <kvmincrease+0x1420>
    80004954:	fffff097          	auipc	ra,0xfffff
    80004958:	3cc080e7          	jalr	972(ra) # 80003d20 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000495c:	00000613          	li	a2,0
    80004960:	00000597          	auipc	a1,0x0
    80004964:	afc58593          	addi	a1,a1,-1284 # 8000445c <_ZL11workerBodyDPv>
    80004968:	fe840513          	addi	a0,s0,-24
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	850080e7          	jalr	-1968(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004974:	00004517          	auipc	a0,0x4
    80004978:	bb450513          	addi	a0,a0,-1100 # 80008528 <kvmincrease+0x1438>
    8000497c:	fffff097          	auipc	ra,0xfffff
    80004980:	3a4080e7          	jalr	932(ra) # 80003d20 <_Z11printStringPKc>
    80004984:	00c0006f          	j	80004990 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004988:	ffffd097          	auipc	ra,0xffffd
    8000498c:	88c080e7          	jalr	-1908(ra) # 80001214 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004990:	00005797          	auipc	a5,0x5
    80004994:	62b7c783          	lbu	a5,1579(a5) # 80009fbb <_ZL9finishedA>
    80004998:	fe0788e3          	beqz	a5,80004988 <_Z16System_Mode_testv+0xb4>
    8000499c:	00005797          	auipc	a5,0x5
    800049a0:	61e7c783          	lbu	a5,1566(a5) # 80009fba <_ZL9finishedB>
    800049a4:	fe0782e3          	beqz	a5,80004988 <_Z16System_Mode_testv+0xb4>
    800049a8:	00005797          	auipc	a5,0x5
    800049ac:	6117c783          	lbu	a5,1553(a5) # 80009fb9 <_ZL9finishedC>
    800049b0:	fc078ce3          	beqz	a5,80004988 <_Z16System_Mode_testv+0xb4>
    800049b4:	00005797          	auipc	a5,0x5
    800049b8:	6047c783          	lbu	a5,1540(a5) # 80009fb8 <_ZL9finishedD>
    800049bc:	fc0786e3          	beqz	a5,80004988 <_Z16System_Mode_testv+0xb4>
    }

}
    800049c0:	02813083          	ld	ra,40(sp)
    800049c4:	02013403          	ld	s0,32(sp)
    800049c8:	03010113          	addi	sp,sp,48
    800049cc:	00008067          	ret

00000000800049d0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800049d0:	fe010113          	addi	sp,sp,-32
    800049d4:	00113c23          	sd	ra,24(sp)
    800049d8:	00813823          	sd	s0,16(sp)
    800049dc:	00913423          	sd	s1,8(sp)
    800049e0:	01213023          	sd	s2,0(sp)
    800049e4:	02010413          	addi	s0,sp,32
    800049e8:	00050493          	mv	s1,a0
    800049ec:	00058913          	mv	s2,a1
    800049f0:	0015879b          	addiw	a5,a1,1
    800049f4:	0007851b          	sext.w	a0,a5
    800049f8:	00f4a023          	sw	a5,0(s1)
    800049fc:	0004a823          	sw	zero,16(s1)
    80004a00:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004a04:	00251513          	slli	a0,a0,0x2
    80004a08:	ffffc097          	auipc	ra,0xffffc
    80004a0c:	760080e7          	jalr	1888(ra) # 80001168 <_Z9mem_allocm>
    80004a10:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004a14:	00000593          	li	a1,0
    80004a18:	02048513          	addi	a0,s1,32
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	81c080e7          	jalr	-2020(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80004a24:	00090593          	mv	a1,s2
    80004a28:	01848513          	addi	a0,s1,24
    80004a2c:	ffffd097          	auipc	ra,0xffffd
    80004a30:	80c080e7          	jalr	-2036(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80004a34:	00100593          	li	a1,1
    80004a38:	02848513          	addi	a0,s1,40
    80004a3c:	ffffc097          	auipc	ra,0xffffc
    80004a40:	7fc080e7          	jalr	2044(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80004a44:	00100593          	li	a1,1
    80004a48:	03048513          	addi	a0,s1,48
    80004a4c:	ffffc097          	auipc	ra,0xffffc
    80004a50:	7ec080e7          	jalr	2028(ra) # 80001238 <_Z8sem_openPP4_semj>
}
    80004a54:	01813083          	ld	ra,24(sp)
    80004a58:	01013403          	ld	s0,16(sp)
    80004a5c:	00813483          	ld	s1,8(sp)
    80004a60:	00013903          	ld	s2,0(sp)
    80004a64:	02010113          	addi	sp,sp,32
    80004a68:	00008067          	ret

0000000080004a6c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004a6c:	fe010113          	addi	sp,sp,-32
    80004a70:	00113c23          	sd	ra,24(sp)
    80004a74:	00813823          	sd	s0,16(sp)
    80004a78:	00913423          	sd	s1,8(sp)
    80004a7c:	01213023          	sd	s2,0(sp)
    80004a80:	02010413          	addi	s0,sp,32
    80004a84:	00050493          	mv	s1,a0
    80004a88:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004a8c:	01853503          	ld	a0,24(a0)
    80004a90:	ffffd097          	auipc	ra,0xffffd
    80004a94:	800080e7          	jalr	-2048(ra) # 80001290 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004a98:	0304b503          	ld	a0,48(s1)
    80004a9c:	ffffc097          	auipc	ra,0xffffc
    80004aa0:	7f4080e7          	jalr	2036(ra) # 80001290 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004aa4:	0084b783          	ld	a5,8(s1)
    80004aa8:	0144a703          	lw	a4,20(s1)
    80004aac:	00271713          	slli	a4,a4,0x2
    80004ab0:	00e787b3          	add	a5,a5,a4
    80004ab4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004ab8:	0144a783          	lw	a5,20(s1)
    80004abc:	0017879b          	addiw	a5,a5,1
    80004ac0:	0004a703          	lw	a4,0(s1)
    80004ac4:	02e7e7bb          	remw	a5,a5,a4
    80004ac8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004acc:	0304b503          	ld	a0,48(s1)
    80004ad0:	ffffc097          	auipc	ra,0xffffc
    80004ad4:	7ec080e7          	jalr	2028(ra) # 800012bc <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004ad8:	0204b503          	ld	a0,32(s1)
    80004adc:	ffffc097          	auipc	ra,0xffffc
    80004ae0:	7e0080e7          	jalr	2016(ra) # 800012bc <_Z10sem_signalP4_sem>

}
    80004ae4:	01813083          	ld	ra,24(sp)
    80004ae8:	01013403          	ld	s0,16(sp)
    80004aec:	00813483          	ld	s1,8(sp)
    80004af0:	00013903          	ld	s2,0(sp)
    80004af4:	02010113          	addi	sp,sp,32
    80004af8:	00008067          	ret

0000000080004afc <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004afc:	fe010113          	addi	sp,sp,-32
    80004b00:	00113c23          	sd	ra,24(sp)
    80004b04:	00813823          	sd	s0,16(sp)
    80004b08:	00913423          	sd	s1,8(sp)
    80004b0c:	01213023          	sd	s2,0(sp)
    80004b10:	02010413          	addi	s0,sp,32
    80004b14:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004b18:	02053503          	ld	a0,32(a0)
    80004b1c:	ffffc097          	auipc	ra,0xffffc
    80004b20:	774080e7          	jalr	1908(ra) # 80001290 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004b24:	0284b503          	ld	a0,40(s1)
    80004b28:	ffffc097          	auipc	ra,0xffffc
    80004b2c:	768080e7          	jalr	1896(ra) # 80001290 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80004b30:	0084b703          	ld	a4,8(s1)
    80004b34:	0104a783          	lw	a5,16(s1)
    80004b38:	00279693          	slli	a3,a5,0x2
    80004b3c:	00d70733          	add	a4,a4,a3
    80004b40:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004b44:	0017879b          	addiw	a5,a5,1
    80004b48:	0004a703          	lw	a4,0(s1)
    80004b4c:	02e7e7bb          	remw	a5,a5,a4
    80004b50:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004b54:	0284b503          	ld	a0,40(s1)
    80004b58:	ffffc097          	auipc	ra,0xffffc
    80004b5c:	764080e7          	jalr	1892(ra) # 800012bc <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80004b60:	0184b503          	ld	a0,24(s1)
    80004b64:	ffffc097          	auipc	ra,0xffffc
    80004b68:	758080e7          	jalr	1880(ra) # 800012bc <_Z10sem_signalP4_sem>

    return ret;
}
    80004b6c:	00090513          	mv	a0,s2
    80004b70:	01813083          	ld	ra,24(sp)
    80004b74:	01013403          	ld	s0,16(sp)
    80004b78:	00813483          	ld	s1,8(sp)
    80004b7c:	00013903          	ld	s2,0(sp)
    80004b80:	02010113          	addi	sp,sp,32
    80004b84:	00008067          	ret

0000000080004b88 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004b88:	fe010113          	addi	sp,sp,-32
    80004b8c:	00113c23          	sd	ra,24(sp)
    80004b90:	00813823          	sd	s0,16(sp)
    80004b94:	00913423          	sd	s1,8(sp)
    80004b98:	01213023          	sd	s2,0(sp)
    80004b9c:	02010413          	addi	s0,sp,32
    80004ba0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004ba4:	02853503          	ld	a0,40(a0)
    80004ba8:	ffffc097          	auipc	ra,0xffffc
    80004bac:	6e8080e7          	jalr	1768(ra) # 80001290 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80004bb0:	0304b503          	ld	a0,48(s1)
    80004bb4:	ffffc097          	auipc	ra,0xffffc
    80004bb8:	6dc080e7          	jalr	1756(ra) # 80001290 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80004bbc:	0144a783          	lw	a5,20(s1)
    80004bc0:	0104a903          	lw	s2,16(s1)
    80004bc4:	0327ce63          	blt	a5,s2,80004c00 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004bc8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004bcc:	0304b503          	ld	a0,48(s1)
    80004bd0:	ffffc097          	auipc	ra,0xffffc
    80004bd4:	6ec080e7          	jalr	1772(ra) # 800012bc <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80004bd8:	0284b503          	ld	a0,40(s1)
    80004bdc:	ffffc097          	auipc	ra,0xffffc
    80004be0:	6e0080e7          	jalr	1760(ra) # 800012bc <_Z10sem_signalP4_sem>

    return ret;
}
    80004be4:	00090513          	mv	a0,s2
    80004be8:	01813083          	ld	ra,24(sp)
    80004bec:	01013403          	ld	s0,16(sp)
    80004bf0:	00813483          	ld	s1,8(sp)
    80004bf4:	00013903          	ld	s2,0(sp)
    80004bf8:	02010113          	addi	sp,sp,32
    80004bfc:	00008067          	ret
        ret = cap - head + tail;
    80004c00:	0004a703          	lw	a4,0(s1)
    80004c04:	4127093b          	subw	s2,a4,s2
    80004c08:	00f9093b          	addw	s2,s2,a5
    80004c0c:	fc1ff06f          	j	80004bcc <_ZN6Buffer6getCntEv+0x44>

0000000080004c10 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80004c10:	fe010113          	addi	sp,sp,-32
    80004c14:	00113c23          	sd	ra,24(sp)
    80004c18:	00813823          	sd	s0,16(sp)
    80004c1c:	00913423          	sd	s1,8(sp)
    80004c20:	02010413          	addi	s0,sp,32
    80004c24:	00050493          	mv	s1,a0
    putc('\n');
    80004c28:	00a00513          	li	a0,10
    80004c2c:	ffffc097          	auipc	ra,0xffffc
    80004c30:	6e8080e7          	jalr	1768(ra) # 80001314 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004c34:	00004517          	auipc	a0,0x4
    80004c38:	91c50513          	addi	a0,a0,-1764 # 80008550 <kvmincrease+0x1460>
    80004c3c:	fffff097          	auipc	ra,0xfffff
    80004c40:	0e4080e7          	jalr	228(ra) # 80003d20 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004c44:	00048513          	mv	a0,s1
    80004c48:	00000097          	auipc	ra,0x0
    80004c4c:	f40080e7          	jalr	-192(ra) # 80004b88 <_ZN6Buffer6getCntEv>
    80004c50:	02a05c63          	blez	a0,80004c88 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004c54:	0084b783          	ld	a5,8(s1)
    80004c58:	0104a703          	lw	a4,16(s1)
    80004c5c:	00271713          	slli	a4,a4,0x2
    80004c60:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80004c64:	0007c503          	lbu	a0,0(a5)
    80004c68:	ffffc097          	auipc	ra,0xffffc
    80004c6c:	6ac080e7          	jalr	1708(ra) # 80001314 <_Z4putcc>
        head = (head + 1) % cap;
    80004c70:	0104a783          	lw	a5,16(s1)
    80004c74:	0017879b          	addiw	a5,a5,1
    80004c78:	0004a703          	lw	a4,0(s1)
    80004c7c:	02e7e7bb          	remw	a5,a5,a4
    80004c80:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80004c84:	fc1ff06f          	j	80004c44 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004c88:	02100513          	li	a0,33
    80004c8c:	ffffc097          	auipc	ra,0xffffc
    80004c90:	688080e7          	jalr	1672(ra) # 80001314 <_Z4putcc>
    putc('\n');
    80004c94:	00a00513          	li	a0,10
    80004c98:	ffffc097          	auipc	ra,0xffffc
    80004c9c:	67c080e7          	jalr	1660(ra) # 80001314 <_Z4putcc>
    mem_free(buffer);
    80004ca0:	0084b503          	ld	a0,8(s1)
    80004ca4:	ffffc097          	auipc	ra,0xffffc
    80004ca8:	4ec080e7          	jalr	1260(ra) # 80001190 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004cac:	0204b503          	ld	a0,32(s1)
    80004cb0:	ffffc097          	auipc	ra,0xffffc
    80004cb4:	5b4080e7          	jalr	1460(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80004cb8:	0184b503          	ld	a0,24(s1)
    80004cbc:	ffffc097          	auipc	ra,0xffffc
    80004cc0:	5a8080e7          	jalr	1448(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80004cc4:	0304b503          	ld	a0,48(s1)
    80004cc8:	ffffc097          	auipc	ra,0xffffc
    80004ccc:	59c080e7          	jalr	1436(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80004cd0:	0284b503          	ld	a0,40(s1)
    80004cd4:	ffffc097          	auipc	ra,0xffffc
    80004cd8:	590080e7          	jalr	1424(ra) # 80001264 <_Z9sem_closeP4_sem>
}
    80004cdc:	01813083          	ld	ra,24(sp)
    80004ce0:	01013403          	ld	s0,16(sp)
    80004ce4:	00813483          	ld	s1,8(sp)
    80004ce8:	02010113          	addi	sp,sp,32
    80004cec:	00008067          	ret

0000000080004cf0 <start>:
    80004cf0:	ff010113          	addi	sp,sp,-16
    80004cf4:	00813423          	sd	s0,8(sp)
    80004cf8:	01010413          	addi	s0,sp,16
    80004cfc:	300027f3          	csrr	a5,mstatus
    80004d00:	ffffe737          	lui	a4,0xffffe
    80004d04:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff35cf>
    80004d08:	00e7f7b3          	and	a5,a5,a4
    80004d0c:	00001737          	lui	a4,0x1
    80004d10:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d14:	00e7e7b3          	or	a5,a5,a4
    80004d18:	30079073          	csrw	mstatus,a5
    80004d1c:	00000797          	auipc	a5,0x0
    80004d20:	16078793          	addi	a5,a5,352 # 80004e7c <system_main>
    80004d24:	34179073          	csrw	mepc,a5
    80004d28:	00000793          	li	a5,0
    80004d2c:	18079073          	csrw	satp,a5
    80004d30:	000107b7          	lui	a5,0x10
    80004d34:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004d38:	30279073          	csrw	medeleg,a5
    80004d3c:	30379073          	csrw	mideleg,a5
    80004d40:	104027f3          	csrr	a5,sie
    80004d44:	2227e793          	ori	a5,a5,546
    80004d48:	10479073          	csrw	sie,a5
    80004d4c:	fff00793          	li	a5,-1
    80004d50:	00a7d793          	srli	a5,a5,0xa
    80004d54:	3b079073          	csrw	pmpaddr0,a5
    80004d58:	00f00793          	li	a5,15
    80004d5c:	3a079073          	csrw	pmpcfg0,a5
    80004d60:	f14027f3          	csrr	a5,mhartid
    80004d64:	0200c737          	lui	a4,0x200c
    80004d68:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004d6c:	0007869b          	sext.w	a3,a5
    80004d70:	00269713          	slli	a4,a3,0x2
    80004d74:	000f4637          	lui	a2,0xf4
    80004d78:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004d7c:	00d70733          	add	a4,a4,a3
    80004d80:	0037979b          	slliw	a5,a5,0x3
    80004d84:	020046b7          	lui	a3,0x2004
    80004d88:	00d787b3          	add	a5,a5,a3
    80004d8c:	00c585b3          	add	a1,a1,a2
    80004d90:	00371693          	slli	a3,a4,0x3
    80004d94:	00005717          	auipc	a4,0x5
    80004d98:	22c70713          	addi	a4,a4,556 # 80009fc0 <timer_scratch>
    80004d9c:	00b7b023          	sd	a1,0(a5)
    80004da0:	00d70733          	add	a4,a4,a3
    80004da4:	00f73c23          	sd	a5,24(a4)
    80004da8:	02c73023          	sd	a2,32(a4)
    80004dac:	34071073          	csrw	mscratch,a4
    80004db0:	00000797          	auipc	a5,0x0
    80004db4:	6e078793          	addi	a5,a5,1760 # 80005490 <timervec>
    80004db8:	30579073          	csrw	mtvec,a5
    80004dbc:	300027f3          	csrr	a5,mstatus
    80004dc0:	0087e793          	ori	a5,a5,8
    80004dc4:	30079073          	csrw	mstatus,a5
    80004dc8:	304027f3          	csrr	a5,mie
    80004dcc:	0807e793          	ori	a5,a5,128
    80004dd0:	30479073          	csrw	mie,a5
    80004dd4:	f14027f3          	csrr	a5,mhartid
    80004dd8:	0007879b          	sext.w	a5,a5
    80004ddc:	00078213          	mv	tp,a5
    80004de0:	30200073          	mret
    80004de4:	00813403          	ld	s0,8(sp)
    80004de8:	01010113          	addi	sp,sp,16
    80004dec:	00008067          	ret

0000000080004df0 <timerinit>:
    80004df0:	ff010113          	addi	sp,sp,-16
    80004df4:	00813423          	sd	s0,8(sp)
    80004df8:	01010413          	addi	s0,sp,16
    80004dfc:	f14027f3          	csrr	a5,mhartid
    80004e00:	0200c737          	lui	a4,0x200c
    80004e04:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004e08:	0007869b          	sext.w	a3,a5
    80004e0c:	00269713          	slli	a4,a3,0x2
    80004e10:	000f4637          	lui	a2,0xf4
    80004e14:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004e18:	00d70733          	add	a4,a4,a3
    80004e1c:	0037979b          	slliw	a5,a5,0x3
    80004e20:	020046b7          	lui	a3,0x2004
    80004e24:	00d787b3          	add	a5,a5,a3
    80004e28:	00c585b3          	add	a1,a1,a2
    80004e2c:	00371693          	slli	a3,a4,0x3
    80004e30:	00005717          	auipc	a4,0x5
    80004e34:	19070713          	addi	a4,a4,400 # 80009fc0 <timer_scratch>
    80004e38:	00b7b023          	sd	a1,0(a5)
    80004e3c:	00d70733          	add	a4,a4,a3
    80004e40:	00f73c23          	sd	a5,24(a4)
    80004e44:	02c73023          	sd	a2,32(a4)
    80004e48:	34071073          	csrw	mscratch,a4
    80004e4c:	00000797          	auipc	a5,0x0
    80004e50:	64478793          	addi	a5,a5,1604 # 80005490 <timervec>
    80004e54:	30579073          	csrw	mtvec,a5
    80004e58:	300027f3          	csrr	a5,mstatus
    80004e5c:	0087e793          	ori	a5,a5,8
    80004e60:	30079073          	csrw	mstatus,a5
    80004e64:	304027f3          	csrr	a5,mie
    80004e68:	0807e793          	ori	a5,a5,128
    80004e6c:	30479073          	csrw	mie,a5
    80004e70:	00813403          	ld	s0,8(sp)
    80004e74:	01010113          	addi	sp,sp,16
    80004e78:	00008067          	ret

0000000080004e7c <system_main>:
    80004e7c:	fe010113          	addi	sp,sp,-32
    80004e80:	00813823          	sd	s0,16(sp)
    80004e84:	00913423          	sd	s1,8(sp)
    80004e88:	00113c23          	sd	ra,24(sp)
    80004e8c:	02010413          	addi	s0,sp,32
    80004e90:	00000097          	auipc	ra,0x0
    80004e94:	0c4080e7          	jalr	196(ra) # 80004f54 <cpuid>
    80004e98:	00005497          	auipc	s1,0x5
    80004e9c:	0a848493          	addi	s1,s1,168 # 80009f40 <started>
    80004ea0:	02050263          	beqz	a0,80004ec4 <system_main+0x48>
    80004ea4:	0004a783          	lw	a5,0(s1)
    80004ea8:	0007879b          	sext.w	a5,a5
    80004eac:	fe078ce3          	beqz	a5,80004ea4 <system_main+0x28>
    80004eb0:	0ff0000f          	fence
    80004eb4:	00003517          	auipc	a0,0x3
    80004eb8:	6e450513          	addi	a0,a0,1764 # 80008598 <kvmincrease+0x14a8>
    80004ebc:	00001097          	auipc	ra,0x1
    80004ec0:	a70080e7          	jalr	-1424(ra) # 8000592c <panic>
    80004ec4:	00001097          	auipc	ra,0x1
    80004ec8:	9c4080e7          	jalr	-1596(ra) # 80005888 <consoleinit>
    80004ecc:	00001097          	auipc	ra,0x1
    80004ed0:	150080e7          	jalr	336(ra) # 8000601c <printfinit>
    80004ed4:	00003517          	auipc	a0,0x3
    80004ed8:	29c50513          	addi	a0,a0,668 # 80008170 <kvmincrease+0x1080>
    80004edc:	00001097          	auipc	ra,0x1
    80004ee0:	aac080e7          	jalr	-1364(ra) # 80005988 <__printf>
    80004ee4:	00003517          	auipc	a0,0x3
    80004ee8:	68450513          	addi	a0,a0,1668 # 80008568 <kvmincrease+0x1478>
    80004eec:	00001097          	auipc	ra,0x1
    80004ef0:	a9c080e7          	jalr	-1380(ra) # 80005988 <__printf>
    80004ef4:	00003517          	auipc	a0,0x3
    80004ef8:	27c50513          	addi	a0,a0,636 # 80008170 <kvmincrease+0x1080>
    80004efc:	00001097          	auipc	ra,0x1
    80004f00:	a8c080e7          	jalr	-1396(ra) # 80005988 <__printf>
    80004f04:	00001097          	auipc	ra,0x1
    80004f08:	4a4080e7          	jalr	1188(ra) # 800063a8 <kinit>
    80004f0c:	00000097          	auipc	ra,0x0
    80004f10:	148080e7          	jalr	328(ra) # 80005054 <trapinit>
    80004f14:	00000097          	auipc	ra,0x0
    80004f18:	16c080e7          	jalr	364(ra) # 80005080 <trapinithart>
    80004f1c:	00000097          	auipc	ra,0x0
    80004f20:	5b4080e7          	jalr	1460(ra) # 800054d0 <plicinit>
    80004f24:	00000097          	auipc	ra,0x0
    80004f28:	5d4080e7          	jalr	1492(ra) # 800054f8 <plicinithart>
    80004f2c:	00000097          	auipc	ra,0x0
    80004f30:	078080e7          	jalr	120(ra) # 80004fa4 <userinit>
    80004f34:	0ff0000f          	fence
    80004f38:	00100793          	li	a5,1
    80004f3c:	00003517          	auipc	a0,0x3
    80004f40:	64450513          	addi	a0,a0,1604 # 80008580 <kvmincrease+0x1490>
    80004f44:	00f4a023          	sw	a5,0(s1)
    80004f48:	00001097          	auipc	ra,0x1
    80004f4c:	a40080e7          	jalr	-1472(ra) # 80005988 <__printf>
    80004f50:	0000006f          	j	80004f50 <system_main+0xd4>

0000000080004f54 <cpuid>:
    80004f54:	ff010113          	addi	sp,sp,-16
    80004f58:	00813423          	sd	s0,8(sp)
    80004f5c:	01010413          	addi	s0,sp,16
    80004f60:	00020513          	mv	a0,tp
    80004f64:	00813403          	ld	s0,8(sp)
    80004f68:	0005051b          	sext.w	a0,a0
    80004f6c:	01010113          	addi	sp,sp,16
    80004f70:	00008067          	ret

0000000080004f74 <mycpu>:
    80004f74:	ff010113          	addi	sp,sp,-16
    80004f78:	00813423          	sd	s0,8(sp)
    80004f7c:	01010413          	addi	s0,sp,16
    80004f80:	00020793          	mv	a5,tp
    80004f84:	00813403          	ld	s0,8(sp)
    80004f88:	0007879b          	sext.w	a5,a5
    80004f8c:	00779793          	slli	a5,a5,0x7
    80004f90:	00006517          	auipc	a0,0x6
    80004f94:	06050513          	addi	a0,a0,96 # 8000aff0 <cpus>
    80004f98:	00f50533          	add	a0,a0,a5
    80004f9c:	01010113          	addi	sp,sp,16
    80004fa0:	00008067          	ret

0000000080004fa4 <userinit>:
    80004fa4:	ff010113          	addi	sp,sp,-16
    80004fa8:	00813423          	sd	s0,8(sp)
    80004fac:	01010413          	addi	s0,sp,16
    80004fb0:	00813403          	ld	s0,8(sp)
    80004fb4:	01010113          	addi	sp,sp,16
    80004fb8:	ffffc317          	auipc	t1,0xffffc
    80004fbc:	6f030067          	jr	1776(t1) # 800016a8 <main>

0000000080004fc0 <either_copyout>:
    80004fc0:	ff010113          	addi	sp,sp,-16
    80004fc4:	00813023          	sd	s0,0(sp)
    80004fc8:	00113423          	sd	ra,8(sp)
    80004fcc:	01010413          	addi	s0,sp,16
    80004fd0:	02051663          	bnez	a0,80004ffc <either_copyout+0x3c>
    80004fd4:	00058513          	mv	a0,a1
    80004fd8:	00060593          	mv	a1,a2
    80004fdc:	0006861b          	sext.w	a2,a3
    80004fe0:	00002097          	auipc	ra,0x2
    80004fe4:	c54080e7          	jalr	-940(ra) # 80006c34 <__memmove>
    80004fe8:	00813083          	ld	ra,8(sp)
    80004fec:	00013403          	ld	s0,0(sp)
    80004ff0:	00000513          	li	a0,0
    80004ff4:	01010113          	addi	sp,sp,16
    80004ff8:	00008067          	ret
    80004ffc:	00003517          	auipc	a0,0x3
    80005000:	5c450513          	addi	a0,a0,1476 # 800085c0 <kvmincrease+0x14d0>
    80005004:	00001097          	auipc	ra,0x1
    80005008:	928080e7          	jalr	-1752(ra) # 8000592c <panic>

000000008000500c <either_copyin>:
    8000500c:	ff010113          	addi	sp,sp,-16
    80005010:	00813023          	sd	s0,0(sp)
    80005014:	00113423          	sd	ra,8(sp)
    80005018:	01010413          	addi	s0,sp,16
    8000501c:	02059463          	bnez	a1,80005044 <either_copyin+0x38>
    80005020:	00060593          	mv	a1,a2
    80005024:	0006861b          	sext.w	a2,a3
    80005028:	00002097          	auipc	ra,0x2
    8000502c:	c0c080e7          	jalr	-1012(ra) # 80006c34 <__memmove>
    80005030:	00813083          	ld	ra,8(sp)
    80005034:	00013403          	ld	s0,0(sp)
    80005038:	00000513          	li	a0,0
    8000503c:	01010113          	addi	sp,sp,16
    80005040:	00008067          	ret
    80005044:	00003517          	auipc	a0,0x3
    80005048:	5a450513          	addi	a0,a0,1444 # 800085e8 <kvmincrease+0x14f8>
    8000504c:	00001097          	auipc	ra,0x1
    80005050:	8e0080e7          	jalr	-1824(ra) # 8000592c <panic>

0000000080005054 <trapinit>:
    80005054:	ff010113          	addi	sp,sp,-16
    80005058:	00813423          	sd	s0,8(sp)
    8000505c:	01010413          	addi	s0,sp,16
    80005060:	00813403          	ld	s0,8(sp)
    80005064:	00003597          	auipc	a1,0x3
    80005068:	5ac58593          	addi	a1,a1,1452 # 80008610 <kvmincrease+0x1520>
    8000506c:	00006517          	auipc	a0,0x6
    80005070:	00450513          	addi	a0,a0,4 # 8000b070 <tickslock>
    80005074:	01010113          	addi	sp,sp,16
    80005078:	00001317          	auipc	t1,0x1
    8000507c:	5c030067          	jr	1472(t1) # 80006638 <initlock>

0000000080005080 <trapinithart>:
    80005080:	ff010113          	addi	sp,sp,-16
    80005084:	00813423          	sd	s0,8(sp)
    80005088:	01010413          	addi	s0,sp,16
    8000508c:	00000797          	auipc	a5,0x0
    80005090:	2f478793          	addi	a5,a5,756 # 80005380 <kernelvec>
    80005094:	10579073          	csrw	stvec,a5
    80005098:	00813403          	ld	s0,8(sp)
    8000509c:	01010113          	addi	sp,sp,16
    800050a0:	00008067          	ret

00000000800050a4 <usertrap>:
    800050a4:	ff010113          	addi	sp,sp,-16
    800050a8:	00813423          	sd	s0,8(sp)
    800050ac:	01010413          	addi	s0,sp,16
    800050b0:	00813403          	ld	s0,8(sp)
    800050b4:	01010113          	addi	sp,sp,16
    800050b8:	00008067          	ret

00000000800050bc <usertrapret>:
    800050bc:	ff010113          	addi	sp,sp,-16
    800050c0:	00813423          	sd	s0,8(sp)
    800050c4:	01010413          	addi	s0,sp,16
    800050c8:	00813403          	ld	s0,8(sp)
    800050cc:	01010113          	addi	sp,sp,16
    800050d0:	00008067          	ret

00000000800050d4 <kerneltrap>:
    800050d4:	fe010113          	addi	sp,sp,-32
    800050d8:	00813823          	sd	s0,16(sp)
    800050dc:	00113c23          	sd	ra,24(sp)
    800050e0:	00913423          	sd	s1,8(sp)
    800050e4:	02010413          	addi	s0,sp,32
    800050e8:	142025f3          	csrr	a1,scause
    800050ec:	100027f3          	csrr	a5,sstatus
    800050f0:	0027f793          	andi	a5,a5,2
    800050f4:	10079c63          	bnez	a5,8000520c <kerneltrap+0x138>
    800050f8:	142027f3          	csrr	a5,scause
    800050fc:	0207ce63          	bltz	a5,80005138 <kerneltrap+0x64>
    80005100:	00003517          	auipc	a0,0x3
    80005104:	55850513          	addi	a0,a0,1368 # 80008658 <kvmincrease+0x1568>
    80005108:	00001097          	auipc	ra,0x1
    8000510c:	880080e7          	jalr	-1920(ra) # 80005988 <__printf>
    80005110:	141025f3          	csrr	a1,sepc
    80005114:	14302673          	csrr	a2,stval
    80005118:	00003517          	auipc	a0,0x3
    8000511c:	55050513          	addi	a0,a0,1360 # 80008668 <kvmincrease+0x1578>
    80005120:	00001097          	auipc	ra,0x1
    80005124:	868080e7          	jalr	-1944(ra) # 80005988 <__printf>
    80005128:	00003517          	auipc	a0,0x3
    8000512c:	55850513          	addi	a0,a0,1368 # 80008680 <kvmincrease+0x1590>
    80005130:	00000097          	auipc	ra,0x0
    80005134:	7fc080e7          	jalr	2044(ra) # 8000592c <panic>
    80005138:	0ff7f713          	andi	a4,a5,255
    8000513c:	00900693          	li	a3,9
    80005140:	04d70063          	beq	a4,a3,80005180 <kerneltrap+0xac>
    80005144:	fff00713          	li	a4,-1
    80005148:	03f71713          	slli	a4,a4,0x3f
    8000514c:	00170713          	addi	a4,a4,1
    80005150:	fae798e3          	bne	a5,a4,80005100 <kerneltrap+0x2c>
    80005154:	00000097          	auipc	ra,0x0
    80005158:	e00080e7          	jalr	-512(ra) # 80004f54 <cpuid>
    8000515c:	06050663          	beqz	a0,800051c8 <kerneltrap+0xf4>
    80005160:	144027f3          	csrr	a5,sip
    80005164:	ffd7f793          	andi	a5,a5,-3
    80005168:	14479073          	csrw	sip,a5
    8000516c:	01813083          	ld	ra,24(sp)
    80005170:	01013403          	ld	s0,16(sp)
    80005174:	00813483          	ld	s1,8(sp)
    80005178:	02010113          	addi	sp,sp,32
    8000517c:	00008067          	ret
    80005180:	00000097          	auipc	ra,0x0
    80005184:	3c4080e7          	jalr	964(ra) # 80005544 <plic_claim>
    80005188:	00a00793          	li	a5,10
    8000518c:	00050493          	mv	s1,a0
    80005190:	06f50863          	beq	a0,a5,80005200 <kerneltrap+0x12c>
    80005194:	fc050ce3          	beqz	a0,8000516c <kerneltrap+0x98>
    80005198:	00050593          	mv	a1,a0
    8000519c:	00003517          	auipc	a0,0x3
    800051a0:	49c50513          	addi	a0,a0,1180 # 80008638 <kvmincrease+0x1548>
    800051a4:	00000097          	auipc	ra,0x0
    800051a8:	7e4080e7          	jalr	2020(ra) # 80005988 <__printf>
    800051ac:	01013403          	ld	s0,16(sp)
    800051b0:	01813083          	ld	ra,24(sp)
    800051b4:	00048513          	mv	a0,s1
    800051b8:	00813483          	ld	s1,8(sp)
    800051bc:	02010113          	addi	sp,sp,32
    800051c0:	00000317          	auipc	t1,0x0
    800051c4:	3bc30067          	jr	956(t1) # 8000557c <plic_complete>
    800051c8:	00006517          	auipc	a0,0x6
    800051cc:	ea850513          	addi	a0,a0,-344 # 8000b070 <tickslock>
    800051d0:	00001097          	auipc	ra,0x1
    800051d4:	48c080e7          	jalr	1164(ra) # 8000665c <acquire>
    800051d8:	00005717          	auipc	a4,0x5
    800051dc:	d6c70713          	addi	a4,a4,-660 # 80009f44 <ticks>
    800051e0:	00072783          	lw	a5,0(a4)
    800051e4:	00006517          	auipc	a0,0x6
    800051e8:	e8c50513          	addi	a0,a0,-372 # 8000b070 <tickslock>
    800051ec:	0017879b          	addiw	a5,a5,1
    800051f0:	00f72023          	sw	a5,0(a4)
    800051f4:	00001097          	auipc	ra,0x1
    800051f8:	534080e7          	jalr	1332(ra) # 80006728 <release>
    800051fc:	f65ff06f          	j	80005160 <kerneltrap+0x8c>
    80005200:	00001097          	auipc	ra,0x1
    80005204:	090080e7          	jalr	144(ra) # 80006290 <uartintr>
    80005208:	fa5ff06f          	j	800051ac <kerneltrap+0xd8>
    8000520c:	00003517          	auipc	a0,0x3
    80005210:	40c50513          	addi	a0,a0,1036 # 80008618 <kvmincrease+0x1528>
    80005214:	00000097          	auipc	ra,0x0
    80005218:	718080e7          	jalr	1816(ra) # 8000592c <panic>

000000008000521c <clockintr>:
    8000521c:	fe010113          	addi	sp,sp,-32
    80005220:	00813823          	sd	s0,16(sp)
    80005224:	00913423          	sd	s1,8(sp)
    80005228:	00113c23          	sd	ra,24(sp)
    8000522c:	02010413          	addi	s0,sp,32
    80005230:	00006497          	auipc	s1,0x6
    80005234:	e4048493          	addi	s1,s1,-448 # 8000b070 <tickslock>
    80005238:	00048513          	mv	a0,s1
    8000523c:	00001097          	auipc	ra,0x1
    80005240:	420080e7          	jalr	1056(ra) # 8000665c <acquire>
    80005244:	00005717          	auipc	a4,0x5
    80005248:	d0070713          	addi	a4,a4,-768 # 80009f44 <ticks>
    8000524c:	00072783          	lw	a5,0(a4)
    80005250:	01013403          	ld	s0,16(sp)
    80005254:	01813083          	ld	ra,24(sp)
    80005258:	00048513          	mv	a0,s1
    8000525c:	0017879b          	addiw	a5,a5,1
    80005260:	00813483          	ld	s1,8(sp)
    80005264:	00f72023          	sw	a5,0(a4)
    80005268:	02010113          	addi	sp,sp,32
    8000526c:	00001317          	auipc	t1,0x1
    80005270:	4bc30067          	jr	1212(t1) # 80006728 <release>

0000000080005274 <devintr>:
    80005274:	142027f3          	csrr	a5,scause
    80005278:	00000513          	li	a0,0
    8000527c:	0007c463          	bltz	a5,80005284 <devintr+0x10>
    80005280:	00008067          	ret
    80005284:	fe010113          	addi	sp,sp,-32
    80005288:	00813823          	sd	s0,16(sp)
    8000528c:	00113c23          	sd	ra,24(sp)
    80005290:	00913423          	sd	s1,8(sp)
    80005294:	02010413          	addi	s0,sp,32
    80005298:	0ff7f713          	andi	a4,a5,255
    8000529c:	00900693          	li	a3,9
    800052a0:	04d70c63          	beq	a4,a3,800052f8 <devintr+0x84>
    800052a4:	fff00713          	li	a4,-1
    800052a8:	03f71713          	slli	a4,a4,0x3f
    800052ac:	00170713          	addi	a4,a4,1
    800052b0:	00e78c63          	beq	a5,a4,800052c8 <devintr+0x54>
    800052b4:	01813083          	ld	ra,24(sp)
    800052b8:	01013403          	ld	s0,16(sp)
    800052bc:	00813483          	ld	s1,8(sp)
    800052c0:	02010113          	addi	sp,sp,32
    800052c4:	00008067          	ret
    800052c8:	00000097          	auipc	ra,0x0
    800052cc:	c8c080e7          	jalr	-884(ra) # 80004f54 <cpuid>
    800052d0:	06050663          	beqz	a0,8000533c <devintr+0xc8>
    800052d4:	144027f3          	csrr	a5,sip
    800052d8:	ffd7f793          	andi	a5,a5,-3
    800052dc:	14479073          	csrw	sip,a5
    800052e0:	01813083          	ld	ra,24(sp)
    800052e4:	01013403          	ld	s0,16(sp)
    800052e8:	00813483          	ld	s1,8(sp)
    800052ec:	00200513          	li	a0,2
    800052f0:	02010113          	addi	sp,sp,32
    800052f4:	00008067          	ret
    800052f8:	00000097          	auipc	ra,0x0
    800052fc:	24c080e7          	jalr	588(ra) # 80005544 <plic_claim>
    80005300:	00a00793          	li	a5,10
    80005304:	00050493          	mv	s1,a0
    80005308:	06f50663          	beq	a0,a5,80005374 <devintr+0x100>
    8000530c:	00100513          	li	a0,1
    80005310:	fa0482e3          	beqz	s1,800052b4 <devintr+0x40>
    80005314:	00048593          	mv	a1,s1
    80005318:	00003517          	auipc	a0,0x3
    8000531c:	32050513          	addi	a0,a0,800 # 80008638 <kvmincrease+0x1548>
    80005320:	00000097          	auipc	ra,0x0
    80005324:	668080e7          	jalr	1640(ra) # 80005988 <__printf>
    80005328:	00048513          	mv	a0,s1
    8000532c:	00000097          	auipc	ra,0x0
    80005330:	250080e7          	jalr	592(ra) # 8000557c <plic_complete>
    80005334:	00100513          	li	a0,1
    80005338:	f7dff06f          	j	800052b4 <devintr+0x40>
    8000533c:	00006517          	auipc	a0,0x6
    80005340:	d3450513          	addi	a0,a0,-716 # 8000b070 <tickslock>
    80005344:	00001097          	auipc	ra,0x1
    80005348:	318080e7          	jalr	792(ra) # 8000665c <acquire>
    8000534c:	00005717          	auipc	a4,0x5
    80005350:	bf870713          	addi	a4,a4,-1032 # 80009f44 <ticks>
    80005354:	00072783          	lw	a5,0(a4)
    80005358:	00006517          	auipc	a0,0x6
    8000535c:	d1850513          	addi	a0,a0,-744 # 8000b070 <tickslock>
    80005360:	0017879b          	addiw	a5,a5,1
    80005364:	00f72023          	sw	a5,0(a4)
    80005368:	00001097          	auipc	ra,0x1
    8000536c:	3c0080e7          	jalr	960(ra) # 80006728 <release>
    80005370:	f65ff06f          	j	800052d4 <devintr+0x60>
    80005374:	00001097          	auipc	ra,0x1
    80005378:	f1c080e7          	jalr	-228(ra) # 80006290 <uartintr>
    8000537c:	fadff06f          	j	80005328 <devintr+0xb4>

0000000080005380 <kernelvec>:
    80005380:	f0010113          	addi	sp,sp,-256
    80005384:	00113023          	sd	ra,0(sp)
    80005388:	00213423          	sd	sp,8(sp)
    8000538c:	00313823          	sd	gp,16(sp)
    80005390:	00413c23          	sd	tp,24(sp)
    80005394:	02513023          	sd	t0,32(sp)
    80005398:	02613423          	sd	t1,40(sp)
    8000539c:	02713823          	sd	t2,48(sp)
    800053a0:	02813c23          	sd	s0,56(sp)
    800053a4:	04913023          	sd	s1,64(sp)
    800053a8:	04a13423          	sd	a0,72(sp)
    800053ac:	04b13823          	sd	a1,80(sp)
    800053b0:	04c13c23          	sd	a2,88(sp)
    800053b4:	06d13023          	sd	a3,96(sp)
    800053b8:	06e13423          	sd	a4,104(sp)
    800053bc:	06f13823          	sd	a5,112(sp)
    800053c0:	07013c23          	sd	a6,120(sp)
    800053c4:	09113023          	sd	a7,128(sp)
    800053c8:	09213423          	sd	s2,136(sp)
    800053cc:	09313823          	sd	s3,144(sp)
    800053d0:	09413c23          	sd	s4,152(sp)
    800053d4:	0b513023          	sd	s5,160(sp)
    800053d8:	0b613423          	sd	s6,168(sp)
    800053dc:	0b713823          	sd	s7,176(sp)
    800053e0:	0b813c23          	sd	s8,184(sp)
    800053e4:	0d913023          	sd	s9,192(sp)
    800053e8:	0da13423          	sd	s10,200(sp)
    800053ec:	0db13823          	sd	s11,208(sp)
    800053f0:	0dc13c23          	sd	t3,216(sp)
    800053f4:	0fd13023          	sd	t4,224(sp)
    800053f8:	0fe13423          	sd	t5,232(sp)
    800053fc:	0ff13823          	sd	t6,240(sp)
    80005400:	cd5ff0ef          	jal	ra,800050d4 <kerneltrap>
    80005404:	00013083          	ld	ra,0(sp)
    80005408:	00813103          	ld	sp,8(sp)
    8000540c:	01013183          	ld	gp,16(sp)
    80005410:	02013283          	ld	t0,32(sp)
    80005414:	02813303          	ld	t1,40(sp)
    80005418:	03013383          	ld	t2,48(sp)
    8000541c:	03813403          	ld	s0,56(sp)
    80005420:	04013483          	ld	s1,64(sp)
    80005424:	04813503          	ld	a0,72(sp)
    80005428:	05013583          	ld	a1,80(sp)
    8000542c:	05813603          	ld	a2,88(sp)
    80005430:	06013683          	ld	a3,96(sp)
    80005434:	06813703          	ld	a4,104(sp)
    80005438:	07013783          	ld	a5,112(sp)
    8000543c:	07813803          	ld	a6,120(sp)
    80005440:	08013883          	ld	a7,128(sp)
    80005444:	08813903          	ld	s2,136(sp)
    80005448:	09013983          	ld	s3,144(sp)
    8000544c:	09813a03          	ld	s4,152(sp)
    80005450:	0a013a83          	ld	s5,160(sp)
    80005454:	0a813b03          	ld	s6,168(sp)
    80005458:	0b013b83          	ld	s7,176(sp)
    8000545c:	0b813c03          	ld	s8,184(sp)
    80005460:	0c013c83          	ld	s9,192(sp)
    80005464:	0c813d03          	ld	s10,200(sp)
    80005468:	0d013d83          	ld	s11,208(sp)
    8000546c:	0d813e03          	ld	t3,216(sp)
    80005470:	0e013e83          	ld	t4,224(sp)
    80005474:	0e813f03          	ld	t5,232(sp)
    80005478:	0f013f83          	ld	t6,240(sp)
    8000547c:	10010113          	addi	sp,sp,256
    80005480:	10200073          	sret
    80005484:	00000013          	nop
    80005488:	00000013          	nop
    8000548c:	00000013          	nop

0000000080005490 <timervec>:
    80005490:	34051573          	csrrw	a0,mscratch,a0
    80005494:	00b53023          	sd	a1,0(a0)
    80005498:	00c53423          	sd	a2,8(a0)
    8000549c:	00d53823          	sd	a3,16(a0)
    800054a0:	01853583          	ld	a1,24(a0)
    800054a4:	02053603          	ld	a2,32(a0)
    800054a8:	0005b683          	ld	a3,0(a1)
    800054ac:	00c686b3          	add	a3,a3,a2
    800054b0:	00d5b023          	sd	a3,0(a1)
    800054b4:	00200593          	li	a1,2
    800054b8:	14459073          	csrw	sip,a1
    800054bc:	01053683          	ld	a3,16(a0)
    800054c0:	00853603          	ld	a2,8(a0)
    800054c4:	00053583          	ld	a1,0(a0)
    800054c8:	34051573          	csrrw	a0,mscratch,a0
    800054cc:	30200073          	mret

00000000800054d0 <plicinit>:
    800054d0:	ff010113          	addi	sp,sp,-16
    800054d4:	00813423          	sd	s0,8(sp)
    800054d8:	01010413          	addi	s0,sp,16
    800054dc:	00813403          	ld	s0,8(sp)
    800054e0:	0c0007b7          	lui	a5,0xc000
    800054e4:	00100713          	li	a4,1
    800054e8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800054ec:	00e7a223          	sw	a4,4(a5)
    800054f0:	01010113          	addi	sp,sp,16
    800054f4:	00008067          	ret

00000000800054f8 <plicinithart>:
    800054f8:	ff010113          	addi	sp,sp,-16
    800054fc:	00813023          	sd	s0,0(sp)
    80005500:	00113423          	sd	ra,8(sp)
    80005504:	01010413          	addi	s0,sp,16
    80005508:	00000097          	auipc	ra,0x0
    8000550c:	a4c080e7          	jalr	-1460(ra) # 80004f54 <cpuid>
    80005510:	0085171b          	slliw	a4,a0,0x8
    80005514:	0c0027b7          	lui	a5,0xc002
    80005518:	00e787b3          	add	a5,a5,a4
    8000551c:	40200713          	li	a4,1026
    80005520:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005524:	00813083          	ld	ra,8(sp)
    80005528:	00013403          	ld	s0,0(sp)
    8000552c:	00d5151b          	slliw	a0,a0,0xd
    80005530:	0c2017b7          	lui	a5,0xc201
    80005534:	00a78533          	add	a0,a5,a0
    80005538:	00052023          	sw	zero,0(a0)
    8000553c:	01010113          	addi	sp,sp,16
    80005540:	00008067          	ret

0000000080005544 <plic_claim>:
    80005544:	ff010113          	addi	sp,sp,-16
    80005548:	00813023          	sd	s0,0(sp)
    8000554c:	00113423          	sd	ra,8(sp)
    80005550:	01010413          	addi	s0,sp,16
    80005554:	00000097          	auipc	ra,0x0
    80005558:	a00080e7          	jalr	-1536(ra) # 80004f54 <cpuid>
    8000555c:	00813083          	ld	ra,8(sp)
    80005560:	00013403          	ld	s0,0(sp)
    80005564:	00d5151b          	slliw	a0,a0,0xd
    80005568:	0c2017b7          	lui	a5,0xc201
    8000556c:	00a78533          	add	a0,a5,a0
    80005570:	00452503          	lw	a0,4(a0)
    80005574:	01010113          	addi	sp,sp,16
    80005578:	00008067          	ret

000000008000557c <plic_complete>:
    8000557c:	fe010113          	addi	sp,sp,-32
    80005580:	00813823          	sd	s0,16(sp)
    80005584:	00913423          	sd	s1,8(sp)
    80005588:	00113c23          	sd	ra,24(sp)
    8000558c:	02010413          	addi	s0,sp,32
    80005590:	00050493          	mv	s1,a0
    80005594:	00000097          	auipc	ra,0x0
    80005598:	9c0080e7          	jalr	-1600(ra) # 80004f54 <cpuid>
    8000559c:	01813083          	ld	ra,24(sp)
    800055a0:	01013403          	ld	s0,16(sp)
    800055a4:	00d5179b          	slliw	a5,a0,0xd
    800055a8:	0c201737          	lui	a4,0xc201
    800055ac:	00f707b3          	add	a5,a4,a5
    800055b0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800055b4:	00813483          	ld	s1,8(sp)
    800055b8:	02010113          	addi	sp,sp,32
    800055bc:	00008067          	ret

00000000800055c0 <consolewrite>:
    800055c0:	fb010113          	addi	sp,sp,-80
    800055c4:	04813023          	sd	s0,64(sp)
    800055c8:	04113423          	sd	ra,72(sp)
    800055cc:	02913c23          	sd	s1,56(sp)
    800055d0:	03213823          	sd	s2,48(sp)
    800055d4:	03313423          	sd	s3,40(sp)
    800055d8:	03413023          	sd	s4,32(sp)
    800055dc:	01513c23          	sd	s5,24(sp)
    800055e0:	05010413          	addi	s0,sp,80
    800055e4:	06c05c63          	blez	a2,8000565c <consolewrite+0x9c>
    800055e8:	00060993          	mv	s3,a2
    800055ec:	00050a13          	mv	s4,a0
    800055f0:	00058493          	mv	s1,a1
    800055f4:	00000913          	li	s2,0
    800055f8:	fff00a93          	li	s5,-1
    800055fc:	01c0006f          	j	80005618 <consolewrite+0x58>
    80005600:	fbf44503          	lbu	a0,-65(s0)
    80005604:	0019091b          	addiw	s2,s2,1
    80005608:	00148493          	addi	s1,s1,1
    8000560c:	00001097          	auipc	ra,0x1
    80005610:	a9c080e7          	jalr	-1380(ra) # 800060a8 <uartputc>
    80005614:	03298063          	beq	s3,s2,80005634 <consolewrite+0x74>
    80005618:	00048613          	mv	a2,s1
    8000561c:	00100693          	li	a3,1
    80005620:	000a0593          	mv	a1,s4
    80005624:	fbf40513          	addi	a0,s0,-65
    80005628:	00000097          	auipc	ra,0x0
    8000562c:	9e4080e7          	jalr	-1564(ra) # 8000500c <either_copyin>
    80005630:	fd5518e3          	bne	a0,s5,80005600 <consolewrite+0x40>
    80005634:	04813083          	ld	ra,72(sp)
    80005638:	04013403          	ld	s0,64(sp)
    8000563c:	03813483          	ld	s1,56(sp)
    80005640:	02813983          	ld	s3,40(sp)
    80005644:	02013a03          	ld	s4,32(sp)
    80005648:	01813a83          	ld	s5,24(sp)
    8000564c:	00090513          	mv	a0,s2
    80005650:	03013903          	ld	s2,48(sp)
    80005654:	05010113          	addi	sp,sp,80
    80005658:	00008067          	ret
    8000565c:	00000913          	li	s2,0
    80005660:	fd5ff06f          	j	80005634 <consolewrite+0x74>

0000000080005664 <consoleread>:
    80005664:	f9010113          	addi	sp,sp,-112
    80005668:	06813023          	sd	s0,96(sp)
    8000566c:	04913c23          	sd	s1,88(sp)
    80005670:	05213823          	sd	s2,80(sp)
    80005674:	05313423          	sd	s3,72(sp)
    80005678:	05413023          	sd	s4,64(sp)
    8000567c:	03513c23          	sd	s5,56(sp)
    80005680:	03613823          	sd	s6,48(sp)
    80005684:	03713423          	sd	s7,40(sp)
    80005688:	03813023          	sd	s8,32(sp)
    8000568c:	06113423          	sd	ra,104(sp)
    80005690:	01913c23          	sd	s9,24(sp)
    80005694:	07010413          	addi	s0,sp,112
    80005698:	00060b93          	mv	s7,a2
    8000569c:	00050913          	mv	s2,a0
    800056a0:	00058c13          	mv	s8,a1
    800056a4:	00060b1b          	sext.w	s6,a2
    800056a8:	00006497          	auipc	s1,0x6
    800056ac:	9f048493          	addi	s1,s1,-1552 # 8000b098 <cons>
    800056b0:	00400993          	li	s3,4
    800056b4:	fff00a13          	li	s4,-1
    800056b8:	00a00a93          	li	s5,10
    800056bc:	05705e63          	blez	s7,80005718 <consoleread+0xb4>
    800056c0:	09c4a703          	lw	a4,156(s1)
    800056c4:	0984a783          	lw	a5,152(s1)
    800056c8:	0007071b          	sext.w	a4,a4
    800056cc:	08e78463          	beq	a5,a4,80005754 <consoleread+0xf0>
    800056d0:	07f7f713          	andi	a4,a5,127
    800056d4:	00e48733          	add	a4,s1,a4
    800056d8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800056dc:	0017869b          	addiw	a3,a5,1
    800056e0:	08d4ac23          	sw	a3,152(s1)
    800056e4:	00070c9b          	sext.w	s9,a4
    800056e8:	0b370663          	beq	a4,s3,80005794 <consoleread+0x130>
    800056ec:	00100693          	li	a3,1
    800056f0:	f9f40613          	addi	a2,s0,-97
    800056f4:	000c0593          	mv	a1,s8
    800056f8:	00090513          	mv	a0,s2
    800056fc:	f8e40fa3          	sb	a4,-97(s0)
    80005700:	00000097          	auipc	ra,0x0
    80005704:	8c0080e7          	jalr	-1856(ra) # 80004fc0 <either_copyout>
    80005708:	01450863          	beq	a0,s4,80005718 <consoleread+0xb4>
    8000570c:	001c0c13          	addi	s8,s8,1
    80005710:	fffb8b9b          	addiw	s7,s7,-1
    80005714:	fb5c94e3          	bne	s9,s5,800056bc <consoleread+0x58>
    80005718:	000b851b          	sext.w	a0,s7
    8000571c:	06813083          	ld	ra,104(sp)
    80005720:	06013403          	ld	s0,96(sp)
    80005724:	05813483          	ld	s1,88(sp)
    80005728:	05013903          	ld	s2,80(sp)
    8000572c:	04813983          	ld	s3,72(sp)
    80005730:	04013a03          	ld	s4,64(sp)
    80005734:	03813a83          	ld	s5,56(sp)
    80005738:	02813b83          	ld	s7,40(sp)
    8000573c:	02013c03          	ld	s8,32(sp)
    80005740:	01813c83          	ld	s9,24(sp)
    80005744:	40ab053b          	subw	a0,s6,a0
    80005748:	03013b03          	ld	s6,48(sp)
    8000574c:	07010113          	addi	sp,sp,112
    80005750:	00008067          	ret
    80005754:	00001097          	auipc	ra,0x1
    80005758:	1d8080e7          	jalr	472(ra) # 8000692c <push_on>
    8000575c:	0984a703          	lw	a4,152(s1)
    80005760:	09c4a783          	lw	a5,156(s1)
    80005764:	0007879b          	sext.w	a5,a5
    80005768:	fef70ce3          	beq	a4,a5,80005760 <consoleread+0xfc>
    8000576c:	00001097          	auipc	ra,0x1
    80005770:	234080e7          	jalr	564(ra) # 800069a0 <pop_on>
    80005774:	0984a783          	lw	a5,152(s1)
    80005778:	07f7f713          	andi	a4,a5,127
    8000577c:	00e48733          	add	a4,s1,a4
    80005780:	01874703          	lbu	a4,24(a4)
    80005784:	0017869b          	addiw	a3,a5,1
    80005788:	08d4ac23          	sw	a3,152(s1)
    8000578c:	00070c9b          	sext.w	s9,a4
    80005790:	f5371ee3          	bne	a4,s3,800056ec <consoleread+0x88>
    80005794:	000b851b          	sext.w	a0,s7
    80005798:	f96bf2e3          	bgeu	s7,s6,8000571c <consoleread+0xb8>
    8000579c:	08f4ac23          	sw	a5,152(s1)
    800057a0:	f7dff06f          	j	8000571c <consoleread+0xb8>

00000000800057a4 <consputc>:
    800057a4:	10000793          	li	a5,256
    800057a8:	00f50663          	beq	a0,a5,800057b4 <consputc+0x10>
    800057ac:	00001317          	auipc	t1,0x1
    800057b0:	9f430067          	jr	-1548(t1) # 800061a0 <uartputc_sync>
    800057b4:	ff010113          	addi	sp,sp,-16
    800057b8:	00113423          	sd	ra,8(sp)
    800057bc:	00813023          	sd	s0,0(sp)
    800057c0:	01010413          	addi	s0,sp,16
    800057c4:	00800513          	li	a0,8
    800057c8:	00001097          	auipc	ra,0x1
    800057cc:	9d8080e7          	jalr	-1576(ra) # 800061a0 <uartputc_sync>
    800057d0:	02000513          	li	a0,32
    800057d4:	00001097          	auipc	ra,0x1
    800057d8:	9cc080e7          	jalr	-1588(ra) # 800061a0 <uartputc_sync>
    800057dc:	00013403          	ld	s0,0(sp)
    800057e0:	00813083          	ld	ra,8(sp)
    800057e4:	00800513          	li	a0,8
    800057e8:	01010113          	addi	sp,sp,16
    800057ec:	00001317          	auipc	t1,0x1
    800057f0:	9b430067          	jr	-1612(t1) # 800061a0 <uartputc_sync>

00000000800057f4 <consoleintr>:
    800057f4:	fe010113          	addi	sp,sp,-32
    800057f8:	00813823          	sd	s0,16(sp)
    800057fc:	00913423          	sd	s1,8(sp)
    80005800:	01213023          	sd	s2,0(sp)
    80005804:	00113c23          	sd	ra,24(sp)
    80005808:	02010413          	addi	s0,sp,32
    8000580c:	00006917          	auipc	s2,0x6
    80005810:	88c90913          	addi	s2,s2,-1908 # 8000b098 <cons>
    80005814:	00050493          	mv	s1,a0
    80005818:	00090513          	mv	a0,s2
    8000581c:	00001097          	auipc	ra,0x1
    80005820:	e40080e7          	jalr	-448(ra) # 8000665c <acquire>
    80005824:	02048c63          	beqz	s1,8000585c <consoleintr+0x68>
    80005828:	0a092783          	lw	a5,160(s2)
    8000582c:	09892703          	lw	a4,152(s2)
    80005830:	07f00693          	li	a3,127
    80005834:	40e7873b          	subw	a4,a5,a4
    80005838:	02e6e263          	bltu	a3,a4,8000585c <consoleintr+0x68>
    8000583c:	00d00713          	li	a4,13
    80005840:	04e48063          	beq	s1,a4,80005880 <consoleintr+0x8c>
    80005844:	07f7f713          	andi	a4,a5,127
    80005848:	00e90733          	add	a4,s2,a4
    8000584c:	0017879b          	addiw	a5,a5,1
    80005850:	0af92023          	sw	a5,160(s2)
    80005854:	00970c23          	sb	s1,24(a4)
    80005858:	08f92e23          	sw	a5,156(s2)
    8000585c:	01013403          	ld	s0,16(sp)
    80005860:	01813083          	ld	ra,24(sp)
    80005864:	00813483          	ld	s1,8(sp)
    80005868:	00013903          	ld	s2,0(sp)
    8000586c:	00006517          	auipc	a0,0x6
    80005870:	82c50513          	addi	a0,a0,-2004 # 8000b098 <cons>
    80005874:	02010113          	addi	sp,sp,32
    80005878:	00001317          	auipc	t1,0x1
    8000587c:	eb030067          	jr	-336(t1) # 80006728 <release>
    80005880:	00a00493          	li	s1,10
    80005884:	fc1ff06f          	j	80005844 <consoleintr+0x50>

0000000080005888 <consoleinit>:
    80005888:	fe010113          	addi	sp,sp,-32
    8000588c:	00113c23          	sd	ra,24(sp)
    80005890:	00813823          	sd	s0,16(sp)
    80005894:	00913423          	sd	s1,8(sp)
    80005898:	02010413          	addi	s0,sp,32
    8000589c:	00005497          	auipc	s1,0x5
    800058a0:	7fc48493          	addi	s1,s1,2044 # 8000b098 <cons>
    800058a4:	00048513          	mv	a0,s1
    800058a8:	00003597          	auipc	a1,0x3
    800058ac:	de858593          	addi	a1,a1,-536 # 80008690 <kvmincrease+0x15a0>
    800058b0:	00001097          	auipc	ra,0x1
    800058b4:	d88080e7          	jalr	-632(ra) # 80006638 <initlock>
    800058b8:	00000097          	auipc	ra,0x0
    800058bc:	7ac080e7          	jalr	1964(ra) # 80006064 <uartinit>
    800058c0:	01813083          	ld	ra,24(sp)
    800058c4:	01013403          	ld	s0,16(sp)
    800058c8:	00000797          	auipc	a5,0x0
    800058cc:	d9c78793          	addi	a5,a5,-612 # 80005664 <consoleread>
    800058d0:	0af4bc23          	sd	a5,184(s1)
    800058d4:	00000797          	auipc	a5,0x0
    800058d8:	cec78793          	addi	a5,a5,-788 # 800055c0 <consolewrite>
    800058dc:	0cf4b023          	sd	a5,192(s1)
    800058e0:	00813483          	ld	s1,8(sp)
    800058e4:	02010113          	addi	sp,sp,32
    800058e8:	00008067          	ret

00000000800058ec <console_read>:
    800058ec:	ff010113          	addi	sp,sp,-16
    800058f0:	00813423          	sd	s0,8(sp)
    800058f4:	01010413          	addi	s0,sp,16
    800058f8:	00813403          	ld	s0,8(sp)
    800058fc:	00006317          	auipc	t1,0x6
    80005900:	85433303          	ld	t1,-1964(t1) # 8000b150 <devsw+0x10>
    80005904:	01010113          	addi	sp,sp,16
    80005908:	00030067          	jr	t1

000000008000590c <console_write>:
    8000590c:	ff010113          	addi	sp,sp,-16
    80005910:	00813423          	sd	s0,8(sp)
    80005914:	01010413          	addi	s0,sp,16
    80005918:	00813403          	ld	s0,8(sp)
    8000591c:	00006317          	auipc	t1,0x6
    80005920:	83c33303          	ld	t1,-1988(t1) # 8000b158 <devsw+0x18>
    80005924:	01010113          	addi	sp,sp,16
    80005928:	00030067          	jr	t1

000000008000592c <panic>:
    8000592c:	fe010113          	addi	sp,sp,-32
    80005930:	00113c23          	sd	ra,24(sp)
    80005934:	00813823          	sd	s0,16(sp)
    80005938:	00913423          	sd	s1,8(sp)
    8000593c:	02010413          	addi	s0,sp,32
    80005940:	00050493          	mv	s1,a0
    80005944:	00003517          	auipc	a0,0x3
    80005948:	d5450513          	addi	a0,a0,-684 # 80008698 <kvmincrease+0x15a8>
    8000594c:	00006797          	auipc	a5,0x6
    80005950:	8a07a623          	sw	zero,-1876(a5) # 8000b1f8 <pr+0x18>
    80005954:	00000097          	auipc	ra,0x0
    80005958:	034080e7          	jalr	52(ra) # 80005988 <__printf>
    8000595c:	00048513          	mv	a0,s1
    80005960:	00000097          	auipc	ra,0x0
    80005964:	028080e7          	jalr	40(ra) # 80005988 <__printf>
    80005968:	00003517          	auipc	a0,0x3
    8000596c:	80850513          	addi	a0,a0,-2040 # 80008170 <kvmincrease+0x1080>
    80005970:	00000097          	auipc	ra,0x0
    80005974:	018080e7          	jalr	24(ra) # 80005988 <__printf>
    80005978:	00100793          	li	a5,1
    8000597c:	00004717          	auipc	a4,0x4
    80005980:	5cf72623          	sw	a5,1484(a4) # 80009f48 <panicked>
    80005984:	0000006f          	j	80005984 <panic+0x58>

0000000080005988 <__printf>:
    80005988:	f3010113          	addi	sp,sp,-208
    8000598c:	08813023          	sd	s0,128(sp)
    80005990:	07313423          	sd	s3,104(sp)
    80005994:	09010413          	addi	s0,sp,144
    80005998:	05813023          	sd	s8,64(sp)
    8000599c:	08113423          	sd	ra,136(sp)
    800059a0:	06913c23          	sd	s1,120(sp)
    800059a4:	07213823          	sd	s2,112(sp)
    800059a8:	07413023          	sd	s4,96(sp)
    800059ac:	05513c23          	sd	s5,88(sp)
    800059b0:	05613823          	sd	s6,80(sp)
    800059b4:	05713423          	sd	s7,72(sp)
    800059b8:	03913c23          	sd	s9,56(sp)
    800059bc:	03a13823          	sd	s10,48(sp)
    800059c0:	03b13423          	sd	s11,40(sp)
    800059c4:	00006317          	auipc	t1,0x6
    800059c8:	81c30313          	addi	t1,t1,-2020 # 8000b1e0 <pr>
    800059cc:	01832c03          	lw	s8,24(t1)
    800059d0:	00b43423          	sd	a1,8(s0)
    800059d4:	00c43823          	sd	a2,16(s0)
    800059d8:	00d43c23          	sd	a3,24(s0)
    800059dc:	02e43023          	sd	a4,32(s0)
    800059e0:	02f43423          	sd	a5,40(s0)
    800059e4:	03043823          	sd	a6,48(s0)
    800059e8:	03143c23          	sd	a7,56(s0)
    800059ec:	00050993          	mv	s3,a0
    800059f0:	4a0c1663          	bnez	s8,80005e9c <__printf+0x514>
    800059f4:	60098c63          	beqz	s3,8000600c <__printf+0x684>
    800059f8:	0009c503          	lbu	a0,0(s3)
    800059fc:	00840793          	addi	a5,s0,8
    80005a00:	f6f43c23          	sd	a5,-136(s0)
    80005a04:	00000493          	li	s1,0
    80005a08:	22050063          	beqz	a0,80005c28 <__printf+0x2a0>
    80005a0c:	00002a37          	lui	s4,0x2
    80005a10:	00018ab7          	lui	s5,0x18
    80005a14:	000f4b37          	lui	s6,0xf4
    80005a18:	00989bb7          	lui	s7,0x989
    80005a1c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005a20:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005a24:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005a28:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005a2c:	00148c9b          	addiw	s9,s1,1
    80005a30:	02500793          	li	a5,37
    80005a34:	01998933          	add	s2,s3,s9
    80005a38:	38f51263          	bne	a0,a5,80005dbc <__printf+0x434>
    80005a3c:	00094783          	lbu	a5,0(s2)
    80005a40:	00078c9b          	sext.w	s9,a5
    80005a44:	1e078263          	beqz	a5,80005c28 <__printf+0x2a0>
    80005a48:	0024849b          	addiw	s1,s1,2
    80005a4c:	07000713          	li	a4,112
    80005a50:	00998933          	add	s2,s3,s1
    80005a54:	38e78a63          	beq	a5,a4,80005de8 <__printf+0x460>
    80005a58:	20f76863          	bltu	a4,a5,80005c68 <__printf+0x2e0>
    80005a5c:	42a78863          	beq	a5,a0,80005e8c <__printf+0x504>
    80005a60:	06400713          	li	a4,100
    80005a64:	40e79663          	bne	a5,a4,80005e70 <__printf+0x4e8>
    80005a68:	f7843783          	ld	a5,-136(s0)
    80005a6c:	0007a603          	lw	a2,0(a5)
    80005a70:	00878793          	addi	a5,a5,8
    80005a74:	f6f43c23          	sd	a5,-136(s0)
    80005a78:	42064a63          	bltz	a2,80005eac <__printf+0x524>
    80005a7c:	00a00713          	li	a4,10
    80005a80:	02e677bb          	remuw	a5,a2,a4
    80005a84:	00003d97          	auipc	s11,0x3
    80005a88:	c3cd8d93          	addi	s11,s11,-964 # 800086c0 <digits>
    80005a8c:	00900593          	li	a1,9
    80005a90:	0006051b          	sext.w	a0,a2
    80005a94:	00000c93          	li	s9,0
    80005a98:	02079793          	slli	a5,a5,0x20
    80005a9c:	0207d793          	srli	a5,a5,0x20
    80005aa0:	00fd87b3          	add	a5,s11,a5
    80005aa4:	0007c783          	lbu	a5,0(a5)
    80005aa8:	02e656bb          	divuw	a3,a2,a4
    80005aac:	f8f40023          	sb	a5,-128(s0)
    80005ab0:	14c5d863          	bge	a1,a2,80005c00 <__printf+0x278>
    80005ab4:	06300593          	li	a1,99
    80005ab8:	00100c93          	li	s9,1
    80005abc:	02e6f7bb          	remuw	a5,a3,a4
    80005ac0:	02079793          	slli	a5,a5,0x20
    80005ac4:	0207d793          	srli	a5,a5,0x20
    80005ac8:	00fd87b3          	add	a5,s11,a5
    80005acc:	0007c783          	lbu	a5,0(a5)
    80005ad0:	02e6d73b          	divuw	a4,a3,a4
    80005ad4:	f8f400a3          	sb	a5,-127(s0)
    80005ad8:	12a5f463          	bgeu	a1,a0,80005c00 <__printf+0x278>
    80005adc:	00a00693          	li	a3,10
    80005ae0:	00900593          	li	a1,9
    80005ae4:	02d777bb          	remuw	a5,a4,a3
    80005ae8:	02079793          	slli	a5,a5,0x20
    80005aec:	0207d793          	srli	a5,a5,0x20
    80005af0:	00fd87b3          	add	a5,s11,a5
    80005af4:	0007c503          	lbu	a0,0(a5)
    80005af8:	02d757bb          	divuw	a5,a4,a3
    80005afc:	f8a40123          	sb	a0,-126(s0)
    80005b00:	48e5f263          	bgeu	a1,a4,80005f84 <__printf+0x5fc>
    80005b04:	06300513          	li	a0,99
    80005b08:	02d7f5bb          	remuw	a1,a5,a3
    80005b0c:	02059593          	slli	a1,a1,0x20
    80005b10:	0205d593          	srli	a1,a1,0x20
    80005b14:	00bd85b3          	add	a1,s11,a1
    80005b18:	0005c583          	lbu	a1,0(a1)
    80005b1c:	02d7d7bb          	divuw	a5,a5,a3
    80005b20:	f8b401a3          	sb	a1,-125(s0)
    80005b24:	48e57263          	bgeu	a0,a4,80005fa8 <__printf+0x620>
    80005b28:	3e700513          	li	a0,999
    80005b2c:	02d7f5bb          	remuw	a1,a5,a3
    80005b30:	02059593          	slli	a1,a1,0x20
    80005b34:	0205d593          	srli	a1,a1,0x20
    80005b38:	00bd85b3          	add	a1,s11,a1
    80005b3c:	0005c583          	lbu	a1,0(a1)
    80005b40:	02d7d7bb          	divuw	a5,a5,a3
    80005b44:	f8b40223          	sb	a1,-124(s0)
    80005b48:	46e57663          	bgeu	a0,a4,80005fb4 <__printf+0x62c>
    80005b4c:	02d7f5bb          	remuw	a1,a5,a3
    80005b50:	02059593          	slli	a1,a1,0x20
    80005b54:	0205d593          	srli	a1,a1,0x20
    80005b58:	00bd85b3          	add	a1,s11,a1
    80005b5c:	0005c583          	lbu	a1,0(a1)
    80005b60:	02d7d7bb          	divuw	a5,a5,a3
    80005b64:	f8b402a3          	sb	a1,-123(s0)
    80005b68:	46ea7863          	bgeu	s4,a4,80005fd8 <__printf+0x650>
    80005b6c:	02d7f5bb          	remuw	a1,a5,a3
    80005b70:	02059593          	slli	a1,a1,0x20
    80005b74:	0205d593          	srli	a1,a1,0x20
    80005b78:	00bd85b3          	add	a1,s11,a1
    80005b7c:	0005c583          	lbu	a1,0(a1)
    80005b80:	02d7d7bb          	divuw	a5,a5,a3
    80005b84:	f8b40323          	sb	a1,-122(s0)
    80005b88:	3eeaf863          	bgeu	s5,a4,80005f78 <__printf+0x5f0>
    80005b8c:	02d7f5bb          	remuw	a1,a5,a3
    80005b90:	02059593          	slli	a1,a1,0x20
    80005b94:	0205d593          	srli	a1,a1,0x20
    80005b98:	00bd85b3          	add	a1,s11,a1
    80005b9c:	0005c583          	lbu	a1,0(a1)
    80005ba0:	02d7d7bb          	divuw	a5,a5,a3
    80005ba4:	f8b403a3          	sb	a1,-121(s0)
    80005ba8:	42eb7e63          	bgeu	s6,a4,80005fe4 <__printf+0x65c>
    80005bac:	02d7f5bb          	remuw	a1,a5,a3
    80005bb0:	02059593          	slli	a1,a1,0x20
    80005bb4:	0205d593          	srli	a1,a1,0x20
    80005bb8:	00bd85b3          	add	a1,s11,a1
    80005bbc:	0005c583          	lbu	a1,0(a1)
    80005bc0:	02d7d7bb          	divuw	a5,a5,a3
    80005bc4:	f8b40423          	sb	a1,-120(s0)
    80005bc8:	42ebfc63          	bgeu	s7,a4,80006000 <__printf+0x678>
    80005bcc:	02079793          	slli	a5,a5,0x20
    80005bd0:	0207d793          	srli	a5,a5,0x20
    80005bd4:	00fd8db3          	add	s11,s11,a5
    80005bd8:	000dc703          	lbu	a4,0(s11)
    80005bdc:	00a00793          	li	a5,10
    80005be0:	00900c93          	li	s9,9
    80005be4:	f8e404a3          	sb	a4,-119(s0)
    80005be8:	00065c63          	bgez	a2,80005c00 <__printf+0x278>
    80005bec:	f9040713          	addi	a4,s0,-112
    80005bf0:	00f70733          	add	a4,a4,a5
    80005bf4:	02d00693          	li	a3,45
    80005bf8:	fed70823          	sb	a3,-16(a4)
    80005bfc:	00078c93          	mv	s9,a5
    80005c00:	f8040793          	addi	a5,s0,-128
    80005c04:	01978cb3          	add	s9,a5,s9
    80005c08:	f7f40d13          	addi	s10,s0,-129
    80005c0c:	000cc503          	lbu	a0,0(s9)
    80005c10:	fffc8c93          	addi	s9,s9,-1
    80005c14:	00000097          	auipc	ra,0x0
    80005c18:	b90080e7          	jalr	-1136(ra) # 800057a4 <consputc>
    80005c1c:	ffac98e3          	bne	s9,s10,80005c0c <__printf+0x284>
    80005c20:	00094503          	lbu	a0,0(s2)
    80005c24:	e00514e3          	bnez	a0,80005a2c <__printf+0xa4>
    80005c28:	1a0c1663          	bnez	s8,80005dd4 <__printf+0x44c>
    80005c2c:	08813083          	ld	ra,136(sp)
    80005c30:	08013403          	ld	s0,128(sp)
    80005c34:	07813483          	ld	s1,120(sp)
    80005c38:	07013903          	ld	s2,112(sp)
    80005c3c:	06813983          	ld	s3,104(sp)
    80005c40:	06013a03          	ld	s4,96(sp)
    80005c44:	05813a83          	ld	s5,88(sp)
    80005c48:	05013b03          	ld	s6,80(sp)
    80005c4c:	04813b83          	ld	s7,72(sp)
    80005c50:	04013c03          	ld	s8,64(sp)
    80005c54:	03813c83          	ld	s9,56(sp)
    80005c58:	03013d03          	ld	s10,48(sp)
    80005c5c:	02813d83          	ld	s11,40(sp)
    80005c60:	0d010113          	addi	sp,sp,208
    80005c64:	00008067          	ret
    80005c68:	07300713          	li	a4,115
    80005c6c:	1ce78a63          	beq	a5,a4,80005e40 <__printf+0x4b8>
    80005c70:	07800713          	li	a4,120
    80005c74:	1ee79e63          	bne	a5,a4,80005e70 <__printf+0x4e8>
    80005c78:	f7843783          	ld	a5,-136(s0)
    80005c7c:	0007a703          	lw	a4,0(a5)
    80005c80:	00878793          	addi	a5,a5,8
    80005c84:	f6f43c23          	sd	a5,-136(s0)
    80005c88:	28074263          	bltz	a4,80005f0c <__printf+0x584>
    80005c8c:	00003d97          	auipc	s11,0x3
    80005c90:	a34d8d93          	addi	s11,s11,-1484 # 800086c0 <digits>
    80005c94:	00f77793          	andi	a5,a4,15
    80005c98:	00fd87b3          	add	a5,s11,a5
    80005c9c:	0007c683          	lbu	a3,0(a5)
    80005ca0:	00f00613          	li	a2,15
    80005ca4:	0007079b          	sext.w	a5,a4
    80005ca8:	f8d40023          	sb	a3,-128(s0)
    80005cac:	0047559b          	srliw	a1,a4,0x4
    80005cb0:	0047569b          	srliw	a3,a4,0x4
    80005cb4:	00000c93          	li	s9,0
    80005cb8:	0ee65063          	bge	a2,a4,80005d98 <__printf+0x410>
    80005cbc:	00f6f693          	andi	a3,a3,15
    80005cc0:	00dd86b3          	add	a3,s11,a3
    80005cc4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005cc8:	0087d79b          	srliw	a5,a5,0x8
    80005ccc:	00100c93          	li	s9,1
    80005cd0:	f8d400a3          	sb	a3,-127(s0)
    80005cd4:	0cb67263          	bgeu	a2,a1,80005d98 <__printf+0x410>
    80005cd8:	00f7f693          	andi	a3,a5,15
    80005cdc:	00dd86b3          	add	a3,s11,a3
    80005ce0:	0006c583          	lbu	a1,0(a3)
    80005ce4:	00f00613          	li	a2,15
    80005ce8:	0047d69b          	srliw	a3,a5,0x4
    80005cec:	f8b40123          	sb	a1,-126(s0)
    80005cf0:	0047d593          	srli	a1,a5,0x4
    80005cf4:	28f67e63          	bgeu	a2,a5,80005f90 <__printf+0x608>
    80005cf8:	00f6f693          	andi	a3,a3,15
    80005cfc:	00dd86b3          	add	a3,s11,a3
    80005d00:	0006c503          	lbu	a0,0(a3)
    80005d04:	0087d813          	srli	a6,a5,0x8
    80005d08:	0087d69b          	srliw	a3,a5,0x8
    80005d0c:	f8a401a3          	sb	a0,-125(s0)
    80005d10:	28b67663          	bgeu	a2,a1,80005f9c <__printf+0x614>
    80005d14:	00f6f693          	andi	a3,a3,15
    80005d18:	00dd86b3          	add	a3,s11,a3
    80005d1c:	0006c583          	lbu	a1,0(a3)
    80005d20:	00c7d513          	srli	a0,a5,0xc
    80005d24:	00c7d69b          	srliw	a3,a5,0xc
    80005d28:	f8b40223          	sb	a1,-124(s0)
    80005d2c:	29067a63          	bgeu	a2,a6,80005fc0 <__printf+0x638>
    80005d30:	00f6f693          	andi	a3,a3,15
    80005d34:	00dd86b3          	add	a3,s11,a3
    80005d38:	0006c583          	lbu	a1,0(a3)
    80005d3c:	0107d813          	srli	a6,a5,0x10
    80005d40:	0107d69b          	srliw	a3,a5,0x10
    80005d44:	f8b402a3          	sb	a1,-123(s0)
    80005d48:	28a67263          	bgeu	a2,a0,80005fcc <__printf+0x644>
    80005d4c:	00f6f693          	andi	a3,a3,15
    80005d50:	00dd86b3          	add	a3,s11,a3
    80005d54:	0006c683          	lbu	a3,0(a3)
    80005d58:	0147d79b          	srliw	a5,a5,0x14
    80005d5c:	f8d40323          	sb	a3,-122(s0)
    80005d60:	21067663          	bgeu	a2,a6,80005f6c <__printf+0x5e4>
    80005d64:	02079793          	slli	a5,a5,0x20
    80005d68:	0207d793          	srli	a5,a5,0x20
    80005d6c:	00fd8db3          	add	s11,s11,a5
    80005d70:	000dc683          	lbu	a3,0(s11)
    80005d74:	00800793          	li	a5,8
    80005d78:	00700c93          	li	s9,7
    80005d7c:	f8d403a3          	sb	a3,-121(s0)
    80005d80:	00075c63          	bgez	a4,80005d98 <__printf+0x410>
    80005d84:	f9040713          	addi	a4,s0,-112
    80005d88:	00f70733          	add	a4,a4,a5
    80005d8c:	02d00693          	li	a3,45
    80005d90:	fed70823          	sb	a3,-16(a4)
    80005d94:	00078c93          	mv	s9,a5
    80005d98:	f8040793          	addi	a5,s0,-128
    80005d9c:	01978cb3          	add	s9,a5,s9
    80005da0:	f7f40d13          	addi	s10,s0,-129
    80005da4:	000cc503          	lbu	a0,0(s9)
    80005da8:	fffc8c93          	addi	s9,s9,-1
    80005dac:	00000097          	auipc	ra,0x0
    80005db0:	9f8080e7          	jalr	-1544(ra) # 800057a4 <consputc>
    80005db4:	ff9d18e3          	bne	s10,s9,80005da4 <__printf+0x41c>
    80005db8:	0100006f          	j	80005dc8 <__printf+0x440>
    80005dbc:	00000097          	auipc	ra,0x0
    80005dc0:	9e8080e7          	jalr	-1560(ra) # 800057a4 <consputc>
    80005dc4:	000c8493          	mv	s1,s9
    80005dc8:	00094503          	lbu	a0,0(s2)
    80005dcc:	c60510e3          	bnez	a0,80005a2c <__printf+0xa4>
    80005dd0:	e40c0ee3          	beqz	s8,80005c2c <__printf+0x2a4>
    80005dd4:	00005517          	auipc	a0,0x5
    80005dd8:	40c50513          	addi	a0,a0,1036 # 8000b1e0 <pr>
    80005ddc:	00001097          	auipc	ra,0x1
    80005de0:	94c080e7          	jalr	-1716(ra) # 80006728 <release>
    80005de4:	e49ff06f          	j	80005c2c <__printf+0x2a4>
    80005de8:	f7843783          	ld	a5,-136(s0)
    80005dec:	03000513          	li	a0,48
    80005df0:	01000d13          	li	s10,16
    80005df4:	00878713          	addi	a4,a5,8
    80005df8:	0007bc83          	ld	s9,0(a5)
    80005dfc:	f6e43c23          	sd	a4,-136(s0)
    80005e00:	00000097          	auipc	ra,0x0
    80005e04:	9a4080e7          	jalr	-1628(ra) # 800057a4 <consputc>
    80005e08:	07800513          	li	a0,120
    80005e0c:	00000097          	auipc	ra,0x0
    80005e10:	998080e7          	jalr	-1640(ra) # 800057a4 <consputc>
    80005e14:	00003d97          	auipc	s11,0x3
    80005e18:	8acd8d93          	addi	s11,s11,-1876 # 800086c0 <digits>
    80005e1c:	03ccd793          	srli	a5,s9,0x3c
    80005e20:	00fd87b3          	add	a5,s11,a5
    80005e24:	0007c503          	lbu	a0,0(a5)
    80005e28:	fffd0d1b          	addiw	s10,s10,-1
    80005e2c:	004c9c93          	slli	s9,s9,0x4
    80005e30:	00000097          	auipc	ra,0x0
    80005e34:	974080e7          	jalr	-1676(ra) # 800057a4 <consputc>
    80005e38:	fe0d12e3          	bnez	s10,80005e1c <__printf+0x494>
    80005e3c:	f8dff06f          	j	80005dc8 <__printf+0x440>
    80005e40:	f7843783          	ld	a5,-136(s0)
    80005e44:	0007bc83          	ld	s9,0(a5)
    80005e48:	00878793          	addi	a5,a5,8
    80005e4c:	f6f43c23          	sd	a5,-136(s0)
    80005e50:	000c9a63          	bnez	s9,80005e64 <__printf+0x4dc>
    80005e54:	1080006f          	j	80005f5c <__printf+0x5d4>
    80005e58:	001c8c93          	addi	s9,s9,1
    80005e5c:	00000097          	auipc	ra,0x0
    80005e60:	948080e7          	jalr	-1720(ra) # 800057a4 <consputc>
    80005e64:	000cc503          	lbu	a0,0(s9)
    80005e68:	fe0518e3          	bnez	a0,80005e58 <__printf+0x4d0>
    80005e6c:	f5dff06f          	j	80005dc8 <__printf+0x440>
    80005e70:	02500513          	li	a0,37
    80005e74:	00000097          	auipc	ra,0x0
    80005e78:	930080e7          	jalr	-1744(ra) # 800057a4 <consputc>
    80005e7c:	000c8513          	mv	a0,s9
    80005e80:	00000097          	auipc	ra,0x0
    80005e84:	924080e7          	jalr	-1756(ra) # 800057a4 <consputc>
    80005e88:	f41ff06f          	j	80005dc8 <__printf+0x440>
    80005e8c:	02500513          	li	a0,37
    80005e90:	00000097          	auipc	ra,0x0
    80005e94:	914080e7          	jalr	-1772(ra) # 800057a4 <consputc>
    80005e98:	f31ff06f          	j	80005dc8 <__printf+0x440>
    80005e9c:	00030513          	mv	a0,t1
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	7bc080e7          	jalr	1980(ra) # 8000665c <acquire>
    80005ea8:	b4dff06f          	j	800059f4 <__printf+0x6c>
    80005eac:	40c0053b          	negw	a0,a2
    80005eb0:	00a00713          	li	a4,10
    80005eb4:	02e576bb          	remuw	a3,a0,a4
    80005eb8:	00003d97          	auipc	s11,0x3
    80005ebc:	808d8d93          	addi	s11,s11,-2040 # 800086c0 <digits>
    80005ec0:	ff700593          	li	a1,-9
    80005ec4:	02069693          	slli	a3,a3,0x20
    80005ec8:	0206d693          	srli	a3,a3,0x20
    80005ecc:	00dd86b3          	add	a3,s11,a3
    80005ed0:	0006c683          	lbu	a3,0(a3)
    80005ed4:	02e557bb          	divuw	a5,a0,a4
    80005ed8:	f8d40023          	sb	a3,-128(s0)
    80005edc:	10b65e63          	bge	a2,a1,80005ff8 <__printf+0x670>
    80005ee0:	06300593          	li	a1,99
    80005ee4:	02e7f6bb          	remuw	a3,a5,a4
    80005ee8:	02069693          	slli	a3,a3,0x20
    80005eec:	0206d693          	srli	a3,a3,0x20
    80005ef0:	00dd86b3          	add	a3,s11,a3
    80005ef4:	0006c683          	lbu	a3,0(a3)
    80005ef8:	02e7d73b          	divuw	a4,a5,a4
    80005efc:	00200793          	li	a5,2
    80005f00:	f8d400a3          	sb	a3,-127(s0)
    80005f04:	bca5ece3          	bltu	a1,a0,80005adc <__printf+0x154>
    80005f08:	ce5ff06f          	j	80005bec <__printf+0x264>
    80005f0c:	40e007bb          	negw	a5,a4
    80005f10:	00002d97          	auipc	s11,0x2
    80005f14:	7b0d8d93          	addi	s11,s11,1968 # 800086c0 <digits>
    80005f18:	00f7f693          	andi	a3,a5,15
    80005f1c:	00dd86b3          	add	a3,s11,a3
    80005f20:	0006c583          	lbu	a1,0(a3)
    80005f24:	ff100613          	li	a2,-15
    80005f28:	0047d69b          	srliw	a3,a5,0x4
    80005f2c:	f8b40023          	sb	a1,-128(s0)
    80005f30:	0047d59b          	srliw	a1,a5,0x4
    80005f34:	0ac75e63          	bge	a4,a2,80005ff0 <__printf+0x668>
    80005f38:	00f6f693          	andi	a3,a3,15
    80005f3c:	00dd86b3          	add	a3,s11,a3
    80005f40:	0006c603          	lbu	a2,0(a3)
    80005f44:	00f00693          	li	a3,15
    80005f48:	0087d79b          	srliw	a5,a5,0x8
    80005f4c:	f8c400a3          	sb	a2,-127(s0)
    80005f50:	d8b6e4e3          	bltu	a3,a1,80005cd8 <__printf+0x350>
    80005f54:	00200793          	li	a5,2
    80005f58:	e2dff06f          	j	80005d84 <__printf+0x3fc>
    80005f5c:	00002c97          	auipc	s9,0x2
    80005f60:	744c8c93          	addi	s9,s9,1860 # 800086a0 <kvmincrease+0x15b0>
    80005f64:	02800513          	li	a0,40
    80005f68:	ef1ff06f          	j	80005e58 <__printf+0x4d0>
    80005f6c:	00700793          	li	a5,7
    80005f70:	00600c93          	li	s9,6
    80005f74:	e0dff06f          	j	80005d80 <__printf+0x3f8>
    80005f78:	00700793          	li	a5,7
    80005f7c:	00600c93          	li	s9,6
    80005f80:	c69ff06f          	j	80005be8 <__printf+0x260>
    80005f84:	00300793          	li	a5,3
    80005f88:	00200c93          	li	s9,2
    80005f8c:	c5dff06f          	j	80005be8 <__printf+0x260>
    80005f90:	00300793          	li	a5,3
    80005f94:	00200c93          	li	s9,2
    80005f98:	de9ff06f          	j	80005d80 <__printf+0x3f8>
    80005f9c:	00400793          	li	a5,4
    80005fa0:	00300c93          	li	s9,3
    80005fa4:	dddff06f          	j	80005d80 <__printf+0x3f8>
    80005fa8:	00400793          	li	a5,4
    80005fac:	00300c93          	li	s9,3
    80005fb0:	c39ff06f          	j	80005be8 <__printf+0x260>
    80005fb4:	00500793          	li	a5,5
    80005fb8:	00400c93          	li	s9,4
    80005fbc:	c2dff06f          	j	80005be8 <__printf+0x260>
    80005fc0:	00500793          	li	a5,5
    80005fc4:	00400c93          	li	s9,4
    80005fc8:	db9ff06f          	j	80005d80 <__printf+0x3f8>
    80005fcc:	00600793          	li	a5,6
    80005fd0:	00500c93          	li	s9,5
    80005fd4:	dadff06f          	j	80005d80 <__printf+0x3f8>
    80005fd8:	00600793          	li	a5,6
    80005fdc:	00500c93          	li	s9,5
    80005fe0:	c09ff06f          	j	80005be8 <__printf+0x260>
    80005fe4:	00800793          	li	a5,8
    80005fe8:	00700c93          	li	s9,7
    80005fec:	bfdff06f          	j	80005be8 <__printf+0x260>
    80005ff0:	00100793          	li	a5,1
    80005ff4:	d91ff06f          	j	80005d84 <__printf+0x3fc>
    80005ff8:	00100793          	li	a5,1
    80005ffc:	bf1ff06f          	j	80005bec <__printf+0x264>
    80006000:	00900793          	li	a5,9
    80006004:	00800c93          	li	s9,8
    80006008:	be1ff06f          	j	80005be8 <__printf+0x260>
    8000600c:	00002517          	auipc	a0,0x2
    80006010:	69c50513          	addi	a0,a0,1692 # 800086a8 <kvmincrease+0x15b8>
    80006014:	00000097          	auipc	ra,0x0
    80006018:	918080e7          	jalr	-1768(ra) # 8000592c <panic>

000000008000601c <printfinit>:
    8000601c:	fe010113          	addi	sp,sp,-32
    80006020:	00813823          	sd	s0,16(sp)
    80006024:	00913423          	sd	s1,8(sp)
    80006028:	00113c23          	sd	ra,24(sp)
    8000602c:	02010413          	addi	s0,sp,32
    80006030:	00005497          	auipc	s1,0x5
    80006034:	1b048493          	addi	s1,s1,432 # 8000b1e0 <pr>
    80006038:	00048513          	mv	a0,s1
    8000603c:	00002597          	auipc	a1,0x2
    80006040:	67c58593          	addi	a1,a1,1660 # 800086b8 <kvmincrease+0x15c8>
    80006044:	00000097          	auipc	ra,0x0
    80006048:	5f4080e7          	jalr	1524(ra) # 80006638 <initlock>
    8000604c:	01813083          	ld	ra,24(sp)
    80006050:	01013403          	ld	s0,16(sp)
    80006054:	0004ac23          	sw	zero,24(s1)
    80006058:	00813483          	ld	s1,8(sp)
    8000605c:	02010113          	addi	sp,sp,32
    80006060:	00008067          	ret

0000000080006064 <uartinit>:
    80006064:	ff010113          	addi	sp,sp,-16
    80006068:	00813423          	sd	s0,8(sp)
    8000606c:	01010413          	addi	s0,sp,16
    80006070:	100007b7          	lui	a5,0x10000
    80006074:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006078:	f8000713          	li	a4,-128
    8000607c:	00e781a3          	sb	a4,3(a5)
    80006080:	00300713          	li	a4,3
    80006084:	00e78023          	sb	a4,0(a5)
    80006088:	000780a3          	sb	zero,1(a5)
    8000608c:	00e781a3          	sb	a4,3(a5)
    80006090:	00700693          	li	a3,7
    80006094:	00d78123          	sb	a3,2(a5)
    80006098:	00e780a3          	sb	a4,1(a5)
    8000609c:	00813403          	ld	s0,8(sp)
    800060a0:	01010113          	addi	sp,sp,16
    800060a4:	00008067          	ret

00000000800060a8 <uartputc>:
    800060a8:	00004797          	auipc	a5,0x4
    800060ac:	ea07a783          	lw	a5,-352(a5) # 80009f48 <panicked>
    800060b0:	00078463          	beqz	a5,800060b8 <uartputc+0x10>
    800060b4:	0000006f          	j	800060b4 <uartputc+0xc>
    800060b8:	fd010113          	addi	sp,sp,-48
    800060bc:	02813023          	sd	s0,32(sp)
    800060c0:	00913c23          	sd	s1,24(sp)
    800060c4:	01213823          	sd	s2,16(sp)
    800060c8:	01313423          	sd	s3,8(sp)
    800060cc:	02113423          	sd	ra,40(sp)
    800060d0:	03010413          	addi	s0,sp,48
    800060d4:	00004917          	auipc	s2,0x4
    800060d8:	e7c90913          	addi	s2,s2,-388 # 80009f50 <uart_tx_r>
    800060dc:	00093783          	ld	a5,0(s2)
    800060e0:	00004497          	auipc	s1,0x4
    800060e4:	e7848493          	addi	s1,s1,-392 # 80009f58 <uart_tx_w>
    800060e8:	0004b703          	ld	a4,0(s1)
    800060ec:	02078693          	addi	a3,a5,32
    800060f0:	00050993          	mv	s3,a0
    800060f4:	02e69c63          	bne	a3,a4,8000612c <uartputc+0x84>
    800060f8:	00001097          	auipc	ra,0x1
    800060fc:	834080e7          	jalr	-1996(ra) # 8000692c <push_on>
    80006100:	00093783          	ld	a5,0(s2)
    80006104:	0004b703          	ld	a4,0(s1)
    80006108:	02078793          	addi	a5,a5,32
    8000610c:	00e79463          	bne	a5,a4,80006114 <uartputc+0x6c>
    80006110:	0000006f          	j	80006110 <uartputc+0x68>
    80006114:	00001097          	auipc	ra,0x1
    80006118:	88c080e7          	jalr	-1908(ra) # 800069a0 <pop_on>
    8000611c:	00093783          	ld	a5,0(s2)
    80006120:	0004b703          	ld	a4,0(s1)
    80006124:	02078693          	addi	a3,a5,32
    80006128:	fce688e3          	beq	a3,a4,800060f8 <uartputc+0x50>
    8000612c:	01f77693          	andi	a3,a4,31
    80006130:	00005597          	auipc	a1,0x5
    80006134:	0d058593          	addi	a1,a1,208 # 8000b200 <uart_tx_buf>
    80006138:	00d586b3          	add	a3,a1,a3
    8000613c:	00170713          	addi	a4,a4,1
    80006140:	01368023          	sb	s3,0(a3)
    80006144:	00e4b023          	sd	a4,0(s1)
    80006148:	10000637          	lui	a2,0x10000
    8000614c:	02f71063          	bne	a4,a5,8000616c <uartputc+0xc4>
    80006150:	0340006f          	j	80006184 <uartputc+0xdc>
    80006154:	00074703          	lbu	a4,0(a4)
    80006158:	00f93023          	sd	a5,0(s2)
    8000615c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006160:	00093783          	ld	a5,0(s2)
    80006164:	0004b703          	ld	a4,0(s1)
    80006168:	00f70e63          	beq	a4,a5,80006184 <uartputc+0xdc>
    8000616c:	00564683          	lbu	a3,5(a2)
    80006170:	01f7f713          	andi	a4,a5,31
    80006174:	00e58733          	add	a4,a1,a4
    80006178:	0206f693          	andi	a3,a3,32
    8000617c:	00178793          	addi	a5,a5,1
    80006180:	fc069ae3          	bnez	a3,80006154 <uartputc+0xac>
    80006184:	02813083          	ld	ra,40(sp)
    80006188:	02013403          	ld	s0,32(sp)
    8000618c:	01813483          	ld	s1,24(sp)
    80006190:	01013903          	ld	s2,16(sp)
    80006194:	00813983          	ld	s3,8(sp)
    80006198:	03010113          	addi	sp,sp,48
    8000619c:	00008067          	ret

00000000800061a0 <uartputc_sync>:
    800061a0:	ff010113          	addi	sp,sp,-16
    800061a4:	00813423          	sd	s0,8(sp)
    800061a8:	01010413          	addi	s0,sp,16
    800061ac:	00004717          	auipc	a4,0x4
    800061b0:	d9c72703          	lw	a4,-612(a4) # 80009f48 <panicked>
    800061b4:	02071663          	bnez	a4,800061e0 <uartputc_sync+0x40>
    800061b8:	00050793          	mv	a5,a0
    800061bc:	100006b7          	lui	a3,0x10000
    800061c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800061c4:	02077713          	andi	a4,a4,32
    800061c8:	fe070ce3          	beqz	a4,800061c0 <uartputc_sync+0x20>
    800061cc:	0ff7f793          	andi	a5,a5,255
    800061d0:	00f68023          	sb	a5,0(a3)
    800061d4:	00813403          	ld	s0,8(sp)
    800061d8:	01010113          	addi	sp,sp,16
    800061dc:	00008067          	ret
    800061e0:	0000006f          	j	800061e0 <uartputc_sync+0x40>

00000000800061e4 <uartstart>:
    800061e4:	ff010113          	addi	sp,sp,-16
    800061e8:	00813423          	sd	s0,8(sp)
    800061ec:	01010413          	addi	s0,sp,16
    800061f0:	00004617          	auipc	a2,0x4
    800061f4:	d6060613          	addi	a2,a2,-672 # 80009f50 <uart_tx_r>
    800061f8:	00004517          	auipc	a0,0x4
    800061fc:	d6050513          	addi	a0,a0,-672 # 80009f58 <uart_tx_w>
    80006200:	00063783          	ld	a5,0(a2)
    80006204:	00053703          	ld	a4,0(a0)
    80006208:	04f70263          	beq	a4,a5,8000624c <uartstart+0x68>
    8000620c:	100005b7          	lui	a1,0x10000
    80006210:	00005817          	auipc	a6,0x5
    80006214:	ff080813          	addi	a6,a6,-16 # 8000b200 <uart_tx_buf>
    80006218:	01c0006f          	j	80006234 <uartstart+0x50>
    8000621c:	0006c703          	lbu	a4,0(a3)
    80006220:	00f63023          	sd	a5,0(a2)
    80006224:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006228:	00063783          	ld	a5,0(a2)
    8000622c:	00053703          	ld	a4,0(a0)
    80006230:	00f70e63          	beq	a4,a5,8000624c <uartstart+0x68>
    80006234:	01f7f713          	andi	a4,a5,31
    80006238:	00e806b3          	add	a3,a6,a4
    8000623c:	0055c703          	lbu	a4,5(a1)
    80006240:	00178793          	addi	a5,a5,1
    80006244:	02077713          	andi	a4,a4,32
    80006248:	fc071ae3          	bnez	a4,8000621c <uartstart+0x38>
    8000624c:	00813403          	ld	s0,8(sp)
    80006250:	01010113          	addi	sp,sp,16
    80006254:	00008067          	ret

0000000080006258 <uartgetc>:
    80006258:	ff010113          	addi	sp,sp,-16
    8000625c:	00813423          	sd	s0,8(sp)
    80006260:	01010413          	addi	s0,sp,16
    80006264:	10000737          	lui	a4,0x10000
    80006268:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000626c:	0017f793          	andi	a5,a5,1
    80006270:	00078c63          	beqz	a5,80006288 <uartgetc+0x30>
    80006274:	00074503          	lbu	a0,0(a4)
    80006278:	0ff57513          	andi	a0,a0,255
    8000627c:	00813403          	ld	s0,8(sp)
    80006280:	01010113          	addi	sp,sp,16
    80006284:	00008067          	ret
    80006288:	fff00513          	li	a0,-1
    8000628c:	ff1ff06f          	j	8000627c <uartgetc+0x24>

0000000080006290 <uartintr>:
    80006290:	100007b7          	lui	a5,0x10000
    80006294:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006298:	0017f793          	andi	a5,a5,1
    8000629c:	0a078463          	beqz	a5,80006344 <uartintr+0xb4>
    800062a0:	fe010113          	addi	sp,sp,-32
    800062a4:	00813823          	sd	s0,16(sp)
    800062a8:	00913423          	sd	s1,8(sp)
    800062ac:	00113c23          	sd	ra,24(sp)
    800062b0:	02010413          	addi	s0,sp,32
    800062b4:	100004b7          	lui	s1,0x10000
    800062b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800062bc:	0ff57513          	andi	a0,a0,255
    800062c0:	fffff097          	auipc	ra,0xfffff
    800062c4:	534080e7          	jalr	1332(ra) # 800057f4 <consoleintr>
    800062c8:	0054c783          	lbu	a5,5(s1)
    800062cc:	0017f793          	andi	a5,a5,1
    800062d0:	fe0794e3          	bnez	a5,800062b8 <uartintr+0x28>
    800062d4:	00004617          	auipc	a2,0x4
    800062d8:	c7c60613          	addi	a2,a2,-900 # 80009f50 <uart_tx_r>
    800062dc:	00004517          	auipc	a0,0x4
    800062e0:	c7c50513          	addi	a0,a0,-900 # 80009f58 <uart_tx_w>
    800062e4:	00063783          	ld	a5,0(a2)
    800062e8:	00053703          	ld	a4,0(a0)
    800062ec:	04f70263          	beq	a4,a5,80006330 <uartintr+0xa0>
    800062f0:	100005b7          	lui	a1,0x10000
    800062f4:	00005817          	auipc	a6,0x5
    800062f8:	f0c80813          	addi	a6,a6,-244 # 8000b200 <uart_tx_buf>
    800062fc:	01c0006f          	j	80006318 <uartintr+0x88>
    80006300:	0006c703          	lbu	a4,0(a3)
    80006304:	00f63023          	sd	a5,0(a2)
    80006308:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000630c:	00063783          	ld	a5,0(a2)
    80006310:	00053703          	ld	a4,0(a0)
    80006314:	00f70e63          	beq	a4,a5,80006330 <uartintr+0xa0>
    80006318:	01f7f713          	andi	a4,a5,31
    8000631c:	00e806b3          	add	a3,a6,a4
    80006320:	0055c703          	lbu	a4,5(a1)
    80006324:	00178793          	addi	a5,a5,1
    80006328:	02077713          	andi	a4,a4,32
    8000632c:	fc071ae3          	bnez	a4,80006300 <uartintr+0x70>
    80006330:	01813083          	ld	ra,24(sp)
    80006334:	01013403          	ld	s0,16(sp)
    80006338:	00813483          	ld	s1,8(sp)
    8000633c:	02010113          	addi	sp,sp,32
    80006340:	00008067          	ret
    80006344:	00004617          	auipc	a2,0x4
    80006348:	c0c60613          	addi	a2,a2,-1012 # 80009f50 <uart_tx_r>
    8000634c:	00004517          	auipc	a0,0x4
    80006350:	c0c50513          	addi	a0,a0,-1012 # 80009f58 <uart_tx_w>
    80006354:	00063783          	ld	a5,0(a2)
    80006358:	00053703          	ld	a4,0(a0)
    8000635c:	04f70263          	beq	a4,a5,800063a0 <uartintr+0x110>
    80006360:	100005b7          	lui	a1,0x10000
    80006364:	00005817          	auipc	a6,0x5
    80006368:	e9c80813          	addi	a6,a6,-356 # 8000b200 <uart_tx_buf>
    8000636c:	01c0006f          	j	80006388 <uartintr+0xf8>
    80006370:	0006c703          	lbu	a4,0(a3)
    80006374:	00f63023          	sd	a5,0(a2)
    80006378:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000637c:	00063783          	ld	a5,0(a2)
    80006380:	00053703          	ld	a4,0(a0)
    80006384:	02f70063          	beq	a4,a5,800063a4 <uartintr+0x114>
    80006388:	01f7f713          	andi	a4,a5,31
    8000638c:	00e806b3          	add	a3,a6,a4
    80006390:	0055c703          	lbu	a4,5(a1)
    80006394:	00178793          	addi	a5,a5,1
    80006398:	02077713          	andi	a4,a4,32
    8000639c:	fc071ae3          	bnez	a4,80006370 <uartintr+0xe0>
    800063a0:	00008067          	ret
    800063a4:	00008067          	ret

00000000800063a8 <kinit>:
    800063a8:	fc010113          	addi	sp,sp,-64
    800063ac:	02913423          	sd	s1,40(sp)
    800063b0:	fffff7b7          	lui	a5,0xfffff
    800063b4:	00006497          	auipc	s1,0x6
    800063b8:	e7b48493          	addi	s1,s1,-389 # 8000c22f <end+0xfff>
    800063bc:	02813823          	sd	s0,48(sp)
    800063c0:	01313c23          	sd	s3,24(sp)
    800063c4:	00f4f4b3          	and	s1,s1,a5
    800063c8:	02113c23          	sd	ra,56(sp)
    800063cc:	03213023          	sd	s2,32(sp)
    800063d0:	01413823          	sd	s4,16(sp)
    800063d4:	01513423          	sd	s5,8(sp)
    800063d8:	04010413          	addi	s0,sp,64
    800063dc:	000017b7          	lui	a5,0x1
    800063e0:	01100993          	li	s3,17
    800063e4:	00f487b3          	add	a5,s1,a5
    800063e8:	01b99993          	slli	s3,s3,0x1b
    800063ec:	06f9e063          	bltu	s3,a5,8000644c <kinit+0xa4>
    800063f0:	00005a97          	auipc	s5,0x5
    800063f4:	e40a8a93          	addi	s5,s5,-448 # 8000b230 <end>
    800063f8:	0754ec63          	bltu	s1,s5,80006470 <kinit+0xc8>
    800063fc:	0734fa63          	bgeu	s1,s3,80006470 <kinit+0xc8>
    80006400:	00088a37          	lui	s4,0x88
    80006404:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006408:	00004917          	auipc	s2,0x4
    8000640c:	b5890913          	addi	s2,s2,-1192 # 80009f60 <kmem>
    80006410:	00ca1a13          	slli	s4,s4,0xc
    80006414:	0140006f          	j	80006428 <kinit+0x80>
    80006418:	000017b7          	lui	a5,0x1
    8000641c:	00f484b3          	add	s1,s1,a5
    80006420:	0554e863          	bltu	s1,s5,80006470 <kinit+0xc8>
    80006424:	0534f663          	bgeu	s1,s3,80006470 <kinit+0xc8>
    80006428:	00001637          	lui	a2,0x1
    8000642c:	00100593          	li	a1,1
    80006430:	00048513          	mv	a0,s1
    80006434:	00000097          	auipc	ra,0x0
    80006438:	5e4080e7          	jalr	1508(ra) # 80006a18 <__memset>
    8000643c:	00093783          	ld	a5,0(s2)
    80006440:	00f4b023          	sd	a5,0(s1)
    80006444:	00993023          	sd	s1,0(s2)
    80006448:	fd4498e3          	bne	s1,s4,80006418 <kinit+0x70>
    8000644c:	03813083          	ld	ra,56(sp)
    80006450:	03013403          	ld	s0,48(sp)
    80006454:	02813483          	ld	s1,40(sp)
    80006458:	02013903          	ld	s2,32(sp)
    8000645c:	01813983          	ld	s3,24(sp)
    80006460:	01013a03          	ld	s4,16(sp)
    80006464:	00813a83          	ld	s5,8(sp)
    80006468:	04010113          	addi	sp,sp,64
    8000646c:	00008067          	ret
    80006470:	00002517          	auipc	a0,0x2
    80006474:	26850513          	addi	a0,a0,616 # 800086d8 <digits+0x18>
    80006478:	fffff097          	auipc	ra,0xfffff
    8000647c:	4b4080e7          	jalr	1204(ra) # 8000592c <panic>

0000000080006480 <freerange>:
    80006480:	fc010113          	addi	sp,sp,-64
    80006484:	000017b7          	lui	a5,0x1
    80006488:	02913423          	sd	s1,40(sp)
    8000648c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006490:	009504b3          	add	s1,a0,s1
    80006494:	fffff537          	lui	a0,0xfffff
    80006498:	02813823          	sd	s0,48(sp)
    8000649c:	02113c23          	sd	ra,56(sp)
    800064a0:	03213023          	sd	s2,32(sp)
    800064a4:	01313c23          	sd	s3,24(sp)
    800064a8:	01413823          	sd	s4,16(sp)
    800064ac:	01513423          	sd	s5,8(sp)
    800064b0:	01613023          	sd	s6,0(sp)
    800064b4:	04010413          	addi	s0,sp,64
    800064b8:	00a4f4b3          	and	s1,s1,a0
    800064bc:	00f487b3          	add	a5,s1,a5
    800064c0:	06f5e463          	bltu	a1,a5,80006528 <freerange+0xa8>
    800064c4:	00005a97          	auipc	s5,0x5
    800064c8:	d6ca8a93          	addi	s5,s5,-660 # 8000b230 <end>
    800064cc:	0954e263          	bltu	s1,s5,80006550 <freerange+0xd0>
    800064d0:	01100993          	li	s3,17
    800064d4:	01b99993          	slli	s3,s3,0x1b
    800064d8:	0734fc63          	bgeu	s1,s3,80006550 <freerange+0xd0>
    800064dc:	00058a13          	mv	s4,a1
    800064e0:	00004917          	auipc	s2,0x4
    800064e4:	a8090913          	addi	s2,s2,-1408 # 80009f60 <kmem>
    800064e8:	00002b37          	lui	s6,0x2
    800064ec:	0140006f          	j	80006500 <freerange+0x80>
    800064f0:	000017b7          	lui	a5,0x1
    800064f4:	00f484b3          	add	s1,s1,a5
    800064f8:	0554ec63          	bltu	s1,s5,80006550 <freerange+0xd0>
    800064fc:	0534fa63          	bgeu	s1,s3,80006550 <freerange+0xd0>
    80006500:	00001637          	lui	a2,0x1
    80006504:	00100593          	li	a1,1
    80006508:	00048513          	mv	a0,s1
    8000650c:	00000097          	auipc	ra,0x0
    80006510:	50c080e7          	jalr	1292(ra) # 80006a18 <__memset>
    80006514:	00093703          	ld	a4,0(s2)
    80006518:	016487b3          	add	a5,s1,s6
    8000651c:	00e4b023          	sd	a4,0(s1)
    80006520:	00993023          	sd	s1,0(s2)
    80006524:	fcfa76e3          	bgeu	s4,a5,800064f0 <freerange+0x70>
    80006528:	03813083          	ld	ra,56(sp)
    8000652c:	03013403          	ld	s0,48(sp)
    80006530:	02813483          	ld	s1,40(sp)
    80006534:	02013903          	ld	s2,32(sp)
    80006538:	01813983          	ld	s3,24(sp)
    8000653c:	01013a03          	ld	s4,16(sp)
    80006540:	00813a83          	ld	s5,8(sp)
    80006544:	00013b03          	ld	s6,0(sp)
    80006548:	04010113          	addi	sp,sp,64
    8000654c:	00008067          	ret
    80006550:	00002517          	auipc	a0,0x2
    80006554:	18850513          	addi	a0,a0,392 # 800086d8 <digits+0x18>
    80006558:	fffff097          	auipc	ra,0xfffff
    8000655c:	3d4080e7          	jalr	980(ra) # 8000592c <panic>

0000000080006560 <kfree>:
    80006560:	fe010113          	addi	sp,sp,-32
    80006564:	00813823          	sd	s0,16(sp)
    80006568:	00113c23          	sd	ra,24(sp)
    8000656c:	00913423          	sd	s1,8(sp)
    80006570:	02010413          	addi	s0,sp,32
    80006574:	03451793          	slli	a5,a0,0x34
    80006578:	04079c63          	bnez	a5,800065d0 <kfree+0x70>
    8000657c:	00005797          	auipc	a5,0x5
    80006580:	cb478793          	addi	a5,a5,-844 # 8000b230 <end>
    80006584:	00050493          	mv	s1,a0
    80006588:	04f56463          	bltu	a0,a5,800065d0 <kfree+0x70>
    8000658c:	01100793          	li	a5,17
    80006590:	01b79793          	slli	a5,a5,0x1b
    80006594:	02f57e63          	bgeu	a0,a5,800065d0 <kfree+0x70>
    80006598:	00001637          	lui	a2,0x1
    8000659c:	00100593          	li	a1,1
    800065a0:	00000097          	auipc	ra,0x0
    800065a4:	478080e7          	jalr	1144(ra) # 80006a18 <__memset>
    800065a8:	00004797          	auipc	a5,0x4
    800065ac:	9b878793          	addi	a5,a5,-1608 # 80009f60 <kmem>
    800065b0:	0007b703          	ld	a4,0(a5)
    800065b4:	01813083          	ld	ra,24(sp)
    800065b8:	01013403          	ld	s0,16(sp)
    800065bc:	00e4b023          	sd	a4,0(s1)
    800065c0:	0097b023          	sd	s1,0(a5)
    800065c4:	00813483          	ld	s1,8(sp)
    800065c8:	02010113          	addi	sp,sp,32
    800065cc:	00008067          	ret
    800065d0:	00002517          	auipc	a0,0x2
    800065d4:	10850513          	addi	a0,a0,264 # 800086d8 <digits+0x18>
    800065d8:	fffff097          	auipc	ra,0xfffff
    800065dc:	354080e7          	jalr	852(ra) # 8000592c <panic>

00000000800065e0 <kalloc>:
    800065e0:	fe010113          	addi	sp,sp,-32
    800065e4:	00813823          	sd	s0,16(sp)
    800065e8:	00913423          	sd	s1,8(sp)
    800065ec:	00113c23          	sd	ra,24(sp)
    800065f0:	02010413          	addi	s0,sp,32
    800065f4:	00004797          	auipc	a5,0x4
    800065f8:	96c78793          	addi	a5,a5,-1684 # 80009f60 <kmem>
    800065fc:	0007b483          	ld	s1,0(a5)
    80006600:	02048063          	beqz	s1,80006620 <kalloc+0x40>
    80006604:	0004b703          	ld	a4,0(s1)
    80006608:	00001637          	lui	a2,0x1
    8000660c:	00500593          	li	a1,5
    80006610:	00048513          	mv	a0,s1
    80006614:	00e7b023          	sd	a4,0(a5)
    80006618:	00000097          	auipc	ra,0x0
    8000661c:	400080e7          	jalr	1024(ra) # 80006a18 <__memset>
    80006620:	01813083          	ld	ra,24(sp)
    80006624:	01013403          	ld	s0,16(sp)
    80006628:	00048513          	mv	a0,s1
    8000662c:	00813483          	ld	s1,8(sp)
    80006630:	02010113          	addi	sp,sp,32
    80006634:	00008067          	ret

0000000080006638 <initlock>:
    80006638:	ff010113          	addi	sp,sp,-16
    8000663c:	00813423          	sd	s0,8(sp)
    80006640:	01010413          	addi	s0,sp,16
    80006644:	00813403          	ld	s0,8(sp)
    80006648:	00b53423          	sd	a1,8(a0)
    8000664c:	00052023          	sw	zero,0(a0)
    80006650:	00053823          	sd	zero,16(a0)
    80006654:	01010113          	addi	sp,sp,16
    80006658:	00008067          	ret

000000008000665c <acquire>:
    8000665c:	fe010113          	addi	sp,sp,-32
    80006660:	00813823          	sd	s0,16(sp)
    80006664:	00913423          	sd	s1,8(sp)
    80006668:	00113c23          	sd	ra,24(sp)
    8000666c:	01213023          	sd	s2,0(sp)
    80006670:	02010413          	addi	s0,sp,32
    80006674:	00050493          	mv	s1,a0
    80006678:	10002973          	csrr	s2,sstatus
    8000667c:	100027f3          	csrr	a5,sstatus
    80006680:	ffd7f793          	andi	a5,a5,-3
    80006684:	10079073          	csrw	sstatus,a5
    80006688:	fffff097          	auipc	ra,0xfffff
    8000668c:	8ec080e7          	jalr	-1812(ra) # 80004f74 <mycpu>
    80006690:	07852783          	lw	a5,120(a0)
    80006694:	06078e63          	beqz	a5,80006710 <acquire+0xb4>
    80006698:	fffff097          	auipc	ra,0xfffff
    8000669c:	8dc080e7          	jalr	-1828(ra) # 80004f74 <mycpu>
    800066a0:	07852783          	lw	a5,120(a0)
    800066a4:	0004a703          	lw	a4,0(s1)
    800066a8:	0017879b          	addiw	a5,a5,1
    800066ac:	06f52c23          	sw	a5,120(a0)
    800066b0:	04071063          	bnez	a4,800066f0 <acquire+0x94>
    800066b4:	00100713          	li	a4,1
    800066b8:	00070793          	mv	a5,a4
    800066bc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800066c0:	0007879b          	sext.w	a5,a5
    800066c4:	fe079ae3          	bnez	a5,800066b8 <acquire+0x5c>
    800066c8:	0ff0000f          	fence
    800066cc:	fffff097          	auipc	ra,0xfffff
    800066d0:	8a8080e7          	jalr	-1880(ra) # 80004f74 <mycpu>
    800066d4:	01813083          	ld	ra,24(sp)
    800066d8:	01013403          	ld	s0,16(sp)
    800066dc:	00a4b823          	sd	a0,16(s1)
    800066e0:	00013903          	ld	s2,0(sp)
    800066e4:	00813483          	ld	s1,8(sp)
    800066e8:	02010113          	addi	sp,sp,32
    800066ec:	00008067          	ret
    800066f0:	0104b903          	ld	s2,16(s1)
    800066f4:	fffff097          	auipc	ra,0xfffff
    800066f8:	880080e7          	jalr	-1920(ra) # 80004f74 <mycpu>
    800066fc:	faa91ce3          	bne	s2,a0,800066b4 <acquire+0x58>
    80006700:	00002517          	auipc	a0,0x2
    80006704:	fe050513          	addi	a0,a0,-32 # 800086e0 <digits+0x20>
    80006708:	fffff097          	auipc	ra,0xfffff
    8000670c:	224080e7          	jalr	548(ra) # 8000592c <panic>
    80006710:	00195913          	srli	s2,s2,0x1
    80006714:	fffff097          	auipc	ra,0xfffff
    80006718:	860080e7          	jalr	-1952(ra) # 80004f74 <mycpu>
    8000671c:	00197913          	andi	s2,s2,1
    80006720:	07252e23          	sw	s2,124(a0)
    80006724:	f75ff06f          	j	80006698 <acquire+0x3c>

0000000080006728 <release>:
    80006728:	fe010113          	addi	sp,sp,-32
    8000672c:	00813823          	sd	s0,16(sp)
    80006730:	00113c23          	sd	ra,24(sp)
    80006734:	00913423          	sd	s1,8(sp)
    80006738:	01213023          	sd	s2,0(sp)
    8000673c:	02010413          	addi	s0,sp,32
    80006740:	00052783          	lw	a5,0(a0)
    80006744:	00079a63          	bnez	a5,80006758 <release+0x30>
    80006748:	00002517          	auipc	a0,0x2
    8000674c:	fa050513          	addi	a0,a0,-96 # 800086e8 <digits+0x28>
    80006750:	fffff097          	auipc	ra,0xfffff
    80006754:	1dc080e7          	jalr	476(ra) # 8000592c <panic>
    80006758:	01053903          	ld	s2,16(a0)
    8000675c:	00050493          	mv	s1,a0
    80006760:	fffff097          	auipc	ra,0xfffff
    80006764:	814080e7          	jalr	-2028(ra) # 80004f74 <mycpu>
    80006768:	fea910e3          	bne	s2,a0,80006748 <release+0x20>
    8000676c:	0004b823          	sd	zero,16(s1)
    80006770:	0ff0000f          	fence
    80006774:	0f50000f          	fence	iorw,ow
    80006778:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000677c:	ffffe097          	auipc	ra,0xffffe
    80006780:	7f8080e7          	jalr	2040(ra) # 80004f74 <mycpu>
    80006784:	100027f3          	csrr	a5,sstatus
    80006788:	0027f793          	andi	a5,a5,2
    8000678c:	04079a63          	bnez	a5,800067e0 <release+0xb8>
    80006790:	07852783          	lw	a5,120(a0)
    80006794:	02f05e63          	blez	a5,800067d0 <release+0xa8>
    80006798:	fff7871b          	addiw	a4,a5,-1
    8000679c:	06e52c23          	sw	a4,120(a0)
    800067a0:	00071c63          	bnez	a4,800067b8 <release+0x90>
    800067a4:	07c52783          	lw	a5,124(a0)
    800067a8:	00078863          	beqz	a5,800067b8 <release+0x90>
    800067ac:	100027f3          	csrr	a5,sstatus
    800067b0:	0027e793          	ori	a5,a5,2
    800067b4:	10079073          	csrw	sstatus,a5
    800067b8:	01813083          	ld	ra,24(sp)
    800067bc:	01013403          	ld	s0,16(sp)
    800067c0:	00813483          	ld	s1,8(sp)
    800067c4:	00013903          	ld	s2,0(sp)
    800067c8:	02010113          	addi	sp,sp,32
    800067cc:	00008067          	ret
    800067d0:	00002517          	auipc	a0,0x2
    800067d4:	f3850513          	addi	a0,a0,-200 # 80008708 <digits+0x48>
    800067d8:	fffff097          	auipc	ra,0xfffff
    800067dc:	154080e7          	jalr	340(ra) # 8000592c <panic>
    800067e0:	00002517          	auipc	a0,0x2
    800067e4:	f1050513          	addi	a0,a0,-240 # 800086f0 <digits+0x30>
    800067e8:	fffff097          	auipc	ra,0xfffff
    800067ec:	144080e7          	jalr	324(ra) # 8000592c <panic>

00000000800067f0 <holding>:
    800067f0:	00052783          	lw	a5,0(a0)
    800067f4:	00079663          	bnez	a5,80006800 <holding+0x10>
    800067f8:	00000513          	li	a0,0
    800067fc:	00008067          	ret
    80006800:	fe010113          	addi	sp,sp,-32
    80006804:	00813823          	sd	s0,16(sp)
    80006808:	00913423          	sd	s1,8(sp)
    8000680c:	00113c23          	sd	ra,24(sp)
    80006810:	02010413          	addi	s0,sp,32
    80006814:	01053483          	ld	s1,16(a0)
    80006818:	ffffe097          	auipc	ra,0xffffe
    8000681c:	75c080e7          	jalr	1884(ra) # 80004f74 <mycpu>
    80006820:	01813083          	ld	ra,24(sp)
    80006824:	01013403          	ld	s0,16(sp)
    80006828:	40a48533          	sub	a0,s1,a0
    8000682c:	00153513          	seqz	a0,a0
    80006830:	00813483          	ld	s1,8(sp)
    80006834:	02010113          	addi	sp,sp,32
    80006838:	00008067          	ret

000000008000683c <push_off>:
    8000683c:	fe010113          	addi	sp,sp,-32
    80006840:	00813823          	sd	s0,16(sp)
    80006844:	00113c23          	sd	ra,24(sp)
    80006848:	00913423          	sd	s1,8(sp)
    8000684c:	02010413          	addi	s0,sp,32
    80006850:	100024f3          	csrr	s1,sstatus
    80006854:	100027f3          	csrr	a5,sstatus
    80006858:	ffd7f793          	andi	a5,a5,-3
    8000685c:	10079073          	csrw	sstatus,a5
    80006860:	ffffe097          	auipc	ra,0xffffe
    80006864:	714080e7          	jalr	1812(ra) # 80004f74 <mycpu>
    80006868:	07852783          	lw	a5,120(a0)
    8000686c:	02078663          	beqz	a5,80006898 <push_off+0x5c>
    80006870:	ffffe097          	auipc	ra,0xffffe
    80006874:	704080e7          	jalr	1796(ra) # 80004f74 <mycpu>
    80006878:	07852783          	lw	a5,120(a0)
    8000687c:	01813083          	ld	ra,24(sp)
    80006880:	01013403          	ld	s0,16(sp)
    80006884:	0017879b          	addiw	a5,a5,1
    80006888:	06f52c23          	sw	a5,120(a0)
    8000688c:	00813483          	ld	s1,8(sp)
    80006890:	02010113          	addi	sp,sp,32
    80006894:	00008067          	ret
    80006898:	0014d493          	srli	s1,s1,0x1
    8000689c:	ffffe097          	auipc	ra,0xffffe
    800068a0:	6d8080e7          	jalr	1752(ra) # 80004f74 <mycpu>
    800068a4:	0014f493          	andi	s1,s1,1
    800068a8:	06952e23          	sw	s1,124(a0)
    800068ac:	fc5ff06f          	j	80006870 <push_off+0x34>

00000000800068b0 <pop_off>:
    800068b0:	ff010113          	addi	sp,sp,-16
    800068b4:	00813023          	sd	s0,0(sp)
    800068b8:	00113423          	sd	ra,8(sp)
    800068bc:	01010413          	addi	s0,sp,16
    800068c0:	ffffe097          	auipc	ra,0xffffe
    800068c4:	6b4080e7          	jalr	1716(ra) # 80004f74 <mycpu>
    800068c8:	100027f3          	csrr	a5,sstatus
    800068cc:	0027f793          	andi	a5,a5,2
    800068d0:	04079663          	bnez	a5,8000691c <pop_off+0x6c>
    800068d4:	07852783          	lw	a5,120(a0)
    800068d8:	02f05a63          	blez	a5,8000690c <pop_off+0x5c>
    800068dc:	fff7871b          	addiw	a4,a5,-1
    800068e0:	06e52c23          	sw	a4,120(a0)
    800068e4:	00071c63          	bnez	a4,800068fc <pop_off+0x4c>
    800068e8:	07c52783          	lw	a5,124(a0)
    800068ec:	00078863          	beqz	a5,800068fc <pop_off+0x4c>
    800068f0:	100027f3          	csrr	a5,sstatus
    800068f4:	0027e793          	ori	a5,a5,2
    800068f8:	10079073          	csrw	sstatus,a5
    800068fc:	00813083          	ld	ra,8(sp)
    80006900:	00013403          	ld	s0,0(sp)
    80006904:	01010113          	addi	sp,sp,16
    80006908:	00008067          	ret
    8000690c:	00002517          	auipc	a0,0x2
    80006910:	dfc50513          	addi	a0,a0,-516 # 80008708 <digits+0x48>
    80006914:	fffff097          	auipc	ra,0xfffff
    80006918:	018080e7          	jalr	24(ra) # 8000592c <panic>
    8000691c:	00002517          	auipc	a0,0x2
    80006920:	dd450513          	addi	a0,a0,-556 # 800086f0 <digits+0x30>
    80006924:	fffff097          	auipc	ra,0xfffff
    80006928:	008080e7          	jalr	8(ra) # 8000592c <panic>

000000008000692c <push_on>:
    8000692c:	fe010113          	addi	sp,sp,-32
    80006930:	00813823          	sd	s0,16(sp)
    80006934:	00113c23          	sd	ra,24(sp)
    80006938:	00913423          	sd	s1,8(sp)
    8000693c:	02010413          	addi	s0,sp,32
    80006940:	100024f3          	csrr	s1,sstatus
    80006944:	100027f3          	csrr	a5,sstatus
    80006948:	0027e793          	ori	a5,a5,2
    8000694c:	10079073          	csrw	sstatus,a5
    80006950:	ffffe097          	auipc	ra,0xffffe
    80006954:	624080e7          	jalr	1572(ra) # 80004f74 <mycpu>
    80006958:	07852783          	lw	a5,120(a0)
    8000695c:	02078663          	beqz	a5,80006988 <push_on+0x5c>
    80006960:	ffffe097          	auipc	ra,0xffffe
    80006964:	614080e7          	jalr	1556(ra) # 80004f74 <mycpu>
    80006968:	07852783          	lw	a5,120(a0)
    8000696c:	01813083          	ld	ra,24(sp)
    80006970:	01013403          	ld	s0,16(sp)
    80006974:	0017879b          	addiw	a5,a5,1
    80006978:	06f52c23          	sw	a5,120(a0)
    8000697c:	00813483          	ld	s1,8(sp)
    80006980:	02010113          	addi	sp,sp,32
    80006984:	00008067          	ret
    80006988:	0014d493          	srli	s1,s1,0x1
    8000698c:	ffffe097          	auipc	ra,0xffffe
    80006990:	5e8080e7          	jalr	1512(ra) # 80004f74 <mycpu>
    80006994:	0014f493          	andi	s1,s1,1
    80006998:	06952e23          	sw	s1,124(a0)
    8000699c:	fc5ff06f          	j	80006960 <push_on+0x34>

00000000800069a0 <pop_on>:
    800069a0:	ff010113          	addi	sp,sp,-16
    800069a4:	00813023          	sd	s0,0(sp)
    800069a8:	00113423          	sd	ra,8(sp)
    800069ac:	01010413          	addi	s0,sp,16
    800069b0:	ffffe097          	auipc	ra,0xffffe
    800069b4:	5c4080e7          	jalr	1476(ra) # 80004f74 <mycpu>
    800069b8:	100027f3          	csrr	a5,sstatus
    800069bc:	0027f793          	andi	a5,a5,2
    800069c0:	04078463          	beqz	a5,80006a08 <pop_on+0x68>
    800069c4:	07852783          	lw	a5,120(a0)
    800069c8:	02f05863          	blez	a5,800069f8 <pop_on+0x58>
    800069cc:	fff7879b          	addiw	a5,a5,-1
    800069d0:	06f52c23          	sw	a5,120(a0)
    800069d4:	07853783          	ld	a5,120(a0)
    800069d8:	00079863          	bnez	a5,800069e8 <pop_on+0x48>
    800069dc:	100027f3          	csrr	a5,sstatus
    800069e0:	ffd7f793          	andi	a5,a5,-3
    800069e4:	10079073          	csrw	sstatus,a5
    800069e8:	00813083          	ld	ra,8(sp)
    800069ec:	00013403          	ld	s0,0(sp)
    800069f0:	01010113          	addi	sp,sp,16
    800069f4:	00008067          	ret
    800069f8:	00002517          	auipc	a0,0x2
    800069fc:	d3850513          	addi	a0,a0,-712 # 80008730 <digits+0x70>
    80006a00:	fffff097          	auipc	ra,0xfffff
    80006a04:	f2c080e7          	jalr	-212(ra) # 8000592c <panic>
    80006a08:	00002517          	auipc	a0,0x2
    80006a0c:	d0850513          	addi	a0,a0,-760 # 80008710 <digits+0x50>
    80006a10:	fffff097          	auipc	ra,0xfffff
    80006a14:	f1c080e7          	jalr	-228(ra) # 8000592c <panic>

0000000080006a18 <__memset>:
    80006a18:	ff010113          	addi	sp,sp,-16
    80006a1c:	00813423          	sd	s0,8(sp)
    80006a20:	01010413          	addi	s0,sp,16
    80006a24:	1a060e63          	beqz	a2,80006be0 <__memset+0x1c8>
    80006a28:	40a007b3          	neg	a5,a0
    80006a2c:	0077f793          	andi	a5,a5,7
    80006a30:	00778693          	addi	a3,a5,7
    80006a34:	00b00813          	li	a6,11
    80006a38:	0ff5f593          	andi	a1,a1,255
    80006a3c:	fff6071b          	addiw	a4,a2,-1
    80006a40:	1b06e663          	bltu	a3,a6,80006bec <__memset+0x1d4>
    80006a44:	1cd76463          	bltu	a4,a3,80006c0c <__memset+0x1f4>
    80006a48:	1a078e63          	beqz	a5,80006c04 <__memset+0x1ec>
    80006a4c:	00b50023          	sb	a1,0(a0)
    80006a50:	00100713          	li	a4,1
    80006a54:	1ae78463          	beq	a5,a4,80006bfc <__memset+0x1e4>
    80006a58:	00b500a3          	sb	a1,1(a0)
    80006a5c:	00200713          	li	a4,2
    80006a60:	1ae78a63          	beq	a5,a4,80006c14 <__memset+0x1fc>
    80006a64:	00b50123          	sb	a1,2(a0)
    80006a68:	00300713          	li	a4,3
    80006a6c:	18e78463          	beq	a5,a4,80006bf4 <__memset+0x1dc>
    80006a70:	00b501a3          	sb	a1,3(a0)
    80006a74:	00400713          	li	a4,4
    80006a78:	1ae78263          	beq	a5,a4,80006c1c <__memset+0x204>
    80006a7c:	00b50223          	sb	a1,4(a0)
    80006a80:	00500713          	li	a4,5
    80006a84:	1ae78063          	beq	a5,a4,80006c24 <__memset+0x20c>
    80006a88:	00b502a3          	sb	a1,5(a0)
    80006a8c:	00700713          	li	a4,7
    80006a90:	18e79e63          	bne	a5,a4,80006c2c <__memset+0x214>
    80006a94:	00b50323          	sb	a1,6(a0)
    80006a98:	00700e93          	li	t4,7
    80006a9c:	00859713          	slli	a4,a1,0x8
    80006aa0:	00e5e733          	or	a4,a1,a4
    80006aa4:	01059e13          	slli	t3,a1,0x10
    80006aa8:	01c76e33          	or	t3,a4,t3
    80006aac:	01859313          	slli	t1,a1,0x18
    80006ab0:	006e6333          	or	t1,t3,t1
    80006ab4:	02059893          	slli	a7,a1,0x20
    80006ab8:	40f60e3b          	subw	t3,a2,a5
    80006abc:	011368b3          	or	a7,t1,a7
    80006ac0:	02859813          	slli	a6,a1,0x28
    80006ac4:	0108e833          	or	a6,a7,a6
    80006ac8:	03059693          	slli	a3,a1,0x30
    80006acc:	003e589b          	srliw	a7,t3,0x3
    80006ad0:	00d866b3          	or	a3,a6,a3
    80006ad4:	03859713          	slli	a4,a1,0x38
    80006ad8:	00389813          	slli	a6,a7,0x3
    80006adc:	00f507b3          	add	a5,a0,a5
    80006ae0:	00e6e733          	or	a4,a3,a4
    80006ae4:	000e089b          	sext.w	a7,t3
    80006ae8:	00f806b3          	add	a3,a6,a5
    80006aec:	00e7b023          	sd	a4,0(a5)
    80006af0:	00878793          	addi	a5,a5,8
    80006af4:	fed79ce3          	bne	a5,a3,80006aec <__memset+0xd4>
    80006af8:	ff8e7793          	andi	a5,t3,-8
    80006afc:	0007871b          	sext.w	a4,a5
    80006b00:	01d787bb          	addw	a5,a5,t4
    80006b04:	0ce88e63          	beq	a7,a4,80006be0 <__memset+0x1c8>
    80006b08:	00f50733          	add	a4,a0,a5
    80006b0c:	00b70023          	sb	a1,0(a4)
    80006b10:	0017871b          	addiw	a4,a5,1
    80006b14:	0cc77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b18:	00e50733          	add	a4,a0,a4
    80006b1c:	00b70023          	sb	a1,0(a4)
    80006b20:	0027871b          	addiw	a4,a5,2
    80006b24:	0ac77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b28:	00e50733          	add	a4,a0,a4
    80006b2c:	00b70023          	sb	a1,0(a4)
    80006b30:	0037871b          	addiw	a4,a5,3
    80006b34:	0ac77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b38:	00e50733          	add	a4,a0,a4
    80006b3c:	00b70023          	sb	a1,0(a4)
    80006b40:	0047871b          	addiw	a4,a5,4
    80006b44:	08c77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b48:	00e50733          	add	a4,a0,a4
    80006b4c:	00b70023          	sb	a1,0(a4)
    80006b50:	0057871b          	addiw	a4,a5,5
    80006b54:	08c77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b58:	00e50733          	add	a4,a0,a4
    80006b5c:	00b70023          	sb	a1,0(a4)
    80006b60:	0067871b          	addiw	a4,a5,6
    80006b64:	06c77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b68:	00e50733          	add	a4,a0,a4
    80006b6c:	00b70023          	sb	a1,0(a4)
    80006b70:	0077871b          	addiw	a4,a5,7
    80006b74:	06c77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b78:	00e50733          	add	a4,a0,a4
    80006b7c:	00b70023          	sb	a1,0(a4)
    80006b80:	0087871b          	addiw	a4,a5,8
    80006b84:	04c77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b88:	00e50733          	add	a4,a0,a4
    80006b8c:	00b70023          	sb	a1,0(a4)
    80006b90:	0097871b          	addiw	a4,a5,9
    80006b94:	04c77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006b98:	00e50733          	add	a4,a0,a4
    80006b9c:	00b70023          	sb	a1,0(a4)
    80006ba0:	00a7871b          	addiw	a4,a5,10
    80006ba4:	02c77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006ba8:	00e50733          	add	a4,a0,a4
    80006bac:	00b70023          	sb	a1,0(a4)
    80006bb0:	00b7871b          	addiw	a4,a5,11
    80006bb4:	02c77663          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006bb8:	00e50733          	add	a4,a0,a4
    80006bbc:	00b70023          	sb	a1,0(a4)
    80006bc0:	00c7871b          	addiw	a4,a5,12
    80006bc4:	00c77e63          	bgeu	a4,a2,80006be0 <__memset+0x1c8>
    80006bc8:	00e50733          	add	a4,a0,a4
    80006bcc:	00b70023          	sb	a1,0(a4)
    80006bd0:	00d7879b          	addiw	a5,a5,13
    80006bd4:	00c7f663          	bgeu	a5,a2,80006be0 <__memset+0x1c8>
    80006bd8:	00f507b3          	add	a5,a0,a5
    80006bdc:	00b78023          	sb	a1,0(a5)
    80006be0:	00813403          	ld	s0,8(sp)
    80006be4:	01010113          	addi	sp,sp,16
    80006be8:	00008067          	ret
    80006bec:	00b00693          	li	a3,11
    80006bf0:	e55ff06f          	j	80006a44 <__memset+0x2c>
    80006bf4:	00300e93          	li	t4,3
    80006bf8:	ea5ff06f          	j	80006a9c <__memset+0x84>
    80006bfc:	00100e93          	li	t4,1
    80006c00:	e9dff06f          	j	80006a9c <__memset+0x84>
    80006c04:	00000e93          	li	t4,0
    80006c08:	e95ff06f          	j	80006a9c <__memset+0x84>
    80006c0c:	00000793          	li	a5,0
    80006c10:	ef9ff06f          	j	80006b08 <__memset+0xf0>
    80006c14:	00200e93          	li	t4,2
    80006c18:	e85ff06f          	j	80006a9c <__memset+0x84>
    80006c1c:	00400e93          	li	t4,4
    80006c20:	e7dff06f          	j	80006a9c <__memset+0x84>
    80006c24:	00500e93          	li	t4,5
    80006c28:	e75ff06f          	j	80006a9c <__memset+0x84>
    80006c2c:	00600e93          	li	t4,6
    80006c30:	e6dff06f          	j	80006a9c <__memset+0x84>

0000000080006c34 <__memmove>:
    80006c34:	ff010113          	addi	sp,sp,-16
    80006c38:	00813423          	sd	s0,8(sp)
    80006c3c:	01010413          	addi	s0,sp,16
    80006c40:	0e060863          	beqz	a2,80006d30 <__memmove+0xfc>
    80006c44:	fff6069b          	addiw	a3,a2,-1
    80006c48:	0006881b          	sext.w	a6,a3
    80006c4c:	0ea5e863          	bltu	a1,a0,80006d3c <__memmove+0x108>
    80006c50:	00758713          	addi	a4,a1,7
    80006c54:	00a5e7b3          	or	a5,a1,a0
    80006c58:	40a70733          	sub	a4,a4,a0
    80006c5c:	0077f793          	andi	a5,a5,7
    80006c60:	00f73713          	sltiu	a4,a4,15
    80006c64:	00174713          	xori	a4,a4,1
    80006c68:	0017b793          	seqz	a5,a5
    80006c6c:	00e7f7b3          	and	a5,a5,a4
    80006c70:	10078863          	beqz	a5,80006d80 <__memmove+0x14c>
    80006c74:	00900793          	li	a5,9
    80006c78:	1107f463          	bgeu	a5,a6,80006d80 <__memmove+0x14c>
    80006c7c:	0036581b          	srliw	a6,a2,0x3
    80006c80:	fff8081b          	addiw	a6,a6,-1
    80006c84:	02081813          	slli	a6,a6,0x20
    80006c88:	01d85893          	srli	a7,a6,0x1d
    80006c8c:	00858813          	addi	a6,a1,8
    80006c90:	00058793          	mv	a5,a1
    80006c94:	00050713          	mv	a4,a0
    80006c98:	01088833          	add	a6,a7,a6
    80006c9c:	0007b883          	ld	a7,0(a5)
    80006ca0:	00878793          	addi	a5,a5,8
    80006ca4:	00870713          	addi	a4,a4,8
    80006ca8:	ff173c23          	sd	a7,-8(a4)
    80006cac:	ff0798e3          	bne	a5,a6,80006c9c <__memmove+0x68>
    80006cb0:	ff867713          	andi	a4,a2,-8
    80006cb4:	02071793          	slli	a5,a4,0x20
    80006cb8:	0207d793          	srli	a5,a5,0x20
    80006cbc:	00f585b3          	add	a1,a1,a5
    80006cc0:	40e686bb          	subw	a3,a3,a4
    80006cc4:	00f507b3          	add	a5,a0,a5
    80006cc8:	06e60463          	beq	a2,a4,80006d30 <__memmove+0xfc>
    80006ccc:	0005c703          	lbu	a4,0(a1)
    80006cd0:	00e78023          	sb	a4,0(a5)
    80006cd4:	04068e63          	beqz	a3,80006d30 <__memmove+0xfc>
    80006cd8:	0015c603          	lbu	a2,1(a1)
    80006cdc:	00100713          	li	a4,1
    80006ce0:	00c780a3          	sb	a2,1(a5)
    80006ce4:	04e68663          	beq	a3,a4,80006d30 <__memmove+0xfc>
    80006ce8:	0025c603          	lbu	a2,2(a1)
    80006cec:	00200713          	li	a4,2
    80006cf0:	00c78123          	sb	a2,2(a5)
    80006cf4:	02e68e63          	beq	a3,a4,80006d30 <__memmove+0xfc>
    80006cf8:	0035c603          	lbu	a2,3(a1)
    80006cfc:	00300713          	li	a4,3
    80006d00:	00c781a3          	sb	a2,3(a5)
    80006d04:	02e68663          	beq	a3,a4,80006d30 <__memmove+0xfc>
    80006d08:	0045c603          	lbu	a2,4(a1)
    80006d0c:	00400713          	li	a4,4
    80006d10:	00c78223          	sb	a2,4(a5)
    80006d14:	00e68e63          	beq	a3,a4,80006d30 <__memmove+0xfc>
    80006d18:	0055c603          	lbu	a2,5(a1)
    80006d1c:	00500713          	li	a4,5
    80006d20:	00c782a3          	sb	a2,5(a5)
    80006d24:	00e68663          	beq	a3,a4,80006d30 <__memmove+0xfc>
    80006d28:	0065c703          	lbu	a4,6(a1)
    80006d2c:	00e78323          	sb	a4,6(a5)
    80006d30:	00813403          	ld	s0,8(sp)
    80006d34:	01010113          	addi	sp,sp,16
    80006d38:	00008067          	ret
    80006d3c:	02061713          	slli	a4,a2,0x20
    80006d40:	02075713          	srli	a4,a4,0x20
    80006d44:	00e587b3          	add	a5,a1,a4
    80006d48:	f0f574e3          	bgeu	a0,a5,80006c50 <__memmove+0x1c>
    80006d4c:	02069613          	slli	a2,a3,0x20
    80006d50:	02065613          	srli	a2,a2,0x20
    80006d54:	fff64613          	not	a2,a2
    80006d58:	00e50733          	add	a4,a0,a4
    80006d5c:	00c78633          	add	a2,a5,a2
    80006d60:	fff7c683          	lbu	a3,-1(a5)
    80006d64:	fff78793          	addi	a5,a5,-1
    80006d68:	fff70713          	addi	a4,a4,-1
    80006d6c:	00d70023          	sb	a3,0(a4)
    80006d70:	fec798e3          	bne	a5,a2,80006d60 <__memmove+0x12c>
    80006d74:	00813403          	ld	s0,8(sp)
    80006d78:	01010113          	addi	sp,sp,16
    80006d7c:	00008067          	ret
    80006d80:	02069713          	slli	a4,a3,0x20
    80006d84:	02075713          	srli	a4,a4,0x20
    80006d88:	00170713          	addi	a4,a4,1
    80006d8c:	00e50733          	add	a4,a0,a4
    80006d90:	00050793          	mv	a5,a0
    80006d94:	0005c683          	lbu	a3,0(a1)
    80006d98:	00178793          	addi	a5,a5,1
    80006d9c:	00158593          	addi	a1,a1,1
    80006da0:	fed78fa3          	sb	a3,-1(a5)
    80006da4:	fee798e3          	bne	a5,a4,80006d94 <__memmove+0x160>
    80006da8:	f89ff06f          	j	80006d30 <__memmove+0xfc>

0000000080006dac <__mem_free>:
    80006dac:	ff010113          	addi	sp,sp,-16
    80006db0:	00813423          	sd	s0,8(sp)
    80006db4:	01010413          	addi	s0,sp,16
    80006db8:	00003597          	auipc	a1,0x3
    80006dbc:	1b058593          	addi	a1,a1,432 # 80009f68 <freep>
    80006dc0:	0005b783          	ld	a5,0(a1)
    80006dc4:	ff050693          	addi	a3,a0,-16
    80006dc8:	0007b703          	ld	a4,0(a5)
    80006dcc:	00d7fc63          	bgeu	a5,a3,80006de4 <__mem_free+0x38>
    80006dd0:	00e6ee63          	bltu	a3,a4,80006dec <__mem_free+0x40>
    80006dd4:	00e7fc63          	bgeu	a5,a4,80006dec <__mem_free+0x40>
    80006dd8:	00070793          	mv	a5,a4
    80006ddc:	0007b703          	ld	a4,0(a5)
    80006de0:	fed7e8e3          	bltu	a5,a3,80006dd0 <__mem_free+0x24>
    80006de4:	fee7eae3          	bltu	a5,a4,80006dd8 <__mem_free+0x2c>
    80006de8:	fee6f8e3          	bgeu	a3,a4,80006dd8 <__mem_free+0x2c>
    80006dec:	ff852803          	lw	a6,-8(a0)
    80006df0:	02081613          	slli	a2,a6,0x20
    80006df4:	01c65613          	srli	a2,a2,0x1c
    80006df8:	00c68633          	add	a2,a3,a2
    80006dfc:	02c70a63          	beq	a4,a2,80006e30 <__mem_free+0x84>
    80006e00:	fee53823          	sd	a4,-16(a0)
    80006e04:	0087a503          	lw	a0,8(a5)
    80006e08:	02051613          	slli	a2,a0,0x20
    80006e0c:	01c65613          	srli	a2,a2,0x1c
    80006e10:	00c78633          	add	a2,a5,a2
    80006e14:	04c68263          	beq	a3,a2,80006e58 <__mem_free+0xac>
    80006e18:	00813403          	ld	s0,8(sp)
    80006e1c:	00d7b023          	sd	a3,0(a5)
    80006e20:	00f5b023          	sd	a5,0(a1)
    80006e24:	00000513          	li	a0,0
    80006e28:	01010113          	addi	sp,sp,16
    80006e2c:	00008067          	ret
    80006e30:	00872603          	lw	a2,8(a4)
    80006e34:	00073703          	ld	a4,0(a4)
    80006e38:	0106083b          	addw	a6,a2,a6
    80006e3c:	ff052c23          	sw	a6,-8(a0)
    80006e40:	fee53823          	sd	a4,-16(a0)
    80006e44:	0087a503          	lw	a0,8(a5)
    80006e48:	02051613          	slli	a2,a0,0x20
    80006e4c:	01c65613          	srli	a2,a2,0x1c
    80006e50:	00c78633          	add	a2,a5,a2
    80006e54:	fcc692e3          	bne	a3,a2,80006e18 <__mem_free+0x6c>
    80006e58:	00813403          	ld	s0,8(sp)
    80006e5c:	0105053b          	addw	a0,a0,a6
    80006e60:	00a7a423          	sw	a0,8(a5)
    80006e64:	00e7b023          	sd	a4,0(a5)
    80006e68:	00f5b023          	sd	a5,0(a1)
    80006e6c:	00000513          	li	a0,0
    80006e70:	01010113          	addi	sp,sp,16
    80006e74:	00008067          	ret

0000000080006e78 <__mem_alloc>:
    80006e78:	fc010113          	addi	sp,sp,-64
    80006e7c:	02813823          	sd	s0,48(sp)
    80006e80:	02913423          	sd	s1,40(sp)
    80006e84:	03213023          	sd	s2,32(sp)
    80006e88:	01513423          	sd	s5,8(sp)
    80006e8c:	02113c23          	sd	ra,56(sp)
    80006e90:	01313c23          	sd	s3,24(sp)
    80006e94:	01413823          	sd	s4,16(sp)
    80006e98:	01613023          	sd	s6,0(sp)
    80006e9c:	04010413          	addi	s0,sp,64
    80006ea0:	00003a97          	auipc	s5,0x3
    80006ea4:	0c8a8a93          	addi	s5,s5,200 # 80009f68 <freep>
    80006ea8:	00f50913          	addi	s2,a0,15
    80006eac:	000ab683          	ld	a3,0(s5)
    80006eb0:	00495913          	srli	s2,s2,0x4
    80006eb4:	0019049b          	addiw	s1,s2,1
    80006eb8:	00048913          	mv	s2,s1
    80006ebc:	0c068c63          	beqz	a3,80006f94 <__mem_alloc+0x11c>
    80006ec0:	0006b503          	ld	a0,0(a3)
    80006ec4:	00852703          	lw	a4,8(a0)
    80006ec8:	10977063          	bgeu	a4,s1,80006fc8 <__mem_alloc+0x150>
    80006ecc:	000017b7          	lui	a5,0x1
    80006ed0:	0009099b          	sext.w	s3,s2
    80006ed4:	0af4e863          	bltu	s1,a5,80006f84 <__mem_alloc+0x10c>
    80006ed8:	02099a13          	slli	s4,s3,0x20
    80006edc:	01ca5a13          	srli	s4,s4,0x1c
    80006ee0:	fff00b13          	li	s6,-1
    80006ee4:	0100006f          	j	80006ef4 <__mem_alloc+0x7c>
    80006ee8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80006eec:	00852703          	lw	a4,8(a0)
    80006ef0:	04977463          	bgeu	a4,s1,80006f38 <__mem_alloc+0xc0>
    80006ef4:	00050793          	mv	a5,a0
    80006ef8:	fea698e3          	bne	a3,a0,80006ee8 <__mem_alloc+0x70>
    80006efc:	000a0513          	mv	a0,s4
    80006f00:	00000097          	auipc	ra,0x0
    80006f04:	1f0080e7          	jalr	496(ra) # 800070f0 <kvmincrease>
    80006f08:	00050793          	mv	a5,a0
    80006f0c:	01050513          	addi	a0,a0,16
    80006f10:	07678e63          	beq	a5,s6,80006f8c <__mem_alloc+0x114>
    80006f14:	0137a423          	sw	s3,8(a5)
    80006f18:	00000097          	auipc	ra,0x0
    80006f1c:	e94080e7          	jalr	-364(ra) # 80006dac <__mem_free>
    80006f20:	000ab783          	ld	a5,0(s5)
    80006f24:	06078463          	beqz	a5,80006f8c <__mem_alloc+0x114>
    80006f28:	0007b503          	ld	a0,0(a5)
    80006f2c:	00078693          	mv	a3,a5
    80006f30:	00852703          	lw	a4,8(a0)
    80006f34:	fc9760e3          	bltu	a4,s1,80006ef4 <__mem_alloc+0x7c>
    80006f38:	08e48263          	beq	s1,a4,80006fbc <__mem_alloc+0x144>
    80006f3c:	4127073b          	subw	a4,a4,s2
    80006f40:	02071693          	slli	a3,a4,0x20
    80006f44:	01c6d693          	srli	a3,a3,0x1c
    80006f48:	00e52423          	sw	a4,8(a0)
    80006f4c:	00d50533          	add	a0,a0,a3
    80006f50:	01252423          	sw	s2,8(a0)
    80006f54:	00fab023          	sd	a5,0(s5)
    80006f58:	01050513          	addi	a0,a0,16
    80006f5c:	03813083          	ld	ra,56(sp)
    80006f60:	03013403          	ld	s0,48(sp)
    80006f64:	02813483          	ld	s1,40(sp)
    80006f68:	02013903          	ld	s2,32(sp)
    80006f6c:	01813983          	ld	s3,24(sp)
    80006f70:	01013a03          	ld	s4,16(sp)
    80006f74:	00813a83          	ld	s5,8(sp)
    80006f78:	00013b03          	ld	s6,0(sp)
    80006f7c:	04010113          	addi	sp,sp,64
    80006f80:	00008067          	ret
    80006f84:	000019b7          	lui	s3,0x1
    80006f88:	f51ff06f          	j	80006ed8 <__mem_alloc+0x60>
    80006f8c:	00000513          	li	a0,0
    80006f90:	fcdff06f          	j	80006f5c <__mem_alloc+0xe4>
    80006f94:	00004797          	auipc	a5,0x4
    80006f98:	28c78793          	addi	a5,a5,652 # 8000b220 <base>
    80006f9c:	00078513          	mv	a0,a5
    80006fa0:	00fab023          	sd	a5,0(s5)
    80006fa4:	00f7b023          	sd	a5,0(a5)
    80006fa8:	00000713          	li	a4,0
    80006fac:	00004797          	auipc	a5,0x4
    80006fb0:	2607ae23          	sw	zero,636(a5) # 8000b228 <base+0x8>
    80006fb4:	00050693          	mv	a3,a0
    80006fb8:	f11ff06f          	j	80006ec8 <__mem_alloc+0x50>
    80006fbc:	00053703          	ld	a4,0(a0)
    80006fc0:	00e7b023          	sd	a4,0(a5)
    80006fc4:	f91ff06f          	j	80006f54 <__mem_alloc+0xdc>
    80006fc8:	00068793          	mv	a5,a3
    80006fcc:	f6dff06f          	j	80006f38 <__mem_alloc+0xc0>

0000000080006fd0 <__putc>:
    80006fd0:	fe010113          	addi	sp,sp,-32
    80006fd4:	00813823          	sd	s0,16(sp)
    80006fd8:	00113c23          	sd	ra,24(sp)
    80006fdc:	02010413          	addi	s0,sp,32
    80006fe0:	00050793          	mv	a5,a0
    80006fe4:	fef40593          	addi	a1,s0,-17
    80006fe8:	00100613          	li	a2,1
    80006fec:	00000513          	li	a0,0
    80006ff0:	fef407a3          	sb	a5,-17(s0)
    80006ff4:	fffff097          	auipc	ra,0xfffff
    80006ff8:	918080e7          	jalr	-1768(ra) # 8000590c <console_write>
    80006ffc:	01813083          	ld	ra,24(sp)
    80007000:	01013403          	ld	s0,16(sp)
    80007004:	02010113          	addi	sp,sp,32
    80007008:	00008067          	ret

000000008000700c <__getc>:
    8000700c:	fe010113          	addi	sp,sp,-32
    80007010:	00813823          	sd	s0,16(sp)
    80007014:	00113c23          	sd	ra,24(sp)
    80007018:	02010413          	addi	s0,sp,32
    8000701c:	fe840593          	addi	a1,s0,-24
    80007020:	00100613          	li	a2,1
    80007024:	00000513          	li	a0,0
    80007028:	fffff097          	auipc	ra,0xfffff
    8000702c:	8c4080e7          	jalr	-1852(ra) # 800058ec <console_read>
    80007030:	fe844503          	lbu	a0,-24(s0)
    80007034:	01813083          	ld	ra,24(sp)
    80007038:	01013403          	ld	s0,16(sp)
    8000703c:	02010113          	addi	sp,sp,32
    80007040:	00008067          	ret

0000000080007044 <console_handler>:
    80007044:	fe010113          	addi	sp,sp,-32
    80007048:	00813823          	sd	s0,16(sp)
    8000704c:	00113c23          	sd	ra,24(sp)
    80007050:	00913423          	sd	s1,8(sp)
    80007054:	02010413          	addi	s0,sp,32
    80007058:	14202773          	csrr	a4,scause
    8000705c:	100027f3          	csrr	a5,sstatus
    80007060:	0027f793          	andi	a5,a5,2
    80007064:	06079e63          	bnez	a5,800070e0 <console_handler+0x9c>
    80007068:	00074c63          	bltz	a4,80007080 <console_handler+0x3c>
    8000706c:	01813083          	ld	ra,24(sp)
    80007070:	01013403          	ld	s0,16(sp)
    80007074:	00813483          	ld	s1,8(sp)
    80007078:	02010113          	addi	sp,sp,32
    8000707c:	00008067          	ret
    80007080:	0ff77713          	andi	a4,a4,255
    80007084:	00900793          	li	a5,9
    80007088:	fef712e3          	bne	a4,a5,8000706c <console_handler+0x28>
    8000708c:	ffffe097          	auipc	ra,0xffffe
    80007090:	4b8080e7          	jalr	1208(ra) # 80005544 <plic_claim>
    80007094:	00a00793          	li	a5,10
    80007098:	00050493          	mv	s1,a0
    8000709c:	02f50c63          	beq	a0,a5,800070d4 <console_handler+0x90>
    800070a0:	fc0506e3          	beqz	a0,8000706c <console_handler+0x28>
    800070a4:	00050593          	mv	a1,a0
    800070a8:	00001517          	auipc	a0,0x1
    800070ac:	59050513          	addi	a0,a0,1424 # 80008638 <kvmincrease+0x1548>
    800070b0:	fffff097          	auipc	ra,0xfffff
    800070b4:	8d8080e7          	jalr	-1832(ra) # 80005988 <__printf>
    800070b8:	01013403          	ld	s0,16(sp)
    800070bc:	01813083          	ld	ra,24(sp)
    800070c0:	00048513          	mv	a0,s1
    800070c4:	00813483          	ld	s1,8(sp)
    800070c8:	02010113          	addi	sp,sp,32
    800070cc:	ffffe317          	auipc	t1,0xffffe
    800070d0:	4b030067          	jr	1200(t1) # 8000557c <plic_complete>
    800070d4:	fffff097          	auipc	ra,0xfffff
    800070d8:	1bc080e7          	jalr	444(ra) # 80006290 <uartintr>
    800070dc:	fddff06f          	j	800070b8 <console_handler+0x74>
    800070e0:	00001517          	auipc	a0,0x1
    800070e4:	65850513          	addi	a0,a0,1624 # 80008738 <digits+0x78>
    800070e8:	fffff097          	auipc	ra,0xfffff
    800070ec:	844080e7          	jalr	-1980(ra) # 8000592c <panic>

00000000800070f0 <kvmincrease>:
    800070f0:	fe010113          	addi	sp,sp,-32
    800070f4:	01213023          	sd	s2,0(sp)
    800070f8:	00001937          	lui	s2,0x1
    800070fc:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80007100:	00813823          	sd	s0,16(sp)
    80007104:	00113c23          	sd	ra,24(sp)
    80007108:	00913423          	sd	s1,8(sp)
    8000710c:	02010413          	addi	s0,sp,32
    80007110:	01250933          	add	s2,a0,s2
    80007114:	00c95913          	srli	s2,s2,0xc
    80007118:	02090863          	beqz	s2,80007148 <kvmincrease+0x58>
    8000711c:	00000493          	li	s1,0
    80007120:	00148493          	addi	s1,s1,1
    80007124:	fffff097          	auipc	ra,0xfffff
    80007128:	4bc080e7          	jalr	1212(ra) # 800065e0 <kalloc>
    8000712c:	fe991ae3          	bne	s2,s1,80007120 <kvmincrease+0x30>
    80007130:	01813083          	ld	ra,24(sp)
    80007134:	01013403          	ld	s0,16(sp)
    80007138:	00813483          	ld	s1,8(sp)
    8000713c:	00013903          	ld	s2,0(sp)
    80007140:	02010113          	addi	sp,sp,32
    80007144:	00008067          	ret
    80007148:	01813083          	ld	ra,24(sp)
    8000714c:	01013403          	ld	s0,16(sp)
    80007150:	00813483          	ld	s1,8(sp)
    80007154:	00013903          	ld	s2,0(sp)
    80007158:	00000513          	li	a0,0
    8000715c:	02010113          	addi	sp,sp,32
    80007160:	00008067          	ret
	...
