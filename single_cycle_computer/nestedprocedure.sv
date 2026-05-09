//IR FH

main:
    addi $a0, $zero, 6
    jal outer
    nop
 
outer:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
 
    jal inner
    nop
 
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
 
inner:
    addi $v0, $zero, 99
    jr   $ra
