# Déborah Raquel Bussolo Ferreira
# Enzo Nicolás Spotorno Bieger

# Atividade 5-2)


.data
	max: .word 10 # Tamanho das linhas e colunas
	block_size: .word 5 # BLock_size para blocking_cache
	A: .float 0:100 # Só colocar o tamanho total da matriz aqui (max*max).
	B: .float 0:10 # Só colocar o tamanho total da matriz aqui (max*max).
	
.text

	
	lw $s4, max # Carrega o valor do tamanho das linhas e colunas
	lw $s5, block_size # Carrega o valor do Block_size
	la $s2, A # Guarda o endereço base de A em $s2
	la $s3, B # Guarda o endereço base de B em $s3
	
	
# Preenchendo a Matriz A

	move $s0, $zero # Inicializa I com zero
AI:
	move $s1, $zero # Inicializa J com zero

AJ:
	# Calcula o endereço (i, j) da matriz A
	mul $t0, $s0, $s4 # Multiplica I pelo número de colunas (max) e guarda em $t0
	add $t0, $t0, $s1 # Adiciona J na multiplicação anterior e guarda em $t0
	sll $t0, $t0, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t0, $s2, $t0 # Adiciona o incremento calculado no endereço base de A
	
	add $t4, $s0, $s1 # Soma i e j e guarda em $t4
	sw $t4, 0($t0) # Armazena o valor de $t4 no endereço (i, j) da matriz A
	
	addi $s1, $s1, 1 # Incrementa J em 1
	
	bne $s1, $s4, AJ # Se J != max vai pro AJ
	
	addi $s0, $s0, 1 # Incrementa I em 1
	
	bne $s0, $s4, AI # Se I != max vai pro AI
	
# Preenchendo a Matriz B

	move $s0, $zero # Inicializa I com zero
	
BI:
	move $s1, $zero # Inicializa J com zero

BJ:
	# Calcula o endereço (i, j) da matriz b
	mul $t0, $s0, $s4 # Multiplica I pelo número de colunas (max) e guarda em $t0
	add $t0, $t0, $s1 # Adiciona J na multiplicação anterior e guarda em $t0
	sll $t0, $t0, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t0, $s3, $t0 # Adiciona o incremento calculado no endereço base de B
	
	add $t4, $s0, $s1 # Soma i e j e guarda em $t4
	sw $t4, 0($t0) # Armazena o valor de $t4 no endereço (i, j) da matriz b
	
	addi $s1, $s1, 1 # Incrementa J em 1
	
	bne $s1, $s4, BJ # Se J != max vai pro BJ
	
	addi $s0, $s0, 1 # Incrementa I em 1
	
	bne $s0, $s4, BI # Se I != max vai pro BI

# Fazendo o algoritmo que multiplica a Matriz A pela transposta de B com blocking_cache

 	move $s0, $zero # Inicializa I com zero 
LoopI:
	move $s1, $zero # Inicializa J com zero
LoopJ:
	move $s6, $s0 # Inicializa II com I
LoopII:
	move $s7, $s1 # Inicializa JJ com J
LoopJJ:

	# Calcula o endereço (ii, jj) da matriz A
	mul $t0, $s6, $s4 # Multiplica II pelo número de colunas (max) e guarda em $t0
	add $t0, $t0, $s7 # Adiciona JJ na multiplicação anterior e guarda em $t0
	sll $t0, $t0, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t0, $s2, $t0 # Adiciona o incremento calculado no endereço base de A
	
	lw $t1, 0($t0) # Guarda o valor do endereço (ii, jj) da matriz A em $t1
	
	# Calcula o endereço (jj, ii) da matriz B
	mul $t2, $s7, $s4 # Multiplica JJ pelo número de colunas (max) e guarda em $t2
	add $t2, $t2, $s6 # Adiciona II na multiplicação anterior e guarda em $t2
	sll $t2, $t2, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t2, $s3, $t2 # Adiciona o incremento calculado no endereço base de B
	
	lw $t3, 0($t2) # Guarda o valor do endereço (jj, ii) da matriz B em $t3
	
	add $t4, $t3, $t1 # Soma A[ii, jj] e B[jj, ii] e guarda em $t4
	sw $t4, 0($t0) # Armazena o valor de $t4 no endereço (ii, jj) da matriz A
	
	addi $s7, $s7, 1 # Incrementa JJ em 1
	
	add $t5, $s1, $s5 # Adiciona J e block_size e coloca em $t5
	
	bne $s7, $t5, LoopJJ # Se JJ != J + block_size vai pro LoopJJ
	
	addi $s6, $s6, 1 # Incrementa II em 1
	
	add $t6, $s0, $s5 # Adiciona I e block_size e coloca em $t6
	
	bne $s6, $t6, LoopII # Se II != I + block_size vai pro LoopII
	
	add $s1, $s1, $s5 # Incrementa J em block_size
	
	bne $s1, $s4, LoopJ # Se J != max vai pro LoopJ
	
	add $s0, $s0, $s5  # Incrementa I em block_size
	
	bne $s0, $s4, LoopI # Se I != max vai pro LoopI
	
	j Exit
	
Exit:
