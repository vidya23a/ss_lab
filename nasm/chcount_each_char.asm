section .data
    msg1 db "Enter string",0xa
    colon db ": " 
    newline db 0xa
    
section .bss 
    str1 resb 100
    count resb 1
    
section .text
    global _start
    
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,13
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,str1
    mov edx,100
    int 0x80
    mov byte[str1+eax-1],0
    
    mov esi,str1
    
    loop1:mov al,[esi]
    test al,al
    jz finish
    xor ecx,ecx
    mov edi,str1
    
    loop2:mov bl,[edi] 
    test bl,bl
    jz end
    cmp al,bl
    jne not_eq
    inc ecx
    
    not_eq:inc edi
    jmp loop2
    
    end:mov eax,ecx
    add eax,'0'
    mov [count],eax
    
    mov eax,4
    mov ebx,1
    mov ecx,esi
    mov edx,1
    int 0x80
    
    mov eax,4
    mov ebx,1
    mov ecx,colon
    mov edx,2
    int 0x80
    
    mov eax,4
    mov ebx,1
    mov ecx,count
    mov edx,1
    int 0x80
    
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80
    
    inc esi
    jmp loop1
    
    finish:mov eax,1
    int 0x80
