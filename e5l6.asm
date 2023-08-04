.data
	erro: .asciiz "Não existem soluções reais para essa equação!"
	quatro: .double 4.0
.text
main:
	li $v0, 7 # Comando para lêr double
	syscall # Lê A
	mov.d $f2, $f0 # Manda o A para o reg $f2
	
	li $v0, 7 # Comando para lêr double
	syscall # Lê B
	mov.d $f4, $f0 # Manda o B para o reg $f4
	
	li $v0, 7 # Comando para lêr double
	syscall # Lê C
	mov.d $f6, $f0 # Manda o C para o reg $f6
	
	# Chama o procedimento
	jal procedimento
	j exit # Vai pro fim do programa
procedimento:
	#li $t0, 4 # Armazena 4 em um registrador temporário
	#mtc1 $t0, $f8 # Move o valor desse registrador temporário para $f8 no coprocessador 1
	#cvt.d.w $f8, $f8 # Converte o valor de $f8 (inteiro) para double
	
	l.d $f8, quatro # Muito mais fácil, porém usa memória, guardar a constante na mem e usar l.d
	
	# Calcula o Delta
	mul.d $f10, $f4, $f4 # $f10 recebe B^2
	mul.d $f6, $f2, $f6 # $f6 recebe A*C 
	mul.d $f6, $f6, $f8 # $f6 recebe 4*A*C
	sub.d $f6, $f10, $f6 # $f6 recebe B^2 - 4*A*C, ou seja, $f6 recebe Delta
	
	li $t0, 0 # Armazena 0 em um registrador temporário
	mtc1 $t0, $f14 # Move o valor desse registrador temporário para $f14 no coprocessador 1
	cvt.d.w $f14, $f14 # Converte o valor de $f14 (inteiro) para double
	
	li $t0, 2 # Armazena 2 em um registrador temporário
	mtc1 $t0, $f16 # Move o valor desse registrador temporário para $f16 no coprocessador 1
	cvt.d.w $f16, $f16 # Converte o valor de $f16 (inteiro) para double
	
	# Se Delta > 0 existem 2 raízes reais
	c.le.d $f6, $f14 # Seta a flag de condição 0 do coprocessador 1 para 1 se Delta for <= 0 
	bc1f raizes # Se a flag de condição 0 do coprocessador for falsa pula pra label raizes
	
	# Se Delta == 0 existe uma raiz real
	c.eq.d $f6, $f14 # Seta a flag de condição 0 do coprocessador 1 para 1 se Delta for == 0
	bc1t raiz # Se a flag de condição 0 do coprocessador 1 for true pula pra label raiz  
	
	# Se não entrou nas condições anteriores, Delta é negativo, portanto não tem solução real
	li $v0, 4 # Comando para printar uma string
	la $a0, erro # Carrega a mensagem de erro
	syscall # Printa a mensagem de erro
	
	jr $ra
	
raizes:
	sqrt.d $f18, $f6 # Calcula a raiz de Delta e a coloca em $f7
	sub.d $f20, $f18, $f4 # $f20 recebe sqrt(Delta) - B
	div.d $f20, $f20, $f16 # Divide $f20 por 2: (sqrt(Delta) - B)/2
	div.d $f20, $f20, $f2 # Divide $f20 por A: (sqrt(Delta) - B)/2A, ou seja, $f20 tem x1
	
	add.d $f22, $f18, $f4 # $f22 recebe sqrt(Delta) + B
	neg.d $f22, $f22 # $f22 recebe -B - sqrt(Delta)
	div.d $f22, $f22, $f16 # Divide $f22 por 2: (- sqrt(Delta) - B)/2
	div.d $f22, $f22, $f2 # Divide $f22 por A: (- sqrt(Delta) - B)/2A, ou seja, $f22 tem x2
	
	li $v0, 3 # Comando para escrever um double
	mov.d $f12, $f20 # Move $f20 (x1) para $f12 para ser printado
	syscall
	
	li $v0, 3 # Comando para escrever um double
	mov.d $f12, $f22 # Move $f22 (x2) para $f12 para ser printado
	syscall
	
	j exit # Vai pro fim do programa
	
raiz:
	sqrt.d $f18, $f6 # Calcula a raiz de Delta e a coloca em $f18
	neg.d $f4, $f4 # -B vai pra $f4
	div.d $f12, $f4, $f16 # Divide -B/2 e coloca em $f12
	div.d $f12, $f12, $f2 # Divide -B/2A e coloca em $f12 para ser printado
	
	li $v0, 3 # COmando para escrever um double
	syscall
	
	j exit # Vai pro fim do programa
	
exit:
	