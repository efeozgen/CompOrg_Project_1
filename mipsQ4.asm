    .data
matrix: .byte 5, 6, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0,
1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0

output_string: .asciiz "The number of the 1s on the largest island is "
newline: .asciiz "\n"
space:   .asciiz " "

    .text
    .globl main



main:
    # Load matrix address
    la $t0, matrix   # $t0 = address of matrix

    # Load number of rows and columns from the matrix
    lb $t1, 0($t0)   # $t1 = number of rows
    lb $t2, 1($t0)   # $t2 = number of columns
    
    # Print the matrix
    jal print_matrix
    ################################################
    # Load matrix address
    la $t0, matrix   # $t0 = address of matrix

    # Load number of rows and columns from the matrix
    lb $t1, 0($t0)   # $t1 = number of rows
    lb $t2, 1($t0)   # $t2 = number of columns

    jal travel_in_matrix

    # Print the first part of the string
    la $a0, output_string
    li $v0, 4           # syscall 4: print string
    syscall

    # Print the value of $t8
    move $a0, $t8       # Load $t8 into $a0 for printing
    li $v0, 1           # syscall 1: print integer
    syscall

    # Exit program
    li $v0, 10       # Exit syscall
    syscall
    
print_matrix:
    # Initialize row and column indices
    li $t3, 0        # $t3 = row index
    li $t4, 0        # $t4 = column index
    
    # Skip the first two elements (row and column numbers)
    addi $t0, $t0, 2
    
    # Loop over rows
    print_matrix_row_loop:
        # Loop over columns
        print_matrix_col_loop:
            # Calculate index of current element in matrix
            mul $t5, $t3, $t2   # $t5 = row index * number of columns
            add $t5, $t5, $t4   # $t5 = index of current element
            add $t5, $t5, $t0   # $t5 = address of current element
            
            # Load current element into $t6
            lb $t6, 0($t5)
            
            # Print current element
            li $v0, 1            # Print integer syscall
            addi $a0, $t6, 0    # Move element value to argument register
            syscall
            
            # Print space between elements
            la $a0, space
            li $v0, 4            # Print string syscall
            syscall
            
            # Increment column index
            addi $t4, $t4, 1
            
            # Check if end of row is reached
            bne $t4, $t2, print_matrix_col_loop
            
            # Print newline at the end of row
            la $a0, newline
            li $v0, 4            # Print string syscall
            syscall
            
            # Reset column index for next row
            li $t4, 0
            
        # Increment row index
        addi $t3, $t3, 1
        
        # Check if end of matrix is reached
        blt $t3, $t1, print_matrix_row_loop
        
    # Return from function
    jr $ra

travel_in_matrix:
    # addi $sp, $sp, -4   # Allocate space on stack for return address
    # sw $ra, 0($sp)      # Save return address on stack

    # Initialize row and column indices
    li $t3, 0        # $t3 = row index
    li $t4, 0        # $t4 = column index

    # Skip the first two elements (row and column numbers)
    addi $t0, $t0, 2,

    li $t7, 0        # $t7 = count value
    li $t8, 0        # $t8 = largest island value

    travel_in_matrix_row_loop:
        
        travel_in_matrix_column_loop:

            # Calculate index of current element in matrix
            mul $t5, $t3, $t2   # $t5 = row index * number of columns
            add $t5, $t5, $t4   # $t5 = index of current element
            add $t5, $t5, $t0   # $t5 = address of current element
            
            # Load current element into $t6
            lb $t6, 0($t5)

            # Save original values of $t3 and $t4
            addi $s0, $t3, 0   # Save $t3 in $s0
            addi $s1, $t4, 0   # Save $t4 in $s1
            addi $s3, $t5, 0   # Save $t5 in $s3 

            li $s2, 0 # Create recursive count value

            # If current element is 1, call recursive search functions
            beq $t6, 1, call_recursive_search_functions
            AA:

            bgt $t7, $t8, set_largest_island_value
            AB:

            add $t7, $zero, $zero   # Reset count value

            # After returning from recursive function, restore original values of $t3 and $t4
            add $t3, $s0, $zero   # Restore $t3 from $s0
            add $t4, $s1, $zero   # Restore $t4 from $s1
            add $t5, $s3, $zero   # Restore $t5 from $s3

            # Increment column index
            addi $t4, $t4, 1

            # Check if end of row is reached
            bne $t4, $t2, travel_in_matrix_column_loop
        
            # Reset column index for next row
            li $t4, 0

        # Increment row index
        addi $t3, $t3, 1
        
        # Check if end of matrix is reached
        blt $t3, $t1, travel_in_matrix_row_loop
        
    # lw $ra, 0($sp)   # Restore return address
    # addi $sp, $sp, 4   # Deallocate space on stack

    # Return from function
    jr $ra

