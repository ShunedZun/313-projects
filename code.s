.section .data
outtext: .asciz "The double is: "
numtext: .asciz
outleng = . - outtext

.section .bss
number: .space 4

.section .text
.globl _start

_start:
mov $0, %eax
mov $0, %edi
mov $number, %esi
mov $4, %edx
int $0x80

mov $4, %eax
mov $1, %ebx
mov $outtext, %ecx
