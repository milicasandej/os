
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	f6813103          	ld	sp,-152(sp) # 80009f68 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	545040ef          	jal	ra,80004d60 <start>

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
    800010a4:	239000ef          	jal	ra,80001adc <_ZN5Riscv20handleSupervisorTrapEv>


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
    8000134c:	774080e7          	jalr	1908(ra) # 80001abc <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) thread_dispatch();
    80001350:	00009797          	auipc	a5,0x9
    80001354:	c707b783          	ld	a5,-912(a5) # 80009fc0 <_ZN7_thread7runningE>

    static int exitThread();

    void setStart(bool b);

    bool isStarted() const { return started; }
    80001358:	0297c783          	lbu	a5,41(a5)
    8000135c:	00079863          	bnez	a5,8000136c <_ZN7_thread13threadWrapperEv+0x34>
    80001360:	00000097          	auipc	ra,0x0
    80001364:	eb4080e7          	jalr	-332(ra) # 80001214 <_Z15thread_dispatchv>
    80001368:	fe9ff06f          	j	80001350 <_ZN7_thread13threadWrapperEv+0x18>
    userMode();
    8000136c:	00000097          	auipc	ra,0x0
    80001370:	dd8080e7          	jalr	-552(ra) # 80001144 <_Z8userModev>
    running->body(running->args);
    80001374:	00009797          	auipc	a5,0x9
    80001378:	c4c7b783          	ld	a5,-948(a5) # 80009fc0 <_ZN7_thread7runningE>
    8000137c:	0007b703          	ld	a4,0(a5)
    80001380:	0087b503          	ld	a0,8(a5)
    80001384:	000700e7          	jalr	a4
    thread_exit();
    80001388:	00000097          	auipc	ra,0x0
    8000138c:	e60080e7          	jalr	-416(ra) # 800011e8 <_Z11thread_exitv>
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
    800013cc:	368080e7          	jalr	872(ra) # 80001730 <_Znwm>
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
    800013e8:	374080e7          	jalr	884(ra) # 80001758 <_Znam>
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
    80001430:	bd0080e7          	jalr	-1072(ra) # 80001ffc <_ZN9Scheduler3putEP7_thread>
    80001434:	0280006f          	j	8000145c <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001438:	00000793          	li	a5,0
    8000143c:	fd5ff06f          	j	80001410 <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    80001440:	00050913          	mv	s2,a0
    80001444:	00048513          	mv	a0,s1
    80001448:	00000097          	auipc	ra,0x0
    8000144c:	338080e7          	jalr	824(ra) # 80001780 <_ZdlPv>
    80001450:	00090513          	mv	a0,s2
    80001454:	0000a097          	auipc	ra,0xa
    80001458:	c84080e7          	jalr	-892(ra) # 8000b0d8 <_Unwind_Resume>
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
    80001494:	b304b483          	ld	s1,-1232(s1) # 80009fc0 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001498:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    8000149c:	00079663          	bnez	a5,800014a8 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    800014a0:	02a4c783          	lbu	a5,42(s1)
    800014a4:	04078263          	beqz	a5,800014e8 <_ZN7_thread8dispatchEv+0x6c>
    running = Scheduler::get();
    800014a8:	00001097          	auipc	ra,0x1
    800014ac:	aec080e7          	jalr	-1300(ra) # 80001f94 <_ZN9Scheduler3getEv>
    800014b0:	00009797          	auipc	a5,0x9
    800014b4:	b0a7b823          	sd	a0,-1264(a5) # 80009fc0 <_ZN7_thread7runningE>
    if (running == nullptr) {
    800014b8:	04050063          	beqz	a0,800014f8 <_ZN7_thread8dispatchEv+0x7c>
    _thread::contextSwitch(&old->context, &running->context);
    800014bc:	00009597          	auipc	a1,0x9
    800014c0:	b045b583          	ld	a1,-1276(a1) # 80009fc0 <_ZN7_thread7runningE>
    800014c4:	01858593          	addi	a1,a1,24
    800014c8:	01848513          	addi	a0,s1,24
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	c64080e7          	jalr	-924(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800014d4:	01813083          	ld	ra,24(sp)
    800014d8:	01013403          	ld	s0,16(sp)
    800014dc:	00813483          	ld	s1,8(sp)
    800014e0:	02010113          	addi	sp,sp,32
    800014e4:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    800014e8:	00048513          	mv	a0,s1
    800014ec:	00001097          	auipc	ra,0x1
    800014f0:	b10080e7          	jalr	-1264(ra) # 80001ffc <_ZN9Scheduler3putEP7_thread>
    800014f4:	fb5ff06f          	j	800014a8 <_ZN7_thread8dispatchEv+0x2c>
        printString("vratili smo null\n");
    800014f8:	00007517          	auipc	a0,0x7
    800014fc:	b0850513          	addi	a0,a0,-1272 # 80008000 <kvmincrease+0xea0>
    80001500:	00003097          	auipc	ra,0x3
    80001504:	890080e7          	jalr	-1904(ra) # 80003d90 <_Z11printStringPKc>
    80001508:	fb5ff06f          	j	800014bc <_ZN7_thread8dispatchEv+0x40>

000000008000150c <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    8000150c:	ff010113          	addi	sp,sp,-16
    80001510:	00113423          	sd	ra,8(sp)
    80001514:	00813023          	sd	s0,0(sp)
    80001518:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    8000151c:	00009797          	auipc	a5,0x9
    80001520:	aa47b783          	ld	a5,-1372(a5) # 80009fc0 <_ZN7_thread7runningE>
    80001524:	00100713          	li	a4,1
    80001528:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    8000152c:	00000097          	auipc	ra,0x0
    80001530:	ce8080e7          	jalr	-792(ra) # 80001214 <_Z15thread_dispatchv>
    return 0;
}
    80001534:	00000513          	li	a0,0
    80001538:	00813083          	ld	ra,8(sp)
    8000153c:	00013403          	ld	s0,0(sp)
    80001540:	01010113          	addi	sp,sp,16
    80001544:	00008067          	ret

0000000080001548 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001548:	ff010113          	addi	sp,sp,-16
    8000154c:	00813423          	sd	s0,8(sp)
    80001550:	01010413          	addi	s0,sp,16
    this->started = b;
    80001554:	02b504a3          	sb	a1,41(a0)
}
    80001558:	00813403          	ld	s0,8(sp)
    8000155c:	01010113          	addi	sp,sp,16
    80001560:	00008067          	ret

0000000080001564 <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    80001564:	ff010113          	addi	sp,sp,-16
    80001568:	00813423          	sd	s0,8(sp)
    8000156c:	01010413          	addi	s0,sp,16
    this->blocked = b;
    80001570:	02b50523          	sb	a1,42(a0)
}
    80001574:	00813403          	ld	s0,8(sp)
    80001578:	01010113          	addi	sp,sp,16
    8000157c:	00008067          	ret

0000000080001580 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001580:	fe010113          	addi	sp,sp,-32
    80001584:	00113c23          	sd	ra,24(sp)
    80001588:	00813823          	sd	s0,16(sp)
    8000158c:	00913423          	sd	s1,8(sp)
    80001590:	01213023          	sd	s2,0(sp)
    80001594:	02010413          	addi	s0,sp,32


    printString("Unesite broj testa? [1-7]\n");
    80001598:	00007517          	auipc	a0,0x7
    8000159c:	a8050513          	addi	a0,a0,-1408 # 80008018 <kvmincrease+0xeb8>
    800015a0:	00002097          	auipc	ra,0x2
    800015a4:	7f0080e7          	jalr	2032(ra) # 80003d90 <_Z11printStringPKc>
    int test = getc() - '0';
    800015a8:	00000097          	auipc	ra,0x0
    800015ac:	d40080e7          	jalr	-704(ra) # 800012e8 <_Z4getcv>
    800015b0:	00050913          	mv	s2,a0
    800015b4:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800015b8:	00000097          	auipc	ra,0x0
    800015bc:	d30080e7          	jalr	-720(ra) # 800012e8 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800015c0:	fcb9091b          	addiw	s2,s2,-53
    800015c4:	00100793          	li	a5,1
    800015c8:	0327f463          	bgeu	a5,s2,800015f0 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800015cc:	00700793          	li	a5,7
    800015d0:	0e97e263          	bltu	a5,s1,800016b4 <_Z8userMainv+0x134>
    800015d4:	00249493          	slli	s1,s1,0x2
    800015d8:	00007717          	auipc	a4,0x7
    800015dc:	c5870713          	addi	a4,a4,-936 # 80008230 <kvmincrease+0x10d0>
    800015e0:	00e484b3          	add	s1,s1,a4
    800015e4:	0004a783          	lw	a5,0(s1)
    800015e8:	00e787b3          	add	a5,a5,a4
    800015ec:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015f0:	00007517          	auipc	a0,0x7
    800015f4:	a4850513          	addi	a0,a0,-1464 # 80008038 <kvmincrease+0xed8>
    800015f8:	00002097          	auipc	ra,0x2
    800015fc:	798080e7          	jalr	1944(ra) # 80003d90 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80001600:	01813083          	ld	ra,24(sp)
    80001604:	01013403          	ld	s0,16(sp)
    80001608:	00813483          	ld	s1,8(sp)
    8000160c:	00013903          	ld	s2,0(sp)
    80001610:	02010113          	addi	sp,sp,32
    80001614:	00008067          	ret
            Threads_C_API_test();
    80001618:	00002097          	auipc	ra,0x2
    8000161c:	df0080e7          	jalr	-528(ra) # 80003408 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001620:	00007517          	auipc	a0,0x7
    80001624:	a4850513          	addi	a0,a0,-1464 # 80008068 <kvmincrease+0xf08>
    80001628:	00002097          	auipc	ra,0x2
    8000162c:	768080e7          	jalr	1896(ra) # 80003d90 <_Z11printStringPKc>
            break;
    80001630:	fd1ff06f          	j	80001600 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001634:	00001097          	auipc	ra,0x1
    80001638:	438080e7          	jalr	1080(ra) # 80002a6c <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000163c:	00007517          	auipc	a0,0x7
    80001640:	a6c50513          	addi	a0,a0,-1428 # 800080a8 <kvmincrease+0xf48>
    80001644:	00002097          	auipc	ra,0x2
    80001648:	74c080e7          	jalr	1868(ra) # 80003d90 <_Z11printStringPKc>
            break;
    8000164c:	fb5ff06f          	j	80001600 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001650:	00001097          	auipc	ra,0x1
    80001654:	c70080e7          	jalr	-912(ra) # 800022c0 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001658:	00007517          	auipc	a0,0x7
    8000165c:	a9050513          	addi	a0,a0,-1392 # 800080e8 <kvmincrease+0xf88>
    80001660:	00002097          	auipc	ra,0x2
    80001664:	730080e7          	jalr	1840(ra) # 80003d90 <_Z11printStringPKc>
            break;
    80001668:	f99ff06f          	j	80001600 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    8000166c:	00002097          	auipc	ra,0x2
    80001670:	0e0080e7          	jalr	224(ra) # 8000374c <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001674:	00007517          	auipc	a0,0x7
    80001678:	ac450513          	addi	a0,a0,-1340 # 80008138 <kvmincrease+0xfd8>
    8000167c:	00002097          	auipc	ra,0x2
    80001680:	714080e7          	jalr	1812(ra) # 80003d90 <_Z11printStringPKc>
            break;
    80001684:	f7dff06f          	j	80001600 <_Z8userMainv+0x80>
            System_Mode_test();
    80001688:	00003097          	auipc	ra,0x3
    8000168c:	2bc080e7          	jalr	700(ra) # 80004944 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80001690:	00007517          	auipc	a0,0x7
    80001694:	b0050513          	addi	a0,a0,-1280 # 80008190 <kvmincrease+0x1030>
    80001698:	00002097          	auipc	ra,0x2
    8000169c:	6f8080e7          	jalr	1784(ra) # 80003d90 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800016a0:	00007517          	auipc	a0,0x7
    800016a4:	b1050513          	addi	a0,a0,-1264 # 800081b0 <kvmincrease+0x1050>
    800016a8:	00002097          	auipc	ra,0x2
    800016ac:	6e8080e7          	jalr	1768(ra) # 80003d90 <_Z11printStringPKc>
            break;
    800016b0:	f51ff06f          	j	80001600 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    800016b4:	00007517          	auipc	a0,0x7
    800016b8:	b5450513          	addi	a0,a0,-1196 # 80008208 <kvmincrease+0x10a8>
    800016bc:	00002097          	auipc	ra,0x2
    800016c0:	6d4080e7          	jalr	1748(ra) # 80003d90 <_Z11printStringPKc>
    800016c4:	f3dff06f          	j	80001600 <_Z8userMainv+0x80>

00000000800016c8 <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    800016c8:	fe010113          	addi	sp,sp,-32
    800016cc:	00113c23          	sd	ra,24(sp)
    800016d0:	00813823          	sd	s0,16(sp)
    800016d4:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800016d8:	00009797          	auipc	a5,0x9
    800016dc:	8887b783          	ld	a5,-1912(a5) # 80009f60 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800016e0:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    800016e4:	00000613          	li	a2,0
    800016e8:	00000593          	li	a1,0
    800016ec:	fe840513          	addi	a0,s0,-24
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	acc080e7          	jalr	-1332(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    800016f8:	00009797          	auipc	a5,0x9
    800016fc:	8607b783          	ld	a5,-1952(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001700:	fe843703          	ld	a4,-24(s0)
    80001704:	00e7b023          	sd	a4,0(a5)

    //userMode();

    userMain();
    80001708:	00000097          	auipc	ra,0x0
    8000170c:	e78080e7          	jalr	-392(ra) # 80001580 <_Z8userMainv>
    printString("Finished\n");
    80001710:	00007517          	auipc	a0,0x7
    80001714:	b4050513          	addi	a0,a0,-1216 # 80008250 <kvmincrease+0x10f0>
    80001718:	00002097          	auipc	ra,0x2
    8000171c:	678080e7          	jalr	1656(ra) # 80003d90 <_Z11printStringPKc>
}
    80001720:	01813083          	ld	ra,24(sp)
    80001724:	01013403          	ld	s0,16(sp)
    80001728:	02010113          	addi	sp,sp,32
    8000172c:	00008067          	ret

0000000080001730 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001730:	ff010113          	addi	sp,sp,-16
    80001734:	00113423          	sd	ra,8(sp)
    80001738:	00813023          	sd	s0,0(sp)
    8000173c:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001740:	00000097          	auipc	ra,0x0
    80001744:	a28080e7          	jalr	-1496(ra) # 80001168 <_Z9mem_allocm>
}
    80001748:	00813083          	ld	ra,8(sp)
    8000174c:	00013403          	ld	s0,0(sp)
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret

0000000080001758 <_Znam>:

void *operator new[](size_t n)
{
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00113423          	sd	ra,8(sp)
    80001760:	00813023          	sd	s0,0(sp)
    80001764:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001768:	00000097          	auipc	ra,0x0
    8000176c:	a00080e7          	jalr	-1536(ra) # 80001168 <_Z9mem_allocm>
}
    80001770:	00813083          	ld	ra,8(sp)
    80001774:	00013403          	ld	s0,0(sp)
    80001778:	01010113          	addi	sp,sp,16
    8000177c:	00008067          	ret

0000000080001780 <_ZdlPv>:

void operator delete(void *p)
{
    80001780:	ff010113          	addi	sp,sp,-16
    80001784:	00113423          	sd	ra,8(sp)
    80001788:	00813023          	sd	s0,0(sp)
    8000178c:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001790:	00000097          	auipc	ra,0x0
    80001794:	a00080e7          	jalr	-1536(ra) # 80001190 <_Z8mem_freePv>
}
    80001798:	00813083          	ld	ra,8(sp)
    8000179c:	00013403          	ld	s0,0(sp)
    800017a0:	01010113          	addi	sp,sp,16
    800017a4:	00008067          	ret

00000000800017a8 <_ZdaPv>:

void operator delete[](void *p)
{
    800017a8:	ff010113          	addi	sp,sp,-16
    800017ac:	00113423          	sd	ra,8(sp)
    800017b0:	00813023          	sd	s0,0(sp)
    800017b4:	01010413          	addi	s0,sp,16
    mem_free(p);
    800017b8:	00000097          	auipc	ra,0x0
    800017bc:	9d8080e7          	jalr	-1576(ra) # 80001190 <_Z8mem_freePv>
}
    800017c0:	00813083          	ld	ra,8(sp)
    800017c4:	00013403          	ld	s0,0(sp)
    800017c8:	01010113          	addi	sp,sp,16
    800017cc:	00008067          	ret

00000000800017d0 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    800017d0:	ff010113          	addi	sp,sp,-16
    800017d4:	00813423          	sd	s0,8(sp)
    800017d8:	01010413          	addi	s0,sp,16

}
    800017dc:	00813403          	ld	s0,8(sp)
    800017e0:	01010113          	addi	sp,sp,16
    800017e4:	00008067          	ret

00000000800017e8 <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    800017e8:	ff010113          	addi	sp,sp,-16
    800017ec:	00113423          	sd	ra,8(sp)
    800017f0:	00813023          	sd	s0,0(sp)
    800017f4:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    800017f8:	00053783          	ld	a5,0(a0)
    800017fc:	0107b783          	ld	a5,16(a5)
    80001800:	000780e7          	jalr	a5
}
    80001804:	00813083          	ld	ra,8(sp)
    80001808:	00013403          	ld	s0,0(sp)
    8000180c:	01010113          	addi	sp,sp,16
    80001810:	00008067          	ret

0000000080001814 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001814:	ff010113          	addi	sp,sp,-16
    80001818:	00113423          	sd	ra,8(sp)
    8000181c:	00813023          	sd	s0,0(sp)
    80001820:	01010413          	addi	s0,sp,16
}
    80001824:	00000097          	auipc	ra,0x0
    80001828:	f5c080e7          	jalr	-164(ra) # 80001780 <_ZdlPv>
    8000182c:	00813083          	ld	ra,8(sp)
    80001830:	00013403          	ld	s0,0(sp)
    80001834:	01010113          	addi	sp,sp,16
    80001838:	00008067          	ret

000000008000183c <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    8000183c:	ff010113          	addi	sp,sp,-16
    80001840:	00113423          	sd	ra,8(sp)
    80001844:	00813023          	sd	s0,0(sp)
    80001848:	01010413          	addi	s0,sp,16
    8000184c:	00008797          	auipc	a5,0x8
    80001850:	5c478793          	addi	a5,a5,1476 # 80009e10 <_ZTV9Semaphore+0x10>
    80001854:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80001858:	00853503          	ld	a0,8(a0)
    8000185c:	00000097          	auipc	ra,0x0
    80001860:	a08080e7          	jalr	-1528(ra) # 80001264 <_Z9sem_closeP4_sem>

}
    80001864:	00813083          	ld	ra,8(sp)
    80001868:	00013403          	ld	s0,0(sp)
    8000186c:	01010113          	addi	sp,sp,16
    80001870:	00008067          	ret

0000000080001874 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001874:	fe010113          	addi	sp,sp,-32
    80001878:	00113c23          	sd	ra,24(sp)
    8000187c:	00813823          	sd	s0,16(sp)
    80001880:	00913423          	sd	s1,8(sp)
    80001884:	02010413          	addi	s0,sp,32
    80001888:	00050493          	mv	s1,a0
}
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	fb0080e7          	jalr	-80(ra) # 8000183c <_ZN9SemaphoreD1Ev>
    80001894:	00048513          	mv	a0,s1
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	ee8080e7          	jalr	-280(ra) # 80001780 <_ZdlPv>
    800018a0:	01813083          	ld	ra,24(sp)
    800018a4:	01013403          	ld	s0,16(sp)
    800018a8:	00813483          	ld	s1,8(sp)
    800018ac:	02010113          	addi	sp,sp,32
    800018b0:	00008067          	ret

00000000800018b4 <_ZN7Console4getcEv>:
char Console::getc() {
    800018b4:	ff010113          	addi	sp,sp,-16
    800018b8:	00113423          	sd	ra,8(sp)
    800018bc:	00813023          	sd	s0,0(sp)
    800018c0:	01010413          	addi	s0,sp,16
    return __getc();
    800018c4:	00005097          	auipc	ra,0x5
    800018c8:	7b8080e7          	jalr	1976(ra) # 8000707c <__getc>
}
    800018cc:	00813083          	ld	ra,8(sp)
    800018d0:	00013403          	ld	s0,0(sp)
    800018d4:	01010113          	addi	sp,sp,16
    800018d8:	00008067          	ret

00000000800018dc <_ZN7Console4putcEc>:
void Console::putc(char c) {
    800018dc:	ff010113          	addi	sp,sp,-16
    800018e0:	00113423          	sd	ra,8(sp)
    800018e4:	00813023          	sd	s0,0(sp)
    800018e8:	01010413          	addi	s0,sp,16
    __putc(c);
    800018ec:	00005097          	auipc	ra,0x5
    800018f0:	754080e7          	jalr	1876(ra) # 80007040 <__putc>
}
    800018f4:	00813083          	ld	ra,8(sp)
    800018f8:	00013403          	ld	s0,0(sp)
    800018fc:	01010113          	addi	sp,sp,16
    80001900:	00008067          	ret

0000000080001904 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001904:	fe010113          	addi	sp,sp,-32
    80001908:	00113c23          	sd	ra,24(sp)
    8000190c:	00813823          	sd	s0,16(sp)
    80001910:	00913423          	sd	s1,8(sp)
    80001914:	02010413          	addi	s0,sp,32
    80001918:	00050493          	mv	s1,a0
    8000191c:	00008797          	auipc	a5,0x8
    80001920:	4cc78793          	addi	a5,a5,1228 # 80009de8 <_ZTV6Thread+0x10>
    80001924:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    80001928:	00850513          	addi	a0,a0,8
    8000192c:	00000097          	auipc	ra,0x0
    80001930:	890080e7          	jalr	-1904(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001934:	00000593          	li	a1,0
    80001938:	0084b503          	ld	a0,8(s1)
    8000193c:	00000097          	auipc	ra,0x0
    80001940:	c0c080e7          	jalr	-1012(ra) # 80001548 <_ZN7_thread8setStartEb>
}
    80001944:	01813083          	ld	ra,24(sp)
    80001948:	01013403          	ld	s0,16(sp)
    8000194c:	00813483          	ld	s1,8(sp)
    80001950:	02010113          	addi	sp,sp,32
    80001954:	00008067          	ret

0000000080001958 <_ZN6Thread5startEv>:
int Thread::start() {
    80001958:	ff010113          	addi	sp,sp,-16
    8000195c:	00113423          	sd	ra,8(sp)
    80001960:	00813023          	sd	s0,0(sp)
    80001964:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001968:	00100593          	li	a1,1
    8000196c:	00853503          	ld	a0,8(a0)
    80001970:	00000097          	auipc	ra,0x0
    80001974:	bd8080e7          	jalr	-1064(ra) # 80001548 <_ZN7_thread8setStartEb>
}
    80001978:	00000513          	li	a0,0
    8000197c:	00813083          	ld	ra,8(sp)
    80001980:	00013403          	ld	s0,0(sp)
    80001984:	01010113          	addi	sp,sp,16
    80001988:	00008067          	ret

000000008000198c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000198c:	ff010113          	addi	sp,sp,-16
    80001990:	00113423          	sd	ra,8(sp)
    80001994:	00813023          	sd	s0,0(sp)
    80001998:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	878080e7          	jalr	-1928(ra) # 80001214 <_Z15thread_dispatchv>
}
    800019a4:	00813083          	ld	ra,8(sp)
    800019a8:	00013403          	ld	s0,0(sp)
    800019ac:	01010113          	addi	sp,sp,16
    800019b0:	00008067          	ret

00000000800019b4 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800019b4:	fe010113          	addi	sp,sp,-32
    800019b8:	00113c23          	sd	ra,24(sp)
    800019bc:	00813823          	sd	s0,16(sp)
    800019c0:	00913423          	sd	s1,8(sp)
    800019c4:	02010413          	addi	s0,sp,32
    800019c8:	00050493          	mv	s1,a0
    800019cc:	00008797          	auipc	a5,0x8
    800019d0:	41c78793          	addi	a5,a5,1052 # 80009de8 <_ZTV6Thread+0x10>
    800019d4:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    800019d8:	00050613          	mv	a2,a0
    800019dc:	00000597          	auipc	a1,0x0
    800019e0:	e0c58593          	addi	a1,a1,-500 # 800017e8 <_ZN6Thread12startWrapperEPv>
    800019e4:	00850513          	addi	a0,a0,8
    800019e8:	fffff097          	auipc	ra,0xfffff
    800019ec:	7d4080e7          	jalr	2004(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800019f0:	00000593          	li	a1,0
    800019f4:	0084b503          	ld	a0,8(s1)
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	b50080e7          	jalr	-1200(ra) # 80001548 <_ZN7_thread8setStartEb>
}
    80001a00:	01813083          	ld	ra,24(sp)
    80001a04:	01013403          	ld	s0,16(sp)
    80001a08:	00813483          	ld	s1,8(sp)
    80001a0c:	02010113          	addi	sp,sp,32
    80001a10:	00008067          	ret

0000000080001a14 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80001a14:	ff010113          	addi	sp,sp,-16
    80001a18:	00113423          	sd	ra,8(sp)
    80001a1c:	00813023          	sd	s0,0(sp)
    80001a20:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001a24:	00853503          	ld	a0,8(a0)
    80001a28:	00000097          	auipc	ra,0x0
    80001a2c:	868080e7          	jalr	-1944(ra) # 80001290 <_Z8sem_waitP4_sem>
}
    80001a30:	00813083          	ld	ra,8(sp)
    80001a34:	00013403          	ld	s0,0(sp)
    80001a38:	01010113          	addi	sp,sp,16
    80001a3c:	00008067          	ret

0000000080001a40 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001a40:	ff010113          	addi	sp,sp,-16
    80001a44:	00113423          	sd	ra,8(sp)
    80001a48:	00813023          	sd	s0,0(sp)
    80001a4c:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001a50:	00853503          	ld	a0,8(a0)
    80001a54:	00000097          	auipc	ra,0x0
    80001a58:	868080e7          	jalr	-1944(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    80001a5c:	00813083          	ld	ra,8(sp)
    80001a60:	00013403          	ld	s0,0(sp)
    80001a64:	01010113          	addi	sp,sp,16
    80001a68:	00008067          	ret

0000000080001a6c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001a6c:	ff010113          	addi	sp,sp,-16
    80001a70:	00113423          	sd	ra,8(sp)
    80001a74:	00813023          	sd	s0,0(sp)
    80001a78:	01010413          	addi	s0,sp,16
    80001a7c:	00008797          	auipc	a5,0x8
    80001a80:	39478793          	addi	a5,a5,916 # 80009e10 <_ZTV9Semaphore+0x10>
    80001a84:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001a88:	00850513          	addi	a0,a0,8
    80001a8c:	fffff097          	auipc	ra,0xfffff
    80001a90:	7ac080e7          	jalr	1964(ra) # 80001238 <_Z8sem_openPP4_semj>
}
    80001a94:	00813083          	ld	ra,8(sp)
    80001a98:	00013403          	ld	s0,0(sp)
    80001a9c:	01010113          	addi	sp,sp,16
    80001aa0:	00008067          	ret

0000000080001aa4 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001aa4:	ff010113          	addi	sp,sp,-16
    80001aa8:	00813423          	sd	s0,8(sp)
    80001aac:	01010413          	addi	s0,sp,16
    80001ab0:	00813403          	ld	s0,8(sp)
    80001ab4:	01010113          	addi	sp,sp,16
    80001ab8:	00008067          	ret

0000000080001abc <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001abc:	ff010113          	addi	sp,sp,-16
    80001ac0:	00813423          	sd	s0,8(sp)
    80001ac4:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001ac8:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001acc:	10200073          	sret

}
    80001ad0:	00813403          	ld	s0,8(sp)
    80001ad4:	01010113          	addi	sp,sp,16
    80001ad8:	00008067          	ret

0000000080001adc <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001adc:	fb010113          	addi	sp,sp,-80
    80001ae0:	04113423          	sd	ra,72(sp)
    80001ae4:	04813023          	sd	s0,64(sp)
    80001ae8:	02913c23          	sd	s1,56(sp)
    80001aec:	03213823          	sd	s2,48(sp)
    80001af0:	03313423          	sd	s3,40(sp)
    80001af4:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001af8:	142027f3          	csrr	a5,scause
    80001afc:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80001b00:	fb843483          	ld	s1,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001b04:	fff00793          	li	a5,-1
    80001b08:	03f79793          	slli	a5,a5,0x3f
    80001b0c:	00178793          	addi	a5,a5,1
    80001b10:	18f48463          	beq	s1,a5,80001c98 <_ZN5Riscv20handleSupervisorTrapEv+0x1bc>
    80001b14:	fff00793          	li	a5,-1
    80001b18:	03f79793          	slli	a5,a5,0x3f
    80001b1c:	00178793          	addi	a5,a5,1
    80001b20:	0497ea63          	bltu	a5,s1,80001b74 <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    80001b24:	ff848793          	addi	a5,s1,-8
    80001b28:	00100713          	li	a4,1
    80001b2c:	18f76863          	bltu	a4,a5,80001cbc <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001b30:	141027f3          	csrr	a5,sepc
    80001b34:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80001b38:	fc843783          	ld	a5,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    80001b3c:	00478493          	addi	s1,a5,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001b40:	100027f3          	csrr	a5,sstatus
    80001b44:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    80001b48:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001b4c:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001b50:	04200713          	li	a4,66
    80001b54:	06f76063          	bltu	a4,a5,80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
    80001b58:	00279793          	slli	a5,a5,0x2
    80001b5c:	00006717          	auipc	a4,0x6
    80001b60:	71070713          	addi	a4,a4,1808 # 8000826c <kvmincrease+0x110c>
    80001b64:	00e787b3          	add	a5,a5,a4
    80001b68:	0007a783          	lw	a5,0(a5)
    80001b6c:	00e787b3          	add	a5,a5,a4
    80001b70:	00078067          	jr	a5
    switch((uint64)scause){
    80001b74:	fff00793          	li	a5,-1
    80001b78:	03f79793          	slli	a5,a5,0x3f
    80001b7c:	00978793          	addi	a5,a5,9
    80001b80:	12f49e63          	bne	s1,a5,80001cbc <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001b84:	00005097          	auipc	ra,0x5
    80001b88:	530080e7          	jalr	1328(ra) # 800070b4 <console_handler>
            break;
    80001b8c:	1140006f          	j	80001ca0 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001b90:	10000793          	li	a5,256
    80001b94:	1007b073          	csrc	sstatus,a5
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001b98:	00200793          	li	a5,2
    80001b9c:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001ba0:	14149073          	csrw	sepc,s1
}
    80001ba4:	0fc0006f          	j	80001ca0 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
                    READ_REG(size, "a0");
    80001ba8:	00050513          	mv	a0,a0
                    __mem_alloc(size);
    80001bac:	00005097          	auipc	ra,0x5
    80001bb0:	33c080e7          	jalr	828(ra) # 80006ee8 <__mem_alloc>
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001bb4:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001bb8:	14149073          	csrw	sepc,s1
}
    80001bbc:	0e40006f          	j	80001ca0 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
                    READ_REG(ptr, "a0");
    80001bc0:	00050513          	mv	a0,a0
                    __mem_free(ptr);
    80001bc4:	00005097          	auipc	ra,0x5
    80001bc8:	258080e7          	jalr	600(ra) # 80006e1c <__mem_free>
                    break;
    80001bcc:	fe9ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(handle, "a0");
    80001bd0:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001bd4:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001bd8:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001bdc:	fffff097          	auipc	ra,0xfffff
    80001be0:	7c4080e7          	jalr	1988(ra) # 800013a0 <_ZN7_thread12createThreadEPFvPvES0_>
    80001be4:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001be8:	00050863          	beqz	a0,80001bf8 <_ZN5Riscv20handleSupervisorTrapEv+0x11c>
    80001bec:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001bf0:	00078513          	mv	a0,a5
                    break;
    80001bf4:	fc1ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    else ret = -1;
    80001bf8:	fff00793          	li	a5,-1
    80001bfc:	ff5ff06f          	j	80001bf0 <_ZN5Riscv20handleSupervisorTrapEv+0x114>
                    _thread::exitThread();
    80001c00:	00000097          	auipc	ra,0x0
    80001c04:	90c080e7          	jalr	-1780(ra) # 8000150c <_ZN7_thread10exitThreadEv>
                    break;
    80001c08:	fadff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    _thread::dispatch();
    80001c0c:	00000097          	auipc	ra,0x0
    80001c10:	870080e7          	jalr	-1936(ra) # 8000147c <_ZN7_thread8dispatchEv>
                    break;
    80001c14:	fa1ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(handle, "a0");
    80001c18:	00050993          	mv	s3,a0
                    READ_REG(init, "a1");
    80001c1c:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001c20:	0005051b          	sext.w	a0,a0
    80001c24:	00000097          	auipc	ra,0x0
    80001c28:	230080e7          	jalr	560(ra) # 80001e54 <_ZN4_sem15createSemaphoreEj>
    80001c2c:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001c30:	00050863          	beqz	a0,80001c40 <_ZN5Riscv20handleSupervisorTrapEv+0x164>
    80001c34:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001c38:	00078513          	mv	a0,a5
                    break;
    80001c3c:	f79ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    else ret = -1;
    80001c40:	fff00793          	li	a5,-1
    80001c44:	ff5ff06f          	j	80001c38 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>
                    READ_REG(handleClose, "a0");
    80001c48:	00050513          	mv	a0,a0
                    handleClose->close();
    80001c4c:	00000097          	auipc	ra,0x0
    80001c50:	270080e7          	jalr	624(ra) # 80001ebc <_ZN4_sem5closeEv>
                    break;
    80001c54:	f61ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(idWait, "a0");
    80001c58:	00050513          	mv	a0,a0
                    idWait->wait();
    80001c5c:	00000097          	auipc	ra,0x0
    80001c60:	090080e7          	jalr	144(ra) # 80001cec <_ZN4_sem4waitEv>
                    break;
    80001c64:	f51ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(idSignal, "a0");
    80001c68:	00050513          	mv	a0,a0
                    idSignal->signal();
    80001c6c:	00000097          	auipc	ra,0x0
    80001c70:	134080e7          	jalr	308(ra) # 80001da0 <_ZN4_sem6signalEv>
                    break;
    80001c74:	f41ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    __getc();
    80001c78:	00005097          	auipc	ra,0x5
    80001c7c:	404080e7          	jalr	1028(ra) # 8000707c <__getc>
                    break;
    80001c80:	f35ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
                    READ_REG(c, "a0");
    80001c84:	00050513          	mv	a0,a0
                    __putc(c);
    80001c88:	0ff57513          	andi	a0,a0,255
    80001c8c:	00005097          	auipc	ra,0x5
    80001c90:	3b4080e7          	jalr	948(ra) # 80007040 <__putc>
                    break;
    80001c94:	f21ff06f          	j	80001bb4 <_ZN5Riscv20handleSupervisorTrapEv+0xd8>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001c98:	00200793          	li	a5,2
    80001c9c:	1447b073          	csrc	sip,a5
            printString("\nScause: ");
            printInt(scause);
            thread_exit();
            break;
    }
    80001ca0:	04813083          	ld	ra,72(sp)
    80001ca4:	04013403          	ld	s0,64(sp)
    80001ca8:	03813483          	ld	s1,56(sp)
    80001cac:	03013903          	ld	s2,48(sp)
    80001cb0:	02813983          	ld	s3,40(sp)
    80001cb4:	05010113          	addi	sp,sp,80
    80001cb8:	00008067          	ret
            printString("\nScause: ");
    80001cbc:	00006517          	auipc	a0,0x6
    80001cc0:	5a450513          	addi	a0,a0,1444 # 80008260 <kvmincrease+0x1100>
    80001cc4:	00002097          	auipc	ra,0x2
    80001cc8:	0cc080e7          	jalr	204(ra) # 80003d90 <_Z11printStringPKc>
            printInt(scause);
    80001ccc:	00000613          	li	a2,0
    80001cd0:	00a00593          	li	a1,10
    80001cd4:	0004851b          	sext.w	a0,s1
    80001cd8:	00002097          	auipc	ra,0x2
    80001cdc:	268080e7          	jalr	616(ra) # 80003f40 <_Z8printIntiii>
            thread_exit();
    80001ce0:	fffff097          	auipc	ra,0xfffff
    80001ce4:	508080e7          	jalr	1288(ra) # 800011e8 <_Z11thread_exitv>
            break;
    80001ce8:	fb9ff06f          	j	80001ca0 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>

0000000080001cec <_ZN4_sem4waitEv>:
    int value() const { return val; }
    void setWaitStatus(int s) { waitStatus = s;}
    int getWaitStatus() const { return waitStatus;}

    void setClosed(bool b);
    bool isClosed() const {return closed;}
    80001cec:	00854783          	lbu	a5,8(a0)

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (isClosed()) return -1;
    80001cf0:	0a079463          	bnez	a5,80001d98 <_ZN4_sem4waitEv+0xac>
int _sem::wait() {
    80001cf4:	fe010113          	addi	sp,sp,-32
    80001cf8:	00113c23          	sd	ra,24(sp)
    80001cfc:	00813823          	sd	s0,16(sp)
    80001d00:	00913423          	sd	s1,8(sp)
    80001d04:	01213023          	sd	s2,0(sp)
    80001d08:	02010413          	addi	s0,sp,32
    80001d0c:	00050493          	mv	s1,a0
    if (--val < 0){
    80001d10:	00052783          	lw	a5,0(a0)
    80001d14:	fff7879b          	addiw	a5,a5,-1
    80001d18:	00f52023          	sw	a5,0(a0)
    80001d1c:	02079713          	slli	a4,a5,0x20
    80001d20:	02074063          	bltz	a4,80001d40 <_ZN4_sem4waitEv+0x54>
    int getWaitStatus() const { return waitStatus;}
    80001d24:	0044a503          	lw	a0,4(s1)
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
}
    80001d28:	01813083          	ld	ra,24(sp)
    80001d2c:	01013403          	ld	s0,16(sp)
    80001d30:	00813483          	ld	s1,8(sp)
    80001d34:	00013903          	ld	s2,0(sp)
    80001d38:	02010113          	addi	sp,sp,32
    80001d3c:	00008067          	ret
        _thread* cur = _thread::running;
    80001d40:	00008797          	auipc	a5,0x8
    80001d44:	2187b783          	ld	a5,536(a5) # 80009f58 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001d48:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    80001d4c:	00100593          	li	a1,1
    80001d50:	00090513          	mv	a0,s2
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	810080e7          	jalr	-2032(ra) # 80001564 <_ZN7_thread8setBlockEb>
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001d5c:	01000513          	li	a0,16
    80001d60:	00000097          	auipc	ra,0x0
    80001d64:	9d0080e7          	jalr	-1584(ra) # 80001730 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001d68:	01253023          	sd	s2,0(a0)
    80001d6c:	00053423          	sd	zero,8(a0)
        if (tail)
    80001d70:	0184b783          	ld	a5,24(s1)
    80001d74:	00078c63          	beqz	a5,80001d8c <_ZN4_sem4waitEv+0xa0>
        {
            tail->next = elem;
    80001d78:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001d7c:	00a4bc23          	sd	a0,24(s1)
        thread_dispatch();
    80001d80:	fffff097          	auipc	ra,0xfffff
    80001d84:	494080e7          	jalr	1172(ra) # 80001214 <_Z15thread_dispatchv>
    80001d88:	f9dff06f          	j	80001d24 <_ZN4_sem4waitEv+0x38>
        } else
        {
            head = tail = elem;
    80001d8c:	00a4bc23          	sd	a0,24(s1)
    80001d90:	00a4b823          	sd	a0,16(s1)
    80001d94:	fedff06f          	j	80001d80 <_ZN4_sem4waitEv+0x94>
    if (isClosed()) return -1;
    80001d98:	fff00513          	li	a0,-1
}
    80001d9c:	00008067          	ret

0000000080001da0 <_ZN4_sem6signalEv>:
    bool isClosed() const {return closed;}
    80001da0:	00854703          	lbu	a4,8(a0)

int _sem::signal() {
    if (isClosed()) return -1;
    80001da4:	08071c63          	bnez	a4,80001e3c <_ZN4_sem6signalEv+0x9c>
    80001da8:	00050793          	mv	a5,a0
    if(++val <= 0){
    80001dac:	00052703          	lw	a4,0(a0)
    80001db0:	0017071b          	addiw	a4,a4,1
    80001db4:	0007069b          	sext.w	a3,a4
    80001db8:	00e52023          	sw	a4,0(a0)
    80001dbc:	00d05663          	blez	a3,80001dc8 <_ZN4_sem6signalEv+0x28>
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
    80001dc0:	00000513          	li	a0,0
    80001dc4:	00008067          	ret
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001dc8:	01053503          	ld	a0,16(a0)
    80001dcc:	06050c63          	beqz	a0,80001e44 <_ZN4_sem6signalEv+0xa4>
int _sem::signal() {
    80001dd0:	fe010113          	addi	sp,sp,-32
    80001dd4:	00113c23          	sd	ra,24(sp)
    80001dd8:	00813823          	sd	s0,16(sp)
    80001ddc:	00913423          	sd	s1,8(sp)
    80001de0:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    80001de4:	00853703          	ld	a4,8(a0)
    80001de8:	00e7b823          	sd	a4,16(a5)
        if (!head) { tail = 0; }
    80001dec:	04070463          	beqz	a4,80001e34 <_ZN4_sem6signalEv+0x94>

        T *ret = elem->data;
    80001df0:	00053483          	ld	s1,0(a0)
        delete elem;
    80001df4:	00000097          	auipc	ra,0x0
    80001df8:	98c080e7          	jalr	-1652(ra) # 80001780 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80001dfc:	04048863          	beqz	s1,80001e4c <_ZN4_sem6signalEv+0xac>
            cur->setBlock(false);
    80001e00:	00000593          	li	a1,0
    80001e04:	00048513          	mv	a0,s1
    80001e08:	fffff097          	auipc	ra,0xfffff
    80001e0c:	75c080e7          	jalr	1884(ra) # 80001564 <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80001e10:	00048513          	mv	a0,s1
    80001e14:	00000097          	auipc	ra,0x0
    80001e18:	1e8080e7          	jalr	488(ra) # 80001ffc <_ZN9Scheduler3putEP7_thread>
    return 0;
    80001e1c:	00000513          	li	a0,0
}
    80001e20:	01813083          	ld	ra,24(sp)
    80001e24:	01013403          	ld	s0,16(sp)
    80001e28:	00813483          	ld	s1,8(sp)
    80001e2c:	02010113          	addi	sp,sp,32
    80001e30:	00008067          	ret
        if (!head) { tail = 0; }
    80001e34:	0007bc23          	sd	zero,24(a5)
    80001e38:	fb9ff06f          	j	80001df0 <_ZN4_sem6signalEv+0x50>
    if (isClosed()) return -1;
    80001e3c:	fff00513          	li	a0,-1
    80001e40:	00008067          	ret
    return 0;
    80001e44:	00000513          	li	a0,0
}
    80001e48:	00008067          	ret
    return 0;
    80001e4c:	00000513          	li	a0,0
    80001e50:	fd1ff06f          	j	80001e20 <_ZN4_sem6signalEv+0x80>

0000000080001e54 <_ZN4_sem15createSemaphoreEj>:
    }

    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    80001e54:	fe010113          	addi	sp,sp,-32
    80001e58:	00113c23          	sd	ra,24(sp)
    80001e5c:	00813823          	sd	s0,16(sp)
    80001e60:	00913423          	sd	s1,8(sp)
    80001e64:	02010413          	addi	s0,sp,32
    80001e68:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    80001e6c:	02000513          	li	a0,32
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	8c0080e7          	jalr	-1856(ra) # 80001730 <_Znwm>
    _sem(uint32 init = 1) : val(init), waitStatus(0), closed(false) {}
    80001e78:	00952023          	sw	s1,0(a0)
    80001e7c:	00052223          	sw	zero,4(a0)
    80001e80:	00050423          	sb	zero,8(a0)
    List() : head(0), tail(0) {}
    80001e84:	00053823          	sd	zero,16(a0)
    80001e88:	00053c23          	sd	zero,24(a0)
    return newSemaphore;
}
    80001e8c:	01813083          	ld	ra,24(sp)
    80001e90:	01013403          	ld	s0,16(sp)
    80001e94:	00813483          	ld	s1,8(sp)
    80001e98:	02010113          	addi	sp,sp,32
    80001e9c:	00008067          	ret

0000000080001ea0 <_ZN4_sem9setClosedEb>:

void _sem::setClosed(bool b) {
    80001ea0:	ff010113          	addi	sp,sp,-16
    80001ea4:	00813423          	sd	s0,8(sp)
    80001ea8:	01010413          	addi	s0,sp,16
    closed = b;
    80001eac:	00b50423          	sb	a1,8(a0)
}
    80001eb0:	00813403          	ld	s0,8(sp)
    80001eb4:	01010113          	addi	sp,sp,16
    80001eb8:	00008067          	ret

0000000080001ebc <_ZN4_sem5closeEv>:
int _sem::close() {
    80001ebc:	fe010113          	addi	sp,sp,-32
    80001ec0:	00113c23          	sd	ra,24(sp)
    80001ec4:	00813823          	sd	s0,16(sp)
    80001ec8:	00913423          	sd	s1,8(sp)
    80001ecc:	01213023          	sd	s2,0(sp)
    80001ed0:	02010413          	addi	s0,sp,32
    80001ed4:	00050913          	mv	s2,a0
    setClosed(true);
    80001ed8:	00100593          	li	a1,1
    80001edc:	00000097          	auipc	ra,0x0
    80001ee0:	fc4080e7          	jalr	-60(ra) # 80001ea0 <_ZN4_sem9setClosedEb>
    void setWaitStatus(int s) { waitStatus = s;}
    80001ee4:	fff00793          	li	a5,-1
    80001ee8:	00f92223          	sw	a5,4(s2)
    80001eec:	0340006f          	j	80001f20 <_ZN4_sem5closeEv+0x64>
        if (!head) { tail = 0; }
    80001ef0:	00093c23          	sd	zero,24(s2)
        T *ret = elem->data;
    80001ef4:	00053483          	ld	s1,0(a0)
        delete elem;
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	888080e7          	jalr	-1912(ra) # 80001780 <_ZdlPv>
    while(_thread* cur = blocked.removeFirst()){
    80001f00:	02048c63          	beqz	s1,80001f38 <_ZN4_sem5closeEv+0x7c>
        cur->setBlock(false);
    80001f04:	00000593          	li	a1,0
    80001f08:	00048513          	mv	a0,s1
    80001f0c:	fffff097          	auipc	ra,0xfffff
    80001f10:	658080e7          	jalr	1624(ra) # 80001564 <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    80001f14:	00048513          	mv	a0,s1
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	0e4080e7          	jalr	228(ra) # 80001ffc <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80001f20:	01093503          	ld	a0,16(s2)
    80001f24:	00050a63          	beqz	a0,80001f38 <_ZN4_sem5closeEv+0x7c>
        head = head->next;
    80001f28:	00853783          	ld	a5,8(a0)
    80001f2c:	00f93823          	sd	a5,16(s2)
        if (!head) { tail = 0; }
    80001f30:	fc0792e3          	bnez	a5,80001ef4 <_ZN4_sem5closeEv+0x38>
    80001f34:	fbdff06f          	j	80001ef0 <_ZN4_sem5closeEv+0x34>
}
    80001f38:	00000513          	li	a0,0
    80001f3c:	01813083          	ld	ra,24(sp)
    80001f40:	01013403          	ld	s0,16(sp)
    80001f44:	00813483          	ld	s1,8(sp)
    80001f48:	00013903          	ld	s2,0(sp)
    80001f4c:	02010113          	addi	sp,sp,32
    80001f50:	00008067          	ret

0000000080001f54 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001f54:	ff010113          	addi	sp,sp,-16
    80001f58:	00813423          	sd	s0,8(sp)
    80001f5c:	01010413          	addi	s0,sp,16
    80001f60:	00100793          	li	a5,1
    80001f64:	00f50863          	beq	a0,a5,80001f74 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001f68:	00813403          	ld	s0,8(sp)
    80001f6c:	01010113          	addi	sp,sp,16
    80001f70:	00008067          	ret
    80001f74:	000107b7          	lui	a5,0x10
    80001f78:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001f7c:	fef596e3          	bne	a1,a5,80001f68 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001f80:	00008797          	auipc	a5,0x8
    80001f84:	04878793          	addi	a5,a5,72 # 80009fc8 <_ZN9Scheduler16readyThreadQueueE>
    80001f88:	0007b023          	sd	zero,0(a5)
    80001f8c:	0007b423          	sd	zero,8(a5)
    80001f90:	fd9ff06f          	j	80001f68 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001f94 <_ZN9Scheduler3getEv>:
{
    80001f94:	fe010113          	addi	sp,sp,-32
    80001f98:	00113c23          	sd	ra,24(sp)
    80001f9c:	00813823          	sd	s0,16(sp)
    80001fa0:	00913423          	sd	s1,8(sp)
    80001fa4:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001fa8:	00008517          	auipc	a0,0x8
    80001fac:	02053503          	ld	a0,32(a0) # 80009fc8 <_ZN9Scheduler16readyThreadQueueE>
    80001fb0:	04050263          	beqz	a0,80001ff4 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001fb4:	00853783          	ld	a5,8(a0)
    80001fb8:	00008717          	auipc	a4,0x8
    80001fbc:	00f73823          	sd	a5,16(a4) # 80009fc8 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001fc0:	02078463          	beqz	a5,80001fe8 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001fc4:	00053483          	ld	s1,0(a0)
        delete elem;
    80001fc8:	fffff097          	auipc	ra,0xfffff
    80001fcc:	7b8080e7          	jalr	1976(ra) # 80001780 <_ZdlPv>
}
    80001fd0:	00048513          	mv	a0,s1
    80001fd4:	01813083          	ld	ra,24(sp)
    80001fd8:	01013403          	ld	s0,16(sp)
    80001fdc:	00813483          	ld	s1,8(sp)
    80001fe0:	02010113          	addi	sp,sp,32
    80001fe4:	00008067          	ret
        if (!head) { tail = 0; }
    80001fe8:	00008797          	auipc	a5,0x8
    80001fec:	fe07b423          	sd	zero,-24(a5) # 80009fd0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001ff0:	fd5ff06f          	j	80001fc4 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001ff4:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001ff8:	fd9ff06f          	j	80001fd0 <_ZN9Scheduler3getEv+0x3c>

0000000080001ffc <_ZN9Scheduler3putEP7_thread>:
{
    80001ffc:	fe010113          	addi	sp,sp,-32
    80002000:	00113c23          	sd	ra,24(sp)
    80002004:	00813823          	sd	s0,16(sp)
    80002008:	00913423          	sd	s1,8(sp)
    8000200c:	02010413          	addi	s0,sp,32
    80002010:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80002014:	01000513          	li	a0,16
    80002018:	fffff097          	auipc	ra,0xfffff
    8000201c:	718080e7          	jalr	1816(ra) # 80001730 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002020:	00953023          	sd	s1,0(a0)
    80002024:	00053423          	sd	zero,8(a0)
        if (tail)
    80002028:	00008797          	auipc	a5,0x8
    8000202c:	fa87b783          	ld	a5,-88(a5) # 80009fd0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002030:	02078263          	beqz	a5,80002054 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80002034:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002038:	00008797          	auipc	a5,0x8
    8000203c:	f8a7bc23          	sd	a0,-104(a5) # 80009fd0 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002040:	01813083          	ld	ra,24(sp)
    80002044:	01013403          	ld	s0,16(sp)
    80002048:	00813483          	ld	s1,8(sp)
    8000204c:	02010113          	addi	sp,sp,32
    80002050:	00008067          	ret
            head = tail = elem;
    80002054:	00008797          	auipc	a5,0x8
    80002058:	f7478793          	addi	a5,a5,-140 # 80009fc8 <_ZN9Scheduler16readyThreadQueueE>
    8000205c:	00a7b423          	sd	a0,8(a5)
    80002060:	00a7b023          	sd	a0,0(a5)
    80002064:	fddff06f          	j	80002040 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080002068 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80002068:	ff010113          	addi	sp,sp,-16
    8000206c:	00113423          	sd	ra,8(sp)
    80002070:	00813023          	sd	s0,0(sp)
    80002074:	01010413          	addi	s0,sp,16
    80002078:	000105b7          	lui	a1,0x10
    8000207c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002080:	00100513          	li	a0,1
    80002084:	00000097          	auipc	ra,0x0
    80002088:	ed0080e7          	jalr	-304(ra) # 80001f54 <_Z41__static_initialization_and_destruction_0ii>
    8000208c:	00813083          	ld	ra,8(sp)
    80002090:	00013403          	ld	s0,0(sp)
    80002094:	01010113          	addi	sp,sp,16
    80002098:	00008067          	ret

000000008000209c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    8000209c:	fe010113          	addi	sp,sp,-32
    800020a0:	00113c23          	sd	ra,24(sp)
    800020a4:	00813823          	sd	s0,16(sp)
    800020a8:	00913423          	sd	s1,8(sp)
    800020ac:	01213023          	sd	s2,0(sp)
    800020b0:	02010413          	addi	s0,sp,32
    800020b4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800020b8:	00000913          	li	s2,0
    800020bc:	00c0006f          	j	800020c8 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	154080e7          	jalr	340(ra) # 80001214 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    800020c8:	fffff097          	auipc	ra,0xfffff
    800020cc:	220080e7          	jalr	544(ra) # 800012e8 <_Z4getcv>
    800020d0:	0005059b          	sext.w	a1,a0
    800020d4:	01b00793          	li	a5,27
    800020d8:	02f58a63          	beq	a1,a5,8000210c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    800020dc:	0084b503          	ld	a0,8(s1)
    800020e0:	00003097          	auipc	ra,0x3
    800020e4:	9fc080e7          	jalr	-1540(ra) # 80004adc <_ZN6Buffer3putEi>
        i++;
    800020e8:	0019071b          	addiw	a4,s2,1
    800020ec:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800020f0:	0004a683          	lw	a3,0(s1)
    800020f4:	0026979b          	slliw	a5,a3,0x2
    800020f8:	00d787bb          	addw	a5,a5,a3
    800020fc:	0017979b          	slliw	a5,a5,0x1
    80002100:	02f767bb          	remw	a5,a4,a5
    80002104:	fc0792e3          	bnez	a5,800020c8 <_ZL16producerKeyboardPv+0x2c>
    80002108:	fb9ff06f          	j	800020c0 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000210c:	00100793          	li	a5,1
    80002110:	00008717          	auipc	a4,0x8
    80002114:	ecf72423          	sw	a5,-312(a4) # 80009fd8 <_ZL9threadEnd>
    data->buffer->put('!');
    80002118:	02100593          	li	a1,33
    8000211c:	0084b503          	ld	a0,8(s1)
    80002120:	00003097          	auipc	ra,0x3
    80002124:	9bc080e7          	jalr	-1604(ra) # 80004adc <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80002128:	0104b503          	ld	a0,16(s1)
    8000212c:	fffff097          	auipc	ra,0xfffff
    80002130:	190080e7          	jalr	400(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    80002134:	01813083          	ld	ra,24(sp)
    80002138:	01013403          	ld	s0,16(sp)
    8000213c:	00813483          	ld	s1,8(sp)
    80002140:	00013903          	ld	s2,0(sp)
    80002144:	02010113          	addi	sp,sp,32
    80002148:	00008067          	ret

000000008000214c <_ZL8producerPv>:

static void producer(void *arg) {
    8000214c:	fe010113          	addi	sp,sp,-32
    80002150:	00113c23          	sd	ra,24(sp)
    80002154:	00813823          	sd	s0,16(sp)
    80002158:	00913423          	sd	s1,8(sp)
    8000215c:	01213023          	sd	s2,0(sp)
    80002160:	02010413          	addi	s0,sp,32
    80002164:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002168:	00000913          	li	s2,0
    8000216c:	00c0006f          	j	80002178 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002170:	fffff097          	auipc	ra,0xfffff
    80002174:	0a4080e7          	jalr	164(ra) # 80001214 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002178:	00008797          	auipc	a5,0x8
    8000217c:	e607a783          	lw	a5,-416(a5) # 80009fd8 <_ZL9threadEnd>
    80002180:	02079e63          	bnez	a5,800021bc <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002184:	0004a583          	lw	a1,0(s1)
    80002188:	0305859b          	addiw	a1,a1,48
    8000218c:	0084b503          	ld	a0,8(s1)
    80002190:	00003097          	auipc	ra,0x3
    80002194:	94c080e7          	jalr	-1716(ra) # 80004adc <_ZN6Buffer3putEi>
        i++;
    80002198:	0019071b          	addiw	a4,s2,1
    8000219c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800021a0:	0004a683          	lw	a3,0(s1)
    800021a4:	0026979b          	slliw	a5,a3,0x2
    800021a8:	00d787bb          	addw	a5,a5,a3
    800021ac:	0017979b          	slliw	a5,a5,0x1
    800021b0:	02f767bb          	remw	a5,a4,a5
    800021b4:	fc0792e3          	bnez	a5,80002178 <_ZL8producerPv+0x2c>
    800021b8:	fb9ff06f          	j	80002170 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800021bc:	0104b503          	ld	a0,16(s1)
    800021c0:	fffff097          	auipc	ra,0xfffff
    800021c4:	0fc080e7          	jalr	252(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    800021c8:	01813083          	ld	ra,24(sp)
    800021cc:	01013403          	ld	s0,16(sp)
    800021d0:	00813483          	ld	s1,8(sp)
    800021d4:	00013903          	ld	s2,0(sp)
    800021d8:	02010113          	addi	sp,sp,32
    800021dc:	00008067          	ret

00000000800021e0 <_ZL8consumerPv>:

static void consumer(void *arg) {
    800021e0:	fd010113          	addi	sp,sp,-48
    800021e4:	02113423          	sd	ra,40(sp)
    800021e8:	02813023          	sd	s0,32(sp)
    800021ec:	00913c23          	sd	s1,24(sp)
    800021f0:	01213823          	sd	s2,16(sp)
    800021f4:	01313423          	sd	s3,8(sp)
    800021f8:	03010413          	addi	s0,sp,48
    800021fc:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002200:	00000993          	li	s3,0
    80002204:	01c0006f          	j	80002220 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002208:	fffff097          	auipc	ra,0xfffff
    8000220c:	00c080e7          	jalr	12(ra) # 80001214 <_Z15thread_dispatchv>
    80002210:	0500006f          	j	80002260 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002214:	00a00513          	li	a0,10
    80002218:	fffff097          	auipc	ra,0xfffff
    8000221c:	0fc080e7          	jalr	252(ra) # 80001314 <_Z4putcc>
    while (!threadEnd) {
    80002220:	00008797          	auipc	a5,0x8
    80002224:	db87a783          	lw	a5,-584(a5) # 80009fd8 <_ZL9threadEnd>
    80002228:	06079063          	bnez	a5,80002288 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    8000222c:	00893503          	ld	a0,8(s2)
    80002230:	00003097          	auipc	ra,0x3
    80002234:	93c080e7          	jalr	-1732(ra) # 80004b6c <_ZN6Buffer3getEv>
        i++;
    80002238:	0019849b          	addiw	s1,s3,1
    8000223c:	0004899b          	sext.w	s3,s1
        putc(key);
    80002240:	0ff57513          	andi	a0,a0,255
    80002244:	fffff097          	auipc	ra,0xfffff
    80002248:	0d0080e7          	jalr	208(ra) # 80001314 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000224c:	00092703          	lw	a4,0(s2)
    80002250:	0027179b          	slliw	a5,a4,0x2
    80002254:	00e787bb          	addw	a5,a5,a4
    80002258:	02f4e7bb          	remw	a5,s1,a5
    8000225c:	fa0786e3          	beqz	a5,80002208 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80002260:	05000793          	li	a5,80
    80002264:	02f4e4bb          	remw	s1,s1,a5
    80002268:	fa049ce3          	bnez	s1,80002220 <_ZL8consumerPv+0x40>
    8000226c:	fa9ff06f          	j	80002214 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002270:	00893503          	ld	a0,8(s2)
    80002274:	00003097          	auipc	ra,0x3
    80002278:	8f8080e7          	jalr	-1800(ra) # 80004b6c <_ZN6Buffer3getEv>
        putc(key);
    8000227c:	0ff57513          	andi	a0,a0,255
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	094080e7          	jalr	148(ra) # 80001314 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002288:	00893503          	ld	a0,8(s2)
    8000228c:	00003097          	auipc	ra,0x3
    80002290:	96c080e7          	jalr	-1684(ra) # 80004bf8 <_ZN6Buffer6getCntEv>
    80002294:	fca04ee3          	bgtz	a0,80002270 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002298:	01093503          	ld	a0,16(s2)
    8000229c:	fffff097          	auipc	ra,0xfffff
    800022a0:	020080e7          	jalr	32(ra) # 800012bc <_Z10sem_signalP4_sem>
}
    800022a4:	02813083          	ld	ra,40(sp)
    800022a8:	02013403          	ld	s0,32(sp)
    800022ac:	01813483          	ld	s1,24(sp)
    800022b0:	01013903          	ld	s2,16(sp)
    800022b4:	00813983          	ld	s3,8(sp)
    800022b8:	03010113          	addi	sp,sp,48
    800022bc:	00008067          	ret

00000000800022c0 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800022c0:	f9010113          	addi	sp,sp,-112
    800022c4:	06113423          	sd	ra,104(sp)
    800022c8:	06813023          	sd	s0,96(sp)
    800022cc:	04913c23          	sd	s1,88(sp)
    800022d0:	05213823          	sd	s2,80(sp)
    800022d4:	05313423          	sd	s3,72(sp)
    800022d8:	05413023          	sd	s4,64(sp)
    800022dc:	03513c23          	sd	s5,56(sp)
    800022e0:	03613823          	sd	s6,48(sp)
    800022e4:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800022e8:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800022ec:	00006517          	auipc	a0,0x6
    800022f0:	08c50513          	addi	a0,a0,140 # 80008378 <kvmincrease+0x1218>
    800022f4:	00002097          	auipc	ra,0x2
    800022f8:	a9c080e7          	jalr	-1380(ra) # 80003d90 <_Z11printStringPKc>
    getString(input, 30);
    800022fc:	01e00593          	li	a1,30
    80002300:	fa040493          	addi	s1,s0,-96
    80002304:	00048513          	mv	a0,s1
    80002308:	00002097          	auipc	ra,0x2
    8000230c:	b10080e7          	jalr	-1264(ra) # 80003e18 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002310:	00048513          	mv	a0,s1
    80002314:	00002097          	auipc	ra,0x2
    80002318:	bdc080e7          	jalr	-1060(ra) # 80003ef0 <_Z11stringToIntPKc>
    8000231c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002320:	00006517          	auipc	a0,0x6
    80002324:	07850513          	addi	a0,a0,120 # 80008398 <kvmincrease+0x1238>
    80002328:	00002097          	auipc	ra,0x2
    8000232c:	a68080e7          	jalr	-1432(ra) # 80003d90 <_Z11printStringPKc>
    getString(input, 30);
    80002330:	01e00593          	li	a1,30
    80002334:	00048513          	mv	a0,s1
    80002338:	00002097          	auipc	ra,0x2
    8000233c:	ae0080e7          	jalr	-1312(ra) # 80003e18 <_Z9getStringPci>
    n = stringToInt(input);
    80002340:	00048513          	mv	a0,s1
    80002344:	00002097          	auipc	ra,0x2
    80002348:	bac080e7          	jalr	-1108(ra) # 80003ef0 <_Z11stringToIntPKc>
    8000234c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002350:	00006517          	auipc	a0,0x6
    80002354:	06850513          	addi	a0,a0,104 # 800083b8 <kvmincrease+0x1258>
    80002358:	00002097          	auipc	ra,0x2
    8000235c:	a38080e7          	jalr	-1480(ra) # 80003d90 <_Z11printStringPKc>
    80002360:	00000613          	li	a2,0
    80002364:	00a00593          	li	a1,10
    80002368:	00090513          	mv	a0,s2
    8000236c:	00002097          	auipc	ra,0x2
    80002370:	bd4080e7          	jalr	-1068(ra) # 80003f40 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002374:	00006517          	auipc	a0,0x6
    80002378:	05c50513          	addi	a0,a0,92 # 800083d0 <kvmincrease+0x1270>
    8000237c:	00002097          	auipc	ra,0x2
    80002380:	a14080e7          	jalr	-1516(ra) # 80003d90 <_Z11printStringPKc>
    80002384:	00000613          	li	a2,0
    80002388:	00a00593          	li	a1,10
    8000238c:	00048513          	mv	a0,s1
    80002390:	00002097          	auipc	ra,0x2
    80002394:	bb0080e7          	jalr	-1104(ra) # 80003f40 <_Z8printIntiii>
    printString(".\n");
    80002398:	00006517          	auipc	a0,0x6
    8000239c:	05050513          	addi	a0,a0,80 # 800083e8 <kvmincrease+0x1288>
    800023a0:	00002097          	auipc	ra,0x2
    800023a4:	9f0080e7          	jalr	-1552(ra) # 80003d90 <_Z11printStringPKc>
    if(threadNum > n) {
    800023a8:	0324c463          	blt	s1,s2,800023d0 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    800023ac:	03205c63          	blez	s2,800023e4 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    800023b0:	03800513          	li	a0,56
    800023b4:	fffff097          	auipc	ra,0xfffff
    800023b8:	37c080e7          	jalr	892(ra) # 80001730 <_Znwm>
    800023bc:	00050a13          	mv	s4,a0
    800023c0:	00048593          	mv	a1,s1
    800023c4:	00002097          	auipc	ra,0x2
    800023c8:	67c080e7          	jalr	1660(ra) # 80004a40 <_ZN6BufferC1Ei>
    800023cc:	0300006f          	j	800023fc <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800023d0:	00006517          	auipc	a0,0x6
    800023d4:	02050513          	addi	a0,a0,32 # 800083f0 <kvmincrease+0x1290>
    800023d8:	00002097          	auipc	ra,0x2
    800023dc:	9b8080e7          	jalr	-1608(ra) # 80003d90 <_Z11printStringPKc>
        return;
    800023e0:	0140006f          	j	800023f4 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800023e4:	00006517          	auipc	a0,0x6
    800023e8:	04c50513          	addi	a0,a0,76 # 80008430 <kvmincrease+0x12d0>
    800023ec:	00002097          	auipc	ra,0x2
    800023f0:	9a4080e7          	jalr	-1628(ra) # 80003d90 <_Z11printStringPKc>
        return;
    800023f4:	000b0113          	mv	sp,s6
    800023f8:	1500006f          	j	80002548 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800023fc:	00000593          	li	a1,0
    80002400:	00008517          	auipc	a0,0x8
    80002404:	be050513          	addi	a0,a0,-1056 # 80009fe0 <_ZL10waitForAll>
    80002408:	fffff097          	auipc	ra,0xfffff
    8000240c:	e30080e7          	jalr	-464(ra) # 80001238 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    80002410:	00391793          	slli	a5,s2,0x3
    80002414:	00f78793          	addi	a5,a5,15
    80002418:	ff07f793          	andi	a5,a5,-16
    8000241c:	40f10133          	sub	sp,sp,a5
    80002420:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002424:	0019071b          	addiw	a4,s2,1
    80002428:	00171793          	slli	a5,a4,0x1
    8000242c:	00e787b3          	add	a5,a5,a4
    80002430:	00379793          	slli	a5,a5,0x3
    80002434:	00f78793          	addi	a5,a5,15
    80002438:	ff07f793          	andi	a5,a5,-16
    8000243c:	40f10133          	sub	sp,sp,a5
    80002440:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002444:	00191613          	slli	a2,s2,0x1
    80002448:	012607b3          	add	a5,a2,s2
    8000244c:	00379793          	slli	a5,a5,0x3
    80002450:	00f987b3          	add	a5,s3,a5
    80002454:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002458:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    8000245c:	00008717          	auipc	a4,0x8
    80002460:	b8473703          	ld	a4,-1148(a4) # 80009fe0 <_ZL10waitForAll>
    80002464:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002468:	00078613          	mv	a2,a5
    8000246c:	00000597          	auipc	a1,0x0
    80002470:	d7458593          	addi	a1,a1,-652 # 800021e0 <_ZL8consumerPv>
    80002474:	f9840513          	addi	a0,s0,-104
    80002478:	fffff097          	auipc	ra,0xfffff
    8000247c:	d44080e7          	jalr	-700(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002480:	00000493          	li	s1,0
    80002484:	0280006f          	j	800024ac <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002488:	00000597          	auipc	a1,0x0
    8000248c:	c1458593          	addi	a1,a1,-1004 # 8000209c <_ZL16producerKeyboardPv>
                      data + i);
    80002490:	00179613          	slli	a2,a5,0x1
    80002494:	00f60633          	add	a2,a2,a5
    80002498:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    8000249c:	00c98633          	add	a2,s3,a2
    800024a0:	fffff097          	auipc	ra,0xfffff
    800024a4:	d1c080e7          	jalr	-740(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800024a8:	0014849b          	addiw	s1,s1,1
    800024ac:	0524d263          	bge	s1,s2,800024f0 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    800024b0:	00149793          	slli	a5,s1,0x1
    800024b4:	009787b3          	add	a5,a5,s1
    800024b8:	00379793          	slli	a5,a5,0x3
    800024bc:	00f987b3          	add	a5,s3,a5
    800024c0:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800024c4:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    800024c8:	00008717          	auipc	a4,0x8
    800024cc:	b1873703          	ld	a4,-1256(a4) # 80009fe0 <_ZL10waitForAll>
    800024d0:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    800024d4:	00048793          	mv	a5,s1
    800024d8:	00349513          	slli	a0,s1,0x3
    800024dc:	00aa8533          	add	a0,s5,a0
    800024e0:	fa9054e3          	blez	s1,80002488 <_Z22producerConsumer_C_APIv+0x1c8>
    800024e4:	00000597          	auipc	a1,0x0
    800024e8:	c6858593          	addi	a1,a1,-920 # 8000214c <_ZL8producerPv>
    800024ec:	fa5ff06f          	j	80002490 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    800024f0:	fffff097          	auipc	ra,0xfffff
    800024f4:	d24080e7          	jalr	-732(ra) # 80001214 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800024f8:	00000493          	li	s1,0
    800024fc:	00994e63          	blt	s2,s1,80002518 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002500:	00008517          	auipc	a0,0x8
    80002504:	ae053503          	ld	a0,-1312(a0) # 80009fe0 <_ZL10waitForAll>
    80002508:	fffff097          	auipc	ra,0xfffff
    8000250c:	d88080e7          	jalr	-632(ra) # 80001290 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    80002510:	0014849b          	addiw	s1,s1,1
    80002514:	fe9ff06f          	j	800024fc <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80002518:	00008517          	auipc	a0,0x8
    8000251c:	ac853503          	ld	a0,-1336(a0) # 80009fe0 <_ZL10waitForAll>
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	d44080e7          	jalr	-700(ra) # 80001264 <_Z9sem_closeP4_sem>
    delete buffer;
    80002528:	000a0e63          	beqz	s4,80002544 <_Z22producerConsumer_C_APIv+0x284>
    8000252c:	000a0513          	mv	a0,s4
    80002530:	00002097          	auipc	ra,0x2
    80002534:	750080e7          	jalr	1872(ra) # 80004c80 <_ZN6BufferD1Ev>
    80002538:	000a0513          	mv	a0,s4
    8000253c:	fffff097          	auipc	ra,0xfffff
    80002540:	244080e7          	jalr	580(ra) # 80001780 <_ZdlPv>
    80002544:	000b0113          	mv	sp,s6

}
    80002548:	f9040113          	addi	sp,s0,-112
    8000254c:	06813083          	ld	ra,104(sp)
    80002550:	06013403          	ld	s0,96(sp)
    80002554:	05813483          	ld	s1,88(sp)
    80002558:	05013903          	ld	s2,80(sp)
    8000255c:	04813983          	ld	s3,72(sp)
    80002560:	04013a03          	ld	s4,64(sp)
    80002564:	03813a83          	ld	s5,56(sp)
    80002568:	03013b03          	ld	s6,48(sp)
    8000256c:	07010113          	addi	sp,sp,112
    80002570:	00008067          	ret
    80002574:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002578:	000a0513          	mv	a0,s4
    8000257c:	fffff097          	auipc	ra,0xfffff
    80002580:	204080e7          	jalr	516(ra) # 80001780 <_ZdlPv>
    80002584:	00048513          	mv	a0,s1
    80002588:	00009097          	auipc	ra,0x9
    8000258c:	b50080e7          	jalr	-1200(ra) # 8000b0d8 <_Unwind_Resume>

0000000080002590 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002590:	fe010113          	addi	sp,sp,-32
    80002594:	00113c23          	sd	ra,24(sp)
    80002598:	00813823          	sd	s0,16(sp)
    8000259c:	00913423          	sd	s1,8(sp)
    800025a0:	01213023          	sd	s2,0(sp)
    800025a4:	02010413          	addi	s0,sp,32
    800025a8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800025ac:	00100793          	li	a5,1
    800025b0:	02a7f863          	bgeu	a5,a0,800025e0 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800025b4:	00a00793          	li	a5,10
    800025b8:	02f577b3          	remu	a5,a0,a5
    800025bc:	02078e63          	beqz	a5,800025f8 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800025c0:	fff48513          	addi	a0,s1,-1
    800025c4:	00000097          	auipc	ra,0x0
    800025c8:	fcc080e7          	jalr	-52(ra) # 80002590 <_ZL9fibonaccim>
    800025cc:	00050913          	mv	s2,a0
    800025d0:	ffe48513          	addi	a0,s1,-2
    800025d4:	00000097          	auipc	ra,0x0
    800025d8:	fbc080e7          	jalr	-68(ra) # 80002590 <_ZL9fibonaccim>
    800025dc:	00a90533          	add	a0,s2,a0
}
    800025e0:	01813083          	ld	ra,24(sp)
    800025e4:	01013403          	ld	s0,16(sp)
    800025e8:	00813483          	ld	s1,8(sp)
    800025ec:	00013903          	ld	s2,0(sp)
    800025f0:	02010113          	addi	sp,sp,32
    800025f4:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800025f8:	fffff097          	auipc	ra,0xfffff
    800025fc:	c1c080e7          	jalr	-996(ra) # 80001214 <_Z15thread_dispatchv>
    80002600:	fc1ff06f          	j	800025c0 <_ZL9fibonaccim+0x30>

0000000080002604 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002604:	fe010113          	addi	sp,sp,-32
    80002608:	00113c23          	sd	ra,24(sp)
    8000260c:	00813823          	sd	s0,16(sp)
    80002610:	00913423          	sd	s1,8(sp)
    80002614:	01213023          	sd	s2,0(sp)
    80002618:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000261c:	00000913          	li	s2,0
    80002620:	0380006f          	j	80002658 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002624:	fffff097          	auipc	ra,0xfffff
    80002628:	bf0080e7          	jalr	-1040(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000262c:	00148493          	addi	s1,s1,1
    80002630:	000027b7          	lui	a5,0x2
    80002634:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002638:	0097ee63          	bltu	a5,s1,80002654 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000263c:	00000713          	li	a4,0
    80002640:	000077b7          	lui	a5,0x7
    80002644:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002648:	fce7eee3          	bltu	a5,a4,80002624 <_ZN7WorkerA11workerBodyAEPv+0x20>
    8000264c:	00170713          	addi	a4,a4,1
    80002650:	ff1ff06f          	j	80002640 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002654:	00190913          	addi	s2,s2,1
    80002658:	00900793          	li	a5,9
    8000265c:	0527e063          	bltu	a5,s2,8000269c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002660:	00006517          	auipc	a0,0x6
    80002664:	e0050513          	addi	a0,a0,-512 # 80008460 <kvmincrease+0x1300>
    80002668:	00001097          	auipc	ra,0x1
    8000266c:	728080e7          	jalr	1832(ra) # 80003d90 <_Z11printStringPKc>
    80002670:	00000613          	li	a2,0
    80002674:	00a00593          	li	a1,10
    80002678:	0009051b          	sext.w	a0,s2
    8000267c:	00002097          	auipc	ra,0x2
    80002680:	8c4080e7          	jalr	-1852(ra) # 80003f40 <_Z8printIntiii>
    80002684:	00006517          	auipc	a0,0x6
    80002688:	b0450513          	addi	a0,a0,-1276 # 80008188 <kvmincrease+0x1028>
    8000268c:	00001097          	auipc	ra,0x1
    80002690:	704080e7          	jalr	1796(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002694:	00000493          	li	s1,0
    80002698:	f99ff06f          	j	80002630 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000269c:	00006517          	auipc	a0,0x6
    800026a0:	dcc50513          	addi	a0,a0,-564 # 80008468 <kvmincrease+0x1308>
    800026a4:	00001097          	auipc	ra,0x1
    800026a8:	6ec080e7          	jalr	1772(ra) # 80003d90 <_Z11printStringPKc>
    finishedA = true;
    800026ac:	00100793          	li	a5,1
    800026b0:	00008717          	auipc	a4,0x8
    800026b4:	92f70c23          	sb	a5,-1736(a4) # 80009fe8 <_ZL9finishedA>
}
    800026b8:	01813083          	ld	ra,24(sp)
    800026bc:	01013403          	ld	s0,16(sp)
    800026c0:	00813483          	ld	s1,8(sp)
    800026c4:	00013903          	ld	s2,0(sp)
    800026c8:	02010113          	addi	sp,sp,32
    800026cc:	00008067          	ret

00000000800026d0 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800026d0:	fe010113          	addi	sp,sp,-32
    800026d4:	00113c23          	sd	ra,24(sp)
    800026d8:	00813823          	sd	s0,16(sp)
    800026dc:	00913423          	sd	s1,8(sp)
    800026e0:	01213023          	sd	s2,0(sp)
    800026e4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800026e8:	00000913          	li	s2,0
    800026ec:	0380006f          	j	80002724 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800026f0:	fffff097          	auipc	ra,0xfffff
    800026f4:	b24080e7          	jalr	-1244(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800026f8:	00148493          	addi	s1,s1,1
    800026fc:	000027b7          	lui	a5,0x2
    80002700:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002704:	0097ee63          	bltu	a5,s1,80002720 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002708:	00000713          	li	a4,0
    8000270c:	000077b7          	lui	a5,0x7
    80002710:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002714:	fce7eee3          	bltu	a5,a4,800026f0 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80002718:	00170713          	addi	a4,a4,1
    8000271c:	ff1ff06f          	j	8000270c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002720:	00190913          	addi	s2,s2,1
    80002724:	00f00793          	li	a5,15
    80002728:	0527e063          	bltu	a5,s2,80002768 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000272c:	00006517          	auipc	a0,0x6
    80002730:	d4c50513          	addi	a0,a0,-692 # 80008478 <kvmincrease+0x1318>
    80002734:	00001097          	auipc	ra,0x1
    80002738:	65c080e7          	jalr	1628(ra) # 80003d90 <_Z11printStringPKc>
    8000273c:	00000613          	li	a2,0
    80002740:	00a00593          	li	a1,10
    80002744:	0009051b          	sext.w	a0,s2
    80002748:	00001097          	auipc	ra,0x1
    8000274c:	7f8080e7          	jalr	2040(ra) # 80003f40 <_Z8printIntiii>
    80002750:	00006517          	auipc	a0,0x6
    80002754:	a3850513          	addi	a0,a0,-1480 # 80008188 <kvmincrease+0x1028>
    80002758:	00001097          	auipc	ra,0x1
    8000275c:	638080e7          	jalr	1592(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002760:	00000493          	li	s1,0
    80002764:	f99ff06f          	j	800026fc <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80002768:	00006517          	auipc	a0,0x6
    8000276c:	d1850513          	addi	a0,a0,-744 # 80008480 <kvmincrease+0x1320>
    80002770:	00001097          	auipc	ra,0x1
    80002774:	620080e7          	jalr	1568(ra) # 80003d90 <_Z11printStringPKc>
    finishedB = true;
    80002778:	00100793          	li	a5,1
    8000277c:	00008717          	auipc	a4,0x8
    80002780:	86f706a3          	sb	a5,-1939(a4) # 80009fe9 <_ZL9finishedB>
    thread_dispatch();
    80002784:	fffff097          	auipc	ra,0xfffff
    80002788:	a90080e7          	jalr	-1392(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000278c:	01813083          	ld	ra,24(sp)
    80002790:	01013403          	ld	s0,16(sp)
    80002794:	00813483          	ld	s1,8(sp)
    80002798:	00013903          	ld	s2,0(sp)
    8000279c:	02010113          	addi	sp,sp,32
    800027a0:	00008067          	ret

00000000800027a4 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800027a4:	fe010113          	addi	sp,sp,-32
    800027a8:	00113c23          	sd	ra,24(sp)
    800027ac:	00813823          	sd	s0,16(sp)
    800027b0:	00913423          	sd	s1,8(sp)
    800027b4:	01213023          	sd	s2,0(sp)
    800027b8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800027bc:	00000493          	li	s1,0
    800027c0:	0400006f          	j	80002800 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800027c4:	00006517          	auipc	a0,0x6
    800027c8:	ccc50513          	addi	a0,a0,-820 # 80008490 <kvmincrease+0x1330>
    800027cc:	00001097          	auipc	ra,0x1
    800027d0:	5c4080e7          	jalr	1476(ra) # 80003d90 <_Z11printStringPKc>
    800027d4:	00000613          	li	a2,0
    800027d8:	00a00593          	li	a1,10
    800027dc:	00048513          	mv	a0,s1
    800027e0:	00001097          	auipc	ra,0x1
    800027e4:	760080e7          	jalr	1888(ra) # 80003f40 <_Z8printIntiii>
    800027e8:	00006517          	auipc	a0,0x6
    800027ec:	9a050513          	addi	a0,a0,-1632 # 80008188 <kvmincrease+0x1028>
    800027f0:	00001097          	auipc	ra,0x1
    800027f4:	5a0080e7          	jalr	1440(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800027f8:	0014849b          	addiw	s1,s1,1
    800027fc:	0ff4f493          	andi	s1,s1,255
    80002800:	00200793          	li	a5,2
    80002804:	fc97f0e3          	bgeu	a5,s1,800027c4 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002808:	00006517          	auipc	a0,0x6
    8000280c:	c9050513          	addi	a0,a0,-880 # 80008498 <kvmincrease+0x1338>
    80002810:	00001097          	auipc	ra,0x1
    80002814:	580080e7          	jalr	1408(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002818:	00700313          	li	t1,7
    thread_dispatch();
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	9f8080e7          	jalr	-1544(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002824:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80002828:	00006517          	auipc	a0,0x6
    8000282c:	c8050513          	addi	a0,a0,-896 # 800084a8 <kvmincrease+0x1348>
    80002830:	00001097          	auipc	ra,0x1
    80002834:	560080e7          	jalr	1376(ra) # 80003d90 <_Z11printStringPKc>
    80002838:	00000613          	li	a2,0
    8000283c:	00a00593          	li	a1,10
    80002840:	0009051b          	sext.w	a0,s2
    80002844:	00001097          	auipc	ra,0x1
    80002848:	6fc080e7          	jalr	1788(ra) # 80003f40 <_Z8printIntiii>
    8000284c:	00006517          	auipc	a0,0x6
    80002850:	93c50513          	addi	a0,a0,-1732 # 80008188 <kvmincrease+0x1028>
    80002854:	00001097          	auipc	ra,0x1
    80002858:	53c080e7          	jalr	1340(ra) # 80003d90 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000285c:	00c00513          	li	a0,12
    80002860:	00000097          	auipc	ra,0x0
    80002864:	d30080e7          	jalr	-720(ra) # 80002590 <_ZL9fibonaccim>
    80002868:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000286c:	00006517          	auipc	a0,0x6
    80002870:	c4450513          	addi	a0,a0,-956 # 800084b0 <kvmincrease+0x1350>
    80002874:	00001097          	auipc	ra,0x1
    80002878:	51c080e7          	jalr	1308(ra) # 80003d90 <_Z11printStringPKc>
    8000287c:	00000613          	li	a2,0
    80002880:	00a00593          	li	a1,10
    80002884:	0009051b          	sext.w	a0,s2
    80002888:	00001097          	auipc	ra,0x1
    8000288c:	6b8080e7          	jalr	1720(ra) # 80003f40 <_Z8printIntiii>
    80002890:	00006517          	auipc	a0,0x6
    80002894:	8f850513          	addi	a0,a0,-1800 # 80008188 <kvmincrease+0x1028>
    80002898:	00001097          	auipc	ra,0x1
    8000289c:	4f8080e7          	jalr	1272(ra) # 80003d90 <_Z11printStringPKc>
    800028a0:	0400006f          	j	800028e0 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800028a4:	00006517          	auipc	a0,0x6
    800028a8:	bec50513          	addi	a0,a0,-1044 # 80008490 <kvmincrease+0x1330>
    800028ac:	00001097          	auipc	ra,0x1
    800028b0:	4e4080e7          	jalr	1252(ra) # 80003d90 <_Z11printStringPKc>
    800028b4:	00000613          	li	a2,0
    800028b8:	00a00593          	li	a1,10
    800028bc:	00048513          	mv	a0,s1
    800028c0:	00001097          	auipc	ra,0x1
    800028c4:	680080e7          	jalr	1664(ra) # 80003f40 <_Z8printIntiii>
    800028c8:	00006517          	auipc	a0,0x6
    800028cc:	8c050513          	addi	a0,a0,-1856 # 80008188 <kvmincrease+0x1028>
    800028d0:	00001097          	auipc	ra,0x1
    800028d4:	4c0080e7          	jalr	1216(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800028d8:	0014849b          	addiw	s1,s1,1
    800028dc:	0ff4f493          	andi	s1,s1,255
    800028e0:	00500793          	li	a5,5
    800028e4:	fc97f0e3          	bgeu	a5,s1,800028a4 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    800028e8:	00006517          	auipc	a0,0x6
    800028ec:	b8050513          	addi	a0,a0,-1152 # 80008468 <kvmincrease+0x1308>
    800028f0:	00001097          	auipc	ra,0x1
    800028f4:	4a0080e7          	jalr	1184(ra) # 80003d90 <_Z11printStringPKc>
    finishedC = true;
    800028f8:	00100793          	li	a5,1
    800028fc:	00007717          	auipc	a4,0x7
    80002900:	6ef70723          	sb	a5,1774(a4) # 80009fea <_ZL9finishedC>
    thread_dispatch();
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	910080e7          	jalr	-1776(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000290c:	01813083          	ld	ra,24(sp)
    80002910:	01013403          	ld	s0,16(sp)
    80002914:	00813483          	ld	s1,8(sp)
    80002918:	00013903          	ld	s2,0(sp)
    8000291c:	02010113          	addi	sp,sp,32
    80002920:	00008067          	ret

0000000080002924 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002924:	fe010113          	addi	sp,sp,-32
    80002928:	00113c23          	sd	ra,24(sp)
    8000292c:	00813823          	sd	s0,16(sp)
    80002930:	00913423          	sd	s1,8(sp)
    80002934:	01213023          	sd	s2,0(sp)
    80002938:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000293c:	00a00493          	li	s1,10
    80002940:	0400006f          	j	80002980 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002944:	00006517          	auipc	a0,0x6
    80002948:	b7c50513          	addi	a0,a0,-1156 # 800084c0 <kvmincrease+0x1360>
    8000294c:	00001097          	auipc	ra,0x1
    80002950:	444080e7          	jalr	1092(ra) # 80003d90 <_Z11printStringPKc>
    80002954:	00000613          	li	a2,0
    80002958:	00a00593          	li	a1,10
    8000295c:	00048513          	mv	a0,s1
    80002960:	00001097          	auipc	ra,0x1
    80002964:	5e0080e7          	jalr	1504(ra) # 80003f40 <_Z8printIntiii>
    80002968:	00006517          	auipc	a0,0x6
    8000296c:	82050513          	addi	a0,a0,-2016 # 80008188 <kvmincrease+0x1028>
    80002970:	00001097          	auipc	ra,0x1
    80002974:	420080e7          	jalr	1056(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002978:	0014849b          	addiw	s1,s1,1
    8000297c:	0ff4f493          	andi	s1,s1,255
    80002980:	00c00793          	li	a5,12
    80002984:	fc97f0e3          	bgeu	a5,s1,80002944 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002988:	00006517          	auipc	a0,0x6
    8000298c:	b4050513          	addi	a0,a0,-1216 # 800084c8 <kvmincrease+0x1368>
    80002990:	00001097          	auipc	ra,0x1
    80002994:	400080e7          	jalr	1024(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002998:	00500313          	li	t1,5
    thread_dispatch();
    8000299c:	fffff097          	auipc	ra,0xfffff
    800029a0:	878080e7          	jalr	-1928(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800029a4:	01000513          	li	a0,16
    800029a8:	00000097          	auipc	ra,0x0
    800029ac:	be8080e7          	jalr	-1048(ra) # 80002590 <_ZL9fibonaccim>
    800029b0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800029b4:	00006517          	auipc	a0,0x6
    800029b8:	b2450513          	addi	a0,a0,-1244 # 800084d8 <kvmincrease+0x1378>
    800029bc:	00001097          	auipc	ra,0x1
    800029c0:	3d4080e7          	jalr	980(ra) # 80003d90 <_Z11printStringPKc>
    800029c4:	00000613          	li	a2,0
    800029c8:	00a00593          	li	a1,10
    800029cc:	0009051b          	sext.w	a0,s2
    800029d0:	00001097          	auipc	ra,0x1
    800029d4:	570080e7          	jalr	1392(ra) # 80003f40 <_Z8printIntiii>
    800029d8:	00005517          	auipc	a0,0x5
    800029dc:	7b050513          	addi	a0,a0,1968 # 80008188 <kvmincrease+0x1028>
    800029e0:	00001097          	auipc	ra,0x1
    800029e4:	3b0080e7          	jalr	944(ra) # 80003d90 <_Z11printStringPKc>
    800029e8:	0400006f          	j	80002a28 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800029ec:	00006517          	auipc	a0,0x6
    800029f0:	ad450513          	addi	a0,a0,-1324 # 800084c0 <kvmincrease+0x1360>
    800029f4:	00001097          	auipc	ra,0x1
    800029f8:	39c080e7          	jalr	924(ra) # 80003d90 <_Z11printStringPKc>
    800029fc:	00000613          	li	a2,0
    80002a00:	00a00593          	li	a1,10
    80002a04:	00048513          	mv	a0,s1
    80002a08:	00001097          	auipc	ra,0x1
    80002a0c:	538080e7          	jalr	1336(ra) # 80003f40 <_Z8printIntiii>
    80002a10:	00005517          	auipc	a0,0x5
    80002a14:	77850513          	addi	a0,a0,1912 # 80008188 <kvmincrease+0x1028>
    80002a18:	00001097          	auipc	ra,0x1
    80002a1c:	378080e7          	jalr	888(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002a20:	0014849b          	addiw	s1,s1,1
    80002a24:	0ff4f493          	andi	s1,s1,255
    80002a28:	00f00793          	li	a5,15
    80002a2c:	fc97f0e3          	bgeu	a5,s1,800029ec <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002a30:	00006517          	auipc	a0,0x6
    80002a34:	ab850513          	addi	a0,a0,-1352 # 800084e8 <kvmincrease+0x1388>
    80002a38:	00001097          	auipc	ra,0x1
    80002a3c:	358080e7          	jalr	856(ra) # 80003d90 <_Z11printStringPKc>
    finishedD = true;
    80002a40:	00100793          	li	a5,1
    80002a44:	00007717          	auipc	a4,0x7
    80002a48:	5af703a3          	sb	a5,1447(a4) # 80009feb <_ZL9finishedD>
    thread_dispatch();
    80002a4c:	ffffe097          	auipc	ra,0xffffe
    80002a50:	7c8080e7          	jalr	1992(ra) # 80001214 <_Z15thread_dispatchv>
}
    80002a54:	01813083          	ld	ra,24(sp)
    80002a58:	01013403          	ld	s0,16(sp)
    80002a5c:	00813483          	ld	s1,8(sp)
    80002a60:	00013903          	ld	s2,0(sp)
    80002a64:	02010113          	addi	sp,sp,32
    80002a68:	00008067          	ret

0000000080002a6c <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002a6c:	fc010113          	addi	sp,sp,-64
    80002a70:	02113c23          	sd	ra,56(sp)
    80002a74:	02813823          	sd	s0,48(sp)
    80002a78:	02913423          	sd	s1,40(sp)
    80002a7c:	03213023          	sd	s2,32(sp)
    80002a80:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002a84:	02000513          	li	a0,32
    80002a88:	fffff097          	auipc	ra,0xfffff
    80002a8c:	ca8080e7          	jalr	-856(ra) # 80001730 <_Znwm>
    80002a90:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002a94:	fffff097          	auipc	ra,0xfffff
    80002a98:	f20080e7          	jalr	-224(ra) # 800019b4 <_ZN6ThreadC1Ev>
    80002a9c:	00007797          	auipc	a5,0x7
    80002aa0:	39478793          	addi	a5,a5,916 # 80009e30 <_ZTV7WorkerA+0x10>
    80002aa4:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80002aa8:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80002aac:	00006517          	auipc	a0,0x6
    80002ab0:	a4c50513          	addi	a0,a0,-1460 # 800084f8 <kvmincrease+0x1398>
    80002ab4:	00001097          	auipc	ra,0x1
    80002ab8:	2dc080e7          	jalr	732(ra) # 80003d90 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002abc:	02000513          	li	a0,32
    80002ac0:	fffff097          	auipc	ra,0xfffff
    80002ac4:	c70080e7          	jalr	-912(ra) # 80001730 <_Znwm>
    80002ac8:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80002acc:	fffff097          	auipc	ra,0xfffff
    80002ad0:	ee8080e7          	jalr	-280(ra) # 800019b4 <_ZN6ThreadC1Ev>
    80002ad4:	00007797          	auipc	a5,0x7
    80002ad8:	38478793          	addi	a5,a5,900 # 80009e58 <_ZTV7WorkerB+0x10>
    80002adc:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002ae0:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002ae4:	00006517          	auipc	a0,0x6
    80002ae8:	a2c50513          	addi	a0,a0,-1492 # 80008510 <kvmincrease+0x13b0>
    80002aec:	00001097          	auipc	ra,0x1
    80002af0:	2a4080e7          	jalr	676(ra) # 80003d90 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002af4:	02000513          	li	a0,32
    80002af8:	fffff097          	auipc	ra,0xfffff
    80002afc:	c38080e7          	jalr	-968(ra) # 80001730 <_Znwm>
    80002b00:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002b04:	fffff097          	auipc	ra,0xfffff
    80002b08:	eb0080e7          	jalr	-336(ra) # 800019b4 <_ZN6ThreadC1Ev>
    80002b0c:	00007797          	auipc	a5,0x7
    80002b10:	37478793          	addi	a5,a5,884 # 80009e80 <_ZTV7WorkerC+0x10>
    80002b14:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002b18:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002b1c:	00006517          	auipc	a0,0x6
    80002b20:	a0c50513          	addi	a0,a0,-1524 # 80008528 <kvmincrease+0x13c8>
    80002b24:	00001097          	auipc	ra,0x1
    80002b28:	26c080e7          	jalr	620(ra) # 80003d90 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002b2c:	02000513          	li	a0,32
    80002b30:	fffff097          	auipc	ra,0xfffff
    80002b34:	c00080e7          	jalr	-1024(ra) # 80001730 <_Znwm>
    80002b38:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002b3c:	fffff097          	auipc	ra,0xfffff
    80002b40:	e78080e7          	jalr	-392(ra) # 800019b4 <_ZN6ThreadC1Ev>
    80002b44:	00007797          	auipc	a5,0x7
    80002b48:	36478793          	addi	a5,a5,868 # 80009ea8 <_ZTV7WorkerD+0x10>
    80002b4c:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002b50:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002b54:	00006517          	auipc	a0,0x6
    80002b58:	9ec50513          	addi	a0,a0,-1556 # 80008540 <kvmincrease+0x13e0>
    80002b5c:	00001097          	auipc	ra,0x1
    80002b60:	234080e7          	jalr	564(ra) # 80003d90 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002b64:	00000493          	li	s1,0
    80002b68:	00300793          	li	a5,3
    80002b6c:	0297c663          	blt	a5,s1,80002b98 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002b70:	00349793          	slli	a5,s1,0x3
    80002b74:	fe040713          	addi	a4,s0,-32
    80002b78:	00f707b3          	add	a5,a4,a5
    80002b7c:	fe07b503          	ld	a0,-32(a5)
    80002b80:	fffff097          	auipc	ra,0xfffff
    80002b84:	dd8080e7          	jalr	-552(ra) # 80001958 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002b88:	0014849b          	addiw	s1,s1,1
    80002b8c:	fddff06f          	j	80002b68 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002b90:	fffff097          	auipc	ra,0xfffff
    80002b94:	dfc080e7          	jalr	-516(ra) # 8000198c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002b98:	00007797          	auipc	a5,0x7
    80002b9c:	4507c783          	lbu	a5,1104(a5) # 80009fe8 <_ZL9finishedA>
    80002ba0:	fe0788e3          	beqz	a5,80002b90 <_Z20Threads_CPP_API_testv+0x124>
    80002ba4:	00007797          	auipc	a5,0x7
    80002ba8:	4457c783          	lbu	a5,1093(a5) # 80009fe9 <_ZL9finishedB>
    80002bac:	fe0782e3          	beqz	a5,80002b90 <_Z20Threads_CPP_API_testv+0x124>
    80002bb0:	00007797          	auipc	a5,0x7
    80002bb4:	43a7c783          	lbu	a5,1082(a5) # 80009fea <_ZL9finishedC>
    80002bb8:	fc078ce3          	beqz	a5,80002b90 <_Z20Threads_CPP_API_testv+0x124>
    80002bbc:	00007797          	auipc	a5,0x7
    80002bc0:	42f7c783          	lbu	a5,1071(a5) # 80009feb <_ZL9finishedD>
    80002bc4:	fc0786e3          	beqz	a5,80002b90 <_Z20Threads_CPP_API_testv+0x124>
    80002bc8:	fc040493          	addi	s1,s0,-64
    80002bcc:	0080006f          	j	80002bd4 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002bd0:	00848493          	addi	s1,s1,8
    80002bd4:	fe040793          	addi	a5,s0,-32
    80002bd8:	08f48663          	beq	s1,a5,80002c64 <_Z20Threads_CPP_API_testv+0x1f8>
    80002bdc:	0004b503          	ld	a0,0(s1)
    80002be0:	fe0508e3          	beqz	a0,80002bd0 <_Z20Threads_CPP_API_testv+0x164>
    80002be4:	00053783          	ld	a5,0(a0)
    80002be8:	0087b783          	ld	a5,8(a5)
    80002bec:	000780e7          	jalr	a5
    80002bf0:	fe1ff06f          	j	80002bd0 <_Z20Threads_CPP_API_testv+0x164>
    80002bf4:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002bf8:	00048513          	mv	a0,s1
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	b84080e7          	jalr	-1148(ra) # 80001780 <_ZdlPv>
    80002c04:	00090513          	mv	a0,s2
    80002c08:	00008097          	auipc	ra,0x8
    80002c0c:	4d0080e7          	jalr	1232(ra) # 8000b0d8 <_Unwind_Resume>
    80002c10:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002c14:	00048513          	mv	a0,s1
    80002c18:	fffff097          	auipc	ra,0xfffff
    80002c1c:	b68080e7          	jalr	-1176(ra) # 80001780 <_ZdlPv>
    80002c20:	00090513          	mv	a0,s2
    80002c24:	00008097          	auipc	ra,0x8
    80002c28:	4b4080e7          	jalr	1204(ra) # 8000b0d8 <_Unwind_Resume>
    80002c2c:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002c30:	00048513          	mv	a0,s1
    80002c34:	fffff097          	auipc	ra,0xfffff
    80002c38:	b4c080e7          	jalr	-1204(ra) # 80001780 <_ZdlPv>
    80002c3c:	00090513          	mv	a0,s2
    80002c40:	00008097          	auipc	ra,0x8
    80002c44:	498080e7          	jalr	1176(ra) # 8000b0d8 <_Unwind_Resume>
    80002c48:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002c4c:	00048513          	mv	a0,s1
    80002c50:	fffff097          	auipc	ra,0xfffff
    80002c54:	b30080e7          	jalr	-1232(ra) # 80001780 <_ZdlPv>
    80002c58:	00090513          	mv	a0,s2
    80002c5c:	00008097          	auipc	ra,0x8
    80002c60:	47c080e7          	jalr	1148(ra) # 8000b0d8 <_Unwind_Resume>
}
    80002c64:	03813083          	ld	ra,56(sp)
    80002c68:	03013403          	ld	s0,48(sp)
    80002c6c:	02813483          	ld	s1,40(sp)
    80002c70:	02013903          	ld	s2,32(sp)
    80002c74:	04010113          	addi	sp,sp,64
    80002c78:	00008067          	ret

0000000080002c7c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002c7c:	ff010113          	addi	sp,sp,-16
    80002c80:	00113423          	sd	ra,8(sp)
    80002c84:	00813023          	sd	s0,0(sp)
    80002c88:	01010413          	addi	s0,sp,16
    80002c8c:	00007797          	auipc	a5,0x7
    80002c90:	1a478793          	addi	a5,a5,420 # 80009e30 <_ZTV7WorkerA+0x10>
    80002c94:	00f53023          	sd	a5,0(a0)
    80002c98:	fffff097          	auipc	ra,0xfffff
    80002c9c:	b38080e7          	jalr	-1224(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002ca0:	00813083          	ld	ra,8(sp)
    80002ca4:	00013403          	ld	s0,0(sp)
    80002ca8:	01010113          	addi	sp,sp,16
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN7WorkerAD0Ev>:
    80002cb0:	fe010113          	addi	sp,sp,-32
    80002cb4:	00113c23          	sd	ra,24(sp)
    80002cb8:	00813823          	sd	s0,16(sp)
    80002cbc:	00913423          	sd	s1,8(sp)
    80002cc0:	02010413          	addi	s0,sp,32
    80002cc4:	00050493          	mv	s1,a0
    80002cc8:	00007797          	auipc	a5,0x7
    80002ccc:	16878793          	addi	a5,a5,360 # 80009e30 <_ZTV7WorkerA+0x10>
    80002cd0:	00f53023          	sd	a5,0(a0)
    80002cd4:	fffff097          	auipc	ra,0xfffff
    80002cd8:	afc080e7          	jalr	-1284(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002cdc:	00048513          	mv	a0,s1
    80002ce0:	fffff097          	auipc	ra,0xfffff
    80002ce4:	aa0080e7          	jalr	-1376(ra) # 80001780 <_ZdlPv>
    80002ce8:	01813083          	ld	ra,24(sp)
    80002cec:	01013403          	ld	s0,16(sp)
    80002cf0:	00813483          	ld	s1,8(sp)
    80002cf4:	02010113          	addi	sp,sp,32
    80002cf8:	00008067          	ret

0000000080002cfc <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002cfc:	ff010113          	addi	sp,sp,-16
    80002d00:	00113423          	sd	ra,8(sp)
    80002d04:	00813023          	sd	s0,0(sp)
    80002d08:	01010413          	addi	s0,sp,16
    80002d0c:	00007797          	auipc	a5,0x7
    80002d10:	14c78793          	addi	a5,a5,332 # 80009e58 <_ZTV7WorkerB+0x10>
    80002d14:	00f53023          	sd	a5,0(a0)
    80002d18:	fffff097          	auipc	ra,0xfffff
    80002d1c:	ab8080e7          	jalr	-1352(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002d20:	00813083          	ld	ra,8(sp)
    80002d24:	00013403          	ld	s0,0(sp)
    80002d28:	01010113          	addi	sp,sp,16
    80002d2c:	00008067          	ret

0000000080002d30 <_ZN7WorkerBD0Ev>:
    80002d30:	fe010113          	addi	sp,sp,-32
    80002d34:	00113c23          	sd	ra,24(sp)
    80002d38:	00813823          	sd	s0,16(sp)
    80002d3c:	00913423          	sd	s1,8(sp)
    80002d40:	02010413          	addi	s0,sp,32
    80002d44:	00050493          	mv	s1,a0
    80002d48:	00007797          	auipc	a5,0x7
    80002d4c:	11078793          	addi	a5,a5,272 # 80009e58 <_ZTV7WorkerB+0x10>
    80002d50:	00f53023          	sd	a5,0(a0)
    80002d54:	fffff097          	auipc	ra,0xfffff
    80002d58:	a7c080e7          	jalr	-1412(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002d5c:	00048513          	mv	a0,s1
    80002d60:	fffff097          	auipc	ra,0xfffff
    80002d64:	a20080e7          	jalr	-1504(ra) # 80001780 <_ZdlPv>
    80002d68:	01813083          	ld	ra,24(sp)
    80002d6c:	01013403          	ld	s0,16(sp)
    80002d70:	00813483          	ld	s1,8(sp)
    80002d74:	02010113          	addi	sp,sp,32
    80002d78:	00008067          	ret

0000000080002d7c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002d7c:	ff010113          	addi	sp,sp,-16
    80002d80:	00113423          	sd	ra,8(sp)
    80002d84:	00813023          	sd	s0,0(sp)
    80002d88:	01010413          	addi	s0,sp,16
    80002d8c:	00007797          	auipc	a5,0x7
    80002d90:	0f478793          	addi	a5,a5,244 # 80009e80 <_ZTV7WorkerC+0x10>
    80002d94:	00f53023          	sd	a5,0(a0)
    80002d98:	fffff097          	auipc	ra,0xfffff
    80002d9c:	a38080e7          	jalr	-1480(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002da0:	00813083          	ld	ra,8(sp)
    80002da4:	00013403          	ld	s0,0(sp)
    80002da8:	01010113          	addi	sp,sp,16
    80002dac:	00008067          	ret

0000000080002db0 <_ZN7WorkerCD0Ev>:
    80002db0:	fe010113          	addi	sp,sp,-32
    80002db4:	00113c23          	sd	ra,24(sp)
    80002db8:	00813823          	sd	s0,16(sp)
    80002dbc:	00913423          	sd	s1,8(sp)
    80002dc0:	02010413          	addi	s0,sp,32
    80002dc4:	00050493          	mv	s1,a0
    80002dc8:	00007797          	auipc	a5,0x7
    80002dcc:	0b878793          	addi	a5,a5,184 # 80009e80 <_ZTV7WorkerC+0x10>
    80002dd0:	00f53023          	sd	a5,0(a0)
    80002dd4:	fffff097          	auipc	ra,0xfffff
    80002dd8:	9fc080e7          	jalr	-1540(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002ddc:	00048513          	mv	a0,s1
    80002de0:	fffff097          	auipc	ra,0xfffff
    80002de4:	9a0080e7          	jalr	-1632(ra) # 80001780 <_ZdlPv>
    80002de8:	01813083          	ld	ra,24(sp)
    80002dec:	01013403          	ld	s0,16(sp)
    80002df0:	00813483          	ld	s1,8(sp)
    80002df4:	02010113          	addi	sp,sp,32
    80002df8:	00008067          	ret

0000000080002dfc <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002dfc:	ff010113          	addi	sp,sp,-16
    80002e00:	00113423          	sd	ra,8(sp)
    80002e04:	00813023          	sd	s0,0(sp)
    80002e08:	01010413          	addi	s0,sp,16
    80002e0c:	00007797          	auipc	a5,0x7
    80002e10:	09c78793          	addi	a5,a5,156 # 80009ea8 <_ZTV7WorkerD+0x10>
    80002e14:	00f53023          	sd	a5,0(a0)
    80002e18:	fffff097          	auipc	ra,0xfffff
    80002e1c:	9b8080e7          	jalr	-1608(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002e20:	00813083          	ld	ra,8(sp)
    80002e24:	00013403          	ld	s0,0(sp)
    80002e28:	01010113          	addi	sp,sp,16
    80002e2c:	00008067          	ret

0000000080002e30 <_ZN7WorkerDD0Ev>:
    80002e30:	fe010113          	addi	sp,sp,-32
    80002e34:	00113c23          	sd	ra,24(sp)
    80002e38:	00813823          	sd	s0,16(sp)
    80002e3c:	00913423          	sd	s1,8(sp)
    80002e40:	02010413          	addi	s0,sp,32
    80002e44:	00050493          	mv	s1,a0
    80002e48:	00007797          	auipc	a5,0x7
    80002e4c:	06078793          	addi	a5,a5,96 # 80009ea8 <_ZTV7WorkerD+0x10>
    80002e50:	00f53023          	sd	a5,0(a0)
    80002e54:	fffff097          	auipc	ra,0xfffff
    80002e58:	97c080e7          	jalr	-1668(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80002e5c:	00048513          	mv	a0,s1
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	920080e7          	jalr	-1760(ra) # 80001780 <_ZdlPv>
    80002e68:	01813083          	ld	ra,24(sp)
    80002e6c:	01013403          	ld	s0,16(sp)
    80002e70:	00813483          	ld	s1,8(sp)
    80002e74:	02010113          	addi	sp,sp,32
    80002e78:	00008067          	ret

0000000080002e7c <_ZN7WorkerA3runEv>:
    void run() override {
    80002e7c:	ff010113          	addi	sp,sp,-16
    80002e80:	00113423          	sd	ra,8(sp)
    80002e84:	00813023          	sd	s0,0(sp)
    80002e88:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002e8c:	00000593          	li	a1,0
    80002e90:	fffff097          	auipc	ra,0xfffff
    80002e94:	774080e7          	jalr	1908(ra) # 80002604 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002e98:	00813083          	ld	ra,8(sp)
    80002e9c:	00013403          	ld	s0,0(sp)
    80002ea0:	01010113          	addi	sp,sp,16
    80002ea4:	00008067          	ret

0000000080002ea8 <_ZN7WorkerB3runEv>:
    void run() override {
    80002ea8:	ff010113          	addi	sp,sp,-16
    80002eac:	00113423          	sd	ra,8(sp)
    80002eb0:	00813023          	sd	s0,0(sp)
    80002eb4:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002eb8:	00000593          	li	a1,0
    80002ebc:	00000097          	auipc	ra,0x0
    80002ec0:	814080e7          	jalr	-2028(ra) # 800026d0 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002ec4:	00813083          	ld	ra,8(sp)
    80002ec8:	00013403          	ld	s0,0(sp)
    80002ecc:	01010113          	addi	sp,sp,16
    80002ed0:	00008067          	ret

0000000080002ed4 <_ZN7WorkerC3runEv>:
    void run() override {
    80002ed4:	ff010113          	addi	sp,sp,-16
    80002ed8:	00113423          	sd	ra,8(sp)
    80002edc:	00813023          	sd	s0,0(sp)
    80002ee0:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002ee4:	00000593          	li	a1,0
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	8bc080e7          	jalr	-1860(ra) # 800027a4 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002ef0:	00813083          	ld	ra,8(sp)
    80002ef4:	00013403          	ld	s0,0(sp)
    80002ef8:	01010113          	addi	sp,sp,16
    80002efc:	00008067          	ret

0000000080002f00 <_ZN7WorkerD3runEv>:
    void run() override {
    80002f00:	ff010113          	addi	sp,sp,-16
    80002f04:	00113423          	sd	ra,8(sp)
    80002f08:	00813023          	sd	s0,0(sp)
    80002f0c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002f10:	00000593          	li	a1,0
    80002f14:	00000097          	auipc	ra,0x0
    80002f18:	a10080e7          	jalr	-1520(ra) # 80002924 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002f1c:	00813083          	ld	ra,8(sp)
    80002f20:	00013403          	ld	s0,0(sp)
    80002f24:	01010113          	addi	sp,sp,16
    80002f28:	00008067          	ret

0000000080002f2c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002f2c:	fe010113          	addi	sp,sp,-32
    80002f30:	00113c23          	sd	ra,24(sp)
    80002f34:	00813823          	sd	s0,16(sp)
    80002f38:	00913423          	sd	s1,8(sp)
    80002f3c:	01213023          	sd	s2,0(sp)
    80002f40:	02010413          	addi	s0,sp,32
    80002f44:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002f48:	00100793          	li	a5,1
    80002f4c:	02a7f863          	bgeu	a5,a0,80002f7c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) {
    80002f50:	00a00793          	li	a5,10
    80002f54:	02f577b3          	remu	a5,a0,a5
    80002f58:	02078e63          	beqz	a5,80002f94 <_ZL9fibonaccim+0x68>
        thread_dispatch();
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002f5c:	fff48513          	addi	a0,s1,-1
    80002f60:	00000097          	auipc	ra,0x0
    80002f64:	fcc080e7          	jalr	-52(ra) # 80002f2c <_ZL9fibonaccim>
    80002f68:	00050913          	mv	s2,a0
    80002f6c:	ffe48513          	addi	a0,s1,-2
    80002f70:	00000097          	auipc	ra,0x0
    80002f74:	fbc080e7          	jalr	-68(ra) # 80002f2c <_ZL9fibonaccim>
    80002f78:	00a90533          	add	a0,s2,a0
}
    80002f7c:	01813083          	ld	ra,24(sp)
    80002f80:	01013403          	ld	s0,16(sp)
    80002f84:	00813483          	ld	s1,8(sp)
    80002f88:	00013903          	ld	s2,0(sp)
    80002f8c:	02010113          	addi	sp,sp,32
    80002f90:	00008067          	ret
        thread_dispatch();
    80002f94:	ffffe097          	auipc	ra,0xffffe
    80002f98:	280080e7          	jalr	640(ra) # 80001214 <_Z15thread_dispatchv>
    80002f9c:	fc1ff06f          	j	80002f5c <_ZL9fibonaccim+0x30>

0000000080002fa0 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002fa0:	fe010113          	addi	sp,sp,-32
    80002fa4:	00113c23          	sd	ra,24(sp)
    80002fa8:	00813823          	sd	s0,16(sp)
    80002fac:	00913423          	sd	s1,8(sp)
    80002fb0:	01213023          	sd	s2,0(sp)
    80002fb4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002fb8:	00a00493          	li	s1,10
    80002fbc:	0400006f          	j	80002ffc <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002fc0:	00005517          	auipc	a0,0x5
    80002fc4:	50050513          	addi	a0,a0,1280 # 800084c0 <kvmincrease+0x1360>
    80002fc8:	00001097          	auipc	ra,0x1
    80002fcc:	dc8080e7          	jalr	-568(ra) # 80003d90 <_Z11printStringPKc>
    80002fd0:	00000613          	li	a2,0
    80002fd4:	00a00593          	li	a1,10
    80002fd8:	00048513          	mv	a0,s1
    80002fdc:	00001097          	auipc	ra,0x1
    80002fe0:	f64080e7          	jalr	-156(ra) # 80003f40 <_Z8printIntiii>
    80002fe4:	00005517          	auipc	a0,0x5
    80002fe8:	1a450513          	addi	a0,a0,420 # 80008188 <kvmincrease+0x1028>
    80002fec:	00001097          	auipc	ra,0x1
    80002ff0:	da4080e7          	jalr	-604(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002ff4:	0014849b          	addiw	s1,s1,1
    80002ff8:	0ff4f493          	andi	s1,s1,255
    80002ffc:	00c00793          	li	a5,12
    80003000:	fc97f0e3          	bgeu	a5,s1,80002fc0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003004:	00005517          	auipc	a0,0x5
    80003008:	4c450513          	addi	a0,a0,1220 # 800084c8 <kvmincrease+0x1368>
    8000300c:	00001097          	auipc	ra,0x1
    80003010:	d84080e7          	jalr	-636(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003014:	00500313          	li	t1,5
    thread_dispatch();
    80003018:	ffffe097          	auipc	ra,0xffffe
    8000301c:	1fc080e7          	jalr	508(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80003020:	01000513          	li	a0,16
    80003024:	00000097          	auipc	ra,0x0
    80003028:	f08080e7          	jalr	-248(ra) # 80002f2c <_ZL9fibonaccim>
    8000302c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80003030:	00005517          	auipc	a0,0x5
    80003034:	4a850513          	addi	a0,a0,1192 # 800084d8 <kvmincrease+0x1378>
    80003038:	00001097          	auipc	ra,0x1
    8000303c:	d58080e7          	jalr	-680(ra) # 80003d90 <_Z11printStringPKc>
    80003040:	00000613          	li	a2,0
    80003044:	00a00593          	li	a1,10
    80003048:	0009051b          	sext.w	a0,s2
    8000304c:	00001097          	auipc	ra,0x1
    80003050:	ef4080e7          	jalr	-268(ra) # 80003f40 <_Z8printIntiii>
    80003054:	00005517          	auipc	a0,0x5
    80003058:	13450513          	addi	a0,a0,308 # 80008188 <kvmincrease+0x1028>
    8000305c:	00001097          	auipc	ra,0x1
    80003060:	d34080e7          	jalr	-716(ra) # 80003d90 <_Z11printStringPKc>
    80003064:	0400006f          	j	800030a4 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003068:	00005517          	auipc	a0,0x5
    8000306c:	45850513          	addi	a0,a0,1112 # 800084c0 <kvmincrease+0x1360>
    80003070:	00001097          	auipc	ra,0x1
    80003074:	d20080e7          	jalr	-736(ra) # 80003d90 <_Z11printStringPKc>
    80003078:	00000613          	li	a2,0
    8000307c:	00a00593          	li	a1,10
    80003080:	00048513          	mv	a0,s1
    80003084:	00001097          	auipc	ra,0x1
    80003088:	ebc080e7          	jalr	-324(ra) # 80003f40 <_Z8printIntiii>
    8000308c:	00005517          	auipc	a0,0x5
    80003090:	0fc50513          	addi	a0,a0,252 # 80008188 <kvmincrease+0x1028>
    80003094:	00001097          	auipc	ra,0x1
    80003098:	cfc080e7          	jalr	-772(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000309c:	0014849b          	addiw	s1,s1,1
    800030a0:	0ff4f493          	andi	s1,s1,255
    800030a4:	00f00793          	li	a5,15
    800030a8:	fc97f0e3          	bgeu	a5,s1,80003068 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800030ac:	00005517          	auipc	a0,0x5
    800030b0:	43c50513          	addi	a0,a0,1084 # 800084e8 <kvmincrease+0x1388>
    800030b4:	00001097          	auipc	ra,0x1
    800030b8:	cdc080e7          	jalr	-804(ra) # 80003d90 <_Z11printStringPKc>
    finishedD = true;
    800030bc:	00100793          	li	a5,1
    800030c0:	00007717          	auipc	a4,0x7
    800030c4:	f2f70623          	sb	a5,-212(a4) # 80009fec <_ZL9finishedD>
    thread_dispatch();
    800030c8:	ffffe097          	auipc	ra,0xffffe
    800030cc:	14c080e7          	jalr	332(ra) # 80001214 <_Z15thread_dispatchv>
}
    800030d0:	01813083          	ld	ra,24(sp)
    800030d4:	01013403          	ld	s0,16(sp)
    800030d8:	00813483          	ld	s1,8(sp)
    800030dc:	00013903          	ld	s2,0(sp)
    800030e0:	02010113          	addi	sp,sp,32
    800030e4:	00008067          	ret

00000000800030e8 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800030e8:	fe010113          	addi	sp,sp,-32
    800030ec:	00113c23          	sd	ra,24(sp)
    800030f0:	00813823          	sd	s0,16(sp)
    800030f4:	00913423          	sd	s1,8(sp)
    800030f8:	01213023          	sd	s2,0(sp)
    800030fc:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003100:	00000493          	li	s1,0
    80003104:	0400006f          	j	80003144 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003108:	00005517          	auipc	a0,0x5
    8000310c:	38850513          	addi	a0,a0,904 # 80008490 <kvmincrease+0x1330>
    80003110:	00001097          	auipc	ra,0x1
    80003114:	c80080e7          	jalr	-896(ra) # 80003d90 <_Z11printStringPKc>
    80003118:	00000613          	li	a2,0
    8000311c:	00a00593          	li	a1,10
    80003120:	00048513          	mv	a0,s1
    80003124:	00001097          	auipc	ra,0x1
    80003128:	e1c080e7          	jalr	-484(ra) # 80003f40 <_Z8printIntiii>
    8000312c:	00005517          	auipc	a0,0x5
    80003130:	05c50513          	addi	a0,a0,92 # 80008188 <kvmincrease+0x1028>
    80003134:	00001097          	auipc	ra,0x1
    80003138:	c5c080e7          	jalr	-932(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 3; i++) {
    8000313c:	0014849b          	addiw	s1,s1,1
    80003140:	0ff4f493          	andi	s1,s1,255
    80003144:	00200793          	li	a5,2
    80003148:	fc97f0e3          	bgeu	a5,s1,80003108 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    8000314c:	00005517          	auipc	a0,0x5
    80003150:	34c50513          	addi	a0,a0,844 # 80008498 <kvmincrease+0x1338>
    80003154:	00001097          	auipc	ra,0x1
    80003158:	c3c080e7          	jalr	-964(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    8000315c:	00700313          	li	t1,7
    thread_dispatch();
    80003160:	ffffe097          	auipc	ra,0xffffe
    80003164:	0b4080e7          	jalr	180(ra) # 80001214 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003168:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    8000316c:	00005517          	auipc	a0,0x5
    80003170:	33c50513          	addi	a0,a0,828 # 800084a8 <kvmincrease+0x1348>
    80003174:	00001097          	auipc	ra,0x1
    80003178:	c1c080e7          	jalr	-996(ra) # 80003d90 <_Z11printStringPKc>
    8000317c:	00000613          	li	a2,0
    80003180:	00a00593          	li	a1,10
    80003184:	0009051b          	sext.w	a0,s2
    80003188:	00001097          	auipc	ra,0x1
    8000318c:	db8080e7          	jalr	-584(ra) # 80003f40 <_Z8printIntiii>
    80003190:	00005517          	auipc	a0,0x5
    80003194:	ff850513          	addi	a0,a0,-8 # 80008188 <kvmincrease+0x1028>
    80003198:	00001097          	auipc	ra,0x1
    8000319c:	bf8080e7          	jalr	-1032(ra) # 80003d90 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800031a0:	00c00513          	li	a0,12
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	d88080e7          	jalr	-632(ra) # 80002f2c <_ZL9fibonaccim>
    800031ac:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800031b0:	00005517          	auipc	a0,0x5
    800031b4:	30050513          	addi	a0,a0,768 # 800084b0 <kvmincrease+0x1350>
    800031b8:	00001097          	auipc	ra,0x1
    800031bc:	bd8080e7          	jalr	-1064(ra) # 80003d90 <_Z11printStringPKc>
    800031c0:	00000613          	li	a2,0
    800031c4:	00a00593          	li	a1,10
    800031c8:	0009051b          	sext.w	a0,s2
    800031cc:	00001097          	auipc	ra,0x1
    800031d0:	d74080e7          	jalr	-652(ra) # 80003f40 <_Z8printIntiii>
    800031d4:	00005517          	auipc	a0,0x5
    800031d8:	fb450513          	addi	a0,a0,-76 # 80008188 <kvmincrease+0x1028>
    800031dc:	00001097          	auipc	ra,0x1
    800031e0:	bb4080e7          	jalr	-1100(ra) # 80003d90 <_Z11printStringPKc>
    800031e4:	0400006f          	j	80003224 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800031e8:	00005517          	auipc	a0,0x5
    800031ec:	2a850513          	addi	a0,a0,680 # 80008490 <kvmincrease+0x1330>
    800031f0:	00001097          	auipc	ra,0x1
    800031f4:	ba0080e7          	jalr	-1120(ra) # 80003d90 <_Z11printStringPKc>
    800031f8:	00000613          	li	a2,0
    800031fc:	00a00593          	li	a1,10
    80003200:	00048513          	mv	a0,s1
    80003204:	00001097          	auipc	ra,0x1
    80003208:	d3c080e7          	jalr	-708(ra) # 80003f40 <_Z8printIntiii>
    8000320c:	00005517          	auipc	a0,0x5
    80003210:	f7c50513          	addi	a0,a0,-132 # 80008188 <kvmincrease+0x1028>
    80003214:	00001097          	auipc	ra,0x1
    80003218:	b7c080e7          	jalr	-1156(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 6; i++) {
    8000321c:	0014849b          	addiw	s1,s1,1
    80003220:	0ff4f493          	andi	s1,s1,255
    80003224:	00500793          	li	a5,5
    80003228:	fc97f0e3          	bgeu	a5,s1,800031e8 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    8000322c:	00005517          	auipc	a0,0x5
    80003230:	32c50513          	addi	a0,a0,812 # 80008558 <kvmincrease+0x13f8>
    80003234:	00001097          	auipc	ra,0x1
    80003238:	b5c080e7          	jalr	-1188(ra) # 80003d90 <_Z11printStringPKc>
    finishedC = true;
    8000323c:	00100793          	li	a5,1
    80003240:	00007717          	auipc	a4,0x7
    80003244:	daf706a3          	sb	a5,-595(a4) # 80009fed <_ZL9finishedC>
    thread_dispatch();
    80003248:	ffffe097          	auipc	ra,0xffffe
    8000324c:	fcc080e7          	jalr	-52(ra) # 80001214 <_Z15thread_dispatchv>
}
    80003250:	01813083          	ld	ra,24(sp)
    80003254:	01013403          	ld	s0,16(sp)
    80003258:	00813483          	ld	s1,8(sp)
    8000325c:	00013903          	ld	s2,0(sp)
    80003260:	02010113          	addi	sp,sp,32
    80003264:	00008067          	ret

0000000080003268 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003268:	fe010113          	addi	sp,sp,-32
    8000326c:	00113c23          	sd	ra,24(sp)
    80003270:	00813823          	sd	s0,16(sp)
    80003274:	00913423          	sd	s1,8(sp)
    80003278:	01213023          	sd	s2,0(sp)
    8000327c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003280:	00000913          	li	s2,0
    80003284:	0380006f          	j	800032bc <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003288:	ffffe097          	auipc	ra,0xffffe
    8000328c:	f8c080e7          	jalr	-116(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003290:	00148493          	addi	s1,s1,1
    80003294:	000027b7          	lui	a5,0x2
    80003298:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000329c:	0097ee63          	bltu	a5,s1,800032b8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800032a0:	00000713          	li	a4,0
    800032a4:	000077b7          	lui	a5,0x7
    800032a8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800032ac:	fce7eee3          	bltu	a5,a4,80003288 <_ZL11workerBodyBPv+0x20>
    800032b0:	00170713          	addi	a4,a4,1
    800032b4:	ff1ff06f          	j	800032a4 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800032b8:	00190913          	addi	s2,s2,1
    800032bc:	00f00793          	li	a5,15
    800032c0:	0527e063          	bltu	a5,s2,80003300 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800032c4:	00005517          	auipc	a0,0x5
    800032c8:	1b450513          	addi	a0,a0,436 # 80008478 <kvmincrease+0x1318>
    800032cc:	00001097          	auipc	ra,0x1
    800032d0:	ac4080e7          	jalr	-1340(ra) # 80003d90 <_Z11printStringPKc>
    800032d4:	00000613          	li	a2,0
    800032d8:	00a00593          	li	a1,10
    800032dc:	0009051b          	sext.w	a0,s2
    800032e0:	00001097          	auipc	ra,0x1
    800032e4:	c60080e7          	jalr	-928(ra) # 80003f40 <_Z8printIntiii>
    800032e8:	00005517          	auipc	a0,0x5
    800032ec:	ea050513          	addi	a0,a0,-352 # 80008188 <kvmincrease+0x1028>
    800032f0:	00001097          	auipc	ra,0x1
    800032f4:	aa0080e7          	jalr	-1376(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800032f8:	00000493          	li	s1,0
    800032fc:	f99ff06f          	j	80003294 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003300:	00005517          	auipc	a0,0x5
    80003304:	18050513          	addi	a0,a0,384 # 80008480 <kvmincrease+0x1320>
    80003308:	00001097          	auipc	ra,0x1
    8000330c:	a88080e7          	jalr	-1400(ra) # 80003d90 <_Z11printStringPKc>
    finishedB = true;
    80003310:	00100793          	li	a5,1
    80003314:	00007717          	auipc	a4,0x7
    80003318:	ccf70d23          	sb	a5,-806(a4) # 80009fee <_ZL9finishedB>
    thread_dispatch();
    8000331c:	ffffe097          	auipc	ra,0xffffe
    80003320:	ef8080e7          	jalr	-264(ra) # 80001214 <_Z15thread_dispatchv>
}
    80003324:	01813083          	ld	ra,24(sp)
    80003328:	01013403          	ld	s0,16(sp)
    8000332c:	00813483          	ld	s1,8(sp)
    80003330:	00013903          	ld	s2,0(sp)
    80003334:	02010113          	addi	sp,sp,32
    80003338:	00008067          	ret

000000008000333c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    8000333c:	fe010113          	addi	sp,sp,-32
    80003340:	00113c23          	sd	ra,24(sp)
    80003344:	00813823          	sd	s0,16(sp)
    80003348:	00913423          	sd	s1,8(sp)
    8000334c:	01213023          	sd	s2,0(sp)
    80003350:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003354:	00000913          	li	s2,0
    80003358:	0380006f          	j	80003390 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    8000335c:	ffffe097          	auipc	ra,0xffffe
    80003360:	eb8080e7          	jalr	-328(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003364:	00148493          	addi	s1,s1,1
    80003368:	000027b7          	lui	a5,0x2
    8000336c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003370:	0097ee63          	bltu	a5,s1,8000338c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003374:	00000713          	li	a4,0
    80003378:	000077b7          	lui	a5,0x7
    8000337c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003380:	fce7eee3          	bltu	a5,a4,8000335c <_ZL11workerBodyAPv+0x20>
    80003384:	00170713          	addi	a4,a4,1
    80003388:	ff1ff06f          	j	80003378 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000338c:	00190913          	addi	s2,s2,1
    80003390:	00900793          	li	a5,9
    80003394:	0527e063          	bltu	a5,s2,800033d4 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003398:	00005517          	auipc	a0,0x5
    8000339c:	0c850513          	addi	a0,a0,200 # 80008460 <kvmincrease+0x1300>
    800033a0:	00001097          	auipc	ra,0x1
    800033a4:	9f0080e7          	jalr	-1552(ra) # 80003d90 <_Z11printStringPKc>
    800033a8:	00000613          	li	a2,0
    800033ac:	00a00593          	li	a1,10
    800033b0:	0009051b          	sext.w	a0,s2
    800033b4:	00001097          	auipc	ra,0x1
    800033b8:	b8c080e7          	jalr	-1140(ra) # 80003f40 <_Z8printIntiii>
    800033bc:	00005517          	auipc	a0,0x5
    800033c0:	dcc50513          	addi	a0,a0,-564 # 80008188 <kvmincrease+0x1028>
    800033c4:	00001097          	auipc	ra,0x1
    800033c8:	9cc080e7          	jalr	-1588(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800033cc:	00000493          	li	s1,0
    800033d0:	f99ff06f          	j	80003368 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800033d4:	00005517          	auipc	a0,0x5
    800033d8:	09450513          	addi	a0,a0,148 # 80008468 <kvmincrease+0x1308>
    800033dc:	00001097          	auipc	ra,0x1
    800033e0:	9b4080e7          	jalr	-1612(ra) # 80003d90 <_Z11printStringPKc>
    finishedA = true;
    800033e4:	00100793          	li	a5,1
    800033e8:	00007717          	auipc	a4,0x7
    800033ec:	c0f703a3          	sb	a5,-1017(a4) # 80009fef <_ZL9finishedA>
}
    800033f0:	01813083          	ld	ra,24(sp)
    800033f4:	01013403          	ld	s0,16(sp)
    800033f8:	00813483          	ld	s1,8(sp)
    800033fc:	00013903          	ld	s2,0(sp)
    80003400:	02010113          	addi	sp,sp,32
    80003404:	00008067          	ret

0000000080003408 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003408:	fd010113          	addi	sp,sp,-48
    8000340c:	02113423          	sd	ra,40(sp)
    80003410:	02813023          	sd	s0,32(sp)
    80003414:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80003418:	00000613          	li	a2,0
    8000341c:	00000597          	auipc	a1,0x0
    80003420:	f2058593          	addi	a1,a1,-224 # 8000333c <_ZL11workerBodyAPv>
    80003424:	fd040513          	addi	a0,s0,-48
    80003428:	ffffe097          	auipc	ra,0xffffe
    8000342c:	d94080e7          	jalr	-620(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80003430:	00005517          	auipc	a0,0x5
    80003434:	0c850513          	addi	a0,a0,200 # 800084f8 <kvmincrease+0x1398>
    80003438:	00001097          	auipc	ra,0x1
    8000343c:	958080e7          	jalr	-1704(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80003440:	00000613          	li	a2,0
    80003444:	00000597          	auipc	a1,0x0
    80003448:	e2458593          	addi	a1,a1,-476 # 80003268 <_ZL11workerBodyBPv>
    8000344c:	fd840513          	addi	a0,s0,-40
    80003450:	ffffe097          	auipc	ra,0xffffe
    80003454:	d6c080e7          	jalr	-660(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80003458:	00005517          	auipc	a0,0x5
    8000345c:	0b850513          	addi	a0,a0,184 # 80008510 <kvmincrease+0x13b0>
    80003460:	00001097          	auipc	ra,0x1
    80003464:	930080e7          	jalr	-1744(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80003468:	00000613          	li	a2,0
    8000346c:	00000597          	auipc	a1,0x0
    80003470:	c7c58593          	addi	a1,a1,-900 # 800030e8 <_ZL11workerBodyCPv>
    80003474:	fe040513          	addi	a0,s0,-32
    80003478:	ffffe097          	auipc	ra,0xffffe
    8000347c:	d44080e7          	jalr	-700(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003480:	00005517          	auipc	a0,0x5
    80003484:	0a850513          	addi	a0,a0,168 # 80008528 <kvmincrease+0x13c8>
    80003488:	00001097          	auipc	ra,0x1
    8000348c:	908080e7          	jalr	-1784(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003490:	00000613          	li	a2,0
    80003494:	00000597          	auipc	a1,0x0
    80003498:	b0c58593          	addi	a1,a1,-1268 # 80002fa0 <_ZL11workerBodyDPv>
    8000349c:	fe840513          	addi	a0,s0,-24
    800034a0:	ffffe097          	auipc	ra,0xffffe
    800034a4:	d1c080e7          	jalr	-740(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800034a8:	00005517          	auipc	a0,0x5
    800034ac:	09850513          	addi	a0,a0,152 # 80008540 <kvmincrease+0x13e0>
    800034b0:	00001097          	auipc	ra,0x1
    800034b4:	8e0080e7          	jalr	-1824(ra) # 80003d90 <_Z11printStringPKc>
    800034b8:	00c0006f          	j	800034c4 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800034bc:	ffffe097          	auipc	ra,0xffffe
    800034c0:	d58080e7          	jalr	-680(ra) # 80001214 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800034c4:	00007797          	auipc	a5,0x7
    800034c8:	b2b7c783          	lbu	a5,-1237(a5) # 80009fef <_ZL9finishedA>
    800034cc:	fe0788e3          	beqz	a5,800034bc <_Z18Threads_C_API_testv+0xb4>
    800034d0:	00007797          	auipc	a5,0x7
    800034d4:	b1e7c783          	lbu	a5,-1250(a5) # 80009fee <_ZL9finishedB>
    800034d8:	fe0782e3          	beqz	a5,800034bc <_Z18Threads_C_API_testv+0xb4>
    800034dc:	00007797          	auipc	a5,0x7
    800034e0:	b117c783          	lbu	a5,-1263(a5) # 80009fed <_ZL9finishedC>
    800034e4:	fc078ce3          	beqz	a5,800034bc <_Z18Threads_C_API_testv+0xb4>
    800034e8:	00007797          	auipc	a5,0x7
    800034ec:	b047c783          	lbu	a5,-1276(a5) # 80009fec <_ZL9finishedD>
    800034f0:	fc0786e3          	beqz	a5,800034bc <_Z18Threads_C_API_testv+0xb4>
    }

}
    800034f4:	02813083          	ld	ra,40(sp)
    800034f8:	02013403          	ld	s0,32(sp)
    800034fc:	03010113          	addi	sp,sp,48
    80003500:	00008067          	ret

0000000080003504 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003504:	fd010113          	addi	sp,sp,-48
    80003508:	02113423          	sd	ra,40(sp)
    8000350c:	02813023          	sd	s0,32(sp)
    80003510:	00913c23          	sd	s1,24(sp)
    80003514:	01213823          	sd	s2,16(sp)
    80003518:	01313423          	sd	s3,8(sp)
    8000351c:	03010413          	addi	s0,sp,48
    80003520:	00050993          	mv	s3,a0
    80003524:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003528:	00000913          	li	s2,0
    8000352c:	00c0006f          	j	80003538 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003530:	ffffe097          	auipc	ra,0xffffe
    80003534:	45c080e7          	jalr	1116(ra) # 8000198c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80003538:	ffffe097          	auipc	ra,0xffffe
    8000353c:	db0080e7          	jalr	-592(ra) # 800012e8 <_Z4getcv>
    80003540:	0005059b          	sext.w	a1,a0
    80003544:	01b00793          	li	a5,27
    80003548:	02f58a63          	beq	a1,a5,8000357c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000354c:	0084b503          	ld	a0,8(s1)
    80003550:	00001097          	auipc	ra,0x1
    80003554:	c64080e7          	jalr	-924(ra) # 800041b4 <_ZN9BufferCPP3putEi>
        i++;
    80003558:	0019071b          	addiw	a4,s2,1
    8000355c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003560:	0004a683          	lw	a3,0(s1)
    80003564:	0026979b          	slliw	a5,a3,0x2
    80003568:	00d787bb          	addw	a5,a5,a3
    8000356c:	0017979b          	slliw	a5,a5,0x1
    80003570:	02f767bb          	remw	a5,a4,a5
    80003574:	fc0792e3          	bnez	a5,80003538 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80003578:	fb9ff06f          	j	80003530 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000357c:	00100793          	li	a5,1
    80003580:	00007717          	auipc	a4,0x7
    80003584:	a6f72823          	sw	a5,-1424(a4) # 80009ff0 <_ZL9threadEnd>
    td->buffer->put('!');
    80003588:	0209b783          	ld	a5,32(s3)
    8000358c:	02100593          	li	a1,33
    80003590:	0087b503          	ld	a0,8(a5)
    80003594:	00001097          	auipc	ra,0x1
    80003598:	c20080e7          	jalr	-992(ra) # 800041b4 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000359c:	0104b503          	ld	a0,16(s1)
    800035a0:	ffffe097          	auipc	ra,0xffffe
    800035a4:	4a0080e7          	jalr	1184(ra) # 80001a40 <_ZN9Semaphore6signalEv>
}
    800035a8:	02813083          	ld	ra,40(sp)
    800035ac:	02013403          	ld	s0,32(sp)
    800035b0:	01813483          	ld	s1,24(sp)
    800035b4:	01013903          	ld	s2,16(sp)
    800035b8:	00813983          	ld	s3,8(sp)
    800035bc:	03010113          	addi	sp,sp,48
    800035c0:	00008067          	ret

00000000800035c4 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800035c4:	fe010113          	addi	sp,sp,-32
    800035c8:	00113c23          	sd	ra,24(sp)
    800035cc:	00813823          	sd	s0,16(sp)
    800035d0:	00913423          	sd	s1,8(sp)
    800035d4:	01213023          	sd	s2,0(sp)
    800035d8:	02010413          	addi	s0,sp,32
    800035dc:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800035e0:	00000913          	li	s2,0
    800035e4:	00c0006f          	j	800035f0 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800035e8:	ffffe097          	auipc	ra,0xffffe
    800035ec:	3a4080e7          	jalr	932(ra) # 8000198c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800035f0:	00007797          	auipc	a5,0x7
    800035f4:	a007a783          	lw	a5,-1536(a5) # 80009ff0 <_ZL9threadEnd>
    800035f8:	02079e63          	bnez	a5,80003634 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800035fc:	0004a583          	lw	a1,0(s1)
    80003600:	0305859b          	addiw	a1,a1,48
    80003604:	0084b503          	ld	a0,8(s1)
    80003608:	00001097          	auipc	ra,0x1
    8000360c:	bac080e7          	jalr	-1108(ra) # 800041b4 <_ZN9BufferCPP3putEi>
        i++;
    80003610:	0019071b          	addiw	a4,s2,1
    80003614:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003618:	0004a683          	lw	a3,0(s1)
    8000361c:	0026979b          	slliw	a5,a3,0x2
    80003620:	00d787bb          	addw	a5,a5,a3
    80003624:	0017979b          	slliw	a5,a5,0x1
    80003628:	02f767bb          	remw	a5,a4,a5
    8000362c:	fc0792e3          	bnez	a5,800035f0 <_ZN12ProducerSync8producerEPv+0x2c>
    80003630:	fb9ff06f          	j	800035e8 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80003634:	0104b503          	ld	a0,16(s1)
    80003638:	ffffe097          	auipc	ra,0xffffe
    8000363c:	408080e7          	jalr	1032(ra) # 80001a40 <_ZN9Semaphore6signalEv>
}
    80003640:	01813083          	ld	ra,24(sp)
    80003644:	01013403          	ld	s0,16(sp)
    80003648:	00813483          	ld	s1,8(sp)
    8000364c:	00013903          	ld	s2,0(sp)
    80003650:	02010113          	addi	sp,sp,32
    80003654:	00008067          	ret

0000000080003658 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80003658:	fd010113          	addi	sp,sp,-48
    8000365c:	02113423          	sd	ra,40(sp)
    80003660:	02813023          	sd	s0,32(sp)
    80003664:	00913c23          	sd	s1,24(sp)
    80003668:	01213823          	sd	s2,16(sp)
    8000366c:	01313423          	sd	s3,8(sp)
    80003670:	01413023          	sd	s4,0(sp)
    80003674:	03010413          	addi	s0,sp,48
    80003678:	00050993          	mv	s3,a0
    8000367c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003680:	00000a13          	li	s4,0
    80003684:	01c0006f          	j	800036a0 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80003688:	ffffe097          	auipc	ra,0xffffe
    8000368c:	304080e7          	jalr	772(ra) # 8000198c <_ZN6Thread8dispatchEv>
    80003690:	0500006f          	j	800036e0 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003694:	00a00513          	li	a0,10
    80003698:	ffffe097          	auipc	ra,0xffffe
    8000369c:	c7c080e7          	jalr	-900(ra) # 80001314 <_Z4putcc>
    while (!threadEnd) {
    800036a0:	00007797          	auipc	a5,0x7
    800036a4:	9507a783          	lw	a5,-1712(a5) # 80009ff0 <_ZL9threadEnd>
    800036a8:	06079263          	bnez	a5,8000370c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800036ac:	00893503          	ld	a0,8(s2)
    800036b0:	00001097          	auipc	ra,0x1
    800036b4:	b94080e7          	jalr	-1132(ra) # 80004244 <_ZN9BufferCPP3getEv>
        i++;
    800036b8:	001a049b          	addiw	s1,s4,1
    800036bc:	00048a1b          	sext.w	s4,s1
        putc(key);
    800036c0:	0ff57513          	andi	a0,a0,255
    800036c4:	ffffe097          	auipc	ra,0xffffe
    800036c8:	c50080e7          	jalr	-944(ra) # 80001314 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800036cc:	00092703          	lw	a4,0(s2)
    800036d0:	0027179b          	slliw	a5,a4,0x2
    800036d4:	00e787bb          	addw	a5,a5,a4
    800036d8:	02f4e7bb          	remw	a5,s1,a5
    800036dc:	fa0786e3          	beqz	a5,80003688 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800036e0:	05000793          	li	a5,80
    800036e4:	02f4e4bb          	remw	s1,s1,a5
    800036e8:	fa049ce3          	bnez	s1,800036a0 <_ZN12ConsumerSync8consumerEPv+0x48>
    800036ec:	fa9ff06f          	j	80003694 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800036f0:	0209b783          	ld	a5,32(s3)
    800036f4:	0087b503          	ld	a0,8(a5)
    800036f8:	00001097          	auipc	ra,0x1
    800036fc:	b4c080e7          	jalr	-1204(ra) # 80004244 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003700:	0ff57513          	andi	a0,a0,255
    80003704:	ffffe097          	auipc	ra,0xffffe
    80003708:	1d8080e7          	jalr	472(ra) # 800018dc <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    8000370c:	0209b783          	ld	a5,32(s3)
    80003710:	0087b503          	ld	a0,8(a5)
    80003714:	00001097          	auipc	ra,0x1
    80003718:	bbc080e7          	jalr	-1092(ra) # 800042d0 <_ZN9BufferCPP6getCntEv>
    8000371c:	fca04ae3          	bgtz	a0,800036f0 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80003720:	01093503          	ld	a0,16(s2)
    80003724:	ffffe097          	auipc	ra,0xffffe
    80003728:	31c080e7          	jalr	796(ra) # 80001a40 <_ZN9Semaphore6signalEv>
}
    8000372c:	02813083          	ld	ra,40(sp)
    80003730:	02013403          	ld	s0,32(sp)
    80003734:	01813483          	ld	s1,24(sp)
    80003738:	01013903          	ld	s2,16(sp)
    8000373c:	00813983          	ld	s3,8(sp)
    80003740:	00013a03          	ld	s4,0(sp)
    80003744:	03010113          	addi	sp,sp,48
    80003748:	00008067          	ret

000000008000374c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    8000374c:	f8010113          	addi	sp,sp,-128
    80003750:	06113c23          	sd	ra,120(sp)
    80003754:	06813823          	sd	s0,112(sp)
    80003758:	06913423          	sd	s1,104(sp)
    8000375c:	07213023          	sd	s2,96(sp)
    80003760:	05313c23          	sd	s3,88(sp)
    80003764:	05413823          	sd	s4,80(sp)
    80003768:	05513423          	sd	s5,72(sp)
    8000376c:	05613023          	sd	s6,64(sp)
    80003770:	03713c23          	sd	s7,56(sp)
    80003774:	03813823          	sd	s8,48(sp)
    80003778:	03913423          	sd	s9,40(sp)
    8000377c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003780:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003784:	00005517          	auipc	a0,0x5
    80003788:	bf450513          	addi	a0,a0,-1036 # 80008378 <kvmincrease+0x1218>
    8000378c:	00000097          	auipc	ra,0x0
    80003790:	604080e7          	jalr	1540(ra) # 80003d90 <_Z11printStringPKc>
    getString(input, 30);
    80003794:	01e00593          	li	a1,30
    80003798:	f8040493          	addi	s1,s0,-128
    8000379c:	00048513          	mv	a0,s1
    800037a0:	00000097          	auipc	ra,0x0
    800037a4:	678080e7          	jalr	1656(ra) # 80003e18 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800037a8:	00048513          	mv	a0,s1
    800037ac:	00000097          	auipc	ra,0x0
    800037b0:	744080e7          	jalr	1860(ra) # 80003ef0 <_Z11stringToIntPKc>
    800037b4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800037b8:	00005517          	auipc	a0,0x5
    800037bc:	be050513          	addi	a0,a0,-1056 # 80008398 <kvmincrease+0x1238>
    800037c0:	00000097          	auipc	ra,0x0
    800037c4:	5d0080e7          	jalr	1488(ra) # 80003d90 <_Z11printStringPKc>
    getString(input, 30);
    800037c8:	01e00593          	li	a1,30
    800037cc:	00048513          	mv	a0,s1
    800037d0:	00000097          	auipc	ra,0x0
    800037d4:	648080e7          	jalr	1608(ra) # 80003e18 <_Z9getStringPci>
    n = stringToInt(input);
    800037d8:	00048513          	mv	a0,s1
    800037dc:	00000097          	auipc	ra,0x0
    800037e0:	714080e7          	jalr	1812(ra) # 80003ef0 <_Z11stringToIntPKc>
    800037e4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800037e8:	00005517          	auipc	a0,0x5
    800037ec:	bd050513          	addi	a0,a0,-1072 # 800083b8 <kvmincrease+0x1258>
    800037f0:	00000097          	auipc	ra,0x0
    800037f4:	5a0080e7          	jalr	1440(ra) # 80003d90 <_Z11printStringPKc>
    800037f8:	00000613          	li	a2,0
    800037fc:	00a00593          	li	a1,10
    80003800:	00090513          	mv	a0,s2
    80003804:	00000097          	auipc	ra,0x0
    80003808:	73c080e7          	jalr	1852(ra) # 80003f40 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000380c:	00005517          	auipc	a0,0x5
    80003810:	bc450513          	addi	a0,a0,-1084 # 800083d0 <kvmincrease+0x1270>
    80003814:	00000097          	auipc	ra,0x0
    80003818:	57c080e7          	jalr	1404(ra) # 80003d90 <_Z11printStringPKc>
    8000381c:	00000613          	li	a2,0
    80003820:	00a00593          	li	a1,10
    80003824:	00048513          	mv	a0,s1
    80003828:	00000097          	auipc	ra,0x0
    8000382c:	718080e7          	jalr	1816(ra) # 80003f40 <_Z8printIntiii>
    printString(".\n");
    80003830:	00005517          	auipc	a0,0x5
    80003834:	bb850513          	addi	a0,a0,-1096 # 800083e8 <kvmincrease+0x1288>
    80003838:	00000097          	auipc	ra,0x0
    8000383c:	558080e7          	jalr	1368(ra) # 80003d90 <_Z11printStringPKc>
    if(threadNum > n) {
    80003840:	0324c463          	blt	s1,s2,80003868 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80003844:	03205c63          	blez	s2,8000387c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80003848:	03800513          	li	a0,56
    8000384c:	ffffe097          	auipc	ra,0xffffe
    80003850:	ee4080e7          	jalr	-284(ra) # 80001730 <_Znwm>
    80003854:	00050a93          	mv	s5,a0
    80003858:	00048593          	mv	a1,s1
    8000385c:	00001097          	auipc	ra,0x1
    80003860:	804080e7          	jalr	-2044(ra) # 80004060 <_ZN9BufferCPPC1Ei>
    80003864:	0300006f          	j	80003894 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003868:	00005517          	auipc	a0,0x5
    8000386c:	b8850513          	addi	a0,a0,-1144 # 800083f0 <kvmincrease+0x1290>
    80003870:	00000097          	auipc	ra,0x0
    80003874:	520080e7          	jalr	1312(ra) # 80003d90 <_Z11printStringPKc>
        return;
    80003878:	0140006f          	j	8000388c <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000387c:	00005517          	auipc	a0,0x5
    80003880:	bb450513          	addi	a0,a0,-1100 # 80008430 <kvmincrease+0x12d0>
    80003884:	00000097          	auipc	ra,0x0
    80003888:	50c080e7          	jalr	1292(ra) # 80003d90 <_Z11printStringPKc>
        return;
    8000388c:	000b8113          	mv	sp,s7
    80003890:	2380006f          	j	80003ac8 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003894:	01000513          	li	a0,16
    80003898:	ffffe097          	auipc	ra,0xffffe
    8000389c:	e98080e7          	jalr	-360(ra) # 80001730 <_Znwm>
    800038a0:	00050493          	mv	s1,a0
    800038a4:	00000593          	li	a1,0
    800038a8:	ffffe097          	auipc	ra,0xffffe
    800038ac:	1c4080e7          	jalr	452(ra) # 80001a6c <_ZN9SemaphoreC1Ej>
    800038b0:	00006797          	auipc	a5,0x6
    800038b4:	7497b423          	sd	s1,1864(a5) # 80009ff8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800038b8:	00391793          	slli	a5,s2,0x3
    800038bc:	00f78793          	addi	a5,a5,15
    800038c0:	ff07f793          	andi	a5,a5,-16
    800038c4:	40f10133          	sub	sp,sp,a5
    800038c8:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800038cc:	0019071b          	addiw	a4,s2,1
    800038d0:	00171793          	slli	a5,a4,0x1
    800038d4:	00e787b3          	add	a5,a5,a4
    800038d8:	00379793          	slli	a5,a5,0x3
    800038dc:	00f78793          	addi	a5,a5,15
    800038e0:	ff07f793          	andi	a5,a5,-16
    800038e4:	40f10133          	sub	sp,sp,a5
    800038e8:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800038ec:	00191c13          	slli	s8,s2,0x1
    800038f0:	012c07b3          	add	a5,s8,s2
    800038f4:	00379793          	slli	a5,a5,0x3
    800038f8:	00fa07b3          	add	a5,s4,a5
    800038fc:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003900:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003904:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003908:	02800513          	li	a0,40
    8000390c:	ffffe097          	auipc	ra,0xffffe
    80003910:	e24080e7          	jalr	-476(ra) # 80001730 <_Znwm>
    80003914:	00050b13          	mv	s6,a0
    80003918:	012c0c33          	add	s8,s8,s2
    8000391c:	003c1c13          	slli	s8,s8,0x3
    80003920:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003924:	ffffe097          	auipc	ra,0xffffe
    80003928:	090080e7          	jalr	144(ra) # 800019b4 <_ZN6ThreadC1Ev>
    8000392c:	00006797          	auipc	a5,0x6
    80003930:	5f478793          	addi	a5,a5,1524 # 80009f20 <_ZTV12ConsumerSync+0x10>
    80003934:	00fb3023          	sd	a5,0(s6)
    80003938:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    8000393c:	000b0513          	mv	a0,s6
    80003940:	ffffe097          	auipc	ra,0xffffe
    80003944:	018080e7          	jalr	24(ra) # 80001958 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003948:	00000493          	li	s1,0
    8000394c:	0380006f          	j	80003984 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003950:	00006797          	auipc	a5,0x6
    80003954:	5a878793          	addi	a5,a5,1448 # 80009ef8 <_ZTV12ProducerSync+0x10>
    80003958:	00fcb023          	sd	a5,0(s9)
    8000395c:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003960:	00349793          	slli	a5,s1,0x3
    80003964:	00f987b3          	add	a5,s3,a5
    80003968:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    8000396c:	00349793          	slli	a5,s1,0x3
    80003970:	00f987b3          	add	a5,s3,a5
    80003974:	0007b503          	ld	a0,0(a5)
    80003978:	ffffe097          	auipc	ra,0xffffe
    8000397c:	fe0080e7          	jalr	-32(ra) # 80001958 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003980:	0014849b          	addiw	s1,s1,1
    80003984:	0b24d063          	bge	s1,s2,80003a24 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003988:	00149793          	slli	a5,s1,0x1
    8000398c:	009787b3          	add	a5,a5,s1
    80003990:	00379793          	slli	a5,a5,0x3
    80003994:	00fa07b3          	add	a5,s4,a5
    80003998:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000399c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800039a0:	00006717          	auipc	a4,0x6
    800039a4:	65873703          	ld	a4,1624(a4) # 80009ff8 <_ZL10waitForAll>
    800039a8:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800039ac:	02905863          	blez	s1,800039dc <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    800039b0:	02800513          	li	a0,40
    800039b4:	ffffe097          	auipc	ra,0xffffe
    800039b8:	d7c080e7          	jalr	-644(ra) # 80001730 <_Znwm>
    800039bc:	00050c93          	mv	s9,a0
    800039c0:	00149c13          	slli	s8,s1,0x1
    800039c4:	009c0c33          	add	s8,s8,s1
    800039c8:	003c1c13          	slli	s8,s8,0x3
    800039cc:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800039d0:	ffffe097          	auipc	ra,0xffffe
    800039d4:	fe4080e7          	jalr	-28(ra) # 800019b4 <_ZN6ThreadC1Ev>
    800039d8:	f79ff06f          	j	80003950 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    800039dc:	02800513          	li	a0,40
    800039e0:	ffffe097          	auipc	ra,0xffffe
    800039e4:	d50080e7          	jalr	-688(ra) # 80001730 <_Znwm>
    800039e8:	00050c93          	mv	s9,a0
    800039ec:	00149c13          	slli	s8,s1,0x1
    800039f0:	009c0c33          	add	s8,s8,s1
    800039f4:	003c1c13          	slli	s8,s8,0x3
    800039f8:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800039fc:	ffffe097          	auipc	ra,0xffffe
    80003a00:	fb8080e7          	jalr	-72(ra) # 800019b4 <_ZN6ThreadC1Ev>
    80003a04:	00006797          	auipc	a5,0x6
    80003a08:	4cc78793          	addi	a5,a5,1228 # 80009ed0 <_ZTV16ProducerKeyboard+0x10>
    80003a0c:	00fcb023          	sd	a5,0(s9)
    80003a10:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80003a14:	00349793          	slli	a5,s1,0x3
    80003a18:	00f987b3          	add	a5,s3,a5
    80003a1c:	0197b023          	sd	s9,0(a5)
    80003a20:	f4dff06f          	j	8000396c <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80003a24:	ffffe097          	auipc	ra,0xffffe
    80003a28:	f68080e7          	jalr	-152(ra) # 8000198c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003a2c:	00000493          	li	s1,0
    80003a30:	00994e63          	blt	s2,s1,80003a4c <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80003a34:	00006517          	auipc	a0,0x6
    80003a38:	5c453503          	ld	a0,1476(a0) # 80009ff8 <_ZL10waitForAll>
    80003a3c:	ffffe097          	auipc	ra,0xffffe
    80003a40:	fd8080e7          	jalr	-40(ra) # 80001a14 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003a44:	0014849b          	addiw	s1,s1,1
    80003a48:	fe9ff06f          	j	80003a30 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003a4c:	00000493          	li	s1,0
    80003a50:	0080006f          	j	80003a58 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003a54:	0014849b          	addiw	s1,s1,1
    80003a58:	0324d263          	bge	s1,s2,80003a7c <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003a5c:	00349793          	slli	a5,s1,0x3
    80003a60:	00f987b3          	add	a5,s3,a5
    80003a64:	0007b503          	ld	a0,0(a5)
    80003a68:	fe0506e3          	beqz	a0,80003a54 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003a6c:	00053783          	ld	a5,0(a0)
    80003a70:	0087b783          	ld	a5,8(a5)
    80003a74:	000780e7          	jalr	a5
    80003a78:	fddff06f          	j	80003a54 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003a7c:	000b0a63          	beqz	s6,80003a90 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003a80:	000b3783          	ld	a5,0(s6)
    80003a84:	0087b783          	ld	a5,8(a5)
    80003a88:	000b0513          	mv	a0,s6
    80003a8c:	000780e7          	jalr	a5
    delete waitForAll;
    80003a90:	00006517          	auipc	a0,0x6
    80003a94:	56853503          	ld	a0,1384(a0) # 80009ff8 <_ZL10waitForAll>
    80003a98:	00050863          	beqz	a0,80003aa8 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003a9c:	00053783          	ld	a5,0(a0)
    80003aa0:	0087b783          	ld	a5,8(a5)
    80003aa4:	000780e7          	jalr	a5
    delete buffer;
    80003aa8:	000a8e63          	beqz	s5,80003ac4 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003aac:	000a8513          	mv	a0,s5
    80003ab0:	00001097          	auipc	ra,0x1
    80003ab4:	8a8080e7          	jalr	-1880(ra) # 80004358 <_ZN9BufferCPPD1Ev>
    80003ab8:	000a8513          	mv	a0,s5
    80003abc:	ffffe097          	auipc	ra,0xffffe
    80003ac0:	cc4080e7          	jalr	-828(ra) # 80001780 <_ZdlPv>
    80003ac4:	000b8113          	mv	sp,s7

}
    80003ac8:	f8040113          	addi	sp,s0,-128
    80003acc:	07813083          	ld	ra,120(sp)
    80003ad0:	07013403          	ld	s0,112(sp)
    80003ad4:	06813483          	ld	s1,104(sp)
    80003ad8:	06013903          	ld	s2,96(sp)
    80003adc:	05813983          	ld	s3,88(sp)
    80003ae0:	05013a03          	ld	s4,80(sp)
    80003ae4:	04813a83          	ld	s5,72(sp)
    80003ae8:	04013b03          	ld	s6,64(sp)
    80003aec:	03813b83          	ld	s7,56(sp)
    80003af0:	03013c03          	ld	s8,48(sp)
    80003af4:	02813c83          	ld	s9,40(sp)
    80003af8:	08010113          	addi	sp,sp,128
    80003afc:	00008067          	ret
    80003b00:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003b04:	000a8513          	mv	a0,s5
    80003b08:	ffffe097          	auipc	ra,0xffffe
    80003b0c:	c78080e7          	jalr	-904(ra) # 80001780 <_ZdlPv>
    80003b10:	00048513          	mv	a0,s1
    80003b14:	00007097          	auipc	ra,0x7
    80003b18:	5c4080e7          	jalr	1476(ra) # 8000b0d8 <_Unwind_Resume>
    80003b1c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003b20:	00048513          	mv	a0,s1
    80003b24:	ffffe097          	auipc	ra,0xffffe
    80003b28:	c5c080e7          	jalr	-932(ra) # 80001780 <_ZdlPv>
    80003b2c:	00090513          	mv	a0,s2
    80003b30:	00007097          	auipc	ra,0x7
    80003b34:	5a8080e7          	jalr	1448(ra) # 8000b0d8 <_Unwind_Resume>
    80003b38:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003b3c:	000b0513          	mv	a0,s6
    80003b40:	ffffe097          	auipc	ra,0xffffe
    80003b44:	c40080e7          	jalr	-960(ra) # 80001780 <_ZdlPv>
    80003b48:	00048513          	mv	a0,s1
    80003b4c:	00007097          	auipc	ra,0x7
    80003b50:	58c080e7          	jalr	1420(ra) # 8000b0d8 <_Unwind_Resume>
    80003b54:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003b58:	000c8513          	mv	a0,s9
    80003b5c:	ffffe097          	auipc	ra,0xffffe
    80003b60:	c24080e7          	jalr	-988(ra) # 80001780 <_ZdlPv>
    80003b64:	00048513          	mv	a0,s1
    80003b68:	00007097          	auipc	ra,0x7
    80003b6c:	570080e7          	jalr	1392(ra) # 8000b0d8 <_Unwind_Resume>
    80003b70:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003b74:	000c8513          	mv	a0,s9
    80003b78:	ffffe097          	auipc	ra,0xffffe
    80003b7c:	c08080e7          	jalr	-1016(ra) # 80001780 <_ZdlPv>
    80003b80:	00048513          	mv	a0,s1
    80003b84:	00007097          	auipc	ra,0x7
    80003b88:	554080e7          	jalr	1364(ra) # 8000b0d8 <_Unwind_Resume>

0000000080003b8c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003b8c:	ff010113          	addi	sp,sp,-16
    80003b90:	00113423          	sd	ra,8(sp)
    80003b94:	00813023          	sd	s0,0(sp)
    80003b98:	01010413          	addi	s0,sp,16
    80003b9c:	00006797          	auipc	a5,0x6
    80003ba0:	38478793          	addi	a5,a5,900 # 80009f20 <_ZTV12ConsumerSync+0x10>
    80003ba4:	00f53023          	sd	a5,0(a0)
    80003ba8:	ffffe097          	auipc	ra,0xffffe
    80003bac:	c28080e7          	jalr	-984(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003bb0:	00813083          	ld	ra,8(sp)
    80003bb4:	00013403          	ld	s0,0(sp)
    80003bb8:	01010113          	addi	sp,sp,16
    80003bbc:	00008067          	ret

0000000080003bc0 <_ZN12ConsumerSyncD0Ev>:
    80003bc0:	fe010113          	addi	sp,sp,-32
    80003bc4:	00113c23          	sd	ra,24(sp)
    80003bc8:	00813823          	sd	s0,16(sp)
    80003bcc:	00913423          	sd	s1,8(sp)
    80003bd0:	02010413          	addi	s0,sp,32
    80003bd4:	00050493          	mv	s1,a0
    80003bd8:	00006797          	auipc	a5,0x6
    80003bdc:	34878793          	addi	a5,a5,840 # 80009f20 <_ZTV12ConsumerSync+0x10>
    80003be0:	00f53023          	sd	a5,0(a0)
    80003be4:	ffffe097          	auipc	ra,0xffffe
    80003be8:	bec080e7          	jalr	-1044(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003bec:	00048513          	mv	a0,s1
    80003bf0:	ffffe097          	auipc	ra,0xffffe
    80003bf4:	b90080e7          	jalr	-1136(ra) # 80001780 <_ZdlPv>
    80003bf8:	01813083          	ld	ra,24(sp)
    80003bfc:	01013403          	ld	s0,16(sp)
    80003c00:	00813483          	ld	s1,8(sp)
    80003c04:	02010113          	addi	sp,sp,32
    80003c08:	00008067          	ret

0000000080003c0c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003c0c:	ff010113          	addi	sp,sp,-16
    80003c10:	00113423          	sd	ra,8(sp)
    80003c14:	00813023          	sd	s0,0(sp)
    80003c18:	01010413          	addi	s0,sp,16
    80003c1c:	00006797          	auipc	a5,0x6
    80003c20:	2dc78793          	addi	a5,a5,732 # 80009ef8 <_ZTV12ProducerSync+0x10>
    80003c24:	00f53023          	sd	a5,0(a0)
    80003c28:	ffffe097          	auipc	ra,0xffffe
    80003c2c:	ba8080e7          	jalr	-1112(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003c30:	00813083          	ld	ra,8(sp)
    80003c34:	00013403          	ld	s0,0(sp)
    80003c38:	01010113          	addi	sp,sp,16
    80003c3c:	00008067          	ret

0000000080003c40 <_ZN12ProducerSyncD0Ev>:
    80003c40:	fe010113          	addi	sp,sp,-32
    80003c44:	00113c23          	sd	ra,24(sp)
    80003c48:	00813823          	sd	s0,16(sp)
    80003c4c:	00913423          	sd	s1,8(sp)
    80003c50:	02010413          	addi	s0,sp,32
    80003c54:	00050493          	mv	s1,a0
    80003c58:	00006797          	auipc	a5,0x6
    80003c5c:	2a078793          	addi	a5,a5,672 # 80009ef8 <_ZTV12ProducerSync+0x10>
    80003c60:	00f53023          	sd	a5,0(a0)
    80003c64:	ffffe097          	auipc	ra,0xffffe
    80003c68:	b6c080e7          	jalr	-1172(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003c6c:	00048513          	mv	a0,s1
    80003c70:	ffffe097          	auipc	ra,0xffffe
    80003c74:	b10080e7          	jalr	-1264(ra) # 80001780 <_ZdlPv>
    80003c78:	01813083          	ld	ra,24(sp)
    80003c7c:	01013403          	ld	s0,16(sp)
    80003c80:	00813483          	ld	s1,8(sp)
    80003c84:	02010113          	addi	sp,sp,32
    80003c88:	00008067          	ret

0000000080003c8c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003c8c:	ff010113          	addi	sp,sp,-16
    80003c90:	00113423          	sd	ra,8(sp)
    80003c94:	00813023          	sd	s0,0(sp)
    80003c98:	01010413          	addi	s0,sp,16
    80003c9c:	00006797          	auipc	a5,0x6
    80003ca0:	23478793          	addi	a5,a5,564 # 80009ed0 <_ZTV16ProducerKeyboard+0x10>
    80003ca4:	00f53023          	sd	a5,0(a0)
    80003ca8:	ffffe097          	auipc	ra,0xffffe
    80003cac:	b28080e7          	jalr	-1240(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003cb0:	00813083          	ld	ra,8(sp)
    80003cb4:	00013403          	ld	s0,0(sp)
    80003cb8:	01010113          	addi	sp,sp,16
    80003cbc:	00008067          	ret

0000000080003cc0 <_ZN16ProducerKeyboardD0Ev>:
    80003cc0:	fe010113          	addi	sp,sp,-32
    80003cc4:	00113c23          	sd	ra,24(sp)
    80003cc8:	00813823          	sd	s0,16(sp)
    80003ccc:	00913423          	sd	s1,8(sp)
    80003cd0:	02010413          	addi	s0,sp,32
    80003cd4:	00050493          	mv	s1,a0
    80003cd8:	00006797          	auipc	a5,0x6
    80003cdc:	1f878793          	addi	a5,a5,504 # 80009ed0 <_ZTV16ProducerKeyboard+0x10>
    80003ce0:	00f53023          	sd	a5,0(a0)
    80003ce4:	ffffe097          	auipc	ra,0xffffe
    80003ce8:	aec080e7          	jalr	-1300(ra) # 800017d0 <_ZN6ThreadD1Ev>
    80003cec:	00048513          	mv	a0,s1
    80003cf0:	ffffe097          	auipc	ra,0xffffe
    80003cf4:	a90080e7          	jalr	-1392(ra) # 80001780 <_ZdlPv>
    80003cf8:	01813083          	ld	ra,24(sp)
    80003cfc:	01013403          	ld	s0,16(sp)
    80003d00:	00813483          	ld	s1,8(sp)
    80003d04:	02010113          	addi	sp,sp,32
    80003d08:	00008067          	ret

0000000080003d0c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003d0c:	ff010113          	addi	sp,sp,-16
    80003d10:	00113423          	sd	ra,8(sp)
    80003d14:	00813023          	sd	s0,0(sp)
    80003d18:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003d1c:	02053583          	ld	a1,32(a0)
    80003d20:	fffff097          	auipc	ra,0xfffff
    80003d24:	7e4080e7          	jalr	2020(ra) # 80003504 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003d28:	00813083          	ld	ra,8(sp)
    80003d2c:	00013403          	ld	s0,0(sp)
    80003d30:	01010113          	addi	sp,sp,16
    80003d34:	00008067          	ret

0000000080003d38 <_ZN12ProducerSync3runEv>:
    void run() override {
    80003d38:	ff010113          	addi	sp,sp,-16
    80003d3c:	00113423          	sd	ra,8(sp)
    80003d40:	00813023          	sd	s0,0(sp)
    80003d44:	01010413          	addi	s0,sp,16
        producer(td);
    80003d48:	02053583          	ld	a1,32(a0)
    80003d4c:	00000097          	auipc	ra,0x0
    80003d50:	878080e7          	jalr	-1928(ra) # 800035c4 <_ZN12ProducerSync8producerEPv>
    }
    80003d54:	00813083          	ld	ra,8(sp)
    80003d58:	00013403          	ld	s0,0(sp)
    80003d5c:	01010113          	addi	sp,sp,16
    80003d60:	00008067          	ret

0000000080003d64 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003d64:	ff010113          	addi	sp,sp,-16
    80003d68:	00113423          	sd	ra,8(sp)
    80003d6c:	00813023          	sd	s0,0(sp)
    80003d70:	01010413          	addi	s0,sp,16
        consumer(td);
    80003d74:	02053583          	ld	a1,32(a0)
    80003d78:	00000097          	auipc	ra,0x0
    80003d7c:	8e0080e7          	jalr	-1824(ra) # 80003658 <_ZN12ConsumerSync8consumerEPv>
    }
    80003d80:	00813083          	ld	ra,8(sp)
    80003d84:	00013403          	ld	s0,0(sp)
    80003d88:	01010113          	addi	sp,sp,16
    80003d8c:	00008067          	ret

0000000080003d90 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003d90:	fe010113          	addi	sp,sp,-32
    80003d94:	00113c23          	sd	ra,24(sp)
    80003d98:	00813823          	sd	s0,16(sp)
    80003d9c:	00913423          	sd	s1,8(sp)
    80003da0:	02010413          	addi	s0,sp,32
    80003da4:	00050493          	mv	s1,a0
    LOCK();
    80003da8:	00100613          	li	a2,1
    80003dac:	00000593          	li	a1,0
    80003db0:	00006517          	auipc	a0,0x6
    80003db4:	25050513          	addi	a0,a0,592 # 8000a000 <lockPrint>
    80003db8:	ffffd097          	auipc	ra,0xffffd
    80003dbc:	248080e7          	jalr	584(ra) # 80001000 <copy_and_swap>
    80003dc0:	00050863          	beqz	a0,80003dd0 <_Z11printStringPKc+0x40>
    80003dc4:	ffffd097          	auipc	ra,0xffffd
    80003dc8:	450080e7          	jalr	1104(ra) # 80001214 <_Z15thread_dispatchv>
    80003dcc:	fddff06f          	j	80003da8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003dd0:	0004c503          	lbu	a0,0(s1)
    80003dd4:	00050a63          	beqz	a0,80003de8 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003dd8:	ffffd097          	auipc	ra,0xffffd
    80003ddc:	53c080e7          	jalr	1340(ra) # 80001314 <_Z4putcc>
        string++;
    80003de0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003de4:	fedff06f          	j	80003dd0 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003de8:	00000613          	li	a2,0
    80003dec:	00100593          	li	a1,1
    80003df0:	00006517          	auipc	a0,0x6
    80003df4:	21050513          	addi	a0,a0,528 # 8000a000 <lockPrint>
    80003df8:	ffffd097          	auipc	ra,0xffffd
    80003dfc:	208080e7          	jalr	520(ra) # 80001000 <copy_and_swap>
    80003e00:	fe0514e3          	bnez	a0,80003de8 <_Z11printStringPKc+0x58>
}
    80003e04:	01813083          	ld	ra,24(sp)
    80003e08:	01013403          	ld	s0,16(sp)
    80003e0c:	00813483          	ld	s1,8(sp)
    80003e10:	02010113          	addi	sp,sp,32
    80003e14:	00008067          	ret

0000000080003e18 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003e18:	fd010113          	addi	sp,sp,-48
    80003e1c:	02113423          	sd	ra,40(sp)
    80003e20:	02813023          	sd	s0,32(sp)
    80003e24:	00913c23          	sd	s1,24(sp)
    80003e28:	01213823          	sd	s2,16(sp)
    80003e2c:	01313423          	sd	s3,8(sp)
    80003e30:	01413023          	sd	s4,0(sp)
    80003e34:	03010413          	addi	s0,sp,48
    80003e38:	00050993          	mv	s3,a0
    80003e3c:	00058a13          	mv	s4,a1
    LOCK();
    80003e40:	00100613          	li	a2,1
    80003e44:	00000593          	li	a1,0
    80003e48:	00006517          	auipc	a0,0x6
    80003e4c:	1b850513          	addi	a0,a0,440 # 8000a000 <lockPrint>
    80003e50:	ffffd097          	auipc	ra,0xffffd
    80003e54:	1b0080e7          	jalr	432(ra) # 80001000 <copy_and_swap>
    80003e58:	00050863          	beqz	a0,80003e68 <_Z9getStringPci+0x50>
    80003e5c:	ffffd097          	auipc	ra,0xffffd
    80003e60:	3b8080e7          	jalr	952(ra) # 80001214 <_Z15thread_dispatchv>
    80003e64:	fddff06f          	j	80003e40 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003e68:	00000913          	li	s2,0
    80003e6c:	00090493          	mv	s1,s2
    80003e70:	0019091b          	addiw	s2,s2,1
    80003e74:	03495a63          	bge	s2,s4,80003ea8 <_Z9getStringPci+0x90>
        cc = getc();
    80003e78:	ffffd097          	auipc	ra,0xffffd
    80003e7c:	470080e7          	jalr	1136(ra) # 800012e8 <_Z4getcv>
        if(cc < 1)
    80003e80:	02050463          	beqz	a0,80003ea8 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003e84:	009984b3          	add	s1,s3,s1
    80003e88:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003e8c:	00a00793          	li	a5,10
    80003e90:	00f50a63          	beq	a0,a5,80003ea4 <_Z9getStringPci+0x8c>
    80003e94:	00d00793          	li	a5,13
    80003e98:	fcf51ae3          	bne	a0,a5,80003e6c <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003e9c:	00090493          	mv	s1,s2
    80003ea0:	0080006f          	j	80003ea8 <_Z9getStringPci+0x90>
    80003ea4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003ea8:	009984b3          	add	s1,s3,s1
    80003eac:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003eb0:	00000613          	li	a2,0
    80003eb4:	00100593          	li	a1,1
    80003eb8:	00006517          	auipc	a0,0x6
    80003ebc:	14850513          	addi	a0,a0,328 # 8000a000 <lockPrint>
    80003ec0:	ffffd097          	auipc	ra,0xffffd
    80003ec4:	140080e7          	jalr	320(ra) # 80001000 <copy_and_swap>
    80003ec8:	fe0514e3          	bnez	a0,80003eb0 <_Z9getStringPci+0x98>
    return buf;
}
    80003ecc:	00098513          	mv	a0,s3
    80003ed0:	02813083          	ld	ra,40(sp)
    80003ed4:	02013403          	ld	s0,32(sp)
    80003ed8:	01813483          	ld	s1,24(sp)
    80003edc:	01013903          	ld	s2,16(sp)
    80003ee0:	00813983          	ld	s3,8(sp)
    80003ee4:	00013a03          	ld	s4,0(sp)
    80003ee8:	03010113          	addi	sp,sp,48
    80003eec:	00008067          	ret

0000000080003ef0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003ef0:	ff010113          	addi	sp,sp,-16
    80003ef4:	00813423          	sd	s0,8(sp)
    80003ef8:	01010413          	addi	s0,sp,16
    80003efc:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003f00:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003f04:	0006c603          	lbu	a2,0(a3)
    80003f08:	fd06071b          	addiw	a4,a2,-48
    80003f0c:	0ff77713          	andi	a4,a4,255
    80003f10:	00900793          	li	a5,9
    80003f14:	02e7e063          	bltu	a5,a4,80003f34 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003f18:	0025179b          	slliw	a5,a0,0x2
    80003f1c:	00a787bb          	addw	a5,a5,a0
    80003f20:	0017979b          	slliw	a5,a5,0x1
    80003f24:	00168693          	addi	a3,a3,1
    80003f28:	00c787bb          	addw	a5,a5,a2
    80003f2c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003f30:	fd5ff06f          	j	80003f04 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003f34:	00813403          	ld	s0,8(sp)
    80003f38:	01010113          	addi	sp,sp,16
    80003f3c:	00008067          	ret

0000000080003f40 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003f40:	fc010113          	addi	sp,sp,-64
    80003f44:	02113c23          	sd	ra,56(sp)
    80003f48:	02813823          	sd	s0,48(sp)
    80003f4c:	02913423          	sd	s1,40(sp)
    80003f50:	03213023          	sd	s2,32(sp)
    80003f54:	01313c23          	sd	s3,24(sp)
    80003f58:	04010413          	addi	s0,sp,64
    80003f5c:	00050493          	mv	s1,a0
    80003f60:	00058913          	mv	s2,a1
    80003f64:	00060993          	mv	s3,a2
    LOCK();
    80003f68:	00100613          	li	a2,1
    80003f6c:	00000593          	li	a1,0
    80003f70:	00006517          	auipc	a0,0x6
    80003f74:	09050513          	addi	a0,a0,144 # 8000a000 <lockPrint>
    80003f78:	ffffd097          	auipc	ra,0xffffd
    80003f7c:	088080e7          	jalr	136(ra) # 80001000 <copy_and_swap>
    80003f80:	00050863          	beqz	a0,80003f90 <_Z8printIntiii+0x50>
    80003f84:	ffffd097          	auipc	ra,0xffffd
    80003f88:	290080e7          	jalr	656(ra) # 80001214 <_Z15thread_dispatchv>
    80003f8c:	fddff06f          	j	80003f68 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003f90:	00098463          	beqz	s3,80003f98 <_Z8printIntiii+0x58>
    80003f94:	0804c463          	bltz	s1,8000401c <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003f98:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003f9c:	00000593          	li	a1,0
    }

    i = 0;
    80003fa0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003fa4:	0009079b          	sext.w	a5,s2
    80003fa8:	0325773b          	remuw	a4,a0,s2
    80003fac:	00048613          	mv	a2,s1
    80003fb0:	0014849b          	addiw	s1,s1,1
    80003fb4:	02071693          	slli	a3,a4,0x20
    80003fb8:	0206d693          	srli	a3,a3,0x20
    80003fbc:	00006717          	auipc	a4,0x6
    80003fc0:	f7c70713          	addi	a4,a4,-132 # 80009f38 <digits>
    80003fc4:	00d70733          	add	a4,a4,a3
    80003fc8:	00074683          	lbu	a3,0(a4)
    80003fcc:	fd040713          	addi	a4,s0,-48
    80003fd0:	00c70733          	add	a4,a4,a2
    80003fd4:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003fd8:	0005071b          	sext.w	a4,a0
    80003fdc:	0325553b          	divuw	a0,a0,s2
    80003fe0:	fcf772e3          	bgeu	a4,a5,80003fa4 <_Z8printIntiii+0x64>
    if(neg)
    80003fe4:	00058c63          	beqz	a1,80003ffc <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003fe8:	fd040793          	addi	a5,s0,-48
    80003fec:	009784b3          	add	s1,a5,s1
    80003ff0:	02d00793          	li	a5,45
    80003ff4:	fef48823          	sb	a5,-16(s1)
    80003ff8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003ffc:	fff4849b          	addiw	s1,s1,-1
    80004000:	0204c463          	bltz	s1,80004028 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004004:	fd040793          	addi	a5,s0,-48
    80004008:	009787b3          	add	a5,a5,s1
    8000400c:	ff07c503          	lbu	a0,-16(a5)
    80004010:	ffffd097          	auipc	ra,0xffffd
    80004014:	304080e7          	jalr	772(ra) # 80001314 <_Z4putcc>
    80004018:	fe5ff06f          	j	80003ffc <_Z8printIntiii+0xbc>
        x = -xx;
    8000401c:	4090053b          	negw	a0,s1
        neg = 1;
    80004020:	00100593          	li	a1,1
        x = -xx;
    80004024:	f7dff06f          	j	80003fa0 <_Z8printIntiii+0x60>

    UNLOCK();
    80004028:	00000613          	li	a2,0
    8000402c:	00100593          	li	a1,1
    80004030:	00006517          	auipc	a0,0x6
    80004034:	fd050513          	addi	a0,a0,-48 # 8000a000 <lockPrint>
    80004038:	ffffd097          	auipc	ra,0xffffd
    8000403c:	fc8080e7          	jalr	-56(ra) # 80001000 <copy_and_swap>
    80004040:	fe0514e3          	bnez	a0,80004028 <_Z8printIntiii+0xe8>
    80004044:	03813083          	ld	ra,56(sp)
    80004048:	03013403          	ld	s0,48(sp)
    8000404c:	02813483          	ld	s1,40(sp)
    80004050:	02013903          	ld	s2,32(sp)
    80004054:	01813983          	ld	s3,24(sp)
    80004058:	04010113          	addi	sp,sp,64
    8000405c:	00008067          	ret

0000000080004060 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004060:	fd010113          	addi	sp,sp,-48
    80004064:	02113423          	sd	ra,40(sp)
    80004068:	02813023          	sd	s0,32(sp)
    8000406c:	00913c23          	sd	s1,24(sp)
    80004070:	01213823          	sd	s2,16(sp)
    80004074:	01313423          	sd	s3,8(sp)
    80004078:	03010413          	addi	s0,sp,48
    8000407c:	00050493          	mv	s1,a0
    80004080:	00058913          	mv	s2,a1
    80004084:	0015879b          	addiw	a5,a1,1
    80004088:	0007851b          	sext.w	a0,a5
    8000408c:	00f4a023          	sw	a5,0(s1)
    80004090:	0004a823          	sw	zero,16(s1)
    80004094:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004098:	00251513          	slli	a0,a0,0x2
    8000409c:	ffffd097          	auipc	ra,0xffffd
    800040a0:	0cc080e7          	jalr	204(ra) # 80001168 <_Z9mem_allocm>
    800040a4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800040a8:	01000513          	li	a0,16
    800040ac:	ffffd097          	auipc	ra,0xffffd
    800040b0:	684080e7          	jalr	1668(ra) # 80001730 <_Znwm>
    800040b4:	00050993          	mv	s3,a0
    800040b8:	00000593          	li	a1,0
    800040bc:	ffffe097          	auipc	ra,0xffffe
    800040c0:	9b0080e7          	jalr	-1616(ra) # 80001a6c <_ZN9SemaphoreC1Ej>
    800040c4:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800040c8:	01000513          	li	a0,16
    800040cc:	ffffd097          	auipc	ra,0xffffd
    800040d0:	664080e7          	jalr	1636(ra) # 80001730 <_Znwm>
    800040d4:	00050993          	mv	s3,a0
    800040d8:	00090593          	mv	a1,s2
    800040dc:	ffffe097          	auipc	ra,0xffffe
    800040e0:	990080e7          	jalr	-1648(ra) # 80001a6c <_ZN9SemaphoreC1Ej>
    800040e4:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800040e8:	01000513          	li	a0,16
    800040ec:	ffffd097          	auipc	ra,0xffffd
    800040f0:	644080e7          	jalr	1604(ra) # 80001730 <_Znwm>
    800040f4:	00050913          	mv	s2,a0
    800040f8:	00100593          	li	a1,1
    800040fc:	ffffe097          	auipc	ra,0xffffe
    80004100:	970080e7          	jalr	-1680(ra) # 80001a6c <_ZN9SemaphoreC1Ej>
    80004104:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004108:	01000513          	li	a0,16
    8000410c:	ffffd097          	auipc	ra,0xffffd
    80004110:	624080e7          	jalr	1572(ra) # 80001730 <_Znwm>
    80004114:	00050913          	mv	s2,a0
    80004118:	00100593          	li	a1,1
    8000411c:	ffffe097          	auipc	ra,0xffffe
    80004120:	950080e7          	jalr	-1712(ra) # 80001a6c <_ZN9SemaphoreC1Ej>
    80004124:	0324b823          	sd	s2,48(s1)
}
    80004128:	02813083          	ld	ra,40(sp)
    8000412c:	02013403          	ld	s0,32(sp)
    80004130:	01813483          	ld	s1,24(sp)
    80004134:	01013903          	ld	s2,16(sp)
    80004138:	00813983          	ld	s3,8(sp)
    8000413c:	03010113          	addi	sp,sp,48
    80004140:	00008067          	ret
    80004144:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80004148:	00098513          	mv	a0,s3
    8000414c:	ffffd097          	auipc	ra,0xffffd
    80004150:	634080e7          	jalr	1588(ra) # 80001780 <_ZdlPv>
    80004154:	00048513          	mv	a0,s1
    80004158:	00007097          	auipc	ra,0x7
    8000415c:	f80080e7          	jalr	-128(ra) # 8000b0d8 <_Unwind_Resume>
    80004160:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004164:	00098513          	mv	a0,s3
    80004168:	ffffd097          	auipc	ra,0xffffd
    8000416c:	618080e7          	jalr	1560(ra) # 80001780 <_ZdlPv>
    80004170:	00048513          	mv	a0,s1
    80004174:	00007097          	auipc	ra,0x7
    80004178:	f64080e7          	jalr	-156(ra) # 8000b0d8 <_Unwind_Resume>
    8000417c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004180:	00090513          	mv	a0,s2
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	5fc080e7          	jalr	1532(ra) # 80001780 <_ZdlPv>
    8000418c:	00048513          	mv	a0,s1
    80004190:	00007097          	auipc	ra,0x7
    80004194:	f48080e7          	jalr	-184(ra) # 8000b0d8 <_Unwind_Resume>
    80004198:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000419c:	00090513          	mv	a0,s2
    800041a0:	ffffd097          	auipc	ra,0xffffd
    800041a4:	5e0080e7          	jalr	1504(ra) # 80001780 <_ZdlPv>
    800041a8:	00048513          	mv	a0,s1
    800041ac:	00007097          	auipc	ra,0x7
    800041b0:	f2c080e7          	jalr	-212(ra) # 8000b0d8 <_Unwind_Resume>

00000000800041b4 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800041b4:	fe010113          	addi	sp,sp,-32
    800041b8:	00113c23          	sd	ra,24(sp)
    800041bc:	00813823          	sd	s0,16(sp)
    800041c0:	00913423          	sd	s1,8(sp)
    800041c4:	01213023          	sd	s2,0(sp)
    800041c8:	02010413          	addi	s0,sp,32
    800041cc:	00050493          	mv	s1,a0
    800041d0:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800041d4:	01853503          	ld	a0,24(a0)
    800041d8:	ffffe097          	auipc	ra,0xffffe
    800041dc:	83c080e7          	jalr	-1988(ra) # 80001a14 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800041e0:	0304b503          	ld	a0,48(s1)
    800041e4:	ffffe097          	auipc	ra,0xffffe
    800041e8:	830080e7          	jalr	-2000(ra) # 80001a14 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800041ec:	0084b783          	ld	a5,8(s1)
    800041f0:	0144a703          	lw	a4,20(s1)
    800041f4:	00271713          	slli	a4,a4,0x2
    800041f8:	00e787b3          	add	a5,a5,a4
    800041fc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004200:	0144a783          	lw	a5,20(s1)
    80004204:	0017879b          	addiw	a5,a5,1
    80004208:	0004a703          	lw	a4,0(s1)
    8000420c:	02e7e7bb          	remw	a5,a5,a4
    80004210:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004214:	0304b503          	ld	a0,48(s1)
    80004218:	ffffe097          	auipc	ra,0xffffe
    8000421c:	828080e7          	jalr	-2008(ra) # 80001a40 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004220:	0204b503          	ld	a0,32(s1)
    80004224:	ffffe097          	auipc	ra,0xffffe
    80004228:	81c080e7          	jalr	-2020(ra) # 80001a40 <_ZN9Semaphore6signalEv>

}
    8000422c:	01813083          	ld	ra,24(sp)
    80004230:	01013403          	ld	s0,16(sp)
    80004234:	00813483          	ld	s1,8(sp)
    80004238:	00013903          	ld	s2,0(sp)
    8000423c:	02010113          	addi	sp,sp,32
    80004240:	00008067          	ret

0000000080004244 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004244:	fe010113          	addi	sp,sp,-32
    80004248:	00113c23          	sd	ra,24(sp)
    8000424c:	00813823          	sd	s0,16(sp)
    80004250:	00913423          	sd	s1,8(sp)
    80004254:	01213023          	sd	s2,0(sp)
    80004258:	02010413          	addi	s0,sp,32
    8000425c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004260:	02053503          	ld	a0,32(a0)
    80004264:	ffffd097          	auipc	ra,0xffffd
    80004268:	7b0080e7          	jalr	1968(ra) # 80001a14 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    8000426c:	0284b503          	ld	a0,40(s1)
    80004270:	ffffd097          	auipc	ra,0xffffd
    80004274:	7a4080e7          	jalr	1956(ra) # 80001a14 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004278:	0084b703          	ld	a4,8(s1)
    8000427c:	0104a783          	lw	a5,16(s1)
    80004280:	00279693          	slli	a3,a5,0x2
    80004284:	00d70733          	add	a4,a4,a3
    80004288:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000428c:	0017879b          	addiw	a5,a5,1
    80004290:	0004a703          	lw	a4,0(s1)
    80004294:	02e7e7bb          	remw	a5,a5,a4
    80004298:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000429c:	0284b503          	ld	a0,40(s1)
    800042a0:	ffffd097          	auipc	ra,0xffffd
    800042a4:	7a0080e7          	jalr	1952(ra) # 80001a40 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800042a8:	0184b503          	ld	a0,24(s1)
    800042ac:	ffffd097          	auipc	ra,0xffffd
    800042b0:	794080e7          	jalr	1940(ra) # 80001a40 <_ZN9Semaphore6signalEv>

    return ret;
}
    800042b4:	00090513          	mv	a0,s2
    800042b8:	01813083          	ld	ra,24(sp)
    800042bc:	01013403          	ld	s0,16(sp)
    800042c0:	00813483          	ld	s1,8(sp)
    800042c4:	00013903          	ld	s2,0(sp)
    800042c8:	02010113          	addi	sp,sp,32
    800042cc:	00008067          	ret

00000000800042d0 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800042d0:	fe010113          	addi	sp,sp,-32
    800042d4:	00113c23          	sd	ra,24(sp)
    800042d8:	00813823          	sd	s0,16(sp)
    800042dc:	00913423          	sd	s1,8(sp)
    800042e0:	01213023          	sd	s2,0(sp)
    800042e4:	02010413          	addi	s0,sp,32
    800042e8:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800042ec:	02853503          	ld	a0,40(a0)
    800042f0:	ffffd097          	auipc	ra,0xffffd
    800042f4:	724080e7          	jalr	1828(ra) # 80001a14 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800042f8:	0304b503          	ld	a0,48(s1)
    800042fc:	ffffd097          	auipc	ra,0xffffd
    80004300:	718080e7          	jalr	1816(ra) # 80001a14 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004304:	0144a783          	lw	a5,20(s1)
    80004308:	0104a903          	lw	s2,16(s1)
    8000430c:	0327ce63          	blt	a5,s2,80004348 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004310:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004314:	0304b503          	ld	a0,48(s1)
    80004318:	ffffd097          	auipc	ra,0xffffd
    8000431c:	728080e7          	jalr	1832(ra) # 80001a40 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004320:	0284b503          	ld	a0,40(s1)
    80004324:	ffffd097          	auipc	ra,0xffffd
    80004328:	71c080e7          	jalr	1820(ra) # 80001a40 <_ZN9Semaphore6signalEv>

    return ret;
}
    8000432c:	00090513          	mv	a0,s2
    80004330:	01813083          	ld	ra,24(sp)
    80004334:	01013403          	ld	s0,16(sp)
    80004338:	00813483          	ld	s1,8(sp)
    8000433c:	00013903          	ld	s2,0(sp)
    80004340:	02010113          	addi	sp,sp,32
    80004344:	00008067          	ret
        ret = cap - head + tail;
    80004348:	0004a703          	lw	a4,0(s1)
    8000434c:	4127093b          	subw	s2,a4,s2
    80004350:	00f9093b          	addw	s2,s2,a5
    80004354:	fc1ff06f          	j	80004314 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004358 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004358:	fe010113          	addi	sp,sp,-32
    8000435c:	00113c23          	sd	ra,24(sp)
    80004360:	00813823          	sd	s0,16(sp)
    80004364:	00913423          	sd	s1,8(sp)
    80004368:	02010413          	addi	s0,sp,32
    8000436c:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004370:	00a00513          	li	a0,10
    80004374:	ffffd097          	auipc	ra,0xffffd
    80004378:	568080e7          	jalr	1384(ra) # 800018dc <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000437c:	00004517          	auipc	a0,0x4
    80004380:	1ec50513          	addi	a0,a0,492 # 80008568 <kvmincrease+0x1408>
    80004384:	00000097          	auipc	ra,0x0
    80004388:	a0c080e7          	jalr	-1524(ra) # 80003d90 <_Z11printStringPKc>
    while (getCnt()) {
    8000438c:	00048513          	mv	a0,s1
    80004390:	00000097          	auipc	ra,0x0
    80004394:	f40080e7          	jalr	-192(ra) # 800042d0 <_ZN9BufferCPP6getCntEv>
    80004398:	02050c63          	beqz	a0,800043d0 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000439c:	0084b783          	ld	a5,8(s1)
    800043a0:	0104a703          	lw	a4,16(s1)
    800043a4:	00271713          	slli	a4,a4,0x2
    800043a8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800043ac:	0007c503          	lbu	a0,0(a5)
    800043b0:	ffffd097          	auipc	ra,0xffffd
    800043b4:	52c080e7          	jalr	1324(ra) # 800018dc <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800043b8:	0104a783          	lw	a5,16(s1)
    800043bc:	0017879b          	addiw	a5,a5,1
    800043c0:	0004a703          	lw	a4,0(s1)
    800043c4:	02e7e7bb          	remw	a5,a5,a4
    800043c8:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800043cc:	fc1ff06f          	j	8000438c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800043d0:	02100513          	li	a0,33
    800043d4:	ffffd097          	auipc	ra,0xffffd
    800043d8:	508080e7          	jalr	1288(ra) # 800018dc <_ZN7Console4putcEc>
    Console::putc('\n');
    800043dc:	00a00513          	li	a0,10
    800043e0:	ffffd097          	auipc	ra,0xffffd
    800043e4:	4fc080e7          	jalr	1276(ra) # 800018dc <_ZN7Console4putcEc>
    mem_free(buffer);
    800043e8:	0084b503          	ld	a0,8(s1)
    800043ec:	ffffd097          	auipc	ra,0xffffd
    800043f0:	da4080e7          	jalr	-604(ra) # 80001190 <_Z8mem_freePv>
    delete itemAvailable;
    800043f4:	0204b503          	ld	a0,32(s1)
    800043f8:	00050863          	beqz	a0,80004408 <_ZN9BufferCPPD1Ev+0xb0>
    800043fc:	00053783          	ld	a5,0(a0)
    80004400:	0087b783          	ld	a5,8(a5)
    80004404:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004408:	0184b503          	ld	a0,24(s1)
    8000440c:	00050863          	beqz	a0,8000441c <_ZN9BufferCPPD1Ev+0xc4>
    80004410:	00053783          	ld	a5,0(a0)
    80004414:	0087b783          	ld	a5,8(a5)
    80004418:	000780e7          	jalr	a5
    delete mutexTail;
    8000441c:	0304b503          	ld	a0,48(s1)
    80004420:	00050863          	beqz	a0,80004430 <_ZN9BufferCPPD1Ev+0xd8>
    80004424:	00053783          	ld	a5,0(a0)
    80004428:	0087b783          	ld	a5,8(a5)
    8000442c:	000780e7          	jalr	a5
    delete mutexHead;
    80004430:	0284b503          	ld	a0,40(s1)
    80004434:	00050863          	beqz	a0,80004444 <_ZN9BufferCPPD1Ev+0xec>
    80004438:	00053783          	ld	a5,0(a0)
    8000443c:	0087b783          	ld	a5,8(a5)
    80004440:	000780e7          	jalr	a5
}
    80004444:	01813083          	ld	ra,24(sp)
    80004448:	01013403          	ld	s0,16(sp)
    8000444c:	00813483          	ld	s1,8(sp)
    80004450:	02010113          	addi	sp,sp,32
    80004454:	00008067          	ret

0000000080004458 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004458:	fe010113          	addi	sp,sp,-32
    8000445c:	00113c23          	sd	ra,24(sp)
    80004460:	00813823          	sd	s0,16(sp)
    80004464:	00913423          	sd	s1,8(sp)
    80004468:	01213023          	sd	s2,0(sp)
    8000446c:	02010413          	addi	s0,sp,32
    80004470:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004474:	00100793          	li	a5,1
    80004478:	02a7f863          	bgeu	a5,a0,800044a8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000447c:	00a00793          	li	a5,10
    80004480:	02f577b3          	remu	a5,a0,a5
    80004484:	02078e63          	beqz	a5,800044c0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004488:	fff48513          	addi	a0,s1,-1
    8000448c:	00000097          	auipc	ra,0x0
    80004490:	fcc080e7          	jalr	-52(ra) # 80004458 <_ZL9fibonaccim>
    80004494:	00050913          	mv	s2,a0
    80004498:	ffe48513          	addi	a0,s1,-2
    8000449c:	00000097          	auipc	ra,0x0
    800044a0:	fbc080e7          	jalr	-68(ra) # 80004458 <_ZL9fibonaccim>
    800044a4:	00a90533          	add	a0,s2,a0
}
    800044a8:	01813083          	ld	ra,24(sp)
    800044ac:	01013403          	ld	s0,16(sp)
    800044b0:	00813483          	ld	s1,8(sp)
    800044b4:	00013903          	ld	s2,0(sp)
    800044b8:	02010113          	addi	sp,sp,32
    800044bc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800044c0:	ffffd097          	auipc	ra,0xffffd
    800044c4:	d54080e7          	jalr	-684(ra) # 80001214 <_Z15thread_dispatchv>
    800044c8:	fc1ff06f          	j	80004488 <_ZL9fibonaccim+0x30>

00000000800044cc <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800044cc:	fe010113          	addi	sp,sp,-32
    800044d0:	00113c23          	sd	ra,24(sp)
    800044d4:	00813823          	sd	s0,16(sp)
    800044d8:	00913423          	sd	s1,8(sp)
    800044dc:	01213023          	sd	s2,0(sp)
    800044e0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800044e4:	00a00493          	li	s1,10
    800044e8:	0400006f          	j	80004528 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800044ec:	00004517          	auipc	a0,0x4
    800044f0:	fd450513          	addi	a0,a0,-44 # 800084c0 <kvmincrease+0x1360>
    800044f4:	00000097          	auipc	ra,0x0
    800044f8:	89c080e7          	jalr	-1892(ra) # 80003d90 <_Z11printStringPKc>
    800044fc:	00000613          	li	a2,0
    80004500:	00a00593          	li	a1,10
    80004504:	00048513          	mv	a0,s1
    80004508:	00000097          	auipc	ra,0x0
    8000450c:	a38080e7          	jalr	-1480(ra) # 80003f40 <_Z8printIntiii>
    80004510:	00004517          	auipc	a0,0x4
    80004514:	c7850513          	addi	a0,a0,-904 # 80008188 <kvmincrease+0x1028>
    80004518:	00000097          	auipc	ra,0x0
    8000451c:	878080e7          	jalr	-1928(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004520:	0014849b          	addiw	s1,s1,1
    80004524:	0ff4f493          	andi	s1,s1,255
    80004528:	00c00793          	li	a5,12
    8000452c:	fc97f0e3          	bgeu	a5,s1,800044ec <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004530:	00004517          	auipc	a0,0x4
    80004534:	f9850513          	addi	a0,a0,-104 # 800084c8 <kvmincrease+0x1368>
    80004538:	00000097          	auipc	ra,0x0
    8000453c:	858080e7          	jalr	-1960(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004540:	00500313          	li	t1,5
    thread_dispatch();
    80004544:	ffffd097          	auipc	ra,0xffffd
    80004548:	cd0080e7          	jalr	-816(ra) # 80001214 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000454c:	01000513          	li	a0,16
    80004550:	00000097          	auipc	ra,0x0
    80004554:	f08080e7          	jalr	-248(ra) # 80004458 <_ZL9fibonaccim>
    80004558:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000455c:	00004517          	auipc	a0,0x4
    80004560:	f7c50513          	addi	a0,a0,-132 # 800084d8 <kvmincrease+0x1378>
    80004564:	00000097          	auipc	ra,0x0
    80004568:	82c080e7          	jalr	-2004(ra) # 80003d90 <_Z11printStringPKc>
    8000456c:	00000613          	li	a2,0
    80004570:	00a00593          	li	a1,10
    80004574:	0009051b          	sext.w	a0,s2
    80004578:	00000097          	auipc	ra,0x0
    8000457c:	9c8080e7          	jalr	-1592(ra) # 80003f40 <_Z8printIntiii>
    80004580:	00004517          	auipc	a0,0x4
    80004584:	c0850513          	addi	a0,a0,-1016 # 80008188 <kvmincrease+0x1028>
    80004588:	00000097          	auipc	ra,0x0
    8000458c:	808080e7          	jalr	-2040(ra) # 80003d90 <_Z11printStringPKc>
    80004590:	0400006f          	j	800045d0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004594:	00004517          	auipc	a0,0x4
    80004598:	f2c50513          	addi	a0,a0,-212 # 800084c0 <kvmincrease+0x1360>
    8000459c:	fffff097          	auipc	ra,0xfffff
    800045a0:	7f4080e7          	jalr	2036(ra) # 80003d90 <_Z11printStringPKc>
    800045a4:	00000613          	li	a2,0
    800045a8:	00a00593          	li	a1,10
    800045ac:	00048513          	mv	a0,s1
    800045b0:	00000097          	auipc	ra,0x0
    800045b4:	990080e7          	jalr	-1648(ra) # 80003f40 <_Z8printIntiii>
    800045b8:	00004517          	auipc	a0,0x4
    800045bc:	bd050513          	addi	a0,a0,-1072 # 80008188 <kvmincrease+0x1028>
    800045c0:	fffff097          	auipc	ra,0xfffff
    800045c4:	7d0080e7          	jalr	2000(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 16; i++) {
    800045c8:	0014849b          	addiw	s1,s1,1
    800045cc:	0ff4f493          	andi	s1,s1,255
    800045d0:	00f00793          	li	a5,15
    800045d4:	fc97f0e3          	bgeu	a5,s1,80004594 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800045d8:	00004517          	auipc	a0,0x4
    800045dc:	f1050513          	addi	a0,a0,-240 # 800084e8 <kvmincrease+0x1388>
    800045e0:	fffff097          	auipc	ra,0xfffff
    800045e4:	7b0080e7          	jalr	1968(ra) # 80003d90 <_Z11printStringPKc>
    finishedD = true;
    800045e8:	00100793          	li	a5,1
    800045ec:	00006717          	auipc	a4,0x6
    800045f0:	a0f70e23          	sb	a5,-1508(a4) # 8000a008 <_ZL9finishedD>
    thread_dispatch();
    800045f4:	ffffd097          	auipc	ra,0xffffd
    800045f8:	c20080e7          	jalr	-992(ra) # 80001214 <_Z15thread_dispatchv>
}
    800045fc:	01813083          	ld	ra,24(sp)
    80004600:	01013403          	ld	s0,16(sp)
    80004604:	00813483          	ld	s1,8(sp)
    80004608:	00013903          	ld	s2,0(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret

0000000080004614 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004614:	fe010113          	addi	sp,sp,-32
    80004618:	00113c23          	sd	ra,24(sp)
    8000461c:	00813823          	sd	s0,16(sp)
    80004620:	00913423          	sd	s1,8(sp)
    80004624:	01213023          	sd	s2,0(sp)
    80004628:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000462c:	00000493          	li	s1,0
    80004630:	0400006f          	j	80004670 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004634:	00004517          	auipc	a0,0x4
    80004638:	e5c50513          	addi	a0,a0,-420 # 80008490 <kvmincrease+0x1330>
    8000463c:	fffff097          	auipc	ra,0xfffff
    80004640:	754080e7          	jalr	1876(ra) # 80003d90 <_Z11printStringPKc>
    80004644:	00000613          	li	a2,0
    80004648:	00a00593          	li	a1,10
    8000464c:	00048513          	mv	a0,s1
    80004650:	00000097          	auipc	ra,0x0
    80004654:	8f0080e7          	jalr	-1808(ra) # 80003f40 <_Z8printIntiii>
    80004658:	00004517          	auipc	a0,0x4
    8000465c:	b3050513          	addi	a0,a0,-1232 # 80008188 <kvmincrease+0x1028>
    80004660:	fffff097          	auipc	ra,0xfffff
    80004664:	730080e7          	jalr	1840(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004668:	0014849b          	addiw	s1,s1,1
    8000466c:	0ff4f493          	andi	s1,s1,255
    80004670:	00200793          	li	a5,2
    80004674:	fc97f0e3          	bgeu	a5,s1,80004634 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004678:	00004517          	auipc	a0,0x4
    8000467c:	e2050513          	addi	a0,a0,-480 # 80008498 <kvmincrease+0x1338>
    80004680:	fffff097          	auipc	ra,0xfffff
    80004684:	710080e7          	jalr	1808(ra) # 80003d90 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004688:	00700313          	li	t1,7
    thread_dispatch();
    8000468c:	ffffd097          	auipc	ra,0xffffd
    80004690:	b88080e7          	jalr	-1144(ra) # 80001214 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004694:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004698:	00004517          	auipc	a0,0x4
    8000469c:	e1050513          	addi	a0,a0,-496 # 800084a8 <kvmincrease+0x1348>
    800046a0:	fffff097          	auipc	ra,0xfffff
    800046a4:	6f0080e7          	jalr	1776(ra) # 80003d90 <_Z11printStringPKc>
    800046a8:	00000613          	li	a2,0
    800046ac:	00a00593          	li	a1,10
    800046b0:	0009051b          	sext.w	a0,s2
    800046b4:	00000097          	auipc	ra,0x0
    800046b8:	88c080e7          	jalr	-1908(ra) # 80003f40 <_Z8printIntiii>
    800046bc:	00004517          	auipc	a0,0x4
    800046c0:	acc50513          	addi	a0,a0,-1332 # 80008188 <kvmincrease+0x1028>
    800046c4:	fffff097          	auipc	ra,0xfffff
    800046c8:	6cc080e7          	jalr	1740(ra) # 80003d90 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800046cc:	00c00513          	li	a0,12
    800046d0:	00000097          	auipc	ra,0x0
    800046d4:	d88080e7          	jalr	-632(ra) # 80004458 <_ZL9fibonaccim>
    800046d8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800046dc:	00004517          	auipc	a0,0x4
    800046e0:	dd450513          	addi	a0,a0,-556 # 800084b0 <kvmincrease+0x1350>
    800046e4:	fffff097          	auipc	ra,0xfffff
    800046e8:	6ac080e7          	jalr	1708(ra) # 80003d90 <_Z11printStringPKc>
    800046ec:	00000613          	li	a2,0
    800046f0:	00a00593          	li	a1,10
    800046f4:	0009051b          	sext.w	a0,s2
    800046f8:	00000097          	auipc	ra,0x0
    800046fc:	848080e7          	jalr	-1976(ra) # 80003f40 <_Z8printIntiii>
    80004700:	00004517          	auipc	a0,0x4
    80004704:	a8850513          	addi	a0,a0,-1400 # 80008188 <kvmincrease+0x1028>
    80004708:	fffff097          	auipc	ra,0xfffff
    8000470c:	688080e7          	jalr	1672(ra) # 80003d90 <_Z11printStringPKc>
    80004710:	0400006f          	j	80004750 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004714:	00004517          	auipc	a0,0x4
    80004718:	d7c50513          	addi	a0,a0,-644 # 80008490 <kvmincrease+0x1330>
    8000471c:	fffff097          	auipc	ra,0xfffff
    80004720:	674080e7          	jalr	1652(ra) # 80003d90 <_Z11printStringPKc>
    80004724:	00000613          	li	a2,0
    80004728:	00a00593          	li	a1,10
    8000472c:	00048513          	mv	a0,s1
    80004730:	00000097          	auipc	ra,0x0
    80004734:	810080e7          	jalr	-2032(ra) # 80003f40 <_Z8printIntiii>
    80004738:	00004517          	auipc	a0,0x4
    8000473c:	a5050513          	addi	a0,a0,-1456 # 80008188 <kvmincrease+0x1028>
    80004740:	fffff097          	auipc	ra,0xfffff
    80004744:	650080e7          	jalr	1616(ra) # 80003d90 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004748:	0014849b          	addiw	s1,s1,1
    8000474c:	0ff4f493          	andi	s1,s1,255
    80004750:	00500793          	li	a5,5
    80004754:	fc97f0e3          	bgeu	a5,s1,80004714 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004758:	00004517          	auipc	a0,0x4
    8000475c:	d1050513          	addi	a0,a0,-752 # 80008468 <kvmincrease+0x1308>
    80004760:	fffff097          	auipc	ra,0xfffff
    80004764:	630080e7          	jalr	1584(ra) # 80003d90 <_Z11printStringPKc>
    finishedC = true;
    80004768:	00100793          	li	a5,1
    8000476c:	00006717          	auipc	a4,0x6
    80004770:	88f70ea3          	sb	a5,-1891(a4) # 8000a009 <_ZL9finishedC>
    thread_dispatch();
    80004774:	ffffd097          	auipc	ra,0xffffd
    80004778:	aa0080e7          	jalr	-1376(ra) # 80001214 <_Z15thread_dispatchv>
}
    8000477c:	01813083          	ld	ra,24(sp)
    80004780:	01013403          	ld	s0,16(sp)
    80004784:	00813483          	ld	s1,8(sp)
    80004788:	00013903          	ld	s2,0(sp)
    8000478c:	02010113          	addi	sp,sp,32
    80004790:	00008067          	ret

0000000080004794 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004794:	fe010113          	addi	sp,sp,-32
    80004798:	00113c23          	sd	ra,24(sp)
    8000479c:	00813823          	sd	s0,16(sp)
    800047a0:	00913423          	sd	s1,8(sp)
    800047a4:	01213023          	sd	s2,0(sp)
    800047a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800047ac:	00000913          	li	s2,0
    800047b0:	0400006f          	j	800047f0 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    800047b4:	ffffd097          	auipc	ra,0xffffd
    800047b8:	a60080e7          	jalr	-1440(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800047bc:	00148493          	addi	s1,s1,1
    800047c0:	000027b7          	lui	a5,0x2
    800047c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800047c8:	0097ee63          	bltu	a5,s1,800047e4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800047cc:	00000713          	li	a4,0
    800047d0:	000077b7          	lui	a5,0x7
    800047d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800047d8:	fce7eee3          	bltu	a5,a4,800047b4 <_ZL11workerBodyBPv+0x20>
    800047dc:	00170713          	addi	a4,a4,1
    800047e0:	ff1ff06f          	j	800047d0 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800047e4:	00a00793          	li	a5,10
    800047e8:	04f90663          	beq	s2,a5,80004834 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800047ec:	00190913          	addi	s2,s2,1
    800047f0:	00f00793          	li	a5,15
    800047f4:	0527e463          	bltu	a5,s2,8000483c <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800047f8:	00004517          	auipc	a0,0x4
    800047fc:	c8050513          	addi	a0,a0,-896 # 80008478 <kvmincrease+0x1318>
    80004800:	fffff097          	auipc	ra,0xfffff
    80004804:	590080e7          	jalr	1424(ra) # 80003d90 <_Z11printStringPKc>
    80004808:	00000613          	li	a2,0
    8000480c:	00a00593          	li	a1,10
    80004810:	0009051b          	sext.w	a0,s2
    80004814:	fffff097          	auipc	ra,0xfffff
    80004818:	72c080e7          	jalr	1836(ra) # 80003f40 <_Z8printIntiii>
    8000481c:	00004517          	auipc	a0,0x4
    80004820:	96c50513          	addi	a0,a0,-1684 # 80008188 <kvmincrease+0x1028>
    80004824:	fffff097          	auipc	ra,0xfffff
    80004828:	56c080e7          	jalr	1388(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000482c:	00000493          	li	s1,0
    80004830:	f91ff06f          	j	800047c0 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80004834:	14102ff3          	csrr	t6,sepc
    80004838:	fb5ff06f          	j	800047ec <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    8000483c:	00004517          	auipc	a0,0x4
    80004840:	c4450513          	addi	a0,a0,-956 # 80008480 <kvmincrease+0x1320>
    80004844:	fffff097          	auipc	ra,0xfffff
    80004848:	54c080e7          	jalr	1356(ra) # 80003d90 <_Z11printStringPKc>
    finishedB = true;
    8000484c:	00100793          	li	a5,1
    80004850:	00005717          	auipc	a4,0x5
    80004854:	7af70d23          	sb	a5,1978(a4) # 8000a00a <_ZL9finishedB>
    thread_dispatch();
    80004858:	ffffd097          	auipc	ra,0xffffd
    8000485c:	9bc080e7          	jalr	-1604(ra) # 80001214 <_Z15thread_dispatchv>
}
    80004860:	01813083          	ld	ra,24(sp)
    80004864:	01013403          	ld	s0,16(sp)
    80004868:	00813483          	ld	s1,8(sp)
    8000486c:	00013903          	ld	s2,0(sp)
    80004870:	02010113          	addi	sp,sp,32
    80004874:	00008067          	ret

0000000080004878 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004878:	fe010113          	addi	sp,sp,-32
    8000487c:	00113c23          	sd	ra,24(sp)
    80004880:	00813823          	sd	s0,16(sp)
    80004884:	00913423          	sd	s1,8(sp)
    80004888:	01213023          	sd	s2,0(sp)
    8000488c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004890:	00000913          	li	s2,0
    80004894:	0380006f          	j	800048cc <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004898:	ffffd097          	auipc	ra,0xffffd
    8000489c:	97c080e7          	jalr	-1668(ra) # 80001214 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800048a0:	00148493          	addi	s1,s1,1
    800048a4:	000027b7          	lui	a5,0x2
    800048a8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800048ac:	0097ee63          	bltu	a5,s1,800048c8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800048b0:	00000713          	li	a4,0
    800048b4:	000077b7          	lui	a5,0x7
    800048b8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800048bc:	fce7eee3          	bltu	a5,a4,80004898 <_ZL11workerBodyAPv+0x20>
    800048c0:	00170713          	addi	a4,a4,1
    800048c4:	ff1ff06f          	j	800048b4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800048c8:	00190913          	addi	s2,s2,1
    800048cc:	00900793          	li	a5,9
    800048d0:	0527e063          	bltu	a5,s2,80004910 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800048d4:	00004517          	auipc	a0,0x4
    800048d8:	b8c50513          	addi	a0,a0,-1140 # 80008460 <kvmincrease+0x1300>
    800048dc:	fffff097          	auipc	ra,0xfffff
    800048e0:	4b4080e7          	jalr	1204(ra) # 80003d90 <_Z11printStringPKc>
    800048e4:	00000613          	li	a2,0
    800048e8:	00a00593          	li	a1,10
    800048ec:	0009051b          	sext.w	a0,s2
    800048f0:	fffff097          	auipc	ra,0xfffff
    800048f4:	650080e7          	jalr	1616(ra) # 80003f40 <_Z8printIntiii>
    800048f8:	00004517          	auipc	a0,0x4
    800048fc:	89050513          	addi	a0,a0,-1904 # 80008188 <kvmincrease+0x1028>
    80004900:	fffff097          	auipc	ra,0xfffff
    80004904:	490080e7          	jalr	1168(ra) # 80003d90 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004908:	00000493          	li	s1,0
    8000490c:	f99ff06f          	j	800048a4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004910:	00004517          	auipc	a0,0x4
    80004914:	b5850513          	addi	a0,a0,-1192 # 80008468 <kvmincrease+0x1308>
    80004918:	fffff097          	auipc	ra,0xfffff
    8000491c:	478080e7          	jalr	1144(ra) # 80003d90 <_Z11printStringPKc>
    finishedA = true;
    80004920:	00100793          	li	a5,1
    80004924:	00005717          	auipc	a4,0x5
    80004928:	6ef703a3          	sb	a5,1767(a4) # 8000a00b <_ZL9finishedA>
}
    8000492c:	01813083          	ld	ra,24(sp)
    80004930:	01013403          	ld	s0,16(sp)
    80004934:	00813483          	ld	s1,8(sp)
    80004938:	00013903          	ld	s2,0(sp)
    8000493c:	02010113          	addi	sp,sp,32
    80004940:	00008067          	ret

0000000080004944 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80004944:	fd010113          	addi	sp,sp,-48
    80004948:	02113423          	sd	ra,40(sp)
    8000494c:	02813023          	sd	s0,32(sp)
    80004950:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004954:	00000613          	li	a2,0
    80004958:	00000597          	auipc	a1,0x0
    8000495c:	f2058593          	addi	a1,a1,-224 # 80004878 <_ZL11workerBodyAPv>
    80004960:	fd040513          	addi	a0,s0,-48
    80004964:	ffffd097          	auipc	ra,0xffffd
    80004968:	858080e7          	jalr	-1960(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000496c:	00004517          	auipc	a0,0x4
    80004970:	b8c50513          	addi	a0,a0,-1140 # 800084f8 <kvmincrease+0x1398>
    80004974:	fffff097          	auipc	ra,0xfffff
    80004978:	41c080e7          	jalr	1052(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000497c:	00000613          	li	a2,0
    80004980:	00000597          	auipc	a1,0x0
    80004984:	e1458593          	addi	a1,a1,-492 # 80004794 <_ZL11workerBodyBPv>
    80004988:	fd840513          	addi	a0,s0,-40
    8000498c:	ffffd097          	auipc	ra,0xffffd
    80004990:	830080e7          	jalr	-2000(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004994:	00004517          	auipc	a0,0x4
    80004998:	b7c50513          	addi	a0,a0,-1156 # 80008510 <kvmincrease+0x13b0>
    8000499c:	fffff097          	auipc	ra,0xfffff
    800049a0:	3f4080e7          	jalr	1012(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800049a4:	00000613          	li	a2,0
    800049a8:	00000597          	auipc	a1,0x0
    800049ac:	c6c58593          	addi	a1,a1,-916 # 80004614 <_ZL11workerBodyCPv>
    800049b0:	fe040513          	addi	a0,s0,-32
    800049b4:	ffffd097          	auipc	ra,0xffffd
    800049b8:	808080e7          	jalr	-2040(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    800049bc:	00004517          	auipc	a0,0x4
    800049c0:	b6c50513          	addi	a0,a0,-1172 # 80008528 <kvmincrease+0x13c8>
    800049c4:	fffff097          	auipc	ra,0xfffff
    800049c8:	3cc080e7          	jalr	972(ra) # 80003d90 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800049cc:	00000613          	li	a2,0
    800049d0:	00000597          	auipc	a1,0x0
    800049d4:	afc58593          	addi	a1,a1,-1284 # 800044cc <_ZL11workerBodyDPv>
    800049d8:	fe840513          	addi	a0,s0,-24
    800049dc:	ffffc097          	auipc	ra,0xffffc
    800049e0:	7e0080e7          	jalr	2016(ra) # 800011bc <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800049e4:	00004517          	auipc	a0,0x4
    800049e8:	b5c50513          	addi	a0,a0,-1188 # 80008540 <kvmincrease+0x13e0>
    800049ec:	fffff097          	auipc	ra,0xfffff
    800049f0:	3a4080e7          	jalr	932(ra) # 80003d90 <_Z11printStringPKc>
    800049f4:	00c0006f          	j	80004a00 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800049f8:	ffffd097          	auipc	ra,0xffffd
    800049fc:	81c080e7          	jalr	-2020(ra) # 80001214 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004a00:	00005797          	auipc	a5,0x5
    80004a04:	60b7c783          	lbu	a5,1547(a5) # 8000a00b <_ZL9finishedA>
    80004a08:	fe0788e3          	beqz	a5,800049f8 <_Z16System_Mode_testv+0xb4>
    80004a0c:	00005797          	auipc	a5,0x5
    80004a10:	5fe7c783          	lbu	a5,1534(a5) # 8000a00a <_ZL9finishedB>
    80004a14:	fe0782e3          	beqz	a5,800049f8 <_Z16System_Mode_testv+0xb4>
    80004a18:	00005797          	auipc	a5,0x5
    80004a1c:	5f17c783          	lbu	a5,1521(a5) # 8000a009 <_ZL9finishedC>
    80004a20:	fc078ce3          	beqz	a5,800049f8 <_Z16System_Mode_testv+0xb4>
    80004a24:	00005797          	auipc	a5,0x5
    80004a28:	5e47c783          	lbu	a5,1508(a5) # 8000a008 <_ZL9finishedD>
    80004a2c:	fc0786e3          	beqz	a5,800049f8 <_Z16System_Mode_testv+0xb4>
    }

}
    80004a30:	02813083          	ld	ra,40(sp)
    80004a34:	02013403          	ld	s0,32(sp)
    80004a38:	03010113          	addi	sp,sp,48
    80004a3c:	00008067          	ret

0000000080004a40 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004a40:	fe010113          	addi	sp,sp,-32
    80004a44:	00113c23          	sd	ra,24(sp)
    80004a48:	00813823          	sd	s0,16(sp)
    80004a4c:	00913423          	sd	s1,8(sp)
    80004a50:	01213023          	sd	s2,0(sp)
    80004a54:	02010413          	addi	s0,sp,32
    80004a58:	00050493          	mv	s1,a0
    80004a5c:	00058913          	mv	s2,a1
    80004a60:	0015879b          	addiw	a5,a1,1
    80004a64:	0007851b          	sext.w	a0,a5
    80004a68:	00f4a023          	sw	a5,0(s1)
    80004a6c:	0004a823          	sw	zero,16(s1)
    80004a70:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004a74:	00251513          	slli	a0,a0,0x2
    80004a78:	ffffc097          	auipc	ra,0xffffc
    80004a7c:	6f0080e7          	jalr	1776(ra) # 80001168 <_Z9mem_allocm>
    80004a80:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004a84:	00000593          	li	a1,0
    80004a88:	02048513          	addi	a0,s1,32
    80004a8c:	ffffc097          	auipc	ra,0xffffc
    80004a90:	7ac080e7          	jalr	1964(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80004a94:	00090593          	mv	a1,s2
    80004a98:	01848513          	addi	a0,s1,24
    80004a9c:	ffffc097          	auipc	ra,0xffffc
    80004aa0:	79c080e7          	jalr	1948(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80004aa4:	00100593          	li	a1,1
    80004aa8:	02848513          	addi	a0,s1,40
    80004aac:	ffffc097          	auipc	ra,0xffffc
    80004ab0:	78c080e7          	jalr	1932(ra) # 80001238 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80004ab4:	00100593          	li	a1,1
    80004ab8:	03048513          	addi	a0,s1,48
    80004abc:	ffffc097          	auipc	ra,0xffffc
    80004ac0:	77c080e7          	jalr	1916(ra) # 80001238 <_Z8sem_openPP4_semj>
}
    80004ac4:	01813083          	ld	ra,24(sp)
    80004ac8:	01013403          	ld	s0,16(sp)
    80004acc:	00813483          	ld	s1,8(sp)
    80004ad0:	00013903          	ld	s2,0(sp)
    80004ad4:	02010113          	addi	sp,sp,32
    80004ad8:	00008067          	ret

0000000080004adc <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004adc:	fe010113          	addi	sp,sp,-32
    80004ae0:	00113c23          	sd	ra,24(sp)
    80004ae4:	00813823          	sd	s0,16(sp)
    80004ae8:	00913423          	sd	s1,8(sp)
    80004aec:	01213023          	sd	s2,0(sp)
    80004af0:	02010413          	addi	s0,sp,32
    80004af4:	00050493          	mv	s1,a0
    80004af8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004afc:	01853503          	ld	a0,24(a0)
    80004b00:	ffffc097          	auipc	ra,0xffffc
    80004b04:	790080e7          	jalr	1936(ra) # 80001290 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004b08:	0304b503          	ld	a0,48(s1)
    80004b0c:	ffffc097          	auipc	ra,0xffffc
    80004b10:	784080e7          	jalr	1924(ra) # 80001290 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004b14:	0084b783          	ld	a5,8(s1)
    80004b18:	0144a703          	lw	a4,20(s1)
    80004b1c:	00271713          	slli	a4,a4,0x2
    80004b20:	00e787b3          	add	a5,a5,a4
    80004b24:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004b28:	0144a783          	lw	a5,20(s1)
    80004b2c:	0017879b          	addiw	a5,a5,1
    80004b30:	0004a703          	lw	a4,0(s1)
    80004b34:	02e7e7bb          	remw	a5,a5,a4
    80004b38:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004b3c:	0304b503          	ld	a0,48(s1)
    80004b40:	ffffc097          	auipc	ra,0xffffc
    80004b44:	77c080e7          	jalr	1916(ra) # 800012bc <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004b48:	0204b503          	ld	a0,32(s1)
    80004b4c:	ffffc097          	auipc	ra,0xffffc
    80004b50:	770080e7          	jalr	1904(ra) # 800012bc <_Z10sem_signalP4_sem>

}
    80004b54:	01813083          	ld	ra,24(sp)
    80004b58:	01013403          	ld	s0,16(sp)
    80004b5c:	00813483          	ld	s1,8(sp)
    80004b60:	00013903          	ld	s2,0(sp)
    80004b64:	02010113          	addi	sp,sp,32
    80004b68:	00008067          	ret

0000000080004b6c <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004b6c:	fe010113          	addi	sp,sp,-32
    80004b70:	00113c23          	sd	ra,24(sp)
    80004b74:	00813823          	sd	s0,16(sp)
    80004b78:	00913423          	sd	s1,8(sp)
    80004b7c:	01213023          	sd	s2,0(sp)
    80004b80:	02010413          	addi	s0,sp,32
    80004b84:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004b88:	02053503          	ld	a0,32(a0)
    80004b8c:	ffffc097          	auipc	ra,0xffffc
    80004b90:	704080e7          	jalr	1796(ra) # 80001290 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004b94:	0284b503          	ld	a0,40(s1)
    80004b98:	ffffc097          	auipc	ra,0xffffc
    80004b9c:	6f8080e7          	jalr	1784(ra) # 80001290 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80004ba0:	0084b703          	ld	a4,8(s1)
    80004ba4:	0104a783          	lw	a5,16(s1)
    80004ba8:	00279693          	slli	a3,a5,0x2
    80004bac:	00d70733          	add	a4,a4,a3
    80004bb0:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004bb4:	0017879b          	addiw	a5,a5,1
    80004bb8:	0004a703          	lw	a4,0(s1)
    80004bbc:	02e7e7bb          	remw	a5,a5,a4
    80004bc0:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004bc4:	0284b503          	ld	a0,40(s1)
    80004bc8:	ffffc097          	auipc	ra,0xffffc
    80004bcc:	6f4080e7          	jalr	1780(ra) # 800012bc <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80004bd0:	0184b503          	ld	a0,24(s1)
    80004bd4:	ffffc097          	auipc	ra,0xffffc
    80004bd8:	6e8080e7          	jalr	1768(ra) # 800012bc <_Z10sem_signalP4_sem>

    return ret;
}
    80004bdc:	00090513          	mv	a0,s2
    80004be0:	01813083          	ld	ra,24(sp)
    80004be4:	01013403          	ld	s0,16(sp)
    80004be8:	00813483          	ld	s1,8(sp)
    80004bec:	00013903          	ld	s2,0(sp)
    80004bf0:	02010113          	addi	sp,sp,32
    80004bf4:	00008067          	ret

0000000080004bf8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004bf8:	fe010113          	addi	sp,sp,-32
    80004bfc:	00113c23          	sd	ra,24(sp)
    80004c00:	00813823          	sd	s0,16(sp)
    80004c04:	00913423          	sd	s1,8(sp)
    80004c08:	01213023          	sd	s2,0(sp)
    80004c0c:	02010413          	addi	s0,sp,32
    80004c10:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004c14:	02853503          	ld	a0,40(a0)
    80004c18:	ffffc097          	auipc	ra,0xffffc
    80004c1c:	678080e7          	jalr	1656(ra) # 80001290 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80004c20:	0304b503          	ld	a0,48(s1)
    80004c24:	ffffc097          	auipc	ra,0xffffc
    80004c28:	66c080e7          	jalr	1644(ra) # 80001290 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80004c2c:	0144a783          	lw	a5,20(s1)
    80004c30:	0104a903          	lw	s2,16(s1)
    80004c34:	0327ce63          	blt	a5,s2,80004c70 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004c38:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004c3c:	0304b503          	ld	a0,48(s1)
    80004c40:	ffffc097          	auipc	ra,0xffffc
    80004c44:	67c080e7          	jalr	1660(ra) # 800012bc <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80004c48:	0284b503          	ld	a0,40(s1)
    80004c4c:	ffffc097          	auipc	ra,0xffffc
    80004c50:	670080e7          	jalr	1648(ra) # 800012bc <_Z10sem_signalP4_sem>

    return ret;
}
    80004c54:	00090513          	mv	a0,s2
    80004c58:	01813083          	ld	ra,24(sp)
    80004c5c:	01013403          	ld	s0,16(sp)
    80004c60:	00813483          	ld	s1,8(sp)
    80004c64:	00013903          	ld	s2,0(sp)
    80004c68:	02010113          	addi	sp,sp,32
    80004c6c:	00008067          	ret
        ret = cap - head + tail;
    80004c70:	0004a703          	lw	a4,0(s1)
    80004c74:	4127093b          	subw	s2,a4,s2
    80004c78:	00f9093b          	addw	s2,s2,a5
    80004c7c:	fc1ff06f          	j	80004c3c <_ZN6Buffer6getCntEv+0x44>

0000000080004c80 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80004c80:	fe010113          	addi	sp,sp,-32
    80004c84:	00113c23          	sd	ra,24(sp)
    80004c88:	00813823          	sd	s0,16(sp)
    80004c8c:	00913423          	sd	s1,8(sp)
    80004c90:	02010413          	addi	s0,sp,32
    80004c94:	00050493          	mv	s1,a0
    putc('\n');
    80004c98:	00a00513          	li	a0,10
    80004c9c:	ffffc097          	auipc	ra,0xffffc
    80004ca0:	678080e7          	jalr	1656(ra) # 80001314 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004ca4:	00004517          	auipc	a0,0x4
    80004ca8:	8c450513          	addi	a0,a0,-1852 # 80008568 <kvmincrease+0x1408>
    80004cac:	fffff097          	auipc	ra,0xfffff
    80004cb0:	0e4080e7          	jalr	228(ra) # 80003d90 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004cb4:	00048513          	mv	a0,s1
    80004cb8:	00000097          	auipc	ra,0x0
    80004cbc:	f40080e7          	jalr	-192(ra) # 80004bf8 <_ZN6Buffer6getCntEv>
    80004cc0:	02a05c63          	blez	a0,80004cf8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004cc4:	0084b783          	ld	a5,8(s1)
    80004cc8:	0104a703          	lw	a4,16(s1)
    80004ccc:	00271713          	slli	a4,a4,0x2
    80004cd0:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80004cd4:	0007c503          	lbu	a0,0(a5)
    80004cd8:	ffffc097          	auipc	ra,0xffffc
    80004cdc:	63c080e7          	jalr	1596(ra) # 80001314 <_Z4putcc>
        head = (head + 1) % cap;
    80004ce0:	0104a783          	lw	a5,16(s1)
    80004ce4:	0017879b          	addiw	a5,a5,1
    80004ce8:	0004a703          	lw	a4,0(s1)
    80004cec:	02e7e7bb          	remw	a5,a5,a4
    80004cf0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80004cf4:	fc1ff06f          	j	80004cb4 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004cf8:	02100513          	li	a0,33
    80004cfc:	ffffc097          	auipc	ra,0xffffc
    80004d00:	618080e7          	jalr	1560(ra) # 80001314 <_Z4putcc>
    putc('\n');
    80004d04:	00a00513          	li	a0,10
    80004d08:	ffffc097          	auipc	ra,0xffffc
    80004d0c:	60c080e7          	jalr	1548(ra) # 80001314 <_Z4putcc>
    mem_free(buffer);
    80004d10:	0084b503          	ld	a0,8(s1)
    80004d14:	ffffc097          	auipc	ra,0xffffc
    80004d18:	47c080e7          	jalr	1148(ra) # 80001190 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004d1c:	0204b503          	ld	a0,32(s1)
    80004d20:	ffffc097          	auipc	ra,0xffffc
    80004d24:	544080e7          	jalr	1348(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80004d28:	0184b503          	ld	a0,24(s1)
    80004d2c:	ffffc097          	auipc	ra,0xffffc
    80004d30:	538080e7          	jalr	1336(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80004d34:	0304b503          	ld	a0,48(s1)
    80004d38:	ffffc097          	auipc	ra,0xffffc
    80004d3c:	52c080e7          	jalr	1324(ra) # 80001264 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80004d40:	0284b503          	ld	a0,40(s1)
    80004d44:	ffffc097          	auipc	ra,0xffffc
    80004d48:	520080e7          	jalr	1312(ra) # 80001264 <_Z9sem_closeP4_sem>
}
    80004d4c:	01813083          	ld	ra,24(sp)
    80004d50:	01013403          	ld	s0,16(sp)
    80004d54:	00813483          	ld	s1,8(sp)
    80004d58:	02010113          	addi	sp,sp,32
    80004d5c:	00008067          	ret

0000000080004d60 <start>:
    80004d60:	ff010113          	addi	sp,sp,-16
    80004d64:	00813423          	sd	s0,8(sp)
    80004d68:	01010413          	addi	s0,sp,16
    80004d6c:	300027f3          	csrr	a5,mstatus
    80004d70:	ffffe737          	lui	a4,0xffffe
    80004d74:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff357f>
    80004d78:	00e7f7b3          	and	a5,a5,a4
    80004d7c:	00001737          	lui	a4,0x1
    80004d80:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004d84:	00e7e7b3          	or	a5,a5,a4
    80004d88:	30079073          	csrw	mstatus,a5
    80004d8c:	00000797          	auipc	a5,0x0
    80004d90:	16078793          	addi	a5,a5,352 # 80004eec <system_main>
    80004d94:	34179073          	csrw	mepc,a5
    80004d98:	00000793          	li	a5,0
    80004d9c:	18079073          	csrw	satp,a5
    80004da0:	000107b7          	lui	a5,0x10
    80004da4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004da8:	30279073          	csrw	medeleg,a5
    80004dac:	30379073          	csrw	mideleg,a5
    80004db0:	104027f3          	csrr	a5,sie
    80004db4:	2227e793          	ori	a5,a5,546
    80004db8:	10479073          	csrw	sie,a5
    80004dbc:	fff00793          	li	a5,-1
    80004dc0:	00a7d793          	srli	a5,a5,0xa
    80004dc4:	3b079073          	csrw	pmpaddr0,a5
    80004dc8:	00f00793          	li	a5,15
    80004dcc:	3a079073          	csrw	pmpcfg0,a5
    80004dd0:	f14027f3          	csrr	a5,mhartid
    80004dd4:	0200c737          	lui	a4,0x200c
    80004dd8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004ddc:	0007869b          	sext.w	a3,a5
    80004de0:	00269713          	slli	a4,a3,0x2
    80004de4:	000f4637          	lui	a2,0xf4
    80004de8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004dec:	00d70733          	add	a4,a4,a3
    80004df0:	0037979b          	slliw	a5,a5,0x3
    80004df4:	020046b7          	lui	a3,0x2004
    80004df8:	00d787b3          	add	a5,a5,a3
    80004dfc:	00c585b3          	add	a1,a1,a2
    80004e00:	00371693          	slli	a3,a4,0x3
    80004e04:	00005717          	auipc	a4,0x5
    80004e08:	20c70713          	addi	a4,a4,524 # 8000a010 <timer_scratch>
    80004e0c:	00b7b023          	sd	a1,0(a5)
    80004e10:	00d70733          	add	a4,a4,a3
    80004e14:	00f73c23          	sd	a5,24(a4)
    80004e18:	02c73023          	sd	a2,32(a4)
    80004e1c:	34071073          	csrw	mscratch,a4
    80004e20:	00000797          	auipc	a5,0x0
    80004e24:	6e078793          	addi	a5,a5,1760 # 80005500 <timervec>
    80004e28:	30579073          	csrw	mtvec,a5
    80004e2c:	300027f3          	csrr	a5,mstatus
    80004e30:	0087e793          	ori	a5,a5,8
    80004e34:	30079073          	csrw	mstatus,a5
    80004e38:	304027f3          	csrr	a5,mie
    80004e3c:	0807e793          	ori	a5,a5,128
    80004e40:	30479073          	csrw	mie,a5
    80004e44:	f14027f3          	csrr	a5,mhartid
    80004e48:	0007879b          	sext.w	a5,a5
    80004e4c:	00078213          	mv	tp,a5
    80004e50:	30200073          	mret
    80004e54:	00813403          	ld	s0,8(sp)
    80004e58:	01010113          	addi	sp,sp,16
    80004e5c:	00008067          	ret

0000000080004e60 <timerinit>:
    80004e60:	ff010113          	addi	sp,sp,-16
    80004e64:	00813423          	sd	s0,8(sp)
    80004e68:	01010413          	addi	s0,sp,16
    80004e6c:	f14027f3          	csrr	a5,mhartid
    80004e70:	0200c737          	lui	a4,0x200c
    80004e74:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004e78:	0007869b          	sext.w	a3,a5
    80004e7c:	00269713          	slli	a4,a3,0x2
    80004e80:	000f4637          	lui	a2,0xf4
    80004e84:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004e88:	00d70733          	add	a4,a4,a3
    80004e8c:	0037979b          	slliw	a5,a5,0x3
    80004e90:	020046b7          	lui	a3,0x2004
    80004e94:	00d787b3          	add	a5,a5,a3
    80004e98:	00c585b3          	add	a1,a1,a2
    80004e9c:	00371693          	slli	a3,a4,0x3
    80004ea0:	00005717          	auipc	a4,0x5
    80004ea4:	17070713          	addi	a4,a4,368 # 8000a010 <timer_scratch>
    80004ea8:	00b7b023          	sd	a1,0(a5)
    80004eac:	00d70733          	add	a4,a4,a3
    80004eb0:	00f73c23          	sd	a5,24(a4)
    80004eb4:	02c73023          	sd	a2,32(a4)
    80004eb8:	34071073          	csrw	mscratch,a4
    80004ebc:	00000797          	auipc	a5,0x0
    80004ec0:	64478793          	addi	a5,a5,1604 # 80005500 <timervec>
    80004ec4:	30579073          	csrw	mtvec,a5
    80004ec8:	300027f3          	csrr	a5,mstatus
    80004ecc:	0087e793          	ori	a5,a5,8
    80004ed0:	30079073          	csrw	mstatus,a5
    80004ed4:	304027f3          	csrr	a5,mie
    80004ed8:	0807e793          	ori	a5,a5,128
    80004edc:	30479073          	csrw	mie,a5
    80004ee0:	00813403          	ld	s0,8(sp)
    80004ee4:	01010113          	addi	sp,sp,16
    80004ee8:	00008067          	ret

0000000080004eec <system_main>:
    80004eec:	fe010113          	addi	sp,sp,-32
    80004ef0:	00813823          	sd	s0,16(sp)
    80004ef4:	00913423          	sd	s1,8(sp)
    80004ef8:	00113c23          	sd	ra,24(sp)
    80004efc:	02010413          	addi	s0,sp,32
    80004f00:	00000097          	auipc	ra,0x0
    80004f04:	0c4080e7          	jalr	196(ra) # 80004fc4 <cpuid>
    80004f08:	00005497          	auipc	s1,0x5
    80004f0c:	08848493          	addi	s1,s1,136 # 80009f90 <started>
    80004f10:	02050263          	beqz	a0,80004f34 <system_main+0x48>
    80004f14:	0004a783          	lw	a5,0(s1)
    80004f18:	0007879b          	sext.w	a5,a5
    80004f1c:	fe078ce3          	beqz	a5,80004f14 <system_main+0x28>
    80004f20:	0ff0000f          	fence
    80004f24:	00003517          	auipc	a0,0x3
    80004f28:	68c50513          	addi	a0,a0,1676 # 800085b0 <kvmincrease+0x1450>
    80004f2c:	00001097          	auipc	ra,0x1
    80004f30:	a70080e7          	jalr	-1424(ra) # 8000599c <panic>
    80004f34:	00001097          	auipc	ra,0x1
    80004f38:	9c4080e7          	jalr	-1596(ra) # 800058f8 <consoleinit>
    80004f3c:	00001097          	auipc	ra,0x1
    80004f40:	150080e7          	jalr	336(ra) # 8000608c <printfinit>
    80004f44:	00003517          	auipc	a0,0x3
    80004f48:	24450513          	addi	a0,a0,580 # 80008188 <kvmincrease+0x1028>
    80004f4c:	00001097          	auipc	ra,0x1
    80004f50:	aac080e7          	jalr	-1364(ra) # 800059f8 <__printf>
    80004f54:	00003517          	auipc	a0,0x3
    80004f58:	62c50513          	addi	a0,a0,1580 # 80008580 <kvmincrease+0x1420>
    80004f5c:	00001097          	auipc	ra,0x1
    80004f60:	a9c080e7          	jalr	-1380(ra) # 800059f8 <__printf>
    80004f64:	00003517          	auipc	a0,0x3
    80004f68:	22450513          	addi	a0,a0,548 # 80008188 <kvmincrease+0x1028>
    80004f6c:	00001097          	auipc	ra,0x1
    80004f70:	a8c080e7          	jalr	-1396(ra) # 800059f8 <__printf>
    80004f74:	00001097          	auipc	ra,0x1
    80004f78:	4a4080e7          	jalr	1188(ra) # 80006418 <kinit>
    80004f7c:	00000097          	auipc	ra,0x0
    80004f80:	148080e7          	jalr	328(ra) # 800050c4 <trapinit>
    80004f84:	00000097          	auipc	ra,0x0
    80004f88:	16c080e7          	jalr	364(ra) # 800050f0 <trapinithart>
    80004f8c:	00000097          	auipc	ra,0x0
    80004f90:	5b4080e7          	jalr	1460(ra) # 80005540 <plicinit>
    80004f94:	00000097          	auipc	ra,0x0
    80004f98:	5d4080e7          	jalr	1492(ra) # 80005568 <plicinithart>
    80004f9c:	00000097          	auipc	ra,0x0
    80004fa0:	078080e7          	jalr	120(ra) # 80005014 <userinit>
    80004fa4:	0ff0000f          	fence
    80004fa8:	00100793          	li	a5,1
    80004fac:	00003517          	auipc	a0,0x3
    80004fb0:	5ec50513          	addi	a0,a0,1516 # 80008598 <kvmincrease+0x1438>
    80004fb4:	00f4a023          	sw	a5,0(s1)
    80004fb8:	00001097          	auipc	ra,0x1
    80004fbc:	a40080e7          	jalr	-1472(ra) # 800059f8 <__printf>
    80004fc0:	0000006f          	j	80004fc0 <system_main+0xd4>

0000000080004fc4 <cpuid>:
    80004fc4:	ff010113          	addi	sp,sp,-16
    80004fc8:	00813423          	sd	s0,8(sp)
    80004fcc:	01010413          	addi	s0,sp,16
    80004fd0:	00020513          	mv	a0,tp
    80004fd4:	00813403          	ld	s0,8(sp)
    80004fd8:	0005051b          	sext.w	a0,a0
    80004fdc:	01010113          	addi	sp,sp,16
    80004fe0:	00008067          	ret

0000000080004fe4 <mycpu>:
    80004fe4:	ff010113          	addi	sp,sp,-16
    80004fe8:	00813423          	sd	s0,8(sp)
    80004fec:	01010413          	addi	s0,sp,16
    80004ff0:	00020793          	mv	a5,tp
    80004ff4:	00813403          	ld	s0,8(sp)
    80004ff8:	0007879b          	sext.w	a5,a5
    80004ffc:	00779793          	slli	a5,a5,0x7
    80005000:	00006517          	auipc	a0,0x6
    80005004:	04050513          	addi	a0,a0,64 # 8000b040 <cpus>
    80005008:	00f50533          	add	a0,a0,a5
    8000500c:	01010113          	addi	sp,sp,16
    80005010:	00008067          	ret

0000000080005014 <userinit>:
    80005014:	ff010113          	addi	sp,sp,-16
    80005018:	00813423          	sd	s0,8(sp)
    8000501c:	01010413          	addi	s0,sp,16
    80005020:	00813403          	ld	s0,8(sp)
    80005024:	01010113          	addi	sp,sp,16
    80005028:	ffffc317          	auipc	t1,0xffffc
    8000502c:	6a030067          	jr	1696(t1) # 800016c8 <main>

0000000080005030 <either_copyout>:
    80005030:	ff010113          	addi	sp,sp,-16
    80005034:	00813023          	sd	s0,0(sp)
    80005038:	00113423          	sd	ra,8(sp)
    8000503c:	01010413          	addi	s0,sp,16
    80005040:	02051663          	bnez	a0,8000506c <either_copyout+0x3c>
    80005044:	00058513          	mv	a0,a1
    80005048:	00060593          	mv	a1,a2
    8000504c:	0006861b          	sext.w	a2,a3
    80005050:	00002097          	auipc	ra,0x2
    80005054:	c54080e7          	jalr	-940(ra) # 80006ca4 <__memmove>
    80005058:	00813083          	ld	ra,8(sp)
    8000505c:	00013403          	ld	s0,0(sp)
    80005060:	00000513          	li	a0,0
    80005064:	01010113          	addi	sp,sp,16
    80005068:	00008067          	ret
    8000506c:	00003517          	auipc	a0,0x3
    80005070:	56c50513          	addi	a0,a0,1388 # 800085d8 <kvmincrease+0x1478>
    80005074:	00001097          	auipc	ra,0x1
    80005078:	928080e7          	jalr	-1752(ra) # 8000599c <panic>

000000008000507c <either_copyin>:
    8000507c:	ff010113          	addi	sp,sp,-16
    80005080:	00813023          	sd	s0,0(sp)
    80005084:	00113423          	sd	ra,8(sp)
    80005088:	01010413          	addi	s0,sp,16
    8000508c:	02059463          	bnez	a1,800050b4 <either_copyin+0x38>
    80005090:	00060593          	mv	a1,a2
    80005094:	0006861b          	sext.w	a2,a3
    80005098:	00002097          	auipc	ra,0x2
    8000509c:	c0c080e7          	jalr	-1012(ra) # 80006ca4 <__memmove>
    800050a0:	00813083          	ld	ra,8(sp)
    800050a4:	00013403          	ld	s0,0(sp)
    800050a8:	00000513          	li	a0,0
    800050ac:	01010113          	addi	sp,sp,16
    800050b0:	00008067          	ret
    800050b4:	00003517          	auipc	a0,0x3
    800050b8:	54c50513          	addi	a0,a0,1356 # 80008600 <kvmincrease+0x14a0>
    800050bc:	00001097          	auipc	ra,0x1
    800050c0:	8e0080e7          	jalr	-1824(ra) # 8000599c <panic>

00000000800050c4 <trapinit>:
    800050c4:	ff010113          	addi	sp,sp,-16
    800050c8:	00813423          	sd	s0,8(sp)
    800050cc:	01010413          	addi	s0,sp,16
    800050d0:	00813403          	ld	s0,8(sp)
    800050d4:	00003597          	auipc	a1,0x3
    800050d8:	55458593          	addi	a1,a1,1364 # 80008628 <kvmincrease+0x14c8>
    800050dc:	00006517          	auipc	a0,0x6
    800050e0:	fe450513          	addi	a0,a0,-28 # 8000b0c0 <tickslock>
    800050e4:	01010113          	addi	sp,sp,16
    800050e8:	00001317          	auipc	t1,0x1
    800050ec:	5c030067          	jr	1472(t1) # 800066a8 <initlock>

00000000800050f0 <trapinithart>:
    800050f0:	ff010113          	addi	sp,sp,-16
    800050f4:	00813423          	sd	s0,8(sp)
    800050f8:	01010413          	addi	s0,sp,16
    800050fc:	00000797          	auipc	a5,0x0
    80005100:	2f478793          	addi	a5,a5,756 # 800053f0 <kernelvec>
    80005104:	10579073          	csrw	stvec,a5
    80005108:	00813403          	ld	s0,8(sp)
    8000510c:	01010113          	addi	sp,sp,16
    80005110:	00008067          	ret

0000000080005114 <usertrap>:
    80005114:	ff010113          	addi	sp,sp,-16
    80005118:	00813423          	sd	s0,8(sp)
    8000511c:	01010413          	addi	s0,sp,16
    80005120:	00813403          	ld	s0,8(sp)
    80005124:	01010113          	addi	sp,sp,16
    80005128:	00008067          	ret

000000008000512c <usertrapret>:
    8000512c:	ff010113          	addi	sp,sp,-16
    80005130:	00813423          	sd	s0,8(sp)
    80005134:	01010413          	addi	s0,sp,16
    80005138:	00813403          	ld	s0,8(sp)
    8000513c:	01010113          	addi	sp,sp,16
    80005140:	00008067          	ret

0000000080005144 <kerneltrap>:
    80005144:	fe010113          	addi	sp,sp,-32
    80005148:	00813823          	sd	s0,16(sp)
    8000514c:	00113c23          	sd	ra,24(sp)
    80005150:	00913423          	sd	s1,8(sp)
    80005154:	02010413          	addi	s0,sp,32
    80005158:	142025f3          	csrr	a1,scause
    8000515c:	100027f3          	csrr	a5,sstatus
    80005160:	0027f793          	andi	a5,a5,2
    80005164:	10079c63          	bnez	a5,8000527c <kerneltrap+0x138>
    80005168:	142027f3          	csrr	a5,scause
    8000516c:	0207ce63          	bltz	a5,800051a8 <kerneltrap+0x64>
    80005170:	00003517          	auipc	a0,0x3
    80005174:	50050513          	addi	a0,a0,1280 # 80008670 <kvmincrease+0x1510>
    80005178:	00001097          	auipc	ra,0x1
    8000517c:	880080e7          	jalr	-1920(ra) # 800059f8 <__printf>
    80005180:	141025f3          	csrr	a1,sepc
    80005184:	14302673          	csrr	a2,stval
    80005188:	00003517          	auipc	a0,0x3
    8000518c:	4f850513          	addi	a0,a0,1272 # 80008680 <kvmincrease+0x1520>
    80005190:	00001097          	auipc	ra,0x1
    80005194:	868080e7          	jalr	-1944(ra) # 800059f8 <__printf>
    80005198:	00003517          	auipc	a0,0x3
    8000519c:	50050513          	addi	a0,a0,1280 # 80008698 <kvmincrease+0x1538>
    800051a0:	00000097          	auipc	ra,0x0
    800051a4:	7fc080e7          	jalr	2044(ra) # 8000599c <panic>
    800051a8:	0ff7f713          	andi	a4,a5,255
    800051ac:	00900693          	li	a3,9
    800051b0:	04d70063          	beq	a4,a3,800051f0 <kerneltrap+0xac>
    800051b4:	fff00713          	li	a4,-1
    800051b8:	03f71713          	slli	a4,a4,0x3f
    800051bc:	00170713          	addi	a4,a4,1
    800051c0:	fae798e3          	bne	a5,a4,80005170 <kerneltrap+0x2c>
    800051c4:	00000097          	auipc	ra,0x0
    800051c8:	e00080e7          	jalr	-512(ra) # 80004fc4 <cpuid>
    800051cc:	06050663          	beqz	a0,80005238 <kerneltrap+0xf4>
    800051d0:	144027f3          	csrr	a5,sip
    800051d4:	ffd7f793          	andi	a5,a5,-3
    800051d8:	14479073          	csrw	sip,a5
    800051dc:	01813083          	ld	ra,24(sp)
    800051e0:	01013403          	ld	s0,16(sp)
    800051e4:	00813483          	ld	s1,8(sp)
    800051e8:	02010113          	addi	sp,sp,32
    800051ec:	00008067          	ret
    800051f0:	00000097          	auipc	ra,0x0
    800051f4:	3c4080e7          	jalr	964(ra) # 800055b4 <plic_claim>
    800051f8:	00a00793          	li	a5,10
    800051fc:	00050493          	mv	s1,a0
    80005200:	06f50863          	beq	a0,a5,80005270 <kerneltrap+0x12c>
    80005204:	fc050ce3          	beqz	a0,800051dc <kerneltrap+0x98>
    80005208:	00050593          	mv	a1,a0
    8000520c:	00003517          	auipc	a0,0x3
    80005210:	44450513          	addi	a0,a0,1092 # 80008650 <kvmincrease+0x14f0>
    80005214:	00000097          	auipc	ra,0x0
    80005218:	7e4080e7          	jalr	2020(ra) # 800059f8 <__printf>
    8000521c:	01013403          	ld	s0,16(sp)
    80005220:	01813083          	ld	ra,24(sp)
    80005224:	00048513          	mv	a0,s1
    80005228:	00813483          	ld	s1,8(sp)
    8000522c:	02010113          	addi	sp,sp,32
    80005230:	00000317          	auipc	t1,0x0
    80005234:	3bc30067          	jr	956(t1) # 800055ec <plic_complete>
    80005238:	00006517          	auipc	a0,0x6
    8000523c:	e8850513          	addi	a0,a0,-376 # 8000b0c0 <tickslock>
    80005240:	00001097          	auipc	ra,0x1
    80005244:	48c080e7          	jalr	1164(ra) # 800066cc <acquire>
    80005248:	00005717          	auipc	a4,0x5
    8000524c:	d4c70713          	addi	a4,a4,-692 # 80009f94 <ticks>
    80005250:	00072783          	lw	a5,0(a4)
    80005254:	00006517          	auipc	a0,0x6
    80005258:	e6c50513          	addi	a0,a0,-404 # 8000b0c0 <tickslock>
    8000525c:	0017879b          	addiw	a5,a5,1
    80005260:	00f72023          	sw	a5,0(a4)
    80005264:	00001097          	auipc	ra,0x1
    80005268:	534080e7          	jalr	1332(ra) # 80006798 <release>
    8000526c:	f65ff06f          	j	800051d0 <kerneltrap+0x8c>
    80005270:	00001097          	auipc	ra,0x1
    80005274:	090080e7          	jalr	144(ra) # 80006300 <uartintr>
    80005278:	fa5ff06f          	j	8000521c <kerneltrap+0xd8>
    8000527c:	00003517          	auipc	a0,0x3
    80005280:	3b450513          	addi	a0,a0,948 # 80008630 <kvmincrease+0x14d0>
    80005284:	00000097          	auipc	ra,0x0
    80005288:	718080e7          	jalr	1816(ra) # 8000599c <panic>

000000008000528c <clockintr>:
    8000528c:	fe010113          	addi	sp,sp,-32
    80005290:	00813823          	sd	s0,16(sp)
    80005294:	00913423          	sd	s1,8(sp)
    80005298:	00113c23          	sd	ra,24(sp)
    8000529c:	02010413          	addi	s0,sp,32
    800052a0:	00006497          	auipc	s1,0x6
    800052a4:	e2048493          	addi	s1,s1,-480 # 8000b0c0 <tickslock>
    800052a8:	00048513          	mv	a0,s1
    800052ac:	00001097          	auipc	ra,0x1
    800052b0:	420080e7          	jalr	1056(ra) # 800066cc <acquire>
    800052b4:	00005717          	auipc	a4,0x5
    800052b8:	ce070713          	addi	a4,a4,-800 # 80009f94 <ticks>
    800052bc:	00072783          	lw	a5,0(a4)
    800052c0:	01013403          	ld	s0,16(sp)
    800052c4:	01813083          	ld	ra,24(sp)
    800052c8:	00048513          	mv	a0,s1
    800052cc:	0017879b          	addiw	a5,a5,1
    800052d0:	00813483          	ld	s1,8(sp)
    800052d4:	00f72023          	sw	a5,0(a4)
    800052d8:	02010113          	addi	sp,sp,32
    800052dc:	00001317          	auipc	t1,0x1
    800052e0:	4bc30067          	jr	1212(t1) # 80006798 <release>

00000000800052e4 <devintr>:
    800052e4:	142027f3          	csrr	a5,scause
    800052e8:	00000513          	li	a0,0
    800052ec:	0007c463          	bltz	a5,800052f4 <devintr+0x10>
    800052f0:	00008067          	ret
    800052f4:	fe010113          	addi	sp,sp,-32
    800052f8:	00813823          	sd	s0,16(sp)
    800052fc:	00113c23          	sd	ra,24(sp)
    80005300:	00913423          	sd	s1,8(sp)
    80005304:	02010413          	addi	s0,sp,32
    80005308:	0ff7f713          	andi	a4,a5,255
    8000530c:	00900693          	li	a3,9
    80005310:	04d70c63          	beq	a4,a3,80005368 <devintr+0x84>
    80005314:	fff00713          	li	a4,-1
    80005318:	03f71713          	slli	a4,a4,0x3f
    8000531c:	00170713          	addi	a4,a4,1
    80005320:	00e78c63          	beq	a5,a4,80005338 <devintr+0x54>
    80005324:	01813083          	ld	ra,24(sp)
    80005328:	01013403          	ld	s0,16(sp)
    8000532c:	00813483          	ld	s1,8(sp)
    80005330:	02010113          	addi	sp,sp,32
    80005334:	00008067          	ret
    80005338:	00000097          	auipc	ra,0x0
    8000533c:	c8c080e7          	jalr	-884(ra) # 80004fc4 <cpuid>
    80005340:	06050663          	beqz	a0,800053ac <devintr+0xc8>
    80005344:	144027f3          	csrr	a5,sip
    80005348:	ffd7f793          	andi	a5,a5,-3
    8000534c:	14479073          	csrw	sip,a5
    80005350:	01813083          	ld	ra,24(sp)
    80005354:	01013403          	ld	s0,16(sp)
    80005358:	00813483          	ld	s1,8(sp)
    8000535c:	00200513          	li	a0,2
    80005360:	02010113          	addi	sp,sp,32
    80005364:	00008067          	ret
    80005368:	00000097          	auipc	ra,0x0
    8000536c:	24c080e7          	jalr	588(ra) # 800055b4 <plic_claim>
    80005370:	00a00793          	li	a5,10
    80005374:	00050493          	mv	s1,a0
    80005378:	06f50663          	beq	a0,a5,800053e4 <devintr+0x100>
    8000537c:	00100513          	li	a0,1
    80005380:	fa0482e3          	beqz	s1,80005324 <devintr+0x40>
    80005384:	00048593          	mv	a1,s1
    80005388:	00003517          	auipc	a0,0x3
    8000538c:	2c850513          	addi	a0,a0,712 # 80008650 <kvmincrease+0x14f0>
    80005390:	00000097          	auipc	ra,0x0
    80005394:	668080e7          	jalr	1640(ra) # 800059f8 <__printf>
    80005398:	00048513          	mv	a0,s1
    8000539c:	00000097          	auipc	ra,0x0
    800053a0:	250080e7          	jalr	592(ra) # 800055ec <plic_complete>
    800053a4:	00100513          	li	a0,1
    800053a8:	f7dff06f          	j	80005324 <devintr+0x40>
    800053ac:	00006517          	auipc	a0,0x6
    800053b0:	d1450513          	addi	a0,a0,-748 # 8000b0c0 <tickslock>
    800053b4:	00001097          	auipc	ra,0x1
    800053b8:	318080e7          	jalr	792(ra) # 800066cc <acquire>
    800053bc:	00005717          	auipc	a4,0x5
    800053c0:	bd870713          	addi	a4,a4,-1064 # 80009f94 <ticks>
    800053c4:	00072783          	lw	a5,0(a4)
    800053c8:	00006517          	auipc	a0,0x6
    800053cc:	cf850513          	addi	a0,a0,-776 # 8000b0c0 <tickslock>
    800053d0:	0017879b          	addiw	a5,a5,1
    800053d4:	00f72023          	sw	a5,0(a4)
    800053d8:	00001097          	auipc	ra,0x1
    800053dc:	3c0080e7          	jalr	960(ra) # 80006798 <release>
    800053e0:	f65ff06f          	j	80005344 <devintr+0x60>
    800053e4:	00001097          	auipc	ra,0x1
    800053e8:	f1c080e7          	jalr	-228(ra) # 80006300 <uartintr>
    800053ec:	fadff06f          	j	80005398 <devintr+0xb4>

00000000800053f0 <kernelvec>:
    800053f0:	f0010113          	addi	sp,sp,-256
    800053f4:	00113023          	sd	ra,0(sp)
    800053f8:	00213423          	sd	sp,8(sp)
    800053fc:	00313823          	sd	gp,16(sp)
    80005400:	00413c23          	sd	tp,24(sp)
    80005404:	02513023          	sd	t0,32(sp)
    80005408:	02613423          	sd	t1,40(sp)
    8000540c:	02713823          	sd	t2,48(sp)
    80005410:	02813c23          	sd	s0,56(sp)
    80005414:	04913023          	sd	s1,64(sp)
    80005418:	04a13423          	sd	a0,72(sp)
    8000541c:	04b13823          	sd	a1,80(sp)
    80005420:	04c13c23          	sd	a2,88(sp)
    80005424:	06d13023          	sd	a3,96(sp)
    80005428:	06e13423          	sd	a4,104(sp)
    8000542c:	06f13823          	sd	a5,112(sp)
    80005430:	07013c23          	sd	a6,120(sp)
    80005434:	09113023          	sd	a7,128(sp)
    80005438:	09213423          	sd	s2,136(sp)
    8000543c:	09313823          	sd	s3,144(sp)
    80005440:	09413c23          	sd	s4,152(sp)
    80005444:	0b513023          	sd	s5,160(sp)
    80005448:	0b613423          	sd	s6,168(sp)
    8000544c:	0b713823          	sd	s7,176(sp)
    80005450:	0b813c23          	sd	s8,184(sp)
    80005454:	0d913023          	sd	s9,192(sp)
    80005458:	0da13423          	sd	s10,200(sp)
    8000545c:	0db13823          	sd	s11,208(sp)
    80005460:	0dc13c23          	sd	t3,216(sp)
    80005464:	0fd13023          	sd	t4,224(sp)
    80005468:	0fe13423          	sd	t5,232(sp)
    8000546c:	0ff13823          	sd	t6,240(sp)
    80005470:	cd5ff0ef          	jal	ra,80005144 <kerneltrap>
    80005474:	00013083          	ld	ra,0(sp)
    80005478:	00813103          	ld	sp,8(sp)
    8000547c:	01013183          	ld	gp,16(sp)
    80005480:	02013283          	ld	t0,32(sp)
    80005484:	02813303          	ld	t1,40(sp)
    80005488:	03013383          	ld	t2,48(sp)
    8000548c:	03813403          	ld	s0,56(sp)
    80005490:	04013483          	ld	s1,64(sp)
    80005494:	04813503          	ld	a0,72(sp)
    80005498:	05013583          	ld	a1,80(sp)
    8000549c:	05813603          	ld	a2,88(sp)
    800054a0:	06013683          	ld	a3,96(sp)
    800054a4:	06813703          	ld	a4,104(sp)
    800054a8:	07013783          	ld	a5,112(sp)
    800054ac:	07813803          	ld	a6,120(sp)
    800054b0:	08013883          	ld	a7,128(sp)
    800054b4:	08813903          	ld	s2,136(sp)
    800054b8:	09013983          	ld	s3,144(sp)
    800054bc:	09813a03          	ld	s4,152(sp)
    800054c0:	0a013a83          	ld	s5,160(sp)
    800054c4:	0a813b03          	ld	s6,168(sp)
    800054c8:	0b013b83          	ld	s7,176(sp)
    800054cc:	0b813c03          	ld	s8,184(sp)
    800054d0:	0c013c83          	ld	s9,192(sp)
    800054d4:	0c813d03          	ld	s10,200(sp)
    800054d8:	0d013d83          	ld	s11,208(sp)
    800054dc:	0d813e03          	ld	t3,216(sp)
    800054e0:	0e013e83          	ld	t4,224(sp)
    800054e4:	0e813f03          	ld	t5,232(sp)
    800054e8:	0f013f83          	ld	t6,240(sp)
    800054ec:	10010113          	addi	sp,sp,256
    800054f0:	10200073          	sret
    800054f4:	00000013          	nop
    800054f8:	00000013          	nop
    800054fc:	00000013          	nop

0000000080005500 <timervec>:
    80005500:	34051573          	csrrw	a0,mscratch,a0
    80005504:	00b53023          	sd	a1,0(a0)
    80005508:	00c53423          	sd	a2,8(a0)
    8000550c:	00d53823          	sd	a3,16(a0)
    80005510:	01853583          	ld	a1,24(a0)
    80005514:	02053603          	ld	a2,32(a0)
    80005518:	0005b683          	ld	a3,0(a1)
    8000551c:	00c686b3          	add	a3,a3,a2
    80005520:	00d5b023          	sd	a3,0(a1)
    80005524:	00200593          	li	a1,2
    80005528:	14459073          	csrw	sip,a1
    8000552c:	01053683          	ld	a3,16(a0)
    80005530:	00853603          	ld	a2,8(a0)
    80005534:	00053583          	ld	a1,0(a0)
    80005538:	34051573          	csrrw	a0,mscratch,a0
    8000553c:	30200073          	mret

0000000080005540 <plicinit>:
    80005540:	ff010113          	addi	sp,sp,-16
    80005544:	00813423          	sd	s0,8(sp)
    80005548:	01010413          	addi	s0,sp,16
    8000554c:	00813403          	ld	s0,8(sp)
    80005550:	0c0007b7          	lui	a5,0xc000
    80005554:	00100713          	li	a4,1
    80005558:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000555c:	00e7a223          	sw	a4,4(a5)
    80005560:	01010113          	addi	sp,sp,16
    80005564:	00008067          	ret

0000000080005568 <plicinithart>:
    80005568:	ff010113          	addi	sp,sp,-16
    8000556c:	00813023          	sd	s0,0(sp)
    80005570:	00113423          	sd	ra,8(sp)
    80005574:	01010413          	addi	s0,sp,16
    80005578:	00000097          	auipc	ra,0x0
    8000557c:	a4c080e7          	jalr	-1460(ra) # 80004fc4 <cpuid>
    80005580:	0085171b          	slliw	a4,a0,0x8
    80005584:	0c0027b7          	lui	a5,0xc002
    80005588:	00e787b3          	add	a5,a5,a4
    8000558c:	40200713          	li	a4,1026
    80005590:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005594:	00813083          	ld	ra,8(sp)
    80005598:	00013403          	ld	s0,0(sp)
    8000559c:	00d5151b          	slliw	a0,a0,0xd
    800055a0:	0c2017b7          	lui	a5,0xc201
    800055a4:	00a78533          	add	a0,a5,a0
    800055a8:	00052023          	sw	zero,0(a0)
    800055ac:	01010113          	addi	sp,sp,16
    800055b0:	00008067          	ret

00000000800055b4 <plic_claim>:
    800055b4:	ff010113          	addi	sp,sp,-16
    800055b8:	00813023          	sd	s0,0(sp)
    800055bc:	00113423          	sd	ra,8(sp)
    800055c0:	01010413          	addi	s0,sp,16
    800055c4:	00000097          	auipc	ra,0x0
    800055c8:	a00080e7          	jalr	-1536(ra) # 80004fc4 <cpuid>
    800055cc:	00813083          	ld	ra,8(sp)
    800055d0:	00013403          	ld	s0,0(sp)
    800055d4:	00d5151b          	slliw	a0,a0,0xd
    800055d8:	0c2017b7          	lui	a5,0xc201
    800055dc:	00a78533          	add	a0,a5,a0
    800055e0:	00452503          	lw	a0,4(a0)
    800055e4:	01010113          	addi	sp,sp,16
    800055e8:	00008067          	ret

00000000800055ec <plic_complete>:
    800055ec:	fe010113          	addi	sp,sp,-32
    800055f0:	00813823          	sd	s0,16(sp)
    800055f4:	00913423          	sd	s1,8(sp)
    800055f8:	00113c23          	sd	ra,24(sp)
    800055fc:	02010413          	addi	s0,sp,32
    80005600:	00050493          	mv	s1,a0
    80005604:	00000097          	auipc	ra,0x0
    80005608:	9c0080e7          	jalr	-1600(ra) # 80004fc4 <cpuid>
    8000560c:	01813083          	ld	ra,24(sp)
    80005610:	01013403          	ld	s0,16(sp)
    80005614:	00d5179b          	slliw	a5,a0,0xd
    80005618:	0c201737          	lui	a4,0xc201
    8000561c:	00f707b3          	add	a5,a4,a5
    80005620:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80005624:	00813483          	ld	s1,8(sp)
    80005628:	02010113          	addi	sp,sp,32
    8000562c:	00008067          	ret

0000000080005630 <consolewrite>:
    80005630:	fb010113          	addi	sp,sp,-80
    80005634:	04813023          	sd	s0,64(sp)
    80005638:	04113423          	sd	ra,72(sp)
    8000563c:	02913c23          	sd	s1,56(sp)
    80005640:	03213823          	sd	s2,48(sp)
    80005644:	03313423          	sd	s3,40(sp)
    80005648:	03413023          	sd	s4,32(sp)
    8000564c:	01513c23          	sd	s5,24(sp)
    80005650:	05010413          	addi	s0,sp,80
    80005654:	06c05c63          	blez	a2,800056cc <consolewrite+0x9c>
    80005658:	00060993          	mv	s3,a2
    8000565c:	00050a13          	mv	s4,a0
    80005660:	00058493          	mv	s1,a1
    80005664:	00000913          	li	s2,0
    80005668:	fff00a93          	li	s5,-1
    8000566c:	01c0006f          	j	80005688 <consolewrite+0x58>
    80005670:	fbf44503          	lbu	a0,-65(s0)
    80005674:	0019091b          	addiw	s2,s2,1
    80005678:	00148493          	addi	s1,s1,1
    8000567c:	00001097          	auipc	ra,0x1
    80005680:	a9c080e7          	jalr	-1380(ra) # 80006118 <uartputc>
    80005684:	03298063          	beq	s3,s2,800056a4 <consolewrite+0x74>
    80005688:	00048613          	mv	a2,s1
    8000568c:	00100693          	li	a3,1
    80005690:	000a0593          	mv	a1,s4
    80005694:	fbf40513          	addi	a0,s0,-65
    80005698:	00000097          	auipc	ra,0x0
    8000569c:	9e4080e7          	jalr	-1564(ra) # 8000507c <either_copyin>
    800056a0:	fd5518e3          	bne	a0,s5,80005670 <consolewrite+0x40>
    800056a4:	04813083          	ld	ra,72(sp)
    800056a8:	04013403          	ld	s0,64(sp)
    800056ac:	03813483          	ld	s1,56(sp)
    800056b0:	02813983          	ld	s3,40(sp)
    800056b4:	02013a03          	ld	s4,32(sp)
    800056b8:	01813a83          	ld	s5,24(sp)
    800056bc:	00090513          	mv	a0,s2
    800056c0:	03013903          	ld	s2,48(sp)
    800056c4:	05010113          	addi	sp,sp,80
    800056c8:	00008067          	ret
    800056cc:	00000913          	li	s2,0
    800056d0:	fd5ff06f          	j	800056a4 <consolewrite+0x74>

00000000800056d4 <consoleread>:
    800056d4:	f9010113          	addi	sp,sp,-112
    800056d8:	06813023          	sd	s0,96(sp)
    800056dc:	04913c23          	sd	s1,88(sp)
    800056e0:	05213823          	sd	s2,80(sp)
    800056e4:	05313423          	sd	s3,72(sp)
    800056e8:	05413023          	sd	s4,64(sp)
    800056ec:	03513c23          	sd	s5,56(sp)
    800056f0:	03613823          	sd	s6,48(sp)
    800056f4:	03713423          	sd	s7,40(sp)
    800056f8:	03813023          	sd	s8,32(sp)
    800056fc:	06113423          	sd	ra,104(sp)
    80005700:	01913c23          	sd	s9,24(sp)
    80005704:	07010413          	addi	s0,sp,112
    80005708:	00060b93          	mv	s7,a2
    8000570c:	00050913          	mv	s2,a0
    80005710:	00058c13          	mv	s8,a1
    80005714:	00060b1b          	sext.w	s6,a2
    80005718:	00006497          	auipc	s1,0x6
    8000571c:	9d048493          	addi	s1,s1,-1584 # 8000b0e8 <cons>
    80005720:	00400993          	li	s3,4
    80005724:	fff00a13          	li	s4,-1
    80005728:	00a00a93          	li	s5,10
    8000572c:	05705e63          	blez	s7,80005788 <consoleread+0xb4>
    80005730:	09c4a703          	lw	a4,156(s1)
    80005734:	0984a783          	lw	a5,152(s1)
    80005738:	0007071b          	sext.w	a4,a4
    8000573c:	08e78463          	beq	a5,a4,800057c4 <consoleread+0xf0>
    80005740:	07f7f713          	andi	a4,a5,127
    80005744:	00e48733          	add	a4,s1,a4
    80005748:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000574c:	0017869b          	addiw	a3,a5,1
    80005750:	08d4ac23          	sw	a3,152(s1)
    80005754:	00070c9b          	sext.w	s9,a4
    80005758:	0b370663          	beq	a4,s3,80005804 <consoleread+0x130>
    8000575c:	00100693          	li	a3,1
    80005760:	f9f40613          	addi	a2,s0,-97
    80005764:	000c0593          	mv	a1,s8
    80005768:	00090513          	mv	a0,s2
    8000576c:	f8e40fa3          	sb	a4,-97(s0)
    80005770:	00000097          	auipc	ra,0x0
    80005774:	8c0080e7          	jalr	-1856(ra) # 80005030 <either_copyout>
    80005778:	01450863          	beq	a0,s4,80005788 <consoleread+0xb4>
    8000577c:	001c0c13          	addi	s8,s8,1
    80005780:	fffb8b9b          	addiw	s7,s7,-1
    80005784:	fb5c94e3          	bne	s9,s5,8000572c <consoleread+0x58>
    80005788:	000b851b          	sext.w	a0,s7
    8000578c:	06813083          	ld	ra,104(sp)
    80005790:	06013403          	ld	s0,96(sp)
    80005794:	05813483          	ld	s1,88(sp)
    80005798:	05013903          	ld	s2,80(sp)
    8000579c:	04813983          	ld	s3,72(sp)
    800057a0:	04013a03          	ld	s4,64(sp)
    800057a4:	03813a83          	ld	s5,56(sp)
    800057a8:	02813b83          	ld	s7,40(sp)
    800057ac:	02013c03          	ld	s8,32(sp)
    800057b0:	01813c83          	ld	s9,24(sp)
    800057b4:	40ab053b          	subw	a0,s6,a0
    800057b8:	03013b03          	ld	s6,48(sp)
    800057bc:	07010113          	addi	sp,sp,112
    800057c0:	00008067          	ret
    800057c4:	00001097          	auipc	ra,0x1
    800057c8:	1d8080e7          	jalr	472(ra) # 8000699c <push_on>
    800057cc:	0984a703          	lw	a4,152(s1)
    800057d0:	09c4a783          	lw	a5,156(s1)
    800057d4:	0007879b          	sext.w	a5,a5
    800057d8:	fef70ce3          	beq	a4,a5,800057d0 <consoleread+0xfc>
    800057dc:	00001097          	auipc	ra,0x1
    800057e0:	234080e7          	jalr	564(ra) # 80006a10 <pop_on>
    800057e4:	0984a783          	lw	a5,152(s1)
    800057e8:	07f7f713          	andi	a4,a5,127
    800057ec:	00e48733          	add	a4,s1,a4
    800057f0:	01874703          	lbu	a4,24(a4)
    800057f4:	0017869b          	addiw	a3,a5,1
    800057f8:	08d4ac23          	sw	a3,152(s1)
    800057fc:	00070c9b          	sext.w	s9,a4
    80005800:	f5371ee3          	bne	a4,s3,8000575c <consoleread+0x88>
    80005804:	000b851b          	sext.w	a0,s7
    80005808:	f96bf2e3          	bgeu	s7,s6,8000578c <consoleread+0xb8>
    8000580c:	08f4ac23          	sw	a5,152(s1)
    80005810:	f7dff06f          	j	8000578c <consoleread+0xb8>

0000000080005814 <consputc>:
    80005814:	10000793          	li	a5,256
    80005818:	00f50663          	beq	a0,a5,80005824 <consputc+0x10>
    8000581c:	00001317          	auipc	t1,0x1
    80005820:	9f430067          	jr	-1548(t1) # 80006210 <uartputc_sync>
    80005824:	ff010113          	addi	sp,sp,-16
    80005828:	00113423          	sd	ra,8(sp)
    8000582c:	00813023          	sd	s0,0(sp)
    80005830:	01010413          	addi	s0,sp,16
    80005834:	00800513          	li	a0,8
    80005838:	00001097          	auipc	ra,0x1
    8000583c:	9d8080e7          	jalr	-1576(ra) # 80006210 <uartputc_sync>
    80005840:	02000513          	li	a0,32
    80005844:	00001097          	auipc	ra,0x1
    80005848:	9cc080e7          	jalr	-1588(ra) # 80006210 <uartputc_sync>
    8000584c:	00013403          	ld	s0,0(sp)
    80005850:	00813083          	ld	ra,8(sp)
    80005854:	00800513          	li	a0,8
    80005858:	01010113          	addi	sp,sp,16
    8000585c:	00001317          	auipc	t1,0x1
    80005860:	9b430067          	jr	-1612(t1) # 80006210 <uartputc_sync>

0000000080005864 <consoleintr>:
    80005864:	fe010113          	addi	sp,sp,-32
    80005868:	00813823          	sd	s0,16(sp)
    8000586c:	00913423          	sd	s1,8(sp)
    80005870:	01213023          	sd	s2,0(sp)
    80005874:	00113c23          	sd	ra,24(sp)
    80005878:	02010413          	addi	s0,sp,32
    8000587c:	00006917          	auipc	s2,0x6
    80005880:	86c90913          	addi	s2,s2,-1940 # 8000b0e8 <cons>
    80005884:	00050493          	mv	s1,a0
    80005888:	00090513          	mv	a0,s2
    8000588c:	00001097          	auipc	ra,0x1
    80005890:	e40080e7          	jalr	-448(ra) # 800066cc <acquire>
    80005894:	02048c63          	beqz	s1,800058cc <consoleintr+0x68>
    80005898:	0a092783          	lw	a5,160(s2)
    8000589c:	09892703          	lw	a4,152(s2)
    800058a0:	07f00693          	li	a3,127
    800058a4:	40e7873b          	subw	a4,a5,a4
    800058a8:	02e6e263          	bltu	a3,a4,800058cc <consoleintr+0x68>
    800058ac:	00d00713          	li	a4,13
    800058b0:	04e48063          	beq	s1,a4,800058f0 <consoleintr+0x8c>
    800058b4:	07f7f713          	andi	a4,a5,127
    800058b8:	00e90733          	add	a4,s2,a4
    800058bc:	0017879b          	addiw	a5,a5,1
    800058c0:	0af92023          	sw	a5,160(s2)
    800058c4:	00970c23          	sb	s1,24(a4)
    800058c8:	08f92e23          	sw	a5,156(s2)
    800058cc:	01013403          	ld	s0,16(sp)
    800058d0:	01813083          	ld	ra,24(sp)
    800058d4:	00813483          	ld	s1,8(sp)
    800058d8:	00013903          	ld	s2,0(sp)
    800058dc:	00006517          	auipc	a0,0x6
    800058e0:	80c50513          	addi	a0,a0,-2036 # 8000b0e8 <cons>
    800058e4:	02010113          	addi	sp,sp,32
    800058e8:	00001317          	auipc	t1,0x1
    800058ec:	eb030067          	jr	-336(t1) # 80006798 <release>
    800058f0:	00a00493          	li	s1,10
    800058f4:	fc1ff06f          	j	800058b4 <consoleintr+0x50>

00000000800058f8 <consoleinit>:
    800058f8:	fe010113          	addi	sp,sp,-32
    800058fc:	00113c23          	sd	ra,24(sp)
    80005900:	00813823          	sd	s0,16(sp)
    80005904:	00913423          	sd	s1,8(sp)
    80005908:	02010413          	addi	s0,sp,32
    8000590c:	00005497          	auipc	s1,0x5
    80005910:	7dc48493          	addi	s1,s1,2012 # 8000b0e8 <cons>
    80005914:	00048513          	mv	a0,s1
    80005918:	00003597          	auipc	a1,0x3
    8000591c:	d9058593          	addi	a1,a1,-624 # 800086a8 <kvmincrease+0x1548>
    80005920:	00001097          	auipc	ra,0x1
    80005924:	d88080e7          	jalr	-632(ra) # 800066a8 <initlock>
    80005928:	00000097          	auipc	ra,0x0
    8000592c:	7ac080e7          	jalr	1964(ra) # 800060d4 <uartinit>
    80005930:	01813083          	ld	ra,24(sp)
    80005934:	01013403          	ld	s0,16(sp)
    80005938:	00000797          	auipc	a5,0x0
    8000593c:	d9c78793          	addi	a5,a5,-612 # 800056d4 <consoleread>
    80005940:	0af4bc23          	sd	a5,184(s1)
    80005944:	00000797          	auipc	a5,0x0
    80005948:	cec78793          	addi	a5,a5,-788 # 80005630 <consolewrite>
    8000594c:	0cf4b023          	sd	a5,192(s1)
    80005950:	00813483          	ld	s1,8(sp)
    80005954:	02010113          	addi	sp,sp,32
    80005958:	00008067          	ret

000000008000595c <console_read>:
    8000595c:	ff010113          	addi	sp,sp,-16
    80005960:	00813423          	sd	s0,8(sp)
    80005964:	01010413          	addi	s0,sp,16
    80005968:	00813403          	ld	s0,8(sp)
    8000596c:	00006317          	auipc	t1,0x6
    80005970:	83433303          	ld	t1,-1996(t1) # 8000b1a0 <devsw+0x10>
    80005974:	01010113          	addi	sp,sp,16
    80005978:	00030067          	jr	t1

000000008000597c <console_write>:
    8000597c:	ff010113          	addi	sp,sp,-16
    80005980:	00813423          	sd	s0,8(sp)
    80005984:	01010413          	addi	s0,sp,16
    80005988:	00813403          	ld	s0,8(sp)
    8000598c:	00006317          	auipc	t1,0x6
    80005990:	81c33303          	ld	t1,-2020(t1) # 8000b1a8 <devsw+0x18>
    80005994:	01010113          	addi	sp,sp,16
    80005998:	00030067          	jr	t1

000000008000599c <panic>:
    8000599c:	fe010113          	addi	sp,sp,-32
    800059a0:	00113c23          	sd	ra,24(sp)
    800059a4:	00813823          	sd	s0,16(sp)
    800059a8:	00913423          	sd	s1,8(sp)
    800059ac:	02010413          	addi	s0,sp,32
    800059b0:	00050493          	mv	s1,a0
    800059b4:	00003517          	auipc	a0,0x3
    800059b8:	cfc50513          	addi	a0,a0,-772 # 800086b0 <kvmincrease+0x1550>
    800059bc:	00006797          	auipc	a5,0x6
    800059c0:	8807a623          	sw	zero,-1908(a5) # 8000b248 <pr+0x18>
    800059c4:	00000097          	auipc	ra,0x0
    800059c8:	034080e7          	jalr	52(ra) # 800059f8 <__printf>
    800059cc:	00048513          	mv	a0,s1
    800059d0:	00000097          	auipc	ra,0x0
    800059d4:	028080e7          	jalr	40(ra) # 800059f8 <__printf>
    800059d8:	00002517          	auipc	a0,0x2
    800059dc:	7b050513          	addi	a0,a0,1968 # 80008188 <kvmincrease+0x1028>
    800059e0:	00000097          	auipc	ra,0x0
    800059e4:	018080e7          	jalr	24(ra) # 800059f8 <__printf>
    800059e8:	00100793          	li	a5,1
    800059ec:	00004717          	auipc	a4,0x4
    800059f0:	5af72623          	sw	a5,1452(a4) # 80009f98 <panicked>
    800059f4:	0000006f          	j	800059f4 <panic+0x58>

00000000800059f8 <__printf>:
    800059f8:	f3010113          	addi	sp,sp,-208
    800059fc:	08813023          	sd	s0,128(sp)
    80005a00:	07313423          	sd	s3,104(sp)
    80005a04:	09010413          	addi	s0,sp,144
    80005a08:	05813023          	sd	s8,64(sp)
    80005a0c:	08113423          	sd	ra,136(sp)
    80005a10:	06913c23          	sd	s1,120(sp)
    80005a14:	07213823          	sd	s2,112(sp)
    80005a18:	07413023          	sd	s4,96(sp)
    80005a1c:	05513c23          	sd	s5,88(sp)
    80005a20:	05613823          	sd	s6,80(sp)
    80005a24:	05713423          	sd	s7,72(sp)
    80005a28:	03913c23          	sd	s9,56(sp)
    80005a2c:	03a13823          	sd	s10,48(sp)
    80005a30:	03b13423          	sd	s11,40(sp)
    80005a34:	00005317          	auipc	t1,0x5
    80005a38:	7fc30313          	addi	t1,t1,2044 # 8000b230 <pr>
    80005a3c:	01832c03          	lw	s8,24(t1)
    80005a40:	00b43423          	sd	a1,8(s0)
    80005a44:	00c43823          	sd	a2,16(s0)
    80005a48:	00d43c23          	sd	a3,24(s0)
    80005a4c:	02e43023          	sd	a4,32(s0)
    80005a50:	02f43423          	sd	a5,40(s0)
    80005a54:	03043823          	sd	a6,48(s0)
    80005a58:	03143c23          	sd	a7,56(s0)
    80005a5c:	00050993          	mv	s3,a0
    80005a60:	4a0c1663          	bnez	s8,80005f0c <__printf+0x514>
    80005a64:	60098c63          	beqz	s3,8000607c <__printf+0x684>
    80005a68:	0009c503          	lbu	a0,0(s3)
    80005a6c:	00840793          	addi	a5,s0,8
    80005a70:	f6f43c23          	sd	a5,-136(s0)
    80005a74:	00000493          	li	s1,0
    80005a78:	22050063          	beqz	a0,80005c98 <__printf+0x2a0>
    80005a7c:	00002a37          	lui	s4,0x2
    80005a80:	00018ab7          	lui	s5,0x18
    80005a84:	000f4b37          	lui	s6,0xf4
    80005a88:	00989bb7          	lui	s7,0x989
    80005a8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005a90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005a94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005a98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005a9c:	00148c9b          	addiw	s9,s1,1
    80005aa0:	02500793          	li	a5,37
    80005aa4:	01998933          	add	s2,s3,s9
    80005aa8:	38f51263          	bne	a0,a5,80005e2c <__printf+0x434>
    80005aac:	00094783          	lbu	a5,0(s2)
    80005ab0:	00078c9b          	sext.w	s9,a5
    80005ab4:	1e078263          	beqz	a5,80005c98 <__printf+0x2a0>
    80005ab8:	0024849b          	addiw	s1,s1,2
    80005abc:	07000713          	li	a4,112
    80005ac0:	00998933          	add	s2,s3,s1
    80005ac4:	38e78a63          	beq	a5,a4,80005e58 <__printf+0x460>
    80005ac8:	20f76863          	bltu	a4,a5,80005cd8 <__printf+0x2e0>
    80005acc:	42a78863          	beq	a5,a0,80005efc <__printf+0x504>
    80005ad0:	06400713          	li	a4,100
    80005ad4:	40e79663          	bne	a5,a4,80005ee0 <__printf+0x4e8>
    80005ad8:	f7843783          	ld	a5,-136(s0)
    80005adc:	0007a603          	lw	a2,0(a5)
    80005ae0:	00878793          	addi	a5,a5,8
    80005ae4:	f6f43c23          	sd	a5,-136(s0)
    80005ae8:	42064a63          	bltz	a2,80005f1c <__printf+0x524>
    80005aec:	00a00713          	li	a4,10
    80005af0:	02e677bb          	remuw	a5,a2,a4
    80005af4:	00003d97          	auipc	s11,0x3
    80005af8:	be4d8d93          	addi	s11,s11,-1052 # 800086d8 <digits>
    80005afc:	00900593          	li	a1,9
    80005b00:	0006051b          	sext.w	a0,a2
    80005b04:	00000c93          	li	s9,0
    80005b08:	02079793          	slli	a5,a5,0x20
    80005b0c:	0207d793          	srli	a5,a5,0x20
    80005b10:	00fd87b3          	add	a5,s11,a5
    80005b14:	0007c783          	lbu	a5,0(a5)
    80005b18:	02e656bb          	divuw	a3,a2,a4
    80005b1c:	f8f40023          	sb	a5,-128(s0)
    80005b20:	14c5d863          	bge	a1,a2,80005c70 <__printf+0x278>
    80005b24:	06300593          	li	a1,99
    80005b28:	00100c93          	li	s9,1
    80005b2c:	02e6f7bb          	remuw	a5,a3,a4
    80005b30:	02079793          	slli	a5,a5,0x20
    80005b34:	0207d793          	srli	a5,a5,0x20
    80005b38:	00fd87b3          	add	a5,s11,a5
    80005b3c:	0007c783          	lbu	a5,0(a5)
    80005b40:	02e6d73b          	divuw	a4,a3,a4
    80005b44:	f8f400a3          	sb	a5,-127(s0)
    80005b48:	12a5f463          	bgeu	a1,a0,80005c70 <__printf+0x278>
    80005b4c:	00a00693          	li	a3,10
    80005b50:	00900593          	li	a1,9
    80005b54:	02d777bb          	remuw	a5,a4,a3
    80005b58:	02079793          	slli	a5,a5,0x20
    80005b5c:	0207d793          	srli	a5,a5,0x20
    80005b60:	00fd87b3          	add	a5,s11,a5
    80005b64:	0007c503          	lbu	a0,0(a5)
    80005b68:	02d757bb          	divuw	a5,a4,a3
    80005b6c:	f8a40123          	sb	a0,-126(s0)
    80005b70:	48e5f263          	bgeu	a1,a4,80005ff4 <__printf+0x5fc>
    80005b74:	06300513          	li	a0,99
    80005b78:	02d7f5bb          	remuw	a1,a5,a3
    80005b7c:	02059593          	slli	a1,a1,0x20
    80005b80:	0205d593          	srli	a1,a1,0x20
    80005b84:	00bd85b3          	add	a1,s11,a1
    80005b88:	0005c583          	lbu	a1,0(a1)
    80005b8c:	02d7d7bb          	divuw	a5,a5,a3
    80005b90:	f8b401a3          	sb	a1,-125(s0)
    80005b94:	48e57263          	bgeu	a0,a4,80006018 <__printf+0x620>
    80005b98:	3e700513          	li	a0,999
    80005b9c:	02d7f5bb          	remuw	a1,a5,a3
    80005ba0:	02059593          	slli	a1,a1,0x20
    80005ba4:	0205d593          	srli	a1,a1,0x20
    80005ba8:	00bd85b3          	add	a1,s11,a1
    80005bac:	0005c583          	lbu	a1,0(a1)
    80005bb0:	02d7d7bb          	divuw	a5,a5,a3
    80005bb4:	f8b40223          	sb	a1,-124(s0)
    80005bb8:	46e57663          	bgeu	a0,a4,80006024 <__printf+0x62c>
    80005bbc:	02d7f5bb          	remuw	a1,a5,a3
    80005bc0:	02059593          	slli	a1,a1,0x20
    80005bc4:	0205d593          	srli	a1,a1,0x20
    80005bc8:	00bd85b3          	add	a1,s11,a1
    80005bcc:	0005c583          	lbu	a1,0(a1)
    80005bd0:	02d7d7bb          	divuw	a5,a5,a3
    80005bd4:	f8b402a3          	sb	a1,-123(s0)
    80005bd8:	46ea7863          	bgeu	s4,a4,80006048 <__printf+0x650>
    80005bdc:	02d7f5bb          	remuw	a1,a5,a3
    80005be0:	02059593          	slli	a1,a1,0x20
    80005be4:	0205d593          	srli	a1,a1,0x20
    80005be8:	00bd85b3          	add	a1,s11,a1
    80005bec:	0005c583          	lbu	a1,0(a1)
    80005bf0:	02d7d7bb          	divuw	a5,a5,a3
    80005bf4:	f8b40323          	sb	a1,-122(s0)
    80005bf8:	3eeaf863          	bgeu	s5,a4,80005fe8 <__printf+0x5f0>
    80005bfc:	02d7f5bb          	remuw	a1,a5,a3
    80005c00:	02059593          	slli	a1,a1,0x20
    80005c04:	0205d593          	srli	a1,a1,0x20
    80005c08:	00bd85b3          	add	a1,s11,a1
    80005c0c:	0005c583          	lbu	a1,0(a1)
    80005c10:	02d7d7bb          	divuw	a5,a5,a3
    80005c14:	f8b403a3          	sb	a1,-121(s0)
    80005c18:	42eb7e63          	bgeu	s6,a4,80006054 <__printf+0x65c>
    80005c1c:	02d7f5bb          	remuw	a1,a5,a3
    80005c20:	02059593          	slli	a1,a1,0x20
    80005c24:	0205d593          	srli	a1,a1,0x20
    80005c28:	00bd85b3          	add	a1,s11,a1
    80005c2c:	0005c583          	lbu	a1,0(a1)
    80005c30:	02d7d7bb          	divuw	a5,a5,a3
    80005c34:	f8b40423          	sb	a1,-120(s0)
    80005c38:	42ebfc63          	bgeu	s7,a4,80006070 <__printf+0x678>
    80005c3c:	02079793          	slli	a5,a5,0x20
    80005c40:	0207d793          	srli	a5,a5,0x20
    80005c44:	00fd8db3          	add	s11,s11,a5
    80005c48:	000dc703          	lbu	a4,0(s11)
    80005c4c:	00a00793          	li	a5,10
    80005c50:	00900c93          	li	s9,9
    80005c54:	f8e404a3          	sb	a4,-119(s0)
    80005c58:	00065c63          	bgez	a2,80005c70 <__printf+0x278>
    80005c5c:	f9040713          	addi	a4,s0,-112
    80005c60:	00f70733          	add	a4,a4,a5
    80005c64:	02d00693          	li	a3,45
    80005c68:	fed70823          	sb	a3,-16(a4)
    80005c6c:	00078c93          	mv	s9,a5
    80005c70:	f8040793          	addi	a5,s0,-128
    80005c74:	01978cb3          	add	s9,a5,s9
    80005c78:	f7f40d13          	addi	s10,s0,-129
    80005c7c:	000cc503          	lbu	a0,0(s9)
    80005c80:	fffc8c93          	addi	s9,s9,-1
    80005c84:	00000097          	auipc	ra,0x0
    80005c88:	b90080e7          	jalr	-1136(ra) # 80005814 <consputc>
    80005c8c:	ffac98e3          	bne	s9,s10,80005c7c <__printf+0x284>
    80005c90:	00094503          	lbu	a0,0(s2)
    80005c94:	e00514e3          	bnez	a0,80005a9c <__printf+0xa4>
    80005c98:	1a0c1663          	bnez	s8,80005e44 <__printf+0x44c>
    80005c9c:	08813083          	ld	ra,136(sp)
    80005ca0:	08013403          	ld	s0,128(sp)
    80005ca4:	07813483          	ld	s1,120(sp)
    80005ca8:	07013903          	ld	s2,112(sp)
    80005cac:	06813983          	ld	s3,104(sp)
    80005cb0:	06013a03          	ld	s4,96(sp)
    80005cb4:	05813a83          	ld	s5,88(sp)
    80005cb8:	05013b03          	ld	s6,80(sp)
    80005cbc:	04813b83          	ld	s7,72(sp)
    80005cc0:	04013c03          	ld	s8,64(sp)
    80005cc4:	03813c83          	ld	s9,56(sp)
    80005cc8:	03013d03          	ld	s10,48(sp)
    80005ccc:	02813d83          	ld	s11,40(sp)
    80005cd0:	0d010113          	addi	sp,sp,208
    80005cd4:	00008067          	ret
    80005cd8:	07300713          	li	a4,115
    80005cdc:	1ce78a63          	beq	a5,a4,80005eb0 <__printf+0x4b8>
    80005ce0:	07800713          	li	a4,120
    80005ce4:	1ee79e63          	bne	a5,a4,80005ee0 <__printf+0x4e8>
    80005ce8:	f7843783          	ld	a5,-136(s0)
    80005cec:	0007a703          	lw	a4,0(a5)
    80005cf0:	00878793          	addi	a5,a5,8
    80005cf4:	f6f43c23          	sd	a5,-136(s0)
    80005cf8:	28074263          	bltz	a4,80005f7c <__printf+0x584>
    80005cfc:	00003d97          	auipc	s11,0x3
    80005d00:	9dcd8d93          	addi	s11,s11,-1572 # 800086d8 <digits>
    80005d04:	00f77793          	andi	a5,a4,15
    80005d08:	00fd87b3          	add	a5,s11,a5
    80005d0c:	0007c683          	lbu	a3,0(a5)
    80005d10:	00f00613          	li	a2,15
    80005d14:	0007079b          	sext.w	a5,a4
    80005d18:	f8d40023          	sb	a3,-128(s0)
    80005d1c:	0047559b          	srliw	a1,a4,0x4
    80005d20:	0047569b          	srliw	a3,a4,0x4
    80005d24:	00000c93          	li	s9,0
    80005d28:	0ee65063          	bge	a2,a4,80005e08 <__printf+0x410>
    80005d2c:	00f6f693          	andi	a3,a3,15
    80005d30:	00dd86b3          	add	a3,s11,a3
    80005d34:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005d38:	0087d79b          	srliw	a5,a5,0x8
    80005d3c:	00100c93          	li	s9,1
    80005d40:	f8d400a3          	sb	a3,-127(s0)
    80005d44:	0cb67263          	bgeu	a2,a1,80005e08 <__printf+0x410>
    80005d48:	00f7f693          	andi	a3,a5,15
    80005d4c:	00dd86b3          	add	a3,s11,a3
    80005d50:	0006c583          	lbu	a1,0(a3)
    80005d54:	00f00613          	li	a2,15
    80005d58:	0047d69b          	srliw	a3,a5,0x4
    80005d5c:	f8b40123          	sb	a1,-126(s0)
    80005d60:	0047d593          	srli	a1,a5,0x4
    80005d64:	28f67e63          	bgeu	a2,a5,80006000 <__printf+0x608>
    80005d68:	00f6f693          	andi	a3,a3,15
    80005d6c:	00dd86b3          	add	a3,s11,a3
    80005d70:	0006c503          	lbu	a0,0(a3)
    80005d74:	0087d813          	srli	a6,a5,0x8
    80005d78:	0087d69b          	srliw	a3,a5,0x8
    80005d7c:	f8a401a3          	sb	a0,-125(s0)
    80005d80:	28b67663          	bgeu	a2,a1,8000600c <__printf+0x614>
    80005d84:	00f6f693          	andi	a3,a3,15
    80005d88:	00dd86b3          	add	a3,s11,a3
    80005d8c:	0006c583          	lbu	a1,0(a3)
    80005d90:	00c7d513          	srli	a0,a5,0xc
    80005d94:	00c7d69b          	srliw	a3,a5,0xc
    80005d98:	f8b40223          	sb	a1,-124(s0)
    80005d9c:	29067a63          	bgeu	a2,a6,80006030 <__printf+0x638>
    80005da0:	00f6f693          	andi	a3,a3,15
    80005da4:	00dd86b3          	add	a3,s11,a3
    80005da8:	0006c583          	lbu	a1,0(a3)
    80005dac:	0107d813          	srli	a6,a5,0x10
    80005db0:	0107d69b          	srliw	a3,a5,0x10
    80005db4:	f8b402a3          	sb	a1,-123(s0)
    80005db8:	28a67263          	bgeu	a2,a0,8000603c <__printf+0x644>
    80005dbc:	00f6f693          	andi	a3,a3,15
    80005dc0:	00dd86b3          	add	a3,s11,a3
    80005dc4:	0006c683          	lbu	a3,0(a3)
    80005dc8:	0147d79b          	srliw	a5,a5,0x14
    80005dcc:	f8d40323          	sb	a3,-122(s0)
    80005dd0:	21067663          	bgeu	a2,a6,80005fdc <__printf+0x5e4>
    80005dd4:	02079793          	slli	a5,a5,0x20
    80005dd8:	0207d793          	srli	a5,a5,0x20
    80005ddc:	00fd8db3          	add	s11,s11,a5
    80005de0:	000dc683          	lbu	a3,0(s11)
    80005de4:	00800793          	li	a5,8
    80005de8:	00700c93          	li	s9,7
    80005dec:	f8d403a3          	sb	a3,-121(s0)
    80005df0:	00075c63          	bgez	a4,80005e08 <__printf+0x410>
    80005df4:	f9040713          	addi	a4,s0,-112
    80005df8:	00f70733          	add	a4,a4,a5
    80005dfc:	02d00693          	li	a3,45
    80005e00:	fed70823          	sb	a3,-16(a4)
    80005e04:	00078c93          	mv	s9,a5
    80005e08:	f8040793          	addi	a5,s0,-128
    80005e0c:	01978cb3          	add	s9,a5,s9
    80005e10:	f7f40d13          	addi	s10,s0,-129
    80005e14:	000cc503          	lbu	a0,0(s9)
    80005e18:	fffc8c93          	addi	s9,s9,-1
    80005e1c:	00000097          	auipc	ra,0x0
    80005e20:	9f8080e7          	jalr	-1544(ra) # 80005814 <consputc>
    80005e24:	ff9d18e3          	bne	s10,s9,80005e14 <__printf+0x41c>
    80005e28:	0100006f          	j	80005e38 <__printf+0x440>
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	9e8080e7          	jalr	-1560(ra) # 80005814 <consputc>
    80005e34:	000c8493          	mv	s1,s9
    80005e38:	00094503          	lbu	a0,0(s2)
    80005e3c:	c60510e3          	bnez	a0,80005a9c <__printf+0xa4>
    80005e40:	e40c0ee3          	beqz	s8,80005c9c <__printf+0x2a4>
    80005e44:	00005517          	auipc	a0,0x5
    80005e48:	3ec50513          	addi	a0,a0,1004 # 8000b230 <pr>
    80005e4c:	00001097          	auipc	ra,0x1
    80005e50:	94c080e7          	jalr	-1716(ra) # 80006798 <release>
    80005e54:	e49ff06f          	j	80005c9c <__printf+0x2a4>
    80005e58:	f7843783          	ld	a5,-136(s0)
    80005e5c:	03000513          	li	a0,48
    80005e60:	01000d13          	li	s10,16
    80005e64:	00878713          	addi	a4,a5,8
    80005e68:	0007bc83          	ld	s9,0(a5)
    80005e6c:	f6e43c23          	sd	a4,-136(s0)
    80005e70:	00000097          	auipc	ra,0x0
    80005e74:	9a4080e7          	jalr	-1628(ra) # 80005814 <consputc>
    80005e78:	07800513          	li	a0,120
    80005e7c:	00000097          	auipc	ra,0x0
    80005e80:	998080e7          	jalr	-1640(ra) # 80005814 <consputc>
    80005e84:	00003d97          	auipc	s11,0x3
    80005e88:	854d8d93          	addi	s11,s11,-1964 # 800086d8 <digits>
    80005e8c:	03ccd793          	srli	a5,s9,0x3c
    80005e90:	00fd87b3          	add	a5,s11,a5
    80005e94:	0007c503          	lbu	a0,0(a5)
    80005e98:	fffd0d1b          	addiw	s10,s10,-1
    80005e9c:	004c9c93          	slli	s9,s9,0x4
    80005ea0:	00000097          	auipc	ra,0x0
    80005ea4:	974080e7          	jalr	-1676(ra) # 80005814 <consputc>
    80005ea8:	fe0d12e3          	bnez	s10,80005e8c <__printf+0x494>
    80005eac:	f8dff06f          	j	80005e38 <__printf+0x440>
    80005eb0:	f7843783          	ld	a5,-136(s0)
    80005eb4:	0007bc83          	ld	s9,0(a5)
    80005eb8:	00878793          	addi	a5,a5,8
    80005ebc:	f6f43c23          	sd	a5,-136(s0)
    80005ec0:	000c9a63          	bnez	s9,80005ed4 <__printf+0x4dc>
    80005ec4:	1080006f          	j	80005fcc <__printf+0x5d4>
    80005ec8:	001c8c93          	addi	s9,s9,1
    80005ecc:	00000097          	auipc	ra,0x0
    80005ed0:	948080e7          	jalr	-1720(ra) # 80005814 <consputc>
    80005ed4:	000cc503          	lbu	a0,0(s9)
    80005ed8:	fe0518e3          	bnez	a0,80005ec8 <__printf+0x4d0>
    80005edc:	f5dff06f          	j	80005e38 <__printf+0x440>
    80005ee0:	02500513          	li	a0,37
    80005ee4:	00000097          	auipc	ra,0x0
    80005ee8:	930080e7          	jalr	-1744(ra) # 80005814 <consputc>
    80005eec:	000c8513          	mv	a0,s9
    80005ef0:	00000097          	auipc	ra,0x0
    80005ef4:	924080e7          	jalr	-1756(ra) # 80005814 <consputc>
    80005ef8:	f41ff06f          	j	80005e38 <__printf+0x440>
    80005efc:	02500513          	li	a0,37
    80005f00:	00000097          	auipc	ra,0x0
    80005f04:	914080e7          	jalr	-1772(ra) # 80005814 <consputc>
    80005f08:	f31ff06f          	j	80005e38 <__printf+0x440>
    80005f0c:	00030513          	mv	a0,t1
    80005f10:	00000097          	auipc	ra,0x0
    80005f14:	7bc080e7          	jalr	1980(ra) # 800066cc <acquire>
    80005f18:	b4dff06f          	j	80005a64 <__printf+0x6c>
    80005f1c:	40c0053b          	negw	a0,a2
    80005f20:	00a00713          	li	a4,10
    80005f24:	02e576bb          	remuw	a3,a0,a4
    80005f28:	00002d97          	auipc	s11,0x2
    80005f2c:	7b0d8d93          	addi	s11,s11,1968 # 800086d8 <digits>
    80005f30:	ff700593          	li	a1,-9
    80005f34:	02069693          	slli	a3,a3,0x20
    80005f38:	0206d693          	srli	a3,a3,0x20
    80005f3c:	00dd86b3          	add	a3,s11,a3
    80005f40:	0006c683          	lbu	a3,0(a3)
    80005f44:	02e557bb          	divuw	a5,a0,a4
    80005f48:	f8d40023          	sb	a3,-128(s0)
    80005f4c:	10b65e63          	bge	a2,a1,80006068 <__printf+0x670>
    80005f50:	06300593          	li	a1,99
    80005f54:	02e7f6bb          	remuw	a3,a5,a4
    80005f58:	02069693          	slli	a3,a3,0x20
    80005f5c:	0206d693          	srli	a3,a3,0x20
    80005f60:	00dd86b3          	add	a3,s11,a3
    80005f64:	0006c683          	lbu	a3,0(a3)
    80005f68:	02e7d73b          	divuw	a4,a5,a4
    80005f6c:	00200793          	li	a5,2
    80005f70:	f8d400a3          	sb	a3,-127(s0)
    80005f74:	bca5ece3          	bltu	a1,a0,80005b4c <__printf+0x154>
    80005f78:	ce5ff06f          	j	80005c5c <__printf+0x264>
    80005f7c:	40e007bb          	negw	a5,a4
    80005f80:	00002d97          	auipc	s11,0x2
    80005f84:	758d8d93          	addi	s11,s11,1880 # 800086d8 <digits>
    80005f88:	00f7f693          	andi	a3,a5,15
    80005f8c:	00dd86b3          	add	a3,s11,a3
    80005f90:	0006c583          	lbu	a1,0(a3)
    80005f94:	ff100613          	li	a2,-15
    80005f98:	0047d69b          	srliw	a3,a5,0x4
    80005f9c:	f8b40023          	sb	a1,-128(s0)
    80005fa0:	0047d59b          	srliw	a1,a5,0x4
    80005fa4:	0ac75e63          	bge	a4,a2,80006060 <__printf+0x668>
    80005fa8:	00f6f693          	andi	a3,a3,15
    80005fac:	00dd86b3          	add	a3,s11,a3
    80005fb0:	0006c603          	lbu	a2,0(a3)
    80005fb4:	00f00693          	li	a3,15
    80005fb8:	0087d79b          	srliw	a5,a5,0x8
    80005fbc:	f8c400a3          	sb	a2,-127(s0)
    80005fc0:	d8b6e4e3          	bltu	a3,a1,80005d48 <__printf+0x350>
    80005fc4:	00200793          	li	a5,2
    80005fc8:	e2dff06f          	j	80005df4 <__printf+0x3fc>
    80005fcc:	00002c97          	auipc	s9,0x2
    80005fd0:	6ecc8c93          	addi	s9,s9,1772 # 800086b8 <kvmincrease+0x1558>
    80005fd4:	02800513          	li	a0,40
    80005fd8:	ef1ff06f          	j	80005ec8 <__printf+0x4d0>
    80005fdc:	00700793          	li	a5,7
    80005fe0:	00600c93          	li	s9,6
    80005fe4:	e0dff06f          	j	80005df0 <__printf+0x3f8>
    80005fe8:	00700793          	li	a5,7
    80005fec:	00600c93          	li	s9,6
    80005ff0:	c69ff06f          	j	80005c58 <__printf+0x260>
    80005ff4:	00300793          	li	a5,3
    80005ff8:	00200c93          	li	s9,2
    80005ffc:	c5dff06f          	j	80005c58 <__printf+0x260>
    80006000:	00300793          	li	a5,3
    80006004:	00200c93          	li	s9,2
    80006008:	de9ff06f          	j	80005df0 <__printf+0x3f8>
    8000600c:	00400793          	li	a5,4
    80006010:	00300c93          	li	s9,3
    80006014:	dddff06f          	j	80005df0 <__printf+0x3f8>
    80006018:	00400793          	li	a5,4
    8000601c:	00300c93          	li	s9,3
    80006020:	c39ff06f          	j	80005c58 <__printf+0x260>
    80006024:	00500793          	li	a5,5
    80006028:	00400c93          	li	s9,4
    8000602c:	c2dff06f          	j	80005c58 <__printf+0x260>
    80006030:	00500793          	li	a5,5
    80006034:	00400c93          	li	s9,4
    80006038:	db9ff06f          	j	80005df0 <__printf+0x3f8>
    8000603c:	00600793          	li	a5,6
    80006040:	00500c93          	li	s9,5
    80006044:	dadff06f          	j	80005df0 <__printf+0x3f8>
    80006048:	00600793          	li	a5,6
    8000604c:	00500c93          	li	s9,5
    80006050:	c09ff06f          	j	80005c58 <__printf+0x260>
    80006054:	00800793          	li	a5,8
    80006058:	00700c93          	li	s9,7
    8000605c:	bfdff06f          	j	80005c58 <__printf+0x260>
    80006060:	00100793          	li	a5,1
    80006064:	d91ff06f          	j	80005df4 <__printf+0x3fc>
    80006068:	00100793          	li	a5,1
    8000606c:	bf1ff06f          	j	80005c5c <__printf+0x264>
    80006070:	00900793          	li	a5,9
    80006074:	00800c93          	li	s9,8
    80006078:	be1ff06f          	j	80005c58 <__printf+0x260>
    8000607c:	00002517          	auipc	a0,0x2
    80006080:	64450513          	addi	a0,a0,1604 # 800086c0 <kvmincrease+0x1560>
    80006084:	00000097          	auipc	ra,0x0
    80006088:	918080e7          	jalr	-1768(ra) # 8000599c <panic>

000000008000608c <printfinit>:
    8000608c:	fe010113          	addi	sp,sp,-32
    80006090:	00813823          	sd	s0,16(sp)
    80006094:	00913423          	sd	s1,8(sp)
    80006098:	00113c23          	sd	ra,24(sp)
    8000609c:	02010413          	addi	s0,sp,32
    800060a0:	00005497          	auipc	s1,0x5
    800060a4:	19048493          	addi	s1,s1,400 # 8000b230 <pr>
    800060a8:	00048513          	mv	a0,s1
    800060ac:	00002597          	auipc	a1,0x2
    800060b0:	62458593          	addi	a1,a1,1572 # 800086d0 <kvmincrease+0x1570>
    800060b4:	00000097          	auipc	ra,0x0
    800060b8:	5f4080e7          	jalr	1524(ra) # 800066a8 <initlock>
    800060bc:	01813083          	ld	ra,24(sp)
    800060c0:	01013403          	ld	s0,16(sp)
    800060c4:	0004ac23          	sw	zero,24(s1)
    800060c8:	00813483          	ld	s1,8(sp)
    800060cc:	02010113          	addi	sp,sp,32
    800060d0:	00008067          	ret

00000000800060d4 <uartinit>:
    800060d4:	ff010113          	addi	sp,sp,-16
    800060d8:	00813423          	sd	s0,8(sp)
    800060dc:	01010413          	addi	s0,sp,16
    800060e0:	100007b7          	lui	a5,0x10000
    800060e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800060e8:	f8000713          	li	a4,-128
    800060ec:	00e781a3          	sb	a4,3(a5)
    800060f0:	00300713          	li	a4,3
    800060f4:	00e78023          	sb	a4,0(a5)
    800060f8:	000780a3          	sb	zero,1(a5)
    800060fc:	00e781a3          	sb	a4,3(a5)
    80006100:	00700693          	li	a3,7
    80006104:	00d78123          	sb	a3,2(a5)
    80006108:	00e780a3          	sb	a4,1(a5)
    8000610c:	00813403          	ld	s0,8(sp)
    80006110:	01010113          	addi	sp,sp,16
    80006114:	00008067          	ret

0000000080006118 <uartputc>:
    80006118:	00004797          	auipc	a5,0x4
    8000611c:	e807a783          	lw	a5,-384(a5) # 80009f98 <panicked>
    80006120:	00078463          	beqz	a5,80006128 <uartputc+0x10>
    80006124:	0000006f          	j	80006124 <uartputc+0xc>
    80006128:	fd010113          	addi	sp,sp,-48
    8000612c:	02813023          	sd	s0,32(sp)
    80006130:	00913c23          	sd	s1,24(sp)
    80006134:	01213823          	sd	s2,16(sp)
    80006138:	01313423          	sd	s3,8(sp)
    8000613c:	02113423          	sd	ra,40(sp)
    80006140:	03010413          	addi	s0,sp,48
    80006144:	00004917          	auipc	s2,0x4
    80006148:	e5c90913          	addi	s2,s2,-420 # 80009fa0 <uart_tx_r>
    8000614c:	00093783          	ld	a5,0(s2)
    80006150:	00004497          	auipc	s1,0x4
    80006154:	e5848493          	addi	s1,s1,-424 # 80009fa8 <uart_tx_w>
    80006158:	0004b703          	ld	a4,0(s1)
    8000615c:	02078693          	addi	a3,a5,32
    80006160:	00050993          	mv	s3,a0
    80006164:	02e69c63          	bne	a3,a4,8000619c <uartputc+0x84>
    80006168:	00001097          	auipc	ra,0x1
    8000616c:	834080e7          	jalr	-1996(ra) # 8000699c <push_on>
    80006170:	00093783          	ld	a5,0(s2)
    80006174:	0004b703          	ld	a4,0(s1)
    80006178:	02078793          	addi	a5,a5,32
    8000617c:	00e79463          	bne	a5,a4,80006184 <uartputc+0x6c>
    80006180:	0000006f          	j	80006180 <uartputc+0x68>
    80006184:	00001097          	auipc	ra,0x1
    80006188:	88c080e7          	jalr	-1908(ra) # 80006a10 <pop_on>
    8000618c:	00093783          	ld	a5,0(s2)
    80006190:	0004b703          	ld	a4,0(s1)
    80006194:	02078693          	addi	a3,a5,32
    80006198:	fce688e3          	beq	a3,a4,80006168 <uartputc+0x50>
    8000619c:	01f77693          	andi	a3,a4,31
    800061a0:	00005597          	auipc	a1,0x5
    800061a4:	0b058593          	addi	a1,a1,176 # 8000b250 <uart_tx_buf>
    800061a8:	00d586b3          	add	a3,a1,a3
    800061ac:	00170713          	addi	a4,a4,1
    800061b0:	01368023          	sb	s3,0(a3)
    800061b4:	00e4b023          	sd	a4,0(s1)
    800061b8:	10000637          	lui	a2,0x10000
    800061bc:	02f71063          	bne	a4,a5,800061dc <uartputc+0xc4>
    800061c0:	0340006f          	j	800061f4 <uartputc+0xdc>
    800061c4:	00074703          	lbu	a4,0(a4)
    800061c8:	00f93023          	sd	a5,0(s2)
    800061cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800061d0:	00093783          	ld	a5,0(s2)
    800061d4:	0004b703          	ld	a4,0(s1)
    800061d8:	00f70e63          	beq	a4,a5,800061f4 <uartputc+0xdc>
    800061dc:	00564683          	lbu	a3,5(a2)
    800061e0:	01f7f713          	andi	a4,a5,31
    800061e4:	00e58733          	add	a4,a1,a4
    800061e8:	0206f693          	andi	a3,a3,32
    800061ec:	00178793          	addi	a5,a5,1
    800061f0:	fc069ae3          	bnez	a3,800061c4 <uartputc+0xac>
    800061f4:	02813083          	ld	ra,40(sp)
    800061f8:	02013403          	ld	s0,32(sp)
    800061fc:	01813483          	ld	s1,24(sp)
    80006200:	01013903          	ld	s2,16(sp)
    80006204:	00813983          	ld	s3,8(sp)
    80006208:	03010113          	addi	sp,sp,48
    8000620c:	00008067          	ret

0000000080006210 <uartputc_sync>:
    80006210:	ff010113          	addi	sp,sp,-16
    80006214:	00813423          	sd	s0,8(sp)
    80006218:	01010413          	addi	s0,sp,16
    8000621c:	00004717          	auipc	a4,0x4
    80006220:	d7c72703          	lw	a4,-644(a4) # 80009f98 <panicked>
    80006224:	02071663          	bnez	a4,80006250 <uartputc_sync+0x40>
    80006228:	00050793          	mv	a5,a0
    8000622c:	100006b7          	lui	a3,0x10000
    80006230:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006234:	02077713          	andi	a4,a4,32
    80006238:	fe070ce3          	beqz	a4,80006230 <uartputc_sync+0x20>
    8000623c:	0ff7f793          	andi	a5,a5,255
    80006240:	00f68023          	sb	a5,0(a3)
    80006244:	00813403          	ld	s0,8(sp)
    80006248:	01010113          	addi	sp,sp,16
    8000624c:	00008067          	ret
    80006250:	0000006f          	j	80006250 <uartputc_sync+0x40>

0000000080006254 <uartstart>:
    80006254:	ff010113          	addi	sp,sp,-16
    80006258:	00813423          	sd	s0,8(sp)
    8000625c:	01010413          	addi	s0,sp,16
    80006260:	00004617          	auipc	a2,0x4
    80006264:	d4060613          	addi	a2,a2,-704 # 80009fa0 <uart_tx_r>
    80006268:	00004517          	auipc	a0,0x4
    8000626c:	d4050513          	addi	a0,a0,-704 # 80009fa8 <uart_tx_w>
    80006270:	00063783          	ld	a5,0(a2)
    80006274:	00053703          	ld	a4,0(a0)
    80006278:	04f70263          	beq	a4,a5,800062bc <uartstart+0x68>
    8000627c:	100005b7          	lui	a1,0x10000
    80006280:	00005817          	auipc	a6,0x5
    80006284:	fd080813          	addi	a6,a6,-48 # 8000b250 <uart_tx_buf>
    80006288:	01c0006f          	j	800062a4 <uartstart+0x50>
    8000628c:	0006c703          	lbu	a4,0(a3)
    80006290:	00f63023          	sd	a5,0(a2)
    80006294:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006298:	00063783          	ld	a5,0(a2)
    8000629c:	00053703          	ld	a4,0(a0)
    800062a0:	00f70e63          	beq	a4,a5,800062bc <uartstart+0x68>
    800062a4:	01f7f713          	andi	a4,a5,31
    800062a8:	00e806b3          	add	a3,a6,a4
    800062ac:	0055c703          	lbu	a4,5(a1)
    800062b0:	00178793          	addi	a5,a5,1
    800062b4:	02077713          	andi	a4,a4,32
    800062b8:	fc071ae3          	bnez	a4,8000628c <uartstart+0x38>
    800062bc:	00813403          	ld	s0,8(sp)
    800062c0:	01010113          	addi	sp,sp,16
    800062c4:	00008067          	ret

00000000800062c8 <uartgetc>:
    800062c8:	ff010113          	addi	sp,sp,-16
    800062cc:	00813423          	sd	s0,8(sp)
    800062d0:	01010413          	addi	s0,sp,16
    800062d4:	10000737          	lui	a4,0x10000
    800062d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800062dc:	0017f793          	andi	a5,a5,1
    800062e0:	00078c63          	beqz	a5,800062f8 <uartgetc+0x30>
    800062e4:	00074503          	lbu	a0,0(a4)
    800062e8:	0ff57513          	andi	a0,a0,255
    800062ec:	00813403          	ld	s0,8(sp)
    800062f0:	01010113          	addi	sp,sp,16
    800062f4:	00008067          	ret
    800062f8:	fff00513          	li	a0,-1
    800062fc:	ff1ff06f          	j	800062ec <uartgetc+0x24>

0000000080006300 <uartintr>:
    80006300:	100007b7          	lui	a5,0x10000
    80006304:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006308:	0017f793          	andi	a5,a5,1
    8000630c:	0a078463          	beqz	a5,800063b4 <uartintr+0xb4>
    80006310:	fe010113          	addi	sp,sp,-32
    80006314:	00813823          	sd	s0,16(sp)
    80006318:	00913423          	sd	s1,8(sp)
    8000631c:	00113c23          	sd	ra,24(sp)
    80006320:	02010413          	addi	s0,sp,32
    80006324:	100004b7          	lui	s1,0x10000
    80006328:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000632c:	0ff57513          	andi	a0,a0,255
    80006330:	fffff097          	auipc	ra,0xfffff
    80006334:	534080e7          	jalr	1332(ra) # 80005864 <consoleintr>
    80006338:	0054c783          	lbu	a5,5(s1)
    8000633c:	0017f793          	andi	a5,a5,1
    80006340:	fe0794e3          	bnez	a5,80006328 <uartintr+0x28>
    80006344:	00004617          	auipc	a2,0x4
    80006348:	c5c60613          	addi	a2,a2,-932 # 80009fa0 <uart_tx_r>
    8000634c:	00004517          	auipc	a0,0x4
    80006350:	c5c50513          	addi	a0,a0,-932 # 80009fa8 <uart_tx_w>
    80006354:	00063783          	ld	a5,0(a2)
    80006358:	00053703          	ld	a4,0(a0)
    8000635c:	04f70263          	beq	a4,a5,800063a0 <uartintr+0xa0>
    80006360:	100005b7          	lui	a1,0x10000
    80006364:	00005817          	auipc	a6,0x5
    80006368:	eec80813          	addi	a6,a6,-276 # 8000b250 <uart_tx_buf>
    8000636c:	01c0006f          	j	80006388 <uartintr+0x88>
    80006370:	0006c703          	lbu	a4,0(a3)
    80006374:	00f63023          	sd	a5,0(a2)
    80006378:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000637c:	00063783          	ld	a5,0(a2)
    80006380:	00053703          	ld	a4,0(a0)
    80006384:	00f70e63          	beq	a4,a5,800063a0 <uartintr+0xa0>
    80006388:	01f7f713          	andi	a4,a5,31
    8000638c:	00e806b3          	add	a3,a6,a4
    80006390:	0055c703          	lbu	a4,5(a1)
    80006394:	00178793          	addi	a5,a5,1
    80006398:	02077713          	andi	a4,a4,32
    8000639c:	fc071ae3          	bnez	a4,80006370 <uartintr+0x70>
    800063a0:	01813083          	ld	ra,24(sp)
    800063a4:	01013403          	ld	s0,16(sp)
    800063a8:	00813483          	ld	s1,8(sp)
    800063ac:	02010113          	addi	sp,sp,32
    800063b0:	00008067          	ret
    800063b4:	00004617          	auipc	a2,0x4
    800063b8:	bec60613          	addi	a2,a2,-1044 # 80009fa0 <uart_tx_r>
    800063bc:	00004517          	auipc	a0,0x4
    800063c0:	bec50513          	addi	a0,a0,-1044 # 80009fa8 <uart_tx_w>
    800063c4:	00063783          	ld	a5,0(a2)
    800063c8:	00053703          	ld	a4,0(a0)
    800063cc:	04f70263          	beq	a4,a5,80006410 <uartintr+0x110>
    800063d0:	100005b7          	lui	a1,0x10000
    800063d4:	00005817          	auipc	a6,0x5
    800063d8:	e7c80813          	addi	a6,a6,-388 # 8000b250 <uart_tx_buf>
    800063dc:	01c0006f          	j	800063f8 <uartintr+0xf8>
    800063e0:	0006c703          	lbu	a4,0(a3)
    800063e4:	00f63023          	sd	a5,0(a2)
    800063e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800063ec:	00063783          	ld	a5,0(a2)
    800063f0:	00053703          	ld	a4,0(a0)
    800063f4:	02f70063          	beq	a4,a5,80006414 <uartintr+0x114>
    800063f8:	01f7f713          	andi	a4,a5,31
    800063fc:	00e806b3          	add	a3,a6,a4
    80006400:	0055c703          	lbu	a4,5(a1)
    80006404:	00178793          	addi	a5,a5,1
    80006408:	02077713          	andi	a4,a4,32
    8000640c:	fc071ae3          	bnez	a4,800063e0 <uartintr+0xe0>
    80006410:	00008067          	ret
    80006414:	00008067          	ret

0000000080006418 <kinit>:
    80006418:	fc010113          	addi	sp,sp,-64
    8000641c:	02913423          	sd	s1,40(sp)
    80006420:	fffff7b7          	lui	a5,0xfffff
    80006424:	00006497          	auipc	s1,0x6
    80006428:	e5b48493          	addi	s1,s1,-421 # 8000c27f <end+0xfff>
    8000642c:	02813823          	sd	s0,48(sp)
    80006430:	01313c23          	sd	s3,24(sp)
    80006434:	00f4f4b3          	and	s1,s1,a5
    80006438:	02113c23          	sd	ra,56(sp)
    8000643c:	03213023          	sd	s2,32(sp)
    80006440:	01413823          	sd	s4,16(sp)
    80006444:	01513423          	sd	s5,8(sp)
    80006448:	04010413          	addi	s0,sp,64
    8000644c:	000017b7          	lui	a5,0x1
    80006450:	01100993          	li	s3,17
    80006454:	00f487b3          	add	a5,s1,a5
    80006458:	01b99993          	slli	s3,s3,0x1b
    8000645c:	06f9e063          	bltu	s3,a5,800064bc <kinit+0xa4>
    80006460:	00005a97          	auipc	s5,0x5
    80006464:	e20a8a93          	addi	s5,s5,-480 # 8000b280 <end>
    80006468:	0754ec63          	bltu	s1,s5,800064e0 <kinit+0xc8>
    8000646c:	0734fa63          	bgeu	s1,s3,800064e0 <kinit+0xc8>
    80006470:	00088a37          	lui	s4,0x88
    80006474:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006478:	00004917          	auipc	s2,0x4
    8000647c:	b3890913          	addi	s2,s2,-1224 # 80009fb0 <kmem>
    80006480:	00ca1a13          	slli	s4,s4,0xc
    80006484:	0140006f          	j	80006498 <kinit+0x80>
    80006488:	000017b7          	lui	a5,0x1
    8000648c:	00f484b3          	add	s1,s1,a5
    80006490:	0554e863          	bltu	s1,s5,800064e0 <kinit+0xc8>
    80006494:	0534f663          	bgeu	s1,s3,800064e0 <kinit+0xc8>
    80006498:	00001637          	lui	a2,0x1
    8000649c:	00100593          	li	a1,1
    800064a0:	00048513          	mv	a0,s1
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	5e4080e7          	jalr	1508(ra) # 80006a88 <__memset>
    800064ac:	00093783          	ld	a5,0(s2)
    800064b0:	00f4b023          	sd	a5,0(s1)
    800064b4:	00993023          	sd	s1,0(s2)
    800064b8:	fd4498e3          	bne	s1,s4,80006488 <kinit+0x70>
    800064bc:	03813083          	ld	ra,56(sp)
    800064c0:	03013403          	ld	s0,48(sp)
    800064c4:	02813483          	ld	s1,40(sp)
    800064c8:	02013903          	ld	s2,32(sp)
    800064cc:	01813983          	ld	s3,24(sp)
    800064d0:	01013a03          	ld	s4,16(sp)
    800064d4:	00813a83          	ld	s5,8(sp)
    800064d8:	04010113          	addi	sp,sp,64
    800064dc:	00008067          	ret
    800064e0:	00002517          	auipc	a0,0x2
    800064e4:	21050513          	addi	a0,a0,528 # 800086f0 <digits+0x18>
    800064e8:	fffff097          	auipc	ra,0xfffff
    800064ec:	4b4080e7          	jalr	1204(ra) # 8000599c <panic>

00000000800064f0 <freerange>:
    800064f0:	fc010113          	addi	sp,sp,-64
    800064f4:	000017b7          	lui	a5,0x1
    800064f8:	02913423          	sd	s1,40(sp)
    800064fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006500:	009504b3          	add	s1,a0,s1
    80006504:	fffff537          	lui	a0,0xfffff
    80006508:	02813823          	sd	s0,48(sp)
    8000650c:	02113c23          	sd	ra,56(sp)
    80006510:	03213023          	sd	s2,32(sp)
    80006514:	01313c23          	sd	s3,24(sp)
    80006518:	01413823          	sd	s4,16(sp)
    8000651c:	01513423          	sd	s5,8(sp)
    80006520:	01613023          	sd	s6,0(sp)
    80006524:	04010413          	addi	s0,sp,64
    80006528:	00a4f4b3          	and	s1,s1,a0
    8000652c:	00f487b3          	add	a5,s1,a5
    80006530:	06f5e463          	bltu	a1,a5,80006598 <freerange+0xa8>
    80006534:	00005a97          	auipc	s5,0x5
    80006538:	d4ca8a93          	addi	s5,s5,-692 # 8000b280 <end>
    8000653c:	0954e263          	bltu	s1,s5,800065c0 <freerange+0xd0>
    80006540:	01100993          	li	s3,17
    80006544:	01b99993          	slli	s3,s3,0x1b
    80006548:	0734fc63          	bgeu	s1,s3,800065c0 <freerange+0xd0>
    8000654c:	00058a13          	mv	s4,a1
    80006550:	00004917          	auipc	s2,0x4
    80006554:	a6090913          	addi	s2,s2,-1440 # 80009fb0 <kmem>
    80006558:	00002b37          	lui	s6,0x2
    8000655c:	0140006f          	j	80006570 <freerange+0x80>
    80006560:	000017b7          	lui	a5,0x1
    80006564:	00f484b3          	add	s1,s1,a5
    80006568:	0554ec63          	bltu	s1,s5,800065c0 <freerange+0xd0>
    8000656c:	0534fa63          	bgeu	s1,s3,800065c0 <freerange+0xd0>
    80006570:	00001637          	lui	a2,0x1
    80006574:	00100593          	li	a1,1
    80006578:	00048513          	mv	a0,s1
    8000657c:	00000097          	auipc	ra,0x0
    80006580:	50c080e7          	jalr	1292(ra) # 80006a88 <__memset>
    80006584:	00093703          	ld	a4,0(s2)
    80006588:	016487b3          	add	a5,s1,s6
    8000658c:	00e4b023          	sd	a4,0(s1)
    80006590:	00993023          	sd	s1,0(s2)
    80006594:	fcfa76e3          	bgeu	s4,a5,80006560 <freerange+0x70>
    80006598:	03813083          	ld	ra,56(sp)
    8000659c:	03013403          	ld	s0,48(sp)
    800065a0:	02813483          	ld	s1,40(sp)
    800065a4:	02013903          	ld	s2,32(sp)
    800065a8:	01813983          	ld	s3,24(sp)
    800065ac:	01013a03          	ld	s4,16(sp)
    800065b0:	00813a83          	ld	s5,8(sp)
    800065b4:	00013b03          	ld	s6,0(sp)
    800065b8:	04010113          	addi	sp,sp,64
    800065bc:	00008067          	ret
    800065c0:	00002517          	auipc	a0,0x2
    800065c4:	13050513          	addi	a0,a0,304 # 800086f0 <digits+0x18>
    800065c8:	fffff097          	auipc	ra,0xfffff
    800065cc:	3d4080e7          	jalr	980(ra) # 8000599c <panic>

00000000800065d0 <kfree>:
    800065d0:	fe010113          	addi	sp,sp,-32
    800065d4:	00813823          	sd	s0,16(sp)
    800065d8:	00113c23          	sd	ra,24(sp)
    800065dc:	00913423          	sd	s1,8(sp)
    800065e0:	02010413          	addi	s0,sp,32
    800065e4:	03451793          	slli	a5,a0,0x34
    800065e8:	04079c63          	bnez	a5,80006640 <kfree+0x70>
    800065ec:	00005797          	auipc	a5,0x5
    800065f0:	c9478793          	addi	a5,a5,-876 # 8000b280 <end>
    800065f4:	00050493          	mv	s1,a0
    800065f8:	04f56463          	bltu	a0,a5,80006640 <kfree+0x70>
    800065fc:	01100793          	li	a5,17
    80006600:	01b79793          	slli	a5,a5,0x1b
    80006604:	02f57e63          	bgeu	a0,a5,80006640 <kfree+0x70>
    80006608:	00001637          	lui	a2,0x1
    8000660c:	00100593          	li	a1,1
    80006610:	00000097          	auipc	ra,0x0
    80006614:	478080e7          	jalr	1144(ra) # 80006a88 <__memset>
    80006618:	00004797          	auipc	a5,0x4
    8000661c:	99878793          	addi	a5,a5,-1640 # 80009fb0 <kmem>
    80006620:	0007b703          	ld	a4,0(a5)
    80006624:	01813083          	ld	ra,24(sp)
    80006628:	01013403          	ld	s0,16(sp)
    8000662c:	00e4b023          	sd	a4,0(s1)
    80006630:	0097b023          	sd	s1,0(a5)
    80006634:	00813483          	ld	s1,8(sp)
    80006638:	02010113          	addi	sp,sp,32
    8000663c:	00008067          	ret
    80006640:	00002517          	auipc	a0,0x2
    80006644:	0b050513          	addi	a0,a0,176 # 800086f0 <digits+0x18>
    80006648:	fffff097          	auipc	ra,0xfffff
    8000664c:	354080e7          	jalr	852(ra) # 8000599c <panic>

0000000080006650 <kalloc>:
    80006650:	fe010113          	addi	sp,sp,-32
    80006654:	00813823          	sd	s0,16(sp)
    80006658:	00913423          	sd	s1,8(sp)
    8000665c:	00113c23          	sd	ra,24(sp)
    80006660:	02010413          	addi	s0,sp,32
    80006664:	00004797          	auipc	a5,0x4
    80006668:	94c78793          	addi	a5,a5,-1716 # 80009fb0 <kmem>
    8000666c:	0007b483          	ld	s1,0(a5)
    80006670:	02048063          	beqz	s1,80006690 <kalloc+0x40>
    80006674:	0004b703          	ld	a4,0(s1)
    80006678:	00001637          	lui	a2,0x1
    8000667c:	00500593          	li	a1,5
    80006680:	00048513          	mv	a0,s1
    80006684:	00e7b023          	sd	a4,0(a5)
    80006688:	00000097          	auipc	ra,0x0
    8000668c:	400080e7          	jalr	1024(ra) # 80006a88 <__memset>
    80006690:	01813083          	ld	ra,24(sp)
    80006694:	01013403          	ld	s0,16(sp)
    80006698:	00048513          	mv	a0,s1
    8000669c:	00813483          	ld	s1,8(sp)
    800066a0:	02010113          	addi	sp,sp,32
    800066a4:	00008067          	ret

00000000800066a8 <initlock>:
    800066a8:	ff010113          	addi	sp,sp,-16
    800066ac:	00813423          	sd	s0,8(sp)
    800066b0:	01010413          	addi	s0,sp,16
    800066b4:	00813403          	ld	s0,8(sp)
    800066b8:	00b53423          	sd	a1,8(a0)
    800066bc:	00052023          	sw	zero,0(a0)
    800066c0:	00053823          	sd	zero,16(a0)
    800066c4:	01010113          	addi	sp,sp,16
    800066c8:	00008067          	ret

00000000800066cc <acquire>:
    800066cc:	fe010113          	addi	sp,sp,-32
    800066d0:	00813823          	sd	s0,16(sp)
    800066d4:	00913423          	sd	s1,8(sp)
    800066d8:	00113c23          	sd	ra,24(sp)
    800066dc:	01213023          	sd	s2,0(sp)
    800066e0:	02010413          	addi	s0,sp,32
    800066e4:	00050493          	mv	s1,a0
    800066e8:	10002973          	csrr	s2,sstatus
    800066ec:	100027f3          	csrr	a5,sstatus
    800066f0:	ffd7f793          	andi	a5,a5,-3
    800066f4:	10079073          	csrw	sstatus,a5
    800066f8:	fffff097          	auipc	ra,0xfffff
    800066fc:	8ec080e7          	jalr	-1812(ra) # 80004fe4 <mycpu>
    80006700:	07852783          	lw	a5,120(a0)
    80006704:	06078e63          	beqz	a5,80006780 <acquire+0xb4>
    80006708:	fffff097          	auipc	ra,0xfffff
    8000670c:	8dc080e7          	jalr	-1828(ra) # 80004fe4 <mycpu>
    80006710:	07852783          	lw	a5,120(a0)
    80006714:	0004a703          	lw	a4,0(s1)
    80006718:	0017879b          	addiw	a5,a5,1
    8000671c:	06f52c23          	sw	a5,120(a0)
    80006720:	04071063          	bnez	a4,80006760 <acquire+0x94>
    80006724:	00100713          	li	a4,1
    80006728:	00070793          	mv	a5,a4
    8000672c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006730:	0007879b          	sext.w	a5,a5
    80006734:	fe079ae3          	bnez	a5,80006728 <acquire+0x5c>
    80006738:	0ff0000f          	fence
    8000673c:	fffff097          	auipc	ra,0xfffff
    80006740:	8a8080e7          	jalr	-1880(ra) # 80004fe4 <mycpu>
    80006744:	01813083          	ld	ra,24(sp)
    80006748:	01013403          	ld	s0,16(sp)
    8000674c:	00a4b823          	sd	a0,16(s1)
    80006750:	00013903          	ld	s2,0(sp)
    80006754:	00813483          	ld	s1,8(sp)
    80006758:	02010113          	addi	sp,sp,32
    8000675c:	00008067          	ret
    80006760:	0104b903          	ld	s2,16(s1)
    80006764:	fffff097          	auipc	ra,0xfffff
    80006768:	880080e7          	jalr	-1920(ra) # 80004fe4 <mycpu>
    8000676c:	faa91ce3          	bne	s2,a0,80006724 <acquire+0x58>
    80006770:	00002517          	auipc	a0,0x2
    80006774:	f8850513          	addi	a0,a0,-120 # 800086f8 <digits+0x20>
    80006778:	fffff097          	auipc	ra,0xfffff
    8000677c:	224080e7          	jalr	548(ra) # 8000599c <panic>
    80006780:	00195913          	srli	s2,s2,0x1
    80006784:	fffff097          	auipc	ra,0xfffff
    80006788:	860080e7          	jalr	-1952(ra) # 80004fe4 <mycpu>
    8000678c:	00197913          	andi	s2,s2,1
    80006790:	07252e23          	sw	s2,124(a0)
    80006794:	f75ff06f          	j	80006708 <acquire+0x3c>

0000000080006798 <release>:
    80006798:	fe010113          	addi	sp,sp,-32
    8000679c:	00813823          	sd	s0,16(sp)
    800067a0:	00113c23          	sd	ra,24(sp)
    800067a4:	00913423          	sd	s1,8(sp)
    800067a8:	01213023          	sd	s2,0(sp)
    800067ac:	02010413          	addi	s0,sp,32
    800067b0:	00052783          	lw	a5,0(a0)
    800067b4:	00079a63          	bnez	a5,800067c8 <release+0x30>
    800067b8:	00002517          	auipc	a0,0x2
    800067bc:	f4850513          	addi	a0,a0,-184 # 80008700 <digits+0x28>
    800067c0:	fffff097          	auipc	ra,0xfffff
    800067c4:	1dc080e7          	jalr	476(ra) # 8000599c <panic>
    800067c8:	01053903          	ld	s2,16(a0)
    800067cc:	00050493          	mv	s1,a0
    800067d0:	fffff097          	auipc	ra,0xfffff
    800067d4:	814080e7          	jalr	-2028(ra) # 80004fe4 <mycpu>
    800067d8:	fea910e3          	bne	s2,a0,800067b8 <release+0x20>
    800067dc:	0004b823          	sd	zero,16(s1)
    800067e0:	0ff0000f          	fence
    800067e4:	0f50000f          	fence	iorw,ow
    800067e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800067ec:	ffffe097          	auipc	ra,0xffffe
    800067f0:	7f8080e7          	jalr	2040(ra) # 80004fe4 <mycpu>
    800067f4:	100027f3          	csrr	a5,sstatus
    800067f8:	0027f793          	andi	a5,a5,2
    800067fc:	04079a63          	bnez	a5,80006850 <release+0xb8>
    80006800:	07852783          	lw	a5,120(a0)
    80006804:	02f05e63          	blez	a5,80006840 <release+0xa8>
    80006808:	fff7871b          	addiw	a4,a5,-1
    8000680c:	06e52c23          	sw	a4,120(a0)
    80006810:	00071c63          	bnez	a4,80006828 <release+0x90>
    80006814:	07c52783          	lw	a5,124(a0)
    80006818:	00078863          	beqz	a5,80006828 <release+0x90>
    8000681c:	100027f3          	csrr	a5,sstatus
    80006820:	0027e793          	ori	a5,a5,2
    80006824:	10079073          	csrw	sstatus,a5
    80006828:	01813083          	ld	ra,24(sp)
    8000682c:	01013403          	ld	s0,16(sp)
    80006830:	00813483          	ld	s1,8(sp)
    80006834:	00013903          	ld	s2,0(sp)
    80006838:	02010113          	addi	sp,sp,32
    8000683c:	00008067          	ret
    80006840:	00002517          	auipc	a0,0x2
    80006844:	ee050513          	addi	a0,a0,-288 # 80008720 <digits+0x48>
    80006848:	fffff097          	auipc	ra,0xfffff
    8000684c:	154080e7          	jalr	340(ra) # 8000599c <panic>
    80006850:	00002517          	auipc	a0,0x2
    80006854:	eb850513          	addi	a0,a0,-328 # 80008708 <digits+0x30>
    80006858:	fffff097          	auipc	ra,0xfffff
    8000685c:	144080e7          	jalr	324(ra) # 8000599c <panic>

0000000080006860 <holding>:
    80006860:	00052783          	lw	a5,0(a0)
    80006864:	00079663          	bnez	a5,80006870 <holding+0x10>
    80006868:	00000513          	li	a0,0
    8000686c:	00008067          	ret
    80006870:	fe010113          	addi	sp,sp,-32
    80006874:	00813823          	sd	s0,16(sp)
    80006878:	00913423          	sd	s1,8(sp)
    8000687c:	00113c23          	sd	ra,24(sp)
    80006880:	02010413          	addi	s0,sp,32
    80006884:	01053483          	ld	s1,16(a0)
    80006888:	ffffe097          	auipc	ra,0xffffe
    8000688c:	75c080e7          	jalr	1884(ra) # 80004fe4 <mycpu>
    80006890:	01813083          	ld	ra,24(sp)
    80006894:	01013403          	ld	s0,16(sp)
    80006898:	40a48533          	sub	a0,s1,a0
    8000689c:	00153513          	seqz	a0,a0
    800068a0:	00813483          	ld	s1,8(sp)
    800068a4:	02010113          	addi	sp,sp,32
    800068a8:	00008067          	ret

00000000800068ac <push_off>:
    800068ac:	fe010113          	addi	sp,sp,-32
    800068b0:	00813823          	sd	s0,16(sp)
    800068b4:	00113c23          	sd	ra,24(sp)
    800068b8:	00913423          	sd	s1,8(sp)
    800068bc:	02010413          	addi	s0,sp,32
    800068c0:	100024f3          	csrr	s1,sstatus
    800068c4:	100027f3          	csrr	a5,sstatus
    800068c8:	ffd7f793          	andi	a5,a5,-3
    800068cc:	10079073          	csrw	sstatus,a5
    800068d0:	ffffe097          	auipc	ra,0xffffe
    800068d4:	714080e7          	jalr	1812(ra) # 80004fe4 <mycpu>
    800068d8:	07852783          	lw	a5,120(a0)
    800068dc:	02078663          	beqz	a5,80006908 <push_off+0x5c>
    800068e0:	ffffe097          	auipc	ra,0xffffe
    800068e4:	704080e7          	jalr	1796(ra) # 80004fe4 <mycpu>
    800068e8:	07852783          	lw	a5,120(a0)
    800068ec:	01813083          	ld	ra,24(sp)
    800068f0:	01013403          	ld	s0,16(sp)
    800068f4:	0017879b          	addiw	a5,a5,1
    800068f8:	06f52c23          	sw	a5,120(a0)
    800068fc:	00813483          	ld	s1,8(sp)
    80006900:	02010113          	addi	sp,sp,32
    80006904:	00008067          	ret
    80006908:	0014d493          	srli	s1,s1,0x1
    8000690c:	ffffe097          	auipc	ra,0xffffe
    80006910:	6d8080e7          	jalr	1752(ra) # 80004fe4 <mycpu>
    80006914:	0014f493          	andi	s1,s1,1
    80006918:	06952e23          	sw	s1,124(a0)
    8000691c:	fc5ff06f          	j	800068e0 <push_off+0x34>

0000000080006920 <pop_off>:
    80006920:	ff010113          	addi	sp,sp,-16
    80006924:	00813023          	sd	s0,0(sp)
    80006928:	00113423          	sd	ra,8(sp)
    8000692c:	01010413          	addi	s0,sp,16
    80006930:	ffffe097          	auipc	ra,0xffffe
    80006934:	6b4080e7          	jalr	1716(ra) # 80004fe4 <mycpu>
    80006938:	100027f3          	csrr	a5,sstatus
    8000693c:	0027f793          	andi	a5,a5,2
    80006940:	04079663          	bnez	a5,8000698c <pop_off+0x6c>
    80006944:	07852783          	lw	a5,120(a0)
    80006948:	02f05a63          	blez	a5,8000697c <pop_off+0x5c>
    8000694c:	fff7871b          	addiw	a4,a5,-1
    80006950:	06e52c23          	sw	a4,120(a0)
    80006954:	00071c63          	bnez	a4,8000696c <pop_off+0x4c>
    80006958:	07c52783          	lw	a5,124(a0)
    8000695c:	00078863          	beqz	a5,8000696c <pop_off+0x4c>
    80006960:	100027f3          	csrr	a5,sstatus
    80006964:	0027e793          	ori	a5,a5,2
    80006968:	10079073          	csrw	sstatus,a5
    8000696c:	00813083          	ld	ra,8(sp)
    80006970:	00013403          	ld	s0,0(sp)
    80006974:	01010113          	addi	sp,sp,16
    80006978:	00008067          	ret
    8000697c:	00002517          	auipc	a0,0x2
    80006980:	da450513          	addi	a0,a0,-604 # 80008720 <digits+0x48>
    80006984:	fffff097          	auipc	ra,0xfffff
    80006988:	018080e7          	jalr	24(ra) # 8000599c <panic>
    8000698c:	00002517          	auipc	a0,0x2
    80006990:	d7c50513          	addi	a0,a0,-644 # 80008708 <digits+0x30>
    80006994:	fffff097          	auipc	ra,0xfffff
    80006998:	008080e7          	jalr	8(ra) # 8000599c <panic>

000000008000699c <push_on>:
    8000699c:	fe010113          	addi	sp,sp,-32
    800069a0:	00813823          	sd	s0,16(sp)
    800069a4:	00113c23          	sd	ra,24(sp)
    800069a8:	00913423          	sd	s1,8(sp)
    800069ac:	02010413          	addi	s0,sp,32
    800069b0:	100024f3          	csrr	s1,sstatus
    800069b4:	100027f3          	csrr	a5,sstatus
    800069b8:	0027e793          	ori	a5,a5,2
    800069bc:	10079073          	csrw	sstatus,a5
    800069c0:	ffffe097          	auipc	ra,0xffffe
    800069c4:	624080e7          	jalr	1572(ra) # 80004fe4 <mycpu>
    800069c8:	07852783          	lw	a5,120(a0)
    800069cc:	02078663          	beqz	a5,800069f8 <push_on+0x5c>
    800069d0:	ffffe097          	auipc	ra,0xffffe
    800069d4:	614080e7          	jalr	1556(ra) # 80004fe4 <mycpu>
    800069d8:	07852783          	lw	a5,120(a0)
    800069dc:	01813083          	ld	ra,24(sp)
    800069e0:	01013403          	ld	s0,16(sp)
    800069e4:	0017879b          	addiw	a5,a5,1
    800069e8:	06f52c23          	sw	a5,120(a0)
    800069ec:	00813483          	ld	s1,8(sp)
    800069f0:	02010113          	addi	sp,sp,32
    800069f4:	00008067          	ret
    800069f8:	0014d493          	srli	s1,s1,0x1
    800069fc:	ffffe097          	auipc	ra,0xffffe
    80006a00:	5e8080e7          	jalr	1512(ra) # 80004fe4 <mycpu>
    80006a04:	0014f493          	andi	s1,s1,1
    80006a08:	06952e23          	sw	s1,124(a0)
    80006a0c:	fc5ff06f          	j	800069d0 <push_on+0x34>

0000000080006a10 <pop_on>:
    80006a10:	ff010113          	addi	sp,sp,-16
    80006a14:	00813023          	sd	s0,0(sp)
    80006a18:	00113423          	sd	ra,8(sp)
    80006a1c:	01010413          	addi	s0,sp,16
    80006a20:	ffffe097          	auipc	ra,0xffffe
    80006a24:	5c4080e7          	jalr	1476(ra) # 80004fe4 <mycpu>
    80006a28:	100027f3          	csrr	a5,sstatus
    80006a2c:	0027f793          	andi	a5,a5,2
    80006a30:	04078463          	beqz	a5,80006a78 <pop_on+0x68>
    80006a34:	07852783          	lw	a5,120(a0)
    80006a38:	02f05863          	blez	a5,80006a68 <pop_on+0x58>
    80006a3c:	fff7879b          	addiw	a5,a5,-1
    80006a40:	06f52c23          	sw	a5,120(a0)
    80006a44:	07853783          	ld	a5,120(a0)
    80006a48:	00079863          	bnez	a5,80006a58 <pop_on+0x48>
    80006a4c:	100027f3          	csrr	a5,sstatus
    80006a50:	ffd7f793          	andi	a5,a5,-3
    80006a54:	10079073          	csrw	sstatus,a5
    80006a58:	00813083          	ld	ra,8(sp)
    80006a5c:	00013403          	ld	s0,0(sp)
    80006a60:	01010113          	addi	sp,sp,16
    80006a64:	00008067          	ret
    80006a68:	00002517          	auipc	a0,0x2
    80006a6c:	ce050513          	addi	a0,a0,-800 # 80008748 <digits+0x70>
    80006a70:	fffff097          	auipc	ra,0xfffff
    80006a74:	f2c080e7          	jalr	-212(ra) # 8000599c <panic>
    80006a78:	00002517          	auipc	a0,0x2
    80006a7c:	cb050513          	addi	a0,a0,-848 # 80008728 <digits+0x50>
    80006a80:	fffff097          	auipc	ra,0xfffff
    80006a84:	f1c080e7          	jalr	-228(ra) # 8000599c <panic>

0000000080006a88 <__memset>:
    80006a88:	ff010113          	addi	sp,sp,-16
    80006a8c:	00813423          	sd	s0,8(sp)
    80006a90:	01010413          	addi	s0,sp,16
    80006a94:	1a060e63          	beqz	a2,80006c50 <__memset+0x1c8>
    80006a98:	40a007b3          	neg	a5,a0
    80006a9c:	0077f793          	andi	a5,a5,7
    80006aa0:	00778693          	addi	a3,a5,7
    80006aa4:	00b00813          	li	a6,11
    80006aa8:	0ff5f593          	andi	a1,a1,255
    80006aac:	fff6071b          	addiw	a4,a2,-1
    80006ab0:	1b06e663          	bltu	a3,a6,80006c5c <__memset+0x1d4>
    80006ab4:	1cd76463          	bltu	a4,a3,80006c7c <__memset+0x1f4>
    80006ab8:	1a078e63          	beqz	a5,80006c74 <__memset+0x1ec>
    80006abc:	00b50023          	sb	a1,0(a0)
    80006ac0:	00100713          	li	a4,1
    80006ac4:	1ae78463          	beq	a5,a4,80006c6c <__memset+0x1e4>
    80006ac8:	00b500a3          	sb	a1,1(a0)
    80006acc:	00200713          	li	a4,2
    80006ad0:	1ae78a63          	beq	a5,a4,80006c84 <__memset+0x1fc>
    80006ad4:	00b50123          	sb	a1,2(a0)
    80006ad8:	00300713          	li	a4,3
    80006adc:	18e78463          	beq	a5,a4,80006c64 <__memset+0x1dc>
    80006ae0:	00b501a3          	sb	a1,3(a0)
    80006ae4:	00400713          	li	a4,4
    80006ae8:	1ae78263          	beq	a5,a4,80006c8c <__memset+0x204>
    80006aec:	00b50223          	sb	a1,4(a0)
    80006af0:	00500713          	li	a4,5
    80006af4:	1ae78063          	beq	a5,a4,80006c94 <__memset+0x20c>
    80006af8:	00b502a3          	sb	a1,5(a0)
    80006afc:	00700713          	li	a4,7
    80006b00:	18e79e63          	bne	a5,a4,80006c9c <__memset+0x214>
    80006b04:	00b50323          	sb	a1,6(a0)
    80006b08:	00700e93          	li	t4,7
    80006b0c:	00859713          	slli	a4,a1,0x8
    80006b10:	00e5e733          	or	a4,a1,a4
    80006b14:	01059e13          	slli	t3,a1,0x10
    80006b18:	01c76e33          	or	t3,a4,t3
    80006b1c:	01859313          	slli	t1,a1,0x18
    80006b20:	006e6333          	or	t1,t3,t1
    80006b24:	02059893          	slli	a7,a1,0x20
    80006b28:	40f60e3b          	subw	t3,a2,a5
    80006b2c:	011368b3          	or	a7,t1,a7
    80006b30:	02859813          	slli	a6,a1,0x28
    80006b34:	0108e833          	or	a6,a7,a6
    80006b38:	03059693          	slli	a3,a1,0x30
    80006b3c:	003e589b          	srliw	a7,t3,0x3
    80006b40:	00d866b3          	or	a3,a6,a3
    80006b44:	03859713          	slli	a4,a1,0x38
    80006b48:	00389813          	slli	a6,a7,0x3
    80006b4c:	00f507b3          	add	a5,a0,a5
    80006b50:	00e6e733          	or	a4,a3,a4
    80006b54:	000e089b          	sext.w	a7,t3
    80006b58:	00f806b3          	add	a3,a6,a5
    80006b5c:	00e7b023          	sd	a4,0(a5)
    80006b60:	00878793          	addi	a5,a5,8
    80006b64:	fed79ce3          	bne	a5,a3,80006b5c <__memset+0xd4>
    80006b68:	ff8e7793          	andi	a5,t3,-8
    80006b6c:	0007871b          	sext.w	a4,a5
    80006b70:	01d787bb          	addw	a5,a5,t4
    80006b74:	0ce88e63          	beq	a7,a4,80006c50 <__memset+0x1c8>
    80006b78:	00f50733          	add	a4,a0,a5
    80006b7c:	00b70023          	sb	a1,0(a4)
    80006b80:	0017871b          	addiw	a4,a5,1
    80006b84:	0cc77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006b88:	00e50733          	add	a4,a0,a4
    80006b8c:	00b70023          	sb	a1,0(a4)
    80006b90:	0027871b          	addiw	a4,a5,2
    80006b94:	0ac77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006b98:	00e50733          	add	a4,a0,a4
    80006b9c:	00b70023          	sb	a1,0(a4)
    80006ba0:	0037871b          	addiw	a4,a5,3
    80006ba4:	0ac77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006ba8:	00e50733          	add	a4,a0,a4
    80006bac:	00b70023          	sb	a1,0(a4)
    80006bb0:	0047871b          	addiw	a4,a5,4
    80006bb4:	08c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bb8:	00e50733          	add	a4,a0,a4
    80006bbc:	00b70023          	sb	a1,0(a4)
    80006bc0:	0057871b          	addiw	a4,a5,5
    80006bc4:	08c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bc8:	00e50733          	add	a4,a0,a4
    80006bcc:	00b70023          	sb	a1,0(a4)
    80006bd0:	0067871b          	addiw	a4,a5,6
    80006bd4:	06c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bd8:	00e50733          	add	a4,a0,a4
    80006bdc:	00b70023          	sb	a1,0(a4)
    80006be0:	0077871b          	addiw	a4,a5,7
    80006be4:	06c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006be8:	00e50733          	add	a4,a0,a4
    80006bec:	00b70023          	sb	a1,0(a4)
    80006bf0:	0087871b          	addiw	a4,a5,8
    80006bf4:	04c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006bf8:	00e50733          	add	a4,a0,a4
    80006bfc:	00b70023          	sb	a1,0(a4)
    80006c00:	0097871b          	addiw	a4,a5,9
    80006c04:	04c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c08:	00e50733          	add	a4,a0,a4
    80006c0c:	00b70023          	sb	a1,0(a4)
    80006c10:	00a7871b          	addiw	a4,a5,10
    80006c14:	02c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c18:	00e50733          	add	a4,a0,a4
    80006c1c:	00b70023          	sb	a1,0(a4)
    80006c20:	00b7871b          	addiw	a4,a5,11
    80006c24:	02c77663          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c28:	00e50733          	add	a4,a0,a4
    80006c2c:	00b70023          	sb	a1,0(a4)
    80006c30:	00c7871b          	addiw	a4,a5,12
    80006c34:	00c77e63          	bgeu	a4,a2,80006c50 <__memset+0x1c8>
    80006c38:	00e50733          	add	a4,a0,a4
    80006c3c:	00b70023          	sb	a1,0(a4)
    80006c40:	00d7879b          	addiw	a5,a5,13
    80006c44:	00c7f663          	bgeu	a5,a2,80006c50 <__memset+0x1c8>
    80006c48:	00f507b3          	add	a5,a0,a5
    80006c4c:	00b78023          	sb	a1,0(a5)
    80006c50:	00813403          	ld	s0,8(sp)
    80006c54:	01010113          	addi	sp,sp,16
    80006c58:	00008067          	ret
    80006c5c:	00b00693          	li	a3,11
    80006c60:	e55ff06f          	j	80006ab4 <__memset+0x2c>
    80006c64:	00300e93          	li	t4,3
    80006c68:	ea5ff06f          	j	80006b0c <__memset+0x84>
    80006c6c:	00100e93          	li	t4,1
    80006c70:	e9dff06f          	j	80006b0c <__memset+0x84>
    80006c74:	00000e93          	li	t4,0
    80006c78:	e95ff06f          	j	80006b0c <__memset+0x84>
    80006c7c:	00000793          	li	a5,0
    80006c80:	ef9ff06f          	j	80006b78 <__memset+0xf0>
    80006c84:	00200e93          	li	t4,2
    80006c88:	e85ff06f          	j	80006b0c <__memset+0x84>
    80006c8c:	00400e93          	li	t4,4
    80006c90:	e7dff06f          	j	80006b0c <__memset+0x84>
    80006c94:	00500e93          	li	t4,5
    80006c98:	e75ff06f          	j	80006b0c <__memset+0x84>
    80006c9c:	00600e93          	li	t4,6
    80006ca0:	e6dff06f          	j	80006b0c <__memset+0x84>

0000000080006ca4 <__memmove>:
    80006ca4:	ff010113          	addi	sp,sp,-16
    80006ca8:	00813423          	sd	s0,8(sp)
    80006cac:	01010413          	addi	s0,sp,16
    80006cb0:	0e060863          	beqz	a2,80006da0 <__memmove+0xfc>
    80006cb4:	fff6069b          	addiw	a3,a2,-1
    80006cb8:	0006881b          	sext.w	a6,a3
    80006cbc:	0ea5e863          	bltu	a1,a0,80006dac <__memmove+0x108>
    80006cc0:	00758713          	addi	a4,a1,7
    80006cc4:	00a5e7b3          	or	a5,a1,a0
    80006cc8:	40a70733          	sub	a4,a4,a0
    80006ccc:	0077f793          	andi	a5,a5,7
    80006cd0:	00f73713          	sltiu	a4,a4,15
    80006cd4:	00174713          	xori	a4,a4,1
    80006cd8:	0017b793          	seqz	a5,a5
    80006cdc:	00e7f7b3          	and	a5,a5,a4
    80006ce0:	10078863          	beqz	a5,80006df0 <__memmove+0x14c>
    80006ce4:	00900793          	li	a5,9
    80006ce8:	1107f463          	bgeu	a5,a6,80006df0 <__memmove+0x14c>
    80006cec:	0036581b          	srliw	a6,a2,0x3
    80006cf0:	fff8081b          	addiw	a6,a6,-1
    80006cf4:	02081813          	slli	a6,a6,0x20
    80006cf8:	01d85893          	srli	a7,a6,0x1d
    80006cfc:	00858813          	addi	a6,a1,8
    80006d00:	00058793          	mv	a5,a1
    80006d04:	00050713          	mv	a4,a0
    80006d08:	01088833          	add	a6,a7,a6
    80006d0c:	0007b883          	ld	a7,0(a5)
    80006d10:	00878793          	addi	a5,a5,8
    80006d14:	00870713          	addi	a4,a4,8
    80006d18:	ff173c23          	sd	a7,-8(a4)
    80006d1c:	ff0798e3          	bne	a5,a6,80006d0c <__memmove+0x68>
    80006d20:	ff867713          	andi	a4,a2,-8
    80006d24:	02071793          	slli	a5,a4,0x20
    80006d28:	0207d793          	srli	a5,a5,0x20
    80006d2c:	00f585b3          	add	a1,a1,a5
    80006d30:	40e686bb          	subw	a3,a3,a4
    80006d34:	00f507b3          	add	a5,a0,a5
    80006d38:	06e60463          	beq	a2,a4,80006da0 <__memmove+0xfc>
    80006d3c:	0005c703          	lbu	a4,0(a1)
    80006d40:	00e78023          	sb	a4,0(a5)
    80006d44:	04068e63          	beqz	a3,80006da0 <__memmove+0xfc>
    80006d48:	0015c603          	lbu	a2,1(a1)
    80006d4c:	00100713          	li	a4,1
    80006d50:	00c780a3          	sb	a2,1(a5)
    80006d54:	04e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d58:	0025c603          	lbu	a2,2(a1)
    80006d5c:	00200713          	li	a4,2
    80006d60:	00c78123          	sb	a2,2(a5)
    80006d64:	02e68e63          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d68:	0035c603          	lbu	a2,3(a1)
    80006d6c:	00300713          	li	a4,3
    80006d70:	00c781a3          	sb	a2,3(a5)
    80006d74:	02e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d78:	0045c603          	lbu	a2,4(a1)
    80006d7c:	00400713          	li	a4,4
    80006d80:	00c78223          	sb	a2,4(a5)
    80006d84:	00e68e63          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d88:	0055c603          	lbu	a2,5(a1)
    80006d8c:	00500713          	li	a4,5
    80006d90:	00c782a3          	sb	a2,5(a5)
    80006d94:	00e68663          	beq	a3,a4,80006da0 <__memmove+0xfc>
    80006d98:	0065c703          	lbu	a4,6(a1)
    80006d9c:	00e78323          	sb	a4,6(a5)
    80006da0:	00813403          	ld	s0,8(sp)
    80006da4:	01010113          	addi	sp,sp,16
    80006da8:	00008067          	ret
    80006dac:	02061713          	slli	a4,a2,0x20
    80006db0:	02075713          	srli	a4,a4,0x20
    80006db4:	00e587b3          	add	a5,a1,a4
    80006db8:	f0f574e3          	bgeu	a0,a5,80006cc0 <__memmove+0x1c>
    80006dbc:	02069613          	slli	a2,a3,0x20
    80006dc0:	02065613          	srli	a2,a2,0x20
    80006dc4:	fff64613          	not	a2,a2
    80006dc8:	00e50733          	add	a4,a0,a4
    80006dcc:	00c78633          	add	a2,a5,a2
    80006dd0:	fff7c683          	lbu	a3,-1(a5)
    80006dd4:	fff78793          	addi	a5,a5,-1
    80006dd8:	fff70713          	addi	a4,a4,-1
    80006ddc:	00d70023          	sb	a3,0(a4)
    80006de0:	fec798e3          	bne	a5,a2,80006dd0 <__memmove+0x12c>
    80006de4:	00813403          	ld	s0,8(sp)
    80006de8:	01010113          	addi	sp,sp,16
    80006dec:	00008067          	ret
    80006df0:	02069713          	slli	a4,a3,0x20
    80006df4:	02075713          	srli	a4,a4,0x20
    80006df8:	00170713          	addi	a4,a4,1
    80006dfc:	00e50733          	add	a4,a0,a4
    80006e00:	00050793          	mv	a5,a0
    80006e04:	0005c683          	lbu	a3,0(a1)
    80006e08:	00178793          	addi	a5,a5,1
    80006e0c:	00158593          	addi	a1,a1,1
    80006e10:	fed78fa3          	sb	a3,-1(a5)
    80006e14:	fee798e3          	bne	a5,a4,80006e04 <__memmove+0x160>
    80006e18:	f89ff06f          	j	80006da0 <__memmove+0xfc>

0000000080006e1c <__mem_free>:
    80006e1c:	ff010113          	addi	sp,sp,-16
    80006e20:	00813423          	sd	s0,8(sp)
    80006e24:	01010413          	addi	s0,sp,16
    80006e28:	00003597          	auipc	a1,0x3
    80006e2c:	19058593          	addi	a1,a1,400 # 80009fb8 <freep>
    80006e30:	0005b783          	ld	a5,0(a1)
    80006e34:	ff050693          	addi	a3,a0,-16
    80006e38:	0007b703          	ld	a4,0(a5)
    80006e3c:	00d7fc63          	bgeu	a5,a3,80006e54 <__mem_free+0x38>
    80006e40:	00e6ee63          	bltu	a3,a4,80006e5c <__mem_free+0x40>
    80006e44:	00e7fc63          	bgeu	a5,a4,80006e5c <__mem_free+0x40>
    80006e48:	00070793          	mv	a5,a4
    80006e4c:	0007b703          	ld	a4,0(a5)
    80006e50:	fed7e8e3          	bltu	a5,a3,80006e40 <__mem_free+0x24>
    80006e54:	fee7eae3          	bltu	a5,a4,80006e48 <__mem_free+0x2c>
    80006e58:	fee6f8e3          	bgeu	a3,a4,80006e48 <__mem_free+0x2c>
    80006e5c:	ff852803          	lw	a6,-8(a0)
    80006e60:	02081613          	slli	a2,a6,0x20
    80006e64:	01c65613          	srli	a2,a2,0x1c
    80006e68:	00c68633          	add	a2,a3,a2
    80006e6c:	02c70a63          	beq	a4,a2,80006ea0 <__mem_free+0x84>
    80006e70:	fee53823          	sd	a4,-16(a0)
    80006e74:	0087a503          	lw	a0,8(a5)
    80006e78:	02051613          	slli	a2,a0,0x20
    80006e7c:	01c65613          	srli	a2,a2,0x1c
    80006e80:	00c78633          	add	a2,a5,a2
    80006e84:	04c68263          	beq	a3,a2,80006ec8 <__mem_free+0xac>
    80006e88:	00813403          	ld	s0,8(sp)
    80006e8c:	00d7b023          	sd	a3,0(a5)
    80006e90:	00f5b023          	sd	a5,0(a1)
    80006e94:	00000513          	li	a0,0
    80006e98:	01010113          	addi	sp,sp,16
    80006e9c:	00008067          	ret
    80006ea0:	00872603          	lw	a2,8(a4)
    80006ea4:	00073703          	ld	a4,0(a4)
    80006ea8:	0106083b          	addw	a6,a2,a6
    80006eac:	ff052c23          	sw	a6,-8(a0)
    80006eb0:	fee53823          	sd	a4,-16(a0)
    80006eb4:	0087a503          	lw	a0,8(a5)
    80006eb8:	02051613          	slli	a2,a0,0x20
    80006ebc:	01c65613          	srli	a2,a2,0x1c
    80006ec0:	00c78633          	add	a2,a5,a2
    80006ec4:	fcc692e3          	bne	a3,a2,80006e88 <__mem_free+0x6c>
    80006ec8:	00813403          	ld	s0,8(sp)
    80006ecc:	0105053b          	addw	a0,a0,a6
    80006ed0:	00a7a423          	sw	a0,8(a5)
    80006ed4:	00e7b023          	sd	a4,0(a5)
    80006ed8:	00f5b023          	sd	a5,0(a1)
    80006edc:	00000513          	li	a0,0
    80006ee0:	01010113          	addi	sp,sp,16
    80006ee4:	00008067          	ret

0000000080006ee8 <__mem_alloc>:
    80006ee8:	fc010113          	addi	sp,sp,-64
    80006eec:	02813823          	sd	s0,48(sp)
    80006ef0:	02913423          	sd	s1,40(sp)
    80006ef4:	03213023          	sd	s2,32(sp)
    80006ef8:	01513423          	sd	s5,8(sp)
    80006efc:	02113c23          	sd	ra,56(sp)
    80006f00:	01313c23          	sd	s3,24(sp)
    80006f04:	01413823          	sd	s4,16(sp)
    80006f08:	01613023          	sd	s6,0(sp)
    80006f0c:	04010413          	addi	s0,sp,64
    80006f10:	00003a97          	auipc	s5,0x3
    80006f14:	0a8a8a93          	addi	s5,s5,168 # 80009fb8 <freep>
    80006f18:	00f50913          	addi	s2,a0,15
    80006f1c:	000ab683          	ld	a3,0(s5)
    80006f20:	00495913          	srli	s2,s2,0x4
    80006f24:	0019049b          	addiw	s1,s2,1
    80006f28:	00048913          	mv	s2,s1
    80006f2c:	0c068c63          	beqz	a3,80007004 <__mem_alloc+0x11c>
    80006f30:	0006b503          	ld	a0,0(a3)
    80006f34:	00852703          	lw	a4,8(a0)
    80006f38:	10977063          	bgeu	a4,s1,80007038 <__mem_alloc+0x150>
    80006f3c:	000017b7          	lui	a5,0x1
    80006f40:	0009099b          	sext.w	s3,s2
    80006f44:	0af4e863          	bltu	s1,a5,80006ff4 <__mem_alloc+0x10c>
    80006f48:	02099a13          	slli	s4,s3,0x20
    80006f4c:	01ca5a13          	srli	s4,s4,0x1c
    80006f50:	fff00b13          	li	s6,-1
    80006f54:	0100006f          	j	80006f64 <__mem_alloc+0x7c>
    80006f58:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80006f5c:	00852703          	lw	a4,8(a0)
    80006f60:	04977463          	bgeu	a4,s1,80006fa8 <__mem_alloc+0xc0>
    80006f64:	00050793          	mv	a5,a0
    80006f68:	fea698e3          	bne	a3,a0,80006f58 <__mem_alloc+0x70>
    80006f6c:	000a0513          	mv	a0,s4
    80006f70:	00000097          	auipc	ra,0x0
    80006f74:	1f0080e7          	jalr	496(ra) # 80007160 <kvmincrease>
    80006f78:	00050793          	mv	a5,a0
    80006f7c:	01050513          	addi	a0,a0,16
    80006f80:	07678e63          	beq	a5,s6,80006ffc <__mem_alloc+0x114>
    80006f84:	0137a423          	sw	s3,8(a5)
    80006f88:	00000097          	auipc	ra,0x0
    80006f8c:	e94080e7          	jalr	-364(ra) # 80006e1c <__mem_free>
    80006f90:	000ab783          	ld	a5,0(s5)
    80006f94:	06078463          	beqz	a5,80006ffc <__mem_alloc+0x114>
    80006f98:	0007b503          	ld	a0,0(a5)
    80006f9c:	00078693          	mv	a3,a5
    80006fa0:	00852703          	lw	a4,8(a0)
    80006fa4:	fc9760e3          	bltu	a4,s1,80006f64 <__mem_alloc+0x7c>
    80006fa8:	08e48263          	beq	s1,a4,8000702c <__mem_alloc+0x144>
    80006fac:	4127073b          	subw	a4,a4,s2
    80006fb0:	02071693          	slli	a3,a4,0x20
    80006fb4:	01c6d693          	srli	a3,a3,0x1c
    80006fb8:	00e52423          	sw	a4,8(a0)
    80006fbc:	00d50533          	add	a0,a0,a3
    80006fc0:	01252423          	sw	s2,8(a0)
    80006fc4:	00fab023          	sd	a5,0(s5)
    80006fc8:	01050513          	addi	a0,a0,16
    80006fcc:	03813083          	ld	ra,56(sp)
    80006fd0:	03013403          	ld	s0,48(sp)
    80006fd4:	02813483          	ld	s1,40(sp)
    80006fd8:	02013903          	ld	s2,32(sp)
    80006fdc:	01813983          	ld	s3,24(sp)
    80006fe0:	01013a03          	ld	s4,16(sp)
    80006fe4:	00813a83          	ld	s5,8(sp)
    80006fe8:	00013b03          	ld	s6,0(sp)
    80006fec:	04010113          	addi	sp,sp,64
    80006ff0:	00008067          	ret
    80006ff4:	000019b7          	lui	s3,0x1
    80006ff8:	f51ff06f          	j	80006f48 <__mem_alloc+0x60>
    80006ffc:	00000513          	li	a0,0
    80007000:	fcdff06f          	j	80006fcc <__mem_alloc+0xe4>
    80007004:	00004797          	auipc	a5,0x4
    80007008:	26c78793          	addi	a5,a5,620 # 8000b270 <base>
    8000700c:	00078513          	mv	a0,a5
    80007010:	00fab023          	sd	a5,0(s5)
    80007014:	00f7b023          	sd	a5,0(a5)
    80007018:	00000713          	li	a4,0
    8000701c:	00004797          	auipc	a5,0x4
    80007020:	2407ae23          	sw	zero,604(a5) # 8000b278 <base+0x8>
    80007024:	00050693          	mv	a3,a0
    80007028:	f11ff06f          	j	80006f38 <__mem_alloc+0x50>
    8000702c:	00053703          	ld	a4,0(a0)
    80007030:	00e7b023          	sd	a4,0(a5)
    80007034:	f91ff06f          	j	80006fc4 <__mem_alloc+0xdc>
    80007038:	00068793          	mv	a5,a3
    8000703c:	f6dff06f          	j	80006fa8 <__mem_alloc+0xc0>

0000000080007040 <__putc>:
    80007040:	fe010113          	addi	sp,sp,-32
    80007044:	00813823          	sd	s0,16(sp)
    80007048:	00113c23          	sd	ra,24(sp)
    8000704c:	02010413          	addi	s0,sp,32
    80007050:	00050793          	mv	a5,a0
    80007054:	fef40593          	addi	a1,s0,-17
    80007058:	00100613          	li	a2,1
    8000705c:	00000513          	li	a0,0
    80007060:	fef407a3          	sb	a5,-17(s0)
    80007064:	fffff097          	auipc	ra,0xfffff
    80007068:	918080e7          	jalr	-1768(ra) # 8000597c <console_write>
    8000706c:	01813083          	ld	ra,24(sp)
    80007070:	01013403          	ld	s0,16(sp)
    80007074:	02010113          	addi	sp,sp,32
    80007078:	00008067          	ret

000000008000707c <__getc>:
    8000707c:	fe010113          	addi	sp,sp,-32
    80007080:	00813823          	sd	s0,16(sp)
    80007084:	00113c23          	sd	ra,24(sp)
    80007088:	02010413          	addi	s0,sp,32
    8000708c:	fe840593          	addi	a1,s0,-24
    80007090:	00100613          	li	a2,1
    80007094:	00000513          	li	a0,0
    80007098:	fffff097          	auipc	ra,0xfffff
    8000709c:	8c4080e7          	jalr	-1852(ra) # 8000595c <console_read>
    800070a0:	fe844503          	lbu	a0,-24(s0)
    800070a4:	01813083          	ld	ra,24(sp)
    800070a8:	01013403          	ld	s0,16(sp)
    800070ac:	02010113          	addi	sp,sp,32
    800070b0:	00008067          	ret

00000000800070b4 <console_handler>:
    800070b4:	fe010113          	addi	sp,sp,-32
    800070b8:	00813823          	sd	s0,16(sp)
    800070bc:	00113c23          	sd	ra,24(sp)
    800070c0:	00913423          	sd	s1,8(sp)
    800070c4:	02010413          	addi	s0,sp,32
    800070c8:	14202773          	csrr	a4,scause
    800070cc:	100027f3          	csrr	a5,sstatus
    800070d0:	0027f793          	andi	a5,a5,2
    800070d4:	06079e63          	bnez	a5,80007150 <console_handler+0x9c>
    800070d8:	00074c63          	bltz	a4,800070f0 <console_handler+0x3c>
    800070dc:	01813083          	ld	ra,24(sp)
    800070e0:	01013403          	ld	s0,16(sp)
    800070e4:	00813483          	ld	s1,8(sp)
    800070e8:	02010113          	addi	sp,sp,32
    800070ec:	00008067          	ret
    800070f0:	0ff77713          	andi	a4,a4,255
    800070f4:	00900793          	li	a5,9
    800070f8:	fef712e3          	bne	a4,a5,800070dc <console_handler+0x28>
    800070fc:	ffffe097          	auipc	ra,0xffffe
    80007100:	4b8080e7          	jalr	1208(ra) # 800055b4 <plic_claim>
    80007104:	00a00793          	li	a5,10
    80007108:	00050493          	mv	s1,a0
    8000710c:	02f50c63          	beq	a0,a5,80007144 <console_handler+0x90>
    80007110:	fc0506e3          	beqz	a0,800070dc <console_handler+0x28>
    80007114:	00050593          	mv	a1,a0
    80007118:	00001517          	auipc	a0,0x1
    8000711c:	53850513          	addi	a0,a0,1336 # 80008650 <kvmincrease+0x14f0>
    80007120:	fffff097          	auipc	ra,0xfffff
    80007124:	8d8080e7          	jalr	-1832(ra) # 800059f8 <__printf>
    80007128:	01013403          	ld	s0,16(sp)
    8000712c:	01813083          	ld	ra,24(sp)
    80007130:	00048513          	mv	a0,s1
    80007134:	00813483          	ld	s1,8(sp)
    80007138:	02010113          	addi	sp,sp,32
    8000713c:	ffffe317          	auipc	t1,0xffffe
    80007140:	4b030067          	jr	1200(t1) # 800055ec <plic_complete>
    80007144:	fffff097          	auipc	ra,0xfffff
    80007148:	1bc080e7          	jalr	444(ra) # 80006300 <uartintr>
    8000714c:	fddff06f          	j	80007128 <console_handler+0x74>
    80007150:	00001517          	auipc	a0,0x1
    80007154:	60050513          	addi	a0,a0,1536 # 80008750 <digits+0x78>
    80007158:	fffff097          	auipc	ra,0xfffff
    8000715c:	844080e7          	jalr	-1980(ra) # 8000599c <panic>

0000000080007160 <kvmincrease>:
    80007160:	fe010113          	addi	sp,sp,-32
    80007164:	01213023          	sd	s2,0(sp)
    80007168:	00001937          	lui	s2,0x1
    8000716c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80007170:	00813823          	sd	s0,16(sp)
    80007174:	00113c23          	sd	ra,24(sp)
    80007178:	00913423          	sd	s1,8(sp)
    8000717c:	02010413          	addi	s0,sp,32
    80007180:	01250933          	add	s2,a0,s2
    80007184:	00c95913          	srli	s2,s2,0xc
    80007188:	02090863          	beqz	s2,800071b8 <kvmincrease+0x58>
    8000718c:	00000493          	li	s1,0
    80007190:	00148493          	addi	s1,s1,1
    80007194:	fffff097          	auipc	ra,0xfffff
    80007198:	4bc080e7          	jalr	1212(ra) # 80006650 <kalloc>
    8000719c:	fe991ae3          	bne	s2,s1,80007190 <kvmincrease+0x30>
    800071a0:	01813083          	ld	ra,24(sp)
    800071a4:	01013403          	ld	s0,16(sp)
    800071a8:	00813483          	ld	s1,8(sp)
    800071ac:	00013903          	ld	s2,0(sp)
    800071b0:	02010113          	addi	sp,sp,32
    800071b4:	00008067          	ret
    800071b8:	01813083          	ld	ra,24(sp)
    800071bc:	01013403          	ld	s0,16(sp)
    800071c0:	00813483          	ld	s1,8(sp)
    800071c4:	00013903          	ld	s2,0(sp)
    800071c8:	00000513          	li	a0,0
    800071cc:	02010113          	addi	sp,sp,32
    800071d0:	00008067          	ret
	...
