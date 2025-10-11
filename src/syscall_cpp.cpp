//
// Created by os on 10/10/25.
//

#include "../h/syscall_cpp.hpp"
#include "../lib/console.h"


char Console::getc() {
    return __getc();
}

void Console::putc(char c) {
    __putc(c);
}

