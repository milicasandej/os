
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	83813103          	ld	sp,-1992(sp) # 80005838 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4c1010ef          	jal	ra,80001cdc <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001000:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001004:	00013023          	sd	zero,0(sp)
    80001008:	00113423          	sd	ra,8(sp)
    8000100c:	00213823          	sd	sp,16(sp)
    80001010:	00313c23          	sd	gp,24(sp)
    80001014:	02413023          	sd	tp,32(sp)
    80001018:	02513423          	sd	t0,40(sp)
    8000101c:	02613823          	sd	t1,48(sp)
    80001020:	02713c23          	sd	t2,56(sp)
    80001024:	04813023          	sd	s0,64(sp)
    80001028:	04913423          	sd	s1,72(sp)
    8000102c:	04a13823          	sd	a0,80(sp)
    80001030:	04b13c23          	sd	a1,88(sp)
    80001034:	06c13023          	sd	a2,96(sp)
    80001038:	06d13423          	sd	a3,104(sp)
    8000103c:	06e13823          	sd	a4,112(sp)
    80001040:	06f13c23          	sd	a5,120(sp)
    80001044:	09013023          	sd	a6,128(sp)
    80001048:	09113423          	sd	a7,136(sp)
    8000104c:	09213823          	sd	s2,144(sp)
    80001050:	09313c23          	sd	s3,152(sp)
    80001054:	0b413023          	sd	s4,160(sp)
    80001058:	0b513423          	sd	s5,168(sp)
    8000105c:	0b613823          	sd	s6,176(sp)
    80001060:	0b713c23          	sd	s7,184(sp)
    80001064:	0d813023          	sd	s8,192(sp)
    80001068:	0d913423          	sd	s9,200(sp)
    8000106c:	0da13823          	sd	s10,208(sp)
    80001070:	0db13c23          	sd	s11,216(sp)
    80001074:	0fc13023          	sd	t3,224(sp)
    80001078:	0fd13423          	sd	t4,232(sp)
    8000107c:	0fe13823          	sd	t5,240(sp)
    80001080:	0ff13c23          	sd	t6,248(sp)

    call _ZN5Riscv20handleSupervisorTrapEv
    80001084:	121000ef          	jal	ra,800019a4 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    80001088:	00013003          	ld	zero,0(sp)
    8000108c:	00813083          	ld	ra,8(sp)
    80001090:	01013103          	ld	sp,16(sp)
    80001094:	01813183          	ld	gp,24(sp)
    80001098:	02013203          	ld	tp,32(sp)
    8000109c:	02813283          	ld	t0,40(sp)
    800010a0:	03013303          	ld	t1,48(sp)
    800010a4:	03813383          	ld	t2,56(sp)
    800010a8:	04013403          	ld	s0,64(sp)
    800010ac:	04813483          	ld	s1,72(sp)
    800010b0:	05013503          	ld	a0,80(sp)
    800010b4:	05813583          	ld	a1,88(sp)
    800010b8:	06013603          	ld	a2,96(sp)
    800010bc:	06813683          	ld	a3,104(sp)
    800010c0:	07013703          	ld	a4,112(sp)
    800010c4:	07813783          	ld	a5,120(sp)
    800010c8:	08013803          	ld	a6,128(sp)
    800010cc:	08813883          	ld	a7,136(sp)
    800010d0:	09013903          	ld	s2,144(sp)
    800010d4:	09813983          	ld	s3,152(sp)
    800010d8:	0a013a03          	ld	s4,160(sp)
    800010dc:	0a813a83          	ld	s5,168(sp)
    800010e0:	0b013b03          	ld	s6,176(sp)
    800010e4:	0b813b83          	ld	s7,184(sp)
    800010e8:	0c013c03          	ld	s8,192(sp)
    800010ec:	0c813c83          	ld	s9,200(sp)
    800010f0:	0d013d03          	ld	s10,208(sp)
    800010f4:	0d813d83          	ld	s11,216(sp)
    800010f8:	0e013e03          	ld	t3,224(sp)
    800010fc:	0e813e83          	ld	t4,232(sp)
    80001100:	0f013f03          	ld	t5,240(sp)
    80001104:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001108:	10010113          	addi	sp,sp,256

    sret
    8000110c:	10200073          	sret

0000000080001110 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001110:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001114:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001118:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000111c:	0085b103          	ld	sp,8(a1)

    80001120:	00008067          	ret

0000000080001124 <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"
#include "../lib/mem.h"


void* mem_alloc(size_t size){
    80001124:	ff010113          	addi	sp,sp,-16
    80001128:	00113423          	sd	ra,8(sp)
    8000112c:	00813023          	sd	s0,0(sp)
    80001130:	01010413          	addi	s0,sp,16
    return __mem_alloc(size); //TODO
    80001134:	00003097          	auipc	ra,0x3
    80001138:	d34080e7          	jalr	-716(ra) # 80003e68 <__mem_alloc>
}
    8000113c:	00813083          	ld	ra,8(sp)
    80001140:	00013403          	ld	s0,0(sp)
    80001144:	01010113          	addi	sp,sp,16
    80001148:	00008067          	ret

000000008000114c <_Z8mem_freePv>:

int mem_free(void* ptr){
    8000114c:	ff010113          	addi	sp,sp,-16
    80001150:	00113423          	sd	ra,8(sp)
    80001154:	00813023          	sd	s0,0(sp)
    80001158:	01010413          	addi	s0,sp,16
    return __mem_free(ptr); //TODO
    8000115c:	00003097          	auipc	ra,0x3
    80001160:	c40080e7          	jalr	-960(ra) # 80003d9c <__mem_free>
}
    80001164:	00813083          	ld	ra,8(sp)
    80001168:	00013403          	ld	s0,0(sp)
    8000116c:	01010113          	addi	sp,sp,16
    80001170:	00008067          	ret

0000000080001174 <_Z13thread_createPP7_threadPFvPvES2_>:
//
//size_t mem_get_largest_free_block(){
//    //TODO
//}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001174:	fd010113          	addi	sp,sp,-48
    80001178:	02113423          	sd	ra,40(sp)
    8000117c:	02813023          	sd	s0,32(sp)
    80001180:	00913c23          	sd	s1,24(sp)
    80001184:	01213823          	sd	s2,16(sp)
    80001188:	01313423          	sd	s3,8(sp)
    8000118c:	03010413          	addi	s0,sp,48
    uint64 r0, r1, r2;
    READ_REG(r0, "a0");
    80001190:	00050993          	mv	s3,a0
    READ_REG(r1, "a1");
    80001194:	00058913          	mv	s2,a1
    READ_REG(r2, "a2");
    80001198:	00060493          	mv	s1,a2

    void* stack = mem_alloc(DEFAULT_STACK_SIZE);
    8000119c:	00001537          	lui	a0,0x1
    800011a0:	00000097          	auipc	ra,0x0
    800011a4:	f84080e7          	jalr	-124(ra) # 80001124 <_Z9mem_allocm>

    WRITE_REG("a0", r0);
    800011a8:	00098513          	mv	a0,s3
    WRITE_REG("a1", r1);
    800011ac:	00090593          	mv	a1,s2
    WRITE_REG("a2", r2);
    800011b0:	00048613          	mv	a2,s1
    WRITE_REG("a3", (uint64)stack + DEFAULT_STACK_SIZE);
    800011b4:	000017b7          	lui	a5,0x1
    800011b8:	00f50533          	add	a0,a0,a5
    800011bc:	00050693          	mv	a3,a0
    WRITE_REG("a7", Num::SCALL_THREAD_CREATE);
    800011c0:	01100793          	li	a5,17
    800011c4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800011c8:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800011cc:	00050513          	mv	a0,a0
    return ret;
}
    800011d0:	0005051b          	sext.w	a0,a0
    800011d4:	02813083          	ld	ra,40(sp)
    800011d8:	02013403          	ld	s0,32(sp)
    800011dc:	01813483          	ld	s1,24(sp)
    800011e0:	01013903          	ld	s2,16(sp)
    800011e4:	00813983          	ld	s3,8(sp)
    800011e8:	03010113          	addi	sp,sp,48
    800011ec:	00008067          	ret

00000000800011f0 <_Z11thread_exitv>:

int thread_exit(){
    800011f0:	ff010113          	addi	sp,sp,-16
    800011f4:	00813423          	sd	s0,8(sp)
    800011f8:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_EXIT);
    800011fc:	01200793          	li	a5,18
    80001200:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001204:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    80001208:	00050513          	mv	a0,a0
    return ret;
}
    8000120c:	0005051b          	sext.w	a0,a0
    80001210:	00813403          	ld	s0,8(sp)
    80001214:	01010113          	addi	sp,sp,16
    80001218:	00008067          	ret

000000008000121c <_Z15thread_dispatchv>:

void thread_dispatch(){
    8000121c:	ff010113          	addi	sp,sp,-16
    80001220:	00813423          	sd	s0,8(sp)
    80001224:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_THREAD_DISPATCH);
    80001228:	01300793          	li	a5,19
    8000122c:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    80001230:	00000073          	ecall
}
    80001234:	00813403          	ld	s0,8(sp)
    80001238:	01010113          	addi	sp,sp,16
    8000123c:	00008067          	ret

0000000080001240 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00813423          	sd	s0,8(sp)
    80001248:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_OPEN);
    8000124c:	02100793          	li	a5,33
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

000000008000126c <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle) {
    8000126c:	ff010113          	addi	sp,sp,-16
    80001270:	00813423          	sd	s0,8(sp)
    80001274:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_CLOSE);
    80001278:	02200793          	li	a5,34
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

0000000080001298 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t id){
    80001298:	ff010113          	addi	sp,sp,-16
    8000129c:	00813423          	sd	s0,8(sp)
    800012a0:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_WAIT);
    800012a4:	02300793          	li	a5,35
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

00000000800012c4 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t id){
    800012c4:	ff010113          	addi	sp,sp,-16
    800012c8:	00813423          	sd	s0,8(sp)
    800012cc:	01010413          	addi	s0,sp,16
    WRITE_REG("a7", Num::SCALL_SEM_SIGNAL);
    800012d0:	02400793          	li	a5,36
    800012d4:	00078893          	mv	a7,a5

    __asm__ volatile("ecall");
    800012d8:	00000073          	ecall

    int ret;
    READ_REG(ret, "a0");
    800012dc:	00050513          	mv	a0,a0
    return ret;
    800012e0:	0005051b          	sext.w	a0,a0
    800012e4:	00813403          	ld	s0,8(sp)
    800012e8:	01010113          	addi	sp,sp,16
    800012ec:	00008067          	ret

00000000800012f0 <_ZN7_thread12createThreadEPFvvEPv>:
_thread *_thread::running = nullptr;

uint64 _thread::timeSliceCounter = 0;

_thread *_thread::createThread(Body body, void* args)
{
    800012f0:	fd010113          	addi	sp,sp,-48
    800012f4:	02113423          	sd	ra,40(sp)
    800012f8:	02813023          	sd	s0,32(sp)
    800012fc:	00913c23          	sd	s1,24(sp)
    80001300:	01213823          	sd	s2,16(sp)
    80001304:	01313423          	sd	s3,8(sp)
    80001308:	03010413          	addi	s0,sp,48
    8000130c:	00050913          	mv	s2,a0
    80001310:	00058993          	mv	s3,a1
    _thread* newThread = new _thread(body, args);
    80001314:	03800513          	li	a0,56
    80001318:	00000097          	auipc	ra,0x0
    8000131c:	5cc080e7          	jalr	1484(ra) # 800018e4 <_Znwm>
    80001320:	00050493          	mv	s1,a0
            args(args),
            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
                    }),
            finished(false)
    80001324:	01253023          	sd	s2,0(a0) # 1000 <_entry-0x7ffff000>
    80001328:	01353423          	sd	s3,8(a0)
            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),
    8000132c:	00090a63          	beqz	s2,80001340 <_ZN7_thread12createThreadEPFvvEPv+0x50>
    80001330:	00002537          	lui	a0,0x2
    80001334:	00000097          	auipc	ra,0x0
    80001338:	5d8080e7          	jalr	1496(ra) # 8000190c <_Znam>
    8000133c:	0080006f          	j	80001344 <_ZN7_thread12createThreadEPFvvEPv+0x54>
    80001340:	00000513          	li	a0,0
            finished(false)
    80001344:	00a4b823          	sd	a0,16(s1)
    80001348:	00000797          	auipc	a5,0x0
    8000134c:	0a078793          	addi	a5,a5,160 # 800013e8 <_ZN7_thread13threadWrapperEv>
    80001350:	00f4bc23          	sd	a5,24(s1)
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80001354:	02050463          	beqz	a0,8000137c <_ZN7_thread12createThreadEPFvvEPv+0x8c>
    80001358:	000027b7          	lui	a5,0x2
    8000135c:	00f507b3          	add	a5,a0,a5
            finished(false)
    80001360:	02f4b023          	sd	a5,32(s1)
    80001364:	02048823          	sb	zero,48(s1)
    {
        if (body != nullptr) { Scheduler::put(this); }
    80001368:	02090c63          	beqz	s2,800013a0 <_ZN7_thread12createThreadEPFvvEPv+0xb0>
    8000136c:	00048513          	mv	a0,s1
    80001370:	00000097          	auipc	ra,0x0
    80001374:	7a0080e7          	jalr	1952(ra) # 80001b10 <_ZN9Scheduler3putEP7_thread>
    80001378:	0280006f          	j	800013a0 <_ZN7_thread12createThreadEPFvvEPv+0xb0>
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    8000137c:	00000793          	li	a5,0
    80001380:	fe1ff06f          	j	80001360 <_ZN7_thread12createThreadEPFvvEPv+0x70>
    80001384:	00050913          	mv	s2,a0
    80001388:	00048513          	mv	a0,s1
    8000138c:	00000097          	auipc	ra,0x0
    80001390:	5a8080e7          	jalr	1448(ra) # 80001934 <_ZdlPv>
    80001394:	00090513          	mv	a0,s2
    80001398:	00005097          	auipc	ra,0x5
    8000139c:	5e0080e7          	jalr	1504(ra) # 80006978 <_Unwind_Resume>
    Scheduler::put(newThread);
    800013a0:	00048513          	mv	a0,s1
    800013a4:	00000097          	auipc	ra,0x0
    800013a8:	76c080e7          	jalr	1900(ra) # 80001b10 <_ZN9Scheduler3putEP7_thread>
    return newThread;
}
    800013ac:	00048513          	mv	a0,s1
    800013b0:	02813083          	ld	ra,40(sp)
    800013b4:	02013403          	ld	s0,32(sp)
    800013b8:	01813483          	ld	s1,24(sp)
    800013bc:	01013903          	ld	s2,16(sp)
    800013c0:	00813983          	ld	s3,8(sp)
    800013c4:	03010113          	addi	sp,sp,48
    800013c8:	00008067          	ret

00000000800013cc <_ZN7_thread5yieldEv>:

void _thread::yield()
{
    800013cc:	ff010113          	addi	sp,sp,-16
    800013d0:	00813423          	sd	s0,8(sp)
    800013d4:	01010413          	addi	s0,sp,16
    __asm__ volatile ("ecall");
    800013d8:	00000073          	ecall
}
    800013dc:	00813403          	ld	s0,8(sp)
    800013e0:	01010113          	addi	sp,sp,16
    800013e4:	00008067          	ret

00000000800013e8 <_ZN7_thread13threadWrapperEv>:

    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper()
{
    800013e8:	fe010113          	addi	sp,sp,-32
    800013ec:	00113c23          	sd	ra,24(sp)
    800013f0:	00813823          	sd	s0,16(sp)
    800013f4:	00913423          	sd	s1,8(sp)
    800013f8:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    800013fc:	00000097          	auipc	ra,0x0
    80001400:	588080e7          	jalr	1416(ra) # 80001984 <_ZN5Riscv10popSppSpieEv>
    running->body();
    80001404:	00004497          	auipc	s1,0x4
    80001408:	48c48493          	addi	s1,s1,1164 # 80005890 <_ZN7_thread7runningE>
    8000140c:	0004b783          	ld	a5,0(s1)
    80001410:	0007b783          	ld	a5,0(a5) # 2000 <_entry-0x7fffe000>
    80001414:	000780e7          	jalr	a5
    running->setFinished(true);
    80001418:	0004b783          	ld	a5,0(s1)
    void setFinished(bool value) { finished = value; }
    8000141c:	00100713          	li	a4,1
    80001420:	02e78823          	sb	a4,48(a5)
    _thread::yield();
    80001424:	00000097          	auipc	ra,0x0
    80001428:	fa8080e7          	jalr	-88(ra) # 800013cc <_ZN7_thread5yieldEv>
}
    8000142c:	01813083          	ld	ra,24(sp)
    80001430:	01013403          	ld	s0,16(sp)
    80001434:	00813483          	ld	s1,8(sp)
    80001438:	02010113          	addi	sp,sp,32
    8000143c:	00008067          	ret

0000000080001440 <_ZN7_thread8dispatchEv>:
{
    80001440:	fe010113          	addi	sp,sp,-32
    80001444:	00113c23          	sd	ra,24(sp)
    80001448:	00813823          	sd	s0,16(sp)
    8000144c:	00913423          	sd	s1,8(sp)
    80001450:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001454:	00004497          	auipc	s1,0x4
    80001458:	43c4b483          	ld	s1,1084(s1) # 80005890 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    8000145c:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished()) { Scheduler::put(old); }
    80001460:	02078c63          	beqz	a5,80001498 <_ZN7_thread8dispatchEv+0x58>
    running = Scheduler::get();
    80001464:	00000097          	auipc	ra,0x0
    80001468:	644080e7          	jalr	1604(ra) # 80001aa8 <_ZN9Scheduler3getEv>
    8000146c:	00004797          	auipc	a5,0x4
    80001470:	42a7b223          	sd	a0,1060(a5) # 80005890 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    80001474:	01850593          	addi	a1,a0,24 # 2018 <_entry-0x7fffdfe8>
    80001478:	01848513          	addi	a0,s1,24
    8000147c:	00000097          	auipc	ra,0x0
    80001480:	c94080e7          	jalr	-876(ra) # 80001110 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001484:	01813083          	ld	ra,24(sp)
    80001488:	01013403          	ld	s0,16(sp)
    8000148c:	00813483          	ld	s1,8(sp)
    80001490:	02010113          	addi	sp,sp,32
    80001494:	00008067          	ret
    if (!old->isFinished()) { Scheduler::put(old); }
    80001498:	00048513          	mv	a0,s1
    8000149c:	00000097          	auipc	ra,0x0
    800014a0:	674080e7          	jalr	1652(ra) # 80001b10 <_ZN9Scheduler3putEP7_thread>
    800014a4:	fc1ff06f          	j	80001464 <_ZN7_thread8dispatchEv+0x24>

00000000800014a8 <_ZL9fibonaccim>:
        }
    }
}

static uint64 fibonacci(uint64 n)
{
    800014a8:	fe010113          	addi	sp,sp,-32
    800014ac:	00113c23          	sd	ra,24(sp)
    800014b0:	00813823          	sd	s0,16(sp)
    800014b4:	00913423          	sd	s1,8(sp)
    800014b8:	01213023          	sd	s2,0(sp)
    800014bc:	02010413          	addi	s0,sp,32
    800014c0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800014c4:	00100793          	li	a5,1
    800014c8:	02a7f863          	bgeu	a5,a0,800014f8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { _thread::yield(); }
    800014cc:	00a00793          	li	a5,10
    800014d0:	02f577b3          	remu	a5,a0,a5
    800014d4:	02078e63          	beqz	a5,80001510 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800014d8:	fff48513          	addi	a0,s1,-1
    800014dc:	00000097          	auipc	ra,0x0
    800014e0:	fcc080e7          	jalr	-52(ra) # 800014a8 <_ZL9fibonaccim>
    800014e4:	00050913          	mv	s2,a0
    800014e8:	ffe48513          	addi	a0,s1,-2
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	fbc080e7          	jalr	-68(ra) # 800014a8 <_ZL9fibonaccim>
    800014f4:	00a90533          	add	a0,s2,a0
}
    800014f8:	01813083          	ld	ra,24(sp)
    800014fc:	01013403          	ld	s0,16(sp)
    80001500:	00813483          	ld	s1,8(sp)
    80001504:	00013903          	ld	s2,0(sp)
    80001508:	02010113          	addi	sp,sp,32
    8000150c:	00008067          	ret
    if (n % 10 == 0) { _thread::yield(); }
    80001510:	00000097          	auipc	ra,0x0
    80001514:	ebc080e7          	jalr	-324(ra) # 800013cc <_ZN7_thread5yieldEv>
    80001518:	fc1ff06f          	j	800014d8 <_ZL9fibonaccim+0x30>

