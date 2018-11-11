// Steal just a bit of code from compliance_io.h...
#define RVTEST_IO_WRITE_STR(_STR)                                       \
    .section .data.string;                                              \
20001:                                                                  \
    .string _STR;                                                       \
    .section .text.init;                                                \
    la a0, 20001b;                                                      \
    jal FN_WriteStr;

#define LOCAL_IO_PUTC(_R)                                               \
    sb          _R, -16(x0);

        j _exception_nmi
        j _test_code_start
        j _exception_trap
_exception_nmi:
_exception_trap:
        li a0, 2
        // fall through
.global _test_over
_test_over:
        beqz a0, _test_success
        addi a0, a0, -1
        beqz a0, _test_fail
        RVTEST_IO_WRITE_STR("Weird test failure\n")
        sb x0, -15(x0)
_test_fail:
        RVTEST_IO_WRITE_STR("Test failure\n")
        sb x0, -15(x0)
_test_success:
        // t0: current address
        la t0, _test_data_start
        // t1: end address
        la t1, _test_data_end
        // t3: current phase / byte to output
        // a0: character to output
        // a1: address of hex codes
        la a1, hexcodes
        // a2: a newline
        li a2, '\n'
1:      xori a0, t0, 15
        lbu t3, 0(a0)
        srli a0, t3, 4
        add a0, a0, a1
        lb a0, 0(a0)
        sb a0, -16(x0)
        andi a0, t3, 15
        add a0, a0, a1
        lb a0, 0(a0)
        sb a0, -16(x0)
        addi t0, t0, 1
        beq t0, t1, 1f
        andi t3, t0, 15
        bnez t3, 1b
        sb a2, -16(x0)
        j 1b
1:      sb a2, -16(x0)
        sb x0, -15(x0)
                
// Another bit of code...
FN_WriteStr:
    mv          t0, a0;
10000:
    lbu         a0, (t0);
    addi        t0, t0, 1;
    beq         a0, zero, 10000f;
    LOCAL_IO_PUTC(a0);
    j           10000b;
10000:
    ret;

hexcodes:
        .string "0123456789abcdef"
