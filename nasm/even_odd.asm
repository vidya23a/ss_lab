section .data
    msg1 db "number:"
    msg2 db "even"
    msg3 db "odd"
    
section .bss
    num resb 10
    
section .text
    global _start

_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,7
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,num
    mov edx,10
    int 0x80
    
    mov al,[num]
    add al,'0'
    and al,1
    jz even
    jmp odd
    
   even:mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,4
    int 0x80
    jmp end
    
    odd:mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,3
    int 0x80
    
    end:mov eax,1
    int 0x80
