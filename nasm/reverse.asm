section .data
    msg1 db "Enter",0xa
    msg2 db "string",0xa
    
section .bss
    str1 resb 100
    str2 resb 100
    
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
    
    mov esi,str1
    mov edi,str2
    
    loop1:mov cl,[esi+eax]
    mov [edi],cl
    dec eax
    inc edi
    cmp eax,0
    jge loop1
     
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,7
    int 0x80
    
    mov eax,4
    mov ebx,1
    mov ecx,str2
    mov edx,100
    int 0x80
    
    mov eax,1
    int 0x80
