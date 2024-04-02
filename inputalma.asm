
.data
array:  .space 80
prompt: .asciiz "Enter an integer (0 to quit) : "
text:   .asciiz "After sorting, the list of integers is: "
separator: .asciiz " "
zero:   .word 0   # Kontrol elemanı

.text
.globl main

main:
    la $a1, array

    # Kullanıcıdan sayıları oku ve diziye ekle
read_numbers:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall

    sw $v0, 0($a1)
    addiu $a1, $a1, 4

    # -1 girilene kadar devam et
    bnez $v0, read_numbers

    # Diziyi sırala ve yazdır
    la $a1, array
    li $v0, 4
    la $a0, text
    syscall

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
