
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	f8813103          	ld	sp,-120(sp) # 80009f88 <_GLOBAL_OFFSET_TABLE_+0x18>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5d5040ef          	jal	ra,80004df0 <start>

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
    800010a4:	29d000ef          	jal	ra,80001b40 <_ZN5Riscv20handleSupervisorTrapEv>


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

0000000080001198 <_Z13thread_createPP7_threadPFvPvES2_>:
//
//size_t mem_get_largest_free_block(){
//    //TODO
//}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001198:	ff010113          	addi	sp,sp,-16
    8000119c:	00813423          	sd	s0,8(sp)
    800011a0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);
    800011a4:	01100793          	li	a5,17
    800011a8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011ac:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011b0:	00050513          	mv	a0,a0
    return ret;
}
    800011b4:	0005051b          	sext.w	a0,a0
    800011b8:	00813403          	ld	s0,8(sp)
    800011bc:	01010113          	addi	sp,sp,16
    800011c0:	00008067          	ret

00000000800011c4 <_Z11thread_exitv>:

int thread_exit(){
    800011c4:	ff010113          	addi	sp,sp,-16
    800011c8:	00813423          	sd	s0,8(sp)
    800011cc:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);
    800011d0:	01200793          	li	a5,18
    800011d4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011d8:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011dc:	00050513          	mv	a0,a0
    return ret;
}
    800011e0:	0005051b          	sext.w	a0,a0
    800011e4:	00813403          	ld	s0,8(sp)
    800011e8:	01010113          	addi	sp,sp,16
    800011ec:	00008067          	ret

00000000800011f0 <_Z15thread_dispatchv>:

void thread_dispatch(){
    800011f0:	ff010113          	addi	sp,sp,-16
    800011f4:	00813423          	sd	s0,8(sp)
    800011f8:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);
    800011fc:	01300793          	li	a5,19
    80001200:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001204:	00000073          	ecall
}
    80001208:	00813403          	ld	s0,8(sp)
    8000120c:	01010113          	addi	sp,sp,16
    80001210:	00008067          	ret

0000000080001214 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    80001214:	ff010113          	addi	sp,sp,-16
    80001218:	00813423          	sd	s0,8(sp)
    8000121c:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);
    80001220:	02100793          	li	a5,33
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

0000000080001240 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle) {
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00813423          	sd	s0,8(sp)
    80001248:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);
    8000124c:	02200793          	li	a5,34
    80001250:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001254:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001258:	00050513          	mv	a0,a0
    return ret;
}
    8000125c:	0005051b          	sext.w	a0,a0
    80001260:	00813403          	ld	s0,8(sp)
    80001264:	01010113          	addi	sp,sp,16
    80001268:	00008067          	ret

000000008000126c <_Z8sem_waitP4_sem>:

int sem_wait(sem_t id){
    8000126c:	ff010113          	addi	sp,sp,-16
    80001270:	00813423          	sd	s0,8(sp)
    80001274:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);
    80001278:	02300793          	li	a5,35
    8000127c:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001280:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001284:	00050513          	mv	a0,a0
    return ret;
}
    80001288:	0005051b          	sext.w	a0,a0
    8000128c:	00813403          	ld	s0,8(sp)
    80001290:	01010113          	addi	sp,sp,16
    80001294:	00008067          	ret

0000000080001298 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t id){
    80001298:	ff010113          	addi	sp,sp,-16
    8000129c:	00813423          	sd	s0,8(sp)
    800012a0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);
    800012a4:	02400793          	li	a5,36
    800012a8:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012ac:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800012b0:	00050513          	mv	a0,a0
    return ret;
}
    800012b4:	0005051b          	sext.w	a0,a0
    800012b8:	00813403          	ld	s0,8(sp)
    800012bc:	01010113          	addi	sp,sp,16
    800012c0:	00008067          	ret

00000000800012c4 <_Z4getcv>:

char getc(){
    800012c4:	ff010113          	addi	sp,sp,-16
    800012c8:	00813423          	sd	s0,8(sp)
    800012cc:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_GETC);
    800012d0:	04100793          	li	a5,65
    800012d4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012d8:	00000073          	ecall

    char ret;
    READ_REG(ret, "a0");
    800012dc:	00050513          	mv	a0,a0
    return ret;
}
    800012e0:	0ff57513          	andi	a0,a0,255
    800012e4:	00813403          	ld	s0,8(sp)
    800012e8:	01010113          	addi	sp,sp,16
    800012ec:	00008067          	ret

00000000800012f0 <_Z4putcc>:

void putc(char c){
    800012f0:	ff010113          	addi	sp,sp,-16
    800012f4:	00813423          	sd	s0,8(sp)
    800012f8:	01010413          	addi	s0,sp,16

    WRITE_REG("a7", Num::SCALL_PUTC);
    800012fc:	04200793          	li	a5,66
    80001300:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001304:	00000073          	ecall


    80001308:	00813403          	ld	s0,8(sp)
    8000130c:	01010113          	addi	sp,sp,16
    80001310:	00008067          	ret

0000000080001314 <_ZN7_thread13threadWrapperEv>:

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    80001314:	ff010113          	addi	sp,sp,-16
    80001318:	00113423          	sd	ra,8(sp)
    8000131c:	00813023          	sd	s0,0(sp)
    80001320:	01010413          	addi	s0,sp,16

    Riscv::popSppSpie();
    80001324:	00000097          	auipc	ra,0x0
    80001328:	7dc080e7          	jalr	2012(ra) # 80001b00 <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) thread_dispatch();
    8000132c:	00009797          	auipc	a5,0x9
    80001330:	cb47b783          	ld	a5,-844(a5) # 80009fe0 <_ZN7_thread7runningE>

    static int exitThread();

    void setStart(bool b);

    bool isStarted() const { return started; }
    80001334:	0297c703          	lbu	a4,41(a5)
    80001338:	00071863          	bnez	a4,80001348 <_ZN7_thread13threadWrapperEv+0x34>
    8000133c:	00000097          	auipc	ra,0x0
    80001340:	eb4080e7          	jalr	-332(ra) # 800011f0 <_Z15thread_dispatchv>
    80001344:	fe9ff06f          	j	8000132c <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    80001348:	0007b703          	ld	a4,0(a5)
    8000134c:	0087b503          	ld	a0,8(a5)
    80001350:	000700e7          	jalr	a4
    thread_exit();
    80001354:	00000097          	auipc	ra,0x0
    80001358:	e70080e7          	jalr	-400(ra) # 800011c4 <_Z11thread_exitv>
}
    8000135c:	00813083          	ld	ra,8(sp)
    80001360:	00013403          	ld	s0,0(sp)
    80001364:	01010113          	addi	sp,sp,16
    80001368:	00008067          	ret

000000008000136c <_ZN7_thread12createThreadEPFvPvES0_>:
{
    8000136c:	fd010113          	addi	sp,sp,-48
    80001370:	02113423          	sd	ra,40(sp)
    80001374:	02813023          	sd	s0,32(sp)
    80001378:	00913c23          	sd	s1,24(sp)
    8000137c:	01213823          	sd	s2,16(sp)
    80001380:	01313423          	sd	s3,8(sp)
    80001384:	03010413          	addi	s0,sp,48
    80001388:	00050913          	mv	s2,a0
    8000138c:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    80001390:	03000513          	li	a0,48
    80001394:	00000097          	auipc	ra,0x0
    80001398:	3e0080e7          	jalr	992(ra) # 80001774 <_Znwm>
    8000139c:	00050493          	mv	s1,a0
                (uint64) &threadWrapper,
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true),
            blocked(false)
    800013a0:	01253023          	sd	s2,0(a0)
    800013a4:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    800013a8:	00090a63          	beqz	s2,800013bc <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    800013ac:	00008537          	lui	a0,0x8
    800013b0:	00000097          	auipc	ra,0x0
    800013b4:	3ec080e7          	jalr	1004(ra) # 8000179c <_Znam>
    800013b8:	0080006f          	j	800013c0 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    800013bc:	00000513          	li	a0,0
            blocked(false)
    800013c0:	00a4b823          	sd	a0,16(s1)
    800013c4:	00000797          	auipc	a5,0x0
    800013c8:	f5078793          	addi	a5,a5,-176 # 80001314 <_ZN7_thread13threadWrapperEv>
    800013cc:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    800013d0:	02050a63          	beqz	a0,80001404 <_ZN7_thread12createThreadEPFvPvES0_+0x98>
    800013d4:	000087b7          	lui	a5,0x8
    800013d8:	00f507b3          	add	a5,a0,a5
            blocked(false)
    800013dc:	02f4b023          	sd	a5,32(s1)
    800013e0:	02048423          	sb	zero,40(s1)
    800013e4:	00100793          	li	a5,1
    800013e8:	02f484a3          	sb	a5,41(s1)
    800013ec:	02048523          	sb	zero,42(s1)
    {
            if (body != nullptr) { Scheduler::put(this);}
    800013f0:	02090c63          	beqz	s2,80001428 <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
    800013f4:	00048513          	mv	a0,s1
    800013f8:	00001097          	auipc	ra,0x1
    800013fc:	c94080e7          	jalr	-876(ra) # 8000208c <_ZN9Scheduler3putEP7_thread>
    80001400:	0280006f          	j	80001428 <_ZN7_thread12createThreadEPFvPvES0_+0xbc>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001404:	00000793          	li	a5,0
    80001408:	fd5ff06f          	j	800013dc <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    8000140c:	00050913          	mv	s2,a0
    80001410:	00048513          	mv	a0,s1
    80001414:	00000097          	auipc	ra,0x0
    80001418:	3b0080e7          	jalr	944(ra) # 800017c4 <_ZdlPv>
    8000141c:	00090513          	mv	a0,s2
    80001420:	0000a097          	auipc	ra,0xa
    80001424:	ce8080e7          	jalr	-792(ra) # 8000b108 <_Unwind_Resume>
}
    80001428:	00048513          	mv	a0,s1
    8000142c:	02813083          	ld	ra,40(sp)
    80001430:	02013403          	ld	s0,32(sp)
    80001434:	01813483          	ld	s1,24(sp)
    80001438:	01013903          	ld	s2,16(sp)
    8000143c:	00813983          	ld	s3,8(sp)
    80001440:	03010113          	addi	sp,sp,48
    80001444:	00008067          	ret

0000000080001448 <_ZN7_thread8dispatchEv>:
{
    80001448:	fe010113          	addi	sp,sp,-32
    8000144c:	00113c23          	sd	ra,24(sp)
    80001450:	00813823          	sd	s0,16(sp)
    80001454:	00913423          	sd	s1,8(sp)
    80001458:	02010413          	addi	s0,sp,32
    _thread *old = running;
    8000145c:	00009497          	auipc	s1,0x9
    80001460:	b844b483          	ld	s1,-1148(s1) # 80009fe0 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001464:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    80001468:	00079663          	bnez	a5,80001474 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    8000146c:	02a4c783          	lbu	a5,42(s1)
    80001470:	04078263          	beqz	a5,800014b4 <_ZN7_thread8dispatchEv+0x6c>
    running = Scheduler::get();
    80001474:	00001097          	auipc	ra,0x1
    80001478:	bb0080e7          	jalr	-1104(ra) # 80002024 <_ZN9Scheduler3getEv>
    8000147c:	00009797          	auipc	a5,0x9
    80001480:	b6a7b223          	sd	a0,-1180(a5) # 80009fe0 <_ZN7_thread7runningE>
    if (running == nullptr) {
    80001484:	04050063          	beqz	a0,800014c4 <_ZN7_thread8dispatchEv+0x7c>
    _thread::contextSwitch(&old->context, &running->context);
    80001488:	00009597          	auipc	a1,0x9
    8000148c:	b585b583          	ld	a1,-1192(a1) # 80009fe0 <_ZN7_thread7runningE>
    80001490:	01858593          	addi	a1,a1,24
    80001494:	01848513          	addi	a0,s1,24
    80001498:	00000097          	auipc	ra,0x0
    8000149c:	c98080e7          	jalr	-872(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800014a0:	01813083          	ld	ra,24(sp)
    800014a4:	01013403          	ld	s0,16(sp)
    800014a8:	00813483          	ld	s1,8(sp)
    800014ac:	02010113          	addi	sp,sp,32
    800014b0:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    800014b4:	00048513          	mv	a0,s1
    800014b8:	00001097          	auipc	ra,0x1
    800014bc:	bd4080e7          	jalr	-1068(ra) # 8000208c <_ZN9Scheduler3putEP7_thread>
    800014c0:	fb5ff06f          	j	80001474 <_ZN7_thread8dispatchEv+0x2c>
        printString("vratili smo null\n");
    800014c4:	00007517          	auipc	a0,0x7
    800014c8:	b3c50513          	addi	a0,a0,-1220 # 80008000 <kvmincrease+0xe10>
    800014cc:	00003097          	auipc	ra,0x3
    800014d0:	954080e7          	jalr	-1708(ra) # 80003e20 <_Z11printStringPKc>
    800014d4:	fb5ff06f          	j	80001488 <_ZN7_thread8dispatchEv+0x40>

00000000800014d8 <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    800014d8:	ff010113          	addi	sp,sp,-16
    800014dc:	00113423          	sd	ra,8(sp)
    800014e0:	00813023          	sd	s0,0(sp)
    800014e4:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    800014e8:	00009797          	auipc	a5,0x9
    800014ec:	af87b783          	ld	a5,-1288(a5) # 80009fe0 <_ZN7_thread7runningE>
    800014f0:	00100713          	li	a4,1
    800014f4:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    800014f8:	00000097          	auipc	ra,0x0
    800014fc:	cf8080e7          	jalr	-776(ra) # 800011f0 <_Z15thread_dispatchv>
    return 0;
}
    80001500:	00000513          	li	a0,0
    80001504:	00813083          	ld	ra,8(sp)
    80001508:	00013403          	ld	s0,0(sp)
    8000150c:	01010113          	addi	sp,sp,16
    80001510:	00008067          	ret

0000000080001514 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001514:	ff010113          	addi	sp,sp,-16
    80001518:	00813423          	sd	s0,8(sp)
    8000151c:	01010413          	addi	s0,sp,16
    this->started = b;
    80001520:	02b504a3          	sb	a1,41(a0)
}
    80001524:	00813403          	ld	s0,8(sp)
    80001528:	01010113          	addi	sp,sp,16
    8000152c:	00008067          	ret

0000000080001530 <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    80001530:	ff010113          	addi	sp,sp,-16
    80001534:	00813423          	sd	s0,8(sp)
    80001538:	01010413          	addi	s0,sp,16
    this->blocked = b;
    8000153c:	02b50523          	sb	a1,42(a0)
}
    80001540:	00813403          	ld	s0,8(sp)
    80001544:	01010113          	addi	sp,sp,16
    80001548:	00008067          	ret

000000008000154c <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    8000154c:	fe010113          	addi	sp,sp,-32
    80001550:	00113c23          	sd	ra,24(sp)
    80001554:	00813823          	sd	s0,16(sp)
    80001558:	00913423          	sd	s1,8(sp)
    8000155c:	01213023          	sd	s2,0(sp)
    80001560:	02010413          	addi	s0,sp,32


    printString("Unesite broj testa? [1-7]\n");
    80001564:	00007517          	auipc	a0,0x7
    80001568:	ab450513          	addi	a0,a0,-1356 # 80008018 <kvmincrease+0xe28>
    8000156c:	00003097          	auipc	ra,0x3
    80001570:	8b4080e7          	jalr	-1868(ra) # 80003e20 <_Z11printStringPKc>
    int test = getc() - '0';
    80001574:	00000097          	auipc	ra,0x0
    80001578:	d50080e7          	jalr	-688(ra) # 800012c4 <_Z4getcv>
    8000157c:	00050913          	mv	s2,a0
    80001580:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001584:	00000097          	auipc	ra,0x0
    80001588:	d40080e7          	jalr	-704(ra) # 800012c4 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    8000158c:	fcb9091b          	addiw	s2,s2,-53
    80001590:	00100793          	li	a5,1
    80001594:	0327f463          	bgeu	a5,s2,800015bc <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001598:	00700793          	li	a5,7
    8000159c:	0e97e263          	bltu	a5,s1,80001680 <_Z8userMainv+0x134>
    800015a0:	00249493          	slli	s1,s1,0x2
    800015a4:	00007717          	auipc	a4,0x7
    800015a8:	c8c70713          	addi	a4,a4,-884 # 80008230 <kvmincrease+0x1040>
    800015ac:	00e484b3          	add	s1,s1,a4
    800015b0:	0004a783          	lw	a5,0(s1)
    800015b4:	00e787b3          	add	a5,a5,a4
    800015b8:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    800015bc:	00007517          	auipc	a0,0x7
    800015c0:	a7c50513          	addi	a0,a0,-1412 # 80008038 <kvmincrease+0xe48>
    800015c4:	00003097          	auipc	ra,0x3
    800015c8:	85c080e7          	jalr	-1956(ra) # 80003e20 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800015cc:	01813083          	ld	ra,24(sp)
    800015d0:	01013403          	ld	s0,16(sp)
    800015d4:	00813483          	ld	s1,8(sp)
    800015d8:	00013903          	ld	s2,0(sp)
    800015dc:	02010113          	addi	sp,sp,32
    800015e0:	00008067          	ret
            Threads_C_API_test();
    800015e4:	00002097          	auipc	ra,0x2
    800015e8:	eb4080e7          	jalr	-332(ra) # 80003498 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800015ec:	00007517          	auipc	a0,0x7
    800015f0:	a7c50513          	addi	a0,a0,-1412 # 80008068 <kvmincrease+0xe78>
    800015f4:	00003097          	auipc	ra,0x3
    800015f8:	82c080e7          	jalr	-2004(ra) # 80003e20 <_Z11printStringPKc>
            break;
    800015fc:	fd1ff06f          	j	800015cc <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001600:	00001097          	auipc	ra,0x1
    80001604:	4fc080e7          	jalr	1276(ra) # 80002afc <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001608:	00007517          	auipc	a0,0x7
    8000160c:	aa050513          	addi	a0,a0,-1376 # 800080a8 <kvmincrease+0xeb8>
    80001610:	00003097          	auipc	ra,0x3
    80001614:	810080e7          	jalr	-2032(ra) # 80003e20 <_Z11printStringPKc>
            break;
    80001618:	fb5ff06f          	j	800015cc <_Z8userMainv+0x80>
            producerConsumer_C_API();
    8000161c:	00001097          	auipc	ra,0x1
    80001620:	d34080e7          	jalr	-716(ra) # 80002350 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001624:	00007517          	auipc	a0,0x7
    80001628:	ac450513          	addi	a0,a0,-1340 # 800080e8 <kvmincrease+0xef8>
    8000162c:	00002097          	auipc	ra,0x2
    80001630:	7f4080e7          	jalr	2036(ra) # 80003e20 <_Z11printStringPKc>
            break;
    80001634:	f99ff06f          	j	800015cc <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001638:	00002097          	auipc	ra,0x2
    8000163c:	1a4080e7          	jalr	420(ra) # 800037dc <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001640:	00007517          	auipc	a0,0x7
    80001644:	af850513          	addi	a0,a0,-1288 # 80008138 <kvmincrease+0xf48>
    80001648:	00002097          	auipc	ra,0x2
    8000164c:	7d8080e7          	jalr	2008(ra) # 80003e20 <_Z11printStringPKc>
            break;
    80001650:	f7dff06f          	j	800015cc <_Z8userMainv+0x80>
            System_Mode_test();
    80001654:	00003097          	auipc	ra,0x3
    80001658:	380080e7          	jalr	896(ra) # 800049d4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    8000165c:	00007517          	auipc	a0,0x7
    80001660:	b3450513          	addi	a0,a0,-1228 # 80008190 <kvmincrease+0xfa0>
    80001664:	00002097          	auipc	ra,0x2
    80001668:	7bc080e7          	jalr	1980(ra) # 80003e20 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    8000166c:	00007517          	auipc	a0,0x7
    80001670:	b4450513          	addi	a0,a0,-1212 # 800081b0 <kvmincrease+0xfc0>
    80001674:	00002097          	auipc	ra,0x2
    80001678:	7ac080e7          	jalr	1964(ra) # 80003e20 <_Z11printStringPKc>
            break;
    8000167c:	f51ff06f          	j	800015cc <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001680:	00007517          	auipc	a0,0x7
    80001684:	b8850513          	addi	a0,a0,-1144 # 80008208 <kvmincrease+0x1018>
    80001688:	00002097          	auipc	ra,0x2
    8000168c:	798080e7          	jalr	1944(ra) # 80003e20 <_Z11printStringPKc>
    80001690:	f3dff06f          	j	800015cc <_Z8userMainv+0x80>

0000000080001694 <_Z15userMainWrapperPv>:
#include "../h/riscv.hpp"
#include "../h/_thread.hpp"

extern void userMain();

void userMainWrapper(void* arg){
    80001694:	ff010113          	addi	sp,sp,-16
    80001698:	00113423          	sd	ra,8(sp)
    8000169c:	00813023          	sd	s0,0(sp)
    800016a0:	01010413          	addi	s0,sp,16
    userMain();
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	ea8080e7          	jalr	-344(ra) # 8000154c <_Z8userMainv>
}
    800016ac:	00813083          	ld	ra,8(sp)
    800016b0:	00013403          	ld	s0,0(sp)
    800016b4:	01010113          	addi	sp,sp,16
    800016b8:	00008067          	ret

00000000800016bc <main>:

void main()
{
    800016bc:	fe010113          	addi	sp,sp,-32
    800016c0:	00113c23          	sd	ra,24(sp)
    800016c4:	00813823          	sd	s0,16(sp)
    800016c8:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800016cc:	00009797          	auipc	a5,0x9
    800016d0:	8b47b783          	ld	a5,-1868(a5) # 80009f80 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800016d4:	10579073          	csrw	stvec,a5
    // memorija inicijalizacija

    // idle nit
    thread_t idleThread = nullptr;
    800016d8:	fe043423          	sd	zero,-24(s0)
    thread_create(&idleThread, nullptr, nullptr);
    800016dc:	00000613          	li	a2,0
    800016e0:	00000593          	li	a1,0
    800016e4:	fe840513          	addi	a0,s0,-24
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	ab0080e7          	jalr	-1360(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    800016f0:	00009797          	auipc	a5,0x9
    800016f4:	8887b783          	ld	a5,-1912(a5) # 80009f78 <_GLOBAL_OFFSET_TABLE_+0x8>
    800016f8:	fe843703          	ld	a4,-24(s0)
    800016fc:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001700:	00200793          	li	a5,2
    80001704:	1007a073          	csrs	sstatus,a5
    static void setUserMode(bool b) {userMode = b;}
    80001708:	00009797          	auipc	a5,0x9
    8000170c:	8887b783          	ld	a5,-1912(a5) # 80009f90 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001710:	00100713          	li	a4,1
    80001714:	00e78023          	sb	a4,0(a5)
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    Riscv::setUserMode(true);

    uint8 userCode = 0x0;
    WRITE_REG("a7", userCode);
    80001718:	00000793          	li	a5,0
    8000171c:	00078893          	mv	a7,a5
    __asm__ volatile("ecall");
    80001720:	00000073          	ecall

    thread_t userThread;
    thread_create(&userThread, &userMainWrapper, nullptr);
    80001724:	00000613          	li	a2,0
    80001728:	00000597          	auipc	a1,0x0
    8000172c:	f6c58593          	addi	a1,a1,-148 # 80001694 <_Z15userMainWrapperPv>
    80001730:	fe040513          	addi	a0,s0,-32
    80001734:	00000097          	auipc	ra,0x0
    80001738:	a64080e7          	jalr	-1436(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    while (!userThread->isFinished()) thread_dispatch();
    8000173c:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001740:	0287c783          	lbu	a5,40(a5)
    80001744:	00079863          	bnez	a5,80001754 <main+0x98>
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	aa8080e7          	jalr	-1368(ra) # 800011f0 <_Z15thread_dispatchv>
    80001750:	fedff06f          	j	8000173c <main+0x80>

    printString("FINISHED!\n");
    80001754:	00007517          	auipc	a0,0x7
    80001758:	afc50513          	addi	a0,a0,-1284 # 80008250 <kvmincrease+0x1060>
    8000175c:	00002097          	auipc	ra,0x2
    80001760:	6c4080e7          	jalr	1732(ra) # 80003e20 <_Z11printStringPKc>
}
    80001764:	01813083          	ld	ra,24(sp)
    80001768:	01013403          	ld	s0,16(sp)
    8000176c:	02010113          	addi	sp,sp,32
    80001770:	00008067          	ret

0000000080001774 <_Znwm>:

#include "../h/syscall_cpp.hpp"


void *operator new(size_t n)
{
    80001774:	ff010113          	addi	sp,sp,-16
    80001778:	00113423          	sd	ra,8(sp)
    8000177c:	00813023          	sd	s0,0(sp)
    80001780:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001784:	00000097          	auipc	ra,0x0
    80001788:	9c0080e7          	jalr	-1600(ra) # 80001144 <_Z9mem_allocm>
}
    8000178c:	00813083          	ld	ra,8(sp)
    80001790:	00013403          	ld	s0,0(sp)
    80001794:	01010113          	addi	sp,sp,16
    80001798:	00008067          	ret

000000008000179c <_Znam>:

void *operator new[](size_t n)
{
    8000179c:	ff010113          	addi	sp,sp,-16
    800017a0:	00113423          	sd	ra,8(sp)
    800017a4:	00813023          	sd	s0,0(sp)
    800017a8:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800017ac:	00000097          	auipc	ra,0x0
    800017b0:	998080e7          	jalr	-1640(ra) # 80001144 <_Z9mem_allocm>
}
    800017b4:	00813083          	ld	ra,8(sp)
    800017b8:	00013403          	ld	s0,0(sp)
    800017bc:	01010113          	addi	sp,sp,16
    800017c0:	00008067          	ret

00000000800017c4 <_ZdlPv>:

void operator delete(void *p)
{
    800017c4:	ff010113          	addi	sp,sp,-16
    800017c8:	00113423          	sd	ra,8(sp)
    800017cc:	00813023          	sd	s0,0(sp)
    800017d0:	01010413          	addi	s0,sp,16
    mem_free(p);
    800017d4:	00000097          	auipc	ra,0x0
    800017d8:	998080e7          	jalr	-1640(ra) # 8000116c <_Z8mem_freePv>
}
    800017dc:	00813083          	ld	ra,8(sp)
    800017e0:	00013403          	ld	s0,0(sp)
    800017e4:	01010113          	addi	sp,sp,16
    800017e8:	00008067          	ret

00000000800017ec <_ZdaPv>:

void operator delete[](void *p)
{
    800017ec:	ff010113          	addi	sp,sp,-16
    800017f0:	00113423          	sd	ra,8(sp)
    800017f4:	00813023          	sd	s0,0(sp)
    800017f8:	01010413          	addi	s0,sp,16
    mem_free(p);
    800017fc:	00000097          	auipc	ra,0x0
    80001800:	970080e7          	jalr	-1680(ra) # 8000116c <_Z8mem_freePv>
}
    80001804:	00813083          	ld	ra,8(sp)
    80001808:	00013403          	ld	s0,0(sp)
    8000180c:	01010113          	addi	sp,sp,16
    80001810:	00008067          	ret

0000000080001814 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    80001814:	ff010113          	addi	sp,sp,-16
    80001818:	00813423          	sd	s0,8(sp)
    8000181c:	01010413          	addi	s0,sp,16

}
    80001820:	00813403          	ld	s0,8(sp)
    80001824:	01010113          	addi	sp,sp,16
    80001828:	00008067          	ret

000000008000182c <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    8000182c:	ff010113          	addi	sp,sp,-16
    80001830:	00113423          	sd	ra,8(sp)
    80001834:	00813023          	sd	s0,0(sp)
    80001838:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    8000183c:	00053783          	ld	a5,0(a0)
    80001840:	0107b783          	ld	a5,16(a5)
    80001844:	000780e7          	jalr	a5
}
    80001848:	00813083          	ld	ra,8(sp)
    8000184c:	00013403          	ld	s0,0(sp)
    80001850:	01010113          	addi	sp,sp,16
    80001854:	00008067          	ret

0000000080001858 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001858:	ff010113          	addi	sp,sp,-16
    8000185c:	00113423          	sd	ra,8(sp)
    80001860:	00813023          	sd	s0,0(sp)
    80001864:	01010413          	addi	s0,sp,16
}
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	f5c080e7          	jalr	-164(ra) # 800017c4 <_ZdlPv>
    80001870:	00813083          	ld	ra,8(sp)
    80001874:	00013403          	ld	s0,0(sp)
    80001878:	01010113          	addi	sp,sp,16
    8000187c:	00008067          	ret

0000000080001880 <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00113423          	sd	ra,8(sp)
    80001888:	00813023          	sd	s0,0(sp)
    8000188c:	01010413          	addi	s0,sp,16
    80001890:	00008797          	auipc	a5,0x8
    80001894:	5a078793          	addi	a5,a5,1440 # 80009e30 <_ZTV9Semaphore+0x10>
    80001898:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    8000189c:	00853503          	ld	a0,8(a0)
    800018a0:	00000097          	auipc	ra,0x0
    800018a4:	9a0080e7          	jalr	-1632(ra) # 80001240 <_Z9sem_closeP4_sem>

}
    800018a8:	00813083          	ld	ra,8(sp)
    800018ac:	00013403          	ld	s0,0(sp)
    800018b0:	01010113          	addi	sp,sp,16
    800018b4:	00008067          	ret

00000000800018b8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    800018b8:	fe010113          	addi	sp,sp,-32
    800018bc:	00113c23          	sd	ra,24(sp)
    800018c0:	00813823          	sd	s0,16(sp)
    800018c4:	00913423          	sd	s1,8(sp)
    800018c8:	02010413          	addi	s0,sp,32
    800018cc:	00050493          	mv	s1,a0
}
    800018d0:	00000097          	auipc	ra,0x0
    800018d4:	fb0080e7          	jalr	-80(ra) # 80001880 <_ZN9SemaphoreD1Ev>
    800018d8:	00048513          	mv	a0,s1
    800018dc:	00000097          	auipc	ra,0x0
    800018e0:	ee8080e7          	jalr	-280(ra) # 800017c4 <_ZdlPv>
    800018e4:	01813083          	ld	ra,24(sp)
    800018e8:	01013403          	ld	s0,16(sp)
    800018ec:	00813483          	ld	s1,8(sp)
    800018f0:	02010113          	addi	sp,sp,32
    800018f4:	00008067          	ret

00000000800018f8 <_ZN7Console4getcEv>:
char Console::getc() {
    800018f8:	ff010113          	addi	sp,sp,-16
    800018fc:	00113423          	sd	ra,8(sp)
    80001900:	00813023          	sd	s0,0(sp)
    80001904:	01010413          	addi	s0,sp,16
    return __getc();
    80001908:	00006097          	auipc	ra,0x6
    8000190c:	804080e7          	jalr	-2044(ra) # 8000710c <__getc>
}
    80001910:	00813083          	ld	ra,8(sp)
    80001914:	00013403          	ld	s0,0(sp)
    80001918:	01010113          	addi	sp,sp,16
    8000191c:	00008067          	ret

0000000080001920 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80001920:	ff010113          	addi	sp,sp,-16
    80001924:	00113423          	sd	ra,8(sp)
    80001928:	00813023          	sd	s0,0(sp)
    8000192c:	01010413          	addi	s0,sp,16
    __putc(c);
    80001930:	00005097          	auipc	ra,0x5
    80001934:	7a0080e7          	jalr	1952(ra) # 800070d0 <__putc>
}
    80001938:	00813083          	ld	ra,8(sp)
    8000193c:	00013403          	ld	s0,0(sp)
    80001940:	01010113          	addi	sp,sp,16
    80001944:	00008067          	ret

0000000080001948 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    80001948:	fe010113          	addi	sp,sp,-32
    8000194c:	00113c23          	sd	ra,24(sp)
    80001950:	00813823          	sd	s0,16(sp)
    80001954:	00913423          	sd	s1,8(sp)
    80001958:	02010413          	addi	s0,sp,32
    8000195c:	00050493          	mv	s1,a0
    80001960:	00008797          	auipc	a5,0x8
    80001964:	4a878793          	addi	a5,a5,1192 # 80009e08 <_ZTV6Thread+0x10>
    80001968:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    8000196c:	00850513          	addi	a0,a0,8
    80001970:	00000097          	auipc	ra,0x0
    80001974:	828080e7          	jalr	-2008(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001978:	00000593          	li	a1,0
    8000197c:	0084b503          	ld	a0,8(s1)
    80001980:	00000097          	auipc	ra,0x0
    80001984:	b94080e7          	jalr	-1132(ra) # 80001514 <_ZN7_thread8setStartEb>
}
    80001988:	01813083          	ld	ra,24(sp)
    8000198c:	01013403          	ld	s0,16(sp)
    80001990:	00813483          	ld	s1,8(sp)
    80001994:	02010113          	addi	sp,sp,32
    80001998:	00008067          	ret

000000008000199c <_ZN6Thread5startEv>:
int Thread::start() {
    8000199c:	ff010113          	addi	sp,sp,-16
    800019a0:	00113423          	sd	ra,8(sp)
    800019a4:	00813023          	sd	s0,0(sp)
    800019a8:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    800019ac:	00100593          	li	a1,1
    800019b0:	00853503          	ld	a0,8(a0)
    800019b4:	00000097          	auipc	ra,0x0
    800019b8:	b60080e7          	jalr	-1184(ra) # 80001514 <_ZN7_thread8setStartEb>
}
    800019bc:	00000513          	li	a0,0
    800019c0:	00813083          	ld	ra,8(sp)
    800019c4:	00013403          	ld	s0,0(sp)
    800019c8:	01010113          	addi	sp,sp,16
    800019cc:	00008067          	ret

00000000800019d0 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    800019d0:	ff010113          	addi	sp,sp,-16
    800019d4:	00113423          	sd	ra,8(sp)
    800019d8:	00813023          	sd	s0,0(sp)
    800019dc:	01010413          	addi	s0,sp,16
    thread_dispatch();
    800019e0:	00000097          	auipc	ra,0x0
    800019e4:	810080e7          	jalr	-2032(ra) # 800011f0 <_Z15thread_dispatchv>
}
    800019e8:	00813083          	ld	ra,8(sp)
    800019ec:	00013403          	ld	s0,0(sp)
    800019f0:	01010113          	addi	sp,sp,16
    800019f4:	00008067          	ret

00000000800019f8 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    800019f8:	fe010113          	addi	sp,sp,-32
    800019fc:	00113c23          	sd	ra,24(sp)
    80001a00:	00813823          	sd	s0,16(sp)
    80001a04:	00913423          	sd	s1,8(sp)
    80001a08:	02010413          	addi	s0,sp,32
    80001a0c:	00050493          	mv	s1,a0
    80001a10:	00008797          	auipc	a5,0x8
    80001a14:	3f878793          	addi	a5,a5,1016 # 80009e08 <_ZTV6Thread+0x10>
    80001a18:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    80001a1c:	00050613          	mv	a2,a0
    80001a20:	00000597          	auipc	a1,0x0
    80001a24:	e0c58593          	addi	a1,a1,-500 # 8000182c <_ZN6Thread12startWrapperEPv>
    80001a28:	00850513          	addi	a0,a0,8
    80001a2c:	fffff097          	auipc	ra,0xfffff
    80001a30:	76c080e7          	jalr	1900(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001a34:	00000593          	li	a1,0
    80001a38:	0084b503          	ld	a0,8(s1)
    80001a3c:	00000097          	auipc	ra,0x0
    80001a40:	ad8080e7          	jalr	-1320(ra) # 80001514 <_ZN7_thread8setStartEb>
}
    80001a44:	01813083          	ld	ra,24(sp)
    80001a48:	01013403          	ld	s0,16(sp)
    80001a4c:	00813483          	ld	s1,8(sp)
    80001a50:	02010113          	addi	sp,sp,32
    80001a54:	00008067          	ret

0000000080001a58 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80001a58:	ff010113          	addi	sp,sp,-16
    80001a5c:	00113423          	sd	ra,8(sp)
    80001a60:	00813023          	sd	s0,0(sp)
    80001a64:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001a68:	00853503          	ld	a0,8(a0)
    80001a6c:	00000097          	auipc	ra,0x0
    80001a70:	800080e7          	jalr	-2048(ra) # 8000126c <_Z8sem_waitP4_sem>
}
    80001a74:	00813083          	ld	ra,8(sp)
    80001a78:	00013403          	ld	s0,0(sp)
    80001a7c:	01010113          	addi	sp,sp,16
    80001a80:	00008067          	ret

0000000080001a84 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001a84:	ff010113          	addi	sp,sp,-16
    80001a88:	00113423          	sd	ra,8(sp)
    80001a8c:	00813023          	sd	s0,0(sp)
    80001a90:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001a94:	00853503          	ld	a0,8(a0)
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	800080e7          	jalr	-2048(ra) # 80001298 <_Z10sem_signalP4_sem>
}
    80001aa0:	00813083          	ld	ra,8(sp)
    80001aa4:	00013403          	ld	s0,0(sp)
    80001aa8:	01010113          	addi	sp,sp,16
    80001aac:	00008067          	ret

0000000080001ab0 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001ab0:	ff010113          	addi	sp,sp,-16
    80001ab4:	00113423          	sd	ra,8(sp)
    80001ab8:	00813023          	sd	s0,0(sp)
    80001abc:	01010413          	addi	s0,sp,16
    80001ac0:	00008797          	auipc	a5,0x8
    80001ac4:	37078793          	addi	a5,a5,880 # 80009e30 <_ZTV9Semaphore+0x10>
    80001ac8:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001acc:	00850513          	addi	a0,a0,8
    80001ad0:	fffff097          	auipc	ra,0xfffff
    80001ad4:	744080e7          	jalr	1860(ra) # 80001214 <_Z8sem_openPP4_semj>
}
    80001ad8:	00813083          	ld	ra,8(sp)
    80001adc:	00013403          	ld	s0,0(sp)
    80001ae0:	01010113          	addi	sp,sp,16
    80001ae4:	00008067          	ret

0000000080001ae8 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001ae8:	ff010113          	addi	sp,sp,-16
    80001aec:	00813423          	sd	s0,8(sp)
    80001af0:	01010413          	addi	s0,sp,16
    80001af4:	00813403          	ld	s0,8(sp)
    80001af8:	01010113          	addi	sp,sp,16
    80001afc:	00008067          	ret

0000000080001b00 <_ZN5Riscv10popSppSpieEv>:
using namespace Num;
bool Riscv::userMode = false;


void Riscv::popSppSpie()
{
    80001b00:	ff010113          	addi	sp,sp,-16
    80001b04:	00813423          	sd	s0,8(sp)
    80001b08:	01010413          	addi	s0,sp,16
    if (userMode) mc_sstatus(SSTATUS_SPP);
    80001b0c:	00008797          	auipc	a5,0x8
    80001b10:	4dc7c783          	lbu	a5,1244(a5) # 80009fe8 <_ZN5Riscv8userModeE>
    80001b14:	02078063          	beqz	a5,80001b34 <_ZN5Riscv10popSppSpieEv+0x34>
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001b18:	10000793          	li	a5,256
    80001b1c:	1007b073          	csrc	sstatus,a5
    else ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    80001b20:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001b24:	10200073          	sret

}
    80001b28:	00813403          	ld	s0,8(sp)
    80001b2c:	01010113          	addi	sp,sp,16
    80001b30:	00008067          	ret
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001b34:	10000793          	li	a5,256
    80001b38:	1007a073          	csrs	sstatus,a5
}
    80001b3c:	fe5ff06f          	j	80001b20 <_ZN5Riscv10popSppSpieEv+0x20>

0000000080001b40 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001b40:	fa010113          	addi	sp,sp,-96
    80001b44:	04113c23          	sd	ra,88(sp)
    80001b48:	04813823          	sd	s0,80(sp)
    80001b4c:	04913423          	sd	s1,72(sp)
    80001b50:	06010413          	addi	s0,sp,96
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001b54:	142027f3          	csrr	a5,scause
    80001b58:	faf43c23          	sd	a5,-72(s0)
    return scause;
    80001b5c:	fb843783          	ld	a5,-72(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001b60:	fff00713          	li	a4,-1
    80001b64:	03f71713          	slli	a4,a4,0x3f
    80001b68:	00170713          	addi	a4,a4,1
    80001b6c:	18e78063          	beq	a5,a4,80001cec <_ZN5Riscv20handleSupervisorTrapEv+0x1ac>
    80001b70:	fff00713          	li	a4,-1
    80001b74:	03f71713          	slli	a4,a4,0x3f
    80001b78:	00170713          	addi	a4,a4,1
    80001b7c:	04f76e63          	bltu	a4,a5,80001bd8 <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    80001b80:	ff878793          	addi	a5,a5,-8
    80001b84:	00100713          	li	a4,1
    80001b88:	18f76063          	bltu	a4,a5,80001d08 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001b8c:	141027f3          	csrr	a5,sepc
    80001b90:	fcf43423          	sd	a5,-56(s0)
    return sepc;
    80001b94:	fc843783          	ld	a5,-56(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 volatile sepc = r_sepc() + 4;
    80001b98:	00478793          	addi	a5,a5,4
    80001b9c:	faf43423          	sd	a5,-88(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001ba0:	100027f3          	csrr	a5,sstatus
    80001ba4:	fcf43023          	sd	a5,-64(s0)
    return sstatus;
    80001ba8:	fc043783          	ld	a5,-64(s0)
            uint64 volatile sstatus = r_sstatus();
    80001bac:	faf43823          	sd	a5,-80(s0)
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001bb0:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001bb4:	04200713          	li	a4,66
    80001bb8:	04f76463          	bltu	a4,a5,80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
    80001bbc:	00279793          	slli	a5,a5,0x2
    80001bc0:	00006717          	auipc	a4,0x6
    80001bc4:	6c870713          	addi	a4,a4,1736 # 80008288 <kvmincrease+0x1098>
    80001bc8:	00e787b3          	add	a5,a5,a4
    80001bcc:	0007a783          	lw	a5,0(a5)
    80001bd0:	00e787b3          	add	a5,a5,a4
    80001bd4:	00078067          	jr	a5
    switch((uint64)scause){
    80001bd8:	fff00713          	li	a4,-1
    80001bdc:	03f71713          	slli	a4,a4,0x3f
    80001be0:	00970713          	addi	a4,a4,9
    80001be4:	12e79263          	bne	a5,a4,80001d08 <_ZN5Riscv20handleSupervisorTrapEv+0x1c8>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001be8:	00005097          	auipc	ra,0x5
    80001bec:	55c080e7          	jalr	1372(ra) # 80007144 <console_handler>
            break;
    80001bf0:	1040006f          	j	80001cf4 <_ZN5Riscv20handleSupervisorTrapEv+0x1b4>
                    READ_REG(size, "a0");
    80001bf4:	00050513          	mv	a0,a0
                    __mem_alloc(size);
    80001bf8:	00005097          	auipc	ra,0x5
    80001bfc:	380080e7          	jalr	896(ra) # 80006f78 <__mem_alloc>
            w_sstatus(sstatus);
    80001c00:	fb043783          	ld	a5,-80(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001c04:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    80001c08:	fa843783          	ld	a5,-88(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001c0c:	14179073          	csrw	sepc,a5
}
    80001c10:	0e40006f          	j	80001cf4 <_ZN5Riscv20handleSupervisorTrapEv+0x1b4>
                    READ_REG(ptr, "a0");
    80001c14:	00050513          	mv	a0,a0
                    __mem_free(ptr);
    80001c18:	00005097          	auipc	ra,0x5
    80001c1c:	294080e7          	jalr	660(ra) # 80006eac <__mem_free>
                    break;
    80001c20:	fe1ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(handle, "a0");
    80001c24:	00050493          	mv	s1,a0
                    READ_REG(body, "a1");
    80001c28:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001c2c:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001c30:	fffff097          	auipc	ra,0xfffff
    80001c34:	73c080e7          	jalr	1852(ra) # 8000136c <_ZN7_thread12createThreadEPFvPvES0_>
    80001c38:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001c3c:	00050863          	beqz	a0,80001c4c <_ZN5Riscv20handleSupervisorTrapEv+0x10c>
    80001c40:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001c44:	00078513          	mv	a0,a5
                    break;
    80001c48:	fb9ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    else ret = -1;
    80001c4c:	fff00793          	li	a5,-1
    80001c50:	ff5ff06f          	j	80001c44 <_ZN5Riscv20handleSupervisorTrapEv+0x104>
                    _thread::exitThread();
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	884080e7          	jalr	-1916(ra) # 800014d8 <_ZN7_thread10exitThreadEv>
                    break;
    80001c5c:	fa5ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    _thread::dispatch();
    80001c60:	fffff097          	auipc	ra,0xfffff
    80001c64:	7e8080e7          	jalr	2024(ra) # 80001448 <_ZN7_thread8dispatchEv>
                    break;
    80001c68:	f99ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(handle, "a0");
    80001c6c:	00050493          	mv	s1,a0
                    READ_REG(init, "a1");
    80001c70:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001c74:	0005051b          	sext.w	a0,a0
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	26c080e7          	jalr	620(ra) # 80001ee4 <_ZN4_sem15createSemaphoreEj>
    80001c80:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001c84:	00050863          	beqz	a0,80001c94 <_ZN5Riscv20handleSupervisorTrapEv+0x154>
    80001c88:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001c8c:	00078513          	mv	a0,a5
                    break;
    80001c90:	f71ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    else ret = -1;
    80001c94:	fff00793          	li	a5,-1
    80001c98:	ff5ff06f          	j	80001c8c <_ZN5Riscv20handleSupervisorTrapEv+0x14c>
                    READ_REG(handleClose, "a0");
    80001c9c:	00050513          	mv	a0,a0
                    handleClose->close();
    80001ca0:	00000097          	auipc	ra,0x0
    80001ca4:	2ac080e7          	jalr	684(ra) # 80001f4c <_ZN4_sem5closeEv>
                    break;
    80001ca8:	f59ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(idWait, "a0");
    80001cac:	00050513          	mv	a0,a0
                    idWait->wait();
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	0cc080e7          	jalr	204(ra) # 80001d7c <_ZN4_sem4waitEv>
                    break;
    80001cb8:	f49ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(idSignal, "a0");
    80001cbc:	00050513          	mv	a0,a0
                    idSignal->signal();
    80001cc0:	00000097          	auipc	ra,0x0
    80001cc4:	170080e7          	jalr	368(ra) # 80001e30 <_ZN4_sem6signalEv>
                    break;
    80001cc8:	f39ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    __getc();
    80001ccc:	00005097          	auipc	ra,0x5
    80001cd0:	440080e7          	jalr	1088(ra) # 8000710c <__getc>
                    break;
    80001cd4:	f2dff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(c, "a0");
    80001cd8:	00050513          	mv	a0,a0
                    __putc(c);
    80001cdc:	0ff57513          	andi	a0,a0,255
    80001ce0:	00005097          	auipc	ra,0x5
    80001ce4:	3f0080e7          	jalr	1008(ra) # 800070d0 <__putc>
                    break;
    80001ce8:	f19ff06f          	j	80001c00 <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001cec:	00200793          	li	a5,2
    80001cf0:	1447b073          	csrc	sip,a5
            printInt((int)Riscv::r_sepc());
            printString("\n");

            break;
    }
    80001cf4:	05813083          	ld	ra,88(sp)
    80001cf8:	05013403          	ld	s0,80(sp)
    80001cfc:	04813483          	ld	s1,72(sp)
    80001d00:	06010113          	addi	sp,sp,96
    80001d04:	00008067          	ret
            printString("Store access fault: stval=");
    80001d08:	00006517          	auipc	a0,0x6
    80001d0c:	55850513          	addi	a0,a0,1368 # 80008260 <kvmincrease+0x1070>
    80001d10:	00002097          	auipc	ra,0x2
    80001d14:	110080e7          	jalr	272(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    80001d18:	143027f3          	csrr	a5,stval
    80001d1c:	fcf43c23          	sd	a5,-40(s0)
    return stval;
    80001d20:	fd843503          	ld	a0,-40(s0)
            printInt((int)Riscv::r_stval());
    80001d24:	00000613          	li	a2,0
    80001d28:	00a00593          	li	a1,10
    80001d2c:	0005051b          	sext.w	a0,a0
    80001d30:	00002097          	auipc	ra,0x2
    80001d34:	2a0080e7          	jalr	672(ra) # 80003fd0 <_Z8printIntiii>
            printString(" sepc=");
    80001d38:	00006517          	auipc	a0,0x6
    80001d3c:	54850513          	addi	a0,a0,1352 # 80008280 <kvmincrease+0x1090>
    80001d40:	00002097          	auipc	ra,0x2
    80001d44:	0e0080e7          	jalr	224(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001d48:	141027f3          	csrr	a5,sepc
    80001d4c:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001d50:	fd043503          	ld	a0,-48(s0)
            printInt((int)Riscv::r_sepc());
    80001d54:	00000613          	li	a2,0
    80001d58:	00a00593          	li	a1,10
    80001d5c:	0005051b          	sext.w	a0,a0
    80001d60:	00002097          	auipc	ra,0x2
    80001d64:	270080e7          	jalr	624(ra) # 80003fd0 <_Z8printIntiii>
            printString("\n");
    80001d68:	00006517          	auipc	a0,0x6
    80001d6c:	42050513          	addi	a0,a0,1056 # 80008188 <kvmincrease+0xf98>
    80001d70:	00002097          	auipc	ra,0x2
    80001d74:	0b0080e7          	jalr	176(ra) # 80003e20 <_Z11printStringPKc>
    80001d78:	f7dff06f          	j	80001cf4 <_ZN5Riscv20handleSupervisorTrapEv+0x1b4>

0000000080001d7c <_ZN4_sem4waitEv>:
    int value() const { return val; }
    void setWaitStatus(int s) { waitStatus = s;}
    int getWaitStatus() const { return waitStatus;}

    void setClosed(bool b);
    bool isClosed() const {return closed;}
    80001d7c:	00854783          	lbu	a5,8(a0)

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (isClosed()) return -1;
    80001d80:	0a079463          	bnez	a5,80001e28 <_ZN4_sem4waitEv+0xac>
int _sem::wait() {
    80001d84:	fe010113          	addi	sp,sp,-32
    80001d88:	00113c23          	sd	ra,24(sp)
    80001d8c:	00813823          	sd	s0,16(sp)
    80001d90:	00913423          	sd	s1,8(sp)
    80001d94:	01213023          	sd	s2,0(sp)
    80001d98:	02010413          	addi	s0,sp,32
    80001d9c:	00050493          	mv	s1,a0
    if (--val < 0){
    80001da0:	00052783          	lw	a5,0(a0)
    80001da4:	fff7879b          	addiw	a5,a5,-1
    80001da8:	00f52023          	sw	a5,0(a0)
    80001dac:	02079713          	slli	a4,a5,0x20
    80001db0:	02074063          	bltz	a4,80001dd0 <_ZN4_sem4waitEv+0x54>
    int getWaitStatus() const { return waitStatus;}
    80001db4:	0044a503          	lw	a0,4(s1)
        blocked.addLast(cur);
        thread_dispatch();
    }

    return this->getWaitStatus();
}
    80001db8:	01813083          	ld	ra,24(sp)
    80001dbc:	01013403          	ld	s0,16(sp)
    80001dc0:	00813483          	ld	s1,8(sp)
    80001dc4:	00013903          	ld	s2,0(sp)
    80001dc8:	02010113          	addi	sp,sp,32
    80001dcc:	00008067          	ret
        _thread* cur = _thread::running;
    80001dd0:	00008797          	auipc	a5,0x8
    80001dd4:	1a87b783          	ld	a5,424(a5) # 80009f78 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001dd8:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    80001ddc:	00100593          	li	a1,1
    80001de0:	00090513          	mv	a0,s2
    80001de4:	fffff097          	auipc	ra,0xfffff
    80001de8:	74c080e7          	jalr	1868(ra) # 80001530 <_ZN7_thread8setBlockEb>
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001dec:	01000513          	li	a0,16
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	984080e7          	jalr	-1660(ra) # 80001774 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001df8:	01253023          	sd	s2,0(a0)
    80001dfc:	00053423          	sd	zero,8(a0)
        if (tail)
    80001e00:	0184b783          	ld	a5,24(s1)
    80001e04:	00078c63          	beqz	a5,80001e1c <_ZN4_sem4waitEv+0xa0>
        {
            tail->next = elem;
    80001e08:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001e0c:	00a4bc23          	sd	a0,24(s1)
        thread_dispatch();
    80001e10:	fffff097          	auipc	ra,0xfffff
    80001e14:	3e0080e7          	jalr	992(ra) # 800011f0 <_Z15thread_dispatchv>
    80001e18:	f9dff06f          	j	80001db4 <_ZN4_sem4waitEv+0x38>
        } else
        {
            head = tail = elem;
    80001e1c:	00a4bc23          	sd	a0,24(s1)
    80001e20:	00a4b823          	sd	a0,16(s1)
    80001e24:	fedff06f          	j	80001e10 <_ZN4_sem4waitEv+0x94>
    if (isClosed()) return -1;
    80001e28:	fff00513          	li	a0,-1
}
    80001e2c:	00008067          	ret

0000000080001e30 <_ZN4_sem6signalEv>:
    bool isClosed() const {return closed;}
    80001e30:	00854703          	lbu	a4,8(a0)

int _sem::signal() {
    if (isClosed()) return -1;
    80001e34:	08071c63          	bnez	a4,80001ecc <_ZN4_sem6signalEv+0x9c>
    80001e38:	00050793          	mv	a5,a0
    if(++val <= 0){
    80001e3c:	00052703          	lw	a4,0(a0)
    80001e40:	0017071b          	addiw	a4,a4,1
    80001e44:	0007069b          	sext.w	a3,a4
    80001e48:	00e52023          	sw	a4,0(a0)
    80001e4c:	00d05663          	blez	a3,80001e58 <_ZN4_sem6signalEv+0x28>
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
    80001e50:	00000513          	li	a0,0
    80001e54:	00008067          	ret
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001e58:	01053503          	ld	a0,16(a0)
    80001e5c:	06050c63          	beqz	a0,80001ed4 <_ZN4_sem6signalEv+0xa4>
int _sem::signal() {
    80001e60:	fe010113          	addi	sp,sp,-32
    80001e64:	00113c23          	sd	ra,24(sp)
    80001e68:	00813823          	sd	s0,16(sp)
    80001e6c:	00913423          	sd	s1,8(sp)
    80001e70:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    80001e74:	00853703          	ld	a4,8(a0)
    80001e78:	00e7b823          	sd	a4,16(a5)
        if (!head) { tail = 0; }
    80001e7c:	04070463          	beqz	a4,80001ec4 <_ZN4_sem6signalEv+0x94>

        T *ret = elem->data;
    80001e80:	00053483          	ld	s1,0(a0)
        delete elem;
    80001e84:	00000097          	auipc	ra,0x0
    80001e88:	940080e7          	jalr	-1728(ra) # 800017c4 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80001e8c:	04048863          	beqz	s1,80001edc <_ZN4_sem6signalEv+0xac>
            cur->setBlock(false);
    80001e90:	00000593          	li	a1,0
    80001e94:	00048513          	mv	a0,s1
    80001e98:	fffff097          	auipc	ra,0xfffff
    80001e9c:	698080e7          	jalr	1688(ra) # 80001530 <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80001ea0:	00048513          	mv	a0,s1
    80001ea4:	00000097          	auipc	ra,0x0
    80001ea8:	1e8080e7          	jalr	488(ra) # 8000208c <_ZN9Scheduler3putEP7_thread>
    return 0;
    80001eac:	00000513          	li	a0,0
}
    80001eb0:	01813083          	ld	ra,24(sp)
    80001eb4:	01013403          	ld	s0,16(sp)
    80001eb8:	00813483          	ld	s1,8(sp)
    80001ebc:	02010113          	addi	sp,sp,32
    80001ec0:	00008067          	ret
        if (!head) { tail = 0; }
    80001ec4:	0007bc23          	sd	zero,24(a5)
    80001ec8:	fb9ff06f          	j	80001e80 <_ZN4_sem6signalEv+0x50>
    if (isClosed()) return -1;
    80001ecc:	fff00513          	li	a0,-1
    80001ed0:	00008067          	ret
    return 0;
    80001ed4:	00000513          	li	a0,0
}
    80001ed8:	00008067          	ret
    return 0;
    80001edc:	00000513          	li	a0,0
    80001ee0:	fd1ff06f          	j	80001eb0 <_ZN4_sem6signalEv+0x80>

0000000080001ee4 <_ZN4_sem15createSemaphoreEj>:
    }

    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    80001ee4:	fe010113          	addi	sp,sp,-32
    80001ee8:	00113c23          	sd	ra,24(sp)
    80001eec:	00813823          	sd	s0,16(sp)
    80001ef0:	00913423          	sd	s1,8(sp)
    80001ef4:	02010413          	addi	s0,sp,32
    80001ef8:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    80001efc:	02000513          	li	a0,32
    80001f00:	00000097          	auipc	ra,0x0
    80001f04:	874080e7          	jalr	-1932(ra) # 80001774 <_Znwm>
    _sem(uint32 init = 1) : val(init), waitStatus(0), closed(false) {}
    80001f08:	00952023          	sw	s1,0(a0)
    80001f0c:	00052223          	sw	zero,4(a0)
    80001f10:	00050423          	sb	zero,8(a0)
    List() : head(0), tail(0) {}
    80001f14:	00053823          	sd	zero,16(a0)
    80001f18:	00053c23          	sd	zero,24(a0)
    return newSemaphore;
}
    80001f1c:	01813083          	ld	ra,24(sp)
    80001f20:	01013403          	ld	s0,16(sp)
    80001f24:	00813483          	ld	s1,8(sp)
    80001f28:	02010113          	addi	sp,sp,32
    80001f2c:	00008067          	ret

0000000080001f30 <_ZN4_sem9setClosedEb>:

void _sem::setClosed(bool b) {
    80001f30:	ff010113          	addi	sp,sp,-16
    80001f34:	00813423          	sd	s0,8(sp)
    80001f38:	01010413          	addi	s0,sp,16
    closed = b;
    80001f3c:	00b50423          	sb	a1,8(a0)
}
    80001f40:	00813403          	ld	s0,8(sp)
    80001f44:	01010113          	addi	sp,sp,16
    80001f48:	00008067          	ret

0000000080001f4c <_ZN4_sem5closeEv>:
int _sem::close() {
    80001f4c:	fe010113          	addi	sp,sp,-32
    80001f50:	00113c23          	sd	ra,24(sp)
    80001f54:	00813823          	sd	s0,16(sp)
    80001f58:	00913423          	sd	s1,8(sp)
    80001f5c:	01213023          	sd	s2,0(sp)
    80001f60:	02010413          	addi	s0,sp,32
    80001f64:	00050913          	mv	s2,a0
    setClosed(true);
    80001f68:	00100593          	li	a1,1
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	fc4080e7          	jalr	-60(ra) # 80001f30 <_ZN4_sem9setClosedEb>
    void setWaitStatus(int s) { waitStatus = s;}
    80001f74:	fff00793          	li	a5,-1
    80001f78:	00f92223          	sw	a5,4(s2)
    80001f7c:	0340006f          	j	80001fb0 <_ZN4_sem5closeEv+0x64>
        if (!head) { tail = 0; }
    80001f80:	00093c23          	sd	zero,24(s2)
        T *ret = elem->data;
    80001f84:	00053483          	ld	s1,0(a0)
        delete elem;
    80001f88:	00000097          	auipc	ra,0x0
    80001f8c:	83c080e7          	jalr	-1988(ra) # 800017c4 <_ZdlPv>
    while(_thread* cur = blocked.removeFirst()){
    80001f90:	02048c63          	beqz	s1,80001fc8 <_ZN4_sem5closeEv+0x7c>
        cur->setBlock(false);
    80001f94:	00000593          	li	a1,0
    80001f98:	00048513          	mv	a0,s1
    80001f9c:	fffff097          	auipc	ra,0xfffff
    80001fa0:	594080e7          	jalr	1428(ra) # 80001530 <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    80001fa4:	00048513          	mv	a0,s1
    80001fa8:	00000097          	auipc	ra,0x0
    80001fac:	0e4080e7          	jalr	228(ra) # 8000208c <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80001fb0:	01093503          	ld	a0,16(s2)
    80001fb4:	00050a63          	beqz	a0,80001fc8 <_ZN4_sem5closeEv+0x7c>
        head = head->next;
    80001fb8:	00853783          	ld	a5,8(a0)
    80001fbc:	00f93823          	sd	a5,16(s2)
        if (!head) { tail = 0; }
    80001fc0:	fc0792e3          	bnez	a5,80001f84 <_ZN4_sem5closeEv+0x38>
    80001fc4:	fbdff06f          	j	80001f80 <_ZN4_sem5closeEv+0x34>
}
    80001fc8:	00000513          	li	a0,0
    80001fcc:	01813083          	ld	ra,24(sp)
    80001fd0:	01013403          	ld	s0,16(sp)
    80001fd4:	00813483          	ld	s1,8(sp)
    80001fd8:	00013903          	ld	s2,0(sp)
    80001fdc:	02010113          	addi	sp,sp,32
    80001fe0:	00008067          	ret

0000000080001fe4 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001fe4:	ff010113          	addi	sp,sp,-16
    80001fe8:	00813423          	sd	s0,8(sp)
    80001fec:	01010413          	addi	s0,sp,16
    80001ff0:	00100793          	li	a5,1
    80001ff4:	00f50863          	beq	a0,a5,80002004 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001ff8:	00813403          	ld	s0,8(sp)
    80001ffc:	01010113          	addi	sp,sp,16
    80002000:	00008067          	ret
    80002004:	000107b7          	lui	a5,0x10
    80002008:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000200c:	fef596e3          	bne	a1,a5,80001ff8 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80002010:	00008797          	auipc	a5,0x8
    80002014:	fe078793          	addi	a5,a5,-32 # 80009ff0 <_ZN9Scheduler16readyThreadQueueE>
    80002018:	0007b023          	sd	zero,0(a5)
    8000201c:	0007b423          	sd	zero,8(a5)
    80002020:	fd9ff06f          	j	80001ff8 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002024 <_ZN9Scheduler3getEv>:
{
    80002024:	fe010113          	addi	sp,sp,-32
    80002028:	00113c23          	sd	ra,24(sp)
    8000202c:	00813823          	sd	s0,16(sp)
    80002030:	00913423          	sd	s1,8(sp)
    80002034:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80002038:	00008517          	auipc	a0,0x8
    8000203c:	fb853503          	ld	a0,-72(a0) # 80009ff0 <_ZN9Scheduler16readyThreadQueueE>
    80002040:	04050263          	beqz	a0,80002084 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80002044:	00853783          	ld	a5,8(a0)
    80002048:	00008717          	auipc	a4,0x8
    8000204c:	faf73423          	sd	a5,-88(a4) # 80009ff0 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80002050:	02078463          	beqz	a5,80002078 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80002054:	00053483          	ld	s1,0(a0)
        delete elem;
    80002058:	fffff097          	auipc	ra,0xfffff
    8000205c:	76c080e7          	jalr	1900(ra) # 800017c4 <_ZdlPv>
}
    80002060:	00048513          	mv	a0,s1
    80002064:	01813083          	ld	ra,24(sp)
    80002068:	01013403          	ld	s0,16(sp)
    8000206c:	00813483          	ld	s1,8(sp)
    80002070:	02010113          	addi	sp,sp,32
    80002074:	00008067          	ret
        if (!head) { tail = 0; }
    80002078:	00008797          	auipc	a5,0x8
    8000207c:	f807b023          	sd	zero,-128(a5) # 80009ff8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002080:	fd5ff06f          	j	80002054 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80002084:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80002088:	fd9ff06f          	j	80002060 <_ZN9Scheduler3getEv+0x3c>

000000008000208c <_ZN9Scheduler3putEP7_thread>:
{
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	02010413          	addi	s0,sp,32
    800020a0:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    800020a4:	01000513          	li	a0,16
    800020a8:	fffff097          	auipc	ra,0xfffff
    800020ac:	6cc080e7          	jalr	1740(ra) # 80001774 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800020b0:	00953023          	sd	s1,0(a0)
    800020b4:	00053423          	sd	zero,8(a0)
        if (tail)
    800020b8:	00008797          	auipc	a5,0x8
    800020bc:	f407b783          	ld	a5,-192(a5) # 80009ff8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800020c0:	02078263          	beqz	a5,800020e4 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800020c4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800020c8:	00008797          	auipc	a5,0x8
    800020cc:	f2a7b823          	sd	a0,-208(a5) # 80009ff8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800020d0:	01813083          	ld	ra,24(sp)
    800020d4:	01013403          	ld	s0,16(sp)
    800020d8:	00813483          	ld	s1,8(sp)
    800020dc:	02010113          	addi	sp,sp,32
    800020e0:	00008067          	ret
            head = tail = elem;
    800020e4:	00008797          	auipc	a5,0x8
    800020e8:	f0c78793          	addi	a5,a5,-244 # 80009ff0 <_ZN9Scheduler16readyThreadQueueE>
    800020ec:	00a7b423          	sd	a0,8(a5)
    800020f0:	00a7b023          	sd	a0,0(a5)
    800020f4:	fddff06f          	j	800020d0 <_ZN9Scheduler3putEP7_thread+0x44>

00000000800020f8 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    800020f8:	ff010113          	addi	sp,sp,-16
    800020fc:	00113423          	sd	ra,8(sp)
    80002100:	00813023          	sd	s0,0(sp)
    80002104:	01010413          	addi	s0,sp,16
    80002108:	000105b7          	lui	a1,0x10
    8000210c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002110:	00100513          	li	a0,1
    80002114:	00000097          	auipc	ra,0x0
    80002118:	ed0080e7          	jalr	-304(ra) # 80001fe4 <_Z41__static_initialization_and_destruction_0ii>
    8000211c:	00813083          	ld	ra,8(sp)
    80002120:	00013403          	ld	s0,0(sp)
    80002124:	01010113          	addi	sp,sp,16
    80002128:	00008067          	ret

000000008000212c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    8000212c:	fe010113          	addi	sp,sp,-32
    80002130:	00113c23          	sd	ra,24(sp)
    80002134:	00813823          	sd	s0,16(sp)
    80002138:	00913423          	sd	s1,8(sp)
    8000213c:	01213023          	sd	s2,0(sp)
    80002140:	02010413          	addi	s0,sp,32
    80002144:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002148:	00000913          	li	s2,0
    8000214c:	00c0006f          	j	80002158 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002150:	fffff097          	auipc	ra,0xfffff
    80002154:	0a0080e7          	jalr	160(ra) # 800011f0 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002158:	fffff097          	auipc	ra,0xfffff
    8000215c:	16c080e7          	jalr	364(ra) # 800012c4 <_Z4getcv>
    80002160:	0005059b          	sext.w	a1,a0
    80002164:	01b00793          	li	a5,27
    80002168:	02f58a63          	beq	a1,a5,8000219c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    8000216c:	0084b503          	ld	a0,8(s1)
    80002170:	00003097          	auipc	ra,0x3
    80002174:	9fc080e7          	jalr	-1540(ra) # 80004b6c <_ZN6Buffer3putEi>
        i++;
    80002178:	0019071b          	addiw	a4,s2,1
    8000217c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002180:	0004a683          	lw	a3,0(s1)
    80002184:	0026979b          	slliw	a5,a3,0x2
    80002188:	00d787bb          	addw	a5,a5,a3
    8000218c:	0017979b          	slliw	a5,a5,0x1
    80002190:	02f767bb          	remw	a5,a4,a5
    80002194:	fc0792e3          	bnez	a5,80002158 <_ZL16producerKeyboardPv+0x2c>
    80002198:	fb9ff06f          	j	80002150 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000219c:	00100793          	li	a5,1
    800021a0:	00008717          	auipc	a4,0x8
    800021a4:	e6f72023          	sw	a5,-416(a4) # 8000a000 <_ZL9threadEnd>
    data->buffer->put('!');
    800021a8:	02100593          	li	a1,33
    800021ac:	0084b503          	ld	a0,8(s1)
    800021b0:	00003097          	auipc	ra,0x3
    800021b4:	9bc080e7          	jalr	-1604(ra) # 80004b6c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800021b8:	0104b503          	ld	a0,16(s1)
    800021bc:	fffff097          	auipc	ra,0xfffff
    800021c0:	0dc080e7          	jalr	220(ra) # 80001298 <_Z10sem_signalP4_sem>
}
    800021c4:	01813083          	ld	ra,24(sp)
    800021c8:	01013403          	ld	s0,16(sp)
    800021cc:	00813483          	ld	s1,8(sp)
    800021d0:	00013903          	ld	s2,0(sp)
    800021d4:	02010113          	addi	sp,sp,32
    800021d8:	00008067          	ret

00000000800021dc <_ZL8producerPv>:

static void producer(void *arg) {
    800021dc:	fe010113          	addi	sp,sp,-32
    800021e0:	00113c23          	sd	ra,24(sp)
    800021e4:	00813823          	sd	s0,16(sp)
    800021e8:	00913423          	sd	s1,8(sp)
    800021ec:	01213023          	sd	s2,0(sp)
    800021f0:	02010413          	addi	s0,sp,32
    800021f4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800021f8:	00000913          	li	s2,0
    800021fc:	00c0006f          	j	80002208 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002200:	fffff097          	auipc	ra,0xfffff
    80002204:	ff0080e7          	jalr	-16(ra) # 800011f0 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002208:	00008797          	auipc	a5,0x8
    8000220c:	df87a783          	lw	a5,-520(a5) # 8000a000 <_ZL9threadEnd>
    80002210:	02079e63          	bnez	a5,8000224c <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002214:	0004a583          	lw	a1,0(s1)
    80002218:	0305859b          	addiw	a1,a1,48
    8000221c:	0084b503          	ld	a0,8(s1)
    80002220:	00003097          	auipc	ra,0x3
    80002224:	94c080e7          	jalr	-1716(ra) # 80004b6c <_ZN6Buffer3putEi>
        i++;
    80002228:	0019071b          	addiw	a4,s2,1
    8000222c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002230:	0004a683          	lw	a3,0(s1)
    80002234:	0026979b          	slliw	a5,a3,0x2
    80002238:	00d787bb          	addw	a5,a5,a3
    8000223c:	0017979b          	slliw	a5,a5,0x1
    80002240:	02f767bb          	remw	a5,a4,a5
    80002244:	fc0792e3          	bnez	a5,80002208 <_ZL8producerPv+0x2c>
    80002248:	fb9ff06f          	j	80002200 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    8000224c:	0104b503          	ld	a0,16(s1)
    80002250:	fffff097          	auipc	ra,0xfffff
    80002254:	048080e7          	jalr	72(ra) # 80001298 <_Z10sem_signalP4_sem>
}
    80002258:	01813083          	ld	ra,24(sp)
    8000225c:	01013403          	ld	s0,16(sp)
    80002260:	00813483          	ld	s1,8(sp)
    80002264:	00013903          	ld	s2,0(sp)
    80002268:	02010113          	addi	sp,sp,32
    8000226c:	00008067          	ret

0000000080002270 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002270:	fd010113          	addi	sp,sp,-48
    80002274:	02113423          	sd	ra,40(sp)
    80002278:	02813023          	sd	s0,32(sp)
    8000227c:	00913c23          	sd	s1,24(sp)
    80002280:	01213823          	sd	s2,16(sp)
    80002284:	01313423          	sd	s3,8(sp)
    80002288:	03010413          	addi	s0,sp,48
    8000228c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002290:	00000993          	li	s3,0
    80002294:	01c0006f          	j	800022b0 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	f58080e7          	jalr	-168(ra) # 800011f0 <_Z15thread_dispatchv>
    800022a0:	0500006f          	j	800022f0 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800022a4:	00a00513          	li	a0,10
    800022a8:	fffff097          	auipc	ra,0xfffff
    800022ac:	048080e7          	jalr	72(ra) # 800012f0 <_Z4putcc>
    while (!threadEnd) {
    800022b0:	00008797          	auipc	a5,0x8
    800022b4:	d507a783          	lw	a5,-688(a5) # 8000a000 <_ZL9threadEnd>
    800022b8:	06079063          	bnez	a5,80002318 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800022bc:	00893503          	ld	a0,8(s2)
    800022c0:	00003097          	auipc	ra,0x3
    800022c4:	93c080e7          	jalr	-1732(ra) # 80004bfc <_ZN6Buffer3getEv>
        i++;
    800022c8:	0019849b          	addiw	s1,s3,1
    800022cc:	0004899b          	sext.w	s3,s1
        putc(key);
    800022d0:	0ff57513          	andi	a0,a0,255
    800022d4:	fffff097          	auipc	ra,0xfffff
    800022d8:	01c080e7          	jalr	28(ra) # 800012f0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800022dc:	00092703          	lw	a4,0(s2)
    800022e0:	0027179b          	slliw	a5,a4,0x2
    800022e4:	00e787bb          	addw	a5,a5,a4
    800022e8:	02f4e7bb          	remw	a5,s1,a5
    800022ec:	fa0786e3          	beqz	a5,80002298 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800022f0:	05000793          	li	a5,80
    800022f4:	02f4e4bb          	remw	s1,s1,a5
    800022f8:	fa049ce3          	bnez	s1,800022b0 <_ZL8consumerPv+0x40>
    800022fc:	fa9ff06f          	j	800022a4 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002300:	00893503          	ld	a0,8(s2)
    80002304:	00003097          	auipc	ra,0x3
    80002308:	8f8080e7          	jalr	-1800(ra) # 80004bfc <_ZN6Buffer3getEv>
        putc(key);
    8000230c:	0ff57513          	andi	a0,a0,255
    80002310:	fffff097          	auipc	ra,0xfffff
    80002314:	fe0080e7          	jalr	-32(ra) # 800012f0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002318:	00893503          	ld	a0,8(s2)
    8000231c:	00003097          	auipc	ra,0x3
    80002320:	96c080e7          	jalr	-1684(ra) # 80004c88 <_ZN6Buffer6getCntEv>
    80002324:	fca04ee3          	bgtz	a0,80002300 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002328:	01093503          	ld	a0,16(s2)
    8000232c:	fffff097          	auipc	ra,0xfffff
    80002330:	f6c080e7          	jalr	-148(ra) # 80001298 <_Z10sem_signalP4_sem>
}
    80002334:	02813083          	ld	ra,40(sp)
    80002338:	02013403          	ld	s0,32(sp)
    8000233c:	01813483          	ld	s1,24(sp)
    80002340:	01013903          	ld	s2,16(sp)
    80002344:	00813983          	ld	s3,8(sp)
    80002348:	03010113          	addi	sp,sp,48
    8000234c:	00008067          	ret

0000000080002350 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002350:	f9010113          	addi	sp,sp,-112
    80002354:	06113423          	sd	ra,104(sp)
    80002358:	06813023          	sd	s0,96(sp)
    8000235c:	04913c23          	sd	s1,88(sp)
    80002360:	05213823          	sd	s2,80(sp)
    80002364:	05313423          	sd	s3,72(sp)
    80002368:	05413023          	sd	s4,64(sp)
    8000236c:	03513c23          	sd	s5,56(sp)
    80002370:	03613823          	sd	s6,48(sp)
    80002374:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002378:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    8000237c:	00006517          	auipc	a0,0x6
    80002380:	01c50513          	addi	a0,a0,28 # 80008398 <kvmincrease+0x11a8>
    80002384:	00002097          	auipc	ra,0x2
    80002388:	a9c080e7          	jalr	-1380(ra) # 80003e20 <_Z11printStringPKc>
    getString(input, 30);
    8000238c:	01e00593          	li	a1,30
    80002390:	fa040493          	addi	s1,s0,-96
    80002394:	00048513          	mv	a0,s1
    80002398:	00002097          	auipc	ra,0x2
    8000239c:	b10080e7          	jalr	-1264(ra) # 80003ea8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800023a0:	00048513          	mv	a0,s1
    800023a4:	00002097          	auipc	ra,0x2
    800023a8:	bdc080e7          	jalr	-1060(ra) # 80003f80 <_Z11stringToIntPKc>
    800023ac:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800023b0:	00006517          	auipc	a0,0x6
    800023b4:	00850513          	addi	a0,a0,8 # 800083b8 <kvmincrease+0x11c8>
    800023b8:	00002097          	auipc	ra,0x2
    800023bc:	a68080e7          	jalr	-1432(ra) # 80003e20 <_Z11printStringPKc>
    getString(input, 30);
    800023c0:	01e00593          	li	a1,30
    800023c4:	00048513          	mv	a0,s1
    800023c8:	00002097          	auipc	ra,0x2
    800023cc:	ae0080e7          	jalr	-1312(ra) # 80003ea8 <_Z9getStringPci>
    n = stringToInt(input);
    800023d0:	00048513          	mv	a0,s1
    800023d4:	00002097          	auipc	ra,0x2
    800023d8:	bac080e7          	jalr	-1108(ra) # 80003f80 <_Z11stringToIntPKc>
    800023dc:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800023e0:	00006517          	auipc	a0,0x6
    800023e4:	ff850513          	addi	a0,a0,-8 # 800083d8 <kvmincrease+0x11e8>
    800023e8:	00002097          	auipc	ra,0x2
    800023ec:	a38080e7          	jalr	-1480(ra) # 80003e20 <_Z11printStringPKc>
    800023f0:	00000613          	li	a2,0
    800023f4:	00a00593          	li	a1,10
    800023f8:	00090513          	mv	a0,s2
    800023fc:	00002097          	auipc	ra,0x2
    80002400:	bd4080e7          	jalr	-1068(ra) # 80003fd0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002404:	00006517          	auipc	a0,0x6
    80002408:	fec50513          	addi	a0,a0,-20 # 800083f0 <kvmincrease+0x1200>
    8000240c:	00002097          	auipc	ra,0x2
    80002410:	a14080e7          	jalr	-1516(ra) # 80003e20 <_Z11printStringPKc>
    80002414:	00000613          	li	a2,0
    80002418:	00a00593          	li	a1,10
    8000241c:	00048513          	mv	a0,s1
    80002420:	00002097          	auipc	ra,0x2
    80002424:	bb0080e7          	jalr	-1104(ra) # 80003fd0 <_Z8printIntiii>
    printString(".\n");
    80002428:	00006517          	auipc	a0,0x6
    8000242c:	fe050513          	addi	a0,a0,-32 # 80008408 <kvmincrease+0x1218>
    80002430:	00002097          	auipc	ra,0x2
    80002434:	9f0080e7          	jalr	-1552(ra) # 80003e20 <_Z11printStringPKc>
    if(threadNum > n) {
    80002438:	0324c463          	blt	s1,s2,80002460 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    8000243c:	03205c63          	blez	s2,80002474 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002440:	03800513          	li	a0,56
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	330080e7          	jalr	816(ra) # 80001774 <_Znwm>
    8000244c:	00050a13          	mv	s4,a0
    80002450:	00048593          	mv	a1,s1
    80002454:	00002097          	auipc	ra,0x2
    80002458:	67c080e7          	jalr	1660(ra) # 80004ad0 <_ZN6BufferC1Ei>
    8000245c:	0300006f          	j	8000248c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002460:	00006517          	auipc	a0,0x6
    80002464:	fb050513          	addi	a0,a0,-80 # 80008410 <kvmincrease+0x1220>
    80002468:	00002097          	auipc	ra,0x2
    8000246c:	9b8080e7          	jalr	-1608(ra) # 80003e20 <_Z11printStringPKc>
        return;
    80002470:	0140006f          	j	80002484 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002474:	00006517          	auipc	a0,0x6
    80002478:	fdc50513          	addi	a0,a0,-36 # 80008450 <kvmincrease+0x1260>
    8000247c:	00002097          	auipc	ra,0x2
    80002480:	9a4080e7          	jalr	-1628(ra) # 80003e20 <_Z11printStringPKc>
        return;
    80002484:	000b0113          	mv	sp,s6
    80002488:	1500006f          	j	800025d8 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    8000248c:	00000593          	li	a1,0
    80002490:	00008517          	auipc	a0,0x8
    80002494:	b7850513          	addi	a0,a0,-1160 # 8000a008 <_ZL10waitForAll>
    80002498:	fffff097          	auipc	ra,0xfffff
    8000249c:	d7c080e7          	jalr	-644(ra) # 80001214 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800024a0:	00391793          	slli	a5,s2,0x3
    800024a4:	00f78793          	addi	a5,a5,15
    800024a8:	ff07f793          	andi	a5,a5,-16
    800024ac:	40f10133          	sub	sp,sp,a5
    800024b0:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800024b4:	0019071b          	addiw	a4,s2,1
    800024b8:	00171793          	slli	a5,a4,0x1
    800024bc:	00e787b3          	add	a5,a5,a4
    800024c0:	00379793          	slli	a5,a5,0x3
    800024c4:	00f78793          	addi	a5,a5,15
    800024c8:	ff07f793          	andi	a5,a5,-16
    800024cc:	40f10133          	sub	sp,sp,a5
    800024d0:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800024d4:	00191613          	slli	a2,s2,0x1
    800024d8:	012607b3          	add	a5,a2,s2
    800024dc:	00379793          	slli	a5,a5,0x3
    800024e0:	00f987b3          	add	a5,s3,a5
    800024e4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800024e8:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800024ec:	00008717          	auipc	a4,0x8
    800024f0:	b1c73703          	ld	a4,-1252(a4) # 8000a008 <_ZL10waitForAll>
    800024f4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800024f8:	00078613          	mv	a2,a5
    800024fc:	00000597          	auipc	a1,0x0
    80002500:	d7458593          	addi	a1,a1,-652 # 80002270 <_ZL8consumerPv>
    80002504:	f9840513          	addi	a0,s0,-104
    80002508:	fffff097          	auipc	ra,0xfffff
    8000250c:	c90080e7          	jalr	-880(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002510:	00000493          	li	s1,0
    80002514:	0280006f          	j	8000253c <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002518:	00000597          	auipc	a1,0x0
    8000251c:	c1458593          	addi	a1,a1,-1004 # 8000212c <_ZL16producerKeyboardPv>
                      data + i);
    80002520:	00179613          	slli	a2,a5,0x1
    80002524:	00f60633          	add	a2,a2,a5
    80002528:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    8000252c:	00c98633          	add	a2,s3,a2
    80002530:	fffff097          	auipc	ra,0xfffff
    80002534:	c68080e7          	jalr	-920(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002538:	0014849b          	addiw	s1,s1,1
    8000253c:	0524d263          	bge	s1,s2,80002580 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002540:	00149793          	slli	a5,s1,0x1
    80002544:	009787b3          	add	a5,a5,s1
    80002548:	00379793          	slli	a5,a5,0x3
    8000254c:	00f987b3          	add	a5,s3,a5
    80002550:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002554:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002558:	00008717          	auipc	a4,0x8
    8000255c:	ab073703          	ld	a4,-1360(a4) # 8000a008 <_ZL10waitForAll>
    80002560:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002564:	00048793          	mv	a5,s1
    80002568:	00349513          	slli	a0,s1,0x3
    8000256c:	00aa8533          	add	a0,s5,a0
    80002570:	fa9054e3          	blez	s1,80002518 <_Z22producerConsumer_C_APIv+0x1c8>
    80002574:	00000597          	auipc	a1,0x0
    80002578:	c6858593          	addi	a1,a1,-920 # 800021dc <_ZL8producerPv>
    8000257c:	fa5ff06f          	j	80002520 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002580:	fffff097          	auipc	ra,0xfffff
    80002584:	c70080e7          	jalr	-912(ra) # 800011f0 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002588:	00000493          	li	s1,0
    8000258c:	00994e63          	blt	s2,s1,800025a8 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002590:	00008517          	auipc	a0,0x8
    80002594:	a7853503          	ld	a0,-1416(a0) # 8000a008 <_ZL10waitForAll>
    80002598:	fffff097          	auipc	ra,0xfffff
    8000259c:	cd4080e7          	jalr	-812(ra) # 8000126c <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800025a0:	0014849b          	addiw	s1,s1,1
    800025a4:	fe9ff06f          	j	8000258c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800025a8:	00008517          	auipc	a0,0x8
    800025ac:	a6053503          	ld	a0,-1440(a0) # 8000a008 <_ZL10waitForAll>
    800025b0:	fffff097          	auipc	ra,0xfffff
    800025b4:	c90080e7          	jalr	-880(ra) # 80001240 <_Z9sem_closeP4_sem>
    delete buffer;
    800025b8:	000a0e63          	beqz	s4,800025d4 <_Z22producerConsumer_C_APIv+0x284>
    800025bc:	000a0513          	mv	a0,s4
    800025c0:	00002097          	auipc	ra,0x2
    800025c4:	750080e7          	jalr	1872(ra) # 80004d10 <_ZN6BufferD1Ev>
    800025c8:	000a0513          	mv	a0,s4
    800025cc:	fffff097          	auipc	ra,0xfffff
    800025d0:	1f8080e7          	jalr	504(ra) # 800017c4 <_ZdlPv>
    800025d4:	000b0113          	mv	sp,s6

}
    800025d8:	f9040113          	addi	sp,s0,-112
    800025dc:	06813083          	ld	ra,104(sp)
    800025e0:	06013403          	ld	s0,96(sp)
    800025e4:	05813483          	ld	s1,88(sp)
    800025e8:	05013903          	ld	s2,80(sp)
    800025ec:	04813983          	ld	s3,72(sp)
    800025f0:	04013a03          	ld	s4,64(sp)
    800025f4:	03813a83          	ld	s5,56(sp)
    800025f8:	03013b03          	ld	s6,48(sp)
    800025fc:	07010113          	addi	sp,sp,112
    80002600:	00008067          	ret
    80002604:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002608:	000a0513          	mv	a0,s4
    8000260c:	fffff097          	auipc	ra,0xfffff
    80002610:	1b8080e7          	jalr	440(ra) # 800017c4 <_ZdlPv>
    80002614:	00048513          	mv	a0,s1
    80002618:	00009097          	auipc	ra,0x9
    8000261c:	af0080e7          	jalr	-1296(ra) # 8000b108 <_Unwind_Resume>

0000000080002620 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002620:	fe010113          	addi	sp,sp,-32
    80002624:	00113c23          	sd	ra,24(sp)
    80002628:	00813823          	sd	s0,16(sp)
    8000262c:	00913423          	sd	s1,8(sp)
    80002630:	01213023          	sd	s2,0(sp)
    80002634:	02010413          	addi	s0,sp,32
    80002638:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000263c:	00100793          	li	a5,1
    80002640:	02a7f863          	bgeu	a5,a0,80002670 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002644:	00a00793          	li	a5,10
    80002648:	02f577b3          	remu	a5,a0,a5
    8000264c:	02078e63          	beqz	a5,80002688 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002650:	fff48513          	addi	a0,s1,-1
    80002654:	00000097          	auipc	ra,0x0
    80002658:	fcc080e7          	jalr	-52(ra) # 80002620 <_ZL9fibonaccim>
    8000265c:	00050913          	mv	s2,a0
    80002660:	ffe48513          	addi	a0,s1,-2
    80002664:	00000097          	auipc	ra,0x0
    80002668:	fbc080e7          	jalr	-68(ra) # 80002620 <_ZL9fibonaccim>
    8000266c:	00a90533          	add	a0,s2,a0
}
    80002670:	01813083          	ld	ra,24(sp)
    80002674:	01013403          	ld	s0,16(sp)
    80002678:	00813483          	ld	s1,8(sp)
    8000267c:	00013903          	ld	s2,0(sp)
    80002680:	02010113          	addi	sp,sp,32
    80002684:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002688:	fffff097          	auipc	ra,0xfffff
    8000268c:	b68080e7          	jalr	-1176(ra) # 800011f0 <_Z15thread_dispatchv>
    80002690:	fc1ff06f          	j	80002650 <_ZL9fibonaccim+0x30>

0000000080002694 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002694:	fe010113          	addi	sp,sp,-32
    80002698:	00113c23          	sd	ra,24(sp)
    8000269c:	00813823          	sd	s0,16(sp)
    800026a0:	00913423          	sd	s1,8(sp)
    800026a4:	01213023          	sd	s2,0(sp)
    800026a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800026ac:	00000913          	li	s2,0
    800026b0:	0380006f          	j	800026e8 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	b3c080e7          	jalr	-1220(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800026bc:	00148493          	addi	s1,s1,1
    800026c0:	000027b7          	lui	a5,0x2
    800026c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800026c8:	0097ee63          	bltu	a5,s1,800026e4 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800026cc:	00000713          	li	a4,0
    800026d0:	000077b7          	lui	a5,0x7
    800026d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800026d8:	fce7eee3          	bltu	a5,a4,800026b4 <_ZN7WorkerA11workerBodyAEPv+0x20>
    800026dc:	00170713          	addi	a4,a4,1
    800026e0:	ff1ff06f          	j	800026d0 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800026e4:	00190913          	addi	s2,s2,1
    800026e8:	00900793          	li	a5,9
    800026ec:	0527e063          	bltu	a5,s2,8000272c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800026f0:	00006517          	auipc	a0,0x6
    800026f4:	d9050513          	addi	a0,a0,-624 # 80008480 <kvmincrease+0x1290>
    800026f8:	00001097          	auipc	ra,0x1
    800026fc:	728080e7          	jalr	1832(ra) # 80003e20 <_Z11printStringPKc>
    80002700:	00000613          	li	a2,0
    80002704:	00a00593          	li	a1,10
    80002708:	0009051b          	sext.w	a0,s2
    8000270c:	00002097          	auipc	ra,0x2
    80002710:	8c4080e7          	jalr	-1852(ra) # 80003fd0 <_Z8printIntiii>
    80002714:	00006517          	auipc	a0,0x6
    80002718:	a7450513          	addi	a0,a0,-1420 # 80008188 <kvmincrease+0xf98>
    8000271c:	00001097          	auipc	ra,0x1
    80002720:	704080e7          	jalr	1796(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002724:	00000493          	li	s1,0
    80002728:	f99ff06f          	j	800026c0 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000272c:	00006517          	auipc	a0,0x6
    80002730:	d5c50513          	addi	a0,a0,-676 # 80008488 <kvmincrease+0x1298>
    80002734:	00001097          	auipc	ra,0x1
    80002738:	6ec080e7          	jalr	1772(ra) # 80003e20 <_Z11printStringPKc>
    finishedA = true;
    8000273c:	00100793          	li	a5,1
    80002740:	00008717          	auipc	a4,0x8
    80002744:	8cf70823          	sb	a5,-1840(a4) # 8000a010 <_ZL9finishedA>
}
    80002748:	01813083          	ld	ra,24(sp)
    8000274c:	01013403          	ld	s0,16(sp)
    80002750:	00813483          	ld	s1,8(sp)
    80002754:	00013903          	ld	s2,0(sp)
    80002758:	02010113          	addi	sp,sp,32
    8000275c:	00008067          	ret

0000000080002760 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002760:	fe010113          	addi	sp,sp,-32
    80002764:	00113c23          	sd	ra,24(sp)
    80002768:	00813823          	sd	s0,16(sp)
    8000276c:	00913423          	sd	s1,8(sp)
    80002770:	01213023          	sd	s2,0(sp)
    80002774:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002778:	00000913          	li	s2,0
    8000277c:	0380006f          	j	800027b4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002780:	fffff097          	auipc	ra,0xfffff
    80002784:	a70080e7          	jalr	-1424(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002788:	00148493          	addi	s1,s1,1
    8000278c:	000027b7          	lui	a5,0x2
    80002790:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002794:	0097ee63          	bltu	a5,s1,800027b0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002798:	00000713          	li	a4,0
    8000279c:	000077b7          	lui	a5,0x7
    800027a0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800027a4:	fce7eee3          	bltu	a5,a4,80002780 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800027a8:	00170713          	addi	a4,a4,1
    800027ac:	ff1ff06f          	j	8000279c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800027b0:	00190913          	addi	s2,s2,1
    800027b4:	00f00793          	li	a5,15
    800027b8:	0527e063          	bltu	a5,s2,800027f8 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800027bc:	00006517          	auipc	a0,0x6
    800027c0:	cdc50513          	addi	a0,a0,-804 # 80008498 <kvmincrease+0x12a8>
    800027c4:	00001097          	auipc	ra,0x1
    800027c8:	65c080e7          	jalr	1628(ra) # 80003e20 <_Z11printStringPKc>
    800027cc:	00000613          	li	a2,0
    800027d0:	00a00593          	li	a1,10
    800027d4:	0009051b          	sext.w	a0,s2
    800027d8:	00001097          	auipc	ra,0x1
    800027dc:	7f8080e7          	jalr	2040(ra) # 80003fd0 <_Z8printIntiii>
    800027e0:	00006517          	auipc	a0,0x6
    800027e4:	9a850513          	addi	a0,a0,-1624 # 80008188 <kvmincrease+0xf98>
    800027e8:	00001097          	auipc	ra,0x1
    800027ec:	638080e7          	jalr	1592(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800027f0:	00000493          	li	s1,0
    800027f4:	f99ff06f          	j	8000278c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800027f8:	00006517          	auipc	a0,0x6
    800027fc:	ca850513          	addi	a0,a0,-856 # 800084a0 <kvmincrease+0x12b0>
    80002800:	00001097          	auipc	ra,0x1
    80002804:	620080e7          	jalr	1568(ra) # 80003e20 <_Z11printStringPKc>
    finishedB = true;
    80002808:	00100793          	li	a5,1
    8000280c:	00008717          	auipc	a4,0x8
    80002810:	80f702a3          	sb	a5,-2043(a4) # 8000a011 <_ZL9finishedB>
    thread_dispatch();
    80002814:	fffff097          	auipc	ra,0xfffff
    80002818:	9dc080e7          	jalr	-1572(ra) # 800011f0 <_Z15thread_dispatchv>
}
    8000281c:	01813083          	ld	ra,24(sp)
    80002820:	01013403          	ld	s0,16(sp)
    80002824:	00813483          	ld	s1,8(sp)
    80002828:	00013903          	ld	s2,0(sp)
    8000282c:	02010113          	addi	sp,sp,32
    80002830:	00008067          	ret

0000000080002834 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002834:	fe010113          	addi	sp,sp,-32
    80002838:	00113c23          	sd	ra,24(sp)
    8000283c:	00813823          	sd	s0,16(sp)
    80002840:	00913423          	sd	s1,8(sp)
    80002844:	01213023          	sd	s2,0(sp)
    80002848:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000284c:	00000493          	li	s1,0
    80002850:	0400006f          	j	80002890 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002854:	00006517          	auipc	a0,0x6
    80002858:	c5c50513          	addi	a0,a0,-932 # 800084b0 <kvmincrease+0x12c0>
    8000285c:	00001097          	auipc	ra,0x1
    80002860:	5c4080e7          	jalr	1476(ra) # 80003e20 <_Z11printStringPKc>
    80002864:	00000613          	li	a2,0
    80002868:	00a00593          	li	a1,10
    8000286c:	00048513          	mv	a0,s1
    80002870:	00001097          	auipc	ra,0x1
    80002874:	760080e7          	jalr	1888(ra) # 80003fd0 <_Z8printIntiii>
    80002878:	00006517          	auipc	a0,0x6
    8000287c:	91050513          	addi	a0,a0,-1776 # 80008188 <kvmincrease+0xf98>
    80002880:	00001097          	auipc	ra,0x1
    80002884:	5a0080e7          	jalr	1440(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002888:	0014849b          	addiw	s1,s1,1
    8000288c:	0ff4f493          	andi	s1,s1,255
    80002890:	00200793          	li	a5,2
    80002894:	fc97f0e3          	bgeu	a5,s1,80002854 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002898:	00006517          	auipc	a0,0x6
    8000289c:	c2050513          	addi	a0,a0,-992 # 800084b8 <kvmincrease+0x12c8>
    800028a0:	00001097          	auipc	ra,0x1
    800028a4:	580080e7          	jalr	1408(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800028a8:	00700313          	li	t1,7
    thread_dispatch();
    800028ac:	fffff097          	auipc	ra,0xfffff
    800028b0:	944080e7          	jalr	-1724(ra) # 800011f0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800028b4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800028b8:	00006517          	auipc	a0,0x6
    800028bc:	c1050513          	addi	a0,a0,-1008 # 800084c8 <kvmincrease+0x12d8>
    800028c0:	00001097          	auipc	ra,0x1
    800028c4:	560080e7          	jalr	1376(ra) # 80003e20 <_Z11printStringPKc>
    800028c8:	00000613          	li	a2,0
    800028cc:	00a00593          	li	a1,10
    800028d0:	0009051b          	sext.w	a0,s2
    800028d4:	00001097          	auipc	ra,0x1
    800028d8:	6fc080e7          	jalr	1788(ra) # 80003fd0 <_Z8printIntiii>
    800028dc:	00006517          	auipc	a0,0x6
    800028e0:	8ac50513          	addi	a0,a0,-1876 # 80008188 <kvmincrease+0xf98>
    800028e4:	00001097          	auipc	ra,0x1
    800028e8:	53c080e7          	jalr	1340(ra) # 80003e20 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800028ec:	00c00513          	li	a0,12
    800028f0:	00000097          	auipc	ra,0x0
    800028f4:	d30080e7          	jalr	-720(ra) # 80002620 <_ZL9fibonaccim>
    800028f8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800028fc:	00006517          	auipc	a0,0x6
    80002900:	bd450513          	addi	a0,a0,-1068 # 800084d0 <kvmincrease+0x12e0>
    80002904:	00001097          	auipc	ra,0x1
    80002908:	51c080e7          	jalr	1308(ra) # 80003e20 <_Z11printStringPKc>
    8000290c:	00000613          	li	a2,0
    80002910:	00a00593          	li	a1,10
    80002914:	0009051b          	sext.w	a0,s2
    80002918:	00001097          	auipc	ra,0x1
    8000291c:	6b8080e7          	jalr	1720(ra) # 80003fd0 <_Z8printIntiii>
    80002920:	00006517          	auipc	a0,0x6
    80002924:	86850513          	addi	a0,a0,-1944 # 80008188 <kvmincrease+0xf98>
    80002928:	00001097          	auipc	ra,0x1
    8000292c:	4f8080e7          	jalr	1272(ra) # 80003e20 <_Z11printStringPKc>
    80002930:	0400006f          	j	80002970 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002934:	00006517          	auipc	a0,0x6
    80002938:	b7c50513          	addi	a0,a0,-1156 # 800084b0 <kvmincrease+0x12c0>
    8000293c:	00001097          	auipc	ra,0x1
    80002940:	4e4080e7          	jalr	1252(ra) # 80003e20 <_Z11printStringPKc>
    80002944:	00000613          	li	a2,0
    80002948:	00a00593          	li	a1,10
    8000294c:	00048513          	mv	a0,s1
    80002950:	00001097          	auipc	ra,0x1
    80002954:	680080e7          	jalr	1664(ra) # 80003fd0 <_Z8printIntiii>
    80002958:	00006517          	auipc	a0,0x6
    8000295c:	83050513          	addi	a0,a0,-2000 # 80008188 <kvmincrease+0xf98>
    80002960:	00001097          	auipc	ra,0x1
    80002964:	4c0080e7          	jalr	1216(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002968:	0014849b          	addiw	s1,s1,1
    8000296c:	0ff4f493          	andi	s1,s1,255
    80002970:	00500793          	li	a5,5
    80002974:	fc97f0e3          	bgeu	a5,s1,80002934 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002978:	00006517          	auipc	a0,0x6
    8000297c:	b1050513          	addi	a0,a0,-1264 # 80008488 <kvmincrease+0x1298>
    80002980:	00001097          	auipc	ra,0x1
    80002984:	4a0080e7          	jalr	1184(ra) # 80003e20 <_Z11printStringPKc>
    finishedC = true;
    80002988:	00100793          	li	a5,1
    8000298c:	00007717          	auipc	a4,0x7
    80002990:	68f70323          	sb	a5,1670(a4) # 8000a012 <_ZL9finishedC>
    thread_dispatch();
    80002994:	fffff097          	auipc	ra,0xfffff
    80002998:	85c080e7          	jalr	-1956(ra) # 800011f0 <_Z15thread_dispatchv>
}
    8000299c:	01813083          	ld	ra,24(sp)
    800029a0:	01013403          	ld	s0,16(sp)
    800029a4:	00813483          	ld	s1,8(sp)
    800029a8:	00013903          	ld	s2,0(sp)
    800029ac:	02010113          	addi	sp,sp,32
    800029b0:	00008067          	ret

00000000800029b4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800029b4:	fe010113          	addi	sp,sp,-32
    800029b8:	00113c23          	sd	ra,24(sp)
    800029bc:	00813823          	sd	s0,16(sp)
    800029c0:	00913423          	sd	s1,8(sp)
    800029c4:	01213023          	sd	s2,0(sp)
    800029c8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800029cc:	00a00493          	li	s1,10
    800029d0:	0400006f          	j	80002a10 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800029d4:	00006517          	auipc	a0,0x6
    800029d8:	b0c50513          	addi	a0,a0,-1268 # 800084e0 <kvmincrease+0x12f0>
    800029dc:	00001097          	auipc	ra,0x1
    800029e0:	444080e7          	jalr	1092(ra) # 80003e20 <_Z11printStringPKc>
    800029e4:	00000613          	li	a2,0
    800029e8:	00a00593          	li	a1,10
    800029ec:	00048513          	mv	a0,s1
    800029f0:	00001097          	auipc	ra,0x1
    800029f4:	5e0080e7          	jalr	1504(ra) # 80003fd0 <_Z8printIntiii>
    800029f8:	00005517          	auipc	a0,0x5
    800029fc:	79050513          	addi	a0,a0,1936 # 80008188 <kvmincrease+0xf98>
    80002a00:	00001097          	auipc	ra,0x1
    80002a04:	420080e7          	jalr	1056(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002a08:	0014849b          	addiw	s1,s1,1
    80002a0c:	0ff4f493          	andi	s1,s1,255
    80002a10:	00c00793          	li	a5,12
    80002a14:	fc97f0e3          	bgeu	a5,s1,800029d4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002a18:	00006517          	auipc	a0,0x6
    80002a1c:	ad050513          	addi	a0,a0,-1328 # 800084e8 <kvmincrease+0x12f8>
    80002a20:	00001097          	auipc	ra,0x1
    80002a24:	400080e7          	jalr	1024(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002a28:	00500313          	li	t1,5
    thread_dispatch();
    80002a2c:	ffffe097          	auipc	ra,0xffffe
    80002a30:	7c4080e7          	jalr	1988(ra) # 800011f0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002a34:	01000513          	li	a0,16
    80002a38:	00000097          	auipc	ra,0x0
    80002a3c:	be8080e7          	jalr	-1048(ra) # 80002620 <_ZL9fibonaccim>
    80002a40:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002a44:	00006517          	auipc	a0,0x6
    80002a48:	ab450513          	addi	a0,a0,-1356 # 800084f8 <kvmincrease+0x1308>
    80002a4c:	00001097          	auipc	ra,0x1
    80002a50:	3d4080e7          	jalr	980(ra) # 80003e20 <_Z11printStringPKc>
    80002a54:	00000613          	li	a2,0
    80002a58:	00a00593          	li	a1,10
    80002a5c:	0009051b          	sext.w	a0,s2
    80002a60:	00001097          	auipc	ra,0x1
    80002a64:	570080e7          	jalr	1392(ra) # 80003fd0 <_Z8printIntiii>
    80002a68:	00005517          	auipc	a0,0x5
    80002a6c:	72050513          	addi	a0,a0,1824 # 80008188 <kvmincrease+0xf98>
    80002a70:	00001097          	auipc	ra,0x1
    80002a74:	3b0080e7          	jalr	944(ra) # 80003e20 <_Z11printStringPKc>
    80002a78:	0400006f          	j	80002ab8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002a7c:	00006517          	auipc	a0,0x6
    80002a80:	a6450513          	addi	a0,a0,-1436 # 800084e0 <kvmincrease+0x12f0>
    80002a84:	00001097          	auipc	ra,0x1
    80002a88:	39c080e7          	jalr	924(ra) # 80003e20 <_Z11printStringPKc>
    80002a8c:	00000613          	li	a2,0
    80002a90:	00a00593          	li	a1,10
    80002a94:	00048513          	mv	a0,s1
    80002a98:	00001097          	auipc	ra,0x1
    80002a9c:	538080e7          	jalr	1336(ra) # 80003fd0 <_Z8printIntiii>
    80002aa0:	00005517          	auipc	a0,0x5
    80002aa4:	6e850513          	addi	a0,a0,1768 # 80008188 <kvmincrease+0xf98>
    80002aa8:	00001097          	auipc	ra,0x1
    80002aac:	378080e7          	jalr	888(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002ab0:	0014849b          	addiw	s1,s1,1
    80002ab4:	0ff4f493          	andi	s1,s1,255
    80002ab8:	00f00793          	li	a5,15
    80002abc:	fc97f0e3          	bgeu	a5,s1,80002a7c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002ac0:	00006517          	auipc	a0,0x6
    80002ac4:	a4850513          	addi	a0,a0,-1464 # 80008508 <kvmincrease+0x1318>
    80002ac8:	00001097          	auipc	ra,0x1
    80002acc:	358080e7          	jalr	856(ra) # 80003e20 <_Z11printStringPKc>
    finishedD = true;
    80002ad0:	00100793          	li	a5,1
    80002ad4:	00007717          	auipc	a4,0x7
    80002ad8:	52f70fa3          	sb	a5,1343(a4) # 8000a013 <_ZL9finishedD>
    thread_dispatch();
    80002adc:	ffffe097          	auipc	ra,0xffffe
    80002ae0:	714080e7          	jalr	1812(ra) # 800011f0 <_Z15thread_dispatchv>
}
    80002ae4:	01813083          	ld	ra,24(sp)
    80002ae8:	01013403          	ld	s0,16(sp)
    80002aec:	00813483          	ld	s1,8(sp)
    80002af0:	00013903          	ld	s2,0(sp)
    80002af4:	02010113          	addi	sp,sp,32
    80002af8:	00008067          	ret

0000000080002afc <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002afc:	fc010113          	addi	sp,sp,-64
    80002b00:	02113c23          	sd	ra,56(sp)
    80002b04:	02813823          	sd	s0,48(sp)
    80002b08:	02913423          	sd	s1,40(sp)
    80002b0c:	03213023          	sd	s2,32(sp)
    80002b10:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002b14:	02000513          	li	a0,32
    80002b18:	fffff097          	auipc	ra,0xfffff
    80002b1c:	c5c080e7          	jalr	-932(ra) # 80001774 <_Znwm>
    80002b20:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	ed4080e7          	jalr	-300(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80002b2c:	00007797          	auipc	a5,0x7
    80002b30:	32478793          	addi	a5,a5,804 # 80009e50 <_ZTV7WorkerA+0x10>
    80002b34:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80002b38:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80002b3c:	00006517          	auipc	a0,0x6
    80002b40:	9dc50513          	addi	a0,a0,-1572 # 80008518 <kvmincrease+0x1328>
    80002b44:	00001097          	auipc	ra,0x1
    80002b48:	2dc080e7          	jalr	732(ra) # 80003e20 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002b4c:	02000513          	li	a0,32
    80002b50:	fffff097          	auipc	ra,0xfffff
    80002b54:	c24080e7          	jalr	-988(ra) # 80001774 <_Znwm>
    80002b58:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80002b5c:	fffff097          	auipc	ra,0xfffff
    80002b60:	e9c080e7          	jalr	-356(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80002b64:	00007797          	auipc	a5,0x7
    80002b68:	31478793          	addi	a5,a5,788 # 80009e78 <_ZTV7WorkerB+0x10>
    80002b6c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002b70:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002b74:	00006517          	auipc	a0,0x6
    80002b78:	9bc50513          	addi	a0,a0,-1604 # 80008530 <kvmincrease+0x1340>
    80002b7c:	00001097          	auipc	ra,0x1
    80002b80:	2a4080e7          	jalr	676(ra) # 80003e20 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002b84:	02000513          	li	a0,32
    80002b88:	fffff097          	auipc	ra,0xfffff
    80002b8c:	bec080e7          	jalr	-1044(ra) # 80001774 <_Znwm>
    80002b90:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002b94:	fffff097          	auipc	ra,0xfffff
    80002b98:	e64080e7          	jalr	-412(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80002b9c:	00007797          	auipc	a5,0x7
    80002ba0:	30478793          	addi	a5,a5,772 # 80009ea0 <_ZTV7WorkerC+0x10>
    80002ba4:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002ba8:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002bac:	00006517          	auipc	a0,0x6
    80002bb0:	99c50513          	addi	a0,a0,-1636 # 80008548 <kvmincrease+0x1358>
    80002bb4:	00001097          	auipc	ra,0x1
    80002bb8:	26c080e7          	jalr	620(ra) # 80003e20 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002bbc:	02000513          	li	a0,32
    80002bc0:	fffff097          	auipc	ra,0xfffff
    80002bc4:	bb4080e7          	jalr	-1100(ra) # 80001774 <_Znwm>
    80002bc8:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002bcc:	fffff097          	auipc	ra,0xfffff
    80002bd0:	e2c080e7          	jalr	-468(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80002bd4:	00007797          	auipc	a5,0x7
    80002bd8:	2f478793          	addi	a5,a5,756 # 80009ec8 <_ZTV7WorkerD+0x10>
    80002bdc:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002be0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002be4:	00006517          	auipc	a0,0x6
    80002be8:	97c50513          	addi	a0,a0,-1668 # 80008560 <kvmincrease+0x1370>
    80002bec:	00001097          	auipc	ra,0x1
    80002bf0:	234080e7          	jalr	564(ra) # 80003e20 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002bf4:	00000493          	li	s1,0
    80002bf8:	00300793          	li	a5,3
    80002bfc:	0297c663          	blt	a5,s1,80002c28 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002c00:	00349793          	slli	a5,s1,0x3
    80002c04:	fe040713          	addi	a4,s0,-32
    80002c08:	00f707b3          	add	a5,a4,a5
    80002c0c:	fe07b503          	ld	a0,-32(a5)
    80002c10:	fffff097          	auipc	ra,0xfffff
    80002c14:	d8c080e7          	jalr	-628(ra) # 8000199c <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002c18:	0014849b          	addiw	s1,s1,1
    80002c1c:	fddff06f          	j	80002bf8 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002c20:	fffff097          	auipc	ra,0xfffff
    80002c24:	db0080e7          	jalr	-592(ra) # 800019d0 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002c28:	00007797          	auipc	a5,0x7
    80002c2c:	3e87c783          	lbu	a5,1000(a5) # 8000a010 <_ZL9finishedA>
    80002c30:	fe0788e3          	beqz	a5,80002c20 <_Z20Threads_CPP_API_testv+0x124>
    80002c34:	00007797          	auipc	a5,0x7
    80002c38:	3dd7c783          	lbu	a5,989(a5) # 8000a011 <_ZL9finishedB>
    80002c3c:	fe0782e3          	beqz	a5,80002c20 <_Z20Threads_CPP_API_testv+0x124>
    80002c40:	00007797          	auipc	a5,0x7
    80002c44:	3d27c783          	lbu	a5,978(a5) # 8000a012 <_ZL9finishedC>
    80002c48:	fc078ce3          	beqz	a5,80002c20 <_Z20Threads_CPP_API_testv+0x124>
    80002c4c:	00007797          	auipc	a5,0x7
    80002c50:	3c77c783          	lbu	a5,967(a5) # 8000a013 <_ZL9finishedD>
    80002c54:	fc0786e3          	beqz	a5,80002c20 <_Z20Threads_CPP_API_testv+0x124>
    80002c58:	fc040493          	addi	s1,s0,-64
    80002c5c:	0080006f          	j	80002c64 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002c60:	00848493          	addi	s1,s1,8
    80002c64:	fe040793          	addi	a5,s0,-32
    80002c68:	08f48663          	beq	s1,a5,80002cf4 <_Z20Threads_CPP_API_testv+0x1f8>
    80002c6c:	0004b503          	ld	a0,0(s1)
    80002c70:	fe0508e3          	beqz	a0,80002c60 <_Z20Threads_CPP_API_testv+0x164>
    80002c74:	00053783          	ld	a5,0(a0)
    80002c78:	0087b783          	ld	a5,8(a5)
    80002c7c:	000780e7          	jalr	a5
    80002c80:	fe1ff06f          	j	80002c60 <_Z20Threads_CPP_API_testv+0x164>
    80002c84:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002c88:	00048513          	mv	a0,s1
    80002c8c:	fffff097          	auipc	ra,0xfffff
    80002c90:	b38080e7          	jalr	-1224(ra) # 800017c4 <_ZdlPv>
    80002c94:	00090513          	mv	a0,s2
    80002c98:	00008097          	auipc	ra,0x8
    80002c9c:	470080e7          	jalr	1136(ra) # 8000b108 <_Unwind_Resume>
    80002ca0:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002ca4:	00048513          	mv	a0,s1
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	b1c080e7          	jalr	-1252(ra) # 800017c4 <_ZdlPv>
    80002cb0:	00090513          	mv	a0,s2
    80002cb4:	00008097          	auipc	ra,0x8
    80002cb8:	454080e7          	jalr	1108(ra) # 8000b108 <_Unwind_Resume>
    80002cbc:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002cc0:	00048513          	mv	a0,s1
    80002cc4:	fffff097          	auipc	ra,0xfffff
    80002cc8:	b00080e7          	jalr	-1280(ra) # 800017c4 <_ZdlPv>
    80002ccc:	00090513          	mv	a0,s2
    80002cd0:	00008097          	auipc	ra,0x8
    80002cd4:	438080e7          	jalr	1080(ra) # 8000b108 <_Unwind_Resume>
    80002cd8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002cdc:	00048513          	mv	a0,s1
    80002ce0:	fffff097          	auipc	ra,0xfffff
    80002ce4:	ae4080e7          	jalr	-1308(ra) # 800017c4 <_ZdlPv>
    80002ce8:	00090513          	mv	a0,s2
    80002cec:	00008097          	auipc	ra,0x8
    80002cf0:	41c080e7          	jalr	1052(ra) # 8000b108 <_Unwind_Resume>
}
    80002cf4:	03813083          	ld	ra,56(sp)
    80002cf8:	03013403          	ld	s0,48(sp)
    80002cfc:	02813483          	ld	s1,40(sp)
    80002d00:	02013903          	ld	s2,32(sp)
    80002d04:	04010113          	addi	sp,sp,64
    80002d08:	00008067          	ret

0000000080002d0c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002d0c:	ff010113          	addi	sp,sp,-16
    80002d10:	00113423          	sd	ra,8(sp)
    80002d14:	00813023          	sd	s0,0(sp)
    80002d18:	01010413          	addi	s0,sp,16
    80002d1c:	00007797          	auipc	a5,0x7
    80002d20:	13478793          	addi	a5,a5,308 # 80009e50 <_ZTV7WorkerA+0x10>
    80002d24:	00f53023          	sd	a5,0(a0)
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	aec080e7          	jalr	-1300(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002d30:	00813083          	ld	ra,8(sp)
    80002d34:	00013403          	ld	s0,0(sp)
    80002d38:	01010113          	addi	sp,sp,16
    80002d3c:	00008067          	ret

0000000080002d40 <_ZN7WorkerAD0Ev>:
    80002d40:	fe010113          	addi	sp,sp,-32
    80002d44:	00113c23          	sd	ra,24(sp)
    80002d48:	00813823          	sd	s0,16(sp)
    80002d4c:	00913423          	sd	s1,8(sp)
    80002d50:	02010413          	addi	s0,sp,32
    80002d54:	00050493          	mv	s1,a0
    80002d58:	00007797          	auipc	a5,0x7
    80002d5c:	0f878793          	addi	a5,a5,248 # 80009e50 <_ZTV7WorkerA+0x10>
    80002d60:	00f53023          	sd	a5,0(a0)
    80002d64:	fffff097          	auipc	ra,0xfffff
    80002d68:	ab0080e7          	jalr	-1360(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002d6c:	00048513          	mv	a0,s1
    80002d70:	fffff097          	auipc	ra,0xfffff
    80002d74:	a54080e7          	jalr	-1452(ra) # 800017c4 <_ZdlPv>
    80002d78:	01813083          	ld	ra,24(sp)
    80002d7c:	01013403          	ld	s0,16(sp)
    80002d80:	00813483          	ld	s1,8(sp)
    80002d84:	02010113          	addi	sp,sp,32
    80002d88:	00008067          	ret

0000000080002d8c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002d8c:	ff010113          	addi	sp,sp,-16
    80002d90:	00113423          	sd	ra,8(sp)
    80002d94:	00813023          	sd	s0,0(sp)
    80002d98:	01010413          	addi	s0,sp,16
    80002d9c:	00007797          	auipc	a5,0x7
    80002da0:	0dc78793          	addi	a5,a5,220 # 80009e78 <_ZTV7WorkerB+0x10>
    80002da4:	00f53023          	sd	a5,0(a0)
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	a6c080e7          	jalr	-1428(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00013403          	ld	s0,0(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN7WorkerBD0Ev>:
    80002dc0:	fe010113          	addi	sp,sp,-32
    80002dc4:	00113c23          	sd	ra,24(sp)
    80002dc8:	00813823          	sd	s0,16(sp)
    80002dcc:	00913423          	sd	s1,8(sp)
    80002dd0:	02010413          	addi	s0,sp,32
    80002dd4:	00050493          	mv	s1,a0
    80002dd8:	00007797          	auipc	a5,0x7
    80002ddc:	0a078793          	addi	a5,a5,160 # 80009e78 <_ZTV7WorkerB+0x10>
    80002de0:	00f53023          	sd	a5,0(a0)
    80002de4:	fffff097          	auipc	ra,0xfffff
    80002de8:	a30080e7          	jalr	-1488(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002dec:	00048513          	mv	a0,s1
    80002df0:	fffff097          	auipc	ra,0xfffff
    80002df4:	9d4080e7          	jalr	-1580(ra) # 800017c4 <_ZdlPv>
    80002df8:	01813083          	ld	ra,24(sp)
    80002dfc:	01013403          	ld	s0,16(sp)
    80002e00:	00813483          	ld	s1,8(sp)
    80002e04:	02010113          	addi	sp,sp,32
    80002e08:	00008067          	ret

0000000080002e0c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002e0c:	ff010113          	addi	sp,sp,-16
    80002e10:	00113423          	sd	ra,8(sp)
    80002e14:	00813023          	sd	s0,0(sp)
    80002e18:	01010413          	addi	s0,sp,16
    80002e1c:	00007797          	auipc	a5,0x7
    80002e20:	08478793          	addi	a5,a5,132 # 80009ea0 <_ZTV7WorkerC+0x10>
    80002e24:	00f53023          	sd	a5,0(a0)
    80002e28:	fffff097          	auipc	ra,0xfffff
    80002e2c:	9ec080e7          	jalr	-1556(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002e30:	00813083          	ld	ra,8(sp)
    80002e34:	00013403          	ld	s0,0(sp)
    80002e38:	01010113          	addi	sp,sp,16
    80002e3c:	00008067          	ret

0000000080002e40 <_ZN7WorkerCD0Ev>:
    80002e40:	fe010113          	addi	sp,sp,-32
    80002e44:	00113c23          	sd	ra,24(sp)
    80002e48:	00813823          	sd	s0,16(sp)
    80002e4c:	00913423          	sd	s1,8(sp)
    80002e50:	02010413          	addi	s0,sp,32
    80002e54:	00050493          	mv	s1,a0
    80002e58:	00007797          	auipc	a5,0x7
    80002e5c:	04878793          	addi	a5,a5,72 # 80009ea0 <_ZTV7WorkerC+0x10>
    80002e60:	00f53023          	sd	a5,0(a0)
    80002e64:	fffff097          	auipc	ra,0xfffff
    80002e68:	9b0080e7          	jalr	-1616(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002e6c:	00048513          	mv	a0,s1
    80002e70:	fffff097          	auipc	ra,0xfffff
    80002e74:	954080e7          	jalr	-1708(ra) # 800017c4 <_ZdlPv>
    80002e78:	01813083          	ld	ra,24(sp)
    80002e7c:	01013403          	ld	s0,16(sp)
    80002e80:	00813483          	ld	s1,8(sp)
    80002e84:	02010113          	addi	sp,sp,32
    80002e88:	00008067          	ret

0000000080002e8c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00113423          	sd	ra,8(sp)
    80002e94:	00813023          	sd	s0,0(sp)
    80002e98:	01010413          	addi	s0,sp,16
    80002e9c:	00007797          	auipc	a5,0x7
    80002ea0:	02c78793          	addi	a5,a5,44 # 80009ec8 <_ZTV7WorkerD+0x10>
    80002ea4:	00f53023          	sd	a5,0(a0)
    80002ea8:	fffff097          	auipc	ra,0xfffff
    80002eac:	96c080e7          	jalr	-1684(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002eb0:	00813083          	ld	ra,8(sp)
    80002eb4:	00013403          	ld	s0,0(sp)
    80002eb8:	01010113          	addi	sp,sp,16
    80002ebc:	00008067          	ret

0000000080002ec0 <_ZN7WorkerDD0Ev>:
    80002ec0:	fe010113          	addi	sp,sp,-32
    80002ec4:	00113c23          	sd	ra,24(sp)
    80002ec8:	00813823          	sd	s0,16(sp)
    80002ecc:	00913423          	sd	s1,8(sp)
    80002ed0:	02010413          	addi	s0,sp,32
    80002ed4:	00050493          	mv	s1,a0
    80002ed8:	00007797          	auipc	a5,0x7
    80002edc:	ff078793          	addi	a5,a5,-16 # 80009ec8 <_ZTV7WorkerD+0x10>
    80002ee0:	00f53023          	sd	a5,0(a0)
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	930080e7          	jalr	-1744(ra) # 80001814 <_ZN6ThreadD1Ev>
    80002eec:	00048513          	mv	a0,s1
    80002ef0:	fffff097          	auipc	ra,0xfffff
    80002ef4:	8d4080e7          	jalr	-1836(ra) # 800017c4 <_ZdlPv>
    80002ef8:	01813083          	ld	ra,24(sp)
    80002efc:	01013403          	ld	s0,16(sp)
    80002f00:	00813483          	ld	s1,8(sp)
    80002f04:	02010113          	addi	sp,sp,32
    80002f08:	00008067          	ret

0000000080002f0c <_ZN7WorkerA3runEv>:
    void run() override {
    80002f0c:	ff010113          	addi	sp,sp,-16
    80002f10:	00113423          	sd	ra,8(sp)
    80002f14:	00813023          	sd	s0,0(sp)
    80002f18:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002f1c:	00000593          	li	a1,0
    80002f20:	fffff097          	auipc	ra,0xfffff
    80002f24:	774080e7          	jalr	1908(ra) # 80002694 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002f28:	00813083          	ld	ra,8(sp)
    80002f2c:	00013403          	ld	s0,0(sp)
    80002f30:	01010113          	addi	sp,sp,16
    80002f34:	00008067          	ret

0000000080002f38 <_ZN7WorkerB3runEv>:
    void run() override {
    80002f38:	ff010113          	addi	sp,sp,-16
    80002f3c:	00113423          	sd	ra,8(sp)
    80002f40:	00813023          	sd	s0,0(sp)
    80002f44:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002f48:	00000593          	li	a1,0
    80002f4c:	00000097          	auipc	ra,0x0
    80002f50:	814080e7          	jalr	-2028(ra) # 80002760 <_ZN7WorkerB11workerBodyBEPv>
    }
    80002f54:	00813083          	ld	ra,8(sp)
    80002f58:	00013403          	ld	s0,0(sp)
    80002f5c:	01010113          	addi	sp,sp,16
    80002f60:	00008067          	ret

0000000080002f64 <_ZN7WorkerC3runEv>:
    void run() override {
    80002f64:	ff010113          	addi	sp,sp,-16
    80002f68:	00113423          	sd	ra,8(sp)
    80002f6c:	00813023          	sd	s0,0(sp)
    80002f70:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002f74:	00000593          	li	a1,0
    80002f78:	00000097          	auipc	ra,0x0
    80002f7c:	8bc080e7          	jalr	-1860(ra) # 80002834 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002f80:	00813083          	ld	ra,8(sp)
    80002f84:	00013403          	ld	s0,0(sp)
    80002f88:	01010113          	addi	sp,sp,16
    80002f8c:	00008067          	ret

0000000080002f90 <_ZN7WorkerD3runEv>:
    void run() override {
    80002f90:	ff010113          	addi	sp,sp,-16
    80002f94:	00113423          	sd	ra,8(sp)
    80002f98:	00813023          	sd	s0,0(sp)
    80002f9c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002fa0:	00000593          	li	a1,0
    80002fa4:	00000097          	auipc	ra,0x0
    80002fa8:	a10080e7          	jalr	-1520(ra) # 800029b4 <_ZN7WorkerD11workerBodyDEPv>
    }
    80002fac:	00813083          	ld	ra,8(sp)
    80002fb0:	00013403          	ld	s0,0(sp)
    80002fb4:	01010113          	addi	sp,sp,16
    80002fb8:	00008067          	ret

0000000080002fbc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002fbc:	fe010113          	addi	sp,sp,-32
    80002fc0:	00113c23          	sd	ra,24(sp)
    80002fc4:	00813823          	sd	s0,16(sp)
    80002fc8:	00913423          	sd	s1,8(sp)
    80002fcc:	01213023          	sd	s2,0(sp)
    80002fd0:	02010413          	addi	s0,sp,32
    80002fd4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002fd8:	00100793          	li	a5,1
    80002fdc:	02a7f863          	bgeu	a5,a0,8000300c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) {
    80002fe0:	00a00793          	li	a5,10
    80002fe4:	02f577b3          	remu	a5,a0,a5
    80002fe8:	02078e63          	beqz	a5,80003024 <_ZL9fibonaccim+0x68>
        thread_dispatch();
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002fec:	fff48513          	addi	a0,s1,-1
    80002ff0:	00000097          	auipc	ra,0x0
    80002ff4:	fcc080e7          	jalr	-52(ra) # 80002fbc <_ZL9fibonaccim>
    80002ff8:	00050913          	mv	s2,a0
    80002ffc:	ffe48513          	addi	a0,s1,-2
    80003000:	00000097          	auipc	ra,0x0
    80003004:	fbc080e7          	jalr	-68(ra) # 80002fbc <_ZL9fibonaccim>
    80003008:	00a90533          	add	a0,s2,a0
}
    8000300c:	01813083          	ld	ra,24(sp)
    80003010:	01013403          	ld	s0,16(sp)
    80003014:	00813483          	ld	s1,8(sp)
    80003018:	00013903          	ld	s2,0(sp)
    8000301c:	02010113          	addi	sp,sp,32
    80003020:	00008067          	ret
        thread_dispatch();
    80003024:	ffffe097          	auipc	ra,0xffffe
    80003028:	1cc080e7          	jalr	460(ra) # 800011f0 <_Z15thread_dispatchv>
    8000302c:	fc1ff06f          	j	80002fec <_ZL9fibonaccim+0x30>

0000000080003030 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003030:	fe010113          	addi	sp,sp,-32
    80003034:	00113c23          	sd	ra,24(sp)
    80003038:	00813823          	sd	s0,16(sp)
    8000303c:	00913423          	sd	s1,8(sp)
    80003040:	01213023          	sd	s2,0(sp)
    80003044:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003048:	00a00493          	li	s1,10
    8000304c:	0400006f          	j	8000308c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003050:	00005517          	auipc	a0,0x5
    80003054:	49050513          	addi	a0,a0,1168 # 800084e0 <kvmincrease+0x12f0>
    80003058:	00001097          	auipc	ra,0x1
    8000305c:	dc8080e7          	jalr	-568(ra) # 80003e20 <_Z11printStringPKc>
    80003060:	00000613          	li	a2,0
    80003064:	00a00593          	li	a1,10
    80003068:	00048513          	mv	a0,s1
    8000306c:	00001097          	auipc	ra,0x1
    80003070:	f64080e7          	jalr	-156(ra) # 80003fd0 <_Z8printIntiii>
    80003074:	00005517          	auipc	a0,0x5
    80003078:	11450513          	addi	a0,a0,276 # 80008188 <kvmincrease+0xf98>
    8000307c:	00001097          	auipc	ra,0x1
    80003080:	da4080e7          	jalr	-604(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003084:	0014849b          	addiw	s1,s1,1
    80003088:	0ff4f493          	andi	s1,s1,255
    8000308c:	00c00793          	li	a5,12
    80003090:	fc97f0e3          	bgeu	a5,s1,80003050 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003094:	00005517          	auipc	a0,0x5
    80003098:	45450513          	addi	a0,a0,1108 # 800084e8 <kvmincrease+0x12f8>
    8000309c:	00001097          	auipc	ra,0x1
    800030a0:	d84080e7          	jalr	-636(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800030a4:	00500313          	li	t1,5
    thread_dispatch();
    800030a8:	ffffe097          	auipc	ra,0xffffe
    800030ac:	148080e7          	jalr	328(ra) # 800011f0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800030b0:	01000513          	li	a0,16
    800030b4:	00000097          	auipc	ra,0x0
    800030b8:	f08080e7          	jalr	-248(ra) # 80002fbc <_ZL9fibonaccim>
    800030bc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800030c0:	00005517          	auipc	a0,0x5
    800030c4:	43850513          	addi	a0,a0,1080 # 800084f8 <kvmincrease+0x1308>
    800030c8:	00001097          	auipc	ra,0x1
    800030cc:	d58080e7          	jalr	-680(ra) # 80003e20 <_Z11printStringPKc>
    800030d0:	00000613          	li	a2,0
    800030d4:	00a00593          	li	a1,10
    800030d8:	0009051b          	sext.w	a0,s2
    800030dc:	00001097          	auipc	ra,0x1
    800030e0:	ef4080e7          	jalr	-268(ra) # 80003fd0 <_Z8printIntiii>
    800030e4:	00005517          	auipc	a0,0x5
    800030e8:	0a450513          	addi	a0,a0,164 # 80008188 <kvmincrease+0xf98>
    800030ec:	00001097          	auipc	ra,0x1
    800030f0:	d34080e7          	jalr	-716(ra) # 80003e20 <_Z11printStringPKc>
    800030f4:	0400006f          	j	80003134 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800030f8:	00005517          	auipc	a0,0x5
    800030fc:	3e850513          	addi	a0,a0,1000 # 800084e0 <kvmincrease+0x12f0>
    80003100:	00001097          	auipc	ra,0x1
    80003104:	d20080e7          	jalr	-736(ra) # 80003e20 <_Z11printStringPKc>
    80003108:	00000613          	li	a2,0
    8000310c:	00a00593          	li	a1,10
    80003110:	00048513          	mv	a0,s1
    80003114:	00001097          	auipc	ra,0x1
    80003118:	ebc080e7          	jalr	-324(ra) # 80003fd0 <_Z8printIntiii>
    8000311c:	00005517          	auipc	a0,0x5
    80003120:	06c50513          	addi	a0,a0,108 # 80008188 <kvmincrease+0xf98>
    80003124:	00001097          	auipc	ra,0x1
    80003128:	cfc080e7          	jalr	-772(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000312c:	0014849b          	addiw	s1,s1,1
    80003130:	0ff4f493          	andi	s1,s1,255
    80003134:	00f00793          	li	a5,15
    80003138:	fc97f0e3          	bgeu	a5,s1,800030f8 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000313c:	00005517          	auipc	a0,0x5
    80003140:	3cc50513          	addi	a0,a0,972 # 80008508 <kvmincrease+0x1318>
    80003144:	00001097          	auipc	ra,0x1
    80003148:	cdc080e7          	jalr	-804(ra) # 80003e20 <_Z11printStringPKc>
    finishedD = true;
    8000314c:	00100793          	li	a5,1
    80003150:	00007717          	auipc	a4,0x7
    80003154:	ecf70223          	sb	a5,-316(a4) # 8000a014 <_ZL9finishedD>
    thread_dispatch();
    80003158:	ffffe097          	auipc	ra,0xffffe
    8000315c:	098080e7          	jalr	152(ra) # 800011f0 <_Z15thread_dispatchv>
}
    80003160:	01813083          	ld	ra,24(sp)
    80003164:	01013403          	ld	s0,16(sp)
    80003168:	00813483          	ld	s1,8(sp)
    8000316c:	00013903          	ld	s2,0(sp)
    80003170:	02010113          	addi	sp,sp,32
    80003174:	00008067          	ret

0000000080003178 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003178:	fe010113          	addi	sp,sp,-32
    8000317c:	00113c23          	sd	ra,24(sp)
    80003180:	00813823          	sd	s0,16(sp)
    80003184:	00913423          	sd	s1,8(sp)
    80003188:	01213023          	sd	s2,0(sp)
    8000318c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003190:	00000493          	li	s1,0
    80003194:	0400006f          	j	800031d4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003198:	00005517          	auipc	a0,0x5
    8000319c:	31850513          	addi	a0,a0,792 # 800084b0 <kvmincrease+0x12c0>
    800031a0:	00001097          	auipc	ra,0x1
    800031a4:	c80080e7          	jalr	-896(ra) # 80003e20 <_Z11printStringPKc>
    800031a8:	00000613          	li	a2,0
    800031ac:	00a00593          	li	a1,10
    800031b0:	00048513          	mv	a0,s1
    800031b4:	00001097          	auipc	ra,0x1
    800031b8:	e1c080e7          	jalr	-484(ra) # 80003fd0 <_Z8printIntiii>
    800031bc:	00005517          	auipc	a0,0x5
    800031c0:	fcc50513          	addi	a0,a0,-52 # 80008188 <kvmincrease+0xf98>
    800031c4:	00001097          	auipc	ra,0x1
    800031c8:	c5c080e7          	jalr	-932(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800031cc:	0014849b          	addiw	s1,s1,1
    800031d0:	0ff4f493          	andi	s1,s1,255
    800031d4:	00200793          	li	a5,2
    800031d8:	fc97f0e3          	bgeu	a5,s1,80003198 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800031dc:	00005517          	auipc	a0,0x5
    800031e0:	2dc50513          	addi	a0,a0,732 # 800084b8 <kvmincrease+0x12c8>
    800031e4:	00001097          	auipc	ra,0x1
    800031e8:	c3c080e7          	jalr	-964(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800031ec:	00700313          	li	t1,7
    thread_dispatch();
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	000080e7          	jalr	ra # 800011f0 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800031f8:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800031fc:	00005517          	auipc	a0,0x5
    80003200:	2cc50513          	addi	a0,a0,716 # 800084c8 <kvmincrease+0x12d8>
    80003204:	00001097          	auipc	ra,0x1
    80003208:	c1c080e7          	jalr	-996(ra) # 80003e20 <_Z11printStringPKc>
    8000320c:	00000613          	li	a2,0
    80003210:	00a00593          	li	a1,10
    80003214:	0009051b          	sext.w	a0,s2
    80003218:	00001097          	auipc	ra,0x1
    8000321c:	db8080e7          	jalr	-584(ra) # 80003fd0 <_Z8printIntiii>
    80003220:	00005517          	auipc	a0,0x5
    80003224:	f6850513          	addi	a0,a0,-152 # 80008188 <kvmincrease+0xf98>
    80003228:	00001097          	auipc	ra,0x1
    8000322c:	bf8080e7          	jalr	-1032(ra) # 80003e20 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003230:	00c00513          	li	a0,12
    80003234:	00000097          	auipc	ra,0x0
    80003238:	d88080e7          	jalr	-632(ra) # 80002fbc <_ZL9fibonaccim>
    8000323c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003240:	00005517          	auipc	a0,0x5
    80003244:	29050513          	addi	a0,a0,656 # 800084d0 <kvmincrease+0x12e0>
    80003248:	00001097          	auipc	ra,0x1
    8000324c:	bd8080e7          	jalr	-1064(ra) # 80003e20 <_Z11printStringPKc>
    80003250:	00000613          	li	a2,0
    80003254:	00a00593          	li	a1,10
    80003258:	0009051b          	sext.w	a0,s2
    8000325c:	00001097          	auipc	ra,0x1
    80003260:	d74080e7          	jalr	-652(ra) # 80003fd0 <_Z8printIntiii>
    80003264:	00005517          	auipc	a0,0x5
    80003268:	f2450513          	addi	a0,a0,-220 # 80008188 <kvmincrease+0xf98>
    8000326c:	00001097          	auipc	ra,0x1
    80003270:	bb4080e7          	jalr	-1100(ra) # 80003e20 <_Z11printStringPKc>
    80003274:	0400006f          	j	800032b4 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003278:	00005517          	auipc	a0,0x5
    8000327c:	23850513          	addi	a0,a0,568 # 800084b0 <kvmincrease+0x12c0>
    80003280:	00001097          	auipc	ra,0x1
    80003284:	ba0080e7          	jalr	-1120(ra) # 80003e20 <_Z11printStringPKc>
    80003288:	00000613          	li	a2,0
    8000328c:	00a00593          	li	a1,10
    80003290:	00048513          	mv	a0,s1
    80003294:	00001097          	auipc	ra,0x1
    80003298:	d3c080e7          	jalr	-708(ra) # 80003fd0 <_Z8printIntiii>
    8000329c:	00005517          	auipc	a0,0x5
    800032a0:	eec50513          	addi	a0,a0,-276 # 80008188 <kvmincrease+0xf98>
    800032a4:	00001097          	auipc	ra,0x1
    800032a8:	b7c080e7          	jalr	-1156(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800032ac:	0014849b          	addiw	s1,s1,1
    800032b0:	0ff4f493          	andi	s1,s1,255
    800032b4:	00500793          	li	a5,5
    800032b8:	fc97f0e3          	bgeu	a5,s1,80003278 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    800032bc:	00005517          	auipc	a0,0x5
    800032c0:	2bc50513          	addi	a0,a0,700 # 80008578 <kvmincrease+0x1388>
    800032c4:	00001097          	auipc	ra,0x1
    800032c8:	b5c080e7          	jalr	-1188(ra) # 80003e20 <_Z11printStringPKc>
    finishedC = true;
    800032cc:	00100793          	li	a5,1
    800032d0:	00007717          	auipc	a4,0x7
    800032d4:	d4f702a3          	sb	a5,-699(a4) # 8000a015 <_ZL9finishedC>
    thread_dispatch();
    800032d8:	ffffe097          	auipc	ra,0xffffe
    800032dc:	f18080e7          	jalr	-232(ra) # 800011f0 <_Z15thread_dispatchv>
}
    800032e0:	01813083          	ld	ra,24(sp)
    800032e4:	01013403          	ld	s0,16(sp)
    800032e8:	00813483          	ld	s1,8(sp)
    800032ec:	00013903          	ld	s2,0(sp)
    800032f0:	02010113          	addi	sp,sp,32
    800032f4:	00008067          	ret

00000000800032f8 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800032f8:	fe010113          	addi	sp,sp,-32
    800032fc:	00113c23          	sd	ra,24(sp)
    80003300:	00813823          	sd	s0,16(sp)
    80003304:	00913423          	sd	s1,8(sp)
    80003308:	01213023          	sd	s2,0(sp)
    8000330c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003310:	00000913          	li	s2,0
    80003314:	0380006f          	j	8000334c <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003318:	ffffe097          	auipc	ra,0xffffe
    8000331c:	ed8080e7          	jalr	-296(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003320:	00148493          	addi	s1,s1,1
    80003324:	000027b7          	lui	a5,0x2
    80003328:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000332c:	0097ee63          	bltu	a5,s1,80003348 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003330:	00000713          	li	a4,0
    80003334:	000077b7          	lui	a5,0x7
    80003338:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000333c:	fce7eee3          	bltu	a5,a4,80003318 <_ZL11workerBodyBPv+0x20>
    80003340:	00170713          	addi	a4,a4,1
    80003344:	ff1ff06f          	j	80003334 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003348:	00190913          	addi	s2,s2,1
    8000334c:	00f00793          	li	a5,15
    80003350:	0527e063          	bltu	a5,s2,80003390 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003354:	00005517          	auipc	a0,0x5
    80003358:	14450513          	addi	a0,a0,324 # 80008498 <kvmincrease+0x12a8>
    8000335c:	00001097          	auipc	ra,0x1
    80003360:	ac4080e7          	jalr	-1340(ra) # 80003e20 <_Z11printStringPKc>
    80003364:	00000613          	li	a2,0
    80003368:	00a00593          	li	a1,10
    8000336c:	0009051b          	sext.w	a0,s2
    80003370:	00001097          	auipc	ra,0x1
    80003374:	c60080e7          	jalr	-928(ra) # 80003fd0 <_Z8printIntiii>
    80003378:	00005517          	auipc	a0,0x5
    8000337c:	e1050513          	addi	a0,a0,-496 # 80008188 <kvmincrease+0xf98>
    80003380:	00001097          	auipc	ra,0x1
    80003384:	aa0080e7          	jalr	-1376(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003388:	00000493          	li	s1,0
    8000338c:	f99ff06f          	j	80003324 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003390:	00005517          	auipc	a0,0x5
    80003394:	11050513          	addi	a0,a0,272 # 800084a0 <kvmincrease+0x12b0>
    80003398:	00001097          	auipc	ra,0x1
    8000339c:	a88080e7          	jalr	-1400(ra) # 80003e20 <_Z11printStringPKc>
    finishedB = true;
    800033a0:	00100793          	li	a5,1
    800033a4:	00007717          	auipc	a4,0x7
    800033a8:	c6f70923          	sb	a5,-910(a4) # 8000a016 <_ZL9finishedB>
    thread_dispatch();
    800033ac:	ffffe097          	auipc	ra,0xffffe
    800033b0:	e44080e7          	jalr	-444(ra) # 800011f0 <_Z15thread_dispatchv>
}
    800033b4:	01813083          	ld	ra,24(sp)
    800033b8:	01013403          	ld	s0,16(sp)
    800033bc:	00813483          	ld	s1,8(sp)
    800033c0:	00013903          	ld	s2,0(sp)
    800033c4:	02010113          	addi	sp,sp,32
    800033c8:	00008067          	ret

00000000800033cc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800033cc:	fe010113          	addi	sp,sp,-32
    800033d0:	00113c23          	sd	ra,24(sp)
    800033d4:	00813823          	sd	s0,16(sp)
    800033d8:	00913423          	sd	s1,8(sp)
    800033dc:	01213023          	sd	s2,0(sp)
    800033e0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800033e4:	00000913          	li	s2,0
    800033e8:	0380006f          	j	80003420 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800033ec:	ffffe097          	auipc	ra,0xffffe
    800033f0:	e04080e7          	jalr	-508(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800033f4:	00148493          	addi	s1,s1,1
    800033f8:	000027b7          	lui	a5,0x2
    800033fc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003400:	0097ee63          	bltu	a5,s1,8000341c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003404:	00000713          	li	a4,0
    80003408:	000077b7          	lui	a5,0x7
    8000340c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003410:	fce7eee3          	bltu	a5,a4,800033ec <_ZL11workerBodyAPv+0x20>
    80003414:	00170713          	addi	a4,a4,1
    80003418:	ff1ff06f          	j	80003408 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000341c:	00190913          	addi	s2,s2,1
    80003420:	00900793          	li	a5,9
    80003424:	0527e063          	bltu	a5,s2,80003464 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003428:	00005517          	auipc	a0,0x5
    8000342c:	05850513          	addi	a0,a0,88 # 80008480 <kvmincrease+0x1290>
    80003430:	00001097          	auipc	ra,0x1
    80003434:	9f0080e7          	jalr	-1552(ra) # 80003e20 <_Z11printStringPKc>
    80003438:	00000613          	li	a2,0
    8000343c:	00a00593          	li	a1,10
    80003440:	0009051b          	sext.w	a0,s2
    80003444:	00001097          	auipc	ra,0x1
    80003448:	b8c080e7          	jalr	-1140(ra) # 80003fd0 <_Z8printIntiii>
    8000344c:	00005517          	auipc	a0,0x5
    80003450:	d3c50513          	addi	a0,a0,-708 # 80008188 <kvmincrease+0xf98>
    80003454:	00001097          	auipc	ra,0x1
    80003458:	9cc080e7          	jalr	-1588(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000345c:	00000493          	li	s1,0
    80003460:	f99ff06f          	j	800033f8 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003464:	00005517          	auipc	a0,0x5
    80003468:	02450513          	addi	a0,a0,36 # 80008488 <kvmincrease+0x1298>
    8000346c:	00001097          	auipc	ra,0x1
    80003470:	9b4080e7          	jalr	-1612(ra) # 80003e20 <_Z11printStringPKc>
    finishedA = true;
    80003474:	00100793          	li	a5,1
    80003478:	00007717          	auipc	a4,0x7
    8000347c:	b8f70fa3          	sb	a5,-1121(a4) # 8000a017 <_ZL9finishedA>
}
    80003480:	01813083          	ld	ra,24(sp)
    80003484:	01013403          	ld	s0,16(sp)
    80003488:	00813483          	ld	s1,8(sp)
    8000348c:	00013903          	ld	s2,0(sp)
    80003490:	02010113          	addi	sp,sp,32
    80003494:	00008067          	ret

0000000080003498 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003498:	fd010113          	addi	sp,sp,-48
    8000349c:	02113423          	sd	ra,40(sp)
    800034a0:	02813023          	sd	s0,32(sp)
    800034a4:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800034a8:	00000613          	li	a2,0
    800034ac:	00000597          	auipc	a1,0x0
    800034b0:	f2058593          	addi	a1,a1,-224 # 800033cc <_ZL11workerBodyAPv>
    800034b4:	fd040513          	addi	a0,s0,-48
    800034b8:	ffffe097          	auipc	ra,0xffffe
    800034bc:	ce0080e7          	jalr	-800(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800034c0:	00005517          	auipc	a0,0x5
    800034c4:	05850513          	addi	a0,a0,88 # 80008518 <kvmincrease+0x1328>
    800034c8:	00001097          	auipc	ra,0x1
    800034cc:	958080e7          	jalr	-1704(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800034d0:	00000613          	li	a2,0
    800034d4:	00000597          	auipc	a1,0x0
    800034d8:	e2458593          	addi	a1,a1,-476 # 800032f8 <_ZL11workerBodyBPv>
    800034dc:	fd840513          	addi	a0,s0,-40
    800034e0:	ffffe097          	auipc	ra,0xffffe
    800034e4:	cb8080e7          	jalr	-840(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    800034e8:	00005517          	auipc	a0,0x5
    800034ec:	04850513          	addi	a0,a0,72 # 80008530 <kvmincrease+0x1340>
    800034f0:	00001097          	auipc	ra,0x1
    800034f4:	930080e7          	jalr	-1744(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800034f8:	00000613          	li	a2,0
    800034fc:	00000597          	auipc	a1,0x0
    80003500:	c7c58593          	addi	a1,a1,-900 # 80003178 <_ZL11workerBodyCPv>
    80003504:	fe040513          	addi	a0,s0,-32
    80003508:	ffffe097          	auipc	ra,0xffffe
    8000350c:	c90080e7          	jalr	-880(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003510:	00005517          	auipc	a0,0x5
    80003514:	03850513          	addi	a0,a0,56 # 80008548 <kvmincrease+0x1358>
    80003518:	00001097          	auipc	ra,0x1
    8000351c:	908080e7          	jalr	-1784(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003520:	00000613          	li	a2,0
    80003524:	00000597          	auipc	a1,0x0
    80003528:	b0c58593          	addi	a1,a1,-1268 # 80003030 <_ZL11workerBodyDPv>
    8000352c:	fe840513          	addi	a0,s0,-24
    80003530:	ffffe097          	auipc	ra,0xffffe
    80003534:	c68080e7          	jalr	-920(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80003538:	00005517          	auipc	a0,0x5
    8000353c:	02850513          	addi	a0,a0,40 # 80008560 <kvmincrease+0x1370>
    80003540:	00001097          	auipc	ra,0x1
    80003544:	8e0080e7          	jalr	-1824(ra) # 80003e20 <_Z11printStringPKc>
    80003548:	00c0006f          	j	80003554 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000354c:	ffffe097          	auipc	ra,0xffffe
    80003550:	ca4080e7          	jalr	-860(ra) # 800011f0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003554:	00007797          	auipc	a5,0x7
    80003558:	ac37c783          	lbu	a5,-1341(a5) # 8000a017 <_ZL9finishedA>
    8000355c:	fe0788e3          	beqz	a5,8000354c <_Z18Threads_C_API_testv+0xb4>
    80003560:	00007797          	auipc	a5,0x7
    80003564:	ab67c783          	lbu	a5,-1354(a5) # 8000a016 <_ZL9finishedB>
    80003568:	fe0782e3          	beqz	a5,8000354c <_Z18Threads_C_API_testv+0xb4>
    8000356c:	00007797          	auipc	a5,0x7
    80003570:	aa97c783          	lbu	a5,-1367(a5) # 8000a015 <_ZL9finishedC>
    80003574:	fc078ce3          	beqz	a5,8000354c <_Z18Threads_C_API_testv+0xb4>
    80003578:	00007797          	auipc	a5,0x7
    8000357c:	a9c7c783          	lbu	a5,-1380(a5) # 8000a014 <_ZL9finishedD>
    80003580:	fc0786e3          	beqz	a5,8000354c <_Z18Threads_C_API_testv+0xb4>
    }

}
    80003584:	02813083          	ld	ra,40(sp)
    80003588:	02013403          	ld	s0,32(sp)
    8000358c:	03010113          	addi	sp,sp,48
    80003590:	00008067          	ret

0000000080003594 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003594:	fd010113          	addi	sp,sp,-48
    80003598:	02113423          	sd	ra,40(sp)
    8000359c:	02813023          	sd	s0,32(sp)
    800035a0:	00913c23          	sd	s1,24(sp)
    800035a4:	01213823          	sd	s2,16(sp)
    800035a8:	01313423          	sd	s3,8(sp)
    800035ac:	03010413          	addi	s0,sp,48
    800035b0:	00050993          	mv	s3,a0
    800035b4:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800035b8:	00000913          	li	s2,0
    800035bc:	00c0006f          	j	800035c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800035c0:	ffffe097          	auipc	ra,0xffffe
    800035c4:	410080e7          	jalr	1040(ra) # 800019d0 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800035c8:	ffffe097          	auipc	ra,0xffffe
    800035cc:	cfc080e7          	jalr	-772(ra) # 800012c4 <_Z4getcv>
    800035d0:	0005059b          	sext.w	a1,a0
    800035d4:	01b00793          	li	a5,27
    800035d8:	02f58a63          	beq	a1,a5,8000360c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800035dc:	0084b503          	ld	a0,8(s1)
    800035e0:	00001097          	auipc	ra,0x1
    800035e4:	c64080e7          	jalr	-924(ra) # 80004244 <_ZN9BufferCPP3putEi>
        i++;
    800035e8:	0019071b          	addiw	a4,s2,1
    800035ec:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800035f0:	0004a683          	lw	a3,0(s1)
    800035f4:	0026979b          	slliw	a5,a3,0x2
    800035f8:	00d787bb          	addw	a5,a5,a3
    800035fc:	0017979b          	slliw	a5,a5,0x1
    80003600:	02f767bb          	remw	a5,a4,a5
    80003604:	fc0792e3          	bnez	a5,800035c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80003608:	fb9ff06f          	j	800035c0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000360c:	00100793          	li	a5,1
    80003610:	00007717          	auipc	a4,0x7
    80003614:	a0f72423          	sw	a5,-1528(a4) # 8000a018 <_ZL9threadEnd>
    td->buffer->put('!');
    80003618:	0209b783          	ld	a5,32(s3)
    8000361c:	02100593          	li	a1,33
    80003620:	0087b503          	ld	a0,8(a5)
    80003624:	00001097          	auipc	ra,0x1
    80003628:	c20080e7          	jalr	-992(ra) # 80004244 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000362c:	0104b503          	ld	a0,16(s1)
    80003630:	ffffe097          	auipc	ra,0xffffe
    80003634:	454080e7          	jalr	1108(ra) # 80001a84 <_ZN9Semaphore6signalEv>
}
    80003638:	02813083          	ld	ra,40(sp)
    8000363c:	02013403          	ld	s0,32(sp)
    80003640:	01813483          	ld	s1,24(sp)
    80003644:	01013903          	ld	s2,16(sp)
    80003648:	00813983          	ld	s3,8(sp)
    8000364c:	03010113          	addi	sp,sp,48
    80003650:	00008067          	ret

0000000080003654 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003654:	fe010113          	addi	sp,sp,-32
    80003658:	00113c23          	sd	ra,24(sp)
    8000365c:	00813823          	sd	s0,16(sp)
    80003660:	00913423          	sd	s1,8(sp)
    80003664:	01213023          	sd	s2,0(sp)
    80003668:	02010413          	addi	s0,sp,32
    8000366c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003670:	00000913          	li	s2,0
    80003674:	00c0006f          	j	80003680 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003678:	ffffe097          	auipc	ra,0xffffe
    8000367c:	358080e7          	jalr	856(ra) # 800019d0 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80003680:	00007797          	auipc	a5,0x7
    80003684:	9987a783          	lw	a5,-1640(a5) # 8000a018 <_ZL9threadEnd>
    80003688:	02079e63          	bnez	a5,800036c4 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000368c:	0004a583          	lw	a1,0(s1)
    80003690:	0305859b          	addiw	a1,a1,48
    80003694:	0084b503          	ld	a0,8(s1)
    80003698:	00001097          	auipc	ra,0x1
    8000369c:	bac080e7          	jalr	-1108(ra) # 80004244 <_ZN9BufferCPP3putEi>
        i++;
    800036a0:	0019071b          	addiw	a4,s2,1
    800036a4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800036a8:	0004a683          	lw	a3,0(s1)
    800036ac:	0026979b          	slliw	a5,a3,0x2
    800036b0:	00d787bb          	addw	a5,a5,a3
    800036b4:	0017979b          	slliw	a5,a5,0x1
    800036b8:	02f767bb          	remw	a5,a4,a5
    800036bc:	fc0792e3          	bnez	a5,80003680 <_ZN12ProducerSync8producerEPv+0x2c>
    800036c0:	fb9ff06f          	j	80003678 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800036c4:	0104b503          	ld	a0,16(s1)
    800036c8:	ffffe097          	auipc	ra,0xffffe
    800036cc:	3bc080e7          	jalr	956(ra) # 80001a84 <_ZN9Semaphore6signalEv>
}
    800036d0:	01813083          	ld	ra,24(sp)
    800036d4:	01013403          	ld	s0,16(sp)
    800036d8:	00813483          	ld	s1,8(sp)
    800036dc:	00013903          	ld	s2,0(sp)
    800036e0:	02010113          	addi	sp,sp,32
    800036e4:	00008067          	ret

00000000800036e8 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800036e8:	fd010113          	addi	sp,sp,-48
    800036ec:	02113423          	sd	ra,40(sp)
    800036f0:	02813023          	sd	s0,32(sp)
    800036f4:	00913c23          	sd	s1,24(sp)
    800036f8:	01213823          	sd	s2,16(sp)
    800036fc:	01313423          	sd	s3,8(sp)
    80003700:	01413023          	sd	s4,0(sp)
    80003704:	03010413          	addi	s0,sp,48
    80003708:	00050993          	mv	s3,a0
    8000370c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003710:	00000a13          	li	s4,0
    80003714:	01c0006f          	j	80003730 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80003718:	ffffe097          	auipc	ra,0xffffe
    8000371c:	2b8080e7          	jalr	696(ra) # 800019d0 <_ZN6Thread8dispatchEv>
    80003720:	0500006f          	j	80003770 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003724:	00a00513          	li	a0,10
    80003728:	ffffe097          	auipc	ra,0xffffe
    8000372c:	bc8080e7          	jalr	-1080(ra) # 800012f0 <_Z4putcc>
    while (!threadEnd) {
    80003730:	00007797          	auipc	a5,0x7
    80003734:	8e87a783          	lw	a5,-1816(a5) # 8000a018 <_ZL9threadEnd>
    80003738:	06079263          	bnez	a5,8000379c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    8000373c:	00893503          	ld	a0,8(s2)
    80003740:	00001097          	auipc	ra,0x1
    80003744:	b94080e7          	jalr	-1132(ra) # 800042d4 <_ZN9BufferCPP3getEv>
        i++;
    80003748:	001a049b          	addiw	s1,s4,1
    8000374c:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003750:	0ff57513          	andi	a0,a0,255
    80003754:	ffffe097          	auipc	ra,0xffffe
    80003758:	b9c080e7          	jalr	-1124(ra) # 800012f0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    8000375c:	00092703          	lw	a4,0(s2)
    80003760:	0027179b          	slliw	a5,a4,0x2
    80003764:	00e787bb          	addw	a5,a5,a4
    80003768:	02f4e7bb          	remw	a5,s1,a5
    8000376c:	fa0786e3          	beqz	a5,80003718 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003770:	05000793          	li	a5,80
    80003774:	02f4e4bb          	remw	s1,s1,a5
    80003778:	fa049ce3          	bnez	s1,80003730 <_ZN12ConsumerSync8consumerEPv+0x48>
    8000377c:	fa9ff06f          	j	80003724 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003780:	0209b783          	ld	a5,32(s3)
    80003784:	0087b503          	ld	a0,8(a5)
    80003788:	00001097          	auipc	ra,0x1
    8000378c:	b4c080e7          	jalr	-1204(ra) # 800042d4 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003790:	0ff57513          	andi	a0,a0,255
    80003794:	ffffe097          	auipc	ra,0xffffe
    80003798:	18c080e7          	jalr	396(ra) # 80001920 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    8000379c:	0209b783          	ld	a5,32(s3)
    800037a0:	0087b503          	ld	a0,8(a5)
    800037a4:	00001097          	auipc	ra,0x1
    800037a8:	bbc080e7          	jalr	-1092(ra) # 80004360 <_ZN9BufferCPP6getCntEv>
    800037ac:	fca04ae3          	bgtz	a0,80003780 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    800037b0:	01093503          	ld	a0,16(s2)
    800037b4:	ffffe097          	auipc	ra,0xffffe
    800037b8:	2d0080e7          	jalr	720(ra) # 80001a84 <_ZN9Semaphore6signalEv>
}
    800037bc:	02813083          	ld	ra,40(sp)
    800037c0:	02013403          	ld	s0,32(sp)
    800037c4:	01813483          	ld	s1,24(sp)
    800037c8:	01013903          	ld	s2,16(sp)
    800037cc:	00813983          	ld	s3,8(sp)
    800037d0:	00013a03          	ld	s4,0(sp)
    800037d4:	03010113          	addi	sp,sp,48
    800037d8:	00008067          	ret

00000000800037dc <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800037dc:	f8010113          	addi	sp,sp,-128
    800037e0:	06113c23          	sd	ra,120(sp)
    800037e4:	06813823          	sd	s0,112(sp)
    800037e8:	06913423          	sd	s1,104(sp)
    800037ec:	07213023          	sd	s2,96(sp)
    800037f0:	05313c23          	sd	s3,88(sp)
    800037f4:	05413823          	sd	s4,80(sp)
    800037f8:	05513423          	sd	s5,72(sp)
    800037fc:	05613023          	sd	s6,64(sp)
    80003800:	03713c23          	sd	s7,56(sp)
    80003804:	03813823          	sd	s8,48(sp)
    80003808:	03913423          	sd	s9,40(sp)
    8000380c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003810:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003814:	00005517          	auipc	a0,0x5
    80003818:	b8450513          	addi	a0,a0,-1148 # 80008398 <kvmincrease+0x11a8>
    8000381c:	00000097          	auipc	ra,0x0
    80003820:	604080e7          	jalr	1540(ra) # 80003e20 <_Z11printStringPKc>
    getString(input, 30);
    80003824:	01e00593          	li	a1,30
    80003828:	f8040493          	addi	s1,s0,-128
    8000382c:	00048513          	mv	a0,s1
    80003830:	00000097          	auipc	ra,0x0
    80003834:	678080e7          	jalr	1656(ra) # 80003ea8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003838:	00048513          	mv	a0,s1
    8000383c:	00000097          	auipc	ra,0x0
    80003840:	744080e7          	jalr	1860(ra) # 80003f80 <_Z11stringToIntPKc>
    80003844:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003848:	00005517          	auipc	a0,0x5
    8000384c:	b7050513          	addi	a0,a0,-1168 # 800083b8 <kvmincrease+0x11c8>
    80003850:	00000097          	auipc	ra,0x0
    80003854:	5d0080e7          	jalr	1488(ra) # 80003e20 <_Z11printStringPKc>
    getString(input, 30);
    80003858:	01e00593          	li	a1,30
    8000385c:	00048513          	mv	a0,s1
    80003860:	00000097          	auipc	ra,0x0
    80003864:	648080e7          	jalr	1608(ra) # 80003ea8 <_Z9getStringPci>
    n = stringToInt(input);
    80003868:	00048513          	mv	a0,s1
    8000386c:	00000097          	auipc	ra,0x0
    80003870:	714080e7          	jalr	1812(ra) # 80003f80 <_Z11stringToIntPKc>
    80003874:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003878:	00005517          	auipc	a0,0x5
    8000387c:	b6050513          	addi	a0,a0,-1184 # 800083d8 <kvmincrease+0x11e8>
    80003880:	00000097          	auipc	ra,0x0
    80003884:	5a0080e7          	jalr	1440(ra) # 80003e20 <_Z11printStringPKc>
    80003888:	00000613          	li	a2,0
    8000388c:	00a00593          	li	a1,10
    80003890:	00090513          	mv	a0,s2
    80003894:	00000097          	auipc	ra,0x0
    80003898:	73c080e7          	jalr	1852(ra) # 80003fd0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000389c:	00005517          	auipc	a0,0x5
    800038a0:	b5450513          	addi	a0,a0,-1196 # 800083f0 <kvmincrease+0x1200>
    800038a4:	00000097          	auipc	ra,0x0
    800038a8:	57c080e7          	jalr	1404(ra) # 80003e20 <_Z11printStringPKc>
    800038ac:	00000613          	li	a2,0
    800038b0:	00a00593          	li	a1,10
    800038b4:	00048513          	mv	a0,s1
    800038b8:	00000097          	auipc	ra,0x0
    800038bc:	718080e7          	jalr	1816(ra) # 80003fd0 <_Z8printIntiii>
    printString(".\n");
    800038c0:	00005517          	auipc	a0,0x5
    800038c4:	b4850513          	addi	a0,a0,-1208 # 80008408 <kvmincrease+0x1218>
    800038c8:	00000097          	auipc	ra,0x0
    800038cc:	558080e7          	jalr	1368(ra) # 80003e20 <_Z11printStringPKc>
    if(threadNum > n) {
    800038d0:	0324c463          	blt	s1,s2,800038f8 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800038d4:	03205c63          	blez	s2,8000390c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800038d8:	03800513          	li	a0,56
    800038dc:	ffffe097          	auipc	ra,0xffffe
    800038e0:	e98080e7          	jalr	-360(ra) # 80001774 <_Znwm>
    800038e4:	00050a93          	mv	s5,a0
    800038e8:	00048593          	mv	a1,s1
    800038ec:	00001097          	auipc	ra,0x1
    800038f0:	804080e7          	jalr	-2044(ra) # 800040f0 <_ZN9BufferCPPC1Ei>
    800038f4:	0300006f          	j	80003924 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800038f8:	00005517          	auipc	a0,0x5
    800038fc:	b1850513          	addi	a0,a0,-1256 # 80008410 <kvmincrease+0x1220>
    80003900:	00000097          	auipc	ra,0x0
    80003904:	520080e7          	jalr	1312(ra) # 80003e20 <_Z11printStringPKc>
        return;
    80003908:	0140006f          	j	8000391c <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000390c:	00005517          	auipc	a0,0x5
    80003910:	b4450513          	addi	a0,a0,-1212 # 80008450 <kvmincrease+0x1260>
    80003914:	00000097          	auipc	ra,0x0
    80003918:	50c080e7          	jalr	1292(ra) # 80003e20 <_Z11printStringPKc>
        return;
    8000391c:	000b8113          	mv	sp,s7
    80003920:	2380006f          	j	80003b58 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003924:	01000513          	li	a0,16
    80003928:	ffffe097          	auipc	ra,0xffffe
    8000392c:	e4c080e7          	jalr	-436(ra) # 80001774 <_Znwm>
    80003930:	00050493          	mv	s1,a0
    80003934:	00000593          	li	a1,0
    80003938:	ffffe097          	auipc	ra,0xffffe
    8000393c:	178080e7          	jalr	376(ra) # 80001ab0 <_ZN9SemaphoreC1Ej>
    80003940:	00006797          	auipc	a5,0x6
    80003944:	6e97b023          	sd	s1,1760(a5) # 8000a020 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003948:	00391793          	slli	a5,s2,0x3
    8000394c:	00f78793          	addi	a5,a5,15
    80003950:	ff07f793          	andi	a5,a5,-16
    80003954:	40f10133          	sub	sp,sp,a5
    80003958:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000395c:	0019071b          	addiw	a4,s2,1
    80003960:	00171793          	slli	a5,a4,0x1
    80003964:	00e787b3          	add	a5,a5,a4
    80003968:	00379793          	slli	a5,a5,0x3
    8000396c:	00f78793          	addi	a5,a5,15
    80003970:	ff07f793          	andi	a5,a5,-16
    80003974:	40f10133          	sub	sp,sp,a5
    80003978:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000397c:	00191c13          	slli	s8,s2,0x1
    80003980:	012c07b3          	add	a5,s8,s2
    80003984:	00379793          	slli	a5,a5,0x3
    80003988:	00fa07b3          	add	a5,s4,a5
    8000398c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003990:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003994:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003998:	02800513          	li	a0,40
    8000399c:	ffffe097          	auipc	ra,0xffffe
    800039a0:	dd8080e7          	jalr	-552(ra) # 80001774 <_Znwm>
    800039a4:	00050b13          	mv	s6,a0
    800039a8:	012c0c33          	add	s8,s8,s2
    800039ac:	003c1c13          	slli	s8,s8,0x3
    800039b0:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    800039b4:	ffffe097          	auipc	ra,0xffffe
    800039b8:	044080e7          	jalr	68(ra) # 800019f8 <_ZN6ThreadC1Ev>
    800039bc:	00006797          	auipc	a5,0x6
    800039c0:	58478793          	addi	a5,a5,1412 # 80009f40 <_ZTV12ConsumerSync+0x10>
    800039c4:	00fb3023          	sd	a5,0(s6)
    800039c8:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    800039cc:	000b0513          	mv	a0,s6
    800039d0:	ffffe097          	auipc	ra,0xffffe
    800039d4:	fcc080e7          	jalr	-52(ra) # 8000199c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800039d8:	00000493          	li	s1,0
    800039dc:	0380006f          	j	80003a14 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800039e0:	00006797          	auipc	a5,0x6
    800039e4:	53878793          	addi	a5,a5,1336 # 80009f18 <_ZTV12ProducerSync+0x10>
    800039e8:	00fcb023          	sd	a5,0(s9)
    800039ec:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    800039f0:	00349793          	slli	a5,s1,0x3
    800039f4:	00f987b3          	add	a5,s3,a5
    800039f8:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800039fc:	00349793          	slli	a5,s1,0x3
    80003a00:	00f987b3          	add	a5,s3,a5
    80003a04:	0007b503          	ld	a0,0(a5)
    80003a08:	ffffe097          	auipc	ra,0xffffe
    80003a0c:	f94080e7          	jalr	-108(ra) # 8000199c <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003a10:	0014849b          	addiw	s1,s1,1
    80003a14:	0b24d063          	bge	s1,s2,80003ab4 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003a18:	00149793          	slli	a5,s1,0x1
    80003a1c:	009787b3          	add	a5,a5,s1
    80003a20:	00379793          	slli	a5,a5,0x3
    80003a24:	00fa07b3          	add	a5,s4,a5
    80003a28:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003a2c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003a30:	00006717          	auipc	a4,0x6
    80003a34:	5f073703          	ld	a4,1520(a4) # 8000a020 <_ZL10waitForAll>
    80003a38:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003a3c:	02905863          	blez	s1,80003a6c <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003a40:	02800513          	li	a0,40
    80003a44:	ffffe097          	auipc	ra,0xffffe
    80003a48:	d30080e7          	jalr	-720(ra) # 80001774 <_Znwm>
    80003a4c:	00050c93          	mv	s9,a0
    80003a50:	00149c13          	slli	s8,s1,0x1
    80003a54:	009c0c33          	add	s8,s8,s1
    80003a58:	003c1c13          	slli	s8,s8,0x3
    80003a5c:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003a60:	ffffe097          	auipc	ra,0xffffe
    80003a64:	f98080e7          	jalr	-104(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80003a68:	f79ff06f          	j	800039e0 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80003a6c:	02800513          	li	a0,40
    80003a70:	ffffe097          	auipc	ra,0xffffe
    80003a74:	d04080e7          	jalr	-764(ra) # 80001774 <_Znwm>
    80003a78:	00050c93          	mv	s9,a0
    80003a7c:	00149c13          	slli	s8,s1,0x1
    80003a80:	009c0c33          	add	s8,s8,s1
    80003a84:	003c1c13          	slli	s8,s8,0x3
    80003a88:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003a8c:	ffffe097          	auipc	ra,0xffffe
    80003a90:	f6c080e7          	jalr	-148(ra) # 800019f8 <_ZN6ThreadC1Ev>
    80003a94:	00006797          	auipc	a5,0x6
    80003a98:	45c78793          	addi	a5,a5,1116 # 80009ef0 <_ZTV16ProducerKeyboard+0x10>
    80003a9c:	00fcb023          	sd	a5,0(s9)
    80003aa0:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80003aa4:	00349793          	slli	a5,s1,0x3
    80003aa8:	00f987b3          	add	a5,s3,a5
    80003aac:	0197b023          	sd	s9,0(a5)
    80003ab0:	f4dff06f          	j	800039fc <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80003ab4:	ffffe097          	auipc	ra,0xffffe
    80003ab8:	f1c080e7          	jalr	-228(ra) # 800019d0 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003abc:	00000493          	li	s1,0
    80003ac0:	00994e63          	blt	s2,s1,80003adc <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80003ac4:	00006517          	auipc	a0,0x6
    80003ac8:	55c53503          	ld	a0,1372(a0) # 8000a020 <_ZL10waitForAll>
    80003acc:	ffffe097          	auipc	ra,0xffffe
    80003ad0:	f8c080e7          	jalr	-116(ra) # 80001a58 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003ad4:	0014849b          	addiw	s1,s1,1
    80003ad8:	fe9ff06f          	j	80003ac0 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003adc:	00000493          	li	s1,0
    80003ae0:	0080006f          	j	80003ae8 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003ae4:	0014849b          	addiw	s1,s1,1
    80003ae8:	0324d263          	bge	s1,s2,80003b0c <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003aec:	00349793          	slli	a5,s1,0x3
    80003af0:	00f987b3          	add	a5,s3,a5
    80003af4:	0007b503          	ld	a0,0(a5)
    80003af8:	fe0506e3          	beqz	a0,80003ae4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003afc:	00053783          	ld	a5,0(a0)
    80003b00:	0087b783          	ld	a5,8(a5)
    80003b04:	000780e7          	jalr	a5
    80003b08:	fddff06f          	j	80003ae4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003b0c:	000b0a63          	beqz	s6,80003b20 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003b10:	000b3783          	ld	a5,0(s6)
    80003b14:	0087b783          	ld	a5,8(a5)
    80003b18:	000b0513          	mv	a0,s6
    80003b1c:	000780e7          	jalr	a5
    delete waitForAll;
    80003b20:	00006517          	auipc	a0,0x6
    80003b24:	50053503          	ld	a0,1280(a0) # 8000a020 <_ZL10waitForAll>
    80003b28:	00050863          	beqz	a0,80003b38 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003b2c:	00053783          	ld	a5,0(a0)
    80003b30:	0087b783          	ld	a5,8(a5)
    80003b34:	000780e7          	jalr	a5
    delete buffer;
    80003b38:	000a8e63          	beqz	s5,80003b54 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003b3c:	000a8513          	mv	a0,s5
    80003b40:	00001097          	auipc	ra,0x1
    80003b44:	8a8080e7          	jalr	-1880(ra) # 800043e8 <_ZN9BufferCPPD1Ev>
    80003b48:	000a8513          	mv	a0,s5
    80003b4c:	ffffe097          	auipc	ra,0xffffe
    80003b50:	c78080e7          	jalr	-904(ra) # 800017c4 <_ZdlPv>
    80003b54:	000b8113          	mv	sp,s7

}
    80003b58:	f8040113          	addi	sp,s0,-128
    80003b5c:	07813083          	ld	ra,120(sp)
    80003b60:	07013403          	ld	s0,112(sp)
    80003b64:	06813483          	ld	s1,104(sp)
    80003b68:	06013903          	ld	s2,96(sp)
    80003b6c:	05813983          	ld	s3,88(sp)
    80003b70:	05013a03          	ld	s4,80(sp)
    80003b74:	04813a83          	ld	s5,72(sp)
    80003b78:	04013b03          	ld	s6,64(sp)
    80003b7c:	03813b83          	ld	s7,56(sp)
    80003b80:	03013c03          	ld	s8,48(sp)
    80003b84:	02813c83          	ld	s9,40(sp)
    80003b88:	08010113          	addi	sp,sp,128
    80003b8c:	00008067          	ret
    80003b90:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003b94:	000a8513          	mv	a0,s5
    80003b98:	ffffe097          	auipc	ra,0xffffe
    80003b9c:	c2c080e7          	jalr	-980(ra) # 800017c4 <_ZdlPv>
    80003ba0:	00048513          	mv	a0,s1
    80003ba4:	00007097          	auipc	ra,0x7
    80003ba8:	564080e7          	jalr	1380(ra) # 8000b108 <_Unwind_Resume>
    80003bac:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003bb0:	00048513          	mv	a0,s1
    80003bb4:	ffffe097          	auipc	ra,0xffffe
    80003bb8:	c10080e7          	jalr	-1008(ra) # 800017c4 <_ZdlPv>
    80003bbc:	00090513          	mv	a0,s2
    80003bc0:	00007097          	auipc	ra,0x7
    80003bc4:	548080e7          	jalr	1352(ra) # 8000b108 <_Unwind_Resume>
    80003bc8:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003bcc:	000b0513          	mv	a0,s6
    80003bd0:	ffffe097          	auipc	ra,0xffffe
    80003bd4:	bf4080e7          	jalr	-1036(ra) # 800017c4 <_ZdlPv>
    80003bd8:	00048513          	mv	a0,s1
    80003bdc:	00007097          	auipc	ra,0x7
    80003be0:	52c080e7          	jalr	1324(ra) # 8000b108 <_Unwind_Resume>
    80003be4:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003be8:	000c8513          	mv	a0,s9
    80003bec:	ffffe097          	auipc	ra,0xffffe
    80003bf0:	bd8080e7          	jalr	-1064(ra) # 800017c4 <_ZdlPv>
    80003bf4:	00048513          	mv	a0,s1
    80003bf8:	00007097          	auipc	ra,0x7
    80003bfc:	510080e7          	jalr	1296(ra) # 8000b108 <_Unwind_Resume>
    80003c00:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003c04:	000c8513          	mv	a0,s9
    80003c08:	ffffe097          	auipc	ra,0xffffe
    80003c0c:	bbc080e7          	jalr	-1092(ra) # 800017c4 <_ZdlPv>
    80003c10:	00048513          	mv	a0,s1
    80003c14:	00007097          	auipc	ra,0x7
    80003c18:	4f4080e7          	jalr	1268(ra) # 8000b108 <_Unwind_Resume>

0000000080003c1c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003c1c:	ff010113          	addi	sp,sp,-16
    80003c20:	00113423          	sd	ra,8(sp)
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	01010413          	addi	s0,sp,16
    80003c2c:	00006797          	auipc	a5,0x6
    80003c30:	31478793          	addi	a5,a5,788 # 80009f40 <_ZTV12ConsumerSync+0x10>
    80003c34:	00f53023          	sd	a5,0(a0)
    80003c38:	ffffe097          	auipc	ra,0xffffe
    80003c3c:	bdc080e7          	jalr	-1060(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003c40:	00813083          	ld	ra,8(sp)
    80003c44:	00013403          	ld	s0,0(sp)
    80003c48:	01010113          	addi	sp,sp,16
    80003c4c:	00008067          	ret

0000000080003c50 <_ZN12ConsumerSyncD0Ev>:
    80003c50:	fe010113          	addi	sp,sp,-32
    80003c54:	00113c23          	sd	ra,24(sp)
    80003c58:	00813823          	sd	s0,16(sp)
    80003c5c:	00913423          	sd	s1,8(sp)
    80003c60:	02010413          	addi	s0,sp,32
    80003c64:	00050493          	mv	s1,a0
    80003c68:	00006797          	auipc	a5,0x6
    80003c6c:	2d878793          	addi	a5,a5,728 # 80009f40 <_ZTV12ConsumerSync+0x10>
    80003c70:	00f53023          	sd	a5,0(a0)
    80003c74:	ffffe097          	auipc	ra,0xffffe
    80003c78:	ba0080e7          	jalr	-1120(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003c7c:	00048513          	mv	a0,s1
    80003c80:	ffffe097          	auipc	ra,0xffffe
    80003c84:	b44080e7          	jalr	-1212(ra) # 800017c4 <_ZdlPv>
    80003c88:	01813083          	ld	ra,24(sp)
    80003c8c:	01013403          	ld	s0,16(sp)
    80003c90:	00813483          	ld	s1,8(sp)
    80003c94:	02010113          	addi	sp,sp,32
    80003c98:	00008067          	ret

0000000080003c9c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003c9c:	ff010113          	addi	sp,sp,-16
    80003ca0:	00113423          	sd	ra,8(sp)
    80003ca4:	00813023          	sd	s0,0(sp)
    80003ca8:	01010413          	addi	s0,sp,16
    80003cac:	00006797          	auipc	a5,0x6
    80003cb0:	26c78793          	addi	a5,a5,620 # 80009f18 <_ZTV12ProducerSync+0x10>
    80003cb4:	00f53023          	sd	a5,0(a0)
    80003cb8:	ffffe097          	auipc	ra,0xffffe
    80003cbc:	b5c080e7          	jalr	-1188(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003cc0:	00813083          	ld	ra,8(sp)
    80003cc4:	00013403          	ld	s0,0(sp)
    80003cc8:	01010113          	addi	sp,sp,16
    80003ccc:	00008067          	ret

0000000080003cd0 <_ZN12ProducerSyncD0Ev>:
    80003cd0:	fe010113          	addi	sp,sp,-32
    80003cd4:	00113c23          	sd	ra,24(sp)
    80003cd8:	00813823          	sd	s0,16(sp)
    80003cdc:	00913423          	sd	s1,8(sp)
    80003ce0:	02010413          	addi	s0,sp,32
    80003ce4:	00050493          	mv	s1,a0
    80003ce8:	00006797          	auipc	a5,0x6
    80003cec:	23078793          	addi	a5,a5,560 # 80009f18 <_ZTV12ProducerSync+0x10>
    80003cf0:	00f53023          	sd	a5,0(a0)
    80003cf4:	ffffe097          	auipc	ra,0xffffe
    80003cf8:	b20080e7          	jalr	-1248(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003cfc:	00048513          	mv	a0,s1
    80003d00:	ffffe097          	auipc	ra,0xffffe
    80003d04:	ac4080e7          	jalr	-1340(ra) # 800017c4 <_ZdlPv>
    80003d08:	01813083          	ld	ra,24(sp)
    80003d0c:	01013403          	ld	s0,16(sp)
    80003d10:	00813483          	ld	s1,8(sp)
    80003d14:	02010113          	addi	sp,sp,32
    80003d18:	00008067          	ret

0000000080003d1c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80003d1c:	ff010113          	addi	sp,sp,-16
    80003d20:	00113423          	sd	ra,8(sp)
    80003d24:	00813023          	sd	s0,0(sp)
    80003d28:	01010413          	addi	s0,sp,16
    80003d2c:	00006797          	auipc	a5,0x6
    80003d30:	1c478793          	addi	a5,a5,452 # 80009ef0 <_ZTV16ProducerKeyboard+0x10>
    80003d34:	00f53023          	sd	a5,0(a0)
    80003d38:	ffffe097          	auipc	ra,0xffffe
    80003d3c:	adc080e7          	jalr	-1316(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003d40:	00813083          	ld	ra,8(sp)
    80003d44:	00013403          	ld	s0,0(sp)
    80003d48:	01010113          	addi	sp,sp,16
    80003d4c:	00008067          	ret

0000000080003d50 <_ZN16ProducerKeyboardD0Ev>:
    80003d50:	fe010113          	addi	sp,sp,-32
    80003d54:	00113c23          	sd	ra,24(sp)
    80003d58:	00813823          	sd	s0,16(sp)
    80003d5c:	00913423          	sd	s1,8(sp)
    80003d60:	02010413          	addi	s0,sp,32
    80003d64:	00050493          	mv	s1,a0
    80003d68:	00006797          	auipc	a5,0x6
    80003d6c:	18878793          	addi	a5,a5,392 # 80009ef0 <_ZTV16ProducerKeyboard+0x10>
    80003d70:	00f53023          	sd	a5,0(a0)
    80003d74:	ffffe097          	auipc	ra,0xffffe
    80003d78:	aa0080e7          	jalr	-1376(ra) # 80001814 <_ZN6ThreadD1Ev>
    80003d7c:	00048513          	mv	a0,s1
    80003d80:	ffffe097          	auipc	ra,0xffffe
    80003d84:	a44080e7          	jalr	-1468(ra) # 800017c4 <_ZdlPv>
    80003d88:	01813083          	ld	ra,24(sp)
    80003d8c:	01013403          	ld	s0,16(sp)
    80003d90:	00813483          	ld	s1,8(sp)
    80003d94:	02010113          	addi	sp,sp,32
    80003d98:	00008067          	ret

0000000080003d9c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003d9c:	ff010113          	addi	sp,sp,-16
    80003da0:	00113423          	sd	ra,8(sp)
    80003da4:	00813023          	sd	s0,0(sp)
    80003da8:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003dac:	02053583          	ld	a1,32(a0)
    80003db0:	fffff097          	auipc	ra,0xfffff
    80003db4:	7e4080e7          	jalr	2020(ra) # 80003594 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003db8:	00813083          	ld	ra,8(sp)
    80003dbc:	00013403          	ld	s0,0(sp)
    80003dc0:	01010113          	addi	sp,sp,16
    80003dc4:	00008067          	ret

0000000080003dc8 <_ZN12ProducerSync3runEv>:
    void run() override {
    80003dc8:	ff010113          	addi	sp,sp,-16
    80003dcc:	00113423          	sd	ra,8(sp)
    80003dd0:	00813023          	sd	s0,0(sp)
    80003dd4:	01010413          	addi	s0,sp,16
        producer(td);
    80003dd8:	02053583          	ld	a1,32(a0)
    80003ddc:	00000097          	auipc	ra,0x0
    80003de0:	878080e7          	jalr	-1928(ra) # 80003654 <_ZN12ProducerSync8producerEPv>
    }
    80003de4:	00813083          	ld	ra,8(sp)
    80003de8:	00013403          	ld	s0,0(sp)
    80003dec:	01010113          	addi	sp,sp,16
    80003df0:	00008067          	ret

0000000080003df4 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80003df4:	ff010113          	addi	sp,sp,-16
    80003df8:	00113423          	sd	ra,8(sp)
    80003dfc:	00813023          	sd	s0,0(sp)
    80003e00:	01010413          	addi	s0,sp,16
        consumer(td);
    80003e04:	02053583          	ld	a1,32(a0)
    80003e08:	00000097          	auipc	ra,0x0
    80003e0c:	8e0080e7          	jalr	-1824(ra) # 800036e8 <_ZN12ConsumerSync8consumerEPv>
    }
    80003e10:	00813083          	ld	ra,8(sp)
    80003e14:	00013403          	ld	s0,0(sp)
    80003e18:	01010113          	addi	sp,sp,16
    80003e1c:	00008067          	ret

0000000080003e20 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80003e20:	fe010113          	addi	sp,sp,-32
    80003e24:	00113c23          	sd	ra,24(sp)
    80003e28:	00813823          	sd	s0,16(sp)
    80003e2c:	00913423          	sd	s1,8(sp)
    80003e30:	02010413          	addi	s0,sp,32
    80003e34:	00050493          	mv	s1,a0
    LOCK();
    80003e38:	00100613          	li	a2,1
    80003e3c:	00000593          	li	a1,0
    80003e40:	00006517          	auipc	a0,0x6
    80003e44:	1e850513          	addi	a0,a0,488 # 8000a028 <lockPrint>
    80003e48:	ffffd097          	auipc	ra,0xffffd
    80003e4c:	1b8080e7          	jalr	440(ra) # 80001000 <copy_and_swap>
    80003e50:	00050863          	beqz	a0,80003e60 <_Z11printStringPKc+0x40>
    80003e54:	ffffd097          	auipc	ra,0xffffd
    80003e58:	39c080e7          	jalr	924(ra) # 800011f0 <_Z15thread_dispatchv>
    80003e5c:	fddff06f          	j	80003e38 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80003e60:	0004c503          	lbu	a0,0(s1)
    80003e64:	00050a63          	beqz	a0,80003e78 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80003e68:	ffffd097          	auipc	ra,0xffffd
    80003e6c:	488080e7          	jalr	1160(ra) # 800012f0 <_Z4putcc>
        string++;
    80003e70:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80003e74:	fedff06f          	j	80003e60 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80003e78:	00000613          	li	a2,0
    80003e7c:	00100593          	li	a1,1
    80003e80:	00006517          	auipc	a0,0x6
    80003e84:	1a850513          	addi	a0,a0,424 # 8000a028 <lockPrint>
    80003e88:	ffffd097          	auipc	ra,0xffffd
    80003e8c:	178080e7          	jalr	376(ra) # 80001000 <copy_and_swap>
    80003e90:	fe0514e3          	bnez	a0,80003e78 <_Z11printStringPKc+0x58>
}
    80003e94:	01813083          	ld	ra,24(sp)
    80003e98:	01013403          	ld	s0,16(sp)
    80003e9c:	00813483          	ld	s1,8(sp)
    80003ea0:	02010113          	addi	sp,sp,32
    80003ea4:	00008067          	ret

0000000080003ea8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80003ea8:	fd010113          	addi	sp,sp,-48
    80003eac:	02113423          	sd	ra,40(sp)
    80003eb0:	02813023          	sd	s0,32(sp)
    80003eb4:	00913c23          	sd	s1,24(sp)
    80003eb8:	01213823          	sd	s2,16(sp)
    80003ebc:	01313423          	sd	s3,8(sp)
    80003ec0:	01413023          	sd	s4,0(sp)
    80003ec4:	03010413          	addi	s0,sp,48
    80003ec8:	00050993          	mv	s3,a0
    80003ecc:	00058a13          	mv	s4,a1
    LOCK();
    80003ed0:	00100613          	li	a2,1
    80003ed4:	00000593          	li	a1,0
    80003ed8:	00006517          	auipc	a0,0x6
    80003edc:	15050513          	addi	a0,a0,336 # 8000a028 <lockPrint>
    80003ee0:	ffffd097          	auipc	ra,0xffffd
    80003ee4:	120080e7          	jalr	288(ra) # 80001000 <copy_and_swap>
    80003ee8:	00050863          	beqz	a0,80003ef8 <_Z9getStringPci+0x50>
    80003eec:	ffffd097          	auipc	ra,0xffffd
    80003ef0:	304080e7          	jalr	772(ra) # 800011f0 <_Z15thread_dispatchv>
    80003ef4:	fddff06f          	j	80003ed0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80003ef8:	00000913          	li	s2,0
    80003efc:	00090493          	mv	s1,s2
    80003f00:	0019091b          	addiw	s2,s2,1
    80003f04:	03495a63          	bge	s2,s4,80003f38 <_Z9getStringPci+0x90>
        cc = getc();
    80003f08:	ffffd097          	auipc	ra,0xffffd
    80003f0c:	3bc080e7          	jalr	956(ra) # 800012c4 <_Z4getcv>
        if(cc < 1)
    80003f10:	02050463          	beqz	a0,80003f38 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80003f14:	009984b3          	add	s1,s3,s1
    80003f18:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80003f1c:	00a00793          	li	a5,10
    80003f20:	00f50a63          	beq	a0,a5,80003f34 <_Z9getStringPci+0x8c>
    80003f24:	00d00793          	li	a5,13
    80003f28:	fcf51ae3          	bne	a0,a5,80003efc <_Z9getStringPci+0x54>
        buf[i++] = c;
    80003f2c:	00090493          	mv	s1,s2
    80003f30:	0080006f          	j	80003f38 <_Z9getStringPci+0x90>
    80003f34:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80003f38:	009984b3          	add	s1,s3,s1
    80003f3c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80003f40:	00000613          	li	a2,0
    80003f44:	00100593          	li	a1,1
    80003f48:	00006517          	auipc	a0,0x6
    80003f4c:	0e050513          	addi	a0,a0,224 # 8000a028 <lockPrint>
    80003f50:	ffffd097          	auipc	ra,0xffffd
    80003f54:	0b0080e7          	jalr	176(ra) # 80001000 <copy_and_swap>
    80003f58:	fe0514e3          	bnez	a0,80003f40 <_Z9getStringPci+0x98>
    return buf;
}
    80003f5c:	00098513          	mv	a0,s3
    80003f60:	02813083          	ld	ra,40(sp)
    80003f64:	02013403          	ld	s0,32(sp)
    80003f68:	01813483          	ld	s1,24(sp)
    80003f6c:	01013903          	ld	s2,16(sp)
    80003f70:	00813983          	ld	s3,8(sp)
    80003f74:	00013a03          	ld	s4,0(sp)
    80003f78:	03010113          	addi	sp,sp,48
    80003f7c:	00008067          	ret

0000000080003f80 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80003f80:	ff010113          	addi	sp,sp,-16
    80003f84:	00813423          	sd	s0,8(sp)
    80003f88:	01010413          	addi	s0,sp,16
    80003f8c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80003f90:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80003f94:	0006c603          	lbu	a2,0(a3)
    80003f98:	fd06071b          	addiw	a4,a2,-48
    80003f9c:	0ff77713          	andi	a4,a4,255
    80003fa0:	00900793          	li	a5,9
    80003fa4:	02e7e063          	bltu	a5,a4,80003fc4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80003fa8:	0025179b          	slliw	a5,a0,0x2
    80003fac:	00a787bb          	addw	a5,a5,a0
    80003fb0:	0017979b          	slliw	a5,a5,0x1
    80003fb4:	00168693          	addi	a3,a3,1
    80003fb8:	00c787bb          	addw	a5,a5,a2
    80003fbc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80003fc0:	fd5ff06f          	j	80003f94 <_Z11stringToIntPKc+0x14>
    return n;
}
    80003fc4:	00813403          	ld	s0,8(sp)
    80003fc8:	01010113          	addi	sp,sp,16
    80003fcc:	00008067          	ret

0000000080003fd0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80003fd0:	fc010113          	addi	sp,sp,-64
    80003fd4:	02113c23          	sd	ra,56(sp)
    80003fd8:	02813823          	sd	s0,48(sp)
    80003fdc:	02913423          	sd	s1,40(sp)
    80003fe0:	03213023          	sd	s2,32(sp)
    80003fe4:	01313c23          	sd	s3,24(sp)
    80003fe8:	04010413          	addi	s0,sp,64
    80003fec:	00050493          	mv	s1,a0
    80003ff0:	00058913          	mv	s2,a1
    80003ff4:	00060993          	mv	s3,a2
    LOCK();
    80003ff8:	00100613          	li	a2,1
    80003ffc:	00000593          	li	a1,0
    80004000:	00006517          	auipc	a0,0x6
    80004004:	02850513          	addi	a0,a0,40 # 8000a028 <lockPrint>
    80004008:	ffffd097          	auipc	ra,0xffffd
    8000400c:	ff8080e7          	jalr	-8(ra) # 80001000 <copy_and_swap>
    80004010:	00050863          	beqz	a0,80004020 <_Z8printIntiii+0x50>
    80004014:	ffffd097          	auipc	ra,0xffffd
    80004018:	1dc080e7          	jalr	476(ra) # 800011f0 <_Z15thread_dispatchv>
    8000401c:	fddff06f          	j	80003ff8 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004020:	00098463          	beqz	s3,80004028 <_Z8printIntiii+0x58>
    80004024:	0804c463          	bltz	s1,800040ac <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004028:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000402c:	00000593          	li	a1,0
    }

    i = 0;
    80004030:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004034:	0009079b          	sext.w	a5,s2
    80004038:	0325773b          	remuw	a4,a0,s2
    8000403c:	00048613          	mv	a2,s1
    80004040:	0014849b          	addiw	s1,s1,1
    80004044:	02071693          	slli	a3,a4,0x20
    80004048:	0206d693          	srli	a3,a3,0x20
    8000404c:	00006717          	auipc	a4,0x6
    80004050:	f0c70713          	addi	a4,a4,-244 # 80009f58 <digits>
    80004054:	00d70733          	add	a4,a4,a3
    80004058:	00074683          	lbu	a3,0(a4)
    8000405c:	fd040713          	addi	a4,s0,-48
    80004060:	00c70733          	add	a4,a4,a2
    80004064:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004068:	0005071b          	sext.w	a4,a0
    8000406c:	0325553b          	divuw	a0,a0,s2
    80004070:	fcf772e3          	bgeu	a4,a5,80004034 <_Z8printIntiii+0x64>
    if(neg)
    80004074:	00058c63          	beqz	a1,8000408c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004078:	fd040793          	addi	a5,s0,-48
    8000407c:	009784b3          	add	s1,a5,s1
    80004080:	02d00793          	li	a5,45
    80004084:	fef48823          	sb	a5,-16(s1)
    80004088:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000408c:	fff4849b          	addiw	s1,s1,-1
    80004090:	0204c463          	bltz	s1,800040b8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004094:	fd040793          	addi	a5,s0,-48
    80004098:	009787b3          	add	a5,a5,s1
    8000409c:	ff07c503          	lbu	a0,-16(a5)
    800040a0:	ffffd097          	auipc	ra,0xffffd
    800040a4:	250080e7          	jalr	592(ra) # 800012f0 <_Z4putcc>
    800040a8:	fe5ff06f          	j	8000408c <_Z8printIntiii+0xbc>
        x = -xx;
    800040ac:	4090053b          	negw	a0,s1
        neg = 1;
    800040b0:	00100593          	li	a1,1
        x = -xx;
    800040b4:	f7dff06f          	j	80004030 <_Z8printIntiii+0x60>

    UNLOCK();
    800040b8:	00000613          	li	a2,0
    800040bc:	00100593          	li	a1,1
    800040c0:	00006517          	auipc	a0,0x6
    800040c4:	f6850513          	addi	a0,a0,-152 # 8000a028 <lockPrint>
    800040c8:	ffffd097          	auipc	ra,0xffffd
    800040cc:	f38080e7          	jalr	-200(ra) # 80001000 <copy_and_swap>
    800040d0:	fe0514e3          	bnez	a0,800040b8 <_Z8printIntiii+0xe8>
    800040d4:	03813083          	ld	ra,56(sp)
    800040d8:	03013403          	ld	s0,48(sp)
    800040dc:	02813483          	ld	s1,40(sp)
    800040e0:	02013903          	ld	s2,32(sp)
    800040e4:	01813983          	ld	s3,24(sp)
    800040e8:	04010113          	addi	sp,sp,64
    800040ec:	00008067          	ret

00000000800040f0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800040f0:	fd010113          	addi	sp,sp,-48
    800040f4:	02113423          	sd	ra,40(sp)
    800040f8:	02813023          	sd	s0,32(sp)
    800040fc:	00913c23          	sd	s1,24(sp)
    80004100:	01213823          	sd	s2,16(sp)
    80004104:	01313423          	sd	s3,8(sp)
    80004108:	03010413          	addi	s0,sp,48
    8000410c:	00050493          	mv	s1,a0
    80004110:	00058913          	mv	s2,a1
    80004114:	0015879b          	addiw	a5,a1,1
    80004118:	0007851b          	sext.w	a0,a5
    8000411c:	00f4a023          	sw	a5,0(s1)
    80004120:	0004a823          	sw	zero,16(s1)
    80004124:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004128:	00251513          	slli	a0,a0,0x2
    8000412c:	ffffd097          	auipc	ra,0xffffd
    80004130:	018080e7          	jalr	24(ra) # 80001144 <_Z9mem_allocm>
    80004134:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004138:	01000513          	li	a0,16
    8000413c:	ffffd097          	auipc	ra,0xffffd
    80004140:	638080e7          	jalr	1592(ra) # 80001774 <_Znwm>
    80004144:	00050993          	mv	s3,a0
    80004148:	00000593          	li	a1,0
    8000414c:	ffffe097          	auipc	ra,0xffffe
    80004150:	964080e7          	jalr	-1692(ra) # 80001ab0 <_ZN9SemaphoreC1Ej>
    80004154:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004158:	01000513          	li	a0,16
    8000415c:	ffffd097          	auipc	ra,0xffffd
    80004160:	618080e7          	jalr	1560(ra) # 80001774 <_Znwm>
    80004164:	00050993          	mv	s3,a0
    80004168:	00090593          	mv	a1,s2
    8000416c:	ffffe097          	auipc	ra,0xffffe
    80004170:	944080e7          	jalr	-1724(ra) # 80001ab0 <_ZN9SemaphoreC1Ej>
    80004174:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004178:	01000513          	li	a0,16
    8000417c:	ffffd097          	auipc	ra,0xffffd
    80004180:	5f8080e7          	jalr	1528(ra) # 80001774 <_Znwm>
    80004184:	00050913          	mv	s2,a0
    80004188:	00100593          	li	a1,1
    8000418c:	ffffe097          	auipc	ra,0xffffe
    80004190:	924080e7          	jalr	-1756(ra) # 80001ab0 <_ZN9SemaphoreC1Ej>
    80004194:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004198:	01000513          	li	a0,16
    8000419c:	ffffd097          	auipc	ra,0xffffd
    800041a0:	5d8080e7          	jalr	1496(ra) # 80001774 <_Znwm>
    800041a4:	00050913          	mv	s2,a0
    800041a8:	00100593          	li	a1,1
    800041ac:	ffffe097          	auipc	ra,0xffffe
    800041b0:	904080e7          	jalr	-1788(ra) # 80001ab0 <_ZN9SemaphoreC1Ej>
    800041b4:	0324b823          	sd	s2,48(s1)
}
    800041b8:	02813083          	ld	ra,40(sp)
    800041bc:	02013403          	ld	s0,32(sp)
    800041c0:	01813483          	ld	s1,24(sp)
    800041c4:	01013903          	ld	s2,16(sp)
    800041c8:	00813983          	ld	s3,8(sp)
    800041cc:	03010113          	addi	sp,sp,48
    800041d0:	00008067          	ret
    800041d4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800041d8:	00098513          	mv	a0,s3
    800041dc:	ffffd097          	auipc	ra,0xffffd
    800041e0:	5e8080e7          	jalr	1512(ra) # 800017c4 <_ZdlPv>
    800041e4:	00048513          	mv	a0,s1
    800041e8:	00007097          	auipc	ra,0x7
    800041ec:	f20080e7          	jalr	-224(ra) # 8000b108 <_Unwind_Resume>
    800041f0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800041f4:	00098513          	mv	a0,s3
    800041f8:	ffffd097          	auipc	ra,0xffffd
    800041fc:	5cc080e7          	jalr	1484(ra) # 800017c4 <_ZdlPv>
    80004200:	00048513          	mv	a0,s1
    80004204:	00007097          	auipc	ra,0x7
    80004208:	f04080e7          	jalr	-252(ra) # 8000b108 <_Unwind_Resume>
    8000420c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004210:	00090513          	mv	a0,s2
    80004214:	ffffd097          	auipc	ra,0xffffd
    80004218:	5b0080e7          	jalr	1456(ra) # 800017c4 <_ZdlPv>
    8000421c:	00048513          	mv	a0,s1
    80004220:	00007097          	auipc	ra,0x7
    80004224:	ee8080e7          	jalr	-280(ra) # 8000b108 <_Unwind_Resume>
    80004228:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000422c:	00090513          	mv	a0,s2
    80004230:	ffffd097          	auipc	ra,0xffffd
    80004234:	594080e7          	jalr	1428(ra) # 800017c4 <_ZdlPv>
    80004238:	00048513          	mv	a0,s1
    8000423c:	00007097          	auipc	ra,0x7
    80004240:	ecc080e7          	jalr	-308(ra) # 8000b108 <_Unwind_Resume>

0000000080004244 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004244:	fe010113          	addi	sp,sp,-32
    80004248:	00113c23          	sd	ra,24(sp)
    8000424c:	00813823          	sd	s0,16(sp)
    80004250:	00913423          	sd	s1,8(sp)
    80004254:	01213023          	sd	s2,0(sp)
    80004258:	02010413          	addi	s0,sp,32
    8000425c:	00050493          	mv	s1,a0
    80004260:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004264:	01853503          	ld	a0,24(a0)
    80004268:	ffffd097          	auipc	ra,0xffffd
    8000426c:	7f0080e7          	jalr	2032(ra) # 80001a58 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004270:	0304b503          	ld	a0,48(s1)
    80004274:	ffffd097          	auipc	ra,0xffffd
    80004278:	7e4080e7          	jalr	2020(ra) # 80001a58 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000427c:	0084b783          	ld	a5,8(s1)
    80004280:	0144a703          	lw	a4,20(s1)
    80004284:	00271713          	slli	a4,a4,0x2
    80004288:	00e787b3          	add	a5,a5,a4
    8000428c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004290:	0144a783          	lw	a5,20(s1)
    80004294:	0017879b          	addiw	a5,a5,1
    80004298:	0004a703          	lw	a4,0(s1)
    8000429c:	02e7e7bb          	remw	a5,a5,a4
    800042a0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800042a4:	0304b503          	ld	a0,48(s1)
    800042a8:	ffffd097          	auipc	ra,0xffffd
    800042ac:	7dc080e7          	jalr	2012(ra) # 80001a84 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800042b0:	0204b503          	ld	a0,32(s1)
    800042b4:	ffffd097          	auipc	ra,0xffffd
    800042b8:	7d0080e7          	jalr	2000(ra) # 80001a84 <_ZN9Semaphore6signalEv>

}
    800042bc:	01813083          	ld	ra,24(sp)
    800042c0:	01013403          	ld	s0,16(sp)
    800042c4:	00813483          	ld	s1,8(sp)
    800042c8:	00013903          	ld	s2,0(sp)
    800042cc:	02010113          	addi	sp,sp,32
    800042d0:	00008067          	ret

00000000800042d4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800042d4:	fe010113          	addi	sp,sp,-32
    800042d8:	00113c23          	sd	ra,24(sp)
    800042dc:	00813823          	sd	s0,16(sp)
    800042e0:	00913423          	sd	s1,8(sp)
    800042e4:	01213023          	sd	s2,0(sp)
    800042e8:	02010413          	addi	s0,sp,32
    800042ec:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800042f0:	02053503          	ld	a0,32(a0)
    800042f4:	ffffd097          	auipc	ra,0xffffd
    800042f8:	764080e7          	jalr	1892(ra) # 80001a58 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800042fc:	0284b503          	ld	a0,40(s1)
    80004300:	ffffd097          	auipc	ra,0xffffd
    80004304:	758080e7          	jalr	1880(ra) # 80001a58 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004308:	0084b703          	ld	a4,8(s1)
    8000430c:	0104a783          	lw	a5,16(s1)
    80004310:	00279693          	slli	a3,a5,0x2
    80004314:	00d70733          	add	a4,a4,a3
    80004318:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000431c:	0017879b          	addiw	a5,a5,1
    80004320:	0004a703          	lw	a4,0(s1)
    80004324:	02e7e7bb          	remw	a5,a5,a4
    80004328:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000432c:	0284b503          	ld	a0,40(s1)
    80004330:	ffffd097          	auipc	ra,0xffffd
    80004334:	754080e7          	jalr	1876(ra) # 80001a84 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004338:	0184b503          	ld	a0,24(s1)
    8000433c:	ffffd097          	auipc	ra,0xffffd
    80004340:	748080e7          	jalr	1864(ra) # 80001a84 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004344:	00090513          	mv	a0,s2
    80004348:	01813083          	ld	ra,24(sp)
    8000434c:	01013403          	ld	s0,16(sp)
    80004350:	00813483          	ld	s1,8(sp)
    80004354:	00013903          	ld	s2,0(sp)
    80004358:	02010113          	addi	sp,sp,32
    8000435c:	00008067          	ret

0000000080004360 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004360:	fe010113          	addi	sp,sp,-32
    80004364:	00113c23          	sd	ra,24(sp)
    80004368:	00813823          	sd	s0,16(sp)
    8000436c:	00913423          	sd	s1,8(sp)
    80004370:	01213023          	sd	s2,0(sp)
    80004374:	02010413          	addi	s0,sp,32
    80004378:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000437c:	02853503          	ld	a0,40(a0)
    80004380:	ffffd097          	auipc	ra,0xffffd
    80004384:	6d8080e7          	jalr	1752(ra) # 80001a58 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004388:	0304b503          	ld	a0,48(s1)
    8000438c:	ffffd097          	auipc	ra,0xffffd
    80004390:	6cc080e7          	jalr	1740(ra) # 80001a58 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004394:	0144a783          	lw	a5,20(s1)
    80004398:	0104a903          	lw	s2,16(s1)
    8000439c:	0327ce63          	blt	a5,s2,800043d8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800043a0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800043a4:	0304b503          	ld	a0,48(s1)
    800043a8:	ffffd097          	auipc	ra,0xffffd
    800043ac:	6dc080e7          	jalr	1756(ra) # 80001a84 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800043b0:	0284b503          	ld	a0,40(s1)
    800043b4:	ffffd097          	auipc	ra,0xffffd
    800043b8:	6d0080e7          	jalr	1744(ra) # 80001a84 <_ZN9Semaphore6signalEv>

    return ret;
}
    800043bc:	00090513          	mv	a0,s2
    800043c0:	01813083          	ld	ra,24(sp)
    800043c4:	01013403          	ld	s0,16(sp)
    800043c8:	00813483          	ld	s1,8(sp)
    800043cc:	00013903          	ld	s2,0(sp)
    800043d0:	02010113          	addi	sp,sp,32
    800043d4:	00008067          	ret
        ret = cap - head + tail;
    800043d8:	0004a703          	lw	a4,0(s1)
    800043dc:	4127093b          	subw	s2,a4,s2
    800043e0:	00f9093b          	addw	s2,s2,a5
    800043e4:	fc1ff06f          	j	800043a4 <_ZN9BufferCPP6getCntEv+0x44>

00000000800043e8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800043e8:	fe010113          	addi	sp,sp,-32
    800043ec:	00113c23          	sd	ra,24(sp)
    800043f0:	00813823          	sd	s0,16(sp)
    800043f4:	00913423          	sd	s1,8(sp)
    800043f8:	02010413          	addi	s0,sp,32
    800043fc:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004400:	00a00513          	li	a0,10
    80004404:	ffffd097          	auipc	ra,0xffffd
    80004408:	51c080e7          	jalr	1308(ra) # 80001920 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000440c:	00004517          	auipc	a0,0x4
    80004410:	17c50513          	addi	a0,a0,380 # 80008588 <kvmincrease+0x1398>
    80004414:	00000097          	auipc	ra,0x0
    80004418:	a0c080e7          	jalr	-1524(ra) # 80003e20 <_Z11printStringPKc>
    while (getCnt()) {
    8000441c:	00048513          	mv	a0,s1
    80004420:	00000097          	auipc	ra,0x0
    80004424:	f40080e7          	jalr	-192(ra) # 80004360 <_ZN9BufferCPP6getCntEv>
    80004428:	02050c63          	beqz	a0,80004460 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000442c:	0084b783          	ld	a5,8(s1)
    80004430:	0104a703          	lw	a4,16(s1)
    80004434:	00271713          	slli	a4,a4,0x2
    80004438:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000443c:	0007c503          	lbu	a0,0(a5)
    80004440:	ffffd097          	auipc	ra,0xffffd
    80004444:	4e0080e7          	jalr	1248(ra) # 80001920 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004448:	0104a783          	lw	a5,16(s1)
    8000444c:	0017879b          	addiw	a5,a5,1
    80004450:	0004a703          	lw	a4,0(s1)
    80004454:	02e7e7bb          	remw	a5,a5,a4
    80004458:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000445c:	fc1ff06f          	j	8000441c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004460:	02100513          	li	a0,33
    80004464:	ffffd097          	auipc	ra,0xffffd
    80004468:	4bc080e7          	jalr	1212(ra) # 80001920 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000446c:	00a00513          	li	a0,10
    80004470:	ffffd097          	auipc	ra,0xffffd
    80004474:	4b0080e7          	jalr	1200(ra) # 80001920 <_ZN7Console4putcEc>
    mem_free(buffer);
    80004478:	0084b503          	ld	a0,8(s1)
    8000447c:	ffffd097          	auipc	ra,0xffffd
    80004480:	cf0080e7          	jalr	-784(ra) # 8000116c <_Z8mem_freePv>
    delete itemAvailable;
    80004484:	0204b503          	ld	a0,32(s1)
    80004488:	00050863          	beqz	a0,80004498 <_ZN9BufferCPPD1Ev+0xb0>
    8000448c:	00053783          	ld	a5,0(a0)
    80004490:	0087b783          	ld	a5,8(a5)
    80004494:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004498:	0184b503          	ld	a0,24(s1)
    8000449c:	00050863          	beqz	a0,800044ac <_ZN9BufferCPPD1Ev+0xc4>
    800044a0:	00053783          	ld	a5,0(a0)
    800044a4:	0087b783          	ld	a5,8(a5)
    800044a8:	000780e7          	jalr	a5
    delete mutexTail;
    800044ac:	0304b503          	ld	a0,48(s1)
    800044b0:	00050863          	beqz	a0,800044c0 <_ZN9BufferCPPD1Ev+0xd8>
    800044b4:	00053783          	ld	a5,0(a0)
    800044b8:	0087b783          	ld	a5,8(a5)
    800044bc:	000780e7          	jalr	a5
    delete mutexHead;
    800044c0:	0284b503          	ld	a0,40(s1)
    800044c4:	00050863          	beqz	a0,800044d4 <_ZN9BufferCPPD1Ev+0xec>
    800044c8:	00053783          	ld	a5,0(a0)
    800044cc:	0087b783          	ld	a5,8(a5)
    800044d0:	000780e7          	jalr	a5
}
    800044d4:	01813083          	ld	ra,24(sp)
    800044d8:	01013403          	ld	s0,16(sp)
    800044dc:	00813483          	ld	s1,8(sp)
    800044e0:	02010113          	addi	sp,sp,32
    800044e4:	00008067          	ret

00000000800044e8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800044e8:	fe010113          	addi	sp,sp,-32
    800044ec:	00113c23          	sd	ra,24(sp)
    800044f0:	00813823          	sd	s0,16(sp)
    800044f4:	00913423          	sd	s1,8(sp)
    800044f8:	01213023          	sd	s2,0(sp)
    800044fc:	02010413          	addi	s0,sp,32
    80004500:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004504:	00100793          	li	a5,1
    80004508:	02a7f863          	bgeu	a5,a0,80004538 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000450c:	00a00793          	li	a5,10
    80004510:	02f577b3          	remu	a5,a0,a5
    80004514:	02078e63          	beqz	a5,80004550 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004518:	fff48513          	addi	a0,s1,-1
    8000451c:	00000097          	auipc	ra,0x0
    80004520:	fcc080e7          	jalr	-52(ra) # 800044e8 <_ZL9fibonaccim>
    80004524:	00050913          	mv	s2,a0
    80004528:	ffe48513          	addi	a0,s1,-2
    8000452c:	00000097          	auipc	ra,0x0
    80004530:	fbc080e7          	jalr	-68(ra) # 800044e8 <_ZL9fibonaccim>
    80004534:	00a90533          	add	a0,s2,a0
}
    80004538:	01813083          	ld	ra,24(sp)
    8000453c:	01013403          	ld	s0,16(sp)
    80004540:	00813483          	ld	s1,8(sp)
    80004544:	00013903          	ld	s2,0(sp)
    80004548:	02010113          	addi	sp,sp,32
    8000454c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004550:	ffffd097          	auipc	ra,0xffffd
    80004554:	ca0080e7          	jalr	-864(ra) # 800011f0 <_Z15thread_dispatchv>
    80004558:	fc1ff06f          	j	80004518 <_ZL9fibonaccim+0x30>

000000008000455c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000455c:	fe010113          	addi	sp,sp,-32
    80004560:	00113c23          	sd	ra,24(sp)
    80004564:	00813823          	sd	s0,16(sp)
    80004568:	00913423          	sd	s1,8(sp)
    8000456c:	01213023          	sd	s2,0(sp)
    80004570:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004574:	00a00493          	li	s1,10
    80004578:	0400006f          	j	800045b8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000457c:	00004517          	auipc	a0,0x4
    80004580:	f6450513          	addi	a0,a0,-156 # 800084e0 <kvmincrease+0x12f0>
    80004584:	00000097          	auipc	ra,0x0
    80004588:	89c080e7          	jalr	-1892(ra) # 80003e20 <_Z11printStringPKc>
    8000458c:	00000613          	li	a2,0
    80004590:	00a00593          	li	a1,10
    80004594:	00048513          	mv	a0,s1
    80004598:	00000097          	auipc	ra,0x0
    8000459c:	a38080e7          	jalr	-1480(ra) # 80003fd0 <_Z8printIntiii>
    800045a0:	00004517          	auipc	a0,0x4
    800045a4:	be850513          	addi	a0,a0,-1048 # 80008188 <kvmincrease+0xf98>
    800045a8:	00000097          	auipc	ra,0x0
    800045ac:	878080e7          	jalr	-1928(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800045b0:	0014849b          	addiw	s1,s1,1
    800045b4:	0ff4f493          	andi	s1,s1,255
    800045b8:	00c00793          	li	a5,12
    800045bc:	fc97f0e3          	bgeu	a5,s1,8000457c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800045c0:	00004517          	auipc	a0,0x4
    800045c4:	f2850513          	addi	a0,a0,-216 # 800084e8 <kvmincrease+0x12f8>
    800045c8:	00000097          	auipc	ra,0x0
    800045cc:	858080e7          	jalr	-1960(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800045d0:	00500313          	li	t1,5
    thread_dispatch();
    800045d4:	ffffd097          	auipc	ra,0xffffd
    800045d8:	c1c080e7          	jalr	-996(ra) # 800011f0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800045dc:	01000513          	li	a0,16
    800045e0:	00000097          	auipc	ra,0x0
    800045e4:	f08080e7          	jalr	-248(ra) # 800044e8 <_ZL9fibonaccim>
    800045e8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800045ec:	00004517          	auipc	a0,0x4
    800045f0:	f0c50513          	addi	a0,a0,-244 # 800084f8 <kvmincrease+0x1308>
    800045f4:	00000097          	auipc	ra,0x0
    800045f8:	82c080e7          	jalr	-2004(ra) # 80003e20 <_Z11printStringPKc>
    800045fc:	00000613          	li	a2,0
    80004600:	00a00593          	li	a1,10
    80004604:	0009051b          	sext.w	a0,s2
    80004608:	00000097          	auipc	ra,0x0
    8000460c:	9c8080e7          	jalr	-1592(ra) # 80003fd0 <_Z8printIntiii>
    80004610:	00004517          	auipc	a0,0x4
    80004614:	b7850513          	addi	a0,a0,-1160 # 80008188 <kvmincrease+0xf98>
    80004618:	00000097          	auipc	ra,0x0
    8000461c:	808080e7          	jalr	-2040(ra) # 80003e20 <_Z11printStringPKc>
    80004620:	0400006f          	j	80004660 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004624:	00004517          	auipc	a0,0x4
    80004628:	ebc50513          	addi	a0,a0,-324 # 800084e0 <kvmincrease+0x12f0>
    8000462c:	fffff097          	auipc	ra,0xfffff
    80004630:	7f4080e7          	jalr	2036(ra) # 80003e20 <_Z11printStringPKc>
    80004634:	00000613          	li	a2,0
    80004638:	00a00593          	li	a1,10
    8000463c:	00048513          	mv	a0,s1
    80004640:	00000097          	auipc	ra,0x0
    80004644:	990080e7          	jalr	-1648(ra) # 80003fd0 <_Z8printIntiii>
    80004648:	00004517          	auipc	a0,0x4
    8000464c:	b4050513          	addi	a0,a0,-1216 # 80008188 <kvmincrease+0xf98>
    80004650:	fffff097          	auipc	ra,0xfffff
    80004654:	7d0080e7          	jalr	2000(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004658:	0014849b          	addiw	s1,s1,1
    8000465c:	0ff4f493          	andi	s1,s1,255
    80004660:	00f00793          	li	a5,15
    80004664:	fc97f0e3          	bgeu	a5,s1,80004624 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004668:	00004517          	auipc	a0,0x4
    8000466c:	ea050513          	addi	a0,a0,-352 # 80008508 <kvmincrease+0x1318>
    80004670:	fffff097          	auipc	ra,0xfffff
    80004674:	7b0080e7          	jalr	1968(ra) # 80003e20 <_Z11printStringPKc>
    finishedD = true;
    80004678:	00100793          	li	a5,1
    8000467c:	00006717          	auipc	a4,0x6
    80004680:	9af70a23          	sb	a5,-1612(a4) # 8000a030 <_ZL9finishedD>
    thread_dispatch();
    80004684:	ffffd097          	auipc	ra,0xffffd
    80004688:	b6c080e7          	jalr	-1172(ra) # 800011f0 <_Z15thread_dispatchv>
}
    8000468c:	01813083          	ld	ra,24(sp)
    80004690:	01013403          	ld	s0,16(sp)
    80004694:	00813483          	ld	s1,8(sp)
    80004698:	00013903          	ld	s2,0(sp)
    8000469c:	02010113          	addi	sp,sp,32
    800046a0:	00008067          	ret

00000000800046a4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800046a4:	fe010113          	addi	sp,sp,-32
    800046a8:	00113c23          	sd	ra,24(sp)
    800046ac:	00813823          	sd	s0,16(sp)
    800046b0:	00913423          	sd	s1,8(sp)
    800046b4:	01213023          	sd	s2,0(sp)
    800046b8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800046bc:	00000493          	li	s1,0
    800046c0:	0400006f          	j	80004700 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800046c4:	00004517          	auipc	a0,0x4
    800046c8:	dec50513          	addi	a0,a0,-532 # 800084b0 <kvmincrease+0x12c0>
    800046cc:	fffff097          	auipc	ra,0xfffff
    800046d0:	754080e7          	jalr	1876(ra) # 80003e20 <_Z11printStringPKc>
    800046d4:	00000613          	li	a2,0
    800046d8:	00a00593          	li	a1,10
    800046dc:	00048513          	mv	a0,s1
    800046e0:	00000097          	auipc	ra,0x0
    800046e4:	8f0080e7          	jalr	-1808(ra) # 80003fd0 <_Z8printIntiii>
    800046e8:	00004517          	auipc	a0,0x4
    800046ec:	aa050513          	addi	a0,a0,-1376 # 80008188 <kvmincrease+0xf98>
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	730080e7          	jalr	1840(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800046f8:	0014849b          	addiw	s1,s1,1
    800046fc:	0ff4f493          	andi	s1,s1,255
    80004700:	00200793          	li	a5,2
    80004704:	fc97f0e3          	bgeu	a5,s1,800046c4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004708:	00004517          	auipc	a0,0x4
    8000470c:	db050513          	addi	a0,a0,-592 # 800084b8 <kvmincrease+0x12c8>
    80004710:	fffff097          	auipc	ra,0xfffff
    80004714:	710080e7          	jalr	1808(ra) # 80003e20 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004718:	00700313          	li	t1,7
    thread_dispatch();
    8000471c:	ffffd097          	auipc	ra,0xffffd
    80004720:	ad4080e7          	jalr	-1324(ra) # 800011f0 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004724:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004728:	00004517          	auipc	a0,0x4
    8000472c:	da050513          	addi	a0,a0,-608 # 800084c8 <kvmincrease+0x12d8>
    80004730:	fffff097          	auipc	ra,0xfffff
    80004734:	6f0080e7          	jalr	1776(ra) # 80003e20 <_Z11printStringPKc>
    80004738:	00000613          	li	a2,0
    8000473c:	00a00593          	li	a1,10
    80004740:	0009051b          	sext.w	a0,s2
    80004744:	00000097          	auipc	ra,0x0
    80004748:	88c080e7          	jalr	-1908(ra) # 80003fd0 <_Z8printIntiii>
    8000474c:	00004517          	auipc	a0,0x4
    80004750:	a3c50513          	addi	a0,a0,-1476 # 80008188 <kvmincrease+0xf98>
    80004754:	fffff097          	auipc	ra,0xfffff
    80004758:	6cc080e7          	jalr	1740(ra) # 80003e20 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    8000475c:	00c00513          	li	a0,12
    80004760:	00000097          	auipc	ra,0x0
    80004764:	d88080e7          	jalr	-632(ra) # 800044e8 <_ZL9fibonaccim>
    80004768:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    8000476c:	00004517          	auipc	a0,0x4
    80004770:	d6450513          	addi	a0,a0,-668 # 800084d0 <kvmincrease+0x12e0>
    80004774:	fffff097          	auipc	ra,0xfffff
    80004778:	6ac080e7          	jalr	1708(ra) # 80003e20 <_Z11printStringPKc>
    8000477c:	00000613          	li	a2,0
    80004780:	00a00593          	li	a1,10
    80004784:	0009051b          	sext.w	a0,s2
    80004788:	00000097          	auipc	ra,0x0
    8000478c:	848080e7          	jalr	-1976(ra) # 80003fd0 <_Z8printIntiii>
    80004790:	00004517          	auipc	a0,0x4
    80004794:	9f850513          	addi	a0,a0,-1544 # 80008188 <kvmincrease+0xf98>
    80004798:	fffff097          	auipc	ra,0xfffff
    8000479c:	688080e7          	jalr	1672(ra) # 80003e20 <_Z11printStringPKc>
    800047a0:	0400006f          	j	800047e0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800047a4:	00004517          	auipc	a0,0x4
    800047a8:	d0c50513          	addi	a0,a0,-756 # 800084b0 <kvmincrease+0x12c0>
    800047ac:	fffff097          	auipc	ra,0xfffff
    800047b0:	674080e7          	jalr	1652(ra) # 80003e20 <_Z11printStringPKc>
    800047b4:	00000613          	li	a2,0
    800047b8:	00a00593          	li	a1,10
    800047bc:	00048513          	mv	a0,s1
    800047c0:	00000097          	auipc	ra,0x0
    800047c4:	810080e7          	jalr	-2032(ra) # 80003fd0 <_Z8printIntiii>
    800047c8:	00004517          	auipc	a0,0x4
    800047cc:	9c050513          	addi	a0,a0,-1600 # 80008188 <kvmincrease+0xf98>
    800047d0:	fffff097          	auipc	ra,0xfffff
    800047d4:	650080e7          	jalr	1616(ra) # 80003e20 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800047d8:	0014849b          	addiw	s1,s1,1
    800047dc:	0ff4f493          	andi	s1,s1,255
    800047e0:	00500793          	li	a5,5
    800047e4:	fc97f0e3          	bgeu	a5,s1,800047a4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    800047e8:	00004517          	auipc	a0,0x4
    800047ec:	ca050513          	addi	a0,a0,-864 # 80008488 <kvmincrease+0x1298>
    800047f0:	fffff097          	auipc	ra,0xfffff
    800047f4:	630080e7          	jalr	1584(ra) # 80003e20 <_Z11printStringPKc>
    finishedC = true;
    800047f8:	00100793          	li	a5,1
    800047fc:	00006717          	auipc	a4,0x6
    80004800:	82f70aa3          	sb	a5,-1995(a4) # 8000a031 <_ZL9finishedC>
    thread_dispatch();
    80004804:	ffffd097          	auipc	ra,0xffffd
    80004808:	9ec080e7          	jalr	-1556(ra) # 800011f0 <_Z15thread_dispatchv>
}
    8000480c:	01813083          	ld	ra,24(sp)
    80004810:	01013403          	ld	s0,16(sp)
    80004814:	00813483          	ld	s1,8(sp)
    80004818:	00013903          	ld	s2,0(sp)
    8000481c:	02010113          	addi	sp,sp,32
    80004820:	00008067          	ret

0000000080004824 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004824:	fe010113          	addi	sp,sp,-32
    80004828:	00113c23          	sd	ra,24(sp)
    8000482c:	00813823          	sd	s0,16(sp)
    80004830:	00913423          	sd	s1,8(sp)
    80004834:	01213023          	sd	s2,0(sp)
    80004838:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000483c:	00000913          	li	s2,0
    80004840:	0400006f          	j	80004880 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80004844:	ffffd097          	auipc	ra,0xffffd
    80004848:	9ac080e7          	jalr	-1620(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000484c:	00148493          	addi	s1,s1,1
    80004850:	000027b7          	lui	a5,0x2
    80004854:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004858:	0097ee63          	bltu	a5,s1,80004874 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000485c:	00000713          	li	a4,0
    80004860:	000077b7          	lui	a5,0x7
    80004864:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004868:	fce7eee3          	bltu	a5,a4,80004844 <_ZL11workerBodyBPv+0x20>
    8000486c:	00170713          	addi	a4,a4,1
    80004870:	ff1ff06f          	j	80004860 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80004874:	00a00793          	li	a5,10
    80004878:	04f90663          	beq	s2,a5,800048c4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    8000487c:	00190913          	addi	s2,s2,1
    80004880:	00f00793          	li	a5,15
    80004884:	0527e463          	bltu	a5,s2,800048cc <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80004888:	00004517          	auipc	a0,0x4
    8000488c:	c1050513          	addi	a0,a0,-1008 # 80008498 <kvmincrease+0x12a8>
    80004890:	fffff097          	auipc	ra,0xfffff
    80004894:	590080e7          	jalr	1424(ra) # 80003e20 <_Z11printStringPKc>
    80004898:	00000613          	li	a2,0
    8000489c:	00a00593          	li	a1,10
    800048a0:	0009051b          	sext.w	a0,s2
    800048a4:	fffff097          	auipc	ra,0xfffff
    800048a8:	72c080e7          	jalr	1836(ra) # 80003fd0 <_Z8printIntiii>
    800048ac:	00004517          	auipc	a0,0x4
    800048b0:	8dc50513          	addi	a0,a0,-1828 # 80008188 <kvmincrease+0xf98>
    800048b4:	fffff097          	auipc	ra,0xfffff
    800048b8:	56c080e7          	jalr	1388(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800048bc:	00000493          	li	s1,0
    800048c0:	f91ff06f          	j	80004850 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800048c4:	14102ff3          	csrr	t6,sepc
    800048c8:	fb5ff06f          	j	8000487c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    800048cc:	00004517          	auipc	a0,0x4
    800048d0:	bd450513          	addi	a0,a0,-1068 # 800084a0 <kvmincrease+0x12b0>
    800048d4:	fffff097          	auipc	ra,0xfffff
    800048d8:	54c080e7          	jalr	1356(ra) # 80003e20 <_Z11printStringPKc>
    finishedB = true;
    800048dc:	00100793          	li	a5,1
    800048e0:	00005717          	auipc	a4,0x5
    800048e4:	74f70923          	sb	a5,1874(a4) # 8000a032 <_ZL9finishedB>
    thread_dispatch();
    800048e8:	ffffd097          	auipc	ra,0xffffd
    800048ec:	908080e7          	jalr	-1784(ra) # 800011f0 <_Z15thread_dispatchv>
}
    800048f0:	01813083          	ld	ra,24(sp)
    800048f4:	01013403          	ld	s0,16(sp)
    800048f8:	00813483          	ld	s1,8(sp)
    800048fc:	00013903          	ld	s2,0(sp)
    80004900:	02010113          	addi	sp,sp,32
    80004904:	00008067          	ret

0000000080004908 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004908:	fe010113          	addi	sp,sp,-32
    8000490c:	00113c23          	sd	ra,24(sp)
    80004910:	00813823          	sd	s0,16(sp)
    80004914:	00913423          	sd	s1,8(sp)
    80004918:	01213023          	sd	s2,0(sp)
    8000491c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004920:	00000913          	li	s2,0
    80004924:	0380006f          	j	8000495c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004928:	ffffd097          	auipc	ra,0xffffd
    8000492c:	8c8080e7          	jalr	-1848(ra) # 800011f0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004930:	00148493          	addi	s1,s1,1
    80004934:	000027b7          	lui	a5,0x2
    80004938:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000493c:	0097ee63          	bltu	a5,s1,80004958 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004940:	00000713          	li	a4,0
    80004944:	000077b7          	lui	a5,0x7
    80004948:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000494c:	fce7eee3          	bltu	a5,a4,80004928 <_ZL11workerBodyAPv+0x20>
    80004950:	00170713          	addi	a4,a4,1
    80004954:	ff1ff06f          	j	80004944 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004958:	00190913          	addi	s2,s2,1
    8000495c:	00900793          	li	a5,9
    80004960:	0527e063          	bltu	a5,s2,800049a0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004964:	00004517          	auipc	a0,0x4
    80004968:	b1c50513          	addi	a0,a0,-1252 # 80008480 <kvmincrease+0x1290>
    8000496c:	fffff097          	auipc	ra,0xfffff
    80004970:	4b4080e7          	jalr	1204(ra) # 80003e20 <_Z11printStringPKc>
    80004974:	00000613          	li	a2,0
    80004978:	00a00593          	li	a1,10
    8000497c:	0009051b          	sext.w	a0,s2
    80004980:	fffff097          	auipc	ra,0xfffff
    80004984:	650080e7          	jalr	1616(ra) # 80003fd0 <_Z8printIntiii>
    80004988:	00004517          	auipc	a0,0x4
    8000498c:	80050513          	addi	a0,a0,-2048 # 80008188 <kvmincrease+0xf98>
    80004990:	fffff097          	auipc	ra,0xfffff
    80004994:	490080e7          	jalr	1168(ra) # 80003e20 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004998:	00000493          	li	s1,0
    8000499c:	f99ff06f          	j	80004934 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800049a0:	00004517          	auipc	a0,0x4
    800049a4:	ae850513          	addi	a0,a0,-1304 # 80008488 <kvmincrease+0x1298>
    800049a8:	fffff097          	auipc	ra,0xfffff
    800049ac:	478080e7          	jalr	1144(ra) # 80003e20 <_Z11printStringPKc>
    finishedA = true;
    800049b0:	00100793          	li	a5,1
    800049b4:	00005717          	auipc	a4,0x5
    800049b8:	66f70fa3          	sb	a5,1663(a4) # 8000a033 <_ZL9finishedA>
}
    800049bc:	01813083          	ld	ra,24(sp)
    800049c0:	01013403          	ld	s0,16(sp)
    800049c4:	00813483          	ld	s1,8(sp)
    800049c8:	00013903          	ld	s2,0(sp)
    800049cc:	02010113          	addi	sp,sp,32
    800049d0:	00008067          	ret

00000000800049d4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    800049d4:	fd010113          	addi	sp,sp,-48
    800049d8:	02113423          	sd	ra,40(sp)
    800049dc:	02813023          	sd	s0,32(sp)
    800049e0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800049e4:	00000613          	li	a2,0
    800049e8:	00000597          	auipc	a1,0x0
    800049ec:	f2058593          	addi	a1,a1,-224 # 80004908 <_ZL11workerBodyAPv>
    800049f0:	fd040513          	addi	a0,s0,-48
    800049f4:	ffffc097          	auipc	ra,0xffffc
    800049f8:	7a4080e7          	jalr	1956(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800049fc:	00004517          	auipc	a0,0x4
    80004a00:	b1c50513          	addi	a0,a0,-1252 # 80008518 <kvmincrease+0x1328>
    80004a04:	fffff097          	auipc	ra,0xfffff
    80004a08:	41c080e7          	jalr	1052(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004a0c:	00000613          	li	a2,0
    80004a10:	00000597          	auipc	a1,0x0
    80004a14:	e1458593          	addi	a1,a1,-492 # 80004824 <_ZL11workerBodyBPv>
    80004a18:	fd840513          	addi	a0,s0,-40
    80004a1c:	ffffc097          	auipc	ra,0xffffc
    80004a20:	77c080e7          	jalr	1916(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004a24:	00004517          	auipc	a0,0x4
    80004a28:	b0c50513          	addi	a0,a0,-1268 # 80008530 <kvmincrease+0x1340>
    80004a2c:	fffff097          	auipc	ra,0xfffff
    80004a30:	3f4080e7          	jalr	1012(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004a34:	00000613          	li	a2,0
    80004a38:	00000597          	auipc	a1,0x0
    80004a3c:	c6c58593          	addi	a1,a1,-916 # 800046a4 <_ZL11workerBodyCPv>
    80004a40:	fe040513          	addi	a0,s0,-32
    80004a44:	ffffc097          	auipc	ra,0xffffc
    80004a48:	754080e7          	jalr	1876(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80004a4c:	00004517          	auipc	a0,0x4
    80004a50:	afc50513          	addi	a0,a0,-1284 # 80008548 <kvmincrease+0x1358>
    80004a54:	fffff097          	auipc	ra,0xfffff
    80004a58:	3cc080e7          	jalr	972(ra) # 80003e20 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004a5c:	00000613          	li	a2,0
    80004a60:	00000597          	auipc	a1,0x0
    80004a64:	afc58593          	addi	a1,a1,-1284 # 8000455c <_ZL11workerBodyDPv>
    80004a68:	fe840513          	addi	a0,s0,-24
    80004a6c:	ffffc097          	auipc	ra,0xffffc
    80004a70:	72c080e7          	jalr	1836(ra) # 80001198 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004a74:	00004517          	auipc	a0,0x4
    80004a78:	aec50513          	addi	a0,a0,-1300 # 80008560 <kvmincrease+0x1370>
    80004a7c:	fffff097          	auipc	ra,0xfffff
    80004a80:	3a4080e7          	jalr	932(ra) # 80003e20 <_Z11printStringPKc>
    80004a84:	00c0006f          	j	80004a90 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004a88:	ffffc097          	auipc	ra,0xffffc
    80004a8c:	768080e7          	jalr	1896(ra) # 800011f0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004a90:	00005797          	auipc	a5,0x5
    80004a94:	5a37c783          	lbu	a5,1443(a5) # 8000a033 <_ZL9finishedA>
    80004a98:	fe0788e3          	beqz	a5,80004a88 <_Z16System_Mode_testv+0xb4>
    80004a9c:	00005797          	auipc	a5,0x5
    80004aa0:	5967c783          	lbu	a5,1430(a5) # 8000a032 <_ZL9finishedB>
    80004aa4:	fe0782e3          	beqz	a5,80004a88 <_Z16System_Mode_testv+0xb4>
    80004aa8:	00005797          	auipc	a5,0x5
    80004aac:	5897c783          	lbu	a5,1417(a5) # 8000a031 <_ZL9finishedC>
    80004ab0:	fc078ce3          	beqz	a5,80004a88 <_Z16System_Mode_testv+0xb4>
    80004ab4:	00005797          	auipc	a5,0x5
    80004ab8:	57c7c783          	lbu	a5,1404(a5) # 8000a030 <_ZL9finishedD>
    80004abc:	fc0786e3          	beqz	a5,80004a88 <_Z16System_Mode_testv+0xb4>
    }

}
    80004ac0:	02813083          	ld	ra,40(sp)
    80004ac4:	02013403          	ld	s0,32(sp)
    80004ac8:	03010113          	addi	sp,sp,48
    80004acc:	00008067          	ret

0000000080004ad0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004ad0:	fe010113          	addi	sp,sp,-32
    80004ad4:	00113c23          	sd	ra,24(sp)
    80004ad8:	00813823          	sd	s0,16(sp)
    80004adc:	00913423          	sd	s1,8(sp)
    80004ae0:	01213023          	sd	s2,0(sp)
    80004ae4:	02010413          	addi	s0,sp,32
    80004ae8:	00050493          	mv	s1,a0
    80004aec:	00058913          	mv	s2,a1
    80004af0:	0015879b          	addiw	a5,a1,1
    80004af4:	0007851b          	sext.w	a0,a5
    80004af8:	00f4a023          	sw	a5,0(s1)
    80004afc:	0004a823          	sw	zero,16(s1)
    80004b00:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004b04:	00251513          	slli	a0,a0,0x2
    80004b08:	ffffc097          	auipc	ra,0xffffc
    80004b0c:	63c080e7          	jalr	1596(ra) # 80001144 <_Z9mem_allocm>
    80004b10:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004b14:	00000593          	li	a1,0
    80004b18:	02048513          	addi	a0,s1,32
    80004b1c:	ffffc097          	auipc	ra,0xffffc
    80004b20:	6f8080e7          	jalr	1784(ra) # 80001214 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80004b24:	00090593          	mv	a1,s2
    80004b28:	01848513          	addi	a0,s1,24
    80004b2c:	ffffc097          	auipc	ra,0xffffc
    80004b30:	6e8080e7          	jalr	1768(ra) # 80001214 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80004b34:	00100593          	li	a1,1
    80004b38:	02848513          	addi	a0,s1,40
    80004b3c:	ffffc097          	auipc	ra,0xffffc
    80004b40:	6d8080e7          	jalr	1752(ra) # 80001214 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80004b44:	00100593          	li	a1,1
    80004b48:	03048513          	addi	a0,s1,48
    80004b4c:	ffffc097          	auipc	ra,0xffffc
    80004b50:	6c8080e7          	jalr	1736(ra) # 80001214 <_Z8sem_openPP4_semj>
}
    80004b54:	01813083          	ld	ra,24(sp)
    80004b58:	01013403          	ld	s0,16(sp)
    80004b5c:	00813483          	ld	s1,8(sp)
    80004b60:	00013903          	ld	s2,0(sp)
    80004b64:	02010113          	addi	sp,sp,32
    80004b68:	00008067          	ret

0000000080004b6c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004b6c:	fe010113          	addi	sp,sp,-32
    80004b70:	00113c23          	sd	ra,24(sp)
    80004b74:	00813823          	sd	s0,16(sp)
    80004b78:	00913423          	sd	s1,8(sp)
    80004b7c:	01213023          	sd	s2,0(sp)
    80004b80:	02010413          	addi	s0,sp,32
    80004b84:	00050493          	mv	s1,a0
    80004b88:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004b8c:	01853503          	ld	a0,24(a0)
    80004b90:	ffffc097          	auipc	ra,0xffffc
    80004b94:	6dc080e7          	jalr	1756(ra) # 8000126c <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004b98:	0304b503          	ld	a0,48(s1)
    80004b9c:	ffffc097          	auipc	ra,0xffffc
    80004ba0:	6d0080e7          	jalr	1744(ra) # 8000126c <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004ba4:	0084b783          	ld	a5,8(s1)
    80004ba8:	0144a703          	lw	a4,20(s1)
    80004bac:	00271713          	slli	a4,a4,0x2
    80004bb0:	00e787b3          	add	a5,a5,a4
    80004bb4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004bb8:	0144a783          	lw	a5,20(s1)
    80004bbc:	0017879b          	addiw	a5,a5,1
    80004bc0:	0004a703          	lw	a4,0(s1)
    80004bc4:	02e7e7bb          	remw	a5,a5,a4
    80004bc8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004bcc:	0304b503          	ld	a0,48(s1)
    80004bd0:	ffffc097          	auipc	ra,0xffffc
    80004bd4:	6c8080e7          	jalr	1736(ra) # 80001298 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004bd8:	0204b503          	ld	a0,32(s1)
    80004bdc:	ffffc097          	auipc	ra,0xffffc
    80004be0:	6bc080e7          	jalr	1724(ra) # 80001298 <_Z10sem_signalP4_sem>

}
    80004be4:	01813083          	ld	ra,24(sp)
    80004be8:	01013403          	ld	s0,16(sp)
    80004bec:	00813483          	ld	s1,8(sp)
    80004bf0:	00013903          	ld	s2,0(sp)
    80004bf4:	02010113          	addi	sp,sp,32
    80004bf8:	00008067          	ret

0000000080004bfc <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004bfc:	fe010113          	addi	sp,sp,-32
    80004c00:	00113c23          	sd	ra,24(sp)
    80004c04:	00813823          	sd	s0,16(sp)
    80004c08:	00913423          	sd	s1,8(sp)
    80004c0c:	01213023          	sd	s2,0(sp)
    80004c10:	02010413          	addi	s0,sp,32
    80004c14:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004c18:	02053503          	ld	a0,32(a0)
    80004c1c:	ffffc097          	auipc	ra,0xffffc
    80004c20:	650080e7          	jalr	1616(ra) # 8000126c <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004c24:	0284b503          	ld	a0,40(s1)
    80004c28:	ffffc097          	auipc	ra,0xffffc
    80004c2c:	644080e7          	jalr	1604(ra) # 8000126c <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80004c30:	0084b703          	ld	a4,8(s1)
    80004c34:	0104a783          	lw	a5,16(s1)
    80004c38:	00279693          	slli	a3,a5,0x2
    80004c3c:	00d70733          	add	a4,a4,a3
    80004c40:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004c44:	0017879b          	addiw	a5,a5,1
    80004c48:	0004a703          	lw	a4,0(s1)
    80004c4c:	02e7e7bb          	remw	a5,a5,a4
    80004c50:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004c54:	0284b503          	ld	a0,40(s1)
    80004c58:	ffffc097          	auipc	ra,0xffffc
    80004c5c:	640080e7          	jalr	1600(ra) # 80001298 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80004c60:	0184b503          	ld	a0,24(s1)
    80004c64:	ffffc097          	auipc	ra,0xffffc
    80004c68:	634080e7          	jalr	1588(ra) # 80001298 <_Z10sem_signalP4_sem>

    return ret;
}
    80004c6c:	00090513          	mv	a0,s2
    80004c70:	01813083          	ld	ra,24(sp)
    80004c74:	01013403          	ld	s0,16(sp)
    80004c78:	00813483          	ld	s1,8(sp)
    80004c7c:	00013903          	ld	s2,0(sp)
    80004c80:	02010113          	addi	sp,sp,32
    80004c84:	00008067          	ret

0000000080004c88 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004c88:	fe010113          	addi	sp,sp,-32
    80004c8c:	00113c23          	sd	ra,24(sp)
    80004c90:	00813823          	sd	s0,16(sp)
    80004c94:	00913423          	sd	s1,8(sp)
    80004c98:	01213023          	sd	s2,0(sp)
    80004c9c:	02010413          	addi	s0,sp,32
    80004ca0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004ca4:	02853503          	ld	a0,40(a0)
    80004ca8:	ffffc097          	auipc	ra,0xffffc
    80004cac:	5c4080e7          	jalr	1476(ra) # 8000126c <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80004cb0:	0304b503          	ld	a0,48(s1)
    80004cb4:	ffffc097          	auipc	ra,0xffffc
    80004cb8:	5b8080e7          	jalr	1464(ra) # 8000126c <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80004cbc:	0144a783          	lw	a5,20(s1)
    80004cc0:	0104a903          	lw	s2,16(s1)
    80004cc4:	0327ce63          	blt	a5,s2,80004d00 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004cc8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004ccc:	0304b503          	ld	a0,48(s1)
    80004cd0:	ffffc097          	auipc	ra,0xffffc
    80004cd4:	5c8080e7          	jalr	1480(ra) # 80001298 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80004cd8:	0284b503          	ld	a0,40(s1)
    80004cdc:	ffffc097          	auipc	ra,0xffffc
    80004ce0:	5bc080e7          	jalr	1468(ra) # 80001298 <_Z10sem_signalP4_sem>

    return ret;
}
    80004ce4:	00090513          	mv	a0,s2
    80004ce8:	01813083          	ld	ra,24(sp)
    80004cec:	01013403          	ld	s0,16(sp)
    80004cf0:	00813483          	ld	s1,8(sp)
    80004cf4:	00013903          	ld	s2,0(sp)
    80004cf8:	02010113          	addi	sp,sp,32
    80004cfc:	00008067          	ret
        ret = cap - head + tail;
    80004d00:	0004a703          	lw	a4,0(s1)
    80004d04:	4127093b          	subw	s2,a4,s2
    80004d08:	00f9093b          	addw	s2,s2,a5
    80004d0c:	fc1ff06f          	j	80004ccc <_ZN6Buffer6getCntEv+0x44>

0000000080004d10 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80004d10:	fe010113          	addi	sp,sp,-32
    80004d14:	00113c23          	sd	ra,24(sp)
    80004d18:	00813823          	sd	s0,16(sp)
    80004d1c:	00913423          	sd	s1,8(sp)
    80004d20:	02010413          	addi	s0,sp,32
    80004d24:	00050493          	mv	s1,a0
    putc('\n');
    80004d28:	00a00513          	li	a0,10
    80004d2c:	ffffc097          	auipc	ra,0xffffc
    80004d30:	5c4080e7          	jalr	1476(ra) # 800012f0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80004d34:	00004517          	auipc	a0,0x4
    80004d38:	85450513          	addi	a0,a0,-1964 # 80008588 <kvmincrease+0x1398>
    80004d3c:	fffff097          	auipc	ra,0xfffff
    80004d40:	0e4080e7          	jalr	228(ra) # 80003e20 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80004d44:	00048513          	mv	a0,s1
    80004d48:	00000097          	auipc	ra,0x0
    80004d4c:	f40080e7          	jalr	-192(ra) # 80004c88 <_ZN6Buffer6getCntEv>
    80004d50:	02a05c63          	blez	a0,80004d88 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80004d54:	0084b783          	ld	a5,8(s1)
    80004d58:	0104a703          	lw	a4,16(s1)
    80004d5c:	00271713          	slli	a4,a4,0x2
    80004d60:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80004d64:	0007c503          	lbu	a0,0(a5)
    80004d68:	ffffc097          	auipc	ra,0xffffc
    80004d6c:	588080e7          	jalr	1416(ra) # 800012f0 <_Z4putcc>
        head = (head + 1) % cap;
    80004d70:	0104a783          	lw	a5,16(s1)
    80004d74:	0017879b          	addiw	a5,a5,1
    80004d78:	0004a703          	lw	a4,0(s1)
    80004d7c:	02e7e7bb          	remw	a5,a5,a4
    80004d80:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80004d84:	fc1ff06f          	j	80004d44 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80004d88:	02100513          	li	a0,33
    80004d8c:	ffffc097          	auipc	ra,0xffffc
    80004d90:	564080e7          	jalr	1380(ra) # 800012f0 <_Z4putcc>
    putc('\n');
    80004d94:	00a00513          	li	a0,10
    80004d98:	ffffc097          	auipc	ra,0xffffc
    80004d9c:	558080e7          	jalr	1368(ra) # 800012f0 <_Z4putcc>
    mem_free(buffer);
    80004da0:	0084b503          	ld	a0,8(s1)
    80004da4:	ffffc097          	auipc	ra,0xffffc
    80004da8:	3c8080e7          	jalr	968(ra) # 8000116c <_Z8mem_freePv>
    sem_close(itemAvailable);
    80004dac:	0204b503          	ld	a0,32(s1)
    80004db0:	ffffc097          	auipc	ra,0xffffc
    80004db4:	490080e7          	jalr	1168(ra) # 80001240 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80004db8:	0184b503          	ld	a0,24(s1)
    80004dbc:	ffffc097          	auipc	ra,0xffffc
    80004dc0:	484080e7          	jalr	1156(ra) # 80001240 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80004dc4:	0304b503          	ld	a0,48(s1)
    80004dc8:	ffffc097          	auipc	ra,0xffffc
    80004dcc:	478080e7          	jalr	1144(ra) # 80001240 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80004dd0:	0284b503          	ld	a0,40(s1)
    80004dd4:	ffffc097          	auipc	ra,0xffffc
    80004dd8:	46c080e7          	jalr	1132(ra) # 80001240 <_Z9sem_closeP4_sem>
}
    80004ddc:	01813083          	ld	ra,24(sp)
    80004de0:	01013403          	ld	s0,16(sp)
    80004de4:	00813483          	ld	s1,8(sp)
    80004de8:	02010113          	addi	sp,sp,32
    80004dec:	00008067          	ret

0000000080004df0 <start>:
    80004df0:	ff010113          	addi	sp,sp,-16
    80004df4:	00813423          	sd	s0,8(sp)
    80004df8:	01010413          	addi	s0,sp,16
    80004dfc:	300027f3          	csrr	a5,mstatus
    80004e00:	ffffe737          	lui	a4,0xffffe
    80004e04:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff354f>
    80004e08:	00e7f7b3          	and	a5,a5,a4
    80004e0c:	00001737          	lui	a4,0x1
    80004e10:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004e14:	00e7e7b3          	or	a5,a5,a4
    80004e18:	30079073          	csrw	mstatus,a5
    80004e1c:	00000797          	auipc	a5,0x0
    80004e20:	16078793          	addi	a5,a5,352 # 80004f7c <system_main>
    80004e24:	34179073          	csrw	mepc,a5
    80004e28:	00000793          	li	a5,0
    80004e2c:	18079073          	csrw	satp,a5
    80004e30:	000107b7          	lui	a5,0x10
    80004e34:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e38:	30279073          	csrw	medeleg,a5
    80004e3c:	30379073          	csrw	mideleg,a5
    80004e40:	104027f3          	csrr	a5,sie
    80004e44:	2227e793          	ori	a5,a5,546
    80004e48:	10479073          	csrw	sie,a5
    80004e4c:	fff00793          	li	a5,-1
    80004e50:	00a7d793          	srli	a5,a5,0xa
    80004e54:	3b079073          	csrw	pmpaddr0,a5
    80004e58:	00f00793          	li	a5,15
    80004e5c:	3a079073          	csrw	pmpcfg0,a5
    80004e60:	f14027f3          	csrr	a5,mhartid
    80004e64:	0200c737          	lui	a4,0x200c
    80004e68:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004e6c:	0007869b          	sext.w	a3,a5
    80004e70:	00269713          	slli	a4,a3,0x2
    80004e74:	000f4637          	lui	a2,0xf4
    80004e78:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004e7c:	00d70733          	add	a4,a4,a3
    80004e80:	0037979b          	slliw	a5,a5,0x3
    80004e84:	020046b7          	lui	a3,0x2004
    80004e88:	00d787b3          	add	a5,a5,a3
    80004e8c:	00c585b3          	add	a1,a1,a2
    80004e90:	00371693          	slli	a3,a4,0x3
    80004e94:	00005717          	auipc	a4,0x5
    80004e98:	1ac70713          	addi	a4,a4,428 # 8000a040 <timer_scratch>
    80004e9c:	00b7b023          	sd	a1,0(a5)
    80004ea0:	00d70733          	add	a4,a4,a3
    80004ea4:	00f73c23          	sd	a5,24(a4)
    80004ea8:	02c73023          	sd	a2,32(a4)
    80004eac:	34071073          	csrw	mscratch,a4
    80004eb0:	00000797          	auipc	a5,0x0
    80004eb4:	6e078793          	addi	a5,a5,1760 # 80005590 <timervec>
    80004eb8:	30579073          	csrw	mtvec,a5
    80004ebc:	300027f3          	csrr	a5,mstatus
    80004ec0:	0087e793          	ori	a5,a5,8
    80004ec4:	30079073          	csrw	mstatus,a5
    80004ec8:	304027f3          	csrr	a5,mie
    80004ecc:	0807e793          	ori	a5,a5,128
    80004ed0:	30479073          	csrw	mie,a5
    80004ed4:	f14027f3          	csrr	a5,mhartid
    80004ed8:	0007879b          	sext.w	a5,a5
    80004edc:	00078213          	mv	tp,a5
    80004ee0:	30200073          	mret
    80004ee4:	00813403          	ld	s0,8(sp)
    80004ee8:	01010113          	addi	sp,sp,16
    80004eec:	00008067          	ret

0000000080004ef0 <timerinit>:
    80004ef0:	ff010113          	addi	sp,sp,-16
    80004ef4:	00813423          	sd	s0,8(sp)
    80004ef8:	01010413          	addi	s0,sp,16
    80004efc:	f14027f3          	csrr	a5,mhartid
    80004f00:	0200c737          	lui	a4,0x200c
    80004f04:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004f08:	0007869b          	sext.w	a3,a5
    80004f0c:	00269713          	slli	a4,a3,0x2
    80004f10:	000f4637          	lui	a2,0xf4
    80004f14:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004f18:	00d70733          	add	a4,a4,a3
    80004f1c:	0037979b          	slliw	a5,a5,0x3
    80004f20:	020046b7          	lui	a3,0x2004
    80004f24:	00d787b3          	add	a5,a5,a3
    80004f28:	00c585b3          	add	a1,a1,a2
    80004f2c:	00371693          	slli	a3,a4,0x3
    80004f30:	00005717          	auipc	a4,0x5
    80004f34:	11070713          	addi	a4,a4,272 # 8000a040 <timer_scratch>
    80004f38:	00b7b023          	sd	a1,0(a5)
    80004f3c:	00d70733          	add	a4,a4,a3
    80004f40:	00f73c23          	sd	a5,24(a4)
    80004f44:	02c73023          	sd	a2,32(a4)
    80004f48:	34071073          	csrw	mscratch,a4
    80004f4c:	00000797          	auipc	a5,0x0
    80004f50:	64478793          	addi	a5,a5,1604 # 80005590 <timervec>
    80004f54:	30579073          	csrw	mtvec,a5
    80004f58:	300027f3          	csrr	a5,mstatus
    80004f5c:	0087e793          	ori	a5,a5,8
    80004f60:	30079073          	csrw	mstatus,a5
    80004f64:	304027f3          	csrr	a5,mie
    80004f68:	0807e793          	ori	a5,a5,128
    80004f6c:	30479073          	csrw	mie,a5
    80004f70:	00813403          	ld	s0,8(sp)
    80004f74:	01010113          	addi	sp,sp,16
    80004f78:	00008067          	ret

0000000080004f7c <system_main>:
    80004f7c:	fe010113          	addi	sp,sp,-32
    80004f80:	00813823          	sd	s0,16(sp)
    80004f84:	00913423          	sd	s1,8(sp)
    80004f88:	00113c23          	sd	ra,24(sp)
    80004f8c:	02010413          	addi	s0,sp,32
    80004f90:	00000097          	auipc	ra,0x0
    80004f94:	0c4080e7          	jalr	196(ra) # 80005054 <cpuid>
    80004f98:	00005497          	auipc	s1,0x5
    80004f9c:	01848493          	addi	s1,s1,24 # 80009fb0 <started>
    80004fa0:	02050263          	beqz	a0,80004fc4 <system_main+0x48>
    80004fa4:	0004a783          	lw	a5,0(s1)
    80004fa8:	0007879b          	sext.w	a5,a5
    80004fac:	fe078ce3          	beqz	a5,80004fa4 <system_main+0x28>
    80004fb0:	0ff0000f          	fence
    80004fb4:	00003517          	auipc	a0,0x3
    80004fb8:	61c50513          	addi	a0,a0,1564 # 800085d0 <kvmincrease+0x13e0>
    80004fbc:	00001097          	auipc	ra,0x1
    80004fc0:	a70080e7          	jalr	-1424(ra) # 80005a2c <panic>
    80004fc4:	00001097          	auipc	ra,0x1
    80004fc8:	9c4080e7          	jalr	-1596(ra) # 80005988 <consoleinit>
    80004fcc:	00001097          	auipc	ra,0x1
    80004fd0:	150080e7          	jalr	336(ra) # 8000611c <printfinit>
    80004fd4:	00003517          	auipc	a0,0x3
    80004fd8:	1b450513          	addi	a0,a0,436 # 80008188 <kvmincrease+0xf98>
    80004fdc:	00001097          	auipc	ra,0x1
    80004fe0:	aac080e7          	jalr	-1364(ra) # 80005a88 <__printf>
    80004fe4:	00003517          	auipc	a0,0x3
    80004fe8:	5bc50513          	addi	a0,a0,1468 # 800085a0 <kvmincrease+0x13b0>
    80004fec:	00001097          	auipc	ra,0x1
    80004ff0:	a9c080e7          	jalr	-1380(ra) # 80005a88 <__printf>
    80004ff4:	00003517          	auipc	a0,0x3
    80004ff8:	19450513          	addi	a0,a0,404 # 80008188 <kvmincrease+0xf98>
    80004ffc:	00001097          	auipc	ra,0x1
    80005000:	a8c080e7          	jalr	-1396(ra) # 80005a88 <__printf>
    80005004:	00001097          	auipc	ra,0x1
    80005008:	4a4080e7          	jalr	1188(ra) # 800064a8 <kinit>
    8000500c:	00000097          	auipc	ra,0x0
    80005010:	148080e7          	jalr	328(ra) # 80005154 <trapinit>
    80005014:	00000097          	auipc	ra,0x0
    80005018:	16c080e7          	jalr	364(ra) # 80005180 <trapinithart>
    8000501c:	00000097          	auipc	ra,0x0
    80005020:	5b4080e7          	jalr	1460(ra) # 800055d0 <plicinit>
    80005024:	00000097          	auipc	ra,0x0
    80005028:	5d4080e7          	jalr	1492(ra) # 800055f8 <plicinithart>
    8000502c:	00000097          	auipc	ra,0x0
    80005030:	078080e7          	jalr	120(ra) # 800050a4 <userinit>
    80005034:	0ff0000f          	fence
    80005038:	00100793          	li	a5,1
    8000503c:	00003517          	auipc	a0,0x3
    80005040:	57c50513          	addi	a0,a0,1404 # 800085b8 <kvmincrease+0x13c8>
    80005044:	00f4a023          	sw	a5,0(s1)
    80005048:	00001097          	auipc	ra,0x1
    8000504c:	a40080e7          	jalr	-1472(ra) # 80005a88 <__printf>
    80005050:	0000006f          	j	80005050 <system_main+0xd4>

0000000080005054 <cpuid>:
    80005054:	ff010113          	addi	sp,sp,-16
    80005058:	00813423          	sd	s0,8(sp)
    8000505c:	01010413          	addi	s0,sp,16
    80005060:	00020513          	mv	a0,tp
    80005064:	00813403          	ld	s0,8(sp)
    80005068:	0005051b          	sext.w	a0,a0
    8000506c:	01010113          	addi	sp,sp,16
    80005070:	00008067          	ret

0000000080005074 <mycpu>:
    80005074:	ff010113          	addi	sp,sp,-16
    80005078:	00813423          	sd	s0,8(sp)
    8000507c:	01010413          	addi	s0,sp,16
    80005080:	00020793          	mv	a5,tp
    80005084:	00813403          	ld	s0,8(sp)
    80005088:	0007879b          	sext.w	a5,a5
    8000508c:	00779793          	slli	a5,a5,0x7
    80005090:	00006517          	auipc	a0,0x6
    80005094:	fe050513          	addi	a0,a0,-32 # 8000b070 <cpus>
    80005098:	00f50533          	add	a0,a0,a5
    8000509c:	01010113          	addi	sp,sp,16
    800050a0:	00008067          	ret

00000000800050a4 <userinit>:
    800050a4:	ff010113          	addi	sp,sp,-16
    800050a8:	00813423          	sd	s0,8(sp)
    800050ac:	01010413          	addi	s0,sp,16
    800050b0:	00813403          	ld	s0,8(sp)
    800050b4:	01010113          	addi	sp,sp,16
    800050b8:	ffffc317          	auipc	t1,0xffffc
    800050bc:	60430067          	jr	1540(t1) # 800016bc <main>

00000000800050c0 <either_copyout>:
    800050c0:	ff010113          	addi	sp,sp,-16
    800050c4:	00813023          	sd	s0,0(sp)
    800050c8:	00113423          	sd	ra,8(sp)
    800050cc:	01010413          	addi	s0,sp,16
    800050d0:	02051663          	bnez	a0,800050fc <either_copyout+0x3c>
    800050d4:	00058513          	mv	a0,a1
    800050d8:	00060593          	mv	a1,a2
    800050dc:	0006861b          	sext.w	a2,a3
    800050e0:	00002097          	auipc	ra,0x2
    800050e4:	c54080e7          	jalr	-940(ra) # 80006d34 <__memmove>
    800050e8:	00813083          	ld	ra,8(sp)
    800050ec:	00013403          	ld	s0,0(sp)
    800050f0:	00000513          	li	a0,0
    800050f4:	01010113          	addi	sp,sp,16
    800050f8:	00008067          	ret
    800050fc:	00003517          	auipc	a0,0x3
    80005100:	4fc50513          	addi	a0,a0,1276 # 800085f8 <kvmincrease+0x1408>
    80005104:	00001097          	auipc	ra,0x1
    80005108:	928080e7          	jalr	-1752(ra) # 80005a2c <panic>

000000008000510c <either_copyin>:
    8000510c:	ff010113          	addi	sp,sp,-16
    80005110:	00813023          	sd	s0,0(sp)
    80005114:	00113423          	sd	ra,8(sp)
    80005118:	01010413          	addi	s0,sp,16
    8000511c:	02059463          	bnez	a1,80005144 <either_copyin+0x38>
    80005120:	00060593          	mv	a1,a2
    80005124:	0006861b          	sext.w	a2,a3
    80005128:	00002097          	auipc	ra,0x2
    8000512c:	c0c080e7          	jalr	-1012(ra) # 80006d34 <__memmove>
    80005130:	00813083          	ld	ra,8(sp)
    80005134:	00013403          	ld	s0,0(sp)
    80005138:	00000513          	li	a0,0
    8000513c:	01010113          	addi	sp,sp,16
    80005140:	00008067          	ret
    80005144:	00003517          	auipc	a0,0x3
    80005148:	4dc50513          	addi	a0,a0,1244 # 80008620 <kvmincrease+0x1430>
    8000514c:	00001097          	auipc	ra,0x1
    80005150:	8e0080e7          	jalr	-1824(ra) # 80005a2c <panic>

0000000080005154 <trapinit>:
    80005154:	ff010113          	addi	sp,sp,-16
    80005158:	00813423          	sd	s0,8(sp)
    8000515c:	01010413          	addi	s0,sp,16
    80005160:	00813403          	ld	s0,8(sp)
    80005164:	00003597          	auipc	a1,0x3
    80005168:	4e458593          	addi	a1,a1,1252 # 80008648 <kvmincrease+0x1458>
    8000516c:	00006517          	auipc	a0,0x6
    80005170:	f8450513          	addi	a0,a0,-124 # 8000b0f0 <tickslock>
    80005174:	01010113          	addi	sp,sp,16
    80005178:	00001317          	auipc	t1,0x1
    8000517c:	5c030067          	jr	1472(t1) # 80006738 <initlock>

0000000080005180 <trapinithart>:
    80005180:	ff010113          	addi	sp,sp,-16
    80005184:	00813423          	sd	s0,8(sp)
    80005188:	01010413          	addi	s0,sp,16
    8000518c:	00000797          	auipc	a5,0x0
    80005190:	2f478793          	addi	a5,a5,756 # 80005480 <kernelvec>
    80005194:	10579073          	csrw	stvec,a5
    80005198:	00813403          	ld	s0,8(sp)
    8000519c:	01010113          	addi	sp,sp,16
    800051a0:	00008067          	ret

00000000800051a4 <usertrap>:
    800051a4:	ff010113          	addi	sp,sp,-16
    800051a8:	00813423          	sd	s0,8(sp)
    800051ac:	01010413          	addi	s0,sp,16
    800051b0:	00813403          	ld	s0,8(sp)
    800051b4:	01010113          	addi	sp,sp,16
    800051b8:	00008067          	ret

00000000800051bc <usertrapret>:
    800051bc:	ff010113          	addi	sp,sp,-16
    800051c0:	00813423          	sd	s0,8(sp)
    800051c4:	01010413          	addi	s0,sp,16
    800051c8:	00813403          	ld	s0,8(sp)
    800051cc:	01010113          	addi	sp,sp,16
    800051d0:	00008067          	ret

00000000800051d4 <kerneltrap>:
    800051d4:	fe010113          	addi	sp,sp,-32
    800051d8:	00813823          	sd	s0,16(sp)
    800051dc:	00113c23          	sd	ra,24(sp)
    800051e0:	00913423          	sd	s1,8(sp)
    800051e4:	02010413          	addi	s0,sp,32
    800051e8:	142025f3          	csrr	a1,scause
    800051ec:	100027f3          	csrr	a5,sstatus
    800051f0:	0027f793          	andi	a5,a5,2
    800051f4:	10079c63          	bnez	a5,8000530c <kerneltrap+0x138>
    800051f8:	142027f3          	csrr	a5,scause
    800051fc:	0207ce63          	bltz	a5,80005238 <kerneltrap+0x64>
    80005200:	00003517          	auipc	a0,0x3
    80005204:	49050513          	addi	a0,a0,1168 # 80008690 <kvmincrease+0x14a0>
    80005208:	00001097          	auipc	ra,0x1
    8000520c:	880080e7          	jalr	-1920(ra) # 80005a88 <__printf>
    80005210:	141025f3          	csrr	a1,sepc
    80005214:	14302673          	csrr	a2,stval
    80005218:	00003517          	auipc	a0,0x3
    8000521c:	48850513          	addi	a0,a0,1160 # 800086a0 <kvmincrease+0x14b0>
    80005220:	00001097          	auipc	ra,0x1
    80005224:	868080e7          	jalr	-1944(ra) # 80005a88 <__printf>
    80005228:	00003517          	auipc	a0,0x3
    8000522c:	49050513          	addi	a0,a0,1168 # 800086b8 <kvmincrease+0x14c8>
    80005230:	00000097          	auipc	ra,0x0
    80005234:	7fc080e7          	jalr	2044(ra) # 80005a2c <panic>
    80005238:	0ff7f713          	andi	a4,a5,255
    8000523c:	00900693          	li	a3,9
    80005240:	04d70063          	beq	a4,a3,80005280 <kerneltrap+0xac>
    80005244:	fff00713          	li	a4,-1
    80005248:	03f71713          	slli	a4,a4,0x3f
    8000524c:	00170713          	addi	a4,a4,1
    80005250:	fae798e3          	bne	a5,a4,80005200 <kerneltrap+0x2c>
    80005254:	00000097          	auipc	ra,0x0
    80005258:	e00080e7          	jalr	-512(ra) # 80005054 <cpuid>
    8000525c:	06050663          	beqz	a0,800052c8 <kerneltrap+0xf4>
    80005260:	144027f3          	csrr	a5,sip
    80005264:	ffd7f793          	andi	a5,a5,-3
    80005268:	14479073          	csrw	sip,a5
    8000526c:	01813083          	ld	ra,24(sp)
    80005270:	01013403          	ld	s0,16(sp)
    80005274:	00813483          	ld	s1,8(sp)
    80005278:	02010113          	addi	sp,sp,32
    8000527c:	00008067          	ret
    80005280:	00000097          	auipc	ra,0x0
    80005284:	3c4080e7          	jalr	964(ra) # 80005644 <plic_claim>
    80005288:	00a00793          	li	a5,10
    8000528c:	00050493          	mv	s1,a0
    80005290:	06f50863          	beq	a0,a5,80005300 <kerneltrap+0x12c>
    80005294:	fc050ce3          	beqz	a0,8000526c <kerneltrap+0x98>
    80005298:	00050593          	mv	a1,a0
    8000529c:	00003517          	auipc	a0,0x3
    800052a0:	3d450513          	addi	a0,a0,980 # 80008670 <kvmincrease+0x1480>
    800052a4:	00000097          	auipc	ra,0x0
    800052a8:	7e4080e7          	jalr	2020(ra) # 80005a88 <__printf>
    800052ac:	01013403          	ld	s0,16(sp)
    800052b0:	01813083          	ld	ra,24(sp)
    800052b4:	00048513          	mv	a0,s1
    800052b8:	00813483          	ld	s1,8(sp)
    800052bc:	02010113          	addi	sp,sp,32
    800052c0:	00000317          	auipc	t1,0x0
    800052c4:	3bc30067          	jr	956(t1) # 8000567c <plic_complete>
    800052c8:	00006517          	auipc	a0,0x6
    800052cc:	e2850513          	addi	a0,a0,-472 # 8000b0f0 <tickslock>
    800052d0:	00001097          	auipc	ra,0x1
    800052d4:	48c080e7          	jalr	1164(ra) # 8000675c <acquire>
    800052d8:	00005717          	auipc	a4,0x5
    800052dc:	cdc70713          	addi	a4,a4,-804 # 80009fb4 <ticks>
    800052e0:	00072783          	lw	a5,0(a4)
    800052e4:	00006517          	auipc	a0,0x6
    800052e8:	e0c50513          	addi	a0,a0,-500 # 8000b0f0 <tickslock>
    800052ec:	0017879b          	addiw	a5,a5,1
    800052f0:	00f72023          	sw	a5,0(a4)
    800052f4:	00001097          	auipc	ra,0x1
    800052f8:	534080e7          	jalr	1332(ra) # 80006828 <release>
    800052fc:	f65ff06f          	j	80005260 <kerneltrap+0x8c>
    80005300:	00001097          	auipc	ra,0x1
    80005304:	090080e7          	jalr	144(ra) # 80006390 <uartintr>
    80005308:	fa5ff06f          	j	800052ac <kerneltrap+0xd8>
    8000530c:	00003517          	auipc	a0,0x3
    80005310:	34450513          	addi	a0,a0,836 # 80008650 <kvmincrease+0x1460>
    80005314:	00000097          	auipc	ra,0x0
    80005318:	718080e7          	jalr	1816(ra) # 80005a2c <panic>

000000008000531c <clockintr>:
    8000531c:	fe010113          	addi	sp,sp,-32
    80005320:	00813823          	sd	s0,16(sp)
    80005324:	00913423          	sd	s1,8(sp)
    80005328:	00113c23          	sd	ra,24(sp)
    8000532c:	02010413          	addi	s0,sp,32
    80005330:	00006497          	auipc	s1,0x6
    80005334:	dc048493          	addi	s1,s1,-576 # 8000b0f0 <tickslock>
    80005338:	00048513          	mv	a0,s1
    8000533c:	00001097          	auipc	ra,0x1
    80005340:	420080e7          	jalr	1056(ra) # 8000675c <acquire>
    80005344:	00005717          	auipc	a4,0x5
    80005348:	c7070713          	addi	a4,a4,-912 # 80009fb4 <ticks>
    8000534c:	00072783          	lw	a5,0(a4)
    80005350:	01013403          	ld	s0,16(sp)
    80005354:	01813083          	ld	ra,24(sp)
    80005358:	00048513          	mv	a0,s1
    8000535c:	0017879b          	addiw	a5,a5,1
    80005360:	00813483          	ld	s1,8(sp)
    80005364:	00f72023          	sw	a5,0(a4)
    80005368:	02010113          	addi	sp,sp,32
    8000536c:	00001317          	auipc	t1,0x1
    80005370:	4bc30067          	jr	1212(t1) # 80006828 <release>

0000000080005374 <devintr>:
    80005374:	142027f3          	csrr	a5,scause
    80005378:	00000513          	li	a0,0
    8000537c:	0007c463          	bltz	a5,80005384 <devintr+0x10>
    80005380:	00008067          	ret
    80005384:	fe010113          	addi	sp,sp,-32
    80005388:	00813823          	sd	s0,16(sp)
    8000538c:	00113c23          	sd	ra,24(sp)
    80005390:	00913423          	sd	s1,8(sp)
    80005394:	02010413          	addi	s0,sp,32
    80005398:	0ff7f713          	andi	a4,a5,255
    8000539c:	00900693          	li	a3,9
    800053a0:	04d70c63          	beq	a4,a3,800053f8 <devintr+0x84>
    800053a4:	fff00713          	li	a4,-1
    800053a8:	03f71713          	slli	a4,a4,0x3f
    800053ac:	00170713          	addi	a4,a4,1
    800053b0:	00e78c63          	beq	a5,a4,800053c8 <devintr+0x54>
    800053b4:	01813083          	ld	ra,24(sp)
    800053b8:	01013403          	ld	s0,16(sp)
    800053bc:	00813483          	ld	s1,8(sp)
    800053c0:	02010113          	addi	sp,sp,32
    800053c4:	00008067          	ret
    800053c8:	00000097          	auipc	ra,0x0
    800053cc:	c8c080e7          	jalr	-884(ra) # 80005054 <cpuid>
    800053d0:	06050663          	beqz	a0,8000543c <devintr+0xc8>
    800053d4:	144027f3          	csrr	a5,sip
    800053d8:	ffd7f793          	andi	a5,a5,-3
    800053dc:	14479073          	csrw	sip,a5
    800053e0:	01813083          	ld	ra,24(sp)
    800053e4:	01013403          	ld	s0,16(sp)
    800053e8:	00813483          	ld	s1,8(sp)
    800053ec:	00200513          	li	a0,2
    800053f0:	02010113          	addi	sp,sp,32
    800053f4:	00008067          	ret
    800053f8:	00000097          	auipc	ra,0x0
    800053fc:	24c080e7          	jalr	588(ra) # 80005644 <plic_claim>
    80005400:	00a00793          	li	a5,10
    80005404:	00050493          	mv	s1,a0
    80005408:	06f50663          	beq	a0,a5,80005474 <devintr+0x100>
    8000540c:	00100513          	li	a0,1
    80005410:	fa0482e3          	beqz	s1,800053b4 <devintr+0x40>
    80005414:	00048593          	mv	a1,s1
    80005418:	00003517          	auipc	a0,0x3
    8000541c:	25850513          	addi	a0,a0,600 # 80008670 <kvmincrease+0x1480>
    80005420:	00000097          	auipc	ra,0x0
    80005424:	668080e7          	jalr	1640(ra) # 80005a88 <__printf>
    80005428:	00048513          	mv	a0,s1
    8000542c:	00000097          	auipc	ra,0x0
    80005430:	250080e7          	jalr	592(ra) # 8000567c <plic_complete>
    80005434:	00100513          	li	a0,1
    80005438:	f7dff06f          	j	800053b4 <devintr+0x40>
    8000543c:	00006517          	auipc	a0,0x6
    80005440:	cb450513          	addi	a0,a0,-844 # 8000b0f0 <tickslock>
    80005444:	00001097          	auipc	ra,0x1
    80005448:	318080e7          	jalr	792(ra) # 8000675c <acquire>
    8000544c:	00005717          	auipc	a4,0x5
    80005450:	b6870713          	addi	a4,a4,-1176 # 80009fb4 <ticks>
    80005454:	00072783          	lw	a5,0(a4)
    80005458:	00006517          	auipc	a0,0x6
    8000545c:	c9850513          	addi	a0,a0,-872 # 8000b0f0 <tickslock>
    80005460:	0017879b          	addiw	a5,a5,1
    80005464:	00f72023          	sw	a5,0(a4)
    80005468:	00001097          	auipc	ra,0x1
    8000546c:	3c0080e7          	jalr	960(ra) # 80006828 <release>
    80005470:	f65ff06f          	j	800053d4 <devintr+0x60>
    80005474:	00001097          	auipc	ra,0x1
    80005478:	f1c080e7          	jalr	-228(ra) # 80006390 <uartintr>
    8000547c:	fadff06f          	j	80005428 <devintr+0xb4>

0000000080005480 <kernelvec>:
    80005480:	f0010113          	addi	sp,sp,-256
    80005484:	00113023          	sd	ra,0(sp)
    80005488:	00213423          	sd	sp,8(sp)
    8000548c:	00313823          	sd	gp,16(sp)
    80005490:	00413c23          	sd	tp,24(sp)
    80005494:	02513023          	sd	t0,32(sp)
    80005498:	02613423          	sd	t1,40(sp)
    8000549c:	02713823          	sd	t2,48(sp)
    800054a0:	02813c23          	sd	s0,56(sp)
    800054a4:	04913023          	sd	s1,64(sp)
    800054a8:	04a13423          	sd	a0,72(sp)
    800054ac:	04b13823          	sd	a1,80(sp)
    800054b0:	04c13c23          	sd	a2,88(sp)
    800054b4:	06d13023          	sd	a3,96(sp)
    800054b8:	06e13423          	sd	a4,104(sp)
    800054bc:	06f13823          	sd	a5,112(sp)
    800054c0:	07013c23          	sd	a6,120(sp)
    800054c4:	09113023          	sd	a7,128(sp)
    800054c8:	09213423          	sd	s2,136(sp)
    800054cc:	09313823          	sd	s3,144(sp)
    800054d0:	09413c23          	sd	s4,152(sp)
    800054d4:	0b513023          	sd	s5,160(sp)
    800054d8:	0b613423          	sd	s6,168(sp)
    800054dc:	0b713823          	sd	s7,176(sp)
    800054e0:	0b813c23          	sd	s8,184(sp)
    800054e4:	0d913023          	sd	s9,192(sp)
    800054e8:	0da13423          	sd	s10,200(sp)
    800054ec:	0db13823          	sd	s11,208(sp)
    800054f0:	0dc13c23          	sd	t3,216(sp)
    800054f4:	0fd13023          	sd	t4,224(sp)
    800054f8:	0fe13423          	sd	t5,232(sp)
    800054fc:	0ff13823          	sd	t6,240(sp)
    80005500:	cd5ff0ef          	jal	ra,800051d4 <kerneltrap>
    80005504:	00013083          	ld	ra,0(sp)
    80005508:	00813103          	ld	sp,8(sp)
    8000550c:	01013183          	ld	gp,16(sp)
    80005510:	02013283          	ld	t0,32(sp)
    80005514:	02813303          	ld	t1,40(sp)
    80005518:	03013383          	ld	t2,48(sp)
    8000551c:	03813403          	ld	s0,56(sp)
    80005520:	04013483          	ld	s1,64(sp)
    80005524:	04813503          	ld	a0,72(sp)
    80005528:	05013583          	ld	a1,80(sp)
    8000552c:	05813603          	ld	a2,88(sp)
    80005530:	06013683          	ld	a3,96(sp)
    80005534:	06813703          	ld	a4,104(sp)
    80005538:	07013783          	ld	a5,112(sp)
    8000553c:	07813803          	ld	a6,120(sp)
    80005540:	08013883          	ld	a7,128(sp)
    80005544:	08813903          	ld	s2,136(sp)
    80005548:	09013983          	ld	s3,144(sp)
    8000554c:	09813a03          	ld	s4,152(sp)
    80005550:	0a013a83          	ld	s5,160(sp)
    80005554:	0a813b03          	ld	s6,168(sp)
    80005558:	0b013b83          	ld	s7,176(sp)
    8000555c:	0b813c03          	ld	s8,184(sp)
    80005560:	0c013c83          	ld	s9,192(sp)
    80005564:	0c813d03          	ld	s10,200(sp)
    80005568:	0d013d83          	ld	s11,208(sp)
    8000556c:	0d813e03          	ld	t3,216(sp)
    80005570:	0e013e83          	ld	t4,224(sp)
    80005574:	0e813f03          	ld	t5,232(sp)
    80005578:	0f013f83          	ld	t6,240(sp)
    8000557c:	10010113          	addi	sp,sp,256
    80005580:	10200073          	sret
    80005584:	00000013          	nop
    80005588:	00000013          	nop
    8000558c:	00000013          	nop

0000000080005590 <timervec>:
    80005590:	34051573          	csrrw	a0,mscratch,a0
    80005594:	00b53023          	sd	a1,0(a0)
    80005598:	00c53423          	sd	a2,8(a0)
    8000559c:	00d53823          	sd	a3,16(a0)
    800055a0:	01853583          	ld	a1,24(a0)
    800055a4:	02053603          	ld	a2,32(a0)
    800055a8:	0005b683          	ld	a3,0(a1)
    800055ac:	00c686b3          	add	a3,a3,a2
    800055b0:	00d5b023          	sd	a3,0(a1)
    800055b4:	00200593          	li	a1,2
    800055b8:	14459073          	csrw	sip,a1
    800055bc:	01053683          	ld	a3,16(a0)
    800055c0:	00853603          	ld	a2,8(a0)
    800055c4:	00053583          	ld	a1,0(a0)
    800055c8:	34051573          	csrrw	a0,mscratch,a0
    800055cc:	30200073          	mret

00000000800055d0 <plicinit>:
    800055d0:	ff010113          	addi	sp,sp,-16
    800055d4:	00813423          	sd	s0,8(sp)
    800055d8:	01010413          	addi	s0,sp,16
    800055dc:	00813403          	ld	s0,8(sp)
    800055e0:	0c0007b7          	lui	a5,0xc000
    800055e4:	00100713          	li	a4,1
    800055e8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800055ec:	00e7a223          	sw	a4,4(a5)
    800055f0:	01010113          	addi	sp,sp,16
    800055f4:	00008067          	ret

00000000800055f8 <plicinithart>:
    800055f8:	ff010113          	addi	sp,sp,-16
    800055fc:	00813023          	sd	s0,0(sp)
    80005600:	00113423          	sd	ra,8(sp)
    80005604:	01010413          	addi	s0,sp,16
    80005608:	00000097          	auipc	ra,0x0
    8000560c:	a4c080e7          	jalr	-1460(ra) # 80005054 <cpuid>
    80005610:	0085171b          	slliw	a4,a0,0x8
    80005614:	0c0027b7          	lui	a5,0xc002
    80005618:	00e787b3          	add	a5,a5,a4
    8000561c:	40200713          	li	a4,1026
    80005620:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005624:	00813083          	ld	ra,8(sp)
    80005628:	00013403          	ld	s0,0(sp)
    8000562c:	00d5151b          	slliw	a0,a0,0xd
    80005630:	0c2017b7          	lui	a5,0xc201
    80005634:	00a78533          	add	a0,a5,a0
    80005638:	00052023          	sw	zero,0(a0)
    8000563c:	01010113          	addi	sp,sp,16
    80005640:	00008067          	ret

0000000080005644 <plic_claim>:
    80005644:	ff010113          	addi	sp,sp,-16
    80005648:	00813023          	sd	s0,0(sp)
    8000564c:	00113423          	sd	ra,8(sp)
    80005650:	01010413          	addi	s0,sp,16
    80005654:	00000097          	auipc	ra,0x0
    80005658:	a00080e7          	jalr	-1536(ra) # 80005054 <cpuid>
    8000565c:	00813083          	ld	ra,8(sp)
    80005660:	00013403          	ld	s0,0(sp)
    80005664:	00d5151b          	slliw	a0,a0,0xd
    80005668:	0c2017b7          	lui	a5,0xc201
    8000566c:	00a78533          	add	a0,a5,a0
    80005670:	00452503          	lw	a0,4(a0)
    80005674:	01010113          	addi	sp,sp,16
    80005678:	00008067          	ret

000000008000567c <plic_complete>:
    8000567c:	fe010113          	addi	sp,sp,-32
    80005680:	00813823          	sd	s0,16(sp)
    80005684:	00913423          	sd	s1,8(sp)
    80005688:	00113c23          	sd	ra,24(sp)
    8000568c:	02010413          	addi	s0,sp,32
    80005690:	00050493          	mv	s1,a0
    80005694:	00000097          	auipc	ra,0x0
    80005698:	9c0080e7          	jalr	-1600(ra) # 80005054 <cpuid>
    8000569c:	01813083          	ld	ra,24(sp)
    800056a0:	01013403          	ld	s0,16(sp)
    800056a4:	00d5179b          	slliw	a5,a0,0xd
    800056a8:	0c201737          	lui	a4,0xc201
    800056ac:	00f707b3          	add	a5,a4,a5
    800056b0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800056b4:	00813483          	ld	s1,8(sp)
    800056b8:	02010113          	addi	sp,sp,32
    800056bc:	00008067          	ret

00000000800056c0 <consolewrite>:
    800056c0:	fb010113          	addi	sp,sp,-80
    800056c4:	04813023          	sd	s0,64(sp)
    800056c8:	04113423          	sd	ra,72(sp)
    800056cc:	02913c23          	sd	s1,56(sp)
    800056d0:	03213823          	sd	s2,48(sp)
    800056d4:	03313423          	sd	s3,40(sp)
    800056d8:	03413023          	sd	s4,32(sp)
    800056dc:	01513c23          	sd	s5,24(sp)
    800056e0:	05010413          	addi	s0,sp,80
    800056e4:	06c05c63          	blez	a2,8000575c <consolewrite+0x9c>
    800056e8:	00060993          	mv	s3,a2
    800056ec:	00050a13          	mv	s4,a0
    800056f0:	00058493          	mv	s1,a1
    800056f4:	00000913          	li	s2,0
    800056f8:	fff00a93          	li	s5,-1
    800056fc:	01c0006f          	j	80005718 <consolewrite+0x58>
    80005700:	fbf44503          	lbu	a0,-65(s0)
    80005704:	0019091b          	addiw	s2,s2,1
    80005708:	00148493          	addi	s1,s1,1
    8000570c:	00001097          	auipc	ra,0x1
    80005710:	a9c080e7          	jalr	-1380(ra) # 800061a8 <uartputc>
    80005714:	03298063          	beq	s3,s2,80005734 <consolewrite+0x74>
    80005718:	00048613          	mv	a2,s1
    8000571c:	00100693          	li	a3,1
    80005720:	000a0593          	mv	a1,s4
    80005724:	fbf40513          	addi	a0,s0,-65
    80005728:	00000097          	auipc	ra,0x0
    8000572c:	9e4080e7          	jalr	-1564(ra) # 8000510c <either_copyin>
    80005730:	fd5518e3          	bne	a0,s5,80005700 <consolewrite+0x40>
    80005734:	04813083          	ld	ra,72(sp)
    80005738:	04013403          	ld	s0,64(sp)
    8000573c:	03813483          	ld	s1,56(sp)
    80005740:	02813983          	ld	s3,40(sp)
    80005744:	02013a03          	ld	s4,32(sp)
    80005748:	01813a83          	ld	s5,24(sp)
    8000574c:	00090513          	mv	a0,s2
    80005750:	03013903          	ld	s2,48(sp)
    80005754:	05010113          	addi	sp,sp,80
    80005758:	00008067          	ret
    8000575c:	00000913          	li	s2,0
    80005760:	fd5ff06f          	j	80005734 <consolewrite+0x74>

0000000080005764 <consoleread>:
    80005764:	f9010113          	addi	sp,sp,-112
    80005768:	06813023          	sd	s0,96(sp)
    8000576c:	04913c23          	sd	s1,88(sp)
    80005770:	05213823          	sd	s2,80(sp)
    80005774:	05313423          	sd	s3,72(sp)
    80005778:	05413023          	sd	s4,64(sp)
    8000577c:	03513c23          	sd	s5,56(sp)
    80005780:	03613823          	sd	s6,48(sp)
    80005784:	03713423          	sd	s7,40(sp)
    80005788:	03813023          	sd	s8,32(sp)
    8000578c:	06113423          	sd	ra,104(sp)
    80005790:	01913c23          	sd	s9,24(sp)
    80005794:	07010413          	addi	s0,sp,112
    80005798:	00060b93          	mv	s7,a2
    8000579c:	00050913          	mv	s2,a0
    800057a0:	00058c13          	mv	s8,a1
    800057a4:	00060b1b          	sext.w	s6,a2
    800057a8:	00006497          	auipc	s1,0x6
    800057ac:	97048493          	addi	s1,s1,-1680 # 8000b118 <cons>
    800057b0:	00400993          	li	s3,4
    800057b4:	fff00a13          	li	s4,-1
    800057b8:	00a00a93          	li	s5,10
    800057bc:	05705e63          	blez	s7,80005818 <consoleread+0xb4>
    800057c0:	09c4a703          	lw	a4,156(s1)
    800057c4:	0984a783          	lw	a5,152(s1)
    800057c8:	0007071b          	sext.w	a4,a4
    800057cc:	08e78463          	beq	a5,a4,80005854 <consoleread+0xf0>
    800057d0:	07f7f713          	andi	a4,a5,127
    800057d4:	00e48733          	add	a4,s1,a4
    800057d8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800057dc:	0017869b          	addiw	a3,a5,1
    800057e0:	08d4ac23          	sw	a3,152(s1)
    800057e4:	00070c9b          	sext.w	s9,a4
    800057e8:	0b370663          	beq	a4,s3,80005894 <consoleread+0x130>
    800057ec:	00100693          	li	a3,1
    800057f0:	f9f40613          	addi	a2,s0,-97
    800057f4:	000c0593          	mv	a1,s8
    800057f8:	00090513          	mv	a0,s2
    800057fc:	f8e40fa3          	sb	a4,-97(s0)
    80005800:	00000097          	auipc	ra,0x0
    80005804:	8c0080e7          	jalr	-1856(ra) # 800050c0 <either_copyout>
    80005808:	01450863          	beq	a0,s4,80005818 <consoleread+0xb4>
    8000580c:	001c0c13          	addi	s8,s8,1
    80005810:	fffb8b9b          	addiw	s7,s7,-1
    80005814:	fb5c94e3          	bne	s9,s5,800057bc <consoleread+0x58>
    80005818:	000b851b          	sext.w	a0,s7
    8000581c:	06813083          	ld	ra,104(sp)
    80005820:	06013403          	ld	s0,96(sp)
    80005824:	05813483          	ld	s1,88(sp)
    80005828:	05013903          	ld	s2,80(sp)
    8000582c:	04813983          	ld	s3,72(sp)
    80005830:	04013a03          	ld	s4,64(sp)
    80005834:	03813a83          	ld	s5,56(sp)
    80005838:	02813b83          	ld	s7,40(sp)
    8000583c:	02013c03          	ld	s8,32(sp)
    80005840:	01813c83          	ld	s9,24(sp)
    80005844:	40ab053b          	subw	a0,s6,a0
    80005848:	03013b03          	ld	s6,48(sp)
    8000584c:	07010113          	addi	sp,sp,112
    80005850:	00008067          	ret
    80005854:	00001097          	auipc	ra,0x1
    80005858:	1d8080e7          	jalr	472(ra) # 80006a2c <push_on>
    8000585c:	0984a703          	lw	a4,152(s1)
    80005860:	09c4a783          	lw	a5,156(s1)
    80005864:	0007879b          	sext.w	a5,a5
    80005868:	fef70ce3          	beq	a4,a5,80005860 <consoleread+0xfc>
    8000586c:	00001097          	auipc	ra,0x1
    80005870:	234080e7          	jalr	564(ra) # 80006aa0 <pop_on>
    80005874:	0984a783          	lw	a5,152(s1)
    80005878:	07f7f713          	andi	a4,a5,127
    8000587c:	00e48733          	add	a4,s1,a4
    80005880:	01874703          	lbu	a4,24(a4)
    80005884:	0017869b          	addiw	a3,a5,1
    80005888:	08d4ac23          	sw	a3,152(s1)
    8000588c:	00070c9b          	sext.w	s9,a4
    80005890:	f5371ee3          	bne	a4,s3,800057ec <consoleread+0x88>
    80005894:	000b851b          	sext.w	a0,s7
    80005898:	f96bf2e3          	bgeu	s7,s6,8000581c <consoleread+0xb8>
    8000589c:	08f4ac23          	sw	a5,152(s1)
    800058a0:	f7dff06f          	j	8000581c <consoleread+0xb8>

00000000800058a4 <consputc>:
    800058a4:	10000793          	li	a5,256
    800058a8:	00f50663          	beq	a0,a5,800058b4 <consputc+0x10>
    800058ac:	00001317          	auipc	t1,0x1
    800058b0:	9f430067          	jr	-1548(t1) # 800062a0 <uartputc_sync>
    800058b4:	ff010113          	addi	sp,sp,-16
    800058b8:	00113423          	sd	ra,8(sp)
    800058bc:	00813023          	sd	s0,0(sp)
    800058c0:	01010413          	addi	s0,sp,16
    800058c4:	00800513          	li	a0,8
    800058c8:	00001097          	auipc	ra,0x1
    800058cc:	9d8080e7          	jalr	-1576(ra) # 800062a0 <uartputc_sync>
    800058d0:	02000513          	li	a0,32
    800058d4:	00001097          	auipc	ra,0x1
    800058d8:	9cc080e7          	jalr	-1588(ra) # 800062a0 <uartputc_sync>
    800058dc:	00013403          	ld	s0,0(sp)
    800058e0:	00813083          	ld	ra,8(sp)
    800058e4:	00800513          	li	a0,8
    800058e8:	01010113          	addi	sp,sp,16
    800058ec:	00001317          	auipc	t1,0x1
    800058f0:	9b430067          	jr	-1612(t1) # 800062a0 <uartputc_sync>

00000000800058f4 <consoleintr>:
    800058f4:	fe010113          	addi	sp,sp,-32
    800058f8:	00813823          	sd	s0,16(sp)
    800058fc:	00913423          	sd	s1,8(sp)
    80005900:	01213023          	sd	s2,0(sp)
    80005904:	00113c23          	sd	ra,24(sp)
    80005908:	02010413          	addi	s0,sp,32
    8000590c:	00006917          	auipc	s2,0x6
    80005910:	80c90913          	addi	s2,s2,-2036 # 8000b118 <cons>
    80005914:	00050493          	mv	s1,a0
    80005918:	00090513          	mv	a0,s2
    8000591c:	00001097          	auipc	ra,0x1
    80005920:	e40080e7          	jalr	-448(ra) # 8000675c <acquire>
    80005924:	02048c63          	beqz	s1,8000595c <consoleintr+0x68>
    80005928:	0a092783          	lw	a5,160(s2)
    8000592c:	09892703          	lw	a4,152(s2)
    80005930:	07f00693          	li	a3,127
    80005934:	40e7873b          	subw	a4,a5,a4
    80005938:	02e6e263          	bltu	a3,a4,8000595c <consoleintr+0x68>
    8000593c:	00d00713          	li	a4,13
    80005940:	04e48063          	beq	s1,a4,80005980 <consoleintr+0x8c>
    80005944:	07f7f713          	andi	a4,a5,127
    80005948:	00e90733          	add	a4,s2,a4
    8000594c:	0017879b          	addiw	a5,a5,1
    80005950:	0af92023          	sw	a5,160(s2)
    80005954:	00970c23          	sb	s1,24(a4)
    80005958:	08f92e23          	sw	a5,156(s2)
    8000595c:	01013403          	ld	s0,16(sp)
    80005960:	01813083          	ld	ra,24(sp)
    80005964:	00813483          	ld	s1,8(sp)
    80005968:	00013903          	ld	s2,0(sp)
    8000596c:	00005517          	auipc	a0,0x5
    80005970:	7ac50513          	addi	a0,a0,1964 # 8000b118 <cons>
    80005974:	02010113          	addi	sp,sp,32
    80005978:	00001317          	auipc	t1,0x1
    8000597c:	eb030067          	jr	-336(t1) # 80006828 <release>
    80005980:	00a00493          	li	s1,10
    80005984:	fc1ff06f          	j	80005944 <consoleintr+0x50>

0000000080005988 <consoleinit>:
    80005988:	fe010113          	addi	sp,sp,-32
    8000598c:	00113c23          	sd	ra,24(sp)
    80005990:	00813823          	sd	s0,16(sp)
    80005994:	00913423          	sd	s1,8(sp)
    80005998:	02010413          	addi	s0,sp,32
    8000599c:	00005497          	auipc	s1,0x5
    800059a0:	77c48493          	addi	s1,s1,1916 # 8000b118 <cons>
    800059a4:	00048513          	mv	a0,s1
    800059a8:	00003597          	auipc	a1,0x3
    800059ac:	d2058593          	addi	a1,a1,-736 # 800086c8 <kvmincrease+0x14d8>
    800059b0:	00001097          	auipc	ra,0x1
    800059b4:	d88080e7          	jalr	-632(ra) # 80006738 <initlock>
    800059b8:	00000097          	auipc	ra,0x0
    800059bc:	7ac080e7          	jalr	1964(ra) # 80006164 <uartinit>
    800059c0:	01813083          	ld	ra,24(sp)
    800059c4:	01013403          	ld	s0,16(sp)
    800059c8:	00000797          	auipc	a5,0x0
    800059cc:	d9c78793          	addi	a5,a5,-612 # 80005764 <consoleread>
    800059d0:	0af4bc23          	sd	a5,184(s1)
    800059d4:	00000797          	auipc	a5,0x0
    800059d8:	cec78793          	addi	a5,a5,-788 # 800056c0 <consolewrite>
    800059dc:	0cf4b023          	sd	a5,192(s1)
    800059e0:	00813483          	ld	s1,8(sp)
    800059e4:	02010113          	addi	sp,sp,32
    800059e8:	00008067          	ret

00000000800059ec <console_read>:
    800059ec:	ff010113          	addi	sp,sp,-16
    800059f0:	00813423          	sd	s0,8(sp)
    800059f4:	01010413          	addi	s0,sp,16
    800059f8:	00813403          	ld	s0,8(sp)
    800059fc:	00005317          	auipc	t1,0x5
    80005a00:	7d433303          	ld	t1,2004(t1) # 8000b1d0 <devsw+0x10>
    80005a04:	01010113          	addi	sp,sp,16
    80005a08:	00030067          	jr	t1

0000000080005a0c <console_write>:
    80005a0c:	ff010113          	addi	sp,sp,-16
    80005a10:	00813423          	sd	s0,8(sp)
    80005a14:	01010413          	addi	s0,sp,16
    80005a18:	00813403          	ld	s0,8(sp)
    80005a1c:	00005317          	auipc	t1,0x5
    80005a20:	7bc33303          	ld	t1,1980(t1) # 8000b1d8 <devsw+0x18>
    80005a24:	01010113          	addi	sp,sp,16
    80005a28:	00030067          	jr	t1

0000000080005a2c <panic>:
    80005a2c:	fe010113          	addi	sp,sp,-32
    80005a30:	00113c23          	sd	ra,24(sp)
    80005a34:	00813823          	sd	s0,16(sp)
    80005a38:	00913423          	sd	s1,8(sp)
    80005a3c:	02010413          	addi	s0,sp,32
    80005a40:	00050493          	mv	s1,a0
    80005a44:	00003517          	auipc	a0,0x3
    80005a48:	c8c50513          	addi	a0,a0,-884 # 800086d0 <kvmincrease+0x14e0>
    80005a4c:	00006797          	auipc	a5,0x6
    80005a50:	8207a623          	sw	zero,-2004(a5) # 8000b278 <pr+0x18>
    80005a54:	00000097          	auipc	ra,0x0
    80005a58:	034080e7          	jalr	52(ra) # 80005a88 <__printf>
    80005a5c:	00048513          	mv	a0,s1
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	028080e7          	jalr	40(ra) # 80005a88 <__printf>
    80005a68:	00002517          	auipc	a0,0x2
    80005a6c:	72050513          	addi	a0,a0,1824 # 80008188 <kvmincrease+0xf98>
    80005a70:	00000097          	auipc	ra,0x0
    80005a74:	018080e7          	jalr	24(ra) # 80005a88 <__printf>
    80005a78:	00100793          	li	a5,1
    80005a7c:	00004717          	auipc	a4,0x4
    80005a80:	52f72e23          	sw	a5,1340(a4) # 80009fb8 <panicked>
    80005a84:	0000006f          	j	80005a84 <panic+0x58>

0000000080005a88 <__printf>:
    80005a88:	f3010113          	addi	sp,sp,-208
    80005a8c:	08813023          	sd	s0,128(sp)
    80005a90:	07313423          	sd	s3,104(sp)
    80005a94:	09010413          	addi	s0,sp,144
    80005a98:	05813023          	sd	s8,64(sp)
    80005a9c:	08113423          	sd	ra,136(sp)
    80005aa0:	06913c23          	sd	s1,120(sp)
    80005aa4:	07213823          	sd	s2,112(sp)
    80005aa8:	07413023          	sd	s4,96(sp)
    80005aac:	05513c23          	sd	s5,88(sp)
    80005ab0:	05613823          	sd	s6,80(sp)
    80005ab4:	05713423          	sd	s7,72(sp)
    80005ab8:	03913c23          	sd	s9,56(sp)
    80005abc:	03a13823          	sd	s10,48(sp)
    80005ac0:	03b13423          	sd	s11,40(sp)
    80005ac4:	00005317          	auipc	t1,0x5
    80005ac8:	79c30313          	addi	t1,t1,1948 # 8000b260 <pr>
    80005acc:	01832c03          	lw	s8,24(t1)
    80005ad0:	00b43423          	sd	a1,8(s0)
    80005ad4:	00c43823          	sd	a2,16(s0)
    80005ad8:	00d43c23          	sd	a3,24(s0)
    80005adc:	02e43023          	sd	a4,32(s0)
    80005ae0:	02f43423          	sd	a5,40(s0)
    80005ae4:	03043823          	sd	a6,48(s0)
    80005ae8:	03143c23          	sd	a7,56(s0)
    80005aec:	00050993          	mv	s3,a0
    80005af0:	4a0c1663          	bnez	s8,80005f9c <__printf+0x514>
    80005af4:	60098c63          	beqz	s3,8000610c <__printf+0x684>
    80005af8:	0009c503          	lbu	a0,0(s3)
    80005afc:	00840793          	addi	a5,s0,8
    80005b00:	f6f43c23          	sd	a5,-136(s0)
    80005b04:	00000493          	li	s1,0
    80005b08:	22050063          	beqz	a0,80005d28 <__printf+0x2a0>
    80005b0c:	00002a37          	lui	s4,0x2
    80005b10:	00018ab7          	lui	s5,0x18
    80005b14:	000f4b37          	lui	s6,0xf4
    80005b18:	00989bb7          	lui	s7,0x989
    80005b1c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005b20:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005b24:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005b28:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005b2c:	00148c9b          	addiw	s9,s1,1
    80005b30:	02500793          	li	a5,37
    80005b34:	01998933          	add	s2,s3,s9
    80005b38:	38f51263          	bne	a0,a5,80005ebc <__printf+0x434>
    80005b3c:	00094783          	lbu	a5,0(s2)
    80005b40:	00078c9b          	sext.w	s9,a5
    80005b44:	1e078263          	beqz	a5,80005d28 <__printf+0x2a0>
    80005b48:	0024849b          	addiw	s1,s1,2
    80005b4c:	07000713          	li	a4,112
    80005b50:	00998933          	add	s2,s3,s1
    80005b54:	38e78a63          	beq	a5,a4,80005ee8 <__printf+0x460>
    80005b58:	20f76863          	bltu	a4,a5,80005d68 <__printf+0x2e0>
    80005b5c:	42a78863          	beq	a5,a0,80005f8c <__printf+0x504>
    80005b60:	06400713          	li	a4,100
    80005b64:	40e79663          	bne	a5,a4,80005f70 <__printf+0x4e8>
    80005b68:	f7843783          	ld	a5,-136(s0)
    80005b6c:	0007a603          	lw	a2,0(a5)
    80005b70:	00878793          	addi	a5,a5,8
    80005b74:	f6f43c23          	sd	a5,-136(s0)
    80005b78:	42064a63          	bltz	a2,80005fac <__printf+0x524>
    80005b7c:	00a00713          	li	a4,10
    80005b80:	02e677bb          	remuw	a5,a2,a4
    80005b84:	00003d97          	auipc	s11,0x3
    80005b88:	b74d8d93          	addi	s11,s11,-1164 # 800086f8 <digits>
    80005b8c:	00900593          	li	a1,9
    80005b90:	0006051b          	sext.w	a0,a2
    80005b94:	00000c93          	li	s9,0
    80005b98:	02079793          	slli	a5,a5,0x20
    80005b9c:	0207d793          	srli	a5,a5,0x20
    80005ba0:	00fd87b3          	add	a5,s11,a5
    80005ba4:	0007c783          	lbu	a5,0(a5)
    80005ba8:	02e656bb          	divuw	a3,a2,a4
    80005bac:	f8f40023          	sb	a5,-128(s0)
    80005bb0:	14c5d863          	bge	a1,a2,80005d00 <__printf+0x278>
    80005bb4:	06300593          	li	a1,99
    80005bb8:	00100c93          	li	s9,1
    80005bbc:	02e6f7bb          	remuw	a5,a3,a4
    80005bc0:	02079793          	slli	a5,a5,0x20
    80005bc4:	0207d793          	srli	a5,a5,0x20
    80005bc8:	00fd87b3          	add	a5,s11,a5
    80005bcc:	0007c783          	lbu	a5,0(a5)
    80005bd0:	02e6d73b          	divuw	a4,a3,a4
    80005bd4:	f8f400a3          	sb	a5,-127(s0)
    80005bd8:	12a5f463          	bgeu	a1,a0,80005d00 <__printf+0x278>
    80005bdc:	00a00693          	li	a3,10
    80005be0:	00900593          	li	a1,9
    80005be4:	02d777bb          	remuw	a5,a4,a3
    80005be8:	02079793          	slli	a5,a5,0x20
    80005bec:	0207d793          	srli	a5,a5,0x20
    80005bf0:	00fd87b3          	add	a5,s11,a5
    80005bf4:	0007c503          	lbu	a0,0(a5)
    80005bf8:	02d757bb          	divuw	a5,a4,a3
    80005bfc:	f8a40123          	sb	a0,-126(s0)
    80005c00:	48e5f263          	bgeu	a1,a4,80006084 <__printf+0x5fc>
    80005c04:	06300513          	li	a0,99
    80005c08:	02d7f5bb          	remuw	a1,a5,a3
    80005c0c:	02059593          	slli	a1,a1,0x20
    80005c10:	0205d593          	srli	a1,a1,0x20
    80005c14:	00bd85b3          	add	a1,s11,a1
    80005c18:	0005c583          	lbu	a1,0(a1)
    80005c1c:	02d7d7bb          	divuw	a5,a5,a3
    80005c20:	f8b401a3          	sb	a1,-125(s0)
    80005c24:	48e57263          	bgeu	a0,a4,800060a8 <__printf+0x620>
    80005c28:	3e700513          	li	a0,999
    80005c2c:	02d7f5bb          	remuw	a1,a5,a3
    80005c30:	02059593          	slli	a1,a1,0x20
    80005c34:	0205d593          	srli	a1,a1,0x20
    80005c38:	00bd85b3          	add	a1,s11,a1
    80005c3c:	0005c583          	lbu	a1,0(a1)
    80005c40:	02d7d7bb          	divuw	a5,a5,a3
    80005c44:	f8b40223          	sb	a1,-124(s0)
    80005c48:	46e57663          	bgeu	a0,a4,800060b4 <__printf+0x62c>
    80005c4c:	02d7f5bb          	remuw	a1,a5,a3
    80005c50:	02059593          	slli	a1,a1,0x20
    80005c54:	0205d593          	srli	a1,a1,0x20
    80005c58:	00bd85b3          	add	a1,s11,a1
    80005c5c:	0005c583          	lbu	a1,0(a1)
    80005c60:	02d7d7bb          	divuw	a5,a5,a3
    80005c64:	f8b402a3          	sb	a1,-123(s0)
    80005c68:	46ea7863          	bgeu	s4,a4,800060d8 <__printf+0x650>
    80005c6c:	02d7f5bb          	remuw	a1,a5,a3
    80005c70:	02059593          	slli	a1,a1,0x20
    80005c74:	0205d593          	srli	a1,a1,0x20
    80005c78:	00bd85b3          	add	a1,s11,a1
    80005c7c:	0005c583          	lbu	a1,0(a1)
    80005c80:	02d7d7bb          	divuw	a5,a5,a3
    80005c84:	f8b40323          	sb	a1,-122(s0)
    80005c88:	3eeaf863          	bgeu	s5,a4,80006078 <__printf+0x5f0>
    80005c8c:	02d7f5bb          	remuw	a1,a5,a3
    80005c90:	02059593          	slli	a1,a1,0x20
    80005c94:	0205d593          	srli	a1,a1,0x20
    80005c98:	00bd85b3          	add	a1,s11,a1
    80005c9c:	0005c583          	lbu	a1,0(a1)
    80005ca0:	02d7d7bb          	divuw	a5,a5,a3
    80005ca4:	f8b403a3          	sb	a1,-121(s0)
    80005ca8:	42eb7e63          	bgeu	s6,a4,800060e4 <__printf+0x65c>
    80005cac:	02d7f5bb          	remuw	a1,a5,a3
    80005cb0:	02059593          	slli	a1,a1,0x20
    80005cb4:	0205d593          	srli	a1,a1,0x20
    80005cb8:	00bd85b3          	add	a1,s11,a1
    80005cbc:	0005c583          	lbu	a1,0(a1)
    80005cc0:	02d7d7bb          	divuw	a5,a5,a3
    80005cc4:	f8b40423          	sb	a1,-120(s0)
    80005cc8:	42ebfc63          	bgeu	s7,a4,80006100 <__printf+0x678>
    80005ccc:	02079793          	slli	a5,a5,0x20
    80005cd0:	0207d793          	srli	a5,a5,0x20
    80005cd4:	00fd8db3          	add	s11,s11,a5
    80005cd8:	000dc703          	lbu	a4,0(s11)
    80005cdc:	00a00793          	li	a5,10
    80005ce0:	00900c93          	li	s9,9
    80005ce4:	f8e404a3          	sb	a4,-119(s0)
    80005ce8:	00065c63          	bgez	a2,80005d00 <__printf+0x278>
    80005cec:	f9040713          	addi	a4,s0,-112
    80005cf0:	00f70733          	add	a4,a4,a5
    80005cf4:	02d00693          	li	a3,45
    80005cf8:	fed70823          	sb	a3,-16(a4)
    80005cfc:	00078c93          	mv	s9,a5
    80005d00:	f8040793          	addi	a5,s0,-128
    80005d04:	01978cb3          	add	s9,a5,s9
    80005d08:	f7f40d13          	addi	s10,s0,-129
    80005d0c:	000cc503          	lbu	a0,0(s9)
    80005d10:	fffc8c93          	addi	s9,s9,-1
    80005d14:	00000097          	auipc	ra,0x0
    80005d18:	b90080e7          	jalr	-1136(ra) # 800058a4 <consputc>
    80005d1c:	ffac98e3          	bne	s9,s10,80005d0c <__printf+0x284>
    80005d20:	00094503          	lbu	a0,0(s2)
    80005d24:	e00514e3          	bnez	a0,80005b2c <__printf+0xa4>
    80005d28:	1a0c1663          	bnez	s8,80005ed4 <__printf+0x44c>
    80005d2c:	08813083          	ld	ra,136(sp)
    80005d30:	08013403          	ld	s0,128(sp)
    80005d34:	07813483          	ld	s1,120(sp)
    80005d38:	07013903          	ld	s2,112(sp)
    80005d3c:	06813983          	ld	s3,104(sp)
    80005d40:	06013a03          	ld	s4,96(sp)
    80005d44:	05813a83          	ld	s5,88(sp)
    80005d48:	05013b03          	ld	s6,80(sp)
    80005d4c:	04813b83          	ld	s7,72(sp)
    80005d50:	04013c03          	ld	s8,64(sp)
    80005d54:	03813c83          	ld	s9,56(sp)
    80005d58:	03013d03          	ld	s10,48(sp)
    80005d5c:	02813d83          	ld	s11,40(sp)
    80005d60:	0d010113          	addi	sp,sp,208
    80005d64:	00008067          	ret
    80005d68:	07300713          	li	a4,115
    80005d6c:	1ce78a63          	beq	a5,a4,80005f40 <__printf+0x4b8>
    80005d70:	07800713          	li	a4,120
    80005d74:	1ee79e63          	bne	a5,a4,80005f70 <__printf+0x4e8>
    80005d78:	f7843783          	ld	a5,-136(s0)
    80005d7c:	0007a703          	lw	a4,0(a5)
    80005d80:	00878793          	addi	a5,a5,8
    80005d84:	f6f43c23          	sd	a5,-136(s0)
    80005d88:	28074263          	bltz	a4,8000600c <__printf+0x584>
    80005d8c:	00003d97          	auipc	s11,0x3
    80005d90:	96cd8d93          	addi	s11,s11,-1684 # 800086f8 <digits>
    80005d94:	00f77793          	andi	a5,a4,15
    80005d98:	00fd87b3          	add	a5,s11,a5
    80005d9c:	0007c683          	lbu	a3,0(a5)
    80005da0:	00f00613          	li	a2,15
    80005da4:	0007079b          	sext.w	a5,a4
    80005da8:	f8d40023          	sb	a3,-128(s0)
    80005dac:	0047559b          	srliw	a1,a4,0x4
    80005db0:	0047569b          	srliw	a3,a4,0x4
    80005db4:	00000c93          	li	s9,0
    80005db8:	0ee65063          	bge	a2,a4,80005e98 <__printf+0x410>
    80005dbc:	00f6f693          	andi	a3,a3,15
    80005dc0:	00dd86b3          	add	a3,s11,a3
    80005dc4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80005dc8:	0087d79b          	srliw	a5,a5,0x8
    80005dcc:	00100c93          	li	s9,1
    80005dd0:	f8d400a3          	sb	a3,-127(s0)
    80005dd4:	0cb67263          	bgeu	a2,a1,80005e98 <__printf+0x410>
    80005dd8:	00f7f693          	andi	a3,a5,15
    80005ddc:	00dd86b3          	add	a3,s11,a3
    80005de0:	0006c583          	lbu	a1,0(a3)
    80005de4:	00f00613          	li	a2,15
    80005de8:	0047d69b          	srliw	a3,a5,0x4
    80005dec:	f8b40123          	sb	a1,-126(s0)
    80005df0:	0047d593          	srli	a1,a5,0x4
    80005df4:	28f67e63          	bgeu	a2,a5,80006090 <__printf+0x608>
    80005df8:	00f6f693          	andi	a3,a3,15
    80005dfc:	00dd86b3          	add	a3,s11,a3
    80005e00:	0006c503          	lbu	a0,0(a3)
    80005e04:	0087d813          	srli	a6,a5,0x8
    80005e08:	0087d69b          	srliw	a3,a5,0x8
    80005e0c:	f8a401a3          	sb	a0,-125(s0)
    80005e10:	28b67663          	bgeu	a2,a1,8000609c <__printf+0x614>
    80005e14:	00f6f693          	andi	a3,a3,15
    80005e18:	00dd86b3          	add	a3,s11,a3
    80005e1c:	0006c583          	lbu	a1,0(a3)
    80005e20:	00c7d513          	srli	a0,a5,0xc
    80005e24:	00c7d69b          	srliw	a3,a5,0xc
    80005e28:	f8b40223          	sb	a1,-124(s0)
    80005e2c:	29067a63          	bgeu	a2,a6,800060c0 <__printf+0x638>
    80005e30:	00f6f693          	andi	a3,a3,15
    80005e34:	00dd86b3          	add	a3,s11,a3
    80005e38:	0006c583          	lbu	a1,0(a3)
    80005e3c:	0107d813          	srli	a6,a5,0x10
    80005e40:	0107d69b          	srliw	a3,a5,0x10
    80005e44:	f8b402a3          	sb	a1,-123(s0)
    80005e48:	28a67263          	bgeu	a2,a0,800060cc <__printf+0x644>
    80005e4c:	00f6f693          	andi	a3,a3,15
    80005e50:	00dd86b3          	add	a3,s11,a3
    80005e54:	0006c683          	lbu	a3,0(a3)
    80005e58:	0147d79b          	srliw	a5,a5,0x14
    80005e5c:	f8d40323          	sb	a3,-122(s0)
    80005e60:	21067663          	bgeu	a2,a6,8000606c <__printf+0x5e4>
    80005e64:	02079793          	slli	a5,a5,0x20
    80005e68:	0207d793          	srli	a5,a5,0x20
    80005e6c:	00fd8db3          	add	s11,s11,a5
    80005e70:	000dc683          	lbu	a3,0(s11)
    80005e74:	00800793          	li	a5,8
    80005e78:	00700c93          	li	s9,7
    80005e7c:	f8d403a3          	sb	a3,-121(s0)
    80005e80:	00075c63          	bgez	a4,80005e98 <__printf+0x410>
    80005e84:	f9040713          	addi	a4,s0,-112
    80005e88:	00f70733          	add	a4,a4,a5
    80005e8c:	02d00693          	li	a3,45
    80005e90:	fed70823          	sb	a3,-16(a4)
    80005e94:	00078c93          	mv	s9,a5
    80005e98:	f8040793          	addi	a5,s0,-128
    80005e9c:	01978cb3          	add	s9,a5,s9
    80005ea0:	f7f40d13          	addi	s10,s0,-129
    80005ea4:	000cc503          	lbu	a0,0(s9)
    80005ea8:	fffc8c93          	addi	s9,s9,-1
    80005eac:	00000097          	auipc	ra,0x0
    80005eb0:	9f8080e7          	jalr	-1544(ra) # 800058a4 <consputc>
    80005eb4:	ff9d18e3          	bne	s10,s9,80005ea4 <__printf+0x41c>
    80005eb8:	0100006f          	j	80005ec8 <__printf+0x440>
    80005ebc:	00000097          	auipc	ra,0x0
    80005ec0:	9e8080e7          	jalr	-1560(ra) # 800058a4 <consputc>
    80005ec4:	000c8493          	mv	s1,s9
    80005ec8:	00094503          	lbu	a0,0(s2)
    80005ecc:	c60510e3          	bnez	a0,80005b2c <__printf+0xa4>
    80005ed0:	e40c0ee3          	beqz	s8,80005d2c <__printf+0x2a4>
    80005ed4:	00005517          	auipc	a0,0x5
    80005ed8:	38c50513          	addi	a0,a0,908 # 8000b260 <pr>
    80005edc:	00001097          	auipc	ra,0x1
    80005ee0:	94c080e7          	jalr	-1716(ra) # 80006828 <release>
    80005ee4:	e49ff06f          	j	80005d2c <__printf+0x2a4>
    80005ee8:	f7843783          	ld	a5,-136(s0)
    80005eec:	03000513          	li	a0,48
    80005ef0:	01000d13          	li	s10,16
    80005ef4:	00878713          	addi	a4,a5,8
    80005ef8:	0007bc83          	ld	s9,0(a5)
    80005efc:	f6e43c23          	sd	a4,-136(s0)
    80005f00:	00000097          	auipc	ra,0x0
    80005f04:	9a4080e7          	jalr	-1628(ra) # 800058a4 <consputc>
    80005f08:	07800513          	li	a0,120
    80005f0c:	00000097          	auipc	ra,0x0
    80005f10:	998080e7          	jalr	-1640(ra) # 800058a4 <consputc>
    80005f14:	00002d97          	auipc	s11,0x2
    80005f18:	7e4d8d93          	addi	s11,s11,2020 # 800086f8 <digits>
    80005f1c:	03ccd793          	srli	a5,s9,0x3c
    80005f20:	00fd87b3          	add	a5,s11,a5
    80005f24:	0007c503          	lbu	a0,0(a5)
    80005f28:	fffd0d1b          	addiw	s10,s10,-1
    80005f2c:	004c9c93          	slli	s9,s9,0x4
    80005f30:	00000097          	auipc	ra,0x0
    80005f34:	974080e7          	jalr	-1676(ra) # 800058a4 <consputc>
    80005f38:	fe0d12e3          	bnez	s10,80005f1c <__printf+0x494>
    80005f3c:	f8dff06f          	j	80005ec8 <__printf+0x440>
    80005f40:	f7843783          	ld	a5,-136(s0)
    80005f44:	0007bc83          	ld	s9,0(a5)
    80005f48:	00878793          	addi	a5,a5,8
    80005f4c:	f6f43c23          	sd	a5,-136(s0)
    80005f50:	000c9a63          	bnez	s9,80005f64 <__printf+0x4dc>
    80005f54:	1080006f          	j	8000605c <__printf+0x5d4>
    80005f58:	001c8c93          	addi	s9,s9,1
    80005f5c:	00000097          	auipc	ra,0x0
    80005f60:	948080e7          	jalr	-1720(ra) # 800058a4 <consputc>
    80005f64:	000cc503          	lbu	a0,0(s9)
    80005f68:	fe0518e3          	bnez	a0,80005f58 <__printf+0x4d0>
    80005f6c:	f5dff06f          	j	80005ec8 <__printf+0x440>
    80005f70:	02500513          	li	a0,37
    80005f74:	00000097          	auipc	ra,0x0
    80005f78:	930080e7          	jalr	-1744(ra) # 800058a4 <consputc>
    80005f7c:	000c8513          	mv	a0,s9
    80005f80:	00000097          	auipc	ra,0x0
    80005f84:	924080e7          	jalr	-1756(ra) # 800058a4 <consputc>
    80005f88:	f41ff06f          	j	80005ec8 <__printf+0x440>
    80005f8c:	02500513          	li	a0,37
    80005f90:	00000097          	auipc	ra,0x0
    80005f94:	914080e7          	jalr	-1772(ra) # 800058a4 <consputc>
    80005f98:	f31ff06f          	j	80005ec8 <__printf+0x440>
    80005f9c:	00030513          	mv	a0,t1
    80005fa0:	00000097          	auipc	ra,0x0
    80005fa4:	7bc080e7          	jalr	1980(ra) # 8000675c <acquire>
    80005fa8:	b4dff06f          	j	80005af4 <__printf+0x6c>
    80005fac:	40c0053b          	negw	a0,a2
    80005fb0:	00a00713          	li	a4,10
    80005fb4:	02e576bb          	remuw	a3,a0,a4
    80005fb8:	00002d97          	auipc	s11,0x2
    80005fbc:	740d8d93          	addi	s11,s11,1856 # 800086f8 <digits>
    80005fc0:	ff700593          	li	a1,-9
    80005fc4:	02069693          	slli	a3,a3,0x20
    80005fc8:	0206d693          	srli	a3,a3,0x20
    80005fcc:	00dd86b3          	add	a3,s11,a3
    80005fd0:	0006c683          	lbu	a3,0(a3)
    80005fd4:	02e557bb          	divuw	a5,a0,a4
    80005fd8:	f8d40023          	sb	a3,-128(s0)
    80005fdc:	10b65e63          	bge	a2,a1,800060f8 <__printf+0x670>
    80005fe0:	06300593          	li	a1,99
    80005fe4:	02e7f6bb          	remuw	a3,a5,a4
    80005fe8:	02069693          	slli	a3,a3,0x20
    80005fec:	0206d693          	srli	a3,a3,0x20
    80005ff0:	00dd86b3          	add	a3,s11,a3
    80005ff4:	0006c683          	lbu	a3,0(a3)
    80005ff8:	02e7d73b          	divuw	a4,a5,a4
    80005ffc:	00200793          	li	a5,2
    80006000:	f8d400a3          	sb	a3,-127(s0)
    80006004:	bca5ece3          	bltu	a1,a0,80005bdc <__printf+0x154>
    80006008:	ce5ff06f          	j	80005cec <__printf+0x264>
    8000600c:	40e007bb          	negw	a5,a4
    80006010:	00002d97          	auipc	s11,0x2
    80006014:	6e8d8d93          	addi	s11,s11,1768 # 800086f8 <digits>
    80006018:	00f7f693          	andi	a3,a5,15
    8000601c:	00dd86b3          	add	a3,s11,a3
    80006020:	0006c583          	lbu	a1,0(a3)
    80006024:	ff100613          	li	a2,-15
    80006028:	0047d69b          	srliw	a3,a5,0x4
    8000602c:	f8b40023          	sb	a1,-128(s0)
    80006030:	0047d59b          	srliw	a1,a5,0x4
    80006034:	0ac75e63          	bge	a4,a2,800060f0 <__printf+0x668>
    80006038:	00f6f693          	andi	a3,a3,15
    8000603c:	00dd86b3          	add	a3,s11,a3
    80006040:	0006c603          	lbu	a2,0(a3)
    80006044:	00f00693          	li	a3,15
    80006048:	0087d79b          	srliw	a5,a5,0x8
    8000604c:	f8c400a3          	sb	a2,-127(s0)
    80006050:	d8b6e4e3          	bltu	a3,a1,80005dd8 <__printf+0x350>
    80006054:	00200793          	li	a5,2
    80006058:	e2dff06f          	j	80005e84 <__printf+0x3fc>
    8000605c:	00002c97          	auipc	s9,0x2
    80006060:	67cc8c93          	addi	s9,s9,1660 # 800086d8 <kvmincrease+0x14e8>
    80006064:	02800513          	li	a0,40
    80006068:	ef1ff06f          	j	80005f58 <__printf+0x4d0>
    8000606c:	00700793          	li	a5,7
    80006070:	00600c93          	li	s9,6
    80006074:	e0dff06f          	j	80005e80 <__printf+0x3f8>
    80006078:	00700793          	li	a5,7
    8000607c:	00600c93          	li	s9,6
    80006080:	c69ff06f          	j	80005ce8 <__printf+0x260>
    80006084:	00300793          	li	a5,3
    80006088:	00200c93          	li	s9,2
    8000608c:	c5dff06f          	j	80005ce8 <__printf+0x260>
    80006090:	00300793          	li	a5,3
    80006094:	00200c93          	li	s9,2
    80006098:	de9ff06f          	j	80005e80 <__printf+0x3f8>
    8000609c:	00400793          	li	a5,4
    800060a0:	00300c93          	li	s9,3
    800060a4:	dddff06f          	j	80005e80 <__printf+0x3f8>
    800060a8:	00400793          	li	a5,4
    800060ac:	00300c93          	li	s9,3
    800060b0:	c39ff06f          	j	80005ce8 <__printf+0x260>
    800060b4:	00500793          	li	a5,5
    800060b8:	00400c93          	li	s9,4
    800060bc:	c2dff06f          	j	80005ce8 <__printf+0x260>
    800060c0:	00500793          	li	a5,5
    800060c4:	00400c93          	li	s9,4
    800060c8:	db9ff06f          	j	80005e80 <__printf+0x3f8>
    800060cc:	00600793          	li	a5,6
    800060d0:	00500c93          	li	s9,5
    800060d4:	dadff06f          	j	80005e80 <__printf+0x3f8>
    800060d8:	00600793          	li	a5,6
    800060dc:	00500c93          	li	s9,5
    800060e0:	c09ff06f          	j	80005ce8 <__printf+0x260>
    800060e4:	00800793          	li	a5,8
    800060e8:	00700c93          	li	s9,7
    800060ec:	bfdff06f          	j	80005ce8 <__printf+0x260>
    800060f0:	00100793          	li	a5,1
    800060f4:	d91ff06f          	j	80005e84 <__printf+0x3fc>
    800060f8:	00100793          	li	a5,1
    800060fc:	bf1ff06f          	j	80005cec <__printf+0x264>
    80006100:	00900793          	li	a5,9
    80006104:	00800c93          	li	s9,8
    80006108:	be1ff06f          	j	80005ce8 <__printf+0x260>
    8000610c:	00002517          	auipc	a0,0x2
    80006110:	5d450513          	addi	a0,a0,1492 # 800086e0 <kvmincrease+0x14f0>
    80006114:	00000097          	auipc	ra,0x0
    80006118:	918080e7          	jalr	-1768(ra) # 80005a2c <panic>

000000008000611c <printfinit>:
    8000611c:	fe010113          	addi	sp,sp,-32
    80006120:	00813823          	sd	s0,16(sp)
    80006124:	00913423          	sd	s1,8(sp)
    80006128:	00113c23          	sd	ra,24(sp)
    8000612c:	02010413          	addi	s0,sp,32
    80006130:	00005497          	auipc	s1,0x5
    80006134:	13048493          	addi	s1,s1,304 # 8000b260 <pr>
    80006138:	00048513          	mv	a0,s1
    8000613c:	00002597          	auipc	a1,0x2
    80006140:	5b458593          	addi	a1,a1,1460 # 800086f0 <kvmincrease+0x1500>
    80006144:	00000097          	auipc	ra,0x0
    80006148:	5f4080e7          	jalr	1524(ra) # 80006738 <initlock>
    8000614c:	01813083          	ld	ra,24(sp)
    80006150:	01013403          	ld	s0,16(sp)
    80006154:	0004ac23          	sw	zero,24(s1)
    80006158:	00813483          	ld	s1,8(sp)
    8000615c:	02010113          	addi	sp,sp,32
    80006160:	00008067          	ret

0000000080006164 <uartinit>:
    80006164:	ff010113          	addi	sp,sp,-16
    80006168:	00813423          	sd	s0,8(sp)
    8000616c:	01010413          	addi	s0,sp,16
    80006170:	100007b7          	lui	a5,0x10000
    80006174:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006178:	f8000713          	li	a4,-128
    8000617c:	00e781a3          	sb	a4,3(a5)
    80006180:	00300713          	li	a4,3
    80006184:	00e78023          	sb	a4,0(a5)
    80006188:	000780a3          	sb	zero,1(a5)
    8000618c:	00e781a3          	sb	a4,3(a5)
    80006190:	00700693          	li	a3,7
    80006194:	00d78123          	sb	a3,2(a5)
    80006198:	00e780a3          	sb	a4,1(a5)
    8000619c:	00813403          	ld	s0,8(sp)
    800061a0:	01010113          	addi	sp,sp,16
    800061a4:	00008067          	ret

00000000800061a8 <uartputc>:
    800061a8:	00004797          	auipc	a5,0x4
    800061ac:	e107a783          	lw	a5,-496(a5) # 80009fb8 <panicked>
    800061b0:	00078463          	beqz	a5,800061b8 <uartputc+0x10>
    800061b4:	0000006f          	j	800061b4 <uartputc+0xc>
    800061b8:	fd010113          	addi	sp,sp,-48
    800061bc:	02813023          	sd	s0,32(sp)
    800061c0:	00913c23          	sd	s1,24(sp)
    800061c4:	01213823          	sd	s2,16(sp)
    800061c8:	01313423          	sd	s3,8(sp)
    800061cc:	02113423          	sd	ra,40(sp)
    800061d0:	03010413          	addi	s0,sp,48
    800061d4:	00004917          	auipc	s2,0x4
    800061d8:	dec90913          	addi	s2,s2,-532 # 80009fc0 <uart_tx_r>
    800061dc:	00093783          	ld	a5,0(s2)
    800061e0:	00004497          	auipc	s1,0x4
    800061e4:	de848493          	addi	s1,s1,-536 # 80009fc8 <uart_tx_w>
    800061e8:	0004b703          	ld	a4,0(s1)
    800061ec:	02078693          	addi	a3,a5,32
    800061f0:	00050993          	mv	s3,a0
    800061f4:	02e69c63          	bne	a3,a4,8000622c <uartputc+0x84>
    800061f8:	00001097          	auipc	ra,0x1
    800061fc:	834080e7          	jalr	-1996(ra) # 80006a2c <push_on>
    80006200:	00093783          	ld	a5,0(s2)
    80006204:	0004b703          	ld	a4,0(s1)
    80006208:	02078793          	addi	a5,a5,32
    8000620c:	00e79463          	bne	a5,a4,80006214 <uartputc+0x6c>
    80006210:	0000006f          	j	80006210 <uartputc+0x68>
    80006214:	00001097          	auipc	ra,0x1
    80006218:	88c080e7          	jalr	-1908(ra) # 80006aa0 <pop_on>
    8000621c:	00093783          	ld	a5,0(s2)
    80006220:	0004b703          	ld	a4,0(s1)
    80006224:	02078693          	addi	a3,a5,32
    80006228:	fce688e3          	beq	a3,a4,800061f8 <uartputc+0x50>
    8000622c:	01f77693          	andi	a3,a4,31
    80006230:	00005597          	auipc	a1,0x5
    80006234:	05058593          	addi	a1,a1,80 # 8000b280 <uart_tx_buf>
    80006238:	00d586b3          	add	a3,a1,a3
    8000623c:	00170713          	addi	a4,a4,1
    80006240:	01368023          	sb	s3,0(a3)
    80006244:	00e4b023          	sd	a4,0(s1)
    80006248:	10000637          	lui	a2,0x10000
    8000624c:	02f71063          	bne	a4,a5,8000626c <uartputc+0xc4>
    80006250:	0340006f          	j	80006284 <uartputc+0xdc>
    80006254:	00074703          	lbu	a4,0(a4)
    80006258:	00f93023          	sd	a5,0(s2)
    8000625c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006260:	00093783          	ld	a5,0(s2)
    80006264:	0004b703          	ld	a4,0(s1)
    80006268:	00f70e63          	beq	a4,a5,80006284 <uartputc+0xdc>
    8000626c:	00564683          	lbu	a3,5(a2)
    80006270:	01f7f713          	andi	a4,a5,31
    80006274:	00e58733          	add	a4,a1,a4
    80006278:	0206f693          	andi	a3,a3,32
    8000627c:	00178793          	addi	a5,a5,1
    80006280:	fc069ae3          	bnez	a3,80006254 <uartputc+0xac>
    80006284:	02813083          	ld	ra,40(sp)
    80006288:	02013403          	ld	s0,32(sp)
    8000628c:	01813483          	ld	s1,24(sp)
    80006290:	01013903          	ld	s2,16(sp)
    80006294:	00813983          	ld	s3,8(sp)
    80006298:	03010113          	addi	sp,sp,48
    8000629c:	00008067          	ret

00000000800062a0 <uartputc_sync>:
    800062a0:	ff010113          	addi	sp,sp,-16
    800062a4:	00813423          	sd	s0,8(sp)
    800062a8:	01010413          	addi	s0,sp,16
    800062ac:	00004717          	auipc	a4,0x4
    800062b0:	d0c72703          	lw	a4,-756(a4) # 80009fb8 <panicked>
    800062b4:	02071663          	bnez	a4,800062e0 <uartputc_sync+0x40>
    800062b8:	00050793          	mv	a5,a0
    800062bc:	100006b7          	lui	a3,0x10000
    800062c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800062c4:	02077713          	andi	a4,a4,32
    800062c8:	fe070ce3          	beqz	a4,800062c0 <uartputc_sync+0x20>
    800062cc:	0ff7f793          	andi	a5,a5,255
    800062d0:	00f68023          	sb	a5,0(a3)
    800062d4:	00813403          	ld	s0,8(sp)
    800062d8:	01010113          	addi	sp,sp,16
    800062dc:	00008067          	ret
    800062e0:	0000006f          	j	800062e0 <uartputc_sync+0x40>

00000000800062e4 <uartstart>:
    800062e4:	ff010113          	addi	sp,sp,-16
    800062e8:	00813423          	sd	s0,8(sp)
    800062ec:	01010413          	addi	s0,sp,16
    800062f0:	00004617          	auipc	a2,0x4
    800062f4:	cd060613          	addi	a2,a2,-816 # 80009fc0 <uart_tx_r>
    800062f8:	00004517          	auipc	a0,0x4
    800062fc:	cd050513          	addi	a0,a0,-816 # 80009fc8 <uart_tx_w>
    80006300:	00063783          	ld	a5,0(a2)
    80006304:	00053703          	ld	a4,0(a0)
    80006308:	04f70263          	beq	a4,a5,8000634c <uartstart+0x68>
    8000630c:	100005b7          	lui	a1,0x10000
    80006310:	00005817          	auipc	a6,0x5
    80006314:	f7080813          	addi	a6,a6,-144 # 8000b280 <uart_tx_buf>
    80006318:	01c0006f          	j	80006334 <uartstart+0x50>
    8000631c:	0006c703          	lbu	a4,0(a3)
    80006320:	00f63023          	sd	a5,0(a2)
    80006324:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006328:	00063783          	ld	a5,0(a2)
    8000632c:	00053703          	ld	a4,0(a0)
    80006330:	00f70e63          	beq	a4,a5,8000634c <uartstart+0x68>
    80006334:	01f7f713          	andi	a4,a5,31
    80006338:	00e806b3          	add	a3,a6,a4
    8000633c:	0055c703          	lbu	a4,5(a1)
    80006340:	00178793          	addi	a5,a5,1
    80006344:	02077713          	andi	a4,a4,32
    80006348:	fc071ae3          	bnez	a4,8000631c <uartstart+0x38>
    8000634c:	00813403          	ld	s0,8(sp)
    80006350:	01010113          	addi	sp,sp,16
    80006354:	00008067          	ret

0000000080006358 <uartgetc>:
    80006358:	ff010113          	addi	sp,sp,-16
    8000635c:	00813423          	sd	s0,8(sp)
    80006360:	01010413          	addi	s0,sp,16
    80006364:	10000737          	lui	a4,0x10000
    80006368:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000636c:	0017f793          	andi	a5,a5,1
    80006370:	00078c63          	beqz	a5,80006388 <uartgetc+0x30>
    80006374:	00074503          	lbu	a0,0(a4)
    80006378:	0ff57513          	andi	a0,a0,255
    8000637c:	00813403          	ld	s0,8(sp)
    80006380:	01010113          	addi	sp,sp,16
    80006384:	00008067          	ret
    80006388:	fff00513          	li	a0,-1
    8000638c:	ff1ff06f          	j	8000637c <uartgetc+0x24>

0000000080006390 <uartintr>:
    80006390:	100007b7          	lui	a5,0x10000
    80006394:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006398:	0017f793          	andi	a5,a5,1
    8000639c:	0a078463          	beqz	a5,80006444 <uartintr+0xb4>
    800063a0:	fe010113          	addi	sp,sp,-32
    800063a4:	00813823          	sd	s0,16(sp)
    800063a8:	00913423          	sd	s1,8(sp)
    800063ac:	00113c23          	sd	ra,24(sp)
    800063b0:	02010413          	addi	s0,sp,32
    800063b4:	100004b7          	lui	s1,0x10000
    800063b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800063bc:	0ff57513          	andi	a0,a0,255
    800063c0:	fffff097          	auipc	ra,0xfffff
    800063c4:	534080e7          	jalr	1332(ra) # 800058f4 <consoleintr>
    800063c8:	0054c783          	lbu	a5,5(s1)
    800063cc:	0017f793          	andi	a5,a5,1
    800063d0:	fe0794e3          	bnez	a5,800063b8 <uartintr+0x28>
    800063d4:	00004617          	auipc	a2,0x4
    800063d8:	bec60613          	addi	a2,a2,-1044 # 80009fc0 <uart_tx_r>
    800063dc:	00004517          	auipc	a0,0x4
    800063e0:	bec50513          	addi	a0,a0,-1044 # 80009fc8 <uart_tx_w>
    800063e4:	00063783          	ld	a5,0(a2)
    800063e8:	00053703          	ld	a4,0(a0)
    800063ec:	04f70263          	beq	a4,a5,80006430 <uartintr+0xa0>
    800063f0:	100005b7          	lui	a1,0x10000
    800063f4:	00005817          	auipc	a6,0x5
    800063f8:	e8c80813          	addi	a6,a6,-372 # 8000b280 <uart_tx_buf>
    800063fc:	01c0006f          	j	80006418 <uartintr+0x88>
    80006400:	0006c703          	lbu	a4,0(a3)
    80006404:	00f63023          	sd	a5,0(a2)
    80006408:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000640c:	00063783          	ld	a5,0(a2)
    80006410:	00053703          	ld	a4,0(a0)
    80006414:	00f70e63          	beq	a4,a5,80006430 <uartintr+0xa0>
    80006418:	01f7f713          	andi	a4,a5,31
    8000641c:	00e806b3          	add	a3,a6,a4
    80006420:	0055c703          	lbu	a4,5(a1)
    80006424:	00178793          	addi	a5,a5,1
    80006428:	02077713          	andi	a4,a4,32
    8000642c:	fc071ae3          	bnez	a4,80006400 <uartintr+0x70>
    80006430:	01813083          	ld	ra,24(sp)
    80006434:	01013403          	ld	s0,16(sp)
    80006438:	00813483          	ld	s1,8(sp)
    8000643c:	02010113          	addi	sp,sp,32
    80006440:	00008067          	ret
    80006444:	00004617          	auipc	a2,0x4
    80006448:	b7c60613          	addi	a2,a2,-1156 # 80009fc0 <uart_tx_r>
    8000644c:	00004517          	auipc	a0,0x4
    80006450:	b7c50513          	addi	a0,a0,-1156 # 80009fc8 <uart_tx_w>
    80006454:	00063783          	ld	a5,0(a2)
    80006458:	00053703          	ld	a4,0(a0)
    8000645c:	04f70263          	beq	a4,a5,800064a0 <uartintr+0x110>
    80006460:	100005b7          	lui	a1,0x10000
    80006464:	00005817          	auipc	a6,0x5
    80006468:	e1c80813          	addi	a6,a6,-484 # 8000b280 <uart_tx_buf>
    8000646c:	01c0006f          	j	80006488 <uartintr+0xf8>
    80006470:	0006c703          	lbu	a4,0(a3)
    80006474:	00f63023          	sd	a5,0(a2)
    80006478:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000647c:	00063783          	ld	a5,0(a2)
    80006480:	00053703          	ld	a4,0(a0)
    80006484:	02f70063          	beq	a4,a5,800064a4 <uartintr+0x114>
    80006488:	01f7f713          	andi	a4,a5,31
    8000648c:	00e806b3          	add	a3,a6,a4
    80006490:	0055c703          	lbu	a4,5(a1)
    80006494:	00178793          	addi	a5,a5,1
    80006498:	02077713          	andi	a4,a4,32
    8000649c:	fc071ae3          	bnez	a4,80006470 <uartintr+0xe0>
    800064a0:	00008067          	ret
    800064a4:	00008067          	ret

00000000800064a8 <kinit>:
    800064a8:	fc010113          	addi	sp,sp,-64
    800064ac:	02913423          	sd	s1,40(sp)
    800064b0:	fffff7b7          	lui	a5,0xfffff
    800064b4:	00006497          	auipc	s1,0x6
    800064b8:	dfb48493          	addi	s1,s1,-517 # 8000c2af <end+0xfff>
    800064bc:	02813823          	sd	s0,48(sp)
    800064c0:	01313c23          	sd	s3,24(sp)
    800064c4:	00f4f4b3          	and	s1,s1,a5
    800064c8:	02113c23          	sd	ra,56(sp)
    800064cc:	03213023          	sd	s2,32(sp)
    800064d0:	01413823          	sd	s4,16(sp)
    800064d4:	01513423          	sd	s5,8(sp)
    800064d8:	04010413          	addi	s0,sp,64
    800064dc:	000017b7          	lui	a5,0x1
    800064e0:	01100993          	li	s3,17
    800064e4:	00f487b3          	add	a5,s1,a5
    800064e8:	01b99993          	slli	s3,s3,0x1b
    800064ec:	06f9e063          	bltu	s3,a5,8000654c <kinit+0xa4>
    800064f0:	00005a97          	auipc	s5,0x5
    800064f4:	dc0a8a93          	addi	s5,s5,-576 # 8000b2b0 <end>
    800064f8:	0754ec63          	bltu	s1,s5,80006570 <kinit+0xc8>
    800064fc:	0734fa63          	bgeu	s1,s3,80006570 <kinit+0xc8>
    80006500:	00088a37          	lui	s4,0x88
    80006504:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006508:	00004917          	auipc	s2,0x4
    8000650c:	ac890913          	addi	s2,s2,-1336 # 80009fd0 <kmem>
    80006510:	00ca1a13          	slli	s4,s4,0xc
    80006514:	0140006f          	j	80006528 <kinit+0x80>
    80006518:	000017b7          	lui	a5,0x1
    8000651c:	00f484b3          	add	s1,s1,a5
    80006520:	0554e863          	bltu	s1,s5,80006570 <kinit+0xc8>
    80006524:	0534f663          	bgeu	s1,s3,80006570 <kinit+0xc8>
    80006528:	00001637          	lui	a2,0x1
    8000652c:	00100593          	li	a1,1
    80006530:	00048513          	mv	a0,s1
    80006534:	00000097          	auipc	ra,0x0
    80006538:	5e4080e7          	jalr	1508(ra) # 80006b18 <__memset>
    8000653c:	00093783          	ld	a5,0(s2)
    80006540:	00f4b023          	sd	a5,0(s1)
    80006544:	00993023          	sd	s1,0(s2)
    80006548:	fd4498e3          	bne	s1,s4,80006518 <kinit+0x70>
    8000654c:	03813083          	ld	ra,56(sp)
    80006550:	03013403          	ld	s0,48(sp)
    80006554:	02813483          	ld	s1,40(sp)
    80006558:	02013903          	ld	s2,32(sp)
    8000655c:	01813983          	ld	s3,24(sp)
    80006560:	01013a03          	ld	s4,16(sp)
    80006564:	00813a83          	ld	s5,8(sp)
    80006568:	04010113          	addi	sp,sp,64
    8000656c:	00008067          	ret
    80006570:	00002517          	auipc	a0,0x2
    80006574:	1a050513          	addi	a0,a0,416 # 80008710 <digits+0x18>
    80006578:	fffff097          	auipc	ra,0xfffff
    8000657c:	4b4080e7          	jalr	1204(ra) # 80005a2c <panic>

0000000080006580 <freerange>:
    80006580:	fc010113          	addi	sp,sp,-64
    80006584:	000017b7          	lui	a5,0x1
    80006588:	02913423          	sd	s1,40(sp)
    8000658c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006590:	009504b3          	add	s1,a0,s1
    80006594:	fffff537          	lui	a0,0xfffff
    80006598:	02813823          	sd	s0,48(sp)
    8000659c:	02113c23          	sd	ra,56(sp)
    800065a0:	03213023          	sd	s2,32(sp)
    800065a4:	01313c23          	sd	s3,24(sp)
    800065a8:	01413823          	sd	s4,16(sp)
    800065ac:	01513423          	sd	s5,8(sp)
    800065b0:	01613023          	sd	s6,0(sp)
    800065b4:	04010413          	addi	s0,sp,64
    800065b8:	00a4f4b3          	and	s1,s1,a0
    800065bc:	00f487b3          	add	a5,s1,a5
    800065c0:	06f5e463          	bltu	a1,a5,80006628 <freerange+0xa8>
    800065c4:	00005a97          	auipc	s5,0x5
    800065c8:	ceca8a93          	addi	s5,s5,-788 # 8000b2b0 <end>
    800065cc:	0954e263          	bltu	s1,s5,80006650 <freerange+0xd0>
    800065d0:	01100993          	li	s3,17
    800065d4:	01b99993          	slli	s3,s3,0x1b
    800065d8:	0734fc63          	bgeu	s1,s3,80006650 <freerange+0xd0>
    800065dc:	00058a13          	mv	s4,a1
    800065e0:	00004917          	auipc	s2,0x4
    800065e4:	9f090913          	addi	s2,s2,-1552 # 80009fd0 <kmem>
    800065e8:	00002b37          	lui	s6,0x2
    800065ec:	0140006f          	j	80006600 <freerange+0x80>
    800065f0:	000017b7          	lui	a5,0x1
    800065f4:	00f484b3          	add	s1,s1,a5
    800065f8:	0554ec63          	bltu	s1,s5,80006650 <freerange+0xd0>
    800065fc:	0534fa63          	bgeu	s1,s3,80006650 <freerange+0xd0>
    80006600:	00001637          	lui	a2,0x1
    80006604:	00100593          	li	a1,1
    80006608:	00048513          	mv	a0,s1
    8000660c:	00000097          	auipc	ra,0x0
    80006610:	50c080e7          	jalr	1292(ra) # 80006b18 <__memset>
    80006614:	00093703          	ld	a4,0(s2)
    80006618:	016487b3          	add	a5,s1,s6
    8000661c:	00e4b023          	sd	a4,0(s1)
    80006620:	00993023          	sd	s1,0(s2)
    80006624:	fcfa76e3          	bgeu	s4,a5,800065f0 <freerange+0x70>
    80006628:	03813083          	ld	ra,56(sp)
    8000662c:	03013403          	ld	s0,48(sp)
    80006630:	02813483          	ld	s1,40(sp)
    80006634:	02013903          	ld	s2,32(sp)
    80006638:	01813983          	ld	s3,24(sp)
    8000663c:	01013a03          	ld	s4,16(sp)
    80006640:	00813a83          	ld	s5,8(sp)
    80006644:	00013b03          	ld	s6,0(sp)
    80006648:	04010113          	addi	sp,sp,64
    8000664c:	00008067          	ret
    80006650:	00002517          	auipc	a0,0x2
    80006654:	0c050513          	addi	a0,a0,192 # 80008710 <digits+0x18>
    80006658:	fffff097          	auipc	ra,0xfffff
    8000665c:	3d4080e7          	jalr	980(ra) # 80005a2c <panic>

0000000080006660 <kfree>:
    80006660:	fe010113          	addi	sp,sp,-32
    80006664:	00813823          	sd	s0,16(sp)
    80006668:	00113c23          	sd	ra,24(sp)
    8000666c:	00913423          	sd	s1,8(sp)
    80006670:	02010413          	addi	s0,sp,32
    80006674:	03451793          	slli	a5,a0,0x34
    80006678:	04079c63          	bnez	a5,800066d0 <kfree+0x70>
    8000667c:	00005797          	auipc	a5,0x5
    80006680:	c3478793          	addi	a5,a5,-972 # 8000b2b0 <end>
    80006684:	00050493          	mv	s1,a0
    80006688:	04f56463          	bltu	a0,a5,800066d0 <kfree+0x70>
    8000668c:	01100793          	li	a5,17
    80006690:	01b79793          	slli	a5,a5,0x1b
    80006694:	02f57e63          	bgeu	a0,a5,800066d0 <kfree+0x70>
    80006698:	00001637          	lui	a2,0x1
    8000669c:	00100593          	li	a1,1
    800066a0:	00000097          	auipc	ra,0x0
    800066a4:	478080e7          	jalr	1144(ra) # 80006b18 <__memset>
    800066a8:	00004797          	auipc	a5,0x4
    800066ac:	92878793          	addi	a5,a5,-1752 # 80009fd0 <kmem>
    800066b0:	0007b703          	ld	a4,0(a5)
    800066b4:	01813083          	ld	ra,24(sp)
    800066b8:	01013403          	ld	s0,16(sp)
    800066bc:	00e4b023          	sd	a4,0(s1)
    800066c0:	0097b023          	sd	s1,0(a5)
    800066c4:	00813483          	ld	s1,8(sp)
    800066c8:	02010113          	addi	sp,sp,32
    800066cc:	00008067          	ret
    800066d0:	00002517          	auipc	a0,0x2
    800066d4:	04050513          	addi	a0,a0,64 # 80008710 <digits+0x18>
    800066d8:	fffff097          	auipc	ra,0xfffff
    800066dc:	354080e7          	jalr	852(ra) # 80005a2c <panic>

00000000800066e0 <kalloc>:
    800066e0:	fe010113          	addi	sp,sp,-32
    800066e4:	00813823          	sd	s0,16(sp)
    800066e8:	00913423          	sd	s1,8(sp)
    800066ec:	00113c23          	sd	ra,24(sp)
    800066f0:	02010413          	addi	s0,sp,32
    800066f4:	00004797          	auipc	a5,0x4
    800066f8:	8dc78793          	addi	a5,a5,-1828 # 80009fd0 <kmem>
    800066fc:	0007b483          	ld	s1,0(a5)
    80006700:	02048063          	beqz	s1,80006720 <kalloc+0x40>
    80006704:	0004b703          	ld	a4,0(s1)
    80006708:	00001637          	lui	a2,0x1
    8000670c:	00500593          	li	a1,5
    80006710:	00048513          	mv	a0,s1
    80006714:	00e7b023          	sd	a4,0(a5)
    80006718:	00000097          	auipc	ra,0x0
    8000671c:	400080e7          	jalr	1024(ra) # 80006b18 <__memset>
    80006720:	01813083          	ld	ra,24(sp)
    80006724:	01013403          	ld	s0,16(sp)
    80006728:	00048513          	mv	a0,s1
    8000672c:	00813483          	ld	s1,8(sp)
    80006730:	02010113          	addi	sp,sp,32
    80006734:	00008067          	ret

0000000080006738 <initlock>:
    80006738:	ff010113          	addi	sp,sp,-16
    8000673c:	00813423          	sd	s0,8(sp)
    80006740:	01010413          	addi	s0,sp,16
    80006744:	00813403          	ld	s0,8(sp)
    80006748:	00b53423          	sd	a1,8(a0)
    8000674c:	00052023          	sw	zero,0(a0)
    80006750:	00053823          	sd	zero,16(a0)
    80006754:	01010113          	addi	sp,sp,16
    80006758:	00008067          	ret

000000008000675c <acquire>:
    8000675c:	fe010113          	addi	sp,sp,-32
    80006760:	00813823          	sd	s0,16(sp)
    80006764:	00913423          	sd	s1,8(sp)
    80006768:	00113c23          	sd	ra,24(sp)
    8000676c:	01213023          	sd	s2,0(sp)
    80006770:	02010413          	addi	s0,sp,32
    80006774:	00050493          	mv	s1,a0
    80006778:	10002973          	csrr	s2,sstatus
    8000677c:	100027f3          	csrr	a5,sstatus
    80006780:	ffd7f793          	andi	a5,a5,-3
    80006784:	10079073          	csrw	sstatus,a5
    80006788:	fffff097          	auipc	ra,0xfffff
    8000678c:	8ec080e7          	jalr	-1812(ra) # 80005074 <mycpu>
    80006790:	07852783          	lw	a5,120(a0)
    80006794:	06078e63          	beqz	a5,80006810 <acquire+0xb4>
    80006798:	fffff097          	auipc	ra,0xfffff
    8000679c:	8dc080e7          	jalr	-1828(ra) # 80005074 <mycpu>
    800067a0:	07852783          	lw	a5,120(a0)
    800067a4:	0004a703          	lw	a4,0(s1)
    800067a8:	0017879b          	addiw	a5,a5,1
    800067ac:	06f52c23          	sw	a5,120(a0)
    800067b0:	04071063          	bnez	a4,800067f0 <acquire+0x94>
    800067b4:	00100713          	li	a4,1
    800067b8:	00070793          	mv	a5,a4
    800067bc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800067c0:	0007879b          	sext.w	a5,a5
    800067c4:	fe079ae3          	bnez	a5,800067b8 <acquire+0x5c>
    800067c8:	0ff0000f          	fence
    800067cc:	fffff097          	auipc	ra,0xfffff
    800067d0:	8a8080e7          	jalr	-1880(ra) # 80005074 <mycpu>
    800067d4:	01813083          	ld	ra,24(sp)
    800067d8:	01013403          	ld	s0,16(sp)
    800067dc:	00a4b823          	sd	a0,16(s1)
    800067e0:	00013903          	ld	s2,0(sp)
    800067e4:	00813483          	ld	s1,8(sp)
    800067e8:	02010113          	addi	sp,sp,32
    800067ec:	00008067          	ret
    800067f0:	0104b903          	ld	s2,16(s1)
    800067f4:	fffff097          	auipc	ra,0xfffff
    800067f8:	880080e7          	jalr	-1920(ra) # 80005074 <mycpu>
    800067fc:	faa91ce3          	bne	s2,a0,800067b4 <acquire+0x58>
    80006800:	00002517          	auipc	a0,0x2
    80006804:	f1850513          	addi	a0,a0,-232 # 80008718 <digits+0x20>
    80006808:	fffff097          	auipc	ra,0xfffff
    8000680c:	224080e7          	jalr	548(ra) # 80005a2c <panic>
    80006810:	00195913          	srli	s2,s2,0x1
    80006814:	fffff097          	auipc	ra,0xfffff
    80006818:	860080e7          	jalr	-1952(ra) # 80005074 <mycpu>
    8000681c:	00197913          	andi	s2,s2,1
    80006820:	07252e23          	sw	s2,124(a0)
    80006824:	f75ff06f          	j	80006798 <acquire+0x3c>

0000000080006828 <release>:
    80006828:	fe010113          	addi	sp,sp,-32
    8000682c:	00813823          	sd	s0,16(sp)
    80006830:	00113c23          	sd	ra,24(sp)
    80006834:	00913423          	sd	s1,8(sp)
    80006838:	01213023          	sd	s2,0(sp)
    8000683c:	02010413          	addi	s0,sp,32
    80006840:	00052783          	lw	a5,0(a0)
    80006844:	00079a63          	bnez	a5,80006858 <release+0x30>
    80006848:	00002517          	auipc	a0,0x2
    8000684c:	ed850513          	addi	a0,a0,-296 # 80008720 <digits+0x28>
    80006850:	fffff097          	auipc	ra,0xfffff
    80006854:	1dc080e7          	jalr	476(ra) # 80005a2c <panic>
    80006858:	01053903          	ld	s2,16(a0)
    8000685c:	00050493          	mv	s1,a0
    80006860:	fffff097          	auipc	ra,0xfffff
    80006864:	814080e7          	jalr	-2028(ra) # 80005074 <mycpu>
    80006868:	fea910e3          	bne	s2,a0,80006848 <release+0x20>
    8000686c:	0004b823          	sd	zero,16(s1)
    80006870:	0ff0000f          	fence
    80006874:	0f50000f          	fence	iorw,ow
    80006878:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000687c:	ffffe097          	auipc	ra,0xffffe
    80006880:	7f8080e7          	jalr	2040(ra) # 80005074 <mycpu>
    80006884:	100027f3          	csrr	a5,sstatus
    80006888:	0027f793          	andi	a5,a5,2
    8000688c:	04079a63          	bnez	a5,800068e0 <release+0xb8>
    80006890:	07852783          	lw	a5,120(a0)
    80006894:	02f05e63          	blez	a5,800068d0 <release+0xa8>
    80006898:	fff7871b          	addiw	a4,a5,-1
    8000689c:	06e52c23          	sw	a4,120(a0)
    800068a0:	00071c63          	bnez	a4,800068b8 <release+0x90>
    800068a4:	07c52783          	lw	a5,124(a0)
    800068a8:	00078863          	beqz	a5,800068b8 <release+0x90>
    800068ac:	100027f3          	csrr	a5,sstatus
    800068b0:	0027e793          	ori	a5,a5,2
    800068b4:	10079073          	csrw	sstatus,a5
    800068b8:	01813083          	ld	ra,24(sp)
    800068bc:	01013403          	ld	s0,16(sp)
    800068c0:	00813483          	ld	s1,8(sp)
    800068c4:	00013903          	ld	s2,0(sp)
    800068c8:	02010113          	addi	sp,sp,32
    800068cc:	00008067          	ret
    800068d0:	00002517          	auipc	a0,0x2
    800068d4:	e7050513          	addi	a0,a0,-400 # 80008740 <digits+0x48>
    800068d8:	fffff097          	auipc	ra,0xfffff
    800068dc:	154080e7          	jalr	340(ra) # 80005a2c <panic>
    800068e0:	00002517          	auipc	a0,0x2
    800068e4:	e4850513          	addi	a0,a0,-440 # 80008728 <digits+0x30>
    800068e8:	fffff097          	auipc	ra,0xfffff
    800068ec:	144080e7          	jalr	324(ra) # 80005a2c <panic>

00000000800068f0 <holding>:
    800068f0:	00052783          	lw	a5,0(a0)
    800068f4:	00079663          	bnez	a5,80006900 <holding+0x10>
    800068f8:	00000513          	li	a0,0
    800068fc:	00008067          	ret
    80006900:	fe010113          	addi	sp,sp,-32
    80006904:	00813823          	sd	s0,16(sp)
    80006908:	00913423          	sd	s1,8(sp)
    8000690c:	00113c23          	sd	ra,24(sp)
    80006910:	02010413          	addi	s0,sp,32
    80006914:	01053483          	ld	s1,16(a0)
    80006918:	ffffe097          	auipc	ra,0xffffe
    8000691c:	75c080e7          	jalr	1884(ra) # 80005074 <mycpu>
    80006920:	01813083          	ld	ra,24(sp)
    80006924:	01013403          	ld	s0,16(sp)
    80006928:	40a48533          	sub	a0,s1,a0
    8000692c:	00153513          	seqz	a0,a0
    80006930:	00813483          	ld	s1,8(sp)
    80006934:	02010113          	addi	sp,sp,32
    80006938:	00008067          	ret

000000008000693c <push_off>:
    8000693c:	fe010113          	addi	sp,sp,-32
    80006940:	00813823          	sd	s0,16(sp)
    80006944:	00113c23          	sd	ra,24(sp)
    80006948:	00913423          	sd	s1,8(sp)
    8000694c:	02010413          	addi	s0,sp,32
    80006950:	100024f3          	csrr	s1,sstatus
    80006954:	100027f3          	csrr	a5,sstatus
    80006958:	ffd7f793          	andi	a5,a5,-3
    8000695c:	10079073          	csrw	sstatus,a5
    80006960:	ffffe097          	auipc	ra,0xffffe
    80006964:	714080e7          	jalr	1812(ra) # 80005074 <mycpu>
    80006968:	07852783          	lw	a5,120(a0)
    8000696c:	02078663          	beqz	a5,80006998 <push_off+0x5c>
    80006970:	ffffe097          	auipc	ra,0xffffe
    80006974:	704080e7          	jalr	1796(ra) # 80005074 <mycpu>
    80006978:	07852783          	lw	a5,120(a0)
    8000697c:	01813083          	ld	ra,24(sp)
    80006980:	01013403          	ld	s0,16(sp)
    80006984:	0017879b          	addiw	a5,a5,1
    80006988:	06f52c23          	sw	a5,120(a0)
    8000698c:	00813483          	ld	s1,8(sp)
    80006990:	02010113          	addi	sp,sp,32
    80006994:	00008067          	ret
    80006998:	0014d493          	srli	s1,s1,0x1
    8000699c:	ffffe097          	auipc	ra,0xffffe
    800069a0:	6d8080e7          	jalr	1752(ra) # 80005074 <mycpu>
    800069a4:	0014f493          	andi	s1,s1,1
    800069a8:	06952e23          	sw	s1,124(a0)
    800069ac:	fc5ff06f          	j	80006970 <push_off+0x34>

00000000800069b0 <pop_off>:
    800069b0:	ff010113          	addi	sp,sp,-16
    800069b4:	00813023          	sd	s0,0(sp)
    800069b8:	00113423          	sd	ra,8(sp)
    800069bc:	01010413          	addi	s0,sp,16
    800069c0:	ffffe097          	auipc	ra,0xffffe
    800069c4:	6b4080e7          	jalr	1716(ra) # 80005074 <mycpu>
    800069c8:	100027f3          	csrr	a5,sstatus
    800069cc:	0027f793          	andi	a5,a5,2
    800069d0:	04079663          	bnez	a5,80006a1c <pop_off+0x6c>
    800069d4:	07852783          	lw	a5,120(a0)
    800069d8:	02f05a63          	blez	a5,80006a0c <pop_off+0x5c>
    800069dc:	fff7871b          	addiw	a4,a5,-1
    800069e0:	06e52c23          	sw	a4,120(a0)
    800069e4:	00071c63          	bnez	a4,800069fc <pop_off+0x4c>
    800069e8:	07c52783          	lw	a5,124(a0)
    800069ec:	00078863          	beqz	a5,800069fc <pop_off+0x4c>
    800069f0:	100027f3          	csrr	a5,sstatus
    800069f4:	0027e793          	ori	a5,a5,2
    800069f8:	10079073          	csrw	sstatus,a5
    800069fc:	00813083          	ld	ra,8(sp)
    80006a00:	00013403          	ld	s0,0(sp)
    80006a04:	01010113          	addi	sp,sp,16
    80006a08:	00008067          	ret
    80006a0c:	00002517          	auipc	a0,0x2
    80006a10:	d3450513          	addi	a0,a0,-716 # 80008740 <digits+0x48>
    80006a14:	fffff097          	auipc	ra,0xfffff
    80006a18:	018080e7          	jalr	24(ra) # 80005a2c <panic>
    80006a1c:	00002517          	auipc	a0,0x2
    80006a20:	d0c50513          	addi	a0,a0,-756 # 80008728 <digits+0x30>
    80006a24:	fffff097          	auipc	ra,0xfffff
    80006a28:	008080e7          	jalr	8(ra) # 80005a2c <panic>

0000000080006a2c <push_on>:
    80006a2c:	fe010113          	addi	sp,sp,-32
    80006a30:	00813823          	sd	s0,16(sp)
    80006a34:	00113c23          	sd	ra,24(sp)
    80006a38:	00913423          	sd	s1,8(sp)
    80006a3c:	02010413          	addi	s0,sp,32
    80006a40:	100024f3          	csrr	s1,sstatus
    80006a44:	100027f3          	csrr	a5,sstatus
    80006a48:	0027e793          	ori	a5,a5,2
    80006a4c:	10079073          	csrw	sstatus,a5
    80006a50:	ffffe097          	auipc	ra,0xffffe
    80006a54:	624080e7          	jalr	1572(ra) # 80005074 <mycpu>
    80006a58:	07852783          	lw	a5,120(a0)
    80006a5c:	02078663          	beqz	a5,80006a88 <push_on+0x5c>
    80006a60:	ffffe097          	auipc	ra,0xffffe
    80006a64:	614080e7          	jalr	1556(ra) # 80005074 <mycpu>
    80006a68:	07852783          	lw	a5,120(a0)
    80006a6c:	01813083          	ld	ra,24(sp)
    80006a70:	01013403          	ld	s0,16(sp)
    80006a74:	0017879b          	addiw	a5,a5,1
    80006a78:	06f52c23          	sw	a5,120(a0)
    80006a7c:	00813483          	ld	s1,8(sp)
    80006a80:	02010113          	addi	sp,sp,32
    80006a84:	00008067          	ret
    80006a88:	0014d493          	srli	s1,s1,0x1
    80006a8c:	ffffe097          	auipc	ra,0xffffe
    80006a90:	5e8080e7          	jalr	1512(ra) # 80005074 <mycpu>
    80006a94:	0014f493          	andi	s1,s1,1
    80006a98:	06952e23          	sw	s1,124(a0)
    80006a9c:	fc5ff06f          	j	80006a60 <push_on+0x34>

0000000080006aa0 <pop_on>:
    80006aa0:	ff010113          	addi	sp,sp,-16
    80006aa4:	00813023          	sd	s0,0(sp)
    80006aa8:	00113423          	sd	ra,8(sp)
    80006aac:	01010413          	addi	s0,sp,16
    80006ab0:	ffffe097          	auipc	ra,0xffffe
    80006ab4:	5c4080e7          	jalr	1476(ra) # 80005074 <mycpu>
    80006ab8:	100027f3          	csrr	a5,sstatus
    80006abc:	0027f793          	andi	a5,a5,2
    80006ac0:	04078463          	beqz	a5,80006b08 <pop_on+0x68>
    80006ac4:	07852783          	lw	a5,120(a0)
    80006ac8:	02f05863          	blez	a5,80006af8 <pop_on+0x58>
    80006acc:	fff7879b          	addiw	a5,a5,-1
    80006ad0:	06f52c23          	sw	a5,120(a0)
    80006ad4:	07853783          	ld	a5,120(a0)
    80006ad8:	00079863          	bnez	a5,80006ae8 <pop_on+0x48>
    80006adc:	100027f3          	csrr	a5,sstatus
    80006ae0:	ffd7f793          	andi	a5,a5,-3
    80006ae4:	10079073          	csrw	sstatus,a5
    80006ae8:	00813083          	ld	ra,8(sp)
    80006aec:	00013403          	ld	s0,0(sp)
    80006af0:	01010113          	addi	sp,sp,16
    80006af4:	00008067          	ret
    80006af8:	00002517          	auipc	a0,0x2
    80006afc:	c7050513          	addi	a0,a0,-912 # 80008768 <digits+0x70>
    80006b00:	fffff097          	auipc	ra,0xfffff
    80006b04:	f2c080e7          	jalr	-212(ra) # 80005a2c <panic>
    80006b08:	00002517          	auipc	a0,0x2
    80006b0c:	c4050513          	addi	a0,a0,-960 # 80008748 <digits+0x50>
    80006b10:	fffff097          	auipc	ra,0xfffff
    80006b14:	f1c080e7          	jalr	-228(ra) # 80005a2c <panic>

0000000080006b18 <__memset>:
    80006b18:	ff010113          	addi	sp,sp,-16
    80006b1c:	00813423          	sd	s0,8(sp)
    80006b20:	01010413          	addi	s0,sp,16
    80006b24:	1a060e63          	beqz	a2,80006ce0 <__memset+0x1c8>
    80006b28:	40a007b3          	neg	a5,a0
    80006b2c:	0077f793          	andi	a5,a5,7
    80006b30:	00778693          	addi	a3,a5,7
    80006b34:	00b00813          	li	a6,11
    80006b38:	0ff5f593          	andi	a1,a1,255
    80006b3c:	fff6071b          	addiw	a4,a2,-1
    80006b40:	1b06e663          	bltu	a3,a6,80006cec <__memset+0x1d4>
    80006b44:	1cd76463          	bltu	a4,a3,80006d0c <__memset+0x1f4>
    80006b48:	1a078e63          	beqz	a5,80006d04 <__memset+0x1ec>
    80006b4c:	00b50023          	sb	a1,0(a0)
    80006b50:	00100713          	li	a4,1
    80006b54:	1ae78463          	beq	a5,a4,80006cfc <__memset+0x1e4>
    80006b58:	00b500a3          	sb	a1,1(a0)
    80006b5c:	00200713          	li	a4,2
    80006b60:	1ae78a63          	beq	a5,a4,80006d14 <__memset+0x1fc>
    80006b64:	00b50123          	sb	a1,2(a0)
    80006b68:	00300713          	li	a4,3
    80006b6c:	18e78463          	beq	a5,a4,80006cf4 <__memset+0x1dc>
    80006b70:	00b501a3          	sb	a1,3(a0)
    80006b74:	00400713          	li	a4,4
    80006b78:	1ae78263          	beq	a5,a4,80006d1c <__memset+0x204>
    80006b7c:	00b50223          	sb	a1,4(a0)
    80006b80:	00500713          	li	a4,5
    80006b84:	1ae78063          	beq	a5,a4,80006d24 <__memset+0x20c>
    80006b88:	00b502a3          	sb	a1,5(a0)
    80006b8c:	00700713          	li	a4,7
    80006b90:	18e79e63          	bne	a5,a4,80006d2c <__memset+0x214>
    80006b94:	00b50323          	sb	a1,6(a0)
    80006b98:	00700e93          	li	t4,7
    80006b9c:	00859713          	slli	a4,a1,0x8
    80006ba0:	00e5e733          	or	a4,a1,a4
    80006ba4:	01059e13          	slli	t3,a1,0x10
    80006ba8:	01c76e33          	or	t3,a4,t3
    80006bac:	01859313          	slli	t1,a1,0x18
    80006bb0:	006e6333          	or	t1,t3,t1
    80006bb4:	02059893          	slli	a7,a1,0x20
    80006bb8:	40f60e3b          	subw	t3,a2,a5
    80006bbc:	011368b3          	or	a7,t1,a7
    80006bc0:	02859813          	slli	a6,a1,0x28
    80006bc4:	0108e833          	or	a6,a7,a6
    80006bc8:	03059693          	slli	a3,a1,0x30
    80006bcc:	003e589b          	srliw	a7,t3,0x3
    80006bd0:	00d866b3          	or	a3,a6,a3
    80006bd4:	03859713          	slli	a4,a1,0x38
    80006bd8:	00389813          	slli	a6,a7,0x3
    80006bdc:	00f507b3          	add	a5,a0,a5
    80006be0:	00e6e733          	or	a4,a3,a4
    80006be4:	000e089b          	sext.w	a7,t3
    80006be8:	00f806b3          	add	a3,a6,a5
    80006bec:	00e7b023          	sd	a4,0(a5)
    80006bf0:	00878793          	addi	a5,a5,8
    80006bf4:	fed79ce3          	bne	a5,a3,80006bec <__memset+0xd4>
    80006bf8:	ff8e7793          	andi	a5,t3,-8
    80006bfc:	0007871b          	sext.w	a4,a5
    80006c00:	01d787bb          	addw	a5,a5,t4
    80006c04:	0ce88e63          	beq	a7,a4,80006ce0 <__memset+0x1c8>
    80006c08:	00f50733          	add	a4,a0,a5
    80006c0c:	00b70023          	sb	a1,0(a4)
    80006c10:	0017871b          	addiw	a4,a5,1
    80006c14:	0cc77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c18:	00e50733          	add	a4,a0,a4
    80006c1c:	00b70023          	sb	a1,0(a4)
    80006c20:	0027871b          	addiw	a4,a5,2
    80006c24:	0ac77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c28:	00e50733          	add	a4,a0,a4
    80006c2c:	00b70023          	sb	a1,0(a4)
    80006c30:	0037871b          	addiw	a4,a5,3
    80006c34:	0ac77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c38:	00e50733          	add	a4,a0,a4
    80006c3c:	00b70023          	sb	a1,0(a4)
    80006c40:	0047871b          	addiw	a4,a5,4
    80006c44:	08c77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c48:	00e50733          	add	a4,a0,a4
    80006c4c:	00b70023          	sb	a1,0(a4)
    80006c50:	0057871b          	addiw	a4,a5,5
    80006c54:	08c77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c58:	00e50733          	add	a4,a0,a4
    80006c5c:	00b70023          	sb	a1,0(a4)
    80006c60:	0067871b          	addiw	a4,a5,6
    80006c64:	06c77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c68:	00e50733          	add	a4,a0,a4
    80006c6c:	00b70023          	sb	a1,0(a4)
    80006c70:	0077871b          	addiw	a4,a5,7
    80006c74:	06c77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c78:	00e50733          	add	a4,a0,a4
    80006c7c:	00b70023          	sb	a1,0(a4)
    80006c80:	0087871b          	addiw	a4,a5,8
    80006c84:	04c77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c88:	00e50733          	add	a4,a0,a4
    80006c8c:	00b70023          	sb	a1,0(a4)
    80006c90:	0097871b          	addiw	a4,a5,9
    80006c94:	04c77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006c98:	00e50733          	add	a4,a0,a4
    80006c9c:	00b70023          	sb	a1,0(a4)
    80006ca0:	00a7871b          	addiw	a4,a5,10
    80006ca4:	02c77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006ca8:	00e50733          	add	a4,a0,a4
    80006cac:	00b70023          	sb	a1,0(a4)
    80006cb0:	00b7871b          	addiw	a4,a5,11
    80006cb4:	02c77663          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006cb8:	00e50733          	add	a4,a0,a4
    80006cbc:	00b70023          	sb	a1,0(a4)
    80006cc0:	00c7871b          	addiw	a4,a5,12
    80006cc4:	00c77e63          	bgeu	a4,a2,80006ce0 <__memset+0x1c8>
    80006cc8:	00e50733          	add	a4,a0,a4
    80006ccc:	00b70023          	sb	a1,0(a4)
    80006cd0:	00d7879b          	addiw	a5,a5,13
    80006cd4:	00c7f663          	bgeu	a5,a2,80006ce0 <__memset+0x1c8>
    80006cd8:	00f507b3          	add	a5,a0,a5
    80006cdc:	00b78023          	sb	a1,0(a5)
    80006ce0:	00813403          	ld	s0,8(sp)
    80006ce4:	01010113          	addi	sp,sp,16
    80006ce8:	00008067          	ret
    80006cec:	00b00693          	li	a3,11
    80006cf0:	e55ff06f          	j	80006b44 <__memset+0x2c>
    80006cf4:	00300e93          	li	t4,3
    80006cf8:	ea5ff06f          	j	80006b9c <__memset+0x84>
    80006cfc:	00100e93          	li	t4,1
    80006d00:	e9dff06f          	j	80006b9c <__memset+0x84>
    80006d04:	00000e93          	li	t4,0
    80006d08:	e95ff06f          	j	80006b9c <__memset+0x84>
    80006d0c:	00000793          	li	a5,0
    80006d10:	ef9ff06f          	j	80006c08 <__memset+0xf0>
    80006d14:	00200e93          	li	t4,2
    80006d18:	e85ff06f          	j	80006b9c <__memset+0x84>
    80006d1c:	00400e93          	li	t4,4
    80006d20:	e7dff06f          	j	80006b9c <__memset+0x84>
    80006d24:	00500e93          	li	t4,5
    80006d28:	e75ff06f          	j	80006b9c <__memset+0x84>
    80006d2c:	00600e93          	li	t4,6
    80006d30:	e6dff06f          	j	80006b9c <__memset+0x84>

0000000080006d34 <__memmove>:
    80006d34:	ff010113          	addi	sp,sp,-16
    80006d38:	00813423          	sd	s0,8(sp)
    80006d3c:	01010413          	addi	s0,sp,16
    80006d40:	0e060863          	beqz	a2,80006e30 <__memmove+0xfc>
    80006d44:	fff6069b          	addiw	a3,a2,-1
    80006d48:	0006881b          	sext.w	a6,a3
    80006d4c:	0ea5e863          	bltu	a1,a0,80006e3c <__memmove+0x108>
    80006d50:	00758713          	addi	a4,a1,7
    80006d54:	00a5e7b3          	or	a5,a1,a0
    80006d58:	40a70733          	sub	a4,a4,a0
    80006d5c:	0077f793          	andi	a5,a5,7
    80006d60:	00f73713          	sltiu	a4,a4,15
    80006d64:	00174713          	xori	a4,a4,1
    80006d68:	0017b793          	seqz	a5,a5
    80006d6c:	00e7f7b3          	and	a5,a5,a4
    80006d70:	10078863          	beqz	a5,80006e80 <__memmove+0x14c>
    80006d74:	00900793          	li	a5,9
    80006d78:	1107f463          	bgeu	a5,a6,80006e80 <__memmove+0x14c>
    80006d7c:	0036581b          	srliw	a6,a2,0x3
    80006d80:	fff8081b          	addiw	a6,a6,-1
    80006d84:	02081813          	slli	a6,a6,0x20
    80006d88:	01d85893          	srli	a7,a6,0x1d
    80006d8c:	00858813          	addi	a6,a1,8
    80006d90:	00058793          	mv	a5,a1
    80006d94:	00050713          	mv	a4,a0
    80006d98:	01088833          	add	a6,a7,a6
    80006d9c:	0007b883          	ld	a7,0(a5)
    80006da0:	00878793          	addi	a5,a5,8
    80006da4:	00870713          	addi	a4,a4,8
    80006da8:	ff173c23          	sd	a7,-8(a4)
    80006dac:	ff0798e3          	bne	a5,a6,80006d9c <__memmove+0x68>
    80006db0:	ff867713          	andi	a4,a2,-8
    80006db4:	02071793          	slli	a5,a4,0x20
    80006db8:	0207d793          	srli	a5,a5,0x20
    80006dbc:	00f585b3          	add	a1,a1,a5
    80006dc0:	40e686bb          	subw	a3,a3,a4
    80006dc4:	00f507b3          	add	a5,a0,a5
    80006dc8:	06e60463          	beq	a2,a4,80006e30 <__memmove+0xfc>
    80006dcc:	0005c703          	lbu	a4,0(a1)
    80006dd0:	00e78023          	sb	a4,0(a5)
    80006dd4:	04068e63          	beqz	a3,80006e30 <__memmove+0xfc>
    80006dd8:	0015c603          	lbu	a2,1(a1)
    80006ddc:	00100713          	li	a4,1
    80006de0:	00c780a3          	sb	a2,1(a5)
    80006de4:	04e68663          	beq	a3,a4,80006e30 <__memmove+0xfc>
    80006de8:	0025c603          	lbu	a2,2(a1)
    80006dec:	00200713          	li	a4,2
    80006df0:	00c78123          	sb	a2,2(a5)
    80006df4:	02e68e63          	beq	a3,a4,80006e30 <__memmove+0xfc>
    80006df8:	0035c603          	lbu	a2,3(a1)
    80006dfc:	00300713          	li	a4,3
    80006e00:	00c781a3          	sb	a2,3(a5)
    80006e04:	02e68663          	beq	a3,a4,80006e30 <__memmove+0xfc>
    80006e08:	0045c603          	lbu	a2,4(a1)
    80006e0c:	00400713          	li	a4,4
    80006e10:	00c78223          	sb	a2,4(a5)
    80006e14:	00e68e63          	beq	a3,a4,80006e30 <__memmove+0xfc>
    80006e18:	0055c603          	lbu	a2,5(a1)
    80006e1c:	00500713          	li	a4,5
    80006e20:	00c782a3          	sb	a2,5(a5)
    80006e24:	00e68663          	beq	a3,a4,80006e30 <__memmove+0xfc>
    80006e28:	0065c703          	lbu	a4,6(a1)
    80006e2c:	00e78323          	sb	a4,6(a5)
    80006e30:	00813403          	ld	s0,8(sp)
    80006e34:	01010113          	addi	sp,sp,16
    80006e38:	00008067          	ret
    80006e3c:	02061713          	slli	a4,a2,0x20
    80006e40:	02075713          	srli	a4,a4,0x20
    80006e44:	00e587b3          	add	a5,a1,a4
    80006e48:	f0f574e3          	bgeu	a0,a5,80006d50 <__memmove+0x1c>
    80006e4c:	02069613          	slli	a2,a3,0x20
    80006e50:	02065613          	srli	a2,a2,0x20
    80006e54:	fff64613          	not	a2,a2
    80006e58:	00e50733          	add	a4,a0,a4
    80006e5c:	00c78633          	add	a2,a5,a2
    80006e60:	fff7c683          	lbu	a3,-1(a5)
    80006e64:	fff78793          	addi	a5,a5,-1
    80006e68:	fff70713          	addi	a4,a4,-1
    80006e6c:	00d70023          	sb	a3,0(a4)
    80006e70:	fec798e3          	bne	a5,a2,80006e60 <__memmove+0x12c>
    80006e74:	00813403          	ld	s0,8(sp)
    80006e78:	01010113          	addi	sp,sp,16
    80006e7c:	00008067          	ret
    80006e80:	02069713          	slli	a4,a3,0x20
    80006e84:	02075713          	srli	a4,a4,0x20
    80006e88:	00170713          	addi	a4,a4,1
    80006e8c:	00e50733          	add	a4,a0,a4
    80006e90:	00050793          	mv	a5,a0
    80006e94:	0005c683          	lbu	a3,0(a1)
    80006e98:	00178793          	addi	a5,a5,1
    80006e9c:	00158593          	addi	a1,a1,1
    80006ea0:	fed78fa3          	sb	a3,-1(a5)
    80006ea4:	fee798e3          	bne	a5,a4,80006e94 <__memmove+0x160>
    80006ea8:	f89ff06f          	j	80006e30 <__memmove+0xfc>

0000000080006eac <__mem_free>:
    80006eac:	ff010113          	addi	sp,sp,-16
    80006eb0:	00813423          	sd	s0,8(sp)
    80006eb4:	01010413          	addi	s0,sp,16
    80006eb8:	00003597          	auipc	a1,0x3
    80006ebc:	12058593          	addi	a1,a1,288 # 80009fd8 <freep>
    80006ec0:	0005b783          	ld	a5,0(a1)
    80006ec4:	ff050693          	addi	a3,a0,-16
    80006ec8:	0007b703          	ld	a4,0(a5)
    80006ecc:	00d7fc63          	bgeu	a5,a3,80006ee4 <__mem_free+0x38>
    80006ed0:	00e6ee63          	bltu	a3,a4,80006eec <__mem_free+0x40>
    80006ed4:	00e7fc63          	bgeu	a5,a4,80006eec <__mem_free+0x40>
    80006ed8:	00070793          	mv	a5,a4
    80006edc:	0007b703          	ld	a4,0(a5)
    80006ee0:	fed7e8e3          	bltu	a5,a3,80006ed0 <__mem_free+0x24>
    80006ee4:	fee7eae3          	bltu	a5,a4,80006ed8 <__mem_free+0x2c>
    80006ee8:	fee6f8e3          	bgeu	a3,a4,80006ed8 <__mem_free+0x2c>
    80006eec:	ff852803          	lw	a6,-8(a0)
    80006ef0:	02081613          	slli	a2,a6,0x20
    80006ef4:	01c65613          	srli	a2,a2,0x1c
    80006ef8:	00c68633          	add	a2,a3,a2
    80006efc:	02c70a63          	beq	a4,a2,80006f30 <__mem_free+0x84>
    80006f00:	fee53823          	sd	a4,-16(a0)
    80006f04:	0087a503          	lw	a0,8(a5)
    80006f08:	02051613          	slli	a2,a0,0x20
    80006f0c:	01c65613          	srli	a2,a2,0x1c
    80006f10:	00c78633          	add	a2,a5,a2
    80006f14:	04c68263          	beq	a3,a2,80006f58 <__mem_free+0xac>
    80006f18:	00813403          	ld	s0,8(sp)
    80006f1c:	00d7b023          	sd	a3,0(a5)
    80006f20:	00f5b023          	sd	a5,0(a1)
    80006f24:	00000513          	li	a0,0
    80006f28:	01010113          	addi	sp,sp,16
    80006f2c:	00008067          	ret
    80006f30:	00872603          	lw	a2,8(a4)
    80006f34:	00073703          	ld	a4,0(a4)
    80006f38:	0106083b          	addw	a6,a2,a6
    80006f3c:	ff052c23          	sw	a6,-8(a0)
    80006f40:	fee53823          	sd	a4,-16(a0)
    80006f44:	0087a503          	lw	a0,8(a5)
    80006f48:	02051613          	slli	a2,a0,0x20
    80006f4c:	01c65613          	srli	a2,a2,0x1c
    80006f50:	00c78633          	add	a2,a5,a2
    80006f54:	fcc692e3          	bne	a3,a2,80006f18 <__mem_free+0x6c>
    80006f58:	00813403          	ld	s0,8(sp)
    80006f5c:	0105053b          	addw	a0,a0,a6
    80006f60:	00a7a423          	sw	a0,8(a5)
    80006f64:	00e7b023          	sd	a4,0(a5)
    80006f68:	00f5b023          	sd	a5,0(a1)
    80006f6c:	00000513          	li	a0,0
    80006f70:	01010113          	addi	sp,sp,16
    80006f74:	00008067          	ret

0000000080006f78 <__mem_alloc>:
    80006f78:	fc010113          	addi	sp,sp,-64
    80006f7c:	02813823          	sd	s0,48(sp)
    80006f80:	02913423          	sd	s1,40(sp)
    80006f84:	03213023          	sd	s2,32(sp)
    80006f88:	01513423          	sd	s5,8(sp)
    80006f8c:	02113c23          	sd	ra,56(sp)
    80006f90:	01313c23          	sd	s3,24(sp)
    80006f94:	01413823          	sd	s4,16(sp)
    80006f98:	01613023          	sd	s6,0(sp)
    80006f9c:	04010413          	addi	s0,sp,64
    80006fa0:	00003a97          	auipc	s5,0x3
    80006fa4:	038a8a93          	addi	s5,s5,56 # 80009fd8 <freep>
    80006fa8:	00f50913          	addi	s2,a0,15
    80006fac:	000ab683          	ld	a3,0(s5)
    80006fb0:	00495913          	srli	s2,s2,0x4
    80006fb4:	0019049b          	addiw	s1,s2,1
    80006fb8:	00048913          	mv	s2,s1
    80006fbc:	0c068c63          	beqz	a3,80007094 <__mem_alloc+0x11c>
    80006fc0:	0006b503          	ld	a0,0(a3)
    80006fc4:	00852703          	lw	a4,8(a0)
    80006fc8:	10977063          	bgeu	a4,s1,800070c8 <__mem_alloc+0x150>
    80006fcc:	000017b7          	lui	a5,0x1
    80006fd0:	0009099b          	sext.w	s3,s2
    80006fd4:	0af4e863          	bltu	s1,a5,80007084 <__mem_alloc+0x10c>
    80006fd8:	02099a13          	slli	s4,s3,0x20
    80006fdc:	01ca5a13          	srli	s4,s4,0x1c
    80006fe0:	fff00b13          	li	s6,-1
    80006fe4:	0100006f          	j	80006ff4 <__mem_alloc+0x7c>
    80006fe8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80006fec:	00852703          	lw	a4,8(a0)
    80006ff0:	04977463          	bgeu	a4,s1,80007038 <__mem_alloc+0xc0>
    80006ff4:	00050793          	mv	a5,a0
    80006ff8:	fea698e3          	bne	a3,a0,80006fe8 <__mem_alloc+0x70>
    80006ffc:	000a0513          	mv	a0,s4
    80007000:	00000097          	auipc	ra,0x0
    80007004:	1f0080e7          	jalr	496(ra) # 800071f0 <kvmincrease>
    80007008:	00050793          	mv	a5,a0
    8000700c:	01050513          	addi	a0,a0,16
    80007010:	07678e63          	beq	a5,s6,8000708c <__mem_alloc+0x114>
    80007014:	0137a423          	sw	s3,8(a5)
    80007018:	00000097          	auipc	ra,0x0
    8000701c:	e94080e7          	jalr	-364(ra) # 80006eac <__mem_free>
    80007020:	000ab783          	ld	a5,0(s5)
    80007024:	06078463          	beqz	a5,8000708c <__mem_alloc+0x114>
    80007028:	0007b503          	ld	a0,0(a5)
    8000702c:	00078693          	mv	a3,a5
    80007030:	00852703          	lw	a4,8(a0)
    80007034:	fc9760e3          	bltu	a4,s1,80006ff4 <__mem_alloc+0x7c>
    80007038:	08e48263          	beq	s1,a4,800070bc <__mem_alloc+0x144>
    8000703c:	4127073b          	subw	a4,a4,s2
    80007040:	02071693          	slli	a3,a4,0x20
    80007044:	01c6d693          	srli	a3,a3,0x1c
    80007048:	00e52423          	sw	a4,8(a0)
    8000704c:	00d50533          	add	a0,a0,a3
    80007050:	01252423          	sw	s2,8(a0)
    80007054:	00fab023          	sd	a5,0(s5)
    80007058:	01050513          	addi	a0,a0,16
    8000705c:	03813083          	ld	ra,56(sp)
    80007060:	03013403          	ld	s0,48(sp)
    80007064:	02813483          	ld	s1,40(sp)
    80007068:	02013903          	ld	s2,32(sp)
    8000706c:	01813983          	ld	s3,24(sp)
    80007070:	01013a03          	ld	s4,16(sp)
    80007074:	00813a83          	ld	s5,8(sp)
    80007078:	00013b03          	ld	s6,0(sp)
    8000707c:	04010113          	addi	sp,sp,64
    80007080:	00008067          	ret
    80007084:	000019b7          	lui	s3,0x1
    80007088:	f51ff06f          	j	80006fd8 <__mem_alloc+0x60>
    8000708c:	00000513          	li	a0,0
    80007090:	fcdff06f          	j	8000705c <__mem_alloc+0xe4>
    80007094:	00004797          	auipc	a5,0x4
    80007098:	20c78793          	addi	a5,a5,524 # 8000b2a0 <base>
    8000709c:	00078513          	mv	a0,a5
    800070a0:	00fab023          	sd	a5,0(s5)
    800070a4:	00f7b023          	sd	a5,0(a5)
    800070a8:	00000713          	li	a4,0
    800070ac:	00004797          	auipc	a5,0x4
    800070b0:	1e07ae23          	sw	zero,508(a5) # 8000b2a8 <base+0x8>
    800070b4:	00050693          	mv	a3,a0
    800070b8:	f11ff06f          	j	80006fc8 <__mem_alloc+0x50>
    800070bc:	00053703          	ld	a4,0(a0)
    800070c0:	00e7b023          	sd	a4,0(a5)
    800070c4:	f91ff06f          	j	80007054 <__mem_alloc+0xdc>
    800070c8:	00068793          	mv	a5,a3
    800070cc:	f6dff06f          	j	80007038 <__mem_alloc+0xc0>

00000000800070d0 <__putc>:
    800070d0:	fe010113          	addi	sp,sp,-32
    800070d4:	00813823          	sd	s0,16(sp)
    800070d8:	00113c23          	sd	ra,24(sp)
    800070dc:	02010413          	addi	s0,sp,32
    800070e0:	00050793          	mv	a5,a0
    800070e4:	fef40593          	addi	a1,s0,-17
    800070e8:	00100613          	li	a2,1
    800070ec:	00000513          	li	a0,0
    800070f0:	fef407a3          	sb	a5,-17(s0)
    800070f4:	fffff097          	auipc	ra,0xfffff
    800070f8:	918080e7          	jalr	-1768(ra) # 80005a0c <console_write>
    800070fc:	01813083          	ld	ra,24(sp)
    80007100:	01013403          	ld	s0,16(sp)
    80007104:	02010113          	addi	sp,sp,32
    80007108:	00008067          	ret

000000008000710c <__getc>:
    8000710c:	fe010113          	addi	sp,sp,-32
    80007110:	00813823          	sd	s0,16(sp)
    80007114:	00113c23          	sd	ra,24(sp)
    80007118:	02010413          	addi	s0,sp,32
    8000711c:	fe840593          	addi	a1,s0,-24
    80007120:	00100613          	li	a2,1
    80007124:	00000513          	li	a0,0
    80007128:	fffff097          	auipc	ra,0xfffff
    8000712c:	8c4080e7          	jalr	-1852(ra) # 800059ec <console_read>
    80007130:	fe844503          	lbu	a0,-24(s0)
    80007134:	01813083          	ld	ra,24(sp)
    80007138:	01013403          	ld	s0,16(sp)
    8000713c:	02010113          	addi	sp,sp,32
    80007140:	00008067          	ret

0000000080007144 <console_handler>:
    80007144:	fe010113          	addi	sp,sp,-32
    80007148:	00813823          	sd	s0,16(sp)
    8000714c:	00113c23          	sd	ra,24(sp)
    80007150:	00913423          	sd	s1,8(sp)
    80007154:	02010413          	addi	s0,sp,32
    80007158:	14202773          	csrr	a4,scause
    8000715c:	100027f3          	csrr	a5,sstatus
    80007160:	0027f793          	andi	a5,a5,2
    80007164:	06079e63          	bnez	a5,800071e0 <console_handler+0x9c>
    80007168:	00074c63          	bltz	a4,80007180 <console_handler+0x3c>
    8000716c:	01813083          	ld	ra,24(sp)
    80007170:	01013403          	ld	s0,16(sp)
    80007174:	00813483          	ld	s1,8(sp)
    80007178:	02010113          	addi	sp,sp,32
    8000717c:	00008067          	ret
    80007180:	0ff77713          	andi	a4,a4,255
    80007184:	00900793          	li	a5,9
    80007188:	fef712e3          	bne	a4,a5,8000716c <console_handler+0x28>
    8000718c:	ffffe097          	auipc	ra,0xffffe
    80007190:	4b8080e7          	jalr	1208(ra) # 80005644 <plic_claim>
    80007194:	00a00793          	li	a5,10
    80007198:	00050493          	mv	s1,a0
    8000719c:	02f50c63          	beq	a0,a5,800071d4 <console_handler+0x90>
    800071a0:	fc0506e3          	beqz	a0,8000716c <console_handler+0x28>
    800071a4:	00050593          	mv	a1,a0
    800071a8:	00001517          	auipc	a0,0x1
    800071ac:	4c850513          	addi	a0,a0,1224 # 80008670 <kvmincrease+0x1480>
    800071b0:	fffff097          	auipc	ra,0xfffff
    800071b4:	8d8080e7          	jalr	-1832(ra) # 80005a88 <__printf>
    800071b8:	01013403          	ld	s0,16(sp)
    800071bc:	01813083          	ld	ra,24(sp)
    800071c0:	00048513          	mv	a0,s1
    800071c4:	00813483          	ld	s1,8(sp)
    800071c8:	02010113          	addi	sp,sp,32
    800071cc:	ffffe317          	auipc	t1,0xffffe
    800071d0:	4b030067          	jr	1200(t1) # 8000567c <plic_complete>
    800071d4:	fffff097          	auipc	ra,0xfffff
    800071d8:	1bc080e7          	jalr	444(ra) # 80006390 <uartintr>
    800071dc:	fddff06f          	j	800071b8 <console_handler+0x74>
    800071e0:	00001517          	auipc	a0,0x1
    800071e4:	59050513          	addi	a0,a0,1424 # 80008770 <digits+0x78>
    800071e8:	fffff097          	auipc	ra,0xfffff
    800071ec:	844080e7          	jalr	-1980(ra) # 80005a2c <panic>

00000000800071f0 <kvmincrease>:
    800071f0:	fe010113          	addi	sp,sp,-32
    800071f4:	01213023          	sd	s2,0(sp)
    800071f8:	00001937          	lui	s2,0x1
    800071fc:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80007200:	00813823          	sd	s0,16(sp)
    80007204:	00113c23          	sd	ra,24(sp)
    80007208:	00913423          	sd	s1,8(sp)
    8000720c:	02010413          	addi	s0,sp,32
    80007210:	01250933          	add	s2,a0,s2
    80007214:	00c95913          	srli	s2,s2,0xc
    80007218:	02090863          	beqz	s2,80007248 <kvmincrease+0x58>
    8000721c:	00000493          	li	s1,0
    80007220:	00148493          	addi	s1,s1,1
    80007224:	fffff097          	auipc	ra,0xfffff
    80007228:	4bc080e7          	jalr	1212(ra) # 800066e0 <kalloc>
    8000722c:	fe991ae3          	bne	s2,s1,80007220 <kvmincrease+0x30>
    80007230:	01813083          	ld	ra,24(sp)
    80007234:	01013403          	ld	s0,16(sp)
    80007238:	00813483          	ld	s1,8(sp)
    8000723c:	00013903          	ld	s2,0(sp)
    80007240:	02010113          	addi	sp,sp,32
    80007244:	00008067          	ret
    80007248:	01813083          	ld	ra,24(sp)
    8000724c:	01013403          	ld	s0,16(sp)
    80007250:	00813483          	ld	s1,8(sp)
    80007254:	00013903          	ld	s2,0(sp)
    80007258:	00000513          	li	a0,0
    8000725c:	02010113          	addi	sp,sp,32
    80007260:	00008067          	ret
	...
