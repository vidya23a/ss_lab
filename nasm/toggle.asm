section .data
    msg1 db "String",0xa
    
section .bss
    str1 resb 100
    tog resb 100
    
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
    mov ecx,str1
    mov edx,100
    int 0x80
    mov byte[str1+eax-1],0
    
    mov esi,str1
    mov edi,tog
    
    loop1:mov al,[esi]
    test al,al
    jz end
    cmp al,'a'
    jb check_upper
    cmp al,'z'
    ja check_upper
    sub al,32
    jmp store
    
    check_upper:cmp al,'A'
    jb store
    cmp al,'z'
    ja store
    add al,32
    
    store:mov [edi],al
    inc esi
    inc edi
    jmp loop1
    
    end:mov eax,4
    mov ebx,1
    mov ecx,tog
    mov edx,100
    int 0x80
    
    mov eax,1
    int 0x80
