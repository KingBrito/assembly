
%include "io.inc"

section .data
    menu db "1-SOMA", 0dh,0ah,
         db "2-SUBTRAÇÂO",0dh,0ah,
         db "3-MULTIPLICAÇÂO",0dh,0ah,
         db "4-DIVISÂO",0dh,0ah,
         db "5-RESTO",0dh,0ah,
         db "",0
         
   CaseTable DB 1 ; lookup value
    DD SOMA ; address of procedure
    EntrySize EQU ($ - CaseTable)
    DB 2
    DD SUBT
    DB 3
    DD MULT
    DB 4
    DD DIVI
    DB 5
    DD RESTO
    NumberOfEntries EQU ($ - CaseTable) / EntrySize
    msgA DB "SOMA",0
    msgB DB "SUBT",0
    msgC DB "MULTI",0
    msgD DB "DIVI",0
    msgE DB "RESTO",0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
      
    GET_DEC 1, al
    
    mov edx, CaseTable ; point EBX to the table
    mov ecx, NumberOfEntries ; loop counter
    L1: cmp al,[edx] ; match found?
    jne L2 ; no: continue
    call FUNC
    call [edx + 1] ; yes: call the procedure
    ;PRINT_STRING [EDX] ; display message
    NEWLINE
    jmp L3 ; and exit the loop
    L2: add edx,EntrySize ; point to next entry
    dec ecx
    JNZ L1 ; repeat until ECX = 0
    L3:
    xor eax, eax
    ret
    
    
    
    xor eax, eax
    ret
    
MULT:
    
    mul ebx
    PRINT_DEC 4,edx
    NEWLINE
    PRINT_DEC 4,eax
    
    ret
    
SUBT:
    sub eax,ebx
    NEWLINE
    PRINT_DEC 4,eax
    ret
    
SOMA:
    add eax,ebx
    NEWLINE        
    PRINT_DEC 4,eax
    ret
    
RESTO:
    mov edx,0
    cmp ebx, 0
    je QUIT
    div ebx
    NEWLINE
    PRINT_DEC 4,edx
    ret
    
DIVI:
    mov edx,0
    cmp ebx, 0
    je QUIT
    div ebx
    NEWLINE
    PRINT_DEC 4,eax
    ret
    
QUIT:ret

FUNC:
    GET_DEC 4, eax
    GET_DEC 4, ebx
    ret