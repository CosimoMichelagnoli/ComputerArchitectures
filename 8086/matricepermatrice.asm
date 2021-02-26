; N*P should be at most 255
N EQU 4 ;column(mat1)==row(mat2)
M EQU 7 ; integer between 0 and 255
P EQU 5 ; integer between 0 and 255
.MODEL small
.STACK
.DATA
; A should be an NxM matrix cut by rows
; B should be an MxP matrix cut by columns
; Elements of A and B should be integers between -128 and 127
; C will store AB cut by rows
;A DB 1,2,3,4, ,6,7,8, 9,10,11,12
;B DB 1,2,3,4, 5,6,7,8
A DB 3,14,-15,9,26,-53,5, 89,79,3,23,84,-6,26, 43,-3,83,27,-9,50,28, -88,41,97,-103,69,39,-9
B DB 37,9,-23,0,9,82,70, -101,74,90,-62,86,5,-67, 0,94,-78,86,28,34,9, 58,-4,16,20,0,-21,82, -20,59,-4,89,-34,1,14 
C DW N*P DUP(0) 
.CODE
.STARTUP 
    lea si, C
    xor si, si
    xor bx, bx
    xor di, di
    xor cx, cx
    xor dx, dx                                          
                                                      
rowColumn:    
    mov al, A[si]
    imul B[bx]
    add C[di], ax
    jo overflow     ; entra se almeno una volta c'e' overflow
back:
    inc si
    inc bx
    inc cl
    cmp cl, M
    jne rowColumn  ;riga per colonna 
    
    cmp dh, 7      ; controlla se nel ciclo siamo entrati in overflow
    je handleOverflow
    
ifOverflow:    
    xor cl, cl
    add di, 2      ; stessa riga ma colonna successiva
    sub si, M      ; torniamo all'inizio della riga   
    inc ch
    cmp ch, P
    jne rowColumn  ; moltiplichiamo riga per le restanti colonne
    
    xor ch, ch
    xor bx, bx
    add si, M
    inc dl
    cmp dl, N
    jne rowColumn  ;cambiamo riga       
    jmp stop 
    
overflow:
    mov dh, 7
    jmp back


handleoverflow:
    xor dh, dh 
    cmp C[di], 0
    js negative
    mov C[di], 8000H  ;se il valore in C[di] e' negativo allora abbiamo sforato nei valori positivi 
    jmp endhandler 
    
negative:
    mov C[di], 7FFFH 
    
endhandler:
    jmp ifOverflow
                                
    
        
    
    
    
    
stop:    
 
.EXIT
END  

    
    
    
    
    
    
    
    
    
    
    
    
    
    








;xor si, si
;xor bx, bx
;xor di, di
;xor cx,cx        ; mov,cx,0
;                 ;xor bx,bx
;innerloop:
;mov al,B[bx]     ;1 in al  
;mul A[si]        ;viene salvato nel ax(16 bits)
;mov dx,C[di]     ;value of di in dx
;add ax,dx   
;mov C[di],ax
;inc bx
;inc si
;cmp bx,M
;jb innerloop     ; qui finisce riga x colonna
;
;mov al,M
;mul cl           ; mette in ax in sequenza 0, M, 2M, ... (N-1)M
;add di, 2        ; prossimo elemento matrice C
;mov si, ax       ; riparte dalla riga
;inc ch 
;cmp ch,P
;jb innerloop     ;qui
; 
;inc cl
;mov al,M
;mov si, ax
;mul cl 
;add di, 2
;xor bx, bx       ; tornate al primo elemento matrice b
;cmp cl ,N 
;jb innerloop