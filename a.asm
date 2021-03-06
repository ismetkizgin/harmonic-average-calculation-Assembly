.text
	.globl main

main:
	ldc1 $f10, zero
	
	addi $t0, $zero, 0
	addi $t1, $zero, 1
	while_input:
		beq $t0, 40, harmonic_average

		li $v0, 1
		addi $a0, $t1, 0
		syscall

		li $v0, 4
		la $a0, input_number_text
		syscall
		
		li $v0, 5
		syscall
		sw $v0, myArray($t0)
		
		addi $t0, $t0, 4
		addi $t1, $t1, 1
		j while_input

	harmonic_average:
		addi $t0, $zero, 0
		ldc1 $f8, one
		
		while_harmonic:
			beq $t0, 40, calculation
			
			lw $t2,myArray($t0)
		
			mtc1.d $t2, $f2
			cvt.d.w $f2, $f2
			
			div.d $f2, $f8, $f2
			add.d $f4, $f4, $f2		
			
			addi $t0, $t0, 4
			j while_harmonic
		
		calculation:
			ldc1 $f8, N
			
			div.d $f12, $f8, $f4
		
		exit:
			li $v0, 4
			la $a0, result_text
			syscall
			
			li $v0, 3
			syscall

.data
	myArray: .space 40
	zero:  .double 0.0
	one: .double 1.0
	N: .double 10.0
	input_number_text: .asciiz ". Lütfen Sayi Giriniz: "
	result_text: .asciiz "\nGirmis Oldugunuz Sayilarin Harmonik Ortalamasi: "
	ln: .asciiz "\n"
