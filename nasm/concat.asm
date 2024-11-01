section .data
    msg1 db "Enter first string",0xa
    msg2 db "Enter",0xa
    msg3 db "string",0xa
    
section .bss
    str1 resb 100
    str2 resb 100
    str3 resb 200
    
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
    mov ebx,str3
    
    loop1:mov dl,[eax]
    test dl,dl
    jz next
    mov [ebx],dl
    inc eax
    inc ebx
    jmp loop1

    next:mov eax,str2
    
    loop2:mov dl,[eax]
    test dl,dl
    jz end
    mov [ebx],dl
    inc eax
    inc ebx
    jmp loop2
    
    end:
    mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,7
    int 0x80
    
    mov eax,4
    mov ebx,1
    mov ecx,str3
    mov edx,100
    int 0x80
    
    mov eax,1
    int 0x80
