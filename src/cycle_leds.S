        .section .text.init
_exception_reset:
        li a0, 0xFF00FF
        sw a0, -4(zero)
        la a0, _exception_trap
        csrw mtvec, a0
        li a0, 0x7F
        slli a1, a0, 8
        slli a2, a1, 8
1:      sw a0, -4(zero)
        call await
        sw a1, -4(zero)
        call await
        sw a2, -4(zero)
        call await
        j 1b
_exception_trap:
        li a0, 0x7F
        sw a0, -4(zero)
1:      j 1b
await:  li t0, 16777216
1:      addi t0, t0, -1
        bnez t0, 1b
        ret
