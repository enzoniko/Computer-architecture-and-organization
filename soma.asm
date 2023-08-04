# ================================================
# Template: Definindo segmentos de dados e c?digo.
# ================================================
# -----------------------------------------------
# Implementando: C = A + B
#------------------------------------------------

.data
	A: .word 25
	B: .word 10
	C: .word 0
		
.text
principal:
	la	$s0, A
	la	$s1, B
	la	$s2, C
	
	lw	$t0, 0($s0)
	lw	$t1, 0($s1)
	add	$s3, $t0, $t1
	sw	$s3, 0($s2)
	