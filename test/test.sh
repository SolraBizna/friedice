#!/bin/bash

set -e

if ! test -f ../GNUmakefile -a -f ../src/memory_sim_fullram.v; then
    echo "Run me from within the 'test' directory inside the 'friedice' directory."
    exit 1
fi

TESTDIRS="riscv-compliance/riscv-test-suite/rv32i"
for TESTDIR in $TESTDIRS; do
    if ! test -d "$TESTDIR"/src -a -d "$TESTDIR"/references; then
        echo "Couldn't find test path '$TESTDIR'; did you run 'git submodule update'?"
        exit 1
    fi
done

make -C .. bin/sim1x_compliance

TOTAL_TESTS=0
PASSING_TESTS=0
FAILING_TESTS=0

rm -rf results
mkdir results

function get_sym() {
    # confirm that the symbol actually exists
    if ! grep -qE \ $1\$ tmp/test.syms; then
        echo "Couldn't find symbol: $1"
        exit 1
    fi
    # make a grievous assumption about readelf's output format
    SYM=`grep -E \ $1\$ tmp/test.syms | cut -b 9-16`
    if [ `echo "$SYM" | wc -c` -ne 9 ] || echo "$SYM" | grep -q '[^0-9A-Fa-f]']; then
        echo "Couldn't seem to parse readelf's output"
        exit 1
    fi
}

for TESTDIR in $TESTDIRS; do
    # I really need to relearn awk
    for TESTSTEM in `ls "$TESTDIR"/src | grep -E '\.S$' | sed -Ee 's/\.S$//'`; do
        echo -ne "$TOTAL_TESTS : -$FAILING_TESTS/+$PASSING_TESTS $TESTSTEM             \r" 1>&2
        SRCPATH="$TESTDIR"/src/"$TESTSTEM".S
        REFPATH="$TESTDIR"/references/"$TESTSTEM".reference_output
        TOTAL_TESTS=$(( $TOTAL_TESTS + 1 ))
        rm -rf tmp
        mkdir tmp
        riscv32-unknown-elf-gcc -march=rv32i -mabi=ilp32 -static -nostdlib -nostartfiles -Iinclude/ -Iriscv-compliance/riscv-test-env/p/ -Iriscv-compliance/riscv-test-env/ "$SRCPATH" -Wl,-Triscv-compliance/riscv-test-env/p/link.ld -o tmp/test.elf
        riscv32-unknown-elf-objcopy -O binary tmp/test.elf tmp/test.bin
        riscv32-unknown-elf-readelf -s tmp/test.elf > tmp/test.syms
        get_sym tohost
        TOHOST="$SYM"
        get_sym begin_signature
        DATASTART="$SYM"
        get_sym end_signature
        DATAEND="$SYM"
        # send the addresses of the tohost, begin_signature, and
        # end_signature symbols, followed by the entire test binary
        ../bin/sim1x_compliance +TESTIMG=tmp/test.bin +SIG_START="$DATASTART" +SIG_END="$DATAEND" +TOHOST="$TOHOST" </dev/null | awk 'BEGIN{RS="^$";ORS="";getline;gsub("\n","\r&");print}' > tmp/output
        if tail -n `wc -l < "$REFPATH"` < tmp/output | cmp -s - "$REFPATH"; then
            PASSING_TESTS=$(( $PASSING_TESTS + 1 ))
        else
            FAILING_TESTS=$(( $FAILING_TESTS + 1 ))
            riscv32-unknown-elf-objdump -D tmp/test.elf | gzip > results/$TESTSTEM.dis.gz
            gzip < tmp/output > results/$TESTSTEM.output.gz
            ../bin/sim1x_compliance +TESTIMG=tmp/test.bin +SIG_START="$DATASTART" +SIG_END="$DATAEND" +TOHOST="$TOHOST" +TRACE=1 </dev/null | gzip > results/$TESTSTEM.trace.gz
        fi
    done
done

echo "Total test count: $TOTAL_TESTS                        "
echo "Pass: $PASSING_TESTS"
echo "Fail: $FAILING_TESTS"

if test $PASSING_TESTS -ne $TOTAL_TESTS; then
    echo "Look inside the 'results' directory for more information on the failing tests."
    exit 1
else
    echo "All tests passed!"
    exit 0
fi
