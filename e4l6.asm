.text
main:
	li $v0, 6 # Comando para lêr float
	syscall # Lê A
	mov.s $f1, $f0 # Manda o A para o reg $f1
	
	li $v0, 6 # Comando para lêr float
	syscall # Lê B
	mov.s $f2, $f0 # Manda o B para o reg $f2
	jal procedimento
	j exit
procedimento:
	neg.s $f2, $f2 # -B vai pra $f2
	div.s $f1, $f2, $f1 # -B/A vai pra $f1
	li $v0, 2 # Comando para printar float
	mov.s $f12, $f1 # Coloca o resultado no $f12 para ser usado no comando
	syscall # Printa o resultado
	jr $ra
exit:
	