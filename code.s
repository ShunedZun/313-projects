.section .data
outtext: .asciz "The double is: "

.section .bss
number: .space 4

.section .text
.globl _start

_start:
mov $0, %eax
mov $0, %edi
mov $number, %esi
move $4, %edx
int $0x80

mov $4, %eax
mov $1, %ebx
mov 
