
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

    jal read_numbers

    jal print_numbers

    jal travel_numbers_for_loop


travel_numbers_for_loop:
    add $t0, $a1, $zero
    li $t1, 0($a1) # t1 = create variable to represent array element
    li $t2, 1($a1) # t2 = create variable to represent array element
    li $t3, 0      # t3 = create non-coprime ekok value
    li $t4, 0      # t4 = temp t1 value
    li $t6, 0      # t6 = temp t2 value
    li $t7, 0      # t7 = represents gcd value
    li $t8, 0      # t8 = represents lcm value


    loop:
        # t1 - t2 aralarında asal mı değil mi kontrol et

        addi $sp, $sp, -4   # Allocate space on stack for return address
        sw $ra, 0($sp)      # Save return address on stack
        beq $zero, $zero check_if_coprime   
        AA: 
        lw $ra, 0($sp)   # Restore return address
        addi $sp, $sp, 4   # Deallocate space on stack     
        
        beq $


        # eğer aralarında asal ise t1 ve t2 yi 1er arttır
        # eğer değillerse en küçük ortak katlarını bul

check_if_coprime:
    beq $t1, $t2, equal
    
    beq $a1, $zero, AA
    addi $t4, $t1, 0
    addi $t6, $t2, 0
    while_loop:

        li $t5, $t4
        div $t5, $t6
        #mfhi $t5 ?

        addi $t4, $t6, 0
        addi $t6, $t5, 0
        
        addi $t7 , $t4, 0

        bne $t6, $zero, while_loop

    beq $zero, $zero, find_LCM

equal:
    # t1 değerini esas alacak

find_LCM:
    # ekok bulma
    beq $t7, $zero, make_LCM_zero 
    AB:
    addi $t4 , $t1, 0
    addi $t6 , $t2, 0
    div $t4, $t7
    mul $t4, $t6
    addi $t8, $t4, 0


make_LCM_zero:
    addi $t3, $zero, $zero
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
    beq $t0, $zero, end_print

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

end_print:
    # Programdan çık
    li $v0, 10
    syscall
