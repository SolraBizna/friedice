#define putc(reg) sb reg, -16(zero)
#define flush() sb zero, -14(zero)
        
        .section .text.init
_exception_reset:
        // Initialize stack pointer
        la sp, __stacktop
        // Initialize trap vector
        la a0, _exception_trap
        csrrw a0, mtvec
        // Print startup banner
        la a0, _startmsg
        call _putstr
        // Play game
        j _play
_exception_trap:
        // Print an "unexpected trap" message and exit
        la a0, _trapmsg
        call _putstr
        csrr a0, mcause
        bgez a0, 1f
        li t0, 'i'
        putc(t0)
        // Trim off the sign bit
        slli a0, a0, 1
        srli a0, a0, 1
1:      call _putint
        call _linebreak
        li a0, -1
        call _exit

_linebreak:
        la a0, _linebreakstr
        // fall through
_putstr:
        lb t0, 0(a0)
        beqz t0, 1f
        putc(t0)
        addi a0, a0, 1
        j _putstr
1:      ret

_putint:
        // if(a0 < 0)
        bgez a0, 2f
        //   if(a0 >= -2048)
        li t0, -2048
        blt a0, t0, 4f
        //     a0 := ~a0 + 1
        xori a0, a0, -1
        addi a0, a0, 1
        //     putc('-')
        li t0, '-'
        putc(t0)
        //     goto 3
        j 3f
        //   else
        //     goto 4
2:      // else if(a0 < 2049)
        li t0, 2049
        bge a0, t0, 4f
3:      //   ; double dabble!
        //   a0 := a0 << 20
        slli a0, a0, 20
        //   rem := 11
        li t0, 11
        //   res := 0
        li t1, 0
        //   t2,t3,t4,t5 := constants
        li t2, 0x88888888
        li t3, 0x44444444
        li t4, 0x22222222
        li t5, 0x11111111
1:      //   do
        //     rem -= 1
        addi t0, t0, -1
        //     ; magically add 3 to any BCD digit of res currently >= 5
        and a1, t1, t5
        slli a1, a1, 1
        and a2, t1, t4
        or a1, a1, a2
        and a2, t1, t3
        srli a2, a2, 1
        and a1, a1, a2
        and a2, t1, t2
        srli a2, a2, 2
        or a1, a1, a2
        srli a2, a1, 1
        or a1, a1, a2
        add t1, t1, a1
        //     res := res << 1
        slli t1, t1, 1
        //     if(a0 < 0)
        bgez a0, 2f
        //       res += 1
        addi t1, t1, 1
2:      //     a0 := a0 << 1
        slli a0, a0, 1
        //   while rem >= 0
        bgez t0, 1b
        //   a0 := res
        move a0, t1
        //   shift = 12
        li t1, 12
        //   while(shift > 0 && (a0 >> shift) == 0)
1:      srl t0, a0, t1
        bnez t0, 1f
        //     shift -= 4
        addi t1, t1, -4
        bnez t1, 1b
1:      //   ; tail squish :)
        j 1f
4:      // else
        //   ; print as hex!
        //   put("0x")
        li t0, '0'
        putc(t0)
        li t0, 'x'
        putc(t0)
        //   shift := 28
        li t1, 28
        //   hexdigits := _hexdigits
1:      la t3, _hexdigits
1:      //   do
        //     digit := (value >> shift) & 15
        srl t2, a0, t1
        andi t2, t2, 15
        //     digit := hexdigits[digit]
        add t2, t2, t3
        lb t2, 0(t2)
        //     putc(digit)
        putc(t2)
        //     shift -= 4
        addi t1, t1, -4
        //   while shift >= 0
        bgez t1, 1b
        //   return
        ret

_exit:  move a1, a0
        la a0, _exitmsg
        call _putstr
        move a0, a1
        call _putint
        call _linebreak
        sb zero, -15(zero)

        .section .bss
        .align 4
_uhp:           .skip 4
_upotions:      .skip 4
_mhp:           .skip 4
        
        .section .text
_play:  // Initialize the variables
        // we are using magic numbers because Fight! is older than time itself
        li t0, 50
        la t1, _uhp
        sw t0, 0(t1)
        li t0, 3
        la t1, _upotions
        sw t0, 0(t1)
        li t0, 100
        la t1, _mhp
        sw t0, 0(t1)
