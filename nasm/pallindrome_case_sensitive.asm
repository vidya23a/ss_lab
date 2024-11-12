section .data
    msg1 db "enter:"
    msg2 db "yes"
    msg3 db "no"
    
section .bss
    str1 resb 100
    
section .text
    global _start
    
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,6
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
    mov edi,str1
    add edi,ecx
    dec edi
    
    loop1:mov al,[esi]
    test al,al
    jz done
    mov bl,[edi]
    cmp al,bl
    jne check
    inc esi
    dec edi
    jmp loop1
    
    check:cmp bl,'a'
    jb check_up
    cmp bl,'z'
    ja check_up
    sub bl,32
    jmp store
    
    check_up:cmp bl,'A'
    jb store
    cmp bl,'Z'
    ja store
    add bl,32
    jmp store
    
    store:cmp al,bl
    jne no_pal
    inc esi
    dec edi
    jmp loop1
    
    no_pal:mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,2
    int 0x80
    jmp end
    
    done:mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,3
    int 0x80
    
    end:mov eax,1
    int 0x80
