.data
	# Armazena as varíáveis na memória
	A: .word 1 2 3
	B: .word 2 3 4
	C: .word 3 4 5
	D: .word 4 5 6
	E: .word 5 6 7
	F: .word 6 7 8

.text
principal:
	# Carrega o ENDEREÇO das variáveis nos registradores
	la $s0, A 
	la $s1, B
	la $s2, C
	la $s3, D
	la $s4, E
	la $s5, F
	
	# Carrega o VALOR dos endereços nos registradores temporários
	lw $t0, 0($s0) # A
	lw $t1, 0($s1) # B
	lw $t2, 0($s2) # C
	lw $t3, 0($s3) # D
	lw $t4, 0($s4) # E
	lw $t5, 0($s5) # F
	
	# a) A = B - C
	sub $t0, $t1, $t2
	sw $t0, 0($s0)
	
	# b) D = (A + B - C)
	add $t3, $t0, $t1
	sub $t3, $t3, $t2
	sw $t3, 0($s3)
	
	 # c) F = (A + B) – D
	 add $t5, $t0, $t1
	 sub $t5, $t5, $t3
	 sw $t5, 0($s5)
	 
	 # d) C = A – (B + D)
	 add $t6, $t1, $t3
	 sub $t2, $t0, $t6
	 sw $t2, 0($s2)
	 
	 # e) E = (A – (B – C) + F)
	 sub $t6, $t1, $t2
	 sub $t6, $t0, $t6
	 add $t4, $t6, $t5
	 sw $t4, 0($s4)
	 
	 # f) F = E – (A – b) * (B – C) 
	sub $t5, $t0, $t1
	sub $t6, $t1, $t2
	addi $t7, $zero, 0
	addi $t8, $zero, 0
mult:  add $t8, $t8, $t5
	 addi $t7, $t7, 1
	 bne $t6, $t7, mult
	sub $t5, $t4, $t8
	sw $t5, 0($s5)
	
	 # g) A = B[15] - C
	 addi $t6, $zero, 15
	 add $t6, $t6, $t6
	 add $t6, $t6, $t6
	 add $t6, $s1, $t6
	 lw $t6, 0($t6)
	 sub $t0, $t6, $t2
	 sw $t0, 0($s0)
	 
	 # h) B = A[5] + C[3]
	 addi $t6, $zero, 5
	 add $t6, $t6, $t6
	 add $t6, $t6, $t6
	 add $t6, $s0, $t6
	 lw $t6, 0($t6)
	 
	 addi $t7, $zero, 3
	 add $t7, $t7, $t7
	 add $t7, $t7, $t7
	 add $t7, $s2, $t7
	 lw $t7, 0($t7)
	 
	 add $t1, $t6, $t7
	 sw $t1, 0($s1)
	 
	 # i) A[10] = B – C
	 addi $t6, $zero, 10
	 add $t6, $t6, $t6
	 add $t6, $t6, $t6
	 add $t6, $s0, $t6
	 sub $t0, $t1, $t2
	 sw $t0, 0($t6)
	 
	 # J, K e L são similares, pulo para poupar tempo!
	 
	 
	 
	
	