.data
msg: .asciiz "Enter a string: "
msg2: .asciiz "Enter the number of shuffles: "
str: .space 256
num: .word 0

.text
main:

    li $v0, 4
    la $a0, msg
    syscall

    # Read a string from the user
    li $v0, 8
    la $a0, str  # Load address of input buffer
    li $a1, 255  # Maximum number of characters to read
    syscall
    move $s0, $v0  # Store the address of the string in $s0

    # Print prompt for entering the number of shuffles
    li $v0, 4
    la $a0, msg2
    syscall

    # Read the number of shuffles from the user
    li $v0, 5
    syscall
    move $s1, $v0
    
        # Compute the length of the string
    move $a0, $s0  # Pass the address of the string
    jal length
    move $s7, $v0
    li $s6, 1


loop:
    li $v0, 1
    la $a0, ($s7)
    syscall
    # Perform the character swap
    move $a0, $s0  # Pass the address of the string
    jal swap_chars
    
    li $v0, 4
    la $a0, str
    syscall
        
    srl $s7, $s7, 1
    sll $s6, $s6, 1
    bne $s1, $zero, loop
    
    # Print the modified string
    li $v0, 4
    la $a0, str
    syscall

    # Exit the program
    li $v0, 10
    syscall
    
length:
    # Compute the length of the string
    move $t0, $a0     # Copy the address of the string to $t0
    li $t1, 0         # Initialize the length counter to 0
    la $t0, str


length_loop:
    lb $t2, 0($t0)  
  # Load the byte from memory
    beq $t2, $zero, length_end  # Check if it's the null terminator
    addi $t1, $t1, 1  # Increment the length counter
    addi $t0, $t0, 1  # Move to the next character
    j length_loop     # Repeat the loop

length_end:
    subi $t1, $t1, 1
    move $v0, $t1     # Return the length in $v0
    jr $ra            # Return


swap_chars:
    la $t0, str
    li $t1, 0         # Initialize the index counter to 0
    srl $t4, $s7, 1
    move $t5, $s6
    subi $s1, $s1, 1

swap_loop:
    	lb $t2, 0($t0)    # Load the first character
    	add $t0, $t0, $t4  # Move to the next character
   	lb $t3, 0($t0)    # Load the second character
    	sb $t2, 0($t0)    # Store the first character at the position of the second character
    	sub $t0, $t0, $t4
    	sb $t3, 0($t0)   # Store the second character at the position of the first character
    	addi $t0, $t0, 1  # Move to the next character
    	addi $t1, $t1, 1  # Increment the index counter
    	beq $t1, $t4, swap_end
    	j swap_loop
    	
swap_end:
	subi $t5, $t5, 1
	beq $t5, $zero, finish
	sub $t0, $t0, $t4
	add $t0, $t0, $s7
	li $t1, 0
	j swap_loop
	
finish:
    jr $ra            # Return