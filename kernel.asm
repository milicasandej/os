
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	d0813103          	ld	sp,-760(sp) # 80008d08 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	640040ef          	jal	ra,8000465c <start>

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
    800010a4:	1e9000ef          	jal	ra,80001a8c <_ZN5Riscv20handleSupervisorTrapEv>

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
    80001154:	00005097          	auipc	ra,0x5
    80001158:	694080e7          	jalr	1684(ra) # 800067e8 <__mem_alloc>
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
    8000117c:	00005097          	auipc	ra,0x5
    80001180:	5a0080e7          	jalr	1440(ra) # 8000671c <__mem_free>
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
    800012d0:	00005097          	auipc	ra,0x5
    800012d4:	6ac080e7          	jalr	1708(ra) # 8000697c <__getc>
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
    800012f8:	00005097          	auipc	ra,0x5
    800012fc:	648080e7          	jalr	1608(ra) # 80006940 <__putc>
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
    8000133c:	3a8080e7          	jalr	936(ra) # 800016e0 <_Znwm>
    80001340:	00050493          	mv	s1,a0
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true),
            blocked(false)
    80001344:	01253023          	sd	s2,0(a0)
    80001348:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    8000134c:	00090a63          	beqz	s2,80001360 <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    80001350:	00008537          	lui	a0,0x8
    80001354:	00000097          	auipc	ra,0x0
    80001358:	3b4080e7          	jalr	948(ra) # 80001708 <_Znam>
    8000135c:	0080006f          	j	80001364 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    80001360:	00000513          	li	a0,0
            blocked(false)
    80001364:	00a4b823          	sd	a0,16(s1)
    80001368:	00000797          	auipc	a5,0x0
    8000136c:	0f478793          	addi	a5,a5,244 # 8000145c <_ZN7_thread13threadWrapperEv>
    80001370:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001374:	02050a63          	beqz	a0,800013a8 <_ZN7_thread12createThreadEPFvPvES0_+0x98>
    80001378:	000087b7          	lui	a5,0x8
    8000137c:	00f507b3          	add	a5,a0,a5
            blocked(false)
    80001380:	02f4b023          	sd	a5,32(s1)
    80001384:	02048823          	sb	zero,48(s1)
    80001388:	00100793          	li	a5,1
    8000138c:	02f488a3          	sb	a5,49(s1)
    80001390:	02048923          	sb	zero,50(s1)
    {
            if (body != nullptr) { Scheduler::put(this);}
    80001394:	02090c63          	beqz	s2,800013cc <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
    80001398:	00048513          	mv	a0,s1
    8000139c:	00001097          	auipc	ra,0x1
    800013a0:	b44080e7          	jalr	-1212(ra) # 80001ee0 <_ZN9Scheduler3putEP7_thread>
    800013a4:	0280006f          	j	800013cc <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    800013a8:	00000793          	li	a5,0
    800013ac:	fd5ff06f          	j	80001380 <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    800013b0:	00050913          	mv	s2,a0
    800013b4:	00048513          	mv	a0,s1
    800013b8:	00000097          	auipc	ra,0x0
    800013bc:	378080e7          	jalr	888(ra) # 80001730 <_ZdlPv>
    800013c0:	00090513          	mv	a0,s2
    800013c4:	00009097          	auipc	ra,0x9
    800013c8:	ab4080e7          	jalr	-1356(ra) # 80009e78 <_Unwind_Resume>
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

00000000800013ec <_ZN7_thread8dispatchEv>:

void _thread::dispatch()
{
    800013ec:	fe010113          	addi	sp,sp,-32
    800013f0:	00113c23          	sd	ra,24(sp)
    800013f4:	00813823          	sd	s0,16(sp)
    800013f8:	00913423          	sd	s1,8(sp)
    800013fc:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001400:	00008497          	auipc	s1,0x8
    80001404:	9604b483          	ld	s1,-1696(s1) # 80008d60 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001408:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    8000140c:	00079663          	bnez	a5,80001418 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    80001410:	0324c783          	lbu	a5,50(s1)
    80001414:	02078c63          	beqz	a5,8000144c <_ZN7_thread8dispatchEv+0x60>
    running = Scheduler::get();
    80001418:	00001097          	auipc	ra,0x1
    8000141c:	a60080e7          	jalr	-1440(ra) # 80001e78 <_ZN9Scheduler3getEv>
    80001420:	00008797          	auipc	a5,0x8
    80001424:	94a7b023          	sd	a0,-1728(a5) # 80008d60 <_ZN7_thread7runningE>

    _thread::contextSwitch(&old->context, &running->context);
    80001428:	01850593          	addi	a1,a0,24 # 8018 <_entry-0x7fff7fe8>
    8000142c:	01848513          	addi	a0,s1,24
    80001430:	00000097          	auipc	ra,0x0
    80001434:	d00080e7          	jalr	-768(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001438:	01813083          	ld	ra,24(sp)
    8000143c:	01013403          	ld	s0,16(sp)
    80001440:	00813483          	ld	s1,8(sp)
    80001444:	02010113          	addi	sp,sp,32
    80001448:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    8000144c:	00048513          	mv	a0,s1
    80001450:	00001097          	auipc	ra,0x1
    80001454:	a90080e7          	jalr	-1392(ra) # 80001ee0 <_ZN9Scheduler3putEP7_thread>
    80001458:	fc1ff06f          	j	80001418 <_ZN7_thread8dispatchEv+0x2c>

000000008000145c <_ZN7_thread13threadWrapperEv>:

void _thread::threadWrapper()
{
    8000145c:	ff010113          	addi	sp,sp,-16
    80001460:	00113423          	sd	ra,8(sp)
    80001464:	00813023          	sd	s0,0(sp)
    80001468:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    8000146c:	00000097          	auipc	ra,0x0
    80001470:	600080e7          	jalr	1536(ra) # 80001a6c <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) _thread::dispatch();
    80001474:	00008797          	auipc	a5,0x8
    80001478:	8ec7b783          	ld	a5,-1812(a5) # 80008d60 <_ZN7_thread7runningE>
    bool isStarted() const { return started; }
    8000147c:	0317c703          	lbu	a4,49(a5)
    80001480:	00071863          	bnez	a4,80001490 <_ZN7_thread13threadWrapperEv+0x34>
    80001484:	00000097          	auipc	ra,0x0
    80001488:	f68080e7          	jalr	-152(ra) # 800013ec <_ZN7_thread8dispatchEv>
    8000148c:	fe9ff06f          	j	80001474 <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    80001490:	0007b703          	ld	a4,0(a5)
    80001494:	0087b503          	ld	a0,8(a5)
    80001498:	000700e7          	jalr	a4
    void setFinished(bool value) { finished = value; }
    8000149c:	00008797          	auipc	a5,0x8
    800014a0:	8c47b783          	ld	a5,-1852(a5) # 80008d60 <_ZN7_thread7runningE>
    800014a4:	00100713          	li	a4,1
    800014a8:	02e78823          	sb	a4,48(a5)
    running->setFinished(true);
    _thread::dispatch();
    800014ac:	00000097          	auipc	ra,0x0
    800014b0:	f40080e7          	jalr	-192(ra) # 800013ec <_ZN7_thread8dispatchEv>
}
    800014b4:	00813083          	ld	ra,8(sp)
    800014b8:	00013403          	ld	s0,0(sp)
    800014bc:	01010113          	addi	sp,sp,16
    800014c0:	00008067          	ret

00000000800014c4 <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014c4:	ff010113          	addi	sp,sp,-16
    800014c8:	00113423          	sd	ra,8(sp)
    800014cc:	00813023          	sd	s0,0(sp)
    800014d0:	01010413          	addi	s0,sp,16
    800014d4:	00008797          	auipc	a5,0x8
    800014d8:	88c7b783          	ld	a5,-1908(a5) # 80008d60 <_ZN7_thread7runningE>
    800014dc:	00100713          	li	a4,1
    800014e0:	02e78823          	sb	a4,48(a5)
    _thread::running->setFinished(true);
    _thread::dispatch();
    800014e4:	00000097          	auipc	ra,0x0
    800014e8:	f08080e7          	jalr	-248(ra) # 800013ec <_ZN7_thread8dispatchEv>
    return 0;
}
    800014ec:	00000513          	li	a0,0
    800014f0:	00813083          	ld	ra,8(sp)
    800014f4:	00013403          	ld	s0,0(sp)
    800014f8:	01010113          	addi	sp,sp,16
    800014fc:	00008067          	ret

0000000080001500 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001500:	ff010113          	addi	sp,sp,-16
    80001504:	00813423          	sd	s0,8(sp)
    80001508:	01010413          	addi	s0,sp,16
    this->started = b;
    8000150c:	02b508a3          	sb	a1,49(a0)
}
    80001510:	00813403          	ld	s0,8(sp)
    80001514:	01010113          	addi	sp,sp,16
    80001518:	00008067          	ret

000000008000151c <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    8000151c:	ff010113          	addi	sp,sp,-16
    80001520:	00813423          	sd	s0,8(sp)
    80001524:	01010413          	addi	s0,sp,16
    this->blocked = b;
    80001528:	02b50923          	sb	a1,50(a0)
}
    8000152c:	00813403          	ld	s0,8(sp)
    80001530:	01010113          	addi	sp,sp,16
    80001534:	00008067          	ret

0000000080001538 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001538:	fe010113          	addi	sp,sp,-32
    8000153c:	00113c23          	sd	ra,24(sp)
    80001540:	00813823          	sd	s0,16(sp)
    80001544:	00913423          	sd	s1,8(sp)
    80001548:	01213023          	sd	s2,0(sp)
    8000154c:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80001550:	00006517          	auipc	a0,0x6
    80001554:	ab050513          	addi	a0,a0,-1360 # 80007000 <kvmincrease+0x5a0>
    80001558:	00002097          	auipc	ra,0x2
    8000155c:	71c080e7          	jalr	1820(ra) # 80003c74 <_Z11printStringPKc>
    int test = getc() - '0';
    80001560:	00000097          	auipc	ra,0x0
    80001564:	d60080e7          	jalr	-672(ra) # 800012c0 <_Z4getcv>
    80001568:	00050913          	mv	s2,a0
    8000156c:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001570:	00000097          	auipc	ra,0x0
    80001574:	d50080e7          	jalr	-688(ra) # 800012c0 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001578:	fcb9091b          	addiw	s2,s2,-53
    8000157c:	00100793          	li	a5,1
    80001580:	0327f463          	bgeu	a5,s2,800015a8 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001584:	00700793          	li	a5,7
    80001588:	0c97ee63          	bltu	a5,s1,80001664 <_Z8userMainv+0x12c>
    8000158c:	00249493          	slli	s1,s1,0x2
    80001590:	00006717          	auipc	a4,0x6
    80001594:	c8870713          	addi	a4,a4,-888 # 80007218 <kvmincrease+0x7b8>
    80001598:	00e484b3          	add	s1,s1,a4
    8000159c:	0004a783          	lw	a5,0(s1)
    800015a0:	00e787b3          	add	a5,a5,a4
    800015a4:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015a8:	00006517          	auipc	a0,0x6
    800015ac:	a7850513          	addi	a0,a0,-1416 # 80007020 <kvmincrease+0x5c0>
    800015b0:	00002097          	auipc	ra,0x2
    800015b4:	6c4080e7          	jalr	1732(ra) # 80003c74 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800015b8:	01813083          	ld	ra,24(sp)
    800015bc:	01013403          	ld	s0,16(sp)
    800015c0:	00813483          	ld	s1,8(sp)
    800015c4:	00013903          	ld	s2,0(sp)
    800015c8:	02010113          	addi	sp,sp,32
    800015cc:	00008067          	ret
            Threads_C_API_test();
    800015d0:	00002097          	auipc	ra,0x2
    800015d4:	d1c080e7          	jalr	-740(ra) # 800032ec <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800015d8:	00006517          	auipc	a0,0x6
    800015dc:	a7850513          	addi	a0,a0,-1416 # 80007050 <kvmincrease+0x5f0>
    800015e0:	00002097          	auipc	ra,0x2
    800015e4:	694080e7          	jalr	1684(ra) # 80003c74 <_Z11printStringPKc>
            break;
    800015e8:	fd1ff06f          	j	800015b8 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    800015ec:	00001097          	auipc	ra,0x1
    800015f0:	364080e7          	jalr	868(ra) # 80002950 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    800015f4:	00006517          	auipc	a0,0x6
    800015f8:	a9c50513          	addi	a0,a0,-1380 # 80007090 <kvmincrease+0x630>
    800015fc:	00002097          	auipc	ra,0x2
    80001600:	678080e7          	jalr	1656(ra) # 80003c74 <_Z11printStringPKc>
            break;
    80001604:	fb5ff06f          	j	800015b8 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001608:	00001097          	auipc	ra,0x1
    8000160c:	b9c080e7          	jalr	-1124(ra) # 800021a4 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001610:	00006517          	auipc	a0,0x6
    80001614:	ac050513          	addi	a0,a0,-1344 # 800070d0 <kvmincrease+0x670>
    80001618:	00002097          	auipc	ra,0x2
    8000161c:	65c080e7          	jalr	1628(ra) # 80003c74 <_Z11printStringPKc>
            break;
    80001620:	f99ff06f          	j	800015b8 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001624:	00002097          	auipc	ra,0x2
    80001628:	00c080e7          	jalr	12(ra) # 80003630 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    8000162c:	00006517          	auipc	a0,0x6
    80001630:	af450513          	addi	a0,a0,-1292 # 80007120 <kvmincrease+0x6c0>
    80001634:	00002097          	auipc	ra,0x2
    80001638:	640080e7          	jalr	1600(ra) # 80003c74 <_Z11printStringPKc>
            break;
    8000163c:	f7dff06f          	j	800015b8 <_Z8userMainv+0x80>
            printString("Test se nije uspesno zavrsio\n");
    80001640:	00006517          	auipc	a0,0x6
    80001644:	b3850513          	addi	a0,a0,-1224 # 80007178 <kvmincrease+0x718>
    80001648:	00002097          	auipc	ra,0x2
    8000164c:	62c080e7          	jalr	1580(ra) # 80003c74 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001650:	00006517          	auipc	a0,0x6
    80001654:	b4850513          	addi	a0,a0,-1208 # 80007198 <kvmincrease+0x738>
    80001658:	00002097          	auipc	ra,0x2
    8000165c:	61c080e7          	jalr	1564(ra) # 80003c74 <_Z11printStringPKc>
            break;
    80001660:	f59ff06f          	j	800015b8 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001664:	00006517          	auipc	a0,0x6
    80001668:	b8c50513          	addi	a0,a0,-1140 # 800071f0 <kvmincrease+0x790>
    8000166c:	00002097          	auipc	ra,0x2
    80001670:	608080e7          	jalr	1544(ra) # 80003c74 <_Z11printStringPKc>
    80001674:	f45ff06f          	j	800015b8 <_Z8userMainv+0x80>

0000000080001678 <main>:
#include "../h/_thread.hpp"

extern void userMain();

void main()
{
    80001678:	fe010113          	addi	sp,sp,-32
    8000167c:	00113c23          	sd	ra,24(sp)
    80001680:	00813823          	sd	s0,16(sp)
    80001684:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80001688:	00007797          	auipc	a5,0x7
    8000168c:	6787b783          	ld	a5,1656(a5) # 80008d00 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001690:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    80001694:	00000613          	li	a2,0
    80001698:	00000593          	li	a1,0
    8000169c:	fe840513          	addi	a0,s0,-24
    800016a0:	00000097          	auipc	ra,0x0
    800016a4:	af4080e7          	jalr	-1292(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    800016a8:	00007797          	auipc	a5,0x7
    800016ac:	6507b783          	ld	a5,1616(a5) # 80008cf8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800016b0:	fe843703          	ld	a4,-24(s0)
    800016b4:	00e7b023          	sd	a4,0(a5)

    // promena rezima

    // uposleno cekanje

    userMain();
    800016b8:	00000097          	auipc	ra,0x0
    800016bc:	e80080e7          	jalr	-384(ra) # 80001538 <_Z8userMainv>
    printString("Finished\n");
    800016c0:	00006517          	auipc	a0,0x6
    800016c4:	b7850513          	addi	a0,a0,-1160 # 80007238 <kvmincrease+0x7d8>
    800016c8:	00002097          	auipc	ra,0x2
    800016cc:	5ac080e7          	jalr	1452(ra) # 80003c74 <_Z11printStringPKc>
}
    800016d0:	01813083          	ld	ra,24(sp)
    800016d4:	01013403          	ld	s0,16(sp)
    800016d8:	02010113          	addi	sp,sp,32
    800016dc:	00008067          	ret

00000000800016e0 <_Znwm>:


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    800016e0:	ff010113          	addi	sp,sp,-16
    800016e4:	00113423          	sd	ra,8(sp)
    800016e8:	00813023          	sd	s0,0(sp)
    800016ec:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800016f0:	00005097          	auipc	ra,0x5
    800016f4:	0f8080e7          	jalr	248(ra) # 800067e8 <__mem_alloc>
}
    800016f8:	00813083          	ld	ra,8(sp)
    800016fc:	00013403          	ld	s0,0(sp)
    80001700:	01010113          	addi	sp,sp,16
    80001704:	00008067          	ret

0000000080001708 <_Znam>:

void *operator new[](size_t n)
{
    80001708:	ff010113          	addi	sp,sp,-16
    8000170c:	00113423          	sd	ra,8(sp)
    80001710:	00813023          	sd	s0,0(sp)
    80001714:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001718:	00005097          	auipc	ra,0x5
    8000171c:	0d0080e7          	jalr	208(ra) # 800067e8 <__mem_alloc>
}
    80001720:	00813083          	ld	ra,8(sp)
    80001724:	00013403          	ld	s0,0(sp)
    80001728:	01010113          	addi	sp,sp,16
    8000172c:	00008067          	ret

0000000080001730 <_ZdlPv>:

void operator delete(void *p)
{
    80001730:	ff010113          	addi	sp,sp,-16
    80001734:	00113423          	sd	ra,8(sp)
    80001738:	00813023          	sd	s0,0(sp)
    8000173c:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001740:	00005097          	auipc	ra,0x5
    80001744:	fdc080e7          	jalr	-36(ra) # 8000671c <__mem_free>
}
    80001748:	00813083          	ld	ra,8(sp)
    8000174c:	00013403          	ld	s0,0(sp)
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret

0000000080001758 <_ZdaPv>:

void operator delete[](void *p)
{
    80001758:	ff010113          	addi	sp,sp,-16
    8000175c:	00113423          	sd	ra,8(sp)
    80001760:	00813023          	sd	s0,0(sp)
    80001764:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001768:	00005097          	auipc	ra,0x5
    8000176c:	fb4080e7          	jalr	-76(ra) # 8000671c <__mem_free>
}
    80001770:	00813083          	ld	ra,8(sp)
    80001774:	00013403          	ld	s0,0(sp)
    80001778:	01010113          	addi	sp,sp,16
    8000177c:	00008067          	ret

0000000080001780 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    80001780:	ff010113          	addi	sp,sp,-16
    80001784:	00813423          	sd	s0,8(sp)
    80001788:	01010413          	addi	s0,sp,16

}
    8000178c:	00813403          	ld	s0,8(sp)
    80001790:	01010113          	addi	sp,sp,16
    80001794:	00008067          	ret

0000000080001798 <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    80001798:	ff010113          	addi	sp,sp,-16
    8000179c:	00113423          	sd	ra,8(sp)
    800017a0:	00813023          	sd	s0,0(sp)
    800017a4:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    800017a8:	00053783          	ld	a5,0(a0)
    800017ac:	0107b783          	ld	a5,16(a5)
    800017b0:	000780e7          	jalr	a5
}
    800017b4:	00813083          	ld	ra,8(sp)
    800017b8:	00013403          	ld	s0,0(sp)
    800017bc:	01010113          	addi	sp,sp,16
    800017c0:	00008067          	ret

00000000800017c4 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800017c4:	ff010113          	addi	sp,sp,-16
    800017c8:	00113423          	sd	ra,8(sp)
    800017cc:	00813023          	sd	s0,0(sp)
    800017d0:	01010413          	addi	s0,sp,16
}
    800017d4:	00000097          	auipc	ra,0x0
    800017d8:	f5c080e7          	jalr	-164(ra) # 80001730 <_ZdlPv>
    800017dc:	00813083          	ld	ra,8(sp)
    800017e0:	00013403          	ld	s0,0(sp)
    800017e4:	01010113          	addi	sp,sp,16
    800017e8:	00008067          	ret

00000000800017ec <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    800017ec:	ff010113          	addi	sp,sp,-16
    800017f0:	00113423          	sd	ra,8(sp)
    800017f4:	00813023          	sd	s0,0(sp)
    800017f8:	01010413          	addi	s0,sp,16
    800017fc:	00007797          	auipc	a5,0x7
    80001800:	3b478793          	addi	a5,a5,948 # 80008bb0 <_ZTV9Semaphore+0x10>
    80001804:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80001808:	00853503          	ld	a0,8(a0)
    8000180c:	00000097          	auipc	ra,0x0
    80001810:	a30080e7          	jalr	-1488(ra) # 8000123c <_Z9sem_closeP4_sem>

}
    80001814:	00813083          	ld	ra,8(sp)
    80001818:	00013403          	ld	s0,0(sp)
    8000181c:	01010113          	addi	sp,sp,16
    80001820:	00008067          	ret

0000000080001824 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001824:	fe010113          	addi	sp,sp,-32
    80001828:	00113c23          	sd	ra,24(sp)
    8000182c:	00813823          	sd	s0,16(sp)
    80001830:	00913423          	sd	s1,8(sp)
    80001834:	02010413          	addi	s0,sp,32
    80001838:	00050493          	mv	s1,a0
}
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	fb0080e7          	jalr	-80(ra) # 800017ec <_ZN9SemaphoreD1Ev>
    80001844:	00048513          	mv	a0,s1
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	ee8080e7          	jalr	-280(ra) # 80001730 <_ZdlPv>
    80001850:	01813083          	ld	ra,24(sp)
    80001854:	01013403          	ld	s0,16(sp)
    80001858:	00813483          	ld	s1,8(sp)
    8000185c:	02010113          	addi	sp,sp,32
    80001860:	00008067          	ret

0000000080001864 <_ZN7Console4getcEv>:
char Console::getc() {
    80001864:	ff010113          	addi	sp,sp,-16
    80001868:	00113423          	sd	ra,8(sp)
    8000186c:	00813023          	sd	s0,0(sp)
    80001870:	01010413          	addi	s0,sp,16
    return __getc();
    80001874:	00005097          	auipc	ra,0x5
    80001878:	108080e7          	jalr	264(ra) # 8000697c <__getc>
}
    8000187c:	00813083          	ld	ra,8(sp)
    80001880:	00013403          	ld	s0,0(sp)
    80001884:	01010113          	addi	sp,sp,16
    80001888:	00008067          	ret

000000008000188c <_ZN7Console4putcEc>:
void Console::putc(char c) {
    8000188c:	ff010113          	addi	sp,sp,-16
    80001890:	00113423          	sd	ra,8(sp)
    80001894:	00813023          	sd	s0,0(sp)
    80001898:	01010413          	addi	s0,sp,16
    __putc(c);
    8000189c:	00005097          	auipc	ra,0x5
    800018a0:	0a4080e7          	jalr	164(ra) # 80006940 <__putc>
}
    800018a4:	00813083          	ld	ra,8(sp)
    800018a8:	00013403          	ld	s0,0(sp)
    800018ac:	01010113          	addi	sp,sp,16
    800018b0:	00008067          	ret

00000000800018b4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800018b4:	fe010113          	addi	sp,sp,-32
    800018b8:	00113c23          	sd	ra,24(sp)
    800018bc:	00813823          	sd	s0,16(sp)
    800018c0:	00913423          	sd	s1,8(sp)
    800018c4:	02010413          	addi	s0,sp,32
    800018c8:	00050493          	mv	s1,a0
    800018cc:	00007797          	auipc	a5,0x7
    800018d0:	2bc78793          	addi	a5,a5,700 # 80008b88 <_ZTV6Thread+0x10>
    800018d4:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    800018d8:	00850513          	addi	a0,a0,8
    800018dc:	00000097          	auipc	ra,0x0
    800018e0:	8b8080e7          	jalr	-1864(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800018e4:	00000593          	li	a1,0
    800018e8:	0084b503          	ld	a0,8(s1)
    800018ec:	00000097          	auipc	ra,0x0
    800018f0:	c14080e7          	jalr	-1004(ra) # 80001500 <_ZN7_thread8setStartEb>
}
    800018f4:	01813083          	ld	ra,24(sp)
    800018f8:	01013403          	ld	s0,16(sp)
    800018fc:	00813483          	ld	s1,8(sp)
    80001900:	02010113          	addi	sp,sp,32
    80001904:	00008067          	ret

0000000080001908 <_ZN6Thread5startEv>:
int Thread::start() {
    80001908:	ff010113          	addi	sp,sp,-16
    8000190c:	00113423          	sd	ra,8(sp)
    80001910:	00813023          	sd	s0,0(sp)
    80001914:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001918:	00100593          	li	a1,1
    8000191c:	00853503          	ld	a0,8(a0)
    80001920:	00000097          	auipc	ra,0x0
    80001924:	be0080e7          	jalr	-1056(ra) # 80001500 <_ZN7_thread8setStartEb>
}
    80001928:	00000513          	li	a0,0
    8000192c:	00813083          	ld	ra,8(sp)
    80001930:	00013403          	ld	s0,0(sp)
    80001934:	01010113          	addi	sp,sp,16
    80001938:	00008067          	ret

000000008000193c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    8000193c:	ff010113          	addi	sp,sp,-16
    80001940:	00113423          	sd	ra,8(sp)
    80001944:	00813023          	sd	s0,0(sp)
    80001948:	01010413          	addi	s0,sp,16
    thread_dispatch();
    8000194c:	00000097          	auipc	ra,0x0
    80001950:	8a0080e7          	jalr	-1888(ra) # 800011ec <_Z15thread_dispatchv>
}
    80001954:	00813083          	ld	ra,8(sp)
    80001958:	00013403          	ld	s0,0(sp)
    8000195c:	01010113          	addi	sp,sp,16
    80001960:	00008067          	ret

0000000080001964 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001964:	fe010113          	addi	sp,sp,-32
    80001968:	00113c23          	sd	ra,24(sp)
    8000196c:	00813823          	sd	s0,16(sp)
    80001970:	00913423          	sd	s1,8(sp)
    80001974:	02010413          	addi	s0,sp,32
    80001978:	00050493          	mv	s1,a0
    8000197c:	00007797          	auipc	a5,0x7
    80001980:	20c78793          	addi	a5,a5,524 # 80008b88 <_ZTV6Thread+0x10>
    80001984:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    80001988:	00050613          	mv	a2,a0
    8000198c:	00000597          	auipc	a1,0x0
    80001990:	e0c58593          	addi	a1,a1,-500 # 80001798 <_ZN6Thread12startWrapperEPv>
    80001994:	00850513          	addi	a0,a0,8
    80001998:	fffff097          	auipc	ra,0xfffff
    8000199c:	7fc080e7          	jalr	2044(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800019a0:	00000593          	li	a1,0
    800019a4:	0084b503          	ld	a0,8(s1)
    800019a8:	00000097          	auipc	ra,0x0
    800019ac:	b58080e7          	jalr	-1192(ra) # 80001500 <_ZN7_thread8setStartEb>
}
    800019b0:	01813083          	ld	ra,24(sp)
    800019b4:	01013403          	ld	s0,16(sp)
    800019b8:	00813483          	ld	s1,8(sp)
    800019bc:	02010113          	addi	sp,sp,32
    800019c0:	00008067          	ret

00000000800019c4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    800019c4:	ff010113          	addi	sp,sp,-16
    800019c8:	00113423          	sd	ra,8(sp)
    800019cc:	00813023          	sd	s0,0(sp)
    800019d0:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    800019d4:	00853503          	ld	a0,8(a0)
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	890080e7          	jalr	-1904(ra) # 80001268 <_Z8sem_waitP4_sem>
}
    800019e0:	00813083          	ld	ra,8(sp)
    800019e4:	00013403          	ld	s0,0(sp)
    800019e8:	01010113          	addi	sp,sp,16
    800019ec:	00008067          	ret

00000000800019f0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800019f0:	ff010113          	addi	sp,sp,-16
    800019f4:	00113423          	sd	ra,8(sp)
    800019f8:	00813023          	sd	s0,0(sp)
    800019fc:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001a00:	00853503          	ld	a0,8(a0)
    80001a04:	00000097          	auipc	ra,0x0
    80001a08:	890080e7          	jalr	-1904(ra) # 80001294 <_Z10sem_signalP4_sem>
}
    80001a0c:	00813083          	ld	ra,8(sp)
    80001a10:	00013403          	ld	s0,0(sp)
    80001a14:	01010113          	addi	sp,sp,16
    80001a18:	00008067          	ret

0000000080001a1c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001a1c:	ff010113          	addi	sp,sp,-16
    80001a20:	00113423          	sd	ra,8(sp)
    80001a24:	00813023          	sd	s0,0(sp)
    80001a28:	01010413          	addi	s0,sp,16
    80001a2c:	00007797          	auipc	a5,0x7
    80001a30:	18478793          	addi	a5,a5,388 # 80008bb0 <_ZTV9Semaphore+0x10>
    80001a34:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001a38:	00850513          	addi	a0,a0,8
    80001a3c:	fffff097          	auipc	ra,0xfffff
    80001a40:	7d4080e7          	jalr	2004(ra) # 80001210 <_Z8sem_openPP4_semj>
}
    80001a44:	00813083          	ld	ra,8(sp)
    80001a48:	00013403          	ld	s0,0(sp)
    80001a4c:	01010113          	addi	sp,sp,16
    80001a50:	00008067          	ret

0000000080001a54 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001a54:	ff010113          	addi	sp,sp,-16
    80001a58:	00813423          	sd	s0,8(sp)
    80001a5c:	01010413          	addi	s0,sp,16
    80001a60:	00813403          	ld	s0,8(sp)
    80001a64:	01010113          	addi	sp,sp,16
    80001a68:	00008067          	ret

0000000080001a6c <_ZN5Riscv10popSppSpieEv>:

using namespace Num;


void Riscv::popSppSpie()
{
    80001a6c:	ff010113          	addi	sp,sp,-16
    80001a70:	00813423          	sd	s0,8(sp)
    80001a74:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001a78:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001a7c:	10200073          	sret
}
    80001a80:	00813403          	ld	s0,8(sp)
    80001a84:	01010113          	addi	sp,sp,16
    80001a88:	00008067          	ret

0000000080001a8c <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001a8c:	fb010113          	addi	sp,sp,-80
    80001a90:	04113423          	sd	ra,72(sp)
    80001a94:	04813023          	sd	s0,64(sp)
    80001a98:	02913c23          	sd	s1,56(sp)
    80001a9c:	03213823          	sd	s2,48(sp)
    80001aa0:	03313423          	sd	s3,40(sp)
    80001aa4:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001aa8:	142027f3          	csrr	a5,scause
    80001aac:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80001ab0:	fb843783          	ld	a5,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001ab4:	fff00713          	li	a4,-1
    80001ab8:	03f71713          	slli	a4,a4,0x3f
    80001abc:	00170713          	addi	a4,a4,1
    80001ac0:	14e78a63          	beq	a5,a4,80001c14 <_ZN5Riscv20handleSupervisorTrapEv+0x188>
    80001ac4:	fff00713          	li	a4,-1
    80001ac8:	03f71713          	slli	a4,a4,0x3f
    80001acc:	00170713          	addi	a4,a4,1
    80001ad0:	04f76c63          	bltu	a4,a5,80001b28 <_ZN5Riscv20handleSupervisorTrapEv+0x9c>
    80001ad4:	ff878793          	addi	a5,a5,-8
    80001ad8:	00100713          	li	a4,1
    80001adc:	10f76663          	bltu	a4,a5,80001be8 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001ae0:	141027f3          	csrr	a5,sepc
    80001ae4:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80001ae8:	fc843483          	ld	s1,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    80001aec:	00448493          	addi	s1,s1,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001af0:	100027f3          	csrr	a5,sstatus
    80001af4:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    80001af8:	fc043903          	ld	s2,-64(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001afc:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001b00:	fef78793          	addi	a5,a5,-17
    80001b04:	01300713          	li	a4,19
    80001b08:	0cf76863          	bltu	a4,a5,80001bd8 <_ZN5Riscv20handleSupervisorTrapEv+0x14c>
    80001b0c:	00279793          	slli	a5,a5,0x2
    80001b10:	00005717          	auipc	a4,0x5
    80001b14:	73470713          	addi	a4,a4,1844 # 80007244 <kvmincrease+0x7e4>
    80001b18:	00e787b3          	add	a5,a5,a4
    80001b1c:	0007a783          	lw	a5,0(a5)
    80001b20:	00e787b3          	add	a5,a5,a4
    80001b24:	00078067          	jr	a5
    switch((uint64)scause){
    80001b28:	fff00713          	li	a4,-1
    80001b2c:	03f71713          	slli	a4,a4,0x3f
    80001b30:	00970713          	addi	a4,a4,9
    80001b34:	0ae79a63          	bne	a5,a4,80001be8 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001b38:	00005097          	auipc	ra,0x5
    80001b3c:	e7c080e7          	jalr	-388(ra) # 800069b4 <console_handler>
            break;
        default:
            break;
    }
    80001b40:	0a80006f          	j	80001be8 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>
                    READ_REG(handle, "a0");
    80001b44:	00050993          	mv	s3,a0
                    READ_REG(body, "a1");
    80001b48:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001b4c:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001b50:	fffff097          	auipc	ra,0xfffff
    80001b54:	7c0080e7          	jalr	1984(ra) # 80001310 <_ZN7_thread12createThreadEPFvPvES0_>
    80001b58:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001b5c:	0a050463          	beqz	a0,80001c04 <_ZN5Riscv20handleSupervisorTrapEv+0x178>
    80001b60:	00000513          	li	a0,0
    80001b64:	0780006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    ret = _thread::exitThread();
    80001b68:	00000097          	auipc	ra,0x0
    80001b6c:	95c080e7          	jalr	-1700(ra) # 800014c4 <_ZN7_thread10exitThreadEv>
                    break;
    80001b70:	06c0006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    _thread::dispatch();
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	878080e7          	jalr	-1928(ra) # 800013ec <_ZN7_thread8dispatchEv>
            uint64 ret = 0;
    80001b7c:	00000513          	li	a0,0
                    break;
    80001b80:	05c0006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    READ_REG(handle, "a0");
    80001b84:	00050993          	mv	s3,a0
                    READ_REG(init, "a1");
    80001b88:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001b8c:	0005051b          	sext.w	a0,a0
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	260080e7          	jalr	608(ra) # 80001df0 <_ZN4_sem15createSemaphoreEj>
    80001b98:	00a9b023          	sd	a0,0(s3)
                    if(*handle != nullptr) ret = 0;
    80001b9c:	06050863          	beqz	a0,80001c0c <_ZN5Riscv20handleSupervisorTrapEv+0x180>
    80001ba0:	00000513          	li	a0,0
    80001ba4:	0380006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    READ_REG(handleClose, "a0");
    80001ba8:	00050513          	mv	a0,a0
                    ret = handleClose->close();
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	1ac080e7          	jalr	428(ra) # 80001d58 <_ZN4_sem5closeEv>
                    break;
    80001bb4:	0280006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    READ_REG(idWait, "a0");
    80001bb8:	00050513          	mv	a0,a0
                    ret = idWait->wait();
    80001bbc:	00000097          	auipc	ra,0x0
    80001bc0:	064080e7          	jalr	100(ra) # 80001c20 <_ZN4_sem4waitEv>
                    break;
    80001bc4:	0180006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    READ_REG(idSignal, "a0");
    80001bc8:	00050513          	mv	a0,a0
                    ret = idSignal->signal();
    80001bcc:	00000097          	auipc	ra,0x0
    80001bd0:	0f8080e7          	jalr	248(ra) # 80001cc4 <_ZN4_sem6signalEv>
                    break;
    80001bd4:	0080006f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
            READ_REG(scallnum, "a7");
    80001bd8:	00000513          	li	a0,0
            WRITE_REG("a0", ret);
    80001bdc:	00050513          	mv	a0,a0
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001be0:	10091073          	csrw	sstatus,s2
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001be4:	14149073          	csrw	sepc,s1
    80001be8:	04813083          	ld	ra,72(sp)
    80001bec:	04013403          	ld	s0,64(sp)
    80001bf0:	03813483          	ld	s1,56(sp)
    80001bf4:	03013903          	ld	s2,48(sp)
    80001bf8:	02813983          	ld	s3,40(sp)
    80001bfc:	05010113          	addi	sp,sp,80
    80001c00:	00008067          	ret
                    else ret = -1;
    80001c04:	fff00513          	li	a0,-1
    80001c08:	fd5ff06f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
                    else ret = -1;
    80001c0c:	fff00513          	li	a0,-1
    80001c10:	fcdff06f          	j	80001bdc <_ZN5Riscv20handleSupervisorTrapEv+0x150>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001c14:	00200793          	li	a5,2
    80001c18:	1447b073          	csrc	sip,a5
}
    80001c1c:	fcdff06f          	j	80001be8 <_ZN5Riscv20handleSupervisorTrapEv+0x15c>

0000000080001c20 <_ZN4_sem4waitEv>:
//

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    80001c20:	fe010113          	addi	sp,sp,-32
    80001c24:	00113c23          	sd	ra,24(sp)
    80001c28:	00813823          	sd	s0,16(sp)
    80001c2c:	00913423          	sd	s1,8(sp)
    80001c30:	01213023          	sd	s2,0(sp)
    80001c34:	02010413          	addi	s0,sp,32
    80001c38:	00050493          	mv	s1,a0
    if (--val < 0){
    80001c3c:	00052783          	lw	a5,0(a0)
    80001c40:	fff7879b          	addiw	a5,a5,-1
    80001c44:	00f52023          	sw	a5,0(a0)
    80001c48:	02079713          	slli	a4,a5,0x20
    80001c4c:	02074063          	bltz	a4,80001c6c <_ZN4_sem4waitEv+0x4c>
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
}
    80001c50:	0044a503          	lw	a0,4(s1)
    80001c54:	01813083          	ld	ra,24(sp)
    80001c58:	01013403          	ld	s0,16(sp)
    80001c5c:	00813483          	ld	s1,8(sp)
    80001c60:	00013903          	ld	s2,0(sp)
    80001c64:	02010113          	addi	sp,sp,32
    80001c68:	00008067          	ret
        _thread* cur = _thread::running;
    80001c6c:	00007797          	auipc	a5,0x7
    80001c70:	08c7b783          	ld	a5,140(a5) # 80008cf8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001c74:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    80001c78:	00100593          	li	a1,1
    80001c7c:	00090513          	mv	a0,s2
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	89c080e7          	jalr	-1892(ra) # 8000151c <_ZN7_thread8setBlockEb>
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001c88:	01000513          	li	a0,16
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	a54080e7          	jalr	-1452(ra) # 800016e0 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001c94:	01253023          	sd	s2,0(a0)
    80001c98:	00053423          	sd	zero,8(a0)
        if (tail)
    80001c9c:	0104b783          	ld	a5,16(s1)
    80001ca0:	00078c63          	beqz	a5,80001cb8 <_ZN4_sem4waitEv+0x98>
        {
            tail->next = elem;
    80001ca4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001ca8:	00a4b823          	sd	a0,16(s1)
        thread_dispatch();
    80001cac:	fffff097          	auipc	ra,0xfffff
    80001cb0:	540080e7          	jalr	1344(ra) # 800011ec <_Z15thread_dispatchv>
    80001cb4:	f9dff06f          	j	80001c50 <_ZN4_sem4waitEv+0x30>
        } else
        {
            head = tail = elem;
    80001cb8:	00a4b823          	sd	a0,16(s1)
    80001cbc:	00a4b423          	sd	a0,8(s1)
    80001cc0:	fedff06f          	j	80001cac <_ZN4_sem4waitEv+0x8c>

0000000080001cc4 <_ZN4_sem6signalEv>:

int _sem::signal() {
    if(++val <= 0){
    80001cc4:	00052703          	lw	a4,0(a0)
    80001cc8:	0017071b          	addiw	a4,a4,1
    80001ccc:	0007069b          	sext.w	a3,a4
    80001cd0:	00e52023          	sw	a4,0(a0)
    80001cd4:	00d05663          	blez	a3,80001ce0 <_ZN4_sem6signalEv+0x1c>
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
}
    80001cd8:	00000513          	li	a0,0
    80001cdc:	00008067          	ret
    80001ce0:	00050793          	mv	a5,a0
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001ce4:	00853503          	ld	a0,8(a0)
    80001ce8:	fe0508e3          	beqz	a0,80001cd8 <_ZN4_sem6signalEv+0x14>
int _sem::signal() {
    80001cec:	fe010113          	addi	sp,sp,-32
    80001cf0:	00113c23          	sd	ra,24(sp)
    80001cf4:	00813823          	sd	s0,16(sp)
    80001cf8:	00913423          	sd	s1,8(sp)
    80001cfc:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    80001d00:	00853703          	ld	a4,8(a0)
    80001d04:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001d08:	04070463          	beqz	a4,80001d50 <_ZN4_sem6signalEv+0x8c>

        T *ret = elem->data;
    80001d0c:	00053483          	ld	s1,0(a0)
        delete elem;
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	a20080e7          	jalr	-1504(ra) # 80001730 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80001d18:	02048063          	beqz	s1,80001d38 <_ZN4_sem6signalEv+0x74>
            cur->setBlock(false);
    80001d1c:	00000593          	li	a1,0
    80001d20:	00048513          	mv	a0,s1
    80001d24:	fffff097          	auipc	ra,0xfffff
    80001d28:	7f8080e7          	jalr	2040(ra) # 8000151c <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80001d2c:	00048513          	mv	a0,s1
    80001d30:	00000097          	auipc	ra,0x0
    80001d34:	1b0080e7          	jalr	432(ra) # 80001ee0 <_ZN9Scheduler3putEP7_thread>
}
    80001d38:	00000513          	li	a0,0
    80001d3c:	01813083          	ld	ra,24(sp)
    80001d40:	01013403          	ld	s0,16(sp)
    80001d44:	00813483          	ld	s1,8(sp)
    80001d48:	02010113          	addi	sp,sp,32
    80001d4c:	00008067          	ret
        if (!head) { tail = 0; }
    80001d50:	0007b823          	sd	zero,16(a5)
    80001d54:	fb9ff06f          	j	80001d0c <_ZN4_sem6signalEv+0x48>

0000000080001d58 <_ZN4_sem5closeEv>:

int _sem::close() {
    80001d58:	fe010113          	addi	sp,sp,-32
    80001d5c:	00113c23          	sd	ra,24(sp)
    80001d60:	00813823          	sd	s0,16(sp)
    80001d64:	00913423          	sd	s1,8(sp)
    80001d68:	01213023          	sd	s2,0(sp)
    80001d6c:	02010413          	addi	s0,sp,32
    80001d70:	00050913          	mv	s2,a0
    int wait();
    int signal();
    int close();

    int value() const { return val; }
    void setWaitStatus(int s) { waitStatus = s;}
    80001d74:	fff00793          	li	a5,-1
    80001d78:	00f52223          	sw	a5,4(a0)
    80001d7c:	0340006f          	j	80001db0 <_ZN4_sem5closeEv+0x58>
    80001d80:	00093823          	sd	zero,16(s2)
        T *ret = elem->data;
    80001d84:	00053483          	ld	s1,0(a0)
        delete elem;
    80001d88:	00000097          	auipc	ra,0x0
    80001d8c:	9a8080e7          	jalr	-1624(ra) # 80001730 <_ZdlPv>
    this->setWaitStatus(-1);
    while(_thread* cur = blocked.removeFirst()){
    80001d90:	02048c63          	beqz	s1,80001dc8 <_ZN4_sem5closeEv+0x70>
        cur->setBlock(false);
    80001d94:	00000593          	li	a1,0
    80001d98:	00048513          	mv	a0,s1
    80001d9c:	fffff097          	auipc	ra,0xfffff
    80001da0:	780080e7          	jalr	1920(ra) # 8000151c <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    80001da4:	00048513          	mv	a0,s1
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	138080e7          	jalr	312(ra) # 80001ee0 <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80001db0:	00893503          	ld	a0,8(s2)
    80001db4:	00050a63          	beqz	a0,80001dc8 <_ZN4_sem5closeEv+0x70>
        head = head->next;
    80001db8:	00853783          	ld	a5,8(a0)
    80001dbc:	00f93423          	sd	a5,8(s2)
        if (!head) { tail = 0; }
    80001dc0:	fc0792e3          	bnez	a5,80001d84 <_ZN4_sem5closeEv+0x2c>
    80001dc4:	fbdff06f          	j	80001d80 <_ZN4_sem5closeEv+0x28>
    }
    delete this;
    80001dc8:	00090513          	mv	a0,s2
    80001dcc:	00000097          	auipc	ra,0x0
    80001dd0:	964080e7          	jalr	-1692(ra) # 80001730 <_ZdlPv>
    return 0;
}
    80001dd4:	00000513          	li	a0,0
    80001dd8:	01813083          	ld	ra,24(sp)
    80001ddc:	01013403          	ld	s0,16(sp)
    80001de0:	00813483          	ld	s1,8(sp)
    80001de4:	00013903          	ld	s2,0(sp)
    80001de8:	02010113          	addi	sp,sp,32
    80001dec:	00008067          	ret

0000000080001df0 <_ZN4_sem15createSemaphoreEj>:

_sem* _sem::createSemaphore(uint32 init) {
    80001df0:	fe010113          	addi	sp,sp,-32
    80001df4:	00113c23          	sd	ra,24(sp)
    80001df8:	00813823          	sd	s0,16(sp)
    80001dfc:	00913423          	sd	s1,8(sp)
    80001e00:	02010413          	addi	s0,sp,32
    80001e04:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    80001e08:	01800513          	li	a0,24
    80001e0c:	00000097          	auipc	ra,0x0
    80001e10:	8d4080e7          	jalr	-1836(ra) # 800016e0 <_Znwm>
    _sem(uint32 init = 1) : val(init), waitStatus(0) {}
    80001e14:	00952023          	sw	s1,0(a0)
    80001e18:	00052223          	sw	zero,4(a0)
    List() : head(0), tail(0) {}
    80001e1c:	00053423          	sd	zero,8(a0)
    80001e20:	00053823          	sd	zero,16(a0)
    return newSemaphore;
}
    80001e24:	01813083          	ld	ra,24(sp)
    80001e28:	01013403          	ld	s0,16(sp)
    80001e2c:	00813483          	ld	s1,8(sp)
    80001e30:	02010113          	addi	sp,sp,32
    80001e34:	00008067          	ret

0000000080001e38 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001e38:	ff010113          	addi	sp,sp,-16
    80001e3c:	00813423          	sd	s0,8(sp)
    80001e40:	01010413          	addi	s0,sp,16
    80001e44:	00100793          	li	a5,1
    80001e48:	00f50863          	beq	a0,a5,80001e58 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001e4c:	00813403          	ld	s0,8(sp)
    80001e50:	01010113          	addi	sp,sp,16
    80001e54:	00008067          	ret
    80001e58:	000107b7          	lui	a5,0x10
    80001e5c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001e60:	fef596e3          	bne	a1,a5,80001e4c <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001e64:	00007797          	auipc	a5,0x7
    80001e68:	f0478793          	addi	a5,a5,-252 # 80008d68 <_ZN9Scheduler16readyThreadQueueE>
    80001e6c:	0007b023          	sd	zero,0(a5)
    80001e70:	0007b423          	sd	zero,8(a5)
    80001e74:	fd9ff06f          	j	80001e4c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001e78 <_ZN9Scheduler3getEv>:
{
    80001e78:	fe010113          	addi	sp,sp,-32
    80001e7c:	00113c23          	sd	ra,24(sp)
    80001e80:	00813823          	sd	s0,16(sp)
    80001e84:	00913423          	sd	s1,8(sp)
    80001e88:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001e8c:	00007517          	auipc	a0,0x7
    80001e90:	edc53503          	ld	a0,-292(a0) # 80008d68 <_ZN9Scheduler16readyThreadQueueE>
    80001e94:	04050263          	beqz	a0,80001ed8 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001e98:	00853783          	ld	a5,8(a0)
    80001e9c:	00007717          	auipc	a4,0x7
    80001ea0:	ecf73623          	sd	a5,-308(a4) # 80008d68 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001ea4:	02078463          	beqz	a5,80001ecc <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001ea8:	00053483          	ld	s1,0(a0)
        delete elem;
    80001eac:	00000097          	auipc	ra,0x0
    80001eb0:	884080e7          	jalr	-1916(ra) # 80001730 <_ZdlPv>
}
    80001eb4:	00048513          	mv	a0,s1
    80001eb8:	01813083          	ld	ra,24(sp)
    80001ebc:	01013403          	ld	s0,16(sp)
    80001ec0:	00813483          	ld	s1,8(sp)
    80001ec4:	02010113          	addi	sp,sp,32
    80001ec8:	00008067          	ret
        if (!head) { tail = 0; }
    80001ecc:	00007797          	auipc	a5,0x7
    80001ed0:	ea07b223          	sd	zero,-348(a5) # 80008d70 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001ed4:	fd5ff06f          	j	80001ea8 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001ed8:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001edc:	fd9ff06f          	j	80001eb4 <_ZN9Scheduler3getEv+0x3c>

0000000080001ee0 <_ZN9Scheduler3putEP7_thread>:
{
    80001ee0:	fe010113          	addi	sp,sp,-32
    80001ee4:	00113c23          	sd	ra,24(sp)
    80001ee8:	00813823          	sd	s0,16(sp)
    80001eec:	00913423          	sd	s1,8(sp)
    80001ef0:	02010413          	addi	s0,sp,32
    80001ef4:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001ef8:	01000513          	li	a0,16
    80001efc:	fffff097          	auipc	ra,0xfffff
    80001f00:	7e4080e7          	jalr	2020(ra) # 800016e0 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001f04:	00953023          	sd	s1,0(a0)
    80001f08:	00053423          	sd	zero,8(a0)
        if (tail)
    80001f0c:	00007797          	auipc	a5,0x7
    80001f10:	e647b783          	ld	a5,-412(a5) # 80008d70 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001f14:	02078263          	beqz	a5,80001f38 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80001f18:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001f1c:	00007797          	auipc	a5,0x7
    80001f20:	e4a7ba23          	sd	a0,-428(a5) # 80008d70 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001f24:	01813083          	ld	ra,24(sp)
    80001f28:	01013403          	ld	s0,16(sp)
    80001f2c:	00813483          	ld	s1,8(sp)
    80001f30:	02010113          	addi	sp,sp,32
    80001f34:	00008067          	ret
            head = tail = elem;
    80001f38:	00007797          	auipc	a5,0x7
    80001f3c:	e3078793          	addi	a5,a5,-464 # 80008d68 <_ZN9Scheduler16readyThreadQueueE>
    80001f40:	00a7b423          	sd	a0,8(a5)
    80001f44:	00a7b023          	sd	a0,0(a5)
    80001f48:	fddff06f          	j	80001f24 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080001f4c <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80001f4c:	ff010113          	addi	sp,sp,-16
    80001f50:	00113423          	sd	ra,8(sp)
    80001f54:	00813023          	sd	s0,0(sp)
    80001f58:	01010413          	addi	s0,sp,16
    80001f5c:	000105b7          	lui	a1,0x10
    80001f60:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001f64:	00100513          	li	a0,1
    80001f68:	00000097          	auipc	ra,0x0
    80001f6c:	ed0080e7          	jalr	-304(ra) # 80001e38 <_Z41__static_initialization_and_destruction_0ii>
    80001f70:	00813083          	ld	ra,8(sp)
    80001f74:	00013403          	ld	s0,0(sp)
    80001f78:	01010113          	addi	sp,sp,16
    80001f7c:	00008067          	ret

0000000080001f80 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80001f80:	fe010113          	addi	sp,sp,-32
    80001f84:	00113c23          	sd	ra,24(sp)
    80001f88:	00813823          	sd	s0,16(sp)
    80001f8c:	00913423          	sd	s1,8(sp)
    80001f90:	01213023          	sd	s2,0(sp)
    80001f94:	02010413          	addi	s0,sp,32
    80001f98:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80001f9c:	00000913          	li	s2,0
    80001fa0:	00c0006f          	j	80001fac <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80001fa4:	fffff097          	auipc	ra,0xfffff
    80001fa8:	248080e7          	jalr	584(ra) # 800011ec <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80001fac:	fffff097          	auipc	ra,0xfffff
    80001fb0:	314080e7          	jalr	788(ra) # 800012c0 <_Z4getcv>
    80001fb4:	0005059b          	sext.w	a1,a0
    80001fb8:	01b00793          	li	a5,27
    80001fbc:	02f58a63          	beq	a1,a5,80001ff0 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80001fc0:	0084b503          	ld	a0,8(s1)
    80001fc4:	00002097          	auipc	ra,0x2
    80001fc8:	414080e7          	jalr	1044(ra) # 800043d8 <_ZN6Buffer3putEi>
        i++;
    80001fcc:	0019071b          	addiw	a4,s2,1
    80001fd0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80001fd4:	0004a683          	lw	a3,0(s1)
    80001fd8:	0026979b          	slliw	a5,a3,0x2
    80001fdc:	00d787bb          	addw	a5,a5,a3
    80001fe0:	0017979b          	slliw	a5,a5,0x1
    80001fe4:	02f767bb          	remw	a5,a4,a5
    80001fe8:	fc0792e3          	bnez	a5,80001fac <_ZL16producerKeyboardPv+0x2c>
    80001fec:	fb9ff06f          	j	80001fa4 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80001ff0:	00100793          	li	a5,1
    80001ff4:	00007717          	auipc	a4,0x7
    80001ff8:	d8f72223          	sw	a5,-636(a4) # 80008d78 <_ZL9threadEnd>
    data->buffer->put('!');
    80001ffc:	02100593          	li	a1,33
    80002000:	0084b503          	ld	a0,8(s1)
    80002004:	00002097          	auipc	ra,0x2
    80002008:	3d4080e7          	jalr	980(ra) # 800043d8 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    8000200c:	0104b503          	ld	a0,16(s1)
    80002010:	fffff097          	auipc	ra,0xfffff
    80002014:	284080e7          	jalr	644(ra) # 80001294 <_Z10sem_signalP4_sem>
}
    80002018:	01813083          	ld	ra,24(sp)
    8000201c:	01013403          	ld	s0,16(sp)
    80002020:	00813483          	ld	s1,8(sp)
    80002024:	00013903          	ld	s2,0(sp)
    80002028:	02010113          	addi	sp,sp,32
    8000202c:	00008067          	ret

0000000080002030 <_ZL8producerPv>:

static void producer(void *arg) {
    80002030:	fe010113          	addi	sp,sp,-32
    80002034:	00113c23          	sd	ra,24(sp)
    80002038:	00813823          	sd	s0,16(sp)
    8000203c:	00913423          	sd	s1,8(sp)
    80002040:	01213023          	sd	s2,0(sp)
    80002044:	02010413          	addi	s0,sp,32
    80002048:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000204c:	00000913          	li	s2,0
    80002050:	00c0006f          	j	8000205c <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002054:	fffff097          	auipc	ra,0xfffff
    80002058:	198080e7          	jalr	408(ra) # 800011ec <_Z15thread_dispatchv>
    while (!threadEnd) {
    8000205c:	00007797          	auipc	a5,0x7
    80002060:	d1c7a783          	lw	a5,-740(a5) # 80008d78 <_ZL9threadEnd>
    80002064:	02079e63          	bnez	a5,800020a0 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002068:	0004a583          	lw	a1,0(s1)
    8000206c:	0305859b          	addiw	a1,a1,48
    80002070:	0084b503          	ld	a0,8(s1)
    80002074:	00002097          	auipc	ra,0x2
    80002078:	364080e7          	jalr	868(ra) # 800043d8 <_ZN6Buffer3putEi>
        i++;
    8000207c:	0019071b          	addiw	a4,s2,1
    80002080:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002084:	0004a683          	lw	a3,0(s1)
    80002088:	0026979b          	slliw	a5,a3,0x2
    8000208c:	00d787bb          	addw	a5,a5,a3
    80002090:	0017979b          	slliw	a5,a5,0x1
    80002094:	02f767bb          	remw	a5,a4,a5
    80002098:	fc0792e3          	bnez	a5,8000205c <_ZL8producerPv+0x2c>
    8000209c:	fb9ff06f          	j	80002054 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800020a0:	0104b503          	ld	a0,16(s1)
    800020a4:	fffff097          	auipc	ra,0xfffff
    800020a8:	1f0080e7          	jalr	496(ra) # 80001294 <_Z10sem_signalP4_sem>
}
    800020ac:	01813083          	ld	ra,24(sp)
    800020b0:	01013403          	ld	s0,16(sp)
    800020b4:	00813483          	ld	s1,8(sp)
    800020b8:	00013903          	ld	s2,0(sp)
    800020bc:	02010113          	addi	sp,sp,32
    800020c0:	00008067          	ret

00000000800020c4 <_ZL8consumerPv>:

static void consumer(void *arg) {
    800020c4:	fd010113          	addi	sp,sp,-48
    800020c8:	02113423          	sd	ra,40(sp)
    800020cc:	02813023          	sd	s0,32(sp)
    800020d0:	00913c23          	sd	s1,24(sp)
    800020d4:	01213823          	sd	s2,16(sp)
    800020d8:	01313423          	sd	s3,8(sp)
    800020dc:	03010413          	addi	s0,sp,48
    800020e0:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800020e4:	00000993          	li	s3,0
    800020e8:	01c0006f          	j	80002104 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	100080e7          	jalr	256(ra) # 800011ec <_Z15thread_dispatchv>
    800020f4:	0500006f          	j	80002144 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800020f8:	00a00513          	li	a0,10
    800020fc:	fffff097          	auipc	ra,0xfffff
    80002100:	1ec080e7          	jalr	492(ra) # 800012e8 <_Z4putcc>
    while (!threadEnd) {
    80002104:	00007797          	auipc	a5,0x7
    80002108:	c747a783          	lw	a5,-908(a5) # 80008d78 <_ZL9threadEnd>
    8000210c:	06079063          	bnez	a5,8000216c <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002110:	00893503          	ld	a0,8(s2)
    80002114:	00002097          	auipc	ra,0x2
    80002118:	354080e7          	jalr	852(ra) # 80004468 <_ZN6Buffer3getEv>
        i++;
    8000211c:	0019849b          	addiw	s1,s3,1
    80002120:	0004899b          	sext.w	s3,s1
        putc(key);
    80002124:	0ff57513          	andi	a0,a0,255
    80002128:	fffff097          	auipc	ra,0xfffff
    8000212c:	1c0080e7          	jalr	448(ra) # 800012e8 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002130:	00092703          	lw	a4,0(s2)
    80002134:	0027179b          	slliw	a5,a4,0x2
    80002138:	00e787bb          	addw	a5,a5,a4
    8000213c:	02f4e7bb          	remw	a5,s1,a5
    80002140:	fa0786e3          	beqz	a5,800020ec <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80002144:	05000793          	li	a5,80
    80002148:	02f4e4bb          	remw	s1,s1,a5
    8000214c:	fa049ce3          	bnez	s1,80002104 <_ZL8consumerPv+0x40>
    80002150:	fa9ff06f          	j	800020f8 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002154:	00893503          	ld	a0,8(s2)
    80002158:	00002097          	auipc	ra,0x2
    8000215c:	310080e7          	jalr	784(ra) # 80004468 <_ZN6Buffer3getEv>
        putc(key);
    80002160:	0ff57513          	andi	a0,a0,255
    80002164:	fffff097          	auipc	ra,0xfffff
    80002168:	184080e7          	jalr	388(ra) # 800012e8 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    8000216c:	00893503          	ld	a0,8(s2)
    80002170:	00002097          	auipc	ra,0x2
    80002174:	384080e7          	jalr	900(ra) # 800044f4 <_ZN6Buffer6getCntEv>
    80002178:	fca04ee3          	bgtz	a0,80002154 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    8000217c:	01093503          	ld	a0,16(s2)
    80002180:	fffff097          	auipc	ra,0xfffff
    80002184:	114080e7          	jalr	276(ra) # 80001294 <_Z10sem_signalP4_sem>
}
    80002188:	02813083          	ld	ra,40(sp)
    8000218c:	02013403          	ld	s0,32(sp)
    80002190:	01813483          	ld	s1,24(sp)
    80002194:	01013903          	ld	s2,16(sp)
    80002198:	00813983          	ld	s3,8(sp)
    8000219c:	03010113          	addi	sp,sp,48
    800021a0:	00008067          	ret

00000000800021a4 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800021a4:	f9010113          	addi	sp,sp,-112
    800021a8:	06113423          	sd	ra,104(sp)
    800021ac:	06813023          	sd	s0,96(sp)
    800021b0:	04913c23          	sd	s1,88(sp)
    800021b4:	05213823          	sd	s2,80(sp)
    800021b8:	05313423          	sd	s3,72(sp)
    800021bc:	05413023          	sd	s4,64(sp)
    800021c0:	03513c23          	sd	s5,56(sp)
    800021c4:	03613823          	sd	s6,48(sp)
    800021c8:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800021cc:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800021d0:	00005517          	auipc	a0,0x5
    800021d4:	0c850513          	addi	a0,a0,200 # 80007298 <kvmincrease+0x838>
    800021d8:	00002097          	auipc	ra,0x2
    800021dc:	a9c080e7          	jalr	-1380(ra) # 80003c74 <_Z11printStringPKc>
    getString(input, 30);
    800021e0:	01e00593          	li	a1,30
    800021e4:	fa040493          	addi	s1,s0,-96
    800021e8:	00048513          	mv	a0,s1
    800021ec:	00002097          	auipc	ra,0x2
    800021f0:	b10080e7          	jalr	-1264(ra) # 80003cfc <_Z9getStringPci>
    threadNum = stringToInt(input);
    800021f4:	00048513          	mv	a0,s1
    800021f8:	00002097          	auipc	ra,0x2
    800021fc:	bdc080e7          	jalr	-1060(ra) # 80003dd4 <_Z11stringToIntPKc>
    80002200:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002204:	00005517          	auipc	a0,0x5
    80002208:	0b450513          	addi	a0,a0,180 # 800072b8 <kvmincrease+0x858>
    8000220c:	00002097          	auipc	ra,0x2
    80002210:	a68080e7          	jalr	-1432(ra) # 80003c74 <_Z11printStringPKc>
    getString(input, 30);
    80002214:	01e00593          	li	a1,30
    80002218:	00048513          	mv	a0,s1
    8000221c:	00002097          	auipc	ra,0x2
    80002220:	ae0080e7          	jalr	-1312(ra) # 80003cfc <_Z9getStringPci>
    n = stringToInt(input);
    80002224:	00048513          	mv	a0,s1
    80002228:	00002097          	auipc	ra,0x2
    8000222c:	bac080e7          	jalr	-1108(ra) # 80003dd4 <_Z11stringToIntPKc>
    80002230:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002234:	00005517          	auipc	a0,0x5
    80002238:	0a450513          	addi	a0,a0,164 # 800072d8 <kvmincrease+0x878>
    8000223c:	00002097          	auipc	ra,0x2
    80002240:	a38080e7          	jalr	-1480(ra) # 80003c74 <_Z11printStringPKc>
    80002244:	00000613          	li	a2,0
    80002248:	00a00593          	li	a1,10
    8000224c:	00090513          	mv	a0,s2
    80002250:	00002097          	auipc	ra,0x2
    80002254:	bd4080e7          	jalr	-1068(ra) # 80003e24 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002258:	00005517          	auipc	a0,0x5
    8000225c:	09850513          	addi	a0,a0,152 # 800072f0 <kvmincrease+0x890>
    80002260:	00002097          	auipc	ra,0x2
    80002264:	a14080e7          	jalr	-1516(ra) # 80003c74 <_Z11printStringPKc>
    80002268:	00000613          	li	a2,0
    8000226c:	00a00593          	li	a1,10
    80002270:	00048513          	mv	a0,s1
    80002274:	00002097          	auipc	ra,0x2
    80002278:	bb0080e7          	jalr	-1104(ra) # 80003e24 <_Z8printIntiii>
    printString(".\n");
    8000227c:	00005517          	auipc	a0,0x5
    80002280:	08c50513          	addi	a0,a0,140 # 80007308 <kvmincrease+0x8a8>
    80002284:	00002097          	auipc	ra,0x2
    80002288:	9f0080e7          	jalr	-1552(ra) # 80003c74 <_Z11printStringPKc>
    if(threadNum > n) {
    8000228c:	0324c463          	blt	s1,s2,800022b4 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80002290:	03205c63          	blez	s2,800022c8 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002294:	03800513          	li	a0,56
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	448080e7          	jalr	1096(ra) # 800016e0 <_Znwm>
    800022a0:	00050a13          	mv	s4,a0
    800022a4:	00048593          	mv	a1,s1
    800022a8:	00002097          	auipc	ra,0x2
    800022ac:	094080e7          	jalr	148(ra) # 8000433c <_ZN6BufferC1Ei>
    800022b0:	0300006f          	j	800022e0 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800022b4:	00005517          	auipc	a0,0x5
    800022b8:	05c50513          	addi	a0,a0,92 # 80007310 <kvmincrease+0x8b0>
    800022bc:	00002097          	auipc	ra,0x2
    800022c0:	9b8080e7          	jalr	-1608(ra) # 80003c74 <_Z11printStringPKc>
        return;
    800022c4:	0140006f          	j	800022d8 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800022c8:	00005517          	auipc	a0,0x5
    800022cc:	08850513          	addi	a0,a0,136 # 80007350 <kvmincrease+0x8f0>
    800022d0:	00002097          	auipc	ra,0x2
    800022d4:	9a4080e7          	jalr	-1628(ra) # 80003c74 <_Z11printStringPKc>
        return;
    800022d8:	000b0113          	mv	sp,s6
    800022dc:	1500006f          	j	8000242c <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800022e0:	00000593          	li	a1,0
    800022e4:	00007517          	auipc	a0,0x7
    800022e8:	a9c50513          	addi	a0,a0,-1380 # 80008d80 <_ZL10waitForAll>
    800022ec:	fffff097          	auipc	ra,0xfffff
    800022f0:	f24080e7          	jalr	-220(ra) # 80001210 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800022f4:	00391793          	slli	a5,s2,0x3
    800022f8:	00f78793          	addi	a5,a5,15
    800022fc:	ff07f793          	andi	a5,a5,-16
    80002300:	40f10133          	sub	sp,sp,a5
    80002304:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002308:	0019071b          	addiw	a4,s2,1
    8000230c:	00171793          	slli	a5,a4,0x1
    80002310:	00e787b3          	add	a5,a5,a4
    80002314:	00379793          	slli	a5,a5,0x3
    80002318:	00f78793          	addi	a5,a5,15
    8000231c:	ff07f793          	andi	a5,a5,-16
    80002320:	40f10133          	sub	sp,sp,a5
    80002324:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002328:	00191613          	slli	a2,s2,0x1
    8000232c:	012607b3          	add	a5,a2,s2
    80002330:	00379793          	slli	a5,a5,0x3
    80002334:	00f987b3          	add	a5,s3,a5
    80002338:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    8000233c:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002340:	00007717          	auipc	a4,0x7
    80002344:	a4073703          	ld	a4,-1472(a4) # 80008d80 <_ZL10waitForAll>
    80002348:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    8000234c:	00078613          	mv	a2,a5
    80002350:	00000597          	auipc	a1,0x0
    80002354:	d7458593          	addi	a1,a1,-652 # 800020c4 <_ZL8consumerPv>
    80002358:	f9840513          	addi	a0,s0,-104
    8000235c:	fffff097          	auipc	ra,0xfffff
    80002360:	e38080e7          	jalr	-456(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002364:	00000493          	li	s1,0
    80002368:	0280006f          	j	80002390 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    8000236c:	00000597          	auipc	a1,0x0
    80002370:	c1458593          	addi	a1,a1,-1004 # 80001f80 <_ZL16producerKeyboardPv>
                      data + i);
    80002374:	00179613          	slli	a2,a5,0x1
    80002378:	00f60633          	add	a2,a2,a5
    8000237c:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80002380:	00c98633          	add	a2,s3,a2
    80002384:	fffff097          	auipc	ra,0xfffff
    80002388:	e10080e7          	jalr	-496(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    8000238c:	0014849b          	addiw	s1,s1,1
    80002390:	0524d263          	bge	s1,s2,800023d4 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002394:	00149793          	slli	a5,s1,0x1
    80002398:	009787b3          	add	a5,a5,s1
    8000239c:	00379793          	slli	a5,a5,0x3
    800023a0:	00f987b3          	add	a5,s3,a5
    800023a4:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800023a8:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    800023ac:	00007717          	auipc	a4,0x7
    800023b0:	9d473703          	ld	a4,-1580(a4) # 80008d80 <_ZL10waitForAll>
    800023b4:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    800023b8:	00048793          	mv	a5,s1
    800023bc:	00349513          	slli	a0,s1,0x3
    800023c0:	00aa8533          	add	a0,s5,a0
    800023c4:	fa9054e3          	blez	s1,8000236c <_Z22producerConsumer_C_APIv+0x1c8>
    800023c8:	00000597          	auipc	a1,0x0
    800023cc:	c6858593          	addi	a1,a1,-920 # 80002030 <_ZL8producerPv>
    800023d0:	fa5ff06f          	j	80002374 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    800023d4:	fffff097          	auipc	ra,0xfffff
    800023d8:	e18080e7          	jalr	-488(ra) # 800011ec <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800023dc:	00000493          	li	s1,0
    800023e0:	00994e63          	blt	s2,s1,800023fc <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    800023e4:	00007517          	auipc	a0,0x7
    800023e8:	99c53503          	ld	a0,-1636(a0) # 80008d80 <_ZL10waitForAll>
    800023ec:	fffff097          	auipc	ra,0xfffff
    800023f0:	e7c080e7          	jalr	-388(ra) # 80001268 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800023f4:	0014849b          	addiw	s1,s1,1
    800023f8:	fe9ff06f          	j	800023e0 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800023fc:	00007517          	auipc	a0,0x7
    80002400:	98453503          	ld	a0,-1660(a0) # 80008d80 <_ZL10waitForAll>
    80002404:	fffff097          	auipc	ra,0xfffff
    80002408:	e38080e7          	jalr	-456(ra) # 8000123c <_Z9sem_closeP4_sem>
    delete buffer;
    8000240c:	000a0e63          	beqz	s4,80002428 <_Z22producerConsumer_C_APIv+0x284>
    80002410:	000a0513          	mv	a0,s4
    80002414:	00002097          	auipc	ra,0x2
    80002418:	168080e7          	jalr	360(ra) # 8000457c <_ZN6BufferD1Ev>
    8000241c:	000a0513          	mv	a0,s4
    80002420:	fffff097          	auipc	ra,0xfffff
    80002424:	310080e7          	jalr	784(ra) # 80001730 <_ZdlPv>
    80002428:	000b0113          	mv	sp,s6

}
    8000242c:	f9040113          	addi	sp,s0,-112
    80002430:	06813083          	ld	ra,104(sp)
    80002434:	06013403          	ld	s0,96(sp)
    80002438:	05813483          	ld	s1,88(sp)
    8000243c:	05013903          	ld	s2,80(sp)
    80002440:	04813983          	ld	s3,72(sp)
    80002444:	04013a03          	ld	s4,64(sp)
    80002448:	03813a83          	ld	s5,56(sp)
    8000244c:	03013b03          	ld	s6,48(sp)
    80002450:	07010113          	addi	sp,sp,112
    80002454:	00008067          	ret
    80002458:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    8000245c:	000a0513          	mv	a0,s4
    80002460:	fffff097          	auipc	ra,0xfffff
    80002464:	2d0080e7          	jalr	720(ra) # 80001730 <_ZdlPv>
    80002468:	00048513          	mv	a0,s1
    8000246c:	00008097          	auipc	ra,0x8
    80002470:	a0c080e7          	jalr	-1524(ra) # 80009e78 <_Unwind_Resume>

0000000080002474 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002474:	fe010113          	addi	sp,sp,-32
    80002478:	00113c23          	sd	ra,24(sp)
    8000247c:	00813823          	sd	s0,16(sp)
    80002480:	00913423          	sd	s1,8(sp)
    80002484:	01213023          	sd	s2,0(sp)
    80002488:	02010413          	addi	s0,sp,32
    8000248c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002490:	00100793          	li	a5,1
    80002494:	02a7f863          	bgeu	a5,a0,800024c4 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002498:	00a00793          	li	a5,10
    8000249c:	02f577b3          	remu	a5,a0,a5
    800024a0:	02078e63          	beqz	a5,800024dc <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800024a4:	fff48513          	addi	a0,s1,-1
    800024a8:	00000097          	auipc	ra,0x0
    800024ac:	fcc080e7          	jalr	-52(ra) # 80002474 <_ZL9fibonaccim>
    800024b0:	00050913          	mv	s2,a0
    800024b4:	ffe48513          	addi	a0,s1,-2
    800024b8:	00000097          	auipc	ra,0x0
    800024bc:	fbc080e7          	jalr	-68(ra) # 80002474 <_ZL9fibonaccim>
    800024c0:	00a90533          	add	a0,s2,a0
}
    800024c4:	01813083          	ld	ra,24(sp)
    800024c8:	01013403          	ld	s0,16(sp)
    800024cc:	00813483          	ld	s1,8(sp)
    800024d0:	00013903          	ld	s2,0(sp)
    800024d4:	02010113          	addi	sp,sp,32
    800024d8:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800024dc:	fffff097          	auipc	ra,0xfffff
    800024e0:	d10080e7          	jalr	-752(ra) # 800011ec <_Z15thread_dispatchv>
    800024e4:	fc1ff06f          	j	800024a4 <_ZL9fibonaccim+0x30>

00000000800024e8 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800024e8:	fe010113          	addi	sp,sp,-32
    800024ec:	00113c23          	sd	ra,24(sp)
    800024f0:	00813823          	sd	s0,16(sp)
    800024f4:	00913423          	sd	s1,8(sp)
    800024f8:	01213023          	sd	s2,0(sp)
    800024fc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002500:	00000913          	li	s2,0
    80002504:	0380006f          	j	8000253c <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002508:	fffff097          	auipc	ra,0xfffff
    8000250c:	ce4080e7          	jalr	-796(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002510:	00148493          	addi	s1,s1,1
    80002514:	000027b7          	lui	a5,0x2
    80002518:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000251c:	0097ee63          	bltu	a5,s1,80002538 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002520:	00000713          	li	a4,0
    80002524:	000077b7          	lui	a5,0x7
    80002528:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000252c:	fce7eee3          	bltu	a5,a4,80002508 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80002530:	00170713          	addi	a4,a4,1
    80002534:	ff1ff06f          	j	80002524 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002538:	00190913          	addi	s2,s2,1
    8000253c:	00900793          	li	a5,9
    80002540:	0527e063          	bltu	a5,s2,80002580 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002544:	00005517          	auipc	a0,0x5
    80002548:	e3c50513          	addi	a0,a0,-452 # 80007380 <kvmincrease+0x920>
    8000254c:	00001097          	auipc	ra,0x1
    80002550:	728080e7          	jalr	1832(ra) # 80003c74 <_Z11printStringPKc>
    80002554:	00000613          	li	a2,0
    80002558:	00a00593          	li	a1,10
    8000255c:	0009051b          	sext.w	a0,s2
    80002560:	00002097          	auipc	ra,0x2
    80002564:	8c4080e7          	jalr	-1852(ra) # 80003e24 <_Z8printIntiii>
    80002568:	00005517          	auipc	a0,0x5
    8000256c:	c0850513          	addi	a0,a0,-1016 # 80007170 <kvmincrease+0x710>
    80002570:	00001097          	auipc	ra,0x1
    80002574:	704080e7          	jalr	1796(ra) # 80003c74 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002578:	00000493          	li	s1,0
    8000257c:	f99ff06f          	j	80002514 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002580:	00005517          	auipc	a0,0x5
    80002584:	e0850513          	addi	a0,a0,-504 # 80007388 <kvmincrease+0x928>
    80002588:	00001097          	auipc	ra,0x1
    8000258c:	6ec080e7          	jalr	1772(ra) # 80003c74 <_Z11printStringPKc>
    finishedA = true;
    80002590:	00100793          	li	a5,1
    80002594:	00006717          	auipc	a4,0x6
    80002598:	7ef70a23          	sb	a5,2036(a4) # 80008d88 <_ZL9finishedA>
}
    8000259c:	01813083          	ld	ra,24(sp)
    800025a0:	01013403          	ld	s0,16(sp)
    800025a4:	00813483          	ld	s1,8(sp)
    800025a8:	00013903          	ld	s2,0(sp)
    800025ac:	02010113          	addi	sp,sp,32
    800025b0:	00008067          	ret

00000000800025b4 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800025b4:	fe010113          	addi	sp,sp,-32
    800025b8:	00113c23          	sd	ra,24(sp)
    800025bc:	00813823          	sd	s0,16(sp)
    800025c0:	00913423          	sd	s1,8(sp)
    800025c4:	01213023          	sd	s2,0(sp)
    800025c8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800025cc:	00000913          	li	s2,0
    800025d0:	0380006f          	j	80002608 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	c18080e7          	jalr	-1000(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800025dc:	00148493          	addi	s1,s1,1
    800025e0:	000027b7          	lui	a5,0x2
    800025e4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800025e8:	0097ee63          	bltu	a5,s1,80002604 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800025ec:	00000713          	li	a4,0
    800025f0:	000077b7          	lui	a5,0x7
    800025f4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800025f8:	fce7eee3          	bltu	a5,a4,800025d4 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800025fc:	00170713          	addi	a4,a4,1
    80002600:	ff1ff06f          	j	800025f0 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002604:	00190913          	addi	s2,s2,1
    80002608:	00f00793          	li	a5,15
    8000260c:	0527e063          	bltu	a5,s2,8000264c <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002610:	00005517          	auipc	a0,0x5
    80002614:	d8850513          	addi	a0,a0,-632 # 80007398 <kvmincrease+0x938>
    80002618:	00001097          	auipc	ra,0x1
    8000261c:	65c080e7          	jalr	1628(ra) # 80003c74 <_Z11printStringPKc>
    80002620:	00000613          	li	a2,0
    80002624:	00a00593          	li	a1,10
    80002628:	0009051b          	sext.w	a0,s2
    8000262c:	00001097          	auipc	ra,0x1
    80002630:	7f8080e7          	jalr	2040(ra) # 80003e24 <_Z8printIntiii>
    80002634:	00005517          	auipc	a0,0x5
    80002638:	b3c50513          	addi	a0,a0,-1220 # 80007170 <kvmincrease+0x710>
    8000263c:	00001097          	auipc	ra,0x1
    80002640:	638080e7          	jalr	1592(ra) # 80003c74 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002644:	00000493          	li	s1,0
    80002648:	f99ff06f          	j	800025e0 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    8000264c:	00005517          	auipc	a0,0x5
    80002650:	d5450513          	addi	a0,a0,-684 # 800073a0 <kvmincrease+0x940>
    80002654:	00001097          	auipc	ra,0x1
    80002658:	620080e7          	jalr	1568(ra) # 80003c74 <_Z11printStringPKc>
    finishedB = true;
    8000265c:	00100793          	li	a5,1
    80002660:	00006717          	auipc	a4,0x6
    80002664:	72f704a3          	sb	a5,1833(a4) # 80008d89 <_ZL9finishedB>
    thread_dispatch();
    80002668:	fffff097          	auipc	ra,0xfffff
    8000266c:	b84080e7          	jalr	-1148(ra) # 800011ec <_Z15thread_dispatchv>
}
    80002670:	01813083          	ld	ra,24(sp)
    80002674:	01013403          	ld	s0,16(sp)
    80002678:	00813483          	ld	s1,8(sp)
    8000267c:	00013903          	ld	s2,0(sp)
    80002680:	02010113          	addi	sp,sp,32
    80002684:	00008067          	ret

0000000080002688 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002688:	fe010113          	addi	sp,sp,-32
    8000268c:	00113c23          	sd	ra,24(sp)
    80002690:	00813823          	sd	s0,16(sp)
    80002694:	00913423          	sd	s1,8(sp)
    80002698:	01213023          	sd	s2,0(sp)
    8000269c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800026a0:	00000493          	li	s1,0
    800026a4:	0400006f          	j	800026e4 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800026a8:	00005517          	auipc	a0,0x5
    800026ac:	d0850513          	addi	a0,a0,-760 # 800073b0 <kvmincrease+0x950>
    800026b0:	00001097          	auipc	ra,0x1
    800026b4:	5c4080e7          	jalr	1476(ra) # 80003c74 <_Z11printStringPKc>
    800026b8:	00000613          	li	a2,0
    800026bc:	00a00593          	li	a1,10
    800026c0:	00048513          	mv	a0,s1
    800026c4:	00001097          	auipc	ra,0x1
    800026c8:	760080e7          	jalr	1888(ra) # 80003e24 <_Z8printIntiii>
    800026cc:	00005517          	auipc	a0,0x5
    800026d0:	aa450513          	addi	a0,a0,-1372 # 80007170 <kvmincrease+0x710>
    800026d4:	00001097          	auipc	ra,0x1
    800026d8:	5a0080e7          	jalr	1440(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800026dc:	0014849b          	addiw	s1,s1,1
    800026e0:	0ff4f493          	andi	s1,s1,255
    800026e4:	00200793          	li	a5,2
    800026e8:	fc97f0e3          	bgeu	a5,s1,800026a8 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800026ec:	00005517          	auipc	a0,0x5
    800026f0:	ccc50513          	addi	a0,a0,-820 # 800073b8 <kvmincrease+0x958>
    800026f4:	00001097          	auipc	ra,0x1
    800026f8:	580080e7          	jalr	1408(ra) # 80003c74 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800026fc:	00700313          	li	t1,7
    thread_dispatch();
    80002700:	fffff097          	auipc	ra,0xfffff
    80002704:	aec080e7          	jalr	-1300(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002708:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    8000270c:	00005517          	auipc	a0,0x5
    80002710:	cbc50513          	addi	a0,a0,-836 # 800073c8 <kvmincrease+0x968>
    80002714:	00001097          	auipc	ra,0x1
    80002718:	560080e7          	jalr	1376(ra) # 80003c74 <_Z11printStringPKc>
    8000271c:	00000613          	li	a2,0
    80002720:	00a00593          	li	a1,10
    80002724:	0009051b          	sext.w	a0,s2
    80002728:	00001097          	auipc	ra,0x1
    8000272c:	6fc080e7          	jalr	1788(ra) # 80003e24 <_Z8printIntiii>
    80002730:	00005517          	auipc	a0,0x5
    80002734:	a4050513          	addi	a0,a0,-1472 # 80007170 <kvmincrease+0x710>
    80002738:	00001097          	auipc	ra,0x1
    8000273c:	53c080e7          	jalr	1340(ra) # 80003c74 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002740:	00c00513          	li	a0,12
    80002744:	00000097          	auipc	ra,0x0
    80002748:	d30080e7          	jalr	-720(ra) # 80002474 <_ZL9fibonaccim>
    8000274c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002750:	00005517          	auipc	a0,0x5
    80002754:	c8050513          	addi	a0,a0,-896 # 800073d0 <kvmincrease+0x970>
    80002758:	00001097          	auipc	ra,0x1
    8000275c:	51c080e7          	jalr	1308(ra) # 80003c74 <_Z11printStringPKc>
    80002760:	00000613          	li	a2,0
    80002764:	00a00593          	li	a1,10
    80002768:	0009051b          	sext.w	a0,s2
    8000276c:	00001097          	auipc	ra,0x1
    80002770:	6b8080e7          	jalr	1720(ra) # 80003e24 <_Z8printIntiii>
    80002774:	00005517          	auipc	a0,0x5
    80002778:	9fc50513          	addi	a0,a0,-1540 # 80007170 <kvmincrease+0x710>
    8000277c:	00001097          	auipc	ra,0x1
    80002780:	4f8080e7          	jalr	1272(ra) # 80003c74 <_Z11printStringPKc>
    80002784:	0400006f          	j	800027c4 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002788:	00005517          	auipc	a0,0x5
    8000278c:	c2850513          	addi	a0,a0,-984 # 800073b0 <kvmincrease+0x950>
    80002790:	00001097          	auipc	ra,0x1
    80002794:	4e4080e7          	jalr	1252(ra) # 80003c74 <_Z11printStringPKc>
    80002798:	00000613          	li	a2,0
    8000279c:	00a00593          	li	a1,10
    800027a0:	00048513          	mv	a0,s1
    800027a4:	00001097          	auipc	ra,0x1
    800027a8:	680080e7          	jalr	1664(ra) # 80003e24 <_Z8printIntiii>
    800027ac:	00005517          	auipc	a0,0x5
    800027b0:	9c450513          	addi	a0,a0,-1596 # 80007170 <kvmincrease+0x710>
    800027b4:	00001097          	auipc	ra,0x1
    800027b8:	4c0080e7          	jalr	1216(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800027bc:	0014849b          	addiw	s1,s1,1
    800027c0:	0ff4f493          	andi	s1,s1,255
    800027c4:	00500793          	li	a5,5
    800027c8:	fc97f0e3          	bgeu	a5,s1,80002788 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    800027cc:	00005517          	auipc	a0,0x5
    800027d0:	bbc50513          	addi	a0,a0,-1092 # 80007388 <kvmincrease+0x928>
    800027d4:	00001097          	auipc	ra,0x1
    800027d8:	4a0080e7          	jalr	1184(ra) # 80003c74 <_Z11printStringPKc>
    finishedC = true;
    800027dc:	00100793          	li	a5,1
    800027e0:	00006717          	auipc	a4,0x6
    800027e4:	5af70523          	sb	a5,1450(a4) # 80008d8a <_ZL9finishedC>
    thread_dispatch();
    800027e8:	fffff097          	auipc	ra,0xfffff
    800027ec:	a04080e7          	jalr	-1532(ra) # 800011ec <_Z15thread_dispatchv>
}
    800027f0:	01813083          	ld	ra,24(sp)
    800027f4:	01013403          	ld	s0,16(sp)
    800027f8:	00813483          	ld	s1,8(sp)
    800027fc:	00013903          	ld	s2,0(sp)
    80002800:	02010113          	addi	sp,sp,32
    80002804:	00008067          	ret

0000000080002808 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002808:	fe010113          	addi	sp,sp,-32
    8000280c:	00113c23          	sd	ra,24(sp)
    80002810:	00813823          	sd	s0,16(sp)
    80002814:	00913423          	sd	s1,8(sp)
    80002818:	01213023          	sd	s2,0(sp)
    8000281c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002820:	00a00493          	li	s1,10
    80002824:	0400006f          	j	80002864 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002828:	00005517          	auipc	a0,0x5
    8000282c:	bb850513          	addi	a0,a0,-1096 # 800073e0 <kvmincrease+0x980>
    80002830:	00001097          	auipc	ra,0x1
    80002834:	444080e7          	jalr	1092(ra) # 80003c74 <_Z11printStringPKc>
    80002838:	00000613          	li	a2,0
    8000283c:	00a00593          	li	a1,10
    80002840:	00048513          	mv	a0,s1
    80002844:	00001097          	auipc	ra,0x1
    80002848:	5e0080e7          	jalr	1504(ra) # 80003e24 <_Z8printIntiii>
    8000284c:	00005517          	auipc	a0,0x5
    80002850:	92450513          	addi	a0,a0,-1756 # 80007170 <kvmincrease+0x710>
    80002854:	00001097          	auipc	ra,0x1
    80002858:	420080e7          	jalr	1056(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 13; i++) {
    8000285c:	0014849b          	addiw	s1,s1,1
    80002860:	0ff4f493          	andi	s1,s1,255
    80002864:	00c00793          	li	a5,12
    80002868:	fc97f0e3          	bgeu	a5,s1,80002828 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    8000286c:	00005517          	auipc	a0,0x5
    80002870:	b7c50513          	addi	a0,a0,-1156 # 800073e8 <kvmincrease+0x988>
    80002874:	00001097          	auipc	ra,0x1
    80002878:	400080e7          	jalr	1024(ra) # 80003c74 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000287c:	00500313          	li	t1,5
    thread_dispatch();
    80002880:	fffff097          	auipc	ra,0xfffff
    80002884:	96c080e7          	jalr	-1684(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002888:	01000513          	li	a0,16
    8000288c:	00000097          	auipc	ra,0x0
    80002890:	be8080e7          	jalr	-1048(ra) # 80002474 <_ZL9fibonaccim>
    80002894:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002898:	00005517          	auipc	a0,0x5
    8000289c:	b6050513          	addi	a0,a0,-1184 # 800073f8 <kvmincrease+0x998>
    800028a0:	00001097          	auipc	ra,0x1
    800028a4:	3d4080e7          	jalr	980(ra) # 80003c74 <_Z11printStringPKc>
    800028a8:	00000613          	li	a2,0
    800028ac:	00a00593          	li	a1,10
    800028b0:	0009051b          	sext.w	a0,s2
    800028b4:	00001097          	auipc	ra,0x1
    800028b8:	570080e7          	jalr	1392(ra) # 80003e24 <_Z8printIntiii>
    800028bc:	00005517          	auipc	a0,0x5
    800028c0:	8b450513          	addi	a0,a0,-1868 # 80007170 <kvmincrease+0x710>
    800028c4:	00001097          	auipc	ra,0x1
    800028c8:	3b0080e7          	jalr	944(ra) # 80003c74 <_Z11printStringPKc>
    800028cc:	0400006f          	j	8000290c <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800028d0:	00005517          	auipc	a0,0x5
    800028d4:	b1050513          	addi	a0,a0,-1264 # 800073e0 <kvmincrease+0x980>
    800028d8:	00001097          	auipc	ra,0x1
    800028dc:	39c080e7          	jalr	924(ra) # 80003c74 <_Z11printStringPKc>
    800028e0:	00000613          	li	a2,0
    800028e4:	00a00593          	li	a1,10
    800028e8:	00048513          	mv	a0,s1
    800028ec:	00001097          	auipc	ra,0x1
    800028f0:	538080e7          	jalr	1336(ra) # 80003e24 <_Z8printIntiii>
    800028f4:	00005517          	auipc	a0,0x5
    800028f8:	87c50513          	addi	a0,a0,-1924 # 80007170 <kvmincrease+0x710>
    800028fc:	00001097          	auipc	ra,0x1
    80002900:	378080e7          	jalr	888(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002904:	0014849b          	addiw	s1,s1,1
    80002908:	0ff4f493          	andi	s1,s1,255
    8000290c:	00f00793          	li	a5,15
    80002910:	fc97f0e3          	bgeu	a5,s1,800028d0 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002914:	00005517          	auipc	a0,0x5
    80002918:	af450513          	addi	a0,a0,-1292 # 80007408 <kvmincrease+0x9a8>
    8000291c:	00001097          	auipc	ra,0x1
    80002920:	358080e7          	jalr	856(ra) # 80003c74 <_Z11printStringPKc>
    finishedD = true;
    80002924:	00100793          	li	a5,1
    80002928:	00006717          	auipc	a4,0x6
    8000292c:	46f701a3          	sb	a5,1123(a4) # 80008d8b <_ZL9finishedD>
    thread_dispatch();
    80002930:	fffff097          	auipc	ra,0xfffff
    80002934:	8bc080e7          	jalr	-1860(ra) # 800011ec <_Z15thread_dispatchv>
}
    80002938:	01813083          	ld	ra,24(sp)
    8000293c:	01013403          	ld	s0,16(sp)
    80002940:	00813483          	ld	s1,8(sp)
    80002944:	00013903          	ld	s2,0(sp)
    80002948:	02010113          	addi	sp,sp,32
    8000294c:	00008067          	ret

0000000080002950 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002950:	fc010113          	addi	sp,sp,-64
    80002954:	02113c23          	sd	ra,56(sp)
    80002958:	02813823          	sd	s0,48(sp)
    8000295c:	02913423          	sd	s1,40(sp)
    80002960:	03213023          	sd	s2,32(sp)
    80002964:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002968:	02000513          	li	a0,32
    8000296c:	fffff097          	auipc	ra,0xfffff
    80002970:	d74080e7          	jalr	-652(ra) # 800016e0 <_Znwm>
    80002974:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002978:	fffff097          	auipc	ra,0xfffff
    8000297c:	fec080e7          	jalr	-20(ra) # 80001964 <_ZN6ThreadC1Ev>
    80002980:	00006797          	auipc	a5,0x6
    80002984:	25078793          	addi	a5,a5,592 # 80008bd0 <_ZTV7WorkerA+0x10>
    80002988:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    8000298c:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80002990:	00005517          	auipc	a0,0x5
    80002994:	a8850513          	addi	a0,a0,-1400 # 80007418 <kvmincrease+0x9b8>
    80002998:	00001097          	auipc	ra,0x1
    8000299c:	2dc080e7          	jalr	732(ra) # 80003c74 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800029a0:	02000513          	li	a0,32
    800029a4:	fffff097          	auipc	ra,0xfffff
    800029a8:	d3c080e7          	jalr	-708(ra) # 800016e0 <_Znwm>
    800029ac:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800029b0:	fffff097          	auipc	ra,0xfffff
    800029b4:	fb4080e7          	jalr	-76(ra) # 80001964 <_ZN6ThreadC1Ev>
    800029b8:	00006797          	auipc	a5,0x6
    800029bc:	24078793          	addi	a5,a5,576 # 80008bf8 <_ZTV7WorkerB+0x10>
    800029c0:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    800029c4:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    800029c8:	00005517          	auipc	a0,0x5
    800029cc:	a6850513          	addi	a0,a0,-1432 # 80007430 <kvmincrease+0x9d0>
    800029d0:	00001097          	auipc	ra,0x1
    800029d4:	2a4080e7          	jalr	676(ra) # 80003c74 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    800029d8:	02000513          	li	a0,32
    800029dc:	fffff097          	auipc	ra,0xfffff
    800029e0:	d04080e7          	jalr	-764(ra) # 800016e0 <_Znwm>
    800029e4:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    800029e8:	fffff097          	auipc	ra,0xfffff
    800029ec:	f7c080e7          	jalr	-132(ra) # 80001964 <_ZN6ThreadC1Ev>
    800029f0:	00006797          	auipc	a5,0x6
    800029f4:	23078793          	addi	a5,a5,560 # 80008c20 <_ZTV7WorkerC+0x10>
    800029f8:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    800029fc:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002a00:	00005517          	auipc	a0,0x5
    80002a04:	a4850513          	addi	a0,a0,-1464 # 80007448 <kvmincrease+0x9e8>
    80002a08:	00001097          	auipc	ra,0x1
    80002a0c:	26c080e7          	jalr	620(ra) # 80003c74 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002a10:	02000513          	li	a0,32
    80002a14:	fffff097          	auipc	ra,0xfffff
    80002a18:	ccc080e7          	jalr	-820(ra) # 800016e0 <_Znwm>
    80002a1c:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002a20:	fffff097          	auipc	ra,0xfffff
    80002a24:	f44080e7          	jalr	-188(ra) # 80001964 <_ZN6ThreadC1Ev>
    80002a28:	00006797          	auipc	a5,0x6
    80002a2c:	22078793          	addi	a5,a5,544 # 80008c48 <_ZTV7WorkerD+0x10>
    80002a30:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002a34:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002a38:	00005517          	auipc	a0,0x5
    80002a3c:	a2850513          	addi	a0,a0,-1496 # 80007460 <kvmincrease+0xa00>
    80002a40:	00001097          	auipc	ra,0x1
    80002a44:	234080e7          	jalr	564(ra) # 80003c74 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002a48:	00000493          	li	s1,0
    80002a4c:	00300793          	li	a5,3
    80002a50:	0297c663          	blt	a5,s1,80002a7c <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002a54:	00349793          	slli	a5,s1,0x3
    80002a58:	fe040713          	addi	a4,s0,-32
    80002a5c:	00f707b3          	add	a5,a4,a5
    80002a60:	fe07b503          	ld	a0,-32(a5)
    80002a64:	fffff097          	auipc	ra,0xfffff
    80002a68:	ea4080e7          	jalr	-348(ra) # 80001908 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002a6c:	0014849b          	addiw	s1,s1,1
    80002a70:	fddff06f          	j	80002a4c <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002a74:	fffff097          	auipc	ra,0xfffff
    80002a78:	ec8080e7          	jalr	-312(ra) # 8000193c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002a7c:	00006797          	auipc	a5,0x6
    80002a80:	30c7c783          	lbu	a5,780(a5) # 80008d88 <_ZL9finishedA>
    80002a84:	fe0788e3          	beqz	a5,80002a74 <_Z20Threads_CPP_API_testv+0x124>
    80002a88:	00006797          	auipc	a5,0x6
    80002a8c:	3017c783          	lbu	a5,769(a5) # 80008d89 <_ZL9finishedB>
    80002a90:	fe0782e3          	beqz	a5,80002a74 <_Z20Threads_CPP_API_testv+0x124>
    80002a94:	00006797          	auipc	a5,0x6
    80002a98:	2f67c783          	lbu	a5,758(a5) # 80008d8a <_ZL9finishedC>
    80002a9c:	fc078ce3          	beqz	a5,80002a74 <_Z20Threads_CPP_API_testv+0x124>
    80002aa0:	00006797          	auipc	a5,0x6
    80002aa4:	2eb7c783          	lbu	a5,747(a5) # 80008d8b <_ZL9finishedD>
    80002aa8:	fc0786e3          	beqz	a5,80002a74 <_Z20Threads_CPP_API_testv+0x124>
    80002aac:	fc040493          	addi	s1,s0,-64
    80002ab0:	0080006f          	j	80002ab8 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002ab4:	00848493          	addi	s1,s1,8
    80002ab8:	fe040793          	addi	a5,s0,-32
    80002abc:	08f48663          	beq	s1,a5,80002b48 <_Z20Threads_CPP_API_testv+0x1f8>
    80002ac0:	0004b503          	ld	a0,0(s1)
    80002ac4:	fe0508e3          	beqz	a0,80002ab4 <_Z20Threads_CPP_API_testv+0x164>
    80002ac8:	00053783          	ld	a5,0(a0)
    80002acc:	0087b783          	ld	a5,8(a5)
    80002ad0:	000780e7          	jalr	a5
    80002ad4:	fe1ff06f          	j	80002ab4 <_Z20Threads_CPP_API_testv+0x164>
    80002ad8:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002adc:	00048513          	mv	a0,s1
    80002ae0:	fffff097          	auipc	ra,0xfffff
    80002ae4:	c50080e7          	jalr	-944(ra) # 80001730 <_ZdlPv>
    80002ae8:	00090513          	mv	a0,s2
    80002aec:	00007097          	auipc	ra,0x7
    80002af0:	38c080e7          	jalr	908(ra) # 80009e78 <_Unwind_Resume>
    80002af4:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002af8:	00048513          	mv	a0,s1
    80002afc:	fffff097          	auipc	ra,0xfffff
    80002b00:	c34080e7          	jalr	-972(ra) # 80001730 <_ZdlPv>
    80002b04:	00090513          	mv	a0,s2
    80002b08:	00007097          	auipc	ra,0x7
    80002b0c:	370080e7          	jalr	880(ra) # 80009e78 <_Unwind_Resume>
    80002b10:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002b14:	00048513          	mv	a0,s1
    80002b18:	fffff097          	auipc	ra,0xfffff
    80002b1c:	c18080e7          	jalr	-1000(ra) # 80001730 <_ZdlPv>
    80002b20:	00090513          	mv	a0,s2
    80002b24:	00007097          	auipc	ra,0x7
    80002b28:	354080e7          	jalr	852(ra) # 80009e78 <_Unwind_Resume>
    80002b2c:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002b30:	00048513          	mv	a0,s1
    80002b34:	fffff097          	auipc	ra,0xfffff
    80002b38:	bfc080e7          	jalr	-1028(ra) # 80001730 <_ZdlPv>
    80002b3c:	00090513          	mv	a0,s2
    80002b40:	00007097          	auipc	ra,0x7
    80002b44:	338080e7          	jalr	824(ra) # 80009e78 <_Unwind_Resume>
}
    80002b48:	03813083          	ld	ra,56(sp)
    80002b4c:	03013403          	ld	s0,48(sp)
    80002b50:	02813483          	ld	s1,40(sp)
    80002b54:	02013903          	ld	s2,32(sp)
    80002b58:	04010113          	addi	sp,sp,64
    80002b5c:	00008067          	ret

0000000080002b60 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002b60:	ff010113          	addi	sp,sp,-16
    80002b64:	00113423          	sd	ra,8(sp)
    80002b68:	00813023          	sd	s0,0(sp)
    80002b6c:	01010413          	addi	s0,sp,16
    80002b70:	00006797          	auipc	a5,0x6
    80002b74:	06078793          	addi	a5,a5,96 # 80008bd0 <_ZTV7WorkerA+0x10>
    80002b78:	00f53023          	sd	a5,0(a0)
    80002b7c:	fffff097          	auipc	ra,0xfffff
    80002b80:	c04080e7          	jalr	-1020(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002b84:	00813083          	ld	ra,8(sp)
    80002b88:	00013403          	ld	s0,0(sp)
    80002b8c:	01010113          	addi	sp,sp,16
    80002b90:	00008067          	ret

0000000080002b94 <_ZN7WorkerAD0Ev>:
    80002b94:	fe010113          	addi	sp,sp,-32
    80002b98:	00113c23          	sd	ra,24(sp)
    80002b9c:	00813823          	sd	s0,16(sp)
    80002ba0:	00913423          	sd	s1,8(sp)
    80002ba4:	02010413          	addi	s0,sp,32
    80002ba8:	00050493          	mv	s1,a0
    80002bac:	00006797          	auipc	a5,0x6
    80002bb0:	02478793          	addi	a5,a5,36 # 80008bd0 <_ZTV7WorkerA+0x10>
    80002bb4:	00f53023          	sd	a5,0(a0)
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	bc8080e7          	jalr	-1080(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002bc0:	00048513          	mv	a0,s1
    80002bc4:	fffff097          	auipc	ra,0xfffff
    80002bc8:	b6c080e7          	jalr	-1172(ra) # 80001730 <_ZdlPv>
    80002bcc:	01813083          	ld	ra,24(sp)
    80002bd0:	01013403          	ld	s0,16(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	02010113          	addi	sp,sp,32
    80002bdc:	00008067          	ret

0000000080002be0 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002be0:	ff010113          	addi	sp,sp,-16
    80002be4:	00113423          	sd	ra,8(sp)
    80002be8:	00813023          	sd	s0,0(sp)
    80002bec:	01010413          	addi	s0,sp,16
    80002bf0:	00006797          	auipc	a5,0x6
    80002bf4:	00878793          	addi	a5,a5,8 # 80008bf8 <_ZTV7WorkerB+0x10>
    80002bf8:	00f53023          	sd	a5,0(a0)
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	b84080e7          	jalr	-1148(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002c04:	00813083          	ld	ra,8(sp)
    80002c08:	00013403          	ld	s0,0(sp)
    80002c0c:	01010113          	addi	sp,sp,16
    80002c10:	00008067          	ret

0000000080002c14 <_ZN7WorkerBD0Ev>:
    80002c14:	fe010113          	addi	sp,sp,-32
    80002c18:	00113c23          	sd	ra,24(sp)
    80002c1c:	00813823          	sd	s0,16(sp)
    80002c20:	00913423          	sd	s1,8(sp)
    80002c24:	02010413          	addi	s0,sp,32
    80002c28:	00050493          	mv	s1,a0
    80002c2c:	00006797          	auipc	a5,0x6
    80002c30:	fcc78793          	addi	a5,a5,-52 # 80008bf8 <_ZTV7WorkerB+0x10>
    80002c34:	00f53023          	sd	a5,0(a0)
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	b48080e7          	jalr	-1208(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002c40:	00048513          	mv	a0,s1
    80002c44:	fffff097          	auipc	ra,0xfffff
    80002c48:	aec080e7          	jalr	-1300(ra) # 80001730 <_ZdlPv>
    80002c4c:	01813083          	ld	ra,24(sp)
    80002c50:	01013403          	ld	s0,16(sp)
    80002c54:	00813483          	ld	s1,8(sp)
    80002c58:	02010113          	addi	sp,sp,32
    80002c5c:	00008067          	ret

0000000080002c60 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002c60:	ff010113          	addi	sp,sp,-16
    80002c64:	00113423          	sd	ra,8(sp)
    80002c68:	00813023          	sd	s0,0(sp)
    80002c6c:	01010413          	addi	s0,sp,16
    80002c70:	00006797          	auipc	a5,0x6
    80002c74:	fb078793          	addi	a5,a5,-80 # 80008c20 <_ZTV7WorkerC+0x10>
    80002c78:	00f53023          	sd	a5,0(a0)
    80002c7c:	fffff097          	auipc	ra,0xfffff
    80002c80:	b04080e7          	jalr	-1276(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002c84:	00813083          	ld	ra,8(sp)
    80002c88:	00013403          	ld	s0,0(sp)
    80002c8c:	01010113          	addi	sp,sp,16
    80002c90:	00008067          	ret

0000000080002c94 <_ZN7WorkerCD0Ev>:
    80002c94:	fe010113          	addi	sp,sp,-32
    80002c98:	00113c23          	sd	ra,24(sp)
    80002c9c:	00813823          	sd	s0,16(sp)
    80002ca0:	00913423          	sd	s1,8(sp)
    80002ca4:	02010413          	addi	s0,sp,32
    80002ca8:	00050493          	mv	s1,a0
    80002cac:	00006797          	auipc	a5,0x6
    80002cb0:	f7478793          	addi	a5,a5,-140 # 80008c20 <_ZTV7WorkerC+0x10>
    80002cb4:	00f53023          	sd	a5,0(a0)
    80002cb8:	fffff097          	auipc	ra,0xfffff
    80002cbc:	ac8080e7          	jalr	-1336(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002cc0:	00048513          	mv	a0,s1
    80002cc4:	fffff097          	auipc	ra,0xfffff
    80002cc8:	a6c080e7          	jalr	-1428(ra) # 80001730 <_ZdlPv>
    80002ccc:	01813083          	ld	ra,24(sp)
    80002cd0:	01013403          	ld	s0,16(sp)
    80002cd4:	00813483          	ld	s1,8(sp)
    80002cd8:	02010113          	addi	sp,sp,32
    80002cdc:	00008067          	ret

0000000080002ce0 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002ce0:	ff010113          	addi	sp,sp,-16
    80002ce4:	00113423          	sd	ra,8(sp)
    80002ce8:	00813023          	sd	s0,0(sp)
    80002cec:	01010413          	addi	s0,sp,16
    80002cf0:	00006797          	auipc	a5,0x6
    80002cf4:	f5878793          	addi	a5,a5,-168 # 80008c48 <_ZTV7WorkerD+0x10>
    80002cf8:	00f53023          	sd	a5,0(a0)
    80002cfc:	fffff097          	auipc	ra,0xfffff
    80002d00:	a84080e7          	jalr	-1404(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002d04:	00813083          	ld	ra,8(sp)
    80002d08:	00013403          	ld	s0,0(sp)
    80002d0c:	01010113          	addi	sp,sp,16
    80002d10:	00008067          	ret

0000000080002d14 <_ZN7WorkerDD0Ev>:
    80002d14:	fe010113          	addi	sp,sp,-32
    80002d18:	00113c23          	sd	ra,24(sp)
    80002d1c:	00813823          	sd	s0,16(sp)
    80002d20:	00913423          	sd	s1,8(sp)
    80002d24:	02010413          	addi	s0,sp,32
    80002d28:	00050493          	mv	s1,a0
    80002d2c:	00006797          	auipc	a5,0x6
    80002d30:	f1c78793          	addi	a5,a5,-228 # 80008c48 <_ZTV7WorkerD+0x10>
    80002d34:	00f53023          	sd	a5,0(a0)
    80002d38:	fffff097          	auipc	ra,0xfffff
    80002d3c:	a48080e7          	jalr	-1464(ra) # 80001780 <_ZN6ThreadD1Ev>
    80002d40:	00048513          	mv	a0,s1
    80002d44:	fffff097          	auipc	ra,0xfffff
    80002d48:	9ec080e7          	jalr	-1556(ra) # 80001730 <_ZdlPv>
    80002d4c:	01813083          	ld	ra,24(sp)
    80002d50:	01013403          	ld	s0,16(sp)
    80002d54:	00813483          	ld	s1,8(sp)
    80002d58:	02010113          	addi	sp,sp,32
    80002d5c:	00008067          	ret

0000000080002d60 <_ZN7WorkerA3runEv>:
    void run() override {
    80002d60:	ff010113          	addi	sp,sp,-16
    80002d64:	00113423          	sd	ra,8(sp)
    80002d68:	00813023          	sd	s0,0(sp)
    80002d6c:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002d70:	00000593          	li	a1,0
    80002d74:	fffff097          	auipc	ra,0xfffff
    80002d78:	774080e7          	jalr	1908(ra) # 800024e8 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002d7c:	00813083          	ld	ra,8(sp)
    80002d80:	00013403          	ld	s0,0(sp)
    80002d84:	01010113          	addi	sp,sp,16
    80002d88:	00008067          	ret

0000000080002d8c <_ZN7WorkerB3runEv>:
    void run() override {
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002d9c:	00000593          	li	a1,0
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	814080e7          	jalr	-2028(ra) # 800025b4 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002da8:	00813083          	ld	ra,8(sp)
    80002dac:	00013403          	ld	s0,0(sp)
    80002db0:	01010113          	addi	sp,sp,16
    80002db4:	00008067          	ret

0000000080002db8 <_ZN7WorkerC3runEv>:
    void run() override {
    80002db8:	ff010113          	addi	sp,sp,-16
    80002dbc:	00113423          	sd	ra,8(sp)
    80002dc0:	00813023          	sd	s0,0(sp)
    80002dc4:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002dc8:	00000593          	li	a1,0
    80002dcc:	00000097          	auipc	ra,0x0
    80002dd0:	8bc080e7          	jalr	-1860(ra) # 80002688 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002dd4:	00813083          	ld	ra,8(sp)
    80002dd8:	00013403          	ld	s0,0(sp)
    80002ddc:	01010113          	addi	sp,sp,16
    80002de0:	00008067          	ret

0000000080002de4 <_ZN7WorkerD3runEv>:
    void run() override {
    80002de4:	ff010113          	addi	sp,sp,-16
    80002de8:	00113423          	sd	ra,8(sp)
    80002dec:	00813023          	sd	s0,0(sp)
    80002df0:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002df4:	00000593          	li	a1,0
    80002df8:	00000097          	auipc	ra,0x0
    80002dfc:	a10080e7          	jalr	-1520(ra) # 80002808 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002e00:	00813083          	ld	ra,8(sp)
    80002e04:	00013403          	ld	s0,0(sp)
    80002e08:	01010113          	addi	sp,sp,16
    80002e0c:	00008067          	ret

0000000080002e10 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002e10:	fe010113          	addi	sp,sp,-32
    80002e14:	00113c23          	sd	ra,24(sp)
    80002e18:	00813823          	sd	s0,16(sp)
    80002e1c:	00913423          	sd	s1,8(sp)
    80002e20:	01213023          	sd	s2,0(sp)
    80002e24:	02010413          	addi	s0,sp,32
    80002e28:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002e2c:	00100793          	li	a5,1
    80002e30:	02a7f863          	bgeu	a5,a0,80002e60 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002e34:	00a00793          	li	a5,10
    80002e38:	02f577b3          	remu	a5,a0,a5
    80002e3c:	02078e63          	beqz	a5,80002e78 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002e40:	fff48513          	addi	a0,s1,-1
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	fcc080e7          	jalr	-52(ra) # 80002e10 <_ZL9fibonaccim>
    80002e4c:	00050913          	mv	s2,a0
    80002e50:	ffe48513          	addi	a0,s1,-2
    80002e54:	00000097          	auipc	ra,0x0
    80002e58:	fbc080e7          	jalr	-68(ra) # 80002e10 <_ZL9fibonaccim>
    80002e5c:	00a90533          	add	a0,s2,a0
}
    80002e60:	01813083          	ld	ra,24(sp)
    80002e64:	01013403          	ld	s0,16(sp)
    80002e68:	00813483          	ld	s1,8(sp)
    80002e6c:	00013903          	ld	s2,0(sp)
    80002e70:	02010113          	addi	sp,sp,32
    80002e74:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002e78:	ffffe097          	auipc	ra,0xffffe
    80002e7c:	374080e7          	jalr	884(ra) # 800011ec <_Z15thread_dispatchv>
    80002e80:	fc1ff06f          	j	80002e40 <_ZL9fibonaccim+0x30>

0000000080002e84 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002e84:	fe010113          	addi	sp,sp,-32
    80002e88:	00113c23          	sd	ra,24(sp)
    80002e8c:	00813823          	sd	s0,16(sp)
    80002e90:	00913423          	sd	s1,8(sp)
    80002e94:	01213023          	sd	s2,0(sp)
    80002e98:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002e9c:	00a00493          	li	s1,10
    80002ea0:	0400006f          	j	80002ee0 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002ea4:	00004517          	auipc	a0,0x4
    80002ea8:	53c50513          	addi	a0,a0,1340 # 800073e0 <kvmincrease+0x980>
    80002eac:	00001097          	auipc	ra,0x1
    80002eb0:	dc8080e7          	jalr	-568(ra) # 80003c74 <_Z11printStringPKc>
    80002eb4:	00000613          	li	a2,0
    80002eb8:	00a00593          	li	a1,10
    80002ebc:	00048513          	mv	a0,s1
    80002ec0:	00001097          	auipc	ra,0x1
    80002ec4:	f64080e7          	jalr	-156(ra) # 80003e24 <_Z8printIntiii>
    80002ec8:	00004517          	auipc	a0,0x4
    80002ecc:	2a850513          	addi	a0,a0,680 # 80007170 <kvmincrease+0x710>
    80002ed0:	00001097          	auipc	ra,0x1
    80002ed4:	da4080e7          	jalr	-604(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002ed8:	0014849b          	addiw	s1,s1,1
    80002edc:	0ff4f493          	andi	s1,s1,255
    80002ee0:	00c00793          	li	a5,12
    80002ee4:	fc97f0e3          	bgeu	a5,s1,80002ea4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80002ee8:	00004517          	auipc	a0,0x4
    80002eec:	50050513          	addi	a0,a0,1280 # 800073e8 <kvmincrease+0x988>
    80002ef0:	00001097          	auipc	ra,0x1
    80002ef4:	d84080e7          	jalr	-636(ra) # 80003c74 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002ef8:	00500313          	li	t1,5
    thread_dispatch();
    80002efc:	ffffe097          	auipc	ra,0xffffe
    80002f00:	2f0080e7          	jalr	752(ra) # 800011ec <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002f04:	01000513          	li	a0,16
    80002f08:	00000097          	auipc	ra,0x0
    80002f0c:	f08080e7          	jalr	-248(ra) # 80002e10 <_ZL9fibonaccim>
    80002f10:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002f14:	00004517          	auipc	a0,0x4
    80002f18:	4e450513          	addi	a0,a0,1252 # 800073f8 <kvmincrease+0x998>
    80002f1c:	00001097          	auipc	ra,0x1
    80002f20:	d58080e7          	jalr	-680(ra) # 80003c74 <_Z11printStringPKc>
    80002f24:	00000613          	li	a2,0
    80002f28:	00a00593          	li	a1,10
    80002f2c:	0009051b          	sext.w	a0,s2
    80002f30:	00001097          	auipc	ra,0x1
    80002f34:	ef4080e7          	jalr	-268(ra) # 80003e24 <_Z8printIntiii>
    80002f38:	00004517          	auipc	a0,0x4
    80002f3c:	23850513          	addi	a0,a0,568 # 80007170 <kvmincrease+0x710>
    80002f40:	00001097          	auipc	ra,0x1
    80002f44:	d34080e7          	jalr	-716(ra) # 80003c74 <_Z11printStringPKc>
    80002f48:	0400006f          	j	80002f88 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f4c:	00004517          	auipc	a0,0x4
    80002f50:	49450513          	addi	a0,a0,1172 # 800073e0 <kvmincrease+0x980>
    80002f54:	00001097          	auipc	ra,0x1
    80002f58:	d20080e7          	jalr	-736(ra) # 80003c74 <_Z11printStringPKc>
    80002f5c:	00000613          	li	a2,0
    80002f60:	00a00593          	li	a1,10
    80002f64:	00048513          	mv	a0,s1
    80002f68:	00001097          	auipc	ra,0x1
    80002f6c:	ebc080e7          	jalr	-324(ra) # 80003e24 <_Z8printIntiii>
    80002f70:	00004517          	auipc	a0,0x4
    80002f74:	20050513          	addi	a0,a0,512 # 80007170 <kvmincrease+0x710>
    80002f78:	00001097          	auipc	ra,0x1
    80002f7c:	cfc080e7          	jalr	-772(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002f80:	0014849b          	addiw	s1,s1,1
    80002f84:	0ff4f493          	andi	s1,s1,255
    80002f88:	00f00793          	li	a5,15
    80002f8c:	fc97f0e3          	bgeu	a5,s1,80002f4c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80002f90:	00004517          	auipc	a0,0x4
    80002f94:	47850513          	addi	a0,a0,1144 # 80007408 <kvmincrease+0x9a8>
    80002f98:	00001097          	auipc	ra,0x1
    80002f9c:	cdc080e7          	jalr	-804(ra) # 80003c74 <_Z11printStringPKc>
    finishedD = true;
    80002fa0:	00100793          	li	a5,1
    80002fa4:	00006717          	auipc	a4,0x6
    80002fa8:	def70423          	sb	a5,-536(a4) # 80008d8c <_ZL9finishedD>
    thread_dispatch();
    80002fac:	ffffe097          	auipc	ra,0xffffe
    80002fb0:	240080e7          	jalr	576(ra) # 800011ec <_Z15thread_dispatchv>
}
    80002fb4:	01813083          	ld	ra,24(sp)
    80002fb8:	01013403          	ld	s0,16(sp)
    80002fbc:	00813483          	ld	s1,8(sp)
    80002fc0:	00013903          	ld	s2,0(sp)
    80002fc4:	02010113          	addi	sp,sp,32
    80002fc8:	00008067          	ret

0000000080002fcc <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80002fcc:	fe010113          	addi	sp,sp,-32
    80002fd0:	00113c23          	sd	ra,24(sp)
    80002fd4:	00813823          	sd	s0,16(sp)
    80002fd8:	00913423          	sd	s1,8(sp)
    80002fdc:	01213023          	sd	s2,0(sp)
    80002fe0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002fe4:	00000493          	li	s1,0
    80002fe8:	0400006f          	j	80003028 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80002fec:	00004517          	auipc	a0,0x4
    80002ff0:	3c450513          	addi	a0,a0,964 # 800073b0 <kvmincrease+0x950>
    80002ff4:	00001097          	auipc	ra,0x1
    80002ff8:	c80080e7          	jalr	-896(ra) # 80003c74 <_Z11printStringPKc>
    80002ffc:	00000613          	li	a2,0
    80003000:	00a00593          	li	a1,10
    80003004:	00048513          	mv	a0,s1
    80003008:	00001097          	auipc	ra,0x1
    8000300c:	e1c080e7          	jalr	-484(ra) # 80003e24 <_Z8printIntiii>
    80003010:	00004517          	auipc	a0,0x4
    80003014:	16050513          	addi	a0,a0,352 # 80007170 <kvmincrease+0x710>
    80003018:	00001097          	auipc	ra,0x1
    8000301c:	c5c080e7          	jalr	-932(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003020:	0014849b          	addiw	s1,s1,1
    80003024:	0ff4f493          	andi	s1,s1,255
    80003028:	00200793          	li	a5,2
    8000302c:	fc97f0e3          	bgeu	a5,s1,80002fec <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003030:	00004517          	auipc	a0,0x4
    80003034:	38850513          	addi	a0,a0,904 # 800073b8 <kvmincrease+0x958>
    80003038:	00001097          	auipc	ra,0x1
    8000303c:	c3c080e7          	jalr	-964(ra) # 80003c74 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003040:	00700313          	li	t1,7
    thread_dispatch();
    80003044:	ffffe097          	auipc	ra,0xffffe
    80003048:	1a8080e7          	jalr	424(ra) # 800011ec <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000304c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003050:	00004517          	auipc	a0,0x4
    80003054:	37850513          	addi	a0,a0,888 # 800073c8 <kvmincrease+0x968>
    80003058:	00001097          	auipc	ra,0x1
    8000305c:	c1c080e7          	jalr	-996(ra) # 80003c74 <_Z11printStringPKc>
    80003060:	00000613          	li	a2,0
    80003064:	00a00593          	li	a1,10
    80003068:	0009051b          	sext.w	a0,s2
    8000306c:	00001097          	auipc	ra,0x1
    80003070:	db8080e7          	jalr	-584(ra) # 80003e24 <_Z8printIntiii>
    80003074:	00004517          	auipc	a0,0x4
    80003078:	0fc50513          	addi	a0,a0,252 # 80007170 <kvmincrease+0x710>
    8000307c:	00001097          	auipc	ra,0x1
    80003080:	bf8080e7          	jalr	-1032(ra) # 80003c74 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003084:	00c00513          	li	a0,12
    80003088:	00000097          	auipc	ra,0x0
    8000308c:	d88080e7          	jalr	-632(ra) # 80002e10 <_ZL9fibonaccim>
    80003090:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003094:	00004517          	auipc	a0,0x4
    80003098:	33c50513          	addi	a0,a0,828 # 800073d0 <kvmincrease+0x970>
    8000309c:	00001097          	auipc	ra,0x1
    800030a0:	bd8080e7          	jalr	-1064(ra) # 80003c74 <_Z11printStringPKc>
    800030a4:	00000613          	li	a2,0
    800030a8:	00a00593          	li	a1,10
    800030ac:	0009051b          	sext.w	a0,s2
    800030b0:	00001097          	auipc	ra,0x1
    800030b4:	d74080e7          	jalr	-652(ra) # 80003e24 <_Z8printIntiii>
    800030b8:	00004517          	auipc	a0,0x4
    800030bc:	0b850513          	addi	a0,a0,184 # 80007170 <kvmincrease+0x710>
    800030c0:	00001097          	auipc	ra,0x1
    800030c4:	bb4080e7          	jalr	-1100(ra) # 80003c74 <_Z11printStringPKc>
    800030c8:	0400006f          	j	80003108 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800030cc:	00004517          	auipc	a0,0x4
    800030d0:	2e450513          	addi	a0,a0,740 # 800073b0 <kvmincrease+0x950>
    800030d4:	00001097          	auipc	ra,0x1
    800030d8:	ba0080e7          	jalr	-1120(ra) # 80003c74 <_Z11printStringPKc>
    800030dc:	00000613          	li	a2,0
    800030e0:	00a00593          	li	a1,10
    800030e4:	00048513          	mv	a0,s1
    800030e8:	00001097          	auipc	ra,0x1
    800030ec:	d3c080e7          	jalr	-708(ra) # 80003e24 <_Z8printIntiii>
    800030f0:	00004517          	auipc	a0,0x4
    800030f4:	08050513          	addi	a0,a0,128 # 80007170 <kvmincrease+0x710>
    800030f8:	00001097          	auipc	ra,0x1
    800030fc:	b7c080e7          	jalr	-1156(ra) # 80003c74 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003100:	0014849b          	addiw	s1,s1,1
    80003104:	0ff4f493          	andi	s1,s1,255
    80003108:	00500793          	li	a5,5
    8000310c:	fc97f0e3          	bgeu	a5,s1,800030cc <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80003110:	00004517          	auipc	a0,0x4
    80003114:	36850513          	addi	a0,a0,872 # 80007478 <kvmincrease+0xa18>
    80003118:	00001097          	auipc	ra,0x1
    8000311c:	b5c080e7          	jalr	-1188(ra) # 80003c74 <_Z11printStringPKc>
    finishedC = true;
    80003120:	00100793          	li	a5,1
    80003124:	00006717          	auipc	a4,0x6
    80003128:	c6f704a3          	sb	a5,-919(a4) # 80008d8d <_ZL9finishedC>
    thread_dispatch();
    8000312c:	ffffe097          	auipc	ra,0xffffe
    80003130:	0c0080e7          	jalr	192(ra) # 800011ec <_Z15thread_dispatchv>
}
    80003134:	01813083          	ld	ra,24(sp)
    80003138:	01013403          	ld	s0,16(sp)
    8000313c:	00813483          	ld	s1,8(sp)
    80003140:	00013903          	ld	s2,0(sp)
    80003144:	02010113          	addi	sp,sp,32
    80003148:	00008067          	ret

000000008000314c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000314c:	fe010113          	addi	sp,sp,-32
    80003150:	00113c23          	sd	ra,24(sp)
    80003154:	00813823          	sd	s0,16(sp)
    80003158:	00913423          	sd	s1,8(sp)
    8000315c:	01213023          	sd	s2,0(sp)
    80003160:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003164:	00000913          	li	s2,0
    80003168:	0380006f          	j	800031a0 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    8000316c:	ffffe097          	auipc	ra,0xffffe
    80003170:	080080e7          	jalr	128(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003174:	00148493          	addi	s1,s1,1
    80003178:	000027b7          	lui	a5,0x2
    8000317c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003180:	0097ee63          	bltu	a5,s1,8000319c <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003184:	00000713          	li	a4,0
    80003188:	000077b7          	lui	a5,0x7
    8000318c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003190:	fce7eee3          	bltu	a5,a4,8000316c <_ZL11workerBodyBPv+0x20>
    80003194:	00170713          	addi	a4,a4,1
    80003198:	ff1ff06f          	j	80003188 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000319c:	00190913          	addi	s2,s2,1
    800031a0:	00f00793          	li	a5,15
    800031a4:	0527e063          	bltu	a5,s2,800031e4 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800031a8:	00004517          	auipc	a0,0x4
    800031ac:	1f050513          	addi	a0,a0,496 # 80007398 <kvmincrease+0x938>
    800031b0:	00001097          	auipc	ra,0x1
    800031b4:	ac4080e7          	jalr	-1340(ra) # 80003c74 <_Z11printStringPKc>
    800031b8:	00000613          	li	a2,0
    800031bc:	00a00593          	li	a1,10
    800031c0:	0009051b          	sext.w	a0,s2
    800031c4:	00001097          	auipc	ra,0x1
    800031c8:	c60080e7          	jalr	-928(ra) # 80003e24 <_Z8printIntiii>
    800031cc:	00004517          	auipc	a0,0x4
    800031d0:	fa450513          	addi	a0,a0,-92 # 80007170 <kvmincrease+0x710>
    800031d4:	00001097          	auipc	ra,0x1
    800031d8:	aa0080e7          	jalr	-1376(ra) # 80003c74 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800031dc:	00000493          	li	s1,0
    800031e0:	f99ff06f          	j	80003178 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800031e4:	00004517          	auipc	a0,0x4
    800031e8:	1bc50513          	addi	a0,a0,444 # 800073a0 <kvmincrease+0x940>
    800031ec:	00001097          	auipc	ra,0x1
    800031f0:	a88080e7          	jalr	-1400(ra) # 80003c74 <_Z11printStringPKc>
    finishedB = true;
    800031f4:	00100793          	li	a5,1
    800031f8:	00006717          	auipc	a4,0x6
    800031fc:	b8f70b23          	sb	a5,-1130(a4) # 80008d8e <_ZL9finishedB>
    thread_dispatch();
    80003200:	ffffe097          	auipc	ra,0xffffe
    80003204:	fec080e7          	jalr	-20(ra) # 800011ec <_Z15thread_dispatchv>
}
    80003208:	01813083          	ld	ra,24(sp)
    8000320c:	01013403          	ld	s0,16(sp)
    80003210:	00813483          	ld	s1,8(sp)
    80003214:	00013903          	ld	s2,0(sp)
    80003218:	02010113          	addi	sp,sp,32
    8000321c:	00008067          	ret

0000000080003220 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003220:	fe010113          	addi	sp,sp,-32
    80003224:	00113c23          	sd	ra,24(sp)
    80003228:	00813823          	sd	s0,16(sp)
    8000322c:	00913423          	sd	s1,8(sp)
    80003230:	01213023          	sd	s2,0(sp)
    80003234:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003238:	00000913          	li	s2,0
    8000323c:	0380006f          	j	80003274 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003240:	ffffe097          	auipc	ra,0xffffe
    80003244:	fac080e7          	jalr	-84(ra) # 800011ec <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003248:	00148493          	addi	s1,s1,1
    8000324c:	000027b7          	lui	a5,0x2
    80003250:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003254:	0097ee63          	bltu	a5,s1,80003270 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003258:	00000713          	li	a4,0
    8000325c:	000077b7          	lui	a5,0x7
    80003260:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003264:	fce7eee3          	bltu	a5,a4,80003240 <_ZL11workerBodyAPv+0x20>
    80003268:	00170713          	addi	a4,a4,1
    8000326c:	ff1ff06f          	j	8000325c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003270:	00190913          	addi	s2,s2,1
    80003274:	00900793          	li	a5,9
    80003278:	0527e063          	bltu	a5,s2,800032b8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000327c:	00004517          	auipc	a0,0x4
    80003280:	10450513          	addi	a0,a0,260 # 80007380 <kvmincrease+0x920>
    80003284:	00001097          	auipc	ra,0x1
    80003288:	9f0080e7          	jalr	-1552(ra) # 80003c74 <_Z11printStringPKc>
    8000328c:	00000613          	li	a2,0
    80003290:	00a00593          	li	a1,10
    80003294:	0009051b          	sext.w	a0,s2
    80003298:	00001097          	auipc	ra,0x1
    8000329c:	b8c080e7          	jalr	-1140(ra) # 80003e24 <_Z8printIntiii>
    800032a0:	00004517          	auipc	a0,0x4
    800032a4:	ed050513          	addi	a0,a0,-304 # 80007170 <kvmincrease+0x710>
    800032a8:	00001097          	auipc	ra,0x1
    800032ac:	9cc080e7          	jalr	-1588(ra) # 80003c74 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800032b0:	00000493          	li	s1,0
    800032b4:	f99ff06f          	j	8000324c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800032b8:	00004517          	auipc	a0,0x4
    800032bc:	0d050513          	addi	a0,a0,208 # 80007388 <kvmincrease+0x928>
    800032c0:	00001097          	auipc	ra,0x1
    800032c4:	9b4080e7          	jalr	-1612(ra) # 80003c74 <_Z11printStringPKc>
    finishedA = true;
    800032c8:	00100793          	li	a5,1
    800032cc:	00006717          	auipc	a4,0x6
    800032d0:	acf701a3          	sb	a5,-1341(a4) # 80008d8f <_ZL9finishedA>
}
    800032d4:	01813083          	ld	ra,24(sp)
    800032d8:	01013403          	ld	s0,16(sp)
    800032dc:	00813483          	ld	s1,8(sp)
    800032e0:	00013903          	ld	s2,0(sp)
    800032e4:	02010113          	addi	sp,sp,32
    800032e8:	00008067          	ret

00000000800032ec <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800032ec:	fd010113          	addi	sp,sp,-48
    800032f0:	02113423          	sd	ra,40(sp)
    800032f4:	02813023          	sd	s0,32(sp)
    800032f8:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800032fc:	00000613          	li	a2,0
    80003300:	00000597          	auipc	a1,0x0
    80003304:	f2058593          	addi	a1,a1,-224 # 80003220 <_ZL11workerBodyAPv>
    80003308:	fd040513          	addi	a0,s0,-48
    8000330c:	ffffe097          	auipc	ra,0xffffe
    80003310:	e88080e7          	jalr	-376(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80003314:	00004517          	auipc	a0,0x4
    80003318:	10450513          	addi	a0,a0,260 # 80007418 <kvmincrease+0x9b8>
    8000331c:	00001097          	auipc	ra,0x1
    80003320:	958080e7          	jalr	-1704(ra) # 80003c74 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80003324:	00000613          	li	a2,0
    80003328:	00000597          	auipc	a1,0x0
    8000332c:	e2458593          	addi	a1,a1,-476 # 8000314c <_ZL11workerBodyBPv>
    80003330:	fd840513          	addi	a0,s0,-40
    80003334:	ffffe097          	auipc	ra,0xffffe
    80003338:	e60080e7          	jalr	-416(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    8000333c:	00004517          	auipc	a0,0x4
    80003340:	0f450513          	addi	a0,a0,244 # 80007430 <kvmincrease+0x9d0>
    80003344:	00001097          	auipc	ra,0x1
    80003348:	930080e7          	jalr	-1744(ra) # 80003c74 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000334c:	00000613          	li	a2,0
    80003350:	00000597          	auipc	a1,0x0
    80003354:	c7c58593          	addi	a1,a1,-900 # 80002fcc <_ZL11workerBodyCPv>
    80003358:	fe040513          	addi	a0,s0,-32
    8000335c:	ffffe097          	auipc	ra,0xffffe
    80003360:	e38080e7          	jalr	-456(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003364:	00004517          	auipc	a0,0x4
    80003368:	0e450513          	addi	a0,a0,228 # 80007448 <kvmincrease+0x9e8>
    8000336c:	00001097          	auipc	ra,0x1
    80003370:	908080e7          	jalr	-1784(ra) # 80003c74 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003374:	00000613          	li	a2,0
    80003378:	00000597          	auipc	a1,0x0
    8000337c:	b0c58593          	addi	a1,a1,-1268 # 80002e84 <_ZL11workerBodyDPv>
    80003380:	fe840513          	addi	a0,s0,-24
    80003384:	ffffe097          	auipc	ra,0xffffe
    80003388:	e10080e7          	jalr	-496(ra) # 80001194 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    8000338c:	00004517          	auipc	a0,0x4
    80003390:	0d450513          	addi	a0,a0,212 # 80007460 <kvmincrease+0xa00>
    80003394:	00001097          	auipc	ra,0x1
    80003398:	8e0080e7          	jalr	-1824(ra) # 80003c74 <_Z11printStringPKc>
    8000339c:	00c0006f          	j	800033a8 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800033a0:	ffffe097          	auipc	ra,0xffffe
    800033a4:	e4c080e7          	jalr	-436(ra) # 800011ec <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800033a8:	00006797          	auipc	a5,0x6
    800033ac:	9e77c783          	lbu	a5,-1561(a5) # 80008d8f <_ZL9finishedA>
    800033b0:	fe0788e3          	beqz	a5,800033a0 <_Z18Threads_C_API_testv+0xb4>
    800033b4:	00006797          	auipc	a5,0x6
    800033b8:	9da7c783          	lbu	a5,-1574(a5) # 80008d8e <_ZL9finishedB>
    800033bc:	fe0782e3          	beqz	a5,800033a0 <_Z18Threads_C_API_testv+0xb4>
    800033c0:	00006797          	auipc	a5,0x6
    800033c4:	9cd7c783          	lbu	a5,-1587(a5) # 80008d8d <_ZL9finishedC>
    800033c8:	fc078ce3          	beqz	a5,800033a0 <_Z18Threads_C_API_testv+0xb4>
    800033cc:	00006797          	auipc	a5,0x6
    800033d0:	9c07c783          	lbu	a5,-1600(a5) # 80008d8c <_ZL9finishedD>
    800033d4:	fc0786e3          	beqz	a5,800033a0 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800033d8:	02813083          	ld	ra,40(sp)
    800033dc:	02013403          	ld	s0,32(sp)
    800033e0:	03010113          	addi	sp,sp,48
    800033e4:	00008067          	ret

00000000800033e8 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    800033e8:	fd010113          	addi	sp,sp,-48
    800033ec:	02113423          	sd	ra,40(sp)
    800033f0:	02813023          	sd	s0,32(sp)
    800033f4:	00913c23          	sd	s1,24(sp)
    800033f8:	01213823          	sd	s2,16(sp)
    800033fc:	01313423          	sd	s3,8(sp)
    80003400:	03010413          	addi	s0,sp,48
    80003404:	00050993          	mv	s3,a0
    80003408:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000340c:	00000913          	li	s2,0
    80003410:	00c0006f          	j	8000341c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003414:	ffffe097          	auipc	ra,0xffffe
    80003418:	528080e7          	jalr	1320(ra) # 8000193c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    8000341c:	ffffe097          	auipc	ra,0xffffe
    80003420:	ea4080e7          	jalr	-348(ra) # 800012c0 <_Z4getcv>
    80003424:	0005059b          	sext.w	a1,a0
    80003428:	01b00793          	li	a5,27
    8000342c:	02f58a63          	beq	a1,a5,80003460 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80003430:	0084b503          	ld	a0,8(s1)
    80003434:	00001097          	auipc	ra,0x1
    80003438:	c64080e7          	jalr	-924(ra) # 80004098 <_ZN9BufferCPP3putEi>
        i++;
    8000343c:	0019071b          	addiw	a4,s2,1
    80003440:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003444:	0004a683          	lw	a3,0(s1)
    80003448:	0026979b          	slliw	a5,a3,0x2
    8000344c:	00d787bb          	addw	a5,a5,a3
    80003450:	0017979b          	slliw	a5,a5,0x1
    80003454:	02f767bb          	remw	a5,a4,a5
    80003458:	fc0792e3          	bnez	a5,8000341c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    8000345c:	fb9ff06f          	j	80003414 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80003460:	00100793          	li	a5,1
    80003464:	00006717          	auipc	a4,0x6
    80003468:	92f72623          	sw	a5,-1748(a4) # 80008d90 <_ZL9threadEnd>
    td->buffer->put('!');
    8000346c:	0209b783          	ld	a5,32(s3)
    80003470:	02100593          	li	a1,33
    80003474:	0087b503          	ld	a0,8(a5)
    80003478:	00001097          	auipc	ra,0x1
    8000347c:	c20080e7          	jalr	-992(ra) # 80004098 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80003480:	0104b503          	ld	a0,16(s1)
    80003484:	ffffe097          	auipc	ra,0xffffe
    80003488:	56c080e7          	jalr	1388(ra) # 800019f0 <_ZN9Semaphore6signalEv>
}
    8000348c:	02813083          	ld	ra,40(sp)
    80003490:	02013403          	ld	s0,32(sp)
    80003494:	01813483          	ld	s1,24(sp)
    80003498:	01013903          	ld	s2,16(sp)
    8000349c:	00813983          	ld	s3,8(sp)
    800034a0:	03010113          	addi	sp,sp,48
    800034a4:	00008067          	ret

00000000800034a8 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800034a8:	fe010113          	addi	sp,sp,-32
    800034ac:	00113c23          	sd	ra,24(sp)
    800034b0:	00813823          	sd	s0,16(sp)
    800034b4:	00913423          	sd	s1,8(sp)
    800034b8:	01213023          	sd	s2,0(sp)
    800034bc:	02010413          	addi	s0,sp,32
    800034c0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800034c4:	00000913          	li	s2,0
    800034c8:	00c0006f          	j	800034d4 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800034cc:	ffffe097          	auipc	ra,0xffffe
    800034d0:	470080e7          	jalr	1136(ra) # 8000193c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800034d4:	00006797          	auipc	a5,0x6
    800034d8:	8bc7a783          	lw	a5,-1860(a5) # 80008d90 <_ZL9threadEnd>
    800034dc:	02079e63          	bnez	a5,80003518 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    800034e0:	0004a583          	lw	a1,0(s1)
    800034e4:	0305859b          	addiw	a1,a1,48
    800034e8:	0084b503          	ld	a0,8(s1)
    800034ec:	00001097          	auipc	ra,0x1
    800034f0:	bac080e7          	jalr	-1108(ra) # 80004098 <_ZN9BufferCPP3putEi>
        i++;
    800034f4:	0019071b          	addiw	a4,s2,1
    800034f8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800034fc:	0004a683          	lw	a3,0(s1)
    80003500:	0026979b          	slliw	a5,a3,0x2
    80003504:	00d787bb          	addw	a5,a5,a3
    80003508:	0017979b          	slliw	a5,a5,0x1
    8000350c:	02f767bb          	remw	a5,a4,a5
    80003510:	fc0792e3          	bnez	a5,800034d4 <_ZN12ProducerSync8producerEPv+0x2c>
    80003514:	fb9ff06f          	j	800034cc <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80003518:	0104b503          	ld	a0,16(s1)
    8000351c:	ffffe097          	auipc	ra,0xffffe
    80003520:	4d4080e7          	jalr	1236(ra) # 800019f0 <_ZN9Semaphore6signalEv>
}
    80003524:	01813083          	ld	ra,24(sp)
    80003528:	01013403          	ld	s0,16(sp)
    8000352c:	00813483          	ld	s1,8(sp)
    80003530:	00013903          	ld	s2,0(sp)
    80003534:	02010113          	addi	sp,sp,32
    80003538:	00008067          	ret

000000008000353c <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    8000353c:	fd010113          	addi	sp,sp,-48
    80003540:	02113423          	sd	ra,40(sp)
    80003544:	02813023          	sd	s0,32(sp)
    80003548:	00913c23          	sd	s1,24(sp)
    8000354c:	01213823          	sd	s2,16(sp)
    80003550:	01313423          	sd	s3,8(sp)
    80003554:	01413023          	sd	s4,0(sp)
    80003558:	03010413          	addi	s0,sp,48
    8000355c:	00050993          	mv	s3,a0
    80003560:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003564:	00000a13          	li	s4,0
    80003568:	01c0006f          	j	80003584 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    8000356c:	ffffe097          	auipc	ra,0xffffe
    80003570:	3d0080e7          	jalr	976(ra) # 8000193c <_ZN6Thread8dispatchEv>
    80003574:	0500006f          	j	800035c4 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003578:	00a00513          	li	a0,10
    8000357c:	ffffe097          	auipc	ra,0xffffe
    80003580:	d6c080e7          	jalr	-660(ra) # 800012e8 <_Z4putcc>
    while (!threadEnd) {
    80003584:	00006797          	auipc	a5,0x6
    80003588:	80c7a783          	lw	a5,-2036(a5) # 80008d90 <_ZL9threadEnd>
    8000358c:	06079263          	bnez	a5,800035f0 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80003590:	00893503          	ld	a0,8(s2)
    80003594:	00001097          	auipc	ra,0x1
    80003598:	b94080e7          	jalr	-1132(ra) # 80004128 <_ZN9BufferCPP3getEv>
        i++;
    8000359c:	001a049b          	addiw	s1,s4,1
    800035a0:	00048a1b          	sext.w	s4,s1
        putc(key);
    800035a4:	0ff57513          	andi	a0,a0,255
    800035a8:	ffffe097          	auipc	ra,0xffffe
    800035ac:	d40080e7          	jalr	-704(ra) # 800012e8 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800035b0:	00092703          	lw	a4,0(s2)
    800035b4:	0027179b          	slliw	a5,a4,0x2
    800035b8:	00e787bb          	addw	a5,a5,a4
    800035bc:	02f4e7bb          	remw	a5,s1,a5
    800035c0:	fa0786e3          	beqz	a5,8000356c <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800035c4:	05000793          	li	a5,80
    800035c8:	02f4e4bb          	remw	s1,s1,a5
    800035cc:	fa049ce3          	bnez	s1,80003584 <_ZN12ConsumerSync8consumerEPv+0x48>
    800035d0:	fa9ff06f          	j	80003578 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800035d4:	0209b783          	ld	a5,32(s3)
    800035d8:	0087b503          	ld	a0,8(a5)
    800035dc:	00001097          	auipc	ra,0x1
    800035e0:	b4c080e7          	jalr	-1204(ra) # 80004128 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    800035e4:	0ff57513          	andi	a0,a0,255
    800035e8:	ffffe097          	auipc	ra,0xffffe
    800035ec:	2a4080e7          	jalr	676(ra) # 8000188c <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    800035f0:	0209b783          	ld	a5,32(s3)
    800035f4:	0087b503          	ld	a0,8(a5)
    800035f8:	00001097          	auipc	ra,0x1
    800035fc:	bbc080e7          	jalr	-1092(ra) # 800041b4 <_ZN9BufferCPP6getCntEv>
    80003600:	fca04ae3          	bgtz	a0,800035d4 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80003604:	01093503          	ld	a0,16(s2)
    80003608:	ffffe097          	auipc	ra,0xffffe
    8000360c:	3e8080e7          	jalr	1000(ra) # 800019f0 <_ZN9Semaphore6signalEv>
}
    80003610:	02813083          	ld	ra,40(sp)
    80003614:	02013403          	ld	s0,32(sp)
    80003618:	01813483          	ld	s1,24(sp)
    8000361c:	01013903          	ld	s2,16(sp)
    80003620:	00813983          	ld	s3,8(sp)
    80003624:	00013a03          	ld	s4,0(sp)
    80003628:	03010113          	addi	sp,sp,48
    8000362c:	00008067          	ret

0000000080003630 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003630:	f8010113          	addi	sp,sp,-128
    80003634:	06113c23          	sd	ra,120(sp)
    80003638:	06813823          	sd	s0,112(sp)
    8000363c:	06913423          	sd	s1,104(sp)
    80003640:	07213023          	sd	s2,96(sp)
    80003644:	05313c23          	sd	s3,88(sp)
    80003648:	05413823          	sd	s4,80(sp)
    8000364c:	05513423          	sd	s5,72(sp)
    80003650:	05613023          	sd	s6,64(sp)
    80003654:	03713c23          	sd	s7,56(sp)
    80003658:	03813823          	sd	s8,48(sp)
    8000365c:	03913423          	sd	s9,40(sp)
    80003660:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003664:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003668:	00004517          	auipc	a0,0x4
    8000366c:	c3050513          	addi	a0,a0,-976 # 80007298 <kvmincrease+0x838>
    80003670:	00000097          	auipc	ra,0x0
    80003674:	604080e7          	jalr	1540(ra) # 80003c74 <_Z11printStringPKc>
    getString(input, 30);
    80003678:	01e00593          	li	a1,30
    8000367c:	f8040493          	addi	s1,s0,-128
    80003680:	00048513          	mv	a0,s1
    80003684:	00000097          	auipc	ra,0x0
    80003688:	678080e7          	jalr	1656(ra) # 80003cfc <_Z9getStringPci>
    threadNum = stringToInt(input);
    8000368c:	00048513          	mv	a0,s1
    80003690:	00000097          	auipc	ra,0x0
    80003694:	744080e7          	jalr	1860(ra) # 80003dd4 <_Z11stringToIntPKc>
    80003698:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000369c:	00004517          	auipc	a0,0x4
    800036a0:	c1c50513          	addi	a0,a0,-996 # 800072b8 <kvmincrease+0x858>
    800036a4:	00000097          	auipc	ra,0x0
    800036a8:	5d0080e7          	jalr	1488(ra) # 80003c74 <_Z11printStringPKc>
    getString(input, 30);
    800036ac:	01e00593          	li	a1,30
    800036b0:	00048513          	mv	a0,s1
    800036b4:	00000097          	auipc	ra,0x0
    800036b8:	648080e7          	jalr	1608(ra) # 80003cfc <_Z9getStringPci>
    n = stringToInt(input);
    800036bc:	00048513          	mv	a0,s1
    800036c0:	00000097          	auipc	ra,0x0
    800036c4:	714080e7          	jalr	1812(ra) # 80003dd4 <_Z11stringToIntPKc>
    800036c8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800036cc:	00004517          	auipc	a0,0x4
    800036d0:	c0c50513          	addi	a0,a0,-1012 # 800072d8 <kvmincrease+0x878>
    800036d4:	00000097          	auipc	ra,0x0
    800036d8:	5a0080e7          	jalr	1440(ra) # 80003c74 <_Z11printStringPKc>
    800036dc:	00000613          	li	a2,0
    800036e0:	00a00593          	li	a1,10
    800036e4:	00090513          	mv	a0,s2
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	73c080e7          	jalr	1852(ra) # 80003e24 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800036f0:	00004517          	auipc	a0,0x4
    800036f4:	c0050513          	addi	a0,a0,-1024 # 800072f0 <kvmincrease+0x890>
    800036f8:	00000097          	auipc	ra,0x0
    800036fc:	57c080e7          	jalr	1404(ra) # 80003c74 <_Z11printStringPKc>
    80003700:	00000613          	li	a2,0
    80003704:	00a00593          	li	a1,10
    80003708:	00048513          	mv	a0,s1
    8000370c:	00000097          	auipc	ra,0x0
    80003710:	718080e7          	jalr	1816(ra) # 80003e24 <_Z8printIntiii>
    printString(".\n");
    80003714:	00004517          	auipc	a0,0x4
    80003718:	bf450513          	addi	a0,a0,-1036 # 80007308 <kvmincrease+0x8a8>
    8000371c:	00000097          	auipc	ra,0x0
    80003720:	558080e7          	jalr	1368(ra) # 80003c74 <_Z11printStringPKc>
    if(threadNum > n) {
    80003724:	0324c463          	blt	s1,s2,8000374c <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80003728:	03205c63          	blez	s2,80003760 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    8000372c:	03800513          	li	a0,56
    80003730:	ffffe097          	auipc	ra,0xffffe
    80003734:	fb0080e7          	jalr	-80(ra) # 800016e0 <_Znwm>
    80003738:	00050a93          	mv	s5,a0
    8000373c:	00048593          	mv	a1,s1
    80003740:	00001097          	auipc	ra,0x1
    80003744:	804080e7          	jalr	-2044(ra) # 80003f44 <_ZN9BufferCPPC1Ei>
    80003748:	0300006f          	j	80003778 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000374c:	00004517          	auipc	a0,0x4
    80003750:	bc450513          	addi	a0,a0,-1084 # 80007310 <kvmincrease+0x8b0>
    80003754:	00000097          	auipc	ra,0x0
    80003758:	520080e7          	jalr	1312(ra) # 80003c74 <_Z11printStringPKc>
        return;
    8000375c:	0140006f          	j	80003770 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003760:	00004517          	auipc	a0,0x4
    80003764:	bf050513          	addi	a0,a0,-1040 # 80007350 <kvmincrease+0x8f0>
    80003768:	00000097          	auipc	ra,0x0
    8000376c:	50c080e7          	jalr	1292(ra) # 80003c74 <_Z11printStringPKc>
        return;
    80003770:	000b8113          	mv	sp,s7
    80003774:	2380006f          	j	800039ac <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003778:	01000513          	li	a0,16
    8000377c:	ffffe097          	auipc	ra,0xffffe
    80003780:	f64080e7          	jalr	-156(ra) # 800016e0 <_Znwm>
    80003784:	00050493          	mv	s1,a0
    80003788:	00000593          	li	a1,0
    8000378c:	ffffe097          	auipc	ra,0xffffe
    80003790:	290080e7          	jalr	656(ra) # 80001a1c <_ZN9SemaphoreC1Ej>
    80003794:	00005797          	auipc	a5,0x5
    80003798:	6097b223          	sd	s1,1540(a5) # 80008d98 <_ZL10waitForAll>
    Thread* threads[threadNum];
    8000379c:	00391793          	slli	a5,s2,0x3
    800037a0:	00f78793          	addi	a5,a5,15
    800037a4:	ff07f793          	andi	a5,a5,-16
    800037a8:	40f10133          	sub	sp,sp,a5
    800037ac:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800037b0:	0019071b          	addiw	a4,s2,1
    800037b4:	00171793          	slli	a5,a4,0x1
    800037b8:	00e787b3          	add	a5,a5,a4
    800037bc:	00379793          	slli	a5,a5,0x3
    800037c0:	00f78793          	addi	a5,a5,15
    800037c4:	ff07f793          	andi	a5,a5,-16
    800037c8:	40f10133          	sub	sp,sp,a5
    800037cc:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    800037d0:	00191c13          	slli	s8,s2,0x1
    800037d4:	012c07b3          	add	a5,s8,s2
    800037d8:	00379793          	slli	a5,a5,0x3
    800037dc:	00fa07b3          	add	a5,s4,a5
    800037e0:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800037e4:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    800037e8:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    800037ec:	02800513          	li	a0,40
    800037f0:	ffffe097          	auipc	ra,0xffffe
    800037f4:	ef0080e7          	jalr	-272(ra) # 800016e0 <_Znwm>
    800037f8:	00050b13          	mv	s6,a0
    800037fc:	012c0c33          	add	s8,s8,s2
    80003800:	003c1c13          	slli	s8,s8,0x3
    80003804:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003808:	ffffe097          	auipc	ra,0xffffe
    8000380c:	15c080e7          	jalr	348(ra) # 80001964 <_ZN6ThreadC1Ev>
    80003810:	00005797          	auipc	a5,0x5
    80003814:	4b078793          	addi	a5,a5,1200 # 80008cc0 <_ZTV12ConsumerSync+0x10>
    80003818:	00fb3023          	sd	a5,0(s6)
    8000381c:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80003820:	000b0513          	mv	a0,s6
    80003824:	ffffe097          	auipc	ra,0xffffe
    80003828:	0e4080e7          	jalr	228(ra) # 80001908 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    8000382c:	00000493          	li	s1,0
    80003830:	0380006f          	j	80003868 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003834:	00005797          	auipc	a5,0x5
    80003838:	46478793          	addi	a5,a5,1124 # 80008c98 <_ZTV12ProducerSync+0x10>
    8000383c:	00fcb023          	sd	a5,0(s9)
    80003840:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003844:	00349793          	slli	a5,s1,0x3
    80003848:	00f987b3          	add	a5,s3,a5
    8000384c:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003850:	00349793          	slli	a5,s1,0x3
    80003854:	00f987b3          	add	a5,s3,a5
    80003858:	0007b503          	ld	a0,0(a5)
    8000385c:	ffffe097          	auipc	ra,0xffffe
    80003860:	0ac080e7          	jalr	172(ra) # 80001908 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003864:	0014849b          	addiw	s1,s1,1
    80003868:	0b24d063          	bge	s1,s2,80003908 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    8000386c:	00149793          	slli	a5,s1,0x1
    80003870:	009787b3          	add	a5,a5,s1
    80003874:	00379793          	slli	a5,a5,0x3
    80003878:	00fa07b3          	add	a5,s4,a5
    8000387c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003880:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003884:	00005717          	auipc	a4,0x5
    80003888:	51473703          	ld	a4,1300(a4) # 80008d98 <_ZL10waitForAll>
    8000388c:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003890:	02905863          	blez	s1,800038c0 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003894:	02800513          	li	a0,40
    80003898:	ffffe097          	auipc	ra,0xffffe
    8000389c:	e48080e7          	jalr	-440(ra) # 800016e0 <_Znwm>
    800038a0:	00050c93          	mv	s9,a0
    800038a4:	00149c13          	slli	s8,s1,0x1
    800038a8:	009c0c33          	add	s8,s8,s1
    800038ac:	003c1c13          	slli	s8,s8,0x3
    800038b0:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800038b4:	ffffe097          	auipc	ra,0xffffe
    800038b8:	0b0080e7          	jalr	176(ra) # 80001964 <_ZN6ThreadC1Ev>
    800038bc:	f79ff06f          	j	80003834 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    800038c0:	02800513          	li	a0,40
    800038c4:	ffffe097          	auipc	ra,0xffffe
    800038c8:	e1c080e7          	jalr	-484(ra) # 800016e0 <_Znwm>
    800038cc:	00050c93          	mv	s9,a0
    800038d0:	00149c13          	slli	s8,s1,0x1
    800038d4:	009c0c33          	add	s8,s8,s1
    800038d8:	003c1c13          	slli	s8,s8,0x3
    800038dc:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    800038e0:	ffffe097          	auipc	ra,0xffffe
    800038e4:	084080e7          	jalr	132(ra) # 80001964 <_ZN6ThreadC1Ev>
    800038e8:	00005797          	auipc	a5,0x5
    800038ec:	38878793          	addi	a5,a5,904 # 80008c70 <_ZTV16ProducerKeyboard+0x10>
    800038f0:	00fcb023          	sd	a5,0(s9)
    800038f4:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    800038f8:	00349793          	slli	a5,s1,0x3
    800038fc:	00f987b3          	add	a5,s3,a5
    80003900:	0197b023          	sd	s9,0(a5)
    80003904:	f4dff06f          	j	80003850 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80003908:	ffffe097          	auipc	ra,0xffffe
    8000390c:	034080e7          	jalr	52(ra) # 8000193c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003910:	00000493          	li	s1,0
    80003914:	00994e63          	blt	s2,s1,80003930 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80003918:	00005517          	auipc	a0,0x5
    8000391c:	48053503          	ld	a0,1152(a0) # 80008d98 <_ZL10waitForAll>
    80003920:	ffffe097          	auipc	ra,0xffffe
    80003924:	0a4080e7          	jalr	164(ra) # 800019c4 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003928:	0014849b          	addiw	s1,s1,1
    8000392c:	fe9ff06f          	j	80003914 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003930:	00000493          	li	s1,0
    80003934:	0080006f          	j	8000393c <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003938:	0014849b          	addiw	s1,s1,1
    8000393c:	0324d263          	bge	s1,s2,80003960 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003940:	00349793          	slli	a5,s1,0x3
    80003944:	00f987b3          	add	a5,s3,a5
    80003948:	0007b503          	ld	a0,0(a5)
    8000394c:	fe0506e3          	beqz	a0,80003938 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003950:	00053783          	ld	a5,0(a0)
    80003954:	0087b783          	ld	a5,8(a5)
    80003958:	000780e7          	jalr	a5
    8000395c:	fddff06f          	j	80003938 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003960:	000b0a63          	beqz	s6,80003974 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003964:	000b3783          	ld	a5,0(s6)
    80003968:	0087b783          	ld	a5,8(a5)
    8000396c:	000b0513          	mv	a0,s6
    80003970:	000780e7          	jalr	a5
    delete waitForAll;
    80003974:	00005517          	auipc	a0,0x5
    80003978:	42453503          	ld	a0,1060(a0) # 80008d98 <_ZL10waitForAll>
    8000397c:	00050863          	beqz	a0,8000398c <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003980:	00053783          	ld	a5,0(a0)
    80003984:	0087b783          	ld	a5,8(a5)
    80003988:	000780e7          	jalr	a5
    delete buffer;
    8000398c:	000a8e63          	beqz	s5,800039a8 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003990:	000a8513          	mv	a0,s5
    80003994:	00001097          	auipc	ra,0x1
    80003998:	8a8080e7          	jalr	-1880(ra) # 8000423c <_ZN9BufferCPPD1Ev>
    8000399c:	000a8513          	mv	a0,s5
    800039a0:	ffffe097          	auipc	ra,0xffffe
    800039a4:	d90080e7          	jalr	-624(ra) # 80001730 <_ZdlPv>
    800039a8:	000b8113          	mv	sp,s7

}
    800039ac:	f8040113          	addi	sp,s0,-128
    800039b0:	07813083          	ld	ra,120(sp)
    800039b4:	07013403          	ld	s0,112(sp)
    800039b8:	06813483          	ld	s1,104(sp)
    800039bc:	06013903          	ld	s2,96(sp)
    800039c0:	05813983          	ld	s3,88(sp)
    800039c4:	05013a03          	ld	s4,80(sp)
    800039c8:	04813a83          	ld	s5,72(sp)
    800039cc:	04013b03          	ld	s6,64(sp)
    800039d0:	03813b83          	ld	s7,56(sp)
    800039d4:	03013c03          	ld	s8,48(sp)
    800039d8:	02813c83          	ld	s9,40(sp)
    800039dc:	08010113          	addi	sp,sp,128
    800039e0:	00008067          	ret
    800039e4:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800039e8:	000a8513          	mv	a0,s5
    800039ec:	ffffe097          	auipc	ra,0xffffe
    800039f0:	d44080e7          	jalr	-700(ra) # 80001730 <_ZdlPv>
    800039f4:	00048513          	mv	a0,s1
    800039f8:	00006097          	auipc	ra,0x6
    800039fc:	480080e7          	jalr	1152(ra) # 80009e78 <_Unwind_Resume>
    80003a00:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003a04:	00048513          	mv	a0,s1
    80003a08:	ffffe097          	auipc	ra,0xffffe
    80003a0c:	d28080e7          	jalr	-728(ra) # 80001730 <_ZdlPv>
    80003a10:	00090513          	mv	a0,s2
    80003a14:	00006097          	auipc	ra,0x6
    80003a18:	464080e7          	jalr	1124(ra) # 80009e78 <_Unwind_Resume>
    80003a1c:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003a20:	000b0513          	mv	a0,s6
    80003a24:	ffffe097          	auipc	ra,0xffffe
    80003a28:	d0c080e7          	jalr	-756(ra) # 80001730 <_ZdlPv>
    80003a2c:	00048513          	mv	a0,s1
    80003a30:	00006097          	auipc	ra,0x6
    80003a34:	448080e7          	jalr	1096(ra) # 80009e78 <_Unwind_Resume>
    80003a38:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003a3c:	000c8513          	mv	a0,s9
    80003a40:	ffffe097          	auipc	ra,0xffffe
    80003a44:	cf0080e7          	jalr	-784(ra) # 80001730 <_ZdlPv>
    80003a48:	00048513          	mv	a0,s1
    80003a4c:	00006097          	auipc	ra,0x6
    80003a50:	42c080e7          	jalr	1068(ra) # 80009e78 <_Unwind_Resume>
    80003a54:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003a58:	000c8513          	mv	a0,s9
    80003a5c:	ffffe097          	auipc	ra,0xffffe
    80003a60:	cd4080e7          	jalr	-812(ra) # 80001730 <_ZdlPv>
    80003a64:	00048513          	mv	a0,s1
    80003a68:	00006097          	auipc	ra,0x6
    80003a6c:	410080e7          	jalr	1040(ra) # 80009e78 <_Unwind_Resume>

0000000080003a70 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003a70:	ff010113          	addi	sp,sp,-16
    80003a74:	00113423          	sd	ra,8(sp)
    80003a78:	00813023          	sd	s0,0(sp)
    80003a7c:	01010413          	addi	s0,sp,16
    80003a80:	00005797          	auipc	a5,0x5
    80003a84:	24078793          	addi	a5,a5,576 # 80008cc0 <_ZTV12ConsumerSync+0x10>
    80003a88:	00f53023          	sd	a5,0(a0)
    80003a8c:	ffffe097          	auipc	ra,0xffffe
    80003a90:	cf4080e7          	jalr	-780(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003a94:	00813083          	ld	ra,8(sp)
    80003a98:	00013403          	ld	s0,0(sp)
    80003a9c:	01010113          	addi	sp,sp,16
    80003aa0:	00008067          	ret

0000000080003aa4 <_ZN12ConsumerSyncD0Ev>:
    80003aa4:	fe010113          	addi	sp,sp,-32
    80003aa8:	00113c23          	sd	ra,24(sp)
    80003aac:	00813823          	sd	s0,16(sp)
    80003ab0:	00913423          	sd	s1,8(sp)
    80003ab4:	02010413          	addi	s0,sp,32
    80003ab8:	00050493          	mv	s1,a0
    80003abc:	00005797          	auipc	a5,0x5
    80003ac0:	20478793          	addi	a5,a5,516 # 80008cc0 <_ZTV12ConsumerSync+0x10>
    80003ac4:	00f53023          	sd	a5,0(a0)
    80003ac8:	ffffe097          	auipc	ra,0xffffe
    80003acc:	cb8080e7          	jalr	-840(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003ad0:	00048513          	mv	a0,s1
    80003ad4:	ffffe097          	auipc	ra,0xffffe
    80003ad8:	c5c080e7          	jalr	-932(ra) # 80001730 <_ZdlPv>
    80003adc:	01813083          	ld	ra,24(sp)
    80003ae0:	01013403          	ld	s0,16(sp)
    80003ae4:	00813483          	ld	s1,8(sp)
    80003ae8:	02010113          	addi	sp,sp,32
    80003aec:	00008067          	ret

0000000080003af0 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003af0:	ff010113          	addi	sp,sp,-16
    80003af4:	00113423          	sd	ra,8(sp)
    80003af8:	00813023          	sd	s0,0(sp)
    80003afc:	01010413          	addi	s0,sp,16
    80003b00:	00005797          	auipc	a5,0x5
    80003b04:	19878793          	addi	a5,a5,408 # 80008c98 <_ZTV12ProducerSync+0x10>
    80003b08:	00f53023          	sd	a5,0(a0)
    80003b0c:	ffffe097          	auipc	ra,0xffffe
    80003b10:	c74080e7          	jalr	-908(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003b14:	00813083          	ld	ra,8(sp)
    80003b18:	00013403          	ld	s0,0(sp)
    80003b1c:	01010113          	addi	sp,sp,16
    80003b20:	00008067          	ret

0000000080003b24 <_ZN12ProducerSyncD0Ev>:
    80003b24:	fe010113          	addi	sp,sp,-32
    80003b28:	00113c23          	sd	ra,24(sp)
    80003b2c:	00813823          	sd	s0,16(sp)
    80003b30:	00913423          	sd	s1,8(sp)
    80003b34:	02010413          	addi	s0,sp,32
    80003b38:	00050493          	mv	s1,a0
    80003b3c:	00005797          	auipc	a5,0x5
    80003b40:	15c78793          	addi	a5,a5,348 # 80008c98 <_ZTV12ProducerSync+0x10>
    80003b44:	00f53023          	sd	a5,0(a0)
    80003b48:	ffffe097          	auipc	ra,0xffffe
    80003b4c:	c38080e7          	jalr	-968(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003b50:	00048513          	mv	a0,s1
    80003b54:	ffffe097          	auipc	ra,0xffffe
    80003b58:	bdc080e7          	jalr	-1060(ra) # 80001730 <_ZdlPv>
    80003b5c:	01813083          	ld	ra,24(sp)
    80003b60:	01013403          	ld	s0,16(sp)
    80003b64:	00813483          	ld	s1,8(sp)
    80003b68:	02010113          	addi	sp,sp,32
    80003b6c:	00008067          	ret

0000000080003b70 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003b70:	ff010113          	addi	sp,sp,-16
    80003b74:	00113423          	sd	ra,8(sp)
    80003b78:	00813023          	sd	s0,0(sp)
    80003b7c:	01010413          	addi	s0,sp,16
    80003b80:	00005797          	auipc	a5,0x5
    80003b84:	0f078793          	addi	a5,a5,240 # 80008c70 <_ZTV16ProducerKeyboard+0x10>
    80003b88:	00f53023          	sd	a5,0(a0)
    80003b8c:	ffffe097          	auipc	ra,0xffffe
    80003b90:	bf4080e7          	jalr	-1036(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003b94:	00813083          	ld	ra,8(sp)
    80003b98:	00013403          	ld	s0,0(sp)
    80003b9c:	01010113          	addi	sp,sp,16
    80003ba0:	00008067          	ret

0000000080003ba4 <_ZN16ProducerKeyboardD0Ev>:
    80003ba4:	fe010113          	addi	sp,sp,-32
    80003ba8:	00113c23          	sd	ra,24(sp)
    80003bac:	00813823          	sd	s0,16(sp)
    80003bb0:	00913423          	sd	s1,8(sp)
    80003bb4:	02010413          	addi	s0,sp,32
    80003bb8:	00050493          	mv	s1,a0
    80003bbc:	00005797          	auipc	a5,0x5
    80003bc0:	0b478793          	addi	a5,a5,180 # 80008c70 <_ZTV16ProducerKeyboard+0x10>
    80003bc4:	00f53023          	sd	a5,0(a0)
    80003bc8:	ffffe097          	auipc	ra,0xffffe
    80003bcc:	bb8080e7          	jalr	-1096(ra) # 80001780 <_ZN6ThreadD1Ev>
    80003bd0:	00048513          	mv	a0,s1
    80003bd4:	ffffe097          	auipc	ra,0xffffe
    80003bd8:	b5c080e7          	jalr	-1188(ra) # 80001730 <_ZdlPv>
    80003bdc:	01813083          	ld	ra,24(sp)
    80003be0:	01013403          	ld	s0,16(sp)
    80003be4:	00813483          	ld	s1,8(sp)
    80003be8:	02010113          	addi	sp,sp,32
    80003bec:	00008067          	ret

0000000080003bf0 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003bf0:	ff010113          	addi	sp,sp,-16
    80003bf4:	00113423          	sd	ra,8(sp)
    80003bf8:	00813023          	sd	s0,0(sp)
    80003bfc:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003c00:	02053583          	ld	a1,32(a0)
    80003c04:	fffff097          	auipc	ra,0xfffff
    80003c08:	7e4080e7          	jalr	2020(ra) # 800033e8 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003c0c:	00813083          	ld	ra,8(sp)
    80003c10:	00013403          	ld	s0,0(sp)
    80003c14:	01010113          	addi	sp,sp,16
    80003c18:	00008067          	ret

0000000080003c1c <_ZN12ProducerSync3runEv>:
    void run() override {
    80003c1c:	ff010113          	addi	sp,sp,-16
    80003c20:	00113423          	sd	ra,8(sp)
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	01010413          	addi	s0,sp,16
        producer(td);
    80003c2c:	02053583          	ld	a1,32(a0)
    80003c30:	00000097          	auipc	ra,0x0
    80003c34:	878080e7          	jalr	-1928(ra) # 800034a8 <_ZN12ProducerSync8producerEPv>
    }
    80003c38:	00813083          	ld	ra,8(sp)
    80003c3c:	00013403          	ld	s0,0(sp)
    80003c40:	01010113          	addi	sp,sp,16
    80003c44:	00008067          	ret

0000000080003c48 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003c48:	ff010113          	addi	sp,sp,-16
    80003c4c:	00113423          	sd	ra,8(sp)
    80003c50:	00813023          	sd	s0,0(sp)
    80003c54:	01010413          	addi	s0,sp,16
        consumer(td);
    80003c58:	02053583          	ld	a1,32(a0)
    80003c5c:	00000097          	auipc	ra,0x0
    80003c60:	8e0080e7          	jalr	-1824(ra) # 8000353c <_ZN12ConsumerSync8consumerEPv>
    }
    80003c64:	00813083          	ld	ra,8(sp)
    80003c68:	00013403          	ld	s0,0(sp)
    80003c6c:	01010113          	addi	sp,sp,16
    80003c70:	00008067          	ret

0000000080003c74 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003c74:	fe010113          	addi	sp,sp,-32
    80003c78:	00113c23          	sd	ra,24(sp)
    80003c7c:	00813823          	sd	s0,16(sp)
    80003c80:	00913423          	sd	s1,8(sp)
    80003c84:	02010413          	addi	s0,sp,32
    80003c88:	00050493          	mv	s1,a0
    LOCK();
    80003c8c:	00100613          	li	a2,1
    80003c90:	00000593          	li	a1,0
    80003c94:	00005517          	auipc	a0,0x5
    80003c98:	10c50513          	addi	a0,a0,268 # 80008da0 <lockPrint>
    80003c9c:	ffffd097          	auipc	ra,0xffffd
    80003ca0:	364080e7          	jalr	868(ra) # 80001000 <copy_and_swap>
    80003ca4:	00050863          	beqz	a0,80003cb4 <_Z11printStringPKc+0x40>
    80003ca8:	ffffd097          	auipc	ra,0xffffd
    80003cac:	544080e7          	jalr	1348(ra) # 800011ec <_Z15thread_dispatchv>
    80003cb0:	fddff06f          	j	80003c8c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003cb4:	0004c503          	lbu	a0,0(s1)
    80003cb8:	00050a63          	beqz	a0,80003ccc <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003cbc:	ffffd097          	auipc	ra,0xffffd
    80003cc0:	62c080e7          	jalr	1580(ra) # 800012e8 <_Z4putcc>
        string++;
    80003cc4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003cc8:	fedff06f          	j	80003cb4 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003ccc:	00000613          	li	a2,0
    80003cd0:	00100593          	li	a1,1
    80003cd4:	00005517          	auipc	a0,0x5
    80003cd8:	0cc50513          	addi	a0,a0,204 # 80008da0 <lockPrint>
    80003cdc:	ffffd097          	auipc	ra,0xffffd
    80003ce0:	324080e7          	jalr	804(ra) # 80001000 <copy_and_swap>
    80003ce4:	fe0514e3          	bnez	a0,80003ccc <_Z11printStringPKc+0x58>
}
    80003ce8:	01813083          	ld	ra,24(sp)
    80003cec:	01013403          	ld	s0,16(sp)
    80003cf0:	00813483          	ld	s1,8(sp)
    80003cf4:	02010113          	addi	sp,sp,32
    80003cf8:	00008067          	ret

0000000080003cfc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003cfc:	fd010113          	addi	sp,sp,-48
    80003d00:	02113423          	sd	ra,40(sp)
    80003d04:	02813023          	sd	s0,32(sp)
    80003d08:	00913c23          	sd	s1,24(sp)
    80003d0c:	01213823          	sd	s2,16(sp)
    80003d10:	01313423          	sd	s3,8(sp)
    80003d14:	01413023          	sd	s4,0(sp)
    80003d18:	03010413          	addi	s0,sp,48
    80003d1c:	00050993          	mv	s3,a0
    80003d20:	00058a13          	mv	s4,a1
    LOCK();
    80003d24:	00100613          	li	a2,1
    80003d28:	00000593          	li	a1,0
    80003d2c:	00005517          	auipc	a0,0x5
    80003d30:	07450513          	addi	a0,a0,116 # 80008da0 <lockPrint>
    80003d34:	ffffd097          	auipc	ra,0xffffd
    80003d38:	2cc080e7          	jalr	716(ra) # 80001000 <copy_and_swap>
    80003d3c:	00050863          	beqz	a0,80003d4c <_Z9getStringPci+0x50>
    80003d40:	ffffd097          	auipc	ra,0xffffd
    80003d44:	4ac080e7          	jalr	1196(ra) # 800011ec <_Z15thread_dispatchv>
    80003d48:	fddff06f          	j	80003d24 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003d4c:	00000913          	li	s2,0
    80003d50:	00090493          	mv	s1,s2
    80003d54:	0019091b          	addiw	s2,s2,1
    80003d58:	03495a63          	bge	s2,s4,80003d8c <_Z9getStringPci+0x90>
        cc = getc();
    80003d5c:	ffffd097          	auipc	ra,0xffffd
    80003d60:	564080e7          	jalr	1380(ra) # 800012c0 <_Z4getcv>
        if(cc < 1)
    80003d64:	02050463          	beqz	a0,80003d8c <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003d68:	009984b3          	add	s1,s3,s1
    80003d6c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003d70:	00a00793          	li	a5,10
    80003d74:	00f50a63          	beq	a0,a5,80003d88 <_Z9getStringPci+0x8c>
    80003d78:	00d00793          	li	a5,13
    80003d7c:	fcf51ae3          	bne	a0,a5,80003d50 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003d80:	00090493          	mv	s1,s2
    80003d84:	0080006f          	j	80003d8c <_Z9getStringPci+0x90>
    80003d88:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003d8c:	009984b3          	add	s1,s3,s1
    80003d90:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003d94:	00000613          	li	a2,0
    80003d98:	00100593          	li	a1,1
    80003d9c:	00005517          	auipc	a0,0x5
    80003da0:	00450513          	addi	a0,a0,4 # 80008da0 <lockPrint>
    80003da4:	ffffd097          	auipc	ra,0xffffd
    80003da8:	25c080e7          	jalr	604(ra) # 80001000 <copy_and_swap>
    80003dac:	fe0514e3          	bnez	a0,80003d94 <_Z9getStringPci+0x98>
    return buf;
}
    80003db0:	00098513          	mv	a0,s3
    80003db4:	02813083          	ld	ra,40(sp)
    80003db8:	02013403          	ld	s0,32(sp)
    80003dbc:	01813483          	ld	s1,24(sp)
    80003dc0:	01013903          	ld	s2,16(sp)
    80003dc4:	00813983          	ld	s3,8(sp)
    80003dc8:	00013a03          	ld	s4,0(sp)
    80003dcc:	03010113          	addi	sp,sp,48
    80003dd0:	00008067          	ret

0000000080003dd4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003dd4:	ff010113          	addi	sp,sp,-16
    80003dd8:	00813423          	sd	s0,8(sp)
    80003ddc:	01010413          	addi	s0,sp,16
    80003de0:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003de4:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003de8:	0006c603          	lbu	a2,0(a3)
    80003dec:	fd06071b          	addiw	a4,a2,-48
    80003df0:	0ff77713          	andi	a4,a4,255
    80003df4:	00900793          	li	a5,9
    80003df8:	02e7e063          	bltu	a5,a4,80003e18 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003dfc:	0025179b          	slliw	a5,a0,0x2
    80003e00:	00a787bb          	addw	a5,a5,a0
    80003e04:	0017979b          	slliw	a5,a5,0x1
    80003e08:	00168693          	addi	a3,a3,1
    80003e0c:	00c787bb          	addw	a5,a5,a2
    80003e10:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003e14:	fd5ff06f          	j	80003de8 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003e18:	00813403          	ld	s0,8(sp)
    80003e1c:	01010113          	addi	sp,sp,16
    80003e20:	00008067          	ret

0000000080003e24 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003e24:	fc010113          	addi	sp,sp,-64
    80003e28:	02113c23          	sd	ra,56(sp)
    80003e2c:	02813823          	sd	s0,48(sp)
    80003e30:	02913423          	sd	s1,40(sp)
    80003e34:	03213023          	sd	s2,32(sp)
    80003e38:	01313c23          	sd	s3,24(sp)
    80003e3c:	04010413          	addi	s0,sp,64
    80003e40:	00050493          	mv	s1,a0
    80003e44:	00058913          	mv	s2,a1
    80003e48:	00060993          	mv	s3,a2
    LOCK();
    80003e4c:	00100613          	li	a2,1
    80003e50:	00000593          	li	a1,0
    80003e54:	00005517          	auipc	a0,0x5
    80003e58:	f4c50513          	addi	a0,a0,-180 # 80008da0 <lockPrint>
    80003e5c:	ffffd097          	auipc	ra,0xffffd
    80003e60:	1a4080e7          	jalr	420(ra) # 80001000 <copy_and_swap>
    80003e64:	00050863          	beqz	a0,80003e74 <_Z8printIntiii+0x50>
    80003e68:	ffffd097          	auipc	ra,0xffffd
    80003e6c:	384080e7          	jalr	900(ra) # 800011ec <_Z15thread_dispatchv>
    80003e70:	fddff06f          	j	80003e4c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80003e74:	00098463          	beqz	s3,80003e7c <_Z8printIntiii+0x58>
    80003e78:	0804c463          	bltz	s1,80003f00 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80003e7c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80003e80:	00000593          	li	a1,0
    }

    i = 0;
    80003e84:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80003e88:	0009079b          	sext.w	a5,s2
    80003e8c:	0325773b          	remuw	a4,a0,s2
    80003e90:	00048613          	mv	a2,s1
    80003e94:	0014849b          	addiw	s1,s1,1
    80003e98:	02071693          	slli	a3,a4,0x20
    80003e9c:	0206d693          	srli	a3,a3,0x20
    80003ea0:	00005717          	auipc	a4,0x5
    80003ea4:	e3870713          	addi	a4,a4,-456 # 80008cd8 <digits>
    80003ea8:	00d70733          	add	a4,a4,a3
    80003eac:	00074683          	lbu	a3,0(a4)
    80003eb0:	fd040713          	addi	a4,s0,-48
    80003eb4:	00c70733          	add	a4,a4,a2
    80003eb8:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80003ebc:	0005071b          	sext.w	a4,a0
    80003ec0:	0325553b          	divuw	a0,a0,s2
    80003ec4:	fcf772e3          	bgeu	a4,a5,80003e88 <_Z8printIntiii+0x64>
    if(neg)
    80003ec8:	00058c63          	beqz	a1,80003ee0 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80003ecc:	fd040793          	addi	a5,s0,-48
    80003ed0:	009784b3          	add	s1,a5,s1
    80003ed4:	02d00793          	li	a5,45
    80003ed8:	fef48823          	sb	a5,-16(s1)
    80003edc:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80003ee0:	fff4849b          	addiw	s1,s1,-1
    80003ee4:	0204c463          	bltz	s1,80003f0c <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80003ee8:	fd040793          	addi	a5,s0,-48
    80003eec:	009787b3          	add	a5,a5,s1
    80003ef0:	ff07c503          	lbu	a0,-16(a5)
    80003ef4:	ffffd097          	auipc	ra,0xffffd
    80003ef8:	3f4080e7          	jalr	1012(ra) # 800012e8 <_Z4putcc>
    80003efc:	fe5ff06f          	j	80003ee0 <_Z8printIntiii+0xbc>
        x = -xx;
    80003f00:	4090053b          	negw	a0,s1
        neg = 1;
    80003f04:	00100593          	li	a1,1
        x = -xx;
    80003f08:	f7dff06f          	j	80003e84 <_Z8printIntiii+0x60>

    UNLOCK();
    80003f0c:	00000613          	li	a2,0
    80003f10:	00100593          	li	a1,1
    80003f14:	00005517          	auipc	a0,0x5
    80003f18:	e8c50513          	addi	a0,a0,-372 # 80008da0 <lockPrint>
    80003f1c:	ffffd097          	auipc	ra,0xffffd
    80003f20:	0e4080e7          	jalr	228(ra) # 80001000 <copy_and_swap>
    80003f24:	fe0514e3          	bnez	a0,80003f0c <_Z8printIntiii+0xe8>
    80003f28:	03813083          	ld	ra,56(sp)
    80003f2c:	03013403          	ld	s0,48(sp)
    80003f30:	02813483          	ld	s1,40(sp)
    80003f34:	02013903          	ld	s2,32(sp)
    80003f38:	01813983          	ld	s3,24(sp)
    80003f3c:	04010113          	addi	sp,sp,64
    80003f40:	00008067          	ret

0000000080003f44 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80003f44:	fd010113          	addi	sp,sp,-48
    80003f48:	02113423          	sd	ra,40(sp)
    80003f4c:	02813023          	sd	s0,32(sp)
    80003f50:	00913c23          	sd	s1,24(sp)
    80003f54:	01213823          	sd	s2,16(sp)
    80003f58:	01313423          	sd	s3,8(sp)
    80003f5c:	03010413          	addi	s0,sp,48
    80003f60:	00050493          	mv	s1,a0
    80003f64:	00058913          	mv	s2,a1
    80003f68:	0015879b          	addiw	a5,a1,1
    80003f6c:	0007851b          	sext.w	a0,a5
    80003f70:	00f4a023          	sw	a5,0(s1)
    80003f74:	0004a823          	sw	zero,16(s1)
    80003f78:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80003f7c:	00251513          	slli	a0,a0,0x2
    80003f80:	ffffd097          	auipc	ra,0xffffd
    80003f84:	1c4080e7          	jalr	452(ra) # 80001144 <_Z9mem_allocm>
    80003f88:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80003f8c:	01000513          	li	a0,16
    80003f90:	ffffd097          	auipc	ra,0xffffd
    80003f94:	750080e7          	jalr	1872(ra) # 800016e0 <_Znwm>
    80003f98:	00050993          	mv	s3,a0
    80003f9c:	00000593          	li	a1,0
    80003fa0:	ffffe097          	auipc	ra,0xffffe
    80003fa4:	a7c080e7          	jalr	-1412(ra) # 80001a1c <_ZN9SemaphoreC1Ej>
    80003fa8:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80003fac:	01000513          	li	a0,16
    80003fb0:	ffffd097          	auipc	ra,0xffffd
    80003fb4:	730080e7          	jalr	1840(ra) # 800016e0 <_Znwm>
    80003fb8:	00050993          	mv	s3,a0
    80003fbc:	00090593          	mv	a1,s2
    80003fc0:	ffffe097          	auipc	ra,0xffffe
    80003fc4:	a5c080e7          	jalr	-1444(ra) # 80001a1c <_ZN9SemaphoreC1Ej>
    80003fc8:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80003fcc:	01000513          	li	a0,16
    80003fd0:	ffffd097          	auipc	ra,0xffffd
    80003fd4:	710080e7          	jalr	1808(ra) # 800016e0 <_Znwm>
    80003fd8:	00050913          	mv	s2,a0
    80003fdc:	00100593          	li	a1,1
    80003fe0:	ffffe097          	auipc	ra,0xffffe
    80003fe4:	a3c080e7          	jalr	-1476(ra) # 80001a1c <_ZN9SemaphoreC1Ej>
    80003fe8:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80003fec:	01000513          	li	a0,16
    80003ff0:	ffffd097          	auipc	ra,0xffffd
    80003ff4:	6f0080e7          	jalr	1776(ra) # 800016e0 <_Znwm>
    80003ff8:	00050913          	mv	s2,a0
    80003ffc:	00100593          	li	a1,1
    80004000:	ffffe097          	auipc	ra,0xffffe
    80004004:	a1c080e7          	jalr	-1508(ra) # 80001a1c <_ZN9SemaphoreC1Ej>
    80004008:	0324b823          	sd	s2,48(s1)
}
    8000400c:	02813083          	ld	ra,40(sp)
    80004010:	02013403          	ld	s0,32(sp)
    80004014:	01813483          	ld	s1,24(sp)
    80004018:	01013903          	ld	s2,16(sp)
    8000401c:	00813983          	ld	s3,8(sp)
    80004020:	03010113          	addi	sp,sp,48
    80004024:	00008067          	ret
    80004028:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    8000402c:	00098513          	mv	a0,s3
    80004030:	ffffd097          	auipc	ra,0xffffd
    80004034:	700080e7          	jalr	1792(ra) # 80001730 <_ZdlPv>
    80004038:	00048513          	mv	a0,s1
    8000403c:	00006097          	auipc	ra,0x6
    80004040:	e3c080e7          	jalr	-452(ra) # 80009e78 <_Unwind_Resume>
    80004044:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004048:	00098513          	mv	a0,s3
    8000404c:	ffffd097          	auipc	ra,0xffffd
    80004050:	6e4080e7          	jalr	1764(ra) # 80001730 <_ZdlPv>
    80004054:	00048513          	mv	a0,s1
    80004058:	00006097          	auipc	ra,0x6
    8000405c:	e20080e7          	jalr	-480(ra) # 80009e78 <_Unwind_Resume>
    80004060:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004064:	00090513          	mv	a0,s2
    80004068:	ffffd097          	auipc	ra,0xffffd
    8000406c:	6c8080e7          	jalr	1736(ra) # 80001730 <_ZdlPv>
    80004070:	00048513          	mv	a0,s1
    80004074:	00006097          	auipc	ra,0x6
    80004078:	e04080e7          	jalr	-508(ra) # 80009e78 <_Unwind_Resume>
    8000407c:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004080:	00090513          	mv	a0,s2
    80004084:	ffffd097          	auipc	ra,0xffffd
    80004088:	6ac080e7          	jalr	1708(ra) # 80001730 <_ZdlPv>
    8000408c:	00048513          	mv	a0,s1
    80004090:	00006097          	auipc	ra,0x6
    80004094:	de8080e7          	jalr	-536(ra) # 80009e78 <_Unwind_Resume>

0000000080004098 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004098:	fe010113          	addi	sp,sp,-32
    8000409c:	00113c23          	sd	ra,24(sp)
    800040a0:	00813823          	sd	s0,16(sp)
    800040a4:	00913423          	sd	s1,8(sp)
    800040a8:	01213023          	sd	s2,0(sp)
    800040ac:	02010413          	addi	s0,sp,32
    800040b0:	00050493          	mv	s1,a0
    800040b4:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800040b8:	01853503          	ld	a0,24(a0)
    800040bc:	ffffe097          	auipc	ra,0xffffe
    800040c0:	908080e7          	jalr	-1784(ra) # 800019c4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800040c4:	0304b503          	ld	a0,48(s1)
    800040c8:	ffffe097          	auipc	ra,0xffffe
    800040cc:	8fc080e7          	jalr	-1796(ra) # 800019c4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800040d0:	0084b783          	ld	a5,8(s1)
    800040d4:	0144a703          	lw	a4,20(s1)
    800040d8:	00271713          	slli	a4,a4,0x2
    800040dc:	00e787b3          	add	a5,a5,a4
    800040e0:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800040e4:	0144a783          	lw	a5,20(s1)
    800040e8:	0017879b          	addiw	a5,a5,1
    800040ec:	0004a703          	lw	a4,0(s1)
    800040f0:	02e7e7bb          	remw	a5,a5,a4
    800040f4:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800040f8:	0304b503          	ld	a0,48(s1)
    800040fc:	ffffe097          	auipc	ra,0xffffe
    80004100:	8f4080e7          	jalr	-1804(ra) # 800019f0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004104:	0204b503          	ld	a0,32(s1)
    80004108:	ffffe097          	auipc	ra,0xffffe
    8000410c:	8e8080e7          	jalr	-1816(ra) # 800019f0 <_ZN9Semaphore6signalEv>

}
    80004110:	01813083          	ld	ra,24(sp)
    80004114:	01013403          	ld	s0,16(sp)
    80004118:	00813483          	ld	s1,8(sp)
    8000411c:	00013903          	ld	s2,0(sp)
    80004120:	02010113          	addi	sp,sp,32
    80004124:	00008067          	ret

0000000080004128 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004128:	fe010113          	addi	sp,sp,-32
    8000412c:	00113c23          	sd	ra,24(sp)
    80004130:	00813823          	sd	s0,16(sp)
    80004134:	00913423          	sd	s1,8(sp)
    80004138:	01213023          	sd	s2,0(sp)
    8000413c:	02010413          	addi	s0,sp,32
    80004140:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004144:	02053503          	ld	a0,32(a0)
    80004148:	ffffe097          	auipc	ra,0xffffe
    8000414c:	87c080e7          	jalr	-1924(ra) # 800019c4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004150:	0284b503          	ld	a0,40(s1)
    80004154:	ffffe097          	auipc	ra,0xffffe
    80004158:	870080e7          	jalr	-1936(ra) # 800019c4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    8000415c:	0084b703          	ld	a4,8(s1)
    80004160:	0104a783          	lw	a5,16(s1)
    80004164:	00279693          	slli	a3,a5,0x2
    80004168:	00d70733          	add	a4,a4,a3
    8000416c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004170:	0017879b          	addiw	a5,a5,1
    80004174:	0004a703          	lw	a4,0(s1)
    80004178:	02e7e7bb          	remw	a5,a5,a4
    8000417c:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004180:	0284b503          	ld	a0,40(s1)
    80004184:	ffffe097          	auipc	ra,0xffffe
    80004188:	86c080e7          	jalr	-1940(ra) # 800019f0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    8000418c:	0184b503          	ld	a0,24(s1)
    80004190:	ffffe097          	auipc	ra,0xffffe
    80004194:	860080e7          	jalr	-1952(ra) # 800019f0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004198:	00090513          	mv	a0,s2
    8000419c:	01813083          	ld	ra,24(sp)
    800041a0:	01013403          	ld	s0,16(sp)
    800041a4:	00813483          	ld	s1,8(sp)
    800041a8:	00013903          	ld	s2,0(sp)
    800041ac:	02010113          	addi	sp,sp,32
    800041b0:	00008067          	ret

00000000800041b4 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800041b4:	fe010113          	addi	sp,sp,-32
    800041b8:	00113c23          	sd	ra,24(sp)
    800041bc:	00813823          	sd	s0,16(sp)
    800041c0:	00913423          	sd	s1,8(sp)
    800041c4:	01213023          	sd	s2,0(sp)
    800041c8:	02010413          	addi	s0,sp,32
    800041cc:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800041d0:	02853503          	ld	a0,40(a0)
    800041d4:	ffffd097          	auipc	ra,0xffffd
    800041d8:	7f0080e7          	jalr	2032(ra) # 800019c4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    800041dc:	0304b503          	ld	a0,48(s1)
    800041e0:	ffffd097          	auipc	ra,0xffffd
    800041e4:	7e4080e7          	jalr	2020(ra) # 800019c4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    800041e8:	0144a783          	lw	a5,20(s1)
    800041ec:	0104a903          	lw	s2,16(s1)
    800041f0:	0327ce63          	blt	a5,s2,8000422c <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800041f4:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800041f8:	0304b503          	ld	a0,48(s1)
    800041fc:	ffffd097          	auipc	ra,0xffffd
    80004200:	7f4080e7          	jalr	2036(ra) # 800019f0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004204:	0284b503          	ld	a0,40(s1)
    80004208:	ffffd097          	auipc	ra,0xffffd
    8000420c:	7e8080e7          	jalr	2024(ra) # 800019f0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004210:	00090513          	mv	a0,s2
    80004214:	01813083          	ld	ra,24(sp)
    80004218:	01013403          	ld	s0,16(sp)
    8000421c:	00813483          	ld	s1,8(sp)
    80004220:	00013903          	ld	s2,0(sp)
    80004224:	02010113          	addi	sp,sp,32
    80004228:	00008067          	ret
        ret = cap - head + tail;
    8000422c:	0004a703          	lw	a4,0(s1)
    80004230:	4127093b          	subw	s2,a4,s2
    80004234:	00f9093b          	addw	s2,s2,a5
    80004238:	fc1ff06f          	j	800041f8 <_ZN9BufferCPP6getCntEv+0x44>

000000008000423c <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    8000423c:	fe010113          	addi	sp,sp,-32
    80004240:	00113c23          	sd	ra,24(sp)
    80004244:	00813823          	sd	s0,16(sp)
    80004248:	00913423          	sd	s1,8(sp)
    8000424c:	02010413          	addi	s0,sp,32
    80004250:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004254:	00a00513          	li	a0,10
    80004258:	ffffd097          	auipc	ra,0xffffd
    8000425c:	634080e7          	jalr	1588(ra) # 8000188c <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004260:	00003517          	auipc	a0,0x3
    80004264:	22850513          	addi	a0,a0,552 # 80007488 <kvmincrease+0xa28>
    80004268:	00000097          	auipc	ra,0x0
    8000426c:	a0c080e7          	jalr	-1524(ra) # 80003c74 <_Z11printStringPKc>
    while (getCnt()) {
    80004270:	00048513          	mv	a0,s1
    80004274:	00000097          	auipc	ra,0x0
    80004278:	f40080e7          	jalr	-192(ra) # 800041b4 <_ZN9BufferCPP6getCntEv>
    8000427c:	02050c63          	beqz	a0,800042b4 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004280:	0084b783          	ld	a5,8(s1)
    80004284:	0104a703          	lw	a4,16(s1)
    80004288:	00271713          	slli	a4,a4,0x2
    8000428c:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004290:	0007c503          	lbu	a0,0(a5)
    80004294:	ffffd097          	auipc	ra,0xffffd
    80004298:	5f8080e7          	jalr	1528(ra) # 8000188c <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    8000429c:	0104a783          	lw	a5,16(s1)
    800042a0:	0017879b          	addiw	a5,a5,1
    800042a4:	0004a703          	lw	a4,0(s1)
    800042a8:	02e7e7bb          	remw	a5,a5,a4
    800042ac:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800042b0:	fc1ff06f          	j	80004270 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800042b4:	02100513          	li	a0,33
    800042b8:	ffffd097          	auipc	ra,0xffffd
    800042bc:	5d4080e7          	jalr	1492(ra) # 8000188c <_ZN7Console4putcEc>
    Console::putc('\n');
    800042c0:	00a00513          	li	a0,10
    800042c4:	ffffd097          	auipc	ra,0xffffd
    800042c8:	5c8080e7          	jalr	1480(ra) # 8000188c <_ZN7Console4putcEc>
    mem_free(buffer);
    800042cc:	0084b503          	ld	a0,8(s1)
    800042d0:	ffffd097          	auipc	ra,0xffffd
    800042d4:	e9c080e7          	jalr	-356(ra) # 8000116c <_Z8mem_freePv>
    delete itemAvailable;
    800042d8:	0204b503          	ld	a0,32(s1)
    800042dc:	00050863          	beqz	a0,800042ec <_ZN9BufferCPPD1Ev+0xb0>
    800042e0:	00053783          	ld	a5,0(a0)
    800042e4:	0087b783          	ld	a5,8(a5)
    800042e8:	000780e7          	jalr	a5
    delete spaceAvailable;
    800042ec:	0184b503          	ld	a0,24(s1)
    800042f0:	00050863          	beqz	a0,80004300 <_ZN9BufferCPPD1Ev+0xc4>
    800042f4:	00053783          	ld	a5,0(a0)
    800042f8:	0087b783          	ld	a5,8(a5)
    800042fc:	000780e7          	jalr	a5
    delete mutexTail;
    80004300:	0304b503          	ld	a0,48(s1)
    80004304:	00050863          	beqz	a0,80004314 <_ZN9BufferCPPD1Ev+0xd8>
    80004308:	00053783          	ld	a5,0(a0)
    8000430c:	0087b783          	ld	a5,8(a5)
    80004310:	000780e7          	jalr	a5
    delete mutexHead;
    80004314:	0284b503          	ld	a0,40(s1)
    80004318:	00050863          	beqz	a0,80004328 <_ZN9BufferCPPD1Ev+0xec>
    8000431c:	00053783          	ld	a5,0(a0)
    80004320:	0087b783          	ld	a5,8(a5)
    80004324:	000780e7          	jalr	a5
}
    80004328:	01813083          	ld	ra,24(sp)
    8000432c:	01013403          	ld	s0,16(sp)
    80004330:	00813483          	ld	s1,8(sp)
    80004334:	02010113          	addi	sp,sp,32
    80004338:	00008067          	ret

000000008000433c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000433c:	fe010113          	addi	sp,sp,-32
    80004340:	00113c23          	sd	ra,24(sp)
    80004344:	00813823          	sd	s0,16(sp)
    80004348:	00913423          	sd	s1,8(sp)
    8000434c:	01213023          	sd	s2,0(sp)
    80004350:	02010413          	addi	s0,sp,32
    80004354:	00050493          	mv	s1,a0
    80004358:	00058913          	mv	s2,a1
    8000435c:	0015879b          	addiw	a5,a1,1
    80004360:	0007851b          	sext.w	a0,a5
    80004364:	00f4a023          	sw	a5,0(s1)
    80004368:	0004a823          	sw	zero,16(s1)
    8000436c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004370:	00251513          	slli	a0,a0,0x2
    80004374:	ffffd097          	auipc	ra,0xffffd
    80004378:	dd0080e7          	jalr	-560(ra) # 80001144 <_Z9mem_allocm>
    8000437c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004380:	00000593          	li	a1,0
    80004384:	02048513          	addi	a0,s1,32
    80004388:	ffffd097          	auipc	ra,0xffffd
    8000438c:	e88080e7          	jalr	-376(ra) # 80001210 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80004390:	00090593          	mv	a1,s2
    80004394:	01848513          	addi	a0,s1,24
    80004398:	ffffd097          	auipc	ra,0xffffd
    8000439c:	e78080e7          	jalr	-392(ra) # 80001210 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    800043a0:	00100593          	li	a1,1
    800043a4:	02848513          	addi	a0,s1,40
    800043a8:	ffffd097          	auipc	ra,0xffffd
    800043ac:	e68080e7          	jalr	-408(ra) # 80001210 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    800043b0:	00100593          	li	a1,1
    800043b4:	03048513          	addi	a0,s1,48
    800043b8:	ffffd097          	auipc	ra,0xffffd
    800043bc:	e58080e7          	jalr	-424(ra) # 80001210 <_Z8sem_openPP4_semj>
}
    800043c0:	01813083          	ld	ra,24(sp)
    800043c4:	01013403          	ld	s0,16(sp)
    800043c8:	00813483          	ld	s1,8(sp)
    800043cc:	00013903          	ld	s2,0(sp)
    800043d0:	02010113          	addi	sp,sp,32
    800043d4:	00008067          	ret

00000000800043d8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800043d8:	fe010113          	addi	sp,sp,-32
    800043dc:	00113c23          	sd	ra,24(sp)
    800043e0:	00813823          	sd	s0,16(sp)
    800043e4:	00913423          	sd	s1,8(sp)
    800043e8:	01213023          	sd	s2,0(sp)
    800043ec:	02010413          	addi	s0,sp,32
    800043f0:	00050493          	mv	s1,a0
    800043f4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800043f8:	01853503          	ld	a0,24(a0)
    800043fc:	ffffd097          	auipc	ra,0xffffd
    80004400:	e6c080e7          	jalr	-404(ra) # 80001268 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004404:	0304b503          	ld	a0,48(s1)
    80004408:	ffffd097          	auipc	ra,0xffffd
    8000440c:	e60080e7          	jalr	-416(ra) # 80001268 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004410:	0084b783          	ld	a5,8(s1)
    80004414:	0144a703          	lw	a4,20(s1)
    80004418:	00271713          	slli	a4,a4,0x2
    8000441c:	00e787b3          	add	a5,a5,a4
    80004420:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004424:	0144a783          	lw	a5,20(s1)
    80004428:	0017879b          	addiw	a5,a5,1
    8000442c:	0004a703          	lw	a4,0(s1)
    80004430:	02e7e7bb          	remw	a5,a5,a4
    80004434:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004438:	0304b503          	ld	a0,48(s1)
    8000443c:	ffffd097          	auipc	ra,0xffffd
    80004440:	e58080e7          	jalr	-424(ra) # 80001294 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004444:	0204b503          	ld	a0,32(s1)
    80004448:	ffffd097          	auipc	ra,0xffffd
    8000444c:	e4c080e7          	jalr	-436(ra) # 80001294 <_Z10sem_signalP4_sem>

}
    80004450:	01813083          	ld	ra,24(sp)
    80004454:	01013403          	ld	s0,16(sp)
    80004458:	00813483          	ld	s1,8(sp)
    8000445c:	00013903          	ld	s2,0(sp)
    80004460:	02010113          	addi	sp,sp,32
    80004464:	00008067          	ret

0000000080004468 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004468:	fe010113          	addi	sp,sp,-32
    8000446c:	00113c23          	sd	ra,24(sp)
    80004470:	00813823          	sd	s0,16(sp)
    80004474:	00913423          	sd	s1,8(sp)
    80004478:	01213023          	sd	s2,0(sp)
    8000447c:	02010413          	addi	s0,sp,32
    80004480:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004484:	02053503          	ld	a0,32(a0)
    80004488:	ffffd097          	auipc	ra,0xffffd
    8000448c:	de0080e7          	jalr	-544(ra) # 80001268 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004490:	0284b503          	ld	a0,40(s1)
    80004494:	ffffd097          	auipc	ra,0xffffd
    80004498:	dd4080e7          	jalr	-556(ra) # 80001268 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    8000449c:	0084b703          	ld	a4,8(s1)
    800044a0:	0104a783          	lw	a5,16(s1)
    800044a4:	00279693          	slli	a3,a5,0x2
    800044a8:	00d70733          	add	a4,a4,a3
    800044ac:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    800044b0:	0017879b          	addiw	a5,a5,1
    800044b4:	0004a703          	lw	a4,0(s1)
    800044b8:	02e7e7bb          	remw	a5,a5,a4
    800044bc:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800044c0:	0284b503          	ld	a0,40(s1)
    800044c4:	ffffd097          	auipc	ra,0xffffd
    800044c8:	dd0080e7          	jalr	-560(ra) # 80001294 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    800044cc:	0184b503          	ld	a0,24(s1)
    800044d0:	ffffd097          	auipc	ra,0xffffd
    800044d4:	dc4080e7          	jalr	-572(ra) # 80001294 <_Z10sem_signalP4_sem>

    return ret;
}
    800044d8:	00090513          	mv	a0,s2
    800044dc:	01813083          	ld	ra,24(sp)
    800044e0:	01013403          	ld	s0,16(sp)
    800044e4:	00813483          	ld	s1,8(sp)
    800044e8:	00013903          	ld	s2,0(sp)
    800044ec:	02010113          	addi	sp,sp,32
    800044f0:	00008067          	ret

00000000800044f4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800044f4:	fe010113          	addi	sp,sp,-32
    800044f8:	00113c23          	sd	ra,24(sp)
    800044fc:	00813823          	sd	s0,16(sp)
    80004500:	00913423          	sd	s1,8(sp)
    80004504:	01213023          	sd	s2,0(sp)
    80004508:	02010413          	addi	s0,sp,32
    8000450c:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004510:	02853503          	ld	a0,40(a0)
    80004514:	ffffd097          	auipc	ra,0xffffd
    80004518:	d54080e7          	jalr	-684(ra) # 80001268 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    8000451c:	0304b503          	ld	a0,48(s1)
    80004520:	ffffd097          	auipc	ra,0xffffd
    80004524:	d48080e7          	jalr	-696(ra) # 80001268 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80004528:	0144a783          	lw	a5,20(s1)
    8000452c:	0104a903          	lw	s2,16(s1)
    80004530:	0327ce63          	blt	a5,s2,8000456c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004534:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004538:	0304b503          	ld	a0,48(s1)
    8000453c:	ffffd097          	auipc	ra,0xffffd
    80004540:	d58080e7          	jalr	-680(ra) # 80001294 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80004544:	0284b503          	ld	a0,40(s1)
    80004548:	ffffd097          	auipc	ra,0xffffd
    8000454c:	d4c080e7          	jalr	-692(ra) # 80001294 <_Z10sem_signalP4_sem>

    return ret;
}
    80004550:	00090513          	mv	a0,s2
    80004554:	01813083          	ld	ra,24(sp)
    80004558:	01013403          	ld	s0,16(sp)
    8000455c:	00813483          	ld	s1,8(sp)
    80004560:	00013903          	ld	s2,0(sp)
    80004564:	02010113          	addi	sp,sp,32
    80004568:	00008067          	ret
        ret = cap - head + tail;
    8000456c:	0004a703          	lw	a4,0(s1)
    80004570:	4127093b          	subw	s2,a4,s2
    80004574:	00f9093b          	addw	s2,s2,a5
    80004578:	fc1ff06f          	j	80004538 <_ZN6Buffer6getCntEv+0x44>

000000008000457c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000457c:	fe010113          	addi	sp,sp,-32
    80004580:	00113c23          	sd	ra,24(sp)
    80004584:	00813823          	sd	s0,16(sp)
    80004588:	00913423          	sd	s1,8(sp)
    8000458c:	02010413          	addi	s0,sp,32
    80004590:	00050493          	mv	s1,a0
    putc('\n');
    80004594:	00a00513          	li	a0,10
    80004598:	ffffd097          	auipc	ra,0xffffd
    8000459c:	d50080e7          	jalr	-688(ra) # 800012e8 <_Z4putcc>
    printString("Buffer deleted!\n");
    800045a0:	00003517          	auipc	a0,0x3
    800045a4:	ee850513          	addi	a0,a0,-280 # 80007488 <kvmincrease+0xa28>
    800045a8:	fffff097          	auipc	ra,0xfffff
    800045ac:	6cc080e7          	jalr	1740(ra) # 80003c74 <_Z11printStringPKc>
    while (getCnt() > 0) {
    800045b0:	00048513          	mv	a0,s1
    800045b4:	00000097          	auipc	ra,0x0
    800045b8:	f40080e7          	jalr	-192(ra) # 800044f4 <_ZN6Buffer6getCntEv>
    800045bc:	02a05c63          	blez	a0,800045f4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800045c0:	0084b783          	ld	a5,8(s1)
    800045c4:	0104a703          	lw	a4,16(s1)
    800045c8:	00271713          	slli	a4,a4,0x2
    800045cc:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800045d0:	0007c503          	lbu	a0,0(a5)
    800045d4:	ffffd097          	auipc	ra,0xffffd
    800045d8:	d14080e7          	jalr	-748(ra) # 800012e8 <_Z4putcc>
        head = (head + 1) % cap;
    800045dc:	0104a783          	lw	a5,16(s1)
    800045e0:	0017879b          	addiw	a5,a5,1
    800045e4:	0004a703          	lw	a4,0(s1)
    800045e8:	02e7e7bb          	remw	a5,a5,a4
    800045ec:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800045f0:	fc1ff06f          	j	800045b0 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800045f4:	02100513          	li	a0,33
    800045f8:	ffffd097          	auipc	ra,0xffffd
    800045fc:	cf0080e7          	jalr	-784(ra) # 800012e8 <_Z4putcc>
    putc('\n');
    80004600:	00a00513          	li	a0,10
    80004604:	ffffd097          	auipc	ra,0xffffd
    80004608:	ce4080e7          	jalr	-796(ra) # 800012e8 <_Z4putcc>
    mem_free(buffer);
    8000460c:	0084b503          	ld	a0,8(s1)
    80004610:	ffffd097          	auipc	ra,0xffffd
    80004614:	b5c080e7          	jalr	-1188(ra) # 8000116c <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004618:	0204b503          	ld	a0,32(s1)
    8000461c:	ffffd097          	auipc	ra,0xffffd
    80004620:	c20080e7          	jalr	-992(ra) # 8000123c <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80004624:	0184b503          	ld	a0,24(s1)
    80004628:	ffffd097          	auipc	ra,0xffffd
    8000462c:	c14080e7          	jalr	-1004(ra) # 8000123c <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80004630:	0304b503          	ld	a0,48(s1)
    80004634:	ffffd097          	auipc	ra,0xffffd
    80004638:	c08080e7          	jalr	-1016(ra) # 8000123c <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    8000463c:	0284b503          	ld	a0,40(s1)
    80004640:	ffffd097          	auipc	ra,0xffffd
    80004644:	bfc080e7          	jalr	-1028(ra) # 8000123c <_Z9sem_closeP4_sem>
}
    80004648:	01813083          	ld	ra,24(sp)
    8000464c:	01013403          	ld	s0,16(sp)
    80004650:	00813483          	ld	s1,8(sp)
    80004654:	02010113          	addi	sp,sp,32
    80004658:	00008067          	ret

000000008000465c <start>:
    8000465c:	ff010113          	addi	sp,sp,-16
    80004660:	00813423          	sd	s0,8(sp)
    80004664:	01010413          	addi	s0,sp,16
    80004668:	300027f3          	csrr	a5,mstatus
    8000466c:	ffffe737          	lui	a4,0xffffe
    80004670:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff47df>
    80004674:	00e7f7b3          	and	a5,a5,a4
    80004678:	00001737          	lui	a4,0x1
    8000467c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004680:	00e7e7b3          	or	a5,a5,a4
    80004684:	30079073          	csrw	mstatus,a5
    80004688:	00000797          	auipc	a5,0x0
    8000468c:	16078793          	addi	a5,a5,352 # 800047e8 <system_main>
    80004690:	34179073          	csrw	mepc,a5
    80004694:	00000793          	li	a5,0
    80004698:	18079073          	csrw	satp,a5
    8000469c:	000107b7          	lui	a5,0x10
    800046a0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800046a4:	30279073          	csrw	medeleg,a5
    800046a8:	30379073          	csrw	mideleg,a5
    800046ac:	104027f3          	csrr	a5,sie
    800046b0:	2227e793          	ori	a5,a5,546
    800046b4:	10479073          	csrw	sie,a5
    800046b8:	fff00793          	li	a5,-1
    800046bc:	00a7d793          	srli	a5,a5,0xa
    800046c0:	3b079073          	csrw	pmpaddr0,a5
    800046c4:	00f00793          	li	a5,15
    800046c8:	3a079073          	csrw	pmpcfg0,a5
    800046cc:	f14027f3          	csrr	a5,mhartid
    800046d0:	0200c737          	lui	a4,0x200c
    800046d4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800046d8:	0007869b          	sext.w	a3,a5
    800046dc:	00269713          	slli	a4,a3,0x2
    800046e0:	000f4637          	lui	a2,0xf4
    800046e4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800046e8:	00d70733          	add	a4,a4,a3
    800046ec:	0037979b          	slliw	a5,a5,0x3
    800046f0:	020046b7          	lui	a3,0x2004
    800046f4:	00d787b3          	add	a5,a5,a3
    800046f8:	00c585b3          	add	a1,a1,a2
    800046fc:	00371693          	slli	a3,a4,0x3
    80004700:	00004717          	auipc	a4,0x4
    80004704:	6b070713          	addi	a4,a4,1712 # 80008db0 <timer_scratch>
    80004708:	00b7b023          	sd	a1,0(a5)
    8000470c:	00d70733          	add	a4,a4,a3
    80004710:	00f73c23          	sd	a5,24(a4)
    80004714:	02c73023          	sd	a2,32(a4)
    80004718:	34071073          	csrw	mscratch,a4
    8000471c:	00000797          	auipc	a5,0x0
    80004720:	6e478793          	addi	a5,a5,1764 # 80004e00 <timervec>
    80004724:	30579073          	csrw	mtvec,a5
    80004728:	300027f3          	csrr	a5,mstatus
    8000472c:	0087e793          	ori	a5,a5,8
    80004730:	30079073          	csrw	mstatus,a5
    80004734:	304027f3          	csrr	a5,mie
    80004738:	0807e793          	ori	a5,a5,128
    8000473c:	30479073          	csrw	mie,a5
    80004740:	f14027f3          	csrr	a5,mhartid
    80004744:	0007879b          	sext.w	a5,a5
    80004748:	00078213          	mv	tp,a5
    8000474c:	30200073          	mret
    80004750:	00813403          	ld	s0,8(sp)
    80004754:	01010113          	addi	sp,sp,16
    80004758:	00008067          	ret

000000008000475c <timerinit>:
    8000475c:	ff010113          	addi	sp,sp,-16
    80004760:	00813423          	sd	s0,8(sp)
    80004764:	01010413          	addi	s0,sp,16
    80004768:	f14027f3          	csrr	a5,mhartid
    8000476c:	0200c737          	lui	a4,0x200c
    80004770:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004774:	0007869b          	sext.w	a3,a5
    80004778:	00269713          	slli	a4,a3,0x2
    8000477c:	000f4637          	lui	a2,0xf4
    80004780:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004784:	00d70733          	add	a4,a4,a3
    80004788:	0037979b          	slliw	a5,a5,0x3
    8000478c:	020046b7          	lui	a3,0x2004
    80004790:	00d787b3          	add	a5,a5,a3
    80004794:	00c585b3          	add	a1,a1,a2
    80004798:	00371693          	slli	a3,a4,0x3
    8000479c:	00004717          	auipc	a4,0x4
    800047a0:	61470713          	addi	a4,a4,1556 # 80008db0 <timer_scratch>
    800047a4:	00b7b023          	sd	a1,0(a5)
    800047a8:	00d70733          	add	a4,a4,a3
    800047ac:	00f73c23          	sd	a5,24(a4)
    800047b0:	02c73023          	sd	a2,32(a4)
    800047b4:	34071073          	csrw	mscratch,a4
    800047b8:	00000797          	auipc	a5,0x0
    800047bc:	64878793          	addi	a5,a5,1608 # 80004e00 <timervec>
    800047c0:	30579073          	csrw	mtvec,a5
    800047c4:	300027f3          	csrr	a5,mstatus
    800047c8:	0087e793          	ori	a5,a5,8
    800047cc:	30079073          	csrw	mstatus,a5
    800047d0:	304027f3          	csrr	a5,mie
    800047d4:	0807e793          	ori	a5,a5,128
    800047d8:	30479073          	csrw	mie,a5
    800047dc:	00813403          	ld	s0,8(sp)
    800047e0:	01010113          	addi	sp,sp,16
    800047e4:	00008067          	ret

00000000800047e8 <system_main>:
    800047e8:	fe010113          	addi	sp,sp,-32
    800047ec:	00813823          	sd	s0,16(sp)
    800047f0:	00913423          	sd	s1,8(sp)
    800047f4:	00113c23          	sd	ra,24(sp)
    800047f8:	02010413          	addi	s0,sp,32
    800047fc:	00000097          	auipc	ra,0x0
    80004800:	0c4080e7          	jalr	196(ra) # 800048c0 <cpuid>
    80004804:	00004497          	auipc	s1,0x4
    80004808:	52c48493          	addi	s1,s1,1324 # 80008d30 <started>
    8000480c:	02050263          	beqz	a0,80004830 <system_main+0x48>
    80004810:	0004a783          	lw	a5,0(s1)
    80004814:	0007879b          	sext.w	a5,a5
    80004818:	fe078ce3          	beqz	a5,80004810 <system_main+0x28>
    8000481c:	0ff0000f          	fence
    80004820:	00003517          	auipc	a0,0x3
    80004824:	cb050513          	addi	a0,a0,-848 # 800074d0 <kvmincrease+0xa70>
    80004828:	00001097          	auipc	ra,0x1
    8000482c:	a74080e7          	jalr	-1420(ra) # 8000529c <panic>
    80004830:	00001097          	auipc	ra,0x1
    80004834:	9c8080e7          	jalr	-1592(ra) # 800051f8 <consoleinit>
    80004838:	00001097          	auipc	ra,0x1
    8000483c:	154080e7          	jalr	340(ra) # 8000598c <printfinit>
    80004840:	00003517          	auipc	a0,0x3
    80004844:	93050513          	addi	a0,a0,-1744 # 80007170 <kvmincrease+0x710>
    80004848:	00001097          	auipc	ra,0x1
    8000484c:	ab0080e7          	jalr	-1360(ra) # 800052f8 <__printf>
    80004850:	00003517          	auipc	a0,0x3
    80004854:	c5050513          	addi	a0,a0,-944 # 800074a0 <kvmincrease+0xa40>
    80004858:	00001097          	auipc	ra,0x1
    8000485c:	aa0080e7          	jalr	-1376(ra) # 800052f8 <__printf>
    80004860:	00003517          	auipc	a0,0x3
    80004864:	91050513          	addi	a0,a0,-1776 # 80007170 <kvmincrease+0x710>
    80004868:	00001097          	auipc	ra,0x1
    8000486c:	a90080e7          	jalr	-1392(ra) # 800052f8 <__printf>
    80004870:	00001097          	auipc	ra,0x1
    80004874:	4a8080e7          	jalr	1192(ra) # 80005d18 <kinit>
    80004878:	00000097          	auipc	ra,0x0
    8000487c:	148080e7          	jalr	328(ra) # 800049c0 <trapinit>
    80004880:	00000097          	auipc	ra,0x0
    80004884:	16c080e7          	jalr	364(ra) # 800049ec <trapinithart>
    80004888:	00000097          	auipc	ra,0x0
    8000488c:	5b8080e7          	jalr	1464(ra) # 80004e40 <plicinit>
    80004890:	00000097          	auipc	ra,0x0
    80004894:	5d8080e7          	jalr	1496(ra) # 80004e68 <plicinithart>
    80004898:	00000097          	auipc	ra,0x0
    8000489c:	078080e7          	jalr	120(ra) # 80004910 <userinit>
    800048a0:	0ff0000f          	fence
    800048a4:	00100793          	li	a5,1
    800048a8:	00003517          	auipc	a0,0x3
    800048ac:	c1050513          	addi	a0,a0,-1008 # 800074b8 <kvmincrease+0xa58>
    800048b0:	00f4a023          	sw	a5,0(s1)
    800048b4:	00001097          	auipc	ra,0x1
    800048b8:	a44080e7          	jalr	-1468(ra) # 800052f8 <__printf>
    800048bc:	0000006f          	j	800048bc <system_main+0xd4>

00000000800048c0 <cpuid>:
    800048c0:	ff010113          	addi	sp,sp,-16
    800048c4:	00813423          	sd	s0,8(sp)
    800048c8:	01010413          	addi	s0,sp,16
    800048cc:	00020513          	mv	a0,tp
    800048d0:	00813403          	ld	s0,8(sp)
    800048d4:	0005051b          	sext.w	a0,a0
    800048d8:	01010113          	addi	sp,sp,16
    800048dc:	00008067          	ret

00000000800048e0 <mycpu>:
    800048e0:	ff010113          	addi	sp,sp,-16
    800048e4:	00813423          	sd	s0,8(sp)
    800048e8:	01010413          	addi	s0,sp,16
    800048ec:	00020793          	mv	a5,tp
    800048f0:	00813403          	ld	s0,8(sp)
    800048f4:	0007879b          	sext.w	a5,a5
    800048f8:	00779793          	slli	a5,a5,0x7
    800048fc:	00005517          	auipc	a0,0x5
    80004900:	4e450513          	addi	a0,a0,1252 # 80009de0 <cpus>
    80004904:	00f50533          	add	a0,a0,a5
    80004908:	01010113          	addi	sp,sp,16
    8000490c:	00008067          	ret

0000000080004910 <userinit>:
    80004910:	ff010113          	addi	sp,sp,-16
    80004914:	00813423          	sd	s0,8(sp)
    80004918:	01010413          	addi	s0,sp,16
    8000491c:	00813403          	ld	s0,8(sp)
    80004920:	01010113          	addi	sp,sp,16
    80004924:	ffffd317          	auipc	t1,0xffffd
    80004928:	d5430067          	jr	-684(t1) # 80001678 <main>

000000008000492c <either_copyout>:
    8000492c:	ff010113          	addi	sp,sp,-16
    80004930:	00813023          	sd	s0,0(sp)
    80004934:	00113423          	sd	ra,8(sp)
    80004938:	01010413          	addi	s0,sp,16
    8000493c:	02051663          	bnez	a0,80004968 <either_copyout+0x3c>
    80004940:	00058513          	mv	a0,a1
    80004944:	00060593          	mv	a1,a2
    80004948:	0006861b          	sext.w	a2,a3
    8000494c:	00002097          	auipc	ra,0x2
    80004950:	c58080e7          	jalr	-936(ra) # 800065a4 <__memmove>
    80004954:	00813083          	ld	ra,8(sp)
    80004958:	00013403          	ld	s0,0(sp)
    8000495c:	00000513          	li	a0,0
    80004960:	01010113          	addi	sp,sp,16
    80004964:	00008067          	ret
    80004968:	00003517          	auipc	a0,0x3
    8000496c:	b9050513          	addi	a0,a0,-1136 # 800074f8 <kvmincrease+0xa98>
    80004970:	00001097          	auipc	ra,0x1
    80004974:	92c080e7          	jalr	-1748(ra) # 8000529c <panic>

0000000080004978 <either_copyin>:
    80004978:	ff010113          	addi	sp,sp,-16
    8000497c:	00813023          	sd	s0,0(sp)
    80004980:	00113423          	sd	ra,8(sp)
    80004984:	01010413          	addi	s0,sp,16
    80004988:	02059463          	bnez	a1,800049b0 <either_copyin+0x38>
    8000498c:	00060593          	mv	a1,a2
    80004990:	0006861b          	sext.w	a2,a3
    80004994:	00002097          	auipc	ra,0x2
    80004998:	c10080e7          	jalr	-1008(ra) # 800065a4 <__memmove>
    8000499c:	00813083          	ld	ra,8(sp)
    800049a0:	00013403          	ld	s0,0(sp)
    800049a4:	00000513          	li	a0,0
    800049a8:	01010113          	addi	sp,sp,16
    800049ac:	00008067          	ret
    800049b0:	00003517          	auipc	a0,0x3
    800049b4:	b7050513          	addi	a0,a0,-1168 # 80007520 <kvmincrease+0xac0>
    800049b8:	00001097          	auipc	ra,0x1
    800049bc:	8e4080e7          	jalr	-1820(ra) # 8000529c <panic>

00000000800049c0 <trapinit>:
    800049c0:	ff010113          	addi	sp,sp,-16
    800049c4:	00813423          	sd	s0,8(sp)
    800049c8:	01010413          	addi	s0,sp,16
    800049cc:	00813403          	ld	s0,8(sp)
    800049d0:	00003597          	auipc	a1,0x3
    800049d4:	b7858593          	addi	a1,a1,-1160 # 80007548 <kvmincrease+0xae8>
    800049d8:	00005517          	auipc	a0,0x5
    800049dc:	48850513          	addi	a0,a0,1160 # 80009e60 <tickslock>
    800049e0:	01010113          	addi	sp,sp,16
    800049e4:	00001317          	auipc	t1,0x1
    800049e8:	5c430067          	jr	1476(t1) # 80005fa8 <initlock>

00000000800049ec <trapinithart>:
    800049ec:	ff010113          	addi	sp,sp,-16
    800049f0:	00813423          	sd	s0,8(sp)
    800049f4:	01010413          	addi	s0,sp,16
    800049f8:	00000797          	auipc	a5,0x0
    800049fc:	2f878793          	addi	a5,a5,760 # 80004cf0 <kernelvec>
    80004a00:	10579073          	csrw	stvec,a5
    80004a04:	00813403          	ld	s0,8(sp)
    80004a08:	01010113          	addi	sp,sp,16
    80004a0c:	00008067          	ret

0000000080004a10 <usertrap>:
    80004a10:	ff010113          	addi	sp,sp,-16
    80004a14:	00813423          	sd	s0,8(sp)
    80004a18:	01010413          	addi	s0,sp,16
    80004a1c:	00813403          	ld	s0,8(sp)
    80004a20:	01010113          	addi	sp,sp,16
    80004a24:	00008067          	ret

0000000080004a28 <usertrapret>:
    80004a28:	ff010113          	addi	sp,sp,-16
    80004a2c:	00813423          	sd	s0,8(sp)
    80004a30:	01010413          	addi	s0,sp,16
    80004a34:	00813403          	ld	s0,8(sp)
    80004a38:	01010113          	addi	sp,sp,16
    80004a3c:	00008067          	ret

0000000080004a40 <kerneltrap>:
    80004a40:	fe010113          	addi	sp,sp,-32
    80004a44:	00813823          	sd	s0,16(sp)
    80004a48:	00113c23          	sd	ra,24(sp)
    80004a4c:	00913423          	sd	s1,8(sp)
    80004a50:	02010413          	addi	s0,sp,32
    80004a54:	142025f3          	csrr	a1,scause
    80004a58:	100027f3          	csrr	a5,sstatus
    80004a5c:	0027f793          	andi	a5,a5,2
    80004a60:	10079c63          	bnez	a5,80004b78 <kerneltrap+0x138>
    80004a64:	142027f3          	csrr	a5,scause
    80004a68:	0207ce63          	bltz	a5,80004aa4 <kerneltrap+0x64>
    80004a6c:	00003517          	auipc	a0,0x3
    80004a70:	b2450513          	addi	a0,a0,-1244 # 80007590 <kvmincrease+0xb30>
    80004a74:	00001097          	auipc	ra,0x1
    80004a78:	884080e7          	jalr	-1916(ra) # 800052f8 <__printf>
    80004a7c:	141025f3          	csrr	a1,sepc
    80004a80:	14302673          	csrr	a2,stval
    80004a84:	00003517          	auipc	a0,0x3
    80004a88:	b1c50513          	addi	a0,a0,-1252 # 800075a0 <kvmincrease+0xb40>
    80004a8c:	00001097          	auipc	ra,0x1
    80004a90:	86c080e7          	jalr	-1940(ra) # 800052f8 <__printf>
    80004a94:	00003517          	auipc	a0,0x3
    80004a98:	b2450513          	addi	a0,a0,-1244 # 800075b8 <kvmincrease+0xb58>
    80004a9c:	00001097          	auipc	ra,0x1
    80004aa0:	800080e7          	jalr	-2048(ra) # 8000529c <panic>
    80004aa4:	0ff7f713          	andi	a4,a5,255
    80004aa8:	00900693          	li	a3,9
    80004aac:	04d70063          	beq	a4,a3,80004aec <kerneltrap+0xac>
    80004ab0:	fff00713          	li	a4,-1
    80004ab4:	03f71713          	slli	a4,a4,0x3f
    80004ab8:	00170713          	addi	a4,a4,1
    80004abc:	fae798e3          	bne	a5,a4,80004a6c <kerneltrap+0x2c>
    80004ac0:	00000097          	auipc	ra,0x0
    80004ac4:	e00080e7          	jalr	-512(ra) # 800048c0 <cpuid>
    80004ac8:	06050663          	beqz	a0,80004b34 <kerneltrap+0xf4>
    80004acc:	144027f3          	csrr	a5,sip
    80004ad0:	ffd7f793          	andi	a5,a5,-3
    80004ad4:	14479073          	csrw	sip,a5
    80004ad8:	01813083          	ld	ra,24(sp)
    80004adc:	01013403          	ld	s0,16(sp)
    80004ae0:	00813483          	ld	s1,8(sp)
    80004ae4:	02010113          	addi	sp,sp,32
    80004ae8:	00008067          	ret
    80004aec:	00000097          	auipc	ra,0x0
    80004af0:	3c8080e7          	jalr	968(ra) # 80004eb4 <plic_claim>
    80004af4:	00a00793          	li	a5,10
    80004af8:	00050493          	mv	s1,a0
    80004afc:	06f50863          	beq	a0,a5,80004b6c <kerneltrap+0x12c>
    80004b00:	fc050ce3          	beqz	a0,80004ad8 <kerneltrap+0x98>
    80004b04:	00050593          	mv	a1,a0
    80004b08:	00003517          	auipc	a0,0x3
    80004b0c:	a6850513          	addi	a0,a0,-1432 # 80007570 <kvmincrease+0xb10>
    80004b10:	00000097          	auipc	ra,0x0
    80004b14:	7e8080e7          	jalr	2024(ra) # 800052f8 <__printf>
    80004b18:	01013403          	ld	s0,16(sp)
    80004b1c:	01813083          	ld	ra,24(sp)
    80004b20:	00048513          	mv	a0,s1
    80004b24:	00813483          	ld	s1,8(sp)
    80004b28:	02010113          	addi	sp,sp,32
    80004b2c:	00000317          	auipc	t1,0x0
    80004b30:	3c030067          	jr	960(t1) # 80004eec <plic_complete>
    80004b34:	00005517          	auipc	a0,0x5
    80004b38:	32c50513          	addi	a0,a0,812 # 80009e60 <tickslock>
    80004b3c:	00001097          	auipc	ra,0x1
    80004b40:	490080e7          	jalr	1168(ra) # 80005fcc <acquire>
    80004b44:	00004717          	auipc	a4,0x4
    80004b48:	1f070713          	addi	a4,a4,496 # 80008d34 <ticks>
    80004b4c:	00072783          	lw	a5,0(a4)
    80004b50:	00005517          	auipc	a0,0x5
    80004b54:	31050513          	addi	a0,a0,784 # 80009e60 <tickslock>
    80004b58:	0017879b          	addiw	a5,a5,1
    80004b5c:	00f72023          	sw	a5,0(a4)
    80004b60:	00001097          	auipc	ra,0x1
    80004b64:	538080e7          	jalr	1336(ra) # 80006098 <release>
    80004b68:	f65ff06f          	j	80004acc <kerneltrap+0x8c>
    80004b6c:	00001097          	auipc	ra,0x1
    80004b70:	094080e7          	jalr	148(ra) # 80005c00 <uartintr>
    80004b74:	fa5ff06f          	j	80004b18 <kerneltrap+0xd8>
    80004b78:	00003517          	auipc	a0,0x3
    80004b7c:	9d850513          	addi	a0,a0,-1576 # 80007550 <kvmincrease+0xaf0>
    80004b80:	00000097          	auipc	ra,0x0
    80004b84:	71c080e7          	jalr	1820(ra) # 8000529c <panic>

0000000080004b88 <clockintr>:
    80004b88:	fe010113          	addi	sp,sp,-32
    80004b8c:	00813823          	sd	s0,16(sp)
    80004b90:	00913423          	sd	s1,8(sp)
    80004b94:	00113c23          	sd	ra,24(sp)
    80004b98:	02010413          	addi	s0,sp,32
    80004b9c:	00005497          	auipc	s1,0x5
    80004ba0:	2c448493          	addi	s1,s1,708 # 80009e60 <tickslock>
    80004ba4:	00048513          	mv	a0,s1
    80004ba8:	00001097          	auipc	ra,0x1
    80004bac:	424080e7          	jalr	1060(ra) # 80005fcc <acquire>
    80004bb0:	00004717          	auipc	a4,0x4
    80004bb4:	18470713          	addi	a4,a4,388 # 80008d34 <ticks>
    80004bb8:	00072783          	lw	a5,0(a4)
    80004bbc:	01013403          	ld	s0,16(sp)
    80004bc0:	01813083          	ld	ra,24(sp)
    80004bc4:	00048513          	mv	a0,s1
    80004bc8:	0017879b          	addiw	a5,a5,1
    80004bcc:	00813483          	ld	s1,8(sp)
    80004bd0:	00f72023          	sw	a5,0(a4)
    80004bd4:	02010113          	addi	sp,sp,32
    80004bd8:	00001317          	auipc	t1,0x1
    80004bdc:	4c030067          	jr	1216(t1) # 80006098 <release>

0000000080004be0 <devintr>:
    80004be0:	142027f3          	csrr	a5,scause
    80004be4:	00000513          	li	a0,0
    80004be8:	0007c463          	bltz	a5,80004bf0 <devintr+0x10>
    80004bec:	00008067          	ret
    80004bf0:	fe010113          	addi	sp,sp,-32
    80004bf4:	00813823          	sd	s0,16(sp)
    80004bf8:	00113c23          	sd	ra,24(sp)
    80004bfc:	00913423          	sd	s1,8(sp)
    80004c00:	02010413          	addi	s0,sp,32
    80004c04:	0ff7f713          	andi	a4,a5,255
    80004c08:	00900693          	li	a3,9
    80004c0c:	04d70c63          	beq	a4,a3,80004c64 <devintr+0x84>
    80004c10:	fff00713          	li	a4,-1
    80004c14:	03f71713          	slli	a4,a4,0x3f
    80004c18:	00170713          	addi	a4,a4,1
    80004c1c:	00e78c63          	beq	a5,a4,80004c34 <devintr+0x54>
    80004c20:	01813083          	ld	ra,24(sp)
    80004c24:	01013403          	ld	s0,16(sp)
    80004c28:	00813483          	ld	s1,8(sp)
    80004c2c:	02010113          	addi	sp,sp,32
    80004c30:	00008067          	ret
    80004c34:	00000097          	auipc	ra,0x0
    80004c38:	c8c080e7          	jalr	-884(ra) # 800048c0 <cpuid>
    80004c3c:	06050663          	beqz	a0,80004ca8 <devintr+0xc8>
    80004c40:	144027f3          	csrr	a5,sip
    80004c44:	ffd7f793          	andi	a5,a5,-3
    80004c48:	14479073          	csrw	sip,a5
    80004c4c:	01813083          	ld	ra,24(sp)
    80004c50:	01013403          	ld	s0,16(sp)
    80004c54:	00813483          	ld	s1,8(sp)
    80004c58:	00200513          	li	a0,2
    80004c5c:	02010113          	addi	sp,sp,32
    80004c60:	00008067          	ret
    80004c64:	00000097          	auipc	ra,0x0
    80004c68:	250080e7          	jalr	592(ra) # 80004eb4 <plic_claim>
    80004c6c:	00a00793          	li	a5,10
    80004c70:	00050493          	mv	s1,a0
    80004c74:	06f50663          	beq	a0,a5,80004ce0 <devintr+0x100>
    80004c78:	00100513          	li	a0,1
    80004c7c:	fa0482e3          	beqz	s1,80004c20 <devintr+0x40>
    80004c80:	00048593          	mv	a1,s1
    80004c84:	00003517          	auipc	a0,0x3
    80004c88:	8ec50513          	addi	a0,a0,-1812 # 80007570 <kvmincrease+0xb10>
    80004c8c:	00000097          	auipc	ra,0x0
    80004c90:	66c080e7          	jalr	1644(ra) # 800052f8 <__printf>
    80004c94:	00048513          	mv	a0,s1
    80004c98:	00000097          	auipc	ra,0x0
    80004c9c:	254080e7          	jalr	596(ra) # 80004eec <plic_complete>
    80004ca0:	00100513          	li	a0,1
    80004ca4:	f7dff06f          	j	80004c20 <devintr+0x40>
    80004ca8:	00005517          	auipc	a0,0x5
    80004cac:	1b850513          	addi	a0,a0,440 # 80009e60 <tickslock>
    80004cb0:	00001097          	auipc	ra,0x1
    80004cb4:	31c080e7          	jalr	796(ra) # 80005fcc <acquire>
    80004cb8:	00004717          	auipc	a4,0x4
    80004cbc:	07c70713          	addi	a4,a4,124 # 80008d34 <ticks>
    80004cc0:	00072783          	lw	a5,0(a4)
    80004cc4:	00005517          	auipc	a0,0x5
    80004cc8:	19c50513          	addi	a0,a0,412 # 80009e60 <tickslock>
    80004ccc:	0017879b          	addiw	a5,a5,1
    80004cd0:	00f72023          	sw	a5,0(a4)
    80004cd4:	00001097          	auipc	ra,0x1
    80004cd8:	3c4080e7          	jalr	964(ra) # 80006098 <release>
    80004cdc:	f65ff06f          	j	80004c40 <devintr+0x60>
    80004ce0:	00001097          	auipc	ra,0x1
    80004ce4:	f20080e7          	jalr	-224(ra) # 80005c00 <uartintr>
    80004ce8:	fadff06f          	j	80004c94 <devintr+0xb4>
    80004cec:	0000                	unimp
	...

0000000080004cf0 <kernelvec>:
    80004cf0:	f0010113          	addi	sp,sp,-256
    80004cf4:	00113023          	sd	ra,0(sp)
    80004cf8:	00213423          	sd	sp,8(sp)
    80004cfc:	00313823          	sd	gp,16(sp)
    80004d00:	00413c23          	sd	tp,24(sp)
    80004d04:	02513023          	sd	t0,32(sp)
    80004d08:	02613423          	sd	t1,40(sp)
    80004d0c:	02713823          	sd	t2,48(sp)
    80004d10:	02813c23          	sd	s0,56(sp)
    80004d14:	04913023          	sd	s1,64(sp)
    80004d18:	04a13423          	sd	a0,72(sp)
    80004d1c:	04b13823          	sd	a1,80(sp)
    80004d20:	04c13c23          	sd	a2,88(sp)
    80004d24:	06d13023          	sd	a3,96(sp)
    80004d28:	06e13423          	sd	a4,104(sp)
    80004d2c:	06f13823          	sd	a5,112(sp)
    80004d30:	07013c23          	sd	a6,120(sp)
    80004d34:	09113023          	sd	a7,128(sp)
    80004d38:	09213423          	sd	s2,136(sp)
    80004d3c:	09313823          	sd	s3,144(sp)
    80004d40:	09413c23          	sd	s4,152(sp)
    80004d44:	0b513023          	sd	s5,160(sp)
    80004d48:	0b613423          	sd	s6,168(sp)
    80004d4c:	0b713823          	sd	s7,176(sp)
    80004d50:	0b813c23          	sd	s8,184(sp)
    80004d54:	0d913023          	sd	s9,192(sp)
    80004d58:	0da13423          	sd	s10,200(sp)
    80004d5c:	0db13823          	sd	s11,208(sp)
    80004d60:	0dc13c23          	sd	t3,216(sp)
    80004d64:	0fd13023          	sd	t4,224(sp)
    80004d68:	0fe13423          	sd	t5,232(sp)
    80004d6c:	0ff13823          	sd	t6,240(sp)
    80004d70:	cd1ff0ef          	jal	ra,80004a40 <kerneltrap>
    80004d74:	00013083          	ld	ra,0(sp)
    80004d78:	00813103          	ld	sp,8(sp)
    80004d7c:	01013183          	ld	gp,16(sp)
    80004d80:	02013283          	ld	t0,32(sp)
    80004d84:	02813303          	ld	t1,40(sp)
    80004d88:	03013383          	ld	t2,48(sp)
    80004d8c:	03813403          	ld	s0,56(sp)
    80004d90:	04013483          	ld	s1,64(sp)
    80004d94:	04813503          	ld	a0,72(sp)
    80004d98:	05013583          	ld	a1,80(sp)
    80004d9c:	05813603          	ld	a2,88(sp)
    80004da0:	06013683          	ld	a3,96(sp)
    80004da4:	06813703          	ld	a4,104(sp)
    80004da8:	07013783          	ld	a5,112(sp)
    80004dac:	07813803          	ld	a6,120(sp)
    80004db0:	08013883          	ld	a7,128(sp)
    80004db4:	08813903          	ld	s2,136(sp)
    80004db8:	09013983          	ld	s3,144(sp)
    80004dbc:	09813a03          	ld	s4,152(sp)
    80004dc0:	0a013a83          	ld	s5,160(sp)
    80004dc4:	0a813b03          	ld	s6,168(sp)
    80004dc8:	0b013b83          	ld	s7,176(sp)
    80004dcc:	0b813c03          	ld	s8,184(sp)
    80004dd0:	0c013c83          	ld	s9,192(sp)
    80004dd4:	0c813d03          	ld	s10,200(sp)
    80004dd8:	0d013d83          	ld	s11,208(sp)
    80004ddc:	0d813e03          	ld	t3,216(sp)
    80004de0:	0e013e83          	ld	t4,224(sp)
    80004de4:	0e813f03          	ld	t5,232(sp)
    80004de8:	0f013f83          	ld	t6,240(sp)
    80004dec:	10010113          	addi	sp,sp,256
    80004df0:	10200073          	sret
    80004df4:	00000013          	nop
    80004df8:	00000013          	nop
    80004dfc:	00000013          	nop

0000000080004e00 <timervec>:
    80004e00:	34051573          	csrrw	a0,mscratch,a0
    80004e04:	00b53023          	sd	a1,0(a0)
    80004e08:	00c53423          	sd	a2,8(a0)
    80004e0c:	00d53823          	sd	a3,16(a0)
    80004e10:	01853583          	ld	a1,24(a0)
    80004e14:	02053603          	ld	a2,32(a0)
    80004e18:	0005b683          	ld	a3,0(a1)
    80004e1c:	00c686b3          	add	a3,a3,a2
    80004e20:	00d5b023          	sd	a3,0(a1)
    80004e24:	00200593          	li	a1,2
    80004e28:	14459073          	csrw	sip,a1
    80004e2c:	01053683          	ld	a3,16(a0)
    80004e30:	00853603          	ld	a2,8(a0)
    80004e34:	00053583          	ld	a1,0(a0)
    80004e38:	34051573          	csrrw	a0,mscratch,a0
    80004e3c:	30200073          	mret

0000000080004e40 <plicinit>:
    80004e40:	ff010113          	addi	sp,sp,-16
    80004e44:	00813423          	sd	s0,8(sp)
    80004e48:	01010413          	addi	s0,sp,16
    80004e4c:	00813403          	ld	s0,8(sp)
    80004e50:	0c0007b7          	lui	a5,0xc000
    80004e54:	00100713          	li	a4,1
    80004e58:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80004e5c:	00e7a223          	sw	a4,4(a5)
    80004e60:	01010113          	addi	sp,sp,16
    80004e64:	00008067          	ret

0000000080004e68 <plicinithart>:
    80004e68:	ff010113          	addi	sp,sp,-16
    80004e6c:	00813023          	sd	s0,0(sp)
    80004e70:	00113423          	sd	ra,8(sp)
    80004e74:	01010413          	addi	s0,sp,16
    80004e78:	00000097          	auipc	ra,0x0
    80004e7c:	a48080e7          	jalr	-1464(ra) # 800048c0 <cpuid>
    80004e80:	0085171b          	slliw	a4,a0,0x8
    80004e84:	0c0027b7          	lui	a5,0xc002
    80004e88:	00e787b3          	add	a5,a5,a4
    80004e8c:	40200713          	li	a4,1026
    80004e90:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80004e94:	00813083          	ld	ra,8(sp)
    80004e98:	00013403          	ld	s0,0(sp)
    80004e9c:	00d5151b          	slliw	a0,a0,0xd
    80004ea0:	0c2017b7          	lui	a5,0xc201
    80004ea4:	00a78533          	add	a0,a5,a0
    80004ea8:	00052023          	sw	zero,0(a0)
    80004eac:	01010113          	addi	sp,sp,16
    80004eb0:	00008067          	ret

0000000080004eb4 <plic_claim>:
    80004eb4:	ff010113          	addi	sp,sp,-16
    80004eb8:	00813023          	sd	s0,0(sp)
    80004ebc:	00113423          	sd	ra,8(sp)
    80004ec0:	01010413          	addi	s0,sp,16
    80004ec4:	00000097          	auipc	ra,0x0
    80004ec8:	9fc080e7          	jalr	-1540(ra) # 800048c0 <cpuid>
    80004ecc:	00813083          	ld	ra,8(sp)
    80004ed0:	00013403          	ld	s0,0(sp)
    80004ed4:	00d5151b          	slliw	a0,a0,0xd
    80004ed8:	0c2017b7          	lui	a5,0xc201
    80004edc:	00a78533          	add	a0,a5,a0
    80004ee0:	00452503          	lw	a0,4(a0)
    80004ee4:	01010113          	addi	sp,sp,16
    80004ee8:	00008067          	ret

0000000080004eec <plic_complete>:
    80004eec:	fe010113          	addi	sp,sp,-32
    80004ef0:	00813823          	sd	s0,16(sp)
    80004ef4:	00913423          	sd	s1,8(sp)
    80004ef8:	00113c23          	sd	ra,24(sp)
    80004efc:	02010413          	addi	s0,sp,32
    80004f00:	00050493          	mv	s1,a0
    80004f04:	00000097          	auipc	ra,0x0
    80004f08:	9bc080e7          	jalr	-1604(ra) # 800048c0 <cpuid>
    80004f0c:	01813083          	ld	ra,24(sp)
    80004f10:	01013403          	ld	s0,16(sp)
    80004f14:	00d5179b          	slliw	a5,a0,0xd
    80004f18:	0c201737          	lui	a4,0xc201
    80004f1c:	00f707b3          	add	a5,a4,a5
    80004f20:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004f24:	00813483          	ld	s1,8(sp)
    80004f28:	02010113          	addi	sp,sp,32
    80004f2c:	00008067          	ret

0000000080004f30 <consolewrite>:
    80004f30:	fb010113          	addi	sp,sp,-80
    80004f34:	04813023          	sd	s0,64(sp)
    80004f38:	04113423          	sd	ra,72(sp)
    80004f3c:	02913c23          	sd	s1,56(sp)
    80004f40:	03213823          	sd	s2,48(sp)
    80004f44:	03313423          	sd	s3,40(sp)
    80004f48:	03413023          	sd	s4,32(sp)
    80004f4c:	01513c23          	sd	s5,24(sp)
    80004f50:	05010413          	addi	s0,sp,80
    80004f54:	06c05c63          	blez	a2,80004fcc <consolewrite+0x9c>
    80004f58:	00060993          	mv	s3,a2
    80004f5c:	00050a13          	mv	s4,a0
    80004f60:	00058493          	mv	s1,a1
    80004f64:	00000913          	li	s2,0
    80004f68:	fff00a93          	li	s5,-1
    80004f6c:	01c0006f          	j	80004f88 <consolewrite+0x58>
    80004f70:	fbf44503          	lbu	a0,-65(s0)
    80004f74:	0019091b          	addiw	s2,s2,1
    80004f78:	00148493          	addi	s1,s1,1
    80004f7c:	00001097          	auipc	ra,0x1
    80004f80:	a9c080e7          	jalr	-1380(ra) # 80005a18 <uartputc>
    80004f84:	03298063          	beq	s3,s2,80004fa4 <consolewrite+0x74>
    80004f88:	00048613          	mv	a2,s1
    80004f8c:	00100693          	li	a3,1
    80004f90:	000a0593          	mv	a1,s4
    80004f94:	fbf40513          	addi	a0,s0,-65
    80004f98:	00000097          	auipc	ra,0x0
    80004f9c:	9e0080e7          	jalr	-1568(ra) # 80004978 <either_copyin>
    80004fa0:	fd5518e3          	bne	a0,s5,80004f70 <consolewrite+0x40>
    80004fa4:	04813083          	ld	ra,72(sp)
    80004fa8:	04013403          	ld	s0,64(sp)
    80004fac:	03813483          	ld	s1,56(sp)
    80004fb0:	02813983          	ld	s3,40(sp)
    80004fb4:	02013a03          	ld	s4,32(sp)
    80004fb8:	01813a83          	ld	s5,24(sp)
    80004fbc:	00090513          	mv	a0,s2
    80004fc0:	03013903          	ld	s2,48(sp)
    80004fc4:	05010113          	addi	sp,sp,80
    80004fc8:	00008067          	ret
    80004fcc:	00000913          	li	s2,0
    80004fd0:	fd5ff06f          	j	80004fa4 <consolewrite+0x74>

0000000080004fd4 <consoleread>:
    80004fd4:	f9010113          	addi	sp,sp,-112
    80004fd8:	06813023          	sd	s0,96(sp)
    80004fdc:	04913c23          	sd	s1,88(sp)
    80004fe0:	05213823          	sd	s2,80(sp)
    80004fe4:	05313423          	sd	s3,72(sp)
    80004fe8:	05413023          	sd	s4,64(sp)
    80004fec:	03513c23          	sd	s5,56(sp)
    80004ff0:	03613823          	sd	s6,48(sp)
    80004ff4:	03713423          	sd	s7,40(sp)
    80004ff8:	03813023          	sd	s8,32(sp)
    80004ffc:	06113423          	sd	ra,104(sp)
    80005000:	01913c23          	sd	s9,24(sp)
    80005004:	07010413          	addi	s0,sp,112
    80005008:	00060b93          	mv	s7,a2
    8000500c:	00050913          	mv	s2,a0
    80005010:	00058c13          	mv	s8,a1
    80005014:	00060b1b          	sext.w	s6,a2
    80005018:	00005497          	auipc	s1,0x5
    8000501c:	e7048493          	addi	s1,s1,-400 # 80009e88 <cons>
    80005020:	00400993          	li	s3,4
    80005024:	fff00a13          	li	s4,-1
    80005028:	00a00a93          	li	s5,10
    8000502c:	05705e63          	blez	s7,80005088 <consoleread+0xb4>
    80005030:	09c4a703          	lw	a4,156(s1)
    80005034:	0984a783          	lw	a5,152(s1)
    80005038:	0007071b          	sext.w	a4,a4
    8000503c:	08e78463          	beq	a5,a4,800050c4 <consoleread+0xf0>
    80005040:	07f7f713          	andi	a4,a5,127
    80005044:	00e48733          	add	a4,s1,a4
    80005048:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000504c:	0017869b          	addiw	a3,a5,1
    80005050:	08d4ac23          	sw	a3,152(s1)
    80005054:	00070c9b          	sext.w	s9,a4
    80005058:	0b370663          	beq	a4,s3,80005104 <consoleread+0x130>
    8000505c:	00100693          	li	a3,1
    80005060:	f9f40613          	addi	a2,s0,-97
    80005064:	000c0593          	mv	a1,s8
    80005068:	00090513          	mv	a0,s2
    8000506c:	f8e40fa3          	sb	a4,-97(s0)
    80005070:	00000097          	auipc	ra,0x0
    80005074:	8bc080e7          	jalr	-1860(ra) # 8000492c <either_copyout>
    80005078:	01450863          	beq	a0,s4,80005088 <consoleread+0xb4>
    8000507c:	001c0c13          	addi	s8,s8,1
    80005080:	fffb8b9b          	addiw	s7,s7,-1
    80005084:	fb5c94e3          	bne	s9,s5,8000502c <consoleread+0x58>
    80005088:	000b851b          	sext.w	a0,s7
    8000508c:	06813083          	ld	ra,104(sp)
    80005090:	06013403          	ld	s0,96(sp)
    80005094:	05813483          	ld	s1,88(sp)
    80005098:	05013903          	ld	s2,80(sp)
    8000509c:	04813983          	ld	s3,72(sp)
    800050a0:	04013a03          	ld	s4,64(sp)
    800050a4:	03813a83          	ld	s5,56(sp)
    800050a8:	02813b83          	ld	s7,40(sp)
    800050ac:	02013c03          	ld	s8,32(sp)
    800050b0:	01813c83          	ld	s9,24(sp)
    800050b4:	40ab053b          	subw	a0,s6,a0
    800050b8:	03013b03          	ld	s6,48(sp)
    800050bc:	07010113          	addi	sp,sp,112
    800050c0:	00008067          	ret
    800050c4:	00001097          	auipc	ra,0x1
    800050c8:	1d8080e7          	jalr	472(ra) # 8000629c <push_on>
    800050cc:	0984a703          	lw	a4,152(s1)
    800050d0:	09c4a783          	lw	a5,156(s1)
    800050d4:	0007879b          	sext.w	a5,a5
    800050d8:	fef70ce3          	beq	a4,a5,800050d0 <consoleread+0xfc>
    800050dc:	00001097          	auipc	ra,0x1
    800050e0:	234080e7          	jalr	564(ra) # 80006310 <pop_on>
    800050e4:	0984a783          	lw	a5,152(s1)
    800050e8:	07f7f713          	andi	a4,a5,127
    800050ec:	00e48733          	add	a4,s1,a4
    800050f0:	01874703          	lbu	a4,24(a4)
    800050f4:	0017869b          	addiw	a3,a5,1
    800050f8:	08d4ac23          	sw	a3,152(s1)
    800050fc:	00070c9b          	sext.w	s9,a4
    80005100:	f5371ee3          	bne	a4,s3,8000505c <consoleread+0x88>
    80005104:	000b851b          	sext.w	a0,s7
    80005108:	f96bf2e3          	bgeu	s7,s6,8000508c <consoleread+0xb8>
    8000510c:	08f4ac23          	sw	a5,152(s1)
    80005110:	f7dff06f          	j	8000508c <consoleread+0xb8>

0000000080005114 <consputc>:
    80005114:	10000793          	li	a5,256
    80005118:	00f50663          	beq	a0,a5,80005124 <consputc+0x10>
    8000511c:	00001317          	auipc	t1,0x1
    80005120:	9f430067          	jr	-1548(t1) # 80005b10 <uartputc_sync>
    80005124:	ff010113          	addi	sp,sp,-16
    80005128:	00113423          	sd	ra,8(sp)
    8000512c:	00813023          	sd	s0,0(sp)
    80005130:	01010413          	addi	s0,sp,16
    80005134:	00800513          	li	a0,8
    80005138:	00001097          	auipc	ra,0x1
    8000513c:	9d8080e7          	jalr	-1576(ra) # 80005b10 <uartputc_sync>
    80005140:	02000513          	li	a0,32
    80005144:	00001097          	auipc	ra,0x1
    80005148:	9cc080e7          	jalr	-1588(ra) # 80005b10 <uartputc_sync>
    8000514c:	00013403          	ld	s0,0(sp)
    80005150:	00813083          	ld	ra,8(sp)
    80005154:	00800513          	li	a0,8
    80005158:	01010113          	addi	sp,sp,16
    8000515c:	00001317          	auipc	t1,0x1
    80005160:	9b430067          	jr	-1612(t1) # 80005b10 <uartputc_sync>

0000000080005164 <consoleintr>:
    80005164:	fe010113          	addi	sp,sp,-32
    80005168:	00813823          	sd	s0,16(sp)
    8000516c:	00913423          	sd	s1,8(sp)
    80005170:	01213023          	sd	s2,0(sp)
    80005174:	00113c23          	sd	ra,24(sp)
    80005178:	02010413          	addi	s0,sp,32
    8000517c:	00005917          	auipc	s2,0x5
    80005180:	d0c90913          	addi	s2,s2,-756 # 80009e88 <cons>
    80005184:	00050493          	mv	s1,a0
    80005188:	00090513          	mv	a0,s2
    8000518c:	00001097          	auipc	ra,0x1
    80005190:	e40080e7          	jalr	-448(ra) # 80005fcc <acquire>
    80005194:	02048c63          	beqz	s1,800051cc <consoleintr+0x68>
    80005198:	0a092783          	lw	a5,160(s2)
    8000519c:	09892703          	lw	a4,152(s2)
    800051a0:	07f00693          	li	a3,127
    800051a4:	40e7873b          	subw	a4,a5,a4
    800051a8:	02e6e263          	bltu	a3,a4,800051cc <consoleintr+0x68>
    800051ac:	00d00713          	li	a4,13
    800051b0:	04e48063          	beq	s1,a4,800051f0 <consoleintr+0x8c>
    800051b4:	07f7f713          	andi	a4,a5,127
    800051b8:	00e90733          	add	a4,s2,a4
    800051bc:	0017879b          	addiw	a5,a5,1
    800051c0:	0af92023          	sw	a5,160(s2)
    800051c4:	00970c23          	sb	s1,24(a4)
    800051c8:	08f92e23          	sw	a5,156(s2)
    800051cc:	01013403          	ld	s0,16(sp)
    800051d0:	01813083          	ld	ra,24(sp)
    800051d4:	00813483          	ld	s1,8(sp)
    800051d8:	00013903          	ld	s2,0(sp)
    800051dc:	00005517          	auipc	a0,0x5
    800051e0:	cac50513          	addi	a0,a0,-852 # 80009e88 <cons>
    800051e4:	02010113          	addi	sp,sp,32
    800051e8:	00001317          	auipc	t1,0x1
    800051ec:	eb030067          	jr	-336(t1) # 80006098 <release>
    800051f0:	00a00493          	li	s1,10
    800051f4:	fc1ff06f          	j	800051b4 <consoleintr+0x50>

00000000800051f8 <consoleinit>:
    800051f8:	fe010113          	addi	sp,sp,-32
    800051fc:	00113c23          	sd	ra,24(sp)
    80005200:	00813823          	sd	s0,16(sp)
    80005204:	00913423          	sd	s1,8(sp)
    80005208:	02010413          	addi	s0,sp,32
    8000520c:	00005497          	auipc	s1,0x5
    80005210:	c7c48493          	addi	s1,s1,-900 # 80009e88 <cons>
    80005214:	00048513          	mv	a0,s1
    80005218:	00002597          	auipc	a1,0x2
    8000521c:	3b058593          	addi	a1,a1,944 # 800075c8 <kvmincrease+0xb68>
    80005220:	00001097          	auipc	ra,0x1
    80005224:	d88080e7          	jalr	-632(ra) # 80005fa8 <initlock>
    80005228:	00000097          	auipc	ra,0x0
    8000522c:	7ac080e7          	jalr	1964(ra) # 800059d4 <uartinit>
    80005230:	01813083          	ld	ra,24(sp)
    80005234:	01013403          	ld	s0,16(sp)
    80005238:	00000797          	auipc	a5,0x0
    8000523c:	d9c78793          	addi	a5,a5,-612 # 80004fd4 <consoleread>
    80005240:	0af4bc23          	sd	a5,184(s1)
    80005244:	00000797          	auipc	a5,0x0
    80005248:	cec78793          	addi	a5,a5,-788 # 80004f30 <consolewrite>
    8000524c:	0cf4b023          	sd	a5,192(s1)
    80005250:	00813483          	ld	s1,8(sp)
    80005254:	02010113          	addi	sp,sp,32
    80005258:	00008067          	ret

000000008000525c <console_read>:
    8000525c:	ff010113          	addi	sp,sp,-16
    80005260:	00813423          	sd	s0,8(sp)
    80005264:	01010413          	addi	s0,sp,16
    80005268:	00813403          	ld	s0,8(sp)
    8000526c:	00005317          	auipc	t1,0x5
    80005270:	cd433303          	ld	t1,-812(t1) # 80009f40 <devsw+0x10>
    80005274:	01010113          	addi	sp,sp,16
    80005278:	00030067          	jr	t1

000000008000527c <console_write>:
    8000527c:	ff010113          	addi	sp,sp,-16
    80005280:	00813423          	sd	s0,8(sp)
    80005284:	01010413          	addi	s0,sp,16
    80005288:	00813403          	ld	s0,8(sp)
    8000528c:	00005317          	auipc	t1,0x5
    80005290:	cbc33303          	ld	t1,-836(t1) # 80009f48 <devsw+0x18>
    80005294:	01010113          	addi	sp,sp,16
    80005298:	00030067          	jr	t1

000000008000529c <panic>:
    8000529c:	fe010113          	addi	sp,sp,-32
    800052a0:	00113c23          	sd	ra,24(sp)
    800052a4:	00813823          	sd	s0,16(sp)
    800052a8:	00913423          	sd	s1,8(sp)
    800052ac:	02010413          	addi	s0,sp,32
    800052b0:	00050493          	mv	s1,a0
    800052b4:	00002517          	auipc	a0,0x2
    800052b8:	31c50513          	addi	a0,a0,796 # 800075d0 <kvmincrease+0xb70>
    800052bc:	00005797          	auipc	a5,0x5
    800052c0:	d207a623          	sw	zero,-724(a5) # 80009fe8 <pr+0x18>
    800052c4:	00000097          	auipc	ra,0x0
    800052c8:	034080e7          	jalr	52(ra) # 800052f8 <__printf>
    800052cc:	00048513          	mv	a0,s1
    800052d0:	00000097          	auipc	ra,0x0
    800052d4:	028080e7          	jalr	40(ra) # 800052f8 <__printf>
    800052d8:	00002517          	auipc	a0,0x2
    800052dc:	e9850513          	addi	a0,a0,-360 # 80007170 <kvmincrease+0x710>
    800052e0:	00000097          	auipc	ra,0x0
    800052e4:	018080e7          	jalr	24(ra) # 800052f8 <__printf>
    800052e8:	00100793          	li	a5,1
    800052ec:	00004717          	auipc	a4,0x4
    800052f0:	a4f72623          	sw	a5,-1460(a4) # 80008d38 <panicked>
    800052f4:	0000006f          	j	800052f4 <panic+0x58>

00000000800052f8 <__printf>:
    800052f8:	f3010113          	addi	sp,sp,-208
    800052fc:	08813023          	sd	s0,128(sp)
    80005300:	07313423          	sd	s3,104(sp)
    80005304:	09010413          	addi	s0,sp,144
    80005308:	05813023          	sd	s8,64(sp)
    8000530c:	08113423          	sd	ra,136(sp)
    80005310:	06913c23          	sd	s1,120(sp)
    80005314:	07213823          	sd	s2,112(sp)
    80005318:	07413023          	sd	s4,96(sp)
    8000531c:	05513c23          	sd	s5,88(sp)
    80005320:	05613823          	sd	s6,80(sp)
    80005324:	05713423          	sd	s7,72(sp)
    80005328:	03913c23          	sd	s9,56(sp)
    8000532c:	03a13823          	sd	s10,48(sp)
    80005330:	03b13423          	sd	s11,40(sp)
    80005334:	00005317          	auipc	t1,0x5
    80005338:	c9c30313          	addi	t1,t1,-868 # 80009fd0 <pr>
    8000533c:	01832c03          	lw	s8,24(t1)
    80005340:	00b43423          	sd	a1,8(s0)
    80005344:	00c43823          	sd	a2,16(s0)
    80005348:	00d43c23          	sd	a3,24(s0)
    8000534c:	02e43023          	sd	a4,32(s0)
    80005350:	02f43423          	sd	a5,40(s0)
    80005354:	03043823          	sd	a6,48(s0)
    80005358:	03143c23          	sd	a7,56(s0)
    8000535c:	00050993          	mv	s3,a0
    80005360:	4a0c1663          	bnez	s8,8000580c <__printf+0x514>
    80005364:	60098c63          	beqz	s3,8000597c <__printf+0x684>
    80005368:	0009c503          	lbu	a0,0(s3)
    8000536c:	00840793          	addi	a5,s0,8
    80005370:	f6f43c23          	sd	a5,-136(s0)
    80005374:	00000493          	li	s1,0
    80005378:	22050063          	beqz	a0,80005598 <__printf+0x2a0>
    8000537c:	00002a37          	lui	s4,0x2
    80005380:	00018ab7          	lui	s5,0x18
    80005384:	000f4b37          	lui	s6,0xf4
    80005388:	00989bb7          	lui	s7,0x989
    8000538c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005390:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005394:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005398:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000539c:	00148c9b          	addiw	s9,s1,1
    800053a0:	02500793          	li	a5,37
    800053a4:	01998933          	add	s2,s3,s9
    800053a8:	38f51263          	bne	a0,a5,8000572c <__printf+0x434>
    800053ac:	00094783          	lbu	a5,0(s2)
    800053b0:	00078c9b          	sext.w	s9,a5
    800053b4:	1e078263          	beqz	a5,80005598 <__printf+0x2a0>
    800053b8:	0024849b          	addiw	s1,s1,2
    800053bc:	07000713          	li	a4,112
    800053c0:	00998933          	add	s2,s3,s1
    800053c4:	38e78a63          	beq	a5,a4,80005758 <__printf+0x460>
    800053c8:	20f76863          	bltu	a4,a5,800055d8 <__printf+0x2e0>
    800053cc:	42a78863          	beq	a5,a0,800057fc <__printf+0x504>
    800053d0:	06400713          	li	a4,100
    800053d4:	40e79663          	bne	a5,a4,800057e0 <__printf+0x4e8>
    800053d8:	f7843783          	ld	a5,-136(s0)
    800053dc:	0007a603          	lw	a2,0(a5)
    800053e0:	00878793          	addi	a5,a5,8
    800053e4:	f6f43c23          	sd	a5,-136(s0)
    800053e8:	42064a63          	bltz	a2,8000581c <__printf+0x524>
    800053ec:	00a00713          	li	a4,10
    800053f0:	02e677bb          	remuw	a5,a2,a4
    800053f4:	00002d97          	auipc	s11,0x2
    800053f8:	204d8d93          	addi	s11,s11,516 # 800075f8 <digits>
    800053fc:	00900593          	li	a1,9
    80005400:	0006051b          	sext.w	a0,a2
    80005404:	00000c93          	li	s9,0
    80005408:	02079793          	slli	a5,a5,0x20
    8000540c:	0207d793          	srli	a5,a5,0x20
    80005410:	00fd87b3          	add	a5,s11,a5
    80005414:	0007c783          	lbu	a5,0(a5)
    80005418:	02e656bb          	divuw	a3,a2,a4
    8000541c:	f8f40023          	sb	a5,-128(s0)
    80005420:	14c5d863          	bge	a1,a2,80005570 <__printf+0x278>
    80005424:	06300593          	li	a1,99
    80005428:	00100c93          	li	s9,1
    8000542c:	02e6f7bb          	remuw	a5,a3,a4
    80005430:	02079793          	slli	a5,a5,0x20
    80005434:	0207d793          	srli	a5,a5,0x20
    80005438:	00fd87b3          	add	a5,s11,a5
    8000543c:	0007c783          	lbu	a5,0(a5)
    80005440:	02e6d73b          	divuw	a4,a3,a4
    80005444:	f8f400a3          	sb	a5,-127(s0)
    80005448:	12a5f463          	bgeu	a1,a0,80005570 <__printf+0x278>
    8000544c:	00a00693          	li	a3,10
    80005450:	00900593          	li	a1,9
    80005454:	02d777bb          	remuw	a5,a4,a3
    80005458:	02079793          	slli	a5,a5,0x20
    8000545c:	0207d793          	srli	a5,a5,0x20
    80005460:	00fd87b3          	add	a5,s11,a5
    80005464:	0007c503          	lbu	a0,0(a5)
    80005468:	02d757bb          	divuw	a5,a4,a3
    8000546c:	f8a40123          	sb	a0,-126(s0)
    80005470:	48e5f263          	bgeu	a1,a4,800058f4 <__printf+0x5fc>
    80005474:	06300513          	li	a0,99
    80005478:	02d7f5bb          	remuw	a1,a5,a3
    8000547c:	02059593          	slli	a1,a1,0x20
    80005480:	0205d593          	srli	a1,a1,0x20
    80005484:	00bd85b3          	add	a1,s11,a1
    80005488:	0005c583          	lbu	a1,0(a1)
    8000548c:	02d7d7bb          	divuw	a5,a5,a3
    80005490:	f8b401a3          	sb	a1,-125(s0)
    80005494:	48e57263          	bgeu	a0,a4,80005918 <__printf+0x620>
    80005498:	3e700513          	li	a0,999
    8000549c:	02d7f5bb          	remuw	a1,a5,a3
    800054a0:	02059593          	slli	a1,a1,0x20
    800054a4:	0205d593          	srli	a1,a1,0x20
    800054a8:	00bd85b3          	add	a1,s11,a1
    800054ac:	0005c583          	lbu	a1,0(a1)
    800054b0:	02d7d7bb          	divuw	a5,a5,a3
    800054b4:	f8b40223          	sb	a1,-124(s0)
    800054b8:	46e57663          	bgeu	a0,a4,80005924 <__printf+0x62c>
    800054bc:	02d7f5bb          	remuw	a1,a5,a3
    800054c0:	02059593          	slli	a1,a1,0x20
    800054c4:	0205d593          	srli	a1,a1,0x20
    800054c8:	00bd85b3          	add	a1,s11,a1
    800054cc:	0005c583          	lbu	a1,0(a1)
    800054d0:	02d7d7bb          	divuw	a5,a5,a3
    800054d4:	f8b402a3          	sb	a1,-123(s0)
    800054d8:	46ea7863          	bgeu	s4,a4,80005948 <__printf+0x650>
    800054dc:	02d7f5bb          	remuw	a1,a5,a3
    800054e0:	02059593          	slli	a1,a1,0x20
    800054e4:	0205d593          	srli	a1,a1,0x20
    800054e8:	00bd85b3          	add	a1,s11,a1
    800054ec:	0005c583          	lbu	a1,0(a1)
    800054f0:	02d7d7bb          	divuw	a5,a5,a3
    800054f4:	f8b40323          	sb	a1,-122(s0)
    800054f8:	3eeaf863          	bgeu	s5,a4,800058e8 <__printf+0x5f0>
    800054fc:	02d7f5bb          	remuw	a1,a5,a3
    80005500:	02059593          	slli	a1,a1,0x20
    80005504:	0205d593          	srli	a1,a1,0x20
    80005508:	00bd85b3          	add	a1,s11,a1
    8000550c:	0005c583          	lbu	a1,0(a1)
    80005510:	02d7d7bb          	divuw	a5,a5,a3
    80005514:	f8b403a3          	sb	a1,-121(s0)
    80005518:	42eb7e63          	bgeu	s6,a4,80005954 <__printf+0x65c>
    8000551c:	02d7f5bb          	remuw	a1,a5,a3
    80005520:	02059593          	slli	a1,a1,0x20
    80005524:	0205d593          	srli	a1,a1,0x20
    80005528:	00bd85b3          	add	a1,s11,a1
    8000552c:	0005c583          	lbu	a1,0(a1)
    80005530:	02d7d7bb          	divuw	a5,a5,a3
    80005534:	f8b40423          	sb	a1,-120(s0)
    80005538:	42ebfc63          	bgeu	s7,a4,80005970 <__printf+0x678>
    8000553c:	02079793          	slli	a5,a5,0x20
    80005540:	0207d793          	srli	a5,a5,0x20
    80005544:	00fd8db3          	add	s11,s11,a5
    80005548:	000dc703          	lbu	a4,0(s11)
    8000554c:	00a00793          	li	a5,10
    80005550:	00900c93          	li	s9,9
    80005554:	f8e404a3          	sb	a4,-119(s0)
    80005558:	00065c63          	bgez	a2,80005570 <__printf+0x278>
    8000555c:	f9040713          	addi	a4,s0,-112
    80005560:	00f70733          	add	a4,a4,a5
    80005564:	02d00693          	li	a3,45
    80005568:	fed70823          	sb	a3,-16(a4)
    8000556c:	00078c93          	mv	s9,a5
    80005570:	f8040793          	addi	a5,s0,-128
    80005574:	01978cb3          	add	s9,a5,s9
    80005578:	f7f40d13          	addi	s10,s0,-129
    8000557c:	000cc503          	lbu	a0,0(s9)
    80005580:	fffc8c93          	addi	s9,s9,-1
    80005584:	00000097          	auipc	ra,0x0
    80005588:	b90080e7          	jalr	-1136(ra) # 80005114 <consputc>
    8000558c:	ffac98e3          	bne	s9,s10,8000557c <__printf+0x284>
    80005590:	00094503          	lbu	a0,0(s2)
    80005594:	e00514e3          	bnez	a0,8000539c <__printf+0xa4>
    80005598:	1a0c1663          	bnez	s8,80005744 <__printf+0x44c>
    8000559c:	08813083          	ld	ra,136(sp)
    800055a0:	08013403          	ld	s0,128(sp)
    800055a4:	07813483          	ld	s1,120(sp)
    800055a8:	07013903          	ld	s2,112(sp)
    800055ac:	06813983          	ld	s3,104(sp)
    800055b0:	06013a03          	ld	s4,96(sp)
    800055b4:	05813a83          	ld	s5,88(sp)
    800055b8:	05013b03          	ld	s6,80(sp)
    800055bc:	04813b83          	ld	s7,72(sp)
    800055c0:	04013c03          	ld	s8,64(sp)
    800055c4:	03813c83          	ld	s9,56(sp)
    800055c8:	03013d03          	ld	s10,48(sp)
    800055cc:	02813d83          	ld	s11,40(sp)
    800055d0:	0d010113          	addi	sp,sp,208
    800055d4:	00008067          	ret
    800055d8:	07300713          	li	a4,115
    800055dc:	1ce78a63          	beq	a5,a4,800057b0 <__printf+0x4b8>
    800055e0:	07800713          	li	a4,120
    800055e4:	1ee79e63          	bne	a5,a4,800057e0 <__printf+0x4e8>
    800055e8:	f7843783          	ld	a5,-136(s0)
    800055ec:	0007a703          	lw	a4,0(a5)
    800055f0:	00878793          	addi	a5,a5,8
    800055f4:	f6f43c23          	sd	a5,-136(s0)
    800055f8:	28074263          	bltz	a4,8000587c <__printf+0x584>
    800055fc:	00002d97          	auipc	s11,0x2
    80005600:	ffcd8d93          	addi	s11,s11,-4 # 800075f8 <digits>
    80005604:	00f77793          	andi	a5,a4,15
    80005608:	00fd87b3          	add	a5,s11,a5
    8000560c:	0007c683          	lbu	a3,0(a5)
    80005610:	00f00613          	li	a2,15
    80005614:	0007079b          	sext.w	a5,a4
    80005618:	f8d40023          	sb	a3,-128(s0)
    8000561c:	0047559b          	srliw	a1,a4,0x4
    80005620:	0047569b          	srliw	a3,a4,0x4
    80005624:	00000c93          	li	s9,0
    80005628:	0ee65063          	bge	a2,a4,80005708 <__printf+0x410>
    8000562c:	00f6f693          	andi	a3,a3,15
    80005630:	00dd86b3          	add	a3,s11,a3
    80005634:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005638:	0087d79b          	srliw	a5,a5,0x8
    8000563c:	00100c93          	li	s9,1
    80005640:	f8d400a3          	sb	a3,-127(s0)
    80005644:	0cb67263          	bgeu	a2,a1,80005708 <__printf+0x410>
    80005648:	00f7f693          	andi	a3,a5,15
    8000564c:	00dd86b3          	add	a3,s11,a3
    80005650:	0006c583          	lbu	a1,0(a3)
    80005654:	00f00613          	li	a2,15
    80005658:	0047d69b          	srliw	a3,a5,0x4
    8000565c:	f8b40123          	sb	a1,-126(s0)
    80005660:	0047d593          	srli	a1,a5,0x4
    80005664:	28f67e63          	bgeu	a2,a5,80005900 <__printf+0x608>
    80005668:	00f6f693          	andi	a3,a3,15
    8000566c:	00dd86b3          	add	a3,s11,a3
    80005670:	0006c503          	lbu	a0,0(a3)
    80005674:	0087d813          	srli	a6,a5,0x8
    80005678:	0087d69b          	srliw	a3,a5,0x8
    8000567c:	f8a401a3          	sb	a0,-125(s0)
    80005680:	28b67663          	bgeu	a2,a1,8000590c <__printf+0x614>
    80005684:	00f6f693          	andi	a3,a3,15
    80005688:	00dd86b3          	add	a3,s11,a3
    8000568c:	0006c583          	lbu	a1,0(a3)
    80005690:	00c7d513          	srli	a0,a5,0xc
    80005694:	00c7d69b          	srliw	a3,a5,0xc
    80005698:	f8b40223          	sb	a1,-124(s0)
    8000569c:	29067a63          	bgeu	a2,a6,80005930 <__printf+0x638>
    800056a0:	00f6f693          	andi	a3,a3,15
    800056a4:	00dd86b3          	add	a3,s11,a3
    800056a8:	0006c583          	lbu	a1,0(a3)
    800056ac:	0107d813          	srli	a6,a5,0x10
    800056b0:	0107d69b          	srliw	a3,a5,0x10
    800056b4:	f8b402a3          	sb	a1,-123(s0)
    800056b8:	28a67263          	bgeu	a2,a0,8000593c <__printf+0x644>
    800056bc:	00f6f693          	andi	a3,a3,15
    800056c0:	00dd86b3          	add	a3,s11,a3
    800056c4:	0006c683          	lbu	a3,0(a3)
    800056c8:	0147d79b          	srliw	a5,a5,0x14
    800056cc:	f8d40323          	sb	a3,-122(s0)
    800056d0:	21067663          	bgeu	a2,a6,800058dc <__printf+0x5e4>
    800056d4:	02079793          	slli	a5,a5,0x20
    800056d8:	0207d793          	srli	a5,a5,0x20
    800056dc:	00fd8db3          	add	s11,s11,a5
    800056e0:	000dc683          	lbu	a3,0(s11)
    800056e4:	00800793          	li	a5,8
    800056e8:	00700c93          	li	s9,7
    800056ec:	f8d403a3          	sb	a3,-121(s0)
    800056f0:	00075c63          	bgez	a4,80005708 <__printf+0x410>
    800056f4:	f9040713          	addi	a4,s0,-112
    800056f8:	00f70733          	add	a4,a4,a5
    800056fc:	02d00693          	li	a3,45
    80005700:	fed70823          	sb	a3,-16(a4)
    80005704:	00078c93          	mv	s9,a5
    80005708:	f8040793          	addi	a5,s0,-128
    8000570c:	01978cb3          	add	s9,a5,s9
    80005710:	f7f40d13          	addi	s10,s0,-129
    80005714:	000cc503          	lbu	a0,0(s9)
    80005718:	fffc8c93          	addi	s9,s9,-1
    8000571c:	00000097          	auipc	ra,0x0
    80005720:	9f8080e7          	jalr	-1544(ra) # 80005114 <consputc>
    80005724:	ff9d18e3          	bne	s10,s9,80005714 <__printf+0x41c>
    80005728:	0100006f          	j	80005738 <__printf+0x440>
    8000572c:	00000097          	auipc	ra,0x0
    80005730:	9e8080e7          	jalr	-1560(ra) # 80005114 <consputc>
    80005734:	000c8493          	mv	s1,s9
    80005738:	00094503          	lbu	a0,0(s2)
    8000573c:	c60510e3          	bnez	a0,8000539c <__printf+0xa4>
    80005740:	e40c0ee3          	beqz	s8,8000559c <__printf+0x2a4>
    80005744:	00005517          	auipc	a0,0x5
    80005748:	88c50513          	addi	a0,a0,-1908 # 80009fd0 <pr>
    8000574c:	00001097          	auipc	ra,0x1
    80005750:	94c080e7          	jalr	-1716(ra) # 80006098 <release>
    80005754:	e49ff06f          	j	8000559c <__printf+0x2a4>
    80005758:	f7843783          	ld	a5,-136(s0)
    8000575c:	03000513          	li	a0,48
    80005760:	01000d13          	li	s10,16
    80005764:	00878713          	addi	a4,a5,8
    80005768:	0007bc83          	ld	s9,0(a5)
    8000576c:	f6e43c23          	sd	a4,-136(s0)
    80005770:	00000097          	auipc	ra,0x0
    80005774:	9a4080e7          	jalr	-1628(ra) # 80005114 <consputc>
    80005778:	07800513          	li	a0,120
    8000577c:	00000097          	auipc	ra,0x0
    80005780:	998080e7          	jalr	-1640(ra) # 80005114 <consputc>
    80005784:	00002d97          	auipc	s11,0x2
    80005788:	e74d8d93          	addi	s11,s11,-396 # 800075f8 <digits>
    8000578c:	03ccd793          	srli	a5,s9,0x3c
    80005790:	00fd87b3          	add	a5,s11,a5
    80005794:	0007c503          	lbu	a0,0(a5)
    80005798:	fffd0d1b          	addiw	s10,s10,-1
    8000579c:	004c9c93          	slli	s9,s9,0x4
    800057a0:	00000097          	auipc	ra,0x0
    800057a4:	974080e7          	jalr	-1676(ra) # 80005114 <consputc>
    800057a8:	fe0d12e3          	bnez	s10,8000578c <__printf+0x494>
    800057ac:	f8dff06f          	j	80005738 <__printf+0x440>
    800057b0:	f7843783          	ld	a5,-136(s0)
    800057b4:	0007bc83          	ld	s9,0(a5)
    800057b8:	00878793          	addi	a5,a5,8
    800057bc:	f6f43c23          	sd	a5,-136(s0)
    800057c0:	000c9a63          	bnez	s9,800057d4 <__printf+0x4dc>
    800057c4:	1080006f          	j	800058cc <__printf+0x5d4>
    800057c8:	001c8c93          	addi	s9,s9,1
    800057cc:	00000097          	auipc	ra,0x0
    800057d0:	948080e7          	jalr	-1720(ra) # 80005114 <consputc>
    800057d4:	000cc503          	lbu	a0,0(s9)
    800057d8:	fe0518e3          	bnez	a0,800057c8 <__printf+0x4d0>
    800057dc:	f5dff06f          	j	80005738 <__printf+0x440>
    800057e0:	02500513          	li	a0,37
    800057e4:	00000097          	auipc	ra,0x0
    800057e8:	930080e7          	jalr	-1744(ra) # 80005114 <consputc>
    800057ec:	000c8513          	mv	a0,s9
    800057f0:	00000097          	auipc	ra,0x0
    800057f4:	924080e7          	jalr	-1756(ra) # 80005114 <consputc>
    800057f8:	f41ff06f          	j	80005738 <__printf+0x440>
    800057fc:	02500513          	li	a0,37
    80005800:	00000097          	auipc	ra,0x0
    80005804:	914080e7          	jalr	-1772(ra) # 80005114 <consputc>
    80005808:	f31ff06f          	j	80005738 <__printf+0x440>
    8000580c:	00030513          	mv	a0,t1
    80005810:	00000097          	auipc	ra,0x0
    80005814:	7bc080e7          	jalr	1980(ra) # 80005fcc <acquire>
    80005818:	b4dff06f          	j	80005364 <__printf+0x6c>
    8000581c:	40c0053b          	negw	a0,a2
    80005820:	00a00713          	li	a4,10
    80005824:	02e576bb          	remuw	a3,a0,a4
    80005828:	00002d97          	auipc	s11,0x2
    8000582c:	dd0d8d93          	addi	s11,s11,-560 # 800075f8 <digits>
    80005830:	ff700593          	li	a1,-9
    80005834:	02069693          	slli	a3,a3,0x20
    80005838:	0206d693          	srli	a3,a3,0x20
    8000583c:	00dd86b3          	add	a3,s11,a3
    80005840:	0006c683          	lbu	a3,0(a3)
    80005844:	02e557bb          	divuw	a5,a0,a4
    80005848:	f8d40023          	sb	a3,-128(s0)
    8000584c:	10b65e63          	bge	a2,a1,80005968 <__printf+0x670>
    80005850:	06300593          	li	a1,99
    80005854:	02e7f6bb          	remuw	a3,a5,a4
    80005858:	02069693          	slli	a3,a3,0x20
    8000585c:	0206d693          	srli	a3,a3,0x20
    80005860:	00dd86b3          	add	a3,s11,a3
    80005864:	0006c683          	lbu	a3,0(a3)
    80005868:	02e7d73b          	divuw	a4,a5,a4
    8000586c:	00200793          	li	a5,2
    80005870:	f8d400a3          	sb	a3,-127(s0)
    80005874:	bca5ece3          	bltu	a1,a0,8000544c <__printf+0x154>
    80005878:	ce5ff06f          	j	8000555c <__printf+0x264>
    8000587c:	40e007bb          	negw	a5,a4
    80005880:	00002d97          	auipc	s11,0x2
    80005884:	d78d8d93          	addi	s11,s11,-648 # 800075f8 <digits>
    80005888:	00f7f693          	andi	a3,a5,15
    8000588c:	00dd86b3          	add	a3,s11,a3
    80005890:	0006c583          	lbu	a1,0(a3)
    80005894:	ff100613          	li	a2,-15
    80005898:	0047d69b          	srliw	a3,a5,0x4
    8000589c:	f8b40023          	sb	a1,-128(s0)
    800058a0:	0047d59b          	srliw	a1,a5,0x4
    800058a4:	0ac75e63          	bge	a4,a2,80005960 <__printf+0x668>
    800058a8:	00f6f693          	andi	a3,a3,15
    800058ac:	00dd86b3          	add	a3,s11,a3
    800058b0:	0006c603          	lbu	a2,0(a3)
    800058b4:	00f00693          	li	a3,15
    800058b8:	0087d79b          	srliw	a5,a5,0x8
    800058bc:	f8c400a3          	sb	a2,-127(s0)
    800058c0:	d8b6e4e3          	bltu	a3,a1,80005648 <__printf+0x350>
    800058c4:	00200793          	li	a5,2
    800058c8:	e2dff06f          	j	800056f4 <__printf+0x3fc>
    800058cc:	00002c97          	auipc	s9,0x2
    800058d0:	d0cc8c93          	addi	s9,s9,-756 # 800075d8 <kvmincrease+0xb78>
    800058d4:	02800513          	li	a0,40
    800058d8:	ef1ff06f          	j	800057c8 <__printf+0x4d0>
    800058dc:	00700793          	li	a5,7
    800058e0:	00600c93          	li	s9,6
    800058e4:	e0dff06f          	j	800056f0 <__printf+0x3f8>
    800058e8:	00700793          	li	a5,7
    800058ec:	00600c93          	li	s9,6
    800058f0:	c69ff06f          	j	80005558 <__printf+0x260>
    800058f4:	00300793          	li	a5,3
    800058f8:	00200c93          	li	s9,2
    800058fc:	c5dff06f          	j	80005558 <__printf+0x260>
    80005900:	00300793          	li	a5,3
    80005904:	00200c93          	li	s9,2
    80005908:	de9ff06f          	j	800056f0 <__printf+0x3f8>
    8000590c:	00400793          	li	a5,4
    80005910:	00300c93          	li	s9,3
    80005914:	dddff06f          	j	800056f0 <__printf+0x3f8>
    80005918:	00400793          	li	a5,4
    8000591c:	00300c93          	li	s9,3
    80005920:	c39ff06f          	j	80005558 <__printf+0x260>
    80005924:	00500793          	li	a5,5
    80005928:	00400c93          	li	s9,4
    8000592c:	c2dff06f          	j	80005558 <__printf+0x260>
    80005930:	00500793          	li	a5,5
    80005934:	00400c93          	li	s9,4
    80005938:	db9ff06f          	j	800056f0 <__printf+0x3f8>
    8000593c:	00600793          	li	a5,6
    80005940:	00500c93          	li	s9,5
    80005944:	dadff06f          	j	800056f0 <__printf+0x3f8>
    80005948:	00600793          	li	a5,6
    8000594c:	00500c93          	li	s9,5
    80005950:	c09ff06f          	j	80005558 <__printf+0x260>
    80005954:	00800793          	li	a5,8
    80005958:	00700c93          	li	s9,7
    8000595c:	bfdff06f          	j	80005558 <__printf+0x260>
    80005960:	00100793          	li	a5,1
    80005964:	d91ff06f          	j	800056f4 <__printf+0x3fc>
    80005968:	00100793          	li	a5,1
    8000596c:	bf1ff06f          	j	8000555c <__printf+0x264>
    80005970:	00900793          	li	a5,9
    80005974:	00800c93          	li	s9,8
    80005978:	be1ff06f          	j	80005558 <__printf+0x260>
    8000597c:	00002517          	auipc	a0,0x2
    80005980:	c6450513          	addi	a0,a0,-924 # 800075e0 <kvmincrease+0xb80>
    80005984:	00000097          	auipc	ra,0x0
    80005988:	918080e7          	jalr	-1768(ra) # 8000529c <panic>

000000008000598c <printfinit>:
    8000598c:	fe010113          	addi	sp,sp,-32
    80005990:	00813823          	sd	s0,16(sp)
    80005994:	00913423          	sd	s1,8(sp)
    80005998:	00113c23          	sd	ra,24(sp)
    8000599c:	02010413          	addi	s0,sp,32
    800059a0:	00004497          	auipc	s1,0x4
    800059a4:	63048493          	addi	s1,s1,1584 # 80009fd0 <pr>
    800059a8:	00048513          	mv	a0,s1
    800059ac:	00002597          	auipc	a1,0x2
    800059b0:	c4458593          	addi	a1,a1,-956 # 800075f0 <kvmincrease+0xb90>
    800059b4:	00000097          	auipc	ra,0x0
    800059b8:	5f4080e7          	jalr	1524(ra) # 80005fa8 <initlock>
    800059bc:	01813083          	ld	ra,24(sp)
    800059c0:	01013403          	ld	s0,16(sp)
    800059c4:	0004ac23          	sw	zero,24(s1)
    800059c8:	00813483          	ld	s1,8(sp)
    800059cc:	02010113          	addi	sp,sp,32
    800059d0:	00008067          	ret

00000000800059d4 <uartinit>:
    800059d4:	ff010113          	addi	sp,sp,-16
    800059d8:	00813423          	sd	s0,8(sp)
    800059dc:	01010413          	addi	s0,sp,16
    800059e0:	100007b7          	lui	a5,0x10000
    800059e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800059e8:	f8000713          	li	a4,-128
    800059ec:	00e781a3          	sb	a4,3(a5)
    800059f0:	00300713          	li	a4,3
    800059f4:	00e78023          	sb	a4,0(a5)
    800059f8:	000780a3          	sb	zero,1(a5)
    800059fc:	00e781a3          	sb	a4,3(a5)
    80005a00:	00700693          	li	a3,7
    80005a04:	00d78123          	sb	a3,2(a5)
    80005a08:	00e780a3          	sb	a4,1(a5)
    80005a0c:	00813403          	ld	s0,8(sp)
    80005a10:	01010113          	addi	sp,sp,16
    80005a14:	00008067          	ret

0000000080005a18 <uartputc>:
    80005a18:	00003797          	auipc	a5,0x3
    80005a1c:	3207a783          	lw	a5,800(a5) # 80008d38 <panicked>
    80005a20:	00078463          	beqz	a5,80005a28 <uartputc+0x10>
    80005a24:	0000006f          	j	80005a24 <uartputc+0xc>
    80005a28:	fd010113          	addi	sp,sp,-48
    80005a2c:	02813023          	sd	s0,32(sp)
    80005a30:	00913c23          	sd	s1,24(sp)
    80005a34:	01213823          	sd	s2,16(sp)
    80005a38:	01313423          	sd	s3,8(sp)
    80005a3c:	02113423          	sd	ra,40(sp)
    80005a40:	03010413          	addi	s0,sp,48
    80005a44:	00003917          	auipc	s2,0x3
    80005a48:	2fc90913          	addi	s2,s2,764 # 80008d40 <uart_tx_r>
    80005a4c:	00093783          	ld	a5,0(s2)
    80005a50:	00003497          	auipc	s1,0x3
    80005a54:	2f848493          	addi	s1,s1,760 # 80008d48 <uart_tx_w>
    80005a58:	0004b703          	ld	a4,0(s1)
    80005a5c:	02078693          	addi	a3,a5,32
    80005a60:	00050993          	mv	s3,a0
    80005a64:	02e69c63          	bne	a3,a4,80005a9c <uartputc+0x84>
    80005a68:	00001097          	auipc	ra,0x1
    80005a6c:	834080e7          	jalr	-1996(ra) # 8000629c <push_on>
    80005a70:	00093783          	ld	a5,0(s2)
    80005a74:	0004b703          	ld	a4,0(s1)
    80005a78:	02078793          	addi	a5,a5,32
    80005a7c:	00e79463          	bne	a5,a4,80005a84 <uartputc+0x6c>
    80005a80:	0000006f          	j	80005a80 <uartputc+0x68>
    80005a84:	00001097          	auipc	ra,0x1
    80005a88:	88c080e7          	jalr	-1908(ra) # 80006310 <pop_on>
    80005a8c:	00093783          	ld	a5,0(s2)
    80005a90:	0004b703          	ld	a4,0(s1)
    80005a94:	02078693          	addi	a3,a5,32
    80005a98:	fce688e3          	beq	a3,a4,80005a68 <uartputc+0x50>
    80005a9c:	01f77693          	andi	a3,a4,31
    80005aa0:	00004597          	auipc	a1,0x4
    80005aa4:	55058593          	addi	a1,a1,1360 # 80009ff0 <uart_tx_buf>
    80005aa8:	00d586b3          	add	a3,a1,a3
    80005aac:	00170713          	addi	a4,a4,1
    80005ab0:	01368023          	sb	s3,0(a3)
    80005ab4:	00e4b023          	sd	a4,0(s1)
    80005ab8:	10000637          	lui	a2,0x10000
    80005abc:	02f71063          	bne	a4,a5,80005adc <uartputc+0xc4>
    80005ac0:	0340006f          	j	80005af4 <uartputc+0xdc>
    80005ac4:	00074703          	lbu	a4,0(a4)
    80005ac8:	00f93023          	sd	a5,0(s2)
    80005acc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005ad0:	00093783          	ld	a5,0(s2)
    80005ad4:	0004b703          	ld	a4,0(s1)
    80005ad8:	00f70e63          	beq	a4,a5,80005af4 <uartputc+0xdc>
    80005adc:	00564683          	lbu	a3,5(a2)
    80005ae0:	01f7f713          	andi	a4,a5,31
    80005ae4:	00e58733          	add	a4,a1,a4
    80005ae8:	0206f693          	andi	a3,a3,32
    80005aec:	00178793          	addi	a5,a5,1
    80005af0:	fc069ae3          	bnez	a3,80005ac4 <uartputc+0xac>
    80005af4:	02813083          	ld	ra,40(sp)
    80005af8:	02013403          	ld	s0,32(sp)
    80005afc:	01813483          	ld	s1,24(sp)
    80005b00:	01013903          	ld	s2,16(sp)
    80005b04:	00813983          	ld	s3,8(sp)
    80005b08:	03010113          	addi	sp,sp,48
    80005b0c:	00008067          	ret

0000000080005b10 <uartputc_sync>:
    80005b10:	ff010113          	addi	sp,sp,-16
    80005b14:	00813423          	sd	s0,8(sp)
    80005b18:	01010413          	addi	s0,sp,16
    80005b1c:	00003717          	auipc	a4,0x3
    80005b20:	21c72703          	lw	a4,540(a4) # 80008d38 <panicked>
    80005b24:	02071663          	bnez	a4,80005b50 <uartputc_sync+0x40>
    80005b28:	00050793          	mv	a5,a0
    80005b2c:	100006b7          	lui	a3,0x10000
    80005b30:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005b34:	02077713          	andi	a4,a4,32
    80005b38:	fe070ce3          	beqz	a4,80005b30 <uartputc_sync+0x20>
    80005b3c:	0ff7f793          	andi	a5,a5,255
    80005b40:	00f68023          	sb	a5,0(a3)
    80005b44:	00813403          	ld	s0,8(sp)
    80005b48:	01010113          	addi	sp,sp,16
    80005b4c:	00008067          	ret
    80005b50:	0000006f          	j	80005b50 <uartputc_sync+0x40>

0000000080005b54 <uartstart>:
    80005b54:	ff010113          	addi	sp,sp,-16
    80005b58:	00813423          	sd	s0,8(sp)
    80005b5c:	01010413          	addi	s0,sp,16
    80005b60:	00003617          	auipc	a2,0x3
    80005b64:	1e060613          	addi	a2,a2,480 # 80008d40 <uart_tx_r>
    80005b68:	00003517          	auipc	a0,0x3
    80005b6c:	1e050513          	addi	a0,a0,480 # 80008d48 <uart_tx_w>
    80005b70:	00063783          	ld	a5,0(a2)
    80005b74:	00053703          	ld	a4,0(a0)
    80005b78:	04f70263          	beq	a4,a5,80005bbc <uartstart+0x68>
    80005b7c:	100005b7          	lui	a1,0x10000
    80005b80:	00004817          	auipc	a6,0x4
    80005b84:	47080813          	addi	a6,a6,1136 # 80009ff0 <uart_tx_buf>
    80005b88:	01c0006f          	j	80005ba4 <uartstart+0x50>
    80005b8c:	0006c703          	lbu	a4,0(a3)
    80005b90:	00f63023          	sd	a5,0(a2)
    80005b94:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005b98:	00063783          	ld	a5,0(a2)
    80005b9c:	00053703          	ld	a4,0(a0)
    80005ba0:	00f70e63          	beq	a4,a5,80005bbc <uartstart+0x68>
    80005ba4:	01f7f713          	andi	a4,a5,31
    80005ba8:	00e806b3          	add	a3,a6,a4
    80005bac:	0055c703          	lbu	a4,5(a1)
    80005bb0:	00178793          	addi	a5,a5,1
    80005bb4:	02077713          	andi	a4,a4,32
    80005bb8:	fc071ae3          	bnez	a4,80005b8c <uartstart+0x38>
    80005bbc:	00813403          	ld	s0,8(sp)
    80005bc0:	01010113          	addi	sp,sp,16
    80005bc4:	00008067          	ret

0000000080005bc8 <uartgetc>:
    80005bc8:	ff010113          	addi	sp,sp,-16
    80005bcc:	00813423          	sd	s0,8(sp)
    80005bd0:	01010413          	addi	s0,sp,16
    80005bd4:	10000737          	lui	a4,0x10000
    80005bd8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005bdc:	0017f793          	andi	a5,a5,1
    80005be0:	00078c63          	beqz	a5,80005bf8 <uartgetc+0x30>
    80005be4:	00074503          	lbu	a0,0(a4)
    80005be8:	0ff57513          	andi	a0,a0,255
    80005bec:	00813403          	ld	s0,8(sp)
    80005bf0:	01010113          	addi	sp,sp,16
    80005bf4:	00008067          	ret
    80005bf8:	fff00513          	li	a0,-1
    80005bfc:	ff1ff06f          	j	80005bec <uartgetc+0x24>

0000000080005c00 <uartintr>:
    80005c00:	100007b7          	lui	a5,0x10000
    80005c04:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005c08:	0017f793          	andi	a5,a5,1
    80005c0c:	0a078463          	beqz	a5,80005cb4 <uartintr+0xb4>
    80005c10:	fe010113          	addi	sp,sp,-32
    80005c14:	00813823          	sd	s0,16(sp)
    80005c18:	00913423          	sd	s1,8(sp)
    80005c1c:	00113c23          	sd	ra,24(sp)
    80005c20:	02010413          	addi	s0,sp,32
    80005c24:	100004b7          	lui	s1,0x10000
    80005c28:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80005c2c:	0ff57513          	andi	a0,a0,255
    80005c30:	fffff097          	auipc	ra,0xfffff
    80005c34:	534080e7          	jalr	1332(ra) # 80005164 <consoleintr>
    80005c38:	0054c783          	lbu	a5,5(s1)
    80005c3c:	0017f793          	andi	a5,a5,1
    80005c40:	fe0794e3          	bnez	a5,80005c28 <uartintr+0x28>
    80005c44:	00003617          	auipc	a2,0x3
    80005c48:	0fc60613          	addi	a2,a2,252 # 80008d40 <uart_tx_r>
    80005c4c:	00003517          	auipc	a0,0x3
    80005c50:	0fc50513          	addi	a0,a0,252 # 80008d48 <uart_tx_w>
    80005c54:	00063783          	ld	a5,0(a2)
    80005c58:	00053703          	ld	a4,0(a0)
    80005c5c:	04f70263          	beq	a4,a5,80005ca0 <uartintr+0xa0>
    80005c60:	100005b7          	lui	a1,0x10000
    80005c64:	00004817          	auipc	a6,0x4
    80005c68:	38c80813          	addi	a6,a6,908 # 80009ff0 <uart_tx_buf>
    80005c6c:	01c0006f          	j	80005c88 <uartintr+0x88>
    80005c70:	0006c703          	lbu	a4,0(a3)
    80005c74:	00f63023          	sd	a5,0(a2)
    80005c78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005c7c:	00063783          	ld	a5,0(a2)
    80005c80:	00053703          	ld	a4,0(a0)
    80005c84:	00f70e63          	beq	a4,a5,80005ca0 <uartintr+0xa0>
    80005c88:	01f7f713          	andi	a4,a5,31
    80005c8c:	00e806b3          	add	a3,a6,a4
    80005c90:	0055c703          	lbu	a4,5(a1)
    80005c94:	00178793          	addi	a5,a5,1
    80005c98:	02077713          	andi	a4,a4,32
    80005c9c:	fc071ae3          	bnez	a4,80005c70 <uartintr+0x70>
    80005ca0:	01813083          	ld	ra,24(sp)
    80005ca4:	01013403          	ld	s0,16(sp)
    80005ca8:	00813483          	ld	s1,8(sp)
    80005cac:	02010113          	addi	sp,sp,32
    80005cb0:	00008067          	ret
    80005cb4:	00003617          	auipc	a2,0x3
    80005cb8:	08c60613          	addi	a2,a2,140 # 80008d40 <uart_tx_r>
    80005cbc:	00003517          	auipc	a0,0x3
    80005cc0:	08c50513          	addi	a0,a0,140 # 80008d48 <uart_tx_w>
    80005cc4:	00063783          	ld	a5,0(a2)
    80005cc8:	00053703          	ld	a4,0(a0)
    80005ccc:	04f70263          	beq	a4,a5,80005d10 <uartintr+0x110>
    80005cd0:	100005b7          	lui	a1,0x10000
    80005cd4:	00004817          	auipc	a6,0x4
    80005cd8:	31c80813          	addi	a6,a6,796 # 80009ff0 <uart_tx_buf>
    80005cdc:	01c0006f          	j	80005cf8 <uartintr+0xf8>
    80005ce0:	0006c703          	lbu	a4,0(a3)
    80005ce4:	00f63023          	sd	a5,0(a2)
    80005ce8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005cec:	00063783          	ld	a5,0(a2)
    80005cf0:	00053703          	ld	a4,0(a0)
    80005cf4:	02f70063          	beq	a4,a5,80005d14 <uartintr+0x114>
    80005cf8:	01f7f713          	andi	a4,a5,31
    80005cfc:	00e806b3          	add	a3,a6,a4
    80005d00:	0055c703          	lbu	a4,5(a1)
    80005d04:	00178793          	addi	a5,a5,1
    80005d08:	02077713          	andi	a4,a4,32
    80005d0c:	fc071ae3          	bnez	a4,80005ce0 <uartintr+0xe0>
    80005d10:	00008067          	ret
    80005d14:	00008067          	ret

0000000080005d18 <kinit>:
    80005d18:	fc010113          	addi	sp,sp,-64
    80005d1c:	02913423          	sd	s1,40(sp)
    80005d20:	fffff7b7          	lui	a5,0xfffff
    80005d24:	00005497          	auipc	s1,0x5
    80005d28:	2fb48493          	addi	s1,s1,763 # 8000b01f <end+0xfff>
    80005d2c:	02813823          	sd	s0,48(sp)
    80005d30:	01313c23          	sd	s3,24(sp)
    80005d34:	00f4f4b3          	and	s1,s1,a5
    80005d38:	02113c23          	sd	ra,56(sp)
    80005d3c:	03213023          	sd	s2,32(sp)
    80005d40:	01413823          	sd	s4,16(sp)
    80005d44:	01513423          	sd	s5,8(sp)
    80005d48:	04010413          	addi	s0,sp,64
    80005d4c:	000017b7          	lui	a5,0x1
    80005d50:	01100993          	li	s3,17
    80005d54:	00f487b3          	add	a5,s1,a5
    80005d58:	01b99993          	slli	s3,s3,0x1b
    80005d5c:	06f9e063          	bltu	s3,a5,80005dbc <kinit+0xa4>
    80005d60:	00004a97          	auipc	s5,0x4
    80005d64:	2c0a8a93          	addi	s5,s5,704 # 8000a020 <end>
    80005d68:	0754ec63          	bltu	s1,s5,80005de0 <kinit+0xc8>
    80005d6c:	0734fa63          	bgeu	s1,s3,80005de0 <kinit+0xc8>
    80005d70:	00088a37          	lui	s4,0x88
    80005d74:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005d78:	00003917          	auipc	s2,0x3
    80005d7c:	fd890913          	addi	s2,s2,-40 # 80008d50 <kmem>
    80005d80:	00ca1a13          	slli	s4,s4,0xc
    80005d84:	0140006f          	j	80005d98 <kinit+0x80>
    80005d88:	000017b7          	lui	a5,0x1
    80005d8c:	00f484b3          	add	s1,s1,a5
    80005d90:	0554e863          	bltu	s1,s5,80005de0 <kinit+0xc8>
    80005d94:	0534f663          	bgeu	s1,s3,80005de0 <kinit+0xc8>
    80005d98:	00001637          	lui	a2,0x1
    80005d9c:	00100593          	li	a1,1
    80005da0:	00048513          	mv	a0,s1
    80005da4:	00000097          	auipc	ra,0x0
    80005da8:	5e4080e7          	jalr	1508(ra) # 80006388 <__memset>
    80005dac:	00093783          	ld	a5,0(s2)
    80005db0:	00f4b023          	sd	a5,0(s1)
    80005db4:	00993023          	sd	s1,0(s2)
    80005db8:	fd4498e3          	bne	s1,s4,80005d88 <kinit+0x70>
    80005dbc:	03813083          	ld	ra,56(sp)
    80005dc0:	03013403          	ld	s0,48(sp)
    80005dc4:	02813483          	ld	s1,40(sp)
    80005dc8:	02013903          	ld	s2,32(sp)
    80005dcc:	01813983          	ld	s3,24(sp)
    80005dd0:	01013a03          	ld	s4,16(sp)
    80005dd4:	00813a83          	ld	s5,8(sp)
    80005dd8:	04010113          	addi	sp,sp,64
    80005ddc:	00008067          	ret
    80005de0:	00002517          	auipc	a0,0x2
    80005de4:	83050513          	addi	a0,a0,-2000 # 80007610 <digits+0x18>
    80005de8:	fffff097          	auipc	ra,0xfffff
    80005dec:	4b4080e7          	jalr	1204(ra) # 8000529c <panic>

0000000080005df0 <freerange>:
    80005df0:	fc010113          	addi	sp,sp,-64
    80005df4:	000017b7          	lui	a5,0x1
    80005df8:	02913423          	sd	s1,40(sp)
    80005dfc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005e00:	009504b3          	add	s1,a0,s1
    80005e04:	fffff537          	lui	a0,0xfffff
    80005e08:	02813823          	sd	s0,48(sp)
    80005e0c:	02113c23          	sd	ra,56(sp)
    80005e10:	03213023          	sd	s2,32(sp)
    80005e14:	01313c23          	sd	s3,24(sp)
    80005e18:	01413823          	sd	s4,16(sp)
    80005e1c:	01513423          	sd	s5,8(sp)
    80005e20:	01613023          	sd	s6,0(sp)
    80005e24:	04010413          	addi	s0,sp,64
    80005e28:	00a4f4b3          	and	s1,s1,a0
    80005e2c:	00f487b3          	add	a5,s1,a5
    80005e30:	06f5e463          	bltu	a1,a5,80005e98 <freerange+0xa8>
    80005e34:	00004a97          	auipc	s5,0x4
    80005e38:	1eca8a93          	addi	s5,s5,492 # 8000a020 <end>
    80005e3c:	0954e263          	bltu	s1,s5,80005ec0 <freerange+0xd0>
    80005e40:	01100993          	li	s3,17
    80005e44:	01b99993          	slli	s3,s3,0x1b
    80005e48:	0734fc63          	bgeu	s1,s3,80005ec0 <freerange+0xd0>
    80005e4c:	00058a13          	mv	s4,a1
    80005e50:	00003917          	auipc	s2,0x3
    80005e54:	f0090913          	addi	s2,s2,-256 # 80008d50 <kmem>
    80005e58:	00002b37          	lui	s6,0x2
    80005e5c:	0140006f          	j	80005e70 <freerange+0x80>
    80005e60:	000017b7          	lui	a5,0x1
    80005e64:	00f484b3          	add	s1,s1,a5
    80005e68:	0554ec63          	bltu	s1,s5,80005ec0 <freerange+0xd0>
    80005e6c:	0534fa63          	bgeu	s1,s3,80005ec0 <freerange+0xd0>
    80005e70:	00001637          	lui	a2,0x1
    80005e74:	00100593          	li	a1,1
    80005e78:	00048513          	mv	a0,s1
    80005e7c:	00000097          	auipc	ra,0x0
    80005e80:	50c080e7          	jalr	1292(ra) # 80006388 <__memset>
    80005e84:	00093703          	ld	a4,0(s2)
    80005e88:	016487b3          	add	a5,s1,s6
    80005e8c:	00e4b023          	sd	a4,0(s1)
    80005e90:	00993023          	sd	s1,0(s2)
    80005e94:	fcfa76e3          	bgeu	s4,a5,80005e60 <freerange+0x70>
    80005e98:	03813083          	ld	ra,56(sp)
    80005e9c:	03013403          	ld	s0,48(sp)
    80005ea0:	02813483          	ld	s1,40(sp)
    80005ea4:	02013903          	ld	s2,32(sp)
    80005ea8:	01813983          	ld	s3,24(sp)
    80005eac:	01013a03          	ld	s4,16(sp)
    80005eb0:	00813a83          	ld	s5,8(sp)
    80005eb4:	00013b03          	ld	s6,0(sp)
    80005eb8:	04010113          	addi	sp,sp,64
    80005ebc:	00008067          	ret
    80005ec0:	00001517          	auipc	a0,0x1
    80005ec4:	75050513          	addi	a0,a0,1872 # 80007610 <digits+0x18>
    80005ec8:	fffff097          	auipc	ra,0xfffff
    80005ecc:	3d4080e7          	jalr	980(ra) # 8000529c <panic>

0000000080005ed0 <kfree>:
    80005ed0:	fe010113          	addi	sp,sp,-32
    80005ed4:	00813823          	sd	s0,16(sp)
    80005ed8:	00113c23          	sd	ra,24(sp)
    80005edc:	00913423          	sd	s1,8(sp)
    80005ee0:	02010413          	addi	s0,sp,32
    80005ee4:	03451793          	slli	a5,a0,0x34
    80005ee8:	04079c63          	bnez	a5,80005f40 <kfree+0x70>
    80005eec:	00004797          	auipc	a5,0x4
    80005ef0:	13478793          	addi	a5,a5,308 # 8000a020 <end>
    80005ef4:	00050493          	mv	s1,a0
    80005ef8:	04f56463          	bltu	a0,a5,80005f40 <kfree+0x70>
    80005efc:	01100793          	li	a5,17
    80005f00:	01b79793          	slli	a5,a5,0x1b
    80005f04:	02f57e63          	bgeu	a0,a5,80005f40 <kfree+0x70>
    80005f08:	00001637          	lui	a2,0x1
    80005f0c:	00100593          	li	a1,1
    80005f10:	00000097          	auipc	ra,0x0
    80005f14:	478080e7          	jalr	1144(ra) # 80006388 <__memset>
    80005f18:	00003797          	auipc	a5,0x3
    80005f1c:	e3878793          	addi	a5,a5,-456 # 80008d50 <kmem>
    80005f20:	0007b703          	ld	a4,0(a5)
    80005f24:	01813083          	ld	ra,24(sp)
    80005f28:	01013403          	ld	s0,16(sp)
    80005f2c:	00e4b023          	sd	a4,0(s1)
    80005f30:	0097b023          	sd	s1,0(a5)
    80005f34:	00813483          	ld	s1,8(sp)
    80005f38:	02010113          	addi	sp,sp,32
    80005f3c:	00008067          	ret
    80005f40:	00001517          	auipc	a0,0x1
    80005f44:	6d050513          	addi	a0,a0,1744 # 80007610 <digits+0x18>
    80005f48:	fffff097          	auipc	ra,0xfffff
    80005f4c:	354080e7          	jalr	852(ra) # 8000529c <panic>

0000000080005f50 <kalloc>:
    80005f50:	fe010113          	addi	sp,sp,-32
    80005f54:	00813823          	sd	s0,16(sp)
    80005f58:	00913423          	sd	s1,8(sp)
    80005f5c:	00113c23          	sd	ra,24(sp)
    80005f60:	02010413          	addi	s0,sp,32
    80005f64:	00003797          	auipc	a5,0x3
    80005f68:	dec78793          	addi	a5,a5,-532 # 80008d50 <kmem>
    80005f6c:	0007b483          	ld	s1,0(a5)
    80005f70:	02048063          	beqz	s1,80005f90 <kalloc+0x40>
    80005f74:	0004b703          	ld	a4,0(s1)
    80005f78:	00001637          	lui	a2,0x1
    80005f7c:	00500593          	li	a1,5
    80005f80:	00048513          	mv	a0,s1
    80005f84:	00e7b023          	sd	a4,0(a5)
    80005f88:	00000097          	auipc	ra,0x0
    80005f8c:	400080e7          	jalr	1024(ra) # 80006388 <__memset>
    80005f90:	01813083          	ld	ra,24(sp)
    80005f94:	01013403          	ld	s0,16(sp)
    80005f98:	00048513          	mv	a0,s1
    80005f9c:	00813483          	ld	s1,8(sp)
    80005fa0:	02010113          	addi	sp,sp,32
    80005fa4:	00008067          	ret

0000000080005fa8 <initlock>:
    80005fa8:	ff010113          	addi	sp,sp,-16
    80005fac:	00813423          	sd	s0,8(sp)
    80005fb0:	01010413          	addi	s0,sp,16
    80005fb4:	00813403          	ld	s0,8(sp)
    80005fb8:	00b53423          	sd	a1,8(a0)
    80005fbc:	00052023          	sw	zero,0(a0)
    80005fc0:	00053823          	sd	zero,16(a0)
    80005fc4:	01010113          	addi	sp,sp,16
    80005fc8:	00008067          	ret

0000000080005fcc <acquire>:
    80005fcc:	fe010113          	addi	sp,sp,-32
    80005fd0:	00813823          	sd	s0,16(sp)
    80005fd4:	00913423          	sd	s1,8(sp)
    80005fd8:	00113c23          	sd	ra,24(sp)
    80005fdc:	01213023          	sd	s2,0(sp)
    80005fe0:	02010413          	addi	s0,sp,32
    80005fe4:	00050493          	mv	s1,a0
    80005fe8:	10002973          	csrr	s2,sstatus
    80005fec:	100027f3          	csrr	a5,sstatus
    80005ff0:	ffd7f793          	andi	a5,a5,-3
    80005ff4:	10079073          	csrw	sstatus,a5
    80005ff8:	fffff097          	auipc	ra,0xfffff
    80005ffc:	8e8080e7          	jalr	-1816(ra) # 800048e0 <mycpu>
    80006000:	07852783          	lw	a5,120(a0)
    80006004:	06078e63          	beqz	a5,80006080 <acquire+0xb4>
    80006008:	fffff097          	auipc	ra,0xfffff
    8000600c:	8d8080e7          	jalr	-1832(ra) # 800048e0 <mycpu>
    80006010:	07852783          	lw	a5,120(a0)
    80006014:	0004a703          	lw	a4,0(s1)
    80006018:	0017879b          	addiw	a5,a5,1
    8000601c:	06f52c23          	sw	a5,120(a0)
    80006020:	04071063          	bnez	a4,80006060 <acquire+0x94>
    80006024:	00100713          	li	a4,1
    80006028:	00070793          	mv	a5,a4
    8000602c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006030:	0007879b          	sext.w	a5,a5
    80006034:	fe079ae3          	bnez	a5,80006028 <acquire+0x5c>
    80006038:	0ff0000f          	fence
    8000603c:	fffff097          	auipc	ra,0xfffff
    80006040:	8a4080e7          	jalr	-1884(ra) # 800048e0 <mycpu>
    80006044:	01813083          	ld	ra,24(sp)
    80006048:	01013403          	ld	s0,16(sp)
    8000604c:	00a4b823          	sd	a0,16(s1)
    80006050:	00013903          	ld	s2,0(sp)
    80006054:	00813483          	ld	s1,8(sp)
    80006058:	02010113          	addi	sp,sp,32
    8000605c:	00008067          	ret
    80006060:	0104b903          	ld	s2,16(s1)
    80006064:	fffff097          	auipc	ra,0xfffff
    80006068:	87c080e7          	jalr	-1924(ra) # 800048e0 <mycpu>
    8000606c:	faa91ce3          	bne	s2,a0,80006024 <acquire+0x58>
    80006070:	00001517          	auipc	a0,0x1
    80006074:	5a850513          	addi	a0,a0,1448 # 80007618 <digits+0x20>
    80006078:	fffff097          	auipc	ra,0xfffff
    8000607c:	224080e7          	jalr	548(ra) # 8000529c <panic>
    80006080:	00195913          	srli	s2,s2,0x1
    80006084:	fffff097          	auipc	ra,0xfffff
    80006088:	85c080e7          	jalr	-1956(ra) # 800048e0 <mycpu>
    8000608c:	00197913          	andi	s2,s2,1
    80006090:	07252e23          	sw	s2,124(a0)
    80006094:	f75ff06f          	j	80006008 <acquire+0x3c>

0000000080006098 <release>:
    80006098:	fe010113          	addi	sp,sp,-32
    8000609c:	00813823          	sd	s0,16(sp)
    800060a0:	00113c23          	sd	ra,24(sp)
    800060a4:	00913423          	sd	s1,8(sp)
    800060a8:	01213023          	sd	s2,0(sp)
    800060ac:	02010413          	addi	s0,sp,32
    800060b0:	00052783          	lw	a5,0(a0)
    800060b4:	00079a63          	bnez	a5,800060c8 <release+0x30>
    800060b8:	00001517          	auipc	a0,0x1
    800060bc:	56850513          	addi	a0,a0,1384 # 80007620 <digits+0x28>
    800060c0:	fffff097          	auipc	ra,0xfffff
    800060c4:	1dc080e7          	jalr	476(ra) # 8000529c <panic>
    800060c8:	01053903          	ld	s2,16(a0)
    800060cc:	00050493          	mv	s1,a0
    800060d0:	fffff097          	auipc	ra,0xfffff
    800060d4:	810080e7          	jalr	-2032(ra) # 800048e0 <mycpu>
    800060d8:	fea910e3          	bne	s2,a0,800060b8 <release+0x20>
    800060dc:	0004b823          	sd	zero,16(s1)
    800060e0:	0ff0000f          	fence
    800060e4:	0f50000f          	fence	iorw,ow
    800060e8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800060ec:	ffffe097          	auipc	ra,0xffffe
    800060f0:	7f4080e7          	jalr	2036(ra) # 800048e0 <mycpu>
    800060f4:	100027f3          	csrr	a5,sstatus
    800060f8:	0027f793          	andi	a5,a5,2
    800060fc:	04079a63          	bnez	a5,80006150 <release+0xb8>
    80006100:	07852783          	lw	a5,120(a0)
    80006104:	02f05e63          	blez	a5,80006140 <release+0xa8>
    80006108:	fff7871b          	addiw	a4,a5,-1
    8000610c:	06e52c23          	sw	a4,120(a0)
    80006110:	00071c63          	bnez	a4,80006128 <release+0x90>
    80006114:	07c52783          	lw	a5,124(a0)
    80006118:	00078863          	beqz	a5,80006128 <release+0x90>
    8000611c:	100027f3          	csrr	a5,sstatus
    80006120:	0027e793          	ori	a5,a5,2
    80006124:	10079073          	csrw	sstatus,a5
    80006128:	01813083          	ld	ra,24(sp)
    8000612c:	01013403          	ld	s0,16(sp)
    80006130:	00813483          	ld	s1,8(sp)
    80006134:	00013903          	ld	s2,0(sp)
    80006138:	02010113          	addi	sp,sp,32
    8000613c:	00008067          	ret
    80006140:	00001517          	auipc	a0,0x1
    80006144:	50050513          	addi	a0,a0,1280 # 80007640 <digits+0x48>
    80006148:	fffff097          	auipc	ra,0xfffff
    8000614c:	154080e7          	jalr	340(ra) # 8000529c <panic>
    80006150:	00001517          	auipc	a0,0x1
    80006154:	4d850513          	addi	a0,a0,1240 # 80007628 <digits+0x30>
    80006158:	fffff097          	auipc	ra,0xfffff
    8000615c:	144080e7          	jalr	324(ra) # 8000529c <panic>

0000000080006160 <holding>:
    80006160:	00052783          	lw	a5,0(a0)
    80006164:	00079663          	bnez	a5,80006170 <holding+0x10>
    80006168:	00000513          	li	a0,0
    8000616c:	00008067          	ret
    80006170:	fe010113          	addi	sp,sp,-32
    80006174:	00813823          	sd	s0,16(sp)
    80006178:	00913423          	sd	s1,8(sp)
    8000617c:	00113c23          	sd	ra,24(sp)
    80006180:	02010413          	addi	s0,sp,32
    80006184:	01053483          	ld	s1,16(a0)
    80006188:	ffffe097          	auipc	ra,0xffffe
    8000618c:	758080e7          	jalr	1880(ra) # 800048e0 <mycpu>
    80006190:	01813083          	ld	ra,24(sp)
    80006194:	01013403          	ld	s0,16(sp)
    80006198:	40a48533          	sub	a0,s1,a0
    8000619c:	00153513          	seqz	a0,a0
    800061a0:	00813483          	ld	s1,8(sp)
    800061a4:	02010113          	addi	sp,sp,32
    800061a8:	00008067          	ret

00000000800061ac <push_off>:
    800061ac:	fe010113          	addi	sp,sp,-32
    800061b0:	00813823          	sd	s0,16(sp)
    800061b4:	00113c23          	sd	ra,24(sp)
    800061b8:	00913423          	sd	s1,8(sp)
    800061bc:	02010413          	addi	s0,sp,32
    800061c0:	100024f3          	csrr	s1,sstatus
    800061c4:	100027f3          	csrr	a5,sstatus
    800061c8:	ffd7f793          	andi	a5,a5,-3
    800061cc:	10079073          	csrw	sstatus,a5
    800061d0:	ffffe097          	auipc	ra,0xffffe
    800061d4:	710080e7          	jalr	1808(ra) # 800048e0 <mycpu>
    800061d8:	07852783          	lw	a5,120(a0)
    800061dc:	02078663          	beqz	a5,80006208 <push_off+0x5c>
    800061e0:	ffffe097          	auipc	ra,0xffffe
    800061e4:	700080e7          	jalr	1792(ra) # 800048e0 <mycpu>
    800061e8:	07852783          	lw	a5,120(a0)
    800061ec:	01813083          	ld	ra,24(sp)
    800061f0:	01013403          	ld	s0,16(sp)
    800061f4:	0017879b          	addiw	a5,a5,1
    800061f8:	06f52c23          	sw	a5,120(a0)
    800061fc:	00813483          	ld	s1,8(sp)
    80006200:	02010113          	addi	sp,sp,32
    80006204:	00008067          	ret
    80006208:	0014d493          	srli	s1,s1,0x1
    8000620c:	ffffe097          	auipc	ra,0xffffe
    80006210:	6d4080e7          	jalr	1748(ra) # 800048e0 <mycpu>
    80006214:	0014f493          	andi	s1,s1,1
    80006218:	06952e23          	sw	s1,124(a0)
    8000621c:	fc5ff06f          	j	800061e0 <push_off+0x34>

0000000080006220 <pop_off>:
    80006220:	ff010113          	addi	sp,sp,-16
    80006224:	00813023          	sd	s0,0(sp)
    80006228:	00113423          	sd	ra,8(sp)
    8000622c:	01010413          	addi	s0,sp,16
    80006230:	ffffe097          	auipc	ra,0xffffe
    80006234:	6b0080e7          	jalr	1712(ra) # 800048e0 <mycpu>
    80006238:	100027f3          	csrr	a5,sstatus
    8000623c:	0027f793          	andi	a5,a5,2
    80006240:	04079663          	bnez	a5,8000628c <pop_off+0x6c>
    80006244:	07852783          	lw	a5,120(a0)
    80006248:	02f05a63          	blez	a5,8000627c <pop_off+0x5c>
    8000624c:	fff7871b          	addiw	a4,a5,-1
    80006250:	06e52c23          	sw	a4,120(a0)
    80006254:	00071c63          	bnez	a4,8000626c <pop_off+0x4c>
    80006258:	07c52783          	lw	a5,124(a0)
    8000625c:	00078863          	beqz	a5,8000626c <pop_off+0x4c>
    80006260:	100027f3          	csrr	a5,sstatus
    80006264:	0027e793          	ori	a5,a5,2
    80006268:	10079073          	csrw	sstatus,a5
    8000626c:	00813083          	ld	ra,8(sp)
    80006270:	00013403          	ld	s0,0(sp)
    80006274:	01010113          	addi	sp,sp,16
    80006278:	00008067          	ret
    8000627c:	00001517          	auipc	a0,0x1
    80006280:	3c450513          	addi	a0,a0,964 # 80007640 <digits+0x48>
    80006284:	fffff097          	auipc	ra,0xfffff
    80006288:	018080e7          	jalr	24(ra) # 8000529c <panic>
    8000628c:	00001517          	auipc	a0,0x1
    80006290:	39c50513          	addi	a0,a0,924 # 80007628 <digits+0x30>
    80006294:	fffff097          	auipc	ra,0xfffff
    80006298:	008080e7          	jalr	8(ra) # 8000529c <panic>

000000008000629c <push_on>:
    8000629c:	fe010113          	addi	sp,sp,-32
    800062a0:	00813823          	sd	s0,16(sp)
    800062a4:	00113c23          	sd	ra,24(sp)
    800062a8:	00913423          	sd	s1,8(sp)
    800062ac:	02010413          	addi	s0,sp,32
    800062b0:	100024f3          	csrr	s1,sstatus
    800062b4:	100027f3          	csrr	a5,sstatus
    800062b8:	0027e793          	ori	a5,a5,2
    800062bc:	10079073          	csrw	sstatus,a5
    800062c0:	ffffe097          	auipc	ra,0xffffe
    800062c4:	620080e7          	jalr	1568(ra) # 800048e0 <mycpu>
    800062c8:	07852783          	lw	a5,120(a0)
    800062cc:	02078663          	beqz	a5,800062f8 <push_on+0x5c>
    800062d0:	ffffe097          	auipc	ra,0xffffe
    800062d4:	610080e7          	jalr	1552(ra) # 800048e0 <mycpu>
    800062d8:	07852783          	lw	a5,120(a0)
    800062dc:	01813083          	ld	ra,24(sp)
    800062e0:	01013403          	ld	s0,16(sp)
    800062e4:	0017879b          	addiw	a5,a5,1
    800062e8:	06f52c23          	sw	a5,120(a0)
    800062ec:	00813483          	ld	s1,8(sp)
    800062f0:	02010113          	addi	sp,sp,32
    800062f4:	00008067          	ret
    800062f8:	0014d493          	srli	s1,s1,0x1
    800062fc:	ffffe097          	auipc	ra,0xffffe
    80006300:	5e4080e7          	jalr	1508(ra) # 800048e0 <mycpu>
    80006304:	0014f493          	andi	s1,s1,1
    80006308:	06952e23          	sw	s1,124(a0)
    8000630c:	fc5ff06f          	j	800062d0 <push_on+0x34>

0000000080006310 <pop_on>:
    80006310:	ff010113          	addi	sp,sp,-16
    80006314:	00813023          	sd	s0,0(sp)
    80006318:	00113423          	sd	ra,8(sp)
    8000631c:	01010413          	addi	s0,sp,16
    80006320:	ffffe097          	auipc	ra,0xffffe
    80006324:	5c0080e7          	jalr	1472(ra) # 800048e0 <mycpu>
    80006328:	100027f3          	csrr	a5,sstatus
    8000632c:	0027f793          	andi	a5,a5,2
    80006330:	04078463          	beqz	a5,80006378 <pop_on+0x68>
    80006334:	07852783          	lw	a5,120(a0)
    80006338:	02f05863          	blez	a5,80006368 <pop_on+0x58>
    8000633c:	fff7879b          	addiw	a5,a5,-1
    80006340:	06f52c23          	sw	a5,120(a0)
    80006344:	07853783          	ld	a5,120(a0)
    80006348:	00079863          	bnez	a5,80006358 <pop_on+0x48>
    8000634c:	100027f3          	csrr	a5,sstatus
    80006350:	ffd7f793          	andi	a5,a5,-3
    80006354:	10079073          	csrw	sstatus,a5
    80006358:	00813083          	ld	ra,8(sp)
    8000635c:	00013403          	ld	s0,0(sp)
    80006360:	01010113          	addi	sp,sp,16
    80006364:	00008067          	ret
    80006368:	00001517          	auipc	a0,0x1
    8000636c:	30050513          	addi	a0,a0,768 # 80007668 <digits+0x70>
    80006370:	fffff097          	auipc	ra,0xfffff
    80006374:	f2c080e7          	jalr	-212(ra) # 8000529c <panic>
    80006378:	00001517          	auipc	a0,0x1
    8000637c:	2d050513          	addi	a0,a0,720 # 80007648 <digits+0x50>
    80006380:	fffff097          	auipc	ra,0xfffff
    80006384:	f1c080e7          	jalr	-228(ra) # 8000529c <panic>

0000000080006388 <__memset>:
    80006388:	ff010113          	addi	sp,sp,-16
    8000638c:	00813423          	sd	s0,8(sp)
    80006390:	01010413          	addi	s0,sp,16
    80006394:	1a060e63          	beqz	a2,80006550 <__memset+0x1c8>
    80006398:	40a007b3          	neg	a5,a0
    8000639c:	0077f793          	andi	a5,a5,7
    800063a0:	00778693          	addi	a3,a5,7
    800063a4:	00b00813          	li	a6,11
    800063a8:	0ff5f593          	andi	a1,a1,255
    800063ac:	fff6071b          	addiw	a4,a2,-1
    800063b0:	1b06e663          	bltu	a3,a6,8000655c <__memset+0x1d4>
    800063b4:	1cd76463          	bltu	a4,a3,8000657c <__memset+0x1f4>
    800063b8:	1a078e63          	beqz	a5,80006574 <__memset+0x1ec>
    800063bc:	00b50023          	sb	a1,0(a0)
    800063c0:	00100713          	li	a4,1
    800063c4:	1ae78463          	beq	a5,a4,8000656c <__memset+0x1e4>
    800063c8:	00b500a3          	sb	a1,1(a0)
    800063cc:	00200713          	li	a4,2
    800063d0:	1ae78a63          	beq	a5,a4,80006584 <__memset+0x1fc>
    800063d4:	00b50123          	sb	a1,2(a0)
    800063d8:	00300713          	li	a4,3
    800063dc:	18e78463          	beq	a5,a4,80006564 <__memset+0x1dc>
    800063e0:	00b501a3          	sb	a1,3(a0)
    800063e4:	00400713          	li	a4,4
    800063e8:	1ae78263          	beq	a5,a4,8000658c <__memset+0x204>
    800063ec:	00b50223          	sb	a1,4(a0)
    800063f0:	00500713          	li	a4,5
    800063f4:	1ae78063          	beq	a5,a4,80006594 <__memset+0x20c>
    800063f8:	00b502a3          	sb	a1,5(a0)
    800063fc:	00700713          	li	a4,7
    80006400:	18e79e63          	bne	a5,a4,8000659c <__memset+0x214>
    80006404:	00b50323          	sb	a1,6(a0)
    80006408:	00700e93          	li	t4,7
    8000640c:	00859713          	slli	a4,a1,0x8
    80006410:	00e5e733          	or	a4,a1,a4
    80006414:	01059e13          	slli	t3,a1,0x10
    80006418:	01c76e33          	or	t3,a4,t3
    8000641c:	01859313          	slli	t1,a1,0x18
    80006420:	006e6333          	or	t1,t3,t1
    80006424:	02059893          	slli	a7,a1,0x20
    80006428:	40f60e3b          	subw	t3,a2,a5
    8000642c:	011368b3          	or	a7,t1,a7
    80006430:	02859813          	slli	a6,a1,0x28
    80006434:	0108e833          	or	a6,a7,a6
    80006438:	03059693          	slli	a3,a1,0x30
    8000643c:	003e589b          	srliw	a7,t3,0x3
    80006440:	00d866b3          	or	a3,a6,a3
    80006444:	03859713          	slli	a4,a1,0x38
    80006448:	00389813          	slli	a6,a7,0x3
    8000644c:	00f507b3          	add	a5,a0,a5
    80006450:	00e6e733          	or	a4,a3,a4
    80006454:	000e089b          	sext.w	a7,t3
    80006458:	00f806b3          	add	a3,a6,a5
    8000645c:	00e7b023          	sd	a4,0(a5)
    80006460:	00878793          	addi	a5,a5,8
    80006464:	fed79ce3          	bne	a5,a3,8000645c <__memset+0xd4>
    80006468:	ff8e7793          	andi	a5,t3,-8
    8000646c:	0007871b          	sext.w	a4,a5
    80006470:	01d787bb          	addw	a5,a5,t4
    80006474:	0ce88e63          	beq	a7,a4,80006550 <__memset+0x1c8>
    80006478:	00f50733          	add	a4,a0,a5
    8000647c:	00b70023          	sb	a1,0(a4)
    80006480:	0017871b          	addiw	a4,a5,1
    80006484:	0cc77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006488:	00e50733          	add	a4,a0,a4
    8000648c:	00b70023          	sb	a1,0(a4)
    80006490:	0027871b          	addiw	a4,a5,2
    80006494:	0ac77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006498:	00e50733          	add	a4,a0,a4
    8000649c:	00b70023          	sb	a1,0(a4)
    800064a0:	0037871b          	addiw	a4,a5,3
    800064a4:	0ac77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064a8:	00e50733          	add	a4,a0,a4
    800064ac:	00b70023          	sb	a1,0(a4)
    800064b0:	0047871b          	addiw	a4,a5,4
    800064b4:	08c77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064b8:	00e50733          	add	a4,a0,a4
    800064bc:	00b70023          	sb	a1,0(a4)
    800064c0:	0057871b          	addiw	a4,a5,5
    800064c4:	08c77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064c8:	00e50733          	add	a4,a0,a4
    800064cc:	00b70023          	sb	a1,0(a4)
    800064d0:	0067871b          	addiw	a4,a5,6
    800064d4:	06c77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064d8:	00e50733          	add	a4,a0,a4
    800064dc:	00b70023          	sb	a1,0(a4)
    800064e0:	0077871b          	addiw	a4,a5,7
    800064e4:	06c77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064e8:	00e50733          	add	a4,a0,a4
    800064ec:	00b70023          	sb	a1,0(a4)
    800064f0:	0087871b          	addiw	a4,a5,8
    800064f4:	04c77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    800064f8:	00e50733          	add	a4,a0,a4
    800064fc:	00b70023          	sb	a1,0(a4)
    80006500:	0097871b          	addiw	a4,a5,9
    80006504:	04c77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006508:	00e50733          	add	a4,a0,a4
    8000650c:	00b70023          	sb	a1,0(a4)
    80006510:	00a7871b          	addiw	a4,a5,10
    80006514:	02c77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006518:	00e50733          	add	a4,a0,a4
    8000651c:	00b70023          	sb	a1,0(a4)
    80006520:	00b7871b          	addiw	a4,a5,11
    80006524:	02c77663          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006528:	00e50733          	add	a4,a0,a4
    8000652c:	00b70023          	sb	a1,0(a4)
    80006530:	00c7871b          	addiw	a4,a5,12
    80006534:	00c77e63          	bgeu	a4,a2,80006550 <__memset+0x1c8>
    80006538:	00e50733          	add	a4,a0,a4
    8000653c:	00b70023          	sb	a1,0(a4)
    80006540:	00d7879b          	addiw	a5,a5,13
    80006544:	00c7f663          	bgeu	a5,a2,80006550 <__memset+0x1c8>
    80006548:	00f507b3          	add	a5,a0,a5
    8000654c:	00b78023          	sb	a1,0(a5)
    80006550:	00813403          	ld	s0,8(sp)
    80006554:	01010113          	addi	sp,sp,16
    80006558:	00008067          	ret
    8000655c:	00b00693          	li	a3,11
    80006560:	e55ff06f          	j	800063b4 <__memset+0x2c>
    80006564:	00300e93          	li	t4,3
    80006568:	ea5ff06f          	j	8000640c <__memset+0x84>
    8000656c:	00100e93          	li	t4,1
    80006570:	e9dff06f          	j	8000640c <__memset+0x84>
    80006574:	00000e93          	li	t4,0
    80006578:	e95ff06f          	j	8000640c <__memset+0x84>
    8000657c:	00000793          	li	a5,0
    80006580:	ef9ff06f          	j	80006478 <__memset+0xf0>
    80006584:	00200e93          	li	t4,2
    80006588:	e85ff06f          	j	8000640c <__memset+0x84>
    8000658c:	00400e93          	li	t4,4
    80006590:	e7dff06f          	j	8000640c <__memset+0x84>
    80006594:	00500e93          	li	t4,5
    80006598:	e75ff06f          	j	8000640c <__memset+0x84>
    8000659c:	00600e93          	li	t4,6
    800065a0:	e6dff06f          	j	8000640c <__memset+0x84>

00000000800065a4 <__memmove>:
    800065a4:	ff010113          	addi	sp,sp,-16
    800065a8:	00813423          	sd	s0,8(sp)
    800065ac:	01010413          	addi	s0,sp,16
    800065b0:	0e060863          	beqz	a2,800066a0 <__memmove+0xfc>
    800065b4:	fff6069b          	addiw	a3,a2,-1
    800065b8:	0006881b          	sext.w	a6,a3
    800065bc:	0ea5e863          	bltu	a1,a0,800066ac <__memmove+0x108>
    800065c0:	00758713          	addi	a4,a1,7
    800065c4:	00a5e7b3          	or	a5,a1,a0
    800065c8:	40a70733          	sub	a4,a4,a0
    800065cc:	0077f793          	andi	a5,a5,7
    800065d0:	00f73713          	sltiu	a4,a4,15
    800065d4:	00174713          	xori	a4,a4,1
    800065d8:	0017b793          	seqz	a5,a5
    800065dc:	00e7f7b3          	and	a5,a5,a4
    800065e0:	10078863          	beqz	a5,800066f0 <__memmove+0x14c>
    800065e4:	00900793          	li	a5,9
    800065e8:	1107f463          	bgeu	a5,a6,800066f0 <__memmove+0x14c>
    800065ec:	0036581b          	srliw	a6,a2,0x3
    800065f0:	fff8081b          	addiw	a6,a6,-1
    800065f4:	02081813          	slli	a6,a6,0x20
    800065f8:	01d85893          	srli	a7,a6,0x1d
    800065fc:	00858813          	addi	a6,a1,8
    80006600:	00058793          	mv	a5,a1
    80006604:	00050713          	mv	a4,a0
    80006608:	01088833          	add	a6,a7,a6
    8000660c:	0007b883          	ld	a7,0(a5)
    80006610:	00878793          	addi	a5,a5,8
    80006614:	00870713          	addi	a4,a4,8
    80006618:	ff173c23          	sd	a7,-8(a4)
    8000661c:	ff0798e3          	bne	a5,a6,8000660c <__memmove+0x68>
    80006620:	ff867713          	andi	a4,a2,-8
    80006624:	02071793          	slli	a5,a4,0x20
    80006628:	0207d793          	srli	a5,a5,0x20
    8000662c:	00f585b3          	add	a1,a1,a5
    80006630:	40e686bb          	subw	a3,a3,a4
    80006634:	00f507b3          	add	a5,a0,a5
    80006638:	06e60463          	beq	a2,a4,800066a0 <__memmove+0xfc>
    8000663c:	0005c703          	lbu	a4,0(a1)
    80006640:	00e78023          	sb	a4,0(a5)
    80006644:	04068e63          	beqz	a3,800066a0 <__memmove+0xfc>
    80006648:	0015c603          	lbu	a2,1(a1)
    8000664c:	00100713          	li	a4,1
    80006650:	00c780a3          	sb	a2,1(a5)
    80006654:	04e68663          	beq	a3,a4,800066a0 <__memmove+0xfc>
    80006658:	0025c603          	lbu	a2,2(a1)
    8000665c:	00200713          	li	a4,2
    80006660:	00c78123          	sb	a2,2(a5)
    80006664:	02e68e63          	beq	a3,a4,800066a0 <__memmove+0xfc>
    80006668:	0035c603          	lbu	a2,3(a1)
    8000666c:	00300713          	li	a4,3
    80006670:	00c781a3          	sb	a2,3(a5)
    80006674:	02e68663          	beq	a3,a4,800066a0 <__memmove+0xfc>
    80006678:	0045c603          	lbu	a2,4(a1)
    8000667c:	00400713          	li	a4,4
    80006680:	00c78223          	sb	a2,4(a5)
    80006684:	00e68e63          	beq	a3,a4,800066a0 <__memmove+0xfc>
    80006688:	0055c603          	lbu	a2,5(a1)
    8000668c:	00500713          	li	a4,5
    80006690:	00c782a3          	sb	a2,5(a5)
    80006694:	00e68663          	beq	a3,a4,800066a0 <__memmove+0xfc>
    80006698:	0065c703          	lbu	a4,6(a1)
    8000669c:	00e78323          	sb	a4,6(a5)
    800066a0:	00813403          	ld	s0,8(sp)
    800066a4:	01010113          	addi	sp,sp,16
    800066a8:	00008067          	ret
    800066ac:	02061713          	slli	a4,a2,0x20
    800066b0:	02075713          	srli	a4,a4,0x20
    800066b4:	00e587b3          	add	a5,a1,a4
    800066b8:	f0f574e3          	bgeu	a0,a5,800065c0 <__memmove+0x1c>
    800066bc:	02069613          	slli	a2,a3,0x20
    800066c0:	02065613          	srli	a2,a2,0x20
    800066c4:	fff64613          	not	a2,a2
    800066c8:	00e50733          	add	a4,a0,a4
    800066cc:	00c78633          	add	a2,a5,a2
    800066d0:	fff7c683          	lbu	a3,-1(a5)
    800066d4:	fff78793          	addi	a5,a5,-1
    800066d8:	fff70713          	addi	a4,a4,-1
    800066dc:	00d70023          	sb	a3,0(a4)
    800066e0:	fec798e3          	bne	a5,a2,800066d0 <__memmove+0x12c>
    800066e4:	00813403          	ld	s0,8(sp)
    800066e8:	01010113          	addi	sp,sp,16
    800066ec:	00008067          	ret
    800066f0:	02069713          	slli	a4,a3,0x20
    800066f4:	02075713          	srli	a4,a4,0x20
    800066f8:	00170713          	addi	a4,a4,1
    800066fc:	00e50733          	add	a4,a0,a4
    80006700:	00050793          	mv	a5,a0
    80006704:	0005c683          	lbu	a3,0(a1)
    80006708:	00178793          	addi	a5,a5,1
    8000670c:	00158593          	addi	a1,a1,1
    80006710:	fed78fa3          	sb	a3,-1(a5)
    80006714:	fee798e3          	bne	a5,a4,80006704 <__memmove+0x160>
    80006718:	f89ff06f          	j	800066a0 <__memmove+0xfc>

000000008000671c <__mem_free>:
    8000671c:	ff010113          	addi	sp,sp,-16
    80006720:	00813423          	sd	s0,8(sp)
    80006724:	01010413          	addi	s0,sp,16
    80006728:	00002597          	auipc	a1,0x2
    8000672c:	63058593          	addi	a1,a1,1584 # 80008d58 <freep>
    80006730:	0005b783          	ld	a5,0(a1)
    80006734:	ff050693          	addi	a3,a0,-16
    80006738:	0007b703          	ld	a4,0(a5)
    8000673c:	00d7fc63          	bgeu	a5,a3,80006754 <__mem_free+0x38>
    80006740:	00e6ee63          	bltu	a3,a4,8000675c <__mem_free+0x40>
    80006744:	00e7fc63          	bgeu	a5,a4,8000675c <__mem_free+0x40>
    80006748:	00070793          	mv	a5,a4
    8000674c:	0007b703          	ld	a4,0(a5)
    80006750:	fed7e8e3          	bltu	a5,a3,80006740 <__mem_free+0x24>
    80006754:	fee7eae3          	bltu	a5,a4,80006748 <__mem_free+0x2c>
    80006758:	fee6f8e3          	bgeu	a3,a4,80006748 <__mem_free+0x2c>
    8000675c:	ff852803          	lw	a6,-8(a0)
    80006760:	02081613          	slli	a2,a6,0x20
    80006764:	01c65613          	srli	a2,a2,0x1c
    80006768:	00c68633          	add	a2,a3,a2
    8000676c:	02c70a63          	beq	a4,a2,800067a0 <__mem_free+0x84>
    80006770:	fee53823          	sd	a4,-16(a0)
    80006774:	0087a503          	lw	a0,8(a5)
    80006778:	02051613          	slli	a2,a0,0x20
    8000677c:	01c65613          	srli	a2,a2,0x1c
    80006780:	00c78633          	add	a2,a5,a2
    80006784:	04c68263          	beq	a3,a2,800067c8 <__mem_free+0xac>
    80006788:	00813403          	ld	s0,8(sp)
    8000678c:	00d7b023          	sd	a3,0(a5)
    80006790:	00f5b023          	sd	a5,0(a1)
    80006794:	00000513          	li	a0,0
    80006798:	01010113          	addi	sp,sp,16
    8000679c:	00008067          	ret
    800067a0:	00872603          	lw	a2,8(a4)
    800067a4:	00073703          	ld	a4,0(a4)
    800067a8:	0106083b          	addw	a6,a2,a6
    800067ac:	ff052c23          	sw	a6,-8(a0)
    800067b0:	fee53823          	sd	a4,-16(a0)
    800067b4:	0087a503          	lw	a0,8(a5)
    800067b8:	02051613          	slli	a2,a0,0x20
    800067bc:	01c65613          	srli	a2,a2,0x1c
    800067c0:	00c78633          	add	a2,a5,a2
    800067c4:	fcc692e3          	bne	a3,a2,80006788 <__mem_free+0x6c>
    800067c8:	00813403          	ld	s0,8(sp)
    800067cc:	0105053b          	addw	a0,a0,a6
    800067d0:	00a7a423          	sw	a0,8(a5)
    800067d4:	00e7b023          	sd	a4,0(a5)
    800067d8:	00f5b023          	sd	a5,0(a1)
    800067dc:	00000513          	li	a0,0
    800067e0:	01010113          	addi	sp,sp,16
    800067e4:	00008067          	ret

00000000800067e8 <__mem_alloc>:
    800067e8:	fc010113          	addi	sp,sp,-64
    800067ec:	02813823          	sd	s0,48(sp)
    800067f0:	02913423          	sd	s1,40(sp)
    800067f4:	03213023          	sd	s2,32(sp)
    800067f8:	01513423          	sd	s5,8(sp)
    800067fc:	02113c23          	sd	ra,56(sp)
    80006800:	01313c23          	sd	s3,24(sp)
    80006804:	01413823          	sd	s4,16(sp)
    80006808:	01613023          	sd	s6,0(sp)
    8000680c:	04010413          	addi	s0,sp,64
    80006810:	00002a97          	auipc	s5,0x2
    80006814:	548a8a93          	addi	s5,s5,1352 # 80008d58 <freep>
    80006818:	00f50913          	addi	s2,a0,15
    8000681c:	000ab683          	ld	a3,0(s5)
    80006820:	00495913          	srli	s2,s2,0x4
    80006824:	0019049b          	addiw	s1,s2,1
    80006828:	00048913          	mv	s2,s1
    8000682c:	0c068c63          	beqz	a3,80006904 <__mem_alloc+0x11c>
    80006830:	0006b503          	ld	a0,0(a3)
    80006834:	00852703          	lw	a4,8(a0)
    80006838:	10977063          	bgeu	a4,s1,80006938 <__mem_alloc+0x150>
    8000683c:	000017b7          	lui	a5,0x1
    80006840:	0009099b          	sext.w	s3,s2
    80006844:	0af4e863          	bltu	s1,a5,800068f4 <__mem_alloc+0x10c>
    80006848:	02099a13          	slli	s4,s3,0x20
    8000684c:	01ca5a13          	srli	s4,s4,0x1c
    80006850:	fff00b13          	li	s6,-1
    80006854:	0100006f          	j	80006864 <__mem_alloc+0x7c>
    80006858:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    8000685c:	00852703          	lw	a4,8(a0)
    80006860:	04977463          	bgeu	a4,s1,800068a8 <__mem_alloc+0xc0>
    80006864:	00050793          	mv	a5,a0
    80006868:	fea698e3          	bne	a3,a0,80006858 <__mem_alloc+0x70>
    8000686c:	000a0513          	mv	a0,s4
    80006870:	00000097          	auipc	ra,0x0
    80006874:	1f0080e7          	jalr	496(ra) # 80006a60 <kvmincrease>
    80006878:	00050793          	mv	a5,a0
    8000687c:	01050513          	addi	a0,a0,16
    80006880:	07678e63          	beq	a5,s6,800068fc <__mem_alloc+0x114>
    80006884:	0137a423          	sw	s3,8(a5)
    80006888:	00000097          	auipc	ra,0x0
    8000688c:	e94080e7          	jalr	-364(ra) # 8000671c <__mem_free>
    80006890:	000ab783          	ld	a5,0(s5)
    80006894:	06078463          	beqz	a5,800068fc <__mem_alloc+0x114>
    80006898:	0007b503          	ld	a0,0(a5)
    8000689c:	00078693          	mv	a3,a5
    800068a0:	00852703          	lw	a4,8(a0)
    800068a4:	fc9760e3          	bltu	a4,s1,80006864 <__mem_alloc+0x7c>
    800068a8:	08e48263          	beq	s1,a4,8000692c <__mem_alloc+0x144>
    800068ac:	4127073b          	subw	a4,a4,s2
    800068b0:	02071693          	slli	a3,a4,0x20
    800068b4:	01c6d693          	srli	a3,a3,0x1c
    800068b8:	00e52423          	sw	a4,8(a0)
    800068bc:	00d50533          	add	a0,a0,a3
    800068c0:	01252423          	sw	s2,8(a0)
    800068c4:	00fab023          	sd	a5,0(s5)
    800068c8:	01050513          	addi	a0,a0,16
    800068cc:	03813083          	ld	ra,56(sp)
    800068d0:	03013403          	ld	s0,48(sp)
    800068d4:	02813483          	ld	s1,40(sp)
    800068d8:	02013903          	ld	s2,32(sp)
    800068dc:	01813983          	ld	s3,24(sp)
    800068e0:	01013a03          	ld	s4,16(sp)
    800068e4:	00813a83          	ld	s5,8(sp)
    800068e8:	00013b03          	ld	s6,0(sp)
    800068ec:	04010113          	addi	sp,sp,64
    800068f0:	00008067          	ret
    800068f4:	000019b7          	lui	s3,0x1
    800068f8:	f51ff06f          	j	80006848 <__mem_alloc+0x60>
    800068fc:	00000513          	li	a0,0
    80006900:	fcdff06f          	j	800068cc <__mem_alloc+0xe4>
    80006904:	00003797          	auipc	a5,0x3
    80006908:	70c78793          	addi	a5,a5,1804 # 8000a010 <base>
    8000690c:	00078513          	mv	a0,a5
    80006910:	00fab023          	sd	a5,0(s5)
    80006914:	00f7b023          	sd	a5,0(a5)
    80006918:	00000713          	li	a4,0
    8000691c:	00003797          	auipc	a5,0x3
    80006920:	6e07ae23          	sw	zero,1788(a5) # 8000a018 <base+0x8>
    80006924:	00050693          	mv	a3,a0
    80006928:	f11ff06f          	j	80006838 <__mem_alloc+0x50>
    8000692c:	00053703          	ld	a4,0(a0)
    80006930:	00e7b023          	sd	a4,0(a5)
    80006934:	f91ff06f          	j	800068c4 <__mem_alloc+0xdc>
    80006938:	00068793          	mv	a5,a3
    8000693c:	f6dff06f          	j	800068a8 <__mem_alloc+0xc0>

0000000080006940 <__putc>:
    80006940:	fe010113          	addi	sp,sp,-32
    80006944:	00813823          	sd	s0,16(sp)
    80006948:	00113c23          	sd	ra,24(sp)
    8000694c:	02010413          	addi	s0,sp,32
    80006950:	00050793          	mv	a5,a0
    80006954:	fef40593          	addi	a1,s0,-17
    80006958:	00100613          	li	a2,1
    8000695c:	00000513          	li	a0,0
    80006960:	fef407a3          	sb	a5,-17(s0)
    80006964:	fffff097          	auipc	ra,0xfffff
    80006968:	918080e7          	jalr	-1768(ra) # 8000527c <console_write>
    8000696c:	01813083          	ld	ra,24(sp)
    80006970:	01013403          	ld	s0,16(sp)
    80006974:	02010113          	addi	sp,sp,32
    80006978:	00008067          	ret

000000008000697c <__getc>:
    8000697c:	fe010113          	addi	sp,sp,-32
    80006980:	00813823          	sd	s0,16(sp)
    80006984:	00113c23          	sd	ra,24(sp)
    80006988:	02010413          	addi	s0,sp,32
    8000698c:	fe840593          	addi	a1,s0,-24
    80006990:	00100613          	li	a2,1
    80006994:	00000513          	li	a0,0
    80006998:	fffff097          	auipc	ra,0xfffff
    8000699c:	8c4080e7          	jalr	-1852(ra) # 8000525c <console_read>
    800069a0:	fe844503          	lbu	a0,-24(s0)
    800069a4:	01813083          	ld	ra,24(sp)
    800069a8:	01013403          	ld	s0,16(sp)
    800069ac:	02010113          	addi	sp,sp,32
    800069b0:	00008067          	ret

00000000800069b4 <console_handler>:
    800069b4:	fe010113          	addi	sp,sp,-32
    800069b8:	00813823          	sd	s0,16(sp)
    800069bc:	00113c23          	sd	ra,24(sp)
    800069c0:	00913423          	sd	s1,8(sp)
    800069c4:	02010413          	addi	s0,sp,32
    800069c8:	14202773          	csrr	a4,scause
    800069cc:	100027f3          	csrr	a5,sstatus
    800069d0:	0027f793          	andi	a5,a5,2
    800069d4:	06079e63          	bnez	a5,80006a50 <console_handler+0x9c>
    800069d8:	00074c63          	bltz	a4,800069f0 <console_handler+0x3c>
    800069dc:	01813083          	ld	ra,24(sp)
    800069e0:	01013403          	ld	s0,16(sp)
    800069e4:	00813483          	ld	s1,8(sp)
    800069e8:	02010113          	addi	sp,sp,32
    800069ec:	00008067          	ret
    800069f0:	0ff77713          	andi	a4,a4,255
    800069f4:	00900793          	li	a5,9
    800069f8:	fef712e3          	bne	a4,a5,800069dc <console_handler+0x28>
    800069fc:	ffffe097          	auipc	ra,0xffffe
    80006a00:	4b8080e7          	jalr	1208(ra) # 80004eb4 <plic_claim>
    80006a04:	00a00793          	li	a5,10
    80006a08:	00050493          	mv	s1,a0
    80006a0c:	02f50c63          	beq	a0,a5,80006a44 <console_handler+0x90>
    80006a10:	fc0506e3          	beqz	a0,800069dc <console_handler+0x28>
    80006a14:	00050593          	mv	a1,a0
    80006a18:	00001517          	auipc	a0,0x1
    80006a1c:	b5850513          	addi	a0,a0,-1192 # 80007570 <kvmincrease+0xb10>
    80006a20:	fffff097          	auipc	ra,0xfffff
    80006a24:	8d8080e7          	jalr	-1832(ra) # 800052f8 <__printf>
    80006a28:	01013403          	ld	s0,16(sp)
    80006a2c:	01813083          	ld	ra,24(sp)
    80006a30:	00048513          	mv	a0,s1
    80006a34:	00813483          	ld	s1,8(sp)
    80006a38:	02010113          	addi	sp,sp,32
    80006a3c:	ffffe317          	auipc	t1,0xffffe
    80006a40:	4b030067          	jr	1200(t1) # 80004eec <plic_complete>
    80006a44:	fffff097          	auipc	ra,0xfffff
    80006a48:	1bc080e7          	jalr	444(ra) # 80005c00 <uartintr>
    80006a4c:	fddff06f          	j	80006a28 <console_handler+0x74>
    80006a50:	00001517          	auipc	a0,0x1
    80006a54:	c2050513          	addi	a0,a0,-992 # 80007670 <digits+0x78>
    80006a58:	fffff097          	auipc	ra,0xfffff
    80006a5c:	844080e7          	jalr	-1980(ra) # 8000529c <panic>

0000000080006a60 <kvmincrease>:
    80006a60:	fe010113          	addi	sp,sp,-32
    80006a64:	01213023          	sd	s2,0(sp)
    80006a68:	00001937          	lui	s2,0x1
    80006a6c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80006a70:	00813823          	sd	s0,16(sp)
    80006a74:	00113c23          	sd	ra,24(sp)
    80006a78:	00913423          	sd	s1,8(sp)
    80006a7c:	02010413          	addi	s0,sp,32
    80006a80:	01250933          	add	s2,a0,s2
    80006a84:	00c95913          	srli	s2,s2,0xc
    80006a88:	02090863          	beqz	s2,80006ab8 <kvmincrease+0x58>
    80006a8c:	00000493          	li	s1,0
    80006a90:	00148493          	addi	s1,s1,1
    80006a94:	fffff097          	auipc	ra,0xfffff
    80006a98:	4bc080e7          	jalr	1212(ra) # 80005f50 <kalloc>
    80006a9c:	fe991ae3          	bne	s2,s1,80006a90 <kvmincrease+0x30>
    80006aa0:	01813083          	ld	ra,24(sp)
    80006aa4:	01013403          	ld	s0,16(sp)
    80006aa8:	00813483          	ld	s1,8(sp)
    80006aac:	00013903          	ld	s2,0(sp)
    80006ab0:	02010113          	addi	sp,sp,32
    80006ab4:	00008067          	ret
    80006ab8:	01813083          	ld	ra,24(sp)
    80006abc:	01013403          	ld	s0,16(sp)
    80006ac0:	00813483          	ld	s1,8(sp)
    80006ac4:	00013903          	ld	s2,0(sp)
    80006ac8:	00000513          	li	a0,0
    80006acc:	02010113          	addi	sp,sp,32
    80006ad0:	00008067          	ret
	...
