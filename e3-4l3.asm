.text
	li $s0, 0x10010020 # Endereço base do vetor
	li $s1, 0 # Inicializa i = 0
	
	li $t0, 1 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 3 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 2 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 1 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 4 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 5 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o índice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endereço base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posição calculada no vetor