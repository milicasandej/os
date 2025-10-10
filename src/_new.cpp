

#include "../lib/mem.h"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"


using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    return __mem_alloc(n);
}

void *operator new[](size_t n)
{
    return __mem_alloc(n);
}

void operator delete(void *p)
{
    __mem_free(p);
}

void operator delete[](void *p)
{
    __mem_free(p);
}

char Console::getc() {
    return __getc();
}

void Console::putc(char c) {
    __putc(c);
}
