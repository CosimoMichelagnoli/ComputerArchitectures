.MODEL small
.STACK 
.DATA

SOURCE DW 'A','B','C','D', 'E','F','G','H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P'

TMP DW 4 DUP (?)


.CODE
.STARTUP  
          LEA AX, SOURCE 
          LEA BX, TMP
          XOR AX, AX  
          XOR BX, BX
          MOV AH, 1
          INT 21H 
          CMP AL, '1'
          JB stop
          CMP AL, '3'
          JA stop
        
          SUB AL,  '0'
          MOV CL, AL
           
        
inizio:   XOR SI, SI  ; pointer to -> 0
          MOV CH, 4  ; counter  
          
caricalo: MOV AX, SOURCE[SI] ; loads entries for one row
          MOV TMP[SI], AX
          ADD SI, 2
          SUB CH, 1
          CMP CH, 0
          JNE caricalo
          
comePrima:MOV DL, 3
        
azzera_di:MOV CH, 4 
          XOR DI, DI
        
shifta_one1: 
          MOV AX, SOURCE[SI]
          MOV BX, TMP[DI]
          MOV SOURCE[SI], BX
          MOV TMP[DI], AX
          ADD DI, 2
          ADD SI, 2
          SUB CH, 1
          CMP CH, 0
          JNE shifta_one1
          
          SUB DL, 1
          CMP DL, 0
          JNE azzera_di
        
          XOR SI, SI
          
        
shifta_one2: 
          MOV BX, TMP[SI]
          MOV SOURCE[SI], BX
          ADD SI, 2 
          CMP SI, 8
          JNE shifta_one2
          
          
          SUB CL, 1
          CMP CL, 0
          JNE comePrima      
   
stop:
  
.EXIT
END
