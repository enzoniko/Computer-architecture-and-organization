# Déborah Raquel Bussolo
# Enzo Nicolás Spotorno Bieger

# Atividade 05-1)

.data
	max: .word 32 # Tamanho das linhas e colunas
	A: .float 0:1024 # Só colocar o tamanho total da matriz aqui (max*max).
	B: .float 0:1024 # Só colocar o tamanho total da matriz aqui (max*max).
	
.text

	
	lw $s4, max # Carrega o valor do tamanho das linhas e colunas
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

# Fazendo o algoritmo que multiplica a Matriz A pela transposta de B

 	move $s0, $zero # Inicializa I com zero 
LoopI:
	move $s1, $zero # Inicializa J com zero

LoopJ:
	# Calcula o endereço (i, j) da matriz A
	mul $t0, $s0, $s4 # Multiplica I pelo número de colunas (max) e guarda em $t0
	add $t0, $t0, $s1 # Adiciona J na multiplicação anterior e guarda em $t0
	sll $t0, $t0, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t0, $s2, $t0 # Adiciona o incremento calculado no endereço base de A
	
	lw $t1, 0($t0) # Guarda o valor do endereço (i, j) da matriz A em $t1
	
	# Calcula o endereço (j, i) da matriz B
	mul $t2, $s1, $s4 # Multiplica J pelo número de colunas (max) e guarda em $t2
	add $t2, $t2, $s0 # Adiciona I na multiplicação anterior e guarda em $t2
	sll $t2, $t2, 2 # Desloca o resultado anterior 2 bits para a esquerda, multiplicando-o por 4
	add $t2, $s3, $t2 # Adiciona o incremento calculado no endereço base de B
	
	lw $t3, 0($t2) # Guarda o valor do endereço (j, i) da matriz B em $t3
	
	add $t4, $t3, $t1 # Soma A[i, j] e B[j, i] e guarda em $t4
	sw $t4, 0($t0) # Armazena o valor de $t4 no endereço (i, j) da matriz A
	
	addi $s1, $s1, 1 # Incrementa J em 1
	
	bne $s1, $s4, LoopJ # Se J != max vai pro LoopJ
	
	addi $s0, $s0, 1 # Incrementa I em 1
	
	bne $s0, $s4, LoopI # Se I != max vai pro LoopI
	
	j Exit
	
Exit: