section .data
    msg1 db "String",0xa
    msg2 db "Pallindrome",0xa
    msg3 db "Not pallindrome",0xa
    
section .bss
    str1 resb 100
    str2 resb 100
    
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
    
    mov ecx,eax
    dec ecx
    mov esi,str1
    mov edi,str2
    add esi,ecx
    dec esi
    
    loop1:mov al,[esi]
    mov [edi],al
    inc edi
    dec esi
    loop loop1
    
    mov byte[edi],0
    mov esi,str1
    mov edi,str2
    
    loop2:mov al,[esi]
    mov bl,[edi]
    cmp al,bl
    jne not_equal
    inc esi
    inc edi
    test al,al
    jz end
    test bl,bl
    jz not_equal
    jmp loop2
    
    not_equal:mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,16
    int 0x80
    jmp finish
    
    end:mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,12
    int 0x80
    
    finish:mov eax,1
    int 0x80
