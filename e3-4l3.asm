.text
	li $s0, 0x10010020 # Endere�o base do vetor
	li $s1, 0 # Inicializa i = 0
	
	li $t0, 1 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 3 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 2 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 1 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 4 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor
	
	addi $s1, $s1, 1 # Incrementa i
	li $t0, 5 # Valor para colocar no vetor
	mul $t1, $s1, 4 # Multiplica o �ndice por 4
	add $t1, $s0, $t1 # Soma o deslocamento no endere�o base do vetor 
	sw $t0, 0($t1) # Guarda o valor na posi��o calculada no vetor