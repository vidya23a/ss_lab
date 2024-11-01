section .data
    msg1 db "Enter first string",0xa
    msg2 db "Enter",0xa
    meq db "Equal",0xa
    mneq db "Not equal",0xa
    
section .bss
    str1 resb 100
    str2 resb 100
    
section .text
    global _start
    
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,19
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,str1
    mov edx,100
    int 0x80
    mov byte[str1+eax-1],0
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,6
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,str2
    mov edx,100
    int 0x80
    mov byte[str2+eax-1],0
    
    mov eax,str1
    mov ebx,str2
    
    loop1:mov dl,[eax]
    mov cl,[ebx]
    test cl,cl
    jz done
    cmp dl,cl
    jne not_eq
    inc eax
    inc ebx
    jmp loop1
    
    
    not_eq:mov eax,4
    mov ebx,1
    mov ecx,mneq
    mov edx,10
    int 0x80
    jmp end
    
    done:mov eax,4
    mov ebx,1
    mov ecx,meq
    mov edx,6
    int 0x80
    jmp end
    
    end:mov eax,1
    int 0x80
