.text
	li $v0, 5 # Comando para ler inteiro
	syscall # Lê o inteiro
	move $a0, $v0 # Move o inteiro lido para $a0 para ser argumento da função fatorial
	jal fatorial # Chama a função fatorial
	
	move $a0, $v0 # Move o resultado retornado para $a0 para ser printado na tela
	li $v0, 1 # Comando para printar inteiro
	syscall # Printa o resultado na tela
	
	j Exit # Vai pro fim
fatorial:
	# Push
	addi $sp, $sp, -8 # Decrementa $sp em 2 palavras
	sw $ra, 0($sp) # Guarda o $ra na pilha
	sw $a0, 4($sp) # Guarda o $a0 na pilha
	
	# Função
	addi $t0, $a0, 1 
	blt $a0, 1, if # Vai pra if se $a0 < 1 (n < 1)
	
	subi $a0, $a0, 1 # $a0 recebe $a0 - 1
	jal fatorial # Chama a função fatorial em $a0 (n - 1) que coloca seu retorno em $v0
	
	# Pop
	addi $sp, $sp, 8 # Incrementa $sp em 2 palavras
	lw $ra, 0($sp) # Pega o $ra da pilha
	lw $a0, 4($sp) # Pega o $a0 da pilha
	
	mul $v0, $v0, $a0 # Carrega o registrador de retorno com n*fatorial(n-1)
	
	jr $ra # VOlta pro chamador
if:
	li $v0, 1 # Carrega o registrador de retorno com 1
	
	# Pop
	addi $sp, $sp, 8 # Incrementa $sp em 2 palavras
	lw $ra, 0($sp) # Pega o $ra da pilha
	lw $a0, 4($sp) # Pega o $a0 da pilha
	
	jr $ra # Volta pro chamador

	
Exit:
	
	
