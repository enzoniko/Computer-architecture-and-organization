.data
	area: .word 0
.text

	jal main
	
end:
	j end
	
main:
	# PUSH
	addi $sp, $sp, -12 # Abre espaço pra 3 words na pilha ($a0, $a1, $ra)
	sw $a0, 8($sp)
	sw $a1, 4($sp)
	sw $ra, 0($sp)
	
	# Carrega $a0 com a altura e $a1 com a largura
	li $a0, 4
	li $a1, 10
	
	# Carrega o endereço de area
	la $s0, area
	
	# Chama o procedimento que calcula a área do quadrado
	jal calcula_area_quadrado
	
	# Armazena a área calculada $v0 no endereço da área na memoria
	sw $v0, 0($s0)
	
	# POP
	lw $a0, 8($sp)
	lw $a1, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12 # Tira o espaço de 3 words na pilha ($a0, $a1, $ra)
	
	# Retorna pro chamador do procedimento main
	jr $ra


calcula_area_quadrado:
	
	# PUSH
	addi $sp, $sp, -8 # Abre o espaço pra 2 words na pilha ($ra, $s0)
	sw $ra, 4($sp)
	sw $s0, 0($sp)
	
	# Calcula a area do quadrado usando os argumentos $a0 e $a1
	mul $s0, $a0, $a1
	
	# Move o resultado para o registrador de retorno $v0
	move $v0, $s0
	
	# POP
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 8 # tira o espaço de 2 words na pilha ($ra, $s0)
	
	# Retorna pro chamador do procedimento calcula_area_quadrado
	jr $ra