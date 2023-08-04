.data
	pi: .double 3.141592653589793
	result: .double 0
.text
main:
	li $v0, 7
	syscall
	l.d $f2, pi
	
	mul.d $f0, $f0, $f0
	mul.d $f2, $f2, $f0
	
	s.d $f2, result
	   