gameloop:
        // Print status
        la a0, _gamehdr1
        call _putstr
        la a0, _uhp
        lw a0, 0(a0)
        call _putint
        la a0, _gamehdr2
        call _putstr
        la a0, _upotions
        lw a0, 0(a0)
        call _putint
        la a0, _gamehdr3
        call _putstr
        la a0, _mhp
        lw a0, 0(a0)
        call _putint
        la a0, _gamehdr4
        call _putstr
        // Are we dead?
        la a0, _uhp
        lw a0, 0(a0)
        beqz a0, udied
        // Are they dead?
        la a0, _mhp
        lw a0, 0(a0)
        beqz a0, mdied
inputloop:
        call _assertgetc
        // a = attack
        li t0, 'a'
        beq a0, t0, attack
        li t0, 'A'
        beq a0, t0, attack
        // p = potion
        li t0, 'p'
        beq a0, t0, potion
        li t0, 'P'
        beq a0, t0, potion
        // ? = help
        li t0, '?'
        beq a0, t0, help
        j inputloop
attack: la a0, _uattackmsg
        call _putstr
        la t1, _mhp
        lw t0, 0(t1)
        addi t0, t0, -10
        sw t0, 0(t1)
        // fall through
mattack:la a0, _mattackmsg
        call _putstr
        la t1, _uhp
        lw t0, 0(t1)
        addi t0, t0, -10
        sw t0, 0(t1)
        j gameloop
potion: la t1, _upotions
        lw t0, 0(t1)
        beqz t0, 1f
        addi t0, t0, -1
        sw t0, 0(t1)
        la a0, _upotmsg
        call _putstr
        la t1, _uhp
        lw t0, 0(t1)
        addi t0, t0, 30
        slti t2, t0, 51
        bnez t2, 2f
        li t0, 50
2:      sw t0, 0(t1)
        bnez t2, mattack
        la a0, _uwastemsg
        call _putstr
        j mattack
1:      la a0, _unopotmsg
        call _putstr
        j gameloop
help:   la a0, _helpmsg
        call _putstr
        j gameloop
udied:  la a0, _udiedmsg
        call _putstr
        j playagain
mdied:  la a0, _mdiedmsg
        call _putstr
playagain:
        la a0, _playagainmsg
        call _putstr
1:      call _assertgetc
        // y = hai
        li t0, 'y'
        beq a0, t0, hai
        li t0, 'Y'
        beq a0, t0, hai
        // n = iie
        li t0, 'n'
        beq a0, t0, iie
        li t0, 'N'
        beq a0, t0, iie
        j 1b
hai:    j _play
iie:    // Done
        li a0, 0
        call _exit
        
_assertgetc:
        lw a0, -16(zero)
        bltz a0, 1f
        ret
1:      li a0, -3
        j _exit
        
        .section .data.string
_hexdigits:     .ascii "0123456789abcdef"
_linebreakstr:  .string "\n"
_trapmsg:       .string "Unexpected trap. mcause="
_startmsg:      .string "Welcome to Fight!\nFor information on how to play, type ?\n"
_gamehdr1:      .string "\nYou have: "
_gamehdr2:      .string "/50 HP, "
_gamehdr3:      .string "/3 potions\nThey have: "
_gamehdr4:      .string "/100 HP\n"
_exitmsg:       .string "Exit status: "
_uattackmsg:    .string "You attack, dealing 10 damage!\n"
_upotmsg:       .string "You drink a potion, healing 30 HP.\n"
_mattackmsg:    .string "They attack, dealing 10 damage!\n"
_uwastemsg:     .string "Some of that healing was wasted!\n"
_unopotmsg:     .string "You don't have any potions to drink.\n"
_helpmsg:       .string "Type 'a' to attack or 'p' to drink a potion.\nEvery time you make a move, your opponent will attack.\nAttacks always deal 10 damage.\nA potion heals you for 30 HP, but can't heal you above 50 HP. Don't waste it!\nYou win if you reduce your opponent to 0 HP without being reduced to 0\nyourself. Be careful, your opponent will be able to attack one last time!\n"
_playagainmsg:  .string "\nPlay again? y/n\n"
_udiedmsg:      .string "You perished...\n"
_mdiedmsg:      .string "You are victorious!\n"
