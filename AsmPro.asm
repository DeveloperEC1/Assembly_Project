section .text
   global _start    ;must be declared for using gcc
    
_start:             ;tell linker entry point
   mov  al,'2'
   sub     al, '0'
    
   mov  bl, '2'
   sub     bl, '0'
   
   mov  cl, '2'
   sub     cl, '0'
   
   mov  dl, '1'
   sub     dl, '0'
   
   mul  bl
   mul  cl
   mul  dl
   add  al, '0'
    
   mov  [res], al
   mov  ecx, msg1   
   mov  edx, len1
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80    ;call kernel
    
   mov  ecx, res
   mov  edx, 1
   mov  ebx, 1  ;file descriptor (stdout)
   mov  eax, 4  ;system call number (sys_write)
   int  0x80    ;call kernel
   
   mov  eax, '1'
   sub  eax, '0'
    
   mov  ebx, '2'
   sub  ebx, '0'
   
   mov  ecx, '3'
   sub  ecx, '0'
   
   mov  edx, '2'
   sub  edx, '0'
   
   add  eax, ebx
   add  eax, ecx
   add  eax, edx
   add  eax, '0'
    
   mov  [sum], eax
   mov  ecx, msg2   
   mov  edx, len2
   mov  ebx, 1           ;file descriptor (stdout)
   mov  eax, 4           ;system call number (sys_write)
   int  0x80             ;call kernel
    
   mov  ecx, sum
   mov  edx, 1
   mov  ebx, 1           ;file descriptor (stdout)
   mov  eax, 4           ;system call number (sys_write)
   int  0x80             ;call kernel
   
   mov  edx, len3     ;message length
   mov  ecx, msg3     ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80        ;call kernel    
    
   mov  edx, len4     ;message length
   mov  ecx, msg4     ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80        ;call kernel 
    
   mov  edx, len5     ;message length
   mov  ecx, msg5     ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80        ;call kernel 
   
   mov  edx, len6     ;message length
   mov  ecx, msg6     ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80        ;call kernel 
   
   mov  eax, 45      ;sys_brk
   xor  ebx, ebx
   int  0x80

   add  eax, 16384   ;number of bytes to be reserved
   mov  ebx, eax
   mov  eax, 45      ;sys_brk
   int  0X80
    
   cmp  eax, 0
   jl   exit    ;exit, if error 
   mov  edi, eax     ;EDI = highest available address
   sub  edi, 4       ;pointing to the last DWORD  
   mov  ecx, 4096    ;number of DWORDs allocated
   xor  eax, eax     ;clear eax
   std           ;backward
   rep  stosd            ;repete for entire allocated area
   cld           ;put DF flag to normal state
   
   mov  edx, len7    ;message length
   mov  ecx, msg7    ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80         ;call kernel
   
   mov  [msg7],  dword 'Name'    ; Changed the name to Nuha Ali
    
   ;writing the name 'Here Cohen'
   mov  edx, len7     ;message length
   mov  ecx, msg7    ;message to write
   mov  ebx, 1       ;file descriptor (stdout)
   mov  eax, 4       ;system call number (sys_write)
   int  0x80         ;call kernel
   
   mov  eax, 4
   mov  ebx, 1
   mov  ecx, msg9
   mov  edx, len9
   int  0x80         ;print a message
   
   mov   ecx, [num1]
   mov   ecx, [num2]
   cmp   ecx, [num3]
   jg    check_fourth_num
   mov   ecx, [num2]
   mov   ecx, [num3]
   
check_fourth_num:
   cmp   ecx, [num4]
   jg    _exit
   mov   ecx, [num4]
   
_exit:
   mov   [largest], ecx
   mov   ecx, msg8
   mov   edx, len8
   mov   ebx, 1 ;file descriptor (stdout)
   mov   eax, 4 ;system call number (sys_write)
   int   0x80   ;call kernel
    
   mov   ecx, largest
   mov   edx, 2
   mov   ebx, 1 ;file descriptor (stdout)
   mov   eax, 4 ;system call number (sys_write)
   int   0x80   ;call kernel
    
   mov   eax, 1 ;system call number (sys_exit)
   int   0x80   ;call kernel
   
exit:
   mov   eax, 1
   xor   ebx, ebx
   int   0X80

section .data
msg1 db "The result of the numbers is: " 
len1 equ $ - msg1

msg2 db 13, 10, 13, 10, "The sum of the number is: "
len2 equ $ - msg2

msg3 db 13, 10, 13, 10, 'My '
len3 equ $ - msg3           

msg4 db 'name '
len4 equ $ - msg4 

msg5 db 'is '
len5 equ $ - msg5

msg6 db 'Elior Cohen', 0xA, 0Xd
len6 equ $ - msg6

msg7 db 'Here Cohen', 0xA, 0Xd
len7 equ $ - msg7   

msg8 db "The largest digit is: "
len8 equ $ - msg8 
num1 dd '47'
num2 dd '55'
num3 dd '31'
num4 dd '22'

msg9 db "Allocated 16 kb of memory!", 0xA, 0xD
len9 equ $ - msg9

segment .bss
res resb 1
sum resb 1
largest resb 1