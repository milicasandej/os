
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	53013103          	ld	sp,1328(sp) # 8000a530 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	021050ef          	jal	ra,8000583c <start>

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
    800010a4:	4ed000ef          	jal	ra,80001d90 <_ZN5Riscv20handleSupervisorTrapEv>


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

0000000080001144 <_Z9mem_allocm>:
//

#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"

void* mem_alloc(size_t size){
    80001144:	ff010113          	addi	sp,sp,-16
    80001148:	00813423          	sd	s0,8(sp)
    8000114c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_ALLOC);
    80001150:	00100793          	li	a5,1
    80001154:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001158:	00000073          	ecall

    void* ret;
    READ_REG(ret, "a0");
    8000115c:	00050513          	mv	a0,a0
    return ret;
}
    80001160:	00813403          	ld	s0,8(sp)
    80001164:	01010113          	addi	sp,sp,16
    80001168:	00008067          	ret

000000008000116c <_Z8mem_freePv>:

int mem_free(void* ptr){
    8000116c:	ff010113          	addi	sp,sp,-16
    80001170:	00813423          	sd	s0,8(sp)
    80001174:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_FREE);
    80001178:	00200793          	li	a5,2
    8000117c:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001180:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001184:	00050513          	mv	a0,a0
    return ret;
}
    80001188:	0005051b          	sext.w	a0,a0
    8000118c:	00813403          	ld	s0,8(sp)
    80001190:	01010113          	addi	sp,sp,16
    80001194:	00008067          	ret

0000000080001198 <_Z18mem_get_free_spacev>:

size_t mem_get_free_space(){
    80001198:	ff010113          	addi	sp,sp,-16
    8000119c:	00813423          	sd	s0,8(sp)
    800011a0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_GET_FREE_SPACE);
    800011a4:	00300793          	li	a5,3
    800011a8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011ac:	00000073          	ecall

    size_t ret;
    READ_REG(ret, "a0");
    800011b0:	00050513          	mv	a0,a0
    return ret;
}
    800011b4:	00813403          	ld	s0,8(sp)
    800011b8:	01010113          	addi	sp,sp,16
    800011bc:	00008067          	ret

00000000800011c0 <_Z26mem_get_largest_free_blockv>:

size_t mem_get_largest_free_block(){
    800011c0:	ff010113          	addi	sp,sp,-16
    800011c4:	00813423          	sd	s0,8(sp)
    800011c8:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_MEM_GET_LARGEST_FREE_BLOCK);
    800011cc:	00400793          	li	a5,4
    800011d0:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011d4:	00000073          	ecall

    size_t ret;
    READ_REG(ret, "a0");
    800011d8:	00050513          	mv	a0,a0
    return ret;
}
    800011dc:	00813403          	ld	s0,8(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret

00000000800011e8 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    800011e8:	ff010113          	addi	sp,sp,-16
    800011ec:	00813423          	sd	s0,8(sp)
    800011f0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);
    800011f4:	01100793          	li	a5,17
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

0000000080001214 <_Z11thread_exitv>:

int thread_exit(){
    80001214:	ff010113          	addi	sp,sp,-16
    80001218:	00813423          	sd	s0,8(sp)
    8000121c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);
    80001220:	01200793          	li	a5,18
    80001224:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001228:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    8000122c:	00050513          	mv	a0,a0
    return ret;
}
    80001230:	0005051b          	sext.w	a0,a0
    80001234:	00813403          	ld	s0,8(sp)
    80001238:	01010113          	addi	sp,sp,16
    8000123c:	00008067          	ret

0000000080001240 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00813423          	sd	s0,8(sp)
    80001248:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);
    8000124c:	01300793          	li	a5,19
    80001250:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001254:	00000073          	ecall
}
    80001258:	00813403          	ld	s0,8(sp)
    8000125c:	01010113          	addi	sp,sp,16
    80001260:	00008067          	ret

0000000080001264 <_Z8sem_openPP4_semj>:


int sem_open(sem_t* handle, unsigned init){
    80001264:	ff010113          	addi	sp,sp,-16
    80001268:	00813423          	sd	s0,8(sp)
    8000126c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);
    80001270:	02100793          	li	a5,33
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

0000000080001290 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle) {
    80001290:	ff010113          	addi	sp,sp,-16
    80001294:	00813423          	sd	s0,8(sp)
    80001298:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);
    8000129c:	02200793          	li	a5,34
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

00000000800012bc <_Z8sem_waitP4_sem>:

int sem_wait(sem_t id){
    800012bc:	ff010113          	addi	sp,sp,-16
    800012c0:	00813423          	sd	s0,8(sp)
    800012c4:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);
    800012c8:	02300793          	li	a5,35
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

00000000800012e8 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t id){
    800012e8:	ff010113          	addi	sp,sp,-16
    800012ec:	00813423          	sd	s0,8(sp)
    800012f0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);
    800012f4:	02400793          	li	a5,36
    800012f8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012fc:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001300:	00050513          	mv	a0,a0
    return ret;
}
    80001304:	0005051b          	sext.w	a0,a0
    80001308:	00813403          	ld	s0,8(sp)
    8000130c:	01010113          	addi	sp,sp,16
    80001310:	00008067          	ret

0000000080001314 <_Z4getcv>:

char getc(){
    80001314:	ff010113          	addi	sp,sp,-16
    80001318:	00813423          	sd	s0,8(sp)
    8000131c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_GETC);
    80001320:	04100793          	li	a5,65
    80001324:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001328:	00000073          	ecall

    char ret;
    READ_REG(ret, "a0");
    8000132c:	00050513          	mv	a0,a0
    return ret;
}
    80001330:	0ff57513          	andi	a0,a0,255
    80001334:	00813403          	ld	s0,8(sp)
    80001338:	01010113          	addi	sp,sp,16
    8000133c:	00008067          	ret

0000000080001340 <_Z4putcc>:

void putc(char c){
    80001340:	ff010113          	addi	sp,sp,-16
    80001344:	00813423          	sd	s0,8(sp)
    80001348:	01010413          	addi	s0,sp,16

    WRITE_REG("a7", Num::SCALL_PUTC);
    8000134c:	04200793          	li	a5,66
    80001350:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001354:	00000073          	ecall


}
    80001358:	00813403          	ld	s0,8(sp)
    8000135c:	01010113          	addi	sp,sp,16
    80001360:	00008067          	ret

0000000080001364 <_Z11thread_joinPP7_thread>:

void thread_join(thread_t* handle) {
    80001364:	ff010113          	addi	sp,sp,-16
    80001368:	00813423          	sd	s0,8(sp)
    8000136c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_JOIN);
    80001370:	01400793          	li	a5,20
    80001374:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001378:	00000073          	ecall
}
    8000137c:	00813403          	ld	s0,8(sp)
    80001380:	01010113          	addi	sp,sp,16
    80001384:	00008067          	ret

0000000080001388 <_Z11getThreadIdv>:

int getThreadId() {
    80001388:	ff010113          	addi	sp,sp,-16
    8000138c:	00813423          	sd	s0,8(sp)
    80001390:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_GET_ID);
    80001394:	01500793          	li	a5,21
    80001398:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    8000139c:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800013a0:	00050513          	mv	a0,a0
    return ret;
}
    800013a4:	0005051b          	sext.w	a0,a0
    800013a8:	00813403          	ld	s0,8(sp)
    800013ac:	01010113          	addi	sp,sp,16
    800013b0:	00008067          	ret

00000000800013b4 <_Z14thread_joinAllv>:
void thread_joinAll(){
    800013b4:	ff010113          	addi	sp,sp,-16
    800013b8:	00813423          	sd	s0,8(sp)
    800013bc:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_JOIN_ALL);
    800013c0:	01600793          	li	a5,22
    800013c4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800013c8:	00000073          	ecall

    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	01010113          	addi	sp,sp,16
    800013d4:	00008067          	ret

00000000800013d8 <_ZN7_thread13threadWrapperEv>:
    }

}

void _thread::threadWrapper()
{
    800013d8:	ff010113          	addi	sp,sp,-16
    800013dc:	00113423          	sd	ra,8(sp)
    800013e0:	00813023          	sd	s0,0(sp)
    800013e4:	01010413          	addi	s0,sp,16

    Riscv::popSppSpie();
    800013e8:	00001097          	auipc	ra,0x1
    800013ec:	968080e7          	jalr	-1688(ra) # 80001d50 <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) thread_dispatch();
    800013f0:	00009797          	auipc	a5,0x9
    800013f4:	1a07b783          	ld	a5,416(a5) # 8000a590 <_ZN7_thread7runningE>
    static int exitThread();

    bool isFinished() const { return finished; }
    void setFinished(bool value) { finished = value; }
    void setStart(bool b);
    bool isStarted() const { return started; }
    800013f8:	0297c703          	lbu	a4,41(a5)
    800013fc:	00071863          	bnez	a4,8000140c <_ZN7_thread13threadWrapperEv+0x34>
    80001400:	00000097          	auipc	ra,0x0
    80001404:	e40080e7          	jalr	-448(ra) # 80001240 <_Z15thread_dispatchv>
    80001408:	fe9ff06f          	j	800013f0 <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    8000140c:	0007b703          	ld	a4,0(a5)
    80001410:	0087b503          	ld	a0,8(a5)
    80001414:	000700e7          	jalr	a4
//    if(_thread::semMaxThreads) sem_signal(_thread::semMaxThreads);
    thread_exit();
    80001418:	00000097          	auipc	ra,0x0
    8000141c:	dfc080e7          	jalr	-516(ra) # 80001214 <_Z11thread_exitv>
}
    80001420:	00813083          	ld	ra,8(sp)
    80001424:	00013403          	ld	s0,0(sp)
    80001428:	01010113          	addi	sp,sp,16
    8000142c:	00008067          	ret

0000000080001430 <_ZN7_thread12createThreadEPFvPvES0_>:
{
    80001430:	fd010113          	addi	sp,sp,-48
    80001434:	02113423          	sd	ra,40(sp)
    80001438:	02813023          	sd	s0,32(sp)
    8000143c:	00913c23          	sd	s1,24(sp)
    80001440:	01213823          	sd	s2,16(sp)
    80001444:	01313423          	sd	s3,8(sp)
    80001448:	03010413          	addi	s0,sp,48
    8000144c:	00050913          	mv	s2,a0
    80001450:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    80001454:	04800513          	li	a0,72
    80001458:	00000097          	auipc	ra,0x0
    8000145c:	540080e7          	jalr	1344(ra) # 80001998 <_Znwm>
    80001460:	00050493          	mv	s1,a0
            finished(false),
            started(true),
            blocked(false),
            semStatus(0),
            myID(ID++),
            children()
    80001464:	01253023          	sd	s2,0(a0)
    80001468:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    8000146c:	00090a63          	beqz	s2,80001480 <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    80001470:	00008537          	lui	a0,0x8
    80001474:	00000097          	auipc	ra,0x0
    80001478:	54c080e7          	jalr	1356(ra) # 800019c0 <_Znam>
    8000147c:	0080006f          	j	80001484 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    80001480:	00000513          	li	a0,0
            children()
    80001484:	00a4b823          	sd	a0,16(s1)
    80001488:	00000797          	auipc	a5,0x0
    8000148c:	f5078793          	addi	a5,a5,-176 # 800013d8 <_ZN7_thread13threadWrapperEv>
    80001490:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001494:	04050c63          	beqz	a0,800014ec <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
    80001498:	000087b7          	lui	a5,0x8
    8000149c:	00f507b3          	add	a5,a0,a5
            children()
    800014a0:	02f4b023          	sd	a5,32(s1)
    800014a4:	02048423          	sb	zero,40(s1)
    800014a8:	00100793          	li	a5,1
    800014ac:	02f484a3          	sb	a5,41(s1)
    800014b0:	02048523          	sb	zero,42(s1)
    800014b4:	0204a623          	sw	zero,44(s1)
            myID(ID++),
    800014b8:	00009717          	auipc	a4,0x9
    800014bc:	0d870713          	addi	a4,a4,216 # 8000a590 <_ZN7_thread7runningE>
    800014c0:	00872783          	lw	a5,8(a4)
    800014c4:	0017869b          	addiw	a3,a5,1
    800014c8:	00d72423          	sw	a3,8(a4)
            children()
    800014cc:	02f4a823          	sw	a5,48(s1)
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    800014d0:	0204bc23          	sd	zero,56(s1)
    800014d4:	0404b023          	sd	zero,64(s1)

    {
            if (body != nullptr) { Scheduler::put(this);}
    800014d8:	00090e63          	beqz	s2,800014f4 <_ZN7_thread12createThreadEPFvPvES0_+0xc4>
    800014dc:	00048513          	mv	a0,s1
    800014e0:	00001097          	auipc	ra,0x1
    800014e4:	e70080e7          	jalr	-400(ra) # 80002350 <_ZN9Scheduler3putEP7_thread>
    800014e8:	00c0006f          	j	800014f4 <_ZN7_thread12createThreadEPFvPvES0_+0xc4>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    800014ec:	00000793          	li	a5,0
    800014f0:	fb1ff06f          	j	800014a0 <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    if(_thread::running){
    800014f4:	00009917          	auipc	s2,0x9
    800014f8:	09c93903          	ld	s2,156(s2) # 8000a590 <_ZN7_thread7runningE>
    800014fc:	02090463          	beqz	s2,80001524 <_ZN7_thread12createThreadEPFvPvES0_+0xf4>
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001500:	01000513          	li	a0,16
    80001504:	00000097          	auipc	ra,0x0
    80001508:	494080e7          	jalr	1172(ra) # 80001998 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    8000150c:	00953023          	sd	s1,0(a0) # 8000 <_entry-0x7fff8000>
    80001510:	00053423          	sd	zero,8(a0)
        if (tail)
    80001514:	04093783          	ld	a5,64(s2)
    80001518:	02078663          	beqz	a5,80001544 <_ZN7_thread12createThreadEPFvPvES0_+0x114>
        {
            tail->next = elem;
    8000151c:	00a7b423          	sd	a0,8(a5) # 8008 <_entry-0x7fff7ff8>
            tail = elem;
    80001520:	04a93023          	sd	a0,64(s2)
}
    80001524:	00048513          	mv	a0,s1
    80001528:	02813083          	ld	ra,40(sp)
    8000152c:	02013403          	ld	s0,32(sp)
    80001530:	01813483          	ld	s1,24(sp)
    80001534:	01013903          	ld	s2,16(sp)
    80001538:	00813983          	ld	s3,8(sp)
    8000153c:	03010113          	addi	sp,sp,48
    80001540:	00008067          	ret
        } else
        {
            head = tail = elem;
    80001544:	04a93023          	sd	a0,64(s2)
    80001548:	02a93c23          	sd	a0,56(s2)
    return newThread;
    8000154c:	fd9ff06f          	j	80001524 <_ZN7_thread12createThreadEPFvPvES0_+0xf4>
    80001550:	00050913          	mv	s2,a0
    _thread* newThread = new _thread(body, args);
    80001554:	00048513          	mv	a0,s1
    80001558:	00000097          	auipc	ra,0x0
    8000155c:	490080e7          	jalr	1168(ra) # 800019e8 <_ZdlPv>
    80001560:	00090513          	mv	a0,s2
    80001564:	0000a097          	auipc	ra,0xa
    80001568:	164080e7          	jalr	356(ra) # 8000b6c8 <_Unwind_Resume>

000000008000156c <_ZN7_thread8dispatchEv>:
{
    8000156c:	fe010113          	addi	sp,sp,-32
    80001570:	00113c23          	sd	ra,24(sp)
    80001574:	00813823          	sd	s0,16(sp)
    80001578:	00913423          	sd	s1,8(sp)
    8000157c:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001580:	00009497          	auipc	s1,0x9
    80001584:	0104b483          	ld	s1,16(s1) # 8000a590 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001588:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    8000158c:	00079663          	bnez	a5,80001598 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    80001590:	02a4c783          	lbu	a5,42(s1)
    80001594:	04078263          	beqz	a5,800015d8 <_ZN7_thread8dispatchEv+0x6c>
    running = Scheduler::get();
    80001598:	00001097          	auipc	ra,0x1
    8000159c:	d50080e7          	jalr	-688(ra) # 800022e8 <_ZN9Scheduler3getEv>
    800015a0:	00009797          	auipc	a5,0x9
    800015a4:	fea7b823          	sd	a0,-16(a5) # 8000a590 <_ZN7_thread7runningE>
    if (running == nullptr) {
    800015a8:	04050063          	beqz	a0,800015e8 <_ZN7_thread8dispatchEv+0x7c>
    _thread::contextSwitch(&old->context, &running->context);
    800015ac:	00009597          	auipc	a1,0x9
    800015b0:	fe45b583          	ld	a1,-28(a1) # 8000a590 <_ZN7_thread7runningE>
    800015b4:	01858593          	addi	a1,a1,24
    800015b8:	01848513          	addi	a0,s1,24
    800015bc:	00000097          	auipc	ra,0x0
    800015c0:	b74080e7          	jalr	-1164(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800015c4:	01813083          	ld	ra,24(sp)
    800015c8:	01013403          	ld	s0,16(sp)
    800015cc:	00813483          	ld	s1,8(sp)
    800015d0:	02010113          	addi	sp,sp,32
    800015d4:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    800015d8:	00048513          	mv	a0,s1
    800015dc:	00001097          	auipc	ra,0x1
    800015e0:	d74080e7          	jalr	-652(ra) # 80002350 <_ZN9Scheduler3putEP7_thread>
    800015e4:	fb5ff06f          	j	80001598 <_ZN7_thread8dispatchEv+0x2c>
        printString("vratili smo null\n");
    800015e8:	00007517          	auipc	a0,0x7
    800015ec:	a3850513          	addi	a0,a0,-1480 # 80008020 <CONSOLE_STATUS+0x10>
    800015f0:	00003097          	auipc	ra,0x3
    800015f4:	050080e7          	jalr	80(ra) # 80004640 <_Z11printStringPKc>
    800015f8:	fb5ff06f          	j	800015ac <_ZN7_thread8dispatchEv+0x40>

00000000800015fc <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800015fc:	ff010113          	addi	sp,sp,-16
    80001600:	00113423          	sd	ra,8(sp)
    80001604:	00813023          	sd	s0,0(sp)
    80001608:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    8000160c:	00009797          	auipc	a5,0x9
    80001610:	f847b783          	ld	a5,-124(a5) # 8000a590 <_ZN7_thread7runningE>
    80001614:	00100713          	li	a4,1
    80001618:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    8000161c:	00000097          	auipc	ra,0x0
    80001620:	c24080e7          	jalr	-988(ra) # 80001240 <_Z15thread_dispatchv>
    return 0;
}
    80001624:	00000513          	li	a0,0
    80001628:	00813083          	ld	ra,8(sp)
    8000162c:	00013403          	ld	s0,0(sp)
    80001630:	01010113          	addi	sp,sp,16
    80001634:	00008067          	ret

0000000080001638 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001638:	ff010113          	addi	sp,sp,-16
    8000163c:	00813423          	sd	s0,8(sp)
    80001640:	01010413          	addi	s0,sp,16
    this->started = b;
    80001644:	02b504a3          	sb	a1,41(a0)
}
    80001648:	00813403          	ld	s0,8(sp)
    8000164c:	01010113          	addi	sp,sp,16
    80001650:	00008067          	ret

0000000080001654 <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    80001654:	ff010113          	addi	sp,sp,-16
    80001658:	00813423          	sd	s0,8(sp)
    8000165c:	01010413          	addi	s0,sp,16
    this->blocked = b;
    80001660:	02b50523          	sb	a1,42(a0)
}
    80001664:	00813403          	ld	s0,8(sp)
    80001668:	01010113          	addi	sp,sp,16
    8000166c:	00008067          	ret

0000000080001670 <_ZN7_thread4joinEPPS_>:

void _thread::join(thread_t *handle) {
    80001670:	fe010113          	addi	sp,sp,-32
    80001674:	00113c23          	sd	ra,24(sp)
    80001678:	00813823          	sd	s0,16(sp)
    8000167c:	00913423          	sd	s1,8(sp)
    80001680:	02010413          	addi	s0,sp,32
    80001684:	00050493          	mv	s1,a0
    while(!(*handle)->isFinished()) thread_dispatch();
    80001688:	0004b783          	ld	a5,0(s1)
    bool isFinished() const { return finished; }
    8000168c:	0287c783          	lbu	a5,40(a5)
    80001690:	00079863          	bnez	a5,800016a0 <_ZN7_thread4joinEPPS_+0x30>
    80001694:	00000097          	auipc	ra,0x0
    80001698:	bac080e7          	jalr	-1108(ra) # 80001240 <_Z15thread_dispatchv>
    8000169c:	fedff06f          	j	80001688 <_ZN7_thread4joinEPPS_+0x18>
}
    800016a0:	01813083          	ld	ra,24(sp)
    800016a4:	01013403          	ld	s0,16(sp)
    800016a8:	00813483          	ld	s1,8(sp)
    800016ac:	02010113          	addi	sp,sp,32
    800016b0:	00008067          	ret

00000000800016b4 <_ZN7_thread7joinAllEv>:
void _thread::joinAll(){
    800016b4:	fd010113          	addi	sp,sp,-48
    800016b8:	02113423          	sd	ra,40(sp)
    800016bc:	02813023          	sd	s0,32(sp)
    800016c0:	00913c23          	sd	s1,24(sp)
    800016c4:	01213823          	sd	s2,16(sp)
    800016c8:	03010413          	addi	s0,sp,48
    800016cc:	00050913          	mv	s2,a0
    800016d0:	0280006f          	j	800016f8 <_ZN7_thread7joinAllEv+0x44>
    {
        if (!head) { return 0; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }
    800016d4:	04093023          	sd	zero,64(s2)

        T *ret = elem->data;
    800016d8:	00053483          	ld	s1,0(a0)
        delete elem;
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	30c080e7          	jalr	780(ra) # 800019e8 <_ZdlPv>
    while (_thread* curr = children.removeFirst()){
    800016e4:	fc943c23          	sd	s1,-40(s0)
    800016e8:	02048863          	beqz	s1,80001718 <_ZN7_thread7joinAllEv+0x64>
        join(&curr);
    800016ec:	fd840513          	addi	a0,s0,-40
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	f80080e7          	jalr	-128(ra) # 80001670 <_ZN7_thread4joinEPPS_>
        if (!head) { return 0; }
    800016f8:	03893503          	ld	a0,56(s2)
    800016fc:	00050a63          	beqz	a0,80001710 <_ZN7_thread7joinAllEv+0x5c>
        head = head->next;
    80001700:	00853783          	ld	a5,8(a0)
    80001704:	02f93c23          	sd	a5,56(s2)
        if (!head) { tail = 0; }
    80001708:	fc0798e3          	bnez	a5,800016d8 <_ZN7_thread7joinAllEv+0x24>
    8000170c:	fc9ff06f          	j	800016d4 <_ZN7_thread7joinAllEv+0x20>
        if (!head) { return 0; }
    80001710:	00050493          	mv	s1,a0
    80001714:	fd1ff06f          	j	800016e4 <_ZN7_thread7joinAllEv+0x30>
}
    80001718:	02813083          	ld	ra,40(sp)
    8000171c:	02013403          	ld	s0,32(sp)
    80001720:	01813483          	ld	s1,24(sp)
    80001724:	01013903          	ld	s2,16(sp)
    80001728:	03010113          	addi	sp,sp,48
    8000172c:	00008067          	ret

0000000080001730 <_ZN7_thread11getThreadIDEv>:

int _thread::getThreadID() {
    80001730:	fe010113          	addi	sp,sp,-32
    80001734:	00113c23          	sd	ra,24(sp)
    80001738:	00813823          	sd	s0,16(sp)
    8000173c:	00913423          	sd	s1,8(sp)
    80001740:	02010413          	addi	s0,sp,32
    80001744:	00050493          	mv	s1,a0
    thread_dispatch();
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	af8080e7          	jalr	-1288(ra) # 80001240 <_Z15thread_dispatchv>
    return myID;
}
    80001750:	0304a503          	lw	a0,48(s1)
    80001754:	01813083          	ld	ra,24(sp)
    80001758:	01013403          	ld	s0,16(sp)
    8000175c:	00813483          	ld	s1,8(sp)
    80001760:	02010113          	addi	sp,sp,32
    80001764:	00008067          	ret

0000000080001768 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    80001768:	fe010113          	addi	sp,sp,-32
    8000176c:	00113c23          	sd	ra,24(sp)
    80001770:	00813823          	sd	s0,16(sp)
    80001774:	00913423          	sd	s1,8(sp)
    80001778:	01213023          	sd	s2,0(sp)
    8000177c:	02010413          	addi	s0,sp,32


    printString("Unesite broj testa? [1-7]\n");
    80001780:	00007517          	auipc	a0,0x7
    80001784:	8b850513          	addi	a0,a0,-1864 # 80008038 <CONSOLE_STATUS+0x28>
    80001788:	00003097          	auipc	ra,0x3
    8000178c:	eb8080e7          	jalr	-328(ra) # 80004640 <_Z11printStringPKc>
    int test = getc() - '0';
    80001790:	00000097          	auipc	ra,0x0
    80001794:	b84080e7          	jalr	-1148(ra) # 80001314 <_Z4getcv>
    80001798:	00050913          	mv	s2,a0
    8000179c:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800017a0:	00000097          	auipc	ra,0x0
    800017a4:	b74080e7          	jalr	-1164(ra) # 80001314 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800017a8:	fcb9091b          	addiw	s2,s2,-53
    800017ac:	00100793          	li	a5,1
    800017b0:	0327f463          	bgeu	a5,s2,800017d8 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800017b4:	00700793          	li	a5,7
    800017b8:	0e97e263          	bltu	a5,s1,8000189c <_Z8userMainv+0x134>
    800017bc:	00249493          	slli	s1,s1,0x2
    800017c0:	00007717          	auipc	a4,0x7
    800017c4:	a9070713          	addi	a4,a4,-1392 # 80008250 <CONSOLE_STATUS+0x240>
    800017c8:	00e484b3          	add	s1,s1,a4
    800017cc:	0004a783          	lw	a5,0(s1)
    800017d0:	00e787b3          	add	a5,a5,a4
    800017d4:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800017d8:	00007517          	auipc	a0,0x7
    800017dc:	88050513          	addi	a0,a0,-1920 # 80008058 <CONSOLE_STATUS+0x48>
    800017e0:	00003097          	auipc	ra,0x3
    800017e4:	e60080e7          	jalr	-416(ra) # 80004640 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800017e8:	01813083          	ld	ra,24(sp)
    800017ec:	01013403          	ld	s0,16(sp)
    800017f0:	00813483          	ld	s1,8(sp)
    800017f4:	00013903          	ld	s2,0(sp)
    800017f8:	02010113          	addi	sp,sp,32
    800017fc:	00008067          	ret
            Threads_C_API_test();
    80001800:	00002097          	auipc	ra,0x2
    80001804:	1f4080e7          	jalr	500(ra) # 800039f4 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001808:	00007517          	auipc	a0,0x7
    8000180c:	88050513          	addi	a0,a0,-1920 # 80008088 <CONSOLE_STATUS+0x78>
    80001810:	00003097          	auipc	ra,0x3
    80001814:	e30080e7          	jalr	-464(ra) # 80004640 <_Z11printStringPKc>
            break;
    80001818:	fd1ff06f          	j	800017e8 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    8000181c:	00002097          	auipc	ra,0x2
    80001820:	83c080e7          	jalr	-1988(ra) # 80003058 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001824:	00007517          	auipc	a0,0x7
    80001828:	8a450513          	addi	a0,a0,-1884 # 800080c8 <CONSOLE_STATUS+0xb8>
    8000182c:	00003097          	auipc	ra,0x3
    80001830:	e14080e7          	jalr	-492(ra) # 80004640 <_Z11printStringPKc>
            break;
    80001834:	fb5ff06f          	j	800017e8 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001838:	00001097          	auipc	ra,0x1
    8000183c:	074080e7          	jalr	116(ra) # 800028ac <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001840:	00007517          	auipc	a0,0x7
    80001844:	8c850513          	addi	a0,a0,-1848 # 80008108 <CONSOLE_STATUS+0xf8>
    80001848:	00003097          	auipc	ra,0x3
    8000184c:	df8080e7          	jalr	-520(ra) # 80004640 <_Z11printStringPKc>
            break;
    80001850:	f99ff06f          	j	800017e8 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001854:	00002097          	auipc	ra,0x2
    80001858:	4e4080e7          	jalr	1252(ra) # 80003d38 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    8000185c:	00007517          	auipc	a0,0x7
    80001860:	8fc50513          	addi	a0,a0,-1796 # 80008158 <CONSOLE_STATUS+0x148>
    80001864:	00003097          	auipc	ra,0x3
    80001868:	ddc080e7          	jalr	-548(ra) # 80004640 <_Z11printStringPKc>
            break;
    8000186c:	f7dff06f          	j	800017e8 <_Z8userMainv+0x80>
            System_Mode_test();
    80001870:	00004097          	auipc	ra,0x4
    80001874:	984080e7          	jalr	-1660(ra) # 800051f4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80001878:	00007517          	auipc	a0,0x7
    8000187c:	93850513          	addi	a0,a0,-1736 # 800081b0 <CONSOLE_STATUS+0x1a0>
    80001880:	00003097          	auipc	ra,0x3
    80001884:	dc0080e7          	jalr	-576(ra) # 80004640 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001888:	00007517          	auipc	a0,0x7
    8000188c:	94850513          	addi	a0,a0,-1720 # 800081d0 <CONSOLE_STATUS+0x1c0>
    80001890:	00003097          	auipc	ra,0x3
    80001894:	db0080e7          	jalr	-592(ra) # 80004640 <_Z11printStringPKc>
            break;
    80001898:	f51ff06f          	j	800017e8 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    8000189c:	00007517          	auipc	a0,0x7
    800018a0:	98c50513          	addi	a0,a0,-1652 # 80008228 <CONSOLE_STATUS+0x218>
    800018a4:	00003097          	auipc	ra,0x3
    800018a8:	d9c080e7          	jalr	-612(ra) # 80004640 <_Z11printStringPKc>
    800018ac:	f3dff06f          	j	800017e8 <_Z8userMainv+0x80>

00000000800018b0 <_Z15userMainWrapperPv>:



extern void userMain();

void userMainWrapper(void* arg){
    800018b0:	ff010113          	addi	sp,sp,-16
    800018b4:	00113423          	sd	ra,8(sp)
    800018b8:	00813023          	sd	s0,0(sp)
    800018bc:	01010413          	addi	s0,sp,16
    //userMain();
    //ThreadJoin_test();
    semMaxThreads_test();
    800018c0:	00004097          	auipc	ra,0x4
    800018c4:	e04080e7          	jalr	-508(ra) # 800056c4 <_Z18semMaxThreads_testv>
}
    800018c8:	00813083          	ld	ra,8(sp)
    800018cc:	00013403          	ld	s0,0(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret

00000000800018d8 <main>:

void main()
{
    800018d8:	fe010113          	addi	sp,sp,-32
    800018dc:	00113c23          	sd	ra,24(sp)
    800018e0:	00813823          	sd	s0,16(sp)
    800018e4:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800018e8:	00009797          	auipc	a5,0x9
    800018ec:	c407b783          	ld	a5,-960(a5) # 8000a528 <_GLOBAL_OFFSET_TABLE_+0x18>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800018f0:	10579073          	csrw	stvec,a5
    memory::initialize();
    800018f4:	00001097          	auipc	ra,0x1
    800018f8:	afc080e7          	jalr	-1284(ra) # 800023f0 <_ZN6memory10initializeEv>

    // idle nit
    thread_t idleThread = nullptr;
    800018fc:	fe043423          	sd	zero,-24(s0)
    thread_create(&idleThread, nullptr, nullptr);
    80001900:	00000613          	li	a2,0
    80001904:	00000593          	li	a1,0
    80001908:	fe840513          	addi	a0,s0,-24
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	8dc080e7          	jalr	-1828(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    80001914:	00009797          	auipc	a5,0x9
    80001918:	c0c7b783          	ld	a5,-1012(a5) # 8000a520 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000191c:	fe843703          	ld	a4,-24(s0)
    80001920:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001924:	00200793          	li	a5,2
    80001928:	1007a073          	csrs	sstatus,a5
    static void setUserMode(bool b) {userMode = b;}
    8000192c:	00009797          	auipc	a5,0x9
    80001930:	c147b783          	ld	a5,-1004(a5) # 8000a540 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001934:	00100713          	li	a4,1
    80001938:	00e78023          	sb	a4,0(a5)
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    Riscv::setUserMode(true);

    uint8 userCode = 0x0;
    WRITE_REG("a7", userCode);
    8000193c:	00000793          	li	a5,0
    80001940:	00078893          	mv	a7,a5
    __asm__ volatile("ecall");
    80001944:	00000073          	ecall

    thread_t userThread;
    thread_create(&userThread, &userMainWrapper, nullptr);
    80001948:	00000613          	li	a2,0
    8000194c:	00000597          	auipc	a1,0x0
    80001950:	f6458593          	addi	a1,a1,-156 # 800018b0 <_Z15userMainWrapperPv>
    80001954:	fe040513          	addi	a0,s0,-32
    80001958:	00000097          	auipc	ra,0x0
    8000195c:	890080e7          	jalr	-1904(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    while (!userThread->isFinished()) thread_dispatch();
    80001960:	fe043783          	ld	a5,-32(s0)
    80001964:	0287c783          	lbu	a5,40(a5)
    80001968:	00079863          	bnez	a5,80001978 <main+0xa0>
    8000196c:	00000097          	auipc	ra,0x0
    80001970:	8d4080e7          	jalr	-1836(ra) # 80001240 <_Z15thread_dispatchv>
    80001974:	fedff06f          	j	80001960 <main+0x88>


    printString("FINISHED!\n");
    80001978:	00007517          	auipc	a0,0x7
    8000197c:	8f850513          	addi	a0,a0,-1800 # 80008270 <CONSOLE_STATUS+0x260>
    80001980:	00003097          	auipc	ra,0x3
    80001984:	cc0080e7          	jalr	-832(ra) # 80004640 <_Z11printStringPKc>
}
    80001988:	01813083          	ld	ra,24(sp)
    8000198c:	01013403          	ld	s0,16(sp)
    80001990:	02010113          	addi	sp,sp,32
    80001994:	00008067          	ret

0000000080001998 <_Znwm>:

#include "../h/syscall_cpp.hpp"


void *operator new(size_t n)
{
    80001998:	ff010113          	addi	sp,sp,-16
    8000199c:	00113423          	sd	ra,8(sp)
    800019a0:	00813023          	sd	s0,0(sp)
    800019a4:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800019a8:	fffff097          	auipc	ra,0xfffff
    800019ac:	79c080e7          	jalr	1948(ra) # 80001144 <_Z9mem_allocm>
}
    800019b0:	00813083          	ld	ra,8(sp)
    800019b4:	00013403          	ld	s0,0(sp)
    800019b8:	01010113          	addi	sp,sp,16
    800019bc:	00008067          	ret

00000000800019c0 <_Znam>:

void *operator new[](size_t n)
{
    800019c0:	ff010113          	addi	sp,sp,-16
    800019c4:	00113423          	sd	ra,8(sp)
    800019c8:	00813023          	sd	s0,0(sp)
    800019cc:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800019d0:	fffff097          	auipc	ra,0xfffff
    800019d4:	774080e7          	jalr	1908(ra) # 80001144 <_Z9mem_allocm>
}
    800019d8:	00813083          	ld	ra,8(sp)
    800019dc:	00013403          	ld	s0,0(sp)
    800019e0:	01010113          	addi	sp,sp,16
    800019e4:	00008067          	ret

00000000800019e8 <_ZdlPv>:

void operator delete(void *p)
{
    800019e8:	ff010113          	addi	sp,sp,-16
    800019ec:	00113423          	sd	ra,8(sp)
    800019f0:	00813023          	sd	s0,0(sp)
    800019f4:	01010413          	addi	s0,sp,16
    mem_free(p);
    800019f8:	fffff097          	auipc	ra,0xfffff
    800019fc:	774080e7          	jalr	1908(ra) # 8000116c <_Z8mem_freePv>
}
    80001a00:	00813083          	ld	ra,8(sp)
    80001a04:	00013403          	ld	s0,0(sp)
    80001a08:	01010113          	addi	sp,sp,16
    80001a0c:	00008067          	ret

0000000080001a10 <_ZdaPv>:

void operator delete[](void *p)
{
    80001a10:	ff010113          	addi	sp,sp,-16
    80001a14:	00113423          	sd	ra,8(sp)
    80001a18:	00813023          	sd	s0,0(sp)
    80001a1c:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001a20:	fffff097          	auipc	ra,0xfffff
    80001a24:	74c080e7          	jalr	1868(ra) # 8000116c <_Z8mem_freePv>
}
    80001a28:	00813083          	ld	ra,8(sp)
    80001a2c:	00013403          	ld	s0,0(sp)
    80001a30:	01010113          	addi	sp,sp,16
    80001a34:	00008067          	ret

0000000080001a38 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    80001a38:	ff010113          	addi	sp,sp,-16
    80001a3c:	00813423          	sd	s0,8(sp)
    80001a40:	01010413          	addi	s0,sp,16

}
    80001a44:	00813403          	ld	s0,8(sp)
    80001a48:	01010113          	addi	sp,sp,16
    80001a4c:	00008067          	ret

0000000080001a50 <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    80001a50:	ff010113          	addi	sp,sp,-16
    80001a54:	00113423          	sd	ra,8(sp)
    80001a58:	00813023          	sd	s0,0(sp)
    80001a5c:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    80001a60:	00053783          	ld	a5,0(a0)
    80001a64:	0107b783          	ld	a5,16(a5)
    80001a68:	000780e7          	jalr	a5
}
    80001a6c:	00813083          	ld	ra,8(sp)
    80001a70:	00013403          	ld	s0,0(sp)
    80001a74:	01010113          	addi	sp,sp,16
    80001a78:	00008067          	ret

0000000080001a7c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001a7c:	ff010113          	addi	sp,sp,-16
    80001a80:	00113423          	sd	ra,8(sp)
    80001a84:	00813023          	sd	s0,0(sp)
    80001a88:	01010413          	addi	s0,sp,16
}
    80001a8c:	00000097          	auipc	ra,0x0
    80001a90:	f5c080e7          	jalr	-164(ra) # 800019e8 <_ZdlPv>
    80001a94:	00813083          	ld	ra,8(sp)
    80001a98:	00013403          	ld	s0,0(sp)
    80001a9c:	01010113          	addi	sp,sp,16
    80001aa0:	00008067          	ret

0000000080001aa4 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    80001aa4:	ff010113          	addi	sp,sp,-16
    80001aa8:	00113423          	sd	ra,8(sp)
    80001aac:	00813023          	sd	s0,0(sp)
    80001ab0:	01010413          	addi	s0,sp,16
    80001ab4:	00009797          	auipc	a5,0x9
    80001ab8:	8cc78793          	addi	a5,a5,-1844 # 8000a380 <_ZTV9Semaphore+0x10>
    80001abc:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    80001ac0:	00853503          	ld	a0,8(a0)
    80001ac4:	fffff097          	auipc	ra,0xfffff
    80001ac8:	7cc080e7          	jalr	1996(ra) # 80001290 <_Z9sem_closeP4_sem>

}
    80001acc:	00813083          	ld	ra,8(sp)
    80001ad0:	00013403          	ld	s0,0(sp)
    80001ad4:	01010113          	addi	sp,sp,16
    80001ad8:	00008067          	ret

0000000080001adc <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001adc:	fe010113          	addi	sp,sp,-32
    80001ae0:	00113c23          	sd	ra,24(sp)
    80001ae4:	00813823          	sd	s0,16(sp)
    80001ae8:	00913423          	sd	s1,8(sp)
    80001aec:	02010413          	addi	s0,sp,32
    80001af0:	00050493          	mv	s1,a0
}
    80001af4:	00000097          	auipc	ra,0x0
    80001af8:	fb0080e7          	jalr	-80(ra) # 80001aa4 <_ZN9SemaphoreD1Ev>
    80001afc:	00048513          	mv	a0,s1
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	ee8080e7          	jalr	-280(ra) # 800019e8 <_ZdlPv>
    80001b08:	01813083          	ld	ra,24(sp)
    80001b0c:	01013403          	ld	s0,16(sp)
    80001b10:	00813483          	ld	s1,8(sp)
    80001b14:	02010113          	addi	sp,sp,32
    80001b18:	00008067          	ret

0000000080001b1c <_ZN7Console4getcEv>:
char Console::getc() {
    80001b1c:	ff010113          	addi	sp,sp,-16
    80001b20:	00113423          	sd	ra,8(sp)
    80001b24:	00813023          	sd	s0,0(sp)
    80001b28:	01010413          	addi	s0,sp,16
    return __getc();
    80001b2c:	00006097          	auipc	ra,0x6
    80001b30:	e0c080e7          	jalr	-500(ra) # 80007938 <__getc>
}
    80001b34:	00813083          	ld	ra,8(sp)
    80001b38:	00013403          	ld	s0,0(sp)
    80001b3c:	01010113          	addi	sp,sp,16
    80001b40:	00008067          	ret

0000000080001b44 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80001b44:	ff010113          	addi	sp,sp,-16
    80001b48:	00113423          	sd	ra,8(sp)
    80001b4c:	00813023          	sd	s0,0(sp)
    80001b50:	01010413          	addi	s0,sp,16
    __putc(c);
    80001b54:	00006097          	auipc	ra,0x6
    80001b58:	da8080e7          	jalr	-600(ra) # 800078fc <__putc>
}
    80001b5c:	00813083          	ld	ra,8(sp)
    80001b60:	00013403          	ld	s0,0(sp)
    80001b64:	01010113          	addi	sp,sp,16
    80001b68:	00008067          	ret

0000000080001b6c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001b6c:	fe010113          	addi	sp,sp,-32
    80001b70:	00113c23          	sd	ra,24(sp)
    80001b74:	00813823          	sd	s0,16(sp)
    80001b78:	00913423          	sd	s1,8(sp)
    80001b7c:	02010413          	addi	s0,sp,32
    80001b80:	00050493          	mv	s1,a0
    80001b84:	00008797          	auipc	a5,0x8
    80001b88:	7d478793          	addi	a5,a5,2004 # 8000a358 <_ZTV6Thread+0x10>
    80001b8c:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    80001b90:	00850513          	addi	a0,a0,8
    80001b94:	fffff097          	auipc	ra,0xfffff
    80001b98:	654080e7          	jalr	1620(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001b9c:	00000593          	li	a1,0
    80001ba0:	0084b503          	ld	a0,8(s1)
    80001ba4:	00000097          	auipc	ra,0x0
    80001ba8:	a94080e7          	jalr	-1388(ra) # 80001638 <_ZN7_thread8setStartEb>
}
    80001bac:	01813083          	ld	ra,24(sp)
    80001bb0:	01013403          	ld	s0,16(sp)
    80001bb4:	00813483          	ld	s1,8(sp)
    80001bb8:	02010113          	addi	sp,sp,32
    80001bbc:	00008067          	ret

0000000080001bc0 <_ZN6Thread5startEv>:
int Thread::start() {
    80001bc0:	ff010113          	addi	sp,sp,-16
    80001bc4:	00113423          	sd	ra,8(sp)
    80001bc8:	00813023          	sd	s0,0(sp)
    80001bcc:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001bd0:	00100593          	li	a1,1
    80001bd4:	00853503          	ld	a0,8(a0)
    80001bd8:	00000097          	auipc	ra,0x0
    80001bdc:	a60080e7          	jalr	-1440(ra) # 80001638 <_ZN7_thread8setStartEb>
}
    80001be0:	00000513          	li	a0,0
    80001be4:	00813083          	ld	ra,8(sp)
    80001be8:	00013403          	ld	s0,0(sp)
    80001bec:	01010113          	addi	sp,sp,16
    80001bf0:	00008067          	ret

0000000080001bf4 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001bf4:	ff010113          	addi	sp,sp,-16
    80001bf8:	00113423          	sd	ra,8(sp)
    80001bfc:	00813023          	sd	s0,0(sp)
    80001c00:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001c04:	fffff097          	auipc	ra,0xfffff
    80001c08:	63c080e7          	jalr	1596(ra) # 80001240 <_Z15thread_dispatchv>
}
    80001c0c:	00813083          	ld	ra,8(sp)
    80001c10:	00013403          	ld	s0,0(sp)
    80001c14:	01010113          	addi	sp,sp,16
    80001c18:	00008067          	ret

0000000080001c1c <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001c1c:	fe010113          	addi	sp,sp,-32
    80001c20:	00113c23          	sd	ra,24(sp)
    80001c24:	00813823          	sd	s0,16(sp)
    80001c28:	00913423          	sd	s1,8(sp)
    80001c2c:	02010413          	addi	s0,sp,32
    80001c30:	00050493          	mv	s1,a0
    80001c34:	00008797          	auipc	a5,0x8
    80001c38:	72478793          	addi	a5,a5,1828 # 8000a358 <_ZTV6Thread+0x10>
    80001c3c:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    80001c40:	00050613          	mv	a2,a0
    80001c44:	00000597          	auipc	a1,0x0
    80001c48:	e0c58593          	addi	a1,a1,-500 # 80001a50 <_ZN6Thread12startWrapperEPv>
    80001c4c:	00850513          	addi	a0,a0,8
    80001c50:	fffff097          	auipc	ra,0xfffff
    80001c54:	598080e7          	jalr	1432(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001c58:	00000593          	li	a1,0
    80001c5c:	0084b503          	ld	a0,8(s1)
    80001c60:	00000097          	auipc	ra,0x0
    80001c64:	9d8080e7          	jalr	-1576(ra) # 80001638 <_ZN7_thread8setStartEb>
}
    80001c68:	01813083          	ld	ra,24(sp)
    80001c6c:	01013403          	ld	s0,16(sp)
    80001c70:	00813483          	ld	s1,8(sp)
    80001c74:	02010113          	addi	sp,sp,32
    80001c78:	00008067          	ret

0000000080001c7c <_ZN6Thread4joinEv>:
void Thread::join() {
    80001c7c:	ff010113          	addi	sp,sp,-16
    80001c80:	00113423          	sd	ra,8(sp)
    80001c84:	00813023          	sd	s0,0(sp)
    80001c88:	01010413          	addi	s0,sp,16
    thread_join(&myHandle);
    80001c8c:	00850513          	addi	a0,a0,8
    80001c90:	fffff097          	auipc	ra,0xfffff
    80001c94:	6d4080e7          	jalr	1748(ra) # 80001364 <_Z11thread_joinPP7_thread>
}
    80001c98:	00813083          	ld	ra,8(sp)
    80001c9c:	00013403          	ld	s0,0(sp)
    80001ca0:	01010113          	addi	sp,sp,16
    80001ca4:	00008067          	ret

0000000080001ca8 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80001ca8:	ff010113          	addi	sp,sp,-16
    80001cac:	00113423          	sd	ra,8(sp)
    80001cb0:	00813023          	sd	s0,0(sp)
    80001cb4:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001cb8:	00853503          	ld	a0,8(a0)
    80001cbc:	fffff097          	auipc	ra,0xfffff
    80001cc0:	600080e7          	jalr	1536(ra) # 800012bc <_Z8sem_waitP4_sem>
}
    80001cc4:	00813083          	ld	ra,8(sp)
    80001cc8:	00013403          	ld	s0,0(sp)
    80001ccc:	01010113          	addi	sp,sp,16
    80001cd0:	00008067          	ret

0000000080001cd4 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001cd4:	ff010113          	addi	sp,sp,-16
    80001cd8:	00113423          	sd	ra,8(sp)
    80001cdc:	00813023          	sd	s0,0(sp)
    80001ce0:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001ce4:	00853503          	ld	a0,8(a0)
    80001ce8:	fffff097          	auipc	ra,0xfffff
    80001cec:	600080e7          	jalr	1536(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80001cf0:	00813083          	ld	ra,8(sp)
    80001cf4:	00013403          	ld	s0,0(sp)
    80001cf8:	01010113          	addi	sp,sp,16
    80001cfc:	00008067          	ret

0000000080001d00 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001d00:	ff010113          	addi	sp,sp,-16
    80001d04:	00113423          	sd	ra,8(sp)
    80001d08:	00813023          	sd	s0,0(sp)
    80001d0c:	01010413          	addi	s0,sp,16
    80001d10:	00008797          	auipc	a5,0x8
    80001d14:	67078793          	addi	a5,a5,1648 # 8000a380 <_ZTV9Semaphore+0x10>
    80001d18:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001d1c:	00850513          	addi	a0,a0,8
    80001d20:	fffff097          	auipc	ra,0xfffff
    80001d24:	544080e7          	jalr	1348(ra) # 80001264 <_Z8sem_openPP4_semj>
}
    80001d28:	00813083          	ld	ra,8(sp)
    80001d2c:	00013403          	ld	s0,0(sp)
    80001d30:	01010113          	addi	sp,sp,16
    80001d34:	00008067          	ret

0000000080001d38 <_ZN6Thread3runEv>:

    //static void SetMaximumThreads(int num_of_threads = 5);

protected:
    Thread();
    virtual void run() {}
    80001d38:	ff010113          	addi	sp,sp,-16
    80001d3c:	00813423          	sd	s0,8(sp)
    80001d40:	01010413          	addi	s0,sp,16
    80001d44:	00813403          	ld	s0,8(sp)
    80001d48:	01010113          	addi	sp,sp,16
    80001d4c:	00008067          	ret

0000000080001d50 <_ZN5Riscv10popSppSpieEv>:
using namespace Num;
bool Riscv::userMode = false;


void Riscv::popSppSpie()
{
    80001d50:	ff010113          	addi	sp,sp,-16
    80001d54:	00813423          	sd	s0,8(sp)
    80001d58:	01010413          	addi	s0,sp,16
    if (userMode) mc_sstatus(SSTATUS_SPP);
    80001d5c:	00009797          	auipc	a5,0x9
    80001d60:	84c7c783          	lbu	a5,-1972(a5) # 8000a5a8 <_ZN5Riscv8userModeE>
    80001d64:	02078063          	beqz	a5,80001d84 <_ZN5Riscv10popSppSpieEv+0x34>
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001d68:	10000793          	li	a5,256
    80001d6c:	1007b073          	csrc	sstatus,a5
    else ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    80001d70:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001d74:	10200073          	sret

}
    80001d78:	00813403          	ld	s0,8(sp)
    80001d7c:	01010113          	addi	sp,sp,16
    80001d80:	00008067          	ret
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001d84:	10000793          	li	a5,256
    80001d88:	1007a073          	csrs	sstatus,a5
}
    80001d8c:	fe5ff06f          	j	80001d70 <_ZN5Riscv10popSppSpieEv+0x20>

0000000080001d90 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001d90:	fb010113          	addi	sp,sp,-80
    80001d94:	04113423          	sd	ra,72(sp)
    80001d98:	04813023          	sd	s0,64(sp)
    80001d9c:	02913c23          	sd	s1,56(sp)
    80001da0:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001da4:	142027f3          	csrr	a5,scause
    80001da8:	fcf43023          	sd	a5,-64(s0)
    return scause;
    80001dac:	fc043483          	ld	s1,-64(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001db0:	fff00793          	li	a5,-1
    80001db4:	03f79793          	slli	a5,a5,0x3f
    80001db8:	00178793          	addi	a5,a5,1
    80001dbc:	1cf48a63          	beq	s1,a5,80001f90 <_ZN5Riscv20handleSupervisorTrapEv+0x200>
    80001dc0:	fff00793          	li	a5,-1
    80001dc4:	03f79793          	slli	a5,a5,0x3f
    80001dc8:	00178793          	addi	a5,a5,1
    80001dcc:	0497ee63          	bltu	a5,s1,80001e28 <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    80001dd0:	ff848793          	addi	a5,s1,-8
    80001dd4:	00100713          	li	a4,1
    80001dd8:	1cf76a63          	bltu	a4,a5,80001fac <_ZN5Riscv20handleSupervisorTrapEv+0x21c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001ddc:	141027f3          	csrr	a5,sepc
    80001de0:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001de4:	fd043783          	ld	a5,-48(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 volatile sepc = r_sepc() + 4;
    80001de8:	00478793          	addi	a5,a5,4
    80001dec:	faf43823          	sd	a5,-80(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001df0:	100027f3          	csrr	a5,sstatus
    80001df4:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001df8:	fc843783          	ld	a5,-56(s0)
            uint64 volatile sstatus = r_sstatus();
    80001dfc:	faf43c23          	sd	a5,-72(s0)
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001e00:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001e04:	04200713          	li	a4,66
    80001e08:	10f76e63          	bltu	a4,a5,80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
    80001e0c:	00279793          	slli	a5,a5,0x2
    80001e10:	00006717          	auipc	a4,0x6
    80001e14:	4b470713          	addi	a4,a4,1204 # 800082c4 <CONSOLE_STATUS+0x2b4>
    80001e18:	00e787b3          	add	a5,a5,a4
    80001e1c:	0007a783          	lw	a5,0(a5)
    80001e20:	00e787b3          	add	a5,a5,a4
    80001e24:	00078067          	jr	a5
    switch((uint64)scause){
    80001e28:	fff00793          	li	a5,-1
    80001e2c:	03f79793          	slli	a5,a5,0x3f
    80001e30:	00978793          	addi	a5,a5,9
    80001e34:	16f49c63          	bne	s1,a5,80001fac <_ZN5Riscv20handleSupervisorTrapEv+0x21c>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001e38:	00006097          	auipc	ra,0x6
    80001e3c:	b38080e7          	jalr	-1224(ra) # 80007970 <console_handler>
            break;
    80001e40:	1580006f          	j	80001f98 <_ZN5Riscv20handleSupervisorTrapEv+0x208>
                    READ_REG(size, "a0");
    80001e44:	00050513          	mv	a0,a0
                    memory::allocateMemory(size);
    80001e48:	00000097          	auipc	ra,0x0
    80001e4c:	5ec080e7          	jalr	1516(ra) # 80002434 <_ZN6memory14allocateMemoryEm>
                    break;
    80001e50:	0d40006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(ptr, "a0");
    80001e54:	00050513          	mv	a0,a0
                    memory::freeMemory(ptr);
    80001e58:	00000097          	auipc	ra,0x0
    80001e5c:	700080e7          	jalr	1792(ra) # 80002558 <_ZN6memory10freeMemoryEPv>
                    break;
    80001e60:	0c40006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    memory::getFreeSpace();
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	7ac080e7          	jalr	1964(ra) # 80002610 <_ZN6memory12getFreeSpaceEv>
                    break;
    80001e6c:	0b80006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    memory::getLargestFreeBlock();
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	7d8080e7          	jalr	2008(ra) # 80002648 <_ZN6memory19getLargestFreeBlockEv>
                    break;
    80001e78:	0ac0006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(handle, "a0");
    80001e7c:	00050493          	mv	s1,a0
                    READ_REG(body, "a1");
    80001e80:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001e84:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001e88:	fffff097          	auipc	ra,0xfffff
    80001e8c:	5a8080e7          	jalr	1448(ra) # 80001430 <_ZN7_thread12createThreadEPFvPvES0_>
    80001e90:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001e94:	00050863          	beqz	a0,80001ea4 <_ZN5Riscv20handleSupervisorTrapEv+0x114>
    80001e98:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001e9c:	00078513          	mv	a0,a5
                    break;
    80001ea0:	0840006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    else ret = -1;
    80001ea4:	fff00793          	li	a5,-1
    80001ea8:	ff5ff06f          	j	80001e9c <_ZN5Riscv20handleSupervisorTrapEv+0x10c>
                    _thread::exitThread();
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	750080e7          	jalr	1872(ra) # 800015fc <_ZN7_thread10exitThreadEv>
                    break;
    80001eb4:	0700006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    _thread::dispatch();
    80001eb8:	fffff097          	auipc	ra,0xfffff
    80001ebc:	6b4080e7          	jalr	1716(ra) # 8000156c <_ZN7_thread8dispatchEv>
                    break;
    80001ec0:	0640006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(handlejoin, "a0");
    80001ec4:	00050513          	mv	a0,a0
                    _thread::join(handlejoin);
    80001ec8:	fffff097          	auipc	ra,0xfffff
    80001ecc:	7a8080e7          	jalr	1960(ra) # 80001670 <_ZN7_thread4joinEPPS_>
                    break;
    80001ed0:	0540006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    _thread::running->getThreadID();
    80001ed4:	00008797          	auipc	a5,0x8
    80001ed8:	64c7b783          	ld	a5,1612(a5) # 8000a520 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001edc:	0007b503          	ld	a0,0(a5)
    80001ee0:	00000097          	auipc	ra,0x0
    80001ee4:	850080e7          	jalr	-1968(ra) # 80001730 <_ZN7_thread11getThreadIDEv>
                    break;
    80001ee8:	03c0006f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    _thread::running->joinAll();
    80001eec:	00008797          	auipc	a5,0x8
    80001ef0:	6347b783          	ld	a5,1588(a5) # 8000a520 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001ef4:	0007b503          	ld	a0,0(a5)
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	7bc080e7          	jalr	1980(ra) # 800016b4 <_ZN7_thread7joinAllEv>
                    READ_REG(handle, "a0");
    80001f00:	00050493          	mv	s1,a0
                    READ_REG(init, "a1");
    80001f04:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001f08:	0005051b          	sext.w	a0,a0
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	2a0080e7          	jalr	672(ra) # 800021ac <_ZN4_sem15createSemaphoreEj>
    80001f14:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001f18:	02050063          	beqz	a0,80001f38 <_ZN5Riscv20handleSupervisorTrapEv+0x1a8>
    80001f1c:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001f20:	00078513          	mv	a0,a5
            w_sstatus(sstatus);
    80001f24:	fb843783          	ld	a5,-72(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001f28:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    80001f2c:	fb043783          	ld	a5,-80(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001f30:	14179073          	csrw	sepc,a5
}
    80001f34:	0640006f          	j	80001f98 <_ZN5Riscv20handleSupervisorTrapEv+0x208>
                    else ret = -1;
    80001f38:	fff00793          	li	a5,-1
    80001f3c:	fe5ff06f          	j	80001f20 <_ZN5Riscv20handleSupervisorTrapEv+0x190>
                    READ_REG(handleClose, "a0");
    80001f40:	00050513          	mv	a0,a0
                    handleClose->close();
    80001f44:	00000097          	auipc	ra,0x0
    80001f48:	2cc080e7          	jalr	716(ra) # 80002210 <_ZN4_sem5closeEv>
                    break;
    80001f4c:	fd9ff06f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(idWait, "a0");
    80001f50:	00050513          	mv	a0,a0
                    idWait->wait();
    80001f54:	00000097          	auipc	ra,0x0
    80001f58:	0e0080e7          	jalr	224(ra) # 80002034 <_ZN4_sem4waitEv>
                    break;
    80001f5c:	fc9ff06f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(idSignal, "a0");
    80001f60:	00050513          	mv	a0,a0
                    idSignal->signal();
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	194080e7          	jalr	404(ra) # 800020f8 <_ZN4_sem6signalEv>
                    break;
    80001f6c:	fb9ff06f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    __getc();
    80001f70:	00006097          	auipc	ra,0x6
    80001f74:	9c8080e7          	jalr	-1592(ra) # 80007938 <__getc>
                    break;
    80001f78:	fadff06f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
                    READ_REG(c, "a0");
    80001f7c:	00050513          	mv	a0,a0
                    __putc(c);
    80001f80:	0ff57513          	andi	a0,a0,255
    80001f84:	00006097          	auipc	ra,0x6
    80001f88:	978080e7          	jalr	-1672(ra) # 800078fc <__putc>
                    break;
    80001f8c:	f99ff06f          	j	80001f24 <_ZN5Riscv20handleSupervisorTrapEv+0x194>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001f90:	00200793          	li	a5,2
    80001f94:	1447b073          	csrc	sip,a5
            if ((int)scause == 2) thread_exit();
            printInt(r_sepc());
            thread_exit();
            break;
    }
    80001f98:	04813083          	ld	ra,72(sp)
    80001f9c:	04013403          	ld	s0,64(sp)
    80001fa0:	03813483          	ld	s1,56(sp)
    80001fa4:	05010113          	addi	sp,sp,80
    80001fa8:	00008067          	ret
            printString("Scause: ");
    80001fac:	00006517          	auipc	a0,0x6
    80001fb0:	2d450513          	addi	a0,a0,724 # 80008280 <CONSOLE_STATUS+0x270>
    80001fb4:	00002097          	auipc	ra,0x2
    80001fb8:	68c080e7          	jalr	1676(ra) # 80004640 <_Z11printStringPKc>
            printInt(scause);
    80001fbc:	0004849b          	sext.w	s1,s1
    80001fc0:	00000613          	li	a2,0
    80001fc4:	00a00593          	li	a1,10
    80001fc8:	00048513          	mv	a0,s1
    80001fcc:	00003097          	auipc	ra,0x3
    80001fd0:	824080e7          	jalr	-2012(ra) # 800047f0 <_Z8printIntiii>
            printString("\n");
    80001fd4:	00006517          	auipc	a0,0x6
    80001fd8:	5fc50513          	addi	a0,a0,1532 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80001fdc:	00002097          	auipc	ra,0x2
    80001fe0:	664080e7          	jalr	1636(ra) # 80004640 <_Z11printStringPKc>
            printString("Koraci ko laki oblaci, skoci da te zemlja odbaci!\n");
    80001fe4:	00006517          	auipc	a0,0x6
    80001fe8:	2ac50513          	addi	a0,a0,684 # 80008290 <CONSOLE_STATUS+0x280>
    80001fec:	00002097          	auipc	ra,0x2
    80001ff0:	654080e7          	jalr	1620(ra) # 80004640 <_Z11printStringPKc>
            if ((int)scause == 2) thread_exit();
    80001ff4:	00200793          	li	a5,2
    80001ff8:	02f48863          	beq	s1,a5,80002028 <_ZN5Riscv20handleSupervisorTrapEv+0x298>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001ffc:	141027f3          	csrr	a5,sepc
    80002000:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80002004:	fd843503          	ld	a0,-40(s0)
            printInt(r_sepc());
    80002008:	00000613          	li	a2,0
    8000200c:	00a00593          	li	a1,10
    80002010:	0005051b          	sext.w	a0,a0
    80002014:	00002097          	auipc	ra,0x2
    80002018:	7dc080e7          	jalr	2012(ra) # 800047f0 <_Z8printIntiii>
            thread_exit();
    8000201c:	fffff097          	auipc	ra,0xfffff
    80002020:	1f8080e7          	jalr	504(ra) # 80001214 <_Z11thread_exitv>
    80002024:	f75ff06f          	j	80001f98 <_ZN5Riscv20handleSupervisorTrapEv+0x208>
            if ((int)scause == 2) thread_exit();
    80002028:	fffff097          	auipc	ra,0xfffff
    8000202c:	1ec080e7          	jalr	492(ra) # 80001214 <_Z11thread_exitv>
    80002030:	fcdff06f          	j	80001ffc <_ZN5Riscv20handleSupervisorTrapEv+0x26c>

0000000080002034 <_ZN4_sem4waitEv>:

    int value() const { return val; }


    void setClosed(bool b);
    bool isClosed() const {return closed;}
    80002034:	00454783          	lbu	a5,4(a0)

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (isClosed()) return -1;
    80002038:	0a079c63          	bnez	a5,800020f0 <_ZN4_sem4waitEv+0xbc>
int _sem::wait() {
    8000203c:	fe010113          	addi	sp,sp,-32
    80002040:	00113c23          	sd	ra,24(sp)
    80002044:	00813823          	sd	s0,16(sp)
    80002048:	00913423          	sd	s1,8(sp)
    8000204c:	01213023          	sd	s2,0(sp)
    80002050:	02010413          	addi	s0,sp,32
    80002054:	00050493          	mv	s1,a0
    if (--val < 0){
    80002058:	00052783          	lw	a5,0(a0)
    8000205c:	fff7879b          	addiw	a5,a5,-1
    80002060:	00f52023          	sw	a5,0(a0)
    80002064:	02079713          	slli	a4,a5,0x20
    80002068:	02074663          	bltz	a4,80002094 <_ZN4_sem4waitEv+0x60>
        cur->setSemStatus(0);
        blocked.addLast(cur);
        thread_dispatch();
    }

    return _thread::running->getSemStatus();
    8000206c:	00008797          	auipc	a5,0x8
    80002070:	4b47b783          	ld	a5,1204(a5) # 8000a520 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002074:	0007b783          	ld	a5,0(a5)
    void setStart(bool b);
    bool isStarted() const { return started; }
    void setBlock(bool b);
    bool isBlocked() const { return blocked; }
    void setSemStatus(int s) { semStatus = s; }
    int getSemStatus() const { return semStatus; }
    80002078:	02c7a503          	lw	a0,44(a5)
}
    8000207c:	01813083          	ld	ra,24(sp)
    80002080:	01013403          	ld	s0,16(sp)
    80002084:	00813483          	ld	s1,8(sp)
    80002088:	00013903          	ld	s2,0(sp)
    8000208c:	02010113          	addi	sp,sp,32
    80002090:	00008067          	ret
        _thread* cur = _thread::running;
    80002094:	00008797          	auipc	a5,0x8
    80002098:	48c7b783          	ld	a5,1164(a5) # 8000a520 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000209c:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    800020a0:	00100593          	li	a1,1
    800020a4:	00090513          	mv	a0,s2
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	5ac080e7          	jalr	1452(ra) # 80001654 <_ZN7_thread8setBlockEb>
    void setSemStatus(int s) { semStatus = s; }
    800020b0:	02092623          	sw	zero,44(s2)
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    800020b4:	01000513          	li	a0,16
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	8e0080e7          	jalr	-1824(ra) # 80001998 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800020c0:	01253023          	sd	s2,0(a0)
    800020c4:	00053423          	sd	zero,8(a0)
        if (tail)
    800020c8:	0104b783          	ld	a5,16(s1)
    800020cc:	00078c63          	beqz	a5,800020e4 <_ZN4_sem4waitEv+0xb0>
        {
            tail->next = elem;
    800020d0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800020d4:	00a4b823          	sd	a0,16(s1)
        thread_dispatch();
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	168080e7          	jalr	360(ra) # 80001240 <_Z15thread_dispatchv>
    800020e0:	f8dff06f          	j	8000206c <_ZN4_sem4waitEv+0x38>
        } else
        {
            head = tail = elem;
    800020e4:	00a4b823          	sd	a0,16(s1)
    800020e8:	00a4b423          	sd	a0,8(s1)
    800020ec:	fedff06f          	j	800020d8 <_ZN4_sem4waitEv+0xa4>
    if (isClosed()) return -1;
    800020f0:	fff00513          	li	a0,-1
}
    800020f4:	00008067          	ret

00000000800020f8 <_ZN4_sem6signalEv>:
    800020f8:	00454703          	lbu	a4,4(a0)

int _sem::signal() {
    if (isClosed()) return -1;
    800020fc:	08071c63          	bnez	a4,80002194 <_ZN4_sem6signalEv+0x9c>
    80002100:	00050793          	mv	a5,a0
    if(++val <= 0){
    80002104:	00052703          	lw	a4,0(a0)
    80002108:	0017071b          	addiw	a4,a4,1
    8000210c:	0007069b          	sext.w	a3,a4
    80002110:	00e52023          	sw	a4,0(a0)
    80002114:	00d05663          	blez	a3,80002120 <_ZN4_sem6signalEv+0x28>
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
    80002118:	00000513          	li	a0,0
    8000211c:	00008067          	ret
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80002120:	00853503          	ld	a0,8(a0)
    80002124:	06050c63          	beqz	a0,8000219c <_ZN4_sem6signalEv+0xa4>
int _sem::signal() {
    80002128:	fe010113          	addi	sp,sp,-32
    8000212c:	00113c23          	sd	ra,24(sp)
    80002130:	00813823          	sd	s0,16(sp)
    80002134:	00913423          	sd	s1,8(sp)
    80002138:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    8000213c:	00853703          	ld	a4,8(a0)
    80002140:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80002144:	04070463          	beqz	a4,8000218c <_ZN4_sem6signalEv+0x94>

        T *ret = elem->data;
    80002148:	00053483          	ld	s1,0(a0)
        delete elem;
    8000214c:	00000097          	auipc	ra,0x0
    80002150:	89c080e7          	jalr	-1892(ra) # 800019e8 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80002154:	04048863          	beqz	s1,800021a4 <_ZN4_sem6signalEv+0xac>
            cur->setBlock(false);
    80002158:	00000593          	li	a1,0
    8000215c:	00048513          	mv	a0,s1
    80002160:	fffff097          	auipc	ra,0xfffff
    80002164:	4f4080e7          	jalr	1268(ra) # 80001654 <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80002168:	00048513          	mv	a0,s1
    8000216c:	00000097          	auipc	ra,0x0
    80002170:	1e4080e7          	jalr	484(ra) # 80002350 <_ZN9Scheduler3putEP7_thread>
    return 0;
    80002174:	00000513          	li	a0,0
}
    80002178:	01813083          	ld	ra,24(sp)
    8000217c:	01013403          	ld	s0,16(sp)
    80002180:	00813483          	ld	s1,8(sp)
    80002184:	02010113          	addi	sp,sp,32
    80002188:	00008067          	ret
        if (!head) { tail = 0; }
    8000218c:	0007b823          	sd	zero,16(a5)
    80002190:	fb9ff06f          	j	80002148 <_ZN4_sem6signalEv+0x50>
    if (isClosed()) return -1;
    80002194:	fff00513          	li	a0,-1
    80002198:	00008067          	ret
    return 0;
    8000219c:	00000513          	li	a0,0
}
    800021a0:	00008067          	ret
    return 0;
    800021a4:	00000513          	li	a0,0
    800021a8:	fd1ff06f          	j	80002178 <_ZN4_sem6signalEv+0x80>

00000000800021ac <_ZN4_sem15createSemaphoreEj>:
    }

    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    800021ac:	fe010113          	addi	sp,sp,-32
    800021b0:	00113c23          	sd	ra,24(sp)
    800021b4:	00813823          	sd	s0,16(sp)
    800021b8:	00913423          	sd	s1,8(sp)
    800021bc:	02010413          	addi	s0,sp,32
    800021c0:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    800021c4:	01800513          	li	a0,24
    800021c8:	fffff097          	auipc	ra,0xfffff
    800021cc:	7d0080e7          	jalr	2000(ra) # 80001998 <_Znwm>
    _sem(uint32 init = 1) : val(init), closed(false) {}
    800021d0:	00952023          	sw	s1,0(a0)
    800021d4:	00050223          	sb	zero,4(a0)
    List() : head(0), tail(0) {}
    800021d8:	00053423          	sd	zero,8(a0)
    800021dc:	00053823          	sd	zero,16(a0)
    return newSemaphore;
}
    800021e0:	01813083          	ld	ra,24(sp)
    800021e4:	01013403          	ld	s0,16(sp)
    800021e8:	00813483          	ld	s1,8(sp)
    800021ec:	02010113          	addi	sp,sp,32
    800021f0:	00008067          	ret

00000000800021f4 <_ZN4_sem9setClosedEb>:

void _sem::setClosed(bool b) {
    800021f4:	ff010113          	addi	sp,sp,-16
    800021f8:	00813423          	sd	s0,8(sp)
    800021fc:	01010413          	addi	s0,sp,16
    closed = b;
    80002200:	00b50223          	sb	a1,4(a0)
}
    80002204:	00813403          	ld	s0,8(sp)
    80002208:	01010113          	addi	sp,sp,16
    8000220c:	00008067          	ret

0000000080002210 <_ZN4_sem5closeEv>:
int _sem::close() {
    80002210:	fe010113          	addi	sp,sp,-32
    80002214:	00113c23          	sd	ra,24(sp)
    80002218:	00813823          	sd	s0,16(sp)
    8000221c:	00913423          	sd	s1,8(sp)
    80002220:	01213023          	sd	s2,0(sp)
    80002224:	02010413          	addi	s0,sp,32
    80002228:	00050913          	mv	s2,a0
    setClosed(true);
    8000222c:	00100593          	li	a1,1
    80002230:	00000097          	auipc	ra,0x0
    80002234:	fc4080e7          	jalr	-60(ra) # 800021f4 <_ZN4_sem9setClosedEb>
    80002238:	03c0006f          	j	80002274 <_ZN4_sem5closeEv+0x64>
        if (!head) { tail = 0; }
    8000223c:	00093823          	sd	zero,16(s2)
        T *ret = elem->data;
    80002240:	00053483          	ld	s1,0(a0)
        delete elem;
    80002244:	fffff097          	auipc	ra,0xfffff
    80002248:	7a4080e7          	jalr	1956(ra) # 800019e8 <_ZdlPv>
    while(_thread* cur = blocked.removeFirst()){
    8000224c:	04048063          	beqz	s1,8000228c <_ZN4_sem5closeEv+0x7c>
    80002250:	fff00793          	li	a5,-1
    80002254:	02f4a623          	sw	a5,44(s1)
        cur->setBlock(false);
    80002258:	00000593          	li	a1,0
    8000225c:	00048513          	mv	a0,s1
    80002260:	fffff097          	auipc	ra,0xfffff
    80002264:	3f4080e7          	jalr	1012(ra) # 80001654 <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    80002268:	00048513          	mv	a0,s1
    8000226c:	00000097          	auipc	ra,0x0
    80002270:	0e4080e7          	jalr	228(ra) # 80002350 <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80002274:	00893503          	ld	a0,8(s2)
    80002278:	00050a63          	beqz	a0,8000228c <_ZN4_sem5closeEv+0x7c>
        head = head->next;
    8000227c:	00853783          	ld	a5,8(a0)
    80002280:	00f93423          	sd	a5,8(s2)
        if (!head) { tail = 0; }
    80002284:	fa079ee3          	bnez	a5,80002240 <_ZN4_sem5closeEv+0x30>
    80002288:	fb5ff06f          	j	8000223c <_ZN4_sem5closeEv+0x2c>
}
    8000228c:	00000513          	li	a0,0
    80002290:	01813083          	ld	ra,24(sp)
    80002294:	01013403          	ld	s0,16(sp)
    80002298:	00813483          	ld	s1,8(sp)
    8000229c:	00013903          	ld	s2,0(sp)
    800022a0:	02010113          	addi	sp,sp,32
    800022a4:	00008067          	ret

00000000800022a8 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *tcb)
{
    readyThreadQueue.addLast(tcb);
    800022a8:	ff010113          	addi	sp,sp,-16
    800022ac:	00813423          	sd	s0,8(sp)
    800022b0:	01010413          	addi	s0,sp,16
    800022b4:	00100793          	li	a5,1
    800022b8:	00f50863          	beq	a0,a5,800022c8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800022bc:	00813403          	ld	s0,8(sp)
    800022c0:	01010113          	addi	sp,sp,16
    800022c4:	00008067          	ret
    800022c8:	000107b7          	lui	a5,0x10
    800022cc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022d0:	fef596e3          	bne	a1,a5,800022bc <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(0), tail(0) {}
    800022d4:	00008797          	auipc	a5,0x8
    800022d8:	2dc78793          	addi	a5,a5,732 # 8000a5b0 <_ZN9Scheduler16readyThreadQueueE>
    800022dc:	0007b023          	sd	zero,0(a5)
    800022e0:	0007b423          	sd	zero,8(a5)
    800022e4:	fd9ff06f          	j	800022bc <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800022e8 <_ZN9Scheduler3getEv>:
{
    800022e8:	fe010113          	addi	sp,sp,-32
    800022ec:	00113c23          	sd	ra,24(sp)
    800022f0:	00813823          	sd	s0,16(sp)
    800022f4:	00913423          	sd	s1,8(sp)
    800022f8:	02010413          	addi	s0,sp,32
        if (!head) { return 0; }
    800022fc:	00008517          	auipc	a0,0x8
    80002300:	2b453503          	ld	a0,692(a0) # 8000a5b0 <_ZN9Scheduler16readyThreadQueueE>
    80002304:	04050263          	beqz	a0,80002348 <_ZN9Scheduler3getEv+0x60>
        head = head->next;
    80002308:	00853783          	ld	a5,8(a0)
    8000230c:	00008717          	auipc	a4,0x8
    80002310:	2af73223          	sd	a5,676(a4) # 8000a5b0 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80002314:	02078463          	beqz	a5,8000233c <_ZN9Scheduler3getEv+0x54>
        T *ret = elem->data;
    80002318:	00053483          	ld	s1,0(a0)
        delete elem;
    8000231c:	fffff097          	auipc	ra,0xfffff
    80002320:	6cc080e7          	jalr	1740(ra) # 800019e8 <_ZdlPv>
}
    80002324:	00048513          	mv	a0,s1
    80002328:	01813083          	ld	ra,24(sp)
    8000232c:	01013403          	ld	s0,16(sp)
    80002330:	00813483          	ld	s1,8(sp)
    80002334:	02010113          	addi	sp,sp,32
    80002338:	00008067          	ret
        if (!head) { tail = 0; }
    8000233c:	00008797          	auipc	a5,0x8
    80002340:	2607be23          	sd	zero,636(a5) # 8000a5b8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002344:	fd5ff06f          	j	80002318 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80002348:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    8000234c:	fd9ff06f          	j	80002324 <_ZN9Scheduler3getEv+0x3c>

0000000080002350 <_ZN9Scheduler3putEP7_thread>:
{
    80002350:	fe010113          	addi	sp,sp,-32
    80002354:	00113c23          	sd	ra,24(sp)
    80002358:	00813823          	sd	s0,16(sp)
    8000235c:	00913423          	sd	s1,8(sp)
    80002360:	02010413          	addi	s0,sp,32
    80002364:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80002368:	01000513          	li	a0,16
    8000236c:	fffff097          	auipc	ra,0xfffff
    80002370:	62c080e7          	jalr	1580(ra) # 80001998 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002374:	00953023          	sd	s1,0(a0)
    80002378:	00053423          	sd	zero,8(a0)
        if (tail)
    8000237c:	00008797          	auipc	a5,0x8
    80002380:	23c7b783          	ld	a5,572(a5) # 8000a5b8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002384:	02078263          	beqz	a5,800023a8 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80002388:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    8000238c:	00008797          	auipc	a5,0x8
    80002390:	22a7b623          	sd	a0,556(a5) # 8000a5b8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002394:	01813083          	ld	ra,24(sp)
    80002398:	01013403          	ld	s0,16(sp)
    8000239c:	00813483          	ld	s1,8(sp)
    800023a0:	02010113          	addi	sp,sp,32
    800023a4:	00008067          	ret
            head = tail = elem;
    800023a8:	00008797          	auipc	a5,0x8
    800023ac:	20878793          	addi	a5,a5,520 # 8000a5b0 <_ZN9Scheduler16readyThreadQueueE>
    800023b0:	00a7b423          	sd	a0,8(a5)
    800023b4:	00a7b023          	sd	a0,0(a5)
    800023b8:	fddff06f          	j	80002394 <_ZN9Scheduler3putEP7_thread+0x44>

00000000800023bc <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    800023bc:	ff010113          	addi	sp,sp,-16
    800023c0:	00113423          	sd	ra,8(sp)
    800023c4:	00813023          	sd	s0,0(sp)
    800023c8:	01010413          	addi	s0,sp,16
    800023cc:	000105b7          	lui	a1,0x10
    800023d0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800023d4:	00100513          	li	a0,1
    800023d8:	00000097          	auipc	ra,0x0
    800023dc:	ed0080e7          	jalr	-304(ra) # 800022a8 <_Z41__static_initialization_and_destruction_0ii>
    800023e0:	00813083          	ld	ra,8(sp)
    800023e4:	00013403          	ld	s0,0(sp)
    800023e8:	01010113          	addi	sp,sp,16
    800023ec:	00008067          	ret

00000000800023f0 <_ZN6memory10initializeEv>:

#include "../h/memory.hpp"

memory::FreeBlock* memory::freeHead = nullptr;

void memory::initialize() {
    800023f0:	ff010113          	addi	sp,sp,-16
    800023f4:	00813423          	sd	s0,8(sp)
    800023f8:	01010413          	addi	s0,sp,16
    freeHead = (FreeBlock*) HEAP_START_ADDR;
    800023fc:	00008797          	auipc	a5,0x8
    80002400:	11c7b783          	ld	a5,284(a5) # 8000a518 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002404:	0007b783          	ld	a5,0(a5)
    80002408:	00008717          	auipc	a4,0x8
    8000240c:	1af73c23          	sd	a5,440(a4) # 8000a5c0 <_ZN6memory8freeHeadE>
    freeHead->size = (size_t)((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR);
    80002410:	00008717          	auipc	a4,0x8
    80002414:	12873703          	ld	a4,296(a4) # 8000a538 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002418:	00073703          	ld	a4,0(a4)
    8000241c:	40f70733          	sub	a4,a4,a5
    80002420:	00e7b423          	sd	a4,8(a5)
    freeHead->next = nullptr;
    80002424:	0007b023          	sd	zero,0(a5)
}
    80002428:	00813403          	ld	s0,8(sp)
    8000242c:	01010113          	addi	sp,sp,16
    80002430:	00008067          	ret

0000000080002434 <_ZN6memory14allocateMemoryEm>:

void *memory::allocateMemory(size_t size) {
    80002434:	ff010113          	addi	sp,sp,-16
    80002438:	00813423          	sd	s0,8(sp)
    8000243c:	01010413          	addi	s0,sp,16
    if (size == 0) return nullptr;
    80002440:	0c050463          	beqz	a0,80002508 <_ZN6memory14allocateMemoryEm+0xd4>

    // zaokruzujemo na MEM_BLOCK_SIZE
    size = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE * MEM_BLOCK_SIZE;
    80002444:	03f50713          	addi	a4,a0,63
    80002448:	fc077713          	andi	a4,a4,-64

    // rezervisemo i header za slobodni blok ako ga cepamo
    size_t totalSize = size + sizeof(FreeBlock);
    8000244c:	01070713          	addi	a4,a4,16
    FreeBlock* bestPrev = nullptr;
    FreeBlock* best = nullptr;
    FreeBlock* prev = nullptr;

    // pronalazak najmanjeg dovoljno velikog bloka (best-fit)
    for(FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002450:	00008797          	auipc	a5,0x8
    80002454:	1707b783          	ld	a5,368(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
    FreeBlock* prev = nullptr;
    80002458:	00000613          	li	a2,0
    FreeBlock* best = nullptr;
    8000245c:	00000513          	li	a0,0
    FreeBlock* bestPrev = nullptr;
    80002460:	00000813          	li	a6,0
    80002464:	0140006f          	j	80002478 <_ZN6memory14allocateMemoryEm+0x44>
        if (curr->size >= totalSize){
            if (!best || curr->size < best->size){
                best = curr;
    80002468:	00078513          	mv	a0,a5
                bestPrev = prev;
    8000246c:	00060813          	mv	a6,a2
            }
        }
        prev = curr;
    80002470:	00078613          	mv	a2,a5
    for(FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002474:	0007b783          	ld	a5,0(a5)
    80002478:	02078263          	beqz	a5,8000249c <_ZN6memory14allocateMemoryEm+0x68>
        if (curr->size >= totalSize){
    8000247c:	0087b683          	ld	a3,8(a5)
    80002480:	fee6e8e3          	bltu	a3,a4,80002470 <_ZN6memory14allocateMemoryEm+0x3c>
            if (!best || curr->size < best->size){
    80002484:	fe0502e3          	beqz	a0,80002468 <_ZN6memory14allocateMemoryEm+0x34>
    80002488:	00853583          	ld	a1,8(a0)
    8000248c:	feb6f2e3          	bgeu	a3,a1,80002470 <_ZN6memory14allocateMemoryEm+0x3c>
                best = curr;
    80002490:	00078513          	mv	a0,a5
                bestPrev = prev;
    80002494:	00060813          	mv	a6,a2
    80002498:	fd9ff06f          	j	80002470 <_ZN6memory14allocateMemoryEm+0x3c>
    }

    if (!best) return nullptr; // nema dovoljno memorije
    8000249c:	02050a63          	beqz	a0,800024d0 <_ZN6memory14allocateMemoryEm+0x9c>

    size_t remaining = best->size - totalSize;
    800024a0:	00853783          	ld	a5,8(a0)
    800024a4:	40e787b3          	sub	a5,a5,a4

    if (remaining >= sizeof(FreeBlock) + MEM_BLOCK_SIZE){
    800024a8:	04f00693          	li	a3,79
    800024ac:	02f6fe63          	bgeu	a3,a5,800024e8 <_ZN6memory14allocateMemoryEm+0xb4>
        // cepamo blok
        FreeBlock* newBlock = (FreeBlock*)((char*)best + totalSize);
    800024b0:	00e506b3          	add	a3,a0,a4
        newBlock->size = remaining;
    800024b4:	00f6b423          	sd	a5,8(a3)
        newBlock->next = best->next;
    800024b8:	00053783          	ld	a5,0(a0)
    800024bc:	00f6b023          	sd	a5,0(a3)
        best->size = totalSize;
    800024c0:	00e53423          	sd	a4,8(a0)
        if (bestPrev) bestPrev->next = newBlock;
    800024c4:	00080c63          	beqz	a6,800024dc <_ZN6memory14allocateMemoryEm+0xa8>
    800024c8:	00d83023          	sd	a3,0(a6)
        if (bestPrev) bestPrev->next = best->next;
        else freeHead = best->next;
    }

    // vracamo pokazivac na korisnicki deo, posle headera
    return (void *)((char*)best + sizeof(FreeBlock));
    800024cc:	01050513          	addi	a0,a0,16
}
    800024d0:	00813403          	ld	s0,8(sp)
    800024d4:	01010113          	addi	sp,sp,16
    800024d8:	00008067          	ret
        else freeHead = newBlock;
    800024dc:	00008797          	auipc	a5,0x8
    800024e0:	0ed7b223          	sd	a3,228(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
    800024e4:	fe9ff06f          	j	800024cc <_ZN6memory14allocateMemoryEm+0x98>
        if (bestPrev) bestPrev->next = best->next;
    800024e8:	00080863          	beqz	a6,800024f8 <_ZN6memory14allocateMemoryEm+0xc4>
    800024ec:	00053783          	ld	a5,0(a0)
    800024f0:	00f83023          	sd	a5,0(a6)
    800024f4:	fd9ff06f          	j	800024cc <_ZN6memory14allocateMemoryEm+0x98>
        else freeHead = best->next;
    800024f8:	00053783          	ld	a5,0(a0)
    800024fc:	00008717          	auipc	a4,0x8
    80002500:	0cf73223          	sd	a5,196(a4) # 8000a5c0 <_ZN6memory8freeHeadE>
    80002504:	fc9ff06f          	j	800024cc <_ZN6memory14allocateMemoryEm+0x98>
    if (size == 0) return nullptr;
    80002508:	00000513          	li	a0,0
    8000250c:	fc5ff06f          	j	800024d0 <_ZN6memory14allocateMemoryEm+0x9c>

0000000080002510 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>:

    tryToJoin(curr);
    return 0;
}

void memory::tryToJoin(memory::FreeBlock *block) {
    80002510:	ff010113          	addi	sp,sp,-16
    80002514:	00813423          	sd	s0,8(sp)
    80002518:	01010413          	addi	s0,sp,16
    if(!block || !block->next) return;
    8000251c:	00050c63          	beqz	a0,80002534 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>
    80002520:	00053783          	ld	a5,0(a0)
    80002524:	00078863          	beqz	a5,80002534 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>

    char* endOfBlock = (char*)block + block->size;
    80002528:	00853703          	ld	a4,8(a0)
    8000252c:	00e506b3          	add	a3,a0,a4
    if (endOfBlock == (char*)block->next){
    80002530:	00d78863          	beq	a5,a3,80002540 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x30>
        block->size += block->next->size;
        block->next = block->next->next;
    }
}
    80002534:	00813403          	ld	s0,8(sp)
    80002538:	01010113          	addi	sp,sp,16
    8000253c:	00008067          	ret
        block->size += block->next->size;
    80002540:	0087b683          	ld	a3,8(a5)
    80002544:	00d70733          	add	a4,a4,a3
    80002548:	00e53423          	sd	a4,8(a0)
        block->next = block->next->next;
    8000254c:	0007b783          	ld	a5,0(a5)
    80002550:	00f53023          	sd	a5,0(a0)
    80002554:	fe1ff06f          	j	80002534 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>

0000000080002558 <_ZN6memory10freeMemoryEPv>:
    if (!ptr) return -1;
    80002558:	0a050063          	beqz	a0,800025f8 <_ZN6memory10freeMemoryEPv+0xa0>
    8000255c:	00050693          	mv	a3,a0
    FreeBlock* block = (FreeBlock*)((char*)ptr - sizeof(FreeBlock));
    80002560:	ff050713          	addi	a4,a0,-16
    if (block < (FreeBlock*)HEAP_START_ADDR || block >= (FreeBlock*)HEAP_END_ADDR) return -2; // van heapa
    80002564:	00008797          	auipc	a5,0x8
    80002568:	fb47b783          	ld	a5,-76(a5) # 8000a518 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000256c:	0007b783          	ld	a5,0(a5)
    80002570:	08f76863          	bltu	a4,a5,80002600 <_ZN6memory10freeMemoryEPv+0xa8>
    80002574:	00008797          	auipc	a5,0x8
    80002578:	fc47b783          	ld	a5,-60(a5) # 8000a538 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000257c:	0007b783          	ld	a5,0(a5)
    80002580:	08f77463          	bgeu	a4,a5,80002608 <_ZN6memory10freeMemoryEPv+0xb0>
int memory::freeMemory(void *ptr) {
    80002584:	ff010113          	addi	sp,sp,-16
    80002588:	00113423          	sd	ra,8(sp)
    8000258c:	00813023          	sd	s0,0(sp)
    80002590:	01010413          	addi	s0,sp,16
    if (!freeHead || block < freeHead){
    80002594:	00008797          	auipc	a5,0x8
    80002598:	02c7b783          	ld	a5,44(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
    8000259c:	02078e63          	beqz	a5,800025d8 <_ZN6memory10freeMemoryEPv+0x80>
    800025a0:	02f76c63          	bltu	a4,a5,800025d8 <_ZN6memory10freeMemoryEPv+0x80>
    while(curr->next && curr->next < block) curr = curr->next;
    800025a4:	00078513          	mv	a0,a5
    800025a8:	0007b783          	ld	a5,0(a5)
    800025ac:	00078463          	beqz	a5,800025b4 <_ZN6memory10freeMemoryEPv+0x5c>
    800025b0:	fee7eae3          	bltu	a5,a4,800025a4 <_ZN6memory10freeMemoryEPv+0x4c>
    block->next = curr->next;
    800025b4:	fef6b823          	sd	a5,-16(a3)
    curr->next = block;
    800025b8:	00e53023          	sd	a4,0(a0)
    tryToJoin(curr);
    800025bc:	00000097          	auipc	ra,0x0
    800025c0:	f54080e7          	jalr	-172(ra) # 80002510 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>
    return 0;
    800025c4:	00000513          	li	a0,0
}
    800025c8:	00813083          	ld	ra,8(sp)
    800025cc:	00013403          	ld	s0,0(sp)
    800025d0:	01010113          	addi	sp,sp,16
    800025d4:	00008067          	ret
        block->next = freeHead;
    800025d8:	fef6b823          	sd	a5,-16(a3)
        freeHead = block;
    800025dc:	00008797          	auipc	a5,0x8
    800025e0:	fee7b223          	sd	a4,-28(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
        tryToJoin(block);
    800025e4:	00070513          	mv	a0,a4
    800025e8:	00000097          	auipc	ra,0x0
    800025ec:	f28080e7          	jalr	-216(ra) # 80002510 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>
        return 0;
    800025f0:	00000513          	li	a0,0
    800025f4:	fd5ff06f          	j	800025c8 <_ZN6memory10freeMemoryEPv+0x70>
    if (!ptr) return -1;
    800025f8:	fff00513          	li	a0,-1
    800025fc:	00008067          	ret
    if (block < (FreeBlock*)HEAP_START_ADDR || block >= (FreeBlock*)HEAP_END_ADDR) return -2; // van heapa
    80002600:	ffe00513          	li	a0,-2
    80002604:	00008067          	ret
    80002608:	ffe00513          	li	a0,-2
}
    8000260c:	00008067          	ret

0000000080002610 <_ZN6memory12getFreeSpaceEv>:

size_t memory::getFreeSpace() {
    80002610:	ff010113          	addi	sp,sp,-16
    80002614:	00813423          	sd	s0,8(sp)
    80002618:	01010413          	addi	s0,sp,16
    size_t total = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next) total += curr->size;
    8000261c:	00008797          	auipc	a5,0x8
    80002620:	fa47b783          	ld	a5,-92(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
    size_t total = 0;
    80002624:	00000513          	li	a0,0
    for (FreeBlock* curr = freeHead; curr; curr = curr->next) total += curr->size;
    80002628:	00078a63          	beqz	a5,8000263c <_ZN6memory12getFreeSpaceEv+0x2c>
    8000262c:	0087b703          	ld	a4,8(a5)
    80002630:	00e50533          	add	a0,a0,a4
    80002634:	0007b783          	ld	a5,0(a5)
    80002638:	ff1ff06f          	j	80002628 <_ZN6memory12getFreeSpaceEv+0x18>
    return total;
}
    8000263c:	00813403          	ld	s0,8(sp)
    80002640:	01010113          	addi	sp,sp,16
    80002644:	00008067          	ret

0000000080002648 <_ZN6memory19getLargestFreeBlockEv>:

size_t memory::getLargestFreeBlock() {
    80002648:	ff010113          	addi	sp,sp,-16
    8000264c:	00813423          	sd	s0,8(sp)
    80002650:	01010413          	addi	s0,sp,16
    size_t largest = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002654:	00008797          	auipc	a5,0x8
    80002658:	f6c7b783          	ld	a5,-148(a5) # 8000a5c0 <_ZN6memory8freeHeadE>
    size_t largest = 0;
    8000265c:	00000513          	li	a0,0
    80002660:	0080006f          	j	80002668 <_ZN6memory19getLargestFreeBlockEv+0x20>
    for (FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002664:	0007b783          	ld	a5,0(a5)
    80002668:	00078a63          	beqz	a5,8000267c <_ZN6memory19getLargestFreeBlockEv+0x34>
        if (curr->size > largest) largest = curr->size;
    8000266c:	0087b703          	ld	a4,8(a5)
    80002670:	fee57ae3          	bgeu	a0,a4,80002664 <_ZN6memory19getLargestFreeBlockEv+0x1c>
    80002674:	00070513          	mv	a0,a4
    80002678:	fedff06f          	j	80002664 <_ZN6memory19getLargestFreeBlockEv+0x1c>
    }
    return largest;
}
    8000267c:	00813403          	ld	s0,8(sp)
    80002680:	01010113          	addi	sp,sp,16
    80002684:	00008067          	ret

0000000080002688 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80002688:	fe010113          	addi	sp,sp,-32
    8000268c:	00113c23          	sd	ra,24(sp)
    80002690:	00813823          	sd	s0,16(sp)
    80002694:	00913423          	sd	s1,8(sp)
    80002698:	01213023          	sd	s2,0(sp)
    8000269c:	02010413          	addi	s0,sp,32
    800026a0:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800026a4:	00000913          	li	s2,0
    800026a8:	00c0006f          	j	800026b4 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800026ac:	fffff097          	auipc	ra,0xfffff
    800026b0:	b94080e7          	jalr	-1132(ra) # 80001240 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	c60080e7          	jalr	-928(ra) # 80001314 <_Z4getcv>
    800026bc:	0005059b          	sext.w	a1,a0
    800026c0:	01b00793          	li	a5,27
    800026c4:	02f58a63          	beq	a1,a5,800026f8 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    800026c8:	0084b503          	ld	a0,8(s1)
    800026cc:	00003097          	auipc	ra,0x3
    800026d0:	cc0080e7          	jalr	-832(ra) # 8000538c <_ZN6Buffer3putEi>
        i++;
    800026d4:	0019071b          	addiw	a4,s2,1
    800026d8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800026dc:	0004a683          	lw	a3,0(s1)
    800026e0:	0026979b          	slliw	a5,a3,0x2
    800026e4:	00d787bb          	addw	a5,a5,a3
    800026e8:	0017979b          	slliw	a5,a5,0x1
    800026ec:	02f767bb          	remw	a5,a4,a5
    800026f0:	fc0792e3          	bnez	a5,800026b4 <_ZL16producerKeyboardPv+0x2c>
    800026f4:	fb9ff06f          	j	800026ac <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    800026f8:	00100793          	li	a5,1
    800026fc:	00008717          	auipc	a4,0x8
    80002700:	ecf72623          	sw	a5,-308(a4) # 8000a5c8 <_ZL9threadEnd>
    data->buffer->put('!');
    80002704:	02100593          	li	a1,33
    80002708:	0084b503          	ld	a0,8(s1)
    8000270c:	00003097          	auipc	ra,0x3
    80002710:	c80080e7          	jalr	-896(ra) # 8000538c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80002714:	0104b503          	ld	a0,16(s1)
    80002718:	fffff097          	auipc	ra,0xfffff
    8000271c:	bd0080e7          	jalr	-1072(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80002720:	01813083          	ld	ra,24(sp)
    80002724:	01013403          	ld	s0,16(sp)
    80002728:	00813483          	ld	s1,8(sp)
    8000272c:	00013903          	ld	s2,0(sp)
    80002730:	02010113          	addi	sp,sp,32
    80002734:	00008067          	ret

0000000080002738 <_ZL8producerPv>:

static void producer(void *arg) {
    80002738:	fe010113          	addi	sp,sp,-32
    8000273c:	00113c23          	sd	ra,24(sp)
    80002740:	00813823          	sd	s0,16(sp)
    80002744:	00913423          	sd	s1,8(sp)
    80002748:	01213023          	sd	s2,0(sp)
    8000274c:	02010413          	addi	s0,sp,32
    80002750:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002754:	00000913          	li	s2,0
    80002758:	00c0006f          	j	80002764 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000275c:	fffff097          	auipc	ra,0xfffff
    80002760:	ae4080e7          	jalr	-1308(ra) # 80001240 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002764:	00008797          	auipc	a5,0x8
    80002768:	e647a783          	lw	a5,-412(a5) # 8000a5c8 <_ZL9threadEnd>
    8000276c:	02079e63          	bnez	a5,800027a8 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002770:	0004a583          	lw	a1,0(s1)
    80002774:	0305859b          	addiw	a1,a1,48
    80002778:	0084b503          	ld	a0,8(s1)
    8000277c:	00003097          	auipc	ra,0x3
    80002780:	c10080e7          	jalr	-1008(ra) # 8000538c <_ZN6Buffer3putEi>
        i++;
    80002784:	0019071b          	addiw	a4,s2,1
    80002788:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000278c:	0004a683          	lw	a3,0(s1)
    80002790:	0026979b          	slliw	a5,a3,0x2
    80002794:	00d787bb          	addw	a5,a5,a3
    80002798:	0017979b          	slliw	a5,a5,0x1
    8000279c:	02f767bb          	remw	a5,a4,a5
    800027a0:	fc0792e3          	bnez	a5,80002764 <_ZL8producerPv+0x2c>
    800027a4:	fb9ff06f          	j	8000275c <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    800027a8:	0104b503          	ld	a0,16(s1)
    800027ac:	fffff097          	auipc	ra,0xfffff
    800027b0:	b3c080e7          	jalr	-1220(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    800027b4:	01813083          	ld	ra,24(sp)
    800027b8:	01013403          	ld	s0,16(sp)
    800027bc:	00813483          	ld	s1,8(sp)
    800027c0:	00013903          	ld	s2,0(sp)
    800027c4:	02010113          	addi	sp,sp,32
    800027c8:	00008067          	ret

00000000800027cc <_ZL8consumerPv>:

static void consumer(void *arg) {
    800027cc:	fd010113          	addi	sp,sp,-48
    800027d0:	02113423          	sd	ra,40(sp)
    800027d4:	02813023          	sd	s0,32(sp)
    800027d8:	00913c23          	sd	s1,24(sp)
    800027dc:	01213823          	sd	s2,16(sp)
    800027e0:	01313423          	sd	s3,8(sp)
    800027e4:	03010413          	addi	s0,sp,48
    800027e8:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800027ec:	00000993          	li	s3,0
    800027f0:	01c0006f          	j	8000280c <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800027f4:	fffff097          	auipc	ra,0xfffff
    800027f8:	a4c080e7          	jalr	-1460(ra) # 80001240 <_Z15thread_dispatchv>
    800027fc:	0500006f          	j	8000284c <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002800:	00a00513          	li	a0,10
    80002804:	fffff097          	auipc	ra,0xfffff
    80002808:	b3c080e7          	jalr	-1220(ra) # 80001340 <_Z4putcc>
    while (!threadEnd) {
    8000280c:	00008797          	auipc	a5,0x8
    80002810:	dbc7a783          	lw	a5,-580(a5) # 8000a5c8 <_ZL9threadEnd>
    80002814:	06079063          	bnez	a5,80002874 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002818:	00893503          	ld	a0,8(s2)
    8000281c:	00003097          	auipc	ra,0x3
    80002820:	c00080e7          	jalr	-1024(ra) # 8000541c <_ZN6Buffer3getEv>
        i++;
    80002824:	0019849b          	addiw	s1,s3,1
    80002828:	0004899b          	sext.w	s3,s1
        putc(key);
    8000282c:	0ff57513          	andi	a0,a0,255
    80002830:	fffff097          	auipc	ra,0xfffff
    80002834:	b10080e7          	jalr	-1264(ra) # 80001340 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002838:	00092703          	lw	a4,0(s2)
    8000283c:	0027179b          	slliw	a5,a4,0x2
    80002840:	00e787bb          	addw	a5,a5,a4
    80002844:	02f4e7bb          	remw	a5,s1,a5
    80002848:	fa0786e3          	beqz	a5,800027f4 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    8000284c:	05000793          	li	a5,80
    80002850:	02f4e4bb          	remw	s1,s1,a5
    80002854:	fa049ce3          	bnez	s1,8000280c <_ZL8consumerPv+0x40>
    80002858:	fa9ff06f          	j	80002800 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    8000285c:	00893503          	ld	a0,8(s2)
    80002860:	00003097          	auipc	ra,0x3
    80002864:	bbc080e7          	jalr	-1092(ra) # 8000541c <_ZN6Buffer3getEv>
        putc(key);
    80002868:	0ff57513          	andi	a0,a0,255
    8000286c:	fffff097          	auipc	ra,0xfffff
    80002870:	ad4080e7          	jalr	-1324(ra) # 80001340 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002874:	00893503          	ld	a0,8(s2)
    80002878:	00003097          	auipc	ra,0x3
    8000287c:	c30080e7          	jalr	-976(ra) # 800054a8 <_ZN6Buffer6getCntEv>
    80002880:	fca04ee3          	bgtz	a0,8000285c <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002884:	01093503          	ld	a0,16(s2)
    80002888:	fffff097          	auipc	ra,0xfffff
    8000288c:	a60080e7          	jalr	-1440(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80002890:	02813083          	ld	ra,40(sp)
    80002894:	02013403          	ld	s0,32(sp)
    80002898:	01813483          	ld	s1,24(sp)
    8000289c:	01013903          	ld	s2,16(sp)
    800028a0:	00813983          	ld	s3,8(sp)
    800028a4:	03010113          	addi	sp,sp,48
    800028a8:	00008067          	ret

00000000800028ac <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    800028ac:	f9010113          	addi	sp,sp,-112
    800028b0:	06113423          	sd	ra,104(sp)
    800028b4:	06813023          	sd	s0,96(sp)
    800028b8:	04913c23          	sd	s1,88(sp)
    800028bc:	05213823          	sd	s2,80(sp)
    800028c0:	05313423          	sd	s3,72(sp)
    800028c4:	05413023          	sd	s4,64(sp)
    800028c8:	03513c23          	sd	s5,56(sp)
    800028cc:	03613823          	sd	s6,48(sp)
    800028d0:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800028d4:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800028d8:	00006517          	auipc	a0,0x6
    800028dc:	af850513          	addi	a0,a0,-1288 # 800083d0 <CONSOLE_STATUS+0x3c0>
    800028e0:	00002097          	auipc	ra,0x2
    800028e4:	d60080e7          	jalr	-672(ra) # 80004640 <_Z11printStringPKc>
    getString(input, 30);
    800028e8:	01e00593          	li	a1,30
    800028ec:	fa040493          	addi	s1,s0,-96
    800028f0:	00048513          	mv	a0,s1
    800028f4:	00002097          	auipc	ra,0x2
    800028f8:	dd4080e7          	jalr	-556(ra) # 800046c8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800028fc:	00048513          	mv	a0,s1
    80002900:	00002097          	auipc	ra,0x2
    80002904:	ea0080e7          	jalr	-352(ra) # 800047a0 <_Z11stringToIntPKc>
    80002908:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    8000290c:	00006517          	auipc	a0,0x6
    80002910:	ae450513          	addi	a0,a0,-1308 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80002914:	00002097          	auipc	ra,0x2
    80002918:	d2c080e7          	jalr	-724(ra) # 80004640 <_Z11printStringPKc>
    getString(input, 30);
    8000291c:	01e00593          	li	a1,30
    80002920:	00048513          	mv	a0,s1
    80002924:	00002097          	auipc	ra,0x2
    80002928:	da4080e7          	jalr	-604(ra) # 800046c8 <_Z9getStringPci>
    n = stringToInt(input);
    8000292c:	00048513          	mv	a0,s1
    80002930:	00002097          	auipc	ra,0x2
    80002934:	e70080e7          	jalr	-400(ra) # 800047a0 <_Z11stringToIntPKc>
    80002938:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    8000293c:	00006517          	auipc	a0,0x6
    80002940:	ad450513          	addi	a0,a0,-1324 # 80008410 <CONSOLE_STATUS+0x400>
    80002944:	00002097          	auipc	ra,0x2
    80002948:	cfc080e7          	jalr	-772(ra) # 80004640 <_Z11printStringPKc>
    8000294c:	00000613          	li	a2,0
    80002950:	00a00593          	li	a1,10
    80002954:	00090513          	mv	a0,s2
    80002958:	00002097          	auipc	ra,0x2
    8000295c:	e98080e7          	jalr	-360(ra) # 800047f0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002960:	00006517          	auipc	a0,0x6
    80002964:	ac850513          	addi	a0,a0,-1336 # 80008428 <CONSOLE_STATUS+0x418>
    80002968:	00002097          	auipc	ra,0x2
    8000296c:	cd8080e7          	jalr	-808(ra) # 80004640 <_Z11printStringPKc>
    80002970:	00000613          	li	a2,0
    80002974:	00a00593          	li	a1,10
    80002978:	00048513          	mv	a0,s1
    8000297c:	00002097          	auipc	ra,0x2
    80002980:	e74080e7          	jalr	-396(ra) # 800047f0 <_Z8printIntiii>
    printString(".\n");
    80002984:	00006517          	auipc	a0,0x6
    80002988:	abc50513          	addi	a0,a0,-1348 # 80008440 <CONSOLE_STATUS+0x430>
    8000298c:	00002097          	auipc	ra,0x2
    80002990:	cb4080e7          	jalr	-844(ra) # 80004640 <_Z11printStringPKc>
    if(threadNum > n) {
    80002994:	0324c463          	blt	s1,s2,800029bc <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80002998:	03205c63          	blez	s2,800029d0 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    8000299c:	03800513          	li	a0,56
    800029a0:	fffff097          	auipc	ra,0xfffff
    800029a4:	ff8080e7          	jalr	-8(ra) # 80001998 <_Znwm>
    800029a8:	00050a13          	mv	s4,a0
    800029ac:	00048593          	mv	a1,s1
    800029b0:	00003097          	auipc	ra,0x3
    800029b4:	940080e7          	jalr	-1728(ra) # 800052f0 <_ZN6BufferC1Ei>
    800029b8:	0300006f          	j	800029e8 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800029bc:	00006517          	auipc	a0,0x6
    800029c0:	a8c50513          	addi	a0,a0,-1396 # 80008448 <CONSOLE_STATUS+0x438>
    800029c4:	00002097          	auipc	ra,0x2
    800029c8:	c7c080e7          	jalr	-900(ra) # 80004640 <_Z11printStringPKc>
        return;
    800029cc:	0140006f          	j	800029e0 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800029d0:	00006517          	auipc	a0,0x6
    800029d4:	ab850513          	addi	a0,a0,-1352 # 80008488 <CONSOLE_STATUS+0x478>
    800029d8:	00002097          	auipc	ra,0x2
    800029dc:	c68080e7          	jalr	-920(ra) # 80004640 <_Z11printStringPKc>
        return;
    800029e0:	000b0113          	mv	sp,s6
    800029e4:	1500006f          	j	80002b34 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800029e8:	00000593          	li	a1,0
    800029ec:	00008517          	auipc	a0,0x8
    800029f0:	be450513          	addi	a0,a0,-1052 # 8000a5d0 <_ZL10waitForAll>
    800029f4:	fffff097          	auipc	ra,0xfffff
    800029f8:	870080e7          	jalr	-1936(ra) # 80001264 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800029fc:	00391793          	slli	a5,s2,0x3
    80002a00:	00f78793          	addi	a5,a5,15
    80002a04:	ff07f793          	andi	a5,a5,-16
    80002a08:	40f10133          	sub	sp,sp,a5
    80002a0c:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002a10:	0019071b          	addiw	a4,s2,1
    80002a14:	00171793          	slli	a5,a4,0x1
    80002a18:	00e787b3          	add	a5,a5,a4
    80002a1c:	00379793          	slli	a5,a5,0x3
    80002a20:	00f78793          	addi	a5,a5,15
    80002a24:	ff07f793          	andi	a5,a5,-16
    80002a28:	40f10133          	sub	sp,sp,a5
    80002a2c:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002a30:	00191613          	slli	a2,s2,0x1
    80002a34:	012607b3          	add	a5,a2,s2
    80002a38:	00379793          	slli	a5,a5,0x3
    80002a3c:	00f987b3          	add	a5,s3,a5
    80002a40:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002a44:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002a48:	00008717          	auipc	a4,0x8
    80002a4c:	b8873703          	ld	a4,-1144(a4) # 8000a5d0 <_ZL10waitForAll>
    80002a50:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002a54:	00078613          	mv	a2,a5
    80002a58:	00000597          	auipc	a1,0x0
    80002a5c:	d7458593          	addi	a1,a1,-652 # 800027cc <_ZL8consumerPv>
    80002a60:	f9840513          	addi	a0,s0,-104
    80002a64:	ffffe097          	auipc	ra,0xffffe
    80002a68:	784080e7          	jalr	1924(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002a6c:	00000493          	li	s1,0
    80002a70:	0280006f          	j	80002a98 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002a74:	00000597          	auipc	a1,0x0
    80002a78:	c1458593          	addi	a1,a1,-1004 # 80002688 <_ZL16producerKeyboardPv>
                      data + i);
    80002a7c:	00179613          	slli	a2,a5,0x1
    80002a80:	00f60633          	add	a2,a2,a5
    80002a84:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80002a88:	00c98633          	add	a2,s3,a2
    80002a8c:	ffffe097          	auipc	ra,0xffffe
    80002a90:	75c080e7          	jalr	1884(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002a94:	0014849b          	addiw	s1,s1,1
    80002a98:	0524d263          	bge	s1,s2,80002adc <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002a9c:	00149793          	slli	a5,s1,0x1
    80002aa0:	009787b3          	add	a5,a5,s1
    80002aa4:	00379793          	slli	a5,a5,0x3
    80002aa8:	00f987b3          	add	a5,s3,a5
    80002aac:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002ab0:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002ab4:	00008717          	auipc	a4,0x8
    80002ab8:	b1c73703          	ld	a4,-1252(a4) # 8000a5d0 <_ZL10waitForAll>
    80002abc:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002ac0:	00048793          	mv	a5,s1
    80002ac4:	00349513          	slli	a0,s1,0x3
    80002ac8:	00aa8533          	add	a0,s5,a0
    80002acc:	fa9054e3          	blez	s1,80002a74 <_Z22producerConsumer_C_APIv+0x1c8>
    80002ad0:	00000597          	auipc	a1,0x0
    80002ad4:	c6858593          	addi	a1,a1,-920 # 80002738 <_ZL8producerPv>
    80002ad8:	fa5ff06f          	j	80002a7c <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002adc:	ffffe097          	auipc	ra,0xffffe
    80002ae0:	764080e7          	jalr	1892(ra) # 80001240 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002ae4:	00000493          	li	s1,0
    80002ae8:	00994e63          	blt	s2,s1,80002b04 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002aec:	00008517          	auipc	a0,0x8
    80002af0:	ae453503          	ld	a0,-1308(a0) # 8000a5d0 <_ZL10waitForAll>
    80002af4:	ffffe097          	auipc	ra,0xffffe
    80002af8:	7c8080e7          	jalr	1992(ra) # 800012bc <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    80002afc:	0014849b          	addiw	s1,s1,1
    80002b00:	fe9ff06f          	j	80002ae8 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80002b04:	00008517          	auipc	a0,0x8
    80002b08:	acc53503          	ld	a0,-1332(a0) # 8000a5d0 <_ZL10waitForAll>
    80002b0c:	ffffe097          	auipc	ra,0xffffe
    80002b10:	784080e7          	jalr	1924(ra) # 80001290 <_Z9sem_closeP4_sem>
    delete buffer;
    80002b14:	000a0e63          	beqz	s4,80002b30 <_Z22producerConsumer_C_APIv+0x284>
    80002b18:	000a0513          	mv	a0,s4
    80002b1c:	00003097          	auipc	ra,0x3
    80002b20:	a14080e7          	jalr	-1516(ra) # 80005530 <_ZN6BufferD1Ev>
    80002b24:	000a0513          	mv	a0,s4
    80002b28:	fffff097          	auipc	ra,0xfffff
    80002b2c:	ec0080e7          	jalr	-320(ra) # 800019e8 <_ZdlPv>
    80002b30:	000b0113          	mv	sp,s6

}
    80002b34:	f9040113          	addi	sp,s0,-112
    80002b38:	06813083          	ld	ra,104(sp)
    80002b3c:	06013403          	ld	s0,96(sp)
    80002b40:	05813483          	ld	s1,88(sp)
    80002b44:	05013903          	ld	s2,80(sp)
    80002b48:	04813983          	ld	s3,72(sp)
    80002b4c:	04013a03          	ld	s4,64(sp)
    80002b50:	03813a83          	ld	s5,56(sp)
    80002b54:	03013b03          	ld	s6,48(sp)
    80002b58:	07010113          	addi	sp,sp,112
    80002b5c:	00008067          	ret
    80002b60:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002b64:	000a0513          	mv	a0,s4
    80002b68:	fffff097          	auipc	ra,0xfffff
    80002b6c:	e80080e7          	jalr	-384(ra) # 800019e8 <_ZdlPv>
    80002b70:	00048513          	mv	a0,s1
    80002b74:	00009097          	auipc	ra,0x9
    80002b78:	b54080e7          	jalr	-1196(ra) # 8000b6c8 <_Unwind_Resume>

0000000080002b7c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002b7c:	fe010113          	addi	sp,sp,-32
    80002b80:	00113c23          	sd	ra,24(sp)
    80002b84:	00813823          	sd	s0,16(sp)
    80002b88:	00913423          	sd	s1,8(sp)
    80002b8c:	01213023          	sd	s2,0(sp)
    80002b90:	02010413          	addi	s0,sp,32
    80002b94:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002b98:	00100793          	li	a5,1
    80002b9c:	02a7f863          	bgeu	a5,a0,80002bcc <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002ba0:	00a00793          	li	a5,10
    80002ba4:	02f577b3          	remu	a5,a0,a5
    80002ba8:	02078e63          	beqz	a5,80002be4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002bac:	fff48513          	addi	a0,s1,-1
    80002bb0:	00000097          	auipc	ra,0x0
    80002bb4:	fcc080e7          	jalr	-52(ra) # 80002b7c <_ZL9fibonaccim>
    80002bb8:	00050913          	mv	s2,a0
    80002bbc:	ffe48513          	addi	a0,s1,-2
    80002bc0:	00000097          	auipc	ra,0x0
    80002bc4:	fbc080e7          	jalr	-68(ra) # 80002b7c <_ZL9fibonaccim>
    80002bc8:	00a90533          	add	a0,s2,a0
}
    80002bcc:	01813083          	ld	ra,24(sp)
    80002bd0:	01013403          	ld	s0,16(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	00013903          	ld	s2,0(sp)
    80002bdc:	02010113          	addi	sp,sp,32
    80002be0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002be4:	ffffe097          	auipc	ra,0xffffe
    80002be8:	65c080e7          	jalr	1628(ra) # 80001240 <_Z15thread_dispatchv>
    80002bec:	fc1ff06f          	j	80002bac <_ZL9fibonaccim+0x30>

0000000080002bf0 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002bf0:	fe010113          	addi	sp,sp,-32
    80002bf4:	00113c23          	sd	ra,24(sp)
    80002bf8:	00813823          	sd	s0,16(sp)
    80002bfc:	00913423          	sd	s1,8(sp)
    80002c00:	01213023          	sd	s2,0(sp)
    80002c04:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002c08:	00000913          	li	s2,0
    80002c0c:	0380006f          	j	80002c44 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002c10:	ffffe097          	auipc	ra,0xffffe
    80002c14:	630080e7          	jalr	1584(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002c18:	00148493          	addi	s1,s1,1
    80002c1c:	000027b7          	lui	a5,0x2
    80002c20:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002c24:	0097ee63          	bltu	a5,s1,80002c40 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002c28:	00000713          	li	a4,0
    80002c2c:	000077b7          	lui	a5,0x7
    80002c30:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002c34:	fce7eee3          	bltu	a5,a4,80002c10 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80002c38:	00170713          	addi	a4,a4,1
    80002c3c:	ff1ff06f          	j	80002c2c <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002c40:	00190913          	addi	s2,s2,1
    80002c44:	00900793          	li	a5,9
    80002c48:	0527e063          	bltu	a5,s2,80002c88 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002c4c:	00006517          	auipc	a0,0x6
    80002c50:	86c50513          	addi	a0,a0,-1940 # 800084b8 <CONSOLE_STATUS+0x4a8>
    80002c54:	00002097          	auipc	ra,0x2
    80002c58:	9ec080e7          	jalr	-1556(ra) # 80004640 <_Z11printStringPKc>
    80002c5c:	00000613          	li	a2,0
    80002c60:	00a00593          	li	a1,10
    80002c64:	0009051b          	sext.w	a0,s2
    80002c68:	00002097          	auipc	ra,0x2
    80002c6c:	b88080e7          	jalr	-1144(ra) # 800047f0 <_Z8printIntiii>
    80002c70:	00006517          	auipc	a0,0x6
    80002c74:	96050513          	addi	a0,a0,-1696 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002c78:	00002097          	auipc	ra,0x2
    80002c7c:	9c8080e7          	jalr	-1592(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002c80:	00000493          	li	s1,0
    80002c84:	f99ff06f          	j	80002c1c <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002c88:	00006517          	auipc	a0,0x6
    80002c8c:	83850513          	addi	a0,a0,-1992 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80002c90:	00002097          	auipc	ra,0x2
    80002c94:	9b0080e7          	jalr	-1616(ra) # 80004640 <_Z11printStringPKc>
    finishedA = true;
    80002c98:	00100793          	li	a5,1
    80002c9c:	00008717          	auipc	a4,0x8
    80002ca0:	92f70e23          	sb	a5,-1732(a4) # 8000a5d8 <_ZL9finishedA>
}
    80002ca4:	01813083          	ld	ra,24(sp)
    80002ca8:	01013403          	ld	s0,16(sp)
    80002cac:	00813483          	ld	s1,8(sp)
    80002cb0:	00013903          	ld	s2,0(sp)
    80002cb4:	02010113          	addi	sp,sp,32
    80002cb8:	00008067          	ret

0000000080002cbc <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002cbc:	fe010113          	addi	sp,sp,-32
    80002cc0:	00113c23          	sd	ra,24(sp)
    80002cc4:	00813823          	sd	s0,16(sp)
    80002cc8:	00913423          	sd	s1,8(sp)
    80002ccc:	01213023          	sd	s2,0(sp)
    80002cd0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002cd4:	00000913          	li	s2,0
    80002cd8:	0380006f          	j	80002d10 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002cdc:	ffffe097          	auipc	ra,0xffffe
    80002ce0:	564080e7          	jalr	1380(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002ce4:	00148493          	addi	s1,s1,1
    80002ce8:	000027b7          	lui	a5,0x2
    80002cec:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002cf0:	0097ee63          	bltu	a5,s1,80002d0c <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002cf4:	00000713          	li	a4,0
    80002cf8:	000077b7          	lui	a5,0x7
    80002cfc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002d00:	fce7eee3          	bltu	a5,a4,80002cdc <_ZN7WorkerB11workerBodyBEPv+0x20>
    80002d04:	00170713          	addi	a4,a4,1
    80002d08:	ff1ff06f          	j	80002cf8 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002d0c:	00190913          	addi	s2,s2,1
    80002d10:	00f00793          	li	a5,15
    80002d14:	0527e063          	bltu	a5,s2,80002d54 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002d18:	00005517          	auipc	a0,0x5
    80002d1c:	7b850513          	addi	a0,a0,1976 # 800084d0 <CONSOLE_STATUS+0x4c0>
    80002d20:	00002097          	auipc	ra,0x2
    80002d24:	920080e7          	jalr	-1760(ra) # 80004640 <_Z11printStringPKc>
    80002d28:	00000613          	li	a2,0
    80002d2c:	00a00593          	li	a1,10
    80002d30:	0009051b          	sext.w	a0,s2
    80002d34:	00002097          	auipc	ra,0x2
    80002d38:	abc080e7          	jalr	-1348(ra) # 800047f0 <_Z8printIntiii>
    80002d3c:	00006517          	auipc	a0,0x6
    80002d40:	89450513          	addi	a0,a0,-1900 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002d44:	00002097          	auipc	ra,0x2
    80002d48:	8fc080e7          	jalr	-1796(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002d4c:	00000493          	li	s1,0
    80002d50:	f99ff06f          	j	80002ce8 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80002d54:	00005517          	auipc	a0,0x5
    80002d58:	78450513          	addi	a0,a0,1924 # 800084d8 <CONSOLE_STATUS+0x4c8>
    80002d5c:	00002097          	auipc	ra,0x2
    80002d60:	8e4080e7          	jalr	-1820(ra) # 80004640 <_Z11printStringPKc>
    finishedB = true;
    80002d64:	00100793          	li	a5,1
    80002d68:	00008717          	auipc	a4,0x8
    80002d6c:	86f708a3          	sb	a5,-1935(a4) # 8000a5d9 <_ZL9finishedB>
    thread_dispatch();
    80002d70:	ffffe097          	auipc	ra,0xffffe
    80002d74:	4d0080e7          	jalr	1232(ra) # 80001240 <_Z15thread_dispatchv>
}
    80002d78:	01813083          	ld	ra,24(sp)
    80002d7c:	01013403          	ld	s0,16(sp)
    80002d80:	00813483          	ld	s1,8(sp)
    80002d84:	00013903          	ld	s2,0(sp)
    80002d88:	02010113          	addi	sp,sp,32
    80002d8c:	00008067          	ret

0000000080002d90 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002d90:	fe010113          	addi	sp,sp,-32
    80002d94:	00113c23          	sd	ra,24(sp)
    80002d98:	00813823          	sd	s0,16(sp)
    80002d9c:	00913423          	sd	s1,8(sp)
    80002da0:	01213023          	sd	s2,0(sp)
    80002da4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002da8:	00000493          	li	s1,0
    80002dac:	0400006f          	j	80002dec <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002db0:	00005517          	auipc	a0,0x5
    80002db4:	73850513          	addi	a0,a0,1848 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80002db8:	00002097          	auipc	ra,0x2
    80002dbc:	888080e7          	jalr	-1912(ra) # 80004640 <_Z11printStringPKc>
    80002dc0:	00000613          	li	a2,0
    80002dc4:	00a00593          	li	a1,10
    80002dc8:	00048513          	mv	a0,s1
    80002dcc:	00002097          	auipc	ra,0x2
    80002dd0:	a24080e7          	jalr	-1500(ra) # 800047f0 <_Z8printIntiii>
    80002dd4:	00005517          	auipc	a0,0x5
    80002dd8:	7fc50513          	addi	a0,a0,2044 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002ddc:	00002097          	auipc	ra,0x2
    80002de0:	864080e7          	jalr	-1948(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002de4:	0014849b          	addiw	s1,s1,1
    80002de8:	0ff4f493          	andi	s1,s1,255
    80002dec:	00200793          	li	a5,2
    80002df0:	fc97f0e3          	bgeu	a5,s1,80002db0 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002df4:	00005517          	auipc	a0,0x5
    80002df8:	6fc50513          	addi	a0,a0,1788 # 800084f0 <CONSOLE_STATUS+0x4e0>
    80002dfc:	00002097          	auipc	ra,0x2
    80002e00:	844080e7          	jalr	-1980(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002e04:	00700313          	li	t1,7
    thread_dispatch();
    80002e08:	ffffe097          	auipc	ra,0xffffe
    80002e0c:	438080e7          	jalr	1080(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002e10:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80002e14:	00005517          	auipc	a0,0x5
    80002e18:	6ec50513          	addi	a0,a0,1772 # 80008500 <CONSOLE_STATUS+0x4f0>
    80002e1c:	00002097          	auipc	ra,0x2
    80002e20:	824080e7          	jalr	-2012(ra) # 80004640 <_Z11printStringPKc>
    80002e24:	00000613          	li	a2,0
    80002e28:	00a00593          	li	a1,10
    80002e2c:	0009051b          	sext.w	a0,s2
    80002e30:	00002097          	auipc	ra,0x2
    80002e34:	9c0080e7          	jalr	-1600(ra) # 800047f0 <_Z8printIntiii>
    80002e38:	00005517          	auipc	a0,0x5
    80002e3c:	79850513          	addi	a0,a0,1944 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002e40:	00002097          	auipc	ra,0x2
    80002e44:	800080e7          	jalr	-2048(ra) # 80004640 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002e48:	00c00513          	li	a0,12
    80002e4c:	00000097          	auipc	ra,0x0
    80002e50:	d30080e7          	jalr	-720(ra) # 80002b7c <_ZL9fibonaccim>
    80002e54:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002e58:	00005517          	auipc	a0,0x5
    80002e5c:	6b050513          	addi	a0,a0,1712 # 80008508 <CONSOLE_STATUS+0x4f8>
    80002e60:	00001097          	auipc	ra,0x1
    80002e64:	7e0080e7          	jalr	2016(ra) # 80004640 <_Z11printStringPKc>
    80002e68:	00000613          	li	a2,0
    80002e6c:	00a00593          	li	a1,10
    80002e70:	0009051b          	sext.w	a0,s2
    80002e74:	00002097          	auipc	ra,0x2
    80002e78:	97c080e7          	jalr	-1668(ra) # 800047f0 <_Z8printIntiii>
    80002e7c:	00005517          	auipc	a0,0x5
    80002e80:	75450513          	addi	a0,a0,1876 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002e84:	00001097          	auipc	ra,0x1
    80002e88:	7bc080e7          	jalr	1980(ra) # 80004640 <_Z11printStringPKc>
    80002e8c:	0400006f          	j	80002ecc <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002e90:	00005517          	auipc	a0,0x5
    80002e94:	65850513          	addi	a0,a0,1624 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80002e98:	00001097          	auipc	ra,0x1
    80002e9c:	7a8080e7          	jalr	1960(ra) # 80004640 <_Z11printStringPKc>
    80002ea0:	00000613          	li	a2,0
    80002ea4:	00a00593          	li	a1,10
    80002ea8:	00048513          	mv	a0,s1
    80002eac:	00002097          	auipc	ra,0x2
    80002eb0:	944080e7          	jalr	-1724(ra) # 800047f0 <_Z8printIntiii>
    80002eb4:	00005517          	auipc	a0,0x5
    80002eb8:	71c50513          	addi	a0,a0,1820 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002ebc:	00001097          	auipc	ra,0x1
    80002ec0:	784080e7          	jalr	1924(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002ec4:	0014849b          	addiw	s1,s1,1
    80002ec8:	0ff4f493          	andi	s1,s1,255
    80002ecc:	00500793          	li	a5,5
    80002ed0:	fc97f0e3          	bgeu	a5,s1,80002e90 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002ed4:	00005517          	auipc	a0,0x5
    80002ed8:	5ec50513          	addi	a0,a0,1516 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80002edc:	00001097          	auipc	ra,0x1
    80002ee0:	764080e7          	jalr	1892(ra) # 80004640 <_Z11printStringPKc>
    finishedC = true;
    80002ee4:	00100793          	li	a5,1
    80002ee8:	00007717          	auipc	a4,0x7
    80002eec:	6ef70923          	sb	a5,1778(a4) # 8000a5da <_ZL9finishedC>
    thread_dispatch();
    80002ef0:	ffffe097          	auipc	ra,0xffffe
    80002ef4:	350080e7          	jalr	848(ra) # 80001240 <_Z15thread_dispatchv>
}
    80002ef8:	01813083          	ld	ra,24(sp)
    80002efc:	01013403          	ld	s0,16(sp)
    80002f00:	00813483          	ld	s1,8(sp)
    80002f04:	00013903          	ld	s2,0(sp)
    80002f08:	02010113          	addi	sp,sp,32
    80002f0c:	00008067          	ret

0000000080002f10 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002f10:	fe010113          	addi	sp,sp,-32
    80002f14:	00113c23          	sd	ra,24(sp)
    80002f18:	00813823          	sd	s0,16(sp)
    80002f1c:	00913423          	sd	s1,8(sp)
    80002f20:	01213023          	sd	s2,0(sp)
    80002f24:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002f28:	00a00493          	li	s1,10
    80002f2c:	0400006f          	j	80002f6c <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002f30:	00005517          	auipc	a0,0x5
    80002f34:	5e850513          	addi	a0,a0,1512 # 80008518 <CONSOLE_STATUS+0x508>
    80002f38:	00001097          	auipc	ra,0x1
    80002f3c:	708080e7          	jalr	1800(ra) # 80004640 <_Z11printStringPKc>
    80002f40:	00000613          	li	a2,0
    80002f44:	00a00593          	li	a1,10
    80002f48:	00048513          	mv	a0,s1
    80002f4c:	00002097          	auipc	ra,0x2
    80002f50:	8a4080e7          	jalr	-1884(ra) # 800047f0 <_Z8printIntiii>
    80002f54:	00005517          	auipc	a0,0x5
    80002f58:	67c50513          	addi	a0,a0,1660 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002f5c:	00001097          	auipc	ra,0x1
    80002f60:	6e4080e7          	jalr	1764(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002f64:	0014849b          	addiw	s1,s1,1
    80002f68:	0ff4f493          	andi	s1,s1,255
    80002f6c:	00c00793          	li	a5,12
    80002f70:	fc97f0e3          	bgeu	a5,s1,80002f30 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002f74:	00005517          	auipc	a0,0x5
    80002f78:	5ac50513          	addi	a0,a0,1452 # 80008520 <CONSOLE_STATUS+0x510>
    80002f7c:	00001097          	auipc	ra,0x1
    80002f80:	6c4080e7          	jalr	1732(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002f84:	00500313          	li	t1,5
    thread_dispatch();
    80002f88:	ffffe097          	auipc	ra,0xffffe
    80002f8c:	2b8080e7          	jalr	696(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002f90:	01000513          	li	a0,16
    80002f94:	00000097          	auipc	ra,0x0
    80002f98:	be8080e7          	jalr	-1048(ra) # 80002b7c <_ZL9fibonaccim>
    80002f9c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002fa0:	00005517          	auipc	a0,0x5
    80002fa4:	59050513          	addi	a0,a0,1424 # 80008530 <CONSOLE_STATUS+0x520>
    80002fa8:	00001097          	auipc	ra,0x1
    80002fac:	698080e7          	jalr	1688(ra) # 80004640 <_Z11printStringPKc>
    80002fb0:	00000613          	li	a2,0
    80002fb4:	00a00593          	li	a1,10
    80002fb8:	0009051b          	sext.w	a0,s2
    80002fbc:	00002097          	auipc	ra,0x2
    80002fc0:	834080e7          	jalr	-1996(ra) # 800047f0 <_Z8printIntiii>
    80002fc4:	00005517          	auipc	a0,0x5
    80002fc8:	60c50513          	addi	a0,a0,1548 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80002fcc:	00001097          	auipc	ra,0x1
    80002fd0:	674080e7          	jalr	1652(ra) # 80004640 <_Z11printStringPKc>
    80002fd4:	0400006f          	j	80003014 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002fd8:	00005517          	auipc	a0,0x5
    80002fdc:	54050513          	addi	a0,a0,1344 # 80008518 <CONSOLE_STATUS+0x508>
    80002fe0:	00001097          	auipc	ra,0x1
    80002fe4:	660080e7          	jalr	1632(ra) # 80004640 <_Z11printStringPKc>
    80002fe8:	00000613          	li	a2,0
    80002fec:	00a00593          	li	a1,10
    80002ff0:	00048513          	mv	a0,s1
    80002ff4:	00001097          	auipc	ra,0x1
    80002ff8:	7fc080e7          	jalr	2044(ra) # 800047f0 <_Z8printIntiii>
    80002ffc:	00005517          	auipc	a0,0x5
    80003000:	5d450513          	addi	a0,a0,1492 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003004:	00001097          	auipc	ra,0x1
    80003008:	63c080e7          	jalr	1596(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000300c:	0014849b          	addiw	s1,s1,1
    80003010:	0ff4f493          	andi	s1,s1,255
    80003014:	00f00793          	li	a5,15
    80003018:	fc97f0e3          	bgeu	a5,s1,80002fd8 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    8000301c:	00005517          	auipc	a0,0x5
    80003020:	52450513          	addi	a0,a0,1316 # 80008540 <CONSOLE_STATUS+0x530>
    80003024:	00001097          	auipc	ra,0x1
    80003028:	61c080e7          	jalr	1564(ra) # 80004640 <_Z11printStringPKc>
    finishedD = true;
    8000302c:	00100793          	li	a5,1
    80003030:	00007717          	auipc	a4,0x7
    80003034:	5af705a3          	sb	a5,1451(a4) # 8000a5db <_ZL9finishedD>
    thread_dispatch();
    80003038:	ffffe097          	auipc	ra,0xffffe
    8000303c:	208080e7          	jalr	520(ra) # 80001240 <_Z15thread_dispatchv>
}
    80003040:	01813083          	ld	ra,24(sp)
    80003044:	01013403          	ld	s0,16(sp)
    80003048:	00813483          	ld	s1,8(sp)
    8000304c:	00013903          	ld	s2,0(sp)
    80003050:	02010113          	addi	sp,sp,32
    80003054:	00008067          	ret

0000000080003058 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80003058:	fc010113          	addi	sp,sp,-64
    8000305c:	02113c23          	sd	ra,56(sp)
    80003060:	02813823          	sd	s0,48(sp)
    80003064:	02913423          	sd	s1,40(sp)
    80003068:	03213023          	sd	s2,32(sp)
    8000306c:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80003070:	02000513          	li	a0,32
    80003074:	fffff097          	auipc	ra,0xfffff
    80003078:	924080e7          	jalr	-1756(ra) # 80001998 <_Znwm>
    8000307c:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80003080:	fffff097          	auipc	ra,0xfffff
    80003084:	b9c080e7          	jalr	-1124(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80003088:	00007797          	auipc	a5,0x7
    8000308c:	31878793          	addi	a5,a5,792 # 8000a3a0 <_ZTV7WorkerA+0x10>
    80003090:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80003094:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80003098:	00005517          	auipc	a0,0x5
    8000309c:	4b850513          	addi	a0,a0,1208 # 80008550 <CONSOLE_STATUS+0x540>
    800030a0:	00001097          	auipc	ra,0x1
    800030a4:	5a0080e7          	jalr	1440(ra) # 80004640 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800030a8:	02000513          	li	a0,32
    800030ac:	fffff097          	auipc	ra,0xfffff
    800030b0:	8ec080e7          	jalr	-1812(ra) # 80001998 <_Znwm>
    800030b4:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    800030b8:	fffff097          	auipc	ra,0xfffff
    800030bc:	b64080e7          	jalr	-1180(ra) # 80001c1c <_ZN6ThreadC1Ev>
    800030c0:	00007797          	auipc	a5,0x7
    800030c4:	30878793          	addi	a5,a5,776 # 8000a3c8 <_ZTV7WorkerB+0x10>
    800030c8:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    800030cc:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    800030d0:	00005517          	auipc	a0,0x5
    800030d4:	49850513          	addi	a0,a0,1176 # 80008568 <CONSOLE_STATUS+0x558>
    800030d8:	00001097          	auipc	ra,0x1
    800030dc:	568080e7          	jalr	1384(ra) # 80004640 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    800030e0:	02000513          	li	a0,32
    800030e4:	fffff097          	auipc	ra,0xfffff
    800030e8:	8b4080e7          	jalr	-1868(ra) # 80001998 <_Znwm>
    800030ec:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    800030f0:	fffff097          	auipc	ra,0xfffff
    800030f4:	b2c080e7          	jalr	-1236(ra) # 80001c1c <_ZN6ThreadC1Ev>
    800030f8:	00007797          	auipc	a5,0x7
    800030fc:	2f878793          	addi	a5,a5,760 # 8000a3f0 <_ZTV7WorkerC+0x10>
    80003100:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80003104:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80003108:	00005517          	auipc	a0,0x5
    8000310c:	47850513          	addi	a0,a0,1144 # 80008580 <CONSOLE_STATUS+0x570>
    80003110:	00001097          	auipc	ra,0x1
    80003114:	530080e7          	jalr	1328(ra) # 80004640 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80003118:	02000513          	li	a0,32
    8000311c:	fffff097          	auipc	ra,0xfffff
    80003120:	87c080e7          	jalr	-1924(ra) # 80001998 <_Znwm>
    80003124:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80003128:	fffff097          	auipc	ra,0xfffff
    8000312c:	af4080e7          	jalr	-1292(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80003130:	00007797          	auipc	a5,0x7
    80003134:	2e878793          	addi	a5,a5,744 # 8000a418 <_ZTV7WorkerD+0x10>
    80003138:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    8000313c:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80003140:	00005517          	auipc	a0,0x5
    80003144:	45850513          	addi	a0,a0,1112 # 80008598 <CONSOLE_STATUS+0x588>
    80003148:	00001097          	auipc	ra,0x1
    8000314c:	4f8080e7          	jalr	1272(ra) # 80004640 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80003150:	00000493          	li	s1,0
    80003154:	00300793          	li	a5,3
    80003158:	0297c663          	blt	a5,s1,80003184 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    8000315c:	00349793          	slli	a5,s1,0x3
    80003160:	fe040713          	addi	a4,s0,-32
    80003164:	00f707b3          	add	a5,a4,a5
    80003168:	fe07b503          	ld	a0,-32(a5)
    8000316c:	fffff097          	auipc	ra,0xfffff
    80003170:	a54080e7          	jalr	-1452(ra) # 80001bc0 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80003174:	0014849b          	addiw	s1,s1,1
    80003178:	fddff06f          	j	80003154 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    8000317c:	fffff097          	auipc	ra,0xfffff
    80003180:	a78080e7          	jalr	-1416(ra) # 80001bf4 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003184:	00007797          	auipc	a5,0x7
    80003188:	4547c783          	lbu	a5,1108(a5) # 8000a5d8 <_ZL9finishedA>
    8000318c:	fe0788e3          	beqz	a5,8000317c <_Z20Threads_CPP_API_testv+0x124>
    80003190:	00007797          	auipc	a5,0x7
    80003194:	4497c783          	lbu	a5,1097(a5) # 8000a5d9 <_ZL9finishedB>
    80003198:	fe0782e3          	beqz	a5,8000317c <_Z20Threads_CPP_API_testv+0x124>
    8000319c:	00007797          	auipc	a5,0x7
    800031a0:	43e7c783          	lbu	a5,1086(a5) # 8000a5da <_ZL9finishedC>
    800031a4:	fc078ce3          	beqz	a5,8000317c <_Z20Threads_CPP_API_testv+0x124>
    800031a8:	00007797          	auipc	a5,0x7
    800031ac:	4337c783          	lbu	a5,1075(a5) # 8000a5db <_ZL9finishedD>
    800031b0:	fc0786e3          	beqz	a5,8000317c <_Z20Threads_CPP_API_testv+0x124>
    800031b4:	fc040493          	addi	s1,s0,-64
    800031b8:	0080006f          	j	800031c0 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    800031bc:	00848493          	addi	s1,s1,8
    800031c0:	fe040793          	addi	a5,s0,-32
    800031c4:	08f48663          	beq	s1,a5,80003250 <_Z20Threads_CPP_API_testv+0x1f8>
    800031c8:	0004b503          	ld	a0,0(s1)
    800031cc:	fe0508e3          	beqz	a0,800031bc <_Z20Threads_CPP_API_testv+0x164>
    800031d0:	00053783          	ld	a5,0(a0)
    800031d4:	0087b783          	ld	a5,8(a5)
    800031d8:	000780e7          	jalr	a5
    800031dc:	fe1ff06f          	j	800031bc <_Z20Threads_CPP_API_testv+0x164>
    800031e0:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    800031e4:	00048513          	mv	a0,s1
    800031e8:	fffff097          	auipc	ra,0xfffff
    800031ec:	800080e7          	jalr	-2048(ra) # 800019e8 <_ZdlPv>
    800031f0:	00090513          	mv	a0,s2
    800031f4:	00008097          	auipc	ra,0x8
    800031f8:	4d4080e7          	jalr	1236(ra) # 8000b6c8 <_Unwind_Resume>
    800031fc:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80003200:	00048513          	mv	a0,s1
    80003204:	ffffe097          	auipc	ra,0xffffe
    80003208:	7e4080e7          	jalr	2020(ra) # 800019e8 <_ZdlPv>
    8000320c:	00090513          	mv	a0,s2
    80003210:	00008097          	auipc	ra,0x8
    80003214:	4b8080e7          	jalr	1208(ra) # 8000b6c8 <_Unwind_Resume>
    80003218:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    8000321c:	00048513          	mv	a0,s1
    80003220:	ffffe097          	auipc	ra,0xffffe
    80003224:	7c8080e7          	jalr	1992(ra) # 800019e8 <_ZdlPv>
    80003228:	00090513          	mv	a0,s2
    8000322c:	00008097          	auipc	ra,0x8
    80003230:	49c080e7          	jalr	1180(ra) # 8000b6c8 <_Unwind_Resume>
    80003234:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80003238:	00048513          	mv	a0,s1
    8000323c:	ffffe097          	auipc	ra,0xffffe
    80003240:	7ac080e7          	jalr	1964(ra) # 800019e8 <_ZdlPv>
    80003244:	00090513          	mv	a0,s2
    80003248:	00008097          	auipc	ra,0x8
    8000324c:	480080e7          	jalr	1152(ra) # 8000b6c8 <_Unwind_Resume>
}
    80003250:	03813083          	ld	ra,56(sp)
    80003254:	03013403          	ld	s0,48(sp)
    80003258:	02813483          	ld	s1,40(sp)
    8000325c:	02013903          	ld	s2,32(sp)
    80003260:	04010113          	addi	sp,sp,64
    80003264:	00008067          	ret

0000000080003268 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80003268:	ff010113          	addi	sp,sp,-16
    8000326c:	00113423          	sd	ra,8(sp)
    80003270:	00813023          	sd	s0,0(sp)
    80003274:	01010413          	addi	s0,sp,16
    80003278:	00007797          	auipc	a5,0x7
    8000327c:	12878793          	addi	a5,a5,296 # 8000a3a0 <_ZTV7WorkerA+0x10>
    80003280:	00f53023          	sd	a5,0(a0)
    80003284:	ffffe097          	auipc	ra,0xffffe
    80003288:	7b4080e7          	jalr	1972(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000328c:	00813083          	ld	ra,8(sp)
    80003290:	00013403          	ld	s0,0(sp)
    80003294:	01010113          	addi	sp,sp,16
    80003298:	00008067          	ret

000000008000329c <_ZN7WorkerAD0Ev>:
    8000329c:	fe010113          	addi	sp,sp,-32
    800032a0:	00113c23          	sd	ra,24(sp)
    800032a4:	00813823          	sd	s0,16(sp)
    800032a8:	00913423          	sd	s1,8(sp)
    800032ac:	02010413          	addi	s0,sp,32
    800032b0:	00050493          	mv	s1,a0
    800032b4:	00007797          	auipc	a5,0x7
    800032b8:	0ec78793          	addi	a5,a5,236 # 8000a3a0 <_ZTV7WorkerA+0x10>
    800032bc:	00f53023          	sd	a5,0(a0)
    800032c0:	ffffe097          	auipc	ra,0xffffe
    800032c4:	778080e7          	jalr	1912(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800032c8:	00048513          	mv	a0,s1
    800032cc:	ffffe097          	auipc	ra,0xffffe
    800032d0:	71c080e7          	jalr	1820(ra) # 800019e8 <_ZdlPv>
    800032d4:	01813083          	ld	ra,24(sp)
    800032d8:	01013403          	ld	s0,16(sp)
    800032dc:	00813483          	ld	s1,8(sp)
    800032e0:	02010113          	addi	sp,sp,32
    800032e4:	00008067          	ret

00000000800032e8 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800032e8:	ff010113          	addi	sp,sp,-16
    800032ec:	00113423          	sd	ra,8(sp)
    800032f0:	00813023          	sd	s0,0(sp)
    800032f4:	01010413          	addi	s0,sp,16
    800032f8:	00007797          	auipc	a5,0x7
    800032fc:	0d078793          	addi	a5,a5,208 # 8000a3c8 <_ZTV7WorkerB+0x10>
    80003300:	00f53023          	sd	a5,0(a0)
    80003304:	ffffe097          	auipc	ra,0xffffe
    80003308:	734080e7          	jalr	1844(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000330c:	00813083          	ld	ra,8(sp)
    80003310:	00013403          	ld	s0,0(sp)
    80003314:	01010113          	addi	sp,sp,16
    80003318:	00008067          	ret

000000008000331c <_ZN7WorkerBD0Ev>:
    8000331c:	fe010113          	addi	sp,sp,-32
    80003320:	00113c23          	sd	ra,24(sp)
    80003324:	00813823          	sd	s0,16(sp)
    80003328:	00913423          	sd	s1,8(sp)
    8000332c:	02010413          	addi	s0,sp,32
    80003330:	00050493          	mv	s1,a0
    80003334:	00007797          	auipc	a5,0x7
    80003338:	09478793          	addi	a5,a5,148 # 8000a3c8 <_ZTV7WorkerB+0x10>
    8000333c:	00f53023          	sd	a5,0(a0)
    80003340:	ffffe097          	auipc	ra,0xffffe
    80003344:	6f8080e7          	jalr	1784(ra) # 80001a38 <_ZN6ThreadD1Ev>
    80003348:	00048513          	mv	a0,s1
    8000334c:	ffffe097          	auipc	ra,0xffffe
    80003350:	69c080e7          	jalr	1692(ra) # 800019e8 <_ZdlPv>
    80003354:	01813083          	ld	ra,24(sp)
    80003358:	01013403          	ld	s0,16(sp)
    8000335c:	00813483          	ld	s1,8(sp)
    80003360:	02010113          	addi	sp,sp,32
    80003364:	00008067          	ret

0000000080003368 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80003368:	ff010113          	addi	sp,sp,-16
    8000336c:	00113423          	sd	ra,8(sp)
    80003370:	00813023          	sd	s0,0(sp)
    80003374:	01010413          	addi	s0,sp,16
    80003378:	00007797          	auipc	a5,0x7
    8000337c:	07878793          	addi	a5,a5,120 # 8000a3f0 <_ZTV7WorkerC+0x10>
    80003380:	00f53023          	sd	a5,0(a0)
    80003384:	ffffe097          	auipc	ra,0xffffe
    80003388:	6b4080e7          	jalr	1716(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000338c:	00813083          	ld	ra,8(sp)
    80003390:	00013403          	ld	s0,0(sp)
    80003394:	01010113          	addi	sp,sp,16
    80003398:	00008067          	ret

000000008000339c <_ZN7WorkerCD0Ev>:
    8000339c:	fe010113          	addi	sp,sp,-32
    800033a0:	00113c23          	sd	ra,24(sp)
    800033a4:	00813823          	sd	s0,16(sp)
    800033a8:	00913423          	sd	s1,8(sp)
    800033ac:	02010413          	addi	s0,sp,32
    800033b0:	00050493          	mv	s1,a0
    800033b4:	00007797          	auipc	a5,0x7
    800033b8:	03c78793          	addi	a5,a5,60 # 8000a3f0 <_ZTV7WorkerC+0x10>
    800033bc:	00f53023          	sd	a5,0(a0)
    800033c0:	ffffe097          	auipc	ra,0xffffe
    800033c4:	678080e7          	jalr	1656(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800033c8:	00048513          	mv	a0,s1
    800033cc:	ffffe097          	auipc	ra,0xffffe
    800033d0:	61c080e7          	jalr	1564(ra) # 800019e8 <_ZdlPv>
    800033d4:	01813083          	ld	ra,24(sp)
    800033d8:	01013403          	ld	s0,16(sp)
    800033dc:	00813483          	ld	s1,8(sp)
    800033e0:	02010113          	addi	sp,sp,32
    800033e4:	00008067          	ret

00000000800033e8 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800033e8:	ff010113          	addi	sp,sp,-16
    800033ec:	00113423          	sd	ra,8(sp)
    800033f0:	00813023          	sd	s0,0(sp)
    800033f4:	01010413          	addi	s0,sp,16
    800033f8:	00007797          	auipc	a5,0x7
    800033fc:	02078793          	addi	a5,a5,32 # 8000a418 <_ZTV7WorkerD+0x10>
    80003400:	00f53023          	sd	a5,0(a0)
    80003404:	ffffe097          	auipc	ra,0xffffe
    80003408:	634080e7          	jalr	1588(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000340c:	00813083          	ld	ra,8(sp)
    80003410:	00013403          	ld	s0,0(sp)
    80003414:	01010113          	addi	sp,sp,16
    80003418:	00008067          	ret

000000008000341c <_ZN7WorkerDD0Ev>:
    8000341c:	fe010113          	addi	sp,sp,-32
    80003420:	00113c23          	sd	ra,24(sp)
    80003424:	00813823          	sd	s0,16(sp)
    80003428:	00913423          	sd	s1,8(sp)
    8000342c:	02010413          	addi	s0,sp,32
    80003430:	00050493          	mv	s1,a0
    80003434:	00007797          	auipc	a5,0x7
    80003438:	fe478793          	addi	a5,a5,-28 # 8000a418 <_ZTV7WorkerD+0x10>
    8000343c:	00f53023          	sd	a5,0(a0)
    80003440:	ffffe097          	auipc	ra,0xffffe
    80003444:	5f8080e7          	jalr	1528(ra) # 80001a38 <_ZN6ThreadD1Ev>
    80003448:	00048513          	mv	a0,s1
    8000344c:	ffffe097          	auipc	ra,0xffffe
    80003450:	59c080e7          	jalr	1436(ra) # 800019e8 <_ZdlPv>
    80003454:	01813083          	ld	ra,24(sp)
    80003458:	01013403          	ld	s0,16(sp)
    8000345c:	00813483          	ld	s1,8(sp)
    80003460:	02010113          	addi	sp,sp,32
    80003464:	00008067          	ret

0000000080003468 <_ZN7WorkerA3runEv>:
    void run() override {
    80003468:	ff010113          	addi	sp,sp,-16
    8000346c:	00113423          	sd	ra,8(sp)
    80003470:	00813023          	sd	s0,0(sp)
    80003474:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80003478:	00000593          	li	a1,0
    8000347c:	fffff097          	auipc	ra,0xfffff
    80003480:	774080e7          	jalr	1908(ra) # 80002bf0 <_ZN7WorkerA11workerBodyAEPv>
    }
    80003484:	00813083          	ld	ra,8(sp)
    80003488:	00013403          	ld	s0,0(sp)
    8000348c:	01010113          	addi	sp,sp,16
    80003490:	00008067          	ret

0000000080003494 <_ZN7WorkerB3runEv>:
    void run() override {
    80003494:	ff010113          	addi	sp,sp,-16
    80003498:	00113423          	sd	ra,8(sp)
    8000349c:	00813023          	sd	s0,0(sp)
    800034a0:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    800034a4:	00000593          	li	a1,0
    800034a8:	00000097          	auipc	ra,0x0
    800034ac:	814080e7          	jalr	-2028(ra) # 80002cbc <_ZN7WorkerB11workerBodyBEPv>
    }
    800034b0:	00813083          	ld	ra,8(sp)
    800034b4:	00013403          	ld	s0,0(sp)
    800034b8:	01010113          	addi	sp,sp,16
    800034bc:	00008067          	ret

00000000800034c0 <_ZN7WorkerC3runEv>:
    void run() override {
    800034c0:	ff010113          	addi	sp,sp,-16
    800034c4:	00113423          	sd	ra,8(sp)
    800034c8:	00813023          	sd	s0,0(sp)
    800034cc:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800034d0:	00000593          	li	a1,0
    800034d4:	00000097          	auipc	ra,0x0
    800034d8:	8bc080e7          	jalr	-1860(ra) # 80002d90 <_ZN7WorkerC11workerBodyCEPv>
    }
    800034dc:	00813083          	ld	ra,8(sp)
    800034e0:	00013403          	ld	s0,0(sp)
    800034e4:	01010113          	addi	sp,sp,16
    800034e8:	00008067          	ret

00000000800034ec <_ZN7WorkerD3runEv>:
    void run() override {
    800034ec:	ff010113          	addi	sp,sp,-16
    800034f0:	00113423          	sd	ra,8(sp)
    800034f4:	00813023          	sd	s0,0(sp)
    800034f8:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800034fc:	00000593          	li	a1,0
    80003500:	00000097          	auipc	ra,0x0
    80003504:	a10080e7          	jalr	-1520(ra) # 80002f10 <_ZN7WorkerD11workerBodyDEPv>
    }
    80003508:	00813083          	ld	ra,8(sp)
    8000350c:	00013403          	ld	s0,0(sp)
    80003510:	01010113          	addi	sp,sp,16
    80003514:	00008067          	ret

0000000080003518 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003518:	fe010113          	addi	sp,sp,-32
    8000351c:	00113c23          	sd	ra,24(sp)
    80003520:	00813823          	sd	s0,16(sp)
    80003524:	00913423          	sd	s1,8(sp)
    80003528:	01213023          	sd	s2,0(sp)
    8000352c:	02010413          	addi	s0,sp,32
    80003530:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003534:	00100793          	li	a5,1
    80003538:	02a7f863          	bgeu	a5,a0,80003568 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) {
    8000353c:	00a00793          	li	a5,10
    80003540:	02f577b3          	remu	a5,a0,a5
    80003544:	02078e63          	beqz	a5,80003580 <_ZL9fibonaccim+0x68>
        thread_dispatch();
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003548:	fff48513          	addi	a0,s1,-1
    8000354c:	00000097          	auipc	ra,0x0
    80003550:	fcc080e7          	jalr	-52(ra) # 80003518 <_ZL9fibonaccim>
    80003554:	00050913          	mv	s2,a0
    80003558:	ffe48513          	addi	a0,s1,-2
    8000355c:	00000097          	auipc	ra,0x0
    80003560:	fbc080e7          	jalr	-68(ra) # 80003518 <_ZL9fibonaccim>
    80003564:	00a90533          	add	a0,s2,a0
}
    80003568:	01813083          	ld	ra,24(sp)
    8000356c:	01013403          	ld	s0,16(sp)
    80003570:	00813483          	ld	s1,8(sp)
    80003574:	00013903          	ld	s2,0(sp)
    80003578:	02010113          	addi	sp,sp,32
    8000357c:	00008067          	ret
        thread_dispatch();
    80003580:	ffffe097          	auipc	ra,0xffffe
    80003584:	cc0080e7          	jalr	-832(ra) # 80001240 <_Z15thread_dispatchv>
    80003588:	fc1ff06f          	j	80003548 <_ZL9fibonaccim+0x30>

000000008000358c <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000358c:	fe010113          	addi	sp,sp,-32
    80003590:	00113c23          	sd	ra,24(sp)
    80003594:	00813823          	sd	s0,16(sp)
    80003598:	00913423          	sd	s1,8(sp)
    8000359c:	01213023          	sd	s2,0(sp)
    800035a0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800035a4:	00a00493          	li	s1,10
    800035a8:	0400006f          	j	800035e8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800035ac:	00005517          	auipc	a0,0x5
    800035b0:	f6c50513          	addi	a0,a0,-148 # 80008518 <CONSOLE_STATUS+0x508>
    800035b4:	00001097          	auipc	ra,0x1
    800035b8:	08c080e7          	jalr	140(ra) # 80004640 <_Z11printStringPKc>
    800035bc:	00000613          	li	a2,0
    800035c0:	00a00593          	li	a1,10
    800035c4:	00048513          	mv	a0,s1
    800035c8:	00001097          	auipc	ra,0x1
    800035cc:	228080e7          	jalr	552(ra) # 800047f0 <_Z8printIntiii>
    800035d0:	00005517          	auipc	a0,0x5
    800035d4:	00050513          	mv	a0,a0
    800035d8:	00001097          	auipc	ra,0x1
    800035dc:	068080e7          	jalr	104(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800035e0:	0014849b          	addiw	s1,s1,1
    800035e4:	0ff4f493          	andi	s1,s1,255
    800035e8:	00c00793          	li	a5,12
    800035ec:	fc97f0e3          	bgeu	a5,s1,800035ac <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800035f0:	00005517          	auipc	a0,0x5
    800035f4:	f3050513          	addi	a0,a0,-208 # 80008520 <CONSOLE_STATUS+0x510>
    800035f8:	00001097          	auipc	ra,0x1
    800035fc:	048080e7          	jalr	72(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003600:	00500313          	li	t1,5
    thread_dispatch();
    80003604:	ffffe097          	auipc	ra,0xffffe
    80003608:	c3c080e7          	jalr	-964(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000360c:	01000513          	li	a0,16
    80003610:	00000097          	auipc	ra,0x0
    80003614:	f08080e7          	jalr	-248(ra) # 80003518 <_ZL9fibonaccim>
    80003618:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000361c:	00005517          	auipc	a0,0x5
    80003620:	f1450513          	addi	a0,a0,-236 # 80008530 <CONSOLE_STATUS+0x520>
    80003624:	00001097          	auipc	ra,0x1
    80003628:	01c080e7          	jalr	28(ra) # 80004640 <_Z11printStringPKc>
    8000362c:	00000613          	li	a2,0
    80003630:	00a00593          	li	a1,10
    80003634:	0009051b          	sext.w	a0,s2
    80003638:	00001097          	auipc	ra,0x1
    8000363c:	1b8080e7          	jalr	440(ra) # 800047f0 <_Z8printIntiii>
    80003640:	00005517          	auipc	a0,0x5
    80003644:	f9050513          	addi	a0,a0,-112 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003648:	00001097          	auipc	ra,0x1
    8000364c:	ff8080e7          	jalr	-8(ra) # 80004640 <_Z11printStringPKc>
    80003650:	0400006f          	j	80003690 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003654:	00005517          	auipc	a0,0x5
    80003658:	ec450513          	addi	a0,a0,-316 # 80008518 <CONSOLE_STATUS+0x508>
    8000365c:	00001097          	auipc	ra,0x1
    80003660:	fe4080e7          	jalr	-28(ra) # 80004640 <_Z11printStringPKc>
    80003664:	00000613          	li	a2,0
    80003668:	00a00593          	li	a1,10
    8000366c:	00048513          	mv	a0,s1
    80003670:	00001097          	auipc	ra,0x1
    80003674:	180080e7          	jalr	384(ra) # 800047f0 <_Z8printIntiii>
    80003678:	00005517          	auipc	a0,0x5
    8000367c:	f5850513          	addi	a0,a0,-168 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003680:	00001097          	auipc	ra,0x1
    80003684:	fc0080e7          	jalr	-64(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003688:	0014849b          	addiw	s1,s1,1
    8000368c:	0ff4f493          	andi	s1,s1,255
    80003690:	00f00793          	li	a5,15
    80003694:	fc97f0e3          	bgeu	a5,s1,80003654 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80003698:	00005517          	auipc	a0,0x5
    8000369c:	ea850513          	addi	a0,a0,-344 # 80008540 <CONSOLE_STATUS+0x530>
    800036a0:	00001097          	auipc	ra,0x1
    800036a4:	fa0080e7          	jalr	-96(ra) # 80004640 <_Z11printStringPKc>
    finishedD = true;
    800036a8:	00100793          	li	a5,1
    800036ac:	00007717          	auipc	a4,0x7
    800036b0:	f2f70823          	sb	a5,-208(a4) # 8000a5dc <_ZL9finishedD>
    thread_dispatch();
    800036b4:	ffffe097          	auipc	ra,0xffffe
    800036b8:	b8c080e7          	jalr	-1140(ra) # 80001240 <_Z15thread_dispatchv>
}
    800036bc:	01813083          	ld	ra,24(sp)
    800036c0:	01013403          	ld	s0,16(sp)
    800036c4:	00813483          	ld	s1,8(sp)
    800036c8:	00013903          	ld	s2,0(sp)
    800036cc:	02010113          	addi	sp,sp,32
    800036d0:	00008067          	ret

00000000800036d4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800036d4:	fe010113          	addi	sp,sp,-32
    800036d8:	00113c23          	sd	ra,24(sp)
    800036dc:	00813823          	sd	s0,16(sp)
    800036e0:	00913423          	sd	s1,8(sp)
    800036e4:	01213023          	sd	s2,0(sp)
    800036e8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800036ec:	00000493          	li	s1,0
    800036f0:	0400006f          	j	80003730 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800036f4:	00005517          	auipc	a0,0x5
    800036f8:	df450513          	addi	a0,a0,-524 # 800084e8 <CONSOLE_STATUS+0x4d8>
    800036fc:	00001097          	auipc	ra,0x1
    80003700:	f44080e7          	jalr	-188(ra) # 80004640 <_Z11printStringPKc>
    80003704:	00000613          	li	a2,0
    80003708:	00a00593          	li	a1,10
    8000370c:	00048513          	mv	a0,s1
    80003710:	00001097          	auipc	ra,0x1
    80003714:	0e0080e7          	jalr	224(ra) # 800047f0 <_Z8printIntiii>
    80003718:	00005517          	auipc	a0,0x5
    8000371c:	eb850513          	addi	a0,a0,-328 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003720:	00001097          	auipc	ra,0x1
    80003724:	f20080e7          	jalr	-224(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003728:	0014849b          	addiw	s1,s1,1
    8000372c:	0ff4f493          	andi	s1,s1,255
    80003730:	00200793          	li	a5,2
    80003734:	fc97f0e3          	bgeu	a5,s1,800036f4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003738:	00005517          	auipc	a0,0x5
    8000373c:	db850513          	addi	a0,a0,-584 # 800084f0 <CONSOLE_STATUS+0x4e0>
    80003740:	00001097          	auipc	ra,0x1
    80003744:	f00080e7          	jalr	-256(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003748:	00700313          	li	t1,7
    thread_dispatch();
    8000374c:	ffffe097          	auipc	ra,0xffffe
    80003750:	af4080e7          	jalr	-1292(ra) # 80001240 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003754:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003758:	00005517          	auipc	a0,0x5
    8000375c:	da850513          	addi	a0,a0,-600 # 80008500 <CONSOLE_STATUS+0x4f0>
    80003760:	00001097          	auipc	ra,0x1
    80003764:	ee0080e7          	jalr	-288(ra) # 80004640 <_Z11printStringPKc>
    80003768:	00000613          	li	a2,0
    8000376c:	00a00593          	li	a1,10
    80003770:	0009051b          	sext.w	a0,s2
    80003774:	00001097          	auipc	ra,0x1
    80003778:	07c080e7          	jalr	124(ra) # 800047f0 <_Z8printIntiii>
    8000377c:	00005517          	auipc	a0,0x5
    80003780:	e5450513          	addi	a0,a0,-428 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003784:	00001097          	auipc	ra,0x1
    80003788:	ebc080e7          	jalr	-324(ra) # 80004640 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000378c:	00c00513          	li	a0,12
    80003790:	00000097          	auipc	ra,0x0
    80003794:	d88080e7          	jalr	-632(ra) # 80003518 <_ZL9fibonaccim>
    80003798:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000379c:	00005517          	auipc	a0,0x5
    800037a0:	d6c50513          	addi	a0,a0,-660 # 80008508 <CONSOLE_STATUS+0x4f8>
    800037a4:	00001097          	auipc	ra,0x1
    800037a8:	e9c080e7          	jalr	-356(ra) # 80004640 <_Z11printStringPKc>
    800037ac:	00000613          	li	a2,0
    800037b0:	00a00593          	li	a1,10
    800037b4:	0009051b          	sext.w	a0,s2
    800037b8:	00001097          	auipc	ra,0x1
    800037bc:	038080e7          	jalr	56(ra) # 800047f0 <_Z8printIntiii>
    800037c0:	00005517          	auipc	a0,0x5
    800037c4:	e1050513          	addi	a0,a0,-496 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800037c8:	00001097          	auipc	ra,0x1
    800037cc:	e78080e7          	jalr	-392(ra) # 80004640 <_Z11printStringPKc>
    800037d0:	0400006f          	j	80003810 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800037d4:	00005517          	auipc	a0,0x5
    800037d8:	d1450513          	addi	a0,a0,-748 # 800084e8 <CONSOLE_STATUS+0x4d8>
    800037dc:	00001097          	auipc	ra,0x1
    800037e0:	e64080e7          	jalr	-412(ra) # 80004640 <_Z11printStringPKc>
    800037e4:	00000613          	li	a2,0
    800037e8:	00a00593          	li	a1,10
    800037ec:	00048513          	mv	a0,s1
    800037f0:	00001097          	auipc	ra,0x1
    800037f4:	000080e7          	jalr	ra # 800047f0 <_Z8printIntiii>
    800037f8:	00005517          	auipc	a0,0x5
    800037fc:	dd850513          	addi	a0,a0,-552 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80003800:	00001097          	auipc	ra,0x1
    80003804:	e40080e7          	jalr	-448(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003808:	0014849b          	addiw	s1,s1,1
    8000380c:	0ff4f493          	andi	s1,s1,255
    80003810:	00500793          	li	a5,5
    80003814:	fc97f0e3          	bgeu	a5,s1,800037d4 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    80003818:	00005517          	auipc	a0,0x5
    8000381c:	d9850513          	addi	a0,a0,-616 # 800085b0 <CONSOLE_STATUS+0x5a0>
    80003820:	00001097          	auipc	ra,0x1
    80003824:	e20080e7          	jalr	-480(ra) # 80004640 <_Z11printStringPKc>
    finishedC = true;
    80003828:	00100793          	li	a5,1
    8000382c:	00007717          	auipc	a4,0x7
    80003830:	daf708a3          	sb	a5,-591(a4) # 8000a5dd <_ZL9finishedC>
    thread_dispatch();
    80003834:	ffffe097          	auipc	ra,0xffffe
    80003838:	a0c080e7          	jalr	-1524(ra) # 80001240 <_Z15thread_dispatchv>
}
    8000383c:	01813083          	ld	ra,24(sp)
    80003840:	01013403          	ld	s0,16(sp)
    80003844:	00813483          	ld	s1,8(sp)
    80003848:	00013903          	ld	s2,0(sp)
    8000384c:	02010113          	addi	sp,sp,32
    80003850:	00008067          	ret

0000000080003854 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003854:	fe010113          	addi	sp,sp,-32
    80003858:	00113c23          	sd	ra,24(sp)
    8000385c:	00813823          	sd	s0,16(sp)
    80003860:	00913423          	sd	s1,8(sp)
    80003864:	01213023          	sd	s2,0(sp)
    80003868:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000386c:	00000913          	li	s2,0
    80003870:	0380006f          	j	800038a8 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003874:	ffffe097          	auipc	ra,0xffffe
    80003878:	9cc080e7          	jalr	-1588(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000387c:	00148493          	addi	s1,s1,1
    80003880:	000027b7          	lui	a5,0x2
    80003884:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003888:	0097ee63          	bltu	a5,s1,800038a4 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000388c:	00000713          	li	a4,0
    80003890:	000077b7          	lui	a5,0x7
    80003894:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003898:	fce7eee3          	bltu	a5,a4,80003874 <_ZL11workerBodyBPv+0x20>
    8000389c:	00170713          	addi	a4,a4,1
    800038a0:	ff1ff06f          	j	80003890 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800038a4:	00190913          	addi	s2,s2,1
    800038a8:	00f00793          	li	a5,15
    800038ac:	0527e063          	bltu	a5,s2,800038ec <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800038b0:	00005517          	auipc	a0,0x5
    800038b4:	c2050513          	addi	a0,a0,-992 # 800084d0 <CONSOLE_STATUS+0x4c0>
    800038b8:	00001097          	auipc	ra,0x1
    800038bc:	d88080e7          	jalr	-632(ra) # 80004640 <_Z11printStringPKc>
    800038c0:	00000613          	li	a2,0
    800038c4:	00a00593          	li	a1,10
    800038c8:	0009051b          	sext.w	a0,s2
    800038cc:	00001097          	auipc	ra,0x1
    800038d0:	f24080e7          	jalr	-220(ra) # 800047f0 <_Z8printIntiii>
    800038d4:	00005517          	auipc	a0,0x5
    800038d8:	cfc50513          	addi	a0,a0,-772 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800038dc:	00001097          	auipc	ra,0x1
    800038e0:	d64080e7          	jalr	-668(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800038e4:	00000493          	li	s1,0
    800038e8:	f99ff06f          	j	80003880 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800038ec:	00005517          	auipc	a0,0x5
    800038f0:	bec50513          	addi	a0,a0,-1044 # 800084d8 <CONSOLE_STATUS+0x4c8>
    800038f4:	00001097          	auipc	ra,0x1
    800038f8:	d4c080e7          	jalr	-692(ra) # 80004640 <_Z11printStringPKc>
    finishedB = true;
    800038fc:	00100793          	li	a5,1
    80003900:	00007717          	auipc	a4,0x7
    80003904:	ccf70f23          	sb	a5,-802(a4) # 8000a5de <_ZL9finishedB>
    thread_dispatch();
    80003908:	ffffe097          	auipc	ra,0xffffe
    8000390c:	938080e7          	jalr	-1736(ra) # 80001240 <_Z15thread_dispatchv>
}
    80003910:	01813083          	ld	ra,24(sp)
    80003914:	01013403          	ld	s0,16(sp)
    80003918:	00813483          	ld	s1,8(sp)
    8000391c:	00013903          	ld	s2,0(sp)
    80003920:	02010113          	addi	sp,sp,32
    80003924:	00008067          	ret

0000000080003928 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003928:	fe010113          	addi	sp,sp,-32
    8000392c:	00113c23          	sd	ra,24(sp)
    80003930:	00813823          	sd	s0,16(sp)
    80003934:	00913423          	sd	s1,8(sp)
    80003938:	01213023          	sd	s2,0(sp)
    8000393c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003940:	00000913          	li	s2,0
    80003944:	0380006f          	j	8000397c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003948:	ffffe097          	auipc	ra,0xffffe
    8000394c:	8f8080e7          	jalr	-1800(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003950:	00148493          	addi	s1,s1,1
    80003954:	000027b7          	lui	a5,0x2
    80003958:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000395c:	0097ee63          	bltu	a5,s1,80003978 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003960:	00000713          	li	a4,0
    80003964:	000077b7          	lui	a5,0x7
    80003968:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000396c:	fce7eee3          	bltu	a5,a4,80003948 <_ZL11workerBodyAPv+0x20>
    80003970:	00170713          	addi	a4,a4,1
    80003974:	ff1ff06f          	j	80003964 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003978:	00190913          	addi	s2,s2,1
    8000397c:	00900793          	li	a5,9
    80003980:	0527e063          	bltu	a5,s2,800039c0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003984:	00005517          	auipc	a0,0x5
    80003988:	b3450513          	addi	a0,a0,-1228 # 800084b8 <CONSOLE_STATUS+0x4a8>
    8000398c:	00001097          	auipc	ra,0x1
    80003990:	cb4080e7          	jalr	-844(ra) # 80004640 <_Z11printStringPKc>
    80003994:	00000613          	li	a2,0
    80003998:	00a00593          	li	a1,10
    8000399c:	0009051b          	sext.w	a0,s2
    800039a0:	00001097          	auipc	ra,0x1
    800039a4:	e50080e7          	jalr	-432(ra) # 800047f0 <_Z8printIntiii>
    800039a8:	00005517          	auipc	a0,0x5
    800039ac:	c2850513          	addi	a0,a0,-984 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800039b0:	00001097          	auipc	ra,0x1
    800039b4:	c90080e7          	jalr	-880(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800039b8:	00000493          	li	s1,0
    800039bc:	f99ff06f          	j	80003954 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800039c0:	00005517          	auipc	a0,0x5
    800039c4:	b0050513          	addi	a0,a0,-1280 # 800084c0 <CONSOLE_STATUS+0x4b0>
    800039c8:	00001097          	auipc	ra,0x1
    800039cc:	c78080e7          	jalr	-904(ra) # 80004640 <_Z11printStringPKc>
    finishedA = true;
    800039d0:	00100793          	li	a5,1
    800039d4:	00007717          	auipc	a4,0x7
    800039d8:	c0f705a3          	sb	a5,-1013(a4) # 8000a5df <_ZL9finishedA>
}
    800039dc:	01813083          	ld	ra,24(sp)
    800039e0:	01013403          	ld	s0,16(sp)
    800039e4:	00813483          	ld	s1,8(sp)
    800039e8:	00013903          	ld	s2,0(sp)
    800039ec:	02010113          	addi	sp,sp,32
    800039f0:	00008067          	ret

00000000800039f4 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    800039f4:	fd010113          	addi	sp,sp,-48
    800039f8:	02113423          	sd	ra,40(sp)
    800039fc:	02813023          	sd	s0,32(sp)
    80003a00:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80003a04:	00000613          	li	a2,0
    80003a08:	00000597          	auipc	a1,0x0
    80003a0c:	f2058593          	addi	a1,a1,-224 # 80003928 <_ZL11workerBodyAPv>
    80003a10:	fd040513          	addi	a0,s0,-48
    80003a14:	ffffd097          	auipc	ra,0xffffd
    80003a18:	7d4080e7          	jalr	2004(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80003a1c:	00005517          	auipc	a0,0x5
    80003a20:	b3450513          	addi	a0,a0,-1228 # 80008550 <CONSOLE_STATUS+0x540>
    80003a24:	00001097          	auipc	ra,0x1
    80003a28:	c1c080e7          	jalr	-996(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80003a2c:	00000613          	li	a2,0
    80003a30:	00000597          	auipc	a1,0x0
    80003a34:	e2458593          	addi	a1,a1,-476 # 80003854 <_ZL11workerBodyBPv>
    80003a38:	fd840513          	addi	a0,s0,-40
    80003a3c:	ffffd097          	auipc	ra,0xffffd
    80003a40:	7ac080e7          	jalr	1964(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80003a44:	00005517          	auipc	a0,0x5
    80003a48:	b2450513          	addi	a0,a0,-1244 # 80008568 <CONSOLE_STATUS+0x558>
    80003a4c:	00001097          	auipc	ra,0x1
    80003a50:	bf4080e7          	jalr	-1036(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80003a54:	00000613          	li	a2,0
    80003a58:	00000597          	auipc	a1,0x0
    80003a5c:	c7c58593          	addi	a1,a1,-900 # 800036d4 <_ZL11workerBodyCPv>
    80003a60:	fe040513          	addi	a0,s0,-32
    80003a64:	ffffd097          	auipc	ra,0xffffd
    80003a68:	784080e7          	jalr	1924(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003a6c:	00005517          	auipc	a0,0x5
    80003a70:	b1450513          	addi	a0,a0,-1260 # 80008580 <CONSOLE_STATUS+0x570>
    80003a74:	00001097          	auipc	ra,0x1
    80003a78:	bcc080e7          	jalr	-1076(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003a7c:	00000613          	li	a2,0
    80003a80:	00000597          	auipc	a1,0x0
    80003a84:	b0c58593          	addi	a1,a1,-1268 # 8000358c <_ZL11workerBodyDPv>
    80003a88:	fe840513          	addi	a0,s0,-24
    80003a8c:	ffffd097          	auipc	ra,0xffffd
    80003a90:	75c080e7          	jalr	1884(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80003a94:	00005517          	auipc	a0,0x5
    80003a98:	b0450513          	addi	a0,a0,-1276 # 80008598 <CONSOLE_STATUS+0x588>
    80003a9c:	00001097          	auipc	ra,0x1
    80003aa0:	ba4080e7          	jalr	-1116(ra) # 80004640 <_Z11printStringPKc>
    80003aa4:	00c0006f          	j	80003ab0 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80003aa8:	ffffd097          	auipc	ra,0xffffd
    80003aac:	798080e7          	jalr	1944(ra) # 80001240 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003ab0:	00007797          	auipc	a5,0x7
    80003ab4:	b2f7c783          	lbu	a5,-1233(a5) # 8000a5df <_ZL9finishedA>
    80003ab8:	fe0788e3          	beqz	a5,80003aa8 <_Z18Threads_C_API_testv+0xb4>
    80003abc:	00007797          	auipc	a5,0x7
    80003ac0:	b227c783          	lbu	a5,-1246(a5) # 8000a5de <_ZL9finishedB>
    80003ac4:	fe0782e3          	beqz	a5,80003aa8 <_Z18Threads_C_API_testv+0xb4>
    80003ac8:	00007797          	auipc	a5,0x7
    80003acc:	b157c783          	lbu	a5,-1259(a5) # 8000a5dd <_ZL9finishedC>
    80003ad0:	fc078ce3          	beqz	a5,80003aa8 <_Z18Threads_C_API_testv+0xb4>
    80003ad4:	00007797          	auipc	a5,0x7
    80003ad8:	b087c783          	lbu	a5,-1272(a5) # 8000a5dc <_ZL9finishedD>
    80003adc:	fc0786e3          	beqz	a5,80003aa8 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80003ae0:	02813083          	ld	ra,40(sp)
    80003ae4:	02013403          	ld	s0,32(sp)
    80003ae8:	03010113          	addi	sp,sp,48
    80003aec:	00008067          	ret

0000000080003af0 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003af0:	fd010113          	addi	sp,sp,-48
    80003af4:	02113423          	sd	ra,40(sp)
    80003af8:	02813023          	sd	s0,32(sp)
    80003afc:	00913c23          	sd	s1,24(sp)
    80003b00:	01213823          	sd	s2,16(sp)
    80003b04:	01313423          	sd	s3,8(sp)
    80003b08:	03010413          	addi	s0,sp,48
    80003b0c:	00050993          	mv	s3,a0
    80003b10:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003b14:	00000913          	li	s2,0
    80003b18:	00c0006f          	j	80003b24 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003b1c:	ffffe097          	auipc	ra,0xffffe
    80003b20:	0d8080e7          	jalr	216(ra) # 80001bf4 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80003b24:	ffffd097          	auipc	ra,0xffffd
    80003b28:	7f0080e7          	jalr	2032(ra) # 80001314 <_Z4getcv>
    80003b2c:	0005059b          	sext.w	a1,a0
    80003b30:	01b00793          	li	a5,27
    80003b34:	02f58a63          	beq	a1,a5,80003b68 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80003b38:	0084b503          	ld	a0,8(s1)
    80003b3c:	00001097          	auipc	ra,0x1
    80003b40:	f28080e7          	jalr	-216(ra) # 80004a64 <_ZN9BufferCPP3putEi>
        i++;
    80003b44:	0019071b          	addiw	a4,s2,1
    80003b48:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003b4c:	0004a683          	lw	a3,0(s1)
    80003b50:	0026979b          	slliw	a5,a3,0x2
    80003b54:	00d787bb          	addw	a5,a5,a3
    80003b58:	0017979b          	slliw	a5,a5,0x1
    80003b5c:	02f767bb          	remw	a5,a4,a5
    80003b60:	fc0792e3          	bnez	a5,80003b24 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80003b64:	fb9ff06f          	j	80003b1c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80003b68:	00100793          	li	a5,1
    80003b6c:	00007717          	auipc	a4,0x7
    80003b70:	a6f72a23          	sw	a5,-1420(a4) # 8000a5e0 <_ZL9threadEnd>
    td->buffer->put('!');
    80003b74:	0209b783          	ld	a5,32(s3)
    80003b78:	02100593          	li	a1,33
    80003b7c:	0087b503          	ld	a0,8(a5)
    80003b80:	00001097          	auipc	ra,0x1
    80003b84:	ee4080e7          	jalr	-284(ra) # 80004a64 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80003b88:	0104b503          	ld	a0,16(s1)
    80003b8c:	ffffe097          	auipc	ra,0xffffe
    80003b90:	148080e7          	jalr	328(ra) # 80001cd4 <_ZN9Semaphore6signalEv>
}
    80003b94:	02813083          	ld	ra,40(sp)
    80003b98:	02013403          	ld	s0,32(sp)
    80003b9c:	01813483          	ld	s1,24(sp)
    80003ba0:	01013903          	ld	s2,16(sp)
    80003ba4:	00813983          	ld	s3,8(sp)
    80003ba8:	03010113          	addi	sp,sp,48
    80003bac:	00008067          	ret

0000000080003bb0 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003bb0:	fe010113          	addi	sp,sp,-32
    80003bb4:	00113c23          	sd	ra,24(sp)
    80003bb8:	00813823          	sd	s0,16(sp)
    80003bbc:	00913423          	sd	s1,8(sp)
    80003bc0:	01213023          	sd	s2,0(sp)
    80003bc4:	02010413          	addi	s0,sp,32
    80003bc8:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003bcc:	00000913          	li	s2,0
    80003bd0:	00c0006f          	j	80003bdc <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003bd4:	ffffe097          	auipc	ra,0xffffe
    80003bd8:	020080e7          	jalr	32(ra) # 80001bf4 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80003bdc:	00007797          	auipc	a5,0x7
    80003be0:	a047a783          	lw	a5,-1532(a5) # 8000a5e0 <_ZL9threadEnd>
    80003be4:	02079e63          	bnez	a5,80003c20 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80003be8:	0004a583          	lw	a1,0(s1)
    80003bec:	0305859b          	addiw	a1,a1,48
    80003bf0:	0084b503          	ld	a0,8(s1)
    80003bf4:	00001097          	auipc	ra,0x1
    80003bf8:	e70080e7          	jalr	-400(ra) # 80004a64 <_ZN9BufferCPP3putEi>
        i++;
    80003bfc:	0019071b          	addiw	a4,s2,1
    80003c00:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003c04:	0004a683          	lw	a3,0(s1)
    80003c08:	0026979b          	slliw	a5,a3,0x2
    80003c0c:	00d787bb          	addw	a5,a5,a3
    80003c10:	0017979b          	slliw	a5,a5,0x1
    80003c14:	02f767bb          	remw	a5,a4,a5
    80003c18:	fc0792e3          	bnez	a5,80003bdc <_ZN12ProducerSync8producerEPv+0x2c>
    80003c1c:	fb9ff06f          	j	80003bd4 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80003c20:	0104b503          	ld	a0,16(s1)
    80003c24:	ffffe097          	auipc	ra,0xffffe
    80003c28:	0b0080e7          	jalr	176(ra) # 80001cd4 <_ZN9Semaphore6signalEv>
}
    80003c2c:	01813083          	ld	ra,24(sp)
    80003c30:	01013403          	ld	s0,16(sp)
    80003c34:	00813483          	ld	s1,8(sp)
    80003c38:	00013903          	ld	s2,0(sp)
    80003c3c:	02010113          	addi	sp,sp,32
    80003c40:	00008067          	ret

0000000080003c44 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80003c44:	fd010113          	addi	sp,sp,-48
    80003c48:	02113423          	sd	ra,40(sp)
    80003c4c:	02813023          	sd	s0,32(sp)
    80003c50:	00913c23          	sd	s1,24(sp)
    80003c54:	01213823          	sd	s2,16(sp)
    80003c58:	01313423          	sd	s3,8(sp)
    80003c5c:	01413023          	sd	s4,0(sp)
    80003c60:	03010413          	addi	s0,sp,48
    80003c64:	00050993          	mv	s3,a0
    80003c68:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003c6c:	00000a13          	li	s4,0
    80003c70:	01c0006f          	j	80003c8c <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80003c74:	ffffe097          	auipc	ra,0xffffe
    80003c78:	f80080e7          	jalr	-128(ra) # 80001bf4 <_ZN6Thread8dispatchEv>
    80003c7c:	0500006f          	j	80003ccc <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003c80:	00a00513          	li	a0,10
    80003c84:	ffffd097          	auipc	ra,0xffffd
    80003c88:	6bc080e7          	jalr	1724(ra) # 80001340 <_Z4putcc>
    while (!threadEnd) {
    80003c8c:	00007797          	auipc	a5,0x7
    80003c90:	9547a783          	lw	a5,-1708(a5) # 8000a5e0 <_ZL9threadEnd>
    80003c94:	06079263          	bnez	a5,80003cf8 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80003c98:	00893503          	ld	a0,8(s2)
    80003c9c:	00001097          	auipc	ra,0x1
    80003ca0:	e58080e7          	jalr	-424(ra) # 80004af4 <_ZN9BufferCPP3getEv>
        i++;
    80003ca4:	001a049b          	addiw	s1,s4,1
    80003ca8:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003cac:	0ff57513          	andi	a0,a0,255
    80003cb0:	ffffd097          	auipc	ra,0xffffd
    80003cb4:	690080e7          	jalr	1680(ra) # 80001340 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003cb8:	00092703          	lw	a4,0(s2)
    80003cbc:	0027179b          	slliw	a5,a4,0x2
    80003cc0:	00e787bb          	addw	a5,a5,a4
    80003cc4:	02f4e7bb          	remw	a5,s1,a5
    80003cc8:	fa0786e3          	beqz	a5,80003c74 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003ccc:	05000793          	li	a5,80
    80003cd0:	02f4e4bb          	remw	s1,s1,a5
    80003cd4:	fa049ce3          	bnez	s1,80003c8c <_ZN12ConsumerSync8consumerEPv+0x48>
    80003cd8:	fa9ff06f          	j	80003c80 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003cdc:	0209b783          	ld	a5,32(s3)
    80003ce0:	0087b503          	ld	a0,8(a5)
    80003ce4:	00001097          	auipc	ra,0x1
    80003ce8:	e10080e7          	jalr	-496(ra) # 80004af4 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003cec:	0ff57513          	andi	a0,a0,255
    80003cf0:	ffffe097          	auipc	ra,0xffffe
    80003cf4:	e54080e7          	jalr	-428(ra) # 80001b44 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80003cf8:	0209b783          	ld	a5,32(s3)
    80003cfc:	0087b503          	ld	a0,8(a5)
    80003d00:	00001097          	auipc	ra,0x1
    80003d04:	e80080e7          	jalr	-384(ra) # 80004b80 <_ZN9BufferCPP6getCntEv>
    80003d08:	fca04ae3          	bgtz	a0,80003cdc <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80003d0c:	01093503          	ld	a0,16(s2)
    80003d10:	ffffe097          	auipc	ra,0xffffe
    80003d14:	fc4080e7          	jalr	-60(ra) # 80001cd4 <_ZN9Semaphore6signalEv>
}
    80003d18:	02813083          	ld	ra,40(sp)
    80003d1c:	02013403          	ld	s0,32(sp)
    80003d20:	01813483          	ld	s1,24(sp)
    80003d24:	01013903          	ld	s2,16(sp)
    80003d28:	00813983          	ld	s3,8(sp)
    80003d2c:	00013a03          	ld	s4,0(sp)
    80003d30:	03010113          	addi	sp,sp,48
    80003d34:	00008067          	ret

0000000080003d38 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003d38:	f8010113          	addi	sp,sp,-128
    80003d3c:	06113c23          	sd	ra,120(sp)
    80003d40:	06813823          	sd	s0,112(sp)
    80003d44:	06913423          	sd	s1,104(sp)
    80003d48:	07213023          	sd	s2,96(sp)
    80003d4c:	05313c23          	sd	s3,88(sp)
    80003d50:	05413823          	sd	s4,80(sp)
    80003d54:	05513423          	sd	s5,72(sp)
    80003d58:	05613023          	sd	s6,64(sp)
    80003d5c:	03713c23          	sd	s7,56(sp)
    80003d60:	03813823          	sd	s8,48(sp)
    80003d64:	03913423          	sd	s9,40(sp)
    80003d68:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003d6c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003d70:	00004517          	auipc	a0,0x4
    80003d74:	66050513          	addi	a0,a0,1632 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80003d78:	00001097          	auipc	ra,0x1
    80003d7c:	8c8080e7          	jalr	-1848(ra) # 80004640 <_Z11printStringPKc>
    getString(input, 30);
    80003d80:	01e00593          	li	a1,30
    80003d84:	f8040493          	addi	s1,s0,-128
    80003d88:	00048513          	mv	a0,s1
    80003d8c:	00001097          	auipc	ra,0x1
    80003d90:	93c080e7          	jalr	-1732(ra) # 800046c8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003d94:	00048513          	mv	a0,s1
    80003d98:	00001097          	auipc	ra,0x1
    80003d9c:	a08080e7          	jalr	-1528(ra) # 800047a0 <_Z11stringToIntPKc>
    80003da0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003da4:	00004517          	auipc	a0,0x4
    80003da8:	64c50513          	addi	a0,a0,1612 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80003dac:	00001097          	auipc	ra,0x1
    80003db0:	894080e7          	jalr	-1900(ra) # 80004640 <_Z11printStringPKc>
    getString(input, 30);
    80003db4:	01e00593          	li	a1,30
    80003db8:	00048513          	mv	a0,s1
    80003dbc:	00001097          	auipc	ra,0x1
    80003dc0:	90c080e7          	jalr	-1780(ra) # 800046c8 <_Z9getStringPci>
    n = stringToInt(input);
    80003dc4:	00048513          	mv	a0,s1
    80003dc8:	00001097          	auipc	ra,0x1
    80003dcc:	9d8080e7          	jalr	-1576(ra) # 800047a0 <_Z11stringToIntPKc>
    80003dd0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003dd4:	00004517          	auipc	a0,0x4
    80003dd8:	63c50513          	addi	a0,a0,1596 # 80008410 <CONSOLE_STATUS+0x400>
    80003ddc:	00001097          	auipc	ra,0x1
    80003de0:	864080e7          	jalr	-1948(ra) # 80004640 <_Z11printStringPKc>
    80003de4:	00000613          	li	a2,0
    80003de8:	00a00593          	li	a1,10
    80003dec:	00090513          	mv	a0,s2
    80003df0:	00001097          	auipc	ra,0x1
    80003df4:	a00080e7          	jalr	-1536(ra) # 800047f0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80003df8:	00004517          	auipc	a0,0x4
    80003dfc:	63050513          	addi	a0,a0,1584 # 80008428 <CONSOLE_STATUS+0x418>
    80003e00:	00001097          	auipc	ra,0x1
    80003e04:	840080e7          	jalr	-1984(ra) # 80004640 <_Z11printStringPKc>
    80003e08:	00000613          	li	a2,0
    80003e0c:	00a00593          	li	a1,10
    80003e10:	00048513          	mv	a0,s1
    80003e14:	00001097          	auipc	ra,0x1
    80003e18:	9dc080e7          	jalr	-1572(ra) # 800047f0 <_Z8printIntiii>
    printString(".\n");
    80003e1c:	00004517          	auipc	a0,0x4
    80003e20:	62450513          	addi	a0,a0,1572 # 80008440 <CONSOLE_STATUS+0x430>
    80003e24:	00001097          	auipc	ra,0x1
    80003e28:	81c080e7          	jalr	-2020(ra) # 80004640 <_Z11printStringPKc>
    if(threadNum > n) {
    80003e2c:	0324c463          	blt	s1,s2,80003e54 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80003e30:	03205c63          	blez	s2,80003e68 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80003e34:	03800513          	li	a0,56
    80003e38:	ffffe097          	auipc	ra,0xffffe
    80003e3c:	b60080e7          	jalr	-1184(ra) # 80001998 <_Znwm>
    80003e40:	00050a93          	mv	s5,a0
    80003e44:	00048593          	mv	a1,s1
    80003e48:	00001097          	auipc	ra,0x1
    80003e4c:	ac8080e7          	jalr	-1336(ra) # 80004910 <_ZN9BufferCPPC1Ei>
    80003e50:	0300006f          	j	80003e80 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003e54:	00004517          	auipc	a0,0x4
    80003e58:	5f450513          	addi	a0,a0,1524 # 80008448 <CONSOLE_STATUS+0x438>
    80003e5c:	00000097          	auipc	ra,0x0
    80003e60:	7e4080e7          	jalr	2020(ra) # 80004640 <_Z11printStringPKc>
        return;
    80003e64:	0140006f          	j	80003e78 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003e68:	00004517          	auipc	a0,0x4
    80003e6c:	62050513          	addi	a0,a0,1568 # 80008488 <CONSOLE_STATUS+0x478>
    80003e70:	00000097          	auipc	ra,0x0
    80003e74:	7d0080e7          	jalr	2000(ra) # 80004640 <_Z11printStringPKc>
        return;
    80003e78:	000b8113          	mv	sp,s7
    80003e7c:	2380006f          	j	800040b4 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003e80:	01000513          	li	a0,16
    80003e84:	ffffe097          	auipc	ra,0xffffe
    80003e88:	b14080e7          	jalr	-1260(ra) # 80001998 <_Znwm>
    80003e8c:	00050493          	mv	s1,a0
    80003e90:	00000593          	li	a1,0
    80003e94:	ffffe097          	auipc	ra,0xffffe
    80003e98:	e6c080e7          	jalr	-404(ra) # 80001d00 <_ZN9SemaphoreC1Ej>
    80003e9c:	00006797          	auipc	a5,0x6
    80003ea0:	7497b623          	sd	s1,1868(a5) # 8000a5e8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003ea4:	00391793          	slli	a5,s2,0x3
    80003ea8:	00f78793          	addi	a5,a5,15
    80003eac:	ff07f793          	andi	a5,a5,-16
    80003eb0:	40f10133          	sub	sp,sp,a5
    80003eb4:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80003eb8:	0019071b          	addiw	a4,s2,1
    80003ebc:	00171793          	slli	a5,a4,0x1
    80003ec0:	00e787b3          	add	a5,a5,a4
    80003ec4:	00379793          	slli	a5,a5,0x3
    80003ec8:	00f78793          	addi	a5,a5,15
    80003ecc:	ff07f793          	andi	a5,a5,-16
    80003ed0:	40f10133          	sub	sp,sp,a5
    80003ed4:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80003ed8:	00191c13          	slli	s8,s2,0x1
    80003edc:	012c07b3          	add	a5,s8,s2
    80003ee0:	00379793          	slli	a5,a5,0x3
    80003ee4:	00fa07b3          	add	a5,s4,a5
    80003ee8:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003eec:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003ef0:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003ef4:	02800513          	li	a0,40
    80003ef8:	ffffe097          	auipc	ra,0xffffe
    80003efc:	aa0080e7          	jalr	-1376(ra) # 80001998 <_Znwm>
    80003f00:	00050b13          	mv	s6,a0
    80003f04:	012c0c33          	add	s8,s8,s2
    80003f08:	003c1c13          	slli	s8,s8,0x3
    80003f0c:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003f10:	ffffe097          	auipc	ra,0xffffe
    80003f14:	d0c080e7          	jalr	-756(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80003f18:	00006797          	auipc	a5,0x6
    80003f1c:	57878793          	addi	a5,a5,1400 # 8000a490 <_ZTV12ConsumerSync+0x10>
    80003f20:	00fb3023          	sd	a5,0(s6)
    80003f24:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80003f28:	000b0513          	mv	a0,s6
    80003f2c:	ffffe097          	auipc	ra,0xffffe
    80003f30:	c94080e7          	jalr	-876(ra) # 80001bc0 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003f34:	00000493          	li	s1,0
    80003f38:	0380006f          	j	80003f70 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003f3c:	00006797          	auipc	a5,0x6
    80003f40:	52c78793          	addi	a5,a5,1324 # 8000a468 <_ZTV12ProducerSync+0x10>
    80003f44:	00fcb023          	sd	a5,0(s9)
    80003f48:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003f4c:	00349793          	slli	a5,s1,0x3
    80003f50:	00f987b3          	add	a5,s3,a5
    80003f54:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003f58:	00349793          	slli	a5,s1,0x3
    80003f5c:	00f987b3          	add	a5,s3,a5
    80003f60:	0007b503          	ld	a0,0(a5)
    80003f64:	ffffe097          	auipc	ra,0xffffe
    80003f68:	c5c080e7          	jalr	-932(ra) # 80001bc0 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003f6c:	0014849b          	addiw	s1,s1,1
    80003f70:	0b24d063          	bge	s1,s2,80004010 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003f74:	00149793          	slli	a5,s1,0x1
    80003f78:	009787b3          	add	a5,a5,s1
    80003f7c:	00379793          	slli	a5,a5,0x3
    80003f80:	00fa07b3          	add	a5,s4,a5
    80003f84:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003f88:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003f8c:	00006717          	auipc	a4,0x6
    80003f90:	65c73703          	ld	a4,1628(a4) # 8000a5e8 <_ZL10waitForAll>
    80003f94:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003f98:	02905863          	blez	s1,80003fc8 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003f9c:	02800513          	li	a0,40
    80003fa0:	ffffe097          	auipc	ra,0xffffe
    80003fa4:	9f8080e7          	jalr	-1544(ra) # 80001998 <_Znwm>
    80003fa8:	00050c93          	mv	s9,a0
    80003fac:	00149c13          	slli	s8,s1,0x1
    80003fb0:	009c0c33          	add	s8,s8,s1
    80003fb4:	003c1c13          	slli	s8,s8,0x3
    80003fb8:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003fbc:	ffffe097          	auipc	ra,0xffffe
    80003fc0:	c60080e7          	jalr	-928(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80003fc4:	f79ff06f          	j	80003f3c <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80003fc8:	02800513          	li	a0,40
    80003fcc:	ffffe097          	auipc	ra,0xffffe
    80003fd0:	9cc080e7          	jalr	-1588(ra) # 80001998 <_Znwm>
    80003fd4:	00050c93          	mv	s9,a0
    80003fd8:	00149c13          	slli	s8,s1,0x1
    80003fdc:	009c0c33          	add	s8,s8,s1
    80003fe0:	003c1c13          	slli	s8,s8,0x3
    80003fe4:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003fe8:	ffffe097          	auipc	ra,0xffffe
    80003fec:	c34080e7          	jalr	-972(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80003ff0:	00006797          	auipc	a5,0x6
    80003ff4:	45078793          	addi	a5,a5,1104 # 8000a440 <_ZTV16ProducerKeyboard+0x10>
    80003ff8:	00fcb023          	sd	a5,0(s9)
    80003ffc:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80004000:	00349793          	slli	a5,s1,0x3
    80004004:	00f987b3          	add	a5,s3,a5
    80004008:	0197b023          	sd	s9,0(a5)
    8000400c:	f4dff06f          	j	80003f58 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80004010:	ffffe097          	auipc	ra,0xffffe
    80004014:	be4080e7          	jalr	-1052(ra) # 80001bf4 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80004018:	00000493          	li	s1,0
    8000401c:	00994e63          	blt	s2,s1,80004038 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80004020:	00006517          	auipc	a0,0x6
    80004024:	5c853503          	ld	a0,1480(a0) # 8000a5e8 <_ZL10waitForAll>
    80004028:	ffffe097          	auipc	ra,0xffffe
    8000402c:	c80080e7          	jalr	-896(ra) # 80001ca8 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80004030:	0014849b          	addiw	s1,s1,1
    80004034:	fe9ff06f          	j	8000401c <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80004038:	00000493          	li	s1,0
    8000403c:	0080006f          	j	80004044 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80004040:	0014849b          	addiw	s1,s1,1
    80004044:	0324d263          	bge	s1,s2,80004068 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80004048:	00349793          	slli	a5,s1,0x3
    8000404c:	00f987b3          	add	a5,s3,a5
    80004050:	0007b503          	ld	a0,0(a5)
    80004054:	fe0506e3          	beqz	a0,80004040 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80004058:	00053783          	ld	a5,0(a0)
    8000405c:	0087b783          	ld	a5,8(a5)
    80004060:	000780e7          	jalr	a5
    80004064:	fddff06f          	j	80004040 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80004068:	000b0a63          	beqz	s6,8000407c <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    8000406c:	000b3783          	ld	a5,0(s6)
    80004070:	0087b783          	ld	a5,8(a5)
    80004074:	000b0513          	mv	a0,s6
    80004078:	000780e7          	jalr	a5
    delete waitForAll;
    8000407c:	00006517          	auipc	a0,0x6
    80004080:	56c53503          	ld	a0,1388(a0) # 8000a5e8 <_ZL10waitForAll>
    80004084:	00050863          	beqz	a0,80004094 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80004088:	00053783          	ld	a5,0(a0)
    8000408c:	0087b783          	ld	a5,8(a5)
    80004090:	000780e7          	jalr	a5
    delete buffer;
    80004094:	000a8e63          	beqz	s5,800040b0 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80004098:	000a8513          	mv	a0,s5
    8000409c:	00001097          	auipc	ra,0x1
    800040a0:	b6c080e7          	jalr	-1172(ra) # 80004c08 <_ZN9BufferCPPD1Ev>
    800040a4:	000a8513          	mv	a0,s5
    800040a8:	ffffe097          	auipc	ra,0xffffe
    800040ac:	940080e7          	jalr	-1728(ra) # 800019e8 <_ZdlPv>
    800040b0:	000b8113          	mv	sp,s7

}
    800040b4:	f8040113          	addi	sp,s0,-128
    800040b8:	07813083          	ld	ra,120(sp)
    800040bc:	07013403          	ld	s0,112(sp)
    800040c0:	06813483          	ld	s1,104(sp)
    800040c4:	06013903          	ld	s2,96(sp)
    800040c8:	05813983          	ld	s3,88(sp)
    800040cc:	05013a03          	ld	s4,80(sp)
    800040d0:	04813a83          	ld	s5,72(sp)
    800040d4:	04013b03          	ld	s6,64(sp)
    800040d8:	03813b83          	ld	s7,56(sp)
    800040dc:	03013c03          	ld	s8,48(sp)
    800040e0:	02813c83          	ld	s9,40(sp)
    800040e4:	08010113          	addi	sp,sp,128
    800040e8:	00008067          	ret
    800040ec:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800040f0:	000a8513          	mv	a0,s5
    800040f4:	ffffe097          	auipc	ra,0xffffe
    800040f8:	8f4080e7          	jalr	-1804(ra) # 800019e8 <_ZdlPv>
    800040fc:	00048513          	mv	a0,s1
    80004100:	00007097          	auipc	ra,0x7
    80004104:	5c8080e7          	jalr	1480(ra) # 8000b6c8 <_Unwind_Resume>
    80004108:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    8000410c:	00048513          	mv	a0,s1
    80004110:	ffffe097          	auipc	ra,0xffffe
    80004114:	8d8080e7          	jalr	-1832(ra) # 800019e8 <_ZdlPv>
    80004118:	00090513          	mv	a0,s2
    8000411c:	00007097          	auipc	ra,0x7
    80004120:	5ac080e7          	jalr	1452(ra) # 8000b6c8 <_Unwind_Resume>
    80004124:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80004128:	000b0513          	mv	a0,s6
    8000412c:	ffffe097          	auipc	ra,0xffffe
    80004130:	8bc080e7          	jalr	-1860(ra) # 800019e8 <_ZdlPv>
    80004134:	00048513          	mv	a0,s1
    80004138:	00007097          	auipc	ra,0x7
    8000413c:	590080e7          	jalr	1424(ra) # 8000b6c8 <_Unwind_Resume>
    80004140:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80004144:	000c8513          	mv	a0,s9
    80004148:	ffffe097          	auipc	ra,0xffffe
    8000414c:	8a0080e7          	jalr	-1888(ra) # 800019e8 <_ZdlPv>
    80004150:	00048513          	mv	a0,s1
    80004154:	00007097          	auipc	ra,0x7
    80004158:	574080e7          	jalr	1396(ra) # 8000b6c8 <_Unwind_Resume>
    8000415c:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80004160:	000c8513          	mv	a0,s9
    80004164:	ffffe097          	auipc	ra,0xffffe
    80004168:	884080e7          	jalr	-1916(ra) # 800019e8 <_ZdlPv>
    8000416c:	00048513          	mv	a0,s1
    80004170:	00007097          	auipc	ra,0x7
    80004174:	558080e7          	jalr	1368(ra) # 8000b6c8 <_Unwind_Resume>

0000000080004178 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80004178:	ff010113          	addi	sp,sp,-16
    8000417c:	00113423          	sd	ra,8(sp)
    80004180:	00813023          	sd	s0,0(sp)
    80004184:	01010413          	addi	s0,sp,16
    80004188:	00006797          	auipc	a5,0x6
    8000418c:	30878793          	addi	a5,a5,776 # 8000a490 <_ZTV12ConsumerSync+0x10>
    80004190:	00f53023          	sd	a5,0(a0)
    80004194:	ffffe097          	auipc	ra,0xffffe
    80004198:	8a4080e7          	jalr	-1884(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000419c:	00813083          	ld	ra,8(sp)
    800041a0:	00013403          	ld	s0,0(sp)
    800041a4:	01010113          	addi	sp,sp,16
    800041a8:	00008067          	ret

00000000800041ac <_ZN12ConsumerSyncD0Ev>:
    800041ac:	fe010113          	addi	sp,sp,-32
    800041b0:	00113c23          	sd	ra,24(sp)
    800041b4:	00813823          	sd	s0,16(sp)
    800041b8:	00913423          	sd	s1,8(sp)
    800041bc:	02010413          	addi	s0,sp,32
    800041c0:	00050493          	mv	s1,a0
    800041c4:	00006797          	auipc	a5,0x6
    800041c8:	2cc78793          	addi	a5,a5,716 # 8000a490 <_ZTV12ConsumerSync+0x10>
    800041cc:	00f53023          	sd	a5,0(a0)
    800041d0:	ffffe097          	auipc	ra,0xffffe
    800041d4:	868080e7          	jalr	-1944(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800041d8:	00048513          	mv	a0,s1
    800041dc:	ffffe097          	auipc	ra,0xffffe
    800041e0:	80c080e7          	jalr	-2036(ra) # 800019e8 <_ZdlPv>
    800041e4:	01813083          	ld	ra,24(sp)
    800041e8:	01013403          	ld	s0,16(sp)
    800041ec:	00813483          	ld	s1,8(sp)
    800041f0:	02010113          	addi	sp,sp,32
    800041f4:	00008067          	ret

00000000800041f8 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    800041f8:	ff010113          	addi	sp,sp,-16
    800041fc:	00113423          	sd	ra,8(sp)
    80004200:	00813023          	sd	s0,0(sp)
    80004204:	01010413          	addi	s0,sp,16
    80004208:	00006797          	auipc	a5,0x6
    8000420c:	26078793          	addi	a5,a5,608 # 8000a468 <_ZTV12ProducerSync+0x10>
    80004210:	00f53023          	sd	a5,0(a0)
    80004214:	ffffe097          	auipc	ra,0xffffe
    80004218:	824080e7          	jalr	-2012(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000421c:	00813083          	ld	ra,8(sp)
    80004220:	00013403          	ld	s0,0(sp)
    80004224:	01010113          	addi	sp,sp,16
    80004228:	00008067          	ret

000000008000422c <_ZN12ProducerSyncD0Ev>:
    8000422c:	fe010113          	addi	sp,sp,-32
    80004230:	00113c23          	sd	ra,24(sp)
    80004234:	00813823          	sd	s0,16(sp)
    80004238:	00913423          	sd	s1,8(sp)
    8000423c:	02010413          	addi	s0,sp,32
    80004240:	00050493          	mv	s1,a0
    80004244:	00006797          	auipc	a5,0x6
    80004248:	22478793          	addi	a5,a5,548 # 8000a468 <_ZTV12ProducerSync+0x10>
    8000424c:	00f53023          	sd	a5,0(a0)
    80004250:	ffffd097          	auipc	ra,0xffffd
    80004254:	7e8080e7          	jalr	2024(ra) # 80001a38 <_ZN6ThreadD1Ev>
    80004258:	00048513          	mv	a0,s1
    8000425c:	ffffd097          	auipc	ra,0xffffd
    80004260:	78c080e7          	jalr	1932(ra) # 800019e8 <_ZdlPv>
    80004264:	01813083          	ld	ra,24(sp)
    80004268:	01013403          	ld	s0,16(sp)
    8000426c:	00813483          	ld	s1,8(sp)
    80004270:	02010113          	addi	sp,sp,32
    80004274:	00008067          	ret

0000000080004278 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80004278:	ff010113          	addi	sp,sp,-16
    8000427c:	00113423          	sd	ra,8(sp)
    80004280:	00813023          	sd	s0,0(sp)
    80004284:	01010413          	addi	s0,sp,16
    80004288:	00006797          	auipc	a5,0x6
    8000428c:	1b878793          	addi	a5,a5,440 # 8000a440 <_ZTV16ProducerKeyboard+0x10>
    80004290:	00f53023          	sd	a5,0(a0)
    80004294:	ffffd097          	auipc	ra,0xffffd
    80004298:	7a4080e7          	jalr	1956(ra) # 80001a38 <_ZN6ThreadD1Ev>
    8000429c:	00813083          	ld	ra,8(sp)
    800042a0:	00013403          	ld	s0,0(sp)
    800042a4:	01010113          	addi	sp,sp,16
    800042a8:	00008067          	ret

00000000800042ac <_ZN16ProducerKeyboardD0Ev>:
    800042ac:	fe010113          	addi	sp,sp,-32
    800042b0:	00113c23          	sd	ra,24(sp)
    800042b4:	00813823          	sd	s0,16(sp)
    800042b8:	00913423          	sd	s1,8(sp)
    800042bc:	02010413          	addi	s0,sp,32
    800042c0:	00050493          	mv	s1,a0
    800042c4:	00006797          	auipc	a5,0x6
    800042c8:	17c78793          	addi	a5,a5,380 # 8000a440 <_ZTV16ProducerKeyboard+0x10>
    800042cc:	00f53023          	sd	a5,0(a0)
    800042d0:	ffffd097          	auipc	ra,0xffffd
    800042d4:	768080e7          	jalr	1896(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800042d8:	00048513          	mv	a0,s1
    800042dc:	ffffd097          	auipc	ra,0xffffd
    800042e0:	70c080e7          	jalr	1804(ra) # 800019e8 <_ZdlPv>
    800042e4:	01813083          	ld	ra,24(sp)
    800042e8:	01013403          	ld	s0,16(sp)
    800042ec:	00813483          	ld	s1,8(sp)
    800042f0:	02010113          	addi	sp,sp,32
    800042f4:	00008067          	ret

00000000800042f8 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    800042f8:	ff010113          	addi	sp,sp,-16
    800042fc:	00113423          	sd	ra,8(sp)
    80004300:	00813023          	sd	s0,0(sp)
    80004304:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80004308:	02053583          	ld	a1,32(a0)
    8000430c:	fffff097          	auipc	ra,0xfffff
    80004310:	7e4080e7          	jalr	2020(ra) # 80003af0 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80004314:	00813083          	ld	ra,8(sp)
    80004318:	00013403          	ld	s0,0(sp)
    8000431c:	01010113          	addi	sp,sp,16
    80004320:	00008067          	ret

0000000080004324 <_ZN12ProducerSync3runEv>:
    void run() override {
    80004324:	ff010113          	addi	sp,sp,-16
    80004328:	00113423          	sd	ra,8(sp)
    8000432c:	00813023          	sd	s0,0(sp)
    80004330:	01010413          	addi	s0,sp,16
        producer(td);
    80004334:	02053583          	ld	a1,32(a0)
    80004338:	00000097          	auipc	ra,0x0
    8000433c:	878080e7          	jalr	-1928(ra) # 80003bb0 <_ZN12ProducerSync8producerEPv>
    }
    80004340:	00813083          	ld	ra,8(sp)
    80004344:	00013403          	ld	s0,0(sp)
    80004348:	01010113          	addi	sp,sp,16
    8000434c:	00008067          	ret

0000000080004350 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80004350:	ff010113          	addi	sp,sp,-16
    80004354:	00113423          	sd	ra,8(sp)
    80004358:	00813023          	sd	s0,0(sp)
    8000435c:	01010413          	addi	s0,sp,16
        consumer(td);
    80004360:	02053583          	ld	a1,32(a0)
    80004364:	00000097          	auipc	ra,0x0
    80004368:	8e0080e7          	jalr	-1824(ra) # 80003c44 <_ZN12ConsumerSync8consumerEPv>
    }
    8000436c:	00813083          	ld	ra,8(sp)
    80004370:	00013403          	ld	s0,0(sp)
    80004374:	01010113          	addi	sp,sp,16
    80004378:	00008067          	ret

000000008000437c <_ZN10WorkerJoin14workerBodyJoinEPv>:
        workerBodyJoin(nullptr);
    }
};


void WorkerJoin::workerBodyJoin(void *arg) {
    8000437c:	fe010113          	addi	sp,sp,-32
    80004380:	00113c23          	sd	ra,24(sp)
    80004384:	00813823          	sd	s0,16(sp)
    80004388:	00913423          	sd	s1,8(sp)
    8000438c:	01213023          	sd	s2,0(sp)
    80004390:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004394:	00000913          	li	s2,0
    80004398:	0380006f          	j	800043d0 <_ZN10WorkerJoin14workerBodyJoinEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000439c:	ffffd097          	auipc	ra,0xffffd
    800043a0:	ea4080e7          	jalr	-348(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800043a4:	00148493          	addi	s1,s1,1
    800043a8:	000027b7          	lui	a5,0x2
    800043ac:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800043b0:	0097ee63          	bltu	a5,s1,800043cc <_ZN10WorkerJoin14workerBodyJoinEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800043b4:	00000713          	li	a4,0
    800043b8:	000077b7          	lui	a5,0x7
    800043bc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800043c0:	fce7eee3          	bltu	a5,a4,8000439c <_ZN10WorkerJoin14workerBodyJoinEPv+0x20>
    800043c4:	00170713          	addi	a4,a4,1
    800043c8:	ff1ff06f          	j	800043b8 <_ZN10WorkerJoin14workerBodyJoinEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800043cc:	00190913          	addi	s2,s2,1
    800043d0:	00900793          	li	a5,9
    800043d4:	0527e063          	bltu	a5,s2,80004414 <_ZN10WorkerJoin14workerBodyJoinEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800043d8:	00004517          	auipc	a0,0x4
    800043dc:	0e050513          	addi	a0,a0,224 # 800084b8 <CONSOLE_STATUS+0x4a8>
    800043e0:	00000097          	auipc	ra,0x0
    800043e4:	260080e7          	jalr	608(ra) # 80004640 <_Z11printStringPKc>
    800043e8:	00000613          	li	a2,0
    800043ec:	00a00593          	li	a1,10
    800043f0:	0009051b          	sext.w	a0,s2
    800043f4:	00000097          	auipc	ra,0x0
    800043f8:	3fc080e7          	jalr	1020(ra) # 800047f0 <_Z8printIntiii>
    800043fc:	00004517          	auipc	a0,0x4
    80004400:	1d450513          	addi	a0,a0,468 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004404:	00000097          	auipc	ra,0x0
    80004408:	23c080e7          	jalr	572(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000440c:	00000493          	li	s1,0
    80004410:	f99ff06f          	j	800043a8 <_ZN10WorkerJoin14workerBodyJoinEPv+0x2c>
        }
    }
    printString("worker finished!\n");
    80004414:	00004517          	auipc	a0,0x4
    80004418:	1ac50513          	addi	a0,a0,428 # 800085c0 <CONSOLE_STATUS+0x5b0>
    8000441c:	00000097          	auipc	ra,0x0
    80004420:	224080e7          	jalr	548(ra) # 80004640 <_Z11printStringPKc>
}
    80004424:	01813083          	ld	ra,24(sp)
    80004428:	01013403          	ld	s0,16(sp)
    8000442c:	00813483          	ld	s1,8(sp)
    80004430:	00013903          	ld	s2,0(sp)
    80004434:	02010113          	addi	sp,sp,32
    80004438:	00008067          	ret

000000008000443c <_Z15ThreadJoin_testv>:


void ThreadJoin_test() {
    8000443c:	fd010113          	addi	sp,sp,-48
    80004440:	02113423          	sd	ra,40(sp)
    80004444:	02813023          	sd	s0,32(sp)
    80004448:	00913c23          	sd	s1,24(sp)
    8000444c:	01213823          	sd	s2,16(sp)
    80004450:	03010413          	addi	s0,sp,48
    Thread* threads[2];

    threads[0] = new WorkerJoin();
    80004454:	02000513          	li	a0,32
    80004458:	ffffd097          	auipc	ra,0xffffd
    8000445c:	540080e7          	jalr	1344(ra) # 80001998 <_Znwm>
    80004460:	00050493          	mv	s1,a0
    WorkerJoin():Thread() {}
    80004464:	ffffd097          	auipc	ra,0xffffd
    80004468:	7b8080e7          	jalr	1976(ra) # 80001c1c <_ZN6ThreadC1Ev>
    8000446c:	00006797          	auipc	a5,0x6
    80004470:	04c78793          	addi	a5,a5,76 # 8000a4b8 <_ZTV10WorkerJoin+0x10>
    80004474:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerJoin();
    80004478:	fc943823          	sd	s1,-48(s0)
    printString("Worker created\n");
    8000447c:	00004517          	auipc	a0,0x4
    80004480:	15c50513          	addi	a0,a0,348 # 800085d8 <CONSOLE_STATUS+0x5c8>
    80004484:	00000097          	auipc	ra,0x0
    80004488:	1bc080e7          	jalr	444(ra) # 80004640 <_Z11printStringPKc>

    threads[1] = new WorkerJoin();
    8000448c:	02000513          	li	a0,32
    80004490:	ffffd097          	auipc	ra,0xffffd
    80004494:	508080e7          	jalr	1288(ra) # 80001998 <_Znwm>
    80004498:	00050493          	mv	s1,a0
    WorkerJoin():Thread() {}
    8000449c:	ffffd097          	auipc	ra,0xffffd
    800044a0:	780080e7          	jalr	1920(ra) # 80001c1c <_ZN6ThreadC1Ev>
    800044a4:	00006797          	auipc	a5,0x6
    800044a8:	01478793          	addi	a5,a5,20 # 8000a4b8 <_ZTV10WorkerJoin+0x10>
    800044ac:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerJoin();
    800044b0:	fc943c23          	sd	s1,-40(s0)
    printString("Worker created\n");
    800044b4:	00004517          	auipc	a0,0x4
    800044b8:	12450513          	addi	a0,a0,292 # 800085d8 <CONSOLE_STATUS+0x5c8>
    800044bc:	00000097          	auipc	ra,0x0
    800044c0:	184080e7          	jalr	388(ra) # 80004640 <_Z11printStringPKc>

    for(int i=0; i<2; i++) {
    800044c4:	00000493          	li	s1,0
    800044c8:	0200006f          	j	800044e8 <_Z15ThreadJoin_testv+0xac>
        threads[i]->start();
    800044cc:	00349793          	slli	a5,s1,0x3
    800044d0:	fe040713          	addi	a4,s0,-32
    800044d4:	00f707b3          	add	a5,a4,a5
    800044d8:	ff07b503          	ld	a0,-16(a5)
    800044dc:	ffffd097          	auipc	ra,0xffffd
    800044e0:	6e4080e7          	jalr	1764(ra) # 80001bc0 <_ZN6Thread5startEv>
    for(int i=0; i<2; i++) {
    800044e4:	0014849b          	addiw	s1,s1,1
    800044e8:	00100793          	li	a5,1
    800044ec:	fe97d0e3          	bge	a5,s1,800044cc <_Z15ThreadJoin_testv+0x90>
    }

    threads[0]->join();
    800044f0:	fd043503          	ld	a0,-48(s0)
    800044f4:	ffffd097          	auipc	ra,0xffffd
    800044f8:	788080e7          	jalr	1928(ra) # 80001c7c <_ZN6Thread4joinEv>
    threads[1]->join();
    800044fc:	fd843503          	ld	a0,-40(s0)
    80004500:	ffffd097          	auipc	ra,0xffffd
    80004504:	77c080e7          	jalr	1916(ra) # 80001c7c <_ZN6Thread4joinEv>
    printString("Main nit zavrsena\n");
    80004508:	00004517          	auipc	a0,0x4
    8000450c:	0e050513          	addi	a0,a0,224 # 800085e8 <CONSOLE_STATUS+0x5d8>
    80004510:	00000097          	auipc	ra,0x0
    80004514:	130080e7          	jalr	304(ra) # 80004640 <_Z11printStringPKc>
    for (auto thread: threads) { delete thread; }
    80004518:	fd040493          	addi	s1,s0,-48
    8000451c:	0080006f          	j	80004524 <_Z15ThreadJoin_testv+0xe8>
    80004520:	00848493          	addi	s1,s1,8
    80004524:	fe040793          	addi	a5,s0,-32
    80004528:	04f48a63          	beq	s1,a5,8000457c <_Z15ThreadJoin_testv+0x140>
    8000452c:	0004b503          	ld	a0,0(s1)
    80004530:	fe0508e3          	beqz	a0,80004520 <_Z15ThreadJoin_testv+0xe4>
    80004534:	00053783          	ld	a5,0(a0)
    80004538:	0087b783          	ld	a5,8(a5)
    8000453c:	000780e7          	jalr	a5
    80004540:	fe1ff06f          	j	80004520 <_Z15ThreadJoin_testv+0xe4>
    80004544:	00050913          	mv	s2,a0
    threads[0] = new WorkerJoin();
    80004548:	00048513          	mv	a0,s1
    8000454c:	ffffd097          	auipc	ra,0xffffd
    80004550:	49c080e7          	jalr	1180(ra) # 800019e8 <_ZdlPv>
    80004554:	00090513          	mv	a0,s2
    80004558:	00007097          	auipc	ra,0x7
    8000455c:	170080e7          	jalr	368(ra) # 8000b6c8 <_Unwind_Resume>
    80004560:	00050913          	mv	s2,a0
    threads[1] = new WorkerJoin();
    80004564:	00048513          	mv	a0,s1
    80004568:	ffffd097          	auipc	ra,0xffffd
    8000456c:	480080e7          	jalr	1152(ra) # 800019e8 <_ZdlPv>
    80004570:	00090513          	mv	a0,s2
    80004574:	00007097          	auipc	ra,0x7
    80004578:	154080e7          	jalr	340(ra) # 8000b6c8 <_Unwind_Resume>
}
    8000457c:	02813083          	ld	ra,40(sp)
    80004580:	02013403          	ld	s0,32(sp)
    80004584:	01813483          	ld	s1,24(sp)
    80004588:	01013903          	ld	s2,16(sp)
    8000458c:	03010113          	addi	sp,sp,48
    80004590:	00008067          	ret

0000000080004594 <_ZN10WorkerJoinD1Ev>:
class WorkerJoin: public Thread {
    80004594:	ff010113          	addi	sp,sp,-16
    80004598:	00113423          	sd	ra,8(sp)
    8000459c:	00813023          	sd	s0,0(sp)
    800045a0:	01010413          	addi	s0,sp,16
    800045a4:	00006797          	auipc	a5,0x6
    800045a8:	f1478793          	addi	a5,a5,-236 # 8000a4b8 <_ZTV10WorkerJoin+0x10>
    800045ac:	00f53023          	sd	a5,0(a0)
    800045b0:	ffffd097          	auipc	ra,0xffffd
    800045b4:	488080e7          	jalr	1160(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800045b8:	00813083          	ld	ra,8(sp)
    800045bc:	00013403          	ld	s0,0(sp)
    800045c0:	01010113          	addi	sp,sp,16
    800045c4:	00008067          	ret

00000000800045c8 <_ZN10WorkerJoinD0Ev>:
    800045c8:	fe010113          	addi	sp,sp,-32
    800045cc:	00113c23          	sd	ra,24(sp)
    800045d0:	00813823          	sd	s0,16(sp)
    800045d4:	00913423          	sd	s1,8(sp)
    800045d8:	02010413          	addi	s0,sp,32
    800045dc:	00050493          	mv	s1,a0
    800045e0:	00006797          	auipc	a5,0x6
    800045e4:	ed878793          	addi	a5,a5,-296 # 8000a4b8 <_ZTV10WorkerJoin+0x10>
    800045e8:	00f53023          	sd	a5,0(a0)
    800045ec:	ffffd097          	auipc	ra,0xffffd
    800045f0:	44c080e7          	jalr	1100(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800045f4:	00048513          	mv	a0,s1
    800045f8:	ffffd097          	auipc	ra,0xffffd
    800045fc:	3f0080e7          	jalr	1008(ra) # 800019e8 <_ZdlPv>
    80004600:	01813083          	ld	ra,24(sp)
    80004604:	01013403          	ld	s0,16(sp)
    80004608:	00813483          	ld	s1,8(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret

0000000080004614 <_ZN10WorkerJoin3runEv>:
    void run() override {
    80004614:	ff010113          	addi	sp,sp,-16
    80004618:	00113423          	sd	ra,8(sp)
    8000461c:	00813023          	sd	s0,0(sp)
    80004620:	01010413          	addi	s0,sp,16
        workerBodyJoin(nullptr);
    80004624:	00000593          	li	a1,0
    80004628:	00000097          	auipc	ra,0x0
    8000462c:	d54080e7          	jalr	-684(ra) # 8000437c <_ZN10WorkerJoin14workerBodyJoinEPv>
    }
    80004630:	00813083          	ld	ra,8(sp)
    80004634:	00013403          	ld	s0,0(sp)
    80004638:	01010113          	addi	sp,sp,16
    8000463c:	00008067          	ret

0000000080004640 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80004640:	fe010113          	addi	sp,sp,-32
    80004644:	00113c23          	sd	ra,24(sp)
    80004648:	00813823          	sd	s0,16(sp)
    8000464c:	00913423          	sd	s1,8(sp)
    80004650:	02010413          	addi	s0,sp,32
    80004654:	00050493          	mv	s1,a0
    LOCK();
    80004658:	00100613          	li	a2,1
    8000465c:	00000593          	li	a1,0
    80004660:	00006517          	auipc	a0,0x6
    80004664:	f9050513          	addi	a0,a0,-112 # 8000a5f0 <lockPrint>
    80004668:	ffffd097          	auipc	ra,0xffffd
    8000466c:	998080e7          	jalr	-1640(ra) # 80001000 <copy_and_swap>
    80004670:	00050863          	beqz	a0,80004680 <_Z11printStringPKc+0x40>
    80004674:	ffffd097          	auipc	ra,0xffffd
    80004678:	bcc080e7          	jalr	-1076(ra) # 80001240 <_Z15thread_dispatchv>
    8000467c:	fddff06f          	j	80004658 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80004680:	0004c503          	lbu	a0,0(s1)
    80004684:	00050a63          	beqz	a0,80004698 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004688:	ffffd097          	auipc	ra,0xffffd
    8000468c:	cb8080e7          	jalr	-840(ra) # 80001340 <_Z4putcc>
        string++;
    80004690:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004694:	fedff06f          	j	80004680 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004698:	00000613          	li	a2,0
    8000469c:	00100593          	li	a1,1
    800046a0:	00006517          	auipc	a0,0x6
    800046a4:	f5050513          	addi	a0,a0,-176 # 8000a5f0 <lockPrint>
    800046a8:	ffffd097          	auipc	ra,0xffffd
    800046ac:	958080e7          	jalr	-1704(ra) # 80001000 <copy_and_swap>
    800046b0:	fe0514e3          	bnez	a0,80004698 <_Z11printStringPKc+0x58>
}
    800046b4:	01813083          	ld	ra,24(sp)
    800046b8:	01013403          	ld	s0,16(sp)
    800046bc:	00813483          	ld	s1,8(sp)
    800046c0:	02010113          	addi	sp,sp,32
    800046c4:	00008067          	ret

00000000800046c8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800046c8:	fd010113          	addi	sp,sp,-48
    800046cc:	02113423          	sd	ra,40(sp)
    800046d0:	02813023          	sd	s0,32(sp)
    800046d4:	00913c23          	sd	s1,24(sp)
    800046d8:	01213823          	sd	s2,16(sp)
    800046dc:	01313423          	sd	s3,8(sp)
    800046e0:	01413023          	sd	s4,0(sp)
    800046e4:	03010413          	addi	s0,sp,48
    800046e8:	00050993          	mv	s3,a0
    800046ec:	00058a13          	mv	s4,a1
    LOCK();
    800046f0:	00100613          	li	a2,1
    800046f4:	00000593          	li	a1,0
    800046f8:	00006517          	auipc	a0,0x6
    800046fc:	ef850513          	addi	a0,a0,-264 # 8000a5f0 <lockPrint>
    80004700:	ffffd097          	auipc	ra,0xffffd
    80004704:	900080e7          	jalr	-1792(ra) # 80001000 <copy_and_swap>
    80004708:	00050863          	beqz	a0,80004718 <_Z9getStringPci+0x50>
    8000470c:	ffffd097          	auipc	ra,0xffffd
    80004710:	b34080e7          	jalr	-1228(ra) # 80001240 <_Z15thread_dispatchv>
    80004714:	fddff06f          	j	800046f0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80004718:	00000913          	li	s2,0
    8000471c:	00090493          	mv	s1,s2
    80004720:	0019091b          	addiw	s2,s2,1
    80004724:	03495a63          	bge	s2,s4,80004758 <_Z9getStringPci+0x90>
        cc = getc();
    80004728:	ffffd097          	auipc	ra,0xffffd
    8000472c:	bec080e7          	jalr	-1044(ra) # 80001314 <_Z4getcv>
        if(cc < 1)
    80004730:	02050463          	beqz	a0,80004758 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80004734:	009984b3          	add	s1,s3,s1
    80004738:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000473c:	00a00793          	li	a5,10
    80004740:	00f50a63          	beq	a0,a5,80004754 <_Z9getStringPci+0x8c>
    80004744:	00d00793          	li	a5,13
    80004748:	fcf51ae3          	bne	a0,a5,8000471c <_Z9getStringPci+0x54>
        buf[i++] = c;
    8000474c:	00090493          	mv	s1,s2
    80004750:	0080006f          	j	80004758 <_Z9getStringPci+0x90>
    80004754:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80004758:	009984b3          	add	s1,s3,s1
    8000475c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80004760:	00000613          	li	a2,0
    80004764:	00100593          	li	a1,1
    80004768:	00006517          	auipc	a0,0x6
    8000476c:	e8850513          	addi	a0,a0,-376 # 8000a5f0 <lockPrint>
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	890080e7          	jalr	-1904(ra) # 80001000 <copy_and_swap>
    80004778:	fe0514e3          	bnez	a0,80004760 <_Z9getStringPci+0x98>
    return buf;
}
    8000477c:	00098513          	mv	a0,s3
    80004780:	02813083          	ld	ra,40(sp)
    80004784:	02013403          	ld	s0,32(sp)
    80004788:	01813483          	ld	s1,24(sp)
    8000478c:	01013903          	ld	s2,16(sp)
    80004790:	00813983          	ld	s3,8(sp)
    80004794:	00013a03          	ld	s4,0(sp)
    80004798:	03010113          	addi	sp,sp,48
    8000479c:	00008067          	ret

00000000800047a0 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800047a0:	ff010113          	addi	sp,sp,-16
    800047a4:	00813423          	sd	s0,8(sp)
    800047a8:	01010413          	addi	s0,sp,16
    800047ac:	00050693          	mv	a3,a0
    int n;

    n = 0;
    800047b0:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    800047b4:	0006c603          	lbu	a2,0(a3)
    800047b8:	fd06071b          	addiw	a4,a2,-48
    800047bc:	0ff77713          	andi	a4,a4,255
    800047c0:	00900793          	li	a5,9
    800047c4:	02e7e063          	bltu	a5,a4,800047e4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800047c8:	0025179b          	slliw	a5,a0,0x2
    800047cc:	00a787bb          	addw	a5,a5,a0
    800047d0:	0017979b          	slliw	a5,a5,0x1
    800047d4:	00168693          	addi	a3,a3,1
    800047d8:	00c787bb          	addw	a5,a5,a2
    800047dc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800047e0:	fd5ff06f          	j	800047b4 <_Z11stringToIntPKc+0x14>
    return n;
}
    800047e4:	00813403          	ld	s0,8(sp)
    800047e8:	01010113          	addi	sp,sp,16
    800047ec:	00008067          	ret

00000000800047f0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800047f0:	fc010113          	addi	sp,sp,-64
    800047f4:	02113c23          	sd	ra,56(sp)
    800047f8:	02813823          	sd	s0,48(sp)
    800047fc:	02913423          	sd	s1,40(sp)
    80004800:	03213023          	sd	s2,32(sp)
    80004804:	01313c23          	sd	s3,24(sp)
    80004808:	04010413          	addi	s0,sp,64
    8000480c:	00050493          	mv	s1,a0
    80004810:	00058913          	mv	s2,a1
    80004814:	00060993          	mv	s3,a2
    LOCK();
    80004818:	00100613          	li	a2,1
    8000481c:	00000593          	li	a1,0
    80004820:	00006517          	auipc	a0,0x6
    80004824:	dd050513          	addi	a0,a0,-560 # 8000a5f0 <lockPrint>
    80004828:	ffffc097          	auipc	ra,0xffffc
    8000482c:	7d8080e7          	jalr	2008(ra) # 80001000 <copy_and_swap>
    80004830:	00050863          	beqz	a0,80004840 <_Z8printIntiii+0x50>
    80004834:	ffffd097          	auipc	ra,0xffffd
    80004838:	a0c080e7          	jalr	-1524(ra) # 80001240 <_Z15thread_dispatchv>
    8000483c:	fddff06f          	j	80004818 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004840:	00098463          	beqz	s3,80004848 <_Z8printIntiii+0x58>
    80004844:	0804c463          	bltz	s1,800048cc <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004848:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000484c:	00000593          	li	a1,0
    }

    i = 0;
    80004850:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004854:	0009079b          	sext.w	a5,s2
    80004858:	0325773b          	remuw	a4,a0,s2
    8000485c:	00048613          	mv	a2,s1
    80004860:	0014849b          	addiw	s1,s1,1
    80004864:	02071693          	slli	a3,a4,0x20
    80004868:	0206d693          	srli	a3,a3,0x20
    8000486c:	00006717          	auipc	a4,0x6
    80004870:	c6470713          	addi	a4,a4,-924 # 8000a4d0 <digits>
    80004874:	00d70733          	add	a4,a4,a3
    80004878:	00074683          	lbu	a3,0(a4)
    8000487c:	fd040713          	addi	a4,s0,-48
    80004880:	00c70733          	add	a4,a4,a2
    80004884:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004888:	0005071b          	sext.w	a4,a0
    8000488c:	0325553b          	divuw	a0,a0,s2
    80004890:	fcf772e3          	bgeu	a4,a5,80004854 <_Z8printIntiii+0x64>
    if(neg)
    80004894:	00058c63          	beqz	a1,800048ac <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004898:	fd040793          	addi	a5,s0,-48
    8000489c:	009784b3          	add	s1,a5,s1
    800048a0:	02d00793          	li	a5,45
    800048a4:	fef48823          	sb	a5,-16(s1)
    800048a8:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    800048ac:	fff4849b          	addiw	s1,s1,-1
    800048b0:	0204c463          	bltz	s1,800048d8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    800048b4:	fd040793          	addi	a5,s0,-48
    800048b8:	009787b3          	add	a5,a5,s1
    800048bc:	ff07c503          	lbu	a0,-16(a5)
    800048c0:	ffffd097          	auipc	ra,0xffffd
    800048c4:	a80080e7          	jalr	-1408(ra) # 80001340 <_Z4putcc>
    800048c8:	fe5ff06f          	j	800048ac <_Z8printIntiii+0xbc>
        x = -xx;
    800048cc:	4090053b          	negw	a0,s1
        neg = 1;
    800048d0:	00100593          	li	a1,1
        x = -xx;
    800048d4:	f7dff06f          	j	80004850 <_Z8printIntiii+0x60>

    UNLOCK();
    800048d8:	00000613          	li	a2,0
    800048dc:	00100593          	li	a1,1
    800048e0:	00006517          	auipc	a0,0x6
    800048e4:	d1050513          	addi	a0,a0,-752 # 8000a5f0 <lockPrint>
    800048e8:	ffffc097          	auipc	ra,0xffffc
    800048ec:	718080e7          	jalr	1816(ra) # 80001000 <copy_and_swap>
    800048f0:	fe0514e3          	bnez	a0,800048d8 <_Z8printIntiii+0xe8>
    800048f4:	03813083          	ld	ra,56(sp)
    800048f8:	03013403          	ld	s0,48(sp)
    800048fc:	02813483          	ld	s1,40(sp)
    80004900:	02013903          	ld	s2,32(sp)
    80004904:	01813983          	ld	s3,24(sp)
    80004908:	04010113          	addi	sp,sp,64
    8000490c:	00008067          	ret

0000000080004910 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004910:	fd010113          	addi	sp,sp,-48
    80004914:	02113423          	sd	ra,40(sp)
    80004918:	02813023          	sd	s0,32(sp)
    8000491c:	00913c23          	sd	s1,24(sp)
    80004920:	01213823          	sd	s2,16(sp)
    80004924:	01313423          	sd	s3,8(sp)
    80004928:	03010413          	addi	s0,sp,48
    8000492c:	00050493          	mv	s1,a0
    80004930:	00058913          	mv	s2,a1
    80004934:	0015879b          	addiw	a5,a1,1
    80004938:	0007851b          	sext.w	a0,a5
    8000493c:	00f4a023          	sw	a5,0(s1)
    80004940:	0004a823          	sw	zero,16(s1)
    80004944:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004948:	00251513          	slli	a0,a0,0x2
    8000494c:	ffffc097          	auipc	ra,0xffffc
    80004950:	7f8080e7          	jalr	2040(ra) # 80001144 <_Z9mem_allocm>
    80004954:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004958:	01000513          	li	a0,16
    8000495c:	ffffd097          	auipc	ra,0xffffd
    80004960:	03c080e7          	jalr	60(ra) # 80001998 <_Znwm>
    80004964:	00050993          	mv	s3,a0
    80004968:	00000593          	li	a1,0
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	394080e7          	jalr	916(ra) # 80001d00 <_ZN9SemaphoreC1Ej>
    80004974:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004978:	01000513          	li	a0,16
    8000497c:	ffffd097          	auipc	ra,0xffffd
    80004980:	01c080e7          	jalr	28(ra) # 80001998 <_Znwm>
    80004984:	00050993          	mv	s3,a0
    80004988:	00090593          	mv	a1,s2
    8000498c:	ffffd097          	auipc	ra,0xffffd
    80004990:	374080e7          	jalr	884(ra) # 80001d00 <_ZN9SemaphoreC1Ej>
    80004994:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004998:	01000513          	li	a0,16
    8000499c:	ffffd097          	auipc	ra,0xffffd
    800049a0:	ffc080e7          	jalr	-4(ra) # 80001998 <_Znwm>
    800049a4:	00050913          	mv	s2,a0
    800049a8:	00100593          	li	a1,1
    800049ac:	ffffd097          	auipc	ra,0xffffd
    800049b0:	354080e7          	jalr	852(ra) # 80001d00 <_ZN9SemaphoreC1Ej>
    800049b4:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    800049b8:	01000513          	li	a0,16
    800049bc:	ffffd097          	auipc	ra,0xffffd
    800049c0:	fdc080e7          	jalr	-36(ra) # 80001998 <_Znwm>
    800049c4:	00050913          	mv	s2,a0
    800049c8:	00100593          	li	a1,1
    800049cc:	ffffd097          	auipc	ra,0xffffd
    800049d0:	334080e7          	jalr	820(ra) # 80001d00 <_ZN9SemaphoreC1Ej>
    800049d4:	0324b823          	sd	s2,48(s1)
}
    800049d8:	02813083          	ld	ra,40(sp)
    800049dc:	02013403          	ld	s0,32(sp)
    800049e0:	01813483          	ld	s1,24(sp)
    800049e4:	01013903          	ld	s2,16(sp)
    800049e8:	00813983          	ld	s3,8(sp)
    800049ec:	03010113          	addi	sp,sp,48
    800049f0:	00008067          	ret
    800049f4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800049f8:	00098513          	mv	a0,s3
    800049fc:	ffffd097          	auipc	ra,0xffffd
    80004a00:	fec080e7          	jalr	-20(ra) # 800019e8 <_ZdlPv>
    80004a04:	00048513          	mv	a0,s1
    80004a08:	00007097          	auipc	ra,0x7
    80004a0c:	cc0080e7          	jalr	-832(ra) # 8000b6c8 <_Unwind_Resume>
    80004a10:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80004a14:	00098513          	mv	a0,s3
    80004a18:	ffffd097          	auipc	ra,0xffffd
    80004a1c:	fd0080e7          	jalr	-48(ra) # 800019e8 <_ZdlPv>
    80004a20:	00048513          	mv	a0,s1
    80004a24:	00007097          	auipc	ra,0x7
    80004a28:	ca4080e7          	jalr	-860(ra) # 8000b6c8 <_Unwind_Resume>
    80004a2c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004a30:	00090513          	mv	a0,s2
    80004a34:	ffffd097          	auipc	ra,0xffffd
    80004a38:	fb4080e7          	jalr	-76(ra) # 800019e8 <_ZdlPv>
    80004a3c:	00048513          	mv	a0,s1
    80004a40:	00007097          	auipc	ra,0x7
    80004a44:	c88080e7          	jalr	-888(ra) # 8000b6c8 <_Unwind_Resume>
    80004a48:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80004a4c:	00090513          	mv	a0,s2
    80004a50:	ffffd097          	auipc	ra,0xffffd
    80004a54:	f98080e7          	jalr	-104(ra) # 800019e8 <_ZdlPv>
    80004a58:	00048513          	mv	a0,s1
    80004a5c:	00007097          	auipc	ra,0x7
    80004a60:	c6c080e7          	jalr	-916(ra) # 8000b6c8 <_Unwind_Resume>

0000000080004a64 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004a64:	fe010113          	addi	sp,sp,-32
    80004a68:	00113c23          	sd	ra,24(sp)
    80004a6c:	00813823          	sd	s0,16(sp)
    80004a70:	00913423          	sd	s1,8(sp)
    80004a74:	01213023          	sd	s2,0(sp)
    80004a78:	02010413          	addi	s0,sp,32
    80004a7c:	00050493          	mv	s1,a0
    80004a80:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004a84:	01853503          	ld	a0,24(a0)
    80004a88:	ffffd097          	auipc	ra,0xffffd
    80004a8c:	220080e7          	jalr	544(ra) # 80001ca8 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004a90:	0304b503          	ld	a0,48(s1)
    80004a94:	ffffd097          	auipc	ra,0xffffd
    80004a98:	214080e7          	jalr	532(ra) # 80001ca8 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80004a9c:	0084b783          	ld	a5,8(s1)
    80004aa0:	0144a703          	lw	a4,20(s1)
    80004aa4:	00271713          	slli	a4,a4,0x2
    80004aa8:	00e787b3          	add	a5,a5,a4
    80004aac:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004ab0:	0144a783          	lw	a5,20(s1)
    80004ab4:	0017879b          	addiw	a5,a5,1
    80004ab8:	0004a703          	lw	a4,0(s1)
    80004abc:	02e7e7bb          	remw	a5,a5,a4
    80004ac0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80004ac4:	0304b503          	ld	a0,48(s1)
    80004ac8:	ffffd097          	auipc	ra,0xffffd
    80004acc:	20c080e7          	jalr	524(ra) # 80001cd4 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80004ad0:	0204b503          	ld	a0,32(s1)
    80004ad4:	ffffd097          	auipc	ra,0xffffd
    80004ad8:	200080e7          	jalr	512(ra) # 80001cd4 <_ZN9Semaphore6signalEv>

}
    80004adc:	01813083          	ld	ra,24(sp)
    80004ae0:	01013403          	ld	s0,16(sp)
    80004ae4:	00813483          	ld	s1,8(sp)
    80004ae8:	00013903          	ld	s2,0(sp)
    80004aec:	02010113          	addi	sp,sp,32
    80004af0:	00008067          	ret

0000000080004af4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80004af4:	fe010113          	addi	sp,sp,-32
    80004af8:	00113c23          	sd	ra,24(sp)
    80004afc:	00813823          	sd	s0,16(sp)
    80004b00:	00913423          	sd	s1,8(sp)
    80004b04:	01213023          	sd	s2,0(sp)
    80004b08:	02010413          	addi	s0,sp,32
    80004b0c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80004b10:	02053503          	ld	a0,32(a0)
    80004b14:	ffffd097          	auipc	ra,0xffffd
    80004b18:	194080e7          	jalr	404(ra) # 80001ca8 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80004b1c:	0284b503          	ld	a0,40(s1)
    80004b20:	ffffd097          	auipc	ra,0xffffd
    80004b24:	188080e7          	jalr	392(ra) # 80001ca8 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004b28:	0084b703          	ld	a4,8(s1)
    80004b2c:	0104a783          	lw	a5,16(s1)
    80004b30:	00279693          	slli	a3,a5,0x2
    80004b34:	00d70733          	add	a4,a4,a3
    80004b38:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004b3c:	0017879b          	addiw	a5,a5,1
    80004b40:	0004a703          	lw	a4,0(s1)
    80004b44:	02e7e7bb          	remw	a5,a5,a4
    80004b48:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80004b4c:	0284b503          	ld	a0,40(s1)
    80004b50:	ffffd097          	auipc	ra,0xffffd
    80004b54:	184080e7          	jalr	388(ra) # 80001cd4 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004b58:	0184b503          	ld	a0,24(s1)
    80004b5c:	ffffd097          	auipc	ra,0xffffd
    80004b60:	178080e7          	jalr	376(ra) # 80001cd4 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004b64:	00090513          	mv	a0,s2
    80004b68:	01813083          	ld	ra,24(sp)
    80004b6c:	01013403          	ld	s0,16(sp)
    80004b70:	00813483          	ld	s1,8(sp)
    80004b74:	00013903          	ld	s2,0(sp)
    80004b78:	02010113          	addi	sp,sp,32
    80004b7c:	00008067          	ret

0000000080004b80 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004b80:	fe010113          	addi	sp,sp,-32
    80004b84:	00113c23          	sd	ra,24(sp)
    80004b88:	00813823          	sd	s0,16(sp)
    80004b8c:	00913423          	sd	s1,8(sp)
    80004b90:	01213023          	sd	s2,0(sp)
    80004b94:	02010413          	addi	s0,sp,32
    80004b98:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80004b9c:	02853503          	ld	a0,40(a0)
    80004ba0:	ffffd097          	auipc	ra,0xffffd
    80004ba4:	108080e7          	jalr	264(ra) # 80001ca8 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004ba8:	0304b503          	ld	a0,48(s1)
    80004bac:	ffffd097          	auipc	ra,0xffffd
    80004bb0:	0fc080e7          	jalr	252(ra) # 80001ca8 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004bb4:	0144a783          	lw	a5,20(s1)
    80004bb8:	0104a903          	lw	s2,16(s1)
    80004bbc:	0327ce63          	blt	a5,s2,80004bf8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80004bc0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80004bc4:	0304b503          	ld	a0,48(s1)
    80004bc8:	ffffd097          	auipc	ra,0xffffd
    80004bcc:	10c080e7          	jalr	268(ra) # 80001cd4 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80004bd0:	0284b503          	ld	a0,40(s1)
    80004bd4:	ffffd097          	auipc	ra,0xffffd
    80004bd8:	100080e7          	jalr	256(ra) # 80001cd4 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004bdc:	00090513          	mv	a0,s2
    80004be0:	01813083          	ld	ra,24(sp)
    80004be4:	01013403          	ld	s0,16(sp)
    80004be8:	00813483          	ld	s1,8(sp)
    80004bec:	00013903          	ld	s2,0(sp)
    80004bf0:	02010113          	addi	sp,sp,32
    80004bf4:	00008067          	ret
        ret = cap - head + tail;
    80004bf8:	0004a703          	lw	a4,0(s1)
    80004bfc:	4127093b          	subw	s2,a4,s2
    80004c00:	00f9093b          	addw	s2,s2,a5
    80004c04:	fc1ff06f          	j	80004bc4 <_ZN9BufferCPP6getCntEv+0x44>

0000000080004c08 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80004c08:	fe010113          	addi	sp,sp,-32
    80004c0c:	00113c23          	sd	ra,24(sp)
    80004c10:	00813823          	sd	s0,16(sp)
    80004c14:	00913423          	sd	s1,8(sp)
    80004c18:	02010413          	addi	s0,sp,32
    80004c1c:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004c20:	00a00513          	li	a0,10
    80004c24:	ffffd097          	auipc	ra,0xffffd
    80004c28:	f20080e7          	jalr	-224(ra) # 80001b44 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80004c2c:	00004517          	auipc	a0,0x4
    80004c30:	9d450513          	addi	a0,a0,-1580 # 80008600 <CONSOLE_STATUS+0x5f0>
    80004c34:	00000097          	auipc	ra,0x0
    80004c38:	a0c080e7          	jalr	-1524(ra) # 80004640 <_Z11printStringPKc>
    while (getCnt()) {
    80004c3c:	00048513          	mv	a0,s1
    80004c40:	00000097          	auipc	ra,0x0
    80004c44:	f40080e7          	jalr	-192(ra) # 80004b80 <_ZN9BufferCPP6getCntEv>
    80004c48:	02050c63          	beqz	a0,80004c80 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80004c4c:	0084b783          	ld	a5,8(s1)
    80004c50:	0104a703          	lw	a4,16(s1)
    80004c54:	00271713          	slli	a4,a4,0x2
    80004c58:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80004c5c:	0007c503          	lbu	a0,0(a5)
    80004c60:	ffffd097          	auipc	ra,0xffffd
    80004c64:	ee4080e7          	jalr	-284(ra) # 80001b44 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004c68:	0104a783          	lw	a5,16(s1)
    80004c6c:	0017879b          	addiw	a5,a5,1
    80004c70:	0004a703          	lw	a4,0(s1)
    80004c74:	02e7e7bb          	remw	a5,a5,a4
    80004c78:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80004c7c:	fc1ff06f          	j	80004c3c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004c80:	02100513          	li	a0,33
    80004c84:	ffffd097          	auipc	ra,0xffffd
    80004c88:	ec0080e7          	jalr	-320(ra) # 80001b44 <_ZN7Console4putcEc>
    Console::putc('\n');
    80004c8c:	00a00513          	li	a0,10
    80004c90:	ffffd097          	auipc	ra,0xffffd
    80004c94:	eb4080e7          	jalr	-332(ra) # 80001b44 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004c98:	0084b503          	ld	a0,8(s1)
    80004c9c:	ffffc097          	auipc	ra,0xffffc
    80004ca0:	4d0080e7          	jalr	1232(ra) # 8000116c <_Z8mem_freePv>
    delete itemAvailable;
    80004ca4:	0204b503          	ld	a0,32(s1)
    80004ca8:	00050863          	beqz	a0,80004cb8 <_ZN9BufferCPPD1Ev+0xb0>
    80004cac:	00053783          	ld	a5,0(a0)
    80004cb0:	0087b783          	ld	a5,8(a5)
    80004cb4:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004cb8:	0184b503          	ld	a0,24(s1)
    80004cbc:	00050863          	beqz	a0,80004ccc <_ZN9BufferCPPD1Ev+0xc4>
    80004cc0:	00053783          	ld	a5,0(a0)
    80004cc4:	0087b783          	ld	a5,8(a5)
    80004cc8:	000780e7          	jalr	a5
    delete mutexTail;
    80004ccc:	0304b503          	ld	a0,48(s1)
    80004cd0:	00050863          	beqz	a0,80004ce0 <_ZN9BufferCPPD1Ev+0xd8>
    80004cd4:	00053783          	ld	a5,0(a0)
    80004cd8:	0087b783          	ld	a5,8(a5)
    80004cdc:	000780e7          	jalr	a5
    delete mutexHead;
    80004ce0:	0284b503          	ld	a0,40(s1)
    80004ce4:	00050863          	beqz	a0,80004cf4 <_ZN9BufferCPPD1Ev+0xec>
    80004ce8:	00053783          	ld	a5,0(a0)
    80004cec:	0087b783          	ld	a5,8(a5)
    80004cf0:	000780e7          	jalr	a5
}
    80004cf4:	01813083          	ld	ra,24(sp)
    80004cf8:	01013403          	ld	s0,16(sp)
    80004cfc:	00813483          	ld	s1,8(sp)
    80004d00:	02010113          	addi	sp,sp,32
    80004d04:	00008067          	ret

0000000080004d08 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004d08:	fe010113          	addi	sp,sp,-32
    80004d0c:	00113c23          	sd	ra,24(sp)
    80004d10:	00813823          	sd	s0,16(sp)
    80004d14:	00913423          	sd	s1,8(sp)
    80004d18:	01213023          	sd	s2,0(sp)
    80004d1c:	02010413          	addi	s0,sp,32
    80004d20:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004d24:	00100793          	li	a5,1
    80004d28:	02a7f863          	bgeu	a5,a0,80004d58 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004d2c:	00a00793          	li	a5,10
    80004d30:	02f577b3          	remu	a5,a0,a5
    80004d34:	02078e63          	beqz	a5,80004d70 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004d38:	fff48513          	addi	a0,s1,-1
    80004d3c:	00000097          	auipc	ra,0x0
    80004d40:	fcc080e7          	jalr	-52(ra) # 80004d08 <_ZL9fibonaccim>
    80004d44:	00050913          	mv	s2,a0
    80004d48:	ffe48513          	addi	a0,s1,-2
    80004d4c:	00000097          	auipc	ra,0x0
    80004d50:	fbc080e7          	jalr	-68(ra) # 80004d08 <_ZL9fibonaccim>
    80004d54:	00a90533          	add	a0,s2,a0
}
    80004d58:	01813083          	ld	ra,24(sp)
    80004d5c:	01013403          	ld	s0,16(sp)
    80004d60:	00813483          	ld	s1,8(sp)
    80004d64:	00013903          	ld	s2,0(sp)
    80004d68:	02010113          	addi	sp,sp,32
    80004d6c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004d70:	ffffc097          	auipc	ra,0xffffc
    80004d74:	4d0080e7          	jalr	1232(ra) # 80001240 <_Z15thread_dispatchv>
    80004d78:	fc1ff06f          	j	80004d38 <_ZL9fibonaccim+0x30>

0000000080004d7c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80004d7c:	fe010113          	addi	sp,sp,-32
    80004d80:	00113c23          	sd	ra,24(sp)
    80004d84:	00813823          	sd	s0,16(sp)
    80004d88:	00913423          	sd	s1,8(sp)
    80004d8c:	01213023          	sd	s2,0(sp)
    80004d90:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004d94:	00a00493          	li	s1,10
    80004d98:	0400006f          	j	80004dd8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004d9c:	00003517          	auipc	a0,0x3
    80004da0:	77c50513          	addi	a0,a0,1916 # 80008518 <CONSOLE_STATUS+0x508>
    80004da4:	00000097          	auipc	ra,0x0
    80004da8:	89c080e7          	jalr	-1892(ra) # 80004640 <_Z11printStringPKc>
    80004dac:	00000613          	li	a2,0
    80004db0:	00a00593          	li	a1,10
    80004db4:	00048513          	mv	a0,s1
    80004db8:	00000097          	auipc	ra,0x0
    80004dbc:	a38080e7          	jalr	-1480(ra) # 800047f0 <_Z8printIntiii>
    80004dc0:	00004517          	auipc	a0,0x4
    80004dc4:	81050513          	addi	a0,a0,-2032 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004dc8:	00000097          	auipc	ra,0x0
    80004dcc:	878080e7          	jalr	-1928(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004dd0:	0014849b          	addiw	s1,s1,1
    80004dd4:	0ff4f493          	andi	s1,s1,255
    80004dd8:	00c00793          	li	a5,12
    80004ddc:	fc97f0e3          	bgeu	a5,s1,80004d9c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004de0:	00003517          	auipc	a0,0x3
    80004de4:	74050513          	addi	a0,a0,1856 # 80008520 <CONSOLE_STATUS+0x510>
    80004de8:	00000097          	auipc	ra,0x0
    80004dec:	858080e7          	jalr	-1960(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004df0:	00500313          	li	t1,5
    thread_dispatch();
    80004df4:	ffffc097          	auipc	ra,0xffffc
    80004df8:	44c080e7          	jalr	1100(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004dfc:	01000513          	li	a0,16
    80004e00:	00000097          	auipc	ra,0x0
    80004e04:	f08080e7          	jalr	-248(ra) # 80004d08 <_ZL9fibonaccim>
    80004e08:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004e0c:	00003517          	auipc	a0,0x3
    80004e10:	72450513          	addi	a0,a0,1828 # 80008530 <CONSOLE_STATUS+0x520>
    80004e14:	00000097          	auipc	ra,0x0
    80004e18:	82c080e7          	jalr	-2004(ra) # 80004640 <_Z11printStringPKc>
    80004e1c:	00000613          	li	a2,0
    80004e20:	00a00593          	li	a1,10
    80004e24:	0009051b          	sext.w	a0,s2
    80004e28:	00000097          	auipc	ra,0x0
    80004e2c:	9c8080e7          	jalr	-1592(ra) # 800047f0 <_Z8printIntiii>
    80004e30:	00003517          	auipc	a0,0x3
    80004e34:	7a050513          	addi	a0,a0,1952 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004e38:	00000097          	auipc	ra,0x0
    80004e3c:	808080e7          	jalr	-2040(ra) # 80004640 <_Z11printStringPKc>
    80004e40:	0400006f          	j	80004e80 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004e44:	00003517          	auipc	a0,0x3
    80004e48:	6d450513          	addi	a0,a0,1748 # 80008518 <CONSOLE_STATUS+0x508>
    80004e4c:	fffff097          	auipc	ra,0xfffff
    80004e50:	7f4080e7          	jalr	2036(ra) # 80004640 <_Z11printStringPKc>
    80004e54:	00000613          	li	a2,0
    80004e58:	00a00593          	li	a1,10
    80004e5c:	00048513          	mv	a0,s1
    80004e60:	00000097          	auipc	ra,0x0
    80004e64:	990080e7          	jalr	-1648(ra) # 800047f0 <_Z8printIntiii>
    80004e68:	00003517          	auipc	a0,0x3
    80004e6c:	76850513          	addi	a0,a0,1896 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004e70:	fffff097          	auipc	ra,0xfffff
    80004e74:	7d0080e7          	jalr	2000(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004e78:	0014849b          	addiw	s1,s1,1
    80004e7c:	0ff4f493          	andi	s1,s1,255
    80004e80:	00f00793          	li	a5,15
    80004e84:	fc97f0e3          	bgeu	a5,s1,80004e44 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004e88:	00003517          	auipc	a0,0x3
    80004e8c:	6b850513          	addi	a0,a0,1720 # 80008540 <CONSOLE_STATUS+0x530>
    80004e90:	fffff097          	auipc	ra,0xfffff
    80004e94:	7b0080e7          	jalr	1968(ra) # 80004640 <_Z11printStringPKc>
    finishedD = true;
    80004e98:	00100793          	li	a5,1
    80004e9c:	00005717          	auipc	a4,0x5
    80004ea0:	74f70e23          	sb	a5,1884(a4) # 8000a5f8 <_ZL9finishedD>
    thread_dispatch();
    80004ea4:	ffffc097          	auipc	ra,0xffffc
    80004ea8:	39c080e7          	jalr	924(ra) # 80001240 <_Z15thread_dispatchv>
}
    80004eac:	01813083          	ld	ra,24(sp)
    80004eb0:	01013403          	ld	s0,16(sp)
    80004eb4:	00813483          	ld	s1,8(sp)
    80004eb8:	00013903          	ld	s2,0(sp)
    80004ebc:	02010113          	addi	sp,sp,32
    80004ec0:	00008067          	ret

0000000080004ec4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004ec4:	fe010113          	addi	sp,sp,-32
    80004ec8:	00113c23          	sd	ra,24(sp)
    80004ecc:	00813823          	sd	s0,16(sp)
    80004ed0:	00913423          	sd	s1,8(sp)
    80004ed4:	01213023          	sd	s2,0(sp)
    80004ed8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004edc:	00000493          	li	s1,0
    80004ee0:	0400006f          	j	80004f20 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004ee4:	00003517          	auipc	a0,0x3
    80004ee8:	60450513          	addi	a0,a0,1540 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80004eec:	fffff097          	auipc	ra,0xfffff
    80004ef0:	754080e7          	jalr	1876(ra) # 80004640 <_Z11printStringPKc>
    80004ef4:	00000613          	li	a2,0
    80004ef8:	00a00593          	li	a1,10
    80004efc:	00048513          	mv	a0,s1
    80004f00:	00000097          	auipc	ra,0x0
    80004f04:	8f0080e7          	jalr	-1808(ra) # 800047f0 <_Z8printIntiii>
    80004f08:	00003517          	auipc	a0,0x3
    80004f0c:	6c850513          	addi	a0,a0,1736 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004f10:	fffff097          	auipc	ra,0xfffff
    80004f14:	730080e7          	jalr	1840(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004f18:	0014849b          	addiw	s1,s1,1
    80004f1c:	0ff4f493          	andi	s1,s1,255
    80004f20:	00200793          	li	a5,2
    80004f24:	fc97f0e3          	bgeu	a5,s1,80004ee4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004f28:	00003517          	auipc	a0,0x3
    80004f2c:	5c850513          	addi	a0,a0,1480 # 800084f0 <CONSOLE_STATUS+0x4e0>
    80004f30:	fffff097          	auipc	ra,0xfffff
    80004f34:	710080e7          	jalr	1808(ra) # 80004640 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004f38:	00700313          	li	t1,7
    thread_dispatch();
    80004f3c:	ffffc097          	auipc	ra,0xffffc
    80004f40:	304080e7          	jalr	772(ra) # 80001240 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004f44:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004f48:	00003517          	auipc	a0,0x3
    80004f4c:	5b850513          	addi	a0,a0,1464 # 80008500 <CONSOLE_STATUS+0x4f0>
    80004f50:	fffff097          	auipc	ra,0xfffff
    80004f54:	6f0080e7          	jalr	1776(ra) # 80004640 <_Z11printStringPKc>
    80004f58:	00000613          	li	a2,0
    80004f5c:	00a00593          	li	a1,10
    80004f60:	0009051b          	sext.w	a0,s2
    80004f64:	00000097          	auipc	ra,0x0
    80004f68:	88c080e7          	jalr	-1908(ra) # 800047f0 <_Z8printIntiii>
    80004f6c:	00003517          	auipc	a0,0x3
    80004f70:	66450513          	addi	a0,a0,1636 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004f74:	fffff097          	auipc	ra,0xfffff
    80004f78:	6cc080e7          	jalr	1740(ra) # 80004640 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80004f7c:	00c00513          	li	a0,12
    80004f80:	00000097          	auipc	ra,0x0
    80004f84:	d88080e7          	jalr	-632(ra) # 80004d08 <_ZL9fibonaccim>
    80004f88:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004f8c:	00003517          	auipc	a0,0x3
    80004f90:	57c50513          	addi	a0,a0,1404 # 80008508 <CONSOLE_STATUS+0x4f8>
    80004f94:	fffff097          	auipc	ra,0xfffff
    80004f98:	6ac080e7          	jalr	1708(ra) # 80004640 <_Z11printStringPKc>
    80004f9c:	00000613          	li	a2,0
    80004fa0:	00a00593          	li	a1,10
    80004fa4:	0009051b          	sext.w	a0,s2
    80004fa8:	00000097          	auipc	ra,0x0
    80004fac:	848080e7          	jalr	-1976(ra) # 800047f0 <_Z8printIntiii>
    80004fb0:	00003517          	auipc	a0,0x3
    80004fb4:	62050513          	addi	a0,a0,1568 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004fb8:	fffff097          	auipc	ra,0xfffff
    80004fbc:	688080e7          	jalr	1672(ra) # 80004640 <_Z11printStringPKc>
    80004fc0:	0400006f          	j	80005000 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004fc4:	00003517          	auipc	a0,0x3
    80004fc8:	52450513          	addi	a0,a0,1316 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80004fcc:	fffff097          	auipc	ra,0xfffff
    80004fd0:	674080e7          	jalr	1652(ra) # 80004640 <_Z11printStringPKc>
    80004fd4:	00000613          	li	a2,0
    80004fd8:	00a00593          	li	a1,10
    80004fdc:	00048513          	mv	a0,s1
    80004fe0:	00000097          	auipc	ra,0x0
    80004fe4:	810080e7          	jalr	-2032(ra) # 800047f0 <_Z8printIntiii>
    80004fe8:	00003517          	auipc	a0,0x3
    80004fec:	5e850513          	addi	a0,a0,1512 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80004ff0:	fffff097          	auipc	ra,0xfffff
    80004ff4:	650080e7          	jalr	1616(ra) # 80004640 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004ff8:	0014849b          	addiw	s1,s1,1
    80004ffc:	0ff4f493          	andi	s1,s1,255
    80005000:	00500793          	li	a5,5
    80005004:	fc97f0e3          	bgeu	a5,s1,80004fc4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005008:	00003517          	auipc	a0,0x3
    8000500c:	4b850513          	addi	a0,a0,1208 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80005010:	fffff097          	auipc	ra,0xfffff
    80005014:	630080e7          	jalr	1584(ra) # 80004640 <_Z11printStringPKc>
    finishedC = true;
    80005018:	00100793          	li	a5,1
    8000501c:	00005717          	auipc	a4,0x5
    80005020:	5cf70ea3          	sb	a5,1501(a4) # 8000a5f9 <_ZL9finishedC>
    thread_dispatch();
    80005024:	ffffc097          	auipc	ra,0xffffc
    80005028:	21c080e7          	jalr	540(ra) # 80001240 <_Z15thread_dispatchv>
}
    8000502c:	01813083          	ld	ra,24(sp)
    80005030:	01013403          	ld	s0,16(sp)
    80005034:	00813483          	ld	s1,8(sp)
    80005038:	00013903          	ld	s2,0(sp)
    8000503c:	02010113          	addi	sp,sp,32
    80005040:	00008067          	ret

0000000080005044 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005044:	fe010113          	addi	sp,sp,-32
    80005048:	00113c23          	sd	ra,24(sp)
    8000504c:	00813823          	sd	s0,16(sp)
    80005050:	00913423          	sd	s1,8(sp)
    80005054:	01213023          	sd	s2,0(sp)
    80005058:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000505c:	00000913          	li	s2,0
    80005060:	0400006f          	j	800050a0 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80005064:	ffffc097          	auipc	ra,0xffffc
    80005068:	1dc080e7          	jalr	476(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000506c:	00148493          	addi	s1,s1,1
    80005070:	000027b7          	lui	a5,0x2
    80005074:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80005078:	0097ee63          	bltu	a5,s1,80005094 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000507c:	00000713          	li	a4,0
    80005080:	000077b7          	lui	a5,0x7
    80005084:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80005088:	fce7eee3          	bltu	a5,a4,80005064 <_ZL11workerBodyBPv+0x20>
    8000508c:	00170713          	addi	a4,a4,1
    80005090:	ff1ff06f          	j	80005080 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80005094:	00a00793          	li	a5,10
    80005098:	04f90663          	beq	s2,a5,800050e4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    8000509c:	00190913          	addi	s2,s2,1
    800050a0:	00f00793          	li	a5,15
    800050a4:	0527e463          	bltu	a5,s2,800050ec <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800050a8:	00003517          	auipc	a0,0x3
    800050ac:	42850513          	addi	a0,a0,1064 # 800084d0 <CONSOLE_STATUS+0x4c0>
    800050b0:	fffff097          	auipc	ra,0xfffff
    800050b4:	590080e7          	jalr	1424(ra) # 80004640 <_Z11printStringPKc>
    800050b8:	00000613          	li	a2,0
    800050bc:	00a00593          	li	a1,10
    800050c0:	0009051b          	sext.w	a0,s2
    800050c4:	fffff097          	auipc	ra,0xfffff
    800050c8:	72c080e7          	jalr	1836(ra) # 800047f0 <_Z8printIntiii>
    800050cc:	00003517          	auipc	a0,0x3
    800050d0:	50450513          	addi	a0,a0,1284 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800050d4:	fffff097          	auipc	ra,0xfffff
    800050d8:	56c080e7          	jalr	1388(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800050dc:	00000493          	li	s1,0
    800050e0:	f91ff06f          	j	80005070 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800050e4:	14102ff3          	csrr	t6,sepc
    800050e8:	fb5ff06f          	j	8000509c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    800050ec:	00003517          	auipc	a0,0x3
    800050f0:	3ec50513          	addi	a0,a0,1004 # 800084d8 <CONSOLE_STATUS+0x4c8>
    800050f4:	fffff097          	auipc	ra,0xfffff
    800050f8:	54c080e7          	jalr	1356(ra) # 80004640 <_Z11printStringPKc>
    finishedB = true;
    800050fc:	00100793          	li	a5,1
    80005100:	00005717          	auipc	a4,0x5
    80005104:	4ef70d23          	sb	a5,1274(a4) # 8000a5fa <_ZL9finishedB>
    thread_dispatch();
    80005108:	ffffc097          	auipc	ra,0xffffc
    8000510c:	138080e7          	jalr	312(ra) # 80001240 <_Z15thread_dispatchv>
}
    80005110:	01813083          	ld	ra,24(sp)
    80005114:	01013403          	ld	s0,16(sp)
    80005118:	00813483          	ld	s1,8(sp)
    8000511c:	00013903          	ld	s2,0(sp)
    80005120:	02010113          	addi	sp,sp,32
    80005124:	00008067          	ret

0000000080005128 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005128:	fe010113          	addi	sp,sp,-32
    8000512c:	00113c23          	sd	ra,24(sp)
    80005130:	00813823          	sd	s0,16(sp)
    80005134:	00913423          	sd	s1,8(sp)
    80005138:	01213023          	sd	s2,0(sp)
    8000513c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005140:	00000913          	li	s2,0
    80005144:	0380006f          	j	8000517c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80005148:	ffffc097          	auipc	ra,0xffffc
    8000514c:	0f8080e7          	jalr	248(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80005150:	00148493          	addi	s1,s1,1
    80005154:	000027b7          	lui	a5,0x2
    80005158:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000515c:	0097ee63          	bltu	a5,s1,80005178 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80005160:	00000713          	li	a4,0
    80005164:	000077b7          	lui	a5,0x7
    80005168:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000516c:	fce7eee3          	bltu	a5,a4,80005148 <_ZL11workerBodyAPv+0x20>
    80005170:	00170713          	addi	a4,a4,1
    80005174:	ff1ff06f          	j	80005164 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80005178:	00190913          	addi	s2,s2,1
    8000517c:	00900793          	li	a5,9
    80005180:	0527e063          	bltu	a5,s2,800051c0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80005184:	00003517          	auipc	a0,0x3
    80005188:	33450513          	addi	a0,a0,820 # 800084b8 <CONSOLE_STATUS+0x4a8>
    8000518c:	fffff097          	auipc	ra,0xfffff
    80005190:	4b4080e7          	jalr	1204(ra) # 80004640 <_Z11printStringPKc>
    80005194:	00000613          	li	a2,0
    80005198:	00a00593          	li	a1,10
    8000519c:	0009051b          	sext.w	a0,s2
    800051a0:	fffff097          	auipc	ra,0xfffff
    800051a4:	650080e7          	jalr	1616(ra) # 800047f0 <_Z8printIntiii>
    800051a8:	00003517          	auipc	a0,0x3
    800051ac:	42850513          	addi	a0,a0,1064 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800051b0:	fffff097          	auipc	ra,0xfffff
    800051b4:	490080e7          	jalr	1168(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800051b8:	00000493          	li	s1,0
    800051bc:	f99ff06f          	j	80005154 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800051c0:	00003517          	auipc	a0,0x3
    800051c4:	30050513          	addi	a0,a0,768 # 800084c0 <CONSOLE_STATUS+0x4b0>
    800051c8:	fffff097          	auipc	ra,0xfffff
    800051cc:	478080e7          	jalr	1144(ra) # 80004640 <_Z11printStringPKc>
    finishedA = true;
    800051d0:	00100793          	li	a5,1
    800051d4:	00005717          	auipc	a4,0x5
    800051d8:	42f703a3          	sb	a5,1063(a4) # 8000a5fb <_ZL9finishedA>
}
    800051dc:	01813083          	ld	ra,24(sp)
    800051e0:	01013403          	ld	s0,16(sp)
    800051e4:	00813483          	ld	s1,8(sp)
    800051e8:	00013903          	ld	s2,0(sp)
    800051ec:	02010113          	addi	sp,sp,32
    800051f0:	00008067          	ret

00000000800051f4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    800051f4:	fd010113          	addi	sp,sp,-48
    800051f8:	02113423          	sd	ra,40(sp)
    800051fc:	02813023          	sd	s0,32(sp)
    80005200:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005204:	00000613          	li	a2,0
    80005208:	00000597          	auipc	a1,0x0
    8000520c:	f2058593          	addi	a1,a1,-224 # 80005128 <_ZL11workerBodyAPv>
    80005210:	fd040513          	addi	a0,s0,-48
    80005214:	ffffc097          	auipc	ra,0xffffc
    80005218:	fd4080e7          	jalr	-44(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    8000521c:	00003517          	auipc	a0,0x3
    80005220:	33450513          	addi	a0,a0,820 # 80008550 <CONSOLE_STATUS+0x540>
    80005224:	fffff097          	auipc	ra,0xfffff
    80005228:	41c080e7          	jalr	1052(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000522c:	00000613          	li	a2,0
    80005230:	00000597          	auipc	a1,0x0
    80005234:	e1458593          	addi	a1,a1,-492 # 80005044 <_ZL11workerBodyBPv>
    80005238:	fd840513          	addi	a0,s0,-40
    8000523c:	ffffc097          	auipc	ra,0xffffc
    80005240:	fac080e7          	jalr	-84(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80005244:	00003517          	auipc	a0,0x3
    80005248:	32450513          	addi	a0,a0,804 # 80008568 <CONSOLE_STATUS+0x558>
    8000524c:	fffff097          	auipc	ra,0xfffff
    80005250:	3f4080e7          	jalr	1012(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005254:	00000613          	li	a2,0
    80005258:	00000597          	auipc	a1,0x0
    8000525c:	c6c58593          	addi	a1,a1,-916 # 80004ec4 <_ZL11workerBodyCPv>
    80005260:	fe040513          	addi	a0,s0,-32
    80005264:	ffffc097          	auipc	ra,0xffffc
    80005268:	f84080e7          	jalr	-124(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000526c:	00003517          	auipc	a0,0x3
    80005270:	31450513          	addi	a0,a0,788 # 80008580 <CONSOLE_STATUS+0x570>
    80005274:	fffff097          	auipc	ra,0xfffff
    80005278:	3cc080e7          	jalr	972(ra) # 80004640 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000527c:	00000613          	li	a2,0
    80005280:	00000597          	auipc	a1,0x0
    80005284:	afc58593          	addi	a1,a1,-1284 # 80004d7c <_ZL11workerBodyDPv>
    80005288:	fe840513          	addi	a0,s0,-24
    8000528c:	ffffc097          	auipc	ra,0xffffc
    80005290:	f5c080e7          	jalr	-164(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80005294:	00003517          	auipc	a0,0x3
    80005298:	30450513          	addi	a0,a0,772 # 80008598 <CONSOLE_STATUS+0x588>
    8000529c:	fffff097          	auipc	ra,0xfffff
    800052a0:	3a4080e7          	jalr	932(ra) # 80004640 <_Z11printStringPKc>
    800052a4:	00c0006f          	j	800052b0 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800052a8:	ffffc097          	auipc	ra,0xffffc
    800052ac:	f98080e7          	jalr	-104(ra) # 80001240 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800052b0:	00005797          	auipc	a5,0x5
    800052b4:	34b7c783          	lbu	a5,843(a5) # 8000a5fb <_ZL9finishedA>
    800052b8:	fe0788e3          	beqz	a5,800052a8 <_Z16System_Mode_testv+0xb4>
    800052bc:	00005797          	auipc	a5,0x5
    800052c0:	33e7c783          	lbu	a5,830(a5) # 8000a5fa <_ZL9finishedB>
    800052c4:	fe0782e3          	beqz	a5,800052a8 <_Z16System_Mode_testv+0xb4>
    800052c8:	00005797          	auipc	a5,0x5
    800052cc:	3317c783          	lbu	a5,817(a5) # 8000a5f9 <_ZL9finishedC>
    800052d0:	fc078ce3          	beqz	a5,800052a8 <_Z16System_Mode_testv+0xb4>
    800052d4:	00005797          	auipc	a5,0x5
    800052d8:	3247c783          	lbu	a5,804(a5) # 8000a5f8 <_ZL9finishedD>
    800052dc:	fc0786e3          	beqz	a5,800052a8 <_Z16System_Mode_testv+0xb4>
    }

}
    800052e0:	02813083          	ld	ra,40(sp)
    800052e4:	02013403          	ld	s0,32(sp)
    800052e8:	03010113          	addi	sp,sp,48
    800052ec:	00008067          	ret

00000000800052f0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800052f0:	fe010113          	addi	sp,sp,-32
    800052f4:	00113c23          	sd	ra,24(sp)
    800052f8:	00813823          	sd	s0,16(sp)
    800052fc:	00913423          	sd	s1,8(sp)
    80005300:	01213023          	sd	s2,0(sp)
    80005304:	02010413          	addi	s0,sp,32
    80005308:	00050493          	mv	s1,a0
    8000530c:	00058913          	mv	s2,a1
    80005310:	0015879b          	addiw	a5,a1,1
    80005314:	0007851b          	sext.w	a0,a5
    80005318:	00f4a023          	sw	a5,0(s1)
    8000531c:	0004a823          	sw	zero,16(s1)
    80005320:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005324:	00251513          	slli	a0,a0,0x2
    80005328:	ffffc097          	auipc	ra,0xffffc
    8000532c:	e1c080e7          	jalr	-484(ra) # 80001144 <_Z9mem_allocm>
    80005330:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005334:	00000593          	li	a1,0
    80005338:	02048513          	addi	a0,s1,32
    8000533c:	ffffc097          	auipc	ra,0xffffc
    80005340:	f28080e7          	jalr	-216(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80005344:	00090593          	mv	a1,s2
    80005348:	01848513          	addi	a0,s1,24
    8000534c:	ffffc097          	auipc	ra,0xffffc
    80005350:	f18080e7          	jalr	-232(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80005354:	00100593          	li	a1,1
    80005358:	02848513          	addi	a0,s1,40
    8000535c:	ffffc097          	auipc	ra,0xffffc
    80005360:	f08080e7          	jalr	-248(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80005364:	00100593          	li	a1,1
    80005368:	03048513          	addi	a0,s1,48
    8000536c:	ffffc097          	auipc	ra,0xffffc
    80005370:	ef8080e7          	jalr	-264(ra) # 80001264 <_Z8sem_openPP4_semj>
}
    80005374:	01813083          	ld	ra,24(sp)
    80005378:	01013403          	ld	s0,16(sp)
    8000537c:	00813483          	ld	s1,8(sp)
    80005380:	00013903          	ld	s2,0(sp)
    80005384:	02010113          	addi	sp,sp,32
    80005388:	00008067          	ret

000000008000538c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    8000538c:	fe010113          	addi	sp,sp,-32
    80005390:	00113c23          	sd	ra,24(sp)
    80005394:	00813823          	sd	s0,16(sp)
    80005398:	00913423          	sd	s1,8(sp)
    8000539c:	01213023          	sd	s2,0(sp)
    800053a0:	02010413          	addi	s0,sp,32
    800053a4:	00050493          	mv	s1,a0
    800053a8:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800053ac:	01853503          	ld	a0,24(a0)
    800053b0:	ffffc097          	auipc	ra,0xffffc
    800053b4:	f0c080e7          	jalr	-244(ra) # 800012bc <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    800053b8:	0304b503          	ld	a0,48(s1)
    800053bc:	ffffc097          	auipc	ra,0xffffc
    800053c0:	f00080e7          	jalr	-256(ra) # 800012bc <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    800053c4:	0084b783          	ld	a5,8(s1)
    800053c8:	0144a703          	lw	a4,20(s1)
    800053cc:	00271713          	slli	a4,a4,0x2
    800053d0:	00e787b3          	add	a5,a5,a4
    800053d4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800053d8:	0144a783          	lw	a5,20(s1)
    800053dc:	0017879b          	addiw	a5,a5,1
    800053e0:	0004a703          	lw	a4,0(s1)
    800053e4:	02e7e7bb          	remw	a5,a5,a4
    800053e8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800053ec:	0304b503          	ld	a0,48(s1)
    800053f0:	ffffc097          	auipc	ra,0xffffc
    800053f4:	ef8080e7          	jalr	-264(ra) # 800012e8 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    800053f8:	0204b503          	ld	a0,32(s1)
    800053fc:	ffffc097          	auipc	ra,0xffffc
    80005400:	eec080e7          	jalr	-276(ra) # 800012e8 <_Z10sem_signalP4_sem>

}
    80005404:	01813083          	ld	ra,24(sp)
    80005408:	01013403          	ld	s0,16(sp)
    8000540c:	00813483          	ld	s1,8(sp)
    80005410:	00013903          	ld	s2,0(sp)
    80005414:	02010113          	addi	sp,sp,32
    80005418:	00008067          	ret

000000008000541c <_ZN6Buffer3getEv>:

int Buffer::get() {
    8000541c:	fe010113          	addi	sp,sp,-32
    80005420:	00113c23          	sd	ra,24(sp)
    80005424:	00813823          	sd	s0,16(sp)
    80005428:	00913423          	sd	s1,8(sp)
    8000542c:	01213023          	sd	s2,0(sp)
    80005430:	02010413          	addi	s0,sp,32
    80005434:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80005438:	02053503          	ld	a0,32(a0)
    8000543c:	ffffc097          	auipc	ra,0xffffc
    80005440:	e80080e7          	jalr	-384(ra) # 800012bc <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80005444:	0284b503          	ld	a0,40(s1)
    80005448:	ffffc097          	auipc	ra,0xffffc
    8000544c:	e74080e7          	jalr	-396(ra) # 800012bc <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80005450:	0084b703          	ld	a4,8(s1)
    80005454:	0104a783          	lw	a5,16(s1)
    80005458:	00279693          	slli	a3,a5,0x2
    8000545c:	00d70733          	add	a4,a4,a3
    80005460:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005464:	0017879b          	addiw	a5,a5,1
    80005468:	0004a703          	lw	a4,0(s1)
    8000546c:	02e7e7bb          	remw	a5,a5,a4
    80005470:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80005474:	0284b503          	ld	a0,40(s1)
    80005478:	ffffc097          	auipc	ra,0xffffc
    8000547c:	e70080e7          	jalr	-400(ra) # 800012e8 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80005480:	0184b503          	ld	a0,24(s1)
    80005484:	ffffc097          	auipc	ra,0xffffc
    80005488:	e64080e7          	jalr	-412(ra) # 800012e8 <_Z10sem_signalP4_sem>

    return ret;
}
    8000548c:	00090513          	mv	a0,s2
    80005490:	01813083          	ld	ra,24(sp)
    80005494:	01013403          	ld	s0,16(sp)
    80005498:	00813483          	ld	s1,8(sp)
    8000549c:	00013903          	ld	s2,0(sp)
    800054a0:	02010113          	addi	sp,sp,32
    800054a4:	00008067          	ret

00000000800054a8 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800054a8:	fe010113          	addi	sp,sp,-32
    800054ac:	00113c23          	sd	ra,24(sp)
    800054b0:	00813823          	sd	s0,16(sp)
    800054b4:	00913423          	sd	s1,8(sp)
    800054b8:	01213023          	sd	s2,0(sp)
    800054bc:	02010413          	addi	s0,sp,32
    800054c0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800054c4:	02853503          	ld	a0,40(a0)
    800054c8:	ffffc097          	auipc	ra,0xffffc
    800054cc:	df4080e7          	jalr	-524(ra) # 800012bc <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    800054d0:	0304b503          	ld	a0,48(s1)
    800054d4:	ffffc097          	auipc	ra,0xffffc
    800054d8:	de8080e7          	jalr	-536(ra) # 800012bc <_Z8sem_waitP4_sem>

    if (tail >= head) {
    800054dc:	0144a783          	lw	a5,20(s1)
    800054e0:	0104a903          	lw	s2,16(s1)
    800054e4:	0327ce63          	blt	a5,s2,80005520 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800054e8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800054ec:	0304b503          	ld	a0,48(s1)
    800054f0:	ffffc097          	auipc	ra,0xffffc
    800054f4:	df8080e7          	jalr	-520(ra) # 800012e8 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    800054f8:	0284b503          	ld	a0,40(s1)
    800054fc:	ffffc097          	auipc	ra,0xffffc
    80005500:	dec080e7          	jalr	-532(ra) # 800012e8 <_Z10sem_signalP4_sem>

    return ret;
}
    80005504:	00090513          	mv	a0,s2
    80005508:	01813083          	ld	ra,24(sp)
    8000550c:	01013403          	ld	s0,16(sp)
    80005510:	00813483          	ld	s1,8(sp)
    80005514:	00013903          	ld	s2,0(sp)
    80005518:	02010113          	addi	sp,sp,32
    8000551c:	00008067          	ret
        ret = cap - head + tail;
    80005520:	0004a703          	lw	a4,0(s1)
    80005524:	4127093b          	subw	s2,a4,s2
    80005528:	00f9093b          	addw	s2,s2,a5
    8000552c:	fc1ff06f          	j	800054ec <_ZN6Buffer6getCntEv+0x44>

0000000080005530 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005530:	fe010113          	addi	sp,sp,-32
    80005534:	00113c23          	sd	ra,24(sp)
    80005538:	00813823          	sd	s0,16(sp)
    8000553c:	00913423          	sd	s1,8(sp)
    80005540:	02010413          	addi	s0,sp,32
    80005544:	00050493          	mv	s1,a0
    putc('\n');
    80005548:	00a00513          	li	a0,10
    8000554c:	ffffc097          	auipc	ra,0xffffc
    80005550:	df4080e7          	jalr	-524(ra) # 80001340 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005554:	00003517          	auipc	a0,0x3
    80005558:	0ac50513          	addi	a0,a0,172 # 80008600 <CONSOLE_STATUS+0x5f0>
    8000555c:	fffff097          	auipc	ra,0xfffff
    80005560:	0e4080e7          	jalr	228(ra) # 80004640 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005564:	00048513          	mv	a0,s1
    80005568:	00000097          	auipc	ra,0x0
    8000556c:	f40080e7          	jalr	-192(ra) # 800054a8 <_ZN6Buffer6getCntEv>
    80005570:	02a05c63          	blez	a0,800055a8 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005574:	0084b783          	ld	a5,8(s1)
    80005578:	0104a703          	lw	a4,16(s1)
    8000557c:	00271713          	slli	a4,a4,0x2
    80005580:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005584:	0007c503          	lbu	a0,0(a5)
    80005588:	ffffc097          	auipc	ra,0xffffc
    8000558c:	db8080e7          	jalr	-584(ra) # 80001340 <_Z4putcc>
        head = (head + 1) % cap;
    80005590:	0104a783          	lw	a5,16(s1)
    80005594:	0017879b          	addiw	a5,a5,1
    80005598:	0004a703          	lw	a4,0(s1)
    8000559c:	02e7e7bb          	remw	a5,a5,a4
    800055a0:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800055a4:	fc1ff06f          	j	80005564 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800055a8:	02100513          	li	a0,33
    800055ac:	ffffc097          	auipc	ra,0xffffc
    800055b0:	d94080e7          	jalr	-620(ra) # 80001340 <_Z4putcc>
    putc('\n');
    800055b4:	00a00513          	li	a0,10
    800055b8:	ffffc097          	auipc	ra,0xffffc
    800055bc:	d88080e7          	jalr	-632(ra) # 80001340 <_Z4putcc>
    mem_free(buffer);
    800055c0:	0084b503          	ld	a0,8(s1)
    800055c4:	ffffc097          	auipc	ra,0xffffc
    800055c8:	ba8080e7          	jalr	-1112(ra) # 8000116c <_Z8mem_freePv>
    sem_close(itemAvailable);
    800055cc:	0204b503          	ld	a0,32(s1)
    800055d0:	ffffc097          	auipc	ra,0xffffc
    800055d4:	cc0080e7          	jalr	-832(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    800055d8:	0184b503          	ld	a0,24(s1)
    800055dc:	ffffc097          	auipc	ra,0xffffc
    800055e0:	cb4080e7          	jalr	-844(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    800055e4:	0304b503          	ld	a0,48(s1)
    800055e8:	ffffc097          	auipc	ra,0xffffc
    800055ec:	ca8080e7          	jalr	-856(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    800055f0:	0284b503          	ld	a0,40(s1)
    800055f4:	ffffc097          	auipc	ra,0xffffc
    800055f8:	c9c080e7          	jalr	-868(ra) # 80001290 <_Z9sem_closeP4_sem>
}
    800055fc:	01813083          	ld	ra,24(sp)
    80005600:	01013403          	ld	s0,16(sp)
    80005604:	00813483          	ld	s1,8(sp)
    80005608:	02010113          	addi	sp,sp,32
    8000560c:	00008067          	ret

0000000080005610 <_ZN12WorkerSemMax10workerBodyEPv>:
        workerBody(nullptr);
    }
};


void WorkerSemMax::workerBody(void *arg) {
    80005610:	fe010113          	addi	sp,sp,-32
    80005614:	00113c23          	sd	ra,24(sp)
    80005618:	00813823          	sd	s0,16(sp)
    8000561c:	00913423          	sd	s1,8(sp)
    80005620:	01213023          	sd	s2,0(sp)
    80005624:	02010413          	addi	s0,sp,32

    for (uint64 i = 0; i < 5; i++) {
    80005628:	00000913          	li	s2,0
    8000562c:	0300006f          	j	8000565c <_ZN12WorkerSemMax10workerBodyEPv+0x4c>
        printString("Hello! ID: ");
        printInt(id);
        printString("\n");
        for (uint64 j = 0; j < 1000; j++) {
            for (uint64 k = 0; k < 1000; k++) { /* busy wait */ }
            thread_dispatch();
    80005630:	ffffc097          	auipc	ra,0xffffc
    80005634:	c10080e7          	jalr	-1008(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 1000; j++) {
    80005638:	00148493          	addi	s1,s1,1
    8000563c:	3e700793          	li	a5,999
    80005640:	0097ec63          	bltu	a5,s1,80005658 <_ZN12WorkerSemMax10workerBodyEPv+0x48>
            for (uint64 k = 0; k < 1000; k++) { /* busy wait */ }
    80005644:	00000793          	li	a5,0
    80005648:	3e700713          	li	a4,999
    8000564c:	fef762e3          	bltu	a4,a5,80005630 <_ZN12WorkerSemMax10workerBodyEPv+0x20>
    80005650:	00178793          	addi	a5,a5,1
    80005654:	ff5ff06f          	j	80005648 <_ZN12WorkerSemMax10workerBodyEPv+0x38>
    for (uint64 i = 0; i < 5; i++) {
    80005658:	00190913          	addi	s2,s2,1
    8000565c:	00400793          	li	a5,4
    80005660:	0527e663          	bltu	a5,s2,800056ac <_ZN12WorkerSemMax10workerBodyEPv+0x9c>
        int id = getThreadId();
    80005664:	ffffc097          	auipc	ra,0xffffc
    80005668:	d24080e7          	jalr	-732(ra) # 80001388 <_Z11getThreadIdv>
    8000566c:	00050493          	mv	s1,a0
        printString("Hello! ID: ");
    80005670:	00003517          	auipc	a0,0x3
    80005674:	fa850513          	addi	a0,a0,-88 # 80008618 <CONSOLE_STATUS+0x608>
    80005678:	fffff097          	auipc	ra,0xfffff
    8000567c:	fc8080e7          	jalr	-56(ra) # 80004640 <_Z11printStringPKc>
        printInt(id);
    80005680:	00000613          	li	a2,0
    80005684:	00a00593          	li	a1,10
    80005688:	00048513          	mv	a0,s1
    8000568c:	fffff097          	auipc	ra,0xfffff
    80005690:	164080e7          	jalr	356(ra) # 800047f0 <_Z8printIntiii>
        printString("\n");
    80005694:	00003517          	auipc	a0,0x3
    80005698:	f3c50513          	addi	a0,a0,-196 # 800085d0 <CONSOLE_STATUS+0x5c0>
    8000569c:	fffff097          	auipc	ra,0xfffff
    800056a0:	fa4080e7          	jalr	-92(ra) # 80004640 <_Z11printStringPKc>
        for (uint64 j = 0; j < 1000; j++) {
    800056a4:	00000493          	li	s1,0
    800056a8:	f95ff06f          	j	8000563c <_ZN12WorkerSemMax10workerBodyEPv+0x2c>
        }
    }
    //brojac--;
}
    800056ac:	01813083          	ld	ra,24(sp)
    800056b0:	01013403          	ld	s0,16(sp)
    800056b4:	00813483          	ld	s1,8(sp)
    800056b8:	00013903          	ld	s2,0(sp)
    800056bc:	02010113          	addi	sp,sp,32
    800056c0:	00008067          	ret

00000000800056c4 <_Z18semMaxThreads_testv>:

void semMaxThreads_test() {
    800056c4:	f4010113          	addi	sp,sp,-192
    800056c8:	0a113c23          	sd	ra,184(sp)
    800056cc:	0a813823          	sd	s0,176(sp)
    800056d0:	0a913423          	sd	s1,168(sp)
    800056d4:	0b213023          	sd	s2,160(sp)
    800056d8:	0c010413          	addi	s0,sp,192

    //Thread::SetMaximumThreads(3);
    Thread* threads[20];

    for(int i=0; i<20; i++) {
    800056dc:	00000913          	li	s2,0
    800056e0:	0240006f          	j	80005704 <_Z18semMaxThreads_testv+0x40>
    WorkerSemMax():Thread() {}
    800056e4:	00005797          	auipc	a5,0x5
    800056e8:	e1478793          	addi	a5,a5,-492 # 8000a4f8 <_ZTV12WorkerSemMax+0x10>
    800056ec:	00f4b023          	sd	a5,0(s1)
        threads[i] = new WorkerSemMax();
    800056f0:	00391793          	slli	a5,s2,0x3
    800056f4:	fe040713          	addi	a4,s0,-32
    800056f8:	00f707b3          	add	a5,a4,a5
    800056fc:	f697b023          	sd	s1,-160(a5)
    for(int i=0; i<20; i++) {
    80005700:	0019091b          	addiw	s2,s2,1
    80005704:	01300793          	li	a5,19
    80005708:	0327c063          	blt	a5,s2,80005728 <_Z18semMaxThreads_testv+0x64>
        threads[i] = new WorkerSemMax();
    8000570c:	02000513          	li	a0,32
    80005710:	ffffc097          	auipc	ra,0xffffc
    80005714:	288080e7          	jalr	648(ra) # 80001998 <_Znwm>
    80005718:	00050493          	mv	s1,a0
    WorkerSemMax():Thread() {}
    8000571c:	ffffc097          	auipc	ra,0xffffc
    80005720:	500080e7          	jalr	1280(ra) # 80001c1c <_ZN6ThreadC1Ev>
    80005724:	fc1ff06f          	j	800056e4 <_Z18semMaxThreads_testv+0x20>
    }

    for(int i=0; i<20; i++) {
    80005728:	00000493          	li	s1,0
    8000572c:	0200006f          	j	8000574c <_Z18semMaxThreads_testv+0x88>
        threads[i]->start();
    80005730:	00349793          	slli	a5,s1,0x3
    80005734:	fe040713          	addi	a4,s0,-32
    80005738:	00f707b3          	add	a5,a4,a5
    8000573c:	f607b503          	ld	a0,-160(a5)
    80005740:	ffffc097          	auipc	ra,0xffffc
    80005744:	480080e7          	jalr	1152(ra) # 80001bc0 <_ZN6Thread5startEv>
    for(int i=0; i<20; i++) {
    80005748:	0014849b          	addiw	s1,s1,1
    8000574c:	01300793          	li	a5,19
    80005750:	fe97d0e3          	bge	a5,s1,80005730 <_Z18semMaxThreads_testv+0x6c>

//    while(brojac) {
//        thread_dispatch();
//   }

    thread_joinAll();
    80005754:	ffffc097          	auipc	ra,0xffffc
    80005758:	c60080e7          	jalr	-928(ra) # 800013b4 <_Z14thread_joinAllv>
}
    8000575c:	0b813083          	ld	ra,184(sp)
    80005760:	0b013403          	ld	s0,176(sp)
    80005764:	0a813483          	ld	s1,168(sp)
    80005768:	0a013903          	ld	s2,160(sp)
    8000576c:	0c010113          	addi	sp,sp,192
    80005770:	00008067          	ret
    80005774:	00050913          	mv	s2,a0
        threads[i] = new WorkerSemMax();
    80005778:	00048513          	mv	a0,s1
    8000577c:	ffffc097          	auipc	ra,0xffffc
    80005780:	26c080e7          	jalr	620(ra) # 800019e8 <_ZdlPv>
    80005784:	00090513          	mv	a0,s2
    80005788:	00006097          	auipc	ra,0x6
    8000578c:	f40080e7          	jalr	-192(ra) # 8000b6c8 <_Unwind_Resume>

0000000080005790 <_ZN12WorkerSemMaxD1Ev>:
class WorkerSemMax: public Thread {
    80005790:	ff010113          	addi	sp,sp,-16
    80005794:	00113423          	sd	ra,8(sp)
    80005798:	00813023          	sd	s0,0(sp)
    8000579c:	01010413          	addi	s0,sp,16
    800057a0:	00005797          	auipc	a5,0x5
    800057a4:	d5878793          	addi	a5,a5,-680 # 8000a4f8 <_ZTV12WorkerSemMax+0x10>
    800057a8:	00f53023          	sd	a5,0(a0)
    800057ac:	ffffc097          	auipc	ra,0xffffc
    800057b0:	28c080e7          	jalr	652(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800057b4:	00813083          	ld	ra,8(sp)
    800057b8:	00013403          	ld	s0,0(sp)
    800057bc:	01010113          	addi	sp,sp,16
    800057c0:	00008067          	ret

00000000800057c4 <_ZN12WorkerSemMaxD0Ev>:
    800057c4:	fe010113          	addi	sp,sp,-32
    800057c8:	00113c23          	sd	ra,24(sp)
    800057cc:	00813823          	sd	s0,16(sp)
    800057d0:	00913423          	sd	s1,8(sp)
    800057d4:	02010413          	addi	s0,sp,32
    800057d8:	00050493          	mv	s1,a0
    800057dc:	00005797          	auipc	a5,0x5
    800057e0:	d1c78793          	addi	a5,a5,-740 # 8000a4f8 <_ZTV12WorkerSemMax+0x10>
    800057e4:	00f53023          	sd	a5,0(a0)
    800057e8:	ffffc097          	auipc	ra,0xffffc
    800057ec:	250080e7          	jalr	592(ra) # 80001a38 <_ZN6ThreadD1Ev>
    800057f0:	00048513          	mv	a0,s1
    800057f4:	ffffc097          	auipc	ra,0xffffc
    800057f8:	1f4080e7          	jalr	500(ra) # 800019e8 <_ZdlPv>
    800057fc:	01813083          	ld	ra,24(sp)
    80005800:	01013403          	ld	s0,16(sp)
    80005804:	00813483          	ld	s1,8(sp)
    80005808:	02010113          	addi	sp,sp,32
    8000580c:	00008067          	ret

0000000080005810 <_ZN12WorkerSemMax3runEv>:
    void run() override {
    80005810:	ff010113          	addi	sp,sp,-16
    80005814:	00113423          	sd	ra,8(sp)
    80005818:	00813023          	sd	s0,0(sp)
    8000581c:	01010413          	addi	s0,sp,16
        workerBody(nullptr);
    80005820:	00000593          	li	a1,0
    80005824:	00000097          	auipc	ra,0x0
    80005828:	dec080e7          	jalr	-532(ra) # 80005610 <_ZN12WorkerSemMax10workerBodyEPv>
    }
    8000582c:	00813083          	ld	ra,8(sp)
    80005830:	00013403          	ld	s0,0(sp)
    80005834:	01010113          	addi	sp,sp,16
    80005838:	00008067          	ret

000000008000583c <start>:
    8000583c:	ff010113          	addi	sp,sp,-16
    80005840:	00813423          	sd	s0,8(sp)
    80005844:	01010413          	addi	s0,sp,16
    80005848:	300027f3          	csrr	a5,mstatus
    8000584c:	ffffe737          	lui	a4,0xffffe
    80005850:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff2f9f>
    80005854:	00e7f7b3          	and	a5,a5,a4
    80005858:	00001737          	lui	a4,0x1
    8000585c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005860:	00e7e7b3          	or	a5,a5,a4
    80005864:	30079073          	csrw	mstatus,a5
    80005868:	00000797          	auipc	a5,0x0
    8000586c:	16078793          	addi	a5,a5,352 # 800059c8 <system_main>
    80005870:	34179073          	csrw	mepc,a5
    80005874:	00000793          	li	a5,0
    80005878:	18079073          	csrw	satp,a5
    8000587c:	000107b7          	lui	a5,0x10
    80005880:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005884:	30279073          	csrw	medeleg,a5
    80005888:	30379073          	csrw	mideleg,a5
    8000588c:	104027f3          	csrr	a5,sie
    80005890:	2227e793          	ori	a5,a5,546
    80005894:	10479073          	csrw	sie,a5
    80005898:	fff00793          	li	a5,-1
    8000589c:	00a7d793          	srli	a5,a5,0xa
    800058a0:	3b079073          	csrw	pmpaddr0,a5
    800058a4:	00f00793          	li	a5,15
    800058a8:	3a079073          	csrw	pmpcfg0,a5
    800058ac:	f14027f3          	csrr	a5,mhartid
    800058b0:	0200c737          	lui	a4,0x200c
    800058b4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800058b8:	0007869b          	sext.w	a3,a5
    800058bc:	00269713          	slli	a4,a3,0x2
    800058c0:	000f4637          	lui	a2,0xf4
    800058c4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800058c8:	00d70733          	add	a4,a4,a3
    800058cc:	0037979b          	slliw	a5,a5,0x3
    800058d0:	020046b7          	lui	a3,0x2004
    800058d4:	00d787b3          	add	a5,a5,a3
    800058d8:	00c585b3          	add	a1,a1,a2
    800058dc:	00371693          	slli	a3,a4,0x3
    800058e0:	00005717          	auipc	a4,0x5
    800058e4:	d2070713          	addi	a4,a4,-736 # 8000a600 <timer_scratch>
    800058e8:	00b7b023          	sd	a1,0(a5)
    800058ec:	00d70733          	add	a4,a4,a3
    800058f0:	00f73c23          	sd	a5,24(a4)
    800058f4:	02c73023          	sd	a2,32(a4)
    800058f8:	34071073          	csrw	mscratch,a4
    800058fc:	00000797          	auipc	a5,0x0
    80005900:	6e478793          	addi	a5,a5,1764 # 80005fe0 <timervec>
    80005904:	30579073          	csrw	mtvec,a5
    80005908:	300027f3          	csrr	a5,mstatus
    8000590c:	0087e793          	ori	a5,a5,8
    80005910:	30079073          	csrw	mstatus,a5
    80005914:	304027f3          	csrr	a5,mie
    80005918:	0807e793          	ori	a5,a5,128
    8000591c:	30479073          	csrw	mie,a5
    80005920:	f14027f3          	csrr	a5,mhartid
    80005924:	0007879b          	sext.w	a5,a5
    80005928:	00078213          	mv	tp,a5
    8000592c:	30200073          	mret
    80005930:	00813403          	ld	s0,8(sp)
    80005934:	01010113          	addi	sp,sp,16
    80005938:	00008067          	ret

000000008000593c <timerinit>:
    8000593c:	ff010113          	addi	sp,sp,-16
    80005940:	00813423          	sd	s0,8(sp)
    80005944:	01010413          	addi	s0,sp,16
    80005948:	f14027f3          	csrr	a5,mhartid
    8000594c:	0200c737          	lui	a4,0x200c
    80005950:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005954:	0007869b          	sext.w	a3,a5
    80005958:	00269713          	slli	a4,a3,0x2
    8000595c:	000f4637          	lui	a2,0xf4
    80005960:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005964:	00d70733          	add	a4,a4,a3
    80005968:	0037979b          	slliw	a5,a5,0x3
    8000596c:	020046b7          	lui	a3,0x2004
    80005970:	00d787b3          	add	a5,a5,a3
    80005974:	00c585b3          	add	a1,a1,a2
    80005978:	00371693          	slli	a3,a4,0x3
    8000597c:	00005717          	auipc	a4,0x5
    80005980:	c8470713          	addi	a4,a4,-892 # 8000a600 <timer_scratch>
    80005984:	00b7b023          	sd	a1,0(a5)
    80005988:	00d70733          	add	a4,a4,a3
    8000598c:	00f73c23          	sd	a5,24(a4)
    80005990:	02c73023          	sd	a2,32(a4)
    80005994:	34071073          	csrw	mscratch,a4
    80005998:	00000797          	auipc	a5,0x0
    8000599c:	64878793          	addi	a5,a5,1608 # 80005fe0 <timervec>
    800059a0:	30579073          	csrw	mtvec,a5
    800059a4:	300027f3          	csrr	a5,mstatus
    800059a8:	0087e793          	ori	a5,a5,8
    800059ac:	30079073          	csrw	mstatus,a5
    800059b0:	304027f3          	csrr	a5,mie
    800059b4:	0807e793          	ori	a5,a5,128
    800059b8:	30479073          	csrw	mie,a5
    800059bc:	00813403          	ld	s0,8(sp)
    800059c0:	01010113          	addi	sp,sp,16
    800059c4:	00008067          	ret

00000000800059c8 <system_main>:
    800059c8:	fe010113          	addi	sp,sp,-32
    800059cc:	00813823          	sd	s0,16(sp)
    800059d0:	00913423          	sd	s1,8(sp)
    800059d4:	00113c23          	sd	ra,24(sp)
    800059d8:	02010413          	addi	s0,sp,32
    800059dc:	00000097          	auipc	ra,0x0
    800059e0:	0c4080e7          	jalr	196(ra) # 80005aa0 <cpuid>
    800059e4:	00005497          	auipc	s1,0x5
    800059e8:	b7c48493          	addi	s1,s1,-1156 # 8000a560 <started>
    800059ec:	02050263          	beqz	a0,80005a10 <system_main+0x48>
    800059f0:	0004a783          	lw	a5,0(s1)
    800059f4:	0007879b          	sext.w	a5,a5
    800059f8:	fe078ce3          	beqz	a5,800059f0 <system_main+0x28>
    800059fc:	0ff0000f          	fence
    80005a00:	00003517          	auipc	a0,0x3
    80005a04:	c5850513          	addi	a0,a0,-936 # 80008658 <CONSOLE_STATUS+0x648>
    80005a08:	00001097          	auipc	ra,0x1
    80005a0c:	a74080e7          	jalr	-1420(ra) # 8000647c <panic>
    80005a10:	00001097          	auipc	ra,0x1
    80005a14:	9c8080e7          	jalr	-1592(ra) # 800063d8 <consoleinit>
    80005a18:	00001097          	auipc	ra,0x1
    80005a1c:	154080e7          	jalr	340(ra) # 80006b6c <printfinit>
    80005a20:	00003517          	auipc	a0,0x3
    80005a24:	bb050513          	addi	a0,a0,-1104 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80005a28:	00001097          	auipc	ra,0x1
    80005a2c:	ab0080e7          	jalr	-1360(ra) # 800064d8 <__printf>
    80005a30:	00003517          	auipc	a0,0x3
    80005a34:	bf850513          	addi	a0,a0,-1032 # 80008628 <CONSOLE_STATUS+0x618>
    80005a38:	00001097          	auipc	ra,0x1
    80005a3c:	aa0080e7          	jalr	-1376(ra) # 800064d8 <__printf>
    80005a40:	00003517          	auipc	a0,0x3
    80005a44:	b9050513          	addi	a0,a0,-1136 # 800085d0 <CONSOLE_STATUS+0x5c0>
    80005a48:	00001097          	auipc	ra,0x1
    80005a4c:	a90080e7          	jalr	-1392(ra) # 800064d8 <__printf>
    80005a50:	00001097          	auipc	ra,0x1
    80005a54:	4a8080e7          	jalr	1192(ra) # 80006ef8 <kinit>
    80005a58:	00000097          	auipc	ra,0x0
    80005a5c:	148080e7          	jalr	328(ra) # 80005ba0 <trapinit>
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	16c080e7          	jalr	364(ra) # 80005bcc <trapinithart>
    80005a68:	00000097          	auipc	ra,0x0
    80005a6c:	5b8080e7          	jalr	1464(ra) # 80006020 <plicinit>
    80005a70:	00000097          	auipc	ra,0x0
    80005a74:	5d8080e7          	jalr	1496(ra) # 80006048 <plicinithart>
    80005a78:	00000097          	auipc	ra,0x0
    80005a7c:	078080e7          	jalr	120(ra) # 80005af0 <userinit>
    80005a80:	0ff0000f          	fence
    80005a84:	00100793          	li	a5,1
    80005a88:	00003517          	auipc	a0,0x3
    80005a8c:	bb850513          	addi	a0,a0,-1096 # 80008640 <CONSOLE_STATUS+0x630>
    80005a90:	00f4a023          	sw	a5,0(s1)
    80005a94:	00001097          	auipc	ra,0x1
    80005a98:	a44080e7          	jalr	-1468(ra) # 800064d8 <__printf>
    80005a9c:	0000006f          	j	80005a9c <system_main+0xd4>

0000000080005aa0 <cpuid>:
    80005aa0:	ff010113          	addi	sp,sp,-16
    80005aa4:	00813423          	sd	s0,8(sp)
    80005aa8:	01010413          	addi	s0,sp,16
    80005aac:	00020513          	mv	a0,tp
    80005ab0:	00813403          	ld	s0,8(sp)
    80005ab4:	0005051b          	sext.w	a0,a0
    80005ab8:	01010113          	addi	sp,sp,16
    80005abc:	00008067          	ret

0000000080005ac0 <mycpu>:
    80005ac0:	ff010113          	addi	sp,sp,-16
    80005ac4:	00813423          	sd	s0,8(sp)
    80005ac8:	01010413          	addi	s0,sp,16
    80005acc:	00020793          	mv	a5,tp
    80005ad0:	00813403          	ld	s0,8(sp)
    80005ad4:	0007879b          	sext.w	a5,a5
    80005ad8:	00779793          	slli	a5,a5,0x7
    80005adc:	00006517          	auipc	a0,0x6
    80005ae0:	b5450513          	addi	a0,a0,-1196 # 8000b630 <cpus>
    80005ae4:	00f50533          	add	a0,a0,a5
    80005ae8:	01010113          	addi	sp,sp,16
    80005aec:	00008067          	ret

0000000080005af0 <userinit>:
    80005af0:	ff010113          	addi	sp,sp,-16
    80005af4:	00813423          	sd	s0,8(sp)
    80005af8:	01010413          	addi	s0,sp,16
    80005afc:	00813403          	ld	s0,8(sp)
    80005b00:	01010113          	addi	sp,sp,16
    80005b04:	ffffc317          	auipc	t1,0xffffc
    80005b08:	dd430067          	jr	-556(t1) # 800018d8 <main>

0000000080005b0c <either_copyout>:
    80005b0c:	ff010113          	addi	sp,sp,-16
    80005b10:	00813023          	sd	s0,0(sp)
    80005b14:	00113423          	sd	ra,8(sp)
    80005b18:	01010413          	addi	s0,sp,16
    80005b1c:	02051663          	bnez	a0,80005b48 <either_copyout+0x3c>
    80005b20:	00058513          	mv	a0,a1
    80005b24:	00060593          	mv	a1,a2
    80005b28:	0006861b          	sext.w	a2,a3
    80005b2c:	00002097          	auipc	ra,0x2
    80005b30:	c58080e7          	jalr	-936(ra) # 80007784 <__memmove>
    80005b34:	00813083          	ld	ra,8(sp)
    80005b38:	00013403          	ld	s0,0(sp)
    80005b3c:	00000513          	li	a0,0
    80005b40:	01010113          	addi	sp,sp,16
    80005b44:	00008067          	ret
    80005b48:	00003517          	auipc	a0,0x3
    80005b4c:	b3850513          	addi	a0,a0,-1224 # 80008680 <CONSOLE_STATUS+0x670>
    80005b50:	00001097          	auipc	ra,0x1
    80005b54:	92c080e7          	jalr	-1748(ra) # 8000647c <panic>

0000000080005b58 <either_copyin>:
    80005b58:	ff010113          	addi	sp,sp,-16
    80005b5c:	00813023          	sd	s0,0(sp)
    80005b60:	00113423          	sd	ra,8(sp)
    80005b64:	01010413          	addi	s0,sp,16
    80005b68:	02059463          	bnez	a1,80005b90 <either_copyin+0x38>
    80005b6c:	00060593          	mv	a1,a2
    80005b70:	0006861b          	sext.w	a2,a3
    80005b74:	00002097          	auipc	ra,0x2
    80005b78:	c10080e7          	jalr	-1008(ra) # 80007784 <__memmove>
    80005b7c:	00813083          	ld	ra,8(sp)
    80005b80:	00013403          	ld	s0,0(sp)
    80005b84:	00000513          	li	a0,0
    80005b88:	01010113          	addi	sp,sp,16
    80005b8c:	00008067          	ret
    80005b90:	00003517          	auipc	a0,0x3
    80005b94:	b1850513          	addi	a0,a0,-1256 # 800086a8 <CONSOLE_STATUS+0x698>
    80005b98:	00001097          	auipc	ra,0x1
    80005b9c:	8e4080e7          	jalr	-1820(ra) # 8000647c <panic>

0000000080005ba0 <trapinit>:
    80005ba0:	ff010113          	addi	sp,sp,-16
    80005ba4:	00813423          	sd	s0,8(sp)
    80005ba8:	01010413          	addi	s0,sp,16
    80005bac:	00813403          	ld	s0,8(sp)
    80005bb0:	00003597          	auipc	a1,0x3
    80005bb4:	b2058593          	addi	a1,a1,-1248 # 800086d0 <CONSOLE_STATUS+0x6c0>
    80005bb8:	00006517          	auipc	a0,0x6
    80005bbc:	af850513          	addi	a0,a0,-1288 # 8000b6b0 <tickslock>
    80005bc0:	01010113          	addi	sp,sp,16
    80005bc4:	00001317          	auipc	t1,0x1
    80005bc8:	5c430067          	jr	1476(t1) # 80007188 <initlock>

0000000080005bcc <trapinithart>:
    80005bcc:	ff010113          	addi	sp,sp,-16
    80005bd0:	00813423          	sd	s0,8(sp)
    80005bd4:	01010413          	addi	s0,sp,16
    80005bd8:	00000797          	auipc	a5,0x0
    80005bdc:	2f878793          	addi	a5,a5,760 # 80005ed0 <kernelvec>
    80005be0:	10579073          	csrw	stvec,a5
    80005be4:	00813403          	ld	s0,8(sp)
    80005be8:	01010113          	addi	sp,sp,16
    80005bec:	00008067          	ret

0000000080005bf0 <usertrap>:
    80005bf0:	ff010113          	addi	sp,sp,-16
    80005bf4:	00813423          	sd	s0,8(sp)
    80005bf8:	01010413          	addi	s0,sp,16
    80005bfc:	00813403          	ld	s0,8(sp)
    80005c00:	01010113          	addi	sp,sp,16
    80005c04:	00008067          	ret

0000000080005c08 <usertrapret>:
    80005c08:	ff010113          	addi	sp,sp,-16
    80005c0c:	00813423          	sd	s0,8(sp)
    80005c10:	01010413          	addi	s0,sp,16
    80005c14:	00813403          	ld	s0,8(sp)
    80005c18:	01010113          	addi	sp,sp,16
    80005c1c:	00008067          	ret

0000000080005c20 <kerneltrap>:
    80005c20:	fe010113          	addi	sp,sp,-32
    80005c24:	00813823          	sd	s0,16(sp)
    80005c28:	00113c23          	sd	ra,24(sp)
    80005c2c:	00913423          	sd	s1,8(sp)
    80005c30:	02010413          	addi	s0,sp,32
    80005c34:	142025f3          	csrr	a1,scause
    80005c38:	100027f3          	csrr	a5,sstatus
    80005c3c:	0027f793          	andi	a5,a5,2
    80005c40:	10079c63          	bnez	a5,80005d58 <kerneltrap+0x138>
    80005c44:	142027f3          	csrr	a5,scause
    80005c48:	0207ce63          	bltz	a5,80005c84 <kerneltrap+0x64>
    80005c4c:	00003517          	auipc	a0,0x3
    80005c50:	acc50513          	addi	a0,a0,-1332 # 80008718 <CONSOLE_STATUS+0x708>
    80005c54:	00001097          	auipc	ra,0x1
    80005c58:	884080e7          	jalr	-1916(ra) # 800064d8 <__printf>
    80005c5c:	141025f3          	csrr	a1,sepc
    80005c60:	14302673          	csrr	a2,stval
    80005c64:	00003517          	auipc	a0,0x3
    80005c68:	ac450513          	addi	a0,a0,-1340 # 80008728 <CONSOLE_STATUS+0x718>
    80005c6c:	00001097          	auipc	ra,0x1
    80005c70:	86c080e7          	jalr	-1940(ra) # 800064d8 <__printf>
    80005c74:	00003517          	auipc	a0,0x3
    80005c78:	acc50513          	addi	a0,a0,-1332 # 80008740 <CONSOLE_STATUS+0x730>
    80005c7c:	00001097          	auipc	ra,0x1
    80005c80:	800080e7          	jalr	-2048(ra) # 8000647c <panic>
    80005c84:	0ff7f713          	andi	a4,a5,255
    80005c88:	00900693          	li	a3,9
    80005c8c:	04d70063          	beq	a4,a3,80005ccc <kerneltrap+0xac>
    80005c90:	fff00713          	li	a4,-1
    80005c94:	03f71713          	slli	a4,a4,0x3f
    80005c98:	00170713          	addi	a4,a4,1
    80005c9c:	fae798e3          	bne	a5,a4,80005c4c <kerneltrap+0x2c>
    80005ca0:	00000097          	auipc	ra,0x0
    80005ca4:	e00080e7          	jalr	-512(ra) # 80005aa0 <cpuid>
    80005ca8:	06050663          	beqz	a0,80005d14 <kerneltrap+0xf4>
    80005cac:	144027f3          	csrr	a5,sip
    80005cb0:	ffd7f793          	andi	a5,a5,-3
    80005cb4:	14479073          	csrw	sip,a5
    80005cb8:	01813083          	ld	ra,24(sp)
    80005cbc:	01013403          	ld	s0,16(sp)
    80005cc0:	00813483          	ld	s1,8(sp)
    80005cc4:	02010113          	addi	sp,sp,32
    80005cc8:	00008067          	ret
    80005ccc:	00000097          	auipc	ra,0x0
    80005cd0:	3c8080e7          	jalr	968(ra) # 80006094 <plic_claim>
    80005cd4:	00a00793          	li	a5,10
    80005cd8:	00050493          	mv	s1,a0
    80005cdc:	06f50863          	beq	a0,a5,80005d4c <kerneltrap+0x12c>
    80005ce0:	fc050ce3          	beqz	a0,80005cb8 <kerneltrap+0x98>
    80005ce4:	00050593          	mv	a1,a0
    80005ce8:	00003517          	auipc	a0,0x3
    80005cec:	a1050513          	addi	a0,a0,-1520 # 800086f8 <CONSOLE_STATUS+0x6e8>
    80005cf0:	00000097          	auipc	ra,0x0
    80005cf4:	7e8080e7          	jalr	2024(ra) # 800064d8 <__printf>
    80005cf8:	01013403          	ld	s0,16(sp)
    80005cfc:	01813083          	ld	ra,24(sp)
    80005d00:	00048513          	mv	a0,s1
    80005d04:	00813483          	ld	s1,8(sp)
    80005d08:	02010113          	addi	sp,sp,32
    80005d0c:	00000317          	auipc	t1,0x0
    80005d10:	3c030067          	jr	960(t1) # 800060cc <plic_complete>
    80005d14:	00006517          	auipc	a0,0x6
    80005d18:	99c50513          	addi	a0,a0,-1636 # 8000b6b0 <tickslock>
    80005d1c:	00001097          	auipc	ra,0x1
    80005d20:	490080e7          	jalr	1168(ra) # 800071ac <acquire>
    80005d24:	00005717          	auipc	a4,0x5
    80005d28:	84070713          	addi	a4,a4,-1984 # 8000a564 <ticks>
    80005d2c:	00072783          	lw	a5,0(a4)
    80005d30:	00006517          	auipc	a0,0x6
    80005d34:	98050513          	addi	a0,a0,-1664 # 8000b6b0 <tickslock>
    80005d38:	0017879b          	addiw	a5,a5,1
    80005d3c:	00f72023          	sw	a5,0(a4)
    80005d40:	00001097          	auipc	ra,0x1
    80005d44:	538080e7          	jalr	1336(ra) # 80007278 <release>
    80005d48:	f65ff06f          	j	80005cac <kerneltrap+0x8c>
    80005d4c:	00001097          	auipc	ra,0x1
    80005d50:	094080e7          	jalr	148(ra) # 80006de0 <uartintr>
    80005d54:	fa5ff06f          	j	80005cf8 <kerneltrap+0xd8>
    80005d58:	00003517          	auipc	a0,0x3
    80005d5c:	98050513          	addi	a0,a0,-1664 # 800086d8 <CONSOLE_STATUS+0x6c8>
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	71c080e7          	jalr	1820(ra) # 8000647c <panic>

0000000080005d68 <clockintr>:
    80005d68:	fe010113          	addi	sp,sp,-32
    80005d6c:	00813823          	sd	s0,16(sp)
    80005d70:	00913423          	sd	s1,8(sp)
    80005d74:	00113c23          	sd	ra,24(sp)
    80005d78:	02010413          	addi	s0,sp,32
    80005d7c:	00006497          	auipc	s1,0x6
    80005d80:	93448493          	addi	s1,s1,-1740 # 8000b6b0 <tickslock>
    80005d84:	00048513          	mv	a0,s1
    80005d88:	00001097          	auipc	ra,0x1
    80005d8c:	424080e7          	jalr	1060(ra) # 800071ac <acquire>
    80005d90:	00004717          	auipc	a4,0x4
    80005d94:	7d470713          	addi	a4,a4,2004 # 8000a564 <ticks>
    80005d98:	00072783          	lw	a5,0(a4)
    80005d9c:	01013403          	ld	s0,16(sp)
    80005da0:	01813083          	ld	ra,24(sp)
    80005da4:	00048513          	mv	a0,s1
    80005da8:	0017879b          	addiw	a5,a5,1
    80005dac:	00813483          	ld	s1,8(sp)
    80005db0:	00f72023          	sw	a5,0(a4)
    80005db4:	02010113          	addi	sp,sp,32
    80005db8:	00001317          	auipc	t1,0x1
    80005dbc:	4c030067          	jr	1216(t1) # 80007278 <release>

0000000080005dc0 <devintr>:
    80005dc0:	142027f3          	csrr	a5,scause
    80005dc4:	00000513          	li	a0,0
    80005dc8:	0007c463          	bltz	a5,80005dd0 <devintr+0x10>
    80005dcc:	00008067          	ret
    80005dd0:	fe010113          	addi	sp,sp,-32
    80005dd4:	00813823          	sd	s0,16(sp)
    80005dd8:	00113c23          	sd	ra,24(sp)
    80005ddc:	00913423          	sd	s1,8(sp)
    80005de0:	02010413          	addi	s0,sp,32
    80005de4:	0ff7f713          	andi	a4,a5,255
    80005de8:	00900693          	li	a3,9
    80005dec:	04d70c63          	beq	a4,a3,80005e44 <devintr+0x84>
    80005df0:	fff00713          	li	a4,-1
    80005df4:	03f71713          	slli	a4,a4,0x3f
    80005df8:	00170713          	addi	a4,a4,1
    80005dfc:	00e78c63          	beq	a5,a4,80005e14 <devintr+0x54>
    80005e00:	01813083          	ld	ra,24(sp)
    80005e04:	01013403          	ld	s0,16(sp)
    80005e08:	00813483          	ld	s1,8(sp)
    80005e0c:	02010113          	addi	sp,sp,32
    80005e10:	00008067          	ret
    80005e14:	00000097          	auipc	ra,0x0
    80005e18:	c8c080e7          	jalr	-884(ra) # 80005aa0 <cpuid>
    80005e1c:	06050663          	beqz	a0,80005e88 <devintr+0xc8>
    80005e20:	144027f3          	csrr	a5,sip
    80005e24:	ffd7f793          	andi	a5,a5,-3
    80005e28:	14479073          	csrw	sip,a5
    80005e2c:	01813083          	ld	ra,24(sp)
    80005e30:	01013403          	ld	s0,16(sp)
    80005e34:	00813483          	ld	s1,8(sp)
    80005e38:	00200513          	li	a0,2
    80005e3c:	02010113          	addi	sp,sp,32
    80005e40:	00008067          	ret
    80005e44:	00000097          	auipc	ra,0x0
    80005e48:	250080e7          	jalr	592(ra) # 80006094 <plic_claim>
    80005e4c:	00a00793          	li	a5,10
    80005e50:	00050493          	mv	s1,a0
    80005e54:	06f50663          	beq	a0,a5,80005ec0 <devintr+0x100>
    80005e58:	00100513          	li	a0,1
    80005e5c:	fa0482e3          	beqz	s1,80005e00 <devintr+0x40>
    80005e60:	00048593          	mv	a1,s1
    80005e64:	00003517          	auipc	a0,0x3
    80005e68:	89450513          	addi	a0,a0,-1900 # 800086f8 <CONSOLE_STATUS+0x6e8>
    80005e6c:	00000097          	auipc	ra,0x0
    80005e70:	66c080e7          	jalr	1644(ra) # 800064d8 <__printf>
    80005e74:	00048513          	mv	a0,s1
    80005e78:	00000097          	auipc	ra,0x0
    80005e7c:	254080e7          	jalr	596(ra) # 800060cc <plic_complete>
    80005e80:	00100513          	li	a0,1
    80005e84:	f7dff06f          	j	80005e00 <devintr+0x40>
    80005e88:	00006517          	auipc	a0,0x6
    80005e8c:	82850513          	addi	a0,a0,-2008 # 8000b6b0 <tickslock>
    80005e90:	00001097          	auipc	ra,0x1
    80005e94:	31c080e7          	jalr	796(ra) # 800071ac <acquire>
    80005e98:	00004717          	auipc	a4,0x4
    80005e9c:	6cc70713          	addi	a4,a4,1740 # 8000a564 <ticks>
    80005ea0:	00072783          	lw	a5,0(a4)
    80005ea4:	00006517          	auipc	a0,0x6
    80005ea8:	80c50513          	addi	a0,a0,-2036 # 8000b6b0 <tickslock>
    80005eac:	0017879b          	addiw	a5,a5,1
    80005eb0:	00f72023          	sw	a5,0(a4)
    80005eb4:	00001097          	auipc	ra,0x1
    80005eb8:	3c4080e7          	jalr	964(ra) # 80007278 <release>
    80005ebc:	f65ff06f          	j	80005e20 <devintr+0x60>
    80005ec0:	00001097          	auipc	ra,0x1
    80005ec4:	f20080e7          	jalr	-224(ra) # 80006de0 <uartintr>
    80005ec8:	fadff06f          	j	80005e74 <devintr+0xb4>
    80005ecc:	0000                	unimp
	...

0000000080005ed0 <kernelvec>:
    80005ed0:	f0010113          	addi	sp,sp,-256
    80005ed4:	00113023          	sd	ra,0(sp)
    80005ed8:	00213423          	sd	sp,8(sp)
    80005edc:	00313823          	sd	gp,16(sp)
    80005ee0:	00413c23          	sd	tp,24(sp)
    80005ee4:	02513023          	sd	t0,32(sp)
    80005ee8:	02613423          	sd	t1,40(sp)
    80005eec:	02713823          	sd	t2,48(sp)
    80005ef0:	02813c23          	sd	s0,56(sp)
    80005ef4:	04913023          	sd	s1,64(sp)
    80005ef8:	04a13423          	sd	a0,72(sp)
    80005efc:	04b13823          	sd	a1,80(sp)
    80005f00:	04c13c23          	sd	a2,88(sp)
    80005f04:	06d13023          	sd	a3,96(sp)
    80005f08:	06e13423          	sd	a4,104(sp)
    80005f0c:	06f13823          	sd	a5,112(sp)
    80005f10:	07013c23          	sd	a6,120(sp)
    80005f14:	09113023          	sd	a7,128(sp)
    80005f18:	09213423          	sd	s2,136(sp)
    80005f1c:	09313823          	sd	s3,144(sp)
    80005f20:	09413c23          	sd	s4,152(sp)
    80005f24:	0b513023          	sd	s5,160(sp)
    80005f28:	0b613423          	sd	s6,168(sp)
    80005f2c:	0b713823          	sd	s7,176(sp)
    80005f30:	0b813c23          	sd	s8,184(sp)
    80005f34:	0d913023          	sd	s9,192(sp)
    80005f38:	0da13423          	sd	s10,200(sp)
    80005f3c:	0db13823          	sd	s11,208(sp)
    80005f40:	0dc13c23          	sd	t3,216(sp)
    80005f44:	0fd13023          	sd	t4,224(sp)
    80005f48:	0fe13423          	sd	t5,232(sp)
    80005f4c:	0ff13823          	sd	t6,240(sp)
    80005f50:	cd1ff0ef          	jal	ra,80005c20 <kerneltrap>
    80005f54:	00013083          	ld	ra,0(sp)
    80005f58:	00813103          	ld	sp,8(sp)
    80005f5c:	01013183          	ld	gp,16(sp)
    80005f60:	02013283          	ld	t0,32(sp)
    80005f64:	02813303          	ld	t1,40(sp)
    80005f68:	03013383          	ld	t2,48(sp)
    80005f6c:	03813403          	ld	s0,56(sp)
    80005f70:	04013483          	ld	s1,64(sp)
    80005f74:	04813503          	ld	a0,72(sp)
    80005f78:	05013583          	ld	a1,80(sp)
    80005f7c:	05813603          	ld	a2,88(sp)
    80005f80:	06013683          	ld	a3,96(sp)
    80005f84:	06813703          	ld	a4,104(sp)
    80005f88:	07013783          	ld	a5,112(sp)
    80005f8c:	07813803          	ld	a6,120(sp)
    80005f90:	08013883          	ld	a7,128(sp)
    80005f94:	08813903          	ld	s2,136(sp)
    80005f98:	09013983          	ld	s3,144(sp)
    80005f9c:	09813a03          	ld	s4,152(sp)
    80005fa0:	0a013a83          	ld	s5,160(sp)
    80005fa4:	0a813b03          	ld	s6,168(sp)
    80005fa8:	0b013b83          	ld	s7,176(sp)
    80005fac:	0b813c03          	ld	s8,184(sp)
    80005fb0:	0c013c83          	ld	s9,192(sp)
    80005fb4:	0c813d03          	ld	s10,200(sp)
    80005fb8:	0d013d83          	ld	s11,208(sp)
    80005fbc:	0d813e03          	ld	t3,216(sp)
    80005fc0:	0e013e83          	ld	t4,224(sp)
    80005fc4:	0e813f03          	ld	t5,232(sp)
    80005fc8:	0f013f83          	ld	t6,240(sp)
    80005fcc:	10010113          	addi	sp,sp,256
    80005fd0:	10200073          	sret
    80005fd4:	00000013          	nop
    80005fd8:	00000013          	nop
    80005fdc:	00000013          	nop

0000000080005fe0 <timervec>:
    80005fe0:	34051573          	csrrw	a0,mscratch,a0
    80005fe4:	00b53023          	sd	a1,0(a0)
    80005fe8:	00c53423          	sd	a2,8(a0)
    80005fec:	00d53823          	sd	a3,16(a0)
    80005ff0:	01853583          	ld	a1,24(a0)
    80005ff4:	02053603          	ld	a2,32(a0)
    80005ff8:	0005b683          	ld	a3,0(a1)
    80005ffc:	00c686b3          	add	a3,a3,a2
    80006000:	00d5b023          	sd	a3,0(a1)
    80006004:	00200593          	li	a1,2
    80006008:	14459073          	csrw	sip,a1
    8000600c:	01053683          	ld	a3,16(a0)
    80006010:	00853603          	ld	a2,8(a0)
    80006014:	00053583          	ld	a1,0(a0)
    80006018:	34051573          	csrrw	a0,mscratch,a0
    8000601c:	30200073          	mret

0000000080006020 <plicinit>:
    80006020:	ff010113          	addi	sp,sp,-16
    80006024:	00813423          	sd	s0,8(sp)
    80006028:	01010413          	addi	s0,sp,16
    8000602c:	00813403          	ld	s0,8(sp)
    80006030:	0c0007b7          	lui	a5,0xc000
    80006034:	00100713          	li	a4,1
    80006038:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000603c:	00e7a223          	sw	a4,4(a5)
    80006040:	01010113          	addi	sp,sp,16
    80006044:	00008067          	ret

0000000080006048 <plicinithart>:
    80006048:	ff010113          	addi	sp,sp,-16
    8000604c:	00813023          	sd	s0,0(sp)
    80006050:	00113423          	sd	ra,8(sp)
    80006054:	01010413          	addi	s0,sp,16
    80006058:	00000097          	auipc	ra,0x0
    8000605c:	a48080e7          	jalr	-1464(ra) # 80005aa0 <cpuid>
    80006060:	0085171b          	slliw	a4,a0,0x8
    80006064:	0c0027b7          	lui	a5,0xc002
    80006068:	00e787b3          	add	a5,a5,a4
    8000606c:	40200713          	li	a4,1026
    80006070:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006074:	00813083          	ld	ra,8(sp)
    80006078:	00013403          	ld	s0,0(sp)
    8000607c:	00d5151b          	slliw	a0,a0,0xd
    80006080:	0c2017b7          	lui	a5,0xc201
    80006084:	00a78533          	add	a0,a5,a0
    80006088:	00052023          	sw	zero,0(a0)
    8000608c:	01010113          	addi	sp,sp,16
    80006090:	00008067          	ret

0000000080006094 <plic_claim>:
    80006094:	ff010113          	addi	sp,sp,-16
    80006098:	00813023          	sd	s0,0(sp)
    8000609c:	00113423          	sd	ra,8(sp)
    800060a0:	01010413          	addi	s0,sp,16
    800060a4:	00000097          	auipc	ra,0x0
    800060a8:	9fc080e7          	jalr	-1540(ra) # 80005aa0 <cpuid>
    800060ac:	00813083          	ld	ra,8(sp)
    800060b0:	00013403          	ld	s0,0(sp)
    800060b4:	00d5151b          	slliw	a0,a0,0xd
    800060b8:	0c2017b7          	lui	a5,0xc201
    800060bc:	00a78533          	add	a0,a5,a0
    800060c0:	00452503          	lw	a0,4(a0)
    800060c4:	01010113          	addi	sp,sp,16
    800060c8:	00008067          	ret

00000000800060cc <plic_complete>:
    800060cc:	fe010113          	addi	sp,sp,-32
    800060d0:	00813823          	sd	s0,16(sp)
    800060d4:	00913423          	sd	s1,8(sp)
    800060d8:	00113c23          	sd	ra,24(sp)
    800060dc:	02010413          	addi	s0,sp,32
    800060e0:	00050493          	mv	s1,a0
    800060e4:	00000097          	auipc	ra,0x0
    800060e8:	9bc080e7          	jalr	-1604(ra) # 80005aa0 <cpuid>
    800060ec:	01813083          	ld	ra,24(sp)
    800060f0:	01013403          	ld	s0,16(sp)
    800060f4:	00d5179b          	slliw	a5,a0,0xd
    800060f8:	0c201737          	lui	a4,0xc201
    800060fc:	00f707b3          	add	a5,a4,a5
    80006100:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006104:	00813483          	ld	s1,8(sp)
    80006108:	02010113          	addi	sp,sp,32
    8000610c:	00008067          	ret

0000000080006110 <consolewrite>:
    80006110:	fb010113          	addi	sp,sp,-80
    80006114:	04813023          	sd	s0,64(sp)
    80006118:	04113423          	sd	ra,72(sp)
    8000611c:	02913c23          	sd	s1,56(sp)
    80006120:	03213823          	sd	s2,48(sp)
    80006124:	03313423          	sd	s3,40(sp)
    80006128:	03413023          	sd	s4,32(sp)
    8000612c:	01513c23          	sd	s5,24(sp)
    80006130:	05010413          	addi	s0,sp,80
    80006134:	06c05c63          	blez	a2,800061ac <consolewrite+0x9c>
    80006138:	00060993          	mv	s3,a2
    8000613c:	00050a13          	mv	s4,a0
    80006140:	00058493          	mv	s1,a1
    80006144:	00000913          	li	s2,0
    80006148:	fff00a93          	li	s5,-1
    8000614c:	01c0006f          	j	80006168 <consolewrite+0x58>
    80006150:	fbf44503          	lbu	a0,-65(s0)
    80006154:	0019091b          	addiw	s2,s2,1
    80006158:	00148493          	addi	s1,s1,1
    8000615c:	00001097          	auipc	ra,0x1
    80006160:	a9c080e7          	jalr	-1380(ra) # 80006bf8 <uartputc>
    80006164:	03298063          	beq	s3,s2,80006184 <consolewrite+0x74>
    80006168:	00048613          	mv	a2,s1
    8000616c:	00100693          	li	a3,1
    80006170:	000a0593          	mv	a1,s4
    80006174:	fbf40513          	addi	a0,s0,-65
    80006178:	00000097          	auipc	ra,0x0
    8000617c:	9e0080e7          	jalr	-1568(ra) # 80005b58 <either_copyin>
    80006180:	fd5518e3          	bne	a0,s5,80006150 <consolewrite+0x40>
    80006184:	04813083          	ld	ra,72(sp)
    80006188:	04013403          	ld	s0,64(sp)
    8000618c:	03813483          	ld	s1,56(sp)
    80006190:	02813983          	ld	s3,40(sp)
    80006194:	02013a03          	ld	s4,32(sp)
    80006198:	01813a83          	ld	s5,24(sp)
    8000619c:	00090513          	mv	a0,s2
    800061a0:	03013903          	ld	s2,48(sp)
    800061a4:	05010113          	addi	sp,sp,80
    800061a8:	00008067          	ret
    800061ac:	00000913          	li	s2,0
    800061b0:	fd5ff06f          	j	80006184 <consolewrite+0x74>

00000000800061b4 <consoleread>:
    800061b4:	f9010113          	addi	sp,sp,-112
    800061b8:	06813023          	sd	s0,96(sp)
    800061bc:	04913c23          	sd	s1,88(sp)
    800061c0:	05213823          	sd	s2,80(sp)
    800061c4:	05313423          	sd	s3,72(sp)
    800061c8:	05413023          	sd	s4,64(sp)
    800061cc:	03513c23          	sd	s5,56(sp)
    800061d0:	03613823          	sd	s6,48(sp)
    800061d4:	03713423          	sd	s7,40(sp)
    800061d8:	03813023          	sd	s8,32(sp)
    800061dc:	06113423          	sd	ra,104(sp)
    800061e0:	01913c23          	sd	s9,24(sp)
    800061e4:	07010413          	addi	s0,sp,112
    800061e8:	00060b93          	mv	s7,a2
    800061ec:	00050913          	mv	s2,a0
    800061f0:	00058c13          	mv	s8,a1
    800061f4:	00060b1b          	sext.w	s6,a2
    800061f8:	00005497          	auipc	s1,0x5
    800061fc:	4e048493          	addi	s1,s1,1248 # 8000b6d8 <cons>
    80006200:	00400993          	li	s3,4
    80006204:	fff00a13          	li	s4,-1
    80006208:	00a00a93          	li	s5,10
    8000620c:	05705e63          	blez	s7,80006268 <consoleread+0xb4>
    80006210:	09c4a703          	lw	a4,156(s1)
    80006214:	0984a783          	lw	a5,152(s1)
    80006218:	0007071b          	sext.w	a4,a4
    8000621c:	08e78463          	beq	a5,a4,800062a4 <consoleread+0xf0>
    80006220:	07f7f713          	andi	a4,a5,127
    80006224:	00e48733          	add	a4,s1,a4
    80006228:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000622c:	0017869b          	addiw	a3,a5,1
    80006230:	08d4ac23          	sw	a3,152(s1)
    80006234:	00070c9b          	sext.w	s9,a4
    80006238:	0b370663          	beq	a4,s3,800062e4 <consoleread+0x130>
    8000623c:	00100693          	li	a3,1
    80006240:	f9f40613          	addi	a2,s0,-97
    80006244:	000c0593          	mv	a1,s8
    80006248:	00090513          	mv	a0,s2
    8000624c:	f8e40fa3          	sb	a4,-97(s0)
    80006250:	00000097          	auipc	ra,0x0
    80006254:	8bc080e7          	jalr	-1860(ra) # 80005b0c <either_copyout>
    80006258:	01450863          	beq	a0,s4,80006268 <consoleread+0xb4>
    8000625c:	001c0c13          	addi	s8,s8,1
    80006260:	fffb8b9b          	addiw	s7,s7,-1
    80006264:	fb5c94e3          	bne	s9,s5,8000620c <consoleread+0x58>
    80006268:	000b851b          	sext.w	a0,s7
    8000626c:	06813083          	ld	ra,104(sp)
    80006270:	06013403          	ld	s0,96(sp)
    80006274:	05813483          	ld	s1,88(sp)
    80006278:	05013903          	ld	s2,80(sp)
    8000627c:	04813983          	ld	s3,72(sp)
    80006280:	04013a03          	ld	s4,64(sp)
    80006284:	03813a83          	ld	s5,56(sp)
    80006288:	02813b83          	ld	s7,40(sp)
    8000628c:	02013c03          	ld	s8,32(sp)
    80006290:	01813c83          	ld	s9,24(sp)
    80006294:	40ab053b          	subw	a0,s6,a0
    80006298:	03013b03          	ld	s6,48(sp)
    8000629c:	07010113          	addi	sp,sp,112
    800062a0:	00008067          	ret
    800062a4:	00001097          	auipc	ra,0x1
    800062a8:	1d8080e7          	jalr	472(ra) # 8000747c <push_on>
    800062ac:	0984a703          	lw	a4,152(s1)
    800062b0:	09c4a783          	lw	a5,156(s1)
    800062b4:	0007879b          	sext.w	a5,a5
    800062b8:	fef70ce3          	beq	a4,a5,800062b0 <consoleread+0xfc>
    800062bc:	00001097          	auipc	ra,0x1
    800062c0:	234080e7          	jalr	564(ra) # 800074f0 <pop_on>
    800062c4:	0984a783          	lw	a5,152(s1)
    800062c8:	07f7f713          	andi	a4,a5,127
    800062cc:	00e48733          	add	a4,s1,a4
    800062d0:	01874703          	lbu	a4,24(a4)
    800062d4:	0017869b          	addiw	a3,a5,1
    800062d8:	08d4ac23          	sw	a3,152(s1)
    800062dc:	00070c9b          	sext.w	s9,a4
    800062e0:	f5371ee3          	bne	a4,s3,8000623c <consoleread+0x88>
    800062e4:	000b851b          	sext.w	a0,s7
    800062e8:	f96bf2e3          	bgeu	s7,s6,8000626c <consoleread+0xb8>
    800062ec:	08f4ac23          	sw	a5,152(s1)
    800062f0:	f7dff06f          	j	8000626c <consoleread+0xb8>

00000000800062f4 <consputc>:
    800062f4:	10000793          	li	a5,256
    800062f8:	00f50663          	beq	a0,a5,80006304 <consputc+0x10>
    800062fc:	00001317          	auipc	t1,0x1
    80006300:	9f430067          	jr	-1548(t1) # 80006cf0 <uartputc_sync>
    80006304:	ff010113          	addi	sp,sp,-16
    80006308:	00113423          	sd	ra,8(sp)
    8000630c:	00813023          	sd	s0,0(sp)
    80006310:	01010413          	addi	s0,sp,16
    80006314:	00800513          	li	a0,8
    80006318:	00001097          	auipc	ra,0x1
    8000631c:	9d8080e7          	jalr	-1576(ra) # 80006cf0 <uartputc_sync>
    80006320:	02000513          	li	a0,32
    80006324:	00001097          	auipc	ra,0x1
    80006328:	9cc080e7          	jalr	-1588(ra) # 80006cf0 <uartputc_sync>
    8000632c:	00013403          	ld	s0,0(sp)
    80006330:	00813083          	ld	ra,8(sp)
    80006334:	00800513          	li	a0,8
    80006338:	01010113          	addi	sp,sp,16
    8000633c:	00001317          	auipc	t1,0x1
    80006340:	9b430067          	jr	-1612(t1) # 80006cf0 <uartputc_sync>

0000000080006344 <consoleintr>:
    80006344:	fe010113          	addi	sp,sp,-32
    80006348:	00813823          	sd	s0,16(sp)
    8000634c:	00913423          	sd	s1,8(sp)
    80006350:	01213023          	sd	s2,0(sp)
    80006354:	00113c23          	sd	ra,24(sp)
    80006358:	02010413          	addi	s0,sp,32
    8000635c:	00005917          	auipc	s2,0x5
    80006360:	37c90913          	addi	s2,s2,892 # 8000b6d8 <cons>
    80006364:	00050493          	mv	s1,a0
    80006368:	00090513          	mv	a0,s2
    8000636c:	00001097          	auipc	ra,0x1
    80006370:	e40080e7          	jalr	-448(ra) # 800071ac <acquire>
    80006374:	02048c63          	beqz	s1,800063ac <consoleintr+0x68>
    80006378:	0a092783          	lw	a5,160(s2)
    8000637c:	09892703          	lw	a4,152(s2)
    80006380:	07f00693          	li	a3,127
    80006384:	40e7873b          	subw	a4,a5,a4
    80006388:	02e6e263          	bltu	a3,a4,800063ac <consoleintr+0x68>
    8000638c:	00d00713          	li	a4,13
    80006390:	04e48063          	beq	s1,a4,800063d0 <consoleintr+0x8c>
    80006394:	07f7f713          	andi	a4,a5,127
    80006398:	00e90733          	add	a4,s2,a4
    8000639c:	0017879b          	addiw	a5,a5,1
    800063a0:	0af92023          	sw	a5,160(s2)
    800063a4:	00970c23          	sb	s1,24(a4)
    800063a8:	08f92e23          	sw	a5,156(s2)
    800063ac:	01013403          	ld	s0,16(sp)
    800063b0:	01813083          	ld	ra,24(sp)
    800063b4:	00813483          	ld	s1,8(sp)
    800063b8:	00013903          	ld	s2,0(sp)
    800063bc:	00005517          	auipc	a0,0x5
    800063c0:	31c50513          	addi	a0,a0,796 # 8000b6d8 <cons>
    800063c4:	02010113          	addi	sp,sp,32
    800063c8:	00001317          	auipc	t1,0x1
    800063cc:	eb030067          	jr	-336(t1) # 80007278 <release>
    800063d0:	00a00493          	li	s1,10
    800063d4:	fc1ff06f          	j	80006394 <consoleintr+0x50>

00000000800063d8 <consoleinit>:
    800063d8:	fe010113          	addi	sp,sp,-32
    800063dc:	00113c23          	sd	ra,24(sp)
    800063e0:	00813823          	sd	s0,16(sp)
    800063e4:	00913423          	sd	s1,8(sp)
    800063e8:	02010413          	addi	s0,sp,32
    800063ec:	00005497          	auipc	s1,0x5
    800063f0:	2ec48493          	addi	s1,s1,748 # 8000b6d8 <cons>
    800063f4:	00048513          	mv	a0,s1
    800063f8:	00002597          	auipc	a1,0x2
    800063fc:	35858593          	addi	a1,a1,856 # 80008750 <CONSOLE_STATUS+0x740>
    80006400:	00001097          	auipc	ra,0x1
    80006404:	d88080e7          	jalr	-632(ra) # 80007188 <initlock>
    80006408:	00000097          	auipc	ra,0x0
    8000640c:	7ac080e7          	jalr	1964(ra) # 80006bb4 <uartinit>
    80006410:	01813083          	ld	ra,24(sp)
    80006414:	01013403          	ld	s0,16(sp)
    80006418:	00000797          	auipc	a5,0x0
    8000641c:	d9c78793          	addi	a5,a5,-612 # 800061b4 <consoleread>
    80006420:	0af4bc23          	sd	a5,184(s1)
    80006424:	00000797          	auipc	a5,0x0
    80006428:	cec78793          	addi	a5,a5,-788 # 80006110 <consolewrite>
    8000642c:	0cf4b023          	sd	a5,192(s1)
    80006430:	00813483          	ld	s1,8(sp)
    80006434:	02010113          	addi	sp,sp,32
    80006438:	00008067          	ret

000000008000643c <console_read>:
    8000643c:	ff010113          	addi	sp,sp,-16
    80006440:	00813423          	sd	s0,8(sp)
    80006444:	01010413          	addi	s0,sp,16
    80006448:	00813403          	ld	s0,8(sp)
    8000644c:	00005317          	auipc	t1,0x5
    80006450:	34433303          	ld	t1,836(t1) # 8000b790 <devsw+0x10>
    80006454:	01010113          	addi	sp,sp,16
    80006458:	00030067          	jr	t1

000000008000645c <console_write>:
    8000645c:	ff010113          	addi	sp,sp,-16
    80006460:	00813423          	sd	s0,8(sp)
    80006464:	01010413          	addi	s0,sp,16
    80006468:	00813403          	ld	s0,8(sp)
    8000646c:	00005317          	auipc	t1,0x5
    80006470:	32c33303          	ld	t1,812(t1) # 8000b798 <devsw+0x18>
    80006474:	01010113          	addi	sp,sp,16
    80006478:	00030067          	jr	t1

000000008000647c <panic>:
    8000647c:	fe010113          	addi	sp,sp,-32
    80006480:	00113c23          	sd	ra,24(sp)
    80006484:	00813823          	sd	s0,16(sp)
    80006488:	00913423          	sd	s1,8(sp)
    8000648c:	02010413          	addi	s0,sp,32
    80006490:	00050493          	mv	s1,a0
    80006494:	00002517          	auipc	a0,0x2
    80006498:	2c450513          	addi	a0,a0,708 # 80008758 <CONSOLE_STATUS+0x748>
    8000649c:	00005797          	auipc	a5,0x5
    800064a0:	3807ae23          	sw	zero,924(a5) # 8000b838 <pr+0x18>
    800064a4:	00000097          	auipc	ra,0x0
    800064a8:	034080e7          	jalr	52(ra) # 800064d8 <__printf>
    800064ac:	00048513          	mv	a0,s1
    800064b0:	00000097          	auipc	ra,0x0
    800064b4:	028080e7          	jalr	40(ra) # 800064d8 <__printf>
    800064b8:	00002517          	auipc	a0,0x2
    800064bc:	11850513          	addi	a0,a0,280 # 800085d0 <CONSOLE_STATUS+0x5c0>
    800064c0:	00000097          	auipc	ra,0x0
    800064c4:	018080e7          	jalr	24(ra) # 800064d8 <__printf>
    800064c8:	00100793          	li	a5,1
    800064cc:	00004717          	auipc	a4,0x4
    800064d0:	08f72e23          	sw	a5,156(a4) # 8000a568 <panicked>
    800064d4:	0000006f          	j	800064d4 <panic+0x58>

00000000800064d8 <__printf>:
    800064d8:	f3010113          	addi	sp,sp,-208
    800064dc:	08813023          	sd	s0,128(sp)
    800064e0:	07313423          	sd	s3,104(sp)
    800064e4:	09010413          	addi	s0,sp,144
    800064e8:	05813023          	sd	s8,64(sp)
    800064ec:	08113423          	sd	ra,136(sp)
    800064f0:	06913c23          	sd	s1,120(sp)
    800064f4:	07213823          	sd	s2,112(sp)
    800064f8:	07413023          	sd	s4,96(sp)
    800064fc:	05513c23          	sd	s5,88(sp)
    80006500:	05613823          	sd	s6,80(sp)
    80006504:	05713423          	sd	s7,72(sp)
    80006508:	03913c23          	sd	s9,56(sp)
    8000650c:	03a13823          	sd	s10,48(sp)
    80006510:	03b13423          	sd	s11,40(sp)
    80006514:	00005317          	auipc	t1,0x5
    80006518:	30c30313          	addi	t1,t1,780 # 8000b820 <pr>
    8000651c:	01832c03          	lw	s8,24(t1)
    80006520:	00b43423          	sd	a1,8(s0)
    80006524:	00c43823          	sd	a2,16(s0)
    80006528:	00d43c23          	sd	a3,24(s0)
    8000652c:	02e43023          	sd	a4,32(s0)
    80006530:	02f43423          	sd	a5,40(s0)
    80006534:	03043823          	sd	a6,48(s0)
    80006538:	03143c23          	sd	a7,56(s0)
    8000653c:	00050993          	mv	s3,a0
    80006540:	4a0c1663          	bnez	s8,800069ec <__printf+0x514>
    80006544:	60098c63          	beqz	s3,80006b5c <__printf+0x684>
    80006548:	0009c503          	lbu	a0,0(s3)
    8000654c:	00840793          	addi	a5,s0,8
    80006550:	f6f43c23          	sd	a5,-136(s0)
    80006554:	00000493          	li	s1,0
    80006558:	22050063          	beqz	a0,80006778 <__printf+0x2a0>
    8000655c:	00002a37          	lui	s4,0x2
    80006560:	00018ab7          	lui	s5,0x18
    80006564:	000f4b37          	lui	s6,0xf4
    80006568:	00989bb7          	lui	s7,0x989
    8000656c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006570:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006574:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006578:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000657c:	00148c9b          	addiw	s9,s1,1
    80006580:	02500793          	li	a5,37
    80006584:	01998933          	add	s2,s3,s9
    80006588:	38f51263          	bne	a0,a5,8000690c <__printf+0x434>
    8000658c:	00094783          	lbu	a5,0(s2)
    80006590:	00078c9b          	sext.w	s9,a5
    80006594:	1e078263          	beqz	a5,80006778 <__printf+0x2a0>
    80006598:	0024849b          	addiw	s1,s1,2
    8000659c:	07000713          	li	a4,112
    800065a0:	00998933          	add	s2,s3,s1
    800065a4:	38e78a63          	beq	a5,a4,80006938 <__printf+0x460>
    800065a8:	20f76863          	bltu	a4,a5,800067b8 <__printf+0x2e0>
    800065ac:	42a78863          	beq	a5,a0,800069dc <__printf+0x504>
    800065b0:	06400713          	li	a4,100
    800065b4:	40e79663          	bne	a5,a4,800069c0 <__printf+0x4e8>
    800065b8:	f7843783          	ld	a5,-136(s0)
    800065bc:	0007a603          	lw	a2,0(a5)
    800065c0:	00878793          	addi	a5,a5,8
    800065c4:	f6f43c23          	sd	a5,-136(s0)
    800065c8:	42064a63          	bltz	a2,800069fc <__printf+0x524>
    800065cc:	00a00713          	li	a4,10
    800065d0:	02e677bb          	remuw	a5,a2,a4
    800065d4:	00002d97          	auipc	s11,0x2
    800065d8:	1acd8d93          	addi	s11,s11,428 # 80008780 <digits>
    800065dc:	00900593          	li	a1,9
    800065e0:	0006051b          	sext.w	a0,a2
    800065e4:	00000c93          	li	s9,0
    800065e8:	02079793          	slli	a5,a5,0x20
    800065ec:	0207d793          	srli	a5,a5,0x20
    800065f0:	00fd87b3          	add	a5,s11,a5
    800065f4:	0007c783          	lbu	a5,0(a5)
    800065f8:	02e656bb          	divuw	a3,a2,a4
    800065fc:	f8f40023          	sb	a5,-128(s0)
    80006600:	14c5d863          	bge	a1,a2,80006750 <__printf+0x278>
    80006604:	06300593          	li	a1,99
    80006608:	00100c93          	li	s9,1
    8000660c:	02e6f7bb          	remuw	a5,a3,a4
    80006610:	02079793          	slli	a5,a5,0x20
    80006614:	0207d793          	srli	a5,a5,0x20
    80006618:	00fd87b3          	add	a5,s11,a5
    8000661c:	0007c783          	lbu	a5,0(a5)
    80006620:	02e6d73b          	divuw	a4,a3,a4
    80006624:	f8f400a3          	sb	a5,-127(s0)
    80006628:	12a5f463          	bgeu	a1,a0,80006750 <__printf+0x278>
    8000662c:	00a00693          	li	a3,10
    80006630:	00900593          	li	a1,9
    80006634:	02d777bb          	remuw	a5,a4,a3
    80006638:	02079793          	slli	a5,a5,0x20
    8000663c:	0207d793          	srli	a5,a5,0x20
    80006640:	00fd87b3          	add	a5,s11,a5
    80006644:	0007c503          	lbu	a0,0(a5)
    80006648:	02d757bb          	divuw	a5,a4,a3
    8000664c:	f8a40123          	sb	a0,-126(s0)
    80006650:	48e5f263          	bgeu	a1,a4,80006ad4 <__printf+0x5fc>
    80006654:	06300513          	li	a0,99
    80006658:	02d7f5bb          	remuw	a1,a5,a3
    8000665c:	02059593          	slli	a1,a1,0x20
    80006660:	0205d593          	srli	a1,a1,0x20
    80006664:	00bd85b3          	add	a1,s11,a1
    80006668:	0005c583          	lbu	a1,0(a1)
    8000666c:	02d7d7bb          	divuw	a5,a5,a3
    80006670:	f8b401a3          	sb	a1,-125(s0)
    80006674:	48e57263          	bgeu	a0,a4,80006af8 <__printf+0x620>
    80006678:	3e700513          	li	a0,999
    8000667c:	02d7f5bb          	remuw	a1,a5,a3
    80006680:	02059593          	slli	a1,a1,0x20
    80006684:	0205d593          	srli	a1,a1,0x20
    80006688:	00bd85b3          	add	a1,s11,a1
    8000668c:	0005c583          	lbu	a1,0(a1)
    80006690:	02d7d7bb          	divuw	a5,a5,a3
    80006694:	f8b40223          	sb	a1,-124(s0)
    80006698:	46e57663          	bgeu	a0,a4,80006b04 <__printf+0x62c>
    8000669c:	02d7f5bb          	remuw	a1,a5,a3
    800066a0:	02059593          	slli	a1,a1,0x20
    800066a4:	0205d593          	srli	a1,a1,0x20
    800066a8:	00bd85b3          	add	a1,s11,a1
    800066ac:	0005c583          	lbu	a1,0(a1)
    800066b0:	02d7d7bb          	divuw	a5,a5,a3
    800066b4:	f8b402a3          	sb	a1,-123(s0)
    800066b8:	46ea7863          	bgeu	s4,a4,80006b28 <__printf+0x650>
    800066bc:	02d7f5bb          	remuw	a1,a5,a3
    800066c0:	02059593          	slli	a1,a1,0x20
    800066c4:	0205d593          	srli	a1,a1,0x20
    800066c8:	00bd85b3          	add	a1,s11,a1
    800066cc:	0005c583          	lbu	a1,0(a1)
    800066d0:	02d7d7bb          	divuw	a5,a5,a3
    800066d4:	f8b40323          	sb	a1,-122(s0)
    800066d8:	3eeaf863          	bgeu	s5,a4,80006ac8 <__printf+0x5f0>
    800066dc:	02d7f5bb          	remuw	a1,a5,a3
    800066e0:	02059593          	slli	a1,a1,0x20
    800066e4:	0205d593          	srli	a1,a1,0x20
    800066e8:	00bd85b3          	add	a1,s11,a1
    800066ec:	0005c583          	lbu	a1,0(a1)
    800066f0:	02d7d7bb          	divuw	a5,a5,a3
    800066f4:	f8b403a3          	sb	a1,-121(s0)
    800066f8:	42eb7e63          	bgeu	s6,a4,80006b34 <__printf+0x65c>
    800066fc:	02d7f5bb          	remuw	a1,a5,a3
    80006700:	02059593          	slli	a1,a1,0x20
    80006704:	0205d593          	srli	a1,a1,0x20
    80006708:	00bd85b3          	add	a1,s11,a1
    8000670c:	0005c583          	lbu	a1,0(a1)
    80006710:	02d7d7bb          	divuw	a5,a5,a3
    80006714:	f8b40423          	sb	a1,-120(s0)
    80006718:	42ebfc63          	bgeu	s7,a4,80006b50 <__printf+0x678>
    8000671c:	02079793          	slli	a5,a5,0x20
    80006720:	0207d793          	srli	a5,a5,0x20
    80006724:	00fd8db3          	add	s11,s11,a5
    80006728:	000dc703          	lbu	a4,0(s11)
    8000672c:	00a00793          	li	a5,10
    80006730:	00900c93          	li	s9,9
    80006734:	f8e404a3          	sb	a4,-119(s0)
    80006738:	00065c63          	bgez	a2,80006750 <__printf+0x278>
    8000673c:	f9040713          	addi	a4,s0,-112
    80006740:	00f70733          	add	a4,a4,a5
    80006744:	02d00693          	li	a3,45
    80006748:	fed70823          	sb	a3,-16(a4)
    8000674c:	00078c93          	mv	s9,a5
    80006750:	f8040793          	addi	a5,s0,-128
    80006754:	01978cb3          	add	s9,a5,s9
    80006758:	f7f40d13          	addi	s10,s0,-129
    8000675c:	000cc503          	lbu	a0,0(s9)
    80006760:	fffc8c93          	addi	s9,s9,-1
    80006764:	00000097          	auipc	ra,0x0
    80006768:	b90080e7          	jalr	-1136(ra) # 800062f4 <consputc>
    8000676c:	ffac98e3          	bne	s9,s10,8000675c <__printf+0x284>
    80006770:	00094503          	lbu	a0,0(s2)
    80006774:	e00514e3          	bnez	a0,8000657c <__printf+0xa4>
    80006778:	1a0c1663          	bnez	s8,80006924 <__printf+0x44c>
    8000677c:	08813083          	ld	ra,136(sp)
    80006780:	08013403          	ld	s0,128(sp)
    80006784:	07813483          	ld	s1,120(sp)
    80006788:	07013903          	ld	s2,112(sp)
    8000678c:	06813983          	ld	s3,104(sp)
    80006790:	06013a03          	ld	s4,96(sp)
    80006794:	05813a83          	ld	s5,88(sp)
    80006798:	05013b03          	ld	s6,80(sp)
    8000679c:	04813b83          	ld	s7,72(sp)
    800067a0:	04013c03          	ld	s8,64(sp)
    800067a4:	03813c83          	ld	s9,56(sp)
    800067a8:	03013d03          	ld	s10,48(sp)
    800067ac:	02813d83          	ld	s11,40(sp)
    800067b0:	0d010113          	addi	sp,sp,208
    800067b4:	00008067          	ret
    800067b8:	07300713          	li	a4,115
    800067bc:	1ce78a63          	beq	a5,a4,80006990 <__printf+0x4b8>
    800067c0:	07800713          	li	a4,120
    800067c4:	1ee79e63          	bne	a5,a4,800069c0 <__printf+0x4e8>
    800067c8:	f7843783          	ld	a5,-136(s0)
    800067cc:	0007a703          	lw	a4,0(a5)
    800067d0:	00878793          	addi	a5,a5,8
    800067d4:	f6f43c23          	sd	a5,-136(s0)
    800067d8:	28074263          	bltz	a4,80006a5c <__printf+0x584>
    800067dc:	00002d97          	auipc	s11,0x2
    800067e0:	fa4d8d93          	addi	s11,s11,-92 # 80008780 <digits>
    800067e4:	00f77793          	andi	a5,a4,15
    800067e8:	00fd87b3          	add	a5,s11,a5
    800067ec:	0007c683          	lbu	a3,0(a5)
    800067f0:	00f00613          	li	a2,15
    800067f4:	0007079b          	sext.w	a5,a4
    800067f8:	f8d40023          	sb	a3,-128(s0)
    800067fc:	0047559b          	srliw	a1,a4,0x4
    80006800:	0047569b          	srliw	a3,a4,0x4
    80006804:	00000c93          	li	s9,0
    80006808:	0ee65063          	bge	a2,a4,800068e8 <__printf+0x410>
    8000680c:	00f6f693          	andi	a3,a3,15
    80006810:	00dd86b3          	add	a3,s11,a3
    80006814:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80006818:	0087d79b          	srliw	a5,a5,0x8
    8000681c:	00100c93          	li	s9,1
    80006820:	f8d400a3          	sb	a3,-127(s0)
    80006824:	0cb67263          	bgeu	a2,a1,800068e8 <__printf+0x410>
    80006828:	00f7f693          	andi	a3,a5,15
    8000682c:	00dd86b3          	add	a3,s11,a3
    80006830:	0006c583          	lbu	a1,0(a3)
    80006834:	00f00613          	li	a2,15
    80006838:	0047d69b          	srliw	a3,a5,0x4
    8000683c:	f8b40123          	sb	a1,-126(s0)
    80006840:	0047d593          	srli	a1,a5,0x4
    80006844:	28f67e63          	bgeu	a2,a5,80006ae0 <__printf+0x608>
    80006848:	00f6f693          	andi	a3,a3,15
    8000684c:	00dd86b3          	add	a3,s11,a3
    80006850:	0006c503          	lbu	a0,0(a3)
    80006854:	0087d813          	srli	a6,a5,0x8
    80006858:	0087d69b          	srliw	a3,a5,0x8
    8000685c:	f8a401a3          	sb	a0,-125(s0)
    80006860:	28b67663          	bgeu	a2,a1,80006aec <__printf+0x614>
    80006864:	00f6f693          	andi	a3,a3,15
    80006868:	00dd86b3          	add	a3,s11,a3
    8000686c:	0006c583          	lbu	a1,0(a3)
    80006870:	00c7d513          	srli	a0,a5,0xc
    80006874:	00c7d69b          	srliw	a3,a5,0xc
    80006878:	f8b40223          	sb	a1,-124(s0)
    8000687c:	29067a63          	bgeu	a2,a6,80006b10 <__printf+0x638>
    80006880:	00f6f693          	andi	a3,a3,15
    80006884:	00dd86b3          	add	a3,s11,a3
    80006888:	0006c583          	lbu	a1,0(a3)
    8000688c:	0107d813          	srli	a6,a5,0x10
    80006890:	0107d69b          	srliw	a3,a5,0x10
    80006894:	f8b402a3          	sb	a1,-123(s0)
    80006898:	28a67263          	bgeu	a2,a0,80006b1c <__printf+0x644>
    8000689c:	00f6f693          	andi	a3,a3,15
    800068a0:	00dd86b3          	add	a3,s11,a3
    800068a4:	0006c683          	lbu	a3,0(a3)
    800068a8:	0147d79b          	srliw	a5,a5,0x14
    800068ac:	f8d40323          	sb	a3,-122(s0)
    800068b0:	21067663          	bgeu	a2,a6,80006abc <__printf+0x5e4>
    800068b4:	02079793          	slli	a5,a5,0x20
    800068b8:	0207d793          	srli	a5,a5,0x20
    800068bc:	00fd8db3          	add	s11,s11,a5
    800068c0:	000dc683          	lbu	a3,0(s11)
    800068c4:	00800793          	li	a5,8
    800068c8:	00700c93          	li	s9,7
    800068cc:	f8d403a3          	sb	a3,-121(s0)
    800068d0:	00075c63          	bgez	a4,800068e8 <__printf+0x410>
    800068d4:	f9040713          	addi	a4,s0,-112
    800068d8:	00f70733          	add	a4,a4,a5
    800068dc:	02d00693          	li	a3,45
    800068e0:	fed70823          	sb	a3,-16(a4)
    800068e4:	00078c93          	mv	s9,a5
    800068e8:	f8040793          	addi	a5,s0,-128
    800068ec:	01978cb3          	add	s9,a5,s9
    800068f0:	f7f40d13          	addi	s10,s0,-129
    800068f4:	000cc503          	lbu	a0,0(s9)
    800068f8:	fffc8c93          	addi	s9,s9,-1
    800068fc:	00000097          	auipc	ra,0x0
    80006900:	9f8080e7          	jalr	-1544(ra) # 800062f4 <consputc>
    80006904:	ff9d18e3          	bne	s10,s9,800068f4 <__printf+0x41c>
    80006908:	0100006f          	j	80006918 <__printf+0x440>
    8000690c:	00000097          	auipc	ra,0x0
    80006910:	9e8080e7          	jalr	-1560(ra) # 800062f4 <consputc>
    80006914:	000c8493          	mv	s1,s9
    80006918:	00094503          	lbu	a0,0(s2)
    8000691c:	c60510e3          	bnez	a0,8000657c <__printf+0xa4>
    80006920:	e40c0ee3          	beqz	s8,8000677c <__printf+0x2a4>
    80006924:	00005517          	auipc	a0,0x5
    80006928:	efc50513          	addi	a0,a0,-260 # 8000b820 <pr>
    8000692c:	00001097          	auipc	ra,0x1
    80006930:	94c080e7          	jalr	-1716(ra) # 80007278 <release>
    80006934:	e49ff06f          	j	8000677c <__printf+0x2a4>
    80006938:	f7843783          	ld	a5,-136(s0)
    8000693c:	03000513          	li	a0,48
    80006940:	01000d13          	li	s10,16
    80006944:	00878713          	addi	a4,a5,8
    80006948:	0007bc83          	ld	s9,0(a5)
    8000694c:	f6e43c23          	sd	a4,-136(s0)
    80006950:	00000097          	auipc	ra,0x0
    80006954:	9a4080e7          	jalr	-1628(ra) # 800062f4 <consputc>
    80006958:	07800513          	li	a0,120
    8000695c:	00000097          	auipc	ra,0x0
    80006960:	998080e7          	jalr	-1640(ra) # 800062f4 <consputc>
    80006964:	00002d97          	auipc	s11,0x2
    80006968:	e1cd8d93          	addi	s11,s11,-484 # 80008780 <digits>
    8000696c:	03ccd793          	srli	a5,s9,0x3c
    80006970:	00fd87b3          	add	a5,s11,a5
    80006974:	0007c503          	lbu	a0,0(a5)
    80006978:	fffd0d1b          	addiw	s10,s10,-1
    8000697c:	004c9c93          	slli	s9,s9,0x4
    80006980:	00000097          	auipc	ra,0x0
    80006984:	974080e7          	jalr	-1676(ra) # 800062f4 <consputc>
    80006988:	fe0d12e3          	bnez	s10,8000696c <__printf+0x494>
    8000698c:	f8dff06f          	j	80006918 <__printf+0x440>
    80006990:	f7843783          	ld	a5,-136(s0)
    80006994:	0007bc83          	ld	s9,0(a5)
    80006998:	00878793          	addi	a5,a5,8
    8000699c:	f6f43c23          	sd	a5,-136(s0)
    800069a0:	000c9a63          	bnez	s9,800069b4 <__printf+0x4dc>
    800069a4:	1080006f          	j	80006aac <__printf+0x5d4>
    800069a8:	001c8c93          	addi	s9,s9,1
    800069ac:	00000097          	auipc	ra,0x0
    800069b0:	948080e7          	jalr	-1720(ra) # 800062f4 <consputc>
    800069b4:	000cc503          	lbu	a0,0(s9)
    800069b8:	fe0518e3          	bnez	a0,800069a8 <__printf+0x4d0>
    800069bc:	f5dff06f          	j	80006918 <__printf+0x440>
    800069c0:	02500513          	li	a0,37
    800069c4:	00000097          	auipc	ra,0x0
    800069c8:	930080e7          	jalr	-1744(ra) # 800062f4 <consputc>
    800069cc:	000c8513          	mv	a0,s9
    800069d0:	00000097          	auipc	ra,0x0
    800069d4:	924080e7          	jalr	-1756(ra) # 800062f4 <consputc>
    800069d8:	f41ff06f          	j	80006918 <__printf+0x440>
    800069dc:	02500513          	li	a0,37
    800069e0:	00000097          	auipc	ra,0x0
    800069e4:	914080e7          	jalr	-1772(ra) # 800062f4 <consputc>
    800069e8:	f31ff06f          	j	80006918 <__printf+0x440>
    800069ec:	00030513          	mv	a0,t1
    800069f0:	00000097          	auipc	ra,0x0
    800069f4:	7bc080e7          	jalr	1980(ra) # 800071ac <acquire>
    800069f8:	b4dff06f          	j	80006544 <__printf+0x6c>
    800069fc:	40c0053b          	negw	a0,a2
    80006a00:	00a00713          	li	a4,10
    80006a04:	02e576bb          	remuw	a3,a0,a4
    80006a08:	00002d97          	auipc	s11,0x2
    80006a0c:	d78d8d93          	addi	s11,s11,-648 # 80008780 <digits>
    80006a10:	ff700593          	li	a1,-9
    80006a14:	02069693          	slli	a3,a3,0x20
    80006a18:	0206d693          	srli	a3,a3,0x20
    80006a1c:	00dd86b3          	add	a3,s11,a3
    80006a20:	0006c683          	lbu	a3,0(a3)
    80006a24:	02e557bb          	divuw	a5,a0,a4
    80006a28:	f8d40023          	sb	a3,-128(s0)
    80006a2c:	10b65e63          	bge	a2,a1,80006b48 <__printf+0x670>
    80006a30:	06300593          	li	a1,99
    80006a34:	02e7f6bb          	remuw	a3,a5,a4
    80006a38:	02069693          	slli	a3,a3,0x20
    80006a3c:	0206d693          	srli	a3,a3,0x20
    80006a40:	00dd86b3          	add	a3,s11,a3
    80006a44:	0006c683          	lbu	a3,0(a3)
    80006a48:	02e7d73b          	divuw	a4,a5,a4
    80006a4c:	00200793          	li	a5,2
    80006a50:	f8d400a3          	sb	a3,-127(s0)
    80006a54:	bca5ece3          	bltu	a1,a0,8000662c <__printf+0x154>
    80006a58:	ce5ff06f          	j	8000673c <__printf+0x264>
    80006a5c:	40e007bb          	negw	a5,a4
    80006a60:	00002d97          	auipc	s11,0x2
    80006a64:	d20d8d93          	addi	s11,s11,-736 # 80008780 <digits>
    80006a68:	00f7f693          	andi	a3,a5,15
    80006a6c:	00dd86b3          	add	a3,s11,a3
    80006a70:	0006c583          	lbu	a1,0(a3)
    80006a74:	ff100613          	li	a2,-15
    80006a78:	0047d69b          	srliw	a3,a5,0x4
    80006a7c:	f8b40023          	sb	a1,-128(s0)
    80006a80:	0047d59b          	srliw	a1,a5,0x4
    80006a84:	0ac75e63          	bge	a4,a2,80006b40 <__printf+0x668>
    80006a88:	00f6f693          	andi	a3,a3,15
    80006a8c:	00dd86b3          	add	a3,s11,a3
    80006a90:	0006c603          	lbu	a2,0(a3)
    80006a94:	00f00693          	li	a3,15
    80006a98:	0087d79b          	srliw	a5,a5,0x8
    80006a9c:	f8c400a3          	sb	a2,-127(s0)
    80006aa0:	d8b6e4e3          	bltu	a3,a1,80006828 <__printf+0x350>
    80006aa4:	00200793          	li	a5,2
    80006aa8:	e2dff06f          	j	800068d4 <__printf+0x3fc>
    80006aac:	00002c97          	auipc	s9,0x2
    80006ab0:	cb4c8c93          	addi	s9,s9,-844 # 80008760 <CONSOLE_STATUS+0x750>
    80006ab4:	02800513          	li	a0,40
    80006ab8:	ef1ff06f          	j	800069a8 <__printf+0x4d0>
    80006abc:	00700793          	li	a5,7
    80006ac0:	00600c93          	li	s9,6
    80006ac4:	e0dff06f          	j	800068d0 <__printf+0x3f8>
    80006ac8:	00700793          	li	a5,7
    80006acc:	00600c93          	li	s9,6
    80006ad0:	c69ff06f          	j	80006738 <__printf+0x260>
    80006ad4:	00300793          	li	a5,3
    80006ad8:	00200c93          	li	s9,2
    80006adc:	c5dff06f          	j	80006738 <__printf+0x260>
    80006ae0:	00300793          	li	a5,3
    80006ae4:	00200c93          	li	s9,2
    80006ae8:	de9ff06f          	j	800068d0 <__printf+0x3f8>
    80006aec:	00400793          	li	a5,4
    80006af0:	00300c93          	li	s9,3
    80006af4:	dddff06f          	j	800068d0 <__printf+0x3f8>
    80006af8:	00400793          	li	a5,4
    80006afc:	00300c93          	li	s9,3
    80006b00:	c39ff06f          	j	80006738 <__printf+0x260>
    80006b04:	00500793          	li	a5,5
    80006b08:	00400c93          	li	s9,4
    80006b0c:	c2dff06f          	j	80006738 <__printf+0x260>
    80006b10:	00500793          	li	a5,5
    80006b14:	00400c93          	li	s9,4
    80006b18:	db9ff06f          	j	800068d0 <__printf+0x3f8>
    80006b1c:	00600793          	li	a5,6
    80006b20:	00500c93          	li	s9,5
    80006b24:	dadff06f          	j	800068d0 <__printf+0x3f8>
    80006b28:	00600793          	li	a5,6
    80006b2c:	00500c93          	li	s9,5
    80006b30:	c09ff06f          	j	80006738 <__printf+0x260>
    80006b34:	00800793          	li	a5,8
    80006b38:	00700c93          	li	s9,7
    80006b3c:	bfdff06f          	j	80006738 <__printf+0x260>
    80006b40:	00100793          	li	a5,1
    80006b44:	d91ff06f          	j	800068d4 <__printf+0x3fc>
    80006b48:	00100793          	li	a5,1
    80006b4c:	bf1ff06f          	j	8000673c <__printf+0x264>
    80006b50:	00900793          	li	a5,9
    80006b54:	00800c93          	li	s9,8
    80006b58:	be1ff06f          	j	80006738 <__printf+0x260>
    80006b5c:	00002517          	auipc	a0,0x2
    80006b60:	c0c50513          	addi	a0,a0,-1012 # 80008768 <CONSOLE_STATUS+0x758>
    80006b64:	00000097          	auipc	ra,0x0
    80006b68:	918080e7          	jalr	-1768(ra) # 8000647c <panic>

0000000080006b6c <printfinit>:
    80006b6c:	fe010113          	addi	sp,sp,-32
    80006b70:	00813823          	sd	s0,16(sp)
    80006b74:	00913423          	sd	s1,8(sp)
    80006b78:	00113c23          	sd	ra,24(sp)
    80006b7c:	02010413          	addi	s0,sp,32
    80006b80:	00005497          	auipc	s1,0x5
    80006b84:	ca048493          	addi	s1,s1,-864 # 8000b820 <pr>
    80006b88:	00048513          	mv	a0,s1
    80006b8c:	00002597          	auipc	a1,0x2
    80006b90:	bec58593          	addi	a1,a1,-1044 # 80008778 <CONSOLE_STATUS+0x768>
    80006b94:	00000097          	auipc	ra,0x0
    80006b98:	5f4080e7          	jalr	1524(ra) # 80007188 <initlock>
    80006b9c:	01813083          	ld	ra,24(sp)
    80006ba0:	01013403          	ld	s0,16(sp)
    80006ba4:	0004ac23          	sw	zero,24(s1)
    80006ba8:	00813483          	ld	s1,8(sp)
    80006bac:	02010113          	addi	sp,sp,32
    80006bb0:	00008067          	ret

0000000080006bb4 <uartinit>:
    80006bb4:	ff010113          	addi	sp,sp,-16
    80006bb8:	00813423          	sd	s0,8(sp)
    80006bbc:	01010413          	addi	s0,sp,16
    80006bc0:	100007b7          	lui	a5,0x10000
    80006bc4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006bc8:	f8000713          	li	a4,-128
    80006bcc:	00e781a3          	sb	a4,3(a5)
    80006bd0:	00300713          	li	a4,3
    80006bd4:	00e78023          	sb	a4,0(a5)
    80006bd8:	000780a3          	sb	zero,1(a5)
    80006bdc:	00e781a3          	sb	a4,3(a5)
    80006be0:	00700693          	li	a3,7
    80006be4:	00d78123          	sb	a3,2(a5)
    80006be8:	00e780a3          	sb	a4,1(a5)
    80006bec:	00813403          	ld	s0,8(sp)
    80006bf0:	01010113          	addi	sp,sp,16
    80006bf4:	00008067          	ret

0000000080006bf8 <uartputc>:
    80006bf8:	00004797          	auipc	a5,0x4
    80006bfc:	9707a783          	lw	a5,-1680(a5) # 8000a568 <panicked>
    80006c00:	00078463          	beqz	a5,80006c08 <uartputc+0x10>
    80006c04:	0000006f          	j	80006c04 <uartputc+0xc>
    80006c08:	fd010113          	addi	sp,sp,-48
    80006c0c:	02813023          	sd	s0,32(sp)
    80006c10:	00913c23          	sd	s1,24(sp)
    80006c14:	01213823          	sd	s2,16(sp)
    80006c18:	01313423          	sd	s3,8(sp)
    80006c1c:	02113423          	sd	ra,40(sp)
    80006c20:	03010413          	addi	s0,sp,48
    80006c24:	00004917          	auipc	s2,0x4
    80006c28:	94c90913          	addi	s2,s2,-1716 # 8000a570 <uart_tx_r>
    80006c2c:	00093783          	ld	a5,0(s2)
    80006c30:	00004497          	auipc	s1,0x4
    80006c34:	94848493          	addi	s1,s1,-1720 # 8000a578 <uart_tx_w>
    80006c38:	0004b703          	ld	a4,0(s1)
    80006c3c:	02078693          	addi	a3,a5,32
    80006c40:	00050993          	mv	s3,a0
    80006c44:	02e69c63          	bne	a3,a4,80006c7c <uartputc+0x84>
    80006c48:	00001097          	auipc	ra,0x1
    80006c4c:	834080e7          	jalr	-1996(ra) # 8000747c <push_on>
    80006c50:	00093783          	ld	a5,0(s2)
    80006c54:	0004b703          	ld	a4,0(s1)
    80006c58:	02078793          	addi	a5,a5,32
    80006c5c:	00e79463          	bne	a5,a4,80006c64 <uartputc+0x6c>
    80006c60:	0000006f          	j	80006c60 <uartputc+0x68>
    80006c64:	00001097          	auipc	ra,0x1
    80006c68:	88c080e7          	jalr	-1908(ra) # 800074f0 <pop_on>
    80006c6c:	00093783          	ld	a5,0(s2)
    80006c70:	0004b703          	ld	a4,0(s1)
    80006c74:	02078693          	addi	a3,a5,32
    80006c78:	fce688e3          	beq	a3,a4,80006c48 <uartputc+0x50>
    80006c7c:	01f77693          	andi	a3,a4,31
    80006c80:	00005597          	auipc	a1,0x5
    80006c84:	bc058593          	addi	a1,a1,-1088 # 8000b840 <uart_tx_buf>
    80006c88:	00d586b3          	add	a3,a1,a3
    80006c8c:	00170713          	addi	a4,a4,1
    80006c90:	01368023          	sb	s3,0(a3)
    80006c94:	00e4b023          	sd	a4,0(s1)
    80006c98:	10000637          	lui	a2,0x10000
    80006c9c:	02f71063          	bne	a4,a5,80006cbc <uartputc+0xc4>
    80006ca0:	0340006f          	j	80006cd4 <uartputc+0xdc>
    80006ca4:	00074703          	lbu	a4,0(a4)
    80006ca8:	00f93023          	sd	a5,0(s2)
    80006cac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006cb0:	00093783          	ld	a5,0(s2)
    80006cb4:	0004b703          	ld	a4,0(s1)
    80006cb8:	00f70e63          	beq	a4,a5,80006cd4 <uartputc+0xdc>
    80006cbc:	00564683          	lbu	a3,5(a2)
    80006cc0:	01f7f713          	andi	a4,a5,31
    80006cc4:	00e58733          	add	a4,a1,a4
    80006cc8:	0206f693          	andi	a3,a3,32
    80006ccc:	00178793          	addi	a5,a5,1
    80006cd0:	fc069ae3          	bnez	a3,80006ca4 <uartputc+0xac>
    80006cd4:	02813083          	ld	ra,40(sp)
    80006cd8:	02013403          	ld	s0,32(sp)
    80006cdc:	01813483          	ld	s1,24(sp)
    80006ce0:	01013903          	ld	s2,16(sp)
    80006ce4:	00813983          	ld	s3,8(sp)
    80006ce8:	03010113          	addi	sp,sp,48
    80006cec:	00008067          	ret

0000000080006cf0 <uartputc_sync>:
    80006cf0:	ff010113          	addi	sp,sp,-16
    80006cf4:	00813423          	sd	s0,8(sp)
    80006cf8:	01010413          	addi	s0,sp,16
    80006cfc:	00004717          	auipc	a4,0x4
    80006d00:	86c72703          	lw	a4,-1940(a4) # 8000a568 <panicked>
    80006d04:	02071663          	bnez	a4,80006d30 <uartputc_sync+0x40>
    80006d08:	00050793          	mv	a5,a0
    80006d0c:	100006b7          	lui	a3,0x10000
    80006d10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80006d14:	02077713          	andi	a4,a4,32
    80006d18:	fe070ce3          	beqz	a4,80006d10 <uartputc_sync+0x20>
    80006d1c:	0ff7f793          	andi	a5,a5,255
    80006d20:	00f68023          	sb	a5,0(a3)
    80006d24:	00813403          	ld	s0,8(sp)
    80006d28:	01010113          	addi	sp,sp,16
    80006d2c:	00008067          	ret
    80006d30:	0000006f          	j	80006d30 <uartputc_sync+0x40>

0000000080006d34 <uartstart>:
    80006d34:	ff010113          	addi	sp,sp,-16
    80006d38:	00813423          	sd	s0,8(sp)
    80006d3c:	01010413          	addi	s0,sp,16
    80006d40:	00004617          	auipc	a2,0x4
    80006d44:	83060613          	addi	a2,a2,-2000 # 8000a570 <uart_tx_r>
    80006d48:	00004517          	auipc	a0,0x4
    80006d4c:	83050513          	addi	a0,a0,-2000 # 8000a578 <uart_tx_w>
    80006d50:	00063783          	ld	a5,0(a2)
    80006d54:	00053703          	ld	a4,0(a0)
    80006d58:	04f70263          	beq	a4,a5,80006d9c <uartstart+0x68>
    80006d5c:	100005b7          	lui	a1,0x10000
    80006d60:	00005817          	auipc	a6,0x5
    80006d64:	ae080813          	addi	a6,a6,-1312 # 8000b840 <uart_tx_buf>
    80006d68:	01c0006f          	j	80006d84 <uartstart+0x50>
    80006d6c:	0006c703          	lbu	a4,0(a3)
    80006d70:	00f63023          	sd	a5,0(a2)
    80006d74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006d78:	00063783          	ld	a5,0(a2)
    80006d7c:	00053703          	ld	a4,0(a0)
    80006d80:	00f70e63          	beq	a4,a5,80006d9c <uartstart+0x68>
    80006d84:	01f7f713          	andi	a4,a5,31
    80006d88:	00e806b3          	add	a3,a6,a4
    80006d8c:	0055c703          	lbu	a4,5(a1)
    80006d90:	00178793          	addi	a5,a5,1
    80006d94:	02077713          	andi	a4,a4,32
    80006d98:	fc071ae3          	bnez	a4,80006d6c <uartstart+0x38>
    80006d9c:	00813403          	ld	s0,8(sp)
    80006da0:	01010113          	addi	sp,sp,16
    80006da4:	00008067          	ret

0000000080006da8 <uartgetc>:
    80006da8:	ff010113          	addi	sp,sp,-16
    80006dac:	00813423          	sd	s0,8(sp)
    80006db0:	01010413          	addi	s0,sp,16
    80006db4:	10000737          	lui	a4,0x10000
    80006db8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006dbc:	0017f793          	andi	a5,a5,1
    80006dc0:	00078c63          	beqz	a5,80006dd8 <uartgetc+0x30>
    80006dc4:	00074503          	lbu	a0,0(a4)
    80006dc8:	0ff57513          	andi	a0,a0,255
    80006dcc:	00813403          	ld	s0,8(sp)
    80006dd0:	01010113          	addi	sp,sp,16
    80006dd4:	00008067          	ret
    80006dd8:	fff00513          	li	a0,-1
    80006ddc:	ff1ff06f          	j	80006dcc <uartgetc+0x24>

0000000080006de0 <uartintr>:
    80006de0:	100007b7          	lui	a5,0x10000
    80006de4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006de8:	0017f793          	andi	a5,a5,1
    80006dec:	0a078463          	beqz	a5,80006e94 <uartintr+0xb4>
    80006df0:	fe010113          	addi	sp,sp,-32
    80006df4:	00813823          	sd	s0,16(sp)
    80006df8:	00913423          	sd	s1,8(sp)
    80006dfc:	00113c23          	sd	ra,24(sp)
    80006e00:	02010413          	addi	s0,sp,32
    80006e04:	100004b7          	lui	s1,0x10000
    80006e08:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80006e0c:	0ff57513          	andi	a0,a0,255
    80006e10:	fffff097          	auipc	ra,0xfffff
    80006e14:	534080e7          	jalr	1332(ra) # 80006344 <consoleintr>
    80006e18:	0054c783          	lbu	a5,5(s1)
    80006e1c:	0017f793          	andi	a5,a5,1
    80006e20:	fe0794e3          	bnez	a5,80006e08 <uartintr+0x28>
    80006e24:	00003617          	auipc	a2,0x3
    80006e28:	74c60613          	addi	a2,a2,1868 # 8000a570 <uart_tx_r>
    80006e2c:	00003517          	auipc	a0,0x3
    80006e30:	74c50513          	addi	a0,a0,1868 # 8000a578 <uart_tx_w>
    80006e34:	00063783          	ld	a5,0(a2)
    80006e38:	00053703          	ld	a4,0(a0)
    80006e3c:	04f70263          	beq	a4,a5,80006e80 <uartintr+0xa0>
    80006e40:	100005b7          	lui	a1,0x10000
    80006e44:	00005817          	auipc	a6,0x5
    80006e48:	9fc80813          	addi	a6,a6,-1540 # 8000b840 <uart_tx_buf>
    80006e4c:	01c0006f          	j	80006e68 <uartintr+0x88>
    80006e50:	0006c703          	lbu	a4,0(a3)
    80006e54:	00f63023          	sd	a5,0(a2)
    80006e58:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006e5c:	00063783          	ld	a5,0(a2)
    80006e60:	00053703          	ld	a4,0(a0)
    80006e64:	00f70e63          	beq	a4,a5,80006e80 <uartintr+0xa0>
    80006e68:	01f7f713          	andi	a4,a5,31
    80006e6c:	00e806b3          	add	a3,a6,a4
    80006e70:	0055c703          	lbu	a4,5(a1)
    80006e74:	00178793          	addi	a5,a5,1
    80006e78:	02077713          	andi	a4,a4,32
    80006e7c:	fc071ae3          	bnez	a4,80006e50 <uartintr+0x70>
    80006e80:	01813083          	ld	ra,24(sp)
    80006e84:	01013403          	ld	s0,16(sp)
    80006e88:	00813483          	ld	s1,8(sp)
    80006e8c:	02010113          	addi	sp,sp,32
    80006e90:	00008067          	ret
    80006e94:	00003617          	auipc	a2,0x3
    80006e98:	6dc60613          	addi	a2,a2,1756 # 8000a570 <uart_tx_r>
    80006e9c:	00003517          	auipc	a0,0x3
    80006ea0:	6dc50513          	addi	a0,a0,1756 # 8000a578 <uart_tx_w>
    80006ea4:	00063783          	ld	a5,0(a2)
    80006ea8:	00053703          	ld	a4,0(a0)
    80006eac:	04f70263          	beq	a4,a5,80006ef0 <uartintr+0x110>
    80006eb0:	100005b7          	lui	a1,0x10000
    80006eb4:	00005817          	auipc	a6,0x5
    80006eb8:	98c80813          	addi	a6,a6,-1652 # 8000b840 <uart_tx_buf>
    80006ebc:	01c0006f          	j	80006ed8 <uartintr+0xf8>
    80006ec0:	0006c703          	lbu	a4,0(a3)
    80006ec4:	00f63023          	sd	a5,0(a2)
    80006ec8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006ecc:	00063783          	ld	a5,0(a2)
    80006ed0:	00053703          	ld	a4,0(a0)
    80006ed4:	02f70063          	beq	a4,a5,80006ef4 <uartintr+0x114>
    80006ed8:	01f7f713          	andi	a4,a5,31
    80006edc:	00e806b3          	add	a3,a6,a4
    80006ee0:	0055c703          	lbu	a4,5(a1)
    80006ee4:	00178793          	addi	a5,a5,1
    80006ee8:	02077713          	andi	a4,a4,32
    80006eec:	fc071ae3          	bnez	a4,80006ec0 <uartintr+0xe0>
    80006ef0:	00008067          	ret
    80006ef4:	00008067          	ret

0000000080006ef8 <kinit>:
    80006ef8:	fc010113          	addi	sp,sp,-64
    80006efc:	02913423          	sd	s1,40(sp)
    80006f00:	fffff7b7          	lui	a5,0xfffff
    80006f04:	00006497          	auipc	s1,0x6
    80006f08:	95b48493          	addi	s1,s1,-1701 # 8000c85f <end+0xfff>
    80006f0c:	02813823          	sd	s0,48(sp)
    80006f10:	01313c23          	sd	s3,24(sp)
    80006f14:	00f4f4b3          	and	s1,s1,a5
    80006f18:	02113c23          	sd	ra,56(sp)
    80006f1c:	03213023          	sd	s2,32(sp)
    80006f20:	01413823          	sd	s4,16(sp)
    80006f24:	01513423          	sd	s5,8(sp)
    80006f28:	04010413          	addi	s0,sp,64
    80006f2c:	000017b7          	lui	a5,0x1
    80006f30:	01100993          	li	s3,17
    80006f34:	00f487b3          	add	a5,s1,a5
    80006f38:	01b99993          	slli	s3,s3,0x1b
    80006f3c:	06f9e063          	bltu	s3,a5,80006f9c <kinit+0xa4>
    80006f40:	00005a97          	auipc	s5,0x5
    80006f44:	920a8a93          	addi	s5,s5,-1760 # 8000b860 <end>
    80006f48:	0754ec63          	bltu	s1,s5,80006fc0 <kinit+0xc8>
    80006f4c:	0734fa63          	bgeu	s1,s3,80006fc0 <kinit+0xc8>
    80006f50:	00088a37          	lui	s4,0x88
    80006f54:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006f58:	00003917          	auipc	s2,0x3
    80006f5c:	62890913          	addi	s2,s2,1576 # 8000a580 <kmem>
    80006f60:	00ca1a13          	slli	s4,s4,0xc
    80006f64:	0140006f          	j	80006f78 <kinit+0x80>
    80006f68:	000017b7          	lui	a5,0x1
    80006f6c:	00f484b3          	add	s1,s1,a5
    80006f70:	0554e863          	bltu	s1,s5,80006fc0 <kinit+0xc8>
    80006f74:	0534f663          	bgeu	s1,s3,80006fc0 <kinit+0xc8>
    80006f78:	00001637          	lui	a2,0x1
    80006f7c:	00100593          	li	a1,1
    80006f80:	00048513          	mv	a0,s1
    80006f84:	00000097          	auipc	ra,0x0
    80006f88:	5e4080e7          	jalr	1508(ra) # 80007568 <__memset>
    80006f8c:	00093783          	ld	a5,0(s2)
    80006f90:	00f4b023          	sd	a5,0(s1)
    80006f94:	00993023          	sd	s1,0(s2)
    80006f98:	fd4498e3          	bne	s1,s4,80006f68 <kinit+0x70>
    80006f9c:	03813083          	ld	ra,56(sp)
    80006fa0:	03013403          	ld	s0,48(sp)
    80006fa4:	02813483          	ld	s1,40(sp)
    80006fa8:	02013903          	ld	s2,32(sp)
    80006fac:	01813983          	ld	s3,24(sp)
    80006fb0:	01013a03          	ld	s4,16(sp)
    80006fb4:	00813a83          	ld	s5,8(sp)
    80006fb8:	04010113          	addi	sp,sp,64
    80006fbc:	00008067          	ret
    80006fc0:	00001517          	auipc	a0,0x1
    80006fc4:	7d850513          	addi	a0,a0,2008 # 80008798 <digits+0x18>
    80006fc8:	fffff097          	auipc	ra,0xfffff
    80006fcc:	4b4080e7          	jalr	1204(ra) # 8000647c <panic>

0000000080006fd0 <freerange>:
    80006fd0:	fc010113          	addi	sp,sp,-64
    80006fd4:	000017b7          	lui	a5,0x1
    80006fd8:	02913423          	sd	s1,40(sp)
    80006fdc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006fe0:	009504b3          	add	s1,a0,s1
    80006fe4:	fffff537          	lui	a0,0xfffff
    80006fe8:	02813823          	sd	s0,48(sp)
    80006fec:	02113c23          	sd	ra,56(sp)
    80006ff0:	03213023          	sd	s2,32(sp)
    80006ff4:	01313c23          	sd	s3,24(sp)
    80006ff8:	01413823          	sd	s4,16(sp)
    80006ffc:	01513423          	sd	s5,8(sp)
    80007000:	01613023          	sd	s6,0(sp)
    80007004:	04010413          	addi	s0,sp,64
    80007008:	00a4f4b3          	and	s1,s1,a0
    8000700c:	00f487b3          	add	a5,s1,a5
    80007010:	06f5e463          	bltu	a1,a5,80007078 <freerange+0xa8>
    80007014:	00005a97          	auipc	s5,0x5
    80007018:	84ca8a93          	addi	s5,s5,-1972 # 8000b860 <end>
    8000701c:	0954e263          	bltu	s1,s5,800070a0 <freerange+0xd0>
    80007020:	01100993          	li	s3,17
    80007024:	01b99993          	slli	s3,s3,0x1b
    80007028:	0734fc63          	bgeu	s1,s3,800070a0 <freerange+0xd0>
    8000702c:	00058a13          	mv	s4,a1
    80007030:	00003917          	auipc	s2,0x3
    80007034:	55090913          	addi	s2,s2,1360 # 8000a580 <kmem>
    80007038:	00002b37          	lui	s6,0x2
    8000703c:	0140006f          	j	80007050 <freerange+0x80>
    80007040:	000017b7          	lui	a5,0x1
    80007044:	00f484b3          	add	s1,s1,a5
    80007048:	0554ec63          	bltu	s1,s5,800070a0 <freerange+0xd0>
    8000704c:	0534fa63          	bgeu	s1,s3,800070a0 <freerange+0xd0>
    80007050:	00001637          	lui	a2,0x1
    80007054:	00100593          	li	a1,1
    80007058:	00048513          	mv	a0,s1
    8000705c:	00000097          	auipc	ra,0x0
    80007060:	50c080e7          	jalr	1292(ra) # 80007568 <__memset>
    80007064:	00093703          	ld	a4,0(s2)
    80007068:	016487b3          	add	a5,s1,s6
    8000706c:	00e4b023          	sd	a4,0(s1)
    80007070:	00993023          	sd	s1,0(s2)
    80007074:	fcfa76e3          	bgeu	s4,a5,80007040 <freerange+0x70>
    80007078:	03813083          	ld	ra,56(sp)
    8000707c:	03013403          	ld	s0,48(sp)
    80007080:	02813483          	ld	s1,40(sp)
    80007084:	02013903          	ld	s2,32(sp)
    80007088:	01813983          	ld	s3,24(sp)
    8000708c:	01013a03          	ld	s4,16(sp)
    80007090:	00813a83          	ld	s5,8(sp)
    80007094:	00013b03          	ld	s6,0(sp)
    80007098:	04010113          	addi	sp,sp,64
    8000709c:	00008067          	ret
    800070a0:	00001517          	auipc	a0,0x1
    800070a4:	6f850513          	addi	a0,a0,1784 # 80008798 <digits+0x18>
    800070a8:	fffff097          	auipc	ra,0xfffff
    800070ac:	3d4080e7          	jalr	980(ra) # 8000647c <panic>

00000000800070b0 <kfree>:
    800070b0:	fe010113          	addi	sp,sp,-32
    800070b4:	00813823          	sd	s0,16(sp)
    800070b8:	00113c23          	sd	ra,24(sp)
    800070bc:	00913423          	sd	s1,8(sp)
    800070c0:	02010413          	addi	s0,sp,32
    800070c4:	03451793          	slli	a5,a0,0x34
    800070c8:	04079c63          	bnez	a5,80007120 <kfree+0x70>
    800070cc:	00004797          	auipc	a5,0x4
    800070d0:	79478793          	addi	a5,a5,1940 # 8000b860 <end>
    800070d4:	00050493          	mv	s1,a0
    800070d8:	04f56463          	bltu	a0,a5,80007120 <kfree+0x70>
    800070dc:	01100793          	li	a5,17
    800070e0:	01b79793          	slli	a5,a5,0x1b
    800070e4:	02f57e63          	bgeu	a0,a5,80007120 <kfree+0x70>
    800070e8:	00001637          	lui	a2,0x1
    800070ec:	00100593          	li	a1,1
    800070f0:	00000097          	auipc	ra,0x0
    800070f4:	478080e7          	jalr	1144(ra) # 80007568 <__memset>
    800070f8:	00003797          	auipc	a5,0x3
    800070fc:	48878793          	addi	a5,a5,1160 # 8000a580 <kmem>
    80007100:	0007b703          	ld	a4,0(a5)
    80007104:	01813083          	ld	ra,24(sp)
    80007108:	01013403          	ld	s0,16(sp)
    8000710c:	00e4b023          	sd	a4,0(s1)
    80007110:	0097b023          	sd	s1,0(a5)
    80007114:	00813483          	ld	s1,8(sp)
    80007118:	02010113          	addi	sp,sp,32
    8000711c:	00008067          	ret
    80007120:	00001517          	auipc	a0,0x1
    80007124:	67850513          	addi	a0,a0,1656 # 80008798 <digits+0x18>
    80007128:	fffff097          	auipc	ra,0xfffff
    8000712c:	354080e7          	jalr	852(ra) # 8000647c <panic>

0000000080007130 <kalloc>:
    80007130:	fe010113          	addi	sp,sp,-32
    80007134:	00813823          	sd	s0,16(sp)
    80007138:	00913423          	sd	s1,8(sp)
    8000713c:	00113c23          	sd	ra,24(sp)
    80007140:	02010413          	addi	s0,sp,32
    80007144:	00003797          	auipc	a5,0x3
    80007148:	43c78793          	addi	a5,a5,1084 # 8000a580 <kmem>
    8000714c:	0007b483          	ld	s1,0(a5)
    80007150:	02048063          	beqz	s1,80007170 <kalloc+0x40>
    80007154:	0004b703          	ld	a4,0(s1)
    80007158:	00001637          	lui	a2,0x1
    8000715c:	00500593          	li	a1,5
    80007160:	00048513          	mv	a0,s1
    80007164:	00e7b023          	sd	a4,0(a5)
    80007168:	00000097          	auipc	ra,0x0
    8000716c:	400080e7          	jalr	1024(ra) # 80007568 <__memset>
    80007170:	01813083          	ld	ra,24(sp)
    80007174:	01013403          	ld	s0,16(sp)
    80007178:	00048513          	mv	a0,s1
    8000717c:	00813483          	ld	s1,8(sp)
    80007180:	02010113          	addi	sp,sp,32
    80007184:	00008067          	ret

0000000080007188 <initlock>:
    80007188:	ff010113          	addi	sp,sp,-16
    8000718c:	00813423          	sd	s0,8(sp)
    80007190:	01010413          	addi	s0,sp,16
    80007194:	00813403          	ld	s0,8(sp)
    80007198:	00b53423          	sd	a1,8(a0)
    8000719c:	00052023          	sw	zero,0(a0)
    800071a0:	00053823          	sd	zero,16(a0)
    800071a4:	01010113          	addi	sp,sp,16
    800071a8:	00008067          	ret

00000000800071ac <acquire>:
    800071ac:	fe010113          	addi	sp,sp,-32
    800071b0:	00813823          	sd	s0,16(sp)
    800071b4:	00913423          	sd	s1,8(sp)
    800071b8:	00113c23          	sd	ra,24(sp)
    800071bc:	01213023          	sd	s2,0(sp)
    800071c0:	02010413          	addi	s0,sp,32
    800071c4:	00050493          	mv	s1,a0
    800071c8:	10002973          	csrr	s2,sstatus
    800071cc:	100027f3          	csrr	a5,sstatus
    800071d0:	ffd7f793          	andi	a5,a5,-3
    800071d4:	10079073          	csrw	sstatus,a5
    800071d8:	fffff097          	auipc	ra,0xfffff
    800071dc:	8e8080e7          	jalr	-1816(ra) # 80005ac0 <mycpu>
    800071e0:	07852783          	lw	a5,120(a0)
    800071e4:	06078e63          	beqz	a5,80007260 <acquire+0xb4>
    800071e8:	fffff097          	auipc	ra,0xfffff
    800071ec:	8d8080e7          	jalr	-1832(ra) # 80005ac0 <mycpu>
    800071f0:	07852783          	lw	a5,120(a0)
    800071f4:	0004a703          	lw	a4,0(s1)
    800071f8:	0017879b          	addiw	a5,a5,1
    800071fc:	06f52c23          	sw	a5,120(a0)
    80007200:	04071063          	bnez	a4,80007240 <acquire+0x94>
    80007204:	00100713          	li	a4,1
    80007208:	00070793          	mv	a5,a4
    8000720c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007210:	0007879b          	sext.w	a5,a5
    80007214:	fe079ae3          	bnez	a5,80007208 <acquire+0x5c>
    80007218:	0ff0000f          	fence
    8000721c:	fffff097          	auipc	ra,0xfffff
    80007220:	8a4080e7          	jalr	-1884(ra) # 80005ac0 <mycpu>
    80007224:	01813083          	ld	ra,24(sp)
    80007228:	01013403          	ld	s0,16(sp)
    8000722c:	00a4b823          	sd	a0,16(s1)
    80007230:	00013903          	ld	s2,0(sp)
    80007234:	00813483          	ld	s1,8(sp)
    80007238:	02010113          	addi	sp,sp,32
    8000723c:	00008067          	ret
    80007240:	0104b903          	ld	s2,16(s1)
    80007244:	fffff097          	auipc	ra,0xfffff
    80007248:	87c080e7          	jalr	-1924(ra) # 80005ac0 <mycpu>
    8000724c:	faa91ce3          	bne	s2,a0,80007204 <acquire+0x58>
    80007250:	00001517          	auipc	a0,0x1
    80007254:	55050513          	addi	a0,a0,1360 # 800087a0 <digits+0x20>
    80007258:	fffff097          	auipc	ra,0xfffff
    8000725c:	224080e7          	jalr	548(ra) # 8000647c <panic>
    80007260:	00195913          	srli	s2,s2,0x1
    80007264:	fffff097          	auipc	ra,0xfffff
    80007268:	85c080e7          	jalr	-1956(ra) # 80005ac0 <mycpu>
    8000726c:	00197913          	andi	s2,s2,1
    80007270:	07252e23          	sw	s2,124(a0)
    80007274:	f75ff06f          	j	800071e8 <acquire+0x3c>

0000000080007278 <release>:
    80007278:	fe010113          	addi	sp,sp,-32
    8000727c:	00813823          	sd	s0,16(sp)
    80007280:	00113c23          	sd	ra,24(sp)
    80007284:	00913423          	sd	s1,8(sp)
    80007288:	01213023          	sd	s2,0(sp)
    8000728c:	02010413          	addi	s0,sp,32
    80007290:	00052783          	lw	a5,0(a0)
    80007294:	00079a63          	bnez	a5,800072a8 <release+0x30>
    80007298:	00001517          	auipc	a0,0x1
    8000729c:	51050513          	addi	a0,a0,1296 # 800087a8 <digits+0x28>
    800072a0:	fffff097          	auipc	ra,0xfffff
    800072a4:	1dc080e7          	jalr	476(ra) # 8000647c <panic>
    800072a8:	01053903          	ld	s2,16(a0)
    800072ac:	00050493          	mv	s1,a0
    800072b0:	fffff097          	auipc	ra,0xfffff
    800072b4:	810080e7          	jalr	-2032(ra) # 80005ac0 <mycpu>
    800072b8:	fea910e3          	bne	s2,a0,80007298 <release+0x20>
    800072bc:	0004b823          	sd	zero,16(s1)
    800072c0:	0ff0000f          	fence
    800072c4:	0f50000f          	fence	iorw,ow
    800072c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800072cc:	ffffe097          	auipc	ra,0xffffe
    800072d0:	7f4080e7          	jalr	2036(ra) # 80005ac0 <mycpu>
    800072d4:	100027f3          	csrr	a5,sstatus
    800072d8:	0027f793          	andi	a5,a5,2
    800072dc:	04079a63          	bnez	a5,80007330 <release+0xb8>
    800072e0:	07852783          	lw	a5,120(a0)
    800072e4:	02f05e63          	blez	a5,80007320 <release+0xa8>
    800072e8:	fff7871b          	addiw	a4,a5,-1
    800072ec:	06e52c23          	sw	a4,120(a0)
    800072f0:	00071c63          	bnez	a4,80007308 <release+0x90>
    800072f4:	07c52783          	lw	a5,124(a0)
    800072f8:	00078863          	beqz	a5,80007308 <release+0x90>
    800072fc:	100027f3          	csrr	a5,sstatus
    80007300:	0027e793          	ori	a5,a5,2
    80007304:	10079073          	csrw	sstatus,a5
    80007308:	01813083          	ld	ra,24(sp)
    8000730c:	01013403          	ld	s0,16(sp)
    80007310:	00813483          	ld	s1,8(sp)
    80007314:	00013903          	ld	s2,0(sp)
    80007318:	02010113          	addi	sp,sp,32
    8000731c:	00008067          	ret
    80007320:	00001517          	auipc	a0,0x1
    80007324:	4a850513          	addi	a0,a0,1192 # 800087c8 <digits+0x48>
    80007328:	fffff097          	auipc	ra,0xfffff
    8000732c:	154080e7          	jalr	340(ra) # 8000647c <panic>
    80007330:	00001517          	auipc	a0,0x1
    80007334:	48050513          	addi	a0,a0,1152 # 800087b0 <digits+0x30>
    80007338:	fffff097          	auipc	ra,0xfffff
    8000733c:	144080e7          	jalr	324(ra) # 8000647c <panic>

0000000080007340 <holding>:
    80007340:	00052783          	lw	a5,0(a0)
    80007344:	00079663          	bnez	a5,80007350 <holding+0x10>
    80007348:	00000513          	li	a0,0
    8000734c:	00008067          	ret
    80007350:	fe010113          	addi	sp,sp,-32
    80007354:	00813823          	sd	s0,16(sp)
    80007358:	00913423          	sd	s1,8(sp)
    8000735c:	00113c23          	sd	ra,24(sp)
    80007360:	02010413          	addi	s0,sp,32
    80007364:	01053483          	ld	s1,16(a0)
    80007368:	ffffe097          	auipc	ra,0xffffe
    8000736c:	758080e7          	jalr	1880(ra) # 80005ac0 <mycpu>
    80007370:	01813083          	ld	ra,24(sp)
    80007374:	01013403          	ld	s0,16(sp)
    80007378:	40a48533          	sub	a0,s1,a0
    8000737c:	00153513          	seqz	a0,a0
    80007380:	00813483          	ld	s1,8(sp)
    80007384:	02010113          	addi	sp,sp,32
    80007388:	00008067          	ret

000000008000738c <push_off>:
    8000738c:	fe010113          	addi	sp,sp,-32
    80007390:	00813823          	sd	s0,16(sp)
    80007394:	00113c23          	sd	ra,24(sp)
    80007398:	00913423          	sd	s1,8(sp)
    8000739c:	02010413          	addi	s0,sp,32
    800073a0:	100024f3          	csrr	s1,sstatus
    800073a4:	100027f3          	csrr	a5,sstatus
    800073a8:	ffd7f793          	andi	a5,a5,-3
    800073ac:	10079073          	csrw	sstatus,a5
    800073b0:	ffffe097          	auipc	ra,0xffffe
    800073b4:	710080e7          	jalr	1808(ra) # 80005ac0 <mycpu>
    800073b8:	07852783          	lw	a5,120(a0)
    800073bc:	02078663          	beqz	a5,800073e8 <push_off+0x5c>
    800073c0:	ffffe097          	auipc	ra,0xffffe
    800073c4:	700080e7          	jalr	1792(ra) # 80005ac0 <mycpu>
    800073c8:	07852783          	lw	a5,120(a0)
    800073cc:	01813083          	ld	ra,24(sp)
    800073d0:	01013403          	ld	s0,16(sp)
    800073d4:	0017879b          	addiw	a5,a5,1
    800073d8:	06f52c23          	sw	a5,120(a0)
    800073dc:	00813483          	ld	s1,8(sp)
    800073e0:	02010113          	addi	sp,sp,32
    800073e4:	00008067          	ret
    800073e8:	0014d493          	srli	s1,s1,0x1
    800073ec:	ffffe097          	auipc	ra,0xffffe
    800073f0:	6d4080e7          	jalr	1748(ra) # 80005ac0 <mycpu>
    800073f4:	0014f493          	andi	s1,s1,1
    800073f8:	06952e23          	sw	s1,124(a0)
    800073fc:	fc5ff06f          	j	800073c0 <push_off+0x34>

0000000080007400 <pop_off>:
    80007400:	ff010113          	addi	sp,sp,-16
    80007404:	00813023          	sd	s0,0(sp)
    80007408:	00113423          	sd	ra,8(sp)
    8000740c:	01010413          	addi	s0,sp,16
    80007410:	ffffe097          	auipc	ra,0xffffe
    80007414:	6b0080e7          	jalr	1712(ra) # 80005ac0 <mycpu>
    80007418:	100027f3          	csrr	a5,sstatus
    8000741c:	0027f793          	andi	a5,a5,2
    80007420:	04079663          	bnez	a5,8000746c <pop_off+0x6c>
    80007424:	07852783          	lw	a5,120(a0)
    80007428:	02f05a63          	blez	a5,8000745c <pop_off+0x5c>
    8000742c:	fff7871b          	addiw	a4,a5,-1
    80007430:	06e52c23          	sw	a4,120(a0)
    80007434:	00071c63          	bnez	a4,8000744c <pop_off+0x4c>
    80007438:	07c52783          	lw	a5,124(a0)
    8000743c:	00078863          	beqz	a5,8000744c <pop_off+0x4c>
    80007440:	100027f3          	csrr	a5,sstatus
    80007444:	0027e793          	ori	a5,a5,2
    80007448:	10079073          	csrw	sstatus,a5
    8000744c:	00813083          	ld	ra,8(sp)
    80007450:	00013403          	ld	s0,0(sp)
    80007454:	01010113          	addi	sp,sp,16
    80007458:	00008067          	ret
    8000745c:	00001517          	auipc	a0,0x1
    80007460:	36c50513          	addi	a0,a0,876 # 800087c8 <digits+0x48>
    80007464:	fffff097          	auipc	ra,0xfffff
    80007468:	018080e7          	jalr	24(ra) # 8000647c <panic>
    8000746c:	00001517          	auipc	a0,0x1
    80007470:	34450513          	addi	a0,a0,836 # 800087b0 <digits+0x30>
    80007474:	fffff097          	auipc	ra,0xfffff
    80007478:	008080e7          	jalr	8(ra) # 8000647c <panic>

000000008000747c <push_on>:
    8000747c:	fe010113          	addi	sp,sp,-32
    80007480:	00813823          	sd	s0,16(sp)
    80007484:	00113c23          	sd	ra,24(sp)
    80007488:	00913423          	sd	s1,8(sp)
    8000748c:	02010413          	addi	s0,sp,32
    80007490:	100024f3          	csrr	s1,sstatus
    80007494:	100027f3          	csrr	a5,sstatus
    80007498:	0027e793          	ori	a5,a5,2
    8000749c:	10079073          	csrw	sstatus,a5
    800074a0:	ffffe097          	auipc	ra,0xffffe
    800074a4:	620080e7          	jalr	1568(ra) # 80005ac0 <mycpu>
    800074a8:	07852783          	lw	a5,120(a0)
    800074ac:	02078663          	beqz	a5,800074d8 <push_on+0x5c>
    800074b0:	ffffe097          	auipc	ra,0xffffe
    800074b4:	610080e7          	jalr	1552(ra) # 80005ac0 <mycpu>
    800074b8:	07852783          	lw	a5,120(a0)
    800074bc:	01813083          	ld	ra,24(sp)
    800074c0:	01013403          	ld	s0,16(sp)
    800074c4:	0017879b          	addiw	a5,a5,1
    800074c8:	06f52c23          	sw	a5,120(a0)
    800074cc:	00813483          	ld	s1,8(sp)
    800074d0:	02010113          	addi	sp,sp,32
    800074d4:	00008067          	ret
    800074d8:	0014d493          	srli	s1,s1,0x1
    800074dc:	ffffe097          	auipc	ra,0xffffe
    800074e0:	5e4080e7          	jalr	1508(ra) # 80005ac0 <mycpu>
    800074e4:	0014f493          	andi	s1,s1,1
    800074e8:	06952e23          	sw	s1,124(a0)
    800074ec:	fc5ff06f          	j	800074b0 <push_on+0x34>

00000000800074f0 <pop_on>:
    800074f0:	ff010113          	addi	sp,sp,-16
    800074f4:	00813023          	sd	s0,0(sp)
    800074f8:	00113423          	sd	ra,8(sp)
    800074fc:	01010413          	addi	s0,sp,16
    80007500:	ffffe097          	auipc	ra,0xffffe
    80007504:	5c0080e7          	jalr	1472(ra) # 80005ac0 <mycpu>
    80007508:	100027f3          	csrr	a5,sstatus
    8000750c:	0027f793          	andi	a5,a5,2
    80007510:	04078463          	beqz	a5,80007558 <pop_on+0x68>
    80007514:	07852783          	lw	a5,120(a0)
    80007518:	02f05863          	blez	a5,80007548 <pop_on+0x58>
    8000751c:	fff7879b          	addiw	a5,a5,-1
    80007520:	06f52c23          	sw	a5,120(a0)
    80007524:	07853783          	ld	a5,120(a0)
    80007528:	00079863          	bnez	a5,80007538 <pop_on+0x48>
    8000752c:	100027f3          	csrr	a5,sstatus
    80007530:	ffd7f793          	andi	a5,a5,-3
    80007534:	10079073          	csrw	sstatus,a5
    80007538:	00813083          	ld	ra,8(sp)
    8000753c:	00013403          	ld	s0,0(sp)
    80007540:	01010113          	addi	sp,sp,16
    80007544:	00008067          	ret
    80007548:	00001517          	auipc	a0,0x1
    8000754c:	2a850513          	addi	a0,a0,680 # 800087f0 <digits+0x70>
    80007550:	fffff097          	auipc	ra,0xfffff
    80007554:	f2c080e7          	jalr	-212(ra) # 8000647c <panic>
    80007558:	00001517          	auipc	a0,0x1
    8000755c:	27850513          	addi	a0,a0,632 # 800087d0 <digits+0x50>
    80007560:	fffff097          	auipc	ra,0xfffff
    80007564:	f1c080e7          	jalr	-228(ra) # 8000647c <panic>

0000000080007568 <__memset>:
    80007568:	ff010113          	addi	sp,sp,-16
    8000756c:	00813423          	sd	s0,8(sp)
    80007570:	01010413          	addi	s0,sp,16
    80007574:	1a060e63          	beqz	a2,80007730 <__memset+0x1c8>
    80007578:	40a007b3          	neg	a5,a0
    8000757c:	0077f793          	andi	a5,a5,7
    80007580:	00778693          	addi	a3,a5,7
    80007584:	00b00813          	li	a6,11
    80007588:	0ff5f593          	andi	a1,a1,255
    8000758c:	fff6071b          	addiw	a4,a2,-1
    80007590:	1b06e663          	bltu	a3,a6,8000773c <__memset+0x1d4>
    80007594:	1cd76463          	bltu	a4,a3,8000775c <__memset+0x1f4>
    80007598:	1a078e63          	beqz	a5,80007754 <__memset+0x1ec>
    8000759c:	00b50023          	sb	a1,0(a0)
    800075a0:	00100713          	li	a4,1
    800075a4:	1ae78463          	beq	a5,a4,8000774c <__memset+0x1e4>
    800075a8:	00b500a3          	sb	a1,1(a0)
    800075ac:	00200713          	li	a4,2
    800075b0:	1ae78a63          	beq	a5,a4,80007764 <__memset+0x1fc>
    800075b4:	00b50123          	sb	a1,2(a0)
    800075b8:	00300713          	li	a4,3
    800075bc:	18e78463          	beq	a5,a4,80007744 <__memset+0x1dc>
    800075c0:	00b501a3          	sb	a1,3(a0)
    800075c4:	00400713          	li	a4,4
    800075c8:	1ae78263          	beq	a5,a4,8000776c <__memset+0x204>
    800075cc:	00b50223          	sb	a1,4(a0)
    800075d0:	00500713          	li	a4,5
    800075d4:	1ae78063          	beq	a5,a4,80007774 <__memset+0x20c>
    800075d8:	00b502a3          	sb	a1,5(a0)
    800075dc:	00700713          	li	a4,7
    800075e0:	18e79e63          	bne	a5,a4,8000777c <__memset+0x214>
    800075e4:	00b50323          	sb	a1,6(a0)
    800075e8:	00700e93          	li	t4,7
    800075ec:	00859713          	slli	a4,a1,0x8
    800075f0:	00e5e733          	or	a4,a1,a4
    800075f4:	01059e13          	slli	t3,a1,0x10
    800075f8:	01c76e33          	or	t3,a4,t3
    800075fc:	01859313          	slli	t1,a1,0x18
    80007600:	006e6333          	or	t1,t3,t1
    80007604:	02059893          	slli	a7,a1,0x20
    80007608:	40f60e3b          	subw	t3,a2,a5
    8000760c:	011368b3          	or	a7,t1,a7
    80007610:	02859813          	slli	a6,a1,0x28
    80007614:	0108e833          	or	a6,a7,a6
    80007618:	03059693          	slli	a3,a1,0x30
    8000761c:	003e589b          	srliw	a7,t3,0x3
    80007620:	00d866b3          	or	a3,a6,a3
    80007624:	03859713          	slli	a4,a1,0x38
    80007628:	00389813          	slli	a6,a7,0x3
    8000762c:	00f507b3          	add	a5,a0,a5
    80007630:	00e6e733          	or	a4,a3,a4
    80007634:	000e089b          	sext.w	a7,t3
    80007638:	00f806b3          	add	a3,a6,a5
    8000763c:	00e7b023          	sd	a4,0(a5)
    80007640:	00878793          	addi	a5,a5,8
    80007644:	fed79ce3          	bne	a5,a3,8000763c <__memset+0xd4>
    80007648:	ff8e7793          	andi	a5,t3,-8
    8000764c:	0007871b          	sext.w	a4,a5
    80007650:	01d787bb          	addw	a5,a5,t4
    80007654:	0ce88e63          	beq	a7,a4,80007730 <__memset+0x1c8>
    80007658:	00f50733          	add	a4,a0,a5
    8000765c:	00b70023          	sb	a1,0(a4)
    80007660:	0017871b          	addiw	a4,a5,1
    80007664:	0cc77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007668:	00e50733          	add	a4,a0,a4
    8000766c:	00b70023          	sb	a1,0(a4)
    80007670:	0027871b          	addiw	a4,a5,2
    80007674:	0ac77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007678:	00e50733          	add	a4,a0,a4
    8000767c:	00b70023          	sb	a1,0(a4)
    80007680:	0037871b          	addiw	a4,a5,3
    80007684:	0ac77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007688:	00e50733          	add	a4,a0,a4
    8000768c:	00b70023          	sb	a1,0(a4)
    80007690:	0047871b          	addiw	a4,a5,4
    80007694:	08c77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007698:	00e50733          	add	a4,a0,a4
    8000769c:	00b70023          	sb	a1,0(a4)
    800076a0:	0057871b          	addiw	a4,a5,5
    800076a4:	08c77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076a8:	00e50733          	add	a4,a0,a4
    800076ac:	00b70023          	sb	a1,0(a4)
    800076b0:	0067871b          	addiw	a4,a5,6
    800076b4:	06c77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076b8:	00e50733          	add	a4,a0,a4
    800076bc:	00b70023          	sb	a1,0(a4)
    800076c0:	0077871b          	addiw	a4,a5,7
    800076c4:	06c77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076c8:	00e50733          	add	a4,a0,a4
    800076cc:	00b70023          	sb	a1,0(a4)
    800076d0:	0087871b          	addiw	a4,a5,8
    800076d4:	04c77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076d8:	00e50733          	add	a4,a0,a4
    800076dc:	00b70023          	sb	a1,0(a4)
    800076e0:	0097871b          	addiw	a4,a5,9
    800076e4:	04c77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076e8:	00e50733          	add	a4,a0,a4
    800076ec:	00b70023          	sb	a1,0(a4)
    800076f0:	00a7871b          	addiw	a4,a5,10
    800076f4:	02c77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    800076f8:	00e50733          	add	a4,a0,a4
    800076fc:	00b70023          	sb	a1,0(a4)
    80007700:	00b7871b          	addiw	a4,a5,11
    80007704:	02c77663          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007708:	00e50733          	add	a4,a0,a4
    8000770c:	00b70023          	sb	a1,0(a4)
    80007710:	00c7871b          	addiw	a4,a5,12
    80007714:	00c77e63          	bgeu	a4,a2,80007730 <__memset+0x1c8>
    80007718:	00e50733          	add	a4,a0,a4
    8000771c:	00b70023          	sb	a1,0(a4)
    80007720:	00d7879b          	addiw	a5,a5,13
    80007724:	00c7f663          	bgeu	a5,a2,80007730 <__memset+0x1c8>
    80007728:	00f507b3          	add	a5,a0,a5
    8000772c:	00b78023          	sb	a1,0(a5)
    80007730:	00813403          	ld	s0,8(sp)
    80007734:	01010113          	addi	sp,sp,16
    80007738:	00008067          	ret
    8000773c:	00b00693          	li	a3,11
    80007740:	e55ff06f          	j	80007594 <__memset+0x2c>
    80007744:	00300e93          	li	t4,3
    80007748:	ea5ff06f          	j	800075ec <__memset+0x84>
    8000774c:	00100e93          	li	t4,1
    80007750:	e9dff06f          	j	800075ec <__memset+0x84>
    80007754:	00000e93          	li	t4,0
    80007758:	e95ff06f          	j	800075ec <__memset+0x84>
    8000775c:	00000793          	li	a5,0
    80007760:	ef9ff06f          	j	80007658 <__memset+0xf0>
    80007764:	00200e93          	li	t4,2
    80007768:	e85ff06f          	j	800075ec <__memset+0x84>
    8000776c:	00400e93          	li	t4,4
    80007770:	e7dff06f          	j	800075ec <__memset+0x84>
    80007774:	00500e93          	li	t4,5
    80007778:	e75ff06f          	j	800075ec <__memset+0x84>
    8000777c:	00600e93          	li	t4,6
    80007780:	e6dff06f          	j	800075ec <__memset+0x84>

0000000080007784 <__memmove>:
    80007784:	ff010113          	addi	sp,sp,-16
    80007788:	00813423          	sd	s0,8(sp)
    8000778c:	01010413          	addi	s0,sp,16
    80007790:	0e060863          	beqz	a2,80007880 <__memmove+0xfc>
    80007794:	fff6069b          	addiw	a3,a2,-1
    80007798:	0006881b          	sext.w	a6,a3
    8000779c:	0ea5e863          	bltu	a1,a0,8000788c <__memmove+0x108>
    800077a0:	00758713          	addi	a4,a1,7
    800077a4:	00a5e7b3          	or	a5,a1,a0
    800077a8:	40a70733          	sub	a4,a4,a0
    800077ac:	0077f793          	andi	a5,a5,7
    800077b0:	00f73713          	sltiu	a4,a4,15
    800077b4:	00174713          	xori	a4,a4,1
    800077b8:	0017b793          	seqz	a5,a5
    800077bc:	00e7f7b3          	and	a5,a5,a4
    800077c0:	10078863          	beqz	a5,800078d0 <__memmove+0x14c>
    800077c4:	00900793          	li	a5,9
    800077c8:	1107f463          	bgeu	a5,a6,800078d0 <__memmove+0x14c>
    800077cc:	0036581b          	srliw	a6,a2,0x3
    800077d0:	fff8081b          	addiw	a6,a6,-1
    800077d4:	02081813          	slli	a6,a6,0x20
    800077d8:	01d85893          	srli	a7,a6,0x1d
    800077dc:	00858813          	addi	a6,a1,8
    800077e0:	00058793          	mv	a5,a1
    800077e4:	00050713          	mv	a4,a0
    800077e8:	01088833          	add	a6,a7,a6
    800077ec:	0007b883          	ld	a7,0(a5)
    800077f0:	00878793          	addi	a5,a5,8
    800077f4:	00870713          	addi	a4,a4,8
    800077f8:	ff173c23          	sd	a7,-8(a4)
    800077fc:	ff0798e3          	bne	a5,a6,800077ec <__memmove+0x68>
    80007800:	ff867713          	andi	a4,a2,-8
    80007804:	02071793          	slli	a5,a4,0x20
    80007808:	0207d793          	srli	a5,a5,0x20
    8000780c:	00f585b3          	add	a1,a1,a5
    80007810:	40e686bb          	subw	a3,a3,a4
    80007814:	00f507b3          	add	a5,a0,a5
    80007818:	06e60463          	beq	a2,a4,80007880 <__memmove+0xfc>
    8000781c:	0005c703          	lbu	a4,0(a1)
    80007820:	00e78023          	sb	a4,0(a5)
    80007824:	04068e63          	beqz	a3,80007880 <__memmove+0xfc>
    80007828:	0015c603          	lbu	a2,1(a1)
    8000782c:	00100713          	li	a4,1
    80007830:	00c780a3          	sb	a2,1(a5)
    80007834:	04e68663          	beq	a3,a4,80007880 <__memmove+0xfc>
    80007838:	0025c603          	lbu	a2,2(a1)
    8000783c:	00200713          	li	a4,2
    80007840:	00c78123          	sb	a2,2(a5)
    80007844:	02e68e63          	beq	a3,a4,80007880 <__memmove+0xfc>
    80007848:	0035c603          	lbu	a2,3(a1)
    8000784c:	00300713          	li	a4,3
    80007850:	00c781a3          	sb	a2,3(a5)
    80007854:	02e68663          	beq	a3,a4,80007880 <__memmove+0xfc>
    80007858:	0045c603          	lbu	a2,4(a1)
    8000785c:	00400713          	li	a4,4
    80007860:	00c78223          	sb	a2,4(a5)
    80007864:	00e68e63          	beq	a3,a4,80007880 <__memmove+0xfc>
    80007868:	0055c603          	lbu	a2,5(a1)
    8000786c:	00500713          	li	a4,5
    80007870:	00c782a3          	sb	a2,5(a5)
    80007874:	00e68663          	beq	a3,a4,80007880 <__memmove+0xfc>
    80007878:	0065c703          	lbu	a4,6(a1)
    8000787c:	00e78323          	sb	a4,6(a5)
    80007880:	00813403          	ld	s0,8(sp)
    80007884:	01010113          	addi	sp,sp,16
    80007888:	00008067          	ret
    8000788c:	02061713          	slli	a4,a2,0x20
    80007890:	02075713          	srli	a4,a4,0x20
    80007894:	00e587b3          	add	a5,a1,a4
    80007898:	f0f574e3          	bgeu	a0,a5,800077a0 <__memmove+0x1c>
    8000789c:	02069613          	slli	a2,a3,0x20
    800078a0:	02065613          	srli	a2,a2,0x20
    800078a4:	fff64613          	not	a2,a2
    800078a8:	00e50733          	add	a4,a0,a4
    800078ac:	00c78633          	add	a2,a5,a2
    800078b0:	fff7c683          	lbu	a3,-1(a5)
    800078b4:	fff78793          	addi	a5,a5,-1
    800078b8:	fff70713          	addi	a4,a4,-1
    800078bc:	00d70023          	sb	a3,0(a4)
    800078c0:	fec798e3          	bne	a5,a2,800078b0 <__memmove+0x12c>
    800078c4:	00813403          	ld	s0,8(sp)
    800078c8:	01010113          	addi	sp,sp,16
    800078cc:	00008067          	ret
    800078d0:	02069713          	slli	a4,a3,0x20
    800078d4:	02075713          	srli	a4,a4,0x20
    800078d8:	00170713          	addi	a4,a4,1
    800078dc:	00e50733          	add	a4,a0,a4
    800078e0:	00050793          	mv	a5,a0
    800078e4:	0005c683          	lbu	a3,0(a1)
    800078e8:	00178793          	addi	a5,a5,1
    800078ec:	00158593          	addi	a1,a1,1
    800078f0:	fed78fa3          	sb	a3,-1(a5)
    800078f4:	fee798e3          	bne	a5,a4,800078e4 <__memmove+0x160>
    800078f8:	f89ff06f          	j	80007880 <__memmove+0xfc>

00000000800078fc <__putc>:
    800078fc:	fe010113          	addi	sp,sp,-32
    80007900:	00813823          	sd	s0,16(sp)
    80007904:	00113c23          	sd	ra,24(sp)
    80007908:	02010413          	addi	s0,sp,32
    8000790c:	00050793          	mv	a5,a0
    80007910:	fef40593          	addi	a1,s0,-17
    80007914:	00100613          	li	a2,1
    80007918:	00000513          	li	a0,0
    8000791c:	fef407a3          	sb	a5,-17(s0)
    80007920:	fffff097          	auipc	ra,0xfffff
    80007924:	b3c080e7          	jalr	-1220(ra) # 8000645c <console_write>
    80007928:	01813083          	ld	ra,24(sp)
    8000792c:	01013403          	ld	s0,16(sp)
    80007930:	02010113          	addi	sp,sp,32
    80007934:	00008067          	ret

0000000080007938 <__getc>:
    80007938:	fe010113          	addi	sp,sp,-32
    8000793c:	00813823          	sd	s0,16(sp)
    80007940:	00113c23          	sd	ra,24(sp)
    80007944:	02010413          	addi	s0,sp,32
    80007948:	fe840593          	addi	a1,s0,-24
    8000794c:	00100613          	li	a2,1
    80007950:	00000513          	li	a0,0
    80007954:	fffff097          	auipc	ra,0xfffff
    80007958:	ae8080e7          	jalr	-1304(ra) # 8000643c <console_read>
    8000795c:	fe844503          	lbu	a0,-24(s0)
    80007960:	01813083          	ld	ra,24(sp)
    80007964:	01013403          	ld	s0,16(sp)
    80007968:	02010113          	addi	sp,sp,32
    8000796c:	00008067          	ret

0000000080007970 <console_handler>:
    80007970:	fe010113          	addi	sp,sp,-32
    80007974:	00813823          	sd	s0,16(sp)
    80007978:	00113c23          	sd	ra,24(sp)
    8000797c:	00913423          	sd	s1,8(sp)
    80007980:	02010413          	addi	s0,sp,32
    80007984:	14202773          	csrr	a4,scause
    80007988:	100027f3          	csrr	a5,sstatus
    8000798c:	0027f793          	andi	a5,a5,2
    80007990:	06079e63          	bnez	a5,80007a0c <console_handler+0x9c>
    80007994:	00074c63          	bltz	a4,800079ac <console_handler+0x3c>
    80007998:	01813083          	ld	ra,24(sp)
    8000799c:	01013403          	ld	s0,16(sp)
    800079a0:	00813483          	ld	s1,8(sp)
    800079a4:	02010113          	addi	sp,sp,32
    800079a8:	00008067          	ret
    800079ac:	0ff77713          	andi	a4,a4,255
    800079b0:	00900793          	li	a5,9
    800079b4:	fef712e3          	bne	a4,a5,80007998 <console_handler+0x28>
    800079b8:	ffffe097          	auipc	ra,0xffffe
    800079bc:	6dc080e7          	jalr	1756(ra) # 80006094 <plic_claim>
    800079c0:	00a00793          	li	a5,10
    800079c4:	00050493          	mv	s1,a0
    800079c8:	02f50c63          	beq	a0,a5,80007a00 <console_handler+0x90>
    800079cc:	fc0506e3          	beqz	a0,80007998 <console_handler+0x28>
    800079d0:	00050593          	mv	a1,a0
    800079d4:	00001517          	auipc	a0,0x1
    800079d8:	d2450513          	addi	a0,a0,-732 # 800086f8 <CONSOLE_STATUS+0x6e8>
    800079dc:	fffff097          	auipc	ra,0xfffff
    800079e0:	afc080e7          	jalr	-1284(ra) # 800064d8 <__printf>
    800079e4:	01013403          	ld	s0,16(sp)
    800079e8:	01813083          	ld	ra,24(sp)
    800079ec:	00048513          	mv	a0,s1
    800079f0:	00813483          	ld	s1,8(sp)
    800079f4:	02010113          	addi	sp,sp,32
    800079f8:	ffffe317          	auipc	t1,0xffffe
    800079fc:	6d430067          	jr	1748(t1) # 800060cc <plic_complete>
    80007a00:	fffff097          	auipc	ra,0xfffff
    80007a04:	3e0080e7          	jalr	992(ra) # 80006de0 <uartintr>
    80007a08:	fddff06f          	j	800079e4 <console_handler+0x74>
    80007a0c:	00001517          	auipc	a0,0x1
    80007a10:	dec50513          	addi	a0,a0,-532 # 800087f8 <digits+0x78>
    80007a14:	fffff097          	auipc	ra,0xfffff
    80007a18:	a68080e7          	jalr	-1432(ra) # 8000647c <panic>
	...
