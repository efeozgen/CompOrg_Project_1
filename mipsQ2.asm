
.data
array:  .space 80
prompt: .asciiz "Enter an integer (0 to quit) : "
text:   .asciiz "The list of integers is: "
separator: .asciiz " "
zero:   .word 0   # Kontrol elemanı

.text
.globl main

main:
    la $a1, array

    li $s3, 0 # s3 = represenets length of the array

    jal read_numbers

    sub $s3, $s3, 1 # get rid of -1 in length

    # jal print_numbers

    jal travel_numbers_for_loop

    jal print_numbers

    CA:
    # Programdan çık
    li $v0, 10
    syscall

travel_numbers_for_loop:
    addi $sp, $sp, -4   # Allocate space on stack for return address
    sw $ra, 0($sp)

    add $t0, $a1, $zero # t0 = address of the array
    li $s4, 0      # s4 = temp address of the array
    add $s4, $t0, $zero # s4 = address of the array
    li $s1, 0      # s1 = represent i - 1
    li $s2, 1      # s2 = represent   i
    lb $t1, 0($t0) # t1 = create variable to represent array element (i-1)
    addi $t0, $t0, 1 # t0 = t0 + 1
    lb $t2, 0($t0) # t2 = create variable to represent array element  (i)
    sub $t0, $t0, 1 # t0 = t0 - 1
    li $t3, 0      # t3 = create non-coprime ekok value
    li $t4, 0      # t4 = temp t1 value
    li $t5, 0      # t5
    li $t6, 0      # t6 = temp t2 value
    li $t7, 0      # t7 = represents gcd value
    li $t8, 0      # t8 = represents lcm value
    li $t9, 0      # t9 = represenet second loop j value

    loop:
        # t1 - t2 aralarında asal mı değil mi kontrol et

        beq $zero, $zero check_if_coprime   
        AA:  
        
        bne $t7, 1, find_LCM
        LCM:

        add $t0, $t0, $s1

        sb $t8, 0($t0) # t7 = gcd value

        add $t0, $a1, $zero # t0 = address of the array

        # add $t9, $t2, $zero # t9=t2 / j=i
        add $t9, $t0, $t2 # find the address of arr[i] of the array 
        addi $t6, $t2, 1 # t6 = i + 1
        add $t0, $t0, $t2
        sub $t0, $t0, 1 # t0 = t0 - 1

        sub $s3, $s3, 1 # decrement array length by 1

        second_loop:

            add $t0, $a1, $t9
            addi $s4, $t0, 1

            sb $t0, 0($s4) # changing jth elemnt of index to $t2 + 1 / (i+1)

            addi $t9, $t9, 1 #inrement t9 / j by 1
            addi $t6, $t6, 1 #increment i by 1
            
            blt $t6, $s3, second_loop #arrayin uzunluğunun 1 eksiğine eşit değilse second_loopa geri döndür

        sub $s3, $s3, 1 # decrement array length by 1
        
        add $t0, $a1, $zero # restore t0 which represents the address of the array
        add $s4, $t0, $zero # restore s4 which represents the address of the array
        addi $s3, $s3, 1 #increment array length by 1

        add $t0, $a1, $zero # restore t0 which represents the address of the array
        add $t6, $t2, $zero # t6 = i / t2
        # add $t0, $a1, $zero # restore t0 which represents the address of the array

        bgt $1, $t2, AC
        AF:
        
        addi $s1, $s1, 1 # increment i - 1 by 1
        addi $s2, $s2, 1 # increment i by 1

        blt $s2, $s3, loop # if i is less than the length of the array, go back to loop

    jr $ra


        # eğer aralarında asal ise t1 ve t2 yi 1er arttır
        # eğer değillerse en küçük ortak katlarını bul


AC:
    add $t4, $t1, $zero
    add $t6, $t2, $zero

    beq $zero, $zero, check_if_coprime2
    BA:
    
    beq $t4, 1, AE 

    AD:
    sub $t1 , $t1, 1
    sub $t2 , $t2, 1
    AE:
    sub $t1 , $t1, 1
    sub $t2 , $t2, 1

    beq $zero, $zero, AF
    

check_if_coprime2:
    beq $t4, $t6, equal2

    beq $a1, $zero, BA

    while_loop2:

        add $t5, $t4, $zero
        div $t5, $t6
        #mfhi $t5 ?

        addi $t4, $t6, 0
        addi $t6, $t5, 0
        
        addi $t7 , $t4, 0

        bne $t6, $zero, while_loop2
    
    beq $zero, $zero, BA
     

equal2:
    add $t7, $t4, $zero
    beq $zero, $zero, BA

check_if_coprime:
    beq $t1, $t2, equal
    
    # beq $a1, $zero, AA
    add $t4, $t1, $zero
    add $t6, $t2, $zero
    add $t5, $zero, $zero
    while_loop:

        # li $t5, 0($t4)
        add $t5, $t4, $zero
        div $t5, $t6
        #mfhi $t5 ?

        addi $t4, $t6, 0
        addi $t6, $t5, 0
        
        addi $t7 , $t4, 0

        bne $t6, $zero, while_loop

    beq $zero, $zero, AA
    # beq $zero, $zero, find_LCM

equal:
    # t1 değerini esas alacak
    add $t7, $t1, $zero
    beq $zero, $zero, AA

find_LCM:
    # ekok bulma
    beq $t7, $zero, make_LCM_zero 
    AB:
    add $t4 , $t1, $zero
    add $t6 , $t2, $zero
    div $t4, $t4, $t7
    mul $t4, $t4, $t6
    addi $t8, $t4, 0

    beq $zero, $zero, LCM

make_LCM_zero:
    add $t3, $zero, $zero
    beq $zero, $zero, AB

# Kullanıcıdan sayıları oku ve diziye ekle
read_numbers:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall

    sw $v0, 0($a1)
    addiu $a1, $a1, 4

    addi $s3, $s3, 1 # increase array length by 1

    # 0 girilene kadar devam et
    bnez $v0, read_numbers

    # Diziyi sırala ve yazdır
    la $a1, array
    li $v0, 4
    la $a0, text
    syscall

    jr $ra

print_numbers:
    lw $t0, 0($a1)

    # Kontrol elemanı olan -1'e kadar yazdırmayı bitir
    beq $t0, $zero, CA

    # Sayıyı yazdır
    li $v0, 1
    move $a0, $t0
    syscall

    # Boşluk yazdır
    li $v0, 4
    la $a0, separator
    syscall

    addiu $a1, $a1, 4

    # Bir sonraki sayıyı yazdırmak için döngüyü tekrarla
    j print_numbers
