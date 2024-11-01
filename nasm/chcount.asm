section .data
    msg1 db "String",0xa
    msg2 db "Character",0xa
    
section .bss
    str1 resb 100
    chr resb 1
    count resb 10
    
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
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,10
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,chr
    mov edx,1
    int 0x80
    
    mov esi,str1
    mov dl,[chr]
    xor ecx,ecx
    
    loop1:mov al,[esi]
    cmp al,0
    je end
    cmp al,dl
    jne eq
    inc ecx
    inc esi
    jmp loop1
    
    eq:inc esi
    jmp loop1
    
    end:mov eax,ecx
    add eax,'0'
    mov [count],eax
    
    mov eax,4
    mov ebx,1
    mov ecx,count
    mov edx,10
    int 0x80
    
    mov eax,1
    int 0x80
