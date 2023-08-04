.data
	FRASE_1: .asciiz "Digite a base: "
	FRASE_2: .asciiz "Digite o expoente: "
	FRASE_3: .asciiz "O resultado foi: "
	base: .word 0
	expoente: .word 0
	resultado: .word 0
	
.text
main: 
	# L� e guarda a base na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_1		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t0, base # Armazena o ENDERE�O da base em $t0
	move    $s0, $v0 # Inteiro lido (base) � salvo em $s0.
	sw $s0, 0($t0) # Armazena a base na mem�ria
	
	# L� e guarda o expoente na mem�ria
	li $v0, 4 # Comando para printar a frase
	la $a0, FRASE_2		
	syscall
	
	li $v0, 5 # Comando para ler inteiro.
	syscall
	la $t1, expoente # Armazena o ENDERE�O do expoente em $t1
	move    $s1, $v0 # Inteiro lido (expoente) � salvo em $s1.
	sw $s1, 0($t1) # Armazena o expoente na mem�ria
		
	# Carrega os argumentos
	move $a0, $s0 # $a0 <- base
	move $a1, $s1 # $a1 <- expoente
		
	# Carrega o endere�o do resultado em $s2
	la $s2, resultado
	
	# Chama o procedimento calcula
	jal pow
	
	# Salva o retorno $v0 do procedimento pow no endere�o de f
	sw $v0, 0($s2)  
	
	# Printa o resultado na tela....
	li	$v0, 4			# Comando pra printar a frase
	la	$a0, FRASE_3		
	syscall 
	
	lw	$t1, 0($s2)	
	li	$v0, 1			# Comando pra printar o valor
	move	$a0, $t1		
	syscall 
	
end:
	j end
pow:
	
	# PUSH
	# Guarda tudo que vou modificar
	addi $sp, $sp, -12 # Decrementa $sp em 3 palavras
	sw $t0, 8($sp) # Salva $t0 na pilha
	sw $t1, 4($sp) # Salva $t1 na pilha
	sw $s0, 0($sp) # Salva $s0 na pilha

	# Realiza o c�lculo da pot�ncia
	# Inicia res = 1 ($t0 vai ser o acumulador res, que acumula as multiplica��es)
	li $t0, 1
	# Inicia i = 0 ($t1 vai ser o contador do loop)
	li $t1, 0
loop:
	mul $t0, $t0, $a0
	addi $t1, $t1, 1
	bne $t1, $a1, loop
	
	# Retorna o resultado
	move $v0, $t0
	
	# POP
	# Devolve tudo que usei, $ra tbm
	lw $t0, 8($sp) # Carrega $t0 da pilha
	lw $t1, 4($sp) # Carrega $t1 da pilha
	lw $s0, 0($sp) # Carrega $s0 da pilha
	addi $sp, $sp, 12 # Incrementa $sp em 3 palavras
	
	# Retorna pro chamador usando $ra
	jr $ra
	
	
