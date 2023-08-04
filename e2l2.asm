.text
	addi $t0, $zero, 1
	addi $t1, $zero, 1
loop: addi $t0, $t0, 1
	mul $t1, $t1, $t0  
	bne $t0, 5, loop
	