section .data
    msg1 db "enter:"
    msg2 db "pallindrome"
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
    mov bl,[edi]
    cmp al,bl
    jne no_pal
    inc esi
    dec edi
    test al,al      ;cmp esi,edi
    jz done         ;jge done
    jmp loop1
    
    done:mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,11
    int 0x80
    jmp end
    
    no_pal:mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,2
    int 0x80
    
    end:mov eax,1
    int 0x80
