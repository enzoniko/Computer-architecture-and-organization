.text 
#F
	li $s0, 0 # Inicializa a com 0
	li $s1, 0 # Inicializa b com 0
	li $s2, 5 # Inicializa c com 

		
while:
	slt $t0, $s0, $s2 # Bota 1 em $t0 se a < c
	bne $t0, 1, Exit # Se a >= c vai pro exit
	addi $s0, $s0, 1 # Incrementa A
	addi $s1, $s1, 2 # Incrementa B em 2
	j while # Se a < c vai pro while
	
Exit:
	
	
# G
	li $s0, 1 # Inicializa a com 1
	li $s1, 2 # Inicializa b com 2
	li $t0, 0 # Inicializa i com 0
for:
	addi $s0, $s1, 1 # a = b + 1
	addi $s1, $s1, 3 # b = b + 3
	addi $t0, $t0, 1 # Incrementa i
	bne $t0, 5, for # Enquanto i < 5 volta pro for
	
# H	
	beq $s0, 1, case1 # Caso a = 1
	beq $s0, 2, case2 # Caso a = 2
default:
	move $s1, $s2 # b = c
	j Break
case1:
	addi $s1, $s2, 1 # b = c + 1
	j Break
case2:
	addi $s1, $s2, 2 # b = c + 2
	j Break 	
Break:


