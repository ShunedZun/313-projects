.section .data
outtext: .asciz "\nThe double is: "
numtext: .asciz "%ld"
outleng = . - outtext

.section .bss
numberin: .space 32
numberout: .space 32

.section .text
.globl _start

_start:

#get the input
mov $3, %eax
mov $0, %ebx
mov $numberin, %ecx
mov $32, %edx
int $0x80

mov $numberin, %esi
xor %eax, %eax

#convert to an integer
convert:
movzbl (%esi), %ebx
cmp $10, %ebx
je done
cmp $0, %ebx
je done

sub $'0', %ebx

imul $10, %eax, %eax
add %ebx, %eax

inc %esi
jmp convert

#point to now double the value
done:
add %eax, %eax
mov $numberout, %esi
add $31, %esi

movb $0, (%esi)
mov $10, %ebx

#convert into string
sconvert:
dec %esi
xor %edx, %edx
div %ebx

add $'0', %dl
mov %dl, (%esi)

test %eax, %eax
jnz sconvert

#output
mov $4, %eax
mov $1, %ebx
mov $outtext, %ecx
mov $outleng, %edx
int $0x80

mov $4, %eax
mov $1, %ebx
mov %esi, %ecx
mov $numberout, %edx
add $31, %edx
sub %esi, %edx
int $0x80

mov $1, %eax
xor %ebx, %ebx
int $0x80
