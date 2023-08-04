.data
	result: .double 0 # Aloca espaço pra double na memória sob a flag result

.text
	
	li $v0, 7 # Seta o Comando para ler double do teclado
	syscall # Chama o comando
	jal convert # Chama a função que vai converter o valor recebido em F para C
	
exit:
	j exit
	
convert:
	
	li $t0, 32 # Armazena 32 no registrador temporário $t0
	mtc1 $t0, $f4 # Move o valor armazenado em $t0 (32) para o registrador $f4 no coprocessador 1
	cvt.d.w $f4, $f4 # Converte o valor armazenado no registrador $f4, de inteiro para double
	
	li $t0, 9 # Armazena 9 no registrador temporário $t0
	mtc1 $t0, $f6 # Move o valor armazenado em $t0 (9) para o registrador $f6 no coprocessador 1
	cvt.d.w $f6, $f6 # Converte o valor armazenado no registrador $f6, de inteiro para double
	
	li $t0, 5 # Armazena 5 no registrador temporário $t0
	mtc1 $t0, $f8 # Move o valor armazenado em $t0 (5) para o registrador $f8 no coprocessador 1
	cvt.d.w $f8, $f8 # Converte o valor armazenado no registrador $f8, de inteiro para double
	
	sub.d $f0, $f0, $f4 # Subtrai $f0 de $f4 e coloca o resultado em $f0 (F - 32)
	div.d $f0, $f0, $f6 # Divide $f0 por $f6 e coloca o resultado em $f0 (F - 32)/9
	mul.d $f0, $f0, $f8 # Multiplica $f0 por $f8 e coloca o resultado em $f0 (F - 32)*5/9
	s.d $f0, result # Armazena o resultado obtido na memória em result

	jr $ra