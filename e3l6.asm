.data 
	media: .float 0.0
	
.text
	li $v0, 6 # Instru��o que l� float
	syscall
	
	movf.s $f1, $f0 # Move o valor lido em $f0(S) para o registrador $f1
	
	li $v0, 6 # Instru��o que l� float
	syscall 
	# C est� em $f0
	
	div.s $f0, $f1, $f0 # Divide $f1 (S) por $f0 (C) e coloca o resultado em $f0

	s.s $f0, media # Guarda a m�dia na mem�ria
	
	
	