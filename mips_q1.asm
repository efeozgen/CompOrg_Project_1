.data  
coefficients: .asciiz "Please enter the coefficients: "
sequence: .asciiz "Please enter first two numbers of the sequence: "
nthNumber: .asciiz "Enter the number you want to calculate (it must be greater than 1): "
output: .asciiz "Output: "
result: .asciiz "th element of the sequence is "


.text
.globl main

main:
    # Prompt message to user to enter coefficients a and b
    li $v0, 4
    la $a0, coefficients
    syscall
    
    # Get coefficient a
    li $v0, 5
    syscall
    # Store coefficient a in $t0
    move $t0, $v0 
    
    # Read coefficient b
    li $v0, 5
    syscall
    # Store coefficient b in $t1
    move $t1, $v0 
    
    # Print message to user to enter first two numbers
    li $v0, 4
    la $a0, sequence
    syscall
    
    # Read first number x0
    li $v0, 5
    syscall
    # Store first number in $t2
    move $t2, $v0 
    
    # Read second number x1
    li $v0, 5
    syscall
    # Store second number in $t3
    move $t3, $v0 
    
    # Loop for n validation
nValidation:
    # Print message to enter n
    li $v0, 4
    la $a0, nthNumber
    syscall
    
    # Read nth number
    li $v0, 5
    syscall
    # Store n in $t4
    move $t4, $v0 
    
    # Check if n > 1
    li $t5, 1
    ble $t4, $t5, nValidation # If n <= 1,ask again
    
    # Main calculation loop
    # Loop counter should starts with 2
    li $t6, 2 
    #t7 to store f(x-2)
    move $t7, $t2 
    #t8 to store f(x-1)
    move $t8, $t3 
    
equation:
    # If loop counter >= n, end calculation
    bge $t6, $t4, end 
    # f(x) = a*f(x-1) + b*f(x-2) -2
    
    # a * f(x-1)
    mul $t9, $t0, $t8
    
    # b * f(x-2) 
    mul $t5, $t1, $t7
    
    # Sum of above
    add $t9, $t9, $t5
    
    # Subtract 2
    sub $t9, $t9, 2
    
    # Update f(x-2) with old f(x-1)
    move $t7, $t8
    
    # Update f(x-1)
    move $t8, $t9 
    addi $t6, $t6, 1 # Increment loop counter
    j equation

end:

    #Print "Output:"
    li $v0, 4
    la $a0, output
    syscall
    
    # Print nth element number
    move $a0, $t4
    li $v0, 1
    syscall
    
    # Print output message
    li $v0, 4
    la $a0, result
    syscall
    
    # Print the result
    move $a0, $t9
    li $v0, 1
    syscall
    
    # Syscall exit command
    li $v0, 10
    syscall
