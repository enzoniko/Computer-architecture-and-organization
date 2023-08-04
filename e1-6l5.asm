.data 
	STRING: .asciiz "        "
.text
main:
	li $v0, 8
	la $s0, STRING
	move $a0, $s0
	li $a1, 8
	syscall
	
	move $t0, $zero
	move $t1, $zero
	
loop:	
	add $t2, $t0, $s0
	lb $t3, 0($t2)
	addi $t0, $t0, 1
	bne $t3, 0x61, nA 
	addi $t1, $t1, 1	
nA:	
	bne $t3, 0x00, loop 
	