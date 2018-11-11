OUTPUT_ARCH(riscv)
MEMORY {
       RAM (rwx): ORIGIN = 0, LENGTH = 0xFFFFF4
}

__stacktop = 0xFFFFF800;
__reg_io = 0xFFFFFFF0;
__reg_exit = 0xFFFFFFF1;

SECTIONS {
         .text : {
               KEEP(*(.text.init))
               *(.text .text.* .gnu.linkonce.t.*)
               *(.rodata .rodata.* .gnu.linkonce.r.*)
               *(.bss .bss.* .gnu.linkonce.b.*)
         } >RAM
}