call_recursive_search_functions:
    

    addi $s2, $s2, 1 # Increase recursive count value by 1

    li $t9, 2   # $t9 = 2

     # Calculate index of current element in matrix
    mul $t5, $t3, $t2   # $t5 = row index * number of columns
    add $t5, $t5, $t4   # $t5 = index of current element
    add $t5, $t5, $t0   # $t5 = address of current element

    sb $t9, 0($t5)   # Mark current element as visited by changing its value to 2
    add $t7, $t7, 1   # Increment count value

    sub $t3, $t3, 1   # Move up
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack
    jal recursive_search_function_up
    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack
    add $t3, $t3, 1   # Restore $t3

    add $t3, $t3, 1   # Move down
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack
    jal recursive_search_function_down
    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack
    sub $t3, $t3, 1   # Restore $t3
    
    sub $t4, $t4, 1   # Move left
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack
    jal recursive_search_function_left
    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack
    add $t4, $t4, 1   # Restore $t4

    add $t4, $t4, 1   # Move right
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack
    jal recursive_search_function_right
    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack
    sub $t4, $t4, 1   # Restore $t4
    # Continue with other operations or return from main
    
    sub $s2, $s2, 1 # Decrease recursive coutn value by 1

    beq $s2, 0, AA

    #jr $ra   # Return from main or other function


recursive_search_function_up:
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack

    bgt $zero, $t3 end_function

     # Calculate index of current element in matrix
    mul $t5, $t3, $t2   # $t5 = row index * number of columns
    add $t5, $t5, $t4   # $t5 = index of current element
    add $t5, $t5, $t0   # $t5 = address of current element
    
    # Load current element into $t6
    lb $t6, 0($t5)

    beq $t6, 1, call_recursive_search_functions

    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    jr $ra

recursive_search_function_down:
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack

    beq $t3, $t1 end_function

    # Calculate index of current element in matrix
    mul $t5, $t3, $t2   # $t5 = row index * number of columns
    add $t5, $t5, $t4   # $t5 = index of current element
    add $t5, $t5, $t0   # $t5 = address of current element
    
    # Load current element into $t6
    lb $t6, 0($t5)

    beq $t6, 1, call_recursive_search_functions

    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    jr $ra

recursive_search_function_left:
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack

    bgt $zero, $t4 end_function

    # Calculate index of current element in matrix
    mul $t5, $t3, $t2   # $t5 = row index * number of columns
    add $t5, $t5, $t4   # $t5 = index of current element
    add $t5, $t5, $t0   # $t5 = address of current element
    
    # Load current element into $t6
    lb $t6, 0($t5)

    beq $t6, 1, call_recursive_search_functions

    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    jr $ra

recursive_search_function_right:
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)      # Save return address on stack

    beq $t4, $t2 end_function

    # Calculate index of current element in matrix
    mul $t5, $t3, $t2   # $t5 = row index * number of columns
    add $t5, $t5, $t4   # $t5 = index of current element
    add $t5, $t5, $t0   # $t5 = address of current element
    
    # Load current element into $t6
    lb $t6, 0($t5)

    beq $t6, 1, call_recursive_search_functions

    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    jr $ra

set_largest_island_value:
    
    add $t8, $t7, $zero   # Set largest island value to count value

    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    beq $zero, $zero, AB

end_function:
    lw $ra, 0($sp)   # Restore return address
    addi $sp, $sp, 4   # Deallocate space on stack

    jr $ra
