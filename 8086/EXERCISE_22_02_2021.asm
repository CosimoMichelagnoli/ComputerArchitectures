.MODEL small
.STACK
.DATA
SOURCE db 1,4,7 ,2,5,8 ,3,6,9 
DESTINATION dw 9 DUP(?) 
.CODE
.STARTUP 
xor si, si 
xor di, di 
xor bx, bx   

nextColoumn: 
mov cl, 2               ;***RESTART COUNTER*** 
cmp di, 18 
jE stop                ;if di is pointing beyond the destination matrix, then stop
                        
finishColoumn: 
mov al, SOURCE[si]      ;get element 
inc SI                            ;position of SOURCE inc si 
mov dl, SOURCE[si]      ;get next in SOURCE

add al, dl
adc ah, 0 
mov DESTINATION[di], ax ;put result in the destination matrix 
add di, 2               ;next destination 
dec cl 
cmp cl, 0 
JNE finishColoumn       ;if cl is not 0 loop 

inc SI  
                                    ; inc SI for point the first element of next coloumn
;when we exit we have write the first two element of each coloum in destination and DI point to the third one BX pointing on the first of the coloumn 
;and DX still has the last element of the coloumn so i just nee to use BX to grab the first element ad after the sum store in DI position

mov al, SOURCE[bx]      ;grab the starting value of the coloumn 
add al, dl              ;dl has the last value of coloumn 
adc ah, 0
add bx, 3               ;next first element of the next coloumn 
mov DESTINATION[di], ax 
add di, 2               ;point next coloumn first element 
jmp nextColoumn

stop:          
.exit
END

