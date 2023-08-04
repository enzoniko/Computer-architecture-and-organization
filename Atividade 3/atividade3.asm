# Déborah Raquel Bussolo Ferreira - 22103732
# Enzo Nicolás Spotorno Bieger - 22100614

.data 
	matriz: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		      
		      
.text
	# Value
	li $s0, 0
	
	# row
	li $s1, 0
	
	# endereço Matriz
	la $s3, matriz
	
loopRow:

	# col
	li $s2, 0		
loopCol:
	
	# row * 16
	mul $t0, $s1, 16
	
	# (row * 16) + col
	add $t0, $t0, $s2
	
	# ((row * 16) + col) * 4 = deslocamento
	mul $t0, $t0, 4
	
	# (((row * 16) + col) * 4) + endereço base
	add $t0, $t0, $s3
	
	# Guarda o valor na memória no endereço calculado
	sw $s0, 0($t0)
	
	# Value ++
	addi $s0, $s0, 1
	
	# col ++
	addi $s2, $s2, 1
	
	# Volta pro loop de coluna enquanto col != 16
	bne $s2, 16, loopCol
	
	# row ++
	addi $s1, $s1, 1
	
	# Quando row == 16, sai dos loops
	beq $s1, 16, Exit
	
	# Se não, volta pro loop da linha
	j loopRow
Exit:
	
	
	