000000008000151c <_Z11workerBodyAv>:
{
    8000151c:	fe010113          	addi	sp,sp,-32
    80001520:	00113c23          	sd	ra,24(sp)
    80001524:	00813823          	sd	s0,16(sp)
    80001528:	00913423          	sd	s1,8(sp)
    8000152c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++)
    80001530:	00000493          	li	s1,0
    80001534:	0300006f          	j	80001564 <_Z11workerBodyAv+0x48>
        for (uint64 j = 0; j < 10000; j++)
    80001538:	00168693          	addi	a3,a3,1
    8000153c:	000027b7          	lui	a5,0x2
    80001540:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80001544:	00d7ee63          	bltu	a5,a3,80001560 <_Z11workerBodyAv+0x44>
            for (uint64 k = 0; k < 30000; k++)
    80001548:	00000713          	li	a4,0
    8000154c:	000077b7          	lui	a5,0x7
    80001550:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80001554:	fee7e2e3          	bltu	a5,a4,80001538 <_Z11workerBodyAv+0x1c>
    80001558:	00170713          	addi	a4,a4,1
    8000155c:	ff1ff06f          	j	8000154c <_Z11workerBodyAv+0x30>
    for (uint64 i = 0; i < 10; i++)
    80001560:	00148493          	addi	s1,s1,1
    80001564:	00900793          	li	a5,9
    80001568:	0297ec63          	bltu	a5,s1,800015a0 <_Z11workerBodyAv+0x84>
        printString("A: i=");
    8000156c:	00004517          	auipc	a0,0x4
    80001570:	a9450513          	addi	a0,a0,-1388 # 80005000 <kvmincrease+0xf20>
    80001574:	00000097          	auipc	ra,0x0
    80001578:	63c080e7          	jalr	1596(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    8000157c:	00048513          	mv	a0,s1
    80001580:	00000097          	auipc	ra,0x0
    80001584:	6a0080e7          	jalr	1696(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    80001588:	00004517          	auipc	a0,0x4
    8000158c:	ae850513          	addi	a0,a0,-1304 # 80005070 <kvmincrease+0xf90>
    80001590:	00000097          	auipc	ra,0x0
    80001594:	620080e7          	jalr	1568(ra) # 80001bb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++)
    80001598:	00000693          	li	a3,0
    8000159c:	fa1ff06f          	j	8000153c <_Z11workerBodyAv+0x20>
}
    800015a0:	01813083          	ld	ra,24(sp)
    800015a4:	01013403          	ld	s0,16(sp)
    800015a8:	00813483          	ld	s1,8(sp)
    800015ac:	02010113          	addi	sp,sp,32
    800015b0:	00008067          	ret

00000000800015b4 <_Z11workerBodyBv>:
{
    800015b4:	fe010113          	addi	sp,sp,-32
    800015b8:	00113c23          	sd	ra,24(sp)
    800015bc:	00813823          	sd	s0,16(sp)
    800015c0:	00913423          	sd	s1,8(sp)
    800015c4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++)
    800015c8:	00000493          	li	s1,0
    800015cc:	0300006f          	j	800015fc <_Z11workerBodyBv+0x48>
        for (uint64 j = 0; j < 10000; j++)
    800015d0:	00168693          	addi	a3,a3,1
    800015d4:	000027b7          	lui	a5,0x2
    800015d8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800015dc:	00d7ee63          	bltu	a5,a3,800015f8 <_Z11workerBodyBv+0x44>
            for (uint64 k = 0; k < 30000; k++)
    800015e0:	00000713          	li	a4,0
    800015e4:	000077b7          	lui	a5,0x7
    800015e8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800015ec:	fee7e2e3          	bltu	a5,a4,800015d0 <_Z11workerBodyBv+0x1c>
    800015f0:	00170713          	addi	a4,a4,1
    800015f4:	ff1ff06f          	j	800015e4 <_Z11workerBodyBv+0x30>
    for (uint64 i = 0; i < 16; i++)
    800015f8:	00148493          	addi	s1,s1,1
    800015fc:	00f00793          	li	a5,15
    80001600:	0297ec63          	bltu	a5,s1,80001638 <_Z11workerBodyBv+0x84>
        printString("B: i=");
    80001604:	00004517          	auipc	a0,0x4
    80001608:	a0450513          	addi	a0,a0,-1532 # 80005008 <kvmincrease+0xf28>
    8000160c:	00000097          	auipc	ra,0x0
    80001610:	5a4080e7          	jalr	1444(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    80001614:	00048513          	mv	a0,s1
    80001618:	00000097          	auipc	ra,0x0
    8000161c:	608080e7          	jalr	1544(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    80001620:	00004517          	auipc	a0,0x4
    80001624:	a5050513          	addi	a0,a0,-1456 # 80005070 <kvmincrease+0xf90>
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	588080e7          	jalr	1416(ra) # 80001bb0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++)
    80001630:	00000693          	li	a3,0
    80001634:	fa1ff06f          	j	800015d4 <_Z11workerBodyBv+0x20>
}
    80001638:	01813083          	ld	ra,24(sp)
    8000163c:	01013403          	ld	s0,16(sp)
    80001640:	00813483          	ld	s1,8(sp)
    80001644:	02010113          	addi	sp,sp,32
    80001648:	00008067          	ret

000000008000164c <_Z11workerBodyCv>:

void workerBodyC()
{
    8000164c:	fe010113          	addi	sp,sp,-32
    80001650:	00113c23          	sd	ra,24(sp)
    80001654:	00813823          	sd	s0,16(sp)
    80001658:	00913423          	sd	s1,8(sp)
    8000165c:	01213023          	sd	s2,0(sp)
    80001660:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80001664:	00000493          	li	s1,0
    80001668:	0380006f          	j	800016a0 <_Z11workerBodyCv+0x54>
    for (; i < 3; i++)
    {
        printString("C: i=");
    8000166c:	00004517          	auipc	a0,0x4
    80001670:	9a450513          	addi	a0,a0,-1628 # 80005010 <kvmincrease+0xf30>
    80001674:	00000097          	auipc	ra,0x0
    80001678:	53c080e7          	jalr	1340(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    8000167c:	00048513          	mv	a0,s1
    80001680:	00000097          	auipc	ra,0x0
    80001684:	5a0080e7          	jalr	1440(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    80001688:	00004517          	auipc	a0,0x4
    8000168c:	9e850513          	addi	a0,a0,-1560 # 80005070 <kvmincrease+0xf90>
    80001690:	00000097          	auipc	ra,0x0
    80001694:	520080e7          	jalr	1312(ra) # 80001bb0 <_Z11printStringPKc>
    for (; i < 3; i++)
    80001698:	0014849b          	addiw	s1,s1,1
    8000169c:	0ff4f493          	andi	s1,s1,255
    800016a0:	00200793          	li	a5,2
    800016a4:	fc97f4e3          	bgeu	a5,s1,8000166c <_Z11workerBodyCv+0x20>
    }

    printString("C: yield\n");
    800016a8:	00004517          	auipc	a0,0x4
    800016ac:	97050513          	addi	a0,a0,-1680 # 80005018 <kvmincrease+0xf38>
    800016b0:	00000097          	auipc	ra,0x0
    800016b4:	500080e7          	jalr	1280(ra) # 80001bb0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800016b8:	00700313          	li	t1,7
    _thread::yield();
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	d10080e7          	jalr	-752(ra) # 800013cc <_ZN7_thread5yieldEv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800016c4:	00030913          	mv	s2,t1

    printString("C: t1=");
    800016c8:	00004517          	auipc	a0,0x4
    800016cc:	96050513          	addi	a0,a0,-1696 # 80005028 <kvmincrease+0xf48>
    800016d0:	00000097          	auipc	ra,0x0
    800016d4:	4e0080e7          	jalr	1248(ra) # 80001bb0 <_Z11printStringPKc>
    printInteger(t1);
    800016d8:	00090513          	mv	a0,s2
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	544080e7          	jalr	1348(ra) # 80001c20 <_Z12printIntegerm>
    printString("\n");
    800016e4:	00004517          	auipc	a0,0x4
    800016e8:	98c50513          	addi	a0,a0,-1652 # 80005070 <kvmincrease+0xf90>
    800016ec:	00000097          	auipc	ra,0x0
    800016f0:	4c4080e7          	jalr	1220(ra) # 80001bb0 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800016f4:	00c00513          	li	a0,12
    800016f8:	00000097          	auipc	ra,0x0
    800016fc:	db0080e7          	jalr	-592(ra) # 800014a8 <_ZL9fibonaccim>
    80001700:	00050913          	mv	s2,a0
    printString("C: fibonaci=");
    80001704:	00004517          	auipc	a0,0x4
    80001708:	92c50513          	addi	a0,a0,-1748 # 80005030 <kvmincrease+0xf50>
    8000170c:	00000097          	auipc	ra,0x0
    80001710:	4a4080e7          	jalr	1188(ra) # 80001bb0 <_Z11printStringPKc>
    printInteger(result);
    80001714:	00090513          	mv	a0,s2
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	508080e7          	jalr	1288(ra) # 80001c20 <_Z12printIntegerm>
    printString("\n");
    80001720:	00004517          	auipc	a0,0x4
    80001724:	95050513          	addi	a0,a0,-1712 # 80005070 <kvmincrease+0xf90>
    80001728:	00000097          	auipc	ra,0x0
    8000172c:	488080e7          	jalr	1160(ra) # 80001bb0 <_Z11printStringPKc>
    80001730:	0380006f          	j	80001768 <_Z11workerBodyCv+0x11c>

    for (; i < 6; i++)
    {
        printString("C: i=");
    80001734:	00004517          	auipc	a0,0x4
    80001738:	8dc50513          	addi	a0,a0,-1828 # 80005010 <kvmincrease+0xf30>
    8000173c:	00000097          	auipc	ra,0x0
    80001740:	474080e7          	jalr	1140(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    80001744:	00048513          	mv	a0,s1
    80001748:	00000097          	auipc	ra,0x0
    8000174c:	4d8080e7          	jalr	1240(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    80001750:	00004517          	auipc	a0,0x4
    80001754:	92050513          	addi	a0,a0,-1760 # 80005070 <kvmincrease+0xf90>
    80001758:	00000097          	auipc	ra,0x0
    8000175c:	458080e7          	jalr	1112(ra) # 80001bb0 <_Z11printStringPKc>
    for (; i < 6; i++)
    80001760:	0014849b          	addiw	s1,s1,1
    80001764:	0ff4f493          	andi	s1,s1,255
    80001768:	00500793          	li	a5,5
    8000176c:	fc97f4e3          	bgeu	a5,s1,80001734 <_Z11workerBodyCv+0xe8>
    }
//    _thread::yield();
}
    80001770:	01813083          	ld	ra,24(sp)
    80001774:	01013403          	ld	s0,16(sp)
    80001778:	00813483          	ld	s1,8(sp)
    8000177c:	00013903          	ld	s2,0(sp)
    80001780:	02010113          	addi	sp,sp,32
    80001784:	00008067          	ret

0000000080001788 <_Z11workerBodyDv>:

void workerBodyD()
{
    80001788:	fe010113          	addi	sp,sp,-32
    8000178c:	00113c23          	sd	ra,24(sp)
    80001790:	00813823          	sd	s0,16(sp)
    80001794:	00913423          	sd	s1,8(sp)
    80001798:	01213023          	sd	s2,0(sp)
    8000179c:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800017a0:	00a00493          	li	s1,10
    800017a4:	0380006f          	j	800017dc <_Z11workerBodyDv+0x54>
    for (; i < 13; i++)
    {
        printString("D: i=");
    800017a8:	00004517          	auipc	a0,0x4
    800017ac:	89850513          	addi	a0,a0,-1896 # 80005040 <kvmincrease+0xf60>
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	400080e7          	jalr	1024(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    800017b8:	00048513          	mv	a0,s1
    800017bc:	00000097          	auipc	ra,0x0
    800017c0:	464080e7          	jalr	1124(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    800017c4:	00004517          	auipc	a0,0x4
    800017c8:	8ac50513          	addi	a0,a0,-1876 # 80005070 <kvmincrease+0xf90>
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	3e4080e7          	jalr	996(ra) # 80001bb0 <_Z11printStringPKc>
    for (; i < 13; i++)
    800017d4:	0014849b          	addiw	s1,s1,1
    800017d8:	0ff4f493          	andi	s1,s1,255
    800017dc:	00c00793          	li	a5,12
    800017e0:	fc97f4e3          	bgeu	a5,s1,800017a8 <_Z11workerBodyDv+0x20>
    }

    printString("D: yield\n");
    800017e4:	00004517          	auipc	a0,0x4
    800017e8:	86450513          	addi	a0,a0,-1948 # 80005048 <kvmincrease+0xf68>
    800017ec:	00000097          	auipc	ra,0x0
    800017f0:	3c4080e7          	jalr	964(ra) # 80001bb0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800017f4:	00500313          	li	t1,5
    _thread::yield();
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	bd4080e7          	jalr	-1068(ra) # 800013cc <_ZN7_thread5yieldEv>

    uint64 result = fibonacci(16);
    80001800:	01000513          	li	a0,16
    80001804:	00000097          	auipc	ra,0x0
    80001808:	ca4080e7          	jalr	-860(ra) # 800014a8 <_ZL9fibonaccim>
    8000180c:	00050913          	mv	s2,a0
    printString("D: fibonaci=");
    80001810:	00004517          	auipc	a0,0x4
    80001814:	84850513          	addi	a0,a0,-1976 # 80005058 <kvmincrease+0xf78>
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	398080e7          	jalr	920(ra) # 80001bb0 <_Z11printStringPKc>
    printInteger(result);
    80001820:	00090513          	mv	a0,s2
    80001824:	00000097          	auipc	ra,0x0
    80001828:	3fc080e7          	jalr	1020(ra) # 80001c20 <_Z12printIntegerm>
    printString("\n");
    8000182c:	00004517          	auipc	a0,0x4
    80001830:	84450513          	addi	a0,a0,-1980 # 80005070 <kvmincrease+0xf90>
    80001834:	00000097          	auipc	ra,0x0
    80001838:	37c080e7          	jalr	892(ra) # 80001bb0 <_Z11printStringPKc>
    8000183c:	0380006f          	j	80001874 <_Z11workerBodyDv+0xec>

    for (; i < 16; i++)
    {
        printString("D: i=");
    80001840:	00004517          	auipc	a0,0x4
    80001844:	80050513          	addi	a0,a0,-2048 # 80005040 <kvmincrease+0xf60>
    80001848:	00000097          	auipc	ra,0x0
    8000184c:	368080e7          	jalr	872(ra) # 80001bb0 <_Z11printStringPKc>
        printInteger(i);
    80001850:	00048513          	mv	a0,s1
    80001854:	00000097          	auipc	ra,0x0
    80001858:	3cc080e7          	jalr	972(ra) # 80001c20 <_Z12printIntegerm>
        printString("\n");
    8000185c:	00004517          	auipc	a0,0x4
    80001860:	81450513          	addi	a0,a0,-2028 # 80005070 <kvmincrease+0xf90>
    80001864:	00000097          	auipc	ra,0x0
    80001868:	34c080e7          	jalr	844(ra) # 80001bb0 <_Z11printStringPKc>
    for (; i < 16; i++)
    8000186c:	0014849b          	addiw	s1,s1,1
    80001870:	0ff4f493          	andi	s1,s1,255
    80001874:	00f00793          	li	a5,15
    80001878:	fc97f4e3          	bgeu	a5,s1,80001840 <_Z11workerBodyDv+0xb8>
    }
//    _thread::yield();
    8000187c:	01813083          	ld	ra,24(sp)
    80001880:	01013403          	ld	s0,16(sp)
    80001884:	00813483          	ld	s1,8(sp)
    80001888:	00013903          	ld	s2,0(sp)
    8000188c:	02010113          	addi	sp,sp,32
    80001890:	00008067          	ret

0000000080001894 <main>:
#include "../h/print.hpp"
#include "../h/syscall_c.hpp"
#include "../h/riscv.hpp"

void main()
{
    80001894:	fe010113          	addi	sp,sp,-32
    80001898:	00113c23          	sd	ra,24(sp)
    8000189c:	00813823          	sd	s0,16(sp)
    800018a0:	02010413          	addi	s0,sp,32

    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800018a4:	00004797          	auipc	a5,0x4
    800018a8:	f8c7b783          	ld	a5,-116(a5) # 80005830 <_GLOBAL_OFFSET_TABLE_+0x8>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800018ac:	10579073          	csrw	stvec,a5

    // idle nit
    thread_t idleThread;
    thread_create(&idleThread, nullptr, nullptr);
    800018b0:	00000613          	li	a2,0
    800018b4:	00000593          	li	a1,0
    800018b8:	fe840513          	addi	a0,s0,-24
    800018bc:	00000097          	auipc	ra,0x0
    800018c0:	8b8080e7          	jalr	-1864(ra) # 80001174 <_Z13thread_createPP7_threadPFvPvES2_>

    // promena rezima

    // uposleno cekanje

    printString("Finished\n");
    800018c4:	00003517          	auipc	a0,0x3
    800018c8:	7a450513          	addi	a0,a0,1956 # 80005068 <kvmincrease+0xf88>
    800018cc:	00000097          	auipc	ra,0x0
    800018d0:	2e4080e7          	jalr	740(ra) # 80001bb0 <_Z11printStringPKc>
}
    800018d4:	01813083          	ld	ra,24(sp)
    800018d8:	01013403          	ld	s0,16(sp)
    800018dc:	02010113          	addi	sp,sp,32
    800018e0:	00008067          	ret

00000000800018e4 <_Znwm>:
#include "../lib/mem.h"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    800018e4:	ff010113          	addi	sp,sp,-16
    800018e8:	00113423          	sd	ra,8(sp)
    800018ec:	00813023          	sd	s0,0(sp)
    800018f0:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    800018f4:	00002097          	auipc	ra,0x2
    800018f8:	574080e7          	jalr	1396(ra) # 80003e68 <__mem_alloc>
}
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret

000000008000190c <_Znam>:

void *operator new[](size_t n)
{
    8000190c:	ff010113          	addi	sp,sp,-16
    80001910:	00113423          	sd	ra,8(sp)
    80001914:	00813023          	sd	s0,0(sp)
    80001918:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    8000191c:	00002097          	auipc	ra,0x2
    80001920:	54c080e7          	jalr	1356(ra) # 80003e68 <__mem_alloc>
}
    80001924:	00813083          	ld	ra,8(sp)
    80001928:	00013403          	ld	s0,0(sp)
    8000192c:	01010113          	addi	sp,sp,16
    80001930:	00008067          	ret

0000000080001934 <_ZdlPv>:

void operator delete(void *p) noexcept
{
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00113423          	sd	ra,8(sp)
    8000193c:	00813023          	sd	s0,0(sp)
    80001940:	01010413          	addi	s0,sp,16
    __mem_free(p);
    80001944:	00002097          	auipc	ra,0x2
    80001948:	458080e7          	jalr	1112(ra) # 80003d9c <__mem_free>
}
    8000194c:	00813083          	ld	ra,8(sp)
    80001950:	00013403          	ld	s0,0(sp)
    80001954:	01010113          	addi	sp,sp,16
    80001958:	00008067          	ret

000000008000195c <_ZdaPv>:

void operator delete[](void *p) noexcept
{
    8000195c:	ff010113          	addi	sp,sp,-16
    80001960:	00113423          	sd	ra,8(sp)
    80001964:	00813023          	sd	s0,0(sp)
    80001968:	01010413          	addi	s0,sp,16
    __mem_free(p);
    8000196c:	00002097          	auipc	ra,0x2
    80001970:	430080e7          	jalr	1072(ra) # 80003d9c <__mem_free>
    80001974:	00813083          	ld	ra,8(sp)
    80001978:	00013403          	ld	s0,0(sp)
    8000197c:	01010113          	addi	sp,sp,16
    80001980:	00008067          	ret

0000000080001984 <_ZN5Riscv10popSppSpieEv>:
#include "../lib/mem.h"

using namespace Num;

void Riscv::popSppSpie()
{
    80001984:	ff010113          	addi	sp,sp,-16
    80001988:	00813423          	sd	s0,8(sp)
    8000198c:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80001990:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80001994:	10200073          	sret
}
    80001998:	00813403          	ld	s0,8(sp)
    8000199c:	01010113          	addi	sp,sp,16
    800019a0:	00008067          	ret

00000000800019a4 <_ZN5Riscv20handleSupervisorTrapEv>:


void Riscv::handleSupervisorTrap()
{
    800019a4:	fd010113          	addi	sp,sp,-48
    800019a8:	02113423          	sd	ra,40(sp)
    800019ac:	02813023          	sd	s0,32(sp)
    800019b0:	03010413          	addi	s0,sp,48
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    800019b4:	142027f3          	csrr	a5,scause
    800019b8:	fcf43c23          	sd	a5,-40(s0)
    return scause;
    800019bc:	fd843783          	ld	a5,-40(s0)
    uint64 scause = r_scause();
    switch((uint64)scause){
    800019c0:	fff00713          	li	a4,-1
    800019c4:	03f71713          	slli	a4,a4,0x3f
    800019c8:	00170713          	addi	a4,a4,1
    800019cc:	04e78c63          	beq	a5,a4,80001a24 <_ZN5Riscv20handleSupervisorTrapEv+0x80>
    800019d0:	fff00713          	li	a4,-1
    800019d4:	03f71713          	slli	a4,a4,0x3f
    800019d8:	00170713          	addi	a4,a4,1
    800019dc:	06f76063          	bltu	a4,a5,80001a3c <_ZN5Riscv20handleSupervisorTrapEv+0x98>
    800019e0:	ff878793          	addi	a5,a5,-8
    800019e4:	00100713          	li	a4,1
    800019e8:	04f76263          	bltu	a4,a5,80001a2c <_ZN5Riscv20handleSupervisorTrapEv+0x88>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800019ec:	141027f3          	csrr	a5,sepc
    800019f0:	fef43423          	sd	a5,-24(s0)
    return sepc;
    800019f4:	fe843783          	ld	a5,-24(s0)
        case 0x0000000000000008UL:
        case 0x0000000000000009UL: {
            uint64 sepc = r_sepc() + 4;
    800019f8:	00478793          	addi	a5,a5,4
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800019fc:	10002773          	csrr	a4,sstatus
    80001a00:	fee43023          	sd	a4,-32(s0)
    return sstatus;
    80001a04:	fe043703          	ld	a4,-32(s0)
            uint64 sstatus = r_sstatus();
            uint64 scallnum;
            uint64 ret = 0;
            READ_REG(scallnum, "a7");
    80001a08:	00088613          	mv	a2,a7
            switch (scallnum) {
    80001a0c:	01100693          	li	a3,17
    80001a10:	04d60463          	beq	a2,a3,80001a58 <_ZN5Riscv20handleSupervisorTrapEv+0xb4>
                case SCALL_SEM_SIGNAL:
                    break;
                default:
                    break;
            }
            WRITE_REG("a0", ret);
    80001a14:	00000693          	li	a3,0
    80001a18:	00068513          	mv	a0,a3
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001a1c:	10071073          	csrw	sstatus,a4
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80001a20:	14179073          	csrw	sepc,a5
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001a24:	00200793          	li	a5,2
    80001a28:	1447b073          	csrc	sip,a5
            console_handler();
            break;
        default:
            break;
    }
    80001a2c:	02813083          	ld	ra,40(sp)
    80001a30:	02013403          	ld	s0,32(sp)
    80001a34:	03010113          	addi	sp,sp,48
    80001a38:	00008067          	ret
    switch((uint64)scause){
    80001a3c:	fff00713          	li	a4,-1
    80001a40:	03f71713          	slli	a4,a4,0x3f
    80001a44:	00970713          	addi	a4,a4,9
    80001a48:	fee792e3          	bne	a5,a4,80001a2c <_ZN5Riscv20handleSupervisorTrapEv+0x88>
            console_handler();
    80001a4c:	00002097          	auipc	ra,0x2
    80001a50:	5e8080e7          	jalr	1512(ra) # 80004034 <console_handler>
    80001a54:	fd9ff06f          	j	80001a2c <_ZN5Riscv20handleSupervisorTrapEv+0x88>
                    READ_REG(param1, "a0");
    80001a58:	00050693          	mv	a3,a0
                    READ_REG(param2, "a1");
    80001a5c:	00058693          	mv	a3,a1
                    READ_REG(param3, "a2");
    80001a60:	00060693          	mv	a3,a2
                    break;
    80001a64:	fb1ff06f          	j	80001a14 <_ZN5Riscv20handleSupervisorTrapEv+0x70>

0000000080001a68 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *ccb)
{
    readyThreadQueue.addLast(ccb);
    80001a68:	ff010113          	addi	sp,sp,-16
    80001a6c:	00813423          	sd	s0,8(sp)
    80001a70:	01010413          	addi	s0,sp,16
    80001a74:	00100793          	li	a5,1
    80001a78:	00f50863          	beq	a0,a5,80001a88 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80001a7c:	00813403          	ld	s0,8(sp)
    80001a80:	01010113          	addi	sp,sp,16
    80001a84:	00008067          	ret
    80001a88:	000107b7          	lui	a5,0x10
    80001a8c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001a90:	fef596e3          	bne	a1,a5,80001a7c <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    80001a94:	00004797          	auipc	a5,0x4
    80001a98:	e0c78793          	addi	a5,a5,-500 # 800058a0 <_ZN9Scheduler16readyThreadQueueE>
    80001a9c:	0007b023          	sd	zero,0(a5)
    80001aa0:	0007b423          	sd	zero,8(a5)
    80001aa4:	fd9ff06f          	j	80001a7c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001aa8 <_ZN9Scheduler3getEv>:
{
    80001aa8:	fe010113          	addi	sp,sp,-32
    80001aac:	00113c23          	sd	ra,24(sp)
    80001ab0:	00813823          	sd	s0,16(sp)
    80001ab4:	00913423          	sd	s1,8(sp)
    80001ab8:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001abc:	00004517          	auipc	a0,0x4
    80001ac0:	de453503          	ld	a0,-540(a0) # 800058a0 <_ZN9Scheduler16readyThreadQueueE>
    80001ac4:	04050263          	beqz	a0,80001b08 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001ac8:	00853783          	ld	a5,8(a0)
    80001acc:	00004717          	auipc	a4,0x4
    80001ad0:	dcf73a23          	sd	a5,-556(a4) # 800058a0 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) { tail = 0; }
    80001ad4:	02078463          	beqz	a5,80001afc <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001ad8:	00053483          	ld	s1,0(a0)
        delete elem;
    80001adc:	00000097          	auipc	ra,0x0
    80001ae0:	e58080e7          	jalr	-424(ra) # 80001934 <_ZdlPv>
}
    80001ae4:	00048513          	mv	a0,s1
    80001ae8:	01813083          	ld	ra,24(sp)
    80001aec:	01013403          	ld	s0,16(sp)
    80001af0:	00813483          	ld	s1,8(sp)
    80001af4:	02010113          	addi	sp,sp,32
    80001af8:	00008067          	ret
        if (!head) { tail = 0; }
    80001afc:	00004797          	auipc	a5,0x4
    80001b00:	da07b623          	sd	zero,-596(a5) # 800058a8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b04:	fd5ff06f          	j	80001ad8 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001b08:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80001b0c:	fd9ff06f          	j	80001ae4 <_ZN9Scheduler3getEv+0x3c>

0000000080001b10 <_ZN9Scheduler3putEP7_thread>:
{
    80001b10:	fe010113          	addi	sp,sp,-32
    80001b14:	00113c23          	sd	ra,24(sp)
    80001b18:	00813823          	sd	s0,16(sp)
    80001b1c:	00913423          	sd	s1,8(sp)
    80001b20:	02010413          	addi	s0,sp,32
    80001b24:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    80001b28:	01000513          	li	a0,16
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	db8080e7          	jalr	-584(ra) # 800018e4 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001b34:	00953023          	sd	s1,0(a0)
    80001b38:	00053423          	sd	zero,8(a0)
        if (tail)
    80001b3c:	00004797          	auipc	a5,0x4
    80001b40:	d6c7b783          	ld	a5,-660(a5) # 800058a8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b44:	02078263          	beqz	a5,80001b68 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    80001b48:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001b4c:	00004797          	auipc	a5,0x4
    80001b50:	d4a7be23          	sd	a0,-676(a5) # 800058a8 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80001b54:	01813083          	ld	ra,24(sp)
    80001b58:	01013403          	ld	s0,16(sp)
    80001b5c:	00813483          	ld	s1,8(sp)
    80001b60:	02010113          	addi	sp,sp,32
    80001b64:	00008067          	ret
            head = tail = elem;
    80001b68:	00004797          	auipc	a5,0x4
    80001b6c:	d3878793          	addi	a5,a5,-712 # 800058a0 <_ZN9Scheduler16readyThreadQueueE>
    80001b70:	00a7b423          	sd	a0,8(a5)
    80001b74:	00a7b023          	sd	a0,0(a5)
    80001b78:	fddff06f          	j	80001b54 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080001b7c <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80001b7c:	ff010113          	addi	sp,sp,-16
    80001b80:	00113423          	sd	ra,8(sp)
    80001b84:	00813023          	sd	s0,0(sp)
    80001b88:	01010413          	addi	s0,sp,16
    80001b8c:	000105b7          	lui	a1,0x10
    80001b90:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001b94:	00100513          	li	a0,1
    80001b98:	00000097          	auipc	ra,0x0
    80001b9c:	ed0080e7          	jalr	-304(ra) # 80001a68 <_Z41__static_initialization_and_destruction_0ii>
    80001ba0:	00813083          	ld	ra,8(sp)
    80001ba4:	00013403          	ld	s0,0(sp)
    80001ba8:	01010113          	addi	sp,sp,16
    80001bac:	00008067          	ret

0000000080001bb0 <_Z11printStringPKc>:
#include "../h/print.hpp"
#include "../h/riscv.hpp"
#include "../lib/console.h"

void printString(char const *string)
{
    80001bb0:	fd010113          	addi	sp,sp,-48
    80001bb4:	02113423          	sd	ra,40(sp)
    80001bb8:	02813023          	sd	s0,32(sp)
    80001bbc:	00913c23          	sd	s1,24(sp)
    80001bc0:	01213823          	sd	s2,16(sp)
    80001bc4:	03010413          	addi	s0,sp,48
    80001bc8:	00050493          	mv	s1,a0
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001bcc:	100027f3          	csrr	a5,sstatus
    80001bd0:	fcf43c23          	sd	a5,-40(s0)
    return sstatus;
    80001bd4:	fd843903          	ld	s2,-40(s0)
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001bd8:	00200793          	li	a5,2
    80001bdc:	1007b073          	csrc	sstatus,a5
    uint64 sstatus = Riscv::r_sstatus();
    Riscv::mc_sstatus(Riscv::SSTATUS_SIE);
    while (*string != '\0')
    80001be0:	0004c503          	lbu	a0,0(s1)
    80001be4:	00050a63          	beqz	a0,80001bf8 <_Z11printStringPKc+0x48>
    {
        __putc(*string);
    80001be8:	00002097          	auipc	ra,0x2
    80001bec:	3d8080e7          	jalr	984(ra) # 80003fc0 <__putc>
        string++;
    80001bf0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001bf4:	fedff06f          	j	80001be0 <_Z11printStringPKc+0x30>
    }
    Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
    80001bf8:	0009091b          	sext.w	s2,s2
    80001bfc:	00297913          	andi	s2,s2,2
    80001c00:	0009091b          	sext.w	s2,s2
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001c04:	10092073          	csrs	sstatus,s2
}
    80001c08:	02813083          	ld	ra,40(sp)
    80001c0c:	02013403          	ld	s0,32(sp)
    80001c10:	01813483          	ld	s1,24(sp)
    80001c14:	01013903          	ld	s2,16(sp)
    80001c18:	03010113          	addi	sp,sp,48
    80001c1c:	00008067          	ret

0000000080001c20 <_Z12printIntegerm>:

void printInteger(uint64 integer)
{
    80001c20:	fc010113          	addi	sp,sp,-64
    80001c24:	02113c23          	sd	ra,56(sp)
    80001c28:	02813823          	sd	s0,48(sp)
    80001c2c:	02913423          	sd	s1,40(sp)
    80001c30:	03213023          	sd	s2,32(sp)
    80001c34:	04010413          	addi	s0,sp,64
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001c38:	100027f3          	csrr	a5,sstatus
    80001c3c:	fcf43423          	sd	a5,-56(s0)
    return sstatus;
    80001c40:	fc843903          	ld	s2,-56(s0)
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    80001c44:	00200793          	li	a5,2
    80001c48:	1007b073          	csrc	sstatus,a5
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80001c4c:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80001c50:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80001c54:	00a00613          	li	a2,10
    80001c58:	02c5773b          	remuw	a4,a0,a2
    80001c5c:	02071693          	slli	a3,a4,0x20
    80001c60:	0206d693          	srli	a3,a3,0x20
    80001c64:	00003717          	auipc	a4,0x3
    80001c68:	41470713          	addi	a4,a4,1044 # 80005078 <_ZZ12printIntegermE6digits>
    80001c6c:	00d70733          	add	a4,a4,a3
    80001c70:	00074703          	lbu	a4,0(a4)
    80001c74:	fe040693          	addi	a3,s0,-32
    80001c78:	009687b3          	add	a5,a3,s1
    80001c7c:	0014849b          	addiw	s1,s1,1
    80001c80:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80001c84:	0005071b          	sext.w	a4,a0
    80001c88:	02c5553b          	divuw	a0,a0,a2
    80001c8c:	00900793          	li	a5,9
    80001c90:	fce7e2e3          	bltu	a5,a4,80001c54 <_Z12printIntegerm+0x34>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { __putc(buf[i]); }
    80001c94:	fff4849b          	addiw	s1,s1,-1
    80001c98:	0004ce63          	bltz	s1,80001cb4 <_Z12printIntegerm+0x94>
    80001c9c:	fe040793          	addi	a5,s0,-32
    80001ca0:	009787b3          	add	a5,a5,s1
    80001ca4:	ff07c503          	lbu	a0,-16(a5)
    80001ca8:	00002097          	auipc	ra,0x2
    80001cac:	318080e7          	jalr	792(ra) # 80003fc0 <__putc>
    80001cb0:	fe5ff06f          	j	80001c94 <_Z12printIntegerm+0x74>
    Riscv::ms_sstatus(sstatus & Riscv::SSTATUS_SIE ? Riscv::SSTATUS_SIE : 0);
    80001cb4:	0009091b          	sext.w	s2,s2
    80001cb8:	00297913          	andi	s2,s2,2
    80001cbc:	0009091b          	sext.w	s2,s2
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80001cc0:	10092073          	csrs	sstatus,s2
    80001cc4:	03813083          	ld	ra,56(sp)
    80001cc8:	03013403          	ld	s0,48(sp)
    80001ccc:	02813483          	ld	s1,40(sp)
    80001cd0:	02013903          	ld	s2,32(sp)
    80001cd4:	04010113          	addi	sp,sp,64
    80001cd8:	00008067          	ret

0000000080001cdc <start>:
    80001cdc:	ff010113          	addi	sp,sp,-16
    80001ce0:	00813423          	sd	s0,8(sp)
    80001ce4:	01010413          	addi	s0,sp,16
    80001ce8:	300027f3          	csrr	a5,mstatus
    80001cec:	ffffe737          	lui	a4,0xffffe
    80001cf0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff7cdf>
    80001cf4:	00e7f7b3          	and	a5,a5,a4
    80001cf8:	00001737          	lui	a4,0x1
    80001cfc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001d00:	00e7e7b3          	or	a5,a5,a4
    80001d04:	30079073          	csrw	mstatus,a5
    80001d08:	00000797          	auipc	a5,0x0
    80001d0c:	16078793          	addi	a5,a5,352 # 80001e68 <system_main>
    80001d10:	34179073          	csrw	mepc,a5
    80001d14:	00000793          	li	a5,0
    80001d18:	18079073          	csrw	satp,a5
    80001d1c:	000107b7          	lui	a5,0x10
    80001d20:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001d24:	30279073          	csrw	medeleg,a5
    80001d28:	30379073          	csrw	mideleg,a5
    80001d2c:	104027f3          	csrr	a5,sie
    80001d30:	2227e793          	ori	a5,a5,546
    80001d34:	10479073          	csrw	sie,a5
    80001d38:	fff00793          	li	a5,-1
    80001d3c:	00a7d793          	srli	a5,a5,0xa
    80001d40:	3b079073          	csrw	pmpaddr0,a5
    80001d44:	00f00793          	li	a5,15
    80001d48:	3a079073          	csrw	pmpcfg0,a5
    80001d4c:	f14027f3          	csrr	a5,mhartid
    80001d50:	0200c737          	lui	a4,0x200c
    80001d54:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001d58:	0007869b          	sext.w	a3,a5
    80001d5c:	00269713          	slli	a4,a3,0x2
    80001d60:	000f4637          	lui	a2,0xf4
    80001d64:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001d68:	00d70733          	add	a4,a4,a3
    80001d6c:	0037979b          	slliw	a5,a5,0x3
    80001d70:	020046b7          	lui	a3,0x2004
    80001d74:	00d787b3          	add	a5,a5,a3
    80001d78:	00c585b3          	add	a1,a1,a2
    80001d7c:	00371693          	slli	a3,a4,0x3
    80001d80:	00004717          	auipc	a4,0x4
    80001d84:	b3070713          	addi	a4,a4,-1232 # 800058b0 <timer_scratch>
    80001d88:	00b7b023          	sd	a1,0(a5)
    80001d8c:	00d70733          	add	a4,a4,a3
    80001d90:	00f73c23          	sd	a5,24(a4)
    80001d94:	02c73023          	sd	a2,32(a4)
    80001d98:	34071073          	csrw	mscratch,a4
    80001d9c:	00000797          	auipc	a5,0x0
    80001da0:	6e478793          	addi	a5,a5,1764 # 80002480 <timervec>
    80001da4:	30579073          	csrw	mtvec,a5
    80001da8:	300027f3          	csrr	a5,mstatus
    80001dac:	0087e793          	ori	a5,a5,8
    80001db0:	30079073          	csrw	mstatus,a5
    80001db4:	304027f3          	csrr	a5,mie
    80001db8:	0807e793          	ori	a5,a5,128
    80001dbc:	30479073          	csrw	mie,a5
    80001dc0:	f14027f3          	csrr	a5,mhartid
    80001dc4:	0007879b          	sext.w	a5,a5
    80001dc8:	00078213          	mv	tp,a5
    80001dcc:	30200073          	mret
    80001dd0:	00813403          	ld	s0,8(sp)
    80001dd4:	01010113          	addi	sp,sp,16
    80001dd8:	00008067          	ret

0000000080001ddc <timerinit>:
    80001ddc:	ff010113          	addi	sp,sp,-16
    80001de0:	00813423          	sd	s0,8(sp)
    80001de4:	01010413          	addi	s0,sp,16
    80001de8:	f14027f3          	csrr	a5,mhartid
    80001dec:	0200c737          	lui	a4,0x200c
    80001df0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001df4:	0007869b          	sext.w	a3,a5
    80001df8:	00269713          	slli	a4,a3,0x2
    80001dfc:	000f4637          	lui	a2,0xf4
    80001e00:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001e04:	00d70733          	add	a4,a4,a3
    80001e08:	0037979b          	slliw	a5,a5,0x3
    80001e0c:	020046b7          	lui	a3,0x2004
    80001e10:	00d787b3          	add	a5,a5,a3
    80001e14:	00c585b3          	add	a1,a1,a2
    80001e18:	00371693          	slli	a3,a4,0x3
    80001e1c:	00004717          	auipc	a4,0x4
    80001e20:	a9470713          	addi	a4,a4,-1388 # 800058b0 <timer_scratch>
    80001e24:	00b7b023          	sd	a1,0(a5)
    80001e28:	00d70733          	add	a4,a4,a3
    80001e2c:	00f73c23          	sd	a5,24(a4)
    80001e30:	02c73023          	sd	a2,32(a4)
    80001e34:	34071073          	csrw	mscratch,a4
    80001e38:	00000797          	auipc	a5,0x0
    80001e3c:	64878793          	addi	a5,a5,1608 # 80002480 <timervec>
    80001e40:	30579073          	csrw	mtvec,a5
    80001e44:	300027f3          	csrr	a5,mstatus
    80001e48:	0087e793          	ori	a5,a5,8
    80001e4c:	30079073          	csrw	mstatus,a5
    80001e50:	304027f3          	csrr	a5,mie
    80001e54:	0807e793          	ori	a5,a5,128
    80001e58:	30479073          	csrw	mie,a5
    80001e5c:	00813403          	ld	s0,8(sp)
    80001e60:	01010113          	addi	sp,sp,16
    80001e64:	00008067          	ret

0000000080001e68 <system_main>:
    80001e68:	fe010113          	addi	sp,sp,-32
    80001e6c:	00813823          	sd	s0,16(sp)
    80001e70:	00913423          	sd	s1,8(sp)
    80001e74:	00113c23          	sd	ra,24(sp)
    80001e78:	02010413          	addi	s0,sp,32
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	0c4080e7          	jalr	196(ra) # 80001f40 <cpuid>
    80001e84:	00004497          	auipc	s1,0x4
    80001e88:	9dc48493          	addi	s1,s1,-1572 # 80005860 <started>
    80001e8c:	02050263          	beqz	a0,80001eb0 <system_main+0x48>
    80001e90:	0004a783          	lw	a5,0(s1)
    80001e94:	0007879b          	sext.w	a5,a5
    80001e98:	fe078ce3          	beqz	a5,80001e90 <system_main+0x28>
    80001e9c:	0ff0000f          	fence
    80001ea0:	00003517          	auipc	a0,0x3
    80001ea4:	21850513          	addi	a0,a0,536 # 800050b8 <_ZZ12printIntegermE6digits+0x40>
    80001ea8:	00001097          	auipc	ra,0x1
    80001eac:	a74080e7          	jalr	-1420(ra) # 8000291c <panic>
    80001eb0:	00001097          	auipc	ra,0x1
    80001eb4:	9c8080e7          	jalr	-1592(ra) # 80002878 <consoleinit>
    80001eb8:	00001097          	auipc	ra,0x1
    80001ebc:	154080e7          	jalr	340(ra) # 8000300c <printfinit>
    80001ec0:	00003517          	auipc	a0,0x3
    80001ec4:	1b050513          	addi	a0,a0,432 # 80005070 <kvmincrease+0xf90>
    80001ec8:	00001097          	auipc	ra,0x1
    80001ecc:	ab0080e7          	jalr	-1360(ra) # 80002978 <__printf>
    80001ed0:	00003517          	auipc	a0,0x3
    80001ed4:	1b850513          	addi	a0,a0,440 # 80005088 <_ZZ12printIntegermE6digits+0x10>
    80001ed8:	00001097          	auipc	ra,0x1
    80001edc:	aa0080e7          	jalr	-1376(ra) # 80002978 <__printf>
    80001ee0:	00003517          	auipc	a0,0x3
    80001ee4:	19050513          	addi	a0,a0,400 # 80005070 <kvmincrease+0xf90>
    80001ee8:	00001097          	auipc	ra,0x1
    80001eec:	a90080e7          	jalr	-1392(ra) # 80002978 <__printf>
    80001ef0:	00001097          	auipc	ra,0x1
    80001ef4:	4a8080e7          	jalr	1192(ra) # 80003398 <kinit>
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	148080e7          	jalr	328(ra) # 80002040 <trapinit>
    80001f00:	00000097          	auipc	ra,0x0
    80001f04:	16c080e7          	jalr	364(ra) # 8000206c <trapinithart>
    80001f08:	00000097          	auipc	ra,0x0
    80001f0c:	5b8080e7          	jalr	1464(ra) # 800024c0 <plicinit>
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	5d8080e7          	jalr	1496(ra) # 800024e8 <plicinithart>
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	078080e7          	jalr	120(ra) # 80001f90 <userinit>
    80001f20:	0ff0000f          	fence
    80001f24:	00100793          	li	a5,1
    80001f28:	00003517          	auipc	a0,0x3
    80001f2c:	17850513          	addi	a0,a0,376 # 800050a0 <_ZZ12printIntegermE6digits+0x28>
    80001f30:	00f4a023          	sw	a5,0(s1)
    80001f34:	00001097          	auipc	ra,0x1
    80001f38:	a44080e7          	jalr	-1468(ra) # 80002978 <__printf>
    80001f3c:	0000006f          	j	80001f3c <system_main+0xd4>

0000000080001f40 <cpuid>:
    80001f40:	ff010113          	addi	sp,sp,-16
    80001f44:	00813423          	sd	s0,8(sp)
    80001f48:	01010413          	addi	s0,sp,16
    80001f4c:	00020513          	mv	a0,tp
    80001f50:	00813403          	ld	s0,8(sp)
    80001f54:	0005051b          	sext.w	a0,a0
    80001f58:	01010113          	addi	sp,sp,16
    80001f5c:	00008067          	ret

0000000080001f60 <mycpu>:
    80001f60:	ff010113          	addi	sp,sp,-16
    80001f64:	00813423          	sd	s0,8(sp)
    80001f68:	01010413          	addi	s0,sp,16
    80001f6c:	00020793          	mv	a5,tp
    80001f70:	00813403          	ld	s0,8(sp)
    80001f74:	0007879b          	sext.w	a5,a5
    80001f78:	00779793          	slli	a5,a5,0x7
    80001f7c:	00005517          	auipc	a0,0x5
    80001f80:	96450513          	addi	a0,a0,-1692 # 800068e0 <cpus>
    80001f84:	00f50533          	add	a0,a0,a5
    80001f88:	01010113          	addi	sp,sp,16
    80001f8c:	00008067          	ret

0000000080001f90 <userinit>:
    80001f90:	ff010113          	addi	sp,sp,-16
    80001f94:	00813423          	sd	s0,8(sp)
    80001f98:	01010413          	addi	s0,sp,16
    80001f9c:	00813403          	ld	s0,8(sp)
    80001fa0:	01010113          	addi	sp,sp,16
    80001fa4:	00000317          	auipc	t1,0x0
    80001fa8:	8f030067          	jr	-1808(t1) # 80001894 <main>

0000000080001fac <either_copyout>:
    80001fac:	ff010113          	addi	sp,sp,-16
    80001fb0:	00813023          	sd	s0,0(sp)
    80001fb4:	00113423          	sd	ra,8(sp)
    80001fb8:	01010413          	addi	s0,sp,16
    80001fbc:	02051663          	bnez	a0,80001fe8 <either_copyout+0x3c>
    80001fc0:	00058513          	mv	a0,a1
    80001fc4:	00060593          	mv	a1,a2
    80001fc8:	0006861b          	sext.w	a2,a3
    80001fcc:	00002097          	auipc	ra,0x2
    80001fd0:	c58080e7          	jalr	-936(ra) # 80003c24 <__memmove>
    80001fd4:	00813083          	ld	ra,8(sp)
    80001fd8:	00013403          	ld	s0,0(sp)
    80001fdc:	00000513          	li	a0,0
    80001fe0:	01010113          	addi	sp,sp,16
    80001fe4:	00008067          	ret
    80001fe8:	00003517          	auipc	a0,0x3
    80001fec:	0f850513          	addi	a0,a0,248 # 800050e0 <_ZZ12printIntegermE6digits+0x68>
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	92c080e7          	jalr	-1748(ra) # 8000291c <panic>

0000000080001ff8 <either_copyin>:
    80001ff8:	ff010113          	addi	sp,sp,-16
    80001ffc:	00813023          	sd	s0,0(sp)
    80002000:	00113423          	sd	ra,8(sp)
    80002004:	01010413          	addi	s0,sp,16
    80002008:	02059463          	bnez	a1,80002030 <either_copyin+0x38>
    8000200c:	00060593          	mv	a1,a2
    80002010:	0006861b          	sext.w	a2,a3
    80002014:	00002097          	auipc	ra,0x2
    80002018:	c10080e7          	jalr	-1008(ra) # 80003c24 <__memmove>
    8000201c:	00813083          	ld	ra,8(sp)
    80002020:	00013403          	ld	s0,0(sp)
    80002024:	00000513          	li	a0,0
    80002028:	01010113          	addi	sp,sp,16
    8000202c:	00008067          	ret
    80002030:	00003517          	auipc	a0,0x3
    80002034:	0d850513          	addi	a0,a0,216 # 80005108 <_ZZ12printIntegermE6digits+0x90>
    80002038:	00001097          	auipc	ra,0x1
    8000203c:	8e4080e7          	jalr	-1820(ra) # 8000291c <panic>

0000000080002040 <trapinit>:
    80002040:	ff010113          	addi	sp,sp,-16
    80002044:	00813423          	sd	s0,8(sp)
    80002048:	01010413          	addi	s0,sp,16
    8000204c:	00813403          	ld	s0,8(sp)
    80002050:	00003597          	auipc	a1,0x3
    80002054:	0e058593          	addi	a1,a1,224 # 80005130 <_ZZ12printIntegermE6digits+0xb8>
    80002058:	00005517          	auipc	a0,0x5
    8000205c:	90850513          	addi	a0,a0,-1784 # 80006960 <tickslock>
    80002060:	01010113          	addi	sp,sp,16
    80002064:	00001317          	auipc	t1,0x1
    80002068:	5c430067          	jr	1476(t1) # 80003628 <initlock>

000000008000206c <trapinithart>:
    8000206c:	ff010113          	addi	sp,sp,-16
    80002070:	00813423          	sd	s0,8(sp)
    80002074:	01010413          	addi	s0,sp,16
    80002078:	00000797          	auipc	a5,0x0
    8000207c:	2f878793          	addi	a5,a5,760 # 80002370 <kernelvec>
    80002080:	10579073          	csrw	stvec,a5
    80002084:	00813403          	ld	s0,8(sp)
    80002088:	01010113          	addi	sp,sp,16
    8000208c:	00008067          	ret

0000000080002090 <usertrap>:
    80002090:	ff010113          	addi	sp,sp,-16
    80002094:	00813423          	sd	s0,8(sp)
    80002098:	01010413          	addi	s0,sp,16
    8000209c:	00813403          	ld	s0,8(sp)
    800020a0:	01010113          	addi	sp,sp,16
    800020a4:	00008067          	ret

00000000800020a8 <usertrapret>:
    800020a8:	ff010113          	addi	sp,sp,-16
    800020ac:	00813423          	sd	s0,8(sp)
    800020b0:	01010413          	addi	s0,sp,16
    800020b4:	00813403          	ld	s0,8(sp)
    800020b8:	01010113          	addi	sp,sp,16
    800020bc:	00008067          	ret

00000000800020c0 <kerneltrap>:
    800020c0:	fe010113          	addi	sp,sp,-32
    800020c4:	00813823          	sd	s0,16(sp)
    800020c8:	00113c23          	sd	ra,24(sp)
    800020cc:	00913423          	sd	s1,8(sp)
    800020d0:	02010413          	addi	s0,sp,32
    800020d4:	142025f3          	csrr	a1,scause
    800020d8:	100027f3          	csrr	a5,sstatus
    800020dc:	0027f793          	andi	a5,a5,2
    800020e0:	10079c63          	bnez	a5,800021f8 <kerneltrap+0x138>
    800020e4:	142027f3          	csrr	a5,scause
    800020e8:	0207ce63          	bltz	a5,80002124 <kerneltrap+0x64>
    800020ec:	00003517          	auipc	a0,0x3
    800020f0:	08c50513          	addi	a0,a0,140 # 80005178 <_ZZ12printIntegermE6digits+0x100>
    800020f4:	00001097          	auipc	ra,0x1
    800020f8:	884080e7          	jalr	-1916(ra) # 80002978 <__printf>
    800020fc:	141025f3          	csrr	a1,sepc
    80002100:	14302673          	csrr	a2,stval
    80002104:	00003517          	auipc	a0,0x3
    80002108:	08450513          	addi	a0,a0,132 # 80005188 <_ZZ12printIntegermE6digits+0x110>
    8000210c:	00001097          	auipc	ra,0x1
    80002110:	86c080e7          	jalr	-1940(ra) # 80002978 <__printf>
    80002114:	00003517          	auipc	a0,0x3
    80002118:	08c50513          	addi	a0,a0,140 # 800051a0 <_ZZ12printIntegermE6digits+0x128>
    8000211c:	00001097          	auipc	ra,0x1
    80002120:	800080e7          	jalr	-2048(ra) # 8000291c <panic>
    80002124:	0ff7f713          	andi	a4,a5,255
    80002128:	00900693          	li	a3,9
    8000212c:	04d70063          	beq	a4,a3,8000216c <kerneltrap+0xac>
    80002130:	fff00713          	li	a4,-1
    80002134:	03f71713          	slli	a4,a4,0x3f
    80002138:	00170713          	addi	a4,a4,1
    8000213c:	fae798e3          	bne	a5,a4,800020ec <kerneltrap+0x2c>
    80002140:	00000097          	auipc	ra,0x0
    80002144:	e00080e7          	jalr	-512(ra) # 80001f40 <cpuid>
    80002148:	06050663          	beqz	a0,800021b4 <kerneltrap+0xf4>
    8000214c:	144027f3          	csrr	a5,sip
    80002150:	ffd7f793          	andi	a5,a5,-3
    80002154:	14479073          	csrw	sip,a5
    80002158:	01813083          	ld	ra,24(sp)
    8000215c:	01013403          	ld	s0,16(sp)
    80002160:	00813483          	ld	s1,8(sp)
    80002164:	02010113          	addi	sp,sp,32
    80002168:	00008067          	ret
    8000216c:	00000097          	auipc	ra,0x0
    80002170:	3c8080e7          	jalr	968(ra) # 80002534 <plic_claim>
    80002174:	00a00793          	li	a5,10
    80002178:	00050493          	mv	s1,a0
    8000217c:	06f50863          	beq	a0,a5,800021ec <kerneltrap+0x12c>
    80002180:	fc050ce3          	beqz	a0,80002158 <kerneltrap+0x98>
    80002184:	00050593          	mv	a1,a0
    80002188:	00003517          	auipc	a0,0x3
    8000218c:	fd050513          	addi	a0,a0,-48 # 80005158 <_ZZ12printIntegermE6digits+0xe0>
    80002190:	00000097          	auipc	ra,0x0
    80002194:	7e8080e7          	jalr	2024(ra) # 80002978 <__printf>
    80002198:	01013403          	ld	s0,16(sp)
    8000219c:	01813083          	ld	ra,24(sp)
    800021a0:	00048513          	mv	a0,s1
    800021a4:	00813483          	ld	s1,8(sp)
    800021a8:	02010113          	addi	sp,sp,32
    800021ac:	00000317          	auipc	t1,0x0
    800021b0:	3c030067          	jr	960(t1) # 8000256c <plic_complete>
    800021b4:	00004517          	auipc	a0,0x4
    800021b8:	7ac50513          	addi	a0,a0,1964 # 80006960 <tickslock>
    800021bc:	00001097          	auipc	ra,0x1
    800021c0:	490080e7          	jalr	1168(ra) # 8000364c <acquire>
    800021c4:	00003717          	auipc	a4,0x3
    800021c8:	6a070713          	addi	a4,a4,1696 # 80005864 <ticks>
    800021cc:	00072783          	lw	a5,0(a4)
    800021d0:	00004517          	auipc	a0,0x4
    800021d4:	79050513          	addi	a0,a0,1936 # 80006960 <tickslock>
    800021d8:	0017879b          	addiw	a5,a5,1
    800021dc:	00f72023          	sw	a5,0(a4)
    800021e0:	00001097          	auipc	ra,0x1
    800021e4:	538080e7          	jalr	1336(ra) # 80003718 <release>
    800021e8:	f65ff06f          	j	8000214c <kerneltrap+0x8c>
    800021ec:	00001097          	auipc	ra,0x1
    800021f0:	094080e7          	jalr	148(ra) # 80003280 <uartintr>
    800021f4:	fa5ff06f          	j	80002198 <kerneltrap+0xd8>
    800021f8:	00003517          	auipc	a0,0x3
    800021fc:	f4050513          	addi	a0,a0,-192 # 80005138 <_ZZ12printIntegermE6digits+0xc0>
    80002200:	00000097          	auipc	ra,0x0
    80002204:	71c080e7          	jalr	1820(ra) # 8000291c <panic>

0000000080002208 <clockintr>:
    80002208:	fe010113          	addi	sp,sp,-32
    8000220c:	00813823          	sd	s0,16(sp)
    80002210:	00913423          	sd	s1,8(sp)
    80002214:	00113c23          	sd	ra,24(sp)
    80002218:	02010413          	addi	s0,sp,32
    8000221c:	00004497          	auipc	s1,0x4
    80002220:	74448493          	addi	s1,s1,1860 # 80006960 <tickslock>
    80002224:	00048513          	mv	a0,s1
    80002228:	00001097          	auipc	ra,0x1
    8000222c:	424080e7          	jalr	1060(ra) # 8000364c <acquire>
    80002230:	00003717          	auipc	a4,0x3
    80002234:	63470713          	addi	a4,a4,1588 # 80005864 <ticks>
    80002238:	00072783          	lw	a5,0(a4)
    8000223c:	01013403          	ld	s0,16(sp)
    80002240:	01813083          	ld	ra,24(sp)
    80002244:	00048513          	mv	a0,s1
    80002248:	0017879b          	addiw	a5,a5,1
    8000224c:	00813483          	ld	s1,8(sp)
    80002250:	00f72023          	sw	a5,0(a4)
    80002254:	02010113          	addi	sp,sp,32
    80002258:	00001317          	auipc	t1,0x1
    8000225c:	4c030067          	jr	1216(t1) # 80003718 <release>

0000000080002260 <devintr>:
    80002260:	142027f3          	csrr	a5,scause
    80002264:	00000513          	li	a0,0
    80002268:	0007c463          	bltz	a5,80002270 <devintr+0x10>
    8000226c:	00008067          	ret
    80002270:	fe010113          	addi	sp,sp,-32
    80002274:	00813823          	sd	s0,16(sp)
    80002278:	00113c23          	sd	ra,24(sp)
    8000227c:	00913423          	sd	s1,8(sp)
    80002280:	02010413          	addi	s0,sp,32
    80002284:	0ff7f713          	andi	a4,a5,255
    80002288:	00900693          	li	a3,9
    8000228c:	04d70c63          	beq	a4,a3,800022e4 <devintr+0x84>
    80002290:	fff00713          	li	a4,-1
    80002294:	03f71713          	slli	a4,a4,0x3f
    80002298:	00170713          	addi	a4,a4,1
    8000229c:	00e78c63          	beq	a5,a4,800022b4 <devintr+0x54>
    800022a0:	01813083          	ld	ra,24(sp)
    800022a4:	01013403          	ld	s0,16(sp)
    800022a8:	00813483          	ld	s1,8(sp)
    800022ac:	02010113          	addi	sp,sp,32
    800022b0:	00008067          	ret
    800022b4:	00000097          	auipc	ra,0x0
    800022b8:	c8c080e7          	jalr	-884(ra) # 80001f40 <cpuid>
    800022bc:	06050663          	beqz	a0,80002328 <devintr+0xc8>
    800022c0:	144027f3          	csrr	a5,sip
    800022c4:	ffd7f793          	andi	a5,a5,-3
    800022c8:	14479073          	csrw	sip,a5
    800022cc:	01813083          	ld	ra,24(sp)
    800022d0:	01013403          	ld	s0,16(sp)
    800022d4:	00813483          	ld	s1,8(sp)
    800022d8:	00200513          	li	a0,2
    800022dc:	02010113          	addi	sp,sp,32
    800022e0:	00008067          	ret
    800022e4:	00000097          	auipc	ra,0x0
    800022e8:	250080e7          	jalr	592(ra) # 80002534 <plic_claim>
    800022ec:	00a00793          	li	a5,10
    800022f0:	00050493          	mv	s1,a0
    800022f4:	06f50663          	beq	a0,a5,80002360 <devintr+0x100>
    800022f8:	00100513          	li	a0,1
    800022fc:	fa0482e3          	beqz	s1,800022a0 <devintr+0x40>
    80002300:	00048593          	mv	a1,s1
    80002304:	00003517          	auipc	a0,0x3
    80002308:	e5450513          	addi	a0,a0,-428 # 80005158 <_ZZ12printIntegermE6digits+0xe0>
    8000230c:	00000097          	auipc	ra,0x0
    80002310:	66c080e7          	jalr	1644(ra) # 80002978 <__printf>
    80002314:	00048513          	mv	a0,s1
    80002318:	00000097          	auipc	ra,0x0
    8000231c:	254080e7          	jalr	596(ra) # 8000256c <plic_complete>
    80002320:	00100513          	li	a0,1
    80002324:	f7dff06f          	j	800022a0 <devintr+0x40>
    80002328:	00004517          	auipc	a0,0x4
    8000232c:	63850513          	addi	a0,a0,1592 # 80006960 <tickslock>
    80002330:	00001097          	auipc	ra,0x1
    80002334:	31c080e7          	jalr	796(ra) # 8000364c <acquire>
    80002338:	00003717          	auipc	a4,0x3
    8000233c:	52c70713          	addi	a4,a4,1324 # 80005864 <ticks>
    80002340:	00072783          	lw	a5,0(a4)
    80002344:	00004517          	auipc	a0,0x4
    80002348:	61c50513          	addi	a0,a0,1564 # 80006960 <tickslock>
    8000234c:	0017879b          	addiw	a5,a5,1
    80002350:	00f72023          	sw	a5,0(a4)
    80002354:	00001097          	auipc	ra,0x1
    80002358:	3c4080e7          	jalr	964(ra) # 80003718 <release>
    8000235c:	f65ff06f          	j	800022c0 <devintr+0x60>
    80002360:	00001097          	auipc	ra,0x1
    80002364:	f20080e7          	jalr	-224(ra) # 80003280 <uartintr>
    80002368:	fadff06f          	j	80002314 <devintr+0xb4>
    8000236c:	0000                	unimp
	...

0000000080002370 <kernelvec>:
    80002370:	f0010113          	addi	sp,sp,-256
    80002374:	00113023          	sd	ra,0(sp)
    80002378:	00213423          	sd	sp,8(sp)
    8000237c:	00313823          	sd	gp,16(sp)
    80002380:	00413c23          	sd	tp,24(sp)
    80002384:	02513023          	sd	t0,32(sp)
    80002388:	02613423          	sd	t1,40(sp)
    8000238c:	02713823          	sd	t2,48(sp)
    80002390:	02813c23          	sd	s0,56(sp)
    80002394:	04913023          	sd	s1,64(sp)
    80002398:	04a13423          	sd	a0,72(sp)
    8000239c:	04b13823          	sd	a1,80(sp)
    800023a0:	04c13c23          	sd	a2,88(sp)
    800023a4:	06d13023          	sd	a3,96(sp)
    800023a8:	06e13423          	sd	a4,104(sp)
    800023ac:	06f13823          	sd	a5,112(sp)
    800023b0:	07013c23          	sd	a6,120(sp)
    800023b4:	09113023          	sd	a7,128(sp)
    800023b8:	09213423          	sd	s2,136(sp)
    800023bc:	09313823          	sd	s3,144(sp)
    800023c0:	09413c23          	sd	s4,152(sp)
    800023c4:	0b513023          	sd	s5,160(sp)
    800023c8:	0b613423          	sd	s6,168(sp)
    800023cc:	0b713823          	sd	s7,176(sp)
    800023d0:	0b813c23          	sd	s8,184(sp)
    800023d4:	0d913023          	sd	s9,192(sp)
    800023d8:	0da13423          	sd	s10,200(sp)
    800023dc:	0db13823          	sd	s11,208(sp)
    800023e0:	0dc13c23          	sd	t3,216(sp)
    800023e4:	0fd13023          	sd	t4,224(sp)
    800023e8:	0fe13423          	sd	t5,232(sp)
    800023ec:	0ff13823          	sd	t6,240(sp)
    800023f0:	cd1ff0ef          	jal	ra,800020c0 <kerneltrap>
    800023f4:	00013083          	ld	ra,0(sp)
    800023f8:	00813103          	ld	sp,8(sp)
    800023fc:	01013183          	ld	gp,16(sp)
    80002400:	02013283          	ld	t0,32(sp)
    80002404:	02813303          	ld	t1,40(sp)
    80002408:	03013383          	ld	t2,48(sp)
    8000240c:	03813403          	ld	s0,56(sp)
    80002410:	04013483          	ld	s1,64(sp)
    80002414:	04813503          	ld	a0,72(sp)
    80002418:	05013583          	ld	a1,80(sp)
    8000241c:	05813603          	ld	a2,88(sp)
    80002420:	06013683          	ld	a3,96(sp)
    80002424:	06813703          	ld	a4,104(sp)
    80002428:	07013783          	ld	a5,112(sp)
    8000242c:	07813803          	ld	a6,120(sp)
    80002430:	08013883          	ld	a7,128(sp)
    80002434:	08813903          	ld	s2,136(sp)
    80002438:	09013983          	ld	s3,144(sp)
    8000243c:	09813a03          	ld	s4,152(sp)
    80002440:	0a013a83          	ld	s5,160(sp)
    80002444:	0a813b03          	ld	s6,168(sp)
    80002448:	0b013b83          	ld	s7,176(sp)
    8000244c:	0b813c03          	ld	s8,184(sp)
    80002450:	0c013c83          	ld	s9,192(sp)
    80002454:	0c813d03          	ld	s10,200(sp)
    80002458:	0d013d83          	ld	s11,208(sp)
    8000245c:	0d813e03          	ld	t3,216(sp)
    80002460:	0e013e83          	ld	t4,224(sp)
    80002464:	0e813f03          	ld	t5,232(sp)
    80002468:	0f013f83          	ld	t6,240(sp)
    8000246c:	10010113          	addi	sp,sp,256
    80002470:	10200073          	sret
    80002474:	00000013          	nop
    80002478:	00000013          	nop
    8000247c:	00000013          	nop

0000000080002480 <timervec>:
    80002480:	34051573          	csrrw	a0,mscratch,a0
    80002484:	00b53023          	sd	a1,0(a0)
    80002488:	00c53423          	sd	a2,8(a0)
    8000248c:	00d53823          	sd	a3,16(a0)
    80002490:	01853583          	ld	a1,24(a0)
    80002494:	02053603          	ld	a2,32(a0)
    80002498:	0005b683          	ld	a3,0(a1)
    8000249c:	00c686b3          	add	a3,a3,a2
    800024a0:	00d5b023          	sd	a3,0(a1)
    800024a4:	00200593          	li	a1,2
    800024a8:	14459073          	csrw	sip,a1
    800024ac:	01053683          	ld	a3,16(a0)
    800024b0:	00853603          	ld	a2,8(a0)
    800024b4:	00053583          	ld	a1,0(a0)
    800024b8:	34051573          	csrrw	a0,mscratch,a0
    800024bc:	30200073          	mret

00000000800024c0 <plicinit>:
    800024c0:	ff010113          	addi	sp,sp,-16
    800024c4:	00813423          	sd	s0,8(sp)
    800024c8:	01010413          	addi	s0,sp,16
    800024cc:	00813403          	ld	s0,8(sp)
    800024d0:	0c0007b7          	lui	a5,0xc000
    800024d4:	00100713          	li	a4,1
    800024d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800024dc:	00e7a223          	sw	a4,4(a5)
    800024e0:	01010113          	addi	sp,sp,16
    800024e4:	00008067          	ret

00000000800024e8 <plicinithart>:
    800024e8:	ff010113          	addi	sp,sp,-16
    800024ec:	00813023          	sd	s0,0(sp)
    800024f0:	00113423          	sd	ra,8(sp)
    800024f4:	01010413          	addi	s0,sp,16
    800024f8:	00000097          	auipc	ra,0x0
    800024fc:	a48080e7          	jalr	-1464(ra) # 80001f40 <cpuid>
    80002500:	0085171b          	slliw	a4,a0,0x8
    80002504:	0c0027b7          	lui	a5,0xc002
    80002508:	00e787b3          	add	a5,a5,a4
    8000250c:	40200713          	li	a4,1026
    80002510:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002514:	00813083          	ld	ra,8(sp)
    80002518:	00013403          	ld	s0,0(sp)
    8000251c:	00d5151b          	slliw	a0,a0,0xd
    80002520:	0c2017b7          	lui	a5,0xc201
    80002524:	00a78533          	add	a0,a5,a0
    80002528:	00052023          	sw	zero,0(a0)
    8000252c:	01010113          	addi	sp,sp,16
    80002530:	00008067          	ret

0000000080002534 <plic_claim>:
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813023          	sd	s0,0(sp)
    8000253c:	00113423          	sd	ra,8(sp)
    80002540:	01010413          	addi	s0,sp,16
    80002544:	00000097          	auipc	ra,0x0
    80002548:	9fc080e7          	jalr	-1540(ra) # 80001f40 <cpuid>
    8000254c:	00813083          	ld	ra,8(sp)
    80002550:	00013403          	ld	s0,0(sp)
    80002554:	00d5151b          	slliw	a0,a0,0xd
    80002558:	0c2017b7          	lui	a5,0xc201
    8000255c:	00a78533          	add	a0,a5,a0
    80002560:	00452503          	lw	a0,4(a0)
    80002564:	01010113          	addi	sp,sp,16
    80002568:	00008067          	ret

000000008000256c <plic_complete>:
    8000256c:	fe010113          	addi	sp,sp,-32
    80002570:	00813823          	sd	s0,16(sp)
    80002574:	00913423          	sd	s1,8(sp)
    80002578:	00113c23          	sd	ra,24(sp)
    8000257c:	02010413          	addi	s0,sp,32
    80002580:	00050493          	mv	s1,a0
    80002584:	00000097          	auipc	ra,0x0
    80002588:	9bc080e7          	jalr	-1604(ra) # 80001f40 <cpuid>
    8000258c:	01813083          	ld	ra,24(sp)
    80002590:	01013403          	ld	s0,16(sp)
    80002594:	00d5179b          	slliw	a5,a0,0xd
    80002598:	0c201737          	lui	a4,0xc201
    8000259c:	00f707b3          	add	a5,a4,a5
    800025a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800025a4:	00813483          	ld	s1,8(sp)
    800025a8:	02010113          	addi	sp,sp,32
    800025ac:	00008067          	ret

00000000800025b0 <consolewrite>:
    800025b0:	fb010113          	addi	sp,sp,-80
    800025b4:	04813023          	sd	s0,64(sp)
    800025b8:	04113423          	sd	ra,72(sp)
    800025bc:	02913c23          	sd	s1,56(sp)
    800025c0:	03213823          	sd	s2,48(sp)
    800025c4:	03313423          	sd	s3,40(sp)
    800025c8:	03413023          	sd	s4,32(sp)
    800025cc:	01513c23          	sd	s5,24(sp)
    800025d0:	05010413          	addi	s0,sp,80
    800025d4:	06c05c63          	blez	a2,8000264c <consolewrite+0x9c>
    800025d8:	00060993          	mv	s3,a2
    800025dc:	00050a13          	mv	s4,a0
    800025e0:	00058493          	mv	s1,a1
    800025e4:	00000913          	li	s2,0
    800025e8:	fff00a93          	li	s5,-1
    800025ec:	01c0006f          	j	80002608 <consolewrite+0x58>
    800025f0:	fbf44503          	lbu	a0,-65(s0)
    800025f4:	0019091b          	addiw	s2,s2,1
    800025f8:	00148493          	addi	s1,s1,1
    800025fc:	00001097          	auipc	ra,0x1
    80002600:	a9c080e7          	jalr	-1380(ra) # 80003098 <uartputc>
    80002604:	03298063          	beq	s3,s2,80002624 <consolewrite+0x74>
    80002608:	00048613          	mv	a2,s1
    8000260c:	00100693          	li	a3,1
    80002610:	000a0593          	mv	a1,s4
    80002614:	fbf40513          	addi	a0,s0,-65
    80002618:	00000097          	auipc	ra,0x0
    8000261c:	9e0080e7          	jalr	-1568(ra) # 80001ff8 <either_copyin>
    80002620:	fd5518e3          	bne	a0,s5,800025f0 <consolewrite+0x40>
    80002624:	04813083          	ld	ra,72(sp)
    80002628:	04013403          	ld	s0,64(sp)
    8000262c:	03813483          	ld	s1,56(sp)
    80002630:	02813983          	ld	s3,40(sp)
    80002634:	02013a03          	ld	s4,32(sp)
    80002638:	01813a83          	ld	s5,24(sp)
    8000263c:	00090513          	mv	a0,s2
    80002640:	03013903          	ld	s2,48(sp)
    80002644:	05010113          	addi	sp,sp,80
    80002648:	00008067          	ret
    8000264c:	00000913          	li	s2,0
    80002650:	fd5ff06f          	j	80002624 <consolewrite+0x74>

0000000080002654 <consoleread>:
    80002654:	f9010113          	addi	sp,sp,-112
    80002658:	06813023          	sd	s0,96(sp)
    8000265c:	04913c23          	sd	s1,88(sp)
    80002660:	05213823          	sd	s2,80(sp)
    80002664:	05313423          	sd	s3,72(sp)
    80002668:	05413023          	sd	s4,64(sp)
    8000266c:	03513c23          	sd	s5,56(sp)
    80002670:	03613823          	sd	s6,48(sp)
    80002674:	03713423          	sd	s7,40(sp)
    80002678:	03813023          	sd	s8,32(sp)
    8000267c:	06113423          	sd	ra,104(sp)
    80002680:	01913c23          	sd	s9,24(sp)
    80002684:	07010413          	addi	s0,sp,112
    80002688:	00060b93          	mv	s7,a2
    8000268c:	00050913          	mv	s2,a0
    80002690:	00058c13          	mv	s8,a1
    80002694:	00060b1b          	sext.w	s6,a2
    80002698:	00004497          	auipc	s1,0x4
    8000269c:	2f048493          	addi	s1,s1,752 # 80006988 <cons>
    800026a0:	00400993          	li	s3,4
    800026a4:	fff00a13          	li	s4,-1
    800026a8:	00a00a93          	li	s5,10
    800026ac:	05705e63          	blez	s7,80002708 <consoleread+0xb4>
    800026b0:	09c4a703          	lw	a4,156(s1)
    800026b4:	0984a783          	lw	a5,152(s1)
    800026b8:	0007071b          	sext.w	a4,a4
    800026bc:	08e78463          	beq	a5,a4,80002744 <consoleread+0xf0>
    800026c0:	07f7f713          	andi	a4,a5,127
    800026c4:	00e48733          	add	a4,s1,a4
    800026c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800026cc:	0017869b          	addiw	a3,a5,1
    800026d0:	08d4ac23          	sw	a3,152(s1)
    800026d4:	00070c9b          	sext.w	s9,a4
    800026d8:	0b370663          	beq	a4,s3,80002784 <consoleread+0x130>
    800026dc:	00100693          	li	a3,1
    800026e0:	f9f40613          	addi	a2,s0,-97
    800026e4:	000c0593          	mv	a1,s8
    800026e8:	00090513          	mv	a0,s2
    800026ec:	f8e40fa3          	sb	a4,-97(s0)
    800026f0:	00000097          	auipc	ra,0x0
    800026f4:	8bc080e7          	jalr	-1860(ra) # 80001fac <either_copyout>
    800026f8:	01450863          	beq	a0,s4,80002708 <consoleread+0xb4>
    800026fc:	001c0c13          	addi	s8,s8,1
    80002700:	fffb8b9b          	addiw	s7,s7,-1
    80002704:	fb5c94e3          	bne	s9,s5,800026ac <consoleread+0x58>
    80002708:	000b851b          	sext.w	a0,s7
    8000270c:	06813083          	ld	ra,104(sp)
    80002710:	06013403          	ld	s0,96(sp)
    80002714:	05813483          	ld	s1,88(sp)
    80002718:	05013903          	ld	s2,80(sp)
    8000271c:	04813983          	ld	s3,72(sp)
    80002720:	04013a03          	ld	s4,64(sp)
    80002724:	03813a83          	ld	s5,56(sp)
    80002728:	02813b83          	ld	s7,40(sp)
    8000272c:	02013c03          	ld	s8,32(sp)
    80002730:	01813c83          	ld	s9,24(sp)
    80002734:	40ab053b          	subw	a0,s6,a0
    80002738:	03013b03          	ld	s6,48(sp)
    8000273c:	07010113          	addi	sp,sp,112
    80002740:	00008067          	ret
    80002744:	00001097          	auipc	ra,0x1
    80002748:	1d8080e7          	jalr	472(ra) # 8000391c <push_on>
    8000274c:	0984a703          	lw	a4,152(s1)
    80002750:	09c4a783          	lw	a5,156(s1)
    80002754:	0007879b          	sext.w	a5,a5
    80002758:	fef70ce3          	beq	a4,a5,80002750 <consoleread+0xfc>
    8000275c:	00001097          	auipc	ra,0x1
    80002760:	234080e7          	jalr	564(ra) # 80003990 <pop_on>
    80002764:	0984a783          	lw	a5,152(s1)
    80002768:	07f7f713          	andi	a4,a5,127
    8000276c:	00e48733          	add	a4,s1,a4
    80002770:	01874703          	lbu	a4,24(a4)
    80002774:	0017869b          	addiw	a3,a5,1
    80002778:	08d4ac23          	sw	a3,152(s1)
    8000277c:	00070c9b          	sext.w	s9,a4
    80002780:	f5371ee3          	bne	a4,s3,800026dc <consoleread+0x88>
    80002784:	000b851b          	sext.w	a0,s7
    80002788:	f96bf2e3          	bgeu	s7,s6,8000270c <consoleread+0xb8>
    8000278c:	08f4ac23          	sw	a5,152(s1)
    80002790:	f7dff06f          	j	8000270c <consoleread+0xb8>

0000000080002794 <consputc>:
    80002794:	10000793          	li	a5,256
    80002798:	00f50663          	beq	a0,a5,800027a4 <consputc+0x10>
    8000279c:	00001317          	auipc	t1,0x1
    800027a0:	9f430067          	jr	-1548(t1) # 80003190 <uartputc_sync>
    800027a4:	ff010113          	addi	sp,sp,-16
    800027a8:	00113423          	sd	ra,8(sp)
    800027ac:	00813023          	sd	s0,0(sp)
    800027b0:	01010413          	addi	s0,sp,16
    800027b4:	00800513          	li	a0,8
    800027b8:	00001097          	auipc	ra,0x1
    800027bc:	9d8080e7          	jalr	-1576(ra) # 80003190 <uartputc_sync>
    800027c0:	02000513          	li	a0,32
    800027c4:	00001097          	auipc	ra,0x1
    800027c8:	9cc080e7          	jalr	-1588(ra) # 80003190 <uartputc_sync>
    800027cc:	00013403          	ld	s0,0(sp)
    800027d0:	00813083          	ld	ra,8(sp)
    800027d4:	00800513          	li	a0,8
    800027d8:	01010113          	addi	sp,sp,16
    800027dc:	00001317          	auipc	t1,0x1
    800027e0:	9b430067          	jr	-1612(t1) # 80003190 <uartputc_sync>

00000000800027e4 <consoleintr>:
    800027e4:	fe010113          	addi	sp,sp,-32
    800027e8:	00813823          	sd	s0,16(sp)
    800027ec:	00913423          	sd	s1,8(sp)
    800027f0:	01213023          	sd	s2,0(sp)
    800027f4:	00113c23          	sd	ra,24(sp)
    800027f8:	02010413          	addi	s0,sp,32
    800027fc:	00004917          	auipc	s2,0x4
    80002800:	18c90913          	addi	s2,s2,396 # 80006988 <cons>
    80002804:	00050493          	mv	s1,a0
    80002808:	00090513          	mv	a0,s2
    8000280c:	00001097          	auipc	ra,0x1
    80002810:	e40080e7          	jalr	-448(ra) # 8000364c <acquire>
    80002814:	02048c63          	beqz	s1,8000284c <consoleintr+0x68>
    80002818:	0a092783          	lw	a5,160(s2)
    8000281c:	09892703          	lw	a4,152(s2)
    80002820:	07f00693          	li	a3,127
    80002824:	40e7873b          	subw	a4,a5,a4
    80002828:	02e6e263          	bltu	a3,a4,8000284c <consoleintr+0x68>
    8000282c:	00d00713          	li	a4,13
    80002830:	04e48063          	beq	s1,a4,80002870 <consoleintr+0x8c>
    80002834:	07f7f713          	andi	a4,a5,127
    80002838:	00e90733          	add	a4,s2,a4
    8000283c:	0017879b          	addiw	a5,a5,1
    80002840:	0af92023          	sw	a5,160(s2)
    80002844:	00970c23          	sb	s1,24(a4)
    80002848:	08f92e23          	sw	a5,156(s2)
    8000284c:	01013403          	ld	s0,16(sp)
    80002850:	01813083          	ld	ra,24(sp)
    80002854:	00813483          	ld	s1,8(sp)
    80002858:	00013903          	ld	s2,0(sp)
    8000285c:	00004517          	auipc	a0,0x4
    80002860:	12c50513          	addi	a0,a0,300 # 80006988 <cons>
    80002864:	02010113          	addi	sp,sp,32
    80002868:	00001317          	auipc	t1,0x1
    8000286c:	eb030067          	jr	-336(t1) # 80003718 <release>
    80002870:	00a00493          	li	s1,10
    80002874:	fc1ff06f          	j	80002834 <consoleintr+0x50>

0000000080002878 <consoleinit>:
    80002878:	fe010113          	addi	sp,sp,-32
    8000287c:	00113c23          	sd	ra,24(sp)
    80002880:	00813823          	sd	s0,16(sp)
    80002884:	00913423          	sd	s1,8(sp)
    80002888:	02010413          	addi	s0,sp,32
    8000288c:	00004497          	auipc	s1,0x4
    80002890:	0fc48493          	addi	s1,s1,252 # 80006988 <cons>
    80002894:	00048513          	mv	a0,s1
    80002898:	00003597          	auipc	a1,0x3
    8000289c:	91858593          	addi	a1,a1,-1768 # 800051b0 <_ZZ12printIntegermE6digits+0x138>
    800028a0:	00001097          	auipc	ra,0x1
    800028a4:	d88080e7          	jalr	-632(ra) # 80003628 <initlock>
    800028a8:	00000097          	auipc	ra,0x0
    800028ac:	7ac080e7          	jalr	1964(ra) # 80003054 <uartinit>
    800028b0:	01813083          	ld	ra,24(sp)
    800028b4:	01013403          	ld	s0,16(sp)
    800028b8:	00000797          	auipc	a5,0x0
    800028bc:	d9c78793          	addi	a5,a5,-612 # 80002654 <consoleread>
    800028c0:	0af4bc23          	sd	a5,184(s1)
    800028c4:	00000797          	auipc	a5,0x0
    800028c8:	cec78793          	addi	a5,a5,-788 # 800025b0 <consolewrite>
    800028cc:	0cf4b023          	sd	a5,192(s1)
    800028d0:	00813483          	ld	s1,8(sp)
    800028d4:	02010113          	addi	sp,sp,32
    800028d8:	00008067          	ret

00000000800028dc <console_read>:
    800028dc:	ff010113          	addi	sp,sp,-16
    800028e0:	00813423          	sd	s0,8(sp)
    800028e4:	01010413          	addi	s0,sp,16
    800028e8:	00813403          	ld	s0,8(sp)
    800028ec:	00004317          	auipc	t1,0x4
    800028f0:	15433303          	ld	t1,340(t1) # 80006a40 <devsw+0x10>
    800028f4:	01010113          	addi	sp,sp,16
    800028f8:	00030067          	jr	t1

00000000800028fc <console_write>:
    800028fc:	ff010113          	addi	sp,sp,-16
    80002900:	00813423          	sd	s0,8(sp)
    80002904:	01010413          	addi	s0,sp,16
    80002908:	00813403          	ld	s0,8(sp)
    8000290c:	00004317          	auipc	t1,0x4
    80002910:	13c33303          	ld	t1,316(t1) # 80006a48 <devsw+0x18>
    80002914:	01010113          	addi	sp,sp,16
    80002918:	00030067          	jr	t1

000000008000291c <panic>:
    8000291c:	fe010113          	addi	sp,sp,-32
    80002920:	00113c23          	sd	ra,24(sp)
    80002924:	00813823          	sd	s0,16(sp)
    80002928:	00913423          	sd	s1,8(sp)
    8000292c:	02010413          	addi	s0,sp,32
    80002930:	00050493          	mv	s1,a0
    80002934:	00003517          	auipc	a0,0x3
    80002938:	88450513          	addi	a0,a0,-1916 # 800051b8 <_ZZ12printIntegermE6digits+0x140>
    8000293c:	00004797          	auipc	a5,0x4
    80002940:	1a07a623          	sw	zero,428(a5) # 80006ae8 <pr+0x18>
    80002944:	00000097          	auipc	ra,0x0
    80002948:	034080e7          	jalr	52(ra) # 80002978 <__printf>
    8000294c:	00048513          	mv	a0,s1
    80002950:	00000097          	auipc	ra,0x0
    80002954:	028080e7          	jalr	40(ra) # 80002978 <__printf>
    80002958:	00002517          	auipc	a0,0x2
    8000295c:	71850513          	addi	a0,a0,1816 # 80005070 <kvmincrease+0xf90>
    80002960:	00000097          	auipc	ra,0x0
    80002964:	018080e7          	jalr	24(ra) # 80002978 <__printf>
    80002968:	00100793          	li	a5,1
    8000296c:	00003717          	auipc	a4,0x3
    80002970:	eef72e23          	sw	a5,-260(a4) # 80005868 <panicked>
    80002974:	0000006f          	j	80002974 <panic+0x58>

0000000080002978 <__printf>:
    80002978:	f3010113          	addi	sp,sp,-208
    8000297c:	08813023          	sd	s0,128(sp)
    80002980:	07313423          	sd	s3,104(sp)
    80002984:	09010413          	addi	s0,sp,144
    80002988:	05813023          	sd	s8,64(sp)
    8000298c:	08113423          	sd	ra,136(sp)
    80002990:	06913c23          	sd	s1,120(sp)
    80002994:	07213823          	sd	s2,112(sp)
    80002998:	07413023          	sd	s4,96(sp)
    8000299c:	05513c23          	sd	s5,88(sp)
    800029a0:	05613823          	sd	s6,80(sp)
    800029a4:	05713423          	sd	s7,72(sp)
    800029a8:	03913c23          	sd	s9,56(sp)
    800029ac:	03a13823          	sd	s10,48(sp)
    800029b0:	03b13423          	sd	s11,40(sp)
    800029b4:	00004317          	auipc	t1,0x4
    800029b8:	11c30313          	addi	t1,t1,284 # 80006ad0 <pr>
    800029bc:	01832c03          	lw	s8,24(t1)
    800029c0:	00b43423          	sd	a1,8(s0)
    800029c4:	00c43823          	sd	a2,16(s0)
    800029c8:	00d43c23          	sd	a3,24(s0)
    800029cc:	02e43023          	sd	a4,32(s0)
    800029d0:	02f43423          	sd	a5,40(s0)
    800029d4:	03043823          	sd	a6,48(s0)
    800029d8:	03143c23          	sd	a7,56(s0)
    800029dc:	00050993          	mv	s3,a0
    800029e0:	4a0c1663          	bnez	s8,80002e8c <__printf+0x514>
    800029e4:	60098c63          	beqz	s3,80002ffc <__printf+0x684>
    800029e8:	0009c503          	lbu	a0,0(s3)
    800029ec:	00840793          	addi	a5,s0,8
    800029f0:	f6f43c23          	sd	a5,-136(s0)
    800029f4:	00000493          	li	s1,0
    800029f8:	22050063          	beqz	a0,80002c18 <__printf+0x2a0>
    800029fc:	00002a37          	lui	s4,0x2
    80002a00:	00018ab7          	lui	s5,0x18
    80002a04:	000f4b37          	lui	s6,0xf4
    80002a08:	00989bb7          	lui	s7,0x989
    80002a0c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002a10:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002a14:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002a18:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002a1c:	00148c9b          	addiw	s9,s1,1
    80002a20:	02500793          	li	a5,37
    80002a24:	01998933          	add	s2,s3,s9
    80002a28:	38f51263          	bne	a0,a5,80002dac <__printf+0x434>
    80002a2c:	00094783          	lbu	a5,0(s2)
    80002a30:	00078c9b          	sext.w	s9,a5
    80002a34:	1e078263          	beqz	a5,80002c18 <__printf+0x2a0>
    80002a38:	0024849b          	addiw	s1,s1,2
    80002a3c:	07000713          	li	a4,112
    80002a40:	00998933          	add	s2,s3,s1
    80002a44:	38e78a63          	beq	a5,a4,80002dd8 <__printf+0x460>
    80002a48:	20f76863          	bltu	a4,a5,80002c58 <__printf+0x2e0>
    80002a4c:	42a78863          	beq	a5,a0,80002e7c <__printf+0x504>
    80002a50:	06400713          	li	a4,100
    80002a54:	40e79663          	bne	a5,a4,80002e60 <__printf+0x4e8>
    80002a58:	f7843783          	ld	a5,-136(s0)
    80002a5c:	0007a603          	lw	a2,0(a5)
    80002a60:	00878793          	addi	a5,a5,8
    80002a64:	f6f43c23          	sd	a5,-136(s0)
    80002a68:	42064a63          	bltz	a2,80002e9c <__printf+0x524>
    80002a6c:	00a00713          	li	a4,10
    80002a70:	02e677bb          	remuw	a5,a2,a4
    80002a74:	00002d97          	auipc	s11,0x2
    80002a78:	76cd8d93          	addi	s11,s11,1900 # 800051e0 <digits>
    80002a7c:	00900593          	li	a1,9
    80002a80:	0006051b          	sext.w	a0,a2
    80002a84:	00000c93          	li	s9,0
    80002a88:	02079793          	slli	a5,a5,0x20
    80002a8c:	0207d793          	srli	a5,a5,0x20
    80002a90:	00fd87b3          	add	a5,s11,a5
    80002a94:	0007c783          	lbu	a5,0(a5)
    80002a98:	02e656bb          	divuw	a3,a2,a4
    80002a9c:	f8f40023          	sb	a5,-128(s0)
    80002aa0:	14c5d863          	bge	a1,a2,80002bf0 <__printf+0x278>
    80002aa4:	06300593          	li	a1,99
    80002aa8:	00100c93          	li	s9,1
    80002aac:	02e6f7bb          	remuw	a5,a3,a4
    80002ab0:	02079793          	slli	a5,a5,0x20
    80002ab4:	0207d793          	srli	a5,a5,0x20
    80002ab8:	00fd87b3          	add	a5,s11,a5
    80002abc:	0007c783          	lbu	a5,0(a5)
    80002ac0:	02e6d73b          	divuw	a4,a3,a4
    80002ac4:	f8f400a3          	sb	a5,-127(s0)
    80002ac8:	12a5f463          	bgeu	a1,a0,80002bf0 <__printf+0x278>
    80002acc:	00a00693          	li	a3,10
    80002ad0:	00900593          	li	a1,9
    80002ad4:	02d777bb          	remuw	a5,a4,a3
    80002ad8:	02079793          	slli	a5,a5,0x20
    80002adc:	0207d793          	srli	a5,a5,0x20
    80002ae0:	00fd87b3          	add	a5,s11,a5
    80002ae4:	0007c503          	lbu	a0,0(a5)
    80002ae8:	02d757bb          	divuw	a5,a4,a3
    80002aec:	f8a40123          	sb	a0,-126(s0)
    80002af0:	48e5f263          	bgeu	a1,a4,80002f74 <__printf+0x5fc>
    80002af4:	06300513          	li	a0,99
    80002af8:	02d7f5bb          	remuw	a1,a5,a3
    80002afc:	02059593          	slli	a1,a1,0x20
    80002b00:	0205d593          	srli	a1,a1,0x20
    80002b04:	00bd85b3          	add	a1,s11,a1
    80002b08:	0005c583          	lbu	a1,0(a1)
    80002b0c:	02d7d7bb          	divuw	a5,a5,a3
    80002b10:	f8b401a3          	sb	a1,-125(s0)
    80002b14:	48e57263          	bgeu	a0,a4,80002f98 <__printf+0x620>
    80002b18:	3e700513          	li	a0,999
    80002b1c:	02d7f5bb          	remuw	a1,a5,a3
    80002b20:	02059593          	slli	a1,a1,0x20
    80002b24:	0205d593          	srli	a1,a1,0x20
    80002b28:	00bd85b3          	add	a1,s11,a1
    80002b2c:	0005c583          	lbu	a1,0(a1)
    80002b30:	02d7d7bb          	divuw	a5,a5,a3
    80002b34:	f8b40223          	sb	a1,-124(s0)
    80002b38:	46e57663          	bgeu	a0,a4,80002fa4 <__printf+0x62c>
    80002b3c:	02d7f5bb          	remuw	a1,a5,a3
    80002b40:	02059593          	slli	a1,a1,0x20
    80002b44:	0205d593          	srli	a1,a1,0x20
    80002b48:	00bd85b3          	add	a1,s11,a1
    80002b4c:	0005c583          	lbu	a1,0(a1)
    80002b50:	02d7d7bb          	divuw	a5,a5,a3
    80002b54:	f8b402a3          	sb	a1,-123(s0)
    80002b58:	46ea7863          	bgeu	s4,a4,80002fc8 <__printf+0x650>
    80002b5c:	02d7f5bb          	remuw	a1,a5,a3
    80002b60:	02059593          	slli	a1,a1,0x20
    80002b64:	0205d593          	srli	a1,a1,0x20
    80002b68:	00bd85b3          	add	a1,s11,a1
    80002b6c:	0005c583          	lbu	a1,0(a1)
    80002b70:	02d7d7bb          	divuw	a5,a5,a3
    80002b74:	f8b40323          	sb	a1,-122(s0)
    80002b78:	3eeaf863          	bgeu	s5,a4,80002f68 <__printf+0x5f0>
    80002b7c:	02d7f5bb          	remuw	a1,a5,a3
    80002b80:	02059593          	slli	a1,a1,0x20
    80002b84:	0205d593          	srli	a1,a1,0x20
    80002b88:	00bd85b3          	add	a1,s11,a1
    80002b8c:	0005c583          	lbu	a1,0(a1)
    80002b90:	02d7d7bb          	divuw	a5,a5,a3
    80002b94:	f8b403a3          	sb	a1,-121(s0)
    80002b98:	42eb7e63          	bgeu	s6,a4,80002fd4 <__printf+0x65c>
    80002b9c:	02d7f5bb          	remuw	a1,a5,a3
    80002ba0:	02059593          	slli	a1,a1,0x20
    80002ba4:	0205d593          	srli	a1,a1,0x20
    80002ba8:	00bd85b3          	add	a1,s11,a1
    80002bac:	0005c583          	lbu	a1,0(a1)
    80002bb0:	02d7d7bb          	divuw	a5,a5,a3
    80002bb4:	f8b40423          	sb	a1,-120(s0)
    80002bb8:	42ebfc63          	bgeu	s7,a4,80002ff0 <__printf+0x678>
    80002bbc:	02079793          	slli	a5,a5,0x20
    80002bc0:	0207d793          	srli	a5,a5,0x20
    80002bc4:	00fd8db3          	add	s11,s11,a5
    80002bc8:	000dc703          	lbu	a4,0(s11)
    80002bcc:	00a00793          	li	a5,10
    80002bd0:	00900c93          	li	s9,9
    80002bd4:	f8e404a3          	sb	a4,-119(s0)
    80002bd8:	00065c63          	bgez	a2,80002bf0 <__printf+0x278>
    80002bdc:	f9040713          	addi	a4,s0,-112
    80002be0:	00f70733          	add	a4,a4,a5
    80002be4:	02d00693          	li	a3,45
    80002be8:	fed70823          	sb	a3,-16(a4)
    80002bec:	00078c93          	mv	s9,a5
    80002bf0:	f8040793          	addi	a5,s0,-128
    80002bf4:	01978cb3          	add	s9,a5,s9
    80002bf8:	f7f40d13          	addi	s10,s0,-129
    80002bfc:	000cc503          	lbu	a0,0(s9)
    80002c00:	fffc8c93          	addi	s9,s9,-1
    80002c04:	00000097          	auipc	ra,0x0
    80002c08:	b90080e7          	jalr	-1136(ra) # 80002794 <consputc>
    80002c0c:	ffac98e3          	bne	s9,s10,80002bfc <__printf+0x284>
    80002c10:	00094503          	lbu	a0,0(s2)
    80002c14:	e00514e3          	bnez	a0,80002a1c <__printf+0xa4>
    80002c18:	1a0c1663          	bnez	s8,80002dc4 <__printf+0x44c>
    80002c1c:	08813083          	ld	ra,136(sp)
    80002c20:	08013403          	ld	s0,128(sp)
    80002c24:	07813483          	ld	s1,120(sp)
    80002c28:	07013903          	ld	s2,112(sp)
    80002c2c:	06813983          	ld	s3,104(sp)
    80002c30:	06013a03          	ld	s4,96(sp)
    80002c34:	05813a83          	ld	s5,88(sp)
    80002c38:	05013b03          	ld	s6,80(sp)
    80002c3c:	04813b83          	ld	s7,72(sp)
    80002c40:	04013c03          	ld	s8,64(sp)
    80002c44:	03813c83          	ld	s9,56(sp)
    80002c48:	03013d03          	ld	s10,48(sp)
    80002c4c:	02813d83          	ld	s11,40(sp)
    80002c50:	0d010113          	addi	sp,sp,208
    80002c54:	00008067          	ret
    80002c58:	07300713          	li	a4,115
    80002c5c:	1ce78a63          	beq	a5,a4,80002e30 <__printf+0x4b8>
    80002c60:	07800713          	li	a4,120
    80002c64:	1ee79e63          	bne	a5,a4,80002e60 <__printf+0x4e8>
    80002c68:	f7843783          	ld	a5,-136(s0)
    80002c6c:	0007a703          	lw	a4,0(a5)
    80002c70:	00878793          	addi	a5,a5,8
    80002c74:	f6f43c23          	sd	a5,-136(s0)
    80002c78:	28074263          	bltz	a4,80002efc <__printf+0x584>
    80002c7c:	00002d97          	auipc	s11,0x2
    80002c80:	564d8d93          	addi	s11,s11,1380 # 800051e0 <digits>
    80002c84:	00f77793          	andi	a5,a4,15
    80002c88:	00fd87b3          	add	a5,s11,a5
    80002c8c:	0007c683          	lbu	a3,0(a5)
    80002c90:	00f00613          	li	a2,15
    80002c94:	0007079b          	sext.w	a5,a4
    80002c98:	f8d40023          	sb	a3,-128(s0)
    80002c9c:	0047559b          	srliw	a1,a4,0x4
    80002ca0:	0047569b          	srliw	a3,a4,0x4
    80002ca4:	00000c93          	li	s9,0
    80002ca8:	0ee65063          	bge	a2,a4,80002d88 <__printf+0x410>
    80002cac:	00f6f693          	andi	a3,a3,15
    80002cb0:	00dd86b3          	add	a3,s11,a3
    80002cb4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002cb8:	0087d79b          	srliw	a5,a5,0x8
    80002cbc:	00100c93          	li	s9,1
    80002cc0:	f8d400a3          	sb	a3,-127(s0)
    80002cc4:	0cb67263          	bgeu	a2,a1,80002d88 <__printf+0x410>
    80002cc8:	00f7f693          	andi	a3,a5,15
    80002ccc:	00dd86b3          	add	a3,s11,a3
    80002cd0:	0006c583          	lbu	a1,0(a3)
    80002cd4:	00f00613          	li	a2,15
    80002cd8:	0047d69b          	srliw	a3,a5,0x4
    80002cdc:	f8b40123          	sb	a1,-126(s0)
    80002ce0:	0047d593          	srli	a1,a5,0x4
    80002ce4:	28f67e63          	bgeu	a2,a5,80002f80 <__printf+0x608>
    80002ce8:	00f6f693          	andi	a3,a3,15
    80002cec:	00dd86b3          	add	a3,s11,a3
    80002cf0:	0006c503          	lbu	a0,0(a3)
    80002cf4:	0087d813          	srli	a6,a5,0x8
    80002cf8:	0087d69b          	srliw	a3,a5,0x8
    80002cfc:	f8a401a3          	sb	a0,-125(s0)
    80002d00:	28b67663          	bgeu	a2,a1,80002f8c <__printf+0x614>
    80002d04:	00f6f693          	andi	a3,a3,15
    80002d08:	00dd86b3          	add	a3,s11,a3
    80002d0c:	0006c583          	lbu	a1,0(a3)
    80002d10:	00c7d513          	srli	a0,a5,0xc
    80002d14:	00c7d69b          	srliw	a3,a5,0xc
    80002d18:	f8b40223          	sb	a1,-124(s0)
    80002d1c:	29067a63          	bgeu	a2,a6,80002fb0 <__printf+0x638>
    80002d20:	00f6f693          	andi	a3,a3,15
    80002d24:	00dd86b3          	add	a3,s11,a3
    80002d28:	0006c583          	lbu	a1,0(a3)
    80002d2c:	0107d813          	srli	a6,a5,0x10
    80002d30:	0107d69b          	srliw	a3,a5,0x10
    80002d34:	f8b402a3          	sb	a1,-123(s0)
    80002d38:	28a67263          	bgeu	a2,a0,80002fbc <__printf+0x644>
    80002d3c:	00f6f693          	andi	a3,a3,15
    80002d40:	00dd86b3          	add	a3,s11,a3
    80002d44:	0006c683          	lbu	a3,0(a3)
    80002d48:	0147d79b          	srliw	a5,a5,0x14
    80002d4c:	f8d40323          	sb	a3,-122(s0)
    80002d50:	21067663          	bgeu	a2,a6,80002f5c <__printf+0x5e4>
    80002d54:	02079793          	slli	a5,a5,0x20
    80002d58:	0207d793          	srli	a5,a5,0x20
    80002d5c:	00fd8db3          	add	s11,s11,a5
    80002d60:	000dc683          	lbu	a3,0(s11)
    80002d64:	00800793          	li	a5,8
    80002d68:	00700c93          	li	s9,7
    80002d6c:	f8d403a3          	sb	a3,-121(s0)
    80002d70:	00075c63          	bgez	a4,80002d88 <__printf+0x410>
    80002d74:	f9040713          	addi	a4,s0,-112
    80002d78:	00f70733          	add	a4,a4,a5
    80002d7c:	02d00693          	li	a3,45
    80002d80:	fed70823          	sb	a3,-16(a4)
    80002d84:	00078c93          	mv	s9,a5
    80002d88:	f8040793          	addi	a5,s0,-128
    80002d8c:	01978cb3          	add	s9,a5,s9
    80002d90:	f7f40d13          	addi	s10,s0,-129
    80002d94:	000cc503          	lbu	a0,0(s9)
    80002d98:	fffc8c93          	addi	s9,s9,-1
    80002d9c:	00000097          	auipc	ra,0x0
    80002da0:	9f8080e7          	jalr	-1544(ra) # 80002794 <consputc>
    80002da4:	ff9d18e3          	bne	s10,s9,80002d94 <__printf+0x41c>
    80002da8:	0100006f          	j	80002db8 <__printf+0x440>
    80002dac:	00000097          	auipc	ra,0x0
    80002db0:	9e8080e7          	jalr	-1560(ra) # 80002794 <consputc>
    80002db4:	000c8493          	mv	s1,s9
    80002db8:	00094503          	lbu	a0,0(s2)
    80002dbc:	c60510e3          	bnez	a0,80002a1c <__printf+0xa4>
    80002dc0:	e40c0ee3          	beqz	s8,80002c1c <__printf+0x2a4>
    80002dc4:	00004517          	auipc	a0,0x4
    80002dc8:	d0c50513          	addi	a0,a0,-756 # 80006ad0 <pr>
    80002dcc:	00001097          	auipc	ra,0x1
    80002dd0:	94c080e7          	jalr	-1716(ra) # 80003718 <release>
    80002dd4:	e49ff06f          	j	80002c1c <__printf+0x2a4>
    80002dd8:	f7843783          	ld	a5,-136(s0)
    80002ddc:	03000513          	li	a0,48
    80002de0:	01000d13          	li	s10,16
    80002de4:	00878713          	addi	a4,a5,8
    80002de8:	0007bc83          	ld	s9,0(a5)
    80002dec:	f6e43c23          	sd	a4,-136(s0)
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	9a4080e7          	jalr	-1628(ra) # 80002794 <consputc>
    80002df8:	07800513          	li	a0,120
    80002dfc:	00000097          	auipc	ra,0x0
    80002e00:	998080e7          	jalr	-1640(ra) # 80002794 <consputc>
    80002e04:	00002d97          	auipc	s11,0x2
    80002e08:	3dcd8d93          	addi	s11,s11,988 # 800051e0 <digits>
    80002e0c:	03ccd793          	srli	a5,s9,0x3c
    80002e10:	00fd87b3          	add	a5,s11,a5
    80002e14:	0007c503          	lbu	a0,0(a5)
    80002e18:	fffd0d1b          	addiw	s10,s10,-1
    80002e1c:	004c9c93          	slli	s9,s9,0x4
    80002e20:	00000097          	auipc	ra,0x0
    80002e24:	974080e7          	jalr	-1676(ra) # 80002794 <consputc>
    80002e28:	fe0d12e3          	bnez	s10,80002e0c <__printf+0x494>
    80002e2c:	f8dff06f          	j	80002db8 <__printf+0x440>
    80002e30:	f7843783          	ld	a5,-136(s0)
    80002e34:	0007bc83          	ld	s9,0(a5)
    80002e38:	00878793          	addi	a5,a5,8
    80002e3c:	f6f43c23          	sd	a5,-136(s0)
    80002e40:	000c9a63          	bnez	s9,80002e54 <__printf+0x4dc>
    80002e44:	1080006f          	j	80002f4c <__printf+0x5d4>
    80002e48:	001c8c93          	addi	s9,s9,1
    80002e4c:	00000097          	auipc	ra,0x0
    80002e50:	948080e7          	jalr	-1720(ra) # 80002794 <consputc>
    80002e54:	000cc503          	lbu	a0,0(s9)
    80002e58:	fe0518e3          	bnez	a0,80002e48 <__printf+0x4d0>
    80002e5c:	f5dff06f          	j	80002db8 <__printf+0x440>
    80002e60:	02500513          	li	a0,37
    80002e64:	00000097          	auipc	ra,0x0
    80002e68:	930080e7          	jalr	-1744(ra) # 80002794 <consputc>
    80002e6c:	000c8513          	mv	a0,s9
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	924080e7          	jalr	-1756(ra) # 80002794 <consputc>
    80002e78:	f41ff06f          	j	80002db8 <__printf+0x440>
    80002e7c:	02500513          	li	a0,37
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	914080e7          	jalr	-1772(ra) # 80002794 <consputc>
    80002e88:	f31ff06f          	j	80002db8 <__printf+0x440>
    80002e8c:	00030513          	mv	a0,t1
    80002e90:	00000097          	auipc	ra,0x0
    80002e94:	7bc080e7          	jalr	1980(ra) # 8000364c <acquire>
    80002e98:	b4dff06f          	j	800029e4 <__printf+0x6c>
    80002e9c:	40c0053b          	negw	a0,a2
    80002ea0:	00a00713          	li	a4,10
    80002ea4:	02e576bb          	remuw	a3,a0,a4
    80002ea8:	00002d97          	auipc	s11,0x2
    80002eac:	338d8d93          	addi	s11,s11,824 # 800051e0 <digits>
    80002eb0:	ff700593          	li	a1,-9
    80002eb4:	02069693          	slli	a3,a3,0x20
    80002eb8:	0206d693          	srli	a3,a3,0x20
    80002ebc:	00dd86b3          	add	a3,s11,a3
    80002ec0:	0006c683          	lbu	a3,0(a3)
    80002ec4:	02e557bb          	divuw	a5,a0,a4
    80002ec8:	f8d40023          	sb	a3,-128(s0)
    80002ecc:	10b65e63          	bge	a2,a1,80002fe8 <__printf+0x670>
    80002ed0:	06300593          	li	a1,99
    80002ed4:	02e7f6bb          	remuw	a3,a5,a4
    80002ed8:	02069693          	slli	a3,a3,0x20
    80002edc:	0206d693          	srli	a3,a3,0x20
    80002ee0:	00dd86b3          	add	a3,s11,a3
    80002ee4:	0006c683          	lbu	a3,0(a3)
    80002ee8:	02e7d73b          	divuw	a4,a5,a4
    80002eec:	00200793          	li	a5,2
    80002ef0:	f8d400a3          	sb	a3,-127(s0)
    80002ef4:	bca5ece3          	bltu	a1,a0,80002acc <__printf+0x154>
    80002ef8:	ce5ff06f          	j	80002bdc <__printf+0x264>
    80002efc:	40e007bb          	negw	a5,a4
    80002f00:	00002d97          	auipc	s11,0x2
    80002f04:	2e0d8d93          	addi	s11,s11,736 # 800051e0 <digits>
    80002f08:	00f7f693          	andi	a3,a5,15
    80002f0c:	00dd86b3          	add	a3,s11,a3
    80002f10:	0006c583          	lbu	a1,0(a3)
    80002f14:	ff100613          	li	a2,-15
    80002f18:	0047d69b          	srliw	a3,a5,0x4
    80002f1c:	f8b40023          	sb	a1,-128(s0)
    80002f20:	0047d59b          	srliw	a1,a5,0x4
    80002f24:	0ac75e63          	bge	a4,a2,80002fe0 <__printf+0x668>
    80002f28:	00f6f693          	andi	a3,a3,15
    80002f2c:	00dd86b3          	add	a3,s11,a3
    80002f30:	0006c603          	lbu	a2,0(a3)
    80002f34:	00f00693          	li	a3,15
    80002f38:	0087d79b          	srliw	a5,a5,0x8
    80002f3c:	f8c400a3          	sb	a2,-127(s0)
    80002f40:	d8b6e4e3          	bltu	a3,a1,80002cc8 <__printf+0x350>
    80002f44:	00200793          	li	a5,2
    80002f48:	e2dff06f          	j	80002d74 <__printf+0x3fc>
    80002f4c:	00002c97          	auipc	s9,0x2
    80002f50:	274c8c93          	addi	s9,s9,628 # 800051c0 <_ZZ12printIntegermE6digits+0x148>
    80002f54:	02800513          	li	a0,40
    80002f58:	ef1ff06f          	j	80002e48 <__printf+0x4d0>
    80002f5c:	00700793          	li	a5,7
    80002f60:	00600c93          	li	s9,6
    80002f64:	e0dff06f          	j	80002d70 <__printf+0x3f8>
    80002f68:	00700793          	li	a5,7
    80002f6c:	00600c93          	li	s9,6
    80002f70:	c69ff06f          	j	80002bd8 <__printf+0x260>
    80002f74:	00300793          	li	a5,3
    80002f78:	00200c93          	li	s9,2
    80002f7c:	c5dff06f          	j	80002bd8 <__printf+0x260>
    80002f80:	00300793          	li	a5,3
    80002f84:	00200c93          	li	s9,2
    80002f88:	de9ff06f          	j	80002d70 <__printf+0x3f8>
    80002f8c:	00400793          	li	a5,4
    80002f90:	00300c93          	li	s9,3
    80002f94:	dddff06f          	j	80002d70 <__printf+0x3f8>
    80002f98:	00400793          	li	a5,4
    80002f9c:	00300c93          	li	s9,3
    80002fa0:	c39ff06f          	j	80002bd8 <__printf+0x260>
    80002fa4:	00500793          	li	a5,5
    80002fa8:	00400c93          	li	s9,4
    80002fac:	c2dff06f          	j	80002bd8 <__printf+0x260>
    80002fb0:	00500793          	li	a5,5
    80002fb4:	00400c93          	li	s9,4
    80002fb8:	db9ff06f          	j	80002d70 <__printf+0x3f8>
    80002fbc:	00600793          	li	a5,6
    80002fc0:	00500c93          	li	s9,5
    80002fc4:	dadff06f          	j	80002d70 <__printf+0x3f8>
    80002fc8:	00600793          	li	a5,6
    80002fcc:	00500c93          	li	s9,5
    80002fd0:	c09ff06f          	j	80002bd8 <__printf+0x260>
    80002fd4:	00800793          	li	a5,8
    80002fd8:	00700c93          	li	s9,7
    80002fdc:	bfdff06f          	j	80002bd8 <__printf+0x260>
    80002fe0:	00100793          	li	a5,1
    80002fe4:	d91ff06f          	j	80002d74 <__printf+0x3fc>
    80002fe8:	00100793          	li	a5,1
    80002fec:	bf1ff06f          	j	80002bdc <__printf+0x264>
    80002ff0:	00900793          	li	a5,9
    80002ff4:	00800c93          	li	s9,8
    80002ff8:	be1ff06f          	j	80002bd8 <__printf+0x260>
    80002ffc:	00002517          	auipc	a0,0x2
    80003000:	1cc50513          	addi	a0,a0,460 # 800051c8 <_ZZ12printIntegermE6digits+0x150>
    80003004:	00000097          	auipc	ra,0x0
    80003008:	918080e7          	jalr	-1768(ra) # 8000291c <panic>

000000008000300c <printfinit>:
    8000300c:	fe010113          	addi	sp,sp,-32
    80003010:	00813823          	sd	s0,16(sp)
    80003014:	00913423          	sd	s1,8(sp)
    80003018:	00113c23          	sd	ra,24(sp)
    8000301c:	02010413          	addi	s0,sp,32
    80003020:	00004497          	auipc	s1,0x4
    80003024:	ab048493          	addi	s1,s1,-1360 # 80006ad0 <pr>
    80003028:	00048513          	mv	a0,s1
    8000302c:	00002597          	auipc	a1,0x2
    80003030:	1ac58593          	addi	a1,a1,428 # 800051d8 <_ZZ12printIntegermE6digits+0x160>
    80003034:	00000097          	auipc	ra,0x0
    80003038:	5f4080e7          	jalr	1524(ra) # 80003628 <initlock>
    8000303c:	01813083          	ld	ra,24(sp)
    80003040:	01013403          	ld	s0,16(sp)
    80003044:	0004ac23          	sw	zero,24(s1)
    80003048:	00813483          	ld	s1,8(sp)
    8000304c:	02010113          	addi	sp,sp,32
    80003050:	00008067          	ret

0000000080003054 <uartinit>:
    80003054:	ff010113          	addi	sp,sp,-16
    80003058:	00813423          	sd	s0,8(sp)
    8000305c:	01010413          	addi	s0,sp,16
    80003060:	100007b7          	lui	a5,0x10000
    80003064:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003068:	f8000713          	li	a4,-128
    8000306c:	00e781a3          	sb	a4,3(a5)
    80003070:	00300713          	li	a4,3
    80003074:	00e78023          	sb	a4,0(a5)
    80003078:	000780a3          	sb	zero,1(a5)
    8000307c:	00e781a3          	sb	a4,3(a5)
    80003080:	00700693          	li	a3,7
    80003084:	00d78123          	sb	a3,2(a5)
    80003088:	00e780a3          	sb	a4,1(a5)
    8000308c:	00813403          	ld	s0,8(sp)
    80003090:	01010113          	addi	sp,sp,16
    80003094:	00008067          	ret

0000000080003098 <uartputc>:
    80003098:	00002797          	auipc	a5,0x2
    8000309c:	7d07a783          	lw	a5,2000(a5) # 80005868 <panicked>
    800030a0:	00078463          	beqz	a5,800030a8 <uartputc+0x10>
    800030a4:	0000006f          	j	800030a4 <uartputc+0xc>
    800030a8:	fd010113          	addi	sp,sp,-48
    800030ac:	02813023          	sd	s0,32(sp)
    800030b0:	00913c23          	sd	s1,24(sp)
    800030b4:	01213823          	sd	s2,16(sp)
    800030b8:	01313423          	sd	s3,8(sp)
    800030bc:	02113423          	sd	ra,40(sp)
    800030c0:	03010413          	addi	s0,sp,48
    800030c4:	00002917          	auipc	s2,0x2
    800030c8:	7ac90913          	addi	s2,s2,1964 # 80005870 <uart_tx_r>
    800030cc:	00093783          	ld	a5,0(s2)
    800030d0:	00002497          	auipc	s1,0x2
    800030d4:	7a848493          	addi	s1,s1,1960 # 80005878 <uart_tx_w>
    800030d8:	0004b703          	ld	a4,0(s1)
    800030dc:	02078693          	addi	a3,a5,32
    800030e0:	00050993          	mv	s3,a0
    800030e4:	02e69c63          	bne	a3,a4,8000311c <uartputc+0x84>
    800030e8:	00001097          	auipc	ra,0x1
    800030ec:	834080e7          	jalr	-1996(ra) # 8000391c <push_on>
    800030f0:	00093783          	ld	a5,0(s2)
    800030f4:	0004b703          	ld	a4,0(s1)
    800030f8:	02078793          	addi	a5,a5,32
    800030fc:	00e79463          	bne	a5,a4,80003104 <uartputc+0x6c>
    80003100:	0000006f          	j	80003100 <uartputc+0x68>
    80003104:	00001097          	auipc	ra,0x1
    80003108:	88c080e7          	jalr	-1908(ra) # 80003990 <pop_on>
    8000310c:	00093783          	ld	a5,0(s2)
    80003110:	0004b703          	ld	a4,0(s1)
    80003114:	02078693          	addi	a3,a5,32
    80003118:	fce688e3          	beq	a3,a4,800030e8 <uartputc+0x50>
    8000311c:	01f77693          	andi	a3,a4,31
    80003120:	00004597          	auipc	a1,0x4
    80003124:	9d058593          	addi	a1,a1,-1584 # 80006af0 <uart_tx_buf>
    80003128:	00d586b3          	add	a3,a1,a3
    8000312c:	00170713          	addi	a4,a4,1
    80003130:	01368023          	sb	s3,0(a3)
    80003134:	00e4b023          	sd	a4,0(s1)
    80003138:	10000637          	lui	a2,0x10000
    8000313c:	02f71063          	bne	a4,a5,8000315c <uartputc+0xc4>
    80003140:	0340006f          	j	80003174 <uartputc+0xdc>
    80003144:	00074703          	lbu	a4,0(a4)
    80003148:	00f93023          	sd	a5,0(s2)
    8000314c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003150:	00093783          	ld	a5,0(s2)
    80003154:	0004b703          	ld	a4,0(s1)
    80003158:	00f70e63          	beq	a4,a5,80003174 <uartputc+0xdc>
    8000315c:	00564683          	lbu	a3,5(a2)
    80003160:	01f7f713          	andi	a4,a5,31
    80003164:	00e58733          	add	a4,a1,a4
    80003168:	0206f693          	andi	a3,a3,32
    8000316c:	00178793          	addi	a5,a5,1
    80003170:	fc069ae3          	bnez	a3,80003144 <uartputc+0xac>
    80003174:	02813083          	ld	ra,40(sp)
    80003178:	02013403          	ld	s0,32(sp)
    8000317c:	01813483          	ld	s1,24(sp)
    80003180:	01013903          	ld	s2,16(sp)
    80003184:	00813983          	ld	s3,8(sp)
    80003188:	03010113          	addi	sp,sp,48
    8000318c:	00008067          	ret

0000000080003190 <uartputc_sync>:
    80003190:	ff010113          	addi	sp,sp,-16
    80003194:	00813423          	sd	s0,8(sp)
    80003198:	01010413          	addi	s0,sp,16
    8000319c:	00002717          	auipc	a4,0x2
    800031a0:	6cc72703          	lw	a4,1740(a4) # 80005868 <panicked>
    800031a4:	02071663          	bnez	a4,800031d0 <uartputc_sync+0x40>
    800031a8:	00050793          	mv	a5,a0
    800031ac:	100006b7          	lui	a3,0x10000
    800031b0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800031b4:	02077713          	andi	a4,a4,32
    800031b8:	fe070ce3          	beqz	a4,800031b0 <uartputc_sync+0x20>
    800031bc:	0ff7f793          	andi	a5,a5,255
    800031c0:	00f68023          	sb	a5,0(a3)
    800031c4:	00813403          	ld	s0,8(sp)
    800031c8:	01010113          	addi	sp,sp,16
    800031cc:	00008067          	ret
    800031d0:	0000006f          	j	800031d0 <uartputc_sync+0x40>

00000000800031d4 <uartstart>:
    800031d4:	ff010113          	addi	sp,sp,-16
    800031d8:	00813423          	sd	s0,8(sp)
    800031dc:	01010413          	addi	s0,sp,16
    800031e0:	00002617          	auipc	a2,0x2
    800031e4:	69060613          	addi	a2,a2,1680 # 80005870 <uart_tx_r>
    800031e8:	00002517          	auipc	a0,0x2
    800031ec:	69050513          	addi	a0,a0,1680 # 80005878 <uart_tx_w>
    800031f0:	00063783          	ld	a5,0(a2)
    800031f4:	00053703          	ld	a4,0(a0)
    800031f8:	04f70263          	beq	a4,a5,8000323c <uartstart+0x68>
    800031fc:	100005b7          	lui	a1,0x10000
    80003200:	00004817          	auipc	a6,0x4
    80003204:	8f080813          	addi	a6,a6,-1808 # 80006af0 <uart_tx_buf>
    80003208:	01c0006f          	j	80003224 <uartstart+0x50>
    8000320c:	0006c703          	lbu	a4,0(a3)
    80003210:	00f63023          	sd	a5,0(a2)
    80003214:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003218:	00063783          	ld	a5,0(a2)
    8000321c:	00053703          	ld	a4,0(a0)
    80003220:	00f70e63          	beq	a4,a5,8000323c <uartstart+0x68>
    80003224:	01f7f713          	andi	a4,a5,31
    80003228:	00e806b3          	add	a3,a6,a4
    8000322c:	0055c703          	lbu	a4,5(a1)
    80003230:	00178793          	addi	a5,a5,1
    80003234:	02077713          	andi	a4,a4,32
    80003238:	fc071ae3          	bnez	a4,8000320c <uartstart+0x38>
    8000323c:	00813403          	ld	s0,8(sp)
    80003240:	01010113          	addi	sp,sp,16
    80003244:	00008067          	ret

0000000080003248 <uartgetc>:
    80003248:	ff010113          	addi	sp,sp,-16
    8000324c:	00813423          	sd	s0,8(sp)
    80003250:	01010413          	addi	s0,sp,16
    80003254:	10000737          	lui	a4,0x10000
    80003258:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000325c:	0017f793          	andi	a5,a5,1
    80003260:	00078c63          	beqz	a5,80003278 <uartgetc+0x30>
    80003264:	00074503          	lbu	a0,0(a4)
    80003268:	0ff57513          	andi	a0,a0,255
    8000326c:	00813403          	ld	s0,8(sp)
    80003270:	01010113          	addi	sp,sp,16
    80003274:	00008067          	ret
    80003278:	fff00513          	li	a0,-1
    8000327c:	ff1ff06f          	j	8000326c <uartgetc+0x24>

0000000080003280 <uartintr>:
    80003280:	100007b7          	lui	a5,0x10000
    80003284:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003288:	0017f793          	andi	a5,a5,1
    8000328c:	0a078463          	beqz	a5,80003334 <uartintr+0xb4>
    80003290:	fe010113          	addi	sp,sp,-32
    80003294:	00813823          	sd	s0,16(sp)
    80003298:	00913423          	sd	s1,8(sp)
    8000329c:	00113c23          	sd	ra,24(sp)
    800032a0:	02010413          	addi	s0,sp,32
    800032a4:	100004b7          	lui	s1,0x10000
    800032a8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800032ac:	0ff57513          	andi	a0,a0,255
    800032b0:	fffff097          	auipc	ra,0xfffff
    800032b4:	534080e7          	jalr	1332(ra) # 800027e4 <consoleintr>
    800032b8:	0054c783          	lbu	a5,5(s1)
    800032bc:	0017f793          	andi	a5,a5,1
    800032c0:	fe0794e3          	bnez	a5,800032a8 <uartintr+0x28>
    800032c4:	00002617          	auipc	a2,0x2
    800032c8:	5ac60613          	addi	a2,a2,1452 # 80005870 <uart_tx_r>
    800032cc:	00002517          	auipc	a0,0x2
    800032d0:	5ac50513          	addi	a0,a0,1452 # 80005878 <uart_tx_w>
    800032d4:	00063783          	ld	a5,0(a2)
    800032d8:	00053703          	ld	a4,0(a0)
    800032dc:	04f70263          	beq	a4,a5,80003320 <uartintr+0xa0>
    800032e0:	100005b7          	lui	a1,0x10000
    800032e4:	00004817          	auipc	a6,0x4
    800032e8:	80c80813          	addi	a6,a6,-2036 # 80006af0 <uart_tx_buf>
    800032ec:	01c0006f          	j	80003308 <uartintr+0x88>
    800032f0:	0006c703          	lbu	a4,0(a3)
    800032f4:	00f63023          	sd	a5,0(a2)
    800032f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800032fc:	00063783          	ld	a5,0(a2)
    80003300:	00053703          	ld	a4,0(a0)
    80003304:	00f70e63          	beq	a4,a5,80003320 <uartintr+0xa0>
    80003308:	01f7f713          	andi	a4,a5,31
    8000330c:	00e806b3          	add	a3,a6,a4
    80003310:	0055c703          	lbu	a4,5(a1)
    80003314:	00178793          	addi	a5,a5,1
    80003318:	02077713          	andi	a4,a4,32
    8000331c:	fc071ae3          	bnez	a4,800032f0 <uartintr+0x70>
    80003320:	01813083          	ld	ra,24(sp)
    80003324:	01013403          	ld	s0,16(sp)
    80003328:	00813483          	ld	s1,8(sp)
    8000332c:	02010113          	addi	sp,sp,32
    80003330:	00008067          	ret
    80003334:	00002617          	auipc	a2,0x2
    80003338:	53c60613          	addi	a2,a2,1340 # 80005870 <uart_tx_r>
    8000333c:	00002517          	auipc	a0,0x2
    80003340:	53c50513          	addi	a0,a0,1340 # 80005878 <uart_tx_w>
    80003344:	00063783          	ld	a5,0(a2)
    80003348:	00053703          	ld	a4,0(a0)
    8000334c:	04f70263          	beq	a4,a5,80003390 <uartintr+0x110>
    80003350:	100005b7          	lui	a1,0x10000
    80003354:	00003817          	auipc	a6,0x3
    80003358:	79c80813          	addi	a6,a6,1948 # 80006af0 <uart_tx_buf>
    8000335c:	01c0006f          	j	80003378 <uartintr+0xf8>
    80003360:	0006c703          	lbu	a4,0(a3)
    80003364:	00f63023          	sd	a5,0(a2)
    80003368:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000336c:	00063783          	ld	a5,0(a2)
    80003370:	00053703          	ld	a4,0(a0)
    80003374:	02f70063          	beq	a4,a5,80003394 <uartintr+0x114>
    80003378:	01f7f713          	andi	a4,a5,31
    8000337c:	00e806b3          	add	a3,a6,a4
    80003380:	0055c703          	lbu	a4,5(a1)
    80003384:	00178793          	addi	a5,a5,1
    80003388:	02077713          	andi	a4,a4,32
    8000338c:	fc071ae3          	bnez	a4,80003360 <uartintr+0xe0>
    80003390:	00008067          	ret
    80003394:	00008067          	ret

0000000080003398 <kinit>:
    80003398:	fc010113          	addi	sp,sp,-64
    8000339c:	02913423          	sd	s1,40(sp)
    800033a0:	fffff7b7          	lui	a5,0xfffff
    800033a4:	00004497          	auipc	s1,0x4
    800033a8:	77b48493          	addi	s1,s1,1915 # 80007b1f <end+0xfff>
    800033ac:	02813823          	sd	s0,48(sp)
    800033b0:	01313c23          	sd	s3,24(sp)
    800033b4:	00f4f4b3          	and	s1,s1,a5
    800033b8:	02113c23          	sd	ra,56(sp)
    800033bc:	03213023          	sd	s2,32(sp)
    800033c0:	01413823          	sd	s4,16(sp)
    800033c4:	01513423          	sd	s5,8(sp)
    800033c8:	04010413          	addi	s0,sp,64
    800033cc:	000017b7          	lui	a5,0x1
    800033d0:	01100993          	li	s3,17
    800033d4:	00f487b3          	add	a5,s1,a5
    800033d8:	01b99993          	slli	s3,s3,0x1b
    800033dc:	06f9e063          	bltu	s3,a5,8000343c <kinit+0xa4>
    800033e0:	00003a97          	auipc	s5,0x3
    800033e4:	740a8a93          	addi	s5,s5,1856 # 80006b20 <end>
    800033e8:	0754ec63          	bltu	s1,s5,80003460 <kinit+0xc8>
    800033ec:	0734fa63          	bgeu	s1,s3,80003460 <kinit+0xc8>
    800033f0:	00088a37          	lui	s4,0x88
    800033f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800033f8:	00002917          	auipc	s2,0x2
    800033fc:	48890913          	addi	s2,s2,1160 # 80005880 <kmem>
    80003400:	00ca1a13          	slli	s4,s4,0xc
    80003404:	0140006f          	j	80003418 <kinit+0x80>
    80003408:	000017b7          	lui	a5,0x1
    8000340c:	00f484b3          	add	s1,s1,a5
    80003410:	0554e863          	bltu	s1,s5,80003460 <kinit+0xc8>
    80003414:	0534f663          	bgeu	s1,s3,80003460 <kinit+0xc8>
    80003418:	00001637          	lui	a2,0x1
    8000341c:	00100593          	li	a1,1
    80003420:	00048513          	mv	a0,s1
    80003424:	00000097          	auipc	ra,0x0
    80003428:	5e4080e7          	jalr	1508(ra) # 80003a08 <__memset>
    8000342c:	00093783          	ld	a5,0(s2)
    80003430:	00f4b023          	sd	a5,0(s1)
    80003434:	00993023          	sd	s1,0(s2)
    80003438:	fd4498e3          	bne	s1,s4,80003408 <kinit+0x70>
    8000343c:	03813083          	ld	ra,56(sp)
    80003440:	03013403          	ld	s0,48(sp)
    80003444:	02813483          	ld	s1,40(sp)
    80003448:	02013903          	ld	s2,32(sp)
    8000344c:	01813983          	ld	s3,24(sp)
    80003450:	01013a03          	ld	s4,16(sp)
    80003454:	00813a83          	ld	s5,8(sp)
    80003458:	04010113          	addi	sp,sp,64
    8000345c:	00008067          	ret
    80003460:	00002517          	auipc	a0,0x2
    80003464:	d9850513          	addi	a0,a0,-616 # 800051f8 <digits+0x18>
    80003468:	fffff097          	auipc	ra,0xfffff
    8000346c:	4b4080e7          	jalr	1204(ra) # 8000291c <panic>

0000000080003470 <freerange>:
    80003470:	fc010113          	addi	sp,sp,-64
    80003474:	000017b7          	lui	a5,0x1
    80003478:	02913423          	sd	s1,40(sp)
    8000347c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003480:	009504b3          	add	s1,a0,s1
    80003484:	fffff537          	lui	a0,0xfffff
    80003488:	02813823          	sd	s0,48(sp)
    8000348c:	02113c23          	sd	ra,56(sp)
    80003490:	03213023          	sd	s2,32(sp)
    80003494:	01313c23          	sd	s3,24(sp)
    80003498:	01413823          	sd	s4,16(sp)
    8000349c:	01513423          	sd	s5,8(sp)
    800034a0:	01613023          	sd	s6,0(sp)
    800034a4:	04010413          	addi	s0,sp,64
    800034a8:	00a4f4b3          	and	s1,s1,a0
    800034ac:	00f487b3          	add	a5,s1,a5
    800034b0:	06f5e463          	bltu	a1,a5,80003518 <freerange+0xa8>
    800034b4:	00003a97          	auipc	s5,0x3
    800034b8:	66ca8a93          	addi	s5,s5,1644 # 80006b20 <end>
    800034bc:	0954e263          	bltu	s1,s5,80003540 <freerange+0xd0>
    800034c0:	01100993          	li	s3,17
    800034c4:	01b99993          	slli	s3,s3,0x1b
    800034c8:	0734fc63          	bgeu	s1,s3,80003540 <freerange+0xd0>
    800034cc:	00058a13          	mv	s4,a1
    800034d0:	00002917          	auipc	s2,0x2
    800034d4:	3b090913          	addi	s2,s2,944 # 80005880 <kmem>
    800034d8:	00002b37          	lui	s6,0x2
    800034dc:	0140006f          	j	800034f0 <freerange+0x80>
    800034e0:	000017b7          	lui	a5,0x1
    800034e4:	00f484b3          	add	s1,s1,a5
    800034e8:	0554ec63          	bltu	s1,s5,80003540 <freerange+0xd0>
    800034ec:	0534fa63          	bgeu	s1,s3,80003540 <freerange+0xd0>
    800034f0:	00001637          	lui	a2,0x1
    800034f4:	00100593          	li	a1,1
    800034f8:	00048513          	mv	a0,s1
    800034fc:	00000097          	auipc	ra,0x0
    80003500:	50c080e7          	jalr	1292(ra) # 80003a08 <__memset>
    80003504:	00093703          	ld	a4,0(s2)
    80003508:	016487b3          	add	a5,s1,s6
    8000350c:	00e4b023          	sd	a4,0(s1)
    80003510:	00993023          	sd	s1,0(s2)
    80003514:	fcfa76e3          	bgeu	s4,a5,800034e0 <freerange+0x70>
    80003518:	03813083          	ld	ra,56(sp)
    8000351c:	03013403          	ld	s0,48(sp)
    80003520:	02813483          	ld	s1,40(sp)
    80003524:	02013903          	ld	s2,32(sp)
    80003528:	01813983          	ld	s3,24(sp)
    8000352c:	01013a03          	ld	s4,16(sp)
    80003530:	00813a83          	ld	s5,8(sp)
    80003534:	00013b03          	ld	s6,0(sp)
    80003538:	04010113          	addi	sp,sp,64
    8000353c:	00008067          	ret
    80003540:	00002517          	auipc	a0,0x2
    80003544:	cb850513          	addi	a0,a0,-840 # 800051f8 <digits+0x18>
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	3d4080e7          	jalr	980(ra) # 8000291c <panic>

0000000080003550 <kfree>:
    80003550:	fe010113          	addi	sp,sp,-32
    80003554:	00813823          	sd	s0,16(sp)
    80003558:	00113c23          	sd	ra,24(sp)
    8000355c:	00913423          	sd	s1,8(sp)
    80003560:	02010413          	addi	s0,sp,32
    80003564:	03451793          	slli	a5,a0,0x34
    80003568:	04079c63          	bnez	a5,800035c0 <kfree+0x70>
    8000356c:	00003797          	auipc	a5,0x3
    80003570:	5b478793          	addi	a5,a5,1460 # 80006b20 <end>
    80003574:	00050493          	mv	s1,a0
    80003578:	04f56463          	bltu	a0,a5,800035c0 <kfree+0x70>
    8000357c:	01100793          	li	a5,17
    80003580:	01b79793          	slli	a5,a5,0x1b
    80003584:	02f57e63          	bgeu	a0,a5,800035c0 <kfree+0x70>
    80003588:	00001637          	lui	a2,0x1
    8000358c:	00100593          	li	a1,1
    80003590:	00000097          	auipc	ra,0x0
    80003594:	478080e7          	jalr	1144(ra) # 80003a08 <__memset>
    80003598:	00002797          	auipc	a5,0x2
    8000359c:	2e878793          	addi	a5,a5,744 # 80005880 <kmem>
    800035a0:	0007b703          	ld	a4,0(a5)
    800035a4:	01813083          	ld	ra,24(sp)
    800035a8:	01013403          	ld	s0,16(sp)
    800035ac:	00e4b023          	sd	a4,0(s1)
    800035b0:	0097b023          	sd	s1,0(a5)
    800035b4:	00813483          	ld	s1,8(sp)
    800035b8:	02010113          	addi	sp,sp,32
    800035bc:	00008067          	ret
    800035c0:	00002517          	auipc	a0,0x2
    800035c4:	c3850513          	addi	a0,a0,-968 # 800051f8 <digits+0x18>
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	354080e7          	jalr	852(ra) # 8000291c <panic>

00000000800035d0 <kalloc>:
    800035d0:	fe010113          	addi	sp,sp,-32
    800035d4:	00813823          	sd	s0,16(sp)
    800035d8:	00913423          	sd	s1,8(sp)
    800035dc:	00113c23          	sd	ra,24(sp)
    800035e0:	02010413          	addi	s0,sp,32
    800035e4:	00002797          	auipc	a5,0x2
    800035e8:	29c78793          	addi	a5,a5,668 # 80005880 <kmem>
    800035ec:	0007b483          	ld	s1,0(a5)
    800035f0:	02048063          	beqz	s1,80003610 <kalloc+0x40>
    800035f4:	0004b703          	ld	a4,0(s1)
    800035f8:	00001637          	lui	a2,0x1
    800035fc:	00500593          	li	a1,5
    80003600:	00048513          	mv	a0,s1
    80003604:	00e7b023          	sd	a4,0(a5)
    80003608:	00000097          	auipc	ra,0x0
    8000360c:	400080e7          	jalr	1024(ra) # 80003a08 <__memset>
    80003610:	01813083          	ld	ra,24(sp)
    80003614:	01013403          	ld	s0,16(sp)
    80003618:	00048513          	mv	a0,s1
    8000361c:	00813483          	ld	s1,8(sp)
    80003620:	02010113          	addi	sp,sp,32
    80003624:	00008067          	ret

0000000080003628 <initlock>:
    80003628:	ff010113          	addi	sp,sp,-16
    8000362c:	00813423          	sd	s0,8(sp)
    80003630:	01010413          	addi	s0,sp,16
    80003634:	00813403          	ld	s0,8(sp)
    80003638:	00b53423          	sd	a1,8(a0)
    8000363c:	00052023          	sw	zero,0(a0)
    80003640:	00053823          	sd	zero,16(a0)
    80003644:	01010113          	addi	sp,sp,16
    80003648:	00008067          	ret

000000008000364c <acquire>:
    8000364c:	fe010113          	addi	sp,sp,-32
    80003650:	00813823          	sd	s0,16(sp)
    80003654:	00913423          	sd	s1,8(sp)
    80003658:	00113c23          	sd	ra,24(sp)
    8000365c:	01213023          	sd	s2,0(sp)
    80003660:	02010413          	addi	s0,sp,32
    80003664:	00050493          	mv	s1,a0
    80003668:	10002973          	csrr	s2,sstatus
    8000366c:	100027f3          	csrr	a5,sstatus
    80003670:	ffd7f793          	andi	a5,a5,-3
    80003674:	10079073          	csrw	sstatus,a5
    80003678:	fffff097          	auipc	ra,0xfffff
    8000367c:	8e8080e7          	jalr	-1816(ra) # 80001f60 <mycpu>
    80003680:	07852783          	lw	a5,120(a0)
    80003684:	06078e63          	beqz	a5,80003700 <acquire+0xb4>
    80003688:	fffff097          	auipc	ra,0xfffff
    8000368c:	8d8080e7          	jalr	-1832(ra) # 80001f60 <mycpu>
    80003690:	07852783          	lw	a5,120(a0)
    80003694:	0004a703          	lw	a4,0(s1)
    80003698:	0017879b          	addiw	a5,a5,1
    8000369c:	06f52c23          	sw	a5,120(a0)
    800036a0:	04071063          	bnez	a4,800036e0 <acquire+0x94>
    800036a4:	00100713          	li	a4,1
    800036a8:	00070793          	mv	a5,a4
    800036ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800036b0:	0007879b          	sext.w	a5,a5
    800036b4:	fe079ae3          	bnez	a5,800036a8 <acquire+0x5c>
    800036b8:	0ff0000f          	fence
    800036bc:	fffff097          	auipc	ra,0xfffff
    800036c0:	8a4080e7          	jalr	-1884(ra) # 80001f60 <mycpu>
    800036c4:	01813083          	ld	ra,24(sp)
    800036c8:	01013403          	ld	s0,16(sp)
    800036cc:	00a4b823          	sd	a0,16(s1)
    800036d0:	00013903          	ld	s2,0(sp)
    800036d4:	00813483          	ld	s1,8(sp)
    800036d8:	02010113          	addi	sp,sp,32
    800036dc:	00008067          	ret
    800036e0:	0104b903          	ld	s2,16(s1)
    800036e4:	fffff097          	auipc	ra,0xfffff
    800036e8:	87c080e7          	jalr	-1924(ra) # 80001f60 <mycpu>
    800036ec:	faa91ce3          	bne	s2,a0,800036a4 <acquire+0x58>
    800036f0:	00002517          	auipc	a0,0x2
    800036f4:	b1050513          	addi	a0,a0,-1264 # 80005200 <digits+0x20>
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	224080e7          	jalr	548(ra) # 8000291c <panic>
    80003700:	00195913          	srli	s2,s2,0x1
    80003704:	fffff097          	auipc	ra,0xfffff
    80003708:	85c080e7          	jalr	-1956(ra) # 80001f60 <mycpu>
    8000370c:	00197913          	andi	s2,s2,1
    80003710:	07252e23          	sw	s2,124(a0)
    80003714:	f75ff06f          	j	80003688 <acquire+0x3c>

0000000080003718 <release>:
    80003718:	fe010113          	addi	sp,sp,-32
    8000371c:	00813823          	sd	s0,16(sp)
    80003720:	00113c23          	sd	ra,24(sp)
    80003724:	00913423          	sd	s1,8(sp)
    80003728:	01213023          	sd	s2,0(sp)
    8000372c:	02010413          	addi	s0,sp,32
    80003730:	00052783          	lw	a5,0(a0)
    80003734:	00079a63          	bnez	a5,80003748 <release+0x30>
    80003738:	00002517          	auipc	a0,0x2
    8000373c:	ad050513          	addi	a0,a0,-1328 # 80005208 <digits+0x28>
    80003740:	fffff097          	auipc	ra,0xfffff
    80003744:	1dc080e7          	jalr	476(ra) # 8000291c <panic>
    80003748:	01053903          	ld	s2,16(a0)
    8000374c:	00050493          	mv	s1,a0
    80003750:	fffff097          	auipc	ra,0xfffff
    80003754:	810080e7          	jalr	-2032(ra) # 80001f60 <mycpu>
    80003758:	fea910e3          	bne	s2,a0,80003738 <release+0x20>
    8000375c:	0004b823          	sd	zero,16(s1)
    80003760:	0ff0000f          	fence
    80003764:	0f50000f          	fence	iorw,ow
    80003768:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000376c:	ffffe097          	auipc	ra,0xffffe
    80003770:	7f4080e7          	jalr	2036(ra) # 80001f60 <mycpu>
    80003774:	100027f3          	csrr	a5,sstatus
    80003778:	0027f793          	andi	a5,a5,2
    8000377c:	04079a63          	bnez	a5,800037d0 <release+0xb8>
    80003780:	07852783          	lw	a5,120(a0)
    80003784:	02f05e63          	blez	a5,800037c0 <release+0xa8>
    80003788:	fff7871b          	addiw	a4,a5,-1
    8000378c:	06e52c23          	sw	a4,120(a0)
    80003790:	00071c63          	bnez	a4,800037a8 <release+0x90>
    80003794:	07c52783          	lw	a5,124(a0)
    80003798:	00078863          	beqz	a5,800037a8 <release+0x90>
    8000379c:	100027f3          	csrr	a5,sstatus
    800037a0:	0027e793          	ori	a5,a5,2
    800037a4:	10079073          	csrw	sstatus,a5
    800037a8:	01813083          	ld	ra,24(sp)
    800037ac:	01013403          	ld	s0,16(sp)
    800037b0:	00813483          	ld	s1,8(sp)
    800037b4:	00013903          	ld	s2,0(sp)
    800037b8:	02010113          	addi	sp,sp,32
    800037bc:	00008067          	ret
    800037c0:	00002517          	auipc	a0,0x2
    800037c4:	a6850513          	addi	a0,a0,-1432 # 80005228 <digits+0x48>
    800037c8:	fffff097          	auipc	ra,0xfffff
    800037cc:	154080e7          	jalr	340(ra) # 8000291c <panic>
    800037d0:	00002517          	auipc	a0,0x2
    800037d4:	a4050513          	addi	a0,a0,-1472 # 80005210 <digits+0x30>
    800037d8:	fffff097          	auipc	ra,0xfffff
    800037dc:	144080e7          	jalr	324(ra) # 8000291c <panic>

00000000800037e0 <holding>:
    800037e0:	00052783          	lw	a5,0(a0)
    800037e4:	00079663          	bnez	a5,800037f0 <holding+0x10>
    800037e8:	00000513          	li	a0,0
    800037ec:	00008067          	ret
    800037f0:	fe010113          	addi	sp,sp,-32
    800037f4:	00813823          	sd	s0,16(sp)
    800037f8:	00913423          	sd	s1,8(sp)
    800037fc:	00113c23          	sd	ra,24(sp)
    80003800:	02010413          	addi	s0,sp,32
    80003804:	01053483          	ld	s1,16(a0)
    80003808:	ffffe097          	auipc	ra,0xffffe
    8000380c:	758080e7          	jalr	1880(ra) # 80001f60 <mycpu>
    80003810:	01813083          	ld	ra,24(sp)
    80003814:	01013403          	ld	s0,16(sp)
    80003818:	40a48533          	sub	a0,s1,a0
    8000381c:	00153513          	seqz	a0,a0
    80003820:	00813483          	ld	s1,8(sp)
    80003824:	02010113          	addi	sp,sp,32
    80003828:	00008067          	ret

000000008000382c <push_off>:
    8000382c:	fe010113          	addi	sp,sp,-32
    80003830:	00813823          	sd	s0,16(sp)
    80003834:	00113c23          	sd	ra,24(sp)
    80003838:	00913423          	sd	s1,8(sp)
    8000383c:	02010413          	addi	s0,sp,32
    80003840:	100024f3          	csrr	s1,sstatus
    80003844:	100027f3          	csrr	a5,sstatus
    80003848:	ffd7f793          	andi	a5,a5,-3
    8000384c:	10079073          	csrw	sstatus,a5
    80003850:	ffffe097          	auipc	ra,0xffffe
    80003854:	710080e7          	jalr	1808(ra) # 80001f60 <mycpu>
    80003858:	07852783          	lw	a5,120(a0)
    8000385c:	02078663          	beqz	a5,80003888 <push_off+0x5c>
    80003860:	ffffe097          	auipc	ra,0xffffe
    80003864:	700080e7          	jalr	1792(ra) # 80001f60 <mycpu>
    80003868:	07852783          	lw	a5,120(a0)
    8000386c:	01813083          	ld	ra,24(sp)
    80003870:	01013403          	ld	s0,16(sp)
    80003874:	0017879b          	addiw	a5,a5,1
    80003878:	06f52c23          	sw	a5,120(a0)
    8000387c:	00813483          	ld	s1,8(sp)
    80003880:	02010113          	addi	sp,sp,32
    80003884:	00008067          	ret
    80003888:	0014d493          	srli	s1,s1,0x1
    8000388c:	ffffe097          	auipc	ra,0xffffe
    80003890:	6d4080e7          	jalr	1748(ra) # 80001f60 <mycpu>
    80003894:	0014f493          	andi	s1,s1,1
    80003898:	06952e23          	sw	s1,124(a0)
    8000389c:	fc5ff06f          	j	80003860 <push_off+0x34>

00000000800038a0 <pop_off>:
    800038a0:	ff010113          	addi	sp,sp,-16
    800038a4:	00813023          	sd	s0,0(sp)
    800038a8:	00113423          	sd	ra,8(sp)
    800038ac:	01010413          	addi	s0,sp,16
    800038b0:	ffffe097          	auipc	ra,0xffffe
    800038b4:	6b0080e7          	jalr	1712(ra) # 80001f60 <mycpu>
    800038b8:	100027f3          	csrr	a5,sstatus
    800038bc:	0027f793          	andi	a5,a5,2
    800038c0:	04079663          	bnez	a5,8000390c <pop_off+0x6c>
    800038c4:	07852783          	lw	a5,120(a0)
    800038c8:	02f05a63          	blez	a5,800038fc <pop_off+0x5c>
    800038cc:	fff7871b          	addiw	a4,a5,-1
    800038d0:	06e52c23          	sw	a4,120(a0)
    800038d4:	00071c63          	bnez	a4,800038ec <pop_off+0x4c>
    800038d8:	07c52783          	lw	a5,124(a0)
    800038dc:	00078863          	beqz	a5,800038ec <pop_off+0x4c>
    800038e0:	100027f3          	csrr	a5,sstatus
    800038e4:	0027e793          	ori	a5,a5,2
    800038e8:	10079073          	csrw	sstatus,a5
    800038ec:	00813083          	ld	ra,8(sp)
    800038f0:	00013403          	ld	s0,0(sp)
    800038f4:	01010113          	addi	sp,sp,16
    800038f8:	00008067          	ret
    800038fc:	00002517          	auipc	a0,0x2
    80003900:	92c50513          	addi	a0,a0,-1748 # 80005228 <digits+0x48>
    80003904:	fffff097          	auipc	ra,0xfffff
    80003908:	018080e7          	jalr	24(ra) # 8000291c <panic>
    8000390c:	00002517          	auipc	a0,0x2
    80003910:	90450513          	addi	a0,a0,-1788 # 80005210 <digits+0x30>
    80003914:	fffff097          	auipc	ra,0xfffff
    80003918:	008080e7          	jalr	8(ra) # 8000291c <panic>

000000008000391c <push_on>:
    8000391c:	fe010113          	addi	sp,sp,-32
    80003920:	00813823          	sd	s0,16(sp)
    80003924:	00113c23          	sd	ra,24(sp)
    80003928:	00913423          	sd	s1,8(sp)
    8000392c:	02010413          	addi	s0,sp,32
    80003930:	100024f3          	csrr	s1,sstatus
    80003934:	100027f3          	csrr	a5,sstatus
    80003938:	0027e793          	ori	a5,a5,2
    8000393c:	10079073          	csrw	sstatus,a5
    80003940:	ffffe097          	auipc	ra,0xffffe
    80003944:	620080e7          	jalr	1568(ra) # 80001f60 <mycpu>
    80003948:	07852783          	lw	a5,120(a0)
    8000394c:	02078663          	beqz	a5,80003978 <push_on+0x5c>
    80003950:	ffffe097          	auipc	ra,0xffffe
    80003954:	610080e7          	jalr	1552(ra) # 80001f60 <mycpu>
    80003958:	07852783          	lw	a5,120(a0)
    8000395c:	01813083          	ld	ra,24(sp)
    80003960:	01013403          	ld	s0,16(sp)
    80003964:	0017879b          	addiw	a5,a5,1
    80003968:	06f52c23          	sw	a5,120(a0)
    8000396c:	00813483          	ld	s1,8(sp)
    80003970:	02010113          	addi	sp,sp,32
    80003974:	00008067          	ret
    80003978:	0014d493          	srli	s1,s1,0x1
    8000397c:	ffffe097          	auipc	ra,0xffffe
    80003980:	5e4080e7          	jalr	1508(ra) # 80001f60 <mycpu>
    80003984:	0014f493          	andi	s1,s1,1
    80003988:	06952e23          	sw	s1,124(a0)
    8000398c:	fc5ff06f          	j	80003950 <push_on+0x34>

0000000080003990 <pop_on>:
    80003990:	ff010113          	addi	sp,sp,-16
    80003994:	00813023          	sd	s0,0(sp)
    80003998:	00113423          	sd	ra,8(sp)
    8000399c:	01010413          	addi	s0,sp,16
    800039a0:	ffffe097          	auipc	ra,0xffffe
    800039a4:	5c0080e7          	jalr	1472(ra) # 80001f60 <mycpu>
    800039a8:	100027f3          	csrr	a5,sstatus
    800039ac:	0027f793          	andi	a5,a5,2
    800039b0:	04078463          	beqz	a5,800039f8 <pop_on+0x68>
    800039b4:	07852783          	lw	a5,120(a0)
    800039b8:	02f05863          	blez	a5,800039e8 <pop_on+0x58>
    800039bc:	fff7879b          	addiw	a5,a5,-1
    800039c0:	06f52c23          	sw	a5,120(a0)
    800039c4:	07853783          	ld	a5,120(a0)
    800039c8:	00079863          	bnez	a5,800039d8 <pop_on+0x48>
    800039cc:	100027f3          	csrr	a5,sstatus
    800039d0:	ffd7f793          	andi	a5,a5,-3
    800039d4:	10079073          	csrw	sstatus,a5
    800039d8:	00813083          	ld	ra,8(sp)
    800039dc:	00013403          	ld	s0,0(sp)
    800039e0:	01010113          	addi	sp,sp,16
    800039e4:	00008067          	ret
    800039e8:	00002517          	auipc	a0,0x2
    800039ec:	86850513          	addi	a0,a0,-1944 # 80005250 <digits+0x70>
    800039f0:	fffff097          	auipc	ra,0xfffff
    800039f4:	f2c080e7          	jalr	-212(ra) # 8000291c <panic>
    800039f8:	00002517          	auipc	a0,0x2
    800039fc:	83850513          	addi	a0,a0,-1992 # 80005230 <digits+0x50>
    80003a00:	fffff097          	auipc	ra,0xfffff
    80003a04:	f1c080e7          	jalr	-228(ra) # 8000291c <panic>

0000000080003a08 <__memset>:
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00813423          	sd	s0,8(sp)
    80003a10:	01010413          	addi	s0,sp,16
    80003a14:	1a060e63          	beqz	a2,80003bd0 <__memset+0x1c8>
    80003a18:	40a007b3          	neg	a5,a0
    80003a1c:	0077f793          	andi	a5,a5,7
    80003a20:	00778693          	addi	a3,a5,7
    80003a24:	00b00813          	li	a6,11
    80003a28:	0ff5f593          	andi	a1,a1,255
    80003a2c:	fff6071b          	addiw	a4,a2,-1
    80003a30:	1b06e663          	bltu	a3,a6,80003bdc <__memset+0x1d4>
    80003a34:	1cd76463          	bltu	a4,a3,80003bfc <__memset+0x1f4>
    80003a38:	1a078e63          	beqz	a5,80003bf4 <__memset+0x1ec>
    80003a3c:	00b50023          	sb	a1,0(a0)
    80003a40:	00100713          	li	a4,1
    80003a44:	1ae78463          	beq	a5,a4,80003bec <__memset+0x1e4>
    80003a48:	00b500a3          	sb	a1,1(a0)
    80003a4c:	00200713          	li	a4,2
    80003a50:	1ae78a63          	beq	a5,a4,80003c04 <__memset+0x1fc>
    80003a54:	00b50123          	sb	a1,2(a0)
    80003a58:	00300713          	li	a4,3
    80003a5c:	18e78463          	beq	a5,a4,80003be4 <__memset+0x1dc>
    80003a60:	00b501a3          	sb	a1,3(a0)
    80003a64:	00400713          	li	a4,4
    80003a68:	1ae78263          	beq	a5,a4,80003c0c <__memset+0x204>
    80003a6c:	00b50223          	sb	a1,4(a0)
    80003a70:	00500713          	li	a4,5
    80003a74:	1ae78063          	beq	a5,a4,80003c14 <__memset+0x20c>
    80003a78:	00b502a3          	sb	a1,5(a0)
    80003a7c:	00700713          	li	a4,7
    80003a80:	18e79e63          	bne	a5,a4,80003c1c <__memset+0x214>
    80003a84:	00b50323          	sb	a1,6(a0)
    80003a88:	00700e93          	li	t4,7
    80003a8c:	00859713          	slli	a4,a1,0x8
    80003a90:	00e5e733          	or	a4,a1,a4
    80003a94:	01059e13          	slli	t3,a1,0x10
    80003a98:	01c76e33          	or	t3,a4,t3
    80003a9c:	01859313          	slli	t1,a1,0x18
    80003aa0:	006e6333          	or	t1,t3,t1
    80003aa4:	02059893          	slli	a7,a1,0x20
    80003aa8:	40f60e3b          	subw	t3,a2,a5
    80003aac:	011368b3          	or	a7,t1,a7
    80003ab0:	02859813          	slli	a6,a1,0x28
    80003ab4:	0108e833          	or	a6,a7,a6
    80003ab8:	03059693          	slli	a3,a1,0x30
    80003abc:	003e589b          	srliw	a7,t3,0x3
    80003ac0:	00d866b3          	or	a3,a6,a3
    80003ac4:	03859713          	slli	a4,a1,0x38
    80003ac8:	00389813          	slli	a6,a7,0x3
    80003acc:	00f507b3          	add	a5,a0,a5
    80003ad0:	00e6e733          	or	a4,a3,a4
    80003ad4:	000e089b          	sext.w	a7,t3
    80003ad8:	00f806b3          	add	a3,a6,a5
    80003adc:	00e7b023          	sd	a4,0(a5)
    80003ae0:	00878793          	addi	a5,a5,8
    80003ae4:	fed79ce3          	bne	a5,a3,80003adc <__memset+0xd4>
    80003ae8:	ff8e7793          	andi	a5,t3,-8
    80003aec:	0007871b          	sext.w	a4,a5
    80003af0:	01d787bb          	addw	a5,a5,t4
    80003af4:	0ce88e63          	beq	a7,a4,80003bd0 <__memset+0x1c8>
    80003af8:	00f50733          	add	a4,a0,a5
    80003afc:	00b70023          	sb	a1,0(a4)
    80003b00:	0017871b          	addiw	a4,a5,1
    80003b04:	0cc77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b08:	00e50733          	add	a4,a0,a4
    80003b0c:	00b70023          	sb	a1,0(a4)
    80003b10:	0027871b          	addiw	a4,a5,2
    80003b14:	0ac77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b18:	00e50733          	add	a4,a0,a4
    80003b1c:	00b70023          	sb	a1,0(a4)
    80003b20:	0037871b          	addiw	a4,a5,3
    80003b24:	0ac77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b28:	00e50733          	add	a4,a0,a4
    80003b2c:	00b70023          	sb	a1,0(a4)
    80003b30:	0047871b          	addiw	a4,a5,4
    80003b34:	08c77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b38:	00e50733          	add	a4,a0,a4
    80003b3c:	00b70023          	sb	a1,0(a4)
    80003b40:	0057871b          	addiw	a4,a5,5
    80003b44:	08c77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b48:	00e50733          	add	a4,a0,a4
    80003b4c:	00b70023          	sb	a1,0(a4)
    80003b50:	0067871b          	addiw	a4,a5,6
    80003b54:	06c77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b58:	00e50733          	add	a4,a0,a4
    80003b5c:	00b70023          	sb	a1,0(a4)
    80003b60:	0077871b          	addiw	a4,a5,7
    80003b64:	06c77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b68:	00e50733          	add	a4,a0,a4
    80003b6c:	00b70023          	sb	a1,0(a4)
    80003b70:	0087871b          	addiw	a4,a5,8
    80003b74:	04c77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b78:	00e50733          	add	a4,a0,a4
    80003b7c:	00b70023          	sb	a1,0(a4)
    80003b80:	0097871b          	addiw	a4,a5,9
    80003b84:	04c77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b88:	00e50733          	add	a4,a0,a4
    80003b8c:	00b70023          	sb	a1,0(a4)
    80003b90:	00a7871b          	addiw	a4,a5,10
    80003b94:	02c77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003b98:	00e50733          	add	a4,a0,a4
    80003b9c:	00b70023          	sb	a1,0(a4)
    80003ba0:	00b7871b          	addiw	a4,a5,11
    80003ba4:	02c77663          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003ba8:	00e50733          	add	a4,a0,a4
    80003bac:	00b70023          	sb	a1,0(a4)
    80003bb0:	00c7871b          	addiw	a4,a5,12
    80003bb4:	00c77e63          	bgeu	a4,a2,80003bd0 <__memset+0x1c8>
    80003bb8:	00e50733          	add	a4,a0,a4
    80003bbc:	00b70023          	sb	a1,0(a4)
    80003bc0:	00d7879b          	addiw	a5,a5,13
    80003bc4:	00c7f663          	bgeu	a5,a2,80003bd0 <__memset+0x1c8>
    80003bc8:	00f507b3          	add	a5,a0,a5
    80003bcc:	00b78023          	sb	a1,0(a5)
    80003bd0:	00813403          	ld	s0,8(sp)
    80003bd4:	01010113          	addi	sp,sp,16
    80003bd8:	00008067          	ret
    80003bdc:	00b00693          	li	a3,11
    80003be0:	e55ff06f          	j	80003a34 <__memset+0x2c>
    80003be4:	00300e93          	li	t4,3
    80003be8:	ea5ff06f          	j	80003a8c <__memset+0x84>
    80003bec:	00100e93          	li	t4,1
    80003bf0:	e9dff06f          	j	80003a8c <__memset+0x84>
    80003bf4:	00000e93          	li	t4,0
    80003bf8:	e95ff06f          	j	80003a8c <__memset+0x84>
    80003bfc:	00000793          	li	a5,0
    80003c00:	ef9ff06f          	j	80003af8 <__memset+0xf0>
    80003c04:	00200e93          	li	t4,2
    80003c08:	e85ff06f          	j	80003a8c <__memset+0x84>
    80003c0c:	00400e93          	li	t4,4
    80003c10:	e7dff06f          	j	80003a8c <__memset+0x84>
    80003c14:	00500e93          	li	t4,5
    80003c18:	e75ff06f          	j	80003a8c <__memset+0x84>
    80003c1c:	00600e93          	li	t4,6
    80003c20:	e6dff06f          	j	80003a8c <__memset+0x84>

0000000080003c24 <__memmove>:
    80003c24:	ff010113          	addi	sp,sp,-16
    80003c28:	00813423          	sd	s0,8(sp)
    80003c2c:	01010413          	addi	s0,sp,16
    80003c30:	0e060863          	beqz	a2,80003d20 <__memmove+0xfc>
    80003c34:	fff6069b          	addiw	a3,a2,-1
    80003c38:	0006881b          	sext.w	a6,a3
    80003c3c:	0ea5e863          	bltu	a1,a0,80003d2c <__memmove+0x108>
    80003c40:	00758713          	addi	a4,a1,7
    80003c44:	00a5e7b3          	or	a5,a1,a0
    80003c48:	40a70733          	sub	a4,a4,a0
    80003c4c:	0077f793          	andi	a5,a5,7
    80003c50:	00f73713          	sltiu	a4,a4,15
    80003c54:	00174713          	xori	a4,a4,1
    80003c58:	0017b793          	seqz	a5,a5
    80003c5c:	00e7f7b3          	and	a5,a5,a4
    80003c60:	10078863          	beqz	a5,80003d70 <__memmove+0x14c>
    80003c64:	00900793          	li	a5,9
    80003c68:	1107f463          	bgeu	a5,a6,80003d70 <__memmove+0x14c>
    80003c6c:	0036581b          	srliw	a6,a2,0x3
    80003c70:	fff8081b          	addiw	a6,a6,-1
    80003c74:	02081813          	slli	a6,a6,0x20
    80003c78:	01d85893          	srli	a7,a6,0x1d
    80003c7c:	00858813          	addi	a6,a1,8
    80003c80:	00058793          	mv	a5,a1
    80003c84:	00050713          	mv	a4,a0
    80003c88:	01088833          	add	a6,a7,a6
    80003c8c:	0007b883          	ld	a7,0(a5)
    80003c90:	00878793          	addi	a5,a5,8
    80003c94:	00870713          	addi	a4,a4,8
    80003c98:	ff173c23          	sd	a7,-8(a4)
    80003c9c:	ff0798e3          	bne	a5,a6,80003c8c <__memmove+0x68>
    80003ca0:	ff867713          	andi	a4,a2,-8
    80003ca4:	02071793          	slli	a5,a4,0x20
    80003ca8:	0207d793          	srli	a5,a5,0x20
    80003cac:	00f585b3          	add	a1,a1,a5
    80003cb0:	40e686bb          	subw	a3,a3,a4
    80003cb4:	00f507b3          	add	a5,a0,a5
    80003cb8:	06e60463          	beq	a2,a4,80003d20 <__memmove+0xfc>
    80003cbc:	0005c703          	lbu	a4,0(a1)
    80003cc0:	00e78023          	sb	a4,0(a5)
    80003cc4:	04068e63          	beqz	a3,80003d20 <__memmove+0xfc>
    80003cc8:	0015c603          	lbu	a2,1(a1)
    80003ccc:	00100713          	li	a4,1
    80003cd0:	00c780a3          	sb	a2,1(a5)
    80003cd4:	04e68663          	beq	a3,a4,80003d20 <__memmove+0xfc>
    80003cd8:	0025c603          	lbu	a2,2(a1)
    80003cdc:	00200713          	li	a4,2
    80003ce0:	00c78123          	sb	a2,2(a5)
    80003ce4:	02e68e63          	beq	a3,a4,80003d20 <__memmove+0xfc>
    80003ce8:	0035c603          	lbu	a2,3(a1)
    80003cec:	00300713          	li	a4,3
    80003cf0:	00c781a3          	sb	a2,3(a5)
    80003cf4:	02e68663          	beq	a3,a4,80003d20 <__memmove+0xfc>
    80003cf8:	0045c603          	lbu	a2,4(a1)
    80003cfc:	00400713          	li	a4,4
    80003d00:	00c78223          	sb	a2,4(a5)
    80003d04:	00e68e63          	beq	a3,a4,80003d20 <__memmove+0xfc>
    80003d08:	0055c603          	lbu	a2,5(a1)
    80003d0c:	00500713          	li	a4,5
    80003d10:	00c782a3          	sb	a2,5(a5)
    80003d14:	00e68663          	beq	a3,a4,80003d20 <__memmove+0xfc>
    80003d18:	0065c703          	lbu	a4,6(a1)
    80003d1c:	00e78323          	sb	a4,6(a5)
    80003d20:	00813403          	ld	s0,8(sp)
    80003d24:	01010113          	addi	sp,sp,16
    80003d28:	00008067          	ret
    80003d2c:	02061713          	slli	a4,a2,0x20
    80003d30:	02075713          	srli	a4,a4,0x20
    80003d34:	00e587b3          	add	a5,a1,a4
    80003d38:	f0f574e3          	bgeu	a0,a5,80003c40 <__memmove+0x1c>
    80003d3c:	02069613          	slli	a2,a3,0x20
    80003d40:	02065613          	srli	a2,a2,0x20
    80003d44:	fff64613          	not	a2,a2
    80003d48:	00e50733          	add	a4,a0,a4
    80003d4c:	00c78633          	add	a2,a5,a2
    80003d50:	fff7c683          	lbu	a3,-1(a5)
    80003d54:	fff78793          	addi	a5,a5,-1
    80003d58:	fff70713          	addi	a4,a4,-1
    80003d5c:	00d70023          	sb	a3,0(a4)
    80003d60:	fec798e3          	bne	a5,a2,80003d50 <__memmove+0x12c>
    80003d64:	00813403          	ld	s0,8(sp)
    80003d68:	01010113          	addi	sp,sp,16
    80003d6c:	00008067          	ret
    80003d70:	02069713          	slli	a4,a3,0x20
    80003d74:	02075713          	srli	a4,a4,0x20
    80003d78:	00170713          	addi	a4,a4,1
    80003d7c:	00e50733          	add	a4,a0,a4
    80003d80:	00050793          	mv	a5,a0
    80003d84:	0005c683          	lbu	a3,0(a1)
    80003d88:	00178793          	addi	a5,a5,1
    80003d8c:	00158593          	addi	a1,a1,1
    80003d90:	fed78fa3          	sb	a3,-1(a5)
    80003d94:	fee798e3          	bne	a5,a4,80003d84 <__memmove+0x160>
    80003d98:	f89ff06f          	j	80003d20 <__memmove+0xfc>

0000000080003d9c <__mem_free>:
    80003d9c:	ff010113          	addi	sp,sp,-16
    80003da0:	00813423          	sd	s0,8(sp)
    80003da4:	01010413          	addi	s0,sp,16
    80003da8:	00002597          	auipc	a1,0x2
    80003dac:	ae058593          	addi	a1,a1,-1312 # 80005888 <freep>
    80003db0:	0005b783          	ld	a5,0(a1)
    80003db4:	ff050693          	addi	a3,a0,-16
    80003db8:	0007b703          	ld	a4,0(a5)
    80003dbc:	00d7fc63          	bgeu	a5,a3,80003dd4 <__mem_free+0x38>
    80003dc0:	00e6ee63          	bltu	a3,a4,80003ddc <__mem_free+0x40>
    80003dc4:	00e7fc63          	bgeu	a5,a4,80003ddc <__mem_free+0x40>
    80003dc8:	00070793          	mv	a5,a4
    80003dcc:	0007b703          	ld	a4,0(a5)
    80003dd0:	fed7e8e3          	bltu	a5,a3,80003dc0 <__mem_free+0x24>
    80003dd4:	fee7eae3          	bltu	a5,a4,80003dc8 <__mem_free+0x2c>
    80003dd8:	fee6f8e3          	bgeu	a3,a4,80003dc8 <__mem_free+0x2c>
    80003ddc:	ff852803          	lw	a6,-8(a0)
    80003de0:	02081613          	slli	a2,a6,0x20
    80003de4:	01c65613          	srli	a2,a2,0x1c
    80003de8:	00c68633          	add	a2,a3,a2
    80003dec:	02c70a63          	beq	a4,a2,80003e20 <__mem_free+0x84>
    80003df0:	fee53823          	sd	a4,-16(a0)
    80003df4:	0087a503          	lw	a0,8(a5)
    80003df8:	02051613          	slli	a2,a0,0x20
    80003dfc:	01c65613          	srli	a2,a2,0x1c
    80003e00:	00c78633          	add	a2,a5,a2
    80003e04:	04c68263          	beq	a3,a2,80003e48 <__mem_free+0xac>
    80003e08:	00813403          	ld	s0,8(sp)
    80003e0c:	00d7b023          	sd	a3,0(a5)
    80003e10:	00f5b023          	sd	a5,0(a1)
    80003e14:	00000513          	li	a0,0
    80003e18:	01010113          	addi	sp,sp,16
    80003e1c:	00008067          	ret
    80003e20:	00872603          	lw	a2,8(a4)
    80003e24:	00073703          	ld	a4,0(a4)
    80003e28:	0106083b          	addw	a6,a2,a6
    80003e2c:	ff052c23          	sw	a6,-8(a0)
    80003e30:	fee53823          	sd	a4,-16(a0)
    80003e34:	0087a503          	lw	a0,8(a5)
    80003e38:	02051613          	slli	a2,a0,0x20
    80003e3c:	01c65613          	srli	a2,a2,0x1c
    80003e40:	00c78633          	add	a2,a5,a2
    80003e44:	fcc692e3          	bne	a3,a2,80003e08 <__mem_free+0x6c>
    80003e48:	00813403          	ld	s0,8(sp)
    80003e4c:	0105053b          	addw	a0,a0,a6
    80003e50:	00a7a423          	sw	a0,8(a5)
    80003e54:	00e7b023          	sd	a4,0(a5)
    80003e58:	00f5b023          	sd	a5,0(a1)
    80003e5c:	00000513          	li	a0,0
    80003e60:	01010113          	addi	sp,sp,16
    80003e64:	00008067          	ret

0000000080003e68 <__mem_alloc>:
    80003e68:	fc010113          	addi	sp,sp,-64
    80003e6c:	02813823          	sd	s0,48(sp)
    80003e70:	02913423          	sd	s1,40(sp)
    80003e74:	03213023          	sd	s2,32(sp)
    80003e78:	01513423          	sd	s5,8(sp)
    80003e7c:	02113c23          	sd	ra,56(sp)
    80003e80:	01313c23          	sd	s3,24(sp)
    80003e84:	01413823          	sd	s4,16(sp)
    80003e88:	01613023          	sd	s6,0(sp)
    80003e8c:	04010413          	addi	s0,sp,64
    80003e90:	00002a97          	auipc	s5,0x2
    80003e94:	9f8a8a93          	addi	s5,s5,-1544 # 80005888 <freep>
    80003e98:	00f50913          	addi	s2,a0,15
    80003e9c:	000ab683          	ld	a3,0(s5)
    80003ea0:	00495913          	srli	s2,s2,0x4
    80003ea4:	0019049b          	addiw	s1,s2,1
    80003ea8:	00048913          	mv	s2,s1
    80003eac:	0c068c63          	beqz	a3,80003f84 <__mem_alloc+0x11c>
    80003eb0:	0006b503          	ld	a0,0(a3)
    80003eb4:	00852703          	lw	a4,8(a0)
    80003eb8:	10977063          	bgeu	a4,s1,80003fb8 <__mem_alloc+0x150>
    80003ebc:	000017b7          	lui	a5,0x1
    80003ec0:	0009099b          	sext.w	s3,s2
    80003ec4:	0af4e863          	bltu	s1,a5,80003f74 <__mem_alloc+0x10c>
    80003ec8:	02099a13          	slli	s4,s3,0x20
    80003ecc:	01ca5a13          	srli	s4,s4,0x1c
    80003ed0:	fff00b13          	li	s6,-1
    80003ed4:	0100006f          	j	80003ee4 <__mem_alloc+0x7c>
    80003ed8:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    80003edc:	00852703          	lw	a4,8(a0)
    80003ee0:	04977463          	bgeu	a4,s1,80003f28 <__mem_alloc+0xc0>
    80003ee4:	00050793          	mv	a5,a0
    80003ee8:	fea698e3          	bne	a3,a0,80003ed8 <__mem_alloc+0x70>
    80003eec:	000a0513          	mv	a0,s4
    80003ef0:	00000097          	auipc	ra,0x0
    80003ef4:	1f0080e7          	jalr	496(ra) # 800040e0 <kvmincrease>
    80003ef8:	00050793          	mv	a5,a0
    80003efc:	01050513          	addi	a0,a0,16
    80003f00:	07678e63          	beq	a5,s6,80003f7c <__mem_alloc+0x114>
    80003f04:	0137a423          	sw	s3,8(a5)
    80003f08:	00000097          	auipc	ra,0x0
    80003f0c:	e94080e7          	jalr	-364(ra) # 80003d9c <__mem_free>
    80003f10:	000ab783          	ld	a5,0(s5)
    80003f14:	06078463          	beqz	a5,80003f7c <__mem_alloc+0x114>
    80003f18:	0007b503          	ld	a0,0(a5)
    80003f1c:	00078693          	mv	a3,a5
    80003f20:	00852703          	lw	a4,8(a0)
    80003f24:	fc9760e3          	bltu	a4,s1,80003ee4 <__mem_alloc+0x7c>
    80003f28:	08e48263          	beq	s1,a4,80003fac <__mem_alloc+0x144>
    80003f2c:	4127073b          	subw	a4,a4,s2
    80003f30:	02071693          	slli	a3,a4,0x20
    80003f34:	01c6d693          	srli	a3,a3,0x1c
    80003f38:	00e52423          	sw	a4,8(a0)
    80003f3c:	00d50533          	add	a0,a0,a3
    80003f40:	01252423          	sw	s2,8(a0)
    80003f44:	00fab023          	sd	a5,0(s5)
    80003f48:	01050513          	addi	a0,a0,16
    80003f4c:	03813083          	ld	ra,56(sp)
    80003f50:	03013403          	ld	s0,48(sp)
    80003f54:	02813483          	ld	s1,40(sp)
    80003f58:	02013903          	ld	s2,32(sp)
    80003f5c:	01813983          	ld	s3,24(sp)
    80003f60:	01013a03          	ld	s4,16(sp)
    80003f64:	00813a83          	ld	s5,8(sp)
    80003f68:	00013b03          	ld	s6,0(sp)
    80003f6c:	04010113          	addi	sp,sp,64
    80003f70:	00008067          	ret
    80003f74:	000019b7          	lui	s3,0x1
    80003f78:	f51ff06f          	j	80003ec8 <__mem_alloc+0x60>
    80003f7c:	00000513          	li	a0,0
    80003f80:	fcdff06f          	j	80003f4c <__mem_alloc+0xe4>
    80003f84:	00003797          	auipc	a5,0x3
    80003f88:	b8c78793          	addi	a5,a5,-1140 # 80006b10 <base>
    80003f8c:	00078513          	mv	a0,a5
    80003f90:	00fab023          	sd	a5,0(s5)
    80003f94:	00f7b023          	sd	a5,0(a5)
    80003f98:	00000713          	li	a4,0
    80003f9c:	00003797          	auipc	a5,0x3
    80003fa0:	b607ae23          	sw	zero,-1156(a5) # 80006b18 <base+0x8>
    80003fa4:	00050693          	mv	a3,a0
    80003fa8:	f11ff06f          	j	80003eb8 <__mem_alloc+0x50>
    80003fac:	00053703          	ld	a4,0(a0)
    80003fb0:	00e7b023          	sd	a4,0(a5)
    80003fb4:	f91ff06f          	j	80003f44 <__mem_alloc+0xdc>
    80003fb8:	00068793          	mv	a5,a3
    80003fbc:	f6dff06f          	j	80003f28 <__mem_alloc+0xc0>

0000000080003fc0 <__putc>:
    80003fc0:	fe010113          	addi	sp,sp,-32
    80003fc4:	00813823          	sd	s0,16(sp)
    80003fc8:	00113c23          	sd	ra,24(sp)
    80003fcc:	02010413          	addi	s0,sp,32
    80003fd0:	00050793          	mv	a5,a0
    80003fd4:	fef40593          	addi	a1,s0,-17
    80003fd8:	00100613          	li	a2,1
    80003fdc:	00000513          	li	a0,0
    80003fe0:	fef407a3          	sb	a5,-17(s0)
    80003fe4:	fffff097          	auipc	ra,0xfffff
    80003fe8:	918080e7          	jalr	-1768(ra) # 800028fc <console_write>
    80003fec:	01813083          	ld	ra,24(sp)
    80003ff0:	01013403          	ld	s0,16(sp)
    80003ff4:	02010113          	addi	sp,sp,32
    80003ff8:	00008067          	ret

0000000080003ffc <__getc>:
    80003ffc:	fe010113          	addi	sp,sp,-32
    80004000:	00813823          	sd	s0,16(sp)
    80004004:	00113c23          	sd	ra,24(sp)
    80004008:	02010413          	addi	s0,sp,32
    8000400c:	fe840593          	addi	a1,s0,-24
    80004010:	00100613          	li	a2,1
    80004014:	00000513          	li	a0,0
    80004018:	fffff097          	auipc	ra,0xfffff
    8000401c:	8c4080e7          	jalr	-1852(ra) # 800028dc <console_read>
    80004020:	fe844503          	lbu	a0,-24(s0)
    80004024:	01813083          	ld	ra,24(sp)
    80004028:	01013403          	ld	s0,16(sp)
    8000402c:	02010113          	addi	sp,sp,32
    80004030:	00008067          	ret

0000000080004034 <console_handler>:
    80004034:	fe010113          	addi	sp,sp,-32
    80004038:	00813823          	sd	s0,16(sp)
    8000403c:	00113c23          	sd	ra,24(sp)
    80004040:	00913423          	sd	s1,8(sp)
    80004044:	02010413          	addi	s0,sp,32
    80004048:	14202773          	csrr	a4,scause
    8000404c:	100027f3          	csrr	a5,sstatus
    80004050:	0027f793          	andi	a5,a5,2
    80004054:	06079e63          	bnez	a5,800040d0 <console_handler+0x9c>
    80004058:	00074c63          	bltz	a4,80004070 <console_handler+0x3c>
    8000405c:	01813083          	ld	ra,24(sp)
    80004060:	01013403          	ld	s0,16(sp)
    80004064:	00813483          	ld	s1,8(sp)
    80004068:	02010113          	addi	sp,sp,32
    8000406c:	00008067          	ret
    80004070:	0ff77713          	andi	a4,a4,255
    80004074:	00900793          	li	a5,9
    80004078:	fef712e3          	bne	a4,a5,8000405c <console_handler+0x28>
    8000407c:	ffffe097          	auipc	ra,0xffffe
    80004080:	4b8080e7          	jalr	1208(ra) # 80002534 <plic_claim>
    80004084:	00a00793          	li	a5,10
    80004088:	00050493          	mv	s1,a0
    8000408c:	02f50c63          	beq	a0,a5,800040c4 <console_handler+0x90>
    80004090:	fc0506e3          	beqz	a0,8000405c <console_handler+0x28>
    80004094:	00050593          	mv	a1,a0
    80004098:	00001517          	auipc	a0,0x1
    8000409c:	0c050513          	addi	a0,a0,192 # 80005158 <_ZZ12printIntegermE6digits+0xe0>
    800040a0:	fffff097          	auipc	ra,0xfffff
    800040a4:	8d8080e7          	jalr	-1832(ra) # 80002978 <__printf>
    800040a8:	01013403          	ld	s0,16(sp)
    800040ac:	01813083          	ld	ra,24(sp)
    800040b0:	00048513          	mv	a0,s1
    800040b4:	00813483          	ld	s1,8(sp)
    800040b8:	02010113          	addi	sp,sp,32
    800040bc:	ffffe317          	auipc	t1,0xffffe
    800040c0:	4b030067          	jr	1200(t1) # 8000256c <plic_complete>
    800040c4:	fffff097          	auipc	ra,0xfffff
    800040c8:	1bc080e7          	jalr	444(ra) # 80003280 <uartintr>
    800040cc:	fddff06f          	j	800040a8 <console_handler+0x74>
    800040d0:	00001517          	auipc	a0,0x1
    800040d4:	18850513          	addi	a0,a0,392 # 80005258 <digits+0x78>
    800040d8:	fffff097          	auipc	ra,0xfffff
    800040dc:	844080e7          	jalr	-1980(ra) # 8000291c <panic>

00000000800040e0 <kvmincrease>:
    800040e0:	fe010113          	addi	sp,sp,-32
    800040e4:	01213023          	sd	s2,0(sp)
    800040e8:	00001937          	lui	s2,0x1
    800040ec:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    800040f0:	00813823          	sd	s0,16(sp)
    800040f4:	00113c23          	sd	ra,24(sp)
    800040f8:	00913423          	sd	s1,8(sp)
    800040fc:	02010413          	addi	s0,sp,32
    80004100:	01250933          	add	s2,a0,s2
    80004104:	00c95913          	srli	s2,s2,0xc
    80004108:	02090863          	beqz	s2,80004138 <kvmincrease+0x58>
    8000410c:	00000493          	li	s1,0
    80004110:	00148493          	addi	s1,s1,1
    80004114:	fffff097          	auipc	ra,0xfffff
    80004118:	4bc080e7          	jalr	1212(ra) # 800035d0 <kalloc>
    8000411c:	fe991ae3          	bne	s2,s1,80004110 <kvmincrease+0x30>
    80004120:	01813083          	ld	ra,24(sp)
    80004124:	01013403          	ld	s0,16(sp)
    80004128:	00813483          	ld	s1,8(sp)
    8000412c:	00013903          	ld	s2,0(sp)
    80004130:	02010113          	addi	sp,sp,32
    80004134:	00008067          	ret
    80004138:	01813083          	ld	ra,24(sp)
    8000413c:	01013403          	ld	s0,16(sp)
    80004140:	00813483          	ld	s1,8(sp)
    80004144:	00013903          	ld	s2,0(sp)
    80004148:	00000513          	li	a0,0
    8000414c:	02010113          	addi	sp,sp,32
    80004150:	00008067          	ret
	...
