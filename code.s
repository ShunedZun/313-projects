#outtext: basic output text
#outleng: the calculated length of the output text
#newline: generic newline character
.section .data
outtext: .asciz "The double is: "
outleng = . - outtext
newline: .asciz "\n"

#numberin: the input space for the integer
#numberout: location to hold the calculated output number
.section .bss
numberin: .space 32
numberout: .space 32

#declaration of start
.section .text
.globl _start

_start:

#get the input
mov $3, %eax
mov $0, %ebx

#store in the numberin
mov $numberin, %ecx
mov $32, %edx
int $0x80
mov $numberin, %esi
xor %eax, %eax

#convert to an integer
convert:
#get first character end ensure it is valid
movzbl (%esi), %ebx
cmp $10, %ebx
je done
cmp $0, %ebx
je done

#adjust the value
sub $'0', %ebx
imul $10, %eax, %eax
add %ebx, %eax

#increment and convert next value
inc %esi
jmp convert

#double the value
done:
#add self to self effectively doubling
add %eax, %eax

#store in the output variable
mov $numberout, %esi
add $31, %esi
movb $0, (%esi)
mov $10, %ebx

#convert back into string
sconvert:

#get the integer data
dec %esi
xor %edx, %edx
div %ebx

#adjust memory as needed
add $'0', %dl
mov %dl, (%esi)

#move to next if needed
test %eax, %eax
jnz sconvert

#output

#print out output string and adjust point in memory
mov $4, %eax
mov $1, %ebx
mov $outtext, %ecx
mov $outleng, %edx
int $0x80

#print out the new value
mov $4, %eax
mov $1, %ebx
mov %esi, %ecx
mov $numberout, %edx
add $31, %edx
sub %esi, %edx
int $0x80

#print out new line for command space organization
mov $4, %eax
mov $1, %ebx
mov $newline, %ecx
mov $1, %edx
int $0x80

#close and exit program
mov $1, %eax
xor %ebx, %ebx
int $0x80
