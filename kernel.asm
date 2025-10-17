
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	11013103          	ld	sp,272(sp) # 8000a110 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	0d4050ef          	jal	ra,800050f0 <start>

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
    800010a4:	2f9000ef          	jal	ra,80001b9c <_ZN5Riscv20handleSupervisorTrapEv>


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


    80001358:	00813403          	ld	s0,8(sp)
    8000135c:	01010113          	addi	sp,sp,16
    80001360:	00008067          	ret

0000000080001364 <_ZN7_thread13threadWrapperEv>:

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    80001364:	ff010113          	addi	sp,sp,-16
    80001368:	00113423          	sd	ra,8(sp)
    8000136c:	00813023          	sd	s0,0(sp)
    80001370:	01010413          	addi	s0,sp,16

    Riscv::popSppSpie();
    80001374:	00000097          	auipc	ra,0x0
    80001378:	7e8080e7          	jalr	2024(ra) # 80001b5c <_ZN5Riscv10popSppSpieEv>
    while(!running->isStarted()) thread_dispatch();
    8000137c:	00009797          	auipc	a5,0x9
    80001380:	df47b783          	ld	a5,-524(a5) # 8000a170 <_ZN7_thread7runningE>

    static int exitThread();

    void setStart(bool b);

    bool isStarted() const { return started; }
    80001384:	0297c703          	lbu	a4,41(a5)
    80001388:	00071863          	bnez	a4,80001398 <_ZN7_thread13threadWrapperEv+0x34>
    8000138c:	00000097          	auipc	ra,0x0
    80001390:	eb4080e7          	jalr	-332(ra) # 80001240 <_Z15thread_dispatchv>
    80001394:	fe9ff06f          	j	8000137c <_ZN7_thread13threadWrapperEv+0x18>
    running->body(running->args);
    80001398:	0007b703          	ld	a4,0(a5)
    8000139c:	0087b503          	ld	a0,8(a5)
    800013a0:	000700e7          	jalr	a4
    thread_exit();
    800013a4:	00000097          	auipc	ra,0x0
    800013a8:	e70080e7          	jalr	-400(ra) # 80001214 <_Z11thread_exitv>
}
    800013ac:	00813083          	ld	ra,8(sp)
    800013b0:	00013403          	ld	s0,0(sp)
    800013b4:	01010113          	addi	sp,sp,16
    800013b8:	00008067          	ret

00000000800013bc <_ZN7_thread12createThreadEPFvPvES0_>:
{
    800013bc:	fd010113          	addi	sp,sp,-48
    800013c0:	02113423          	sd	ra,40(sp)
    800013c4:	02813023          	sd	s0,32(sp)
    800013c8:	00913c23          	sd	s1,24(sp)
    800013cc:	01213823          	sd	s2,16(sp)
    800013d0:	01313423          	sd	s3,8(sp)
    800013d4:	03010413          	addi	s0,sp,48
    800013d8:	00050913          	mv	s2,a0
    800013dc:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    800013e0:	03000513          	li	a0,48
    800013e4:	00000097          	auipc	ra,0x0
    800013e8:	3ec080e7          	jalr	1004(ra) # 800017d0 <_Znwm>
    800013ec:	00050493          	mv	s1,a0
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
            }),
            finished(false),
            started(true),
            blocked(false),
            semStatus(0)
    800013f0:	01253023          	sd	s2,0(a0)
    800013f4:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[DEFAULT_STACK_SIZE] : nullptr),
    800013f8:	00090a63          	beqz	s2,8000140c <_ZN7_thread12createThreadEPFvPvES0_+0x50>
    800013fc:	00008537          	lui	a0,0x8
    80001400:	00000097          	auipc	ra,0x0
    80001404:	3f8080e7          	jalr	1016(ra) # 800017f8 <_Znam>
    80001408:	0080006f          	j	80001410 <_ZN7_thread12createThreadEPFvPvES0_+0x54>
    8000140c:	00000513          	li	a0,0
            semStatus(0)
    80001410:	00a4b823          	sd	a0,16(s1)
    80001414:	00000797          	auipc	a5,0x0
    80001418:	f5078793          	addi	a5,a5,-176 # 80001364 <_ZN7_thread13threadWrapperEv>
    8000141c:	00f4bc23          	sd	a5,24(s1)
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001420:	02050c63          	beqz	a0,80001458 <_ZN7_thread12createThreadEPFvPvES0_+0x9c>
    80001424:	000087b7          	lui	a5,0x8
    80001428:	00f507b3          	add	a5,a0,a5
            semStatus(0)
    8000142c:	02f4b023          	sd	a5,32(s1)
    80001430:	02048423          	sb	zero,40(s1)
    80001434:	00100793          	li	a5,1
    80001438:	02f484a3          	sb	a5,41(s1)
    8000143c:	02048523          	sb	zero,42(s1)
    80001440:	0204a623          	sw	zero,44(s1)
    {
            if (body != nullptr) { Scheduler::put(this);}
    80001444:	02090c63          	beqz	s2,8000147c <_ZN7_thread12createThreadEPFvPvES0_+0xc0>
    80001448:	00048513          	mv	a0,s1
    8000144c:	00001097          	auipc	ra,0x1
    80001450:	ca8080e7          	jalr	-856(ra) # 800020f4 <_ZN9Scheduler3putEP7_thread>
    80001454:	0280006f          	j	8000147c <_ZN7_thread12createThreadEPFvPvES0_+0xc0>
                stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001458:	00000793          	li	a5,0
    8000145c:	fd1ff06f          	j	8000142c <_ZN7_thread12createThreadEPFvPvES0_+0x70>
    80001460:	00050913          	mv	s2,a0
    80001464:	00048513          	mv	a0,s1
    80001468:	00000097          	auipc	ra,0x0
    8000146c:	3b8080e7          	jalr	952(ra) # 80001820 <_ZdlPv>
    80001470:	00090513          	mv	a0,s2
    80001474:	0000a097          	auipc	ra,0xa
    80001478:	e24080e7          	jalr	-476(ra) # 8000b298 <_Unwind_Resume>
}
    8000147c:	00048513          	mv	a0,s1
    80001480:	02813083          	ld	ra,40(sp)
    80001484:	02013403          	ld	s0,32(sp)
    80001488:	01813483          	ld	s1,24(sp)
    8000148c:	01013903          	ld	s2,16(sp)
    80001490:	00813983          	ld	s3,8(sp)
    80001494:	03010113          	addi	sp,sp,48
    80001498:	00008067          	ret

000000008000149c <_ZN7_thread8dispatchEv>:
{
    8000149c:	fe010113          	addi	sp,sp,-32
    800014a0:	00113c23          	sd	ra,24(sp)
    800014a4:	00813823          	sd	s0,16(sp)
    800014a8:	00913423          	sd	s1,8(sp)
    800014ac:	02010413          	addi	s0,sp,32
    _thread *old = running;
    800014b0:	00009497          	auipc	s1,0x9
    800014b4:	cc04b483          	ld	s1,-832(s1) # 8000a170 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    800014b8:	0284c783          	lbu	a5,40(s1)
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    800014bc:	00079663          	bnez	a5,800014c8 <_ZN7_thread8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    800014c0:	02a4c783          	lbu	a5,42(s1)
    800014c4:	04078263          	beqz	a5,80001508 <_ZN7_thread8dispatchEv+0x6c>
    running = Scheduler::get();
    800014c8:	00001097          	auipc	ra,0x1
    800014cc:	bc4080e7          	jalr	-1084(ra) # 8000208c <_ZN9Scheduler3getEv>
    800014d0:	00009797          	auipc	a5,0x9
    800014d4:	caa7b023          	sd	a0,-864(a5) # 8000a170 <_ZN7_thread7runningE>
    if (running == nullptr) {
    800014d8:	04050063          	beqz	a0,80001518 <_ZN7_thread8dispatchEv+0x7c>
    _thread::contextSwitch(&old->context, &running->context);
    800014dc:	00009597          	auipc	a1,0x9
    800014e0:	c945b583          	ld	a1,-876(a1) # 8000a170 <_ZN7_thread7runningE>
    800014e4:	01858593          	addi	a1,a1,24
    800014e8:	01848513          	addi	a0,s1,24
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	c44080e7          	jalr	-956(ra) # 80001130 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    800014f4:	01813083          	ld	ra,24(sp)
    800014f8:	01013403          	ld	s0,16(sp)
    800014fc:	00813483          	ld	s1,8(sp)
    80001500:	02010113          	addi	sp,sp,32
    80001504:	00008067          	ret
    if (!old->isFinished() && !old->isBlocked()) { Scheduler::put(old); }
    80001508:	00048513          	mv	a0,s1
    8000150c:	00001097          	auipc	ra,0x1
    80001510:	be8080e7          	jalr	-1048(ra) # 800020f4 <_ZN9Scheduler3putEP7_thread>
    80001514:	fb5ff06f          	j	800014c8 <_ZN7_thread8dispatchEv+0x2c>
        printString("vratili smo null\n");
    80001518:	00007517          	auipc	a0,0x7
    8000151c:	b0850513          	addi	a0,a0,-1272 # 80008020 <CONSOLE_STATUS+0x10>
    80001520:	00003097          	auipc	ra,0x3
    80001524:	c00080e7          	jalr	-1024(ra) # 80004120 <_Z11printStringPKc>
    80001528:	fb5ff06f          	j	800014dc <_ZN7_thread8dispatchEv+0x40>

000000008000152c <_ZN7_thread10exitThreadEv>:

int _thread::exitThread() {
    8000152c:	ff010113          	addi	sp,sp,-16
    80001530:	00113423          	sd	ra,8(sp)
    80001534:	00813023          	sd	s0,0(sp)
    80001538:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    8000153c:	00009797          	auipc	a5,0x9
    80001540:	c347b783          	ld	a5,-972(a5) # 8000a170 <_ZN7_thread7runningE>
    80001544:	00100713          	li	a4,1
    80001548:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	cf4080e7          	jalr	-780(ra) # 80001240 <_Z15thread_dispatchv>
    return 0;
}
    80001554:	00000513          	li	a0,0
    80001558:	00813083          	ld	ra,8(sp)
    8000155c:	00013403          	ld	s0,0(sp)
    80001560:	01010113          	addi	sp,sp,16
    80001564:	00008067          	ret

0000000080001568 <_ZN7_thread8setStartEb>:

void _thread::setStart(bool b) {
    80001568:	ff010113          	addi	sp,sp,-16
    8000156c:	00813423          	sd	s0,8(sp)
    80001570:	01010413          	addi	s0,sp,16
    this->started = b;
    80001574:	02b504a3          	sb	a1,41(a0)
}
    80001578:	00813403          	ld	s0,8(sp)
    8000157c:	01010113          	addi	sp,sp,16
    80001580:	00008067          	ret

0000000080001584 <_ZN7_thread8setBlockEb>:

void _thread::setBlock(bool b) {
    80001584:	ff010113          	addi	sp,sp,-16
    80001588:	00813423          	sd	s0,8(sp)
    8000158c:	01010413          	addi	s0,sp,16
    this->blocked = b;
    80001590:	02b50523          	sb	a1,42(a0)
}
    80001594:	00813403          	ld	s0,8(sp)
    80001598:	01010113          	addi	sp,sp,16
    8000159c:	00008067          	ret

00000000800015a0 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "../test/System_Mode_test.hpp"

#endif

void userMain() {
    800015a0:	fe010113          	addi	sp,sp,-32
    800015a4:	00113c23          	sd	ra,24(sp)
    800015a8:	00813823          	sd	s0,16(sp)
    800015ac:	00913423          	sd	s1,8(sp)
    800015b0:	01213023          	sd	s2,0(sp)
    800015b4:	02010413          	addi	s0,sp,32


    printString("Unesite broj testa? [1-7]\n");
    800015b8:	00007517          	auipc	a0,0x7
    800015bc:	a8050513          	addi	a0,a0,-1408 # 80008038 <CONSOLE_STATUS+0x28>
    800015c0:	00003097          	auipc	ra,0x3
    800015c4:	b60080e7          	jalr	-1184(ra) # 80004120 <_Z11printStringPKc>
    int test = getc() - '0';
    800015c8:	00000097          	auipc	ra,0x0
    800015cc:	d4c080e7          	jalr	-692(ra) # 80001314 <_Z4getcv>
    800015d0:	00050913          	mv	s2,a0
    800015d4:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800015d8:	00000097          	auipc	ra,0x0
    800015dc:	d3c080e7          	jalr	-708(ra) # 80001314 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800015e0:	fcb9091b          	addiw	s2,s2,-53
    800015e4:	00100793          	li	a5,1
    800015e8:	0327f463          	bgeu	a5,s2,80001610 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800015ec:	00700793          	li	a5,7
    800015f0:	0e97e263          	bltu	a5,s1,800016d4 <_Z8userMainv+0x134>
    800015f4:	00249493          	slli	s1,s1,0x2
    800015f8:	00007717          	auipc	a4,0x7
    800015fc:	c5870713          	addi	a4,a4,-936 # 80008250 <CONSOLE_STATUS+0x240>
    80001600:	00e484b3          	add	s1,s1,a4
    80001604:	0004a783          	lw	a5,0(s1)
    80001608:	00e787b3          	add	a5,a5,a4
    8000160c:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001610:	00007517          	auipc	a0,0x7
    80001614:	a4850513          	addi	a0,a0,-1464 # 80008058 <CONSOLE_STATUS+0x48>
    80001618:	00003097          	auipc	ra,0x3
    8000161c:	b08080e7          	jalr	-1272(ra) # 80004120 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80001620:	01813083          	ld	ra,24(sp)
    80001624:	01013403          	ld	s0,16(sp)
    80001628:	00813483          	ld	s1,8(sp)
    8000162c:	00013903          	ld	s2,0(sp)
    80001630:	02010113          	addi	sp,sp,32
    80001634:	00008067          	ret
            Threads_C_API_test();
    80001638:	00002097          	auipc	ra,0x2
    8000163c:	160080e7          	jalr	352(ra) # 80003798 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001640:	00007517          	auipc	a0,0x7
    80001644:	a4850513          	addi	a0,a0,-1464 # 80008088 <CONSOLE_STATUS+0x78>
    80001648:	00003097          	auipc	ra,0x3
    8000164c:	ad8080e7          	jalr	-1320(ra) # 80004120 <_Z11printStringPKc>
            break;
    80001650:	fd1ff06f          	j	80001620 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001654:	00001097          	auipc	ra,0x1
    80001658:	7a8080e7          	jalr	1960(ra) # 80002dfc <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000165c:	00007517          	auipc	a0,0x7
    80001660:	a6c50513          	addi	a0,a0,-1428 # 800080c8 <CONSOLE_STATUS+0xb8>
    80001664:	00003097          	auipc	ra,0x3
    80001668:	abc080e7          	jalr	-1348(ra) # 80004120 <_Z11printStringPKc>
            break;
    8000166c:	fb5ff06f          	j	80001620 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001670:	00001097          	auipc	ra,0x1
    80001674:	fe0080e7          	jalr	-32(ra) # 80002650 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001678:	00007517          	auipc	a0,0x7
    8000167c:	a9050513          	addi	a0,a0,-1392 # 80008108 <CONSOLE_STATUS+0xf8>
    80001680:	00003097          	auipc	ra,0x3
    80001684:	aa0080e7          	jalr	-1376(ra) # 80004120 <_Z11printStringPKc>
            break;
    80001688:	f99ff06f          	j	80001620 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    8000168c:	00002097          	auipc	ra,0x2
    80001690:	450080e7          	jalr	1104(ra) # 80003adc <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001694:	00007517          	auipc	a0,0x7
    80001698:	ac450513          	addi	a0,a0,-1340 # 80008158 <CONSOLE_STATUS+0x148>
    8000169c:	00003097          	auipc	ra,0x3
    800016a0:	a84080e7          	jalr	-1404(ra) # 80004120 <_Z11printStringPKc>
            break;
    800016a4:	f7dff06f          	j	80001620 <_Z8userMainv+0x80>
            System_Mode_test();
    800016a8:	00003097          	auipc	ra,0x3
    800016ac:	62c080e7          	jalr	1580(ra) # 80004cd4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    800016b0:	00007517          	auipc	a0,0x7
    800016b4:	b0050513          	addi	a0,a0,-1280 # 800081b0 <CONSOLE_STATUS+0x1a0>
    800016b8:	00003097          	auipc	ra,0x3
    800016bc:	a68080e7          	jalr	-1432(ra) # 80004120 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800016c0:	00007517          	auipc	a0,0x7
    800016c4:	b1050513          	addi	a0,a0,-1264 # 800081d0 <CONSOLE_STATUS+0x1c0>
    800016c8:	00003097          	auipc	ra,0x3
    800016cc:	a58080e7          	jalr	-1448(ra) # 80004120 <_Z11printStringPKc>
            break;
    800016d0:	f51ff06f          	j	80001620 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    800016d4:	00007517          	auipc	a0,0x7
    800016d8:	b5450513          	addi	a0,a0,-1196 # 80008228 <CONSOLE_STATUS+0x218>
    800016dc:	00003097          	auipc	ra,0x3
    800016e0:	a44080e7          	jalr	-1468(ra) # 80004120 <_Z11printStringPKc>
    800016e4:	f3dff06f          	j	80001620 <_Z8userMainv+0x80>

00000000800016e8 <_Z15userMainWrapperPv>:
#include "../h/_thread.hpp"
#include "../h/memory.hpp"

extern void userMain();

void userMainWrapper(void* arg){
    800016e8:	ff010113          	addi	sp,sp,-16
    800016ec:	00113423          	sd	ra,8(sp)
    800016f0:	00813023          	sd	s0,0(sp)
    800016f4:	01010413          	addi	s0,sp,16
    userMain();
    800016f8:	00000097          	auipc	ra,0x0
    800016fc:	ea8080e7          	jalr	-344(ra) # 800015a0 <_Z8userMainv>
}
    80001700:	00813083          	ld	ra,8(sp)
    80001704:	00013403          	ld	s0,0(sp)
    80001708:	01010113          	addi	sp,sp,16
    8000170c:	00008067          	ret

0000000080001710 <main>:

void main()
{
    80001710:	fe010113          	addi	sp,sp,-32
    80001714:	00113c23          	sd	ra,24(sp)
    80001718:	00813823          	sd	s0,16(sp)
    8000171c:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    80001720:	00009797          	auipc	a5,0x9
    80001724:	9e87b783          	ld	a5,-1560(a5) # 8000a108 <_GLOBAL_OFFSET_TABLE_+0x18>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001728:	10579073          	csrw	stvec,a5
    memory::initialize();
    8000172c:	00001097          	auipc	ra,0x1
    80001730:	a68080e7          	jalr	-1432(ra) # 80002194 <_ZN6memory10initializeEv>

    // idle nit
    thread_t idleThread = nullptr;
    80001734:	fe043423          	sd	zero,-24(s0)
    thread_create(&idleThread, nullptr, nullptr);
    80001738:	00000613          	li	a2,0
    8000173c:	00000593          	li	a1,0
    80001740:	fe840513          	addi	a0,s0,-24
    80001744:	00000097          	auipc	ra,0x0
    80001748:	aa4080e7          	jalr	-1372(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = idleThread;
    8000174c:	00009797          	auipc	a5,0x9
    80001750:	9b47b783          	ld	a5,-1612(a5) # 8000a100 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001754:	fe843703          	ld	a4,-24(s0)
    80001758:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrw sip, %[sip]" : : [sip] "r"(sip));
}

inline void Riscv::ms_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000175c:	00200793          	li	a5,2
    80001760:	1007a073          	csrs	sstatus,a5
    static void setUserMode(bool b) {userMode = b;}
    80001764:	00009797          	auipc	a5,0x9
    80001768:	9bc7b783          	ld	a5,-1604(a5) # 8000a120 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000176c:	00100713          	li	a4,1
    80001770:	00e78023          	sb	a4,0(a5)
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);

    Riscv::setUserMode(true);

    uint8 userCode = 0x0;
    WRITE_REG("a7", userCode);
    80001774:	00000793          	li	a5,0
    80001778:	00078893          	mv	a7,a5
    __asm__ volatile("ecall");
    8000177c:	00000073          	ecall

    thread_t userThread;
    thread_create(&userThread, &userMainWrapper, nullptr);
    80001780:	00000613          	li	a2,0
    80001784:	00000597          	auipc	a1,0x0
    80001788:	f6458593          	addi	a1,a1,-156 # 800016e8 <_Z15userMainWrapperPv>
    8000178c:	fe040513          	addi	a0,s0,-32
    80001790:	00000097          	auipc	ra,0x0
    80001794:	a58080e7          	jalr	-1448(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    while (!userThread->isFinished()) thread_dispatch();
    80001798:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    8000179c:	0287c783          	lbu	a5,40(a5)
    800017a0:	00079863          	bnez	a5,800017b0 <main+0xa0>
    800017a4:	00000097          	auipc	ra,0x0
    800017a8:	a9c080e7          	jalr	-1380(ra) # 80001240 <_Z15thread_dispatchv>
    800017ac:	fedff06f          	j	80001798 <main+0x88>

    printString("FINISHED!\n");
    800017b0:	00007517          	auipc	a0,0x7
    800017b4:	ac050513          	addi	a0,a0,-1344 # 80008270 <CONSOLE_STATUS+0x260>
    800017b8:	00003097          	auipc	ra,0x3
    800017bc:	968080e7          	jalr	-1688(ra) # 80004120 <_Z11printStringPKc>
}
    800017c0:	01813083          	ld	ra,24(sp)
    800017c4:	01013403          	ld	s0,16(sp)
    800017c8:	02010113          	addi	sp,sp,32
    800017cc:	00008067          	ret

00000000800017d0 <_Znwm>:

#include "../h/syscall_cpp.hpp"


void *operator new(size_t n)
{
    800017d0:	ff010113          	addi	sp,sp,-16
    800017d4:	00113423          	sd	ra,8(sp)
    800017d8:	00813023          	sd	s0,0(sp)
    800017dc:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    800017e0:	00000097          	auipc	ra,0x0
    800017e4:	964080e7          	jalr	-1692(ra) # 80001144 <_Z9mem_allocm>
}
    800017e8:	00813083          	ld	ra,8(sp)
    800017ec:	00013403          	ld	s0,0(sp)
    800017f0:	01010113          	addi	sp,sp,16
    800017f4:	00008067          	ret

00000000800017f8 <_Znam>:

void *operator new[](size_t n)
{
    800017f8:	ff010113          	addi	sp,sp,-16
    800017fc:	00113423          	sd	ra,8(sp)
    80001800:	00813023          	sd	s0,0(sp)
    80001804:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001808:	00000097          	auipc	ra,0x0
    8000180c:	93c080e7          	jalr	-1732(ra) # 80001144 <_Z9mem_allocm>
}
    80001810:	00813083          	ld	ra,8(sp)
    80001814:	00013403          	ld	s0,0(sp)
    80001818:	01010113          	addi	sp,sp,16
    8000181c:	00008067          	ret

0000000080001820 <_ZdlPv>:

void operator delete(void *p)
{
    80001820:	ff010113          	addi	sp,sp,-16
    80001824:	00113423          	sd	ra,8(sp)
    80001828:	00813023          	sd	s0,0(sp)
    8000182c:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001830:	00000097          	auipc	ra,0x0
    80001834:	93c080e7          	jalr	-1732(ra) # 8000116c <_Z8mem_freePv>
}
    80001838:	00813083          	ld	ra,8(sp)
    8000183c:	00013403          	ld	s0,0(sp)
    80001840:	01010113          	addi	sp,sp,16
    80001844:	00008067          	ret

0000000080001848 <_ZdaPv>:

void operator delete[](void *p)
{
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00113423          	sd	ra,8(sp)
    80001850:	00813023          	sd	s0,0(sp)
    80001854:	01010413          	addi	s0,sp,16
    mem_free(p);
    80001858:	00000097          	auipc	ra,0x0
    8000185c:	914080e7          	jalr	-1772(ra) # 8000116c <_Z8mem_freePv>
}
    80001860:	00813083          	ld	ra,8(sp)
    80001864:	00013403          	ld	s0,0(sp)
    80001868:	01010113          	addi	sp,sp,16
    8000186c:	00008067          	ret

0000000080001870 <_ZN6ThreadD1Ev>:
void Thread::dispatch() {
    thread_dispatch();

}

Thread::~Thread() {
    80001870:	ff010113          	addi	sp,sp,-16
    80001874:	00813423          	sd	s0,8(sp)
    80001878:	01010413          	addi	s0,sp,16

}
    8000187c:	00813403          	ld	s0,8(sp)
    80001880:	01010113          	addi	sp,sp,16
    80001884:	00008067          	ret

0000000080001888 <_ZN6Thread12startWrapperEPv>:
Thread::Thread() {
    thread_create(&myHandle, &startWrapper, this);
    myHandle->setStart(false);
}

void Thread::startWrapper(void *thread) {
    80001888:	ff010113          	addi	sp,sp,-16
    8000188c:	00113423          	sd	ra,8(sp)
    80001890:	00813023          	sd	s0,0(sp)
    80001894:	01010413          	addi	s0,sp,16
    Thread* t = (Thread*)thread;
    t->run();
    80001898:	00053783          	ld	a5,0(a0)
    8000189c:	0107b783          	ld	a5,16(a5)
    800018a0:	000780e7          	jalr	a5
}
    800018a4:	00813083          	ld	ra,8(sp)
    800018a8:	00013403          	ld	s0,0(sp)
    800018ac:	01010113          	addi	sp,sp,16
    800018b0:	00008067          	ret

00000000800018b4 <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    800018b4:	ff010113          	addi	sp,sp,-16
    800018b8:	00113423          	sd	ra,8(sp)
    800018bc:	00813023          	sd	s0,0(sp)
    800018c0:	01010413          	addi	s0,sp,16
}
    800018c4:	00000097          	auipc	ra,0x0
    800018c8:	f5c080e7          	jalr	-164(ra) # 80001820 <_ZdlPv>
    800018cc:	00813083          	ld	ra,8(sp)
    800018d0:	00013403          	ld	s0,0(sp)
    800018d4:	01010113          	addi	sp,sp,16
    800018d8:	00008067          	ret

00000000800018dc <_ZN9SemaphoreD1Ev>:

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    800018dc:	ff010113          	addi	sp,sp,-16
    800018e0:	00113423          	sd	ra,8(sp)
    800018e4:	00813023          	sd	s0,0(sp)
    800018e8:	01010413          	addi	s0,sp,16
    800018ec:	00008797          	auipc	a5,0x8
    800018f0:	6c478793          	addi	a5,a5,1732 # 80009fb0 <_ZTV9Semaphore+0x10>
    800018f4:	00f53023          	sd	a5,0(a0)
    sem_close(myHandle);
    800018f8:	00853503          	ld	a0,8(a0)
    800018fc:	00000097          	auipc	ra,0x0
    80001900:	994080e7          	jalr	-1644(ra) # 80001290 <_Z9sem_closeP4_sem>

}
    80001904:	00813083          	ld	ra,8(sp)
    80001908:	00013403          	ld	s0,0(sp)
    8000190c:	01010113          	addi	sp,sp,16
    80001910:	00008067          	ret

0000000080001914 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001914:	fe010113          	addi	sp,sp,-32
    80001918:	00113c23          	sd	ra,24(sp)
    8000191c:	00813823          	sd	s0,16(sp)
    80001920:	00913423          	sd	s1,8(sp)
    80001924:	02010413          	addi	s0,sp,32
    80001928:	00050493          	mv	s1,a0
}
    8000192c:	00000097          	auipc	ra,0x0
    80001930:	fb0080e7          	jalr	-80(ra) # 800018dc <_ZN9SemaphoreD1Ev>
    80001934:	00048513          	mv	a0,s1
    80001938:	00000097          	auipc	ra,0x0
    8000193c:	ee8080e7          	jalr	-280(ra) # 80001820 <_ZdlPv>
    80001940:	01813083          	ld	ra,24(sp)
    80001944:	01013403          	ld	s0,16(sp)
    80001948:	00813483          	ld	s1,8(sp)
    8000194c:	02010113          	addi	sp,sp,32
    80001950:	00008067          	ret

0000000080001954 <_ZN7Console4getcEv>:
char Console::getc() {
    80001954:	ff010113          	addi	sp,sp,-16
    80001958:	00113423          	sd	ra,8(sp)
    8000195c:	00813023          	sd	s0,0(sp)
    80001960:	01010413          	addi	s0,sp,16
    return __getc();
    80001964:	00006097          	auipc	ra,0x6
    80001968:	884080e7          	jalr	-1916(ra) # 800071e8 <__getc>
}
    8000196c:	00813083          	ld	ra,8(sp)
    80001970:	00013403          	ld	s0,0(sp)
    80001974:	01010113          	addi	sp,sp,16
    80001978:	00008067          	ret

000000008000197c <_ZN7Console4putcEc>:
void Console::putc(char c) {
    8000197c:	ff010113          	addi	sp,sp,-16
    80001980:	00113423          	sd	ra,8(sp)
    80001984:	00813023          	sd	s0,0(sp)
    80001988:	01010413          	addi	s0,sp,16
    __putc(c);
    8000198c:	00006097          	auipc	ra,0x6
    80001990:	820080e7          	jalr	-2016(ra) # 800071ac <__putc>
}
    80001994:	00813083          	ld	ra,8(sp)
    80001998:	00013403          	ld	s0,0(sp)
    8000199c:	01010113          	addi	sp,sp,16
    800019a0:	00008067          	ret

00000000800019a4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    800019a4:	fe010113          	addi	sp,sp,-32
    800019a8:	00113c23          	sd	ra,24(sp)
    800019ac:	00813823          	sd	s0,16(sp)
    800019b0:	00913423          	sd	s1,8(sp)
    800019b4:	02010413          	addi	s0,sp,32
    800019b8:	00050493          	mv	s1,a0
    800019bc:	00008797          	auipc	a5,0x8
    800019c0:	5cc78793          	addi	a5,a5,1484 # 80009f88 <_ZTV6Thread+0x10>
    800019c4:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, body, arg);
    800019c8:	00850513          	addi	a0,a0,8
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	81c080e7          	jalr	-2020(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    800019d4:	00000593          	li	a1,0
    800019d8:	0084b503          	ld	a0,8(s1)
    800019dc:	00000097          	auipc	ra,0x0
    800019e0:	b8c080e7          	jalr	-1140(ra) # 80001568 <_ZN7_thread8setStartEb>
}
    800019e4:	01813083          	ld	ra,24(sp)
    800019e8:	01013403          	ld	s0,16(sp)
    800019ec:	00813483          	ld	s1,8(sp)
    800019f0:	02010113          	addi	sp,sp,32
    800019f4:	00008067          	ret

00000000800019f8 <_ZN6Thread5startEv>:
int Thread::start() {
    800019f8:	ff010113          	addi	sp,sp,-16
    800019fc:	00113423          	sd	ra,8(sp)
    80001a00:	00813023          	sd	s0,0(sp)
    80001a04:	01010413          	addi	s0,sp,16
    myHandle->setStart(true);
    80001a08:	00100593          	li	a1,1
    80001a0c:	00853503          	ld	a0,8(a0)
    80001a10:	00000097          	auipc	ra,0x0
    80001a14:	b58080e7          	jalr	-1192(ra) # 80001568 <_ZN7_thread8setStartEb>
}
    80001a18:	00000513          	li	a0,0
    80001a1c:	00813083          	ld	ra,8(sp)
    80001a20:	00013403          	ld	s0,0(sp)
    80001a24:	01010113          	addi	sp,sp,16
    80001a28:	00008067          	ret

0000000080001a2c <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001a2c:	ff010113          	addi	sp,sp,-16
    80001a30:	00113423          	sd	ra,8(sp)
    80001a34:	00813023          	sd	s0,0(sp)
    80001a38:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001a3c:	00000097          	auipc	ra,0x0
    80001a40:	804080e7          	jalr	-2044(ra) # 80001240 <_Z15thread_dispatchv>
}
    80001a44:	00813083          	ld	ra,8(sp)
    80001a48:	00013403          	ld	s0,0(sp)
    80001a4c:	01010113          	addi	sp,sp,16
    80001a50:	00008067          	ret

0000000080001a54 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001a54:	fe010113          	addi	sp,sp,-32
    80001a58:	00113c23          	sd	ra,24(sp)
    80001a5c:	00813823          	sd	s0,16(sp)
    80001a60:	00913423          	sd	s1,8(sp)
    80001a64:	02010413          	addi	s0,sp,32
    80001a68:	00050493          	mv	s1,a0
    80001a6c:	00008797          	auipc	a5,0x8
    80001a70:	51c78793          	addi	a5,a5,1308 # 80009f88 <_ZTV6Thread+0x10>
    80001a74:	00f53023          	sd	a5,0(a0)
    thread_create(&myHandle, &startWrapper, this);
    80001a78:	00050613          	mv	a2,a0
    80001a7c:	00000597          	auipc	a1,0x0
    80001a80:	e0c58593          	addi	a1,a1,-500 # 80001888 <_ZN6Thread12startWrapperEPv>
    80001a84:	00850513          	addi	a0,a0,8
    80001a88:	fffff097          	auipc	ra,0xfffff
    80001a8c:	760080e7          	jalr	1888(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    myHandle->setStart(false);
    80001a90:	00000593          	li	a1,0
    80001a94:	0084b503          	ld	a0,8(s1)
    80001a98:	00000097          	auipc	ra,0x0
    80001a9c:	ad0080e7          	jalr	-1328(ra) # 80001568 <_ZN7_thread8setStartEb>
}
    80001aa0:	01813083          	ld	ra,24(sp)
    80001aa4:	01013403          	ld	s0,16(sp)
    80001aa8:	00813483          	ld	s1,8(sp)
    80001aac:	02010113          	addi	sp,sp,32
    80001ab0:	00008067          	ret

0000000080001ab4 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80001ab4:	ff010113          	addi	sp,sp,-16
    80001ab8:	00113423          	sd	ra,8(sp)
    80001abc:	00813023          	sd	s0,0(sp)
    80001ac0:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001ac4:	00853503          	ld	a0,8(a0)
    80001ac8:	fffff097          	auipc	ra,0xfffff
    80001acc:	7f4080e7          	jalr	2036(ra) # 800012bc <_Z8sem_waitP4_sem>
}
    80001ad0:	00813083          	ld	ra,8(sp)
    80001ad4:	00013403          	ld	s0,0(sp)
    80001ad8:	01010113          	addi	sp,sp,16
    80001adc:	00008067          	ret

0000000080001ae0 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001ae0:	ff010113          	addi	sp,sp,-16
    80001ae4:	00113423          	sd	ra,8(sp)
    80001ae8:	00813023          	sd	s0,0(sp)
    80001aec:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001af0:	00853503          	ld	a0,8(a0)
    80001af4:	fffff097          	auipc	ra,0xfffff
    80001af8:	7f4080e7          	jalr	2036(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80001afc:	00813083          	ld	ra,8(sp)
    80001b00:	00013403          	ld	s0,0(sp)
    80001b04:	01010113          	addi	sp,sp,16
    80001b08:	00008067          	ret

0000000080001b0c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned int init) {
    80001b0c:	ff010113          	addi	sp,sp,-16
    80001b10:	00113423          	sd	ra,8(sp)
    80001b14:	00813023          	sd	s0,0(sp)
    80001b18:	01010413          	addi	s0,sp,16
    80001b1c:	00008797          	auipc	a5,0x8
    80001b20:	49478793          	addi	a5,a5,1172 # 80009fb0 <_ZTV9Semaphore+0x10>
    80001b24:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    80001b28:	00850513          	addi	a0,a0,8
    80001b2c:	fffff097          	auipc	ra,0xfffff
    80001b30:	738080e7          	jalr	1848(ra) # 80001264 <_Z8sem_openPP4_semj>
}
    80001b34:	00813083          	ld	ra,8(sp)
    80001b38:	00013403          	ld	s0,0(sp)
    80001b3c:	01010113          	addi	sp,sp,16
    80001b40:	00008067          	ret

0000000080001b44 <_ZN6Thread3runEv>:



protected:
    Thread();
    virtual void run() {}
    80001b44:	ff010113          	addi	sp,sp,-16
    80001b48:	00813423          	sd	s0,8(sp)
    80001b4c:	01010413          	addi	s0,sp,16
    80001b50:	00813403          	ld	s0,8(sp)
    80001b54:	01010113          	addi	sp,sp,16
    80001b58:	00008067          	ret

0000000080001b5c <_ZN5Riscv10popSppSpieEv>:
using namespace Num;
bool Riscv::userMode = false;


void Riscv::popSppSpie()
{
    80001b5c:	ff010113          	addi	sp,sp,-16
    80001b60:	00813423          	sd	s0,8(sp)
    80001b64:	01010413          	addi	s0,sp,16
    if (userMode) mc_sstatus(SSTATUS_SPP);
    80001b68:	00008797          	auipc	a5,0x8
    80001b6c:	6107c783          	lbu	a5,1552(a5) # 8000a178 <_ZN5Riscv8userModeE>
    80001b70:	02078063          	beqz	a5,80001b90 <_ZN5Riscv10popSppSpieEv+0x34>
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001b74:	10000793          	li	a5,256
    80001b78:	1007b073          	csrc	sstatus,a5
    else ms_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    80001b7c:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001b80:	10200073          	sret

}
    80001b84:	00813403          	ld	s0,8(sp)
    80001b88:	01010113          	addi	sp,sp,16
    80001b8c:	00008067          	ret
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001b90:	10000793          	li	a5,256
    80001b94:	1007a073          	csrs	sstatus,a5
}
    80001b98:	fe5ff06f          	j	80001b7c <_ZN5Riscv10popSppSpieEv+0x20>

0000000080001b9c <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    80001b9c:	fb010113          	addi	sp,sp,-80
    80001ba0:	04113423          	sd	ra,72(sp)
    80001ba4:	04813023          	sd	s0,64(sp)
    80001ba8:	02913c23          	sd	s1,56(sp)
    80001bac:	05010413          	addi	s0,sp,80
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001bb0:	142027f3          	csrr	a5,scause
    80001bb4:	fcf43423          	sd	a5,-56(s0)
    return scause;
    80001bb8:	fc843483          	ld	s1,-56(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    80001bbc:	fff00793          	li	a5,-1
    80001bc0:	03f79793          	slli	a5,a5,0x3f
    80001bc4:	00178793          	addi	a5,a5,1
    80001bc8:	18f48c63          	beq	s1,a5,80001d60 <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
    80001bcc:	fff00793          	li	a5,-1
    80001bd0:	03f79793          	slli	a5,a5,0x3f
    80001bd4:	00178793          	addi	a5,a5,1
    80001bd8:	0497ee63          	bltu	a5,s1,80001c34 <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    80001bdc:	ff848793          	addi	a5,s1,-8
    80001be0:	00100713          	li	a4,1
    80001be4:	18f76c63          	bltu	a4,a5,80001d7c <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001be8:	141027f3          	csrr	a5,sepc
    80001bec:	fcf43c23          	sd	a5,-40(s0)
    return sepc;
    80001bf0:	fd843783          	ld	a5,-40(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 volatile sepc = r_sepc() + 4;
    80001bf4:	00478793          	addi	a5,a5,4
    80001bf8:	faf43c23          	sd	a5,-72(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001bfc:	100027f3          	csrr	a5,sstatus
    80001c00:	fcf43823          	sd	a5,-48(s0)
    return sstatus;
    80001c04:	fd043783          	ld	a5,-48(s0)
            uint64 volatile sstatus = r_sstatus();
    80001c08:	fcf43023          	sd	a5,-64(s0)
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001c0c:	00088793          	mv	a5,a7
            switch (scallnum) {
    80001c10:	04200713          	li	a4,66
    80001c14:	04f76463          	bltu	a4,a5,80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
    80001c18:	00279793          	slli	a5,a5,0x2
    80001c1c:	00006717          	auipc	a4,0x6
    80001c20:	6a870713          	addi	a4,a4,1704 # 800082c4 <CONSOLE_STATUS+0x2b4>
    80001c24:	00e787b3          	add	a5,a5,a4
    80001c28:	0007a783          	lw	a5,0(a5)
    80001c2c:	00e787b3          	add	a5,a5,a4
    80001c30:	00078067          	jr	a5
    switch((uint64)scause){
    80001c34:	fff00793          	li	a5,-1
    80001c38:	03f79793          	slli	a5,a5,0x3f
    80001c3c:	00978793          	addi	a5,a5,9
    80001c40:	12f49e63          	bne	s1,a5,80001d7c <_ZN5Riscv20handleSupervisorTrapEv+0x1e0>
        }
        case 0x8000000000000001UL:
            mc_sip(SIP_SSIP);
            break;
        case 0x8000000000000009UL:
            console_handler();
    80001c44:	00005097          	auipc	ra,0x5
    80001c48:	5dc080e7          	jalr	1500(ra) # 80007220 <console_handler>
            break;
    80001c4c:	11c0006f          	j	80001d68 <_ZN5Riscv20handleSupervisorTrapEv+0x1cc>
                    READ_REG(size, "a0");
    80001c50:	00050513          	mv	a0,a0
                    memory::allocateMemory(size);
    80001c54:	00000097          	auipc	ra,0x0
    80001c58:	584080e7          	jalr	1412(ra) # 800021d8 <_ZN6memory14allocateMemoryEm>
            w_sstatus(sstatus);
    80001c5c:	fc043783          	ld	a5,-64(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001c60:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    80001c64:	fb843783          	ld	a5,-72(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001c68:	14179073          	csrw	sepc,a5
}
    80001c6c:	0fc0006f          	j	80001d68 <_ZN5Riscv20handleSupervisorTrapEv+0x1cc>
                    READ_REG(ptr, "a0");
    80001c70:	00050513          	mv	a0,a0
                    memory::freeMemory(ptr);
    80001c74:	00000097          	auipc	ra,0x0
    80001c78:	688080e7          	jalr	1672(ra) # 800022fc <_ZN6memory10freeMemoryEPv>
                    break;
    80001c7c:	fe1ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    memory::getFreeSpace();
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	734080e7          	jalr	1844(ra) # 800023b4 <_ZN6memory12getFreeSpaceEv>
                    break;
    80001c88:	fd5ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    memory::getLargestFreeBlock();
    80001c8c:	00000097          	auipc	ra,0x0
    80001c90:	760080e7          	jalr	1888(ra) # 800023ec <_ZN6memory19getLargestFreeBlockEv>
                    break;
    80001c94:	fc9ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(handle, "a0");
    80001c98:	00050493          	mv	s1,a0
                    READ_REG(body, "a1");
    80001c9c:	00058513          	mv	a0,a1
                    READ_REG(args, "a2");
    80001ca0:	00060593          	mv	a1,a2
                    *handle = _thread::createThread(body, args);
    80001ca4:	fffff097          	auipc	ra,0xfffff
    80001ca8:	718080e7          	jalr	1816(ra) # 800013bc <_ZN7_thread12createThreadEPFvPvES0_>
    80001cac:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001cb0:	00050863          	beqz	a0,80001cc0 <_ZN5Riscv20handleSupervisorTrapEv+0x124>
    80001cb4:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001cb8:	00078513          	mv	a0,a5
                    break;
    80001cbc:	fa1ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    else ret = -1;
    80001cc0:	fff00793          	li	a5,-1
    80001cc4:	ff5ff06f          	j	80001cb8 <_ZN5Riscv20handleSupervisorTrapEv+0x11c>
                    _thread::exitThread();
    80001cc8:	00000097          	auipc	ra,0x0
    80001ccc:	864080e7          	jalr	-1948(ra) # 8000152c <_ZN7_thread10exitThreadEv>
                    break;
    80001cd0:	f8dff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    _thread::dispatch();
    80001cd4:	fffff097          	auipc	ra,0xfffff
    80001cd8:	7c8080e7          	jalr	1992(ra) # 8000149c <_ZN7_thread8dispatchEv>
                    break;
    80001cdc:	f81ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(handle, "a0");
    80001ce0:	00050493          	mv	s1,a0
                    READ_REG(init, "a1");
    80001ce4:	00058513          	mv	a0,a1
                    *handle = _sem::createSemaphore(init);
    80001ce8:	0005051b          	sext.w	a0,a0
    80001cec:	00000097          	auipc	ra,0x0
    80001cf0:	264080e7          	jalr	612(ra) # 80001f50 <_ZN4_sem15createSemaphoreEj>
    80001cf4:	00a4b023          	sd	a0,0(s1)
                    if(*handle != nullptr) ret = 0;
    80001cf8:	00050863          	beqz	a0,80001d08 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
    80001cfc:	00000793          	li	a5,0
                    WRITE_REG("a0", ret);
    80001d00:	00078513          	mv	a0,a5
                    break;
    80001d04:	f59ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    else ret = -1;
    80001d08:	fff00793          	li	a5,-1
    80001d0c:	ff5ff06f          	j	80001d00 <_ZN5Riscv20handleSupervisorTrapEv+0x164>
                    READ_REG(handleClose, "a0");
    80001d10:	00050513          	mv	a0,a0
                    handleClose->close();
    80001d14:	00000097          	auipc	ra,0x0
    80001d18:	2a0080e7          	jalr	672(ra) # 80001fb4 <_ZN4_sem5closeEv>
                    break;
    80001d1c:	f41ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(idWait, "a0");
    80001d20:	00050513          	mv	a0,a0
                    idWait->wait();
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	0b4080e7          	jalr	180(ra) # 80001dd8 <_ZN4_sem4waitEv>
                    break;
    80001d2c:	f31ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(idSignal, "a0");
    80001d30:	00050513          	mv	a0,a0
                    idSignal->signal();
    80001d34:	00000097          	auipc	ra,0x0
    80001d38:	168080e7          	jalr	360(ra) # 80001e9c <_ZN4_sem6signalEv>
                    break;
    80001d3c:	f21ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    __getc();
    80001d40:	00005097          	auipc	ra,0x5
    80001d44:	4a8080e7          	jalr	1192(ra) # 800071e8 <__getc>
                    break;
    80001d48:	f15ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
                    READ_REG(c, "a0");
    80001d4c:	00050513          	mv	a0,a0
                    __putc(c);
    80001d50:	0ff57513          	andi	a0,a0,255
    80001d54:	00005097          	auipc	ra,0x5
    80001d58:	458080e7          	jalr	1112(ra) # 800071ac <__putc>
                    break;
    80001d5c:	f01ff06f          	j	80001c5c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001d60:	00200793          	li	a5,2
    80001d64:	1447b073          	csrc	sip,a5
            printString("Koraci ko laki oblaci, skoci da te zemlja odbaci!\n");
            if ((int)scause == 2) thread_exit();

            break;
    }
    80001d68:	04813083          	ld	ra,72(sp)
    80001d6c:	04013403          	ld	s0,64(sp)
    80001d70:	03813483          	ld	s1,56(sp)
    80001d74:	05010113          	addi	sp,sp,80
    80001d78:	00008067          	ret
            printString("Scause: ");
    80001d7c:	00006517          	auipc	a0,0x6
    80001d80:	50450513          	addi	a0,a0,1284 # 80008280 <CONSOLE_STATUS+0x270>
    80001d84:	00002097          	auipc	ra,0x2
    80001d88:	39c080e7          	jalr	924(ra) # 80004120 <_Z11printStringPKc>
            printInt(scause);
    80001d8c:	0004849b          	sext.w	s1,s1
    80001d90:	00000613          	li	a2,0
    80001d94:	00a00593          	li	a1,10
    80001d98:	00048513          	mv	a0,s1
    80001d9c:	00002097          	auipc	ra,0x2
    80001da0:	534080e7          	jalr	1332(ra) # 800042d0 <_Z8printIntiii>
            printString("\n");
    80001da4:	00006517          	auipc	a0,0x6
    80001da8:	40450513          	addi	a0,a0,1028 # 800081a8 <CONSOLE_STATUS+0x198>
    80001dac:	00002097          	auipc	ra,0x2
    80001db0:	374080e7          	jalr	884(ra) # 80004120 <_Z11printStringPKc>
            printString("Koraci ko laki oblaci, skoci da te zemlja odbaci!\n");
    80001db4:	00006517          	auipc	a0,0x6
    80001db8:	4dc50513          	addi	a0,a0,1244 # 80008290 <CONSOLE_STATUS+0x280>
    80001dbc:	00002097          	auipc	ra,0x2
    80001dc0:	364080e7          	jalr	868(ra) # 80004120 <_Z11printStringPKc>
            if ((int)scause == 2) thread_exit();
    80001dc4:	00200793          	li	a5,2
    80001dc8:	faf490e3          	bne	s1,a5,80001d68 <_ZN5Riscv20handleSupervisorTrapEv+0x1cc>
    80001dcc:	fffff097          	auipc	ra,0xfffff
    80001dd0:	448080e7          	jalr	1096(ra) # 80001214 <_Z11thread_exitv>
    80001dd4:	f95ff06f          	j	80001d68 <_ZN5Riscv20handleSupervisorTrapEv+0x1cc>

0000000080001dd8 <_ZN4_sem4waitEv>:

    int value() const { return val; }


    void setClosed(bool b);
    bool isClosed() const {return closed;}
    80001dd8:	00454783          	lbu	a5,4(a0)

#include "../h/_sem.hpp"
#include "../h/syscall_c.hpp"

int _sem::wait() {
    if (isClosed()) return -1;
    80001ddc:	0a079c63          	bnez	a5,80001e94 <_ZN4_sem4waitEv+0xbc>
int _sem::wait() {
    80001de0:	fe010113          	addi	sp,sp,-32
    80001de4:	00113c23          	sd	ra,24(sp)
    80001de8:	00813823          	sd	s0,16(sp)
    80001dec:	00913423          	sd	s1,8(sp)
    80001df0:	01213023          	sd	s2,0(sp)
    80001df4:	02010413          	addi	s0,sp,32
    80001df8:	00050493          	mv	s1,a0
    if (--val < 0){
    80001dfc:	00052783          	lw	a5,0(a0)
    80001e00:	fff7879b          	addiw	a5,a5,-1
    80001e04:	00f52023          	sw	a5,0(a0)
    80001e08:	02079713          	slli	a4,a5,0x20
    80001e0c:	02074663          	bltz	a4,80001e38 <_ZN4_sem4waitEv+0x60>
        cur->setSemStatus(0);
        blocked.addLast(cur);
        thread_dispatch();
    }

    return _thread::running->getSemStatus();
    80001e10:	00008797          	auipc	a5,0x8
    80001e14:	2f07b783          	ld	a5,752(a5) # 8000a100 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001e18:	0007b783          	ld	a5,0(a5)
    void setBlock(bool b);

    bool isBlocked() const { return blocked; }

    void setSemStatus(int s) { semStatus = s; }
    int getSemStatus() const { return semStatus; }
    80001e1c:	02c7a503          	lw	a0,44(a5)
}
    80001e20:	01813083          	ld	ra,24(sp)
    80001e24:	01013403          	ld	s0,16(sp)
    80001e28:	00813483          	ld	s1,8(sp)
    80001e2c:	00013903          	ld	s2,0(sp)
    80001e30:	02010113          	addi	sp,sp,32
    80001e34:	00008067          	ret
        _thread* cur = _thread::running;
    80001e38:	00008797          	auipc	a5,0x8
    80001e3c:	2c87b783          	ld	a5,712(a5) # 8000a100 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001e40:	0007b903          	ld	s2,0(a5)
        cur->setBlock(true);
    80001e44:	00100593          	li	a1,1
    80001e48:	00090513          	mv	a0,s2
    80001e4c:	fffff097          	auipc	ra,0xfffff
    80001e50:	738080e7          	jalr	1848(ra) # 80001584 <_ZN7_thread8setBlockEb>
    void setSemStatus(int s) { semStatus = s; }
    80001e54:	02092623          	sw	zero,44(s2)
        if (!tail) { tail = head; }
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
    80001e58:	01000513          	li	a0,16
    80001e5c:	00000097          	auipc	ra,0x0
    80001e60:	974080e7          	jalr	-1676(ra) # 800017d0 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001e64:	01253023          	sd	s2,0(a0)
    80001e68:	00053423          	sd	zero,8(a0)
        if (tail)
    80001e6c:	0104b783          	ld	a5,16(s1)
    80001e70:	00078c63          	beqz	a5,80001e88 <_ZN4_sem4waitEv+0xb0>
        {
            tail->next = elem;
    80001e74:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001e78:	00a4b823          	sd	a0,16(s1)
        thread_dispatch();
    80001e7c:	fffff097          	auipc	ra,0xfffff
    80001e80:	3c4080e7          	jalr	964(ra) # 80001240 <_Z15thread_dispatchv>
    80001e84:	f8dff06f          	j	80001e10 <_ZN4_sem4waitEv+0x38>
        } else
        {
            head = tail = elem;
    80001e88:	00a4b823          	sd	a0,16(s1)
    80001e8c:	00a4b423          	sd	a0,8(s1)
    80001e90:	fedff06f          	j	80001e7c <_ZN4_sem4waitEv+0xa4>
    if (isClosed()) return -1;
    80001e94:	fff00513          	li	a0,-1
}
    80001e98:	00008067          	ret

0000000080001e9c <_ZN4_sem6signalEv>:
    80001e9c:	00454703          	lbu	a4,4(a0)

int _sem::signal() {
    if (isClosed()) return -1;
    80001ea0:	08071c63          	bnez	a4,80001f38 <_ZN4_sem6signalEv+0x9c>
    80001ea4:	00050793          	mv	a5,a0
    if(++val <= 0){
    80001ea8:	00052703          	lw	a4,0(a0)
    80001eac:	0017071b          	addiw	a4,a4,1
    80001eb0:	0007069b          	sext.w	a3,a4
    80001eb4:	00e52023          	sw	a4,0(a0)
    80001eb8:	00d05663          	blez	a3,80001ec4 <_ZN4_sem6signalEv+0x28>
        if(_thread* cur = blocked.removeFirst()){
            cur->setBlock(false);
            Scheduler::put(cur);
        }
    }
    return 0;
    80001ebc:	00000513          	li	a0,0
    80001ec0:	00008067          	ret
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001ec4:	00853503          	ld	a0,8(a0)
    80001ec8:	06050c63          	beqz	a0,80001f40 <_ZN4_sem6signalEv+0xa4>
int _sem::signal() {
    80001ecc:	fe010113          	addi	sp,sp,-32
    80001ed0:	00113c23          	sd	ra,24(sp)
    80001ed4:	00813823          	sd	s0,16(sp)
    80001ed8:	00913423          	sd	s1,8(sp)
    80001edc:	02010413          	addi	s0,sp,32

        Elem *elem = head;
        head = head->next;
    80001ee0:	00853703          	ld	a4,8(a0)
    80001ee4:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001ee8:	04070463          	beqz	a4,80001f30 <_ZN4_sem6signalEv+0x94>

        T *ret = elem->data;
    80001eec:	00053483          	ld	s1,0(a0)
        delete elem;
    80001ef0:	00000097          	auipc	ra,0x0
    80001ef4:	930080e7          	jalr	-1744(ra) # 80001820 <_ZdlPv>
        if(_thread* cur = blocked.removeFirst()){
    80001ef8:	04048863          	beqz	s1,80001f48 <_ZN4_sem6signalEv+0xac>
            cur->setBlock(false);
    80001efc:	00000593          	li	a1,0
    80001f00:	00048513          	mv	a0,s1
    80001f04:	fffff097          	auipc	ra,0xfffff
    80001f08:	680080e7          	jalr	1664(ra) # 80001584 <_ZN7_thread8setBlockEb>
            Scheduler::put(cur);
    80001f0c:	00048513          	mv	a0,s1
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	1e4080e7          	jalr	484(ra) # 800020f4 <_ZN9Scheduler3putEP7_thread>
    return 0;
    80001f18:	00000513          	li	a0,0
}
    80001f1c:	01813083          	ld	ra,24(sp)
    80001f20:	01013403          	ld	s0,16(sp)
    80001f24:	00813483          	ld	s1,8(sp)
    80001f28:	02010113          	addi	sp,sp,32
    80001f2c:	00008067          	ret
        if (!head) { tail = 0; }
    80001f30:	0007b823          	sd	zero,16(a5)
    80001f34:	fb9ff06f          	j	80001eec <_ZN4_sem6signalEv+0x50>
    if (isClosed()) return -1;
    80001f38:	fff00513          	li	a0,-1
    80001f3c:	00008067          	ret
    return 0;
    80001f40:	00000513          	li	a0,0
}
    80001f44:	00008067          	ret
    return 0;
    80001f48:	00000513          	li	a0,0
    80001f4c:	fd1ff06f          	j	80001f1c <_ZN4_sem6signalEv+0x80>

0000000080001f50 <_ZN4_sem15createSemaphoreEj>:
    }

    return 0;
}

_sem* _sem::createSemaphore(uint32 init) {
    80001f50:	fe010113          	addi	sp,sp,-32
    80001f54:	00113c23          	sd	ra,24(sp)
    80001f58:	00813823          	sd	s0,16(sp)
    80001f5c:	00913423          	sd	s1,8(sp)
    80001f60:	02010413          	addi	s0,sp,32
    80001f64:	00050493          	mv	s1,a0
    _sem* newSemaphore = new _sem(init);
    80001f68:	01800513          	li	a0,24
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	864080e7          	jalr	-1948(ra) # 800017d0 <_Znwm>
    _sem(uint32 init = 1) : val(init), closed(false) {}
    80001f74:	00952023          	sw	s1,0(a0)
    80001f78:	00050223          	sb	zero,4(a0)
    List() : head(0), tail(0) {}
    80001f7c:	00053423          	sd	zero,8(a0)
    80001f80:	00053823          	sd	zero,16(a0)
    return newSemaphore;
}
    80001f84:	01813083          	ld	ra,24(sp)
    80001f88:	01013403          	ld	s0,16(sp)
    80001f8c:	00813483          	ld	s1,8(sp)
    80001f90:	02010113          	addi	sp,sp,32
    80001f94:	00008067          	ret

0000000080001f98 <_ZN4_sem9setClosedEb>:

void _sem::setClosed(bool b) {
    80001f98:	ff010113          	addi	sp,sp,-16
    80001f9c:	00813423          	sd	s0,8(sp)
    80001fa0:	01010413          	addi	s0,sp,16
    closed = b;
    80001fa4:	00b50223          	sb	a1,4(a0)
}
    80001fa8:	00813403          	ld	s0,8(sp)
    80001fac:	01010113          	addi	sp,sp,16
    80001fb0:	00008067          	ret

0000000080001fb4 <_ZN4_sem5closeEv>:
int _sem::close() {
    80001fb4:	fe010113          	addi	sp,sp,-32
    80001fb8:	00113c23          	sd	ra,24(sp)
    80001fbc:	00813823          	sd	s0,16(sp)
    80001fc0:	00913423          	sd	s1,8(sp)
    80001fc4:	01213023          	sd	s2,0(sp)
    80001fc8:	02010413          	addi	s0,sp,32
    80001fcc:	00050913          	mv	s2,a0
    setClosed(true);
    80001fd0:	00100593          	li	a1,1
    80001fd4:	00000097          	auipc	ra,0x0
    80001fd8:	fc4080e7          	jalr	-60(ra) # 80001f98 <_ZN4_sem9setClosedEb>
    80001fdc:	03c0006f          	j	80002018 <_ZN4_sem5closeEv+0x64>
        if (!head) { tail = 0; }
    80001fe0:	00093823          	sd	zero,16(s2)
        T *ret = elem->data;
    80001fe4:	00053483          	ld	s1,0(a0)
        delete elem;
    80001fe8:	00000097          	auipc	ra,0x0
    80001fec:	838080e7          	jalr	-1992(ra) # 80001820 <_ZdlPv>
    while(_thread* cur = blocked.removeFirst()){
    80001ff0:	04048063          	beqz	s1,80002030 <_ZN4_sem5closeEv+0x7c>
    80001ff4:	fff00793          	li	a5,-1
    80001ff8:	02f4a623          	sw	a5,44(s1)
        cur->setBlock(false);
    80001ffc:	00000593          	li	a1,0
    80002000:	00048513          	mv	a0,s1
    80002004:	fffff097          	auipc	ra,0xfffff
    80002008:	580080e7          	jalr	1408(ra) # 80001584 <_ZN7_thread8setBlockEb>
        Scheduler::put(cur);
    8000200c:	00048513          	mv	a0,s1
    80002010:	00000097          	auipc	ra,0x0
    80002014:	0e4080e7          	jalr	228(ra) # 800020f4 <_ZN9Scheduler3putEP7_thread>
        if (!head) { return 0; }
    80002018:	00893503          	ld	a0,8(s2)
    8000201c:	00050a63          	beqz	a0,80002030 <_ZN4_sem5closeEv+0x7c>
        head = head->next;
    80002020:	00853783          	ld	a5,8(a0)
    80002024:	00f93423          	sd	a5,8(s2)
        if (!head) { tail = 0; }
    80002028:	fa079ee3          	bnez	a5,80001fe4 <_ZN4_sem5closeEv+0x30>
    8000202c:	fb5ff06f          	j	80001fe0 <_ZN4_sem5closeEv+0x2c>
}
    80002030:	00000513          	li	a0,0
    80002034:	01813083          	ld	ra,24(sp)
    80002038:	01013403          	ld	s0,16(sp)
    8000203c:	00813483          	ld	s1,8(sp)
    80002040:	00013903          	ld	s2,0(sp)
    80002044:	02010113          	addi	sp,sp,32
    80002048:	00008067          	ret

000000008000204c <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *tcb)
{
    readyThreadQueue.addLast(tcb);
    8000204c:	ff010113          	addi	sp,sp,-16
    80002050:	00813423          	sd	s0,8(sp)
    80002054:	01010413          	addi	s0,sp,16
    80002058:	00100793          	li	a5,1
    8000205c:	00f50863          	beq	a0,a5,8000206c <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002060:	00813403          	ld	s0,8(sp)
    80002064:	01010113          	addi	sp,sp,16
    80002068:	00008067          	ret
    8000206c:	000107b7          	lui	a5,0x10
    80002070:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002074:	fef596e3          	bne	a1,a5,80002060 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80002078:	00008797          	auipc	a5,0x8
    8000207c:	10878793          	addi	a5,a5,264 # 8000a180 <_ZN9Scheduler16readyThreadQueueE>
    80002080:	0007b023          	sd	zero,0(a5)
    80002084:	0007b423          	sd	zero,8(a5)
    80002088:	fd9ff06f          	j	80002060 <_Z41__static_initialization_and_destruction_0ii+0x14>

000000008000208c <_ZN9Scheduler3getEv>:
{
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    800020a0:	00008517          	auipc	a0,0x8
    800020a4:	0e053503          	ld	a0,224(a0) # 8000a180 <_ZN9Scheduler16readyThreadQueueE>
    800020a8:	04050263          	beqz	a0,800020ec <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    800020ac:	00853783          	ld	a5,8(a0)
    800020b0:	00008717          	auipc	a4,0x8
    800020b4:	0cf73823          	sd	a5,208(a4) # 8000a180 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    800020b8:	02078463          	beqz	a5,800020e0 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    800020bc:	00053483          	ld	s1,0(a0)
        delete elem;
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	760080e7          	jalr	1888(ra) # 80001820 <_ZdlPv>
}
    800020c8:	00048513          	mv	a0,s1
    800020cc:	01813083          	ld	ra,24(sp)
    800020d0:	01013403          	ld	s0,16(sp)
    800020d4:	00813483          	ld	s1,8(sp)
    800020d8:	02010113          	addi	sp,sp,32
    800020dc:	00008067          	ret
        if (!head) { tail = 0; }
    800020e0:	00008797          	auipc	a5,0x8
    800020e4:	0a07b423          	sd	zero,168(a5) # 8000a188 <_ZN9Scheduler16readyThreadQueueE+0x8>
    800020e8:	fd5ff06f          	j	800020bc <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    800020ec:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    800020f0:	fd9ff06f          	j	800020c8 <_ZN9Scheduler3getEv+0x3c>

00000000800020f4 <_ZN9Scheduler3putEP7_thread>:
{
    800020f4:	fe010113          	addi	sp,sp,-32
    800020f8:	00113c23          	sd	ra,24(sp)
    800020fc:	00813823          	sd	s0,16(sp)
    80002100:	00913423          	sd	s1,8(sp)
    80002104:	02010413          	addi	s0,sp,32
    80002108:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    8000210c:	01000513          	li	a0,16
    80002110:	fffff097          	auipc	ra,0xfffff
    80002114:	6c0080e7          	jalr	1728(ra) # 800017d0 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002118:	00953023          	sd	s1,0(a0)
    8000211c:	00053423          	sd	zero,8(a0)
        if (tail)
    80002120:	00008797          	auipc	a5,0x8
    80002124:	0687b783          	ld	a5,104(a5) # 8000a188 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002128:	02078263          	beqz	a5,8000214c <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    8000212c:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002130:	00008797          	auipc	a5,0x8
    80002134:	04a7bc23          	sd	a0,88(a5) # 8000a188 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002138:	01813083          	ld	ra,24(sp)
    8000213c:	01013403          	ld	s0,16(sp)
    80002140:	00813483          	ld	s1,8(sp)
    80002144:	02010113          	addi	sp,sp,32
    80002148:	00008067          	ret
            head = tail = elem;
    8000214c:	00008797          	auipc	a5,0x8
    80002150:	03478793          	addi	a5,a5,52 # 8000a180 <_ZN9Scheduler16readyThreadQueueE>
    80002154:	00a7b423          	sd	a0,8(a5)
    80002158:	00a7b023          	sd	a0,0(a5)
    8000215c:	fddff06f          	j	80002138 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080002160 <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80002160:	ff010113          	addi	sp,sp,-16
    80002164:	00113423          	sd	ra,8(sp)
    80002168:	00813023          	sd	s0,0(sp)
    8000216c:	01010413          	addi	s0,sp,16
    80002170:	000105b7          	lui	a1,0x10
    80002174:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002178:	00100513          	li	a0,1
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	ed0080e7          	jalr	-304(ra) # 8000204c <_Z41__static_initialization_and_destruction_0ii>
    80002184:	00813083          	ld	ra,8(sp)
    80002188:	00013403          	ld	s0,0(sp)
    8000218c:	01010113          	addi	sp,sp,16
    80002190:	00008067          	ret

0000000080002194 <_ZN6memory10initializeEv>:

#include "../h/memory.hpp"

memory::FreeBlock* memory::freeHead = nullptr;

void memory::initialize() {
    80002194:	ff010113          	addi	sp,sp,-16
    80002198:	00813423          	sd	s0,8(sp)
    8000219c:	01010413          	addi	s0,sp,16
    freeHead = (FreeBlock*) HEAP_START_ADDR;
    800021a0:	00008797          	auipc	a5,0x8
    800021a4:	f587b783          	ld	a5,-168(a5) # 8000a0f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800021a8:	0007b783          	ld	a5,0(a5)
    800021ac:	00008717          	auipc	a4,0x8
    800021b0:	fef73223          	sd	a5,-28(a4) # 8000a190 <_ZN6memory8freeHeadE>
    freeHead->size = (size_t)((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR);
    800021b4:	00008717          	auipc	a4,0x8
    800021b8:	f6473703          	ld	a4,-156(a4) # 8000a118 <_GLOBAL_OFFSET_TABLE_+0x28>
    800021bc:	00073703          	ld	a4,0(a4)
    800021c0:	40f70733          	sub	a4,a4,a5
    800021c4:	00e7b423          	sd	a4,8(a5)
    freeHead->next = nullptr;
    800021c8:	0007b023          	sd	zero,0(a5)
}
    800021cc:	00813403          	ld	s0,8(sp)
    800021d0:	01010113          	addi	sp,sp,16
    800021d4:	00008067          	ret

00000000800021d8 <_ZN6memory14allocateMemoryEm>:

void *memory::allocateMemory(size_t size) {
    800021d8:	ff010113          	addi	sp,sp,-16
    800021dc:	00813423          	sd	s0,8(sp)
    800021e0:	01010413          	addi	s0,sp,16
    if (size == 0) return nullptr;
    800021e4:	0c050463          	beqz	a0,800022ac <_ZN6memory14allocateMemoryEm+0xd4>

    // zaokruzujemo na MEM_BLOCK_SIZE
    size = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE * MEM_BLOCK_SIZE;
    800021e8:	03f50713          	addi	a4,a0,63
    800021ec:	fc077713          	andi	a4,a4,-64

    // rezervisemo i header za slobodni blok ako ga cepamo
    size_t totalSize = size + sizeof(FreeBlock);
    800021f0:	01070713          	addi	a4,a4,16
    FreeBlock* bestPrev = nullptr;
    FreeBlock* best = nullptr;
    FreeBlock* prev = nullptr;

    // pronalazak najmanjeg dovoljno velikog bloka (best-fit)
    for(FreeBlock* curr = freeHead; curr; curr = curr->next){
    800021f4:	00008797          	auipc	a5,0x8
    800021f8:	f9c7b783          	ld	a5,-100(a5) # 8000a190 <_ZN6memory8freeHeadE>
    FreeBlock* prev = nullptr;
    800021fc:	00000613          	li	a2,0
    FreeBlock* best = nullptr;
    80002200:	00000513          	li	a0,0
    FreeBlock* bestPrev = nullptr;
    80002204:	00000813          	li	a6,0
    80002208:	0140006f          	j	8000221c <_ZN6memory14allocateMemoryEm+0x44>
        if (curr->size >= totalSize){
            if (!best || curr->size < best->size){
                best = curr;
    8000220c:	00078513          	mv	a0,a5
                bestPrev = prev;
    80002210:	00060813          	mv	a6,a2
            }
        }
        prev = curr;
    80002214:	00078613          	mv	a2,a5
    for(FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002218:	0007b783          	ld	a5,0(a5)
    8000221c:	02078263          	beqz	a5,80002240 <_ZN6memory14allocateMemoryEm+0x68>
        if (curr->size >= totalSize){
    80002220:	0087b683          	ld	a3,8(a5)
    80002224:	fee6e8e3          	bltu	a3,a4,80002214 <_ZN6memory14allocateMemoryEm+0x3c>
            if (!best || curr->size < best->size){
    80002228:	fe0502e3          	beqz	a0,8000220c <_ZN6memory14allocateMemoryEm+0x34>
    8000222c:	00853583          	ld	a1,8(a0)
    80002230:	feb6f2e3          	bgeu	a3,a1,80002214 <_ZN6memory14allocateMemoryEm+0x3c>
                best = curr;
    80002234:	00078513          	mv	a0,a5
                bestPrev = prev;
    80002238:	00060813          	mv	a6,a2
    8000223c:	fd9ff06f          	j	80002214 <_ZN6memory14allocateMemoryEm+0x3c>
    }

    if (!best) return nullptr; // nema dovoljno memorije
    80002240:	02050a63          	beqz	a0,80002274 <_ZN6memory14allocateMemoryEm+0x9c>

    size_t remaining = best->size - totalSize;
    80002244:	00853783          	ld	a5,8(a0)
    80002248:	40e787b3          	sub	a5,a5,a4

    if (remaining >= sizeof(FreeBlock) + MEM_BLOCK_SIZE){
    8000224c:	04f00693          	li	a3,79
    80002250:	02f6fe63          	bgeu	a3,a5,8000228c <_ZN6memory14allocateMemoryEm+0xb4>
        // cepamo blok
        FreeBlock* newBlock = (FreeBlock*)((char*)best + totalSize);
    80002254:	00e506b3          	add	a3,a0,a4
        newBlock->size = remaining;
    80002258:	00f6b423          	sd	a5,8(a3)
        newBlock->next = best->next;
    8000225c:	00053783          	ld	a5,0(a0)
    80002260:	00f6b023          	sd	a5,0(a3)
        best->size = totalSize;
    80002264:	00e53423          	sd	a4,8(a0)
        if (bestPrev) bestPrev->next = newBlock;
    80002268:	00080c63          	beqz	a6,80002280 <_ZN6memory14allocateMemoryEm+0xa8>
    8000226c:	00d83023          	sd	a3,0(a6)
        if (bestPrev) bestPrev->next = best->next;
        else freeHead = best->next;
    }

    // vracamo pokazivac na korisnicki deo, posle headera
    return (void *)((char*)best + sizeof(FreeBlock));
    80002270:	01050513          	addi	a0,a0,16
}
    80002274:	00813403          	ld	s0,8(sp)
    80002278:	01010113          	addi	sp,sp,16
    8000227c:	00008067          	ret
        else freeHead = newBlock;
    80002280:	00008797          	auipc	a5,0x8
    80002284:	f0d7b823          	sd	a3,-240(a5) # 8000a190 <_ZN6memory8freeHeadE>
    80002288:	fe9ff06f          	j	80002270 <_ZN6memory14allocateMemoryEm+0x98>
        if (bestPrev) bestPrev->next = best->next;
    8000228c:	00080863          	beqz	a6,8000229c <_ZN6memory14allocateMemoryEm+0xc4>
    80002290:	00053783          	ld	a5,0(a0)
    80002294:	00f83023          	sd	a5,0(a6)
    80002298:	fd9ff06f          	j	80002270 <_ZN6memory14allocateMemoryEm+0x98>
        else freeHead = best->next;
    8000229c:	00053783          	ld	a5,0(a0)
    800022a0:	00008717          	auipc	a4,0x8
    800022a4:	eef73823          	sd	a5,-272(a4) # 8000a190 <_ZN6memory8freeHeadE>
    800022a8:	fc9ff06f          	j	80002270 <_ZN6memory14allocateMemoryEm+0x98>
    if (size == 0) return nullptr;
    800022ac:	00000513          	li	a0,0
    800022b0:	fc5ff06f          	j	80002274 <_ZN6memory14allocateMemoryEm+0x9c>

00000000800022b4 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>:

    tryToJoin(curr);
    return 0;
}

void memory::tryToJoin(memory::FreeBlock *block) {
    800022b4:	ff010113          	addi	sp,sp,-16
    800022b8:	00813423          	sd	s0,8(sp)
    800022bc:	01010413          	addi	s0,sp,16
    if(!block || !block->next) return;
    800022c0:	00050c63          	beqz	a0,800022d8 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>
    800022c4:	00053783          	ld	a5,0(a0)
    800022c8:	00078863          	beqz	a5,800022d8 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>

    char* endOfBlock = (char*)block + block->size;
    800022cc:	00853703          	ld	a4,8(a0)
    800022d0:	00e506b3          	add	a3,a0,a4
    if (endOfBlock == (char*)block->next){
    800022d4:	00d78863          	beq	a5,a3,800022e4 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x30>
        block->size += block->next->size;
        block->next = block->next->next;
    }
}
    800022d8:	00813403          	ld	s0,8(sp)
    800022dc:	01010113          	addi	sp,sp,16
    800022e0:	00008067          	ret
        block->size += block->next->size;
    800022e4:	0087b683          	ld	a3,8(a5)
    800022e8:	00d70733          	add	a4,a4,a3
    800022ec:	00e53423          	sd	a4,8(a0)
        block->next = block->next->next;
    800022f0:	0007b783          	ld	a5,0(a5)
    800022f4:	00f53023          	sd	a5,0(a0)
    800022f8:	fe1ff06f          	j	800022d8 <_ZN6memory9tryToJoinEPNS_9FreeBlockE+0x24>

00000000800022fc <_ZN6memory10freeMemoryEPv>:
    if (!ptr) return -1;
    800022fc:	0a050063          	beqz	a0,8000239c <_ZN6memory10freeMemoryEPv+0xa0>
    80002300:	00050693          	mv	a3,a0
    FreeBlock* block = (FreeBlock*)((char*)ptr - sizeof(FreeBlock));
    80002304:	ff050713          	addi	a4,a0,-16
    if (block < (FreeBlock*)HEAP_START_ADDR || block >= (FreeBlock*)HEAP_END_ADDR) return -2; // van heapa
    80002308:	00008797          	auipc	a5,0x8
    8000230c:	df07b783          	ld	a5,-528(a5) # 8000a0f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002310:	0007b783          	ld	a5,0(a5)
    80002314:	08f76863          	bltu	a4,a5,800023a4 <_ZN6memory10freeMemoryEPv+0xa8>
    80002318:	00008797          	auipc	a5,0x8
    8000231c:	e007b783          	ld	a5,-512(a5) # 8000a118 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002320:	0007b783          	ld	a5,0(a5)
    80002324:	08f77463          	bgeu	a4,a5,800023ac <_ZN6memory10freeMemoryEPv+0xb0>
int memory::freeMemory(void *ptr) {
    80002328:	ff010113          	addi	sp,sp,-16
    8000232c:	00113423          	sd	ra,8(sp)
    80002330:	00813023          	sd	s0,0(sp)
    80002334:	01010413          	addi	s0,sp,16
    if (!freeHead || block < freeHead){
    80002338:	00008797          	auipc	a5,0x8
    8000233c:	e587b783          	ld	a5,-424(a5) # 8000a190 <_ZN6memory8freeHeadE>
    80002340:	02078e63          	beqz	a5,8000237c <_ZN6memory10freeMemoryEPv+0x80>
    80002344:	02f76c63          	bltu	a4,a5,8000237c <_ZN6memory10freeMemoryEPv+0x80>
    while(curr->next && curr->next < block) curr = curr->next;
    80002348:	00078513          	mv	a0,a5
    8000234c:	0007b783          	ld	a5,0(a5)
    80002350:	00078463          	beqz	a5,80002358 <_ZN6memory10freeMemoryEPv+0x5c>
    80002354:	fee7eae3          	bltu	a5,a4,80002348 <_ZN6memory10freeMemoryEPv+0x4c>
    block->next = curr->next;
    80002358:	fef6b823          	sd	a5,-16(a3)
    curr->next = block;
    8000235c:	00e53023          	sd	a4,0(a0)
    tryToJoin(curr);
    80002360:	00000097          	auipc	ra,0x0
    80002364:	f54080e7          	jalr	-172(ra) # 800022b4 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>
    return 0;
    80002368:	00000513          	li	a0,0
}
    8000236c:	00813083          	ld	ra,8(sp)
    80002370:	00013403          	ld	s0,0(sp)
    80002374:	01010113          	addi	sp,sp,16
    80002378:	00008067          	ret
        block->next = freeHead;
    8000237c:	fef6b823          	sd	a5,-16(a3)
        freeHead = block;
    80002380:	00008797          	auipc	a5,0x8
    80002384:	e0e7b823          	sd	a4,-496(a5) # 8000a190 <_ZN6memory8freeHeadE>
        tryToJoin(block);
    80002388:	00070513          	mv	a0,a4
    8000238c:	00000097          	auipc	ra,0x0
    80002390:	f28080e7          	jalr	-216(ra) # 800022b4 <_ZN6memory9tryToJoinEPNS_9FreeBlockE>
        return 0;
    80002394:	00000513          	li	a0,0
    80002398:	fd5ff06f          	j	8000236c <_ZN6memory10freeMemoryEPv+0x70>
    if (!ptr) return -1;
    8000239c:	fff00513          	li	a0,-1
    800023a0:	00008067          	ret
    if (block < (FreeBlock*)HEAP_START_ADDR || block >= (FreeBlock*)HEAP_END_ADDR) return -2; // van heapa
    800023a4:	ffe00513          	li	a0,-2
    800023a8:	00008067          	ret
    800023ac:	ffe00513          	li	a0,-2
}
    800023b0:	00008067          	ret

00000000800023b4 <_ZN6memory12getFreeSpaceEv>:

size_t memory::getFreeSpace() {
    800023b4:	ff010113          	addi	sp,sp,-16
    800023b8:	00813423          	sd	s0,8(sp)
    800023bc:	01010413          	addi	s0,sp,16
    size_t total = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next) total += curr->size;
    800023c0:	00008797          	auipc	a5,0x8
    800023c4:	dd07b783          	ld	a5,-560(a5) # 8000a190 <_ZN6memory8freeHeadE>
    size_t total = 0;
    800023c8:	00000513          	li	a0,0
    for (FreeBlock* curr = freeHead; curr; curr = curr->next) total += curr->size;
    800023cc:	00078a63          	beqz	a5,800023e0 <_ZN6memory12getFreeSpaceEv+0x2c>
    800023d0:	0087b703          	ld	a4,8(a5)
    800023d4:	00e50533          	add	a0,a0,a4
    800023d8:	0007b783          	ld	a5,0(a5)
    800023dc:	ff1ff06f          	j	800023cc <_ZN6memory12getFreeSpaceEv+0x18>
    return total;
}
    800023e0:	00813403          	ld	s0,8(sp)
    800023e4:	01010113          	addi	sp,sp,16
    800023e8:	00008067          	ret

00000000800023ec <_ZN6memory19getLargestFreeBlockEv>:

size_t memory::getLargestFreeBlock() {
    800023ec:	ff010113          	addi	sp,sp,-16
    800023f0:	00813423          	sd	s0,8(sp)
    800023f4:	01010413          	addi	s0,sp,16
    size_t largest = 0;
    for (FreeBlock* curr = freeHead; curr; curr = curr->next){
    800023f8:	00008797          	auipc	a5,0x8
    800023fc:	d987b783          	ld	a5,-616(a5) # 8000a190 <_ZN6memory8freeHeadE>
    size_t largest = 0;
    80002400:	00000513          	li	a0,0
    80002404:	0080006f          	j	8000240c <_ZN6memory19getLargestFreeBlockEv+0x20>
    for (FreeBlock* curr = freeHead; curr; curr = curr->next){
    80002408:	0007b783          	ld	a5,0(a5)
    8000240c:	00078a63          	beqz	a5,80002420 <_ZN6memory19getLargestFreeBlockEv+0x34>
        if (curr->size > largest) largest = curr->size;
    80002410:	0087b703          	ld	a4,8(a5)
    80002414:	fee57ae3          	bgeu	a0,a4,80002408 <_ZN6memory19getLargestFreeBlockEv+0x1c>
    80002418:	00070513          	mv	a0,a4
    8000241c:	fedff06f          	j	80002408 <_ZN6memory19getLargestFreeBlockEv+0x1c>
    }
    return largest;
}
    80002420:	00813403          	ld	s0,8(sp)
    80002424:	01010113          	addi	sp,sp,16
    80002428:	00008067          	ret

000000008000242c <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    8000242c:	fe010113          	addi	sp,sp,-32
    80002430:	00113c23          	sd	ra,24(sp)
    80002434:	00813823          	sd	s0,16(sp)
    80002438:	00913423          	sd	s1,8(sp)
    8000243c:	01213023          	sd	s2,0(sp)
    80002440:	02010413          	addi	s0,sp,32
    80002444:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002448:	00000913          	li	s2,0
    8000244c:	00c0006f          	j	80002458 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002450:	fffff097          	auipc	ra,0xfffff
    80002454:	df0080e7          	jalr	-528(ra) # 80001240 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002458:	fffff097          	auipc	ra,0xfffff
    8000245c:	ebc080e7          	jalr	-324(ra) # 80001314 <_Z4getcv>
    80002460:	0005059b          	sext.w	a1,a0
    80002464:	01b00793          	li	a5,27
    80002468:	02f58a63          	beq	a1,a5,8000249c <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    8000246c:	0084b503          	ld	a0,8(s1)
    80002470:	00003097          	auipc	ra,0x3
    80002474:	9fc080e7          	jalr	-1540(ra) # 80004e6c <_ZN6Buffer3putEi>
        i++;
    80002478:	0019071b          	addiw	a4,s2,1
    8000247c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002480:	0004a683          	lw	a3,0(s1)
    80002484:	0026979b          	slliw	a5,a3,0x2
    80002488:	00d787bb          	addw	a5,a5,a3
    8000248c:	0017979b          	slliw	a5,a5,0x1
    80002490:	02f767bb          	remw	a5,a4,a5
    80002494:	fc0792e3          	bnez	a5,80002458 <_ZL16producerKeyboardPv+0x2c>
    80002498:	fb9ff06f          	j	80002450 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    8000249c:	00100793          	li	a5,1
    800024a0:	00008717          	auipc	a4,0x8
    800024a4:	cef72c23          	sw	a5,-776(a4) # 8000a198 <_ZL9threadEnd>
    data->buffer->put('!');
    800024a8:	02100593          	li	a1,33
    800024ac:	0084b503          	ld	a0,8(s1)
    800024b0:	00003097          	auipc	ra,0x3
    800024b4:	9bc080e7          	jalr	-1604(ra) # 80004e6c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800024b8:	0104b503          	ld	a0,16(s1)
    800024bc:	fffff097          	auipc	ra,0xfffff
    800024c0:	e2c080e7          	jalr	-468(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    800024c4:	01813083          	ld	ra,24(sp)
    800024c8:	01013403          	ld	s0,16(sp)
    800024cc:	00813483          	ld	s1,8(sp)
    800024d0:	00013903          	ld	s2,0(sp)
    800024d4:	02010113          	addi	sp,sp,32
    800024d8:	00008067          	ret

00000000800024dc <_ZL8producerPv>:

static void producer(void *arg) {
    800024dc:	fe010113          	addi	sp,sp,-32
    800024e0:	00113c23          	sd	ra,24(sp)
    800024e4:	00813823          	sd	s0,16(sp)
    800024e8:	00913423          	sd	s1,8(sp)
    800024ec:	01213023          	sd	s2,0(sp)
    800024f0:	02010413          	addi	s0,sp,32
    800024f4:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800024f8:	00000913          	li	s2,0
    800024fc:	00c0006f          	j	80002508 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002500:	fffff097          	auipc	ra,0xfffff
    80002504:	d40080e7          	jalr	-704(ra) # 80001240 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002508:	00008797          	auipc	a5,0x8
    8000250c:	c907a783          	lw	a5,-880(a5) # 8000a198 <_ZL9threadEnd>
    80002510:	02079e63          	bnez	a5,8000254c <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002514:	0004a583          	lw	a1,0(s1)
    80002518:	0305859b          	addiw	a1,a1,48
    8000251c:	0084b503          	ld	a0,8(s1)
    80002520:	00003097          	auipc	ra,0x3
    80002524:	94c080e7          	jalr	-1716(ra) # 80004e6c <_ZN6Buffer3putEi>
        i++;
    80002528:	0019071b          	addiw	a4,s2,1
    8000252c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002530:	0004a683          	lw	a3,0(s1)
    80002534:	0026979b          	slliw	a5,a3,0x2
    80002538:	00d787bb          	addw	a5,a5,a3
    8000253c:	0017979b          	slliw	a5,a5,0x1
    80002540:	02f767bb          	remw	a5,a4,a5
    80002544:	fc0792e3          	bnez	a5,80002508 <_ZL8producerPv+0x2c>
    80002548:	fb9ff06f          	j	80002500 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    8000254c:	0104b503          	ld	a0,16(s1)
    80002550:	fffff097          	auipc	ra,0xfffff
    80002554:	d98080e7          	jalr	-616(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80002558:	01813083          	ld	ra,24(sp)
    8000255c:	01013403          	ld	s0,16(sp)
    80002560:	00813483          	ld	s1,8(sp)
    80002564:	00013903          	ld	s2,0(sp)
    80002568:	02010113          	addi	sp,sp,32
    8000256c:	00008067          	ret

0000000080002570 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002570:	fd010113          	addi	sp,sp,-48
    80002574:	02113423          	sd	ra,40(sp)
    80002578:	02813023          	sd	s0,32(sp)
    8000257c:	00913c23          	sd	s1,24(sp)
    80002580:	01213823          	sd	s2,16(sp)
    80002584:	01313423          	sd	s3,8(sp)
    80002588:	03010413          	addi	s0,sp,48
    8000258c:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002590:	00000993          	li	s3,0
    80002594:	01c0006f          	j	800025b0 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002598:	fffff097          	auipc	ra,0xfffff
    8000259c:	ca8080e7          	jalr	-856(ra) # 80001240 <_Z15thread_dispatchv>
    800025a0:	0500006f          	j	800025f0 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800025a4:	00a00513          	li	a0,10
    800025a8:	fffff097          	auipc	ra,0xfffff
    800025ac:	d98080e7          	jalr	-616(ra) # 80001340 <_Z4putcc>
    while (!threadEnd) {
    800025b0:	00008797          	auipc	a5,0x8
    800025b4:	be87a783          	lw	a5,-1048(a5) # 8000a198 <_ZL9threadEnd>
    800025b8:	06079063          	bnez	a5,80002618 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800025bc:	00893503          	ld	a0,8(s2)
    800025c0:	00003097          	auipc	ra,0x3
    800025c4:	93c080e7          	jalr	-1732(ra) # 80004efc <_ZN6Buffer3getEv>
        i++;
    800025c8:	0019849b          	addiw	s1,s3,1
    800025cc:	0004899b          	sext.w	s3,s1
        putc(key);
    800025d0:	0ff57513          	andi	a0,a0,255
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	d6c080e7          	jalr	-660(ra) # 80001340 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800025dc:	00092703          	lw	a4,0(s2)
    800025e0:	0027179b          	slliw	a5,a4,0x2
    800025e4:	00e787bb          	addw	a5,a5,a4
    800025e8:	02f4e7bb          	remw	a5,s1,a5
    800025ec:	fa0786e3          	beqz	a5,80002598 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800025f0:	05000793          	li	a5,80
    800025f4:	02f4e4bb          	remw	s1,s1,a5
    800025f8:	fa049ce3          	bnez	s1,800025b0 <_ZL8consumerPv+0x40>
    800025fc:	fa9ff06f          	j	800025a4 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002600:	00893503          	ld	a0,8(s2)
    80002604:	00003097          	auipc	ra,0x3
    80002608:	8f8080e7          	jalr	-1800(ra) # 80004efc <_ZN6Buffer3getEv>
        putc(key);
    8000260c:	0ff57513          	andi	a0,a0,255
    80002610:	fffff097          	auipc	ra,0xfffff
    80002614:	d30080e7          	jalr	-720(ra) # 80001340 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002618:	00893503          	ld	a0,8(s2)
    8000261c:	00003097          	auipc	ra,0x3
    80002620:	96c080e7          	jalr	-1684(ra) # 80004f88 <_ZN6Buffer6getCntEv>
    80002624:	fca04ee3          	bgtz	a0,80002600 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002628:	01093503          	ld	a0,16(s2)
    8000262c:	fffff097          	auipc	ra,0xfffff
    80002630:	cbc080e7          	jalr	-836(ra) # 800012e8 <_Z10sem_signalP4_sem>
}
    80002634:	02813083          	ld	ra,40(sp)
    80002638:	02013403          	ld	s0,32(sp)
    8000263c:	01813483          	ld	s1,24(sp)
    80002640:	01013903          	ld	s2,16(sp)
    80002644:	00813983          	ld	s3,8(sp)
    80002648:	03010113          	addi	sp,sp,48
    8000264c:	00008067          	ret

0000000080002650 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002650:	f9010113          	addi	sp,sp,-112
    80002654:	06113423          	sd	ra,104(sp)
    80002658:	06813023          	sd	s0,96(sp)
    8000265c:	04913c23          	sd	s1,88(sp)
    80002660:	05213823          	sd	s2,80(sp)
    80002664:	05313423          	sd	s3,72(sp)
    80002668:	05413023          	sd	s4,64(sp)
    8000266c:	03513c23          	sd	s5,56(sp)
    80002670:	03613823          	sd	s6,48(sp)
    80002674:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002678:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    8000267c:	00006517          	auipc	a0,0x6
    80002680:	d5450513          	addi	a0,a0,-684 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80002684:	00002097          	auipc	ra,0x2
    80002688:	a9c080e7          	jalr	-1380(ra) # 80004120 <_Z11printStringPKc>
    getString(input, 30);
    8000268c:	01e00593          	li	a1,30
    80002690:	fa040493          	addi	s1,s0,-96
    80002694:	00048513          	mv	a0,s1
    80002698:	00002097          	auipc	ra,0x2
    8000269c:	b10080e7          	jalr	-1264(ra) # 800041a8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800026a0:	00048513          	mv	a0,s1
    800026a4:	00002097          	auipc	ra,0x2
    800026a8:	bdc080e7          	jalr	-1060(ra) # 80004280 <_Z11stringToIntPKc>
    800026ac:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800026b0:	00006517          	auipc	a0,0x6
    800026b4:	d4050513          	addi	a0,a0,-704 # 800083f0 <CONSOLE_STATUS+0x3e0>
    800026b8:	00002097          	auipc	ra,0x2
    800026bc:	a68080e7          	jalr	-1432(ra) # 80004120 <_Z11printStringPKc>
    getString(input, 30);
    800026c0:	01e00593          	li	a1,30
    800026c4:	00048513          	mv	a0,s1
    800026c8:	00002097          	auipc	ra,0x2
    800026cc:	ae0080e7          	jalr	-1312(ra) # 800041a8 <_Z9getStringPci>
    n = stringToInt(input);
    800026d0:	00048513          	mv	a0,s1
    800026d4:	00002097          	auipc	ra,0x2
    800026d8:	bac080e7          	jalr	-1108(ra) # 80004280 <_Z11stringToIntPKc>
    800026dc:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800026e0:	00006517          	auipc	a0,0x6
    800026e4:	d3050513          	addi	a0,a0,-720 # 80008410 <CONSOLE_STATUS+0x400>
    800026e8:	00002097          	auipc	ra,0x2
    800026ec:	a38080e7          	jalr	-1480(ra) # 80004120 <_Z11printStringPKc>
    800026f0:	00000613          	li	a2,0
    800026f4:	00a00593          	li	a1,10
    800026f8:	00090513          	mv	a0,s2
    800026fc:	00002097          	auipc	ra,0x2
    80002700:	bd4080e7          	jalr	-1068(ra) # 800042d0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002704:	00006517          	auipc	a0,0x6
    80002708:	d2450513          	addi	a0,a0,-732 # 80008428 <CONSOLE_STATUS+0x418>
    8000270c:	00002097          	auipc	ra,0x2
    80002710:	a14080e7          	jalr	-1516(ra) # 80004120 <_Z11printStringPKc>
    80002714:	00000613          	li	a2,0
    80002718:	00a00593          	li	a1,10
    8000271c:	00048513          	mv	a0,s1
    80002720:	00002097          	auipc	ra,0x2
    80002724:	bb0080e7          	jalr	-1104(ra) # 800042d0 <_Z8printIntiii>
    printString(".\n");
    80002728:	00006517          	auipc	a0,0x6
    8000272c:	d1850513          	addi	a0,a0,-744 # 80008440 <CONSOLE_STATUS+0x430>
    80002730:	00002097          	auipc	ra,0x2
    80002734:	9f0080e7          	jalr	-1552(ra) # 80004120 <_Z11printStringPKc>
    if(threadNum > n) {
    80002738:	0324c463          	blt	s1,s2,80002760 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    8000273c:	03205c63          	blez	s2,80002774 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002740:	03800513          	li	a0,56
    80002744:	fffff097          	auipc	ra,0xfffff
    80002748:	08c080e7          	jalr	140(ra) # 800017d0 <_Znwm>
    8000274c:	00050a13          	mv	s4,a0
    80002750:	00048593          	mv	a1,s1
    80002754:	00002097          	auipc	ra,0x2
    80002758:	67c080e7          	jalr	1660(ra) # 80004dd0 <_ZN6BufferC1Ei>
    8000275c:	0300006f          	j	8000278c <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002760:	00006517          	auipc	a0,0x6
    80002764:	ce850513          	addi	a0,a0,-792 # 80008448 <CONSOLE_STATUS+0x438>
    80002768:	00002097          	auipc	ra,0x2
    8000276c:	9b8080e7          	jalr	-1608(ra) # 80004120 <_Z11printStringPKc>
        return;
    80002770:	0140006f          	j	80002784 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002774:	00006517          	auipc	a0,0x6
    80002778:	d1450513          	addi	a0,a0,-748 # 80008488 <CONSOLE_STATUS+0x478>
    8000277c:	00002097          	auipc	ra,0x2
    80002780:	9a4080e7          	jalr	-1628(ra) # 80004120 <_Z11printStringPKc>
        return;
    80002784:	000b0113          	mv	sp,s6
    80002788:	1500006f          	j	800028d8 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    8000278c:	00000593          	li	a1,0
    80002790:	00008517          	auipc	a0,0x8
    80002794:	a1050513          	addi	a0,a0,-1520 # 8000a1a0 <_ZL10waitForAll>
    80002798:	fffff097          	auipc	ra,0xfffff
    8000279c:	acc080e7          	jalr	-1332(ra) # 80001264 <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    800027a0:	00391793          	slli	a5,s2,0x3
    800027a4:	00f78793          	addi	a5,a5,15
    800027a8:	ff07f793          	andi	a5,a5,-16
    800027ac:	40f10133          	sub	sp,sp,a5
    800027b0:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800027b4:	0019071b          	addiw	a4,s2,1
    800027b8:	00171793          	slli	a5,a4,0x1
    800027bc:	00e787b3          	add	a5,a5,a4
    800027c0:	00379793          	slli	a5,a5,0x3
    800027c4:	00f78793          	addi	a5,a5,15
    800027c8:	ff07f793          	andi	a5,a5,-16
    800027cc:	40f10133          	sub	sp,sp,a5
    800027d0:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800027d4:	00191613          	slli	a2,s2,0x1
    800027d8:	012607b3          	add	a5,a2,s2
    800027dc:	00379793          	slli	a5,a5,0x3
    800027e0:	00f987b3          	add	a5,s3,a5
    800027e4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800027e8:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800027ec:	00008717          	auipc	a4,0x8
    800027f0:	9b473703          	ld	a4,-1612(a4) # 8000a1a0 <_ZL10waitForAll>
    800027f4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800027f8:	00078613          	mv	a2,a5
    800027fc:	00000597          	auipc	a1,0x0
    80002800:	d7458593          	addi	a1,a1,-652 # 80002570 <_ZL8consumerPv>
    80002804:	f9840513          	addi	a0,s0,-104
    80002808:	fffff097          	auipc	ra,0xfffff
    8000280c:	9e0080e7          	jalr	-1568(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002810:	00000493          	li	s1,0
    80002814:	0280006f          	j	8000283c <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002818:	00000597          	auipc	a1,0x0
    8000281c:	c1458593          	addi	a1,a1,-1004 # 8000242c <_ZL16producerKeyboardPv>
                      data + i);
    80002820:	00179613          	slli	a2,a5,0x1
    80002824:	00f60633          	add	a2,a2,a5
    80002828:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    8000282c:	00c98633          	add	a2,s3,a2
    80002830:	fffff097          	auipc	ra,0xfffff
    80002834:	9b8080e7          	jalr	-1608(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002838:	0014849b          	addiw	s1,s1,1
    8000283c:	0524d263          	bge	s1,s2,80002880 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002840:	00149793          	slli	a5,s1,0x1
    80002844:	009787b3          	add	a5,a5,s1
    80002848:	00379793          	slli	a5,a5,0x3
    8000284c:	00f987b3          	add	a5,s3,a5
    80002850:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002854:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002858:	00008717          	auipc	a4,0x8
    8000285c:	94873703          	ld	a4,-1720(a4) # 8000a1a0 <_ZL10waitForAll>
    80002860:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002864:	00048793          	mv	a5,s1
    80002868:	00349513          	slli	a0,s1,0x3
    8000286c:	00aa8533          	add	a0,s5,a0
    80002870:	fa9054e3          	blez	s1,80002818 <_Z22producerConsumer_C_APIv+0x1c8>
    80002874:	00000597          	auipc	a1,0x0
    80002878:	c6858593          	addi	a1,a1,-920 # 800024dc <_ZL8producerPv>
    8000287c:	fa5ff06f          	j	80002820 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002880:	fffff097          	auipc	ra,0xfffff
    80002884:	9c0080e7          	jalr	-1600(ra) # 80001240 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002888:	00000493          	li	s1,0
    8000288c:	00994e63          	blt	s2,s1,800028a8 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002890:	00008517          	auipc	a0,0x8
    80002894:	91053503          	ld	a0,-1776(a0) # 8000a1a0 <_ZL10waitForAll>
    80002898:	fffff097          	auipc	ra,0xfffff
    8000289c:	a24080e7          	jalr	-1500(ra) # 800012bc <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    800028a0:	0014849b          	addiw	s1,s1,1
    800028a4:	fe9ff06f          	j	8000288c <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800028a8:	00008517          	auipc	a0,0x8
    800028ac:	8f853503          	ld	a0,-1800(a0) # 8000a1a0 <_ZL10waitForAll>
    800028b0:	fffff097          	auipc	ra,0xfffff
    800028b4:	9e0080e7          	jalr	-1568(ra) # 80001290 <_Z9sem_closeP4_sem>
    delete buffer;
    800028b8:	000a0e63          	beqz	s4,800028d4 <_Z22producerConsumer_C_APIv+0x284>
    800028bc:	000a0513          	mv	a0,s4
    800028c0:	00002097          	auipc	ra,0x2
    800028c4:	750080e7          	jalr	1872(ra) # 80005010 <_ZN6BufferD1Ev>
    800028c8:	000a0513          	mv	a0,s4
    800028cc:	fffff097          	auipc	ra,0xfffff
    800028d0:	f54080e7          	jalr	-172(ra) # 80001820 <_ZdlPv>
    800028d4:	000b0113          	mv	sp,s6

}
    800028d8:	f9040113          	addi	sp,s0,-112
    800028dc:	06813083          	ld	ra,104(sp)
    800028e0:	06013403          	ld	s0,96(sp)
    800028e4:	05813483          	ld	s1,88(sp)
    800028e8:	05013903          	ld	s2,80(sp)
    800028ec:	04813983          	ld	s3,72(sp)
    800028f0:	04013a03          	ld	s4,64(sp)
    800028f4:	03813a83          	ld	s5,56(sp)
    800028f8:	03013b03          	ld	s6,48(sp)
    800028fc:	07010113          	addi	sp,sp,112
    80002900:	00008067          	ret
    80002904:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80002908:	000a0513          	mv	a0,s4
    8000290c:	fffff097          	auipc	ra,0xfffff
    80002910:	f14080e7          	jalr	-236(ra) # 80001820 <_ZdlPv>
    80002914:	00048513          	mv	a0,s1
    80002918:	00009097          	auipc	ra,0x9
    8000291c:	980080e7          	jalr	-1664(ra) # 8000b298 <_Unwind_Resume>

0000000080002920 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002920:	fe010113          	addi	sp,sp,-32
    80002924:	00113c23          	sd	ra,24(sp)
    80002928:	00813823          	sd	s0,16(sp)
    8000292c:	00913423          	sd	s1,8(sp)
    80002930:	01213023          	sd	s2,0(sp)
    80002934:	02010413          	addi	s0,sp,32
    80002938:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000293c:	00100793          	li	a5,1
    80002940:	02a7f863          	bgeu	a5,a0,80002970 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002944:	00a00793          	li	a5,10
    80002948:	02f577b3          	remu	a5,a0,a5
    8000294c:	02078e63          	beqz	a5,80002988 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002950:	fff48513          	addi	a0,s1,-1
    80002954:	00000097          	auipc	ra,0x0
    80002958:	fcc080e7          	jalr	-52(ra) # 80002920 <_ZL9fibonaccim>
    8000295c:	00050913          	mv	s2,a0
    80002960:	ffe48513          	addi	a0,s1,-2
    80002964:	00000097          	auipc	ra,0x0
    80002968:	fbc080e7          	jalr	-68(ra) # 80002920 <_ZL9fibonaccim>
    8000296c:	00a90533          	add	a0,s2,a0
}
    80002970:	01813083          	ld	ra,24(sp)
    80002974:	01013403          	ld	s0,16(sp)
    80002978:	00813483          	ld	s1,8(sp)
    8000297c:	00013903          	ld	s2,0(sp)
    80002980:	02010113          	addi	sp,sp,32
    80002984:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002988:	fffff097          	auipc	ra,0xfffff
    8000298c:	8b8080e7          	jalr	-1864(ra) # 80001240 <_Z15thread_dispatchv>
    80002990:	fc1ff06f          	j	80002950 <_ZL9fibonaccim+0x30>

0000000080002994 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002994:	fe010113          	addi	sp,sp,-32
    80002998:	00113c23          	sd	ra,24(sp)
    8000299c:	00813823          	sd	s0,16(sp)
    800029a0:	00913423          	sd	s1,8(sp)
    800029a4:	01213023          	sd	s2,0(sp)
    800029a8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800029ac:	00000913          	li	s2,0
    800029b0:	0380006f          	j	800029e8 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800029b4:	fffff097          	auipc	ra,0xfffff
    800029b8:	88c080e7          	jalr	-1908(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800029bc:	00148493          	addi	s1,s1,1
    800029c0:	000027b7          	lui	a5,0x2
    800029c4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800029c8:	0097ee63          	bltu	a5,s1,800029e4 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800029cc:	00000713          	li	a4,0
    800029d0:	000077b7          	lui	a5,0x7
    800029d4:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800029d8:	fce7eee3          	bltu	a5,a4,800029b4 <_ZN7WorkerA11workerBodyAEPv+0x20>
    800029dc:	00170713          	addi	a4,a4,1
    800029e0:	ff1ff06f          	j	800029d0 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800029e4:	00190913          	addi	s2,s2,1
    800029e8:	00900793          	li	a5,9
    800029ec:	0527e063          	bltu	a5,s2,80002a2c <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800029f0:	00006517          	auipc	a0,0x6
    800029f4:	ac850513          	addi	a0,a0,-1336 # 800084b8 <CONSOLE_STATUS+0x4a8>
    800029f8:	00001097          	auipc	ra,0x1
    800029fc:	728080e7          	jalr	1832(ra) # 80004120 <_Z11printStringPKc>
    80002a00:	00000613          	li	a2,0
    80002a04:	00a00593          	li	a1,10
    80002a08:	0009051b          	sext.w	a0,s2
    80002a0c:	00002097          	auipc	ra,0x2
    80002a10:	8c4080e7          	jalr	-1852(ra) # 800042d0 <_Z8printIntiii>
    80002a14:	00005517          	auipc	a0,0x5
    80002a18:	79450513          	addi	a0,a0,1940 # 800081a8 <CONSOLE_STATUS+0x198>
    80002a1c:	00001097          	auipc	ra,0x1
    80002a20:	704080e7          	jalr	1796(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002a24:	00000493          	li	s1,0
    80002a28:	f99ff06f          	j	800029c0 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002a2c:	00006517          	auipc	a0,0x6
    80002a30:	a9450513          	addi	a0,a0,-1388 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80002a34:	00001097          	auipc	ra,0x1
    80002a38:	6ec080e7          	jalr	1772(ra) # 80004120 <_Z11printStringPKc>
    finishedA = true;
    80002a3c:	00100793          	li	a5,1
    80002a40:	00007717          	auipc	a4,0x7
    80002a44:	76f70423          	sb	a5,1896(a4) # 8000a1a8 <_ZL9finishedA>
}
    80002a48:	01813083          	ld	ra,24(sp)
    80002a4c:	01013403          	ld	s0,16(sp)
    80002a50:	00813483          	ld	s1,8(sp)
    80002a54:	00013903          	ld	s2,0(sp)
    80002a58:	02010113          	addi	sp,sp,32
    80002a5c:	00008067          	ret

0000000080002a60 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80002a60:	fe010113          	addi	sp,sp,-32
    80002a64:	00113c23          	sd	ra,24(sp)
    80002a68:	00813823          	sd	s0,16(sp)
    80002a6c:	00913423          	sd	s1,8(sp)
    80002a70:	01213023          	sd	s2,0(sp)
    80002a74:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002a78:	00000913          	li	s2,0
    80002a7c:	0380006f          	j	80002ab4 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002a80:	ffffe097          	auipc	ra,0xffffe
    80002a84:	7c0080e7          	jalr	1984(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002a88:	00148493          	addi	s1,s1,1
    80002a8c:	000027b7          	lui	a5,0x2
    80002a90:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002a94:	0097ee63          	bltu	a5,s1,80002ab0 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002a98:	00000713          	li	a4,0
    80002a9c:	000077b7          	lui	a5,0x7
    80002aa0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002aa4:	fce7eee3          	bltu	a5,a4,80002a80 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80002aa8:	00170713          	addi	a4,a4,1
    80002aac:	ff1ff06f          	j	80002a9c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80002ab0:	00190913          	addi	s2,s2,1
    80002ab4:	00f00793          	li	a5,15
    80002ab8:	0527e063          	bltu	a5,s2,80002af8 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002abc:	00006517          	auipc	a0,0x6
    80002ac0:	a1450513          	addi	a0,a0,-1516 # 800084d0 <CONSOLE_STATUS+0x4c0>
    80002ac4:	00001097          	auipc	ra,0x1
    80002ac8:	65c080e7          	jalr	1628(ra) # 80004120 <_Z11printStringPKc>
    80002acc:	00000613          	li	a2,0
    80002ad0:	00a00593          	li	a1,10
    80002ad4:	0009051b          	sext.w	a0,s2
    80002ad8:	00001097          	auipc	ra,0x1
    80002adc:	7f8080e7          	jalr	2040(ra) # 800042d0 <_Z8printIntiii>
    80002ae0:	00005517          	auipc	a0,0x5
    80002ae4:	6c850513          	addi	a0,a0,1736 # 800081a8 <CONSOLE_STATUS+0x198>
    80002ae8:	00001097          	auipc	ra,0x1
    80002aec:	638080e7          	jalr	1592(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002af0:	00000493          	li	s1,0
    80002af4:	f99ff06f          	j	80002a8c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80002af8:	00006517          	auipc	a0,0x6
    80002afc:	9e050513          	addi	a0,a0,-1568 # 800084d8 <CONSOLE_STATUS+0x4c8>
    80002b00:	00001097          	auipc	ra,0x1
    80002b04:	620080e7          	jalr	1568(ra) # 80004120 <_Z11printStringPKc>
    finishedB = true;
    80002b08:	00100793          	li	a5,1
    80002b0c:	00007717          	auipc	a4,0x7
    80002b10:	68f70ea3          	sb	a5,1693(a4) # 8000a1a9 <_ZL9finishedB>
    thread_dispatch();
    80002b14:	ffffe097          	auipc	ra,0xffffe
    80002b18:	72c080e7          	jalr	1836(ra) # 80001240 <_Z15thread_dispatchv>
}
    80002b1c:	01813083          	ld	ra,24(sp)
    80002b20:	01013403          	ld	s0,16(sp)
    80002b24:	00813483          	ld	s1,8(sp)
    80002b28:	00013903          	ld	s2,0(sp)
    80002b2c:	02010113          	addi	sp,sp,32
    80002b30:	00008067          	ret

0000000080002b34 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002b34:	fe010113          	addi	sp,sp,-32
    80002b38:	00113c23          	sd	ra,24(sp)
    80002b3c:	00813823          	sd	s0,16(sp)
    80002b40:	00913423          	sd	s1,8(sp)
    80002b44:	01213023          	sd	s2,0(sp)
    80002b48:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002b4c:	00000493          	li	s1,0
    80002b50:	0400006f          	j	80002b90 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002b54:	00006517          	auipc	a0,0x6
    80002b58:	99450513          	addi	a0,a0,-1644 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80002b5c:	00001097          	auipc	ra,0x1
    80002b60:	5c4080e7          	jalr	1476(ra) # 80004120 <_Z11printStringPKc>
    80002b64:	00000613          	li	a2,0
    80002b68:	00a00593          	li	a1,10
    80002b6c:	00048513          	mv	a0,s1
    80002b70:	00001097          	auipc	ra,0x1
    80002b74:	760080e7          	jalr	1888(ra) # 800042d0 <_Z8printIntiii>
    80002b78:	00005517          	auipc	a0,0x5
    80002b7c:	63050513          	addi	a0,a0,1584 # 800081a8 <CONSOLE_STATUS+0x198>
    80002b80:	00001097          	auipc	ra,0x1
    80002b84:	5a0080e7          	jalr	1440(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002b88:	0014849b          	addiw	s1,s1,1
    80002b8c:	0ff4f493          	andi	s1,s1,255
    80002b90:	00200793          	li	a5,2
    80002b94:	fc97f0e3          	bgeu	a5,s1,80002b54 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002b98:	00006517          	auipc	a0,0x6
    80002b9c:	95850513          	addi	a0,a0,-1704 # 800084f0 <CONSOLE_STATUS+0x4e0>
    80002ba0:	00001097          	auipc	ra,0x1
    80002ba4:	580080e7          	jalr	1408(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002ba8:	00700313          	li	t1,7
    thread_dispatch();
    80002bac:	ffffe097          	auipc	ra,0xffffe
    80002bb0:	694080e7          	jalr	1684(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002bb4:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80002bb8:	00006517          	auipc	a0,0x6
    80002bbc:	94850513          	addi	a0,a0,-1720 # 80008500 <CONSOLE_STATUS+0x4f0>
    80002bc0:	00001097          	auipc	ra,0x1
    80002bc4:	560080e7          	jalr	1376(ra) # 80004120 <_Z11printStringPKc>
    80002bc8:	00000613          	li	a2,0
    80002bcc:	00a00593          	li	a1,10
    80002bd0:	0009051b          	sext.w	a0,s2
    80002bd4:	00001097          	auipc	ra,0x1
    80002bd8:	6fc080e7          	jalr	1788(ra) # 800042d0 <_Z8printIntiii>
    80002bdc:	00005517          	auipc	a0,0x5
    80002be0:	5cc50513          	addi	a0,a0,1484 # 800081a8 <CONSOLE_STATUS+0x198>
    80002be4:	00001097          	auipc	ra,0x1
    80002be8:	53c080e7          	jalr	1340(ra) # 80004120 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80002bec:	00c00513          	li	a0,12
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	d30080e7          	jalr	-720(ra) # 80002920 <_ZL9fibonaccim>
    80002bf8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80002bfc:	00006517          	auipc	a0,0x6
    80002c00:	90c50513          	addi	a0,a0,-1780 # 80008508 <CONSOLE_STATUS+0x4f8>
    80002c04:	00001097          	auipc	ra,0x1
    80002c08:	51c080e7          	jalr	1308(ra) # 80004120 <_Z11printStringPKc>
    80002c0c:	00000613          	li	a2,0
    80002c10:	00a00593          	li	a1,10
    80002c14:	0009051b          	sext.w	a0,s2
    80002c18:	00001097          	auipc	ra,0x1
    80002c1c:	6b8080e7          	jalr	1720(ra) # 800042d0 <_Z8printIntiii>
    80002c20:	00005517          	auipc	a0,0x5
    80002c24:	58850513          	addi	a0,a0,1416 # 800081a8 <CONSOLE_STATUS+0x198>
    80002c28:	00001097          	auipc	ra,0x1
    80002c2c:	4f8080e7          	jalr	1272(ra) # 80004120 <_Z11printStringPKc>
    80002c30:	0400006f          	j	80002c70 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002c34:	00006517          	auipc	a0,0x6
    80002c38:	8b450513          	addi	a0,a0,-1868 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80002c3c:	00001097          	auipc	ra,0x1
    80002c40:	4e4080e7          	jalr	1252(ra) # 80004120 <_Z11printStringPKc>
    80002c44:	00000613          	li	a2,0
    80002c48:	00a00593          	li	a1,10
    80002c4c:	00048513          	mv	a0,s1
    80002c50:	00001097          	auipc	ra,0x1
    80002c54:	680080e7          	jalr	1664(ra) # 800042d0 <_Z8printIntiii>
    80002c58:	00005517          	auipc	a0,0x5
    80002c5c:	55050513          	addi	a0,a0,1360 # 800081a8 <CONSOLE_STATUS+0x198>
    80002c60:	00001097          	auipc	ra,0x1
    80002c64:	4c0080e7          	jalr	1216(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002c68:	0014849b          	addiw	s1,s1,1
    80002c6c:	0ff4f493          	andi	s1,s1,255
    80002c70:	00500793          	li	a5,5
    80002c74:	fc97f0e3          	bgeu	a5,s1,80002c34 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002c78:	00006517          	auipc	a0,0x6
    80002c7c:	84850513          	addi	a0,a0,-1976 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80002c80:	00001097          	auipc	ra,0x1
    80002c84:	4a0080e7          	jalr	1184(ra) # 80004120 <_Z11printStringPKc>
    finishedC = true;
    80002c88:	00100793          	li	a5,1
    80002c8c:	00007717          	auipc	a4,0x7
    80002c90:	50f70f23          	sb	a5,1310(a4) # 8000a1aa <_ZL9finishedC>
    thread_dispatch();
    80002c94:	ffffe097          	auipc	ra,0xffffe
    80002c98:	5ac080e7          	jalr	1452(ra) # 80001240 <_Z15thread_dispatchv>
}
    80002c9c:	01813083          	ld	ra,24(sp)
    80002ca0:	01013403          	ld	s0,16(sp)
    80002ca4:	00813483          	ld	s1,8(sp)
    80002ca8:	00013903          	ld	s2,0(sp)
    80002cac:	02010113          	addi	sp,sp,32
    80002cb0:	00008067          	ret

0000000080002cb4 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002cb4:	fe010113          	addi	sp,sp,-32
    80002cb8:	00113c23          	sd	ra,24(sp)
    80002cbc:	00813823          	sd	s0,16(sp)
    80002cc0:	00913423          	sd	s1,8(sp)
    80002cc4:	01213023          	sd	s2,0(sp)
    80002cc8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80002ccc:	00a00493          	li	s1,10
    80002cd0:	0400006f          	j	80002d10 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002cd4:	00006517          	auipc	a0,0x6
    80002cd8:	84450513          	addi	a0,a0,-1980 # 80008518 <CONSOLE_STATUS+0x508>
    80002cdc:	00001097          	auipc	ra,0x1
    80002ce0:	444080e7          	jalr	1092(ra) # 80004120 <_Z11printStringPKc>
    80002ce4:	00000613          	li	a2,0
    80002ce8:	00a00593          	li	a1,10
    80002cec:	00048513          	mv	a0,s1
    80002cf0:	00001097          	auipc	ra,0x1
    80002cf4:	5e0080e7          	jalr	1504(ra) # 800042d0 <_Z8printIntiii>
    80002cf8:	00005517          	auipc	a0,0x5
    80002cfc:	4b050513          	addi	a0,a0,1200 # 800081a8 <CONSOLE_STATUS+0x198>
    80002d00:	00001097          	auipc	ra,0x1
    80002d04:	420080e7          	jalr	1056(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80002d08:	0014849b          	addiw	s1,s1,1
    80002d0c:	0ff4f493          	andi	s1,s1,255
    80002d10:	00c00793          	li	a5,12
    80002d14:	fc97f0e3          	bgeu	a5,s1,80002cd4 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80002d18:	00006517          	auipc	a0,0x6
    80002d1c:	80850513          	addi	a0,a0,-2040 # 80008520 <CONSOLE_STATUS+0x510>
    80002d20:	00001097          	auipc	ra,0x1
    80002d24:	400080e7          	jalr	1024(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002d28:	00500313          	li	t1,5
    thread_dispatch();
    80002d2c:	ffffe097          	auipc	ra,0xffffe
    80002d30:	514080e7          	jalr	1300(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002d34:	01000513          	li	a0,16
    80002d38:	00000097          	auipc	ra,0x0
    80002d3c:	be8080e7          	jalr	-1048(ra) # 80002920 <_ZL9fibonaccim>
    80002d40:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002d44:	00005517          	auipc	a0,0x5
    80002d48:	7ec50513          	addi	a0,a0,2028 # 80008530 <CONSOLE_STATUS+0x520>
    80002d4c:	00001097          	auipc	ra,0x1
    80002d50:	3d4080e7          	jalr	980(ra) # 80004120 <_Z11printStringPKc>
    80002d54:	00000613          	li	a2,0
    80002d58:	00a00593          	li	a1,10
    80002d5c:	0009051b          	sext.w	a0,s2
    80002d60:	00001097          	auipc	ra,0x1
    80002d64:	570080e7          	jalr	1392(ra) # 800042d0 <_Z8printIntiii>
    80002d68:	00005517          	auipc	a0,0x5
    80002d6c:	44050513          	addi	a0,a0,1088 # 800081a8 <CONSOLE_STATUS+0x198>
    80002d70:	00001097          	auipc	ra,0x1
    80002d74:	3b0080e7          	jalr	944(ra) # 80004120 <_Z11printStringPKc>
    80002d78:	0400006f          	j	80002db8 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002d7c:	00005517          	auipc	a0,0x5
    80002d80:	79c50513          	addi	a0,a0,1948 # 80008518 <CONSOLE_STATUS+0x508>
    80002d84:	00001097          	auipc	ra,0x1
    80002d88:	39c080e7          	jalr	924(ra) # 80004120 <_Z11printStringPKc>
    80002d8c:	00000613          	li	a2,0
    80002d90:	00a00593          	li	a1,10
    80002d94:	00048513          	mv	a0,s1
    80002d98:	00001097          	auipc	ra,0x1
    80002d9c:	538080e7          	jalr	1336(ra) # 800042d0 <_Z8printIntiii>
    80002da0:	00005517          	auipc	a0,0x5
    80002da4:	40850513          	addi	a0,a0,1032 # 800081a8 <CONSOLE_STATUS+0x198>
    80002da8:	00001097          	auipc	ra,0x1
    80002dac:	378080e7          	jalr	888(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002db0:	0014849b          	addiw	s1,s1,1
    80002db4:	0ff4f493          	andi	s1,s1,255
    80002db8:	00f00793          	li	a5,15
    80002dbc:	fc97f0e3          	bgeu	a5,s1,80002d7c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002dc0:	00005517          	auipc	a0,0x5
    80002dc4:	78050513          	addi	a0,a0,1920 # 80008540 <CONSOLE_STATUS+0x530>
    80002dc8:	00001097          	auipc	ra,0x1
    80002dcc:	358080e7          	jalr	856(ra) # 80004120 <_Z11printStringPKc>
    finishedD = true;
    80002dd0:	00100793          	li	a5,1
    80002dd4:	00007717          	auipc	a4,0x7
    80002dd8:	3cf70ba3          	sb	a5,983(a4) # 8000a1ab <_ZL9finishedD>
    thread_dispatch();
    80002ddc:	ffffe097          	auipc	ra,0xffffe
    80002de0:	464080e7          	jalr	1124(ra) # 80001240 <_Z15thread_dispatchv>
}
    80002de4:	01813083          	ld	ra,24(sp)
    80002de8:	01013403          	ld	s0,16(sp)
    80002dec:	00813483          	ld	s1,8(sp)
    80002df0:	00013903          	ld	s2,0(sp)
    80002df4:	02010113          	addi	sp,sp,32
    80002df8:	00008067          	ret

0000000080002dfc <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002dfc:	fc010113          	addi	sp,sp,-64
    80002e00:	02113c23          	sd	ra,56(sp)
    80002e04:	02813823          	sd	s0,48(sp)
    80002e08:	02913423          	sd	s1,40(sp)
    80002e0c:	03213023          	sd	s2,32(sp)
    80002e10:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002e14:	02000513          	li	a0,32
    80002e18:	fffff097          	auipc	ra,0xfffff
    80002e1c:	9b8080e7          	jalr	-1608(ra) # 800017d0 <_Znwm>
    80002e20:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80002e24:	fffff097          	auipc	ra,0xfffff
    80002e28:	c30080e7          	jalr	-976(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80002e2c:	00007797          	auipc	a5,0x7
    80002e30:	1a478793          	addi	a5,a5,420 # 80009fd0 <_ZTV7WorkerA+0x10>
    80002e34:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80002e38:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80002e3c:	00005517          	auipc	a0,0x5
    80002e40:	71450513          	addi	a0,a0,1812 # 80008550 <CONSOLE_STATUS+0x540>
    80002e44:	00001097          	auipc	ra,0x1
    80002e48:	2dc080e7          	jalr	732(ra) # 80004120 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002e4c:	02000513          	li	a0,32
    80002e50:	fffff097          	auipc	ra,0xfffff
    80002e54:	980080e7          	jalr	-1664(ra) # 800017d0 <_Znwm>
    80002e58:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80002e5c:	fffff097          	auipc	ra,0xfffff
    80002e60:	bf8080e7          	jalr	-1032(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80002e64:	00007797          	auipc	a5,0x7
    80002e68:	19478793          	addi	a5,a5,404 # 80009ff8 <_ZTV7WorkerB+0x10>
    80002e6c:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80002e70:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80002e74:	00005517          	auipc	a0,0x5
    80002e78:	6f450513          	addi	a0,a0,1780 # 80008568 <CONSOLE_STATUS+0x558>
    80002e7c:	00001097          	auipc	ra,0x1
    80002e80:	2a4080e7          	jalr	676(ra) # 80004120 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002e84:	02000513          	li	a0,32
    80002e88:	fffff097          	auipc	ra,0xfffff
    80002e8c:	948080e7          	jalr	-1720(ra) # 800017d0 <_Znwm>
    80002e90:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80002e94:	fffff097          	auipc	ra,0xfffff
    80002e98:	bc0080e7          	jalr	-1088(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80002e9c:	00007797          	auipc	a5,0x7
    80002ea0:	18478793          	addi	a5,a5,388 # 8000a020 <_ZTV7WorkerC+0x10>
    80002ea4:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80002ea8:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80002eac:	00005517          	auipc	a0,0x5
    80002eb0:	6d450513          	addi	a0,a0,1748 # 80008580 <CONSOLE_STATUS+0x570>
    80002eb4:	00001097          	auipc	ra,0x1
    80002eb8:	26c080e7          	jalr	620(ra) # 80004120 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002ebc:	02000513          	li	a0,32
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	910080e7          	jalr	-1776(ra) # 800017d0 <_Znwm>
    80002ec8:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80002ecc:	fffff097          	auipc	ra,0xfffff
    80002ed0:	b88080e7          	jalr	-1144(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80002ed4:	00007797          	auipc	a5,0x7
    80002ed8:	17478793          	addi	a5,a5,372 # 8000a048 <_ZTV7WorkerD+0x10>
    80002edc:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80002ee0:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80002ee4:	00005517          	auipc	a0,0x5
    80002ee8:	6b450513          	addi	a0,a0,1716 # 80008598 <CONSOLE_STATUS+0x588>
    80002eec:	00001097          	auipc	ra,0x1
    80002ef0:	234080e7          	jalr	564(ra) # 80004120 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002ef4:	00000493          	li	s1,0
    80002ef8:	00300793          	li	a5,3
    80002efc:	0297c663          	blt	a5,s1,80002f28 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80002f00:	00349793          	slli	a5,s1,0x3
    80002f04:	fe040713          	addi	a4,s0,-32
    80002f08:	00f707b3          	add	a5,a4,a5
    80002f0c:	fe07b503          	ld	a0,-32(a5)
    80002f10:	fffff097          	auipc	ra,0xfffff
    80002f14:	ae8080e7          	jalr	-1304(ra) # 800019f8 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80002f18:	0014849b          	addiw	s1,s1,1
    80002f1c:	fddff06f          	j	80002ef8 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80002f20:	fffff097          	auipc	ra,0xfffff
    80002f24:	b0c080e7          	jalr	-1268(ra) # 80001a2c <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002f28:	00007797          	auipc	a5,0x7
    80002f2c:	2807c783          	lbu	a5,640(a5) # 8000a1a8 <_ZL9finishedA>
    80002f30:	fe0788e3          	beqz	a5,80002f20 <_Z20Threads_CPP_API_testv+0x124>
    80002f34:	00007797          	auipc	a5,0x7
    80002f38:	2757c783          	lbu	a5,629(a5) # 8000a1a9 <_ZL9finishedB>
    80002f3c:	fe0782e3          	beqz	a5,80002f20 <_Z20Threads_CPP_API_testv+0x124>
    80002f40:	00007797          	auipc	a5,0x7
    80002f44:	26a7c783          	lbu	a5,618(a5) # 8000a1aa <_ZL9finishedC>
    80002f48:	fc078ce3          	beqz	a5,80002f20 <_Z20Threads_CPP_API_testv+0x124>
    80002f4c:	00007797          	auipc	a5,0x7
    80002f50:	25f7c783          	lbu	a5,607(a5) # 8000a1ab <_ZL9finishedD>
    80002f54:	fc0786e3          	beqz	a5,80002f20 <_Z20Threads_CPP_API_testv+0x124>
    80002f58:	fc040493          	addi	s1,s0,-64
    80002f5c:	0080006f          	j	80002f64 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80002f60:	00848493          	addi	s1,s1,8
    80002f64:	fe040793          	addi	a5,s0,-32
    80002f68:	08f48663          	beq	s1,a5,80002ff4 <_Z20Threads_CPP_API_testv+0x1f8>
    80002f6c:	0004b503          	ld	a0,0(s1)
    80002f70:	fe0508e3          	beqz	a0,80002f60 <_Z20Threads_CPP_API_testv+0x164>
    80002f74:	00053783          	ld	a5,0(a0)
    80002f78:	0087b783          	ld	a5,8(a5)
    80002f7c:	000780e7          	jalr	a5
    80002f80:	fe1ff06f          	j	80002f60 <_Z20Threads_CPP_API_testv+0x164>
    80002f84:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80002f88:	00048513          	mv	a0,s1
    80002f8c:	fffff097          	auipc	ra,0xfffff
    80002f90:	894080e7          	jalr	-1900(ra) # 80001820 <_ZdlPv>
    80002f94:	00090513          	mv	a0,s2
    80002f98:	00008097          	auipc	ra,0x8
    80002f9c:	300080e7          	jalr	768(ra) # 8000b298 <_Unwind_Resume>
    80002fa0:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80002fa4:	00048513          	mv	a0,s1
    80002fa8:	fffff097          	auipc	ra,0xfffff
    80002fac:	878080e7          	jalr	-1928(ra) # 80001820 <_ZdlPv>
    80002fb0:	00090513          	mv	a0,s2
    80002fb4:	00008097          	auipc	ra,0x8
    80002fb8:	2e4080e7          	jalr	740(ra) # 8000b298 <_Unwind_Resume>
    80002fbc:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80002fc0:	00048513          	mv	a0,s1
    80002fc4:	fffff097          	auipc	ra,0xfffff
    80002fc8:	85c080e7          	jalr	-1956(ra) # 80001820 <_ZdlPv>
    80002fcc:	00090513          	mv	a0,s2
    80002fd0:	00008097          	auipc	ra,0x8
    80002fd4:	2c8080e7          	jalr	712(ra) # 8000b298 <_Unwind_Resume>
    80002fd8:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80002fdc:	00048513          	mv	a0,s1
    80002fe0:	fffff097          	auipc	ra,0xfffff
    80002fe4:	840080e7          	jalr	-1984(ra) # 80001820 <_ZdlPv>
    80002fe8:	00090513          	mv	a0,s2
    80002fec:	00008097          	auipc	ra,0x8
    80002ff0:	2ac080e7          	jalr	684(ra) # 8000b298 <_Unwind_Resume>
}
    80002ff4:	03813083          	ld	ra,56(sp)
    80002ff8:	03013403          	ld	s0,48(sp)
    80002ffc:	02813483          	ld	s1,40(sp)
    80003000:	02013903          	ld	s2,32(sp)
    80003004:	04010113          	addi	sp,sp,64
    80003008:	00008067          	ret

000000008000300c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    8000300c:	ff010113          	addi	sp,sp,-16
    80003010:	00113423          	sd	ra,8(sp)
    80003014:	00813023          	sd	s0,0(sp)
    80003018:	01010413          	addi	s0,sp,16
    8000301c:	00007797          	auipc	a5,0x7
    80003020:	fb478793          	addi	a5,a5,-76 # 80009fd0 <_ZTV7WorkerA+0x10>
    80003024:	00f53023          	sd	a5,0(a0)
    80003028:	fffff097          	auipc	ra,0xfffff
    8000302c:	848080e7          	jalr	-1976(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003030:	00813083          	ld	ra,8(sp)
    80003034:	00013403          	ld	s0,0(sp)
    80003038:	01010113          	addi	sp,sp,16
    8000303c:	00008067          	ret

0000000080003040 <_ZN7WorkerAD0Ev>:
    80003040:	fe010113          	addi	sp,sp,-32
    80003044:	00113c23          	sd	ra,24(sp)
    80003048:	00813823          	sd	s0,16(sp)
    8000304c:	00913423          	sd	s1,8(sp)
    80003050:	02010413          	addi	s0,sp,32
    80003054:	00050493          	mv	s1,a0
    80003058:	00007797          	auipc	a5,0x7
    8000305c:	f7878793          	addi	a5,a5,-136 # 80009fd0 <_ZTV7WorkerA+0x10>
    80003060:	00f53023          	sd	a5,0(a0)
    80003064:	fffff097          	auipc	ra,0xfffff
    80003068:	80c080e7          	jalr	-2036(ra) # 80001870 <_ZN6ThreadD1Ev>
    8000306c:	00048513          	mv	a0,s1
    80003070:	ffffe097          	auipc	ra,0xffffe
    80003074:	7b0080e7          	jalr	1968(ra) # 80001820 <_ZdlPv>
    80003078:	01813083          	ld	ra,24(sp)
    8000307c:	01013403          	ld	s0,16(sp)
    80003080:	00813483          	ld	s1,8(sp)
    80003084:	02010113          	addi	sp,sp,32
    80003088:	00008067          	ret

000000008000308c <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    8000308c:	ff010113          	addi	sp,sp,-16
    80003090:	00113423          	sd	ra,8(sp)
    80003094:	00813023          	sd	s0,0(sp)
    80003098:	01010413          	addi	s0,sp,16
    8000309c:	00007797          	auipc	a5,0x7
    800030a0:	f5c78793          	addi	a5,a5,-164 # 80009ff8 <_ZTV7WorkerB+0x10>
    800030a4:	00f53023          	sd	a5,0(a0)
    800030a8:	ffffe097          	auipc	ra,0xffffe
    800030ac:	7c8080e7          	jalr	1992(ra) # 80001870 <_ZN6ThreadD1Ev>
    800030b0:	00813083          	ld	ra,8(sp)
    800030b4:	00013403          	ld	s0,0(sp)
    800030b8:	01010113          	addi	sp,sp,16
    800030bc:	00008067          	ret

00000000800030c0 <_ZN7WorkerBD0Ev>:
    800030c0:	fe010113          	addi	sp,sp,-32
    800030c4:	00113c23          	sd	ra,24(sp)
    800030c8:	00813823          	sd	s0,16(sp)
    800030cc:	00913423          	sd	s1,8(sp)
    800030d0:	02010413          	addi	s0,sp,32
    800030d4:	00050493          	mv	s1,a0
    800030d8:	00007797          	auipc	a5,0x7
    800030dc:	f2078793          	addi	a5,a5,-224 # 80009ff8 <_ZTV7WorkerB+0x10>
    800030e0:	00f53023          	sd	a5,0(a0)
    800030e4:	ffffe097          	auipc	ra,0xffffe
    800030e8:	78c080e7          	jalr	1932(ra) # 80001870 <_ZN6ThreadD1Ev>
    800030ec:	00048513          	mv	a0,s1
    800030f0:	ffffe097          	auipc	ra,0xffffe
    800030f4:	730080e7          	jalr	1840(ra) # 80001820 <_ZdlPv>
    800030f8:	01813083          	ld	ra,24(sp)
    800030fc:	01013403          	ld	s0,16(sp)
    80003100:	00813483          	ld	s1,8(sp)
    80003104:	02010113          	addi	sp,sp,32
    80003108:	00008067          	ret

000000008000310c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    8000310c:	ff010113          	addi	sp,sp,-16
    80003110:	00113423          	sd	ra,8(sp)
    80003114:	00813023          	sd	s0,0(sp)
    80003118:	01010413          	addi	s0,sp,16
    8000311c:	00007797          	auipc	a5,0x7
    80003120:	f0478793          	addi	a5,a5,-252 # 8000a020 <_ZTV7WorkerC+0x10>
    80003124:	00f53023          	sd	a5,0(a0)
    80003128:	ffffe097          	auipc	ra,0xffffe
    8000312c:	748080e7          	jalr	1864(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003130:	00813083          	ld	ra,8(sp)
    80003134:	00013403          	ld	s0,0(sp)
    80003138:	01010113          	addi	sp,sp,16
    8000313c:	00008067          	ret

0000000080003140 <_ZN7WorkerCD0Ev>:
    80003140:	fe010113          	addi	sp,sp,-32
    80003144:	00113c23          	sd	ra,24(sp)
    80003148:	00813823          	sd	s0,16(sp)
    8000314c:	00913423          	sd	s1,8(sp)
    80003150:	02010413          	addi	s0,sp,32
    80003154:	00050493          	mv	s1,a0
    80003158:	00007797          	auipc	a5,0x7
    8000315c:	ec878793          	addi	a5,a5,-312 # 8000a020 <_ZTV7WorkerC+0x10>
    80003160:	00f53023          	sd	a5,0(a0)
    80003164:	ffffe097          	auipc	ra,0xffffe
    80003168:	70c080e7          	jalr	1804(ra) # 80001870 <_ZN6ThreadD1Ev>
    8000316c:	00048513          	mv	a0,s1
    80003170:	ffffe097          	auipc	ra,0xffffe
    80003174:	6b0080e7          	jalr	1712(ra) # 80001820 <_ZdlPv>
    80003178:	01813083          	ld	ra,24(sp)
    8000317c:	01013403          	ld	s0,16(sp)
    80003180:	00813483          	ld	s1,8(sp)
    80003184:	02010113          	addi	sp,sp,32
    80003188:	00008067          	ret

000000008000318c <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    8000318c:	ff010113          	addi	sp,sp,-16
    80003190:	00113423          	sd	ra,8(sp)
    80003194:	00813023          	sd	s0,0(sp)
    80003198:	01010413          	addi	s0,sp,16
    8000319c:	00007797          	auipc	a5,0x7
    800031a0:	eac78793          	addi	a5,a5,-340 # 8000a048 <_ZTV7WorkerD+0x10>
    800031a4:	00f53023          	sd	a5,0(a0)
    800031a8:	ffffe097          	auipc	ra,0xffffe
    800031ac:	6c8080e7          	jalr	1736(ra) # 80001870 <_ZN6ThreadD1Ev>
    800031b0:	00813083          	ld	ra,8(sp)
    800031b4:	00013403          	ld	s0,0(sp)
    800031b8:	01010113          	addi	sp,sp,16
    800031bc:	00008067          	ret

00000000800031c0 <_ZN7WorkerDD0Ev>:
    800031c0:	fe010113          	addi	sp,sp,-32
    800031c4:	00113c23          	sd	ra,24(sp)
    800031c8:	00813823          	sd	s0,16(sp)
    800031cc:	00913423          	sd	s1,8(sp)
    800031d0:	02010413          	addi	s0,sp,32
    800031d4:	00050493          	mv	s1,a0
    800031d8:	00007797          	auipc	a5,0x7
    800031dc:	e7078793          	addi	a5,a5,-400 # 8000a048 <_ZTV7WorkerD+0x10>
    800031e0:	00f53023          	sd	a5,0(a0)
    800031e4:	ffffe097          	auipc	ra,0xffffe
    800031e8:	68c080e7          	jalr	1676(ra) # 80001870 <_ZN6ThreadD1Ev>
    800031ec:	00048513          	mv	a0,s1
    800031f0:	ffffe097          	auipc	ra,0xffffe
    800031f4:	630080e7          	jalr	1584(ra) # 80001820 <_ZdlPv>
    800031f8:	01813083          	ld	ra,24(sp)
    800031fc:	01013403          	ld	s0,16(sp)
    80003200:	00813483          	ld	s1,8(sp)
    80003204:	02010113          	addi	sp,sp,32
    80003208:	00008067          	ret

000000008000320c <_ZN7WorkerA3runEv>:
    void run() override {
    8000320c:	ff010113          	addi	sp,sp,-16
    80003210:	00113423          	sd	ra,8(sp)
    80003214:	00813023          	sd	s0,0(sp)
    80003218:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    8000321c:	00000593          	li	a1,0
    80003220:	fffff097          	auipc	ra,0xfffff
    80003224:	774080e7          	jalr	1908(ra) # 80002994 <_ZN7WorkerA11workerBodyAEPv>
    }
    80003228:	00813083          	ld	ra,8(sp)
    8000322c:	00013403          	ld	s0,0(sp)
    80003230:	01010113          	addi	sp,sp,16
    80003234:	00008067          	ret

0000000080003238 <_ZN7WorkerB3runEv>:
    void run() override {
    80003238:	ff010113          	addi	sp,sp,-16
    8000323c:	00113423          	sd	ra,8(sp)
    80003240:	00813023          	sd	s0,0(sp)
    80003244:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80003248:	00000593          	li	a1,0
    8000324c:	00000097          	auipc	ra,0x0
    80003250:	814080e7          	jalr	-2028(ra) # 80002a60 <_ZN7WorkerB11workerBodyBEPv>
    }
    80003254:	00813083          	ld	ra,8(sp)
    80003258:	00013403          	ld	s0,0(sp)
    8000325c:	01010113          	addi	sp,sp,16
    80003260:	00008067          	ret

0000000080003264 <_ZN7WorkerC3runEv>:
    void run() override {
    80003264:	ff010113          	addi	sp,sp,-16
    80003268:	00113423          	sd	ra,8(sp)
    8000326c:	00813023          	sd	s0,0(sp)
    80003270:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80003274:	00000593          	li	a1,0
    80003278:	00000097          	auipc	ra,0x0
    8000327c:	8bc080e7          	jalr	-1860(ra) # 80002b34 <_ZN7WorkerC11workerBodyCEPv>
    }
    80003280:	00813083          	ld	ra,8(sp)
    80003284:	00013403          	ld	s0,0(sp)
    80003288:	01010113          	addi	sp,sp,16
    8000328c:	00008067          	ret

0000000080003290 <_ZN7WorkerD3runEv>:
    void run() override {
    80003290:	ff010113          	addi	sp,sp,-16
    80003294:	00113423          	sd	ra,8(sp)
    80003298:	00813023          	sd	s0,0(sp)
    8000329c:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800032a0:	00000593          	li	a1,0
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	a10080e7          	jalr	-1520(ra) # 80002cb4 <_ZN7WorkerD11workerBodyDEPv>
    }
    800032ac:	00813083          	ld	ra,8(sp)
    800032b0:	00013403          	ld	s0,0(sp)
    800032b4:	01010113          	addi	sp,sp,16
    800032b8:	00008067          	ret

00000000800032bc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800032bc:	fe010113          	addi	sp,sp,-32
    800032c0:	00113c23          	sd	ra,24(sp)
    800032c4:	00813823          	sd	s0,16(sp)
    800032c8:	00913423          	sd	s1,8(sp)
    800032cc:	01213023          	sd	s2,0(sp)
    800032d0:	02010413          	addi	s0,sp,32
    800032d4:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800032d8:	00100793          	li	a5,1
    800032dc:	02a7f863          	bgeu	a5,a0,8000330c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) {
    800032e0:	00a00793          	li	a5,10
    800032e4:	02f577b3          	remu	a5,a0,a5
    800032e8:	02078e63          	beqz	a5,80003324 <_ZL9fibonaccim+0x68>
        thread_dispatch();
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
    800032ec:	fff48513          	addi	a0,s1,-1
    800032f0:	00000097          	auipc	ra,0x0
    800032f4:	fcc080e7          	jalr	-52(ra) # 800032bc <_ZL9fibonaccim>
    800032f8:	00050913          	mv	s2,a0
    800032fc:	ffe48513          	addi	a0,s1,-2
    80003300:	00000097          	auipc	ra,0x0
    80003304:	fbc080e7          	jalr	-68(ra) # 800032bc <_ZL9fibonaccim>
    80003308:	00a90533          	add	a0,s2,a0
}
    8000330c:	01813083          	ld	ra,24(sp)
    80003310:	01013403          	ld	s0,16(sp)
    80003314:	00813483          	ld	s1,8(sp)
    80003318:	00013903          	ld	s2,0(sp)
    8000331c:	02010113          	addi	sp,sp,32
    80003320:	00008067          	ret
        thread_dispatch();
    80003324:	ffffe097          	auipc	ra,0xffffe
    80003328:	f1c080e7          	jalr	-228(ra) # 80001240 <_Z15thread_dispatchv>
    8000332c:	fc1ff06f          	j	800032ec <_ZL9fibonaccim+0x30>

0000000080003330 <_ZL11workerBodyDPv>:
    printString("C finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003330:	fe010113          	addi	sp,sp,-32
    80003334:	00113c23          	sd	ra,24(sp)
    80003338:	00813823          	sd	s0,16(sp)
    8000333c:	00913423          	sd	s1,8(sp)
    80003340:	01213023          	sd	s2,0(sp)
    80003344:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003348:	00a00493          	li	s1,10
    8000334c:	0400006f          	j	8000338c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003350:	00005517          	auipc	a0,0x5
    80003354:	1c850513          	addi	a0,a0,456 # 80008518 <CONSOLE_STATUS+0x508>
    80003358:	00001097          	auipc	ra,0x1
    8000335c:	dc8080e7          	jalr	-568(ra) # 80004120 <_Z11printStringPKc>
    80003360:	00000613          	li	a2,0
    80003364:	00a00593          	li	a1,10
    80003368:	00048513          	mv	a0,s1
    8000336c:	00001097          	auipc	ra,0x1
    80003370:	f64080e7          	jalr	-156(ra) # 800042d0 <_Z8printIntiii>
    80003374:	00005517          	auipc	a0,0x5
    80003378:	e3450513          	addi	a0,a0,-460 # 800081a8 <CONSOLE_STATUS+0x198>
    8000337c:	00001097          	auipc	ra,0x1
    80003380:	da4080e7          	jalr	-604(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003384:	0014849b          	addiw	s1,s1,1
    80003388:	0ff4f493          	andi	s1,s1,255
    8000338c:	00c00793          	li	a5,12
    80003390:	fc97f0e3          	bgeu	a5,s1,80003350 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003394:	00005517          	auipc	a0,0x5
    80003398:	18c50513          	addi	a0,a0,396 # 80008520 <CONSOLE_STATUS+0x510>
    8000339c:	00001097          	auipc	ra,0x1
    800033a0:	d84080e7          	jalr	-636(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800033a4:	00500313          	li	t1,5
    thread_dispatch();
    800033a8:	ffffe097          	auipc	ra,0xffffe
    800033ac:	e98080e7          	jalr	-360(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800033b0:	01000513          	li	a0,16
    800033b4:	00000097          	auipc	ra,0x0
    800033b8:	f08080e7          	jalr	-248(ra) # 800032bc <_ZL9fibonaccim>
    800033bc:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800033c0:	00005517          	auipc	a0,0x5
    800033c4:	17050513          	addi	a0,a0,368 # 80008530 <CONSOLE_STATUS+0x520>
    800033c8:	00001097          	auipc	ra,0x1
    800033cc:	d58080e7          	jalr	-680(ra) # 80004120 <_Z11printStringPKc>
    800033d0:	00000613          	li	a2,0
    800033d4:	00a00593          	li	a1,10
    800033d8:	0009051b          	sext.w	a0,s2
    800033dc:	00001097          	auipc	ra,0x1
    800033e0:	ef4080e7          	jalr	-268(ra) # 800042d0 <_Z8printIntiii>
    800033e4:	00005517          	auipc	a0,0x5
    800033e8:	dc450513          	addi	a0,a0,-572 # 800081a8 <CONSOLE_STATUS+0x198>
    800033ec:	00001097          	auipc	ra,0x1
    800033f0:	d34080e7          	jalr	-716(ra) # 80004120 <_Z11printStringPKc>
    800033f4:	0400006f          	j	80003434 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800033f8:	00005517          	auipc	a0,0x5
    800033fc:	12050513          	addi	a0,a0,288 # 80008518 <CONSOLE_STATUS+0x508>
    80003400:	00001097          	auipc	ra,0x1
    80003404:	d20080e7          	jalr	-736(ra) # 80004120 <_Z11printStringPKc>
    80003408:	00000613          	li	a2,0
    8000340c:	00a00593          	li	a1,10
    80003410:	00048513          	mv	a0,s1
    80003414:	00001097          	auipc	ra,0x1
    80003418:	ebc080e7          	jalr	-324(ra) # 800042d0 <_Z8printIntiii>
    8000341c:	00005517          	auipc	a0,0x5
    80003420:	d8c50513          	addi	a0,a0,-628 # 800081a8 <CONSOLE_STATUS+0x198>
    80003424:	00001097          	auipc	ra,0x1
    80003428:	cfc080e7          	jalr	-772(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 16; i++) {
    8000342c:	0014849b          	addiw	s1,s1,1
    80003430:	0ff4f493          	andi	s1,s1,255
    80003434:	00f00793          	li	a5,15
    80003438:	fc97f0e3          	bgeu	a5,s1,800033f8 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    8000343c:	00005517          	auipc	a0,0x5
    80003440:	10450513          	addi	a0,a0,260 # 80008540 <CONSOLE_STATUS+0x530>
    80003444:	00001097          	auipc	ra,0x1
    80003448:	cdc080e7          	jalr	-804(ra) # 80004120 <_Z11printStringPKc>
    finishedD = true;
    8000344c:	00100793          	li	a5,1
    80003450:	00007717          	auipc	a4,0x7
    80003454:	d4f70e23          	sb	a5,-676(a4) # 8000a1ac <_ZL9finishedD>
    thread_dispatch();
    80003458:	ffffe097          	auipc	ra,0xffffe
    8000345c:	de8080e7          	jalr	-536(ra) # 80001240 <_Z15thread_dispatchv>
}
    80003460:	01813083          	ld	ra,24(sp)
    80003464:	01013403          	ld	s0,16(sp)
    80003468:	00813483          	ld	s1,8(sp)
    8000346c:	00013903          	ld	s2,0(sp)
    80003470:	02010113          	addi	sp,sp,32
    80003474:	00008067          	ret

0000000080003478 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003478:	fe010113          	addi	sp,sp,-32
    8000347c:	00113c23          	sd	ra,24(sp)
    80003480:	00813823          	sd	s0,16(sp)
    80003484:	00913423          	sd	s1,8(sp)
    80003488:	01213023          	sd	s2,0(sp)
    8000348c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003490:	00000493          	li	s1,0
    80003494:	0400006f          	j	800034d4 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003498:	00005517          	auipc	a0,0x5
    8000349c:	05050513          	addi	a0,a0,80 # 800084e8 <CONSOLE_STATUS+0x4d8>
    800034a0:	00001097          	auipc	ra,0x1
    800034a4:	c80080e7          	jalr	-896(ra) # 80004120 <_Z11printStringPKc>
    800034a8:	00000613          	li	a2,0
    800034ac:	00a00593          	li	a1,10
    800034b0:	00048513          	mv	a0,s1
    800034b4:	00001097          	auipc	ra,0x1
    800034b8:	e1c080e7          	jalr	-484(ra) # 800042d0 <_Z8printIntiii>
    800034bc:	00005517          	auipc	a0,0x5
    800034c0:	cec50513          	addi	a0,a0,-788 # 800081a8 <CONSOLE_STATUS+0x198>
    800034c4:	00001097          	auipc	ra,0x1
    800034c8:	c5c080e7          	jalr	-932(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800034cc:	0014849b          	addiw	s1,s1,1
    800034d0:	0ff4f493          	andi	s1,s1,255
    800034d4:	00200793          	li	a5,2
    800034d8:	fc97f0e3          	bgeu	a5,s1,80003498 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    800034dc:	00005517          	auipc	a0,0x5
    800034e0:	01450513          	addi	a0,a0,20 # 800084f0 <CONSOLE_STATUS+0x4e0>
    800034e4:	00001097          	auipc	ra,0x1
    800034e8:	c3c080e7          	jalr	-964(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800034ec:	00700313          	li	t1,7
    thread_dispatch();
    800034f0:	ffffe097          	auipc	ra,0xffffe
    800034f4:	d50080e7          	jalr	-688(ra) # 80001240 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800034f8:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    800034fc:	00005517          	auipc	a0,0x5
    80003500:	00450513          	addi	a0,a0,4 # 80008500 <CONSOLE_STATUS+0x4f0>
    80003504:	00001097          	auipc	ra,0x1
    80003508:	c1c080e7          	jalr	-996(ra) # 80004120 <_Z11printStringPKc>
    8000350c:	00000613          	li	a2,0
    80003510:	00a00593          	li	a1,10
    80003514:	0009051b          	sext.w	a0,s2
    80003518:	00001097          	auipc	ra,0x1
    8000351c:	db8080e7          	jalr	-584(ra) # 800042d0 <_Z8printIntiii>
    80003520:	00005517          	auipc	a0,0x5
    80003524:	c8850513          	addi	a0,a0,-888 # 800081a8 <CONSOLE_STATUS+0x198>
    80003528:	00001097          	auipc	ra,0x1
    8000352c:	bf8080e7          	jalr	-1032(ra) # 80004120 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003530:	00c00513          	li	a0,12
    80003534:	00000097          	auipc	ra,0x0
    80003538:	d88080e7          	jalr	-632(ra) # 800032bc <_ZL9fibonaccim>
    8000353c:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003540:	00005517          	auipc	a0,0x5
    80003544:	fc850513          	addi	a0,a0,-56 # 80008508 <CONSOLE_STATUS+0x4f8>
    80003548:	00001097          	auipc	ra,0x1
    8000354c:	bd8080e7          	jalr	-1064(ra) # 80004120 <_Z11printStringPKc>
    80003550:	00000613          	li	a2,0
    80003554:	00a00593          	li	a1,10
    80003558:	0009051b          	sext.w	a0,s2
    8000355c:	00001097          	auipc	ra,0x1
    80003560:	d74080e7          	jalr	-652(ra) # 800042d0 <_Z8printIntiii>
    80003564:	00005517          	auipc	a0,0x5
    80003568:	c4450513          	addi	a0,a0,-956 # 800081a8 <CONSOLE_STATUS+0x198>
    8000356c:	00001097          	auipc	ra,0x1
    80003570:	bb4080e7          	jalr	-1100(ra) # 80004120 <_Z11printStringPKc>
    80003574:	0400006f          	j	800035b4 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003578:	00005517          	auipc	a0,0x5
    8000357c:	f7050513          	addi	a0,a0,-144 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80003580:	00001097          	auipc	ra,0x1
    80003584:	ba0080e7          	jalr	-1120(ra) # 80004120 <_Z11printStringPKc>
    80003588:	00000613          	li	a2,0
    8000358c:	00a00593          	li	a1,10
    80003590:	00048513          	mv	a0,s1
    80003594:	00001097          	auipc	ra,0x1
    80003598:	d3c080e7          	jalr	-708(ra) # 800042d0 <_Z8printIntiii>
    8000359c:	00005517          	auipc	a0,0x5
    800035a0:	c0c50513          	addi	a0,a0,-1012 # 800081a8 <CONSOLE_STATUS+0x198>
    800035a4:	00001097          	auipc	ra,0x1
    800035a8:	b7c080e7          	jalr	-1156(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 6; i++) {
    800035ac:	0014849b          	addiw	s1,s1,1
    800035b0:	0ff4f493          	andi	s1,s1,255
    800035b4:	00500793          	li	a5,5
    800035b8:	fc97f0e3          	bgeu	a5,s1,80003578 <_ZL11workerBodyCPv+0x100>
    printString("C finished!\n");
    800035bc:	00005517          	auipc	a0,0x5
    800035c0:	ff450513          	addi	a0,a0,-12 # 800085b0 <CONSOLE_STATUS+0x5a0>
    800035c4:	00001097          	auipc	ra,0x1
    800035c8:	b5c080e7          	jalr	-1188(ra) # 80004120 <_Z11printStringPKc>
    finishedC = true;
    800035cc:	00100793          	li	a5,1
    800035d0:	00007717          	auipc	a4,0x7
    800035d4:	bcf70ea3          	sb	a5,-1059(a4) # 8000a1ad <_ZL9finishedC>
    thread_dispatch();
    800035d8:	ffffe097          	auipc	ra,0xffffe
    800035dc:	c68080e7          	jalr	-920(ra) # 80001240 <_Z15thread_dispatchv>
}
    800035e0:	01813083          	ld	ra,24(sp)
    800035e4:	01013403          	ld	s0,16(sp)
    800035e8:	00813483          	ld	s1,8(sp)
    800035ec:	00013903          	ld	s2,0(sp)
    800035f0:	02010113          	addi	sp,sp,32
    800035f4:	00008067          	ret

00000000800035f8 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    800035f8:	fe010113          	addi	sp,sp,-32
    800035fc:	00113c23          	sd	ra,24(sp)
    80003600:	00813823          	sd	s0,16(sp)
    80003604:	00913423          	sd	s1,8(sp)
    80003608:	01213023          	sd	s2,0(sp)
    8000360c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003610:	00000913          	li	s2,0
    80003614:	0380006f          	j	8000364c <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003618:	ffffe097          	auipc	ra,0xffffe
    8000361c:	c28080e7          	jalr	-984(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003620:	00148493          	addi	s1,s1,1
    80003624:	000027b7          	lui	a5,0x2
    80003628:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    8000362c:	0097ee63          	bltu	a5,s1,80003648 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003630:	00000713          	li	a4,0
    80003634:	000077b7          	lui	a5,0x7
    80003638:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    8000363c:	fce7eee3          	bltu	a5,a4,80003618 <_ZL11workerBodyBPv+0x20>
    80003640:	00170713          	addi	a4,a4,1
    80003644:	ff1ff06f          	j	80003634 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003648:	00190913          	addi	s2,s2,1
    8000364c:	00f00793          	li	a5,15
    80003650:	0527e063          	bltu	a5,s2,80003690 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003654:	00005517          	auipc	a0,0x5
    80003658:	e7c50513          	addi	a0,a0,-388 # 800084d0 <CONSOLE_STATUS+0x4c0>
    8000365c:	00001097          	auipc	ra,0x1
    80003660:	ac4080e7          	jalr	-1340(ra) # 80004120 <_Z11printStringPKc>
    80003664:	00000613          	li	a2,0
    80003668:	00a00593          	li	a1,10
    8000366c:	0009051b          	sext.w	a0,s2
    80003670:	00001097          	auipc	ra,0x1
    80003674:	c60080e7          	jalr	-928(ra) # 800042d0 <_Z8printIntiii>
    80003678:	00005517          	auipc	a0,0x5
    8000367c:	b3050513          	addi	a0,a0,-1232 # 800081a8 <CONSOLE_STATUS+0x198>
    80003680:	00001097          	auipc	ra,0x1
    80003684:	aa0080e7          	jalr	-1376(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003688:	00000493          	li	s1,0
    8000368c:	f99ff06f          	j	80003624 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003690:	00005517          	auipc	a0,0x5
    80003694:	e4850513          	addi	a0,a0,-440 # 800084d8 <CONSOLE_STATUS+0x4c8>
    80003698:	00001097          	auipc	ra,0x1
    8000369c:	a88080e7          	jalr	-1400(ra) # 80004120 <_Z11printStringPKc>
    finishedB = true;
    800036a0:	00100793          	li	a5,1
    800036a4:	00007717          	auipc	a4,0x7
    800036a8:	b0f70523          	sb	a5,-1270(a4) # 8000a1ae <_ZL9finishedB>
    thread_dispatch();
    800036ac:	ffffe097          	auipc	ra,0xffffe
    800036b0:	b94080e7          	jalr	-1132(ra) # 80001240 <_Z15thread_dispatchv>
}
    800036b4:	01813083          	ld	ra,24(sp)
    800036b8:	01013403          	ld	s0,16(sp)
    800036bc:	00813483          	ld	s1,8(sp)
    800036c0:	00013903          	ld	s2,0(sp)
    800036c4:	02010113          	addi	sp,sp,32
    800036c8:	00008067          	ret

00000000800036cc <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    800036cc:	fe010113          	addi	sp,sp,-32
    800036d0:	00113c23          	sd	ra,24(sp)
    800036d4:	00813823          	sd	s0,16(sp)
    800036d8:	00913423          	sd	s1,8(sp)
    800036dc:	01213023          	sd	s2,0(sp)
    800036e0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800036e4:	00000913          	li	s2,0
    800036e8:	0380006f          	j	80003720 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    800036ec:	ffffe097          	auipc	ra,0xffffe
    800036f0:	b54080e7          	jalr	-1196(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800036f4:	00148493          	addi	s1,s1,1
    800036f8:	000027b7          	lui	a5,0x2
    800036fc:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003700:	0097ee63          	bltu	a5,s1,8000371c <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003704:	00000713          	li	a4,0
    80003708:	000077b7          	lui	a5,0x7
    8000370c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003710:	fce7eee3          	bltu	a5,a4,800036ec <_ZL11workerBodyAPv+0x20>
    80003714:	00170713          	addi	a4,a4,1
    80003718:	ff1ff06f          	j	80003708 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000371c:	00190913          	addi	s2,s2,1
    80003720:	00900793          	li	a5,9
    80003724:	0527e063          	bltu	a5,s2,80003764 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003728:	00005517          	auipc	a0,0x5
    8000372c:	d9050513          	addi	a0,a0,-624 # 800084b8 <CONSOLE_STATUS+0x4a8>
    80003730:	00001097          	auipc	ra,0x1
    80003734:	9f0080e7          	jalr	-1552(ra) # 80004120 <_Z11printStringPKc>
    80003738:	00000613          	li	a2,0
    8000373c:	00a00593          	li	a1,10
    80003740:	0009051b          	sext.w	a0,s2
    80003744:	00001097          	auipc	ra,0x1
    80003748:	b8c080e7          	jalr	-1140(ra) # 800042d0 <_Z8printIntiii>
    8000374c:	00005517          	auipc	a0,0x5
    80003750:	a5c50513          	addi	a0,a0,-1444 # 800081a8 <CONSOLE_STATUS+0x198>
    80003754:	00001097          	auipc	ra,0x1
    80003758:	9cc080e7          	jalr	-1588(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000375c:	00000493          	li	s1,0
    80003760:	f99ff06f          	j	800036f8 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003764:	00005517          	auipc	a0,0x5
    80003768:	d5c50513          	addi	a0,a0,-676 # 800084c0 <CONSOLE_STATUS+0x4b0>
    8000376c:	00001097          	auipc	ra,0x1
    80003770:	9b4080e7          	jalr	-1612(ra) # 80004120 <_Z11printStringPKc>
    finishedA = true;
    80003774:	00100793          	li	a5,1
    80003778:	00007717          	auipc	a4,0x7
    8000377c:	a2f70ba3          	sb	a5,-1481(a4) # 8000a1af <_ZL9finishedA>
}
    80003780:	01813083          	ld	ra,24(sp)
    80003784:	01013403          	ld	s0,16(sp)
    80003788:	00813483          	ld	s1,8(sp)
    8000378c:	00013903          	ld	s2,0(sp)
    80003790:	02010113          	addi	sp,sp,32
    80003794:	00008067          	ret

0000000080003798 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003798:	fd010113          	addi	sp,sp,-48
    8000379c:	02113423          	sd	ra,40(sp)
    800037a0:	02813023          	sd	s0,32(sp)
    800037a4:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    800037a8:	00000613          	li	a2,0
    800037ac:	00000597          	auipc	a1,0x0
    800037b0:	f2058593          	addi	a1,a1,-224 # 800036cc <_ZL11workerBodyAPv>
    800037b4:	fd040513          	addi	a0,s0,-48
    800037b8:	ffffe097          	auipc	ra,0xffffe
    800037bc:	a30080e7          	jalr	-1488(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    800037c0:	00005517          	auipc	a0,0x5
    800037c4:	d9050513          	addi	a0,a0,-624 # 80008550 <CONSOLE_STATUS+0x540>
    800037c8:	00001097          	auipc	ra,0x1
    800037cc:	958080e7          	jalr	-1704(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    800037d0:	00000613          	li	a2,0
    800037d4:	00000597          	auipc	a1,0x0
    800037d8:	e2458593          	addi	a1,a1,-476 # 800035f8 <_ZL11workerBodyBPv>
    800037dc:	fd840513          	addi	a0,s0,-40
    800037e0:	ffffe097          	auipc	ra,0xffffe
    800037e4:	a08080e7          	jalr	-1528(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    800037e8:	00005517          	auipc	a0,0x5
    800037ec:	d8050513          	addi	a0,a0,-640 # 80008568 <CONSOLE_STATUS+0x558>
    800037f0:	00001097          	auipc	ra,0x1
    800037f4:	930080e7          	jalr	-1744(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    800037f8:	00000613          	li	a2,0
    800037fc:	00000597          	auipc	a1,0x0
    80003800:	c7c58593          	addi	a1,a1,-900 # 80003478 <_ZL11workerBodyCPv>
    80003804:	fe040513          	addi	a0,s0,-32
    80003808:	ffffe097          	auipc	ra,0xffffe
    8000380c:	9e0080e7          	jalr	-1568(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80003810:	00005517          	auipc	a0,0x5
    80003814:	d7050513          	addi	a0,a0,-656 # 80008580 <CONSOLE_STATUS+0x570>
    80003818:	00001097          	auipc	ra,0x1
    8000381c:	908080e7          	jalr	-1784(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80003820:	00000613          	li	a2,0
    80003824:	00000597          	auipc	a1,0x0
    80003828:	b0c58593          	addi	a1,a1,-1268 # 80003330 <_ZL11workerBodyDPv>
    8000382c:	fe840513          	addi	a0,s0,-24
    80003830:	ffffe097          	auipc	ra,0xffffe
    80003834:	9b8080e7          	jalr	-1608(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80003838:	00005517          	auipc	a0,0x5
    8000383c:	d6050513          	addi	a0,a0,-672 # 80008598 <CONSOLE_STATUS+0x588>
    80003840:	00001097          	auipc	ra,0x1
    80003844:	8e0080e7          	jalr	-1824(ra) # 80004120 <_Z11printStringPKc>
    80003848:	00c0006f          	j	80003854 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    8000384c:	ffffe097          	auipc	ra,0xffffe
    80003850:	9f4080e7          	jalr	-1548(ra) # 80001240 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003854:	00007797          	auipc	a5,0x7
    80003858:	95b7c783          	lbu	a5,-1701(a5) # 8000a1af <_ZL9finishedA>
    8000385c:	fe0788e3          	beqz	a5,8000384c <_Z18Threads_C_API_testv+0xb4>
    80003860:	00007797          	auipc	a5,0x7
    80003864:	94e7c783          	lbu	a5,-1714(a5) # 8000a1ae <_ZL9finishedB>
    80003868:	fe0782e3          	beqz	a5,8000384c <_Z18Threads_C_API_testv+0xb4>
    8000386c:	00007797          	auipc	a5,0x7
    80003870:	9417c783          	lbu	a5,-1727(a5) # 8000a1ad <_ZL9finishedC>
    80003874:	fc078ce3          	beqz	a5,8000384c <_Z18Threads_C_API_testv+0xb4>
    80003878:	00007797          	auipc	a5,0x7
    8000387c:	9347c783          	lbu	a5,-1740(a5) # 8000a1ac <_ZL9finishedD>
    80003880:	fc0786e3          	beqz	a5,8000384c <_Z18Threads_C_API_testv+0xb4>
    }

}
    80003884:	02813083          	ld	ra,40(sp)
    80003888:	02013403          	ld	s0,32(sp)
    8000388c:	03010113          	addi	sp,sp,48
    80003890:	00008067          	ret

0000000080003894 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80003894:	fd010113          	addi	sp,sp,-48
    80003898:	02113423          	sd	ra,40(sp)
    8000389c:	02813023          	sd	s0,32(sp)
    800038a0:	00913c23          	sd	s1,24(sp)
    800038a4:	01213823          	sd	s2,16(sp)
    800038a8:	01313423          	sd	s3,8(sp)
    800038ac:	03010413          	addi	s0,sp,48
    800038b0:	00050993          	mv	s3,a0
    800038b4:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    800038b8:	00000913          	li	s2,0
    800038bc:	00c0006f          	j	800038c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800038c0:	ffffe097          	auipc	ra,0xffffe
    800038c4:	16c080e7          	jalr	364(ra) # 80001a2c <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    800038c8:	ffffe097          	auipc	ra,0xffffe
    800038cc:	a4c080e7          	jalr	-1460(ra) # 80001314 <_Z4getcv>
    800038d0:	0005059b          	sext.w	a1,a0
    800038d4:	01b00793          	li	a5,27
    800038d8:	02f58a63          	beq	a1,a5,8000390c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    800038dc:	0084b503          	ld	a0,8(s1)
    800038e0:	00001097          	auipc	ra,0x1
    800038e4:	c64080e7          	jalr	-924(ra) # 80004544 <_ZN9BufferCPP3putEi>
        i++;
    800038e8:	0019071b          	addiw	a4,s2,1
    800038ec:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800038f0:	0004a683          	lw	a3,0(s1)
    800038f4:	0026979b          	slliw	a5,a3,0x2
    800038f8:	00d787bb          	addw	a5,a5,a3
    800038fc:	0017979b          	slliw	a5,a5,0x1
    80003900:	02f767bb          	remw	a5,a4,a5
    80003904:	fc0792e3          	bnez	a5,800038c8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80003908:	fb9ff06f          	j	800038c0 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    8000390c:	00100793          	li	a5,1
    80003910:	00007717          	auipc	a4,0x7
    80003914:	8af72023          	sw	a5,-1888(a4) # 8000a1b0 <_ZL9threadEnd>
    td->buffer->put('!');
    80003918:	0209b783          	ld	a5,32(s3)
    8000391c:	02100593          	li	a1,33
    80003920:	0087b503          	ld	a0,8(a5)
    80003924:	00001097          	auipc	ra,0x1
    80003928:	c20080e7          	jalr	-992(ra) # 80004544 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    8000392c:	0104b503          	ld	a0,16(s1)
    80003930:	ffffe097          	auipc	ra,0xffffe
    80003934:	1b0080e7          	jalr	432(ra) # 80001ae0 <_ZN9Semaphore6signalEv>
}
    80003938:	02813083          	ld	ra,40(sp)
    8000393c:	02013403          	ld	s0,32(sp)
    80003940:	01813483          	ld	s1,24(sp)
    80003944:	01013903          	ld	s2,16(sp)
    80003948:	00813983          	ld	s3,8(sp)
    8000394c:	03010113          	addi	sp,sp,48
    80003950:	00008067          	ret

0000000080003954 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80003954:	fe010113          	addi	sp,sp,-32
    80003958:	00113c23          	sd	ra,24(sp)
    8000395c:	00813823          	sd	s0,16(sp)
    80003960:	00913423          	sd	s1,8(sp)
    80003964:	01213023          	sd	s2,0(sp)
    80003968:	02010413          	addi	s0,sp,32
    8000396c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003970:	00000913          	li	s2,0
    80003974:	00c0006f          	j	80003980 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80003978:	ffffe097          	auipc	ra,0xffffe
    8000397c:	0b4080e7          	jalr	180(ra) # 80001a2c <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80003980:	00007797          	auipc	a5,0x7
    80003984:	8307a783          	lw	a5,-2000(a5) # 8000a1b0 <_ZL9threadEnd>
    80003988:	02079e63          	bnez	a5,800039c4 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000398c:	0004a583          	lw	a1,0(s1)
    80003990:	0305859b          	addiw	a1,a1,48
    80003994:	0084b503          	ld	a0,8(s1)
    80003998:	00001097          	auipc	ra,0x1
    8000399c:	bac080e7          	jalr	-1108(ra) # 80004544 <_ZN9BufferCPP3putEi>
        i++;
    800039a0:	0019071b          	addiw	a4,s2,1
    800039a4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800039a8:	0004a683          	lw	a3,0(s1)
    800039ac:	0026979b          	slliw	a5,a3,0x2
    800039b0:	00d787bb          	addw	a5,a5,a3
    800039b4:	0017979b          	slliw	a5,a5,0x1
    800039b8:	02f767bb          	remw	a5,a4,a5
    800039bc:	fc0792e3          	bnez	a5,80003980 <_ZN12ProducerSync8producerEPv+0x2c>
    800039c0:	fb9ff06f          	j	80003978 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    800039c4:	0104b503          	ld	a0,16(s1)
    800039c8:	ffffe097          	auipc	ra,0xffffe
    800039cc:	118080e7          	jalr	280(ra) # 80001ae0 <_ZN9Semaphore6signalEv>
}
    800039d0:	01813083          	ld	ra,24(sp)
    800039d4:	01013403          	ld	s0,16(sp)
    800039d8:	00813483          	ld	s1,8(sp)
    800039dc:	00013903          	ld	s2,0(sp)
    800039e0:	02010113          	addi	sp,sp,32
    800039e4:	00008067          	ret

00000000800039e8 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800039e8:	fd010113          	addi	sp,sp,-48
    800039ec:	02113423          	sd	ra,40(sp)
    800039f0:	02813023          	sd	s0,32(sp)
    800039f4:	00913c23          	sd	s1,24(sp)
    800039f8:	01213823          	sd	s2,16(sp)
    800039fc:	01313423          	sd	s3,8(sp)
    80003a00:	01413023          	sd	s4,0(sp)
    80003a04:	03010413          	addi	s0,sp,48
    80003a08:	00050993          	mv	s3,a0
    80003a0c:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003a10:	00000a13          	li	s4,0
    80003a14:	01c0006f          	j	80003a30 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80003a18:	ffffe097          	auipc	ra,0xffffe
    80003a1c:	014080e7          	jalr	20(ra) # 80001a2c <_ZN6Thread8dispatchEv>
    80003a20:	0500006f          	j	80003a70 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    80003a24:	00a00513          	li	a0,10
    80003a28:	ffffe097          	auipc	ra,0xffffe
    80003a2c:	918080e7          	jalr	-1768(ra) # 80001340 <_Z4putcc>
    while (!threadEnd) {
    80003a30:	00006797          	auipc	a5,0x6
    80003a34:	7807a783          	lw	a5,1920(a5) # 8000a1b0 <_ZL9threadEnd>
    80003a38:	06079263          	bnez	a5,80003a9c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80003a3c:	00893503          	ld	a0,8(s2)
    80003a40:	00001097          	auipc	ra,0x1
    80003a44:	b94080e7          	jalr	-1132(ra) # 800045d4 <_ZN9BufferCPP3getEv>
        i++;
    80003a48:	001a049b          	addiw	s1,s4,1
    80003a4c:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003a50:	0ff57513          	andi	a0,a0,255
    80003a54:	ffffe097          	auipc	ra,0xffffe
    80003a58:	8ec080e7          	jalr	-1812(ra) # 80001340 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003a5c:	00092703          	lw	a4,0(s2)
    80003a60:	0027179b          	slliw	a5,a4,0x2
    80003a64:	00e787bb          	addw	a5,a5,a4
    80003a68:	02f4e7bb          	remw	a5,s1,a5
    80003a6c:	fa0786e3          	beqz	a5,80003a18 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003a70:	05000793          	li	a5,80
    80003a74:	02f4e4bb          	remw	s1,s1,a5
    80003a78:	fa049ce3          	bnez	s1,80003a30 <_ZN12ConsumerSync8consumerEPv+0x48>
    80003a7c:	fa9ff06f          	j	80003a24 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003a80:	0209b783          	ld	a5,32(s3)
    80003a84:	0087b503          	ld	a0,8(a5)
    80003a88:	00001097          	auipc	ra,0x1
    80003a8c:	b4c080e7          	jalr	-1204(ra) # 800045d4 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80003a90:	0ff57513          	andi	a0,a0,255
    80003a94:	ffffe097          	auipc	ra,0xffffe
    80003a98:	ee8080e7          	jalr	-280(ra) # 8000197c <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80003a9c:	0209b783          	ld	a5,32(s3)
    80003aa0:	0087b503          	ld	a0,8(a5)
    80003aa4:	00001097          	auipc	ra,0x1
    80003aa8:	bbc080e7          	jalr	-1092(ra) # 80004660 <_ZN9BufferCPP6getCntEv>
    80003aac:	fca04ae3          	bgtz	a0,80003a80 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80003ab0:	01093503          	ld	a0,16(s2)
    80003ab4:	ffffe097          	auipc	ra,0xffffe
    80003ab8:	02c080e7          	jalr	44(ra) # 80001ae0 <_ZN9Semaphore6signalEv>
}
    80003abc:	02813083          	ld	ra,40(sp)
    80003ac0:	02013403          	ld	s0,32(sp)
    80003ac4:	01813483          	ld	s1,24(sp)
    80003ac8:	01013903          	ld	s2,16(sp)
    80003acc:	00813983          	ld	s3,8(sp)
    80003ad0:	00013a03          	ld	s4,0(sp)
    80003ad4:	03010113          	addi	sp,sp,48
    80003ad8:	00008067          	ret

0000000080003adc <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80003adc:	f8010113          	addi	sp,sp,-128
    80003ae0:	06113c23          	sd	ra,120(sp)
    80003ae4:	06813823          	sd	s0,112(sp)
    80003ae8:	06913423          	sd	s1,104(sp)
    80003aec:	07213023          	sd	s2,96(sp)
    80003af0:	05313c23          	sd	s3,88(sp)
    80003af4:	05413823          	sd	s4,80(sp)
    80003af8:	05513423          	sd	s5,72(sp)
    80003afc:	05613023          	sd	s6,64(sp)
    80003b00:	03713c23          	sd	s7,56(sp)
    80003b04:	03813823          	sd	s8,48(sp)
    80003b08:	03913423          	sd	s9,40(sp)
    80003b0c:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003b10:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003b14:	00005517          	auipc	a0,0x5
    80003b18:	8bc50513          	addi	a0,a0,-1860 # 800083d0 <CONSOLE_STATUS+0x3c0>
    80003b1c:	00000097          	auipc	ra,0x0
    80003b20:	604080e7          	jalr	1540(ra) # 80004120 <_Z11printStringPKc>
    getString(input, 30);
    80003b24:	01e00593          	li	a1,30
    80003b28:	f8040493          	addi	s1,s0,-128
    80003b2c:	00048513          	mv	a0,s1
    80003b30:	00000097          	auipc	ra,0x0
    80003b34:	678080e7          	jalr	1656(ra) # 800041a8 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003b38:	00048513          	mv	a0,s1
    80003b3c:	00000097          	auipc	ra,0x0
    80003b40:	744080e7          	jalr	1860(ra) # 80004280 <_Z11stringToIntPKc>
    80003b44:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003b48:	00005517          	auipc	a0,0x5
    80003b4c:	8a850513          	addi	a0,a0,-1880 # 800083f0 <CONSOLE_STATUS+0x3e0>
    80003b50:	00000097          	auipc	ra,0x0
    80003b54:	5d0080e7          	jalr	1488(ra) # 80004120 <_Z11printStringPKc>
    getString(input, 30);
    80003b58:	01e00593          	li	a1,30
    80003b5c:	00048513          	mv	a0,s1
    80003b60:	00000097          	auipc	ra,0x0
    80003b64:	648080e7          	jalr	1608(ra) # 800041a8 <_Z9getStringPci>
    n = stringToInt(input);
    80003b68:	00048513          	mv	a0,s1
    80003b6c:	00000097          	auipc	ra,0x0
    80003b70:	714080e7          	jalr	1812(ra) # 80004280 <_Z11stringToIntPKc>
    80003b74:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003b78:	00005517          	auipc	a0,0x5
    80003b7c:	89850513          	addi	a0,a0,-1896 # 80008410 <CONSOLE_STATUS+0x400>
    80003b80:	00000097          	auipc	ra,0x0
    80003b84:	5a0080e7          	jalr	1440(ra) # 80004120 <_Z11printStringPKc>
    80003b88:	00000613          	li	a2,0
    80003b8c:	00a00593          	li	a1,10
    80003b90:	00090513          	mv	a0,s2
    80003b94:	00000097          	auipc	ra,0x0
    80003b98:	73c080e7          	jalr	1852(ra) # 800042d0 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80003b9c:	00005517          	auipc	a0,0x5
    80003ba0:	88c50513          	addi	a0,a0,-1908 # 80008428 <CONSOLE_STATUS+0x418>
    80003ba4:	00000097          	auipc	ra,0x0
    80003ba8:	57c080e7          	jalr	1404(ra) # 80004120 <_Z11printStringPKc>
    80003bac:	00000613          	li	a2,0
    80003bb0:	00a00593          	li	a1,10
    80003bb4:	00048513          	mv	a0,s1
    80003bb8:	00000097          	auipc	ra,0x0
    80003bbc:	718080e7          	jalr	1816(ra) # 800042d0 <_Z8printIntiii>
    printString(".\n");
    80003bc0:	00005517          	auipc	a0,0x5
    80003bc4:	88050513          	addi	a0,a0,-1920 # 80008440 <CONSOLE_STATUS+0x430>
    80003bc8:	00000097          	auipc	ra,0x0
    80003bcc:	558080e7          	jalr	1368(ra) # 80004120 <_Z11printStringPKc>
    if(threadNum > n) {
    80003bd0:	0324c463          	blt	s1,s2,80003bf8 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80003bd4:	03205c63          	blez	s2,80003c0c <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80003bd8:	03800513          	li	a0,56
    80003bdc:	ffffe097          	auipc	ra,0xffffe
    80003be0:	bf4080e7          	jalr	-1036(ra) # 800017d0 <_Znwm>
    80003be4:	00050a93          	mv	s5,a0
    80003be8:	00048593          	mv	a1,s1
    80003bec:	00001097          	auipc	ra,0x1
    80003bf0:	804080e7          	jalr	-2044(ra) # 800043f0 <_ZN9BufferCPPC1Ei>
    80003bf4:	0300006f          	j	80003c24 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003bf8:	00005517          	auipc	a0,0x5
    80003bfc:	85050513          	addi	a0,a0,-1968 # 80008448 <CONSOLE_STATUS+0x438>
    80003c00:	00000097          	auipc	ra,0x0
    80003c04:	520080e7          	jalr	1312(ra) # 80004120 <_Z11printStringPKc>
        return;
    80003c08:	0140006f          	j	80003c1c <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003c0c:	00005517          	auipc	a0,0x5
    80003c10:	87c50513          	addi	a0,a0,-1924 # 80008488 <CONSOLE_STATUS+0x478>
    80003c14:	00000097          	auipc	ra,0x0
    80003c18:	50c080e7          	jalr	1292(ra) # 80004120 <_Z11printStringPKc>
        return;
    80003c1c:	000b8113          	mv	sp,s7
    80003c20:	2380006f          	j	80003e58 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80003c24:	01000513          	li	a0,16
    80003c28:	ffffe097          	auipc	ra,0xffffe
    80003c2c:	ba8080e7          	jalr	-1112(ra) # 800017d0 <_Znwm>
    80003c30:	00050493          	mv	s1,a0
    80003c34:	00000593          	li	a1,0
    80003c38:	ffffe097          	auipc	ra,0xffffe
    80003c3c:	ed4080e7          	jalr	-300(ra) # 80001b0c <_ZN9SemaphoreC1Ej>
    80003c40:	00006797          	auipc	a5,0x6
    80003c44:	5697bc23          	sd	s1,1400(a5) # 8000a1b8 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003c48:	00391793          	slli	a5,s2,0x3
    80003c4c:	00f78793          	addi	a5,a5,15
    80003c50:	ff07f793          	andi	a5,a5,-16
    80003c54:	40f10133          	sub	sp,sp,a5
    80003c58:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80003c5c:	0019071b          	addiw	a4,s2,1
    80003c60:	00171793          	slli	a5,a4,0x1
    80003c64:	00e787b3          	add	a5,a5,a4
    80003c68:	00379793          	slli	a5,a5,0x3
    80003c6c:	00f78793          	addi	a5,a5,15
    80003c70:	ff07f793          	andi	a5,a5,-16
    80003c74:	40f10133          	sub	sp,sp,a5
    80003c78:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80003c7c:	00191c13          	slli	s8,s2,0x1
    80003c80:	012c07b3          	add	a5,s8,s2
    80003c84:	00379793          	slli	a5,a5,0x3
    80003c88:	00fa07b3          	add	a5,s4,a5
    80003c8c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003c90:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80003c94:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80003c98:	02800513          	li	a0,40
    80003c9c:	ffffe097          	auipc	ra,0xffffe
    80003ca0:	b34080e7          	jalr	-1228(ra) # 800017d0 <_Znwm>
    80003ca4:	00050b13          	mv	s6,a0
    80003ca8:	012c0c33          	add	s8,s8,s2
    80003cac:	003c1c13          	slli	s8,s8,0x3
    80003cb0:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80003cb4:	ffffe097          	auipc	ra,0xffffe
    80003cb8:	da0080e7          	jalr	-608(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80003cbc:	00006797          	auipc	a5,0x6
    80003cc0:	40478793          	addi	a5,a5,1028 # 8000a0c0 <_ZTV12ConsumerSync+0x10>
    80003cc4:	00fb3023          	sd	a5,0(s6)
    80003cc8:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80003ccc:	000b0513          	mv	a0,s6
    80003cd0:	ffffe097          	auipc	ra,0xffffe
    80003cd4:	d28080e7          	jalr	-728(ra) # 800019f8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003cd8:	00000493          	li	s1,0
    80003cdc:	0380006f          	j	80003d14 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003ce0:	00006797          	auipc	a5,0x6
    80003ce4:	3b878793          	addi	a5,a5,952 # 8000a098 <_ZTV12ProducerSync+0x10>
    80003ce8:	00fcb023          	sd	a5,0(s9)
    80003cec:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80003cf0:	00349793          	slli	a5,s1,0x3
    80003cf4:	00f987b3          	add	a5,s3,a5
    80003cf8:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80003cfc:	00349793          	slli	a5,s1,0x3
    80003d00:	00f987b3          	add	a5,s3,a5
    80003d04:	0007b503          	ld	a0,0(a5)
    80003d08:	ffffe097          	auipc	ra,0xffffe
    80003d0c:	cf0080e7          	jalr	-784(ra) # 800019f8 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80003d10:	0014849b          	addiw	s1,s1,1
    80003d14:	0b24d063          	bge	s1,s2,80003db4 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80003d18:	00149793          	slli	a5,s1,0x1
    80003d1c:	009787b3          	add	a5,a5,s1
    80003d20:	00379793          	slli	a5,a5,0x3
    80003d24:	00fa07b3          	add	a5,s4,a5
    80003d28:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003d2c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003d30:	00006717          	auipc	a4,0x6
    80003d34:	48873703          	ld	a4,1160(a4) # 8000a1b8 <_ZL10waitForAll>
    80003d38:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80003d3c:	02905863          	blez	s1,80003d6c <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80003d40:	02800513          	li	a0,40
    80003d44:	ffffe097          	auipc	ra,0xffffe
    80003d48:	a8c080e7          	jalr	-1396(ra) # 800017d0 <_Znwm>
    80003d4c:	00050c93          	mv	s9,a0
    80003d50:	00149c13          	slli	s8,s1,0x1
    80003d54:	009c0c33          	add	s8,s8,s1
    80003d58:	003c1c13          	slli	s8,s8,0x3
    80003d5c:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80003d60:	ffffe097          	auipc	ra,0xffffe
    80003d64:	cf4080e7          	jalr	-780(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80003d68:	f79ff06f          	j	80003ce0 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80003d6c:	02800513          	li	a0,40
    80003d70:	ffffe097          	auipc	ra,0xffffe
    80003d74:	a60080e7          	jalr	-1440(ra) # 800017d0 <_Znwm>
    80003d78:	00050c93          	mv	s9,a0
    80003d7c:	00149c13          	slli	s8,s1,0x1
    80003d80:	009c0c33          	add	s8,s8,s1
    80003d84:	003c1c13          	slli	s8,s8,0x3
    80003d88:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003d8c:	ffffe097          	auipc	ra,0xffffe
    80003d90:	cc8080e7          	jalr	-824(ra) # 80001a54 <_ZN6ThreadC1Ev>
    80003d94:	00006797          	auipc	a5,0x6
    80003d98:	2dc78793          	addi	a5,a5,732 # 8000a070 <_ZTV16ProducerKeyboard+0x10>
    80003d9c:	00fcb023          	sd	a5,0(s9)
    80003da0:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80003da4:	00349793          	slli	a5,s1,0x3
    80003da8:	00f987b3          	add	a5,s3,a5
    80003dac:	0197b023          	sd	s9,0(a5)
    80003db0:	f4dff06f          	j	80003cfc <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80003db4:	ffffe097          	auipc	ra,0xffffe
    80003db8:	c78080e7          	jalr	-904(ra) # 80001a2c <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003dbc:	00000493          	li	s1,0
    80003dc0:	00994e63          	blt	s2,s1,80003ddc <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80003dc4:	00006517          	auipc	a0,0x6
    80003dc8:	3f453503          	ld	a0,1012(a0) # 8000a1b8 <_ZL10waitForAll>
    80003dcc:	ffffe097          	auipc	ra,0xffffe
    80003dd0:	ce8080e7          	jalr	-792(ra) # 80001ab4 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003dd4:	0014849b          	addiw	s1,s1,1
    80003dd8:	fe9ff06f          	j	80003dc0 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80003ddc:	00000493          	li	s1,0
    80003de0:	0080006f          	j	80003de8 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80003de4:	0014849b          	addiw	s1,s1,1
    80003de8:	0324d263          	bge	s1,s2,80003e0c <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80003dec:	00349793          	slli	a5,s1,0x3
    80003df0:	00f987b3          	add	a5,s3,a5
    80003df4:	0007b503          	ld	a0,0(a5)
    80003df8:	fe0506e3          	beqz	a0,80003de4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80003dfc:	00053783          	ld	a5,0(a0)
    80003e00:	0087b783          	ld	a5,8(a5)
    80003e04:	000780e7          	jalr	a5
    80003e08:	fddff06f          	j	80003de4 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80003e0c:	000b0a63          	beqz	s6,80003e20 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80003e10:	000b3783          	ld	a5,0(s6)
    80003e14:	0087b783          	ld	a5,8(a5)
    80003e18:	000b0513          	mv	a0,s6
    80003e1c:	000780e7          	jalr	a5
    delete waitForAll;
    80003e20:	00006517          	auipc	a0,0x6
    80003e24:	39853503          	ld	a0,920(a0) # 8000a1b8 <_ZL10waitForAll>
    80003e28:	00050863          	beqz	a0,80003e38 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80003e2c:	00053783          	ld	a5,0(a0)
    80003e30:	0087b783          	ld	a5,8(a5)
    80003e34:	000780e7          	jalr	a5
    delete buffer;
    80003e38:	000a8e63          	beqz	s5,80003e54 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80003e3c:	000a8513          	mv	a0,s5
    80003e40:	00001097          	auipc	ra,0x1
    80003e44:	8a8080e7          	jalr	-1880(ra) # 800046e8 <_ZN9BufferCPPD1Ev>
    80003e48:	000a8513          	mv	a0,s5
    80003e4c:	ffffe097          	auipc	ra,0xffffe
    80003e50:	9d4080e7          	jalr	-1580(ra) # 80001820 <_ZdlPv>
    80003e54:	000b8113          	mv	sp,s7

}
    80003e58:	f8040113          	addi	sp,s0,-128
    80003e5c:	07813083          	ld	ra,120(sp)
    80003e60:	07013403          	ld	s0,112(sp)
    80003e64:	06813483          	ld	s1,104(sp)
    80003e68:	06013903          	ld	s2,96(sp)
    80003e6c:	05813983          	ld	s3,88(sp)
    80003e70:	05013a03          	ld	s4,80(sp)
    80003e74:	04813a83          	ld	s5,72(sp)
    80003e78:	04013b03          	ld	s6,64(sp)
    80003e7c:	03813b83          	ld	s7,56(sp)
    80003e80:	03013c03          	ld	s8,48(sp)
    80003e84:	02813c83          	ld	s9,40(sp)
    80003e88:	08010113          	addi	sp,sp,128
    80003e8c:	00008067          	ret
    80003e90:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003e94:	000a8513          	mv	a0,s5
    80003e98:	ffffe097          	auipc	ra,0xffffe
    80003e9c:	988080e7          	jalr	-1656(ra) # 80001820 <_ZdlPv>
    80003ea0:	00048513          	mv	a0,s1
    80003ea4:	00007097          	auipc	ra,0x7
    80003ea8:	3f4080e7          	jalr	1012(ra) # 8000b298 <_Unwind_Resume>
    80003eac:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80003eb0:	00048513          	mv	a0,s1
    80003eb4:	ffffe097          	auipc	ra,0xffffe
    80003eb8:	96c080e7          	jalr	-1684(ra) # 80001820 <_ZdlPv>
    80003ebc:	00090513          	mv	a0,s2
    80003ec0:	00007097          	auipc	ra,0x7
    80003ec4:	3d8080e7          	jalr	984(ra) # 8000b298 <_Unwind_Resume>
    80003ec8:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80003ecc:	000b0513          	mv	a0,s6
    80003ed0:	ffffe097          	auipc	ra,0xffffe
    80003ed4:	950080e7          	jalr	-1712(ra) # 80001820 <_ZdlPv>
    80003ed8:	00048513          	mv	a0,s1
    80003edc:	00007097          	auipc	ra,0x7
    80003ee0:	3bc080e7          	jalr	956(ra) # 8000b298 <_Unwind_Resume>
    80003ee4:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80003ee8:	000c8513          	mv	a0,s9
    80003eec:	ffffe097          	auipc	ra,0xffffe
    80003ef0:	934080e7          	jalr	-1740(ra) # 80001820 <_ZdlPv>
    80003ef4:	00048513          	mv	a0,s1
    80003ef8:	00007097          	auipc	ra,0x7
    80003efc:	3a0080e7          	jalr	928(ra) # 8000b298 <_Unwind_Resume>
    80003f00:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80003f04:	000c8513          	mv	a0,s9
    80003f08:	ffffe097          	auipc	ra,0xffffe
    80003f0c:	918080e7          	jalr	-1768(ra) # 80001820 <_ZdlPv>
    80003f10:	00048513          	mv	a0,s1
    80003f14:	00007097          	auipc	ra,0x7
    80003f18:	384080e7          	jalr	900(ra) # 8000b298 <_Unwind_Resume>

0000000080003f1c <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80003f1c:	ff010113          	addi	sp,sp,-16
    80003f20:	00113423          	sd	ra,8(sp)
    80003f24:	00813023          	sd	s0,0(sp)
    80003f28:	01010413          	addi	s0,sp,16
    80003f2c:	00006797          	auipc	a5,0x6
    80003f30:	19478793          	addi	a5,a5,404 # 8000a0c0 <_ZTV12ConsumerSync+0x10>
    80003f34:	00f53023          	sd	a5,0(a0)
    80003f38:	ffffe097          	auipc	ra,0xffffe
    80003f3c:	938080e7          	jalr	-1736(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003f40:	00813083          	ld	ra,8(sp)
    80003f44:	00013403          	ld	s0,0(sp)
    80003f48:	01010113          	addi	sp,sp,16
    80003f4c:	00008067          	ret

0000000080003f50 <_ZN12ConsumerSyncD0Ev>:
    80003f50:	fe010113          	addi	sp,sp,-32
    80003f54:	00113c23          	sd	ra,24(sp)
    80003f58:	00813823          	sd	s0,16(sp)
    80003f5c:	00913423          	sd	s1,8(sp)
    80003f60:	02010413          	addi	s0,sp,32
    80003f64:	00050493          	mv	s1,a0
    80003f68:	00006797          	auipc	a5,0x6
    80003f6c:	15878793          	addi	a5,a5,344 # 8000a0c0 <_ZTV12ConsumerSync+0x10>
    80003f70:	00f53023          	sd	a5,0(a0)
    80003f74:	ffffe097          	auipc	ra,0xffffe
    80003f78:	8fc080e7          	jalr	-1796(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003f7c:	00048513          	mv	a0,s1
    80003f80:	ffffe097          	auipc	ra,0xffffe
    80003f84:	8a0080e7          	jalr	-1888(ra) # 80001820 <_ZdlPv>
    80003f88:	01813083          	ld	ra,24(sp)
    80003f8c:	01013403          	ld	s0,16(sp)
    80003f90:	00813483          	ld	s1,8(sp)
    80003f94:	02010113          	addi	sp,sp,32
    80003f98:	00008067          	ret

0000000080003f9c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003f9c:	ff010113          	addi	sp,sp,-16
    80003fa0:	00113423          	sd	ra,8(sp)
    80003fa4:	00813023          	sd	s0,0(sp)
    80003fa8:	01010413          	addi	s0,sp,16
    80003fac:	00006797          	auipc	a5,0x6
    80003fb0:	0ec78793          	addi	a5,a5,236 # 8000a098 <_ZTV12ProducerSync+0x10>
    80003fb4:	00f53023          	sd	a5,0(a0)
    80003fb8:	ffffe097          	auipc	ra,0xffffe
    80003fbc:	8b8080e7          	jalr	-1864(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003fc0:	00813083          	ld	ra,8(sp)
    80003fc4:	00013403          	ld	s0,0(sp)
    80003fc8:	01010113          	addi	sp,sp,16
    80003fcc:	00008067          	ret

0000000080003fd0 <_ZN12ProducerSyncD0Ev>:
    80003fd0:	fe010113          	addi	sp,sp,-32
    80003fd4:	00113c23          	sd	ra,24(sp)
    80003fd8:	00813823          	sd	s0,16(sp)
    80003fdc:	00913423          	sd	s1,8(sp)
    80003fe0:	02010413          	addi	s0,sp,32
    80003fe4:	00050493          	mv	s1,a0
    80003fe8:	00006797          	auipc	a5,0x6
    80003fec:	0b078793          	addi	a5,a5,176 # 8000a098 <_ZTV12ProducerSync+0x10>
    80003ff0:	00f53023          	sd	a5,0(a0)
    80003ff4:	ffffe097          	auipc	ra,0xffffe
    80003ff8:	87c080e7          	jalr	-1924(ra) # 80001870 <_ZN6ThreadD1Ev>
    80003ffc:	00048513          	mv	a0,s1
    80004000:	ffffe097          	auipc	ra,0xffffe
    80004004:	820080e7          	jalr	-2016(ra) # 80001820 <_ZdlPv>
    80004008:	01813083          	ld	ra,24(sp)
    8000400c:	01013403          	ld	s0,16(sp)
    80004010:	00813483          	ld	s1,8(sp)
    80004014:	02010113          	addi	sp,sp,32
    80004018:	00008067          	ret

000000008000401c <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    8000401c:	ff010113          	addi	sp,sp,-16
    80004020:	00113423          	sd	ra,8(sp)
    80004024:	00813023          	sd	s0,0(sp)
    80004028:	01010413          	addi	s0,sp,16
    8000402c:	00006797          	auipc	a5,0x6
    80004030:	04478793          	addi	a5,a5,68 # 8000a070 <_ZTV16ProducerKeyboard+0x10>
    80004034:	00f53023          	sd	a5,0(a0)
    80004038:	ffffe097          	auipc	ra,0xffffe
    8000403c:	838080e7          	jalr	-1992(ra) # 80001870 <_ZN6ThreadD1Ev>
    80004040:	00813083          	ld	ra,8(sp)
    80004044:	00013403          	ld	s0,0(sp)
    80004048:	01010113          	addi	sp,sp,16
    8000404c:	00008067          	ret

0000000080004050 <_ZN16ProducerKeyboardD0Ev>:
    80004050:	fe010113          	addi	sp,sp,-32
    80004054:	00113c23          	sd	ra,24(sp)
    80004058:	00813823          	sd	s0,16(sp)
    8000405c:	00913423          	sd	s1,8(sp)
    80004060:	02010413          	addi	s0,sp,32
    80004064:	00050493          	mv	s1,a0
    80004068:	00006797          	auipc	a5,0x6
    8000406c:	00878793          	addi	a5,a5,8 # 8000a070 <_ZTV16ProducerKeyboard+0x10>
    80004070:	00f53023          	sd	a5,0(a0)
    80004074:	ffffd097          	auipc	ra,0xffffd
    80004078:	7fc080e7          	jalr	2044(ra) # 80001870 <_ZN6ThreadD1Ev>
    8000407c:	00048513          	mv	a0,s1
    80004080:	ffffd097          	auipc	ra,0xffffd
    80004084:	7a0080e7          	jalr	1952(ra) # 80001820 <_ZdlPv>
    80004088:	01813083          	ld	ra,24(sp)
    8000408c:	01013403          	ld	s0,16(sp)
    80004090:	00813483          	ld	s1,8(sp)
    80004094:	02010113          	addi	sp,sp,32
    80004098:	00008067          	ret

000000008000409c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    8000409c:	ff010113          	addi	sp,sp,-16
    800040a0:	00113423          	sd	ra,8(sp)
    800040a4:	00813023          	sd	s0,0(sp)
    800040a8:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    800040ac:	02053583          	ld	a1,32(a0)
    800040b0:	fffff097          	auipc	ra,0xfffff
    800040b4:	7e4080e7          	jalr	2020(ra) # 80003894 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    800040b8:	00813083          	ld	ra,8(sp)
    800040bc:	00013403          	ld	s0,0(sp)
    800040c0:	01010113          	addi	sp,sp,16
    800040c4:	00008067          	ret

00000000800040c8 <_ZN12ProducerSync3runEv>:
    void run() override {
    800040c8:	ff010113          	addi	sp,sp,-16
    800040cc:	00113423          	sd	ra,8(sp)
    800040d0:	00813023          	sd	s0,0(sp)
    800040d4:	01010413          	addi	s0,sp,16
        producer(td);
    800040d8:	02053583          	ld	a1,32(a0)
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	878080e7          	jalr	-1928(ra) # 80003954 <_ZN12ProducerSync8producerEPv>
    }
    800040e4:	00813083          	ld	ra,8(sp)
    800040e8:	00013403          	ld	s0,0(sp)
    800040ec:	01010113          	addi	sp,sp,16
    800040f0:	00008067          	ret

00000000800040f4 <_ZN12ConsumerSync3runEv>:
    void run() override {
    800040f4:	ff010113          	addi	sp,sp,-16
    800040f8:	00113423          	sd	ra,8(sp)
    800040fc:	00813023          	sd	s0,0(sp)
    80004100:	01010413          	addi	s0,sp,16
        consumer(td);
    80004104:	02053583          	ld	a1,32(a0)
    80004108:	00000097          	auipc	ra,0x0
    8000410c:	8e0080e7          	jalr	-1824(ra) # 800039e8 <_ZN12ConsumerSync8consumerEPv>
    }
    80004110:	00813083          	ld	ra,8(sp)
    80004114:	00013403          	ld	s0,0(sp)
    80004118:	01010113          	addi	sp,sp,16
    8000411c:	00008067          	ret

0000000080004120 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80004120:	fe010113          	addi	sp,sp,-32
    80004124:	00113c23          	sd	ra,24(sp)
    80004128:	00813823          	sd	s0,16(sp)
    8000412c:	00913423          	sd	s1,8(sp)
    80004130:	02010413          	addi	s0,sp,32
    80004134:	00050493          	mv	s1,a0
    LOCK();
    80004138:	00100613          	li	a2,1
    8000413c:	00000593          	li	a1,0
    80004140:	00006517          	auipc	a0,0x6
    80004144:	08050513          	addi	a0,a0,128 # 8000a1c0 <lockPrint>
    80004148:	ffffd097          	auipc	ra,0xffffd
    8000414c:	eb8080e7          	jalr	-328(ra) # 80001000 <copy_and_swap>
    80004150:	00050863          	beqz	a0,80004160 <_Z11printStringPKc+0x40>
    80004154:	ffffd097          	auipc	ra,0xffffd
    80004158:	0ec080e7          	jalr	236(ra) # 80001240 <_Z15thread_dispatchv>
    8000415c:	fddff06f          	j	80004138 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80004160:	0004c503          	lbu	a0,0(s1)
    80004164:	00050a63          	beqz	a0,80004178 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004168:	ffffd097          	auipc	ra,0xffffd
    8000416c:	1d8080e7          	jalr	472(ra) # 80001340 <_Z4putcc>
        string++;
    80004170:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004174:	fedff06f          	j	80004160 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004178:	00000613          	li	a2,0
    8000417c:	00100593          	li	a1,1
    80004180:	00006517          	auipc	a0,0x6
    80004184:	04050513          	addi	a0,a0,64 # 8000a1c0 <lockPrint>
    80004188:	ffffd097          	auipc	ra,0xffffd
    8000418c:	e78080e7          	jalr	-392(ra) # 80001000 <copy_and_swap>
    80004190:	fe0514e3          	bnez	a0,80004178 <_Z11printStringPKc+0x58>
}
    80004194:	01813083          	ld	ra,24(sp)
    80004198:	01013403          	ld	s0,16(sp)
    8000419c:	00813483          	ld	s1,8(sp)
    800041a0:	02010113          	addi	sp,sp,32
    800041a4:	00008067          	ret

00000000800041a8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    800041a8:	fd010113          	addi	sp,sp,-48
    800041ac:	02113423          	sd	ra,40(sp)
    800041b0:	02813023          	sd	s0,32(sp)
    800041b4:	00913c23          	sd	s1,24(sp)
    800041b8:	01213823          	sd	s2,16(sp)
    800041bc:	01313423          	sd	s3,8(sp)
    800041c0:	01413023          	sd	s4,0(sp)
    800041c4:	03010413          	addi	s0,sp,48
    800041c8:	00050993          	mv	s3,a0
    800041cc:	00058a13          	mv	s4,a1
    LOCK();
    800041d0:	00100613          	li	a2,1
    800041d4:	00000593          	li	a1,0
    800041d8:	00006517          	auipc	a0,0x6
    800041dc:	fe850513          	addi	a0,a0,-24 # 8000a1c0 <lockPrint>
    800041e0:	ffffd097          	auipc	ra,0xffffd
    800041e4:	e20080e7          	jalr	-480(ra) # 80001000 <copy_and_swap>
    800041e8:	00050863          	beqz	a0,800041f8 <_Z9getStringPci+0x50>
    800041ec:	ffffd097          	auipc	ra,0xffffd
    800041f0:	054080e7          	jalr	84(ra) # 80001240 <_Z15thread_dispatchv>
    800041f4:	fddff06f          	j	800041d0 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800041f8:	00000913          	li	s2,0
    800041fc:	00090493          	mv	s1,s2
    80004200:	0019091b          	addiw	s2,s2,1
    80004204:	03495a63          	bge	s2,s4,80004238 <_Z9getStringPci+0x90>
        cc = getc();
    80004208:	ffffd097          	auipc	ra,0xffffd
    8000420c:	10c080e7          	jalr	268(ra) # 80001314 <_Z4getcv>
        if(cc < 1)
    80004210:	02050463          	beqz	a0,80004238 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80004214:	009984b3          	add	s1,s3,s1
    80004218:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    8000421c:	00a00793          	li	a5,10
    80004220:	00f50a63          	beq	a0,a5,80004234 <_Z9getStringPci+0x8c>
    80004224:	00d00793          	li	a5,13
    80004228:	fcf51ae3          	bne	a0,a5,800041fc <_Z9getStringPci+0x54>
        buf[i++] = c;
    8000422c:	00090493          	mv	s1,s2
    80004230:	0080006f          	j	80004238 <_Z9getStringPci+0x90>
    80004234:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80004238:	009984b3          	add	s1,s3,s1
    8000423c:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80004240:	00000613          	li	a2,0
    80004244:	00100593          	li	a1,1
    80004248:	00006517          	auipc	a0,0x6
    8000424c:	f7850513          	addi	a0,a0,-136 # 8000a1c0 <lockPrint>
    80004250:	ffffd097          	auipc	ra,0xffffd
    80004254:	db0080e7          	jalr	-592(ra) # 80001000 <copy_and_swap>
    80004258:	fe0514e3          	bnez	a0,80004240 <_Z9getStringPci+0x98>
    return buf;
}
    8000425c:	00098513          	mv	a0,s3
    80004260:	02813083          	ld	ra,40(sp)
    80004264:	02013403          	ld	s0,32(sp)
    80004268:	01813483          	ld	s1,24(sp)
    8000426c:	01013903          	ld	s2,16(sp)
    80004270:	00813983          	ld	s3,8(sp)
    80004274:	00013a03          	ld	s4,0(sp)
    80004278:	03010113          	addi	sp,sp,48
    8000427c:	00008067          	ret

0000000080004280 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80004280:	ff010113          	addi	sp,sp,-16
    80004284:	00813423          	sd	s0,8(sp)
    80004288:	01010413          	addi	s0,sp,16
    8000428c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80004290:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80004294:	0006c603          	lbu	a2,0(a3)
    80004298:	fd06071b          	addiw	a4,a2,-48
    8000429c:	0ff77713          	andi	a4,a4,255
    800042a0:	00900793          	li	a5,9
    800042a4:	02e7e063          	bltu	a5,a4,800042c4 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    800042a8:	0025179b          	slliw	a5,a0,0x2
    800042ac:	00a787bb          	addw	a5,a5,a0
    800042b0:	0017979b          	slliw	a5,a5,0x1
    800042b4:	00168693          	addi	a3,a3,1
    800042b8:	00c787bb          	addw	a5,a5,a2
    800042bc:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    800042c0:	fd5ff06f          	j	80004294 <_Z11stringToIntPKc+0x14>
    return n;
}
    800042c4:	00813403          	ld	s0,8(sp)
    800042c8:	01010113          	addi	sp,sp,16
    800042cc:	00008067          	ret

00000000800042d0 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    800042d0:	fc010113          	addi	sp,sp,-64
    800042d4:	02113c23          	sd	ra,56(sp)
    800042d8:	02813823          	sd	s0,48(sp)
    800042dc:	02913423          	sd	s1,40(sp)
    800042e0:	03213023          	sd	s2,32(sp)
    800042e4:	01313c23          	sd	s3,24(sp)
    800042e8:	04010413          	addi	s0,sp,64
    800042ec:	00050493          	mv	s1,a0
    800042f0:	00058913          	mv	s2,a1
    800042f4:	00060993          	mv	s3,a2
    LOCK();
    800042f8:	00100613          	li	a2,1
    800042fc:	00000593          	li	a1,0
    80004300:	00006517          	auipc	a0,0x6
    80004304:	ec050513          	addi	a0,a0,-320 # 8000a1c0 <lockPrint>
    80004308:	ffffd097          	auipc	ra,0xffffd
    8000430c:	cf8080e7          	jalr	-776(ra) # 80001000 <copy_and_swap>
    80004310:	00050863          	beqz	a0,80004320 <_Z8printIntiii+0x50>
    80004314:	ffffd097          	auipc	ra,0xffffd
    80004318:	f2c080e7          	jalr	-212(ra) # 80001240 <_Z15thread_dispatchv>
    8000431c:	fddff06f          	j	800042f8 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80004320:	00098463          	beqz	s3,80004328 <_Z8printIntiii+0x58>
    80004324:	0804c463          	bltz	s1,800043ac <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80004328:	0004851b          	sext.w	a0,s1
    neg = 0;
    8000432c:	00000593          	li	a1,0
    }

    i = 0;
    80004330:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80004334:	0009079b          	sext.w	a5,s2
    80004338:	0325773b          	remuw	a4,a0,s2
    8000433c:	00048613          	mv	a2,s1
    80004340:	0014849b          	addiw	s1,s1,1
    80004344:	02071693          	slli	a3,a4,0x20
    80004348:	0206d693          	srli	a3,a3,0x20
    8000434c:	00006717          	auipc	a4,0x6
    80004350:	d8c70713          	addi	a4,a4,-628 # 8000a0d8 <digits>
    80004354:	00d70733          	add	a4,a4,a3
    80004358:	00074683          	lbu	a3,0(a4)
    8000435c:	fd040713          	addi	a4,s0,-48
    80004360:	00c70733          	add	a4,a4,a2
    80004364:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80004368:	0005071b          	sext.w	a4,a0
    8000436c:	0325553b          	divuw	a0,a0,s2
    80004370:	fcf772e3          	bgeu	a4,a5,80004334 <_Z8printIntiii+0x64>
    if(neg)
    80004374:	00058c63          	beqz	a1,8000438c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80004378:	fd040793          	addi	a5,s0,-48
    8000437c:	009784b3          	add	s1,a5,s1
    80004380:	02d00793          	li	a5,45
    80004384:	fef48823          	sb	a5,-16(s1)
    80004388:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000438c:	fff4849b          	addiw	s1,s1,-1
    80004390:	0204c463          	bltz	s1,800043b8 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80004394:	fd040793          	addi	a5,s0,-48
    80004398:	009787b3          	add	a5,a5,s1
    8000439c:	ff07c503          	lbu	a0,-16(a5)
    800043a0:	ffffd097          	auipc	ra,0xffffd
    800043a4:	fa0080e7          	jalr	-96(ra) # 80001340 <_Z4putcc>
    800043a8:	fe5ff06f          	j	8000438c <_Z8printIntiii+0xbc>
        x = -xx;
    800043ac:	4090053b          	negw	a0,s1
        neg = 1;
    800043b0:	00100593          	li	a1,1
        x = -xx;
    800043b4:	f7dff06f          	j	80004330 <_Z8printIntiii+0x60>

    UNLOCK();
    800043b8:	00000613          	li	a2,0
    800043bc:	00100593          	li	a1,1
    800043c0:	00006517          	auipc	a0,0x6
    800043c4:	e0050513          	addi	a0,a0,-512 # 8000a1c0 <lockPrint>
    800043c8:	ffffd097          	auipc	ra,0xffffd
    800043cc:	c38080e7          	jalr	-968(ra) # 80001000 <copy_and_swap>
    800043d0:	fe0514e3          	bnez	a0,800043b8 <_Z8printIntiii+0xe8>
    800043d4:	03813083          	ld	ra,56(sp)
    800043d8:	03013403          	ld	s0,48(sp)
    800043dc:	02813483          	ld	s1,40(sp)
    800043e0:	02013903          	ld	s2,32(sp)
    800043e4:	01813983          	ld	s3,24(sp)
    800043e8:	04010113          	addi	sp,sp,64
    800043ec:	00008067          	ret

00000000800043f0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800043f0:	fd010113          	addi	sp,sp,-48
    800043f4:	02113423          	sd	ra,40(sp)
    800043f8:	02813023          	sd	s0,32(sp)
    800043fc:	00913c23          	sd	s1,24(sp)
    80004400:	01213823          	sd	s2,16(sp)
    80004404:	01313423          	sd	s3,8(sp)
    80004408:	03010413          	addi	s0,sp,48
    8000440c:	00050493          	mv	s1,a0
    80004410:	00058913          	mv	s2,a1
    80004414:	0015879b          	addiw	a5,a1,1
    80004418:	0007851b          	sext.w	a0,a5
    8000441c:	00f4a023          	sw	a5,0(s1)
    80004420:	0004a823          	sw	zero,16(s1)
    80004424:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004428:	00251513          	slli	a0,a0,0x2
    8000442c:	ffffd097          	auipc	ra,0xffffd
    80004430:	d18080e7          	jalr	-744(ra) # 80001144 <_Z9mem_allocm>
    80004434:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80004438:	01000513          	li	a0,16
    8000443c:	ffffd097          	auipc	ra,0xffffd
    80004440:	394080e7          	jalr	916(ra) # 800017d0 <_Znwm>
    80004444:	00050993          	mv	s3,a0
    80004448:	00000593          	li	a1,0
    8000444c:	ffffd097          	auipc	ra,0xffffd
    80004450:	6c0080e7          	jalr	1728(ra) # 80001b0c <_ZN9SemaphoreC1Ej>
    80004454:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80004458:	01000513          	li	a0,16
    8000445c:	ffffd097          	auipc	ra,0xffffd
    80004460:	374080e7          	jalr	884(ra) # 800017d0 <_Znwm>
    80004464:	00050993          	mv	s3,a0
    80004468:	00090593          	mv	a1,s2
    8000446c:	ffffd097          	auipc	ra,0xffffd
    80004470:	6a0080e7          	jalr	1696(ra) # 80001b0c <_ZN9SemaphoreC1Ej>
    80004474:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80004478:	01000513          	li	a0,16
    8000447c:	ffffd097          	auipc	ra,0xffffd
    80004480:	354080e7          	jalr	852(ra) # 800017d0 <_Znwm>
    80004484:	00050913          	mv	s2,a0
    80004488:	00100593          	li	a1,1
    8000448c:	ffffd097          	auipc	ra,0xffffd
    80004490:	680080e7          	jalr	1664(ra) # 80001b0c <_ZN9SemaphoreC1Ej>
    80004494:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80004498:	01000513          	li	a0,16
    8000449c:	ffffd097          	auipc	ra,0xffffd
    800044a0:	334080e7          	jalr	820(ra) # 800017d0 <_Znwm>
    800044a4:	00050913          	mv	s2,a0
    800044a8:	00100593          	li	a1,1
    800044ac:	ffffd097          	auipc	ra,0xffffd
    800044b0:	660080e7          	jalr	1632(ra) # 80001b0c <_ZN9SemaphoreC1Ej>
    800044b4:	0324b823          	sd	s2,48(s1)
}
    800044b8:	02813083          	ld	ra,40(sp)
    800044bc:	02013403          	ld	s0,32(sp)
    800044c0:	01813483          	ld	s1,24(sp)
    800044c4:	01013903          	ld	s2,16(sp)
    800044c8:	00813983          	ld	s3,8(sp)
    800044cc:	03010113          	addi	sp,sp,48
    800044d0:	00008067          	ret
    800044d4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    800044d8:	00098513          	mv	a0,s3
    800044dc:	ffffd097          	auipc	ra,0xffffd
    800044e0:	344080e7          	jalr	836(ra) # 80001820 <_ZdlPv>
    800044e4:	00048513          	mv	a0,s1
    800044e8:	00007097          	auipc	ra,0x7
    800044ec:	db0080e7          	jalr	-592(ra) # 8000b298 <_Unwind_Resume>
    800044f0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    800044f4:	00098513          	mv	a0,s3
    800044f8:	ffffd097          	auipc	ra,0xffffd
    800044fc:	328080e7          	jalr	808(ra) # 80001820 <_ZdlPv>
    80004500:	00048513          	mv	a0,s1
    80004504:	00007097          	auipc	ra,0x7
    80004508:	d94080e7          	jalr	-620(ra) # 8000b298 <_Unwind_Resume>
    8000450c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80004510:	00090513          	mv	a0,s2
    80004514:	ffffd097          	auipc	ra,0xffffd
    80004518:	30c080e7          	jalr	780(ra) # 80001820 <_ZdlPv>
    8000451c:	00048513          	mv	a0,s1
    80004520:	00007097          	auipc	ra,0x7
    80004524:	d78080e7          	jalr	-648(ra) # 8000b298 <_Unwind_Resume>
    80004528:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    8000452c:	00090513          	mv	a0,s2
    80004530:	ffffd097          	auipc	ra,0xffffd
    80004534:	2f0080e7          	jalr	752(ra) # 80001820 <_ZdlPv>
    80004538:	00048513          	mv	a0,s1
    8000453c:	00007097          	auipc	ra,0x7
    80004540:	d5c080e7          	jalr	-676(ra) # 8000b298 <_Unwind_Resume>

0000000080004544 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80004544:	fe010113          	addi	sp,sp,-32
    80004548:	00113c23          	sd	ra,24(sp)
    8000454c:	00813823          	sd	s0,16(sp)
    80004550:	00913423          	sd	s1,8(sp)
    80004554:	01213023          	sd	s2,0(sp)
    80004558:	02010413          	addi	s0,sp,32
    8000455c:	00050493          	mv	s1,a0
    80004560:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80004564:	01853503          	ld	a0,24(a0)
    80004568:	ffffd097          	auipc	ra,0xffffd
    8000456c:	54c080e7          	jalr	1356(ra) # 80001ab4 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80004570:	0304b503          	ld	a0,48(s1)
    80004574:	ffffd097          	auipc	ra,0xffffd
    80004578:	540080e7          	jalr	1344(ra) # 80001ab4 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    8000457c:	0084b783          	ld	a5,8(s1)
    80004580:	0144a703          	lw	a4,20(s1)
    80004584:	00271713          	slli	a4,a4,0x2
    80004588:	00e787b3          	add	a5,a5,a4
    8000458c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004590:	0144a783          	lw	a5,20(s1)
    80004594:	0017879b          	addiw	a5,a5,1
    80004598:	0004a703          	lw	a4,0(s1)
    8000459c:	02e7e7bb          	remw	a5,a5,a4
    800045a0:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    800045a4:	0304b503          	ld	a0,48(s1)
    800045a8:	ffffd097          	auipc	ra,0xffffd
    800045ac:	538080e7          	jalr	1336(ra) # 80001ae0 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    800045b0:	0204b503          	ld	a0,32(s1)
    800045b4:	ffffd097          	auipc	ra,0xffffd
    800045b8:	52c080e7          	jalr	1324(ra) # 80001ae0 <_ZN9Semaphore6signalEv>

}
    800045bc:	01813083          	ld	ra,24(sp)
    800045c0:	01013403          	ld	s0,16(sp)
    800045c4:	00813483          	ld	s1,8(sp)
    800045c8:	00013903          	ld	s2,0(sp)
    800045cc:	02010113          	addi	sp,sp,32
    800045d0:	00008067          	ret

00000000800045d4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    800045d4:	fe010113          	addi	sp,sp,-32
    800045d8:	00113c23          	sd	ra,24(sp)
    800045dc:	00813823          	sd	s0,16(sp)
    800045e0:	00913423          	sd	s1,8(sp)
    800045e4:	01213023          	sd	s2,0(sp)
    800045e8:	02010413          	addi	s0,sp,32
    800045ec:	00050493          	mv	s1,a0
    itemAvailable->wait();
    800045f0:	02053503          	ld	a0,32(a0)
    800045f4:	ffffd097          	auipc	ra,0xffffd
    800045f8:	4c0080e7          	jalr	1216(ra) # 80001ab4 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    800045fc:	0284b503          	ld	a0,40(s1)
    80004600:	ffffd097          	auipc	ra,0xffffd
    80004604:	4b4080e7          	jalr	1204(ra) # 80001ab4 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80004608:	0084b703          	ld	a4,8(s1)
    8000460c:	0104a783          	lw	a5,16(s1)
    80004610:	00279693          	slli	a3,a5,0x2
    80004614:	00d70733          	add	a4,a4,a3
    80004618:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000461c:	0017879b          	addiw	a5,a5,1
    80004620:	0004a703          	lw	a4,0(s1)
    80004624:	02e7e7bb          	remw	a5,a5,a4
    80004628:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    8000462c:	0284b503          	ld	a0,40(s1)
    80004630:	ffffd097          	auipc	ra,0xffffd
    80004634:	4b0080e7          	jalr	1200(ra) # 80001ae0 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80004638:	0184b503          	ld	a0,24(s1)
    8000463c:	ffffd097          	auipc	ra,0xffffd
    80004640:	4a4080e7          	jalr	1188(ra) # 80001ae0 <_ZN9Semaphore6signalEv>

    return ret;
}
    80004644:	00090513          	mv	a0,s2
    80004648:	01813083          	ld	ra,24(sp)
    8000464c:	01013403          	ld	s0,16(sp)
    80004650:	00813483          	ld	s1,8(sp)
    80004654:	00013903          	ld	s2,0(sp)
    80004658:	02010113          	addi	sp,sp,32
    8000465c:	00008067          	ret

0000000080004660 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80004660:	fe010113          	addi	sp,sp,-32
    80004664:	00113c23          	sd	ra,24(sp)
    80004668:	00813823          	sd	s0,16(sp)
    8000466c:	00913423          	sd	s1,8(sp)
    80004670:	01213023          	sd	s2,0(sp)
    80004674:	02010413          	addi	s0,sp,32
    80004678:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    8000467c:	02853503          	ld	a0,40(a0)
    80004680:	ffffd097          	auipc	ra,0xffffd
    80004684:	434080e7          	jalr	1076(ra) # 80001ab4 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80004688:	0304b503          	ld	a0,48(s1)
    8000468c:	ffffd097          	auipc	ra,0xffffd
    80004690:	428080e7          	jalr	1064(ra) # 80001ab4 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80004694:	0144a783          	lw	a5,20(s1)
    80004698:	0104a903          	lw	s2,16(s1)
    8000469c:	0327ce63          	blt	a5,s2,800046d8 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    800046a0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    800046a4:	0304b503          	ld	a0,48(s1)
    800046a8:	ffffd097          	auipc	ra,0xffffd
    800046ac:	438080e7          	jalr	1080(ra) # 80001ae0 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    800046b0:	0284b503          	ld	a0,40(s1)
    800046b4:	ffffd097          	auipc	ra,0xffffd
    800046b8:	42c080e7          	jalr	1068(ra) # 80001ae0 <_ZN9Semaphore6signalEv>

    return ret;
}
    800046bc:	00090513          	mv	a0,s2
    800046c0:	01813083          	ld	ra,24(sp)
    800046c4:	01013403          	ld	s0,16(sp)
    800046c8:	00813483          	ld	s1,8(sp)
    800046cc:	00013903          	ld	s2,0(sp)
    800046d0:	02010113          	addi	sp,sp,32
    800046d4:	00008067          	ret
        ret = cap - head + tail;
    800046d8:	0004a703          	lw	a4,0(s1)
    800046dc:	4127093b          	subw	s2,a4,s2
    800046e0:	00f9093b          	addw	s2,s2,a5
    800046e4:	fc1ff06f          	j	800046a4 <_ZN9BufferCPP6getCntEv+0x44>

00000000800046e8 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    800046e8:	fe010113          	addi	sp,sp,-32
    800046ec:	00113c23          	sd	ra,24(sp)
    800046f0:	00813823          	sd	s0,16(sp)
    800046f4:	00913423          	sd	s1,8(sp)
    800046f8:	02010413          	addi	s0,sp,32
    800046fc:	00050493          	mv	s1,a0
    Console::putc('\n');
    80004700:	00a00513          	li	a0,10
    80004704:	ffffd097          	auipc	ra,0xffffd
    80004708:	278080e7          	jalr	632(ra) # 8000197c <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    8000470c:	00004517          	auipc	a0,0x4
    80004710:	eb450513          	addi	a0,a0,-332 # 800085c0 <CONSOLE_STATUS+0x5b0>
    80004714:	00000097          	auipc	ra,0x0
    80004718:	a0c080e7          	jalr	-1524(ra) # 80004120 <_Z11printStringPKc>
    while (getCnt()) {
    8000471c:	00048513          	mv	a0,s1
    80004720:	00000097          	auipc	ra,0x0
    80004724:	f40080e7          	jalr	-192(ra) # 80004660 <_ZN9BufferCPP6getCntEv>
    80004728:	02050c63          	beqz	a0,80004760 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    8000472c:	0084b783          	ld	a5,8(s1)
    80004730:	0104a703          	lw	a4,16(s1)
    80004734:	00271713          	slli	a4,a4,0x2
    80004738:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    8000473c:	0007c503          	lbu	a0,0(a5)
    80004740:	ffffd097          	auipc	ra,0xffffd
    80004744:	23c080e7          	jalr	572(ra) # 8000197c <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80004748:	0104a783          	lw	a5,16(s1)
    8000474c:	0017879b          	addiw	a5,a5,1
    80004750:	0004a703          	lw	a4,0(s1)
    80004754:	02e7e7bb          	remw	a5,a5,a4
    80004758:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    8000475c:	fc1ff06f          	j	8000471c <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80004760:	02100513          	li	a0,33
    80004764:	ffffd097          	auipc	ra,0xffffd
    80004768:	218080e7          	jalr	536(ra) # 8000197c <_ZN7Console4putcEc>
    Console::putc('\n');
    8000476c:	00a00513          	li	a0,10
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	20c080e7          	jalr	524(ra) # 8000197c <_ZN7Console4putcEc>
    mem_free(buffer);
    80004778:	0084b503          	ld	a0,8(s1)
    8000477c:	ffffd097          	auipc	ra,0xffffd
    80004780:	9f0080e7          	jalr	-1552(ra) # 8000116c <_Z8mem_freePv>
    delete itemAvailable;
    80004784:	0204b503          	ld	a0,32(s1)
    80004788:	00050863          	beqz	a0,80004798 <_ZN9BufferCPPD1Ev+0xb0>
    8000478c:	00053783          	ld	a5,0(a0)
    80004790:	0087b783          	ld	a5,8(a5)
    80004794:	000780e7          	jalr	a5
    delete spaceAvailable;
    80004798:	0184b503          	ld	a0,24(s1)
    8000479c:	00050863          	beqz	a0,800047ac <_ZN9BufferCPPD1Ev+0xc4>
    800047a0:	00053783          	ld	a5,0(a0)
    800047a4:	0087b783          	ld	a5,8(a5)
    800047a8:	000780e7          	jalr	a5
    delete mutexTail;
    800047ac:	0304b503          	ld	a0,48(s1)
    800047b0:	00050863          	beqz	a0,800047c0 <_ZN9BufferCPPD1Ev+0xd8>
    800047b4:	00053783          	ld	a5,0(a0)
    800047b8:	0087b783          	ld	a5,8(a5)
    800047bc:	000780e7          	jalr	a5
    delete mutexHead;
    800047c0:	0284b503          	ld	a0,40(s1)
    800047c4:	00050863          	beqz	a0,800047d4 <_ZN9BufferCPPD1Ev+0xec>
    800047c8:	00053783          	ld	a5,0(a0)
    800047cc:	0087b783          	ld	a5,8(a5)
    800047d0:	000780e7          	jalr	a5
}
    800047d4:	01813083          	ld	ra,24(sp)
    800047d8:	01013403          	ld	s0,16(sp)
    800047dc:	00813483          	ld	s1,8(sp)
    800047e0:	02010113          	addi	sp,sp,32
    800047e4:	00008067          	ret

00000000800047e8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800047e8:	fe010113          	addi	sp,sp,-32
    800047ec:	00113c23          	sd	ra,24(sp)
    800047f0:	00813823          	sd	s0,16(sp)
    800047f4:	00913423          	sd	s1,8(sp)
    800047f8:	01213023          	sd	s2,0(sp)
    800047fc:	02010413          	addi	s0,sp,32
    80004800:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004804:	00100793          	li	a5,1
    80004808:	02a7f863          	bgeu	a5,a0,80004838 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000480c:	00a00793          	li	a5,10
    80004810:	02f577b3          	remu	a5,a0,a5
    80004814:	02078e63          	beqz	a5,80004850 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004818:	fff48513          	addi	a0,s1,-1
    8000481c:	00000097          	auipc	ra,0x0
    80004820:	fcc080e7          	jalr	-52(ra) # 800047e8 <_ZL9fibonaccim>
    80004824:	00050913          	mv	s2,a0
    80004828:	ffe48513          	addi	a0,s1,-2
    8000482c:	00000097          	auipc	ra,0x0
    80004830:	fbc080e7          	jalr	-68(ra) # 800047e8 <_ZL9fibonaccim>
    80004834:	00a90533          	add	a0,s2,a0
}
    80004838:	01813083          	ld	ra,24(sp)
    8000483c:	01013403          	ld	s0,16(sp)
    80004840:	00813483          	ld	s1,8(sp)
    80004844:	00013903          	ld	s2,0(sp)
    80004848:	02010113          	addi	sp,sp,32
    8000484c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004850:	ffffd097          	auipc	ra,0xffffd
    80004854:	9f0080e7          	jalr	-1552(ra) # 80001240 <_Z15thread_dispatchv>
    80004858:	fc1ff06f          	j	80004818 <_ZL9fibonaccim+0x30>

000000008000485c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000485c:	fe010113          	addi	sp,sp,-32
    80004860:	00113c23          	sd	ra,24(sp)
    80004864:	00813823          	sd	s0,16(sp)
    80004868:	00913423          	sd	s1,8(sp)
    8000486c:	01213023          	sd	s2,0(sp)
    80004870:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004874:	00a00493          	li	s1,10
    80004878:	0400006f          	j	800048b8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000487c:	00004517          	auipc	a0,0x4
    80004880:	c9c50513          	addi	a0,a0,-868 # 80008518 <CONSOLE_STATUS+0x508>
    80004884:	00000097          	auipc	ra,0x0
    80004888:	89c080e7          	jalr	-1892(ra) # 80004120 <_Z11printStringPKc>
    8000488c:	00000613          	li	a2,0
    80004890:	00a00593          	li	a1,10
    80004894:	00048513          	mv	a0,s1
    80004898:	00000097          	auipc	ra,0x0
    8000489c:	a38080e7          	jalr	-1480(ra) # 800042d0 <_Z8printIntiii>
    800048a0:	00004517          	auipc	a0,0x4
    800048a4:	90850513          	addi	a0,a0,-1784 # 800081a8 <CONSOLE_STATUS+0x198>
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	878080e7          	jalr	-1928(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800048b0:	0014849b          	addiw	s1,s1,1
    800048b4:	0ff4f493          	andi	s1,s1,255
    800048b8:	00c00793          	li	a5,12
    800048bc:	fc97f0e3          	bgeu	a5,s1,8000487c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800048c0:	00004517          	auipc	a0,0x4
    800048c4:	c6050513          	addi	a0,a0,-928 # 80008520 <CONSOLE_STATUS+0x510>
    800048c8:	00000097          	auipc	ra,0x0
    800048cc:	858080e7          	jalr	-1960(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800048d0:	00500313          	li	t1,5
    thread_dispatch();
    800048d4:	ffffd097          	auipc	ra,0xffffd
    800048d8:	96c080e7          	jalr	-1684(ra) # 80001240 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800048dc:	01000513          	li	a0,16
    800048e0:	00000097          	auipc	ra,0x0
    800048e4:	f08080e7          	jalr	-248(ra) # 800047e8 <_ZL9fibonaccim>
    800048e8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800048ec:	00004517          	auipc	a0,0x4
    800048f0:	c4450513          	addi	a0,a0,-956 # 80008530 <CONSOLE_STATUS+0x520>
    800048f4:	00000097          	auipc	ra,0x0
    800048f8:	82c080e7          	jalr	-2004(ra) # 80004120 <_Z11printStringPKc>
    800048fc:	00000613          	li	a2,0
    80004900:	00a00593          	li	a1,10
    80004904:	0009051b          	sext.w	a0,s2
    80004908:	00000097          	auipc	ra,0x0
    8000490c:	9c8080e7          	jalr	-1592(ra) # 800042d0 <_Z8printIntiii>
    80004910:	00004517          	auipc	a0,0x4
    80004914:	89850513          	addi	a0,a0,-1896 # 800081a8 <CONSOLE_STATUS+0x198>
    80004918:	00000097          	auipc	ra,0x0
    8000491c:	808080e7          	jalr	-2040(ra) # 80004120 <_Z11printStringPKc>
    80004920:	0400006f          	j	80004960 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004924:	00004517          	auipc	a0,0x4
    80004928:	bf450513          	addi	a0,a0,-1036 # 80008518 <CONSOLE_STATUS+0x508>
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	7f4080e7          	jalr	2036(ra) # 80004120 <_Z11printStringPKc>
    80004934:	00000613          	li	a2,0
    80004938:	00a00593          	li	a1,10
    8000493c:	00048513          	mv	a0,s1
    80004940:	00000097          	auipc	ra,0x0
    80004944:	990080e7          	jalr	-1648(ra) # 800042d0 <_Z8printIntiii>
    80004948:	00004517          	auipc	a0,0x4
    8000494c:	86050513          	addi	a0,a0,-1952 # 800081a8 <CONSOLE_STATUS+0x198>
    80004950:	fffff097          	auipc	ra,0xfffff
    80004954:	7d0080e7          	jalr	2000(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004958:	0014849b          	addiw	s1,s1,1
    8000495c:	0ff4f493          	andi	s1,s1,255
    80004960:	00f00793          	li	a5,15
    80004964:	fc97f0e3          	bgeu	a5,s1,80004924 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004968:	00004517          	auipc	a0,0x4
    8000496c:	bd850513          	addi	a0,a0,-1064 # 80008540 <CONSOLE_STATUS+0x530>
    80004970:	fffff097          	auipc	ra,0xfffff
    80004974:	7b0080e7          	jalr	1968(ra) # 80004120 <_Z11printStringPKc>
    finishedD = true;
    80004978:	00100793          	li	a5,1
    8000497c:	00006717          	auipc	a4,0x6
    80004980:	84f70623          	sb	a5,-1972(a4) # 8000a1c8 <_ZL9finishedD>
    thread_dispatch();
    80004984:	ffffd097          	auipc	ra,0xffffd
    80004988:	8bc080e7          	jalr	-1860(ra) # 80001240 <_Z15thread_dispatchv>
}
    8000498c:	01813083          	ld	ra,24(sp)
    80004990:	01013403          	ld	s0,16(sp)
    80004994:	00813483          	ld	s1,8(sp)
    80004998:	00013903          	ld	s2,0(sp)
    8000499c:	02010113          	addi	sp,sp,32
    800049a0:	00008067          	ret

00000000800049a4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800049a4:	fe010113          	addi	sp,sp,-32
    800049a8:	00113c23          	sd	ra,24(sp)
    800049ac:	00813823          	sd	s0,16(sp)
    800049b0:	00913423          	sd	s1,8(sp)
    800049b4:	01213023          	sd	s2,0(sp)
    800049b8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800049bc:	00000493          	li	s1,0
    800049c0:	0400006f          	j	80004a00 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800049c4:	00004517          	auipc	a0,0x4
    800049c8:	b2450513          	addi	a0,a0,-1244 # 800084e8 <CONSOLE_STATUS+0x4d8>
    800049cc:	fffff097          	auipc	ra,0xfffff
    800049d0:	754080e7          	jalr	1876(ra) # 80004120 <_Z11printStringPKc>
    800049d4:	00000613          	li	a2,0
    800049d8:	00a00593          	li	a1,10
    800049dc:	00048513          	mv	a0,s1
    800049e0:	00000097          	auipc	ra,0x0
    800049e4:	8f0080e7          	jalr	-1808(ra) # 800042d0 <_Z8printIntiii>
    800049e8:	00003517          	auipc	a0,0x3
    800049ec:	7c050513          	addi	a0,a0,1984 # 800081a8 <CONSOLE_STATUS+0x198>
    800049f0:	fffff097          	auipc	ra,0xfffff
    800049f4:	730080e7          	jalr	1840(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 3; i++) {
    800049f8:	0014849b          	addiw	s1,s1,1
    800049fc:	0ff4f493          	andi	s1,s1,255
    80004a00:	00200793          	li	a5,2
    80004a04:	fc97f0e3          	bgeu	a5,s1,800049c4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004a08:	00004517          	auipc	a0,0x4
    80004a0c:	ae850513          	addi	a0,a0,-1304 # 800084f0 <CONSOLE_STATUS+0x4e0>
    80004a10:	fffff097          	auipc	ra,0xfffff
    80004a14:	710080e7          	jalr	1808(ra) # 80004120 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004a18:	00700313          	li	t1,7
    thread_dispatch();
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	824080e7          	jalr	-2012(ra) # 80001240 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004a24:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004a28:	00004517          	auipc	a0,0x4
    80004a2c:	ad850513          	addi	a0,a0,-1320 # 80008500 <CONSOLE_STATUS+0x4f0>
    80004a30:	fffff097          	auipc	ra,0xfffff
    80004a34:	6f0080e7          	jalr	1776(ra) # 80004120 <_Z11printStringPKc>
    80004a38:	00000613          	li	a2,0
    80004a3c:	00a00593          	li	a1,10
    80004a40:	0009051b          	sext.w	a0,s2
    80004a44:	00000097          	auipc	ra,0x0
    80004a48:	88c080e7          	jalr	-1908(ra) # 800042d0 <_Z8printIntiii>
    80004a4c:	00003517          	auipc	a0,0x3
    80004a50:	75c50513          	addi	a0,a0,1884 # 800081a8 <CONSOLE_STATUS+0x198>
    80004a54:	fffff097          	auipc	ra,0xfffff
    80004a58:	6cc080e7          	jalr	1740(ra) # 80004120 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80004a5c:	00c00513          	li	a0,12
    80004a60:	00000097          	auipc	ra,0x0
    80004a64:	d88080e7          	jalr	-632(ra) # 800047e8 <_ZL9fibonaccim>
    80004a68:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004a6c:	00004517          	auipc	a0,0x4
    80004a70:	a9c50513          	addi	a0,a0,-1380 # 80008508 <CONSOLE_STATUS+0x4f8>
    80004a74:	fffff097          	auipc	ra,0xfffff
    80004a78:	6ac080e7          	jalr	1708(ra) # 80004120 <_Z11printStringPKc>
    80004a7c:	00000613          	li	a2,0
    80004a80:	00a00593          	li	a1,10
    80004a84:	0009051b          	sext.w	a0,s2
    80004a88:	00000097          	auipc	ra,0x0
    80004a8c:	848080e7          	jalr	-1976(ra) # 800042d0 <_Z8printIntiii>
    80004a90:	00003517          	auipc	a0,0x3
    80004a94:	71850513          	addi	a0,a0,1816 # 800081a8 <CONSOLE_STATUS+0x198>
    80004a98:	fffff097          	auipc	ra,0xfffff
    80004a9c:	688080e7          	jalr	1672(ra) # 80004120 <_Z11printStringPKc>
    80004aa0:	0400006f          	j	80004ae0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004aa4:	00004517          	auipc	a0,0x4
    80004aa8:	a4450513          	addi	a0,a0,-1468 # 800084e8 <CONSOLE_STATUS+0x4d8>
    80004aac:	fffff097          	auipc	ra,0xfffff
    80004ab0:	674080e7          	jalr	1652(ra) # 80004120 <_Z11printStringPKc>
    80004ab4:	00000613          	li	a2,0
    80004ab8:	00a00593          	li	a1,10
    80004abc:	00048513          	mv	a0,s1
    80004ac0:	00000097          	auipc	ra,0x0
    80004ac4:	810080e7          	jalr	-2032(ra) # 800042d0 <_Z8printIntiii>
    80004ac8:	00003517          	auipc	a0,0x3
    80004acc:	6e050513          	addi	a0,a0,1760 # 800081a8 <CONSOLE_STATUS+0x198>
    80004ad0:	fffff097          	auipc	ra,0xfffff
    80004ad4:	650080e7          	jalr	1616(ra) # 80004120 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004ad8:	0014849b          	addiw	s1,s1,1
    80004adc:	0ff4f493          	andi	s1,s1,255
    80004ae0:	00500793          	li	a5,5
    80004ae4:	fc97f0e3          	bgeu	a5,s1,80004aa4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004ae8:	00004517          	auipc	a0,0x4
    80004aec:	9d850513          	addi	a0,a0,-1576 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80004af0:	fffff097          	auipc	ra,0xfffff
    80004af4:	630080e7          	jalr	1584(ra) # 80004120 <_Z11printStringPKc>
    finishedC = true;
    80004af8:	00100793          	li	a5,1
    80004afc:	00005717          	auipc	a4,0x5
    80004b00:	6cf706a3          	sb	a5,1741(a4) # 8000a1c9 <_ZL9finishedC>
    thread_dispatch();
    80004b04:	ffffc097          	auipc	ra,0xffffc
    80004b08:	73c080e7          	jalr	1852(ra) # 80001240 <_Z15thread_dispatchv>
}
    80004b0c:	01813083          	ld	ra,24(sp)
    80004b10:	01013403          	ld	s0,16(sp)
    80004b14:	00813483          	ld	s1,8(sp)
    80004b18:	00013903          	ld	s2,0(sp)
    80004b1c:	02010113          	addi	sp,sp,32
    80004b20:	00008067          	ret

0000000080004b24 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004b24:	fe010113          	addi	sp,sp,-32
    80004b28:	00113c23          	sd	ra,24(sp)
    80004b2c:	00813823          	sd	s0,16(sp)
    80004b30:	00913423          	sd	s1,8(sp)
    80004b34:	01213023          	sd	s2,0(sp)
    80004b38:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004b3c:	00000913          	li	s2,0
    80004b40:	0400006f          	j	80004b80 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80004b44:	ffffc097          	auipc	ra,0xffffc
    80004b48:	6fc080e7          	jalr	1788(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004b4c:	00148493          	addi	s1,s1,1
    80004b50:	000027b7          	lui	a5,0x2
    80004b54:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004b58:	0097ee63          	bltu	a5,s1,80004b74 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004b5c:	00000713          	li	a4,0
    80004b60:	000077b7          	lui	a5,0x7
    80004b64:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004b68:	fce7eee3          	bltu	a5,a4,80004b44 <_ZL11workerBodyBPv+0x20>
    80004b6c:	00170713          	addi	a4,a4,1
    80004b70:	ff1ff06f          	j	80004b60 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    80004b74:	00a00793          	li	a5,10
    80004b78:	04f90663          	beq	s2,a5,80004bc4 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    80004b7c:	00190913          	addi	s2,s2,1
    80004b80:	00f00793          	li	a5,15
    80004b84:	0527e463          	bltu	a5,s2,80004bcc <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    80004b88:	00004517          	auipc	a0,0x4
    80004b8c:	94850513          	addi	a0,a0,-1720 # 800084d0 <CONSOLE_STATUS+0x4c0>
    80004b90:	fffff097          	auipc	ra,0xfffff
    80004b94:	590080e7          	jalr	1424(ra) # 80004120 <_Z11printStringPKc>
    80004b98:	00000613          	li	a2,0
    80004b9c:	00a00593          	li	a1,10
    80004ba0:	0009051b          	sext.w	a0,s2
    80004ba4:	fffff097          	auipc	ra,0xfffff
    80004ba8:	72c080e7          	jalr	1836(ra) # 800042d0 <_Z8printIntiii>
    80004bac:	00003517          	auipc	a0,0x3
    80004bb0:	5fc50513          	addi	a0,a0,1532 # 800081a8 <CONSOLE_STATUS+0x198>
    80004bb4:	fffff097          	auipc	ra,0xfffff
    80004bb8:	56c080e7          	jalr	1388(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004bbc:	00000493          	li	s1,0
    80004bc0:	f91ff06f          	j	80004b50 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80004bc4:	14102ff3          	csrr	t6,sepc
    80004bc8:	fb5ff06f          	j	80004b7c <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80004bcc:	00004517          	auipc	a0,0x4
    80004bd0:	90c50513          	addi	a0,a0,-1780 # 800084d8 <CONSOLE_STATUS+0x4c8>
    80004bd4:	fffff097          	auipc	ra,0xfffff
    80004bd8:	54c080e7          	jalr	1356(ra) # 80004120 <_Z11printStringPKc>
    finishedB = true;
    80004bdc:	00100793          	li	a5,1
    80004be0:	00005717          	auipc	a4,0x5
    80004be4:	5ef70523          	sb	a5,1514(a4) # 8000a1ca <_ZL9finishedB>
    thread_dispatch();
    80004be8:	ffffc097          	auipc	ra,0xffffc
    80004bec:	658080e7          	jalr	1624(ra) # 80001240 <_Z15thread_dispatchv>
}
    80004bf0:	01813083          	ld	ra,24(sp)
    80004bf4:	01013403          	ld	s0,16(sp)
    80004bf8:	00813483          	ld	s1,8(sp)
    80004bfc:	00013903          	ld	s2,0(sp)
    80004c00:	02010113          	addi	sp,sp,32
    80004c04:	00008067          	ret

0000000080004c08 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004c08:	fe010113          	addi	sp,sp,-32
    80004c0c:	00113c23          	sd	ra,24(sp)
    80004c10:	00813823          	sd	s0,16(sp)
    80004c14:	00913423          	sd	s1,8(sp)
    80004c18:	01213023          	sd	s2,0(sp)
    80004c1c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004c20:	00000913          	li	s2,0
    80004c24:	0380006f          	j	80004c5c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004c28:	ffffc097          	auipc	ra,0xffffc
    80004c2c:	618080e7          	jalr	1560(ra) # 80001240 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004c30:	00148493          	addi	s1,s1,1
    80004c34:	000027b7          	lui	a5,0x2
    80004c38:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004c3c:	0097ee63          	bltu	a5,s1,80004c58 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004c40:	00000713          	li	a4,0
    80004c44:	000077b7          	lui	a5,0x7
    80004c48:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004c4c:	fce7eee3          	bltu	a5,a4,80004c28 <_ZL11workerBodyAPv+0x20>
    80004c50:	00170713          	addi	a4,a4,1
    80004c54:	ff1ff06f          	j	80004c44 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004c58:	00190913          	addi	s2,s2,1
    80004c5c:	00900793          	li	a5,9
    80004c60:	0527e063          	bltu	a5,s2,80004ca0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004c64:	00004517          	auipc	a0,0x4
    80004c68:	85450513          	addi	a0,a0,-1964 # 800084b8 <CONSOLE_STATUS+0x4a8>
    80004c6c:	fffff097          	auipc	ra,0xfffff
    80004c70:	4b4080e7          	jalr	1204(ra) # 80004120 <_Z11printStringPKc>
    80004c74:	00000613          	li	a2,0
    80004c78:	00a00593          	li	a1,10
    80004c7c:	0009051b          	sext.w	a0,s2
    80004c80:	fffff097          	auipc	ra,0xfffff
    80004c84:	650080e7          	jalr	1616(ra) # 800042d0 <_Z8printIntiii>
    80004c88:	00003517          	auipc	a0,0x3
    80004c8c:	52050513          	addi	a0,a0,1312 # 800081a8 <CONSOLE_STATUS+0x198>
    80004c90:	fffff097          	auipc	ra,0xfffff
    80004c94:	490080e7          	jalr	1168(ra) # 80004120 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004c98:	00000493          	li	s1,0
    80004c9c:	f99ff06f          	j	80004c34 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004ca0:	00004517          	auipc	a0,0x4
    80004ca4:	82050513          	addi	a0,a0,-2016 # 800084c0 <CONSOLE_STATUS+0x4b0>
    80004ca8:	fffff097          	auipc	ra,0xfffff
    80004cac:	478080e7          	jalr	1144(ra) # 80004120 <_Z11printStringPKc>
    finishedA = true;
    80004cb0:	00100793          	li	a5,1
    80004cb4:	00005717          	auipc	a4,0x5
    80004cb8:	50f70ba3          	sb	a5,1303(a4) # 8000a1cb <_ZL9finishedA>
}
    80004cbc:	01813083          	ld	ra,24(sp)
    80004cc0:	01013403          	ld	s0,16(sp)
    80004cc4:	00813483          	ld	s1,8(sp)
    80004cc8:	00013903          	ld	s2,0(sp)
    80004ccc:	02010113          	addi	sp,sp,32
    80004cd0:	00008067          	ret

0000000080004cd4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80004cd4:	fd010113          	addi	sp,sp,-48
    80004cd8:	02113423          	sd	ra,40(sp)
    80004cdc:	02813023          	sd	s0,32(sp)
    80004ce0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004ce4:	00000613          	li	a2,0
    80004ce8:	00000597          	auipc	a1,0x0
    80004cec:	f2058593          	addi	a1,a1,-224 # 80004c08 <_ZL11workerBodyAPv>
    80004cf0:	fd040513          	addi	a0,s0,-48
    80004cf4:	ffffc097          	auipc	ra,0xffffc
    80004cf8:	4f4080e7          	jalr	1268(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80004cfc:	00004517          	auipc	a0,0x4
    80004d00:	85450513          	addi	a0,a0,-1964 # 80008550 <CONSOLE_STATUS+0x540>
    80004d04:	fffff097          	auipc	ra,0xfffff
    80004d08:	41c080e7          	jalr	1052(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004d0c:	00000613          	li	a2,0
    80004d10:	00000597          	auipc	a1,0x0
    80004d14:	e1458593          	addi	a1,a1,-492 # 80004b24 <_ZL11workerBodyBPv>
    80004d18:	fd840513          	addi	a0,s0,-40
    80004d1c:	ffffc097          	auipc	ra,0xffffc
    80004d20:	4cc080e7          	jalr	1228(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004d24:	00004517          	auipc	a0,0x4
    80004d28:	84450513          	addi	a0,a0,-1980 # 80008568 <CONSOLE_STATUS+0x558>
    80004d2c:	fffff097          	auipc	ra,0xfffff
    80004d30:	3f4080e7          	jalr	1012(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004d34:	00000613          	li	a2,0
    80004d38:	00000597          	auipc	a1,0x0
    80004d3c:	c6c58593          	addi	a1,a1,-916 # 800049a4 <_ZL11workerBodyCPv>
    80004d40:	fe040513          	addi	a0,s0,-32
    80004d44:	ffffc097          	auipc	ra,0xffffc
    80004d48:	4a4080e7          	jalr	1188(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80004d4c:	00004517          	auipc	a0,0x4
    80004d50:	83450513          	addi	a0,a0,-1996 # 80008580 <CONSOLE_STATUS+0x570>
    80004d54:	fffff097          	auipc	ra,0xfffff
    80004d58:	3cc080e7          	jalr	972(ra) # 80004120 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004d5c:	00000613          	li	a2,0
    80004d60:	00000597          	auipc	a1,0x0
    80004d64:	afc58593          	addi	a1,a1,-1284 # 8000485c <_ZL11workerBodyDPv>
    80004d68:	fe840513          	addi	a0,s0,-24
    80004d6c:	ffffc097          	auipc	ra,0xffffc
    80004d70:	47c080e7          	jalr	1148(ra) # 800011e8 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004d74:	00004517          	auipc	a0,0x4
    80004d78:	82450513          	addi	a0,a0,-2012 # 80008598 <CONSOLE_STATUS+0x588>
    80004d7c:	fffff097          	auipc	ra,0xfffff
    80004d80:	3a4080e7          	jalr	932(ra) # 80004120 <_Z11printStringPKc>
    80004d84:	00c0006f          	j	80004d90 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004d88:	ffffc097          	auipc	ra,0xffffc
    80004d8c:	4b8080e7          	jalr	1208(ra) # 80001240 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004d90:	00005797          	auipc	a5,0x5
    80004d94:	43b7c783          	lbu	a5,1083(a5) # 8000a1cb <_ZL9finishedA>
    80004d98:	fe0788e3          	beqz	a5,80004d88 <_Z16System_Mode_testv+0xb4>
    80004d9c:	00005797          	auipc	a5,0x5
    80004da0:	42e7c783          	lbu	a5,1070(a5) # 8000a1ca <_ZL9finishedB>
    80004da4:	fe0782e3          	beqz	a5,80004d88 <_Z16System_Mode_testv+0xb4>
    80004da8:	00005797          	auipc	a5,0x5
    80004dac:	4217c783          	lbu	a5,1057(a5) # 8000a1c9 <_ZL9finishedC>
    80004db0:	fc078ce3          	beqz	a5,80004d88 <_Z16System_Mode_testv+0xb4>
    80004db4:	00005797          	auipc	a5,0x5
    80004db8:	4147c783          	lbu	a5,1044(a5) # 8000a1c8 <_ZL9finishedD>
    80004dbc:	fc0786e3          	beqz	a5,80004d88 <_Z16System_Mode_testv+0xb4>
    }

}
    80004dc0:	02813083          	ld	ra,40(sp)
    80004dc4:	02013403          	ld	s0,32(sp)
    80004dc8:	03010113          	addi	sp,sp,48
    80004dcc:	00008067          	ret

0000000080004dd0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80004dd0:	fe010113          	addi	sp,sp,-32
    80004dd4:	00113c23          	sd	ra,24(sp)
    80004dd8:	00813823          	sd	s0,16(sp)
    80004ddc:	00913423          	sd	s1,8(sp)
    80004de0:	01213023          	sd	s2,0(sp)
    80004de4:	02010413          	addi	s0,sp,32
    80004de8:	00050493          	mv	s1,a0
    80004dec:	00058913          	mv	s2,a1
    80004df0:	0015879b          	addiw	a5,a1,1
    80004df4:	0007851b          	sext.w	a0,a5
    80004df8:	00f4a023          	sw	a5,0(s1)
    80004dfc:	0004a823          	sw	zero,16(s1)
    80004e00:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80004e04:	00251513          	slli	a0,a0,0x2
    80004e08:	ffffc097          	auipc	ra,0xffffc
    80004e0c:	33c080e7          	jalr	828(ra) # 80001144 <_Z9mem_allocm>
    80004e10:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80004e14:	00000593          	li	a1,0
    80004e18:	02048513          	addi	a0,s1,32
    80004e1c:	ffffc097          	auipc	ra,0xffffc
    80004e20:	448080e7          	jalr	1096(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    80004e24:	00090593          	mv	a1,s2
    80004e28:	01848513          	addi	a0,s1,24
    80004e2c:	ffffc097          	auipc	ra,0xffffc
    80004e30:	438080e7          	jalr	1080(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    80004e34:	00100593          	li	a1,1
    80004e38:	02848513          	addi	a0,s1,40
    80004e3c:	ffffc097          	auipc	ra,0xffffc
    80004e40:	428080e7          	jalr	1064(ra) # 80001264 <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    80004e44:	00100593          	li	a1,1
    80004e48:	03048513          	addi	a0,s1,48
    80004e4c:	ffffc097          	auipc	ra,0xffffc
    80004e50:	418080e7          	jalr	1048(ra) # 80001264 <_Z8sem_openPP4_semj>
}
    80004e54:	01813083          	ld	ra,24(sp)
    80004e58:	01013403          	ld	s0,16(sp)
    80004e5c:	00813483          	ld	s1,8(sp)
    80004e60:	00013903          	ld	s2,0(sp)
    80004e64:	02010113          	addi	sp,sp,32
    80004e68:	00008067          	ret

0000000080004e6c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80004e6c:	fe010113          	addi	sp,sp,-32
    80004e70:	00113c23          	sd	ra,24(sp)
    80004e74:	00813823          	sd	s0,16(sp)
    80004e78:	00913423          	sd	s1,8(sp)
    80004e7c:	01213023          	sd	s2,0(sp)
    80004e80:	02010413          	addi	s0,sp,32
    80004e84:	00050493          	mv	s1,a0
    80004e88:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80004e8c:	01853503          	ld	a0,24(a0)
    80004e90:	ffffc097          	auipc	ra,0xffffc
    80004e94:	42c080e7          	jalr	1068(ra) # 800012bc <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    80004e98:	0304b503          	ld	a0,48(s1)
    80004e9c:	ffffc097          	auipc	ra,0xffffc
    80004ea0:	420080e7          	jalr	1056(ra) # 800012bc <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80004ea4:	0084b783          	ld	a5,8(s1)
    80004ea8:	0144a703          	lw	a4,20(s1)
    80004eac:	00271713          	slli	a4,a4,0x2
    80004eb0:	00e787b3          	add	a5,a5,a4
    80004eb4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80004eb8:	0144a783          	lw	a5,20(s1)
    80004ebc:	0017879b          	addiw	a5,a5,1
    80004ec0:	0004a703          	lw	a4,0(s1)
    80004ec4:	02e7e7bb          	remw	a5,a5,a4
    80004ec8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80004ecc:	0304b503          	ld	a0,48(s1)
    80004ed0:	ffffc097          	auipc	ra,0xffffc
    80004ed4:	418080e7          	jalr	1048(ra) # 800012e8 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    80004ed8:	0204b503          	ld	a0,32(s1)
    80004edc:	ffffc097          	auipc	ra,0xffffc
    80004ee0:	40c080e7          	jalr	1036(ra) # 800012e8 <_Z10sem_signalP4_sem>

}
    80004ee4:	01813083          	ld	ra,24(sp)
    80004ee8:	01013403          	ld	s0,16(sp)
    80004eec:	00813483          	ld	s1,8(sp)
    80004ef0:	00013903          	ld	s2,0(sp)
    80004ef4:	02010113          	addi	sp,sp,32
    80004ef8:	00008067          	ret

0000000080004efc <_ZN6Buffer3getEv>:

int Buffer::get() {
    80004efc:	fe010113          	addi	sp,sp,-32
    80004f00:	00113c23          	sd	ra,24(sp)
    80004f04:	00813823          	sd	s0,16(sp)
    80004f08:	00913423          	sd	s1,8(sp)
    80004f0c:	01213023          	sd	s2,0(sp)
    80004f10:	02010413          	addi	s0,sp,32
    80004f14:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80004f18:	02053503          	ld	a0,32(a0)
    80004f1c:	ffffc097          	auipc	ra,0xffffc
    80004f20:	3a0080e7          	jalr	928(ra) # 800012bc <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    80004f24:	0284b503          	ld	a0,40(s1)
    80004f28:	ffffc097          	auipc	ra,0xffffc
    80004f2c:	394080e7          	jalr	916(ra) # 800012bc <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80004f30:	0084b703          	ld	a4,8(s1)
    80004f34:	0104a783          	lw	a5,16(s1)
    80004f38:	00279693          	slli	a3,a5,0x2
    80004f3c:	00d70733          	add	a4,a4,a3
    80004f40:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80004f44:	0017879b          	addiw	a5,a5,1
    80004f48:	0004a703          	lw	a4,0(s1)
    80004f4c:	02e7e7bb          	remw	a5,a5,a4
    80004f50:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80004f54:	0284b503          	ld	a0,40(s1)
    80004f58:	ffffc097          	auipc	ra,0xffffc
    80004f5c:	390080e7          	jalr	912(ra) # 800012e8 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80004f60:	0184b503          	ld	a0,24(s1)
    80004f64:	ffffc097          	auipc	ra,0xffffc
    80004f68:	384080e7          	jalr	900(ra) # 800012e8 <_Z10sem_signalP4_sem>

    return ret;
}
    80004f6c:	00090513          	mv	a0,s2
    80004f70:	01813083          	ld	ra,24(sp)
    80004f74:	01013403          	ld	s0,16(sp)
    80004f78:	00813483          	ld	s1,8(sp)
    80004f7c:	00013903          	ld	s2,0(sp)
    80004f80:	02010113          	addi	sp,sp,32
    80004f84:	00008067          	ret

0000000080004f88 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80004f88:	fe010113          	addi	sp,sp,-32
    80004f8c:	00113c23          	sd	ra,24(sp)
    80004f90:	00813823          	sd	s0,16(sp)
    80004f94:	00913423          	sd	s1,8(sp)
    80004f98:	01213023          	sd	s2,0(sp)
    80004f9c:	02010413          	addi	s0,sp,32
    80004fa0:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80004fa4:	02853503          	ld	a0,40(a0)
    80004fa8:	ffffc097          	auipc	ra,0xffffc
    80004fac:	314080e7          	jalr	788(ra) # 800012bc <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    80004fb0:	0304b503          	ld	a0,48(s1)
    80004fb4:	ffffc097          	auipc	ra,0xffffc
    80004fb8:	308080e7          	jalr	776(ra) # 800012bc <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80004fbc:	0144a783          	lw	a5,20(s1)
    80004fc0:	0104a903          	lw	s2,16(s1)
    80004fc4:	0327ce63          	blt	a5,s2,80005000 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80004fc8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80004fcc:	0304b503          	ld	a0,48(s1)
    80004fd0:	ffffc097          	auipc	ra,0xffffc
    80004fd4:	318080e7          	jalr	792(ra) # 800012e8 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    80004fd8:	0284b503          	ld	a0,40(s1)
    80004fdc:	ffffc097          	auipc	ra,0xffffc
    80004fe0:	30c080e7          	jalr	780(ra) # 800012e8 <_Z10sem_signalP4_sem>

    return ret;
}
    80004fe4:	00090513          	mv	a0,s2
    80004fe8:	01813083          	ld	ra,24(sp)
    80004fec:	01013403          	ld	s0,16(sp)
    80004ff0:	00813483          	ld	s1,8(sp)
    80004ff4:	00013903          	ld	s2,0(sp)
    80004ff8:	02010113          	addi	sp,sp,32
    80004ffc:	00008067          	ret
        ret = cap - head + tail;
    80005000:	0004a703          	lw	a4,0(s1)
    80005004:	4127093b          	subw	s2,a4,s2
    80005008:	00f9093b          	addw	s2,s2,a5
    8000500c:	fc1ff06f          	j	80004fcc <_ZN6Buffer6getCntEv+0x44>

0000000080005010 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80005010:	fe010113          	addi	sp,sp,-32
    80005014:	00113c23          	sd	ra,24(sp)
    80005018:	00813823          	sd	s0,16(sp)
    8000501c:	00913423          	sd	s1,8(sp)
    80005020:	02010413          	addi	s0,sp,32
    80005024:	00050493          	mv	s1,a0
    putc('\n');
    80005028:	00a00513          	li	a0,10
    8000502c:	ffffc097          	auipc	ra,0xffffc
    80005030:	314080e7          	jalr	788(ra) # 80001340 <_Z4putcc>
    printString("Buffer deleted!\n");
    80005034:	00003517          	auipc	a0,0x3
    80005038:	58c50513          	addi	a0,a0,1420 # 800085c0 <CONSOLE_STATUS+0x5b0>
    8000503c:	fffff097          	auipc	ra,0xfffff
    80005040:	0e4080e7          	jalr	228(ra) # 80004120 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80005044:	00048513          	mv	a0,s1
    80005048:	00000097          	auipc	ra,0x0
    8000504c:	f40080e7          	jalr	-192(ra) # 80004f88 <_ZN6Buffer6getCntEv>
    80005050:	02a05c63          	blez	a0,80005088 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80005054:	0084b783          	ld	a5,8(s1)
    80005058:	0104a703          	lw	a4,16(s1)
    8000505c:	00271713          	slli	a4,a4,0x2
    80005060:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80005064:	0007c503          	lbu	a0,0(a5)
    80005068:	ffffc097          	auipc	ra,0xffffc
    8000506c:	2d8080e7          	jalr	728(ra) # 80001340 <_Z4putcc>
        head = (head + 1) % cap;
    80005070:	0104a783          	lw	a5,16(s1)
    80005074:	0017879b          	addiw	a5,a5,1
    80005078:	0004a703          	lw	a4,0(s1)
    8000507c:	02e7e7bb          	remw	a5,a5,a4
    80005080:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80005084:	fc1ff06f          	j	80005044 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80005088:	02100513          	li	a0,33
    8000508c:	ffffc097          	auipc	ra,0xffffc
    80005090:	2b4080e7          	jalr	692(ra) # 80001340 <_Z4putcc>
    putc('\n');
    80005094:	00a00513          	li	a0,10
    80005098:	ffffc097          	auipc	ra,0xffffc
    8000509c:	2a8080e7          	jalr	680(ra) # 80001340 <_Z4putcc>
    mem_free(buffer);
    800050a0:	0084b503          	ld	a0,8(s1)
    800050a4:	ffffc097          	auipc	ra,0xffffc
    800050a8:	0c8080e7          	jalr	200(ra) # 8000116c <_Z8mem_freePv>
    sem_close(itemAvailable);
    800050ac:	0204b503          	ld	a0,32(s1)
    800050b0:	ffffc097          	auipc	ra,0xffffc
    800050b4:	1e0080e7          	jalr	480(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    800050b8:	0184b503          	ld	a0,24(s1)
    800050bc:	ffffc097          	auipc	ra,0xffffc
    800050c0:	1d4080e7          	jalr	468(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    800050c4:	0304b503          	ld	a0,48(s1)
    800050c8:	ffffc097          	auipc	ra,0xffffc
    800050cc:	1c8080e7          	jalr	456(ra) # 80001290 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    800050d0:	0284b503          	ld	a0,40(s1)
    800050d4:	ffffc097          	auipc	ra,0xffffc
    800050d8:	1bc080e7          	jalr	444(ra) # 80001290 <_Z9sem_closeP4_sem>
}
    800050dc:	01813083          	ld	ra,24(sp)
    800050e0:	01013403          	ld	s0,16(sp)
    800050e4:	00813483          	ld	s1,8(sp)
    800050e8:	02010113          	addi	sp,sp,32
    800050ec:	00008067          	ret

00000000800050f0 <start>:
    800050f0:	ff010113          	addi	sp,sp,-16
    800050f4:	00813423          	sd	s0,8(sp)
    800050f8:	01010413          	addi	s0,sp,16
    800050fc:	300027f3          	csrr	a5,mstatus
    80005100:	ffffe737          	lui	a4,0xffffe
    80005104:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff33cf>
    80005108:	00e7f7b3          	and	a5,a5,a4
    8000510c:	00001737          	lui	a4,0x1
    80005110:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005114:	00e7e7b3          	or	a5,a5,a4
    80005118:	30079073          	csrw	mstatus,a5
    8000511c:	00000797          	auipc	a5,0x0
    80005120:	16078793          	addi	a5,a5,352 # 8000527c <system_main>
    80005124:	34179073          	csrw	mepc,a5
    80005128:	00000793          	li	a5,0
    8000512c:	18079073          	csrw	satp,a5
    80005130:	000107b7          	lui	a5,0x10
    80005134:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005138:	30279073          	csrw	medeleg,a5
    8000513c:	30379073          	csrw	mideleg,a5
    80005140:	104027f3          	csrr	a5,sie
    80005144:	2227e793          	ori	a5,a5,546
    80005148:	10479073          	csrw	sie,a5
    8000514c:	fff00793          	li	a5,-1
    80005150:	00a7d793          	srli	a5,a5,0xa
    80005154:	3b079073          	csrw	pmpaddr0,a5
    80005158:	00f00793          	li	a5,15
    8000515c:	3a079073          	csrw	pmpcfg0,a5
    80005160:	f14027f3          	csrr	a5,mhartid
    80005164:	0200c737          	lui	a4,0x200c
    80005168:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000516c:	0007869b          	sext.w	a3,a5
    80005170:	00269713          	slli	a4,a3,0x2
    80005174:	000f4637          	lui	a2,0xf4
    80005178:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000517c:	00d70733          	add	a4,a4,a3
    80005180:	0037979b          	slliw	a5,a5,0x3
    80005184:	020046b7          	lui	a3,0x2004
    80005188:	00d787b3          	add	a5,a5,a3
    8000518c:	00c585b3          	add	a1,a1,a2
    80005190:	00371693          	slli	a3,a4,0x3
    80005194:	00005717          	auipc	a4,0x5
    80005198:	03c70713          	addi	a4,a4,60 # 8000a1d0 <timer_scratch>
    8000519c:	00b7b023          	sd	a1,0(a5)
    800051a0:	00d70733          	add	a4,a4,a3
    800051a4:	00f73c23          	sd	a5,24(a4)
    800051a8:	02c73023          	sd	a2,32(a4)
    800051ac:	34071073          	csrw	mscratch,a4
    800051b0:	00000797          	auipc	a5,0x0
    800051b4:	6e078793          	addi	a5,a5,1760 # 80005890 <timervec>
    800051b8:	30579073          	csrw	mtvec,a5
    800051bc:	300027f3          	csrr	a5,mstatus
    800051c0:	0087e793          	ori	a5,a5,8
    800051c4:	30079073          	csrw	mstatus,a5
    800051c8:	304027f3          	csrr	a5,mie
    800051cc:	0807e793          	ori	a5,a5,128
    800051d0:	30479073          	csrw	mie,a5
    800051d4:	f14027f3          	csrr	a5,mhartid
    800051d8:	0007879b          	sext.w	a5,a5
    800051dc:	00078213          	mv	tp,a5
    800051e0:	30200073          	mret
    800051e4:	00813403          	ld	s0,8(sp)
    800051e8:	01010113          	addi	sp,sp,16
    800051ec:	00008067          	ret

00000000800051f0 <timerinit>:
    800051f0:	ff010113          	addi	sp,sp,-16
    800051f4:	00813423          	sd	s0,8(sp)
    800051f8:	01010413          	addi	s0,sp,16
    800051fc:	f14027f3          	csrr	a5,mhartid
    80005200:	0200c737          	lui	a4,0x200c
    80005204:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005208:	0007869b          	sext.w	a3,a5
    8000520c:	00269713          	slli	a4,a3,0x2
    80005210:	000f4637          	lui	a2,0xf4
    80005214:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005218:	00d70733          	add	a4,a4,a3
    8000521c:	0037979b          	slliw	a5,a5,0x3
    80005220:	020046b7          	lui	a3,0x2004
    80005224:	00d787b3          	add	a5,a5,a3
    80005228:	00c585b3          	add	a1,a1,a2
    8000522c:	00371693          	slli	a3,a4,0x3
    80005230:	00005717          	auipc	a4,0x5
    80005234:	fa070713          	addi	a4,a4,-96 # 8000a1d0 <timer_scratch>
    80005238:	00b7b023          	sd	a1,0(a5)
    8000523c:	00d70733          	add	a4,a4,a3
    80005240:	00f73c23          	sd	a5,24(a4)
    80005244:	02c73023          	sd	a2,32(a4)
    80005248:	34071073          	csrw	mscratch,a4
    8000524c:	00000797          	auipc	a5,0x0
    80005250:	64478793          	addi	a5,a5,1604 # 80005890 <timervec>
    80005254:	30579073          	csrw	mtvec,a5
    80005258:	300027f3          	csrr	a5,mstatus
    8000525c:	0087e793          	ori	a5,a5,8
    80005260:	30079073          	csrw	mstatus,a5
    80005264:	304027f3          	csrr	a5,mie
    80005268:	0807e793          	ori	a5,a5,128
    8000526c:	30479073          	csrw	mie,a5
    80005270:	00813403          	ld	s0,8(sp)
    80005274:	01010113          	addi	sp,sp,16
    80005278:	00008067          	ret

000000008000527c <system_main>:
    8000527c:	fe010113          	addi	sp,sp,-32
    80005280:	00813823          	sd	s0,16(sp)
    80005284:	00913423          	sd	s1,8(sp)
    80005288:	00113c23          	sd	ra,24(sp)
    8000528c:	02010413          	addi	s0,sp,32
    80005290:	00000097          	auipc	ra,0x0
    80005294:	0c4080e7          	jalr	196(ra) # 80005354 <cpuid>
    80005298:	00005497          	auipc	s1,0x5
    8000529c:	ea848493          	addi	s1,s1,-344 # 8000a140 <started>
    800052a0:	02050263          	beqz	a0,800052c4 <system_main+0x48>
    800052a4:	0004a783          	lw	a5,0(s1)
    800052a8:	0007879b          	sext.w	a5,a5
    800052ac:	fe078ce3          	beqz	a5,800052a4 <system_main+0x28>
    800052b0:	0ff0000f          	fence
    800052b4:	00003517          	auipc	a0,0x3
    800052b8:	35450513          	addi	a0,a0,852 # 80008608 <CONSOLE_STATUS+0x5f8>
    800052bc:	00001097          	auipc	ra,0x1
    800052c0:	a70080e7          	jalr	-1424(ra) # 80005d2c <panic>
    800052c4:	00001097          	auipc	ra,0x1
    800052c8:	9c4080e7          	jalr	-1596(ra) # 80005c88 <consoleinit>
    800052cc:	00001097          	auipc	ra,0x1
    800052d0:	150080e7          	jalr	336(ra) # 8000641c <printfinit>
    800052d4:	00003517          	auipc	a0,0x3
    800052d8:	ed450513          	addi	a0,a0,-300 # 800081a8 <CONSOLE_STATUS+0x198>
    800052dc:	00001097          	auipc	ra,0x1
    800052e0:	aac080e7          	jalr	-1364(ra) # 80005d88 <__printf>
    800052e4:	00003517          	auipc	a0,0x3
    800052e8:	2f450513          	addi	a0,a0,756 # 800085d8 <CONSOLE_STATUS+0x5c8>
    800052ec:	00001097          	auipc	ra,0x1
    800052f0:	a9c080e7          	jalr	-1380(ra) # 80005d88 <__printf>
    800052f4:	00003517          	auipc	a0,0x3
    800052f8:	eb450513          	addi	a0,a0,-332 # 800081a8 <CONSOLE_STATUS+0x198>
    800052fc:	00001097          	auipc	ra,0x1
    80005300:	a8c080e7          	jalr	-1396(ra) # 80005d88 <__printf>
    80005304:	00001097          	auipc	ra,0x1
    80005308:	4a4080e7          	jalr	1188(ra) # 800067a8 <kinit>
    8000530c:	00000097          	auipc	ra,0x0
    80005310:	148080e7          	jalr	328(ra) # 80005454 <trapinit>
    80005314:	00000097          	auipc	ra,0x0
    80005318:	16c080e7          	jalr	364(ra) # 80005480 <trapinithart>
    8000531c:	00000097          	auipc	ra,0x0
    80005320:	5b4080e7          	jalr	1460(ra) # 800058d0 <plicinit>
    80005324:	00000097          	auipc	ra,0x0
    80005328:	5d4080e7          	jalr	1492(ra) # 800058f8 <plicinithart>
    8000532c:	00000097          	auipc	ra,0x0
    80005330:	078080e7          	jalr	120(ra) # 800053a4 <userinit>
    80005334:	0ff0000f          	fence
    80005338:	00100793          	li	a5,1
    8000533c:	00003517          	auipc	a0,0x3
    80005340:	2b450513          	addi	a0,a0,692 # 800085f0 <CONSOLE_STATUS+0x5e0>
    80005344:	00f4a023          	sw	a5,0(s1)
    80005348:	00001097          	auipc	ra,0x1
    8000534c:	a40080e7          	jalr	-1472(ra) # 80005d88 <__printf>
    80005350:	0000006f          	j	80005350 <system_main+0xd4>

0000000080005354 <cpuid>:
    80005354:	ff010113          	addi	sp,sp,-16
    80005358:	00813423          	sd	s0,8(sp)
    8000535c:	01010413          	addi	s0,sp,16
    80005360:	00020513          	mv	a0,tp
    80005364:	00813403          	ld	s0,8(sp)
    80005368:	0005051b          	sext.w	a0,a0
    8000536c:	01010113          	addi	sp,sp,16
    80005370:	00008067          	ret

0000000080005374 <mycpu>:
    80005374:	ff010113          	addi	sp,sp,-16
    80005378:	00813423          	sd	s0,8(sp)
    8000537c:	01010413          	addi	s0,sp,16
    80005380:	00020793          	mv	a5,tp
    80005384:	00813403          	ld	s0,8(sp)
    80005388:	0007879b          	sext.w	a5,a5
    8000538c:	00779793          	slli	a5,a5,0x7
    80005390:	00006517          	auipc	a0,0x6
    80005394:	e7050513          	addi	a0,a0,-400 # 8000b200 <cpus>
    80005398:	00f50533          	add	a0,a0,a5
    8000539c:	01010113          	addi	sp,sp,16
    800053a0:	00008067          	ret

00000000800053a4 <userinit>:
    800053a4:	ff010113          	addi	sp,sp,-16
    800053a8:	00813423          	sd	s0,8(sp)
    800053ac:	01010413          	addi	s0,sp,16
    800053b0:	00813403          	ld	s0,8(sp)
    800053b4:	01010113          	addi	sp,sp,16
    800053b8:	ffffc317          	auipc	t1,0xffffc
    800053bc:	35830067          	jr	856(t1) # 80001710 <main>

00000000800053c0 <either_copyout>:
    800053c0:	ff010113          	addi	sp,sp,-16
    800053c4:	00813023          	sd	s0,0(sp)
    800053c8:	00113423          	sd	ra,8(sp)
    800053cc:	01010413          	addi	s0,sp,16
    800053d0:	02051663          	bnez	a0,800053fc <either_copyout+0x3c>
    800053d4:	00058513          	mv	a0,a1
    800053d8:	00060593          	mv	a1,a2
    800053dc:	0006861b          	sext.w	a2,a3
    800053e0:	00002097          	auipc	ra,0x2
    800053e4:	c54080e7          	jalr	-940(ra) # 80007034 <__memmove>
    800053e8:	00813083          	ld	ra,8(sp)
    800053ec:	00013403          	ld	s0,0(sp)
    800053f0:	00000513          	li	a0,0
    800053f4:	01010113          	addi	sp,sp,16
    800053f8:	00008067          	ret
    800053fc:	00003517          	auipc	a0,0x3
    80005400:	23450513          	addi	a0,a0,564 # 80008630 <CONSOLE_STATUS+0x620>
    80005404:	00001097          	auipc	ra,0x1
    80005408:	928080e7          	jalr	-1752(ra) # 80005d2c <panic>

000000008000540c <either_copyin>:
    8000540c:	ff010113          	addi	sp,sp,-16
    80005410:	00813023          	sd	s0,0(sp)
    80005414:	00113423          	sd	ra,8(sp)
    80005418:	01010413          	addi	s0,sp,16
    8000541c:	02059463          	bnez	a1,80005444 <either_copyin+0x38>
    80005420:	00060593          	mv	a1,a2
    80005424:	0006861b          	sext.w	a2,a3
    80005428:	00002097          	auipc	ra,0x2
    8000542c:	c0c080e7          	jalr	-1012(ra) # 80007034 <__memmove>
    80005430:	00813083          	ld	ra,8(sp)
    80005434:	00013403          	ld	s0,0(sp)
    80005438:	00000513          	li	a0,0
    8000543c:	01010113          	addi	sp,sp,16
    80005440:	00008067          	ret
    80005444:	00003517          	auipc	a0,0x3
    80005448:	21450513          	addi	a0,a0,532 # 80008658 <CONSOLE_STATUS+0x648>
    8000544c:	00001097          	auipc	ra,0x1
    80005450:	8e0080e7          	jalr	-1824(ra) # 80005d2c <panic>

0000000080005454 <trapinit>:
    80005454:	ff010113          	addi	sp,sp,-16
    80005458:	00813423          	sd	s0,8(sp)
    8000545c:	01010413          	addi	s0,sp,16
    80005460:	00813403          	ld	s0,8(sp)
    80005464:	00003597          	auipc	a1,0x3
    80005468:	21c58593          	addi	a1,a1,540 # 80008680 <CONSOLE_STATUS+0x670>
    8000546c:	00006517          	auipc	a0,0x6
    80005470:	e1450513          	addi	a0,a0,-492 # 8000b280 <tickslock>
    80005474:	01010113          	addi	sp,sp,16
    80005478:	00001317          	auipc	t1,0x1
    8000547c:	5c030067          	jr	1472(t1) # 80006a38 <initlock>

0000000080005480 <trapinithart>:
    80005480:	ff010113          	addi	sp,sp,-16
    80005484:	00813423          	sd	s0,8(sp)
    80005488:	01010413          	addi	s0,sp,16
    8000548c:	00000797          	auipc	a5,0x0
    80005490:	2f478793          	addi	a5,a5,756 # 80005780 <kernelvec>
    80005494:	10579073          	csrw	stvec,a5
    80005498:	00813403          	ld	s0,8(sp)
    8000549c:	01010113          	addi	sp,sp,16
    800054a0:	00008067          	ret

00000000800054a4 <usertrap>:
    800054a4:	ff010113          	addi	sp,sp,-16
    800054a8:	00813423          	sd	s0,8(sp)
    800054ac:	01010413          	addi	s0,sp,16
    800054b0:	00813403          	ld	s0,8(sp)
    800054b4:	01010113          	addi	sp,sp,16
    800054b8:	00008067          	ret

00000000800054bc <usertrapret>:
    800054bc:	ff010113          	addi	sp,sp,-16
    800054c0:	00813423          	sd	s0,8(sp)
    800054c4:	01010413          	addi	s0,sp,16
    800054c8:	00813403          	ld	s0,8(sp)
    800054cc:	01010113          	addi	sp,sp,16
    800054d0:	00008067          	ret

00000000800054d4 <kerneltrap>:
    800054d4:	fe010113          	addi	sp,sp,-32
    800054d8:	00813823          	sd	s0,16(sp)
    800054dc:	00113c23          	sd	ra,24(sp)
    800054e0:	00913423          	sd	s1,8(sp)
    800054e4:	02010413          	addi	s0,sp,32
    800054e8:	142025f3          	csrr	a1,scause
    800054ec:	100027f3          	csrr	a5,sstatus
    800054f0:	0027f793          	andi	a5,a5,2
    800054f4:	10079c63          	bnez	a5,8000560c <kerneltrap+0x138>
    800054f8:	142027f3          	csrr	a5,scause
    800054fc:	0207ce63          	bltz	a5,80005538 <kerneltrap+0x64>
    80005500:	00003517          	auipc	a0,0x3
    80005504:	1c850513          	addi	a0,a0,456 # 800086c8 <CONSOLE_STATUS+0x6b8>
    80005508:	00001097          	auipc	ra,0x1
    8000550c:	880080e7          	jalr	-1920(ra) # 80005d88 <__printf>
    80005510:	141025f3          	csrr	a1,sepc
    80005514:	14302673          	csrr	a2,stval
    80005518:	00003517          	auipc	a0,0x3
    8000551c:	1c050513          	addi	a0,a0,448 # 800086d8 <CONSOLE_STATUS+0x6c8>
    80005520:	00001097          	auipc	ra,0x1
    80005524:	868080e7          	jalr	-1944(ra) # 80005d88 <__printf>
    80005528:	00003517          	auipc	a0,0x3
    8000552c:	1c850513          	addi	a0,a0,456 # 800086f0 <CONSOLE_STATUS+0x6e0>
    80005530:	00000097          	auipc	ra,0x0
    80005534:	7fc080e7          	jalr	2044(ra) # 80005d2c <panic>
    80005538:	0ff7f713          	andi	a4,a5,255
    8000553c:	00900693          	li	a3,9
    80005540:	04d70063          	beq	a4,a3,80005580 <kerneltrap+0xac>
    80005544:	fff00713          	li	a4,-1
    80005548:	03f71713          	slli	a4,a4,0x3f
    8000554c:	00170713          	addi	a4,a4,1
    80005550:	fae798e3          	bne	a5,a4,80005500 <kerneltrap+0x2c>
    80005554:	00000097          	auipc	ra,0x0
    80005558:	e00080e7          	jalr	-512(ra) # 80005354 <cpuid>
    8000555c:	06050663          	beqz	a0,800055c8 <kerneltrap+0xf4>
    80005560:	144027f3          	csrr	a5,sip
    80005564:	ffd7f793          	andi	a5,a5,-3
    80005568:	14479073          	csrw	sip,a5
    8000556c:	01813083          	ld	ra,24(sp)
    80005570:	01013403          	ld	s0,16(sp)
    80005574:	00813483          	ld	s1,8(sp)
    80005578:	02010113          	addi	sp,sp,32
    8000557c:	00008067          	ret
    80005580:	00000097          	auipc	ra,0x0
    80005584:	3c4080e7          	jalr	964(ra) # 80005944 <plic_claim>
    80005588:	00a00793          	li	a5,10
    8000558c:	00050493          	mv	s1,a0
    80005590:	06f50863          	beq	a0,a5,80005600 <kerneltrap+0x12c>
    80005594:	fc050ce3          	beqz	a0,8000556c <kerneltrap+0x98>
    80005598:	00050593          	mv	a1,a0
    8000559c:	00003517          	auipc	a0,0x3
    800055a0:	10c50513          	addi	a0,a0,268 # 800086a8 <CONSOLE_STATUS+0x698>
    800055a4:	00000097          	auipc	ra,0x0
    800055a8:	7e4080e7          	jalr	2020(ra) # 80005d88 <__printf>
    800055ac:	01013403          	ld	s0,16(sp)
    800055b0:	01813083          	ld	ra,24(sp)
    800055b4:	00048513          	mv	a0,s1
    800055b8:	00813483          	ld	s1,8(sp)
    800055bc:	02010113          	addi	sp,sp,32
    800055c0:	00000317          	auipc	t1,0x0
    800055c4:	3bc30067          	jr	956(t1) # 8000597c <plic_complete>
    800055c8:	00006517          	auipc	a0,0x6
    800055cc:	cb850513          	addi	a0,a0,-840 # 8000b280 <tickslock>
    800055d0:	00001097          	auipc	ra,0x1
    800055d4:	48c080e7          	jalr	1164(ra) # 80006a5c <acquire>
    800055d8:	00005717          	auipc	a4,0x5
    800055dc:	b6c70713          	addi	a4,a4,-1172 # 8000a144 <ticks>
    800055e0:	00072783          	lw	a5,0(a4)
    800055e4:	00006517          	auipc	a0,0x6
    800055e8:	c9c50513          	addi	a0,a0,-868 # 8000b280 <tickslock>
    800055ec:	0017879b          	addiw	a5,a5,1
    800055f0:	00f72023          	sw	a5,0(a4)
    800055f4:	00001097          	auipc	ra,0x1
    800055f8:	534080e7          	jalr	1332(ra) # 80006b28 <release>
    800055fc:	f65ff06f          	j	80005560 <kerneltrap+0x8c>
    80005600:	00001097          	auipc	ra,0x1
    80005604:	090080e7          	jalr	144(ra) # 80006690 <uartintr>
    80005608:	fa5ff06f          	j	800055ac <kerneltrap+0xd8>
    8000560c:	00003517          	auipc	a0,0x3
    80005610:	07c50513          	addi	a0,a0,124 # 80008688 <CONSOLE_STATUS+0x678>
    80005614:	00000097          	auipc	ra,0x0
    80005618:	718080e7          	jalr	1816(ra) # 80005d2c <panic>

000000008000561c <clockintr>:
    8000561c:	fe010113          	addi	sp,sp,-32
    80005620:	00813823          	sd	s0,16(sp)
    80005624:	00913423          	sd	s1,8(sp)
    80005628:	00113c23          	sd	ra,24(sp)
    8000562c:	02010413          	addi	s0,sp,32
    80005630:	00006497          	auipc	s1,0x6
    80005634:	c5048493          	addi	s1,s1,-944 # 8000b280 <tickslock>
    80005638:	00048513          	mv	a0,s1
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	420080e7          	jalr	1056(ra) # 80006a5c <acquire>
    80005644:	00005717          	auipc	a4,0x5
    80005648:	b0070713          	addi	a4,a4,-1280 # 8000a144 <ticks>
    8000564c:	00072783          	lw	a5,0(a4)
    80005650:	01013403          	ld	s0,16(sp)
    80005654:	01813083          	ld	ra,24(sp)
    80005658:	00048513          	mv	a0,s1
    8000565c:	0017879b          	addiw	a5,a5,1
    80005660:	00813483          	ld	s1,8(sp)
    80005664:	00f72023          	sw	a5,0(a4)
    80005668:	02010113          	addi	sp,sp,32
    8000566c:	00001317          	auipc	t1,0x1
    80005670:	4bc30067          	jr	1212(t1) # 80006b28 <release>

0000000080005674 <devintr>:
    80005674:	142027f3          	csrr	a5,scause
    80005678:	00000513          	li	a0,0
    8000567c:	0007c463          	bltz	a5,80005684 <devintr+0x10>
    80005680:	00008067          	ret
    80005684:	fe010113          	addi	sp,sp,-32
    80005688:	00813823          	sd	s0,16(sp)
    8000568c:	00113c23          	sd	ra,24(sp)
    80005690:	00913423          	sd	s1,8(sp)
    80005694:	02010413          	addi	s0,sp,32
    80005698:	0ff7f713          	andi	a4,a5,255
    8000569c:	00900693          	li	a3,9
    800056a0:	04d70c63          	beq	a4,a3,800056f8 <devintr+0x84>
    800056a4:	fff00713          	li	a4,-1
    800056a8:	03f71713          	slli	a4,a4,0x3f
    800056ac:	00170713          	addi	a4,a4,1
    800056b0:	00e78c63          	beq	a5,a4,800056c8 <devintr+0x54>
    800056b4:	01813083          	ld	ra,24(sp)
    800056b8:	01013403          	ld	s0,16(sp)
    800056bc:	00813483          	ld	s1,8(sp)
    800056c0:	02010113          	addi	sp,sp,32
    800056c4:	00008067          	ret
    800056c8:	00000097          	auipc	ra,0x0
    800056cc:	c8c080e7          	jalr	-884(ra) # 80005354 <cpuid>
    800056d0:	06050663          	beqz	a0,8000573c <devintr+0xc8>
    800056d4:	144027f3          	csrr	a5,sip
    800056d8:	ffd7f793          	andi	a5,a5,-3
    800056dc:	14479073          	csrw	sip,a5
    800056e0:	01813083          	ld	ra,24(sp)
    800056e4:	01013403          	ld	s0,16(sp)
    800056e8:	00813483          	ld	s1,8(sp)
    800056ec:	00200513          	li	a0,2
    800056f0:	02010113          	addi	sp,sp,32
    800056f4:	00008067          	ret
    800056f8:	00000097          	auipc	ra,0x0
    800056fc:	24c080e7          	jalr	588(ra) # 80005944 <plic_claim>
    80005700:	00a00793          	li	a5,10
    80005704:	00050493          	mv	s1,a0
    80005708:	06f50663          	beq	a0,a5,80005774 <devintr+0x100>
    8000570c:	00100513          	li	a0,1
    80005710:	fa0482e3          	beqz	s1,800056b4 <devintr+0x40>
    80005714:	00048593          	mv	a1,s1
    80005718:	00003517          	auipc	a0,0x3
    8000571c:	f9050513          	addi	a0,a0,-112 # 800086a8 <CONSOLE_STATUS+0x698>
    80005720:	00000097          	auipc	ra,0x0
    80005724:	668080e7          	jalr	1640(ra) # 80005d88 <__printf>
    80005728:	00048513          	mv	a0,s1
    8000572c:	00000097          	auipc	ra,0x0
    80005730:	250080e7          	jalr	592(ra) # 8000597c <plic_complete>
    80005734:	00100513          	li	a0,1
    80005738:	f7dff06f          	j	800056b4 <devintr+0x40>
    8000573c:	00006517          	auipc	a0,0x6
    80005740:	b4450513          	addi	a0,a0,-1212 # 8000b280 <tickslock>
    80005744:	00001097          	auipc	ra,0x1
    80005748:	318080e7          	jalr	792(ra) # 80006a5c <acquire>
    8000574c:	00005717          	auipc	a4,0x5
    80005750:	9f870713          	addi	a4,a4,-1544 # 8000a144 <ticks>
    80005754:	00072783          	lw	a5,0(a4)
    80005758:	00006517          	auipc	a0,0x6
    8000575c:	b2850513          	addi	a0,a0,-1240 # 8000b280 <tickslock>
    80005760:	0017879b          	addiw	a5,a5,1
    80005764:	00f72023          	sw	a5,0(a4)
    80005768:	00001097          	auipc	ra,0x1
    8000576c:	3c0080e7          	jalr	960(ra) # 80006b28 <release>
    80005770:	f65ff06f          	j	800056d4 <devintr+0x60>
    80005774:	00001097          	auipc	ra,0x1
    80005778:	f1c080e7          	jalr	-228(ra) # 80006690 <uartintr>
    8000577c:	fadff06f          	j	80005728 <devintr+0xb4>

0000000080005780 <kernelvec>:
    80005780:	f0010113          	addi	sp,sp,-256
    80005784:	00113023          	sd	ra,0(sp)
    80005788:	00213423          	sd	sp,8(sp)
    8000578c:	00313823          	sd	gp,16(sp)
    80005790:	00413c23          	sd	tp,24(sp)
    80005794:	02513023          	sd	t0,32(sp)
    80005798:	02613423          	sd	t1,40(sp)
    8000579c:	02713823          	sd	t2,48(sp)
    800057a0:	02813c23          	sd	s0,56(sp)
    800057a4:	04913023          	sd	s1,64(sp)
    800057a8:	04a13423          	sd	a0,72(sp)
    800057ac:	04b13823          	sd	a1,80(sp)
    800057b0:	04c13c23          	sd	a2,88(sp)
    800057b4:	06d13023          	sd	a3,96(sp)
    800057b8:	06e13423          	sd	a4,104(sp)
    800057bc:	06f13823          	sd	a5,112(sp)
    800057c0:	07013c23          	sd	a6,120(sp)
    800057c4:	09113023          	sd	a7,128(sp)
    800057c8:	09213423          	sd	s2,136(sp)
    800057cc:	09313823          	sd	s3,144(sp)
    800057d0:	09413c23          	sd	s4,152(sp)
    800057d4:	0b513023          	sd	s5,160(sp)
    800057d8:	0b613423          	sd	s6,168(sp)
    800057dc:	0b713823          	sd	s7,176(sp)
    800057e0:	0b813c23          	sd	s8,184(sp)
    800057e4:	0d913023          	sd	s9,192(sp)
    800057e8:	0da13423          	sd	s10,200(sp)
    800057ec:	0db13823          	sd	s11,208(sp)
    800057f0:	0dc13c23          	sd	t3,216(sp)
    800057f4:	0fd13023          	sd	t4,224(sp)
    800057f8:	0fe13423          	sd	t5,232(sp)
    800057fc:	0ff13823          	sd	t6,240(sp)
    80005800:	cd5ff0ef          	jal	ra,800054d4 <kerneltrap>
    80005804:	00013083          	ld	ra,0(sp)
    80005808:	00813103          	ld	sp,8(sp)
    8000580c:	01013183          	ld	gp,16(sp)
    80005810:	02013283          	ld	t0,32(sp)
    80005814:	02813303          	ld	t1,40(sp)
    80005818:	03013383          	ld	t2,48(sp)
    8000581c:	03813403          	ld	s0,56(sp)
    80005820:	04013483          	ld	s1,64(sp)
    80005824:	04813503          	ld	a0,72(sp)
    80005828:	05013583          	ld	a1,80(sp)
    8000582c:	05813603          	ld	a2,88(sp)
    80005830:	06013683          	ld	a3,96(sp)
    80005834:	06813703          	ld	a4,104(sp)
    80005838:	07013783          	ld	a5,112(sp)
    8000583c:	07813803          	ld	a6,120(sp)
    80005840:	08013883          	ld	a7,128(sp)
    80005844:	08813903          	ld	s2,136(sp)
    80005848:	09013983          	ld	s3,144(sp)
    8000584c:	09813a03          	ld	s4,152(sp)
    80005850:	0a013a83          	ld	s5,160(sp)
    80005854:	0a813b03          	ld	s6,168(sp)
    80005858:	0b013b83          	ld	s7,176(sp)
    8000585c:	0b813c03          	ld	s8,184(sp)
    80005860:	0c013c83          	ld	s9,192(sp)
    80005864:	0c813d03          	ld	s10,200(sp)
    80005868:	0d013d83          	ld	s11,208(sp)
    8000586c:	0d813e03          	ld	t3,216(sp)
    80005870:	0e013e83          	ld	t4,224(sp)
    80005874:	0e813f03          	ld	t5,232(sp)
    80005878:	0f013f83          	ld	t6,240(sp)
    8000587c:	10010113          	addi	sp,sp,256
    80005880:	10200073          	sret
    80005884:	00000013          	nop
    80005888:	00000013          	nop
    8000588c:	00000013          	nop

0000000080005890 <timervec>:
    80005890:	34051573          	csrrw	a0,mscratch,a0
    80005894:	00b53023          	sd	a1,0(a0)
    80005898:	00c53423          	sd	a2,8(a0)
    8000589c:	00d53823          	sd	a3,16(a0)
    800058a0:	01853583          	ld	a1,24(a0)
    800058a4:	02053603          	ld	a2,32(a0)
    800058a8:	0005b683          	ld	a3,0(a1)
    800058ac:	00c686b3          	add	a3,a3,a2
    800058b0:	00d5b023          	sd	a3,0(a1)
    800058b4:	00200593          	li	a1,2
    800058b8:	14459073          	csrw	sip,a1
    800058bc:	01053683          	ld	a3,16(a0)
    800058c0:	00853603          	ld	a2,8(a0)
    800058c4:	00053583          	ld	a1,0(a0)
    800058c8:	34051573          	csrrw	a0,mscratch,a0
    800058cc:	30200073          	mret

00000000800058d0 <plicinit>:
    800058d0:	ff010113          	addi	sp,sp,-16
    800058d4:	00813423          	sd	s0,8(sp)
    800058d8:	01010413          	addi	s0,sp,16
    800058dc:	00813403          	ld	s0,8(sp)
    800058e0:	0c0007b7          	lui	a5,0xc000
    800058e4:	00100713          	li	a4,1
    800058e8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800058ec:	00e7a223          	sw	a4,4(a5)
    800058f0:	01010113          	addi	sp,sp,16
    800058f4:	00008067          	ret

00000000800058f8 <plicinithart>:
    800058f8:	ff010113          	addi	sp,sp,-16
    800058fc:	00813023          	sd	s0,0(sp)
    80005900:	00113423          	sd	ra,8(sp)
    80005904:	01010413          	addi	s0,sp,16
    80005908:	00000097          	auipc	ra,0x0
    8000590c:	a4c080e7          	jalr	-1460(ra) # 80005354 <cpuid>
    80005910:	0085171b          	slliw	a4,a0,0x8
    80005914:	0c0027b7          	lui	a5,0xc002
    80005918:	00e787b3          	add	a5,a5,a4
    8000591c:	40200713          	li	a4,1026
    80005920:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005924:	00813083          	ld	ra,8(sp)
    80005928:	00013403          	ld	s0,0(sp)
    8000592c:	00d5151b          	slliw	a0,a0,0xd
    80005930:	0c2017b7          	lui	a5,0xc201
    80005934:	00a78533          	add	a0,a5,a0
    80005938:	00052023          	sw	zero,0(a0)
    8000593c:	01010113          	addi	sp,sp,16
    80005940:	00008067          	ret

0000000080005944 <plic_claim>:
    80005944:	ff010113          	addi	sp,sp,-16
    80005948:	00813023          	sd	s0,0(sp)
    8000594c:	00113423          	sd	ra,8(sp)
    80005950:	01010413          	addi	s0,sp,16
    80005954:	00000097          	auipc	ra,0x0
    80005958:	a00080e7          	jalr	-1536(ra) # 80005354 <cpuid>
    8000595c:	00813083          	ld	ra,8(sp)
    80005960:	00013403          	ld	s0,0(sp)
    80005964:	00d5151b          	slliw	a0,a0,0xd
    80005968:	0c2017b7          	lui	a5,0xc201
    8000596c:	00a78533          	add	a0,a5,a0
    80005970:	00452503          	lw	a0,4(a0)
    80005974:	01010113          	addi	sp,sp,16
    80005978:	00008067          	ret

000000008000597c <plic_complete>:
    8000597c:	fe010113          	addi	sp,sp,-32
    80005980:	00813823          	sd	s0,16(sp)
    80005984:	00913423          	sd	s1,8(sp)
    80005988:	00113c23          	sd	ra,24(sp)
    8000598c:	02010413          	addi	s0,sp,32
    80005990:	00050493          	mv	s1,a0
    80005994:	00000097          	auipc	ra,0x0
    80005998:	9c0080e7          	jalr	-1600(ra) # 80005354 <cpuid>
    8000599c:	01813083          	ld	ra,24(sp)
    800059a0:	01013403          	ld	s0,16(sp)
    800059a4:	00d5179b          	slliw	a5,a0,0xd
    800059a8:	0c201737          	lui	a4,0xc201
    800059ac:	00f707b3          	add	a5,a4,a5
    800059b0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800059b4:	00813483          	ld	s1,8(sp)
    800059b8:	02010113          	addi	sp,sp,32
    800059bc:	00008067          	ret

00000000800059c0 <consolewrite>:
    800059c0:	fb010113          	addi	sp,sp,-80
    800059c4:	04813023          	sd	s0,64(sp)
    800059c8:	04113423          	sd	ra,72(sp)
    800059cc:	02913c23          	sd	s1,56(sp)
    800059d0:	03213823          	sd	s2,48(sp)
    800059d4:	03313423          	sd	s3,40(sp)
    800059d8:	03413023          	sd	s4,32(sp)
    800059dc:	01513c23          	sd	s5,24(sp)
    800059e0:	05010413          	addi	s0,sp,80
    800059e4:	06c05c63          	blez	a2,80005a5c <consolewrite+0x9c>
    800059e8:	00060993          	mv	s3,a2
    800059ec:	00050a13          	mv	s4,a0
    800059f0:	00058493          	mv	s1,a1
    800059f4:	00000913          	li	s2,0
    800059f8:	fff00a93          	li	s5,-1
    800059fc:	01c0006f          	j	80005a18 <consolewrite+0x58>
    80005a00:	fbf44503          	lbu	a0,-65(s0)
    80005a04:	0019091b          	addiw	s2,s2,1
    80005a08:	00148493          	addi	s1,s1,1
    80005a0c:	00001097          	auipc	ra,0x1
    80005a10:	a9c080e7          	jalr	-1380(ra) # 800064a8 <uartputc>
    80005a14:	03298063          	beq	s3,s2,80005a34 <consolewrite+0x74>
    80005a18:	00048613          	mv	a2,s1
    80005a1c:	00100693          	li	a3,1
    80005a20:	000a0593          	mv	a1,s4
    80005a24:	fbf40513          	addi	a0,s0,-65
    80005a28:	00000097          	auipc	ra,0x0
    80005a2c:	9e4080e7          	jalr	-1564(ra) # 8000540c <either_copyin>
    80005a30:	fd5518e3          	bne	a0,s5,80005a00 <consolewrite+0x40>
    80005a34:	04813083          	ld	ra,72(sp)
    80005a38:	04013403          	ld	s0,64(sp)
    80005a3c:	03813483          	ld	s1,56(sp)
    80005a40:	02813983          	ld	s3,40(sp)
    80005a44:	02013a03          	ld	s4,32(sp)
    80005a48:	01813a83          	ld	s5,24(sp)
    80005a4c:	00090513          	mv	a0,s2
    80005a50:	03013903          	ld	s2,48(sp)
    80005a54:	05010113          	addi	sp,sp,80
    80005a58:	00008067          	ret
    80005a5c:	00000913          	li	s2,0
    80005a60:	fd5ff06f          	j	80005a34 <consolewrite+0x74>

0000000080005a64 <consoleread>:
    80005a64:	f9010113          	addi	sp,sp,-112
    80005a68:	06813023          	sd	s0,96(sp)
    80005a6c:	04913c23          	sd	s1,88(sp)
    80005a70:	05213823          	sd	s2,80(sp)
    80005a74:	05313423          	sd	s3,72(sp)
    80005a78:	05413023          	sd	s4,64(sp)
    80005a7c:	03513c23          	sd	s5,56(sp)
    80005a80:	03613823          	sd	s6,48(sp)
    80005a84:	03713423          	sd	s7,40(sp)
    80005a88:	03813023          	sd	s8,32(sp)
    80005a8c:	06113423          	sd	ra,104(sp)
    80005a90:	01913c23          	sd	s9,24(sp)
    80005a94:	07010413          	addi	s0,sp,112
    80005a98:	00060b93          	mv	s7,a2
    80005a9c:	00050913          	mv	s2,a0
    80005aa0:	00058c13          	mv	s8,a1
    80005aa4:	00060b1b          	sext.w	s6,a2
    80005aa8:	00006497          	auipc	s1,0x6
    80005aac:	80048493          	addi	s1,s1,-2048 # 8000b2a8 <cons>
    80005ab0:	00400993          	li	s3,4
    80005ab4:	fff00a13          	li	s4,-1
    80005ab8:	00a00a93          	li	s5,10
    80005abc:	05705e63          	blez	s7,80005b18 <consoleread+0xb4>
    80005ac0:	09c4a703          	lw	a4,156(s1)
    80005ac4:	0984a783          	lw	a5,152(s1)
    80005ac8:	0007071b          	sext.w	a4,a4
    80005acc:	08e78463          	beq	a5,a4,80005b54 <consoleread+0xf0>
    80005ad0:	07f7f713          	andi	a4,a5,127
    80005ad4:	00e48733          	add	a4,s1,a4
    80005ad8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80005adc:	0017869b          	addiw	a3,a5,1
    80005ae0:	08d4ac23          	sw	a3,152(s1)
    80005ae4:	00070c9b          	sext.w	s9,a4
    80005ae8:	0b370663          	beq	a4,s3,80005b94 <consoleread+0x130>
    80005aec:	00100693          	li	a3,1
    80005af0:	f9f40613          	addi	a2,s0,-97
    80005af4:	000c0593          	mv	a1,s8
    80005af8:	00090513          	mv	a0,s2
    80005afc:	f8e40fa3          	sb	a4,-97(s0)
    80005b00:	00000097          	auipc	ra,0x0
    80005b04:	8c0080e7          	jalr	-1856(ra) # 800053c0 <either_copyout>
    80005b08:	01450863          	beq	a0,s4,80005b18 <consoleread+0xb4>
    80005b0c:	001c0c13          	addi	s8,s8,1
    80005b10:	fffb8b9b          	addiw	s7,s7,-1
    80005b14:	fb5c94e3          	bne	s9,s5,80005abc <consoleread+0x58>
    80005b18:	000b851b          	sext.w	a0,s7
    80005b1c:	06813083          	ld	ra,104(sp)
    80005b20:	06013403          	ld	s0,96(sp)
    80005b24:	05813483          	ld	s1,88(sp)
    80005b28:	05013903          	ld	s2,80(sp)
    80005b2c:	04813983          	ld	s3,72(sp)
    80005b30:	04013a03          	ld	s4,64(sp)
    80005b34:	03813a83          	ld	s5,56(sp)
    80005b38:	02813b83          	ld	s7,40(sp)
    80005b3c:	02013c03          	ld	s8,32(sp)
    80005b40:	01813c83          	ld	s9,24(sp)
    80005b44:	40ab053b          	subw	a0,s6,a0
    80005b48:	03013b03          	ld	s6,48(sp)
    80005b4c:	07010113          	addi	sp,sp,112
    80005b50:	00008067          	ret
    80005b54:	00001097          	auipc	ra,0x1
    80005b58:	1d8080e7          	jalr	472(ra) # 80006d2c <push_on>
    80005b5c:	0984a703          	lw	a4,152(s1)
    80005b60:	09c4a783          	lw	a5,156(s1)
    80005b64:	0007879b          	sext.w	a5,a5
    80005b68:	fef70ce3          	beq	a4,a5,80005b60 <consoleread+0xfc>
    80005b6c:	00001097          	auipc	ra,0x1
    80005b70:	234080e7          	jalr	564(ra) # 80006da0 <pop_on>
    80005b74:	0984a783          	lw	a5,152(s1)
    80005b78:	07f7f713          	andi	a4,a5,127
    80005b7c:	00e48733          	add	a4,s1,a4
    80005b80:	01874703          	lbu	a4,24(a4)
    80005b84:	0017869b          	addiw	a3,a5,1
    80005b88:	08d4ac23          	sw	a3,152(s1)
    80005b8c:	00070c9b          	sext.w	s9,a4
    80005b90:	f5371ee3          	bne	a4,s3,80005aec <consoleread+0x88>
    80005b94:	000b851b          	sext.w	a0,s7
    80005b98:	f96bf2e3          	bgeu	s7,s6,80005b1c <consoleread+0xb8>
    80005b9c:	08f4ac23          	sw	a5,152(s1)
    80005ba0:	f7dff06f          	j	80005b1c <consoleread+0xb8>

0000000080005ba4 <consputc>:
    80005ba4:	10000793          	li	a5,256
    80005ba8:	00f50663          	beq	a0,a5,80005bb4 <consputc+0x10>
    80005bac:	00001317          	auipc	t1,0x1
    80005bb0:	9f430067          	jr	-1548(t1) # 800065a0 <uartputc_sync>
    80005bb4:	ff010113          	addi	sp,sp,-16
    80005bb8:	00113423          	sd	ra,8(sp)
    80005bbc:	00813023          	sd	s0,0(sp)
    80005bc0:	01010413          	addi	s0,sp,16
    80005bc4:	00800513          	li	a0,8
    80005bc8:	00001097          	auipc	ra,0x1
    80005bcc:	9d8080e7          	jalr	-1576(ra) # 800065a0 <uartputc_sync>
    80005bd0:	02000513          	li	a0,32
    80005bd4:	00001097          	auipc	ra,0x1
    80005bd8:	9cc080e7          	jalr	-1588(ra) # 800065a0 <uartputc_sync>
    80005bdc:	00013403          	ld	s0,0(sp)
    80005be0:	00813083          	ld	ra,8(sp)
    80005be4:	00800513          	li	a0,8
    80005be8:	01010113          	addi	sp,sp,16
    80005bec:	00001317          	auipc	t1,0x1
    80005bf0:	9b430067          	jr	-1612(t1) # 800065a0 <uartputc_sync>

0000000080005bf4 <consoleintr>:
    80005bf4:	fe010113          	addi	sp,sp,-32
    80005bf8:	00813823          	sd	s0,16(sp)
    80005bfc:	00913423          	sd	s1,8(sp)
    80005c00:	01213023          	sd	s2,0(sp)
    80005c04:	00113c23          	sd	ra,24(sp)
    80005c08:	02010413          	addi	s0,sp,32
    80005c0c:	00005917          	auipc	s2,0x5
    80005c10:	69c90913          	addi	s2,s2,1692 # 8000b2a8 <cons>
    80005c14:	00050493          	mv	s1,a0
    80005c18:	00090513          	mv	a0,s2
    80005c1c:	00001097          	auipc	ra,0x1
    80005c20:	e40080e7          	jalr	-448(ra) # 80006a5c <acquire>
    80005c24:	02048c63          	beqz	s1,80005c5c <consoleintr+0x68>
    80005c28:	0a092783          	lw	a5,160(s2)
    80005c2c:	09892703          	lw	a4,152(s2)
    80005c30:	07f00693          	li	a3,127
    80005c34:	40e7873b          	subw	a4,a5,a4
    80005c38:	02e6e263          	bltu	a3,a4,80005c5c <consoleintr+0x68>
    80005c3c:	00d00713          	li	a4,13
    80005c40:	04e48063          	beq	s1,a4,80005c80 <consoleintr+0x8c>
    80005c44:	07f7f713          	andi	a4,a5,127
    80005c48:	00e90733          	add	a4,s2,a4
    80005c4c:	0017879b          	addiw	a5,a5,1
    80005c50:	0af92023          	sw	a5,160(s2)
    80005c54:	00970c23          	sb	s1,24(a4)
    80005c58:	08f92e23          	sw	a5,156(s2)
    80005c5c:	01013403          	ld	s0,16(sp)
    80005c60:	01813083          	ld	ra,24(sp)
    80005c64:	00813483          	ld	s1,8(sp)
    80005c68:	00013903          	ld	s2,0(sp)
    80005c6c:	00005517          	auipc	a0,0x5
    80005c70:	63c50513          	addi	a0,a0,1596 # 8000b2a8 <cons>
    80005c74:	02010113          	addi	sp,sp,32
    80005c78:	00001317          	auipc	t1,0x1
    80005c7c:	eb030067          	jr	-336(t1) # 80006b28 <release>
    80005c80:	00a00493          	li	s1,10
    80005c84:	fc1ff06f          	j	80005c44 <consoleintr+0x50>

0000000080005c88 <consoleinit>:
    80005c88:	fe010113          	addi	sp,sp,-32
    80005c8c:	00113c23          	sd	ra,24(sp)
    80005c90:	00813823          	sd	s0,16(sp)
    80005c94:	00913423          	sd	s1,8(sp)
    80005c98:	02010413          	addi	s0,sp,32
    80005c9c:	00005497          	auipc	s1,0x5
    80005ca0:	60c48493          	addi	s1,s1,1548 # 8000b2a8 <cons>
    80005ca4:	00048513          	mv	a0,s1
    80005ca8:	00003597          	auipc	a1,0x3
    80005cac:	a5858593          	addi	a1,a1,-1448 # 80008700 <CONSOLE_STATUS+0x6f0>
    80005cb0:	00001097          	auipc	ra,0x1
    80005cb4:	d88080e7          	jalr	-632(ra) # 80006a38 <initlock>
    80005cb8:	00000097          	auipc	ra,0x0
    80005cbc:	7ac080e7          	jalr	1964(ra) # 80006464 <uartinit>
    80005cc0:	01813083          	ld	ra,24(sp)
    80005cc4:	01013403          	ld	s0,16(sp)
    80005cc8:	00000797          	auipc	a5,0x0
    80005ccc:	d9c78793          	addi	a5,a5,-612 # 80005a64 <consoleread>
    80005cd0:	0af4bc23          	sd	a5,184(s1)
    80005cd4:	00000797          	auipc	a5,0x0
    80005cd8:	cec78793          	addi	a5,a5,-788 # 800059c0 <consolewrite>
    80005cdc:	0cf4b023          	sd	a5,192(s1)
    80005ce0:	00813483          	ld	s1,8(sp)
    80005ce4:	02010113          	addi	sp,sp,32
    80005ce8:	00008067          	ret

0000000080005cec <console_read>:
    80005cec:	ff010113          	addi	sp,sp,-16
    80005cf0:	00813423          	sd	s0,8(sp)
    80005cf4:	01010413          	addi	s0,sp,16
    80005cf8:	00813403          	ld	s0,8(sp)
    80005cfc:	00005317          	auipc	t1,0x5
    80005d00:	66433303          	ld	t1,1636(t1) # 8000b360 <devsw+0x10>
    80005d04:	01010113          	addi	sp,sp,16
    80005d08:	00030067          	jr	t1

0000000080005d0c <console_write>:
    80005d0c:	ff010113          	addi	sp,sp,-16
    80005d10:	00813423          	sd	s0,8(sp)
    80005d14:	01010413          	addi	s0,sp,16
    80005d18:	00813403          	ld	s0,8(sp)
    80005d1c:	00005317          	auipc	t1,0x5
    80005d20:	64c33303          	ld	t1,1612(t1) # 8000b368 <devsw+0x18>
    80005d24:	01010113          	addi	sp,sp,16
    80005d28:	00030067          	jr	t1

0000000080005d2c <panic>:
    80005d2c:	fe010113          	addi	sp,sp,-32
    80005d30:	00113c23          	sd	ra,24(sp)
    80005d34:	00813823          	sd	s0,16(sp)
    80005d38:	00913423          	sd	s1,8(sp)
    80005d3c:	02010413          	addi	s0,sp,32
    80005d40:	00050493          	mv	s1,a0
    80005d44:	00003517          	auipc	a0,0x3
    80005d48:	9c450513          	addi	a0,a0,-1596 # 80008708 <CONSOLE_STATUS+0x6f8>
    80005d4c:	00005797          	auipc	a5,0x5
    80005d50:	6a07ae23          	sw	zero,1724(a5) # 8000b408 <pr+0x18>
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	034080e7          	jalr	52(ra) # 80005d88 <__printf>
    80005d5c:	00048513          	mv	a0,s1
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	028080e7          	jalr	40(ra) # 80005d88 <__printf>
    80005d68:	00002517          	auipc	a0,0x2
    80005d6c:	44050513          	addi	a0,a0,1088 # 800081a8 <CONSOLE_STATUS+0x198>
    80005d70:	00000097          	auipc	ra,0x0
    80005d74:	018080e7          	jalr	24(ra) # 80005d88 <__printf>
    80005d78:	00100793          	li	a5,1
    80005d7c:	00004717          	auipc	a4,0x4
    80005d80:	3cf72623          	sw	a5,972(a4) # 8000a148 <panicked>
    80005d84:	0000006f          	j	80005d84 <panic+0x58>

0000000080005d88 <__printf>:
    80005d88:	f3010113          	addi	sp,sp,-208
    80005d8c:	08813023          	sd	s0,128(sp)
    80005d90:	07313423          	sd	s3,104(sp)
    80005d94:	09010413          	addi	s0,sp,144
    80005d98:	05813023          	sd	s8,64(sp)
    80005d9c:	08113423          	sd	ra,136(sp)
    80005da0:	06913c23          	sd	s1,120(sp)
    80005da4:	07213823          	sd	s2,112(sp)
    80005da8:	07413023          	sd	s4,96(sp)
    80005dac:	05513c23          	sd	s5,88(sp)
    80005db0:	05613823          	sd	s6,80(sp)
    80005db4:	05713423          	sd	s7,72(sp)
    80005db8:	03913c23          	sd	s9,56(sp)
    80005dbc:	03a13823          	sd	s10,48(sp)
    80005dc0:	03b13423          	sd	s11,40(sp)
    80005dc4:	00005317          	auipc	t1,0x5
    80005dc8:	62c30313          	addi	t1,t1,1580 # 8000b3f0 <pr>
    80005dcc:	01832c03          	lw	s8,24(t1)
    80005dd0:	00b43423          	sd	a1,8(s0)
    80005dd4:	00c43823          	sd	a2,16(s0)
    80005dd8:	00d43c23          	sd	a3,24(s0)
    80005ddc:	02e43023          	sd	a4,32(s0)
    80005de0:	02f43423          	sd	a5,40(s0)
    80005de4:	03043823          	sd	a6,48(s0)
    80005de8:	03143c23          	sd	a7,56(s0)
    80005dec:	00050993          	mv	s3,a0
    80005df0:	4a0c1663          	bnez	s8,8000629c <__printf+0x514>
    80005df4:	60098c63          	beqz	s3,8000640c <__printf+0x684>
    80005df8:	0009c503          	lbu	a0,0(s3)
    80005dfc:	00840793          	addi	a5,s0,8
    80005e00:	f6f43c23          	sd	a5,-136(s0)
    80005e04:	00000493          	li	s1,0
    80005e08:	22050063          	beqz	a0,80006028 <__printf+0x2a0>
    80005e0c:	00002a37          	lui	s4,0x2
    80005e10:	00018ab7          	lui	s5,0x18
    80005e14:	000f4b37          	lui	s6,0xf4
    80005e18:	00989bb7          	lui	s7,0x989
    80005e1c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005e20:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005e24:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005e28:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80005e2c:	00148c9b          	addiw	s9,s1,1
    80005e30:	02500793          	li	a5,37
    80005e34:	01998933          	add	s2,s3,s9
    80005e38:	38f51263          	bne	a0,a5,800061bc <__printf+0x434>
    80005e3c:	00094783          	lbu	a5,0(s2)
    80005e40:	00078c9b          	sext.w	s9,a5
    80005e44:	1e078263          	beqz	a5,80006028 <__printf+0x2a0>
    80005e48:	0024849b          	addiw	s1,s1,2
    80005e4c:	07000713          	li	a4,112
    80005e50:	00998933          	add	s2,s3,s1
    80005e54:	38e78a63          	beq	a5,a4,800061e8 <__printf+0x460>
    80005e58:	20f76863          	bltu	a4,a5,80006068 <__printf+0x2e0>
    80005e5c:	42a78863          	beq	a5,a0,8000628c <__printf+0x504>
    80005e60:	06400713          	li	a4,100
    80005e64:	40e79663          	bne	a5,a4,80006270 <__printf+0x4e8>
    80005e68:	f7843783          	ld	a5,-136(s0)
    80005e6c:	0007a603          	lw	a2,0(a5)
    80005e70:	00878793          	addi	a5,a5,8
    80005e74:	f6f43c23          	sd	a5,-136(s0)
    80005e78:	42064a63          	bltz	a2,800062ac <__printf+0x524>
    80005e7c:	00a00713          	li	a4,10
    80005e80:	02e677bb          	remuw	a5,a2,a4
    80005e84:	00003d97          	auipc	s11,0x3
    80005e88:	8acd8d93          	addi	s11,s11,-1876 # 80008730 <digits>
    80005e8c:	00900593          	li	a1,9
    80005e90:	0006051b          	sext.w	a0,a2
    80005e94:	00000c93          	li	s9,0
    80005e98:	02079793          	slli	a5,a5,0x20
    80005e9c:	0207d793          	srli	a5,a5,0x20
    80005ea0:	00fd87b3          	add	a5,s11,a5
    80005ea4:	0007c783          	lbu	a5,0(a5)
    80005ea8:	02e656bb          	divuw	a3,a2,a4
    80005eac:	f8f40023          	sb	a5,-128(s0)
    80005eb0:	14c5d863          	bge	a1,a2,80006000 <__printf+0x278>
    80005eb4:	06300593          	li	a1,99
    80005eb8:	00100c93          	li	s9,1
    80005ebc:	02e6f7bb          	remuw	a5,a3,a4
    80005ec0:	02079793          	slli	a5,a5,0x20
    80005ec4:	0207d793          	srli	a5,a5,0x20
    80005ec8:	00fd87b3          	add	a5,s11,a5
    80005ecc:	0007c783          	lbu	a5,0(a5)
    80005ed0:	02e6d73b          	divuw	a4,a3,a4
    80005ed4:	f8f400a3          	sb	a5,-127(s0)
    80005ed8:	12a5f463          	bgeu	a1,a0,80006000 <__printf+0x278>
    80005edc:	00a00693          	li	a3,10
    80005ee0:	00900593          	li	a1,9
    80005ee4:	02d777bb          	remuw	a5,a4,a3
    80005ee8:	02079793          	slli	a5,a5,0x20
    80005eec:	0207d793          	srli	a5,a5,0x20
    80005ef0:	00fd87b3          	add	a5,s11,a5
    80005ef4:	0007c503          	lbu	a0,0(a5)
    80005ef8:	02d757bb          	divuw	a5,a4,a3
    80005efc:	f8a40123          	sb	a0,-126(s0)
    80005f00:	48e5f263          	bgeu	a1,a4,80006384 <__printf+0x5fc>
    80005f04:	06300513          	li	a0,99
    80005f08:	02d7f5bb          	remuw	a1,a5,a3
    80005f0c:	02059593          	slli	a1,a1,0x20
    80005f10:	0205d593          	srli	a1,a1,0x20
    80005f14:	00bd85b3          	add	a1,s11,a1
    80005f18:	0005c583          	lbu	a1,0(a1)
    80005f1c:	02d7d7bb          	divuw	a5,a5,a3
    80005f20:	f8b401a3          	sb	a1,-125(s0)
    80005f24:	48e57263          	bgeu	a0,a4,800063a8 <__printf+0x620>
    80005f28:	3e700513          	li	a0,999
    80005f2c:	02d7f5bb          	remuw	a1,a5,a3
    80005f30:	02059593          	slli	a1,a1,0x20
    80005f34:	0205d593          	srli	a1,a1,0x20
    80005f38:	00bd85b3          	add	a1,s11,a1
    80005f3c:	0005c583          	lbu	a1,0(a1)
    80005f40:	02d7d7bb          	divuw	a5,a5,a3
    80005f44:	f8b40223          	sb	a1,-124(s0)
    80005f48:	46e57663          	bgeu	a0,a4,800063b4 <__printf+0x62c>
    80005f4c:	02d7f5bb          	remuw	a1,a5,a3
    80005f50:	02059593          	slli	a1,a1,0x20
    80005f54:	0205d593          	srli	a1,a1,0x20
    80005f58:	00bd85b3          	add	a1,s11,a1
    80005f5c:	0005c583          	lbu	a1,0(a1)
    80005f60:	02d7d7bb          	divuw	a5,a5,a3
    80005f64:	f8b402a3          	sb	a1,-123(s0)
    80005f68:	46ea7863          	bgeu	s4,a4,800063d8 <__printf+0x650>
    80005f6c:	02d7f5bb          	remuw	a1,a5,a3
    80005f70:	02059593          	slli	a1,a1,0x20
    80005f74:	0205d593          	srli	a1,a1,0x20
    80005f78:	00bd85b3          	add	a1,s11,a1
    80005f7c:	0005c583          	lbu	a1,0(a1)
    80005f80:	02d7d7bb          	divuw	a5,a5,a3
    80005f84:	f8b40323          	sb	a1,-122(s0)
    80005f88:	3eeaf863          	bgeu	s5,a4,80006378 <__printf+0x5f0>
    80005f8c:	02d7f5bb          	remuw	a1,a5,a3
    80005f90:	02059593          	slli	a1,a1,0x20
    80005f94:	0205d593          	srli	a1,a1,0x20
    80005f98:	00bd85b3          	add	a1,s11,a1
    80005f9c:	0005c583          	lbu	a1,0(a1)
    80005fa0:	02d7d7bb          	divuw	a5,a5,a3
    80005fa4:	f8b403a3          	sb	a1,-121(s0)
    80005fa8:	42eb7e63          	bgeu	s6,a4,800063e4 <__printf+0x65c>
    80005fac:	02d7f5bb          	remuw	a1,a5,a3
    80005fb0:	02059593          	slli	a1,a1,0x20
    80005fb4:	0205d593          	srli	a1,a1,0x20
    80005fb8:	00bd85b3          	add	a1,s11,a1
    80005fbc:	0005c583          	lbu	a1,0(a1)
    80005fc0:	02d7d7bb          	divuw	a5,a5,a3
    80005fc4:	f8b40423          	sb	a1,-120(s0)
    80005fc8:	42ebfc63          	bgeu	s7,a4,80006400 <__printf+0x678>
    80005fcc:	02079793          	slli	a5,a5,0x20
    80005fd0:	0207d793          	srli	a5,a5,0x20
    80005fd4:	00fd8db3          	add	s11,s11,a5
    80005fd8:	000dc703          	lbu	a4,0(s11)
    80005fdc:	00a00793          	li	a5,10
    80005fe0:	00900c93          	li	s9,9
    80005fe4:	f8e404a3          	sb	a4,-119(s0)
    80005fe8:	00065c63          	bgez	a2,80006000 <__printf+0x278>
    80005fec:	f9040713          	addi	a4,s0,-112
    80005ff0:	00f70733          	add	a4,a4,a5
    80005ff4:	02d00693          	li	a3,45
    80005ff8:	fed70823          	sb	a3,-16(a4)
    80005ffc:	00078c93          	mv	s9,a5
    80006000:	f8040793          	addi	a5,s0,-128
    80006004:	01978cb3          	add	s9,a5,s9
    80006008:	f7f40d13          	addi	s10,s0,-129
    8000600c:	000cc503          	lbu	a0,0(s9)
    80006010:	fffc8c93          	addi	s9,s9,-1
    80006014:	00000097          	auipc	ra,0x0
    80006018:	b90080e7          	jalr	-1136(ra) # 80005ba4 <consputc>
    8000601c:	ffac98e3          	bne	s9,s10,8000600c <__printf+0x284>
    80006020:	00094503          	lbu	a0,0(s2)
    80006024:	e00514e3          	bnez	a0,80005e2c <__printf+0xa4>
    80006028:	1a0c1663          	bnez	s8,800061d4 <__printf+0x44c>
    8000602c:	08813083          	ld	ra,136(sp)
    80006030:	08013403          	ld	s0,128(sp)
    80006034:	07813483          	ld	s1,120(sp)
    80006038:	07013903          	ld	s2,112(sp)
    8000603c:	06813983          	ld	s3,104(sp)
    80006040:	06013a03          	ld	s4,96(sp)
    80006044:	05813a83          	ld	s5,88(sp)
    80006048:	05013b03          	ld	s6,80(sp)
    8000604c:	04813b83          	ld	s7,72(sp)
    80006050:	04013c03          	ld	s8,64(sp)
    80006054:	03813c83          	ld	s9,56(sp)
    80006058:	03013d03          	ld	s10,48(sp)
    8000605c:	02813d83          	ld	s11,40(sp)
    80006060:	0d010113          	addi	sp,sp,208
    80006064:	00008067          	ret
    80006068:	07300713          	li	a4,115
    8000606c:	1ce78a63          	beq	a5,a4,80006240 <__printf+0x4b8>
    80006070:	07800713          	li	a4,120
    80006074:	1ee79e63          	bne	a5,a4,80006270 <__printf+0x4e8>
    80006078:	f7843783          	ld	a5,-136(s0)
    8000607c:	0007a703          	lw	a4,0(a5)
    80006080:	00878793          	addi	a5,a5,8
    80006084:	f6f43c23          	sd	a5,-136(s0)
    80006088:	28074263          	bltz	a4,8000630c <__printf+0x584>
    8000608c:	00002d97          	auipc	s11,0x2
    80006090:	6a4d8d93          	addi	s11,s11,1700 # 80008730 <digits>
    80006094:	00f77793          	andi	a5,a4,15
    80006098:	00fd87b3          	add	a5,s11,a5
    8000609c:	0007c683          	lbu	a3,0(a5)
    800060a0:	00f00613          	li	a2,15
    800060a4:	0007079b          	sext.w	a5,a4
    800060a8:	f8d40023          	sb	a3,-128(s0)
    800060ac:	0047559b          	srliw	a1,a4,0x4
    800060b0:	0047569b          	srliw	a3,a4,0x4
    800060b4:	00000c93          	li	s9,0
    800060b8:	0ee65063          	bge	a2,a4,80006198 <__printf+0x410>
    800060bc:	00f6f693          	andi	a3,a3,15
    800060c0:	00dd86b3          	add	a3,s11,a3
    800060c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800060c8:	0087d79b          	srliw	a5,a5,0x8
    800060cc:	00100c93          	li	s9,1
    800060d0:	f8d400a3          	sb	a3,-127(s0)
    800060d4:	0cb67263          	bgeu	a2,a1,80006198 <__printf+0x410>
    800060d8:	00f7f693          	andi	a3,a5,15
    800060dc:	00dd86b3          	add	a3,s11,a3
    800060e0:	0006c583          	lbu	a1,0(a3)
    800060e4:	00f00613          	li	a2,15
    800060e8:	0047d69b          	srliw	a3,a5,0x4
    800060ec:	f8b40123          	sb	a1,-126(s0)
    800060f0:	0047d593          	srli	a1,a5,0x4
    800060f4:	28f67e63          	bgeu	a2,a5,80006390 <__printf+0x608>
    800060f8:	00f6f693          	andi	a3,a3,15
    800060fc:	00dd86b3          	add	a3,s11,a3
    80006100:	0006c503          	lbu	a0,0(a3)
    80006104:	0087d813          	srli	a6,a5,0x8
    80006108:	0087d69b          	srliw	a3,a5,0x8
    8000610c:	f8a401a3          	sb	a0,-125(s0)
    80006110:	28b67663          	bgeu	a2,a1,8000639c <__printf+0x614>
    80006114:	00f6f693          	andi	a3,a3,15
    80006118:	00dd86b3          	add	a3,s11,a3
    8000611c:	0006c583          	lbu	a1,0(a3)
    80006120:	00c7d513          	srli	a0,a5,0xc
    80006124:	00c7d69b          	srliw	a3,a5,0xc
    80006128:	f8b40223          	sb	a1,-124(s0)
    8000612c:	29067a63          	bgeu	a2,a6,800063c0 <__printf+0x638>
    80006130:	00f6f693          	andi	a3,a3,15
    80006134:	00dd86b3          	add	a3,s11,a3
    80006138:	0006c583          	lbu	a1,0(a3)
    8000613c:	0107d813          	srli	a6,a5,0x10
    80006140:	0107d69b          	srliw	a3,a5,0x10
    80006144:	f8b402a3          	sb	a1,-123(s0)
    80006148:	28a67263          	bgeu	a2,a0,800063cc <__printf+0x644>
    8000614c:	00f6f693          	andi	a3,a3,15
    80006150:	00dd86b3          	add	a3,s11,a3
    80006154:	0006c683          	lbu	a3,0(a3)
    80006158:	0147d79b          	srliw	a5,a5,0x14
    8000615c:	f8d40323          	sb	a3,-122(s0)
    80006160:	21067663          	bgeu	a2,a6,8000636c <__printf+0x5e4>
    80006164:	02079793          	slli	a5,a5,0x20
    80006168:	0207d793          	srli	a5,a5,0x20
    8000616c:	00fd8db3          	add	s11,s11,a5
    80006170:	000dc683          	lbu	a3,0(s11)
    80006174:	00800793          	li	a5,8
    80006178:	00700c93          	li	s9,7
    8000617c:	f8d403a3          	sb	a3,-121(s0)
    80006180:	00075c63          	bgez	a4,80006198 <__printf+0x410>
    80006184:	f9040713          	addi	a4,s0,-112
    80006188:	00f70733          	add	a4,a4,a5
    8000618c:	02d00693          	li	a3,45
    80006190:	fed70823          	sb	a3,-16(a4)
    80006194:	00078c93          	mv	s9,a5
    80006198:	f8040793          	addi	a5,s0,-128
    8000619c:	01978cb3          	add	s9,a5,s9
    800061a0:	f7f40d13          	addi	s10,s0,-129
    800061a4:	000cc503          	lbu	a0,0(s9)
    800061a8:	fffc8c93          	addi	s9,s9,-1
    800061ac:	00000097          	auipc	ra,0x0
    800061b0:	9f8080e7          	jalr	-1544(ra) # 80005ba4 <consputc>
    800061b4:	ff9d18e3          	bne	s10,s9,800061a4 <__printf+0x41c>
    800061b8:	0100006f          	j	800061c8 <__printf+0x440>
    800061bc:	00000097          	auipc	ra,0x0
    800061c0:	9e8080e7          	jalr	-1560(ra) # 80005ba4 <consputc>
    800061c4:	000c8493          	mv	s1,s9
    800061c8:	00094503          	lbu	a0,0(s2)
    800061cc:	c60510e3          	bnez	a0,80005e2c <__printf+0xa4>
    800061d0:	e40c0ee3          	beqz	s8,8000602c <__printf+0x2a4>
    800061d4:	00005517          	auipc	a0,0x5
    800061d8:	21c50513          	addi	a0,a0,540 # 8000b3f0 <pr>
    800061dc:	00001097          	auipc	ra,0x1
    800061e0:	94c080e7          	jalr	-1716(ra) # 80006b28 <release>
    800061e4:	e49ff06f          	j	8000602c <__printf+0x2a4>
    800061e8:	f7843783          	ld	a5,-136(s0)
    800061ec:	03000513          	li	a0,48
    800061f0:	01000d13          	li	s10,16
    800061f4:	00878713          	addi	a4,a5,8
    800061f8:	0007bc83          	ld	s9,0(a5)
    800061fc:	f6e43c23          	sd	a4,-136(s0)
    80006200:	00000097          	auipc	ra,0x0
    80006204:	9a4080e7          	jalr	-1628(ra) # 80005ba4 <consputc>
    80006208:	07800513          	li	a0,120
    8000620c:	00000097          	auipc	ra,0x0
    80006210:	998080e7          	jalr	-1640(ra) # 80005ba4 <consputc>
    80006214:	00002d97          	auipc	s11,0x2
    80006218:	51cd8d93          	addi	s11,s11,1308 # 80008730 <digits>
    8000621c:	03ccd793          	srli	a5,s9,0x3c
    80006220:	00fd87b3          	add	a5,s11,a5
    80006224:	0007c503          	lbu	a0,0(a5)
    80006228:	fffd0d1b          	addiw	s10,s10,-1
    8000622c:	004c9c93          	slli	s9,s9,0x4
    80006230:	00000097          	auipc	ra,0x0
    80006234:	974080e7          	jalr	-1676(ra) # 80005ba4 <consputc>
    80006238:	fe0d12e3          	bnez	s10,8000621c <__printf+0x494>
    8000623c:	f8dff06f          	j	800061c8 <__printf+0x440>
    80006240:	f7843783          	ld	a5,-136(s0)
    80006244:	0007bc83          	ld	s9,0(a5)
    80006248:	00878793          	addi	a5,a5,8
    8000624c:	f6f43c23          	sd	a5,-136(s0)
    80006250:	000c9a63          	bnez	s9,80006264 <__printf+0x4dc>
    80006254:	1080006f          	j	8000635c <__printf+0x5d4>
    80006258:	001c8c93          	addi	s9,s9,1
    8000625c:	00000097          	auipc	ra,0x0
    80006260:	948080e7          	jalr	-1720(ra) # 80005ba4 <consputc>
    80006264:	000cc503          	lbu	a0,0(s9)
    80006268:	fe0518e3          	bnez	a0,80006258 <__printf+0x4d0>
    8000626c:	f5dff06f          	j	800061c8 <__printf+0x440>
    80006270:	02500513          	li	a0,37
    80006274:	00000097          	auipc	ra,0x0
    80006278:	930080e7          	jalr	-1744(ra) # 80005ba4 <consputc>
    8000627c:	000c8513          	mv	a0,s9
    80006280:	00000097          	auipc	ra,0x0
    80006284:	924080e7          	jalr	-1756(ra) # 80005ba4 <consputc>
    80006288:	f41ff06f          	j	800061c8 <__printf+0x440>
    8000628c:	02500513          	li	a0,37
    80006290:	00000097          	auipc	ra,0x0
    80006294:	914080e7          	jalr	-1772(ra) # 80005ba4 <consputc>
    80006298:	f31ff06f          	j	800061c8 <__printf+0x440>
    8000629c:	00030513          	mv	a0,t1
    800062a0:	00000097          	auipc	ra,0x0
    800062a4:	7bc080e7          	jalr	1980(ra) # 80006a5c <acquire>
    800062a8:	b4dff06f          	j	80005df4 <__printf+0x6c>
    800062ac:	40c0053b          	negw	a0,a2
    800062b0:	00a00713          	li	a4,10
    800062b4:	02e576bb          	remuw	a3,a0,a4
    800062b8:	00002d97          	auipc	s11,0x2
    800062bc:	478d8d93          	addi	s11,s11,1144 # 80008730 <digits>
    800062c0:	ff700593          	li	a1,-9
    800062c4:	02069693          	slli	a3,a3,0x20
    800062c8:	0206d693          	srli	a3,a3,0x20
    800062cc:	00dd86b3          	add	a3,s11,a3
    800062d0:	0006c683          	lbu	a3,0(a3)
    800062d4:	02e557bb          	divuw	a5,a0,a4
    800062d8:	f8d40023          	sb	a3,-128(s0)
    800062dc:	10b65e63          	bge	a2,a1,800063f8 <__printf+0x670>
    800062e0:	06300593          	li	a1,99
    800062e4:	02e7f6bb          	remuw	a3,a5,a4
    800062e8:	02069693          	slli	a3,a3,0x20
    800062ec:	0206d693          	srli	a3,a3,0x20
    800062f0:	00dd86b3          	add	a3,s11,a3
    800062f4:	0006c683          	lbu	a3,0(a3)
    800062f8:	02e7d73b          	divuw	a4,a5,a4
    800062fc:	00200793          	li	a5,2
    80006300:	f8d400a3          	sb	a3,-127(s0)
    80006304:	bca5ece3          	bltu	a1,a0,80005edc <__printf+0x154>
    80006308:	ce5ff06f          	j	80005fec <__printf+0x264>
    8000630c:	40e007bb          	negw	a5,a4
    80006310:	00002d97          	auipc	s11,0x2
    80006314:	420d8d93          	addi	s11,s11,1056 # 80008730 <digits>
    80006318:	00f7f693          	andi	a3,a5,15
    8000631c:	00dd86b3          	add	a3,s11,a3
    80006320:	0006c583          	lbu	a1,0(a3)
    80006324:	ff100613          	li	a2,-15
    80006328:	0047d69b          	srliw	a3,a5,0x4
    8000632c:	f8b40023          	sb	a1,-128(s0)
    80006330:	0047d59b          	srliw	a1,a5,0x4
    80006334:	0ac75e63          	bge	a4,a2,800063f0 <__printf+0x668>
    80006338:	00f6f693          	andi	a3,a3,15
    8000633c:	00dd86b3          	add	a3,s11,a3
    80006340:	0006c603          	lbu	a2,0(a3)
    80006344:	00f00693          	li	a3,15
    80006348:	0087d79b          	srliw	a5,a5,0x8
    8000634c:	f8c400a3          	sb	a2,-127(s0)
    80006350:	d8b6e4e3          	bltu	a3,a1,800060d8 <__printf+0x350>
    80006354:	00200793          	li	a5,2
    80006358:	e2dff06f          	j	80006184 <__printf+0x3fc>
    8000635c:	00002c97          	auipc	s9,0x2
    80006360:	3b4c8c93          	addi	s9,s9,948 # 80008710 <CONSOLE_STATUS+0x700>
    80006364:	02800513          	li	a0,40
    80006368:	ef1ff06f          	j	80006258 <__printf+0x4d0>
    8000636c:	00700793          	li	a5,7
    80006370:	00600c93          	li	s9,6
    80006374:	e0dff06f          	j	80006180 <__printf+0x3f8>
    80006378:	00700793          	li	a5,7
    8000637c:	00600c93          	li	s9,6
    80006380:	c69ff06f          	j	80005fe8 <__printf+0x260>
    80006384:	00300793          	li	a5,3
    80006388:	00200c93          	li	s9,2
    8000638c:	c5dff06f          	j	80005fe8 <__printf+0x260>
    80006390:	00300793          	li	a5,3
    80006394:	00200c93          	li	s9,2
    80006398:	de9ff06f          	j	80006180 <__printf+0x3f8>
    8000639c:	00400793          	li	a5,4
    800063a0:	00300c93          	li	s9,3
    800063a4:	dddff06f          	j	80006180 <__printf+0x3f8>
    800063a8:	00400793          	li	a5,4
    800063ac:	00300c93          	li	s9,3
    800063b0:	c39ff06f          	j	80005fe8 <__printf+0x260>
    800063b4:	00500793          	li	a5,5
    800063b8:	00400c93          	li	s9,4
    800063bc:	c2dff06f          	j	80005fe8 <__printf+0x260>
    800063c0:	00500793          	li	a5,5
    800063c4:	00400c93          	li	s9,4
    800063c8:	db9ff06f          	j	80006180 <__printf+0x3f8>
    800063cc:	00600793          	li	a5,6
    800063d0:	00500c93          	li	s9,5
    800063d4:	dadff06f          	j	80006180 <__printf+0x3f8>
    800063d8:	00600793          	li	a5,6
    800063dc:	00500c93          	li	s9,5
    800063e0:	c09ff06f          	j	80005fe8 <__printf+0x260>
    800063e4:	00800793          	li	a5,8
    800063e8:	00700c93          	li	s9,7
    800063ec:	bfdff06f          	j	80005fe8 <__printf+0x260>
    800063f0:	00100793          	li	a5,1
    800063f4:	d91ff06f          	j	80006184 <__printf+0x3fc>
    800063f8:	00100793          	li	a5,1
    800063fc:	bf1ff06f          	j	80005fec <__printf+0x264>
    80006400:	00900793          	li	a5,9
    80006404:	00800c93          	li	s9,8
    80006408:	be1ff06f          	j	80005fe8 <__printf+0x260>
    8000640c:	00002517          	auipc	a0,0x2
    80006410:	30c50513          	addi	a0,a0,780 # 80008718 <CONSOLE_STATUS+0x708>
    80006414:	00000097          	auipc	ra,0x0
    80006418:	918080e7          	jalr	-1768(ra) # 80005d2c <panic>

000000008000641c <printfinit>:
    8000641c:	fe010113          	addi	sp,sp,-32
    80006420:	00813823          	sd	s0,16(sp)
    80006424:	00913423          	sd	s1,8(sp)
    80006428:	00113c23          	sd	ra,24(sp)
    8000642c:	02010413          	addi	s0,sp,32
    80006430:	00005497          	auipc	s1,0x5
    80006434:	fc048493          	addi	s1,s1,-64 # 8000b3f0 <pr>
    80006438:	00048513          	mv	a0,s1
    8000643c:	00002597          	auipc	a1,0x2
    80006440:	2ec58593          	addi	a1,a1,748 # 80008728 <CONSOLE_STATUS+0x718>
    80006444:	00000097          	auipc	ra,0x0
    80006448:	5f4080e7          	jalr	1524(ra) # 80006a38 <initlock>
    8000644c:	01813083          	ld	ra,24(sp)
    80006450:	01013403          	ld	s0,16(sp)
    80006454:	0004ac23          	sw	zero,24(s1)
    80006458:	00813483          	ld	s1,8(sp)
    8000645c:	02010113          	addi	sp,sp,32
    80006460:	00008067          	ret

0000000080006464 <uartinit>:
    80006464:	ff010113          	addi	sp,sp,-16
    80006468:	00813423          	sd	s0,8(sp)
    8000646c:	01010413          	addi	s0,sp,16
    80006470:	100007b7          	lui	a5,0x10000
    80006474:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80006478:	f8000713          	li	a4,-128
    8000647c:	00e781a3          	sb	a4,3(a5)
    80006480:	00300713          	li	a4,3
    80006484:	00e78023          	sb	a4,0(a5)
    80006488:	000780a3          	sb	zero,1(a5)
    8000648c:	00e781a3          	sb	a4,3(a5)
    80006490:	00700693          	li	a3,7
    80006494:	00d78123          	sb	a3,2(a5)
    80006498:	00e780a3          	sb	a4,1(a5)
    8000649c:	00813403          	ld	s0,8(sp)
    800064a0:	01010113          	addi	sp,sp,16
    800064a4:	00008067          	ret

00000000800064a8 <uartputc>:
    800064a8:	00004797          	auipc	a5,0x4
    800064ac:	ca07a783          	lw	a5,-864(a5) # 8000a148 <panicked>
    800064b0:	00078463          	beqz	a5,800064b8 <uartputc+0x10>
    800064b4:	0000006f          	j	800064b4 <uartputc+0xc>
    800064b8:	fd010113          	addi	sp,sp,-48
    800064bc:	02813023          	sd	s0,32(sp)
    800064c0:	00913c23          	sd	s1,24(sp)
    800064c4:	01213823          	sd	s2,16(sp)
    800064c8:	01313423          	sd	s3,8(sp)
    800064cc:	02113423          	sd	ra,40(sp)
    800064d0:	03010413          	addi	s0,sp,48
    800064d4:	00004917          	auipc	s2,0x4
    800064d8:	c7c90913          	addi	s2,s2,-900 # 8000a150 <uart_tx_r>
    800064dc:	00093783          	ld	a5,0(s2)
    800064e0:	00004497          	auipc	s1,0x4
    800064e4:	c7848493          	addi	s1,s1,-904 # 8000a158 <uart_tx_w>
    800064e8:	0004b703          	ld	a4,0(s1)
    800064ec:	02078693          	addi	a3,a5,32
    800064f0:	00050993          	mv	s3,a0
    800064f4:	02e69c63          	bne	a3,a4,8000652c <uartputc+0x84>
    800064f8:	00001097          	auipc	ra,0x1
    800064fc:	834080e7          	jalr	-1996(ra) # 80006d2c <push_on>
    80006500:	00093783          	ld	a5,0(s2)
    80006504:	0004b703          	ld	a4,0(s1)
    80006508:	02078793          	addi	a5,a5,32
    8000650c:	00e79463          	bne	a5,a4,80006514 <uartputc+0x6c>
    80006510:	0000006f          	j	80006510 <uartputc+0x68>
    80006514:	00001097          	auipc	ra,0x1
    80006518:	88c080e7          	jalr	-1908(ra) # 80006da0 <pop_on>
    8000651c:	00093783          	ld	a5,0(s2)
    80006520:	0004b703          	ld	a4,0(s1)
    80006524:	02078693          	addi	a3,a5,32
    80006528:	fce688e3          	beq	a3,a4,800064f8 <uartputc+0x50>
    8000652c:	01f77693          	andi	a3,a4,31
    80006530:	00005597          	auipc	a1,0x5
    80006534:	ee058593          	addi	a1,a1,-288 # 8000b410 <uart_tx_buf>
    80006538:	00d586b3          	add	a3,a1,a3
    8000653c:	00170713          	addi	a4,a4,1
    80006540:	01368023          	sb	s3,0(a3)
    80006544:	00e4b023          	sd	a4,0(s1)
    80006548:	10000637          	lui	a2,0x10000
    8000654c:	02f71063          	bne	a4,a5,8000656c <uartputc+0xc4>
    80006550:	0340006f          	j	80006584 <uartputc+0xdc>
    80006554:	00074703          	lbu	a4,0(a4)
    80006558:	00f93023          	sd	a5,0(s2)
    8000655c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80006560:	00093783          	ld	a5,0(s2)
    80006564:	0004b703          	ld	a4,0(s1)
    80006568:	00f70e63          	beq	a4,a5,80006584 <uartputc+0xdc>
    8000656c:	00564683          	lbu	a3,5(a2)
    80006570:	01f7f713          	andi	a4,a5,31
    80006574:	00e58733          	add	a4,a1,a4
    80006578:	0206f693          	andi	a3,a3,32
    8000657c:	00178793          	addi	a5,a5,1
    80006580:	fc069ae3          	bnez	a3,80006554 <uartputc+0xac>
    80006584:	02813083          	ld	ra,40(sp)
    80006588:	02013403          	ld	s0,32(sp)
    8000658c:	01813483          	ld	s1,24(sp)
    80006590:	01013903          	ld	s2,16(sp)
    80006594:	00813983          	ld	s3,8(sp)
    80006598:	03010113          	addi	sp,sp,48
    8000659c:	00008067          	ret

00000000800065a0 <uartputc_sync>:
    800065a0:	ff010113          	addi	sp,sp,-16
    800065a4:	00813423          	sd	s0,8(sp)
    800065a8:	01010413          	addi	s0,sp,16
    800065ac:	00004717          	auipc	a4,0x4
    800065b0:	b9c72703          	lw	a4,-1124(a4) # 8000a148 <panicked>
    800065b4:	02071663          	bnez	a4,800065e0 <uartputc_sync+0x40>
    800065b8:	00050793          	mv	a5,a0
    800065bc:	100006b7          	lui	a3,0x10000
    800065c0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800065c4:	02077713          	andi	a4,a4,32
    800065c8:	fe070ce3          	beqz	a4,800065c0 <uartputc_sync+0x20>
    800065cc:	0ff7f793          	andi	a5,a5,255
    800065d0:	00f68023          	sb	a5,0(a3)
    800065d4:	00813403          	ld	s0,8(sp)
    800065d8:	01010113          	addi	sp,sp,16
    800065dc:	00008067          	ret
    800065e0:	0000006f          	j	800065e0 <uartputc_sync+0x40>

00000000800065e4 <uartstart>:
    800065e4:	ff010113          	addi	sp,sp,-16
    800065e8:	00813423          	sd	s0,8(sp)
    800065ec:	01010413          	addi	s0,sp,16
    800065f0:	00004617          	auipc	a2,0x4
    800065f4:	b6060613          	addi	a2,a2,-1184 # 8000a150 <uart_tx_r>
    800065f8:	00004517          	auipc	a0,0x4
    800065fc:	b6050513          	addi	a0,a0,-1184 # 8000a158 <uart_tx_w>
    80006600:	00063783          	ld	a5,0(a2)
    80006604:	00053703          	ld	a4,0(a0)
    80006608:	04f70263          	beq	a4,a5,8000664c <uartstart+0x68>
    8000660c:	100005b7          	lui	a1,0x10000
    80006610:	00005817          	auipc	a6,0x5
    80006614:	e0080813          	addi	a6,a6,-512 # 8000b410 <uart_tx_buf>
    80006618:	01c0006f          	j	80006634 <uartstart+0x50>
    8000661c:	0006c703          	lbu	a4,0(a3)
    80006620:	00f63023          	sd	a5,0(a2)
    80006624:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80006628:	00063783          	ld	a5,0(a2)
    8000662c:	00053703          	ld	a4,0(a0)
    80006630:	00f70e63          	beq	a4,a5,8000664c <uartstart+0x68>
    80006634:	01f7f713          	andi	a4,a5,31
    80006638:	00e806b3          	add	a3,a6,a4
    8000663c:	0055c703          	lbu	a4,5(a1)
    80006640:	00178793          	addi	a5,a5,1
    80006644:	02077713          	andi	a4,a4,32
    80006648:	fc071ae3          	bnez	a4,8000661c <uartstart+0x38>
    8000664c:	00813403          	ld	s0,8(sp)
    80006650:	01010113          	addi	sp,sp,16
    80006654:	00008067          	ret

0000000080006658 <uartgetc>:
    80006658:	ff010113          	addi	sp,sp,-16
    8000665c:	00813423          	sd	s0,8(sp)
    80006660:	01010413          	addi	s0,sp,16
    80006664:	10000737          	lui	a4,0x10000
    80006668:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000666c:	0017f793          	andi	a5,a5,1
    80006670:	00078c63          	beqz	a5,80006688 <uartgetc+0x30>
    80006674:	00074503          	lbu	a0,0(a4)
    80006678:	0ff57513          	andi	a0,a0,255
    8000667c:	00813403          	ld	s0,8(sp)
    80006680:	01010113          	addi	sp,sp,16
    80006684:	00008067          	ret
    80006688:	fff00513          	li	a0,-1
    8000668c:	ff1ff06f          	j	8000667c <uartgetc+0x24>

0000000080006690 <uartintr>:
    80006690:	100007b7          	lui	a5,0x10000
    80006694:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006698:	0017f793          	andi	a5,a5,1
    8000669c:	0a078463          	beqz	a5,80006744 <uartintr+0xb4>
    800066a0:	fe010113          	addi	sp,sp,-32
    800066a4:	00813823          	sd	s0,16(sp)
    800066a8:	00913423          	sd	s1,8(sp)
    800066ac:	00113c23          	sd	ra,24(sp)
    800066b0:	02010413          	addi	s0,sp,32
    800066b4:	100004b7          	lui	s1,0x10000
    800066b8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800066bc:	0ff57513          	andi	a0,a0,255
    800066c0:	fffff097          	auipc	ra,0xfffff
    800066c4:	534080e7          	jalr	1332(ra) # 80005bf4 <consoleintr>
    800066c8:	0054c783          	lbu	a5,5(s1)
    800066cc:	0017f793          	andi	a5,a5,1
    800066d0:	fe0794e3          	bnez	a5,800066b8 <uartintr+0x28>
    800066d4:	00004617          	auipc	a2,0x4
    800066d8:	a7c60613          	addi	a2,a2,-1412 # 8000a150 <uart_tx_r>
    800066dc:	00004517          	auipc	a0,0x4
    800066e0:	a7c50513          	addi	a0,a0,-1412 # 8000a158 <uart_tx_w>
    800066e4:	00063783          	ld	a5,0(a2)
    800066e8:	00053703          	ld	a4,0(a0)
    800066ec:	04f70263          	beq	a4,a5,80006730 <uartintr+0xa0>
    800066f0:	100005b7          	lui	a1,0x10000
    800066f4:	00005817          	auipc	a6,0x5
    800066f8:	d1c80813          	addi	a6,a6,-740 # 8000b410 <uart_tx_buf>
    800066fc:	01c0006f          	j	80006718 <uartintr+0x88>
    80006700:	0006c703          	lbu	a4,0(a3)
    80006704:	00f63023          	sd	a5,0(a2)
    80006708:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000670c:	00063783          	ld	a5,0(a2)
    80006710:	00053703          	ld	a4,0(a0)
    80006714:	00f70e63          	beq	a4,a5,80006730 <uartintr+0xa0>
    80006718:	01f7f713          	andi	a4,a5,31
    8000671c:	00e806b3          	add	a3,a6,a4
    80006720:	0055c703          	lbu	a4,5(a1)
    80006724:	00178793          	addi	a5,a5,1
    80006728:	02077713          	andi	a4,a4,32
    8000672c:	fc071ae3          	bnez	a4,80006700 <uartintr+0x70>
    80006730:	01813083          	ld	ra,24(sp)
    80006734:	01013403          	ld	s0,16(sp)
    80006738:	00813483          	ld	s1,8(sp)
    8000673c:	02010113          	addi	sp,sp,32
    80006740:	00008067          	ret
    80006744:	00004617          	auipc	a2,0x4
    80006748:	a0c60613          	addi	a2,a2,-1524 # 8000a150 <uart_tx_r>
    8000674c:	00004517          	auipc	a0,0x4
    80006750:	a0c50513          	addi	a0,a0,-1524 # 8000a158 <uart_tx_w>
    80006754:	00063783          	ld	a5,0(a2)
    80006758:	00053703          	ld	a4,0(a0)
    8000675c:	04f70263          	beq	a4,a5,800067a0 <uartintr+0x110>
    80006760:	100005b7          	lui	a1,0x10000
    80006764:	00005817          	auipc	a6,0x5
    80006768:	cac80813          	addi	a6,a6,-852 # 8000b410 <uart_tx_buf>
    8000676c:	01c0006f          	j	80006788 <uartintr+0xf8>
    80006770:	0006c703          	lbu	a4,0(a3)
    80006774:	00f63023          	sd	a5,0(a2)
    80006778:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000677c:	00063783          	ld	a5,0(a2)
    80006780:	00053703          	ld	a4,0(a0)
    80006784:	02f70063          	beq	a4,a5,800067a4 <uartintr+0x114>
    80006788:	01f7f713          	andi	a4,a5,31
    8000678c:	00e806b3          	add	a3,a6,a4
    80006790:	0055c703          	lbu	a4,5(a1)
    80006794:	00178793          	addi	a5,a5,1
    80006798:	02077713          	andi	a4,a4,32
    8000679c:	fc071ae3          	bnez	a4,80006770 <uartintr+0xe0>
    800067a0:	00008067          	ret
    800067a4:	00008067          	ret

00000000800067a8 <kinit>:
    800067a8:	fc010113          	addi	sp,sp,-64
    800067ac:	02913423          	sd	s1,40(sp)
    800067b0:	fffff7b7          	lui	a5,0xfffff
    800067b4:	00006497          	auipc	s1,0x6
    800067b8:	c7b48493          	addi	s1,s1,-901 # 8000c42f <end+0xfff>
    800067bc:	02813823          	sd	s0,48(sp)
    800067c0:	01313c23          	sd	s3,24(sp)
    800067c4:	00f4f4b3          	and	s1,s1,a5
    800067c8:	02113c23          	sd	ra,56(sp)
    800067cc:	03213023          	sd	s2,32(sp)
    800067d0:	01413823          	sd	s4,16(sp)
    800067d4:	01513423          	sd	s5,8(sp)
    800067d8:	04010413          	addi	s0,sp,64
    800067dc:	000017b7          	lui	a5,0x1
    800067e0:	01100993          	li	s3,17
    800067e4:	00f487b3          	add	a5,s1,a5
    800067e8:	01b99993          	slli	s3,s3,0x1b
    800067ec:	06f9e063          	bltu	s3,a5,8000684c <kinit+0xa4>
    800067f0:	00005a97          	auipc	s5,0x5
    800067f4:	c40a8a93          	addi	s5,s5,-960 # 8000b430 <end>
    800067f8:	0754ec63          	bltu	s1,s5,80006870 <kinit+0xc8>
    800067fc:	0734fa63          	bgeu	s1,s3,80006870 <kinit+0xc8>
    80006800:	00088a37          	lui	s4,0x88
    80006804:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006808:	00004917          	auipc	s2,0x4
    8000680c:	95890913          	addi	s2,s2,-1704 # 8000a160 <kmem>
    80006810:	00ca1a13          	slli	s4,s4,0xc
    80006814:	0140006f          	j	80006828 <kinit+0x80>
    80006818:	000017b7          	lui	a5,0x1
    8000681c:	00f484b3          	add	s1,s1,a5
    80006820:	0554e863          	bltu	s1,s5,80006870 <kinit+0xc8>
    80006824:	0534f663          	bgeu	s1,s3,80006870 <kinit+0xc8>
    80006828:	00001637          	lui	a2,0x1
    8000682c:	00100593          	li	a1,1
    80006830:	00048513          	mv	a0,s1
    80006834:	00000097          	auipc	ra,0x0
    80006838:	5e4080e7          	jalr	1508(ra) # 80006e18 <__memset>
    8000683c:	00093783          	ld	a5,0(s2)
    80006840:	00f4b023          	sd	a5,0(s1)
    80006844:	00993023          	sd	s1,0(s2)
    80006848:	fd4498e3          	bne	s1,s4,80006818 <kinit+0x70>
    8000684c:	03813083          	ld	ra,56(sp)
    80006850:	03013403          	ld	s0,48(sp)
    80006854:	02813483          	ld	s1,40(sp)
    80006858:	02013903          	ld	s2,32(sp)
    8000685c:	01813983          	ld	s3,24(sp)
    80006860:	01013a03          	ld	s4,16(sp)
    80006864:	00813a83          	ld	s5,8(sp)
    80006868:	04010113          	addi	sp,sp,64
    8000686c:	00008067          	ret
    80006870:	00002517          	auipc	a0,0x2
    80006874:	ed850513          	addi	a0,a0,-296 # 80008748 <digits+0x18>
    80006878:	fffff097          	auipc	ra,0xfffff
    8000687c:	4b4080e7          	jalr	1204(ra) # 80005d2c <panic>

0000000080006880 <freerange>:
    80006880:	fc010113          	addi	sp,sp,-64
    80006884:	000017b7          	lui	a5,0x1
    80006888:	02913423          	sd	s1,40(sp)
    8000688c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80006890:	009504b3          	add	s1,a0,s1
    80006894:	fffff537          	lui	a0,0xfffff
    80006898:	02813823          	sd	s0,48(sp)
    8000689c:	02113c23          	sd	ra,56(sp)
    800068a0:	03213023          	sd	s2,32(sp)
    800068a4:	01313c23          	sd	s3,24(sp)
    800068a8:	01413823          	sd	s4,16(sp)
    800068ac:	01513423          	sd	s5,8(sp)
    800068b0:	01613023          	sd	s6,0(sp)
    800068b4:	04010413          	addi	s0,sp,64
    800068b8:	00a4f4b3          	and	s1,s1,a0
    800068bc:	00f487b3          	add	a5,s1,a5
    800068c0:	06f5e463          	bltu	a1,a5,80006928 <freerange+0xa8>
    800068c4:	00005a97          	auipc	s5,0x5
    800068c8:	b6ca8a93          	addi	s5,s5,-1172 # 8000b430 <end>
    800068cc:	0954e263          	bltu	s1,s5,80006950 <freerange+0xd0>
    800068d0:	01100993          	li	s3,17
    800068d4:	01b99993          	slli	s3,s3,0x1b
    800068d8:	0734fc63          	bgeu	s1,s3,80006950 <freerange+0xd0>
    800068dc:	00058a13          	mv	s4,a1
    800068e0:	00004917          	auipc	s2,0x4
    800068e4:	88090913          	addi	s2,s2,-1920 # 8000a160 <kmem>
    800068e8:	00002b37          	lui	s6,0x2
    800068ec:	0140006f          	j	80006900 <freerange+0x80>
    800068f0:	000017b7          	lui	a5,0x1
    800068f4:	00f484b3          	add	s1,s1,a5
    800068f8:	0554ec63          	bltu	s1,s5,80006950 <freerange+0xd0>
    800068fc:	0534fa63          	bgeu	s1,s3,80006950 <freerange+0xd0>
    80006900:	00001637          	lui	a2,0x1
    80006904:	00100593          	li	a1,1
    80006908:	00048513          	mv	a0,s1
    8000690c:	00000097          	auipc	ra,0x0
    80006910:	50c080e7          	jalr	1292(ra) # 80006e18 <__memset>
    80006914:	00093703          	ld	a4,0(s2)
    80006918:	016487b3          	add	a5,s1,s6
    8000691c:	00e4b023          	sd	a4,0(s1)
    80006920:	00993023          	sd	s1,0(s2)
    80006924:	fcfa76e3          	bgeu	s4,a5,800068f0 <freerange+0x70>
    80006928:	03813083          	ld	ra,56(sp)
    8000692c:	03013403          	ld	s0,48(sp)
    80006930:	02813483          	ld	s1,40(sp)
    80006934:	02013903          	ld	s2,32(sp)
    80006938:	01813983          	ld	s3,24(sp)
    8000693c:	01013a03          	ld	s4,16(sp)
    80006940:	00813a83          	ld	s5,8(sp)
    80006944:	00013b03          	ld	s6,0(sp)
    80006948:	04010113          	addi	sp,sp,64
    8000694c:	00008067          	ret
    80006950:	00002517          	auipc	a0,0x2
    80006954:	df850513          	addi	a0,a0,-520 # 80008748 <digits+0x18>
    80006958:	fffff097          	auipc	ra,0xfffff
    8000695c:	3d4080e7          	jalr	980(ra) # 80005d2c <panic>

0000000080006960 <kfree>:
    80006960:	fe010113          	addi	sp,sp,-32
    80006964:	00813823          	sd	s0,16(sp)
    80006968:	00113c23          	sd	ra,24(sp)
    8000696c:	00913423          	sd	s1,8(sp)
    80006970:	02010413          	addi	s0,sp,32
    80006974:	03451793          	slli	a5,a0,0x34
    80006978:	04079c63          	bnez	a5,800069d0 <kfree+0x70>
    8000697c:	00005797          	auipc	a5,0x5
    80006980:	ab478793          	addi	a5,a5,-1356 # 8000b430 <end>
    80006984:	00050493          	mv	s1,a0
    80006988:	04f56463          	bltu	a0,a5,800069d0 <kfree+0x70>
    8000698c:	01100793          	li	a5,17
    80006990:	01b79793          	slli	a5,a5,0x1b
    80006994:	02f57e63          	bgeu	a0,a5,800069d0 <kfree+0x70>
    80006998:	00001637          	lui	a2,0x1
    8000699c:	00100593          	li	a1,1
    800069a0:	00000097          	auipc	ra,0x0
    800069a4:	478080e7          	jalr	1144(ra) # 80006e18 <__memset>
    800069a8:	00003797          	auipc	a5,0x3
    800069ac:	7b878793          	addi	a5,a5,1976 # 8000a160 <kmem>
    800069b0:	0007b703          	ld	a4,0(a5)
    800069b4:	01813083          	ld	ra,24(sp)
    800069b8:	01013403          	ld	s0,16(sp)
    800069bc:	00e4b023          	sd	a4,0(s1)
    800069c0:	0097b023          	sd	s1,0(a5)
    800069c4:	00813483          	ld	s1,8(sp)
    800069c8:	02010113          	addi	sp,sp,32
    800069cc:	00008067          	ret
    800069d0:	00002517          	auipc	a0,0x2
    800069d4:	d7850513          	addi	a0,a0,-648 # 80008748 <digits+0x18>
    800069d8:	fffff097          	auipc	ra,0xfffff
    800069dc:	354080e7          	jalr	852(ra) # 80005d2c <panic>

00000000800069e0 <kalloc>:
    800069e0:	fe010113          	addi	sp,sp,-32
    800069e4:	00813823          	sd	s0,16(sp)
    800069e8:	00913423          	sd	s1,8(sp)
    800069ec:	00113c23          	sd	ra,24(sp)
    800069f0:	02010413          	addi	s0,sp,32
    800069f4:	00003797          	auipc	a5,0x3
    800069f8:	76c78793          	addi	a5,a5,1900 # 8000a160 <kmem>
    800069fc:	0007b483          	ld	s1,0(a5)
    80006a00:	02048063          	beqz	s1,80006a20 <kalloc+0x40>
    80006a04:	0004b703          	ld	a4,0(s1)
    80006a08:	00001637          	lui	a2,0x1
    80006a0c:	00500593          	li	a1,5
    80006a10:	00048513          	mv	a0,s1
    80006a14:	00e7b023          	sd	a4,0(a5)
    80006a18:	00000097          	auipc	ra,0x0
    80006a1c:	400080e7          	jalr	1024(ra) # 80006e18 <__memset>
    80006a20:	01813083          	ld	ra,24(sp)
    80006a24:	01013403          	ld	s0,16(sp)
    80006a28:	00048513          	mv	a0,s1
    80006a2c:	00813483          	ld	s1,8(sp)
    80006a30:	02010113          	addi	sp,sp,32
    80006a34:	00008067          	ret

0000000080006a38 <initlock>:
    80006a38:	ff010113          	addi	sp,sp,-16
    80006a3c:	00813423          	sd	s0,8(sp)
    80006a40:	01010413          	addi	s0,sp,16
    80006a44:	00813403          	ld	s0,8(sp)
    80006a48:	00b53423          	sd	a1,8(a0)
    80006a4c:	00052023          	sw	zero,0(a0)
    80006a50:	00053823          	sd	zero,16(a0)
    80006a54:	01010113          	addi	sp,sp,16
    80006a58:	00008067          	ret

0000000080006a5c <acquire>:
    80006a5c:	fe010113          	addi	sp,sp,-32
    80006a60:	00813823          	sd	s0,16(sp)
    80006a64:	00913423          	sd	s1,8(sp)
    80006a68:	00113c23          	sd	ra,24(sp)
    80006a6c:	01213023          	sd	s2,0(sp)
    80006a70:	02010413          	addi	s0,sp,32
    80006a74:	00050493          	mv	s1,a0
    80006a78:	10002973          	csrr	s2,sstatus
    80006a7c:	100027f3          	csrr	a5,sstatus
    80006a80:	ffd7f793          	andi	a5,a5,-3
    80006a84:	10079073          	csrw	sstatus,a5
    80006a88:	fffff097          	auipc	ra,0xfffff
    80006a8c:	8ec080e7          	jalr	-1812(ra) # 80005374 <mycpu>
    80006a90:	07852783          	lw	a5,120(a0)
    80006a94:	06078e63          	beqz	a5,80006b10 <acquire+0xb4>
    80006a98:	fffff097          	auipc	ra,0xfffff
    80006a9c:	8dc080e7          	jalr	-1828(ra) # 80005374 <mycpu>
    80006aa0:	07852783          	lw	a5,120(a0)
    80006aa4:	0004a703          	lw	a4,0(s1)
    80006aa8:	0017879b          	addiw	a5,a5,1
    80006aac:	06f52c23          	sw	a5,120(a0)
    80006ab0:	04071063          	bnez	a4,80006af0 <acquire+0x94>
    80006ab4:	00100713          	li	a4,1
    80006ab8:	00070793          	mv	a5,a4
    80006abc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006ac0:	0007879b          	sext.w	a5,a5
    80006ac4:	fe079ae3          	bnez	a5,80006ab8 <acquire+0x5c>
    80006ac8:	0ff0000f          	fence
    80006acc:	fffff097          	auipc	ra,0xfffff
    80006ad0:	8a8080e7          	jalr	-1880(ra) # 80005374 <mycpu>
    80006ad4:	01813083          	ld	ra,24(sp)
    80006ad8:	01013403          	ld	s0,16(sp)
    80006adc:	00a4b823          	sd	a0,16(s1)
    80006ae0:	00013903          	ld	s2,0(sp)
    80006ae4:	00813483          	ld	s1,8(sp)
    80006ae8:	02010113          	addi	sp,sp,32
    80006aec:	00008067          	ret
    80006af0:	0104b903          	ld	s2,16(s1)
    80006af4:	fffff097          	auipc	ra,0xfffff
    80006af8:	880080e7          	jalr	-1920(ra) # 80005374 <mycpu>
    80006afc:	faa91ce3          	bne	s2,a0,80006ab4 <acquire+0x58>
    80006b00:	00002517          	auipc	a0,0x2
    80006b04:	c5050513          	addi	a0,a0,-944 # 80008750 <digits+0x20>
    80006b08:	fffff097          	auipc	ra,0xfffff
    80006b0c:	224080e7          	jalr	548(ra) # 80005d2c <panic>
    80006b10:	00195913          	srli	s2,s2,0x1
    80006b14:	fffff097          	auipc	ra,0xfffff
    80006b18:	860080e7          	jalr	-1952(ra) # 80005374 <mycpu>
    80006b1c:	00197913          	andi	s2,s2,1
    80006b20:	07252e23          	sw	s2,124(a0)
    80006b24:	f75ff06f          	j	80006a98 <acquire+0x3c>

0000000080006b28 <release>:
    80006b28:	fe010113          	addi	sp,sp,-32
    80006b2c:	00813823          	sd	s0,16(sp)
    80006b30:	00113c23          	sd	ra,24(sp)
    80006b34:	00913423          	sd	s1,8(sp)
    80006b38:	01213023          	sd	s2,0(sp)
    80006b3c:	02010413          	addi	s0,sp,32
    80006b40:	00052783          	lw	a5,0(a0)
    80006b44:	00079a63          	bnez	a5,80006b58 <release+0x30>
    80006b48:	00002517          	auipc	a0,0x2
    80006b4c:	c1050513          	addi	a0,a0,-1008 # 80008758 <digits+0x28>
    80006b50:	fffff097          	auipc	ra,0xfffff
    80006b54:	1dc080e7          	jalr	476(ra) # 80005d2c <panic>
    80006b58:	01053903          	ld	s2,16(a0)
    80006b5c:	00050493          	mv	s1,a0
    80006b60:	fffff097          	auipc	ra,0xfffff
    80006b64:	814080e7          	jalr	-2028(ra) # 80005374 <mycpu>
    80006b68:	fea910e3          	bne	s2,a0,80006b48 <release+0x20>
    80006b6c:	0004b823          	sd	zero,16(s1)
    80006b70:	0ff0000f          	fence
    80006b74:	0f50000f          	fence	iorw,ow
    80006b78:	0804a02f          	amoswap.w	zero,zero,(s1)
    80006b7c:	ffffe097          	auipc	ra,0xffffe
    80006b80:	7f8080e7          	jalr	2040(ra) # 80005374 <mycpu>
    80006b84:	100027f3          	csrr	a5,sstatus
    80006b88:	0027f793          	andi	a5,a5,2
    80006b8c:	04079a63          	bnez	a5,80006be0 <release+0xb8>
    80006b90:	07852783          	lw	a5,120(a0)
    80006b94:	02f05e63          	blez	a5,80006bd0 <release+0xa8>
    80006b98:	fff7871b          	addiw	a4,a5,-1
    80006b9c:	06e52c23          	sw	a4,120(a0)
    80006ba0:	00071c63          	bnez	a4,80006bb8 <release+0x90>
    80006ba4:	07c52783          	lw	a5,124(a0)
    80006ba8:	00078863          	beqz	a5,80006bb8 <release+0x90>
    80006bac:	100027f3          	csrr	a5,sstatus
    80006bb0:	0027e793          	ori	a5,a5,2
    80006bb4:	10079073          	csrw	sstatus,a5
    80006bb8:	01813083          	ld	ra,24(sp)
    80006bbc:	01013403          	ld	s0,16(sp)
    80006bc0:	00813483          	ld	s1,8(sp)
    80006bc4:	00013903          	ld	s2,0(sp)
    80006bc8:	02010113          	addi	sp,sp,32
    80006bcc:	00008067          	ret
    80006bd0:	00002517          	auipc	a0,0x2
    80006bd4:	ba850513          	addi	a0,a0,-1112 # 80008778 <digits+0x48>
    80006bd8:	fffff097          	auipc	ra,0xfffff
    80006bdc:	154080e7          	jalr	340(ra) # 80005d2c <panic>
    80006be0:	00002517          	auipc	a0,0x2
    80006be4:	b8050513          	addi	a0,a0,-1152 # 80008760 <digits+0x30>
    80006be8:	fffff097          	auipc	ra,0xfffff
    80006bec:	144080e7          	jalr	324(ra) # 80005d2c <panic>

0000000080006bf0 <holding>:
    80006bf0:	00052783          	lw	a5,0(a0)
    80006bf4:	00079663          	bnez	a5,80006c00 <holding+0x10>
    80006bf8:	00000513          	li	a0,0
    80006bfc:	00008067          	ret
    80006c00:	fe010113          	addi	sp,sp,-32
    80006c04:	00813823          	sd	s0,16(sp)
    80006c08:	00913423          	sd	s1,8(sp)
    80006c0c:	00113c23          	sd	ra,24(sp)
    80006c10:	02010413          	addi	s0,sp,32
    80006c14:	01053483          	ld	s1,16(a0)
    80006c18:	ffffe097          	auipc	ra,0xffffe
    80006c1c:	75c080e7          	jalr	1884(ra) # 80005374 <mycpu>
    80006c20:	01813083          	ld	ra,24(sp)
    80006c24:	01013403          	ld	s0,16(sp)
    80006c28:	40a48533          	sub	a0,s1,a0
    80006c2c:	00153513          	seqz	a0,a0
    80006c30:	00813483          	ld	s1,8(sp)
    80006c34:	02010113          	addi	sp,sp,32
    80006c38:	00008067          	ret

0000000080006c3c <push_off>:
    80006c3c:	fe010113          	addi	sp,sp,-32
    80006c40:	00813823          	sd	s0,16(sp)
    80006c44:	00113c23          	sd	ra,24(sp)
    80006c48:	00913423          	sd	s1,8(sp)
    80006c4c:	02010413          	addi	s0,sp,32
    80006c50:	100024f3          	csrr	s1,sstatus
    80006c54:	100027f3          	csrr	a5,sstatus
    80006c58:	ffd7f793          	andi	a5,a5,-3
    80006c5c:	10079073          	csrw	sstatus,a5
    80006c60:	ffffe097          	auipc	ra,0xffffe
    80006c64:	714080e7          	jalr	1812(ra) # 80005374 <mycpu>
    80006c68:	07852783          	lw	a5,120(a0)
    80006c6c:	02078663          	beqz	a5,80006c98 <push_off+0x5c>
    80006c70:	ffffe097          	auipc	ra,0xffffe
    80006c74:	704080e7          	jalr	1796(ra) # 80005374 <mycpu>
    80006c78:	07852783          	lw	a5,120(a0)
    80006c7c:	01813083          	ld	ra,24(sp)
    80006c80:	01013403          	ld	s0,16(sp)
    80006c84:	0017879b          	addiw	a5,a5,1
    80006c88:	06f52c23          	sw	a5,120(a0)
    80006c8c:	00813483          	ld	s1,8(sp)
    80006c90:	02010113          	addi	sp,sp,32
    80006c94:	00008067          	ret
    80006c98:	0014d493          	srli	s1,s1,0x1
    80006c9c:	ffffe097          	auipc	ra,0xffffe
    80006ca0:	6d8080e7          	jalr	1752(ra) # 80005374 <mycpu>
    80006ca4:	0014f493          	andi	s1,s1,1
    80006ca8:	06952e23          	sw	s1,124(a0)
    80006cac:	fc5ff06f          	j	80006c70 <push_off+0x34>

0000000080006cb0 <pop_off>:
    80006cb0:	ff010113          	addi	sp,sp,-16
    80006cb4:	00813023          	sd	s0,0(sp)
    80006cb8:	00113423          	sd	ra,8(sp)
    80006cbc:	01010413          	addi	s0,sp,16
    80006cc0:	ffffe097          	auipc	ra,0xffffe
    80006cc4:	6b4080e7          	jalr	1716(ra) # 80005374 <mycpu>
    80006cc8:	100027f3          	csrr	a5,sstatus
    80006ccc:	0027f793          	andi	a5,a5,2
    80006cd0:	04079663          	bnez	a5,80006d1c <pop_off+0x6c>
    80006cd4:	07852783          	lw	a5,120(a0)
    80006cd8:	02f05a63          	blez	a5,80006d0c <pop_off+0x5c>
    80006cdc:	fff7871b          	addiw	a4,a5,-1
    80006ce0:	06e52c23          	sw	a4,120(a0)
    80006ce4:	00071c63          	bnez	a4,80006cfc <pop_off+0x4c>
    80006ce8:	07c52783          	lw	a5,124(a0)
    80006cec:	00078863          	beqz	a5,80006cfc <pop_off+0x4c>
    80006cf0:	100027f3          	csrr	a5,sstatus
    80006cf4:	0027e793          	ori	a5,a5,2
    80006cf8:	10079073          	csrw	sstatus,a5
    80006cfc:	00813083          	ld	ra,8(sp)
    80006d00:	00013403          	ld	s0,0(sp)
    80006d04:	01010113          	addi	sp,sp,16
    80006d08:	00008067          	ret
    80006d0c:	00002517          	auipc	a0,0x2
    80006d10:	a6c50513          	addi	a0,a0,-1428 # 80008778 <digits+0x48>
    80006d14:	fffff097          	auipc	ra,0xfffff
    80006d18:	018080e7          	jalr	24(ra) # 80005d2c <panic>
    80006d1c:	00002517          	auipc	a0,0x2
    80006d20:	a4450513          	addi	a0,a0,-1468 # 80008760 <digits+0x30>
    80006d24:	fffff097          	auipc	ra,0xfffff
    80006d28:	008080e7          	jalr	8(ra) # 80005d2c <panic>

0000000080006d2c <push_on>:
    80006d2c:	fe010113          	addi	sp,sp,-32
    80006d30:	00813823          	sd	s0,16(sp)
    80006d34:	00113c23          	sd	ra,24(sp)
    80006d38:	00913423          	sd	s1,8(sp)
    80006d3c:	02010413          	addi	s0,sp,32
    80006d40:	100024f3          	csrr	s1,sstatus
    80006d44:	100027f3          	csrr	a5,sstatus
    80006d48:	0027e793          	ori	a5,a5,2
    80006d4c:	10079073          	csrw	sstatus,a5
    80006d50:	ffffe097          	auipc	ra,0xffffe
    80006d54:	624080e7          	jalr	1572(ra) # 80005374 <mycpu>
    80006d58:	07852783          	lw	a5,120(a0)
    80006d5c:	02078663          	beqz	a5,80006d88 <push_on+0x5c>
    80006d60:	ffffe097          	auipc	ra,0xffffe
    80006d64:	614080e7          	jalr	1556(ra) # 80005374 <mycpu>
    80006d68:	07852783          	lw	a5,120(a0)
    80006d6c:	01813083          	ld	ra,24(sp)
    80006d70:	01013403          	ld	s0,16(sp)
    80006d74:	0017879b          	addiw	a5,a5,1
    80006d78:	06f52c23          	sw	a5,120(a0)
    80006d7c:	00813483          	ld	s1,8(sp)
    80006d80:	02010113          	addi	sp,sp,32
    80006d84:	00008067          	ret
    80006d88:	0014d493          	srli	s1,s1,0x1
    80006d8c:	ffffe097          	auipc	ra,0xffffe
    80006d90:	5e8080e7          	jalr	1512(ra) # 80005374 <mycpu>
    80006d94:	0014f493          	andi	s1,s1,1
    80006d98:	06952e23          	sw	s1,124(a0)
    80006d9c:	fc5ff06f          	j	80006d60 <push_on+0x34>

0000000080006da0 <pop_on>:
    80006da0:	ff010113          	addi	sp,sp,-16
    80006da4:	00813023          	sd	s0,0(sp)
    80006da8:	00113423          	sd	ra,8(sp)
    80006dac:	01010413          	addi	s0,sp,16
    80006db0:	ffffe097          	auipc	ra,0xffffe
    80006db4:	5c4080e7          	jalr	1476(ra) # 80005374 <mycpu>
    80006db8:	100027f3          	csrr	a5,sstatus
    80006dbc:	0027f793          	andi	a5,a5,2
    80006dc0:	04078463          	beqz	a5,80006e08 <pop_on+0x68>
    80006dc4:	07852783          	lw	a5,120(a0)
    80006dc8:	02f05863          	blez	a5,80006df8 <pop_on+0x58>
    80006dcc:	fff7879b          	addiw	a5,a5,-1
    80006dd0:	06f52c23          	sw	a5,120(a0)
    80006dd4:	07853783          	ld	a5,120(a0)
    80006dd8:	00079863          	bnez	a5,80006de8 <pop_on+0x48>
    80006ddc:	100027f3          	csrr	a5,sstatus
    80006de0:	ffd7f793          	andi	a5,a5,-3
    80006de4:	10079073          	csrw	sstatus,a5
    80006de8:	00813083          	ld	ra,8(sp)
    80006dec:	00013403          	ld	s0,0(sp)
    80006df0:	01010113          	addi	sp,sp,16
    80006df4:	00008067          	ret
    80006df8:	00002517          	auipc	a0,0x2
    80006dfc:	9a850513          	addi	a0,a0,-1624 # 800087a0 <digits+0x70>
    80006e00:	fffff097          	auipc	ra,0xfffff
    80006e04:	f2c080e7          	jalr	-212(ra) # 80005d2c <panic>
    80006e08:	00002517          	auipc	a0,0x2
    80006e0c:	97850513          	addi	a0,a0,-1672 # 80008780 <digits+0x50>
    80006e10:	fffff097          	auipc	ra,0xfffff
    80006e14:	f1c080e7          	jalr	-228(ra) # 80005d2c <panic>

0000000080006e18 <__memset>:
    80006e18:	ff010113          	addi	sp,sp,-16
    80006e1c:	00813423          	sd	s0,8(sp)
    80006e20:	01010413          	addi	s0,sp,16
    80006e24:	1a060e63          	beqz	a2,80006fe0 <__memset+0x1c8>
    80006e28:	40a007b3          	neg	a5,a0
    80006e2c:	0077f793          	andi	a5,a5,7
    80006e30:	00778693          	addi	a3,a5,7
    80006e34:	00b00813          	li	a6,11
    80006e38:	0ff5f593          	andi	a1,a1,255
    80006e3c:	fff6071b          	addiw	a4,a2,-1
    80006e40:	1b06e663          	bltu	a3,a6,80006fec <__memset+0x1d4>
    80006e44:	1cd76463          	bltu	a4,a3,8000700c <__memset+0x1f4>
    80006e48:	1a078e63          	beqz	a5,80007004 <__memset+0x1ec>
    80006e4c:	00b50023          	sb	a1,0(a0)
    80006e50:	00100713          	li	a4,1
    80006e54:	1ae78463          	beq	a5,a4,80006ffc <__memset+0x1e4>
    80006e58:	00b500a3          	sb	a1,1(a0)
    80006e5c:	00200713          	li	a4,2
    80006e60:	1ae78a63          	beq	a5,a4,80007014 <__memset+0x1fc>
    80006e64:	00b50123          	sb	a1,2(a0)
    80006e68:	00300713          	li	a4,3
    80006e6c:	18e78463          	beq	a5,a4,80006ff4 <__memset+0x1dc>
    80006e70:	00b501a3          	sb	a1,3(a0)
    80006e74:	00400713          	li	a4,4
    80006e78:	1ae78263          	beq	a5,a4,8000701c <__memset+0x204>
    80006e7c:	00b50223          	sb	a1,4(a0)
    80006e80:	00500713          	li	a4,5
    80006e84:	1ae78063          	beq	a5,a4,80007024 <__memset+0x20c>
    80006e88:	00b502a3          	sb	a1,5(a0)
    80006e8c:	00700713          	li	a4,7
    80006e90:	18e79e63          	bne	a5,a4,8000702c <__memset+0x214>
    80006e94:	00b50323          	sb	a1,6(a0)
    80006e98:	00700e93          	li	t4,7
    80006e9c:	00859713          	slli	a4,a1,0x8
    80006ea0:	00e5e733          	or	a4,a1,a4
    80006ea4:	01059e13          	slli	t3,a1,0x10
    80006ea8:	01c76e33          	or	t3,a4,t3
    80006eac:	01859313          	slli	t1,a1,0x18
    80006eb0:	006e6333          	or	t1,t3,t1
    80006eb4:	02059893          	slli	a7,a1,0x20
    80006eb8:	40f60e3b          	subw	t3,a2,a5
    80006ebc:	011368b3          	or	a7,t1,a7
    80006ec0:	02859813          	slli	a6,a1,0x28
    80006ec4:	0108e833          	or	a6,a7,a6
    80006ec8:	03059693          	slli	a3,a1,0x30
    80006ecc:	003e589b          	srliw	a7,t3,0x3
    80006ed0:	00d866b3          	or	a3,a6,a3
    80006ed4:	03859713          	slli	a4,a1,0x38
    80006ed8:	00389813          	slli	a6,a7,0x3
    80006edc:	00f507b3          	add	a5,a0,a5
    80006ee0:	00e6e733          	or	a4,a3,a4
    80006ee4:	000e089b          	sext.w	a7,t3
    80006ee8:	00f806b3          	add	a3,a6,a5
    80006eec:	00e7b023          	sd	a4,0(a5)
    80006ef0:	00878793          	addi	a5,a5,8
    80006ef4:	fed79ce3          	bne	a5,a3,80006eec <__memset+0xd4>
    80006ef8:	ff8e7793          	andi	a5,t3,-8
    80006efc:	0007871b          	sext.w	a4,a5
    80006f00:	01d787bb          	addw	a5,a5,t4
    80006f04:	0ce88e63          	beq	a7,a4,80006fe0 <__memset+0x1c8>
    80006f08:	00f50733          	add	a4,a0,a5
    80006f0c:	00b70023          	sb	a1,0(a4)
    80006f10:	0017871b          	addiw	a4,a5,1
    80006f14:	0cc77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f18:	00e50733          	add	a4,a0,a4
    80006f1c:	00b70023          	sb	a1,0(a4)
    80006f20:	0027871b          	addiw	a4,a5,2
    80006f24:	0ac77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f28:	00e50733          	add	a4,a0,a4
    80006f2c:	00b70023          	sb	a1,0(a4)
    80006f30:	0037871b          	addiw	a4,a5,3
    80006f34:	0ac77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f38:	00e50733          	add	a4,a0,a4
    80006f3c:	00b70023          	sb	a1,0(a4)
    80006f40:	0047871b          	addiw	a4,a5,4
    80006f44:	08c77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f48:	00e50733          	add	a4,a0,a4
    80006f4c:	00b70023          	sb	a1,0(a4)
    80006f50:	0057871b          	addiw	a4,a5,5
    80006f54:	08c77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f58:	00e50733          	add	a4,a0,a4
    80006f5c:	00b70023          	sb	a1,0(a4)
    80006f60:	0067871b          	addiw	a4,a5,6
    80006f64:	06c77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f68:	00e50733          	add	a4,a0,a4
    80006f6c:	00b70023          	sb	a1,0(a4)
    80006f70:	0077871b          	addiw	a4,a5,7
    80006f74:	06c77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f78:	00e50733          	add	a4,a0,a4
    80006f7c:	00b70023          	sb	a1,0(a4)
    80006f80:	0087871b          	addiw	a4,a5,8
    80006f84:	04c77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f88:	00e50733          	add	a4,a0,a4
    80006f8c:	00b70023          	sb	a1,0(a4)
    80006f90:	0097871b          	addiw	a4,a5,9
    80006f94:	04c77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006f98:	00e50733          	add	a4,a0,a4
    80006f9c:	00b70023          	sb	a1,0(a4)
    80006fa0:	00a7871b          	addiw	a4,a5,10
    80006fa4:	02c77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006fa8:	00e50733          	add	a4,a0,a4
    80006fac:	00b70023          	sb	a1,0(a4)
    80006fb0:	00b7871b          	addiw	a4,a5,11
    80006fb4:	02c77663          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006fb8:	00e50733          	add	a4,a0,a4
    80006fbc:	00b70023          	sb	a1,0(a4)
    80006fc0:	00c7871b          	addiw	a4,a5,12
    80006fc4:	00c77e63          	bgeu	a4,a2,80006fe0 <__memset+0x1c8>
    80006fc8:	00e50733          	add	a4,a0,a4
    80006fcc:	00b70023          	sb	a1,0(a4)
    80006fd0:	00d7879b          	addiw	a5,a5,13
    80006fd4:	00c7f663          	bgeu	a5,a2,80006fe0 <__memset+0x1c8>
    80006fd8:	00f507b3          	add	a5,a0,a5
    80006fdc:	00b78023          	sb	a1,0(a5)
    80006fe0:	00813403          	ld	s0,8(sp)
    80006fe4:	01010113          	addi	sp,sp,16
    80006fe8:	00008067          	ret
    80006fec:	00b00693          	li	a3,11
    80006ff0:	e55ff06f          	j	80006e44 <__memset+0x2c>
    80006ff4:	00300e93          	li	t4,3
    80006ff8:	ea5ff06f          	j	80006e9c <__memset+0x84>
    80006ffc:	00100e93          	li	t4,1
    80007000:	e9dff06f          	j	80006e9c <__memset+0x84>
    80007004:	00000e93          	li	t4,0
    80007008:	e95ff06f          	j	80006e9c <__memset+0x84>
    8000700c:	00000793          	li	a5,0
    80007010:	ef9ff06f          	j	80006f08 <__memset+0xf0>
    80007014:	00200e93          	li	t4,2
    80007018:	e85ff06f          	j	80006e9c <__memset+0x84>
    8000701c:	00400e93          	li	t4,4
    80007020:	e7dff06f          	j	80006e9c <__memset+0x84>
    80007024:	00500e93          	li	t4,5
    80007028:	e75ff06f          	j	80006e9c <__memset+0x84>
    8000702c:	00600e93          	li	t4,6
    80007030:	e6dff06f          	j	80006e9c <__memset+0x84>

0000000080007034 <__memmove>:
    80007034:	ff010113          	addi	sp,sp,-16
    80007038:	00813423          	sd	s0,8(sp)
    8000703c:	01010413          	addi	s0,sp,16
    80007040:	0e060863          	beqz	a2,80007130 <__memmove+0xfc>
    80007044:	fff6069b          	addiw	a3,a2,-1
    80007048:	0006881b          	sext.w	a6,a3
    8000704c:	0ea5e863          	bltu	a1,a0,8000713c <__memmove+0x108>
    80007050:	00758713          	addi	a4,a1,7
    80007054:	00a5e7b3          	or	a5,a1,a0
    80007058:	40a70733          	sub	a4,a4,a0
    8000705c:	0077f793          	andi	a5,a5,7
    80007060:	00f73713          	sltiu	a4,a4,15
    80007064:	00174713          	xori	a4,a4,1
    80007068:	0017b793          	seqz	a5,a5
    8000706c:	00e7f7b3          	and	a5,a5,a4
    80007070:	10078863          	beqz	a5,80007180 <__memmove+0x14c>
    80007074:	00900793          	li	a5,9
    80007078:	1107f463          	bgeu	a5,a6,80007180 <__memmove+0x14c>
    8000707c:	0036581b          	srliw	a6,a2,0x3
    80007080:	fff8081b          	addiw	a6,a6,-1
    80007084:	02081813          	slli	a6,a6,0x20
    80007088:	01d85893          	srli	a7,a6,0x1d
    8000708c:	00858813          	addi	a6,a1,8
    80007090:	00058793          	mv	a5,a1
    80007094:	00050713          	mv	a4,a0
    80007098:	01088833          	add	a6,a7,a6
    8000709c:	0007b883          	ld	a7,0(a5)
    800070a0:	00878793          	addi	a5,a5,8
    800070a4:	00870713          	addi	a4,a4,8
    800070a8:	ff173c23          	sd	a7,-8(a4)
    800070ac:	ff0798e3          	bne	a5,a6,8000709c <__memmove+0x68>
    800070b0:	ff867713          	andi	a4,a2,-8
    800070b4:	02071793          	slli	a5,a4,0x20
    800070b8:	0207d793          	srli	a5,a5,0x20
    800070bc:	00f585b3          	add	a1,a1,a5
    800070c0:	40e686bb          	subw	a3,a3,a4
    800070c4:	00f507b3          	add	a5,a0,a5
    800070c8:	06e60463          	beq	a2,a4,80007130 <__memmove+0xfc>
    800070cc:	0005c703          	lbu	a4,0(a1)
    800070d0:	00e78023          	sb	a4,0(a5)
    800070d4:	04068e63          	beqz	a3,80007130 <__memmove+0xfc>
    800070d8:	0015c603          	lbu	a2,1(a1)
    800070dc:	00100713          	li	a4,1
    800070e0:	00c780a3          	sb	a2,1(a5)
    800070e4:	04e68663          	beq	a3,a4,80007130 <__memmove+0xfc>
    800070e8:	0025c603          	lbu	a2,2(a1)
    800070ec:	00200713          	li	a4,2
    800070f0:	00c78123          	sb	a2,2(a5)
    800070f4:	02e68e63          	beq	a3,a4,80007130 <__memmove+0xfc>
    800070f8:	0035c603          	lbu	a2,3(a1)
    800070fc:	00300713          	li	a4,3
    80007100:	00c781a3          	sb	a2,3(a5)
    80007104:	02e68663          	beq	a3,a4,80007130 <__memmove+0xfc>
    80007108:	0045c603          	lbu	a2,4(a1)
    8000710c:	00400713          	li	a4,4
    80007110:	00c78223          	sb	a2,4(a5)
    80007114:	00e68e63          	beq	a3,a4,80007130 <__memmove+0xfc>
    80007118:	0055c603          	lbu	a2,5(a1)
    8000711c:	00500713          	li	a4,5
    80007120:	00c782a3          	sb	a2,5(a5)
    80007124:	00e68663          	beq	a3,a4,80007130 <__memmove+0xfc>
    80007128:	0065c703          	lbu	a4,6(a1)
    8000712c:	00e78323          	sb	a4,6(a5)
    80007130:	00813403          	ld	s0,8(sp)
    80007134:	01010113          	addi	sp,sp,16
    80007138:	00008067          	ret
    8000713c:	02061713          	slli	a4,a2,0x20
    80007140:	02075713          	srli	a4,a4,0x20
    80007144:	00e587b3          	add	a5,a1,a4
    80007148:	f0f574e3          	bgeu	a0,a5,80007050 <__memmove+0x1c>
    8000714c:	02069613          	slli	a2,a3,0x20
    80007150:	02065613          	srli	a2,a2,0x20
    80007154:	fff64613          	not	a2,a2
    80007158:	00e50733          	add	a4,a0,a4
    8000715c:	00c78633          	add	a2,a5,a2
    80007160:	fff7c683          	lbu	a3,-1(a5)
    80007164:	fff78793          	addi	a5,a5,-1
    80007168:	fff70713          	addi	a4,a4,-1
    8000716c:	00d70023          	sb	a3,0(a4)
    80007170:	fec798e3          	bne	a5,a2,80007160 <__memmove+0x12c>
    80007174:	00813403          	ld	s0,8(sp)
    80007178:	01010113          	addi	sp,sp,16
    8000717c:	00008067          	ret
    80007180:	02069713          	slli	a4,a3,0x20
    80007184:	02075713          	srli	a4,a4,0x20
    80007188:	00170713          	addi	a4,a4,1
    8000718c:	00e50733          	add	a4,a0,a4
    80007190:	00050793          	mv	a5,a0
    80007194:	0005c683          	lbu	a3,0(a1)
    80007198:	00178793          	addi	a5,a5,1
    8000719c:	00158593          	addi	a1,a1,1
    800071a0:	fed78fa3          	sb	a3,-1(a5)
    800071a4:	fee798e3          	bne	a5,a4,80007194 <__memmove+0x160>
    800071a8:	f89ff06f          	j	80007130 <__memmove+0xfc>

00000000800071ac <__putc>:
    800071ac:	fe010113          	addi	sp,sp,-32
    800071b0:	00813823          	sd	s0,16(sp)
    800071b4:	00113c23          	sd	ra,24(sp)
    800071b8:	02010413          	addi	s0,sp,32
    800071bc:	00050793          	mv	a5,a0
    800071c0:	fef40593          	addi	a1,s0,-17
    800071c4:	00100613          	li	a2,1
    800071c8:	00000513          	li	a0,0
    800071cc:	fef407a3          	sb	a5,-17(s0)
    800071d0:	fffff097          	auipc	ra,0xfffff
    800071d4:	b3c080e7          	jalr	-1220(ra) # 80005d0c <console_write>
    800071d8:	01813083          	ld	ra,24(sp)
    800071dc:	01013403          	ld	s0,16(sp)
    800071e0:	02010113          	addi	sp,sp,32
    800071e4:	00008067          	ret

00000000800071e8 <__getc>:
    800071e8:	fe010113          	addi	sp,sp,-32
    800071ec:	00813823          	sd	s0,16(sp)
    800071f0:	00113c23          	sd	ra,24(sp)
    800071f4:	02010413          	addi	s0,sp,32
    800071f8:	fe840593          	addi	a1,s0,-24
    800071fc:	00100613          	li	a2,1
    80007200:	00000513          	li	a0,0
    80007204:	fffff097          	auipc	ra,0xfffff
    80007208:	ae8080e7          	jalr	-1304(ra) # 80005cec <console_read>
    8000720c:	fe844503          	lbu	a0,-24(s0)
    80007210:	01813083          	ld	ra,24(sp)
    80007214:	01013403          	ld	s0,16(sp)
    80007218:	02010113          	addi	sp,sp,32
    8000721c:	00008067          	ret

0000000080007220 <console_handler>:
    80007220:	fe010113          	addi	sp,sp,-32
    80007224:	00813823          	sd	s0,16(sp)
    80007228:	00113c23          	sd	ra,24(sp)
    8000722c:	00913423          	sd	s1,8(sp)
    80007230:	02010413          	addi	s0,sp,32
    80007234:	14202773          	csrr	a4,scause
    80007238:	100027f3          	csrr	a5,sstatus
    8000723c:	0027f793          	andi	a5,a5,2
    80007240:	06079e63          	bnez	a5,800072bc <console_handler+0x9c>
    80007244:	00074c63          	bltz	a4,8000725c <console_handler+0x3c>
    80007248:	01813083          	ld	ra,24(sp)
    8000724c:	01013403          	ld	s0,16(sp)
    80007250:	00813483          	ld	s1,8(sp)
    80007254:	02010113          	addi	sp,sp,32
    80007258:	00008067          	ret
    8000725c:	0ff77713          	andi	a4,a4,255
    80007260:	00900793          	li	a5,9
    80007264:	fef712e3          	bne	a4,a5,80007248 <console_handler+0x28>
    80007268:	ffffe097          	auipc	ra,0xffffe
    8000726c:	6dc080e7          	jalr	1756(ra) # 80005944 <plic_claim>
    80007270:	00a00793          	li	a5,10
    80007274:	00050493          	mv	s1,a0
    80007278:	02f50c63          	beq	a0,a5,800072b0 <console_handler+0x90>
    8000727c:	fc0506e3          	beqz	a0,80007248 <console_handler+0x28>
    80007280:	00050593          	mv	a1,a0
    80007284:	00001517          	auipc	a0,0x1
    80007288:	42450513          	addi	a0,a0,1060 # 800086a8 <CONSOLE_STATUS+0x698>
    8000728c:	fffff097          	auipc	ra,0xfffff
    80007290:	afc080e7          	jalr	-1284(ra) # 80005d88 <__printf>
    80007294:	01013403          	ld	s0,16(sp)
    80007298:	01813083          	ld	ra,24(sp)
    8000729c:	00048513          	mv	a0,s1
    800072a0:	00813483          	ld	s1,8(sp)
    800072a4:	02010113          	addi	sp,sp,32
    800072a8:	ffffe317          	auipc	t1,0xffffe
    800072ac:	6d430067          	jr	1748(t1) # 8000597c <plic_complete>
    800072b0:	fffff097          	auipc	ra,0xfffff
    800072b4:	3e0080e7          	jalr	992(ra) # 80006690 <uartintr>
    800072b8:	fddff06f          	j	80007294 <console_handler+0x74>
    800072bc:	00001517          	auipc	a0,0x1
    800072c0:	4ec50513          	addi	a0,a0,1260 # 800087a8 <digits+0x78>
    800072c4:	fffff097          	auipc	ra,0xfffff
    800072c8:	a68080e7          	jalr	-1432(ra) # 80005d2c <panic>
	...
