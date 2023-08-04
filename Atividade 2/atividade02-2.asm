.data
	
	A: .word 1 2 3 # Inicializa a matriz A
	    .word 0 1 4
	    .word 0 0 1
	
	
	B: .word 1 -2 5 # Inicializa a matriz B
	    .word 0 1 -4
	    .word 0 0 1
	
	
	C: .word 0 0 0 # Inicializa a matriz C
	    .word 0 0 0
	    .word 0 0 0
	
	.align 2
	STRING: .space 36
	fout: .asciiz "array.txt"

.text
	la $s0, A # Carrega o ENDEREÇO BASE da matriz A -> $s0
	la $s1, B # Carrega o ENDEREÇO BASE da matriz B -> $s1
	la $s2, C # Carrega o ENDEREÇO BASE da matriz C -> $s2
	
	# ----- O código abaixo abre um arquivo para ser escrito. -----
	#
	li	$v0, 13			# Comando para abrir novo arquivo.
	la	$a0, fout		# Carrega o nome do arquivo a ser aberto.
	li	$a1, 1			# Aberto para escrita (0: lêr; 1: escrever).
	li	$a2, 0			# Modo ignorado (neste caso).
	syscall				# Chamada de sistema. Descritor do arquivo é colocado em $v0.
	move	$s6, $v0		# Salva descritor do arquivo para uso no fechamento posterior.
	
	move $s3, $zero # Inicializa o registrador do i -> $s3
loopI: # Loop i -> 0:2
	move $s4, $zero # Zera o registrador do k -> $s4
loopK: # Loop k -> 0:2
	move $s5, $zero # Zera o registrador do j -> $s5
loopJ: # Loop j -> 0:2

	# Deslocamento para Cik -> $t0
	mul $t0, $s3, 3 # i * 3 -> $t0
	add $t0, $t0, $s4 # i * 3 + k -> $t0
	mul $t0, $t0, 4 # 4*(i * 3 + k) -> $t0
	
	add $t0, $s2, $t0 # Endereço para Cik -> $t0
	
	# Deslocamento para Aij -> $t1
	mul $t1, $s3, 3 # i * 3 -> $t1
	add $t1, $t1, $s5 # i * 3 + j -> $t1
	mul $t1, $t1, 4 # 4*(i * 3 + j) -> $t1
	
	add $t1, $s0, $t1 # Endereço para Aij -> $t1
	
	# Deslocamento para Bjk -> $t2
	mul $t2, $s5, 3 # j * 3 -> $t2
	add $t2, $t2, $s4 # j * 3 + k -> $t2
	mul $t2, $t2, 4 # 4*(j * 3 + k) -> $t2
	
	add $t2, $s1, $t2 # Endereço para Bjk -> $t2
	
	lw $t3, 0($t1) # Carrega Aij em um registrador -> $t3
	lw $t4, 0($t2) # Carrega Bjk em um registrador -> $t4
	lw $t5, 0($t0) # Carrega Cik em um registrador -> $t5
	
	mul $t3, $t3, $t4 # Aij * Bjk -> $t3
	add $t3, $t5, $t3 # Adiciona Aij * Bjk em Cik -> $t3
	sw $t3, 0($t0) # Armazena o novo valor de Cik no endereço de Cik 
	
	addi $s5, $s5, 1 # Incrementa j
	bne $s5, 3, loopJ # Enquanto j != 2 volta pro loopJ
	
	addi $s4, $s4, 1 # Incrementa k
	bne $s4, 3, loopK # Enquanto k != 2 volta pro loopK
	
	addi $s3, $s3, 1 # Incrementa i
	bne $s3, 3, loopI # Enquanto i != 2 volta pro loopI
	
	
	# Código para passar a matriz para a STRING
	move $t6, $s2 # Bota o endereço de C em $t6
	la $t7, STRING # Bota o endereço da STRING em $t7
	move $t8, $zero # Zera $t8 pra usar pra contar iterações
loopT:
	lw $t9,  0($t6) # Carrega o valor da matriz C em $t9
	addi $t9, $t9, 48 # Soma 48 no valor da matriz C pra ficar conforme a tabela ascii
	sw $t9, 0($t7) # Armazena o valor de $t9 na STRING
	addi $t6, $t6, 4 # Incrementa o endereço do elemento da matriz em 4 
	addi $t7, $t7, 4 # Incrementa o endereço do elemento da STRING em 4
	addi $t8, $t8, 1 # Incrementa o contador de iterações em 1
	bne $t8, 10, loopT # Enquanto não fizermos 9 iterações fica voltando no loopT
	
	
	# ----- Salva o buffer STRING no arquivo que foi aberto anteriormente. -----
	# 		
	li	$v0, 15			# Comando para escrever no arquivo.
	move	$a0, $s6		# Passa o descritor do arquivo previamente salvo.
	la	$a1, STRING		# Passa endereço base do buffer a ser salvo.
	li	$a2, 36			# Delimita tamanho do buffer a ser escrito.
	syscall				# Chamada de sistema. Escreve buffer no arquivo.
	
	
	# ----- Após transferir o buffer para o arquvio, o código abaixo fecha o arquivo com uma chamada no SO. -----
	# 	
	li	$v0, 16			# Comando para fechamento do arquivo.
	move	$a0, $s6		# Passa o descritor do arquivo que será fechado.
	syscall				# Arquivo é fechado pelo Sistema Operacional.
	
	
	




	
	
	
