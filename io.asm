.data
        FRASE_1: .asciiz "Digie um numero: "
        FRASE_2: .asciiz " O numero digitado foi: "
        NUMERO: .word 0
.text
main:
	li	$v0, 4			# Comando.
	la	$a0, FRASE_1		# Carrega string (endere?o).
	syscall 
	
	li	$v0, 5	      		# Comando para ler inteiro.
	syscall
	move    $t0, $v0         	# Resultado ? salvo em $t0. 

	la	$s0, NUMERO
	sw	$t0, 0($s0)
	
	li	$v0, 4			# Comando.
	la	$a0, FRASE_2		# Carrega string (endere?o).	
	syscall 
	
	lw	$t1, 0($s0)	
	li	$v0, 1			# Comando.
	move	$a0, $t1		# Carrega valor.
	syscall 
	
	