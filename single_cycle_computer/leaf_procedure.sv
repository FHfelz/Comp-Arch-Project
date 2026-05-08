// By Ishmam Raiyan and Fatin Hoque

main:
    addi $a0, $zero, 4
    jal square
    nop
 
square:
    mul  $v0, $a0, $a0
    jr   $ra
