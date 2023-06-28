main:
        # printf("Enter a number: );
        li      $v0, 4
        la      $a0, phrase
        syscall
        jr $ra
phrase:
    .asciiz "Well, this was a MIPStake!\n"