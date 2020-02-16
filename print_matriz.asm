%include "io.inc"
section .data
    matrix db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
    
    sizeM  equ $-matrix
    numLin db 4
    numCol db 4
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    call PRINT
    xor eax, eax
    ret
    
    
    PRINT:
        mov esi,0
        mov al,0 ;iterador da linha
        mov bl,0 ;iterador da coluna
    IMPRIMIR:    
        PRINT_DEC 1,[matrix + (esi*1)]
        inc esi
        inc al
        cmp al,[numLin]
        je NL
        jmp IMPRIMIR
        
        
    NL:
        xor al,al
        NEWLINE
        inc bl
        cmp bl,[numCol]
        JE  FIM
        JMP IMPRIMIR
        FIM:
            ret