.data
	a: .word 0
	b: .word 0
	
.text
	li $v0, 5 # Comando para ler inteiro
	syscall # Lê o primeiro inteiro 
	sw $v0, a # O guarda em a
	
	li $v0, 5 # Comando para ler inteiro
	syscall # Lê o segundo inteiro 
	sw $v0, b # O guarda em b
	
	lw $s0, a # Guarda a no reg $s0
	lw $s1, b # Guarda b no reg $s1
	
	sgt $t0, $s0, $s1 # Bota 1 em $t0 se a > b
	bne $t0, $zero, ifA # Se a > b vai pro ifA
	
	
ifA:
	addi $s0, $s0, 1 # Incrementa a
	sw $s0, a # Guarda o novo valor de a na memória
	
	
	sge $t1, $s0, $s1 # Bota 1 em $t1 se a >= b
	bne $t1, $zero, ifB # Se a >= b vai pro ifB

ifB:
	addi $s1, $s1, 1 # Incrementa b
	sw $s1, b # Guarda o novo valor de b na memória

 	sle $t2, $s0, $s1 # Bota 1 em $t2 se a <= b
 	bne $t2, $zero, ifC # Se a <= b vai pro ifC
 
ifC:
	addi $s0, $s0, 1 # Incrementa a
	sw $s0, a # Guarda o novo valor de a na memória
	
	beq $s0, $s1, ifD # Vai pro ifD se a == b

 ifD:
 
 	move $s1, $s0 # b = a?????
 	sw $s1, b # Guarda o novo valor de b na memória
 	
 	slt $t3, $s0, $s1 # Bota 1 em $t3 se a < b
 	bne $t3, 1, else # Vai pro else se a >= b
 	j ifB # Vai pro ifA se a < b
else: 	j ifB # Senão Vai pro ifB    


	

	
	