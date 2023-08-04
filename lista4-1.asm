.data
	FRASE_1: .asciiz "Digite um n�mero: "
	g: .word 0
	h: .word 0
	i: .word 0
	j: .word 0
	f: .word 0
	
.text
main: 
	# L� e guarda g na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_1		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t0, g # Armazena o ENDERE�O de g em $t0
	move    $s0, $v0 # Inteiro lido (g) � salvo em $s0.
	sw $s0, 0($t0) # Armazena g na mem�ria
	
	# L� e guarda h na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_1		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t1, h # Armazena o ENDERE�O de h em $t1
	move    $s1, $v0 # Inteiro lido (h) � salvo em $s1.
	sw $s1, 0($t1) # Armazena h na mem�ria
	
	# L� e guarda i na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_1		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t2, i # Armazena o ENDERE�O de i em $t2
	move    $s2, $v0 # Inteiro lido (i) � salvo em $s2.
	sw $s2, 0($t2) # Armazena i na mem�ria
	
	# L� e guarda j na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_1		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t3, j # Armazena o ENDERE�O de j em $t3
	move    $s3, $v0 # Inteiro lido (j) � salvo em $s3.
	sw $s3, 0($t3) # Armazena j na mem�ria
	
	# Carrega os argumentos
	move $a0, $s0 # $a0 <- g
	move $a1, $s1 # $a1 <- h
	move $a2, $s2 # $a2 <- i
	move $a3, $s3 # $a3 <- j
	
	# Carrega o endere�o de f em $s4
	la $s4, f
	# Chama o procedimento calcula
	jal calcula
	
	# Salva o retorno $v0 do procedimento calcula no endere�o de f
	sw $v0, 0($s4)  
	
end:
	j end
calcula:
	
	# PUSH
	# Guarda tudo que vou modificar, $ra tbm
	addi $sp, $sp, -12 # Decrementa $sp em 3 palavras
	sw $t0, 8($sp) # Salva $t0 na pilha
	sw $t1, 4($sp) # Salva $t1 na pilha
	sw $s0, 0($sp) # Salva $s0 na pilha

	# Realiza o c�lculo
	add $t0, $a0, $a1
	add $t1, $a2, $a3
	sub $s0, $t0, $t1
	move $v0, $s0 
	
	# POP
	# Devolve tudo que usei, $ra tbm
	lw $t0, 8($sp) # Carrega $t0 da pilha
	lw $t1, 4($sp) # Carrega $t1 da pilha
	lw $s0, 0($sp) # Carrega $s0 da pilha
	addi $sp, $sp, 12 # Incrementa $sp em 3 palavras
	
	# Retorna pro chamador usando $ra
	jr $ra
	
	
