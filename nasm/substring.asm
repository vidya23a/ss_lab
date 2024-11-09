section .data
    msg1 db "string:"
    msg2 db "substring:"
    msg3 db "found"
    msg4 db "not found"
    
section .bss
    str1 resb 10
    str2 resb 10
    
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
    mov edx,10
    int 0x80
    mov byte[str1+eax-1],0
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,10
    int 0x80
    
    mov eax,3
    mov ebx,0
    mov ecx,str2
    mov edx,10
    int 0x80
    mov byte[str2+eax-1],0
    
   mov esi,str1
   mov edi,str2
   
   loop1:mov al,[esi]
   mov bl,[edi]
   test al,al
   jz done_ne
   cmp al,bl
   je eq
   inc esi
   jmp loop1
   
   eq:inc esi
   inc edi
   mov al,[esi]
   mov bl,[edi]
   test bl,bl
   jz done_eq
   cmp al,bl
   je eq
   xor edi,edi
   mov edi,str2
   jmp loop1
   
   done_eq:mov eax,4
   mov ebx,1
   mov ecx,msg3
   mov edx,5
   int 0x80
   jmp end
   
   done_ne:mov eax,4
   mov ebx,1
   mov ecx,msg4
   mov edx,9
   int 0x80
   
   end:mov eax,1
   int 0x80
   
