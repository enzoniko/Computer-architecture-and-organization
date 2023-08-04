.data
	primeiro: .asciiz "\n Digite o valor do primeiro numero: "
	segundo: .asciiz "\n Digite o valor do segundo numero: "
	resultado: .asciiz "\n O resultado da soma é: "
.text
	li $s0, 0 # n1
	li $s1, 0 # n2
main:
	move $a0, $s0 # Argumento 0 é o n1
	move $a1, $s1 # Argumento 1 é o n2
	jal soma # Chama a função soma com os argumentos a0 e a1
	
	
	
	move $a0, $s0 # Argumento 0 é o n1
	move $a1, $s1 # Argumento 1 é o n2
	
	jal soma # Chama a função soma com os argumentos a0 e a1
	
	move $t0, $v0 # Move o retorno da função pro registrado $t0 temporariamente
	
	li $v0, 4 # Comando para printar string
	la $a0, resultado # Carrega $a0 com o endereço da string de resultado
	syscall # Printa a string de resultado
	
	move $a0, $t0 # Move o retorno da função para $a0 para ser printado
	li $v0, 1 # Comando pra printar inteiro
	syscall # Printa o retorno da função
	
	li $v0, 0 # "Retorna 0" ao finalizar a main
	j Exit # Vai pro fim
soma:
	# push
	addi $sp, $sp, -12 # Decrementa a pilha em 3 palavra
	sw $ra, 0($sp) # Guarda $ra na pilha
	sw $a0, 4($sp) # Guarda $a0 na pilha
	sw $a1, 8($sp) # Guarda $a1 na pilha
	
	# função
	jal leitura # Chama a função leitura
	
	# pop
	lw $ra, 0($sp) # Pega $ra da pilha
	lw $a0, 4($sp) # Pega $a0 da pilha
	lw $a1, 8($sp) # Pega $a1 da pilha
	addi $sp, $sp, 12 # Incremenenta a pilha em 3 palavras
	
	add $v0, $a0, $a1 # Soma os argumentos LOCAIS e os retorna
	
	# Volta pro chamador
	jr $ra

leitura:
	li $v0, 4 # Comando para printar string
	la $a0, primeiro # Carrega $a0 com o endereço da primeira string
	syscall # Printa a primeira string
	
	li $v0, 5 # Comando para ler inteiro
	syscall # Lê inteiro
	move $s0, $v0 # Move o valor lido para $s0 (n1)
	
	li $v0, 4 # Comando para printar string
	la $a0, segundo # Carrega $a0 com o endereço da segunda string
	syscall # Printa a segunda string
	
	li $v0, 5 # Comando para ler inteiro
	syscall # Lê inteiro
	move $s1, $v0 # Move o valor lido para $s1 (n2)
	
	jr $ra # Retorna para o chamador

Exit: