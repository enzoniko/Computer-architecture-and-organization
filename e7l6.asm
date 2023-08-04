.data
	NUM: .word 0
	newline: .asciiz "\n"
	A: .double 0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	    	   0 0 0 0 0 0 0 0 0 0
	
.text

main:
	la $t3, NUM # Pega o endereço de NUM
	li $s0, 10 # Carrega $s0 com 10
	sw $s0, 0($t3) # Armazena em NUM 10
	
	la $s1, A # Carrega o endereço base de A
	
	li $t0, 0 # i
	li $t1, 0 # j
	
	move $a0, $s0 # Passa $s0 como argumento pra função
	jal init # Chama a função init
	
	la $s2, newline # Carrega o endereço base da quebra de linha

forI:
	
	li $t1, 0 # Zera j
forJ:
	mul $t4, $t0, $s0 # $t4 recebe i*10
	add $t4, $t4, $t1 # $t4 recebe i*10 + j
	mul $t4, $t4, 8 # Multiplica $t4 por 8 (pois é double) para obtermos o deslocamento
	add $t5, $t4, $s1 # Calculca o endereço do elemento A[i][j] 
	ldc1 $f12, 0($t5) # Carrega o elemento da memória e o coloca em #f12 para ser printado
	 
	li $v0, 3 # Comando para printar double
	syscall # Printa o elemento A[i][j]
	
	li $v0, 4 # Comando para printar string
	move $a0, $s2 # Move o endereço da quebra de linha para $a0 para ser argumento do comando
	syscall # Quebra a linha
	
	addi $t1, $t1, 1 # Incrementa j
	bne $t1, $s0, forJ # Enquanto j != 10 (não tivermos feito o loopJ 10 vezes) faz o loopJ
	
	addi $t0, $t0, 1 # Incrementa i
	bne $t0, $s0, forI # Enquanto i != 10 (não tivermos feito o loopI 10 vezes) faz o loopI
	
	j exit # Vai pro fim do programa
init:
	#PUSH
	addi $sp, $sp, -8 # Decrementa $sp em 2 palavras
	sw $t0, 0($sp) # Guarda $t0 na pilha
	sw $t1, 4($sp) # Guarda $t1 na pilha
	
	# Função
forIinit:
	
	li $t1, 0 # Zera j
forJinit:
	mul $t4, $t0, $s0 # $t4 recebe i*10
	add $t4, $t4, $t1 # $t4 recebe i*10 + j
	mul $t4, $t4, 8 # Multiplica $t4 por 8 (pois é double) para obtermos o deslocamento
	add $t5, $t4, $s1 # Calculca o endereço do elemento A[i][j]
	
	add $t6, $t0, $t1 # Calcula i + j
	mtc1 $t6, $f0 # Move o i + j para $f0
	cvt.d.w $f0, $f0 # Converte o valor em $f0 pra double
	s.d $f0, 0($t5) # A[i][j] = i + j
		 
	addi $t1, $t1, 1 # Incrementa j
	bne $t1, $s0, forJinit # Enquanto j != 10 (não tivermos feito o loopJ 10 vezes) faz o loopJ
	
	addi $t0, $t0, 1 # Incrementa i
	bne $t0, $s0, forIinit # Enquanto i != 10 (não tivermos feito o loopI 10 vezes) faz o loopI
	
	#POP
	lw $t0, 0($sp) # Recupera $t0 da pilha
	lw $t1, 4($sp) # Recupera $t1 da pilha
	addi $sp, $sp, 8 # Incrementa $sp em 2 palavras
	jr $ra

exit:
		   
		   